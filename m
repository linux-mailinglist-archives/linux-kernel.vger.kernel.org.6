Return-Path: <linux-kernel+bounces-538932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E6A49EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0049177C77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9F27425D;
	Fri, 28 Feb 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOFgXZoF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0C27424C;
	Fri, 28 Feb 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760447; cv=none; b=oArhI4i5XxGA27KRO4eprrLyX1eLQ2Hm5aG3MiyyYAdrb1YsDlzzR3LUVBaKi7ZQVcSDoA0HfmjcFN+cpIzzme5K3WW+5EB1xVR/p7ULMjCZqnW4kQTAcwY3+894f3H47Zbl8s2TUk0huuStuiiB40T0+GrKFVcNU5zJ1M7JFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760447; c=relaxed/simple;
	bh=Y7gVppC806d4x+N8BuSPq50RobAMFhNHz+K44jCJoZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1WxW/LP026YATvOemDulrUs+Xb54+RTPJScrHqTDnOshLft6e7Vdw1AulE0lvhJiOio+H6QSWAsBJZskcfSaRVzKHSH8/7ACF17UZgevbMyHOTvu9zTtzEqCMp0xdH8bJvOBVPaPXaj8z6SGlE8sQSrHEk1kdukcNP8/sZmEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOFgXZoF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c1412c76adso1298419fac.3;
        Fri, 28 Feb 2025 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760444; x=1741365244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bd2RecI7+OW3fvVxDHb0VZAopYNqNNRuxF3S461Ii4=;
        b=gOFgXZoFH8JEAmmmNkEwQpU10iejGoatr++F59R37CjRhbVunDLqYQGq6scm84iUXg
         69IAEwENKvea5s3vav+bVRp+/s4WtwCqZY8s5g9woBFwZz7/NTsO/USa+rQhZQc+pOgb
         1eelOAW2a7E4woN7Ms13yOs7TgfPzRsR1HrzE+Idd4fRK5o2n/6NXk7Bm67Mqn4dOOWZ
         dAjt/aPe4M6I3u6bkDZwP2zvNbBLPmTwDRarJn++Te8wX+hW85sKYTqYNxMY99XMTVV+
         3puPctzln/jr+YI3A9fJ556Y1FvvumFmV8Mma8DY4T+hJXYV85lxu/CMuNoyiiSMxdpd
         mCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760444; x=1741365244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bd2RecI7+OW3fvVxDHb0VZAopYNqNNRuxF3S461Ii4=;
        b=qWZEWRYrqOkvsXeCMhKySlDTUS0pQlMRCiIh0Ncr9FLBqkNVE/lMnifwvsGxOEELqQ
         82t17hoHha2g600vVYRg0QYcAfz+AYYaC3+cT4EOD7otbBLdOenN5WlJlJ8skqojF5lT
         C33HL6jroU4RMP65ZWWl22XYEi0LBS208GUeGfQSDsAHDWC9YNXNhgmAPeyTM4of6sxO
         JumhK5nWDbgbb7nFPGhZTX42Yv1ExDV4LY1bDH+HgHF4DjM/NIZUZmCgLjxlKNDXzFq9
         W9mna78xZ2PNKCULyXyLORB1rLEQfjeBb9PEykpN7x8QYpIZU18rMLi6097nhncCk2gv
         jJEA==
X-Forwarded-Encrypted: i=1; AJvYcCXT+Q/tC2SglDJlRBiX7W1vkN6FlJh6mwHyHHQR1RaVdSrgfftmJ4CbRnHrFxEo87ANgWBwUAEllD3tPutfnI4=@vger.kernel.org, AJvYcCXdFaeBnnBWIoiWKXLCszoXR+h+AMOPPgneIm9SzFhE3JROHbWTWTK55u9Tj2RGHHZp4kL/1wnT4+qGhLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWz3Ph7xVmNuKI+mLCWf1MDNnNNqSx+v1ig3IbYDa0zM5f/A5f
	oppQMmNZ6CJDvq2yAuJ2sB9mYnCQNecyi4xpW1SMK4grM8DX9ierjA5KaDC4vwOhWEh6iSd1aoa
	J/zrMaUXvzeazkwCT1DAd76B1VCU=
X-Gm-Gg: ASbGncvc8Ry2z3PSmtM9FJ6lSYMtK2IIk8FNbgDqi3r0YFRJ/OXw82mAYHuqFaqTo4t
	fn1x+7A656yu1ypewfZspwtQOvyh2DoAFbULd8MrFLifWJ1p547u8d/aXONcJS4JbQShAyRkit7
	CQOGc3ztA=
X-Google-Smtp-Source: AGHT+IE9ZVo6mD54mGDSvOGzvPh5RWvOb3z9Jfbise5M8Qj3jRErFfOxJ3fCzIeXRCOzzl7JzJkM6uMOxZnYeGzIZ3w=
X-Received: by 2002:a05:6870:7ec4:b0:288:60d6:f183 with SMTP id
 586e51a60fabf-2c17867f6cemr2391944fac.38.1740760443635; Fri, 28 Feb 2025
 08:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132928.880683-1-guillaume1.gomez@gmail.com> <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
In-Reply-To: <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Fri, 28 Feb 2025 17:33:51 +0100
X-Gm-Features: AQ5f1JoTV_Q2NcA9iZUtGfKyqSuHIjH6iANyXybeuv_F4-lO8JFyUnXw7N0XZbE
Message-ID: <CAAOQCfQ8wWzq8ktS3-uTpR7A-v_M9ruKcP3n=C7=RiLKaqychw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command
 line flag to improve doctest handling.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

> > +    let doctest_code =3D doctest_code.replace(
> > +        "} _inner().unwrap() }",
> > +        "} let test_return_value =3D _inner(); assert!(test_return_val=
ue.is_ok()); }",
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
is to add methods on `JsonValue` in a future patch which would allow to red=
uce
code in this file (and call `expect` too).

> These two bits could go in a first patch, I think, though it isn't a big =
deal.

You're absolutely right, removing them and sending a separate patch.

Here is the updated patch:


The goal of this patch is to remove the use of 2 unstable rustdoc features
(`--no-run` and `--test-builder`) and replace it with a stable feature:
`--output-format=3Ddoctest`, which was added in
https://github.com/rust-lang/rust/pull/134531.

Before this patch, the code was using very hacky methods in order to retrie=
ve
doctests, modify them as needed and then concatenate all of them in one fil=
e.

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
@@ -171,14 +171,14 @@ quiet_cmd_rustdoc_test_kernel =3D RUSTDOC TK $<
  rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
  mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
  OBJTREE=3D$(abspath $(objtree)) \
- $(RUSTDOC) --test $(rust_flags) \
+ $(RUSTDOC) --output-format=3Ddoctest $(rust_flags) \
  -L$(objtree)/$(obj) --extern ffi --extern kernel \
  --extern build_error --extern macros \
  --extern bindings --extern uapi \
- --no-run --crate-name kernel -Zunstable-options \
+ --crate-name kernel -Zunstable-options \
  --sysroot=3D/dev/null \
- --test-builder $(objtree)/scripts/rustdoc_test_builder \
- $< $(rustdoc_test_kernel_quiet); \
+ $< $(rustdoc_test_kernel_quiet) > rustdoc.json; \
+ cat rustdoc.json | $(objtree)/scripts/rustdoc_test_builder; \
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
+fn parse_ident<I: Iterator<Item =3D char>>(
+    iter: &mut I,
+    output: JsonValue,
+    ident: &str,
+) -> Result<JsonValue, String> {
+    let mut ident_iter =3D ident.chars().skip(1);
+
+    loop {
+        let i =3D ident_iter.next();
+        if i.is_none() {
+            return Ok(output);
+        }
+        let c =3D iter.next();
+        if i !=3D c {
+            if let Some(c) =3D c {
+                return Err(format!("Unexpected character `{c}` when
parsing `{ident}`"));
+            }
+            return Err(format!("Missing character when parsing `{ident}`")=
);
+        }
+    }
+}
+
+fn parse_string<I: Iterator<Item =3D char>>(iter: &mut I) ->
Result<JsonValue, String> {
+    let mut out =3D String::new();
+
+    while let Some(c) =3D iter.next() {
+        match c {
+            '\\' =3D> {
+                let Some(c) =3D iter.next() else { break };
+                match c {
+                    '"' | '\\' | '/' =3D> out.push(c),
+                    'b' =3D> out.push(char::from(0x8u8)),
+                    'f' =3D> out.push(char::from(0xCu8)),
+                    't' =3D> out.push('\t'),
+                    'r' =3D> out.push('\r'),
+                    'n' =3D> out.push('\n'),
+                    _ =3D> {
+                        // This code doesn't handle codepoints so we
put the string content as is.
+                        out.push('\\');
+                        out.push(c);
+                    }
+                }
+            }
+            '"' =3D> {
+                return Ok(JsonValue::String(out));
+            }
+            _ =3D> out.push(c),
+        }
+    }
+    Err(format!("Unclosed JSON string `{out}`"))
+}
+
+fn parse_number<I: Iterator<Item =3D char>>(
+    iter: &mut Peekable<I>,
+    digit: char,
+) -> Result<JsonValue, String> {
+    let mut nb =3D String::new();
+
+    nb.push(digit);
+    loop {
+        // We peek next character to prevent taking it from the
iterator in case it's a comma.
+        if matches!(iter.peek(), Some(',' | '}' | ']')) {
+            break;
+        }
+        let Some(c) =3D iter.next() else { break };
+        if c.is_whitespace() {
+            break;
+        } else if !c.is_ascii_digit() {
+            return Err(format!("Error when parsing number `{nb}`:
found `{c}`"));
+        }
+        nb.push(c);
+    }
+    i32::from_str(&nb)
+        .map(|nb| JsonValue::Number(nb))
+        .map_err(|error| format!("Invalid number: `{error}`"))
+}
+
+fn parse_array<I: Iterator<Item =3D char>>(iter: &mut Peekable<I>) ->
Result<JsonValue, String> {
+    let mut values =3D Vec::new();
+
+    'main: loop {
+        let Some(c) =3D iter.next() else {
+            return Err("Unclosed array".to_string());
+        };
+        if c.is_whitespace() {
+            continue;
+        } else if c =3D=3D ']' {
+            break;
+        }
+        values.push(parse(iter, c)?);
+        while let Some(c) =3D iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c =3D=3D ',' {
+                break;
+            } else if c =3D=3D ']' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"))=
;
+            }
+        }
+    }
+    Ok(JsonValue::Array(values))
+}
+
+fn parse_object<I: Iterator<Item =3D char>>(iter: &mut Peekable<I>) ->
Result<JsonValue, String> {
+    let mut values =3D HashMap::new();
+
+    'main: loop {
+        let Some(c) =3D iter.next() else {
+            return Err("Unclosed object".to_string());
+        };
+        let key;
+        if c.is_whitespace() {
+            continue;
+        } else if c =3D=3D '"' {
+            let JsonValue::String(k) =3D parse_string(iter)? else {
+                unreachable!()
+            };
+            key =3D k;
+        } else if c =3D=3D '}' {
+            break;
+        } else {
+            return Err(format!("Expected `\"` when parsing Object,
found `{c}`"));
+        }
+
+        // We then get the `:` separator.
+        loop {
+            let Some(c) =3D iter.next() else {
+                return Err(format!("Missing value after key `{key}`"));
+            };
+            if c.is_whitespace() {
+                continue;
+            } else if c =3D=3D ':' {
+                break;
+            } else {
+                return Err(format!(
+                    "Expected `:` after key, found `{c}` when parsing obje=
ct"
+                ));
+            }
+        }
+        // Then the value.
+        let value =3D loop {
+            let Some(c) =3D iter.next() else {
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
+        while let Some(c) =3D iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c =3D=3D ',' {
+                break;
+            } else if c =3D=3D '}' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"))=
;
+            }
+        }
+    }
+    Ok(JsonValue::Object(values))
+}
+
+fn parse<I: Iterator<Item =3D char>>(iter: &mut Peekable<I>, c: char)
-> Result<JsonValue, String> {
+    match c {
+        '{' =3D> parse_object(iter),
+        '"' =3D> parse_string(iter),
+        '[' =3D> parse_array(iter),
+        't' =3D> parse_ident(iter, JsonValue::Bool(true), "true"),
+        'f' =3D> parse_ident(iter, JsonValue::Bool(false), "false"),
+        'n' =3D> parse_ident(iter, JsonValue::Null, "null"),
+        c =3D> {
+            if c.is_ascii_digit() || c =3D=3D '-' {
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
+        let mut iter =3D input.chars().peekable();
+        let mut value =3D None;
+
+        while let Some(c) =3D iter.next() {
+            if c.is_whitespace() {
+                continue;
+            }
+            value =3D Some(parse(&mut iter, c)?);
+            break;
+        }
+        while let Some(c) =3D iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else {
+                return Err(format!("Unexpected character `{c}` after
content"));
+            }
+        }
+        if let Some(value) =3D value {
+            Ok(value)
+        } else {
+            Err("Empty content".to_string())
+        }
+    }
+}
diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder=
.rs
index e5894652f..ba17e9db9 100644
--- a/scripts/rustdoc_test_builder.rs
+++ b/scripts/rustdoc_test_builder.rs
@@ -15,58 +15,93 @@
 //! from that. For the moment, we generate ourselves a new name,
`{file}_{number}` instead, in
 //! the `gen` script (done there since we need to be aware of all the
tests in a given file).

+use std::fs::create_dir_all;
 use std::io::Read;

-fn main() {
-    let mut stdin =3D std::io::stdin().lock();
-    let mut body =3D String::new();
-    stdin.read_to_string(&mut body).unwrap();
+use json::JsonValue;

-    // Find the generated function name looking for the inner
function inside `main()`.
-    //
-    // The line we are looking for looks like one of the following:
-    //
-    // ```
-    // fn main() { #[allow(non_snake_case)] fn
_doctest_main_rust_kernel_file_rs_28_0() {
-    // fn main() { #[allow(non_snake_case)] fn
_doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl
core::fmt::Debug> {
-    // ```
-    //
-    // It should be unlikely that doctest code matches such lines
(when code is formatted properly).
-    let rustdoc_function_name =3D body
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
-            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c =3D=3D =
'_'))
-        })
-        .expect("No test function found in `rustdoc`'s output.");
+mod json;

-    // Qualify `Result` to avoid the collision with our own `Result`
coming from the prelude.
-    let body =3D body.replace(
-        &format!("{rustdoc_function_name}() -> Result<(), impl
core::fmt::Debug> {{"),
-        &format!("{rustdoc_function_name}() ->
core::result::Result<(), impl core::fmt::Debug> {{"),
-    );
+fn generate_doctest(file: &str, line: i32, doctest_code: &str) {
+    let file =3D file
+        .strip_suffix(".rs")
+        .unwrap_or(file)
+        .strip_prefix("../rust/kernel/")
+        .unwrap_or(file)
+        .replace('/', "_");
+    let path =3D format!("rust/test/doctests/kernel/{file}-{line}.rs");

+    // We replace the `Result` if needed.
+    let doctest_code =3D doctest_code.replace(
+        "fn main() { fn _inner() -> Result<",
+        "fn main() { fn _inner() -> core::result::Result<",
+    );
     // For tests that get generated with `Result`, like above,
`rustdoc` generates an `unwrap()` on
     // the return value to check there were no returned errors.
Instead, we use our assert macro
     // since we want to just fail the test, not panic the kernel.
     //
     // We save the result in a variable so that the failed assertion
message looks nicer.
-    let body =3D body.replace(
-        &format!("}} {rustdoc_function_name}().unwrap() }}"),
-        &format!("}} let test_return_value =3D
{rustdoc_function_name}(); assert!(test_return_value.is_ok()); }}"),
+    let doctest_code =3D doctest_code.replace(
+        "} _inner().unwrap() }",
+        "} let test_return_value =3D _inner();
assert!(test_return_value.is_ok()); }",
     );
+    std::fs::write(path, doctest_code.as_bytes()).unwrap();
+}
+
+fn main() {
+    let mut stdin =3D std::io::stdin().lock();
+    let mut body =3D String::new();
+    stdin.read_to_string(&mut body).unwrap();
+
+    let JsonValue::Object(rustdoc) =3D JsonValue::parse(&body).unwrap() el=
se {
+        panic!("Expected an object")
+    };
+    if let Some(JsonValue::Number(format_version)) =3D
rustdoc.get("format_version") {
+        if *format_version !=3D 1 {
+            panic!("unsupported rustdoc format version: {format_version}")=
;
+        }
+    } else {
+        panic!("missing `format_version` field");
+    }
+    let Some(JsonValue::Array(doctests)) =3D rustdoc.get("doctests") else =
{
+        panic!("`doctests` field is missing or has the wrong type");
+    };
+
+    // We ignore the error since it will fail when generating
doctests below if the folder doesn't
+    // exist.
+    let _ =3D create_dir_all("rust/test/doctests/kernel");

-    // Figure out a smaller test name based on the generated function name=
.
-    let name =3D rustdoc_function_name.split_once("_rust_kernel_").unwrap(=
).1;
+    let mut nb_generated =3D 0;
+    for doctest in doctests {
+        let JsonValue::Object(doctest) =3D doctest else {
+            unreachable!()
+        };

-    let path =3D format!("rust/test/doctests/kernel/{name}");
+        // We check if we need to skip this test by checking it's a
rust code and it's not ignored.
+        if let Some(JsonValue::Object(attributes)) =3D
doctest.get("doctest_attributes") {
+            if attributes.get("rust") !=3D Some(&JsonValue::Bool(true)) {
+                continue;
+            } else if let Some(JsonValue::String(ignore)) =3D
attributes.get("ignore") {
+                if ignore !=3D "None" {
+                    continue;
+                }
+            }
+        }
+        if let (
+            Some(JsonValue::String(file)),
+            Some(JsonValue::Number(line)),
+            Some(JsonValue::String(doctest_code)),
+        ) =3D (
+            doctest.get("file"),
+            doctest.get("line"),
+            doctest.get("doctest_code"),
+        ) {
+            generate_doctest(file, *line, doctest_code);
+            nb_generated +=3D 1;
+        }
+    }

-    std::fs::write(path, body.as_bytes()).unwrap();
+    if nb_generated =3D=3D 0 {
+        panic!("No test function found in `rustdoc`'s output.");
+    }
 }
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4..66e665ea0 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -48,7 +48,7 @@
 fn find_real_path<'a>(srctree: &Path, valid_paths: &'a mut
Vec<PathBuf>, file: &str) -> &'a str {
     valid_paths.clear();

-    let potential_components: Vec<&str> =3D
file.strip_suffix("_rs").unwrap().split('_').collect();
+    let potential_components: Vec<&str> =3D file.split('_').collect();

     find_candidates(srctree, valid_paths, Path::new(""),
&potential_components);
     fn find_candidates(
@@ -88,7 +88,7 @@ fn find_candidates(
     assert!(
         valid_paths.len() > 0,
         "No path candidates found. This is likely a bug in the build
system, or some files went \
-        away while compiling."
+        away while compiling.",
     );

     if valid_paths.len() > 1 {
@@ -126,12 +126,13 @@ fn main() {
     let mut valid_paths: Vec<PathBuf> =3D Vec::new();
     let mut real_path: &str =3D "";
     for path in paths {
-        // The `name` follows the `{file}_{line}_{number}` pattern
(see description in
+        // The `name` follows the `{file}_{line}` pattern (see description=
 in
         // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
         let name =3D path.file_name().unwrap().to_str().unwrap().to_string=
();

-        // Extract the `file` and the `line`, discarding the `number`.
-        let (file, line) =3D
name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
+        // Extract the `file` and the `line`, discarding the extension.
+        let (file, line) =3D name.rsplit_once('-').unwrap();
+        let line =3D line.split('.').next().unwrap();

         // Generate an ID sequence ("test number") for each one in the fil=
e.
         if file =3D=3D last_file {
--=20
2.48.1


Le ven. 28 f=C3=A9vr. 2025 =C3=A0 16:43, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Fri, Feb 28, 2025 at 2:29=E2=80=AFPM Guillaume Gomez
> <guillaume1.gomez@gmail.com> wrote:
> >
> > Before this patch, the code was using very hacky methods in order to re=
trieve
> > doctests, modify them as needed and then concatenate all of them in one=
 file.
> >
> > Now, with this new flag, it instead asks rustdoc to provide the doctest=
s
> > code with their associated information such as file path and line numbe=
r.
>
> Thanks for doing this (and the `rustdoc` side of it!), and welcome!
>
> Normally in commit messages we need to give more details:
>
>   - A Signed-off-by is required (please see for what that implies).
>
>     https://docs.kernel.org/process/submitting-patches.html#sign-your-wor=
k-the-developer-s-certificate-of-origin
>
>   - The commit message should explain the motivation, i.e. removing
> the 2 unstable `rustdoc` features, and moving to the new,
> intended-to-be-stable one (which one? etc.), and so on.
>
>   - Also, a bit of context (or at least linking to it) would be good,
> e.g. explaining that we were working on removing unstable features,
> and that `rustdoc` provided a new flag for the kernel, ideally with
> links to the relevant Rust tracking issues/PRs (typically with a
> "Link: " tag), plus which version the unstable feature is available,
> etc. (well, when we know for sure, i.e. I understand that we may need
> to tweak it still).
>
> Anyway, those are procedural details we can sort out later :) What is
> most important I think are the following two notes, please see below.
>
> > -       $(RUSTDOC) --test $(rust_flags) \
> > +       $(RUSTDOC) --output-format=3Ddoctest $(rust_flags) \
> >                 -L$(objtree)/$(obj) --extern ffi --extern kernel \
> >                 --extern build_error --extern macros \
> >                 --extern bindings --extern uapi \
> > -               --no-run --crate-name kernel -Zunstable-options \
> > +               --crate-name kernel -Zunstable-options \
> >                 --sysroot=3D/dev/null \
> > -               --test-builder $(objtree)/scripts/rustdoc_test_builder =
\
> > -               $< $(rustdoc_test_kernel_quiet); \
> > +               $< $(rustdoc_test_kernel_quiet) > rustdoc.json; \
> > +       cat rustdoc.json | $(objtree)/scripts/rustdoc_test_builder; \
> >         $(objtree)/scripts/rustdoc_test_gen
>
> We currently support versions 1.78+, so we will need to do these
> things conditionally. I can help with that, so don't worry too much
> about it for the moment (e.g. we have `rustc-option` and other helpers
> to pick the right flags given a version etc.).
>
> Similarly, we will also need to tell the script whether to use the old
> or the new way, too.
>
> > +    // We replace the `Result` if needed.
> > +    let doctest_code =3D doctest_code.replace(
> > +        "fn main() { fn _inner() -> Result<",
> > +        "fn main() { fn _inner() -> core::result::Result<",
> > +    );
>
> Hmm... I was hoping we could do something on the `rustdoc` side to
> remove these hacks altogether since we are going to have a "proper
> flag" for it, i.e. to avoid relying on the particular "format" of the
> tests somehow.
>
> I wrote about a bit of that here:
>
>     https://github.com/rust-lang/rust/pull/134531#discussion_r1894610592
>
> > +    let doctest_code =3D doctest_code.replace(
> > +        "} _inner().unwrap() }",
> > +        "} let test_return_value =3D _inner(); assert!(test_return_val=
ue.is_ok()); }",
> >      );
> > +    std::fs::write(path, doctest_code.as_bytes()).unwrap();
> > +}
>
> Same for this.
>
> > +    } else {
> > +        panic!("missing `format_version` field");
> > +    }
>
> `expect` maybe?
>
> > @@ -87,8 +87,8 @@ fn find_candidates(
> >
> >      assert!(
> >          valid_paths.len() > 0,
> > -        "No path candidates found. This is likely a bug in the build s=
ystem, or some files went \
> > -        away while compiling."
> > +        "No path candidates found for `{file}`. This is likely a bug i=
n the build system, or some \
> > +        files went away while compiling.",
> >      );
> >
> >      if valid_paths.len() > 1 {
> > @@ -97,8 +97,8 @@ fn find_candidates(
> >              eprintln!("    {path:?}");
> >          }
> >          panic!(
> > -            "Several path candidates found, please resolve the ambigui=
ty by renaming a file or \
> > -            folder."
> > +            "Several path candidates found for `{file}`, please resolv=
e the ambiguity by renaming \
> > +            a file or folder."
> >          );
> >      }
>
> These two bits could go in a first patch, I think, though it isn't a big =
deal.
>
> Thanks again for getting us out of unstable in `rustdoc`!
>
> Cheers,
> Miguel

