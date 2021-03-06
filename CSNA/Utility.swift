import UIKit

func formattedTime(_ value: Int) -> String {
    let hours = value / 3600
    let minutes = (value % 3600) / 60
    let seconds = (value % 3600) % 60
    return hours > 0 ? String(format: "%00d:%02d:%02d", hours, minutes, seconds) : String(format: "%02d:%02d", minutes, seconds)
}

func localizedString(_ key: String, _ options: String...) -> String {
    var string = NSLocalizedString(key, comment: "")
    (0..<options.count).forEach { string = string.replacingOccurrences(of: "%\($0)", with: options[$0]) }
    return string
}

extension CGPoint {
    func distance(to other: CGPoint) -> CGFloat {
        return sqrt(pow(other.x-x, 2)+pow(other.y-y, 2))
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> Self {
        return Array(Set(self))
    }
    
    
    func mergeOne(_ merged: [Self]) -> [Self] {
        var set = Set(self)
        var result: [Self] = []
        
        for merge in merged {
            if set.isDisjoint(with: merge) {
                result.append(merge)
            } else {
                set.formUnion(merge)
            }
        }
        result.append(Array(set))
        return result
    }
    
}

extension Dictionary where Key: Comparable {
    var first: Value? {
        guard let key = keys.sorted().first else { return nil }
        return self[key]
    }
    
    var last: Value? {
        guard let key = keys.sorted().last else { return nil }
        return self[key]
    }
}

extension UILabel {
    @IBInspectable var localized: Bool {
        get { return true }
        set(value) {
            guard let key = text, value else { return }
            text = localizedString(key)
        }
    }
}
