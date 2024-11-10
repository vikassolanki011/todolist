import 'package:flutter/material.dart';

// Task model to represent each task
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  // Add a new task to the list
  void _addTask(String taskTitle) {
    if (taskTitle.isEmpty) return;
    setState(() {
      _tasks.add(Task(title: taskTitle));
    });
    _controller.clear();
  }

  // Toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field to add a new task
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _addTask,
            ),
            SizedBox(height: 10),
            // Button to add task
            ElevatedButton(
              onPressed: () {
                _addTask(_controller.text);
              },
              child: Text('Add Task'),
            ),
            const SizedBox(height: 20),
            // List of tasks
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _tasks[index].title,
                      style: TextStyle(
                        decoration: _tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Text(_tasks[index].isCompleted?"Completed":"Pending"),
                    leading: Checkbox(
                      value: _tasks[index].isCompleted,
                      fillColor: _tasks[index].isCompleted? MaterialStateProperty.all(Colors.grey.shade400): MaterialStateProperty.all(Colors.transparent),
                      // checkColor: Colors.blue,
                      onChanged: _tasks[index].isCompleted?null: (_) {
                        _toggleTaskCompletion(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}