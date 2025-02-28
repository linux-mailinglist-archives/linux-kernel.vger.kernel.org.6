Return-Path: <linux-kernel+bounces-538582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C694A49A87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F637A7138
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0826E157;
	Fri, 28 Feb 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZWSdug7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C31D555;
	Fri, 28 Feb 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749375; cv=none; b=MGWBCzDgSSPdItPPHjPhHRXNUKWZh06Qc4lwJqupW0td1VmGWvhi8BGk1bVQDUntreCrPeDI0wqA4UXxaQXoScZfUgUloqo+9OKDYX7MuUXOzN/za02DviK800+t5o3SAx6x72zRHRiIfIAfGZag8Ey+S5wqqndNjZCShCxIi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749375; c=relaxed/simple;
	bh=h1gcfXKxYDFuWGauGFyZ/WuO0uocpWz6LqllgGyg64Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5vvAhbrrbZAMOWx147VaF4zCruJdvnsaF5kKToMAli326EkVBRtAhZ3ga4qdNOREic15CYH4jcIGcF4WHjm2Sk4oXGLq8lBRjPyUdo2XjlOJhgcJnQkFAcW3I19Iq4bM3dNWHCkxg28meaJMXBGYIWlEbJq8LdSqouZ2ZAG6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZWSdug7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so19544685e9.2;
        Fri, 28 Feb 2025 05:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740749371; x=1741354171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Avez2xSDYscvxHDuCxg1ie5SK+Du5TC+14a6JKYQZoQ=;
        b=mZWSdug7C7iY/uUmbcqtfyaOqiOS1wWx3lWZQu8g3nlnVIVArHHFqz6tIcHvEiqImw
         HZmahGN/qPXLST+r710WgDmEUFdp+HdCBUc6/gnnL/ZAkZGr0kSUPJ5GfvjMcLzNcR6u
         iX+KWfMbZfw/HMy7jrXlmurOBeq0foiQdd7+zMrJ/IdGx5O8Hvs0iqkBBQDfWTaqe80j
         fmUXKjOwd0V5lwD9/T1L7OZgcblUNM2otKMkvvGj1BWNpzgdAm+2ZjRT7eKa1kvINd6G
         +8j2PEGoQGJiDI43YkTXhA/qhUyL7H55KbvPldmUECIg03q1ign61jPLbJnqWBmDJJia
         skfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740749371; x=1741354171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avez2xSDYscvxHDuCxg1ie5SK+Du5TC+14a6JKYQZoQ=;
        b=asBJTQ7JuG25uP1uC4tBgfdg+SIeIhg44cUaLQo2Y43lo6VdYQFFYu3k0rgzO/fS9w
         QdrZhi+4qUWoVJvPjqIuY08mEeevGMsmmPDuXusJpm5LIJyC00/9vHS9VvuB9RNK8GmC
         /9bH/ezmIbSlWuS0HWgReoC+niFksqfrWXoLDHrc3vHgTKNy46tjF0FYGcfvfaj5KaA8
         MPqUPJ9iLL2KGaMipVLT1wx65kTddHkY/us0YIaVToUR+BvAgC54vIGBgQczrP5U3U1J
         XqdxUdt+D6ruxPKMNDgZiGXY1nPf6eX1Bq9NZME77NDq6gmHuGNWlQnmSabzjgr+nU4n
         Serg==
X-Forwarded-Encrypted: i=1; AJvYcCVoxZTO4E25j3ku7Riue8UlUGvmYMCLbcn1/uhSMS7tUWouoih5KvBPBv3KbmUqIliPgMu85XEoRbiRTGg=@vger.kernel.org, AJvYcCXPczyvF8vjpZoRPZ9FfB8jqWrMwxdlI/2rjlPoEXXKSvtD7ZjahoCO1TPZsyN5Xt9yBYgVQD4g62xZ1ev7nFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpc0DjYUa5Ae8rqTlJ3D46GXTuFXt6Y6HOkFdqSFksIIUgKL4W
	WaE46WF5+q0gCRDYiHzRXkWUX8tBxn2dRoQkxAgEx+TfV2My1ov2lyudSVJr
X-Gm-Gg: ASbGncvIQnW9v7d4j21Xstp/Hukk2TrSGs1ojaRCNNGLQgVor8SJ8BrWRZiKgQQC1c0
	j56FyDTXkkNebik1W8JlAj2Fm+k9OFW+9onxO1cO31FPsmzA5VSr2tkerGxeUcpFm4HRk6vfcCm
	vjl2YvmJJ/RY1L+X3mf8RJBZZtL+6BQFDRlnRPQeHZ/oNitE88V9AvDUOSlus6P24DsRaZx9gaQ
	R5DC9CRsxcu1mfA5wqOG86HF/g4SIexFddf4Qhoda/mUOLluqnw4J76+b1b29Myr+UWALVoG2Lz
	cGTwlpjFtEy7KjHAOuMxfDhAXzD1pw==
X-Google-Smtp-Source: AGHT+IGlY+8f/TJ66ysQmZN61hQQEryPUVbnOuK90G1E8TY4dFR0/Hi1Fwk7z2HQ0W6TjEyL1VD/+Q==
X-Received: by 2002:a05:6000:1f8c:b0:38f:4fa6:bb24 with SMTP id ffacd0b85a97d-390eca530a8mr2830857f8f.39.1740749371055;
        Fri, 28 Feb 2025 05:29:31 -0800 (PST)
Received: from fedora.. ([82.67.147.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6dbsm5212693f8f.82.2025.02.28.05.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:29:30 -0800 (PST)
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
To: ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guillaume Gomez <guillaume1.gomez@gmail.com>
Subject: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command line flag to improve doctest handling.
Date: Fri, 28 Feb 2025 14:29:28 +0100
Message-ID: <20250228132928.880683-1-guillaume1.gomez@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this patch, the code was using very hacky methods in order to retrieve
doctests, modify them as needed and then concatenate all of them in one file.

Now, with this new flag, it instead asks rustdoc to provide the doctests
code with their associated information such as file path and line number.
---
 rust/Makefile                   |   8 +-
 scripts/json.rs                 | 235 ++++++++++++++++++++++++++++++++
 scripts/rustdoc_test_builder.rs | 115 ++++++++++------
 scripts/rustdoc_test_gen.rs     |  17 +--
 4 files changed, 323 insertions(+), 52 deletions(-)
 create mode 100644 scripts/json.rs

diff --git a/rust/Makefile b/rust/Makefile
index ea3849eb7..237ed23f8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -171,14 +171,14 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) --test $(rust_flags) \
+	$(RUSTDOC) --output-format=doctest $(rust_flags) \
 		-L$(objtree)/$(obj) --extern ffi --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
-		--no-run --crate-name kernel -Zunstable-options \
+		--crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
-		--test-builder $(objtree)/scripts/rustdoc_test_builder \
-		$< $(rustdoc_test_kernel_quiet); \
+		$< $(rustdoc_test_kernel_quiet) > rustdoc.json; \
+	cat rustdoc.json | $(objtree)/scripts/rustdoc_test_builder; \
 	$(objtree)/scripts/rustdoc_test_gen
 
 %/doctests_kernel_generated.rs %/doctests_kernel_generated_kunit.c: \
diff --git a/scripts/json.rs b/scripts/json.rs
new file mode 100644
index 000000000..aff24bfd9
--- /dev/null
+++ b/scripts/json.rs
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! JSON parser used to parse rustdoc output when retrieving doctests.
+
+use std::collections::HashMap;
+use std::iter::Peekable;
+use std::str::FromStr;
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) enum JsonValue {
+    Object(HashMap<String, JsonValue>),
+    String(String),
+    Number(i32),
+    Bool(bool),
+    Array(Vec<JsonValue>),
+    Null,
+}
+
+fn parse_ident<I: Iterator<Item = char>>(
+    iter: &mut I,
+    output: JsonValue,
+    ident: &str,
+) -> Result<JsonValue, String> {
+    let mut ident_iter = ident.chars().skip(1);
+
+    loop {
+        let i = ident_iter.next();
+        if i.is_none() {
+            return Ok(output);
+        }
+        let c = iter.next();
+        if i != c {
+            if let Some(c) = c {
+                return Err(format!("Unexpected character `{c}` when parsing `{ident}`"));
+            }
+            return Err(format!("Missing character when parsing `{ident}`"));
+        }
+    }
+}
+
+fn parse_string<I: Iterator<Item = char>>(iter: &mut I) -> Result<JsonValue, String> {
+    let mut out = String::new();
+
+    while let Some(c) = iter.next() {
+        match c {
+            '\\' => {
+                let Some(c) = iter.next() else { break };
+                match c {
+                    '"' | '\\' | '/' => out.push(c),
+                    'b' => out.push(char::from(0x8u8)),
+                    'f' => out.push(char::from(0xCu8)),
+                    't' => out.push('\t'),
+                    'r' => out.push('\r'),
+                    'n' => out.push('\n'),
+                    _ => {
+                        // This code doesn't handle codepoints so we put the string content as is.
+                        out.push('\\');
+                        out.push(c);
+                    }
+                }
+            }
+            '"' => {
+                return Ok(JsonValue::String(out));
+            }
+            _ => out.push(c),
+        }
+    }
+    Err(format!("Unclosed JSON string `{out}`"))
+}
+
+fn parse_number<I: Iterator<Item = char>>(
+    iter: &mut Peekable<I>,
+    digit: char,
+) -> Result<JsonValue, String> {
+    let mut nb = String::new();
+
+    nb.push(digit);
+    loop {
+        // We peek next character to prevent taking it from the iterator in case it's a comma.
+        if matches!(iter.peek(), Some(',' | '}' | ']')) {
+            break;
+        }
+        let Some(c) = iter.next() else { break };
+        if c.is_whitespace() {
+            break;
+        } else if !c.is_ascii_digit() {
+            return Err(format!("Error when parsing number `{nb}`: found `{c}`"));
+        }
+        nb.push(c);
+    }
+    i32::from_str(&nb)
+        .map(|nb| JsonValue::Number(nb))
+        .map_err(|error| format!("Invalid number: `{error}`"))
+}
+
+fn parse_array<I: Iterator<Item = char>>(iter: &mut Peekable<I>) -> Result<JsonValue, String> {
+    let mut values = Vec::new();
+
+    'main: loop {
+        let Some(c) = iter.next() else {
+            return Err("Unclosed array".to_string());
+        };
+        if c.is_whitespace() {
+            continue;
+        } else if c == ']' {
+            break;
+        }
+        values.push(parse(iter, c)?);
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c == ',' {
+                break;
+            } else if c == ']' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"));
+            }
+        }
+    }
+    Ok(JsonValue::Array(values))
+}
+
+fn parse_object<I: Iterator<Item = char>>(iter: &mut Peekable<I>) -> Result<JsonValue, String> {
+    let mut values = HashMap::new();
+
+    'main: loop {
+        let Some(c) = iter.next() else {
+            return Err("Unclosed object".to_string());
+        };
+        let key;
+        if c.is_whitespace() {
+            continue;
+        } else if c == '"' {
+            let JsonValue::String(k) = parse_string(iter)? else {
+                unreachable!()
+            };
+            key = k;
+        } else if c == '}' {
+            break;
+        } else {
+            return Err(format!("Expected `\"` when parsing Object, found `{c}`"));
+        }
+
+        // We then get the `:` separator.
+        loop {
+            let Some(c) = iter.next() else {
+                return Err(format!("Missing value after key `{key}`"));
+            };
+            if c.is_whitespace() {
+                continue;
+            } else if c == ':' {
+                break;
+            } else {
+                return Err(format!(
+                    "Expected `:` after key, found `{c}` when parsing object"
+                ));
+            }
+        }
+        // Then the value.
+        let value = loop {
+            let Some(c) = iter.next() else {
+                return Err(format!("Missing value after key `{key}`"));
+            };
+            if c.is_whitespace() {
+                continue;
+            } else {
+                break parse(iter, c)?;
+            }
+        };
+
+        if values.contains_key(&key) {
+            return Err(format!("Duplicated key `{key}`"));
+        }
+        values.insert(key, value);
+
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c == ',' {
+                break;
+            } else if c == '}' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"));
+            }
+        }
+    }
+    Ok(JsonValue::Object(values))
+}
+
+fn parse<I: Iterator<Item = char>>(iter: &mut Peekable<I>, c: char) -> Result<JsonValue, String> {
+    match c {
+        '{' => parse_object(iter),
+        '"' => parse_string(iter),
+        '[' => parse_array(iter),
+        't' => parse_ident(iter, JsonValue::Bool(true), "true"),
+        'f' => parse_ident(iter, JsonValue::Bool(false), "false"),
+        'n' => parse_ident(iter, JsonValue::Null, "null"),
+        c => {
+            if c.is_ascii_digit() || c == '-' {
+                parse_number(iter, c)
+            } else {
+                Err(format!("Unexpected `{c}` character"))
+            }
+        }
+    }
+}
+
+impl JsonValue {
+    pub(crate) fn parse(input: &str) -> Result<Self, String> {
+        let mut iter = input.chars().peekable();
+        let mut value = None;
+
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            }
+            value = Some(parse(&mut iter, c)?);
+            break;
+        }
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else {
+                return Err(format!("Unexpected character `{c}` after content"));
+            }
+        }
+        if let Some(value) = value {
+            Ok(value)
+        } else {
+            Err("Empty content".to_string())
+        }
+    }
+}
diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
index e5894652f..9b6bc1c1d 100644
--- a/scripts/rustdoc_test_builder.rs
+++ b/scripts/rustdoc_test_builder.rs
@@ -15,58 +15,93 @@
 //! from that. For the moment, we generate ourselves a new name, `{file}_{number}` instead, in
 //! the `gen` script (done there since we need to be aware of all the tests in a given file).
 
+use std::fs::create_dir_all;
 use std::io::Read;
 
-fn main() {
-    let mut stdin = std::io::stdin().lock();
-    let mut body = String::new();
-    stdin.read_to_string(&mut body).unwrap();
+use json::JsonValue;
 
-    // Find the generated function name looking for the inner function inside `main()`.
-    //
-    // The line we are looking for looks like one of the following:
-    //
-    // ```
-    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_28_0() {
-    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl core::fmt::Debug> {
-    // ```
-    //
-    // It should be unlikely that doctest code matches such lines (when code is formatted properly).
-    let rustdoc_function_name = body
-        .lines()
-        .find_map(|line| {
-            Some(
-                line.split_once("fn main() {")?
-                    .1
-                    .split_once("fn ")?
-                    .1
-                    .split_once("()")?
-                    .0,
-            )
-            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c == '_'))
-        })
-        .expect("No test function found in `rustdoc`'s output.");
+mod json;
 
-    // Qualify `Result` to avoid the collision with our own `Result` coming from the prelude.
-    let body = body.replace(
-        &format!("{rustdoc_function_name}() -> Result<(), impl core::fmt::Debug> {{"),
-        &format!("{rustdoc_function_name}() -> core::result::Result<(), impl core::fmt::Debug> {{"),
-    );
+fn generate_doctest(file: &str, line: i32, doctest_code: &str) {
+    let file = file
+        .strip_suffix(".rs")
+        .unwrap_or(file)
+        .strip_prefix("../rust/kernel/")
+        .unwrap_or(file)
+        .replace('/', "_");
+    let path = format!("rust/test/doctests/kernel/{file}-{line}.rs");
 
+    // We replace the `Result` if needed.
+    let doctest_code = doctest_code.replace(
+        "fn main() { fn _inner() -> Result<",
+        "fn main() { fn _inner() -> core::result::Result<",
+    );
     // For tests that get generated with `Result`, like above, `rustdoc` generates an `unwrap()` on
     // the return value to check there were no returned errors. Instead, we use our assert macro
     // since we want to just fail the test, not panic the kernel.
     //
     // We save the result in a variable so that the failed assertion message looks nicer.
-    let body = body.replace(
-        &format!("}} {rustdoc_function_name}().unwrap() }}"),
-        &format!("}} let test_return_value = {rustdoc_function_name}(); assert!(test_return_value.is_ok()); }}"),
+    let doctest_code = doctest_code.replace(
+        "} _inner().unwrap() }",
+        "} let test_return_value = _inner(); assert!(test_return_value.is_ok()); }",
     );
+    std::fs::write(path, doctest_code.as_bytes()).unwrap();
+}
+
+fn main() {
+    let mut stdin = std::io::stdin().lock();
+    let mut body = String::new();
+    stdin.read_to_string(&mut body).unwrap();
+
+    let JsonValue::Object(rustdoc) = JsonValue::parse(&body).unwrap() else {
+        panic!("Expected an object")
+    };
+    if let Some(JsonValue::Number(format_version)) = rustdoc.get("format_version") {
+        if *format_version != 1 {
+            panic!("unsupported rustdoc format version: {format_version}");
+        }
+    } else {
+        panic!("missing `format_version` field");
+    }
+    let Some(JsonValue::Array(doctests)) = rustdoc.get("doctests") else {
+        panic!("missing `doctests` field");
+    };
+
+    // We ignore the error since it will fail when generating doctests below if the folder doesn't
+    // exist.
+    let _ = create_dir_all("rust/test/doctests/kernel");
 
-    // Figure out a smaller test name based on the generated function name.
-    let name = rustdoc_function_name.split_once("_rust_kernel_").unwrap().1;
+    let mut nb_generated = 0;
+    for doctest in doctests {
+        let JsonValue::Object(doctest) = doctest else {
+            unreachable!()
+        };
 
-    let path = format!("rust/test/doctests/kernel/{name}");
+        // We check if we need to skip this test by checking it's a rust code and it's not ignored.
+        if let Some(JsonValue::Object(attributes)) = doctest.get("doctest_attributes") {
+            if attributes.get("rust") != Some(&JsonValue::Bool(true)) {
+                continue;
+            } else if let Some(JsonValue::String(ignore)) = attributes.get("ignore") {
+                if ignore != "None" {
+                    continue;
+                }
+            }
+        }
+        if let (
+            Some(JsonValue::String(file)),
+            Some(JsonValue::Number(line)),
+            Some(JsonValue::String(doctest_code)),
+        ) = (
+            doctest.get("file"),
+            doctest.get("line"),
+            doctest.get("doctest_code"),
+        ) {
+            generate_doctest(file, *line, doctest_code);
+            nb_generated += 1;
+        }
+    }
 
-    std::fs::write(path, body.as_bytes()).unwrap();
+    if nb_generated == 0 {
+        panic!("No test function found in `rustdoc`'s output.");
+    }
 }
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4..fd6635bbf 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -48,7 +48,7 @@
 fn find_real_path<'a>(srctree: &Path, valid_paths: &'a mut Vec<PathBuf>, file: &str) -> &'a str {
     valid_paths.clear();
 
-    let potential_components: Vec<&str> = file.strip_suffix("_rs").unwrap().split('_').collect();
+    let potential_components: Vec<&str> = file.split('_').collect();
 
     find_candidates(srctree, valid_paths, Path::new(""), &potential_components);
     fn find_candidates(
@@ -87,8 +87,8 @@ fn find_candidates(
 
     assert!(
         valid_paths.len() > 0,
-        "No path candidates found. This is likely a bug in the build system, or some files went \
-        away while compiling."
+        "No path candidates found for `{file}`. This is likely a bug in the build system, or some \
+        files went away while compiling.",
     );
 
     if valid_paths.len() > 1 {
@@ -97,8 +97,8 @@ fn find_candidates(
             eprintln!("    {path:?}");
         }
         panic!(
-            "Several path candidates found, please resolve the ambiguity by renaming a file or \
-            folder."
+            "Several path candidates found for `{file}`, please resolve the ambiguity by renaming \
+            a file or folder."
         );
     }
 
@@ -126,12 +126,13 @@ fn main() {
     let mut valid_paths: Vec<PathBuf> = Vec::new();
     let mut real_path: &str = "";
     for path in paths {
-        // The `name` follows the `{file}_{line}_{number}` pattern (see description in
+        // The `name` follows the `{file}_{line}` pattern (see description in
         // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
         let name = path.file_name().unwrap().to_str().unwrap().to_string();
 
-        // Extract the `file` and the `line`, discarding the `number`.
-        let (file, line) = name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
+        // Extract the `file` and the `line`, discarding the extension.
+        let (file, line) = name.rsplit_once('-').unwrap();
+        let line = line.split('.').next().unwrap();
 
         // Generate an ID sequence ("test number") for each one in the file.
         if file == last_file {
-- 
2.48.1


