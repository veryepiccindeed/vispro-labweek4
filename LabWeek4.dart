// Kelas untuk menyimpan graf dengan adjacency matrix
class Graph {
  final Map<String, int> vertices;
  final List<List<int>> distances;

  Graph(this.vertices, this.distances);

  // Mencari jarak antara dua simpul berdasarkan indeks
  int distance(String from, String to) {
    int i = vertices[from]!;
    int j = vertices[to]!;
    return distances[i][j];
  }
}

// Fungsi untuk menghitung semua permutasi dari simpul yang akan dikunjungi
List<List<T>> permute<T>(List<T> items) {
  if (items.isEmpty) {
    return [[]];
  }
  List<List<T>> result = [];
  for (var i = 0; i < items.length; i++) {
    var remaining = [...items]..removeAt(i);
    for (var perm in permute(remaining)) {
      result.add([items[i], ...perm]);
    }
  }
  return result;
}

// Fungsi untuk menghitung rute TSP dengan brute force
void tsp(Graph graph, String startVertex) {
  var vertices = graph.vertices.keys.where((v) => v != startVertex).toList();

  // Mendapatkan semua permutasi simpul-simpul yang akan dikunjungi
  var routes = permute(vertices);

  double minDistance = double.infinity;  // Jangan gunakan toInt()
  List<String> bestRoute = [];

  print("Semua percobaan rute:");

  // Menguji setiap rute dan menghitung jaraknya
  for (var route in routes) {
    int currentDistance = 0;
    String currentVertex = startVertex;

    // Cetak rute yang sedang diperiksa
    print("$startVertex -> ${route.join(' -> ')} -> $startVertex",);

    for (var nextVertex in route) {
      currentDistance += graph.distance(currentVertex, nextVertex);
      currentVertex = nextVertex;
    }
    
    // Tambahkan jarak kembali ke simpul asal (untuk menutup rute)
    currentDistance += graph.distance(currentVertex, startVertex);

    // Cetak jarak total untuk rute tersebut
    print("Jarak total: $currentDistance");

    // Perbarui rute terbaik jika jarak yang dihitung lebih kecil dari jarak minimum
    if (currentDistance < minDistance) {
      minDistance = currentDistance.toDouble();  // Pastikan tetap dalam bentuk double
      bestRoute = [startVertex, ...route, startVertex];
    }
  }

  // Menampilkan rute terbaik dan jarak total
  print('\nRute terbaik: ${bestRoute.join(' -> ')}');
  print('Jarak total: $minDistance');
}

void main() {
  // Definisikan vertex dan indeksnya dalam adjacency matrix
  Map<String, int> vertices = {
    'A': 0,
    'B': 1,
    'C': 2,
    'D': 3,
    'E': 4,
  };

  // Adjacency matrix untuk menyimpan jarak antar simpul
  List<List<int>> distances = [
    // A   B   C   D   E
    [0,  8,  3,  4, 10], // A
    [8,  0,  5,  2,  7], // B
    [3,  5,  0,  1,  6], // C
    [4,  2,  1,  0,  3], // D
    [10, 7,  6,  3,  0], // E
  ];

  // Membuat graf
  Graph graph = Graph(vertices, distances);

  // Melakukan brute force TSP dimulai dari simpul A
  tsp(graph, 'A');
}
