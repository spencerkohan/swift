// REQUIRES: objc_interop
// RUN: %empty-directory(%t.mod)
// RUN: %target-swift-frontend -emit-module -o %t.mod/MyAppKit.swiftmodule %S/Inputs/MyAppKit.swift -module-name MyAppKit -parse-as-library -swift-version 3
// RUN: %target-swift-frontend -emit-module -o %t.mod/MySwift.swiftmodule %S/Inputs/MySwift.swift -module-name MySwift -parse-as-library -swift-version 3
// RUN: %empty-directory(%t) && %target-swift-frontend -c -update-code -primary-file %s -I %t.mod -emit-migrated-file-path %t/api-special-cases.swift.result -emit-remap-file-path %t/api-special-cases.swift.remap -o /dev/null -api-diff-data-file %S/Inputs/SpecialCaseAPI.json -swift-version 3
// RUN: diff -u %S/api-special-cases.swift.expected %t/api-special-cases.swift.result

import MyAppKit
import MySwift

func foo(_ Opt: NSOpenGLOption) {
  var Value = 1
  NSOpenGLSetOption(Opt, 1)
  NSOpenGLGetOption(Opt, &Value)
}

do {
  _ = MyDouble.abs(1.0)
}
