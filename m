Return-Path: <linux-kernel+bounces-538942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FDA49F11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCFD3A5CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429A274253;
	Fri, 28 Feb 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwZDOokE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5527002E;
	Fri, 28 Feb 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760740; cv=none; b=QU0Y1WjeIdachAQ3gsAKkx/E8w1Ij1KtFy/PX8MLm/eVTWRm/+TP8v7Wo1DGiLm/T3/77oIhurskGogoUoepbZDPR2Ix2y3UuoJxkITHI76LMMhFKzUB7eHyzcjnOhCt0qvQjWBr9yG5x66CdiDX5GbUf0yzwI+XcuRnS3JLPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760740; c=relaxed/simple;
	bh=3UFQyrglhtr1koe7YmxCR/o1lvkM1795X8v9uC3qkjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T61liBVmVClias0qSJ1Mo0Anx7RHiabz2egYD+GKS/tg8fKys7RmgGd6scYy5WEmEzMVOSskBhtrDIW17n4+QoroQKuPw+FncM+cLAqsm9t5Ah4T5V9iKnhBwS/2rJg5E6dKa7W0dsDd7Lgh36G3HQJnbGPQhOLC2K5C5ZbW3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwZDOokE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso25110615e9.1;
        Fri, 28 Feb 2025 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760736; x=1741365536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1FcPs7/CaNFrM5LlsasKI8pHTqREv+zStdEwhTmmUE=;
        b=hwZDOokEfefxvGMT1T/5fiB37GRTmDNREF8DSAYoZ3eJlIpR2DKzQ8lWck/hWzsYI3
         7nGoPOhzquvf6+MufQpQUllG3JG5gKXyKSSdP2Yc7fV1tYF+O25AZ+Ob+kZ1ozUzLkjU
         rZCm/lpdD1JvCixsNQhhLT3e2/GLYpK8dqunaghka+KW10wivbxsHuKAL9/W6WgwqpE7
         w/vCuhhbLA/i+MxlHzOAVjWq2js9SPC2L2GwATsoI5UnXxKXkN5NagStOq7xsBt24iQO
         Fbnw0Atbh0oq4omGhob4tfFd0FI6poUNw0uwU1Cc/zwi/noAhLtD6ym+CAziKx6gxp7L
         dyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760736; x=1741365536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1FcPs7/CaNFrM5LlsasKI8pHTqREv+zStdEwhTmmUE=;
        b=OAqEybsANsAk9Eaec33TXfr8JyOEaHeS8f8mgCVBCEhZ8ucLc6yOvDmXgIjpuBIBZ/
         TDDMqSns8I5XfyWfSAY+1jeLKaaOBksYvRBttmbvSUW/PSVig+IW70oWlWSIi1Dg8WTP
         2P8oFz1MXQ6xDWquhH3TJatnpYKFdVRdyJGkiMtjieV3dVoTQLWXuieCPbs69GJhm0oj
         MZE8aRrSSvumcZBNX+kUY7mCcI90gBRgkc6mZ/FGg9F6EjSnT3rW6hEiLp4RS1udw0hQ
         aUKl1tiQ/omSd312EAMfjC85FgrknjSwgpGfAstnpgdKKEm8kkJlvClFYTlnwiwgzCGV
         rp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK4qWxnsLHfr1Y7yug15/mw4y8kyYCZqLUW/fPIdQyAlV5zUbrB9m3WZBwIlGAj4kLv8rjiOSjFwEjrb5qS2k=@vger.kernel.org, AJvYcCXeZc7LHJjNwt/61l5fNeDBlSpl+dUpEWy8f6lv9+lSIr9HtHvh/IIEdimuFPWz/SW1cjTPXkpxTh2UJ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGZAkXu387CuGDkP9i7KtXEMJvY2bbDnFk4lerbLo0cLhPzNA
	40ZhwFynVu9ovzl3WdEaXCJPsmN29jmaEmR+q/a4h1Lf7sDX5S8ifQ8j8sqR
X-Gm-Gg: ASbGnctDXr7A4VuB6o5QupkF1FApXnbTdPV9h4UwliscBZ8Tbcs7LK5hPurG9oKlm6C
	nlaPc8DDdMyF1x431Ge2YSe+lLFKRPXVeMwYZWxm0rS4diYEOLkBgdzhqfNFqRAscfahrfrxUVv
	sHYUIYAPfmKjo2FXlhdJopg3EdmaZCZlT3hwwJKpRFtR6+PumOz2kQDYJWW8BPcqqXiBYJYxWv7
	MmqF4Pf2CIPnoZ4+uiCdwnlRayo0VC4Pjxau2vVfZ9QgSJUqHNKy57I6ZjSCMbLu8L6+y7xEHDB
	fJpQLa1m5nFG+zneu17EXlLo9wXjiQ==
X-Google-Smtp-Source: AGHT+IE56C6BorgdF530IJPk286GDSVQ0lKGwkGCQrlabcjSlgPX4rQ4Z8MwDlScuLbg6ivZ1hCWlA==
X-Received: by 2002:a05:6000:10c1:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-390eca069a5mr3842778f8f.43.1740760735788;
        Fri, 28 Feb 2025 08:38:55 -0800 (PST)
Received: from fedora.. ([82.67.147.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795d30sm5745796f8f.10.2025.02.28.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:38:55 -0800 (PST)
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: guillaume1.gomez@gmail.com,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command line flag to improve doctest handling.
Date: Fri, 28 Feb 2025 17:38:45 +0100
Message-ID: <20250228163844.945140-2-guillaume1.gomez@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
References: <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the detailed answer!

I added the missing "Signed-of-by" in the commit message.

I added some more context in the commit message, hopefully I didn't
miss anything.

> We currently support versions 1.78+, so we will need to do these
> things conditionally. I can help with that, so don't worry too much
> about it for the moment (e.g. we have `rustc-option` and other helpers
> to pick the right flags given a version etc.).

I'll definitely need some help here. I'm not sure current stable already
has this change so until then, we'll need a beta/nightly version to run
these tests.

> Hmm... I was hoping we could do something on the `rustdoc` side to
> remove these hacks altogether since we are going to have a "proper
> flag" for it, i.e. to avoid relying on the particular "format" of the
> tests somehow.

I opened https://github.com/rust-lang/rust/pull/137807 to resolve
this problem.

> > +    let doctest_code = doctest_code.replace(
> > +        "} _inner().unwrap() }",
> > +        "} let test_return_value = _inner(); assert!(test_return_value.is_ok()); }",
> >      );
> > +    std::fs::write(path, doctest_code.as_bytes()).unwrap();
> > +}
>
> Same for this.

For this one I'll need to check first if it can be done "safely" (ie,
so unexpected side
effect).

> > +    } else {
> > +        panic!("missing `format_version` field");
> > +    }
>
> `expect` maybe?

I don't think `expect` would work in any of the cases in this file.
What I suggest
is to add methods on `JsonValue` in a future patch which would allow to reduce
code in this file (and call `expect` too).

> These two bits could go in a first patch, I think, though it isn't a big deal.

You're absolutely right, removing them and sending a separate patch.

Here is the updated patch:


The goal of this patch is to remove the use of 2 unstable rustdoc features
(`--no-run` and `--test-builder`) and replace it with a stable feature:
`--output-format=doctest`, which was added in
https://github.com/rust-lang/rust/pull/134531.

Before this patch, the code was using very hacky methods in order to retrieve
doctests, modify them as needed and then concatenate all of them in one file.

Now, with this new flag, it instead asks rustdoc to provide the doctests
code with their associated information such as file path and line number.

Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>
---
 rust/Makefile                   |   8 +-
 scripts/json.rs                 | 235 ++++++++++++++++++++++++++++++++
 scripts/rustdoc_test_builder.rs | 115 ++++++++++------
 scripts/rustdoc_test_gen.rs     |  11 +-
 4 files changed, 320 insertions(+), 49 deletions(-)
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
index e5894652f..ba17e9db9 100644
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
+        panic!("`doctests` field is missing or has the wrong type");
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
index 5ebd42ae4..66e665ea0 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -48,7 +48,7 @@
 fn find_real_path<'a>(srctree: &Path, valid_paths: &'a mut Vec<PathBuf>, file: &str) -> &'a str {
     valid_paths.clear();
 
-    let potential_components: Vec<&str> = file.strip_suffix("_rs").unwrap().split('_').collect();
+    let potential_components: Vec<&str> = file.split('_').collect();
 
     find_candidates(srctree, valid_paths, Path::new(""), &potential_components);
     fn find_candidates(
@@ -88,7 +88,7 @@ fn find_candidates(
     assert!(
         valid_paths.len() > 0,
         "No path candidates found. This is likely a bug in the build system, or some files went \
-        away while compiling."
+        away while compiling.",
     );
 
     if valid_paths.len() > 1 {
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


