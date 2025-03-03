Return-Path: <linux-kernel+bounces-541181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E771A4B9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFBD3A6674
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8D1E5701;
	Mon,  3 Mar 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IM+P1vHr"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3991F03F8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991556; cv=none; b=OkUdr4+Q96tuan/y89FaT865G8SnGjRduUeSBBRdbR7+DbLtKxqECD7FLU3/pYqQC7aKwEN6u3vRsjZwhXrQZcdsVkM9/p2A8U2Yu+NSToa+7d+U++rPIjzDYWaAl6rXgyfXlyDce8VW1FGQw88w9qruReW1OfRgKpXtk8TjcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991556; c=relaxed/simple;
	bh=1SNAXOe9oyT3qRvAmlmyXdBbsP3AQD5dhDmNwYVOio8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4Ns7EqX9OqKZh6Mc+hGPZf6HRCQunp8GHEHYxWtHoAWONDlRhijNXaMbLise3Np/WEHuS4Hj21YWMax2FLIsFcR5QGkWd+SrgW+54g/6eL5qcYMahnRH/6Ponsl3bGVj4mF7bGjwxRsdnC/LKZBgMNy9rq1Zi5/7Ba/dPAhnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IM+P1vHr; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390e8df7ab6so1369938f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991553; x=1741596353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgRB7R3QxdYuF4ALv/yYMTfwUqi5oUHSBNOS9q0wOcQ=;
        b=IM+P1vHrFiUqhcC9xDjRvUZHkGQzJbarIU9rW4ZMrGjzRB1OkFCzyjWsCABsrsWoz0
         aOyhLeJ2OfN5GsnIiVc2RJfeYzhQ1KsA3YYLjoN/kMlu+PdDd52Z/uzGBgPeLaUOVmyJ
         sOtaxcQZoL/vYgp9fqZuMsI0wG85JzDZGMQiifYvzok5eMIBNy0ptp3xTaOx1qXgtiDJ
         4sKUejrJP00yS4NGqTQjdcTpWVO57SMbaKYH5sGBvej03P6RQU8S/9TrtqFNDYZ6rkHd
         T6GbrCtU35MrmnAm59Amf1PbbJM2ec4drHU0YoFOEu2QNJQim4aoOOdzYAs1MyEmQ/9h
         kNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991553; x=1741596353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgRB7R3QxdYuF4ALv/yYMTfwUqi5oUHSBNOS9q0wOcQ=;
        b=fEiuI+UzQwJNSsj3Y0praltns1+tPlbIN6udaT8FBJbt6xCVFAxQEpNfgN8f2rneBO
         9MqYNrPK6vl/hUZAqOK7YGv9Qjg7uUT8/1HxyJjqv8d8BaRN9iXoF0OwVFJ7UTT5cyOH
         tR6HWyuiYlT2Q80GBzjWV9Q7ZlxYYHOCgPwKJhCPs2P3DHA2EWcHCgNf4yi1jjgapOcf
         Xt/L3zBg0KSzxTt/rIglTv/GO8LqugiibNB1FA+7/Lyyk0BC/Vg01EVGnFOy8FVzysVL
         Q2rEJVhvGvEhcbxvVdWJmGl9tZrZv6NmqbDRe7OC6xl2lWTSjaBdfmmiZuDtCD4xDzX9
         OHSA==
X-Forwarded-Encrypted: i=1; AJvYcCX9czHLeCF1AQNsmdUWfjc75iq/H+c9TtThTHKnYZEmoPFn1lYtaf7rwHChoRbTyFQL+UJP53VucEqFhjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkko9OSq3M5TQQ6XP8asuNKfBARknsHzmslD5rFx067SGVmdd0
	IUA3TRRsiRjRvbj4Uz0NBi/sjRAZE9LLhu6IiDAtfyv6N3aVMhkvP0wiRp8sn86UsH1O8v80Dlt
	LJX8938uPG+vBAQ==
X-Google-Smtp-Source: AGHT+IEbagZM/EJ0D/zs3j/Sycg3tpD2lbmYa29N6g/8/oZyQL05ic4DnohKXYym9qS/gDiNrS+7p/b4SDKBM28=
X-Received: from wmsd10.prod.google.com ([2002:a05:600c:3aca:b0:439:9541:1cf5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588c:0:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-390eca414c6mr7792866f8f.42.1740991553493;
 Mon, 03 Mar 2025 00:45:53 -0800 (PST)
Date: Mon, 03 Mar 2025 08:45:14 +0000
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6732; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1SNAXOe9oyT3qRvAmlmyXdBbsP3AQD5dhDmNwYVOio8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxWw2t+6Dxj44koarvcgY9JDKUuMhLzySqp2yS
 kaGfNpNK3eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8VsNgAKCRAEWL7uWMY5
 RgwPD/9IdLzG+1nDOK5S9Nc3Wnyk6K1CZNtu7cX/HaCmzPhgLgoTKD3RncHw/rHaM0HaQpwUC0p
 wyoHfvjTiJB7C+/wx+uF3UJygcVabx1GU9ri9ZtkoRWaTcAbKXXB56Dr/a2N7nUKiDqTg8QSvR6
 efpNr+G5neqz+5RF7eN75GEIVYv1K3VTK5KzOslfmVBYybYNVFIXDtbbOaFvMgdHCRInkE79H/f
 3BaBPmUIvFHIKwTxBZIcGjaQpYopL6TdaM2Vn21eTxPsCWtowuJg91TGsrDFvBE1canWkG1Ie3C
 WswfS09Hr1ZX+ab0L/uTjunIWwi+2rkeeaceEAp023ESvo1Ei1Kd2LpVmsHL6/62BpDN85cp853
 I/6Y8sTLQheFSozz5bfOneb+Q4xfM+rfyaw8/bN33JkEUPbrXSb0XK/4JWFNuRnCQ45xk5rBjyD
 V0vRrVwLugEKOApFh7opcO1uovnWsmI2CzzvGv8+q45n0vqNIvnoWiwOyiBk60OHZFHb/yvCIQq
 5ntMZslk52d5qT9WCJefLx0JsmjeBhRyE8Kkj7qCrAeO1Mr85OFau9BnHRfm8bZ1sutuHaSiOYR
 GB4IuLgfwEc7zUOUmaDeGQ2IheDFUE9g+UnUgflSXUZUUF1q/tZCdoR22R8YrcnN835DzntiJZm Qo6fUXFEi7wHgrw==
X-Mailer: b4 0.14.1
Message-ID: <20250303-export-macro-v3-3-41fbad85a27f@google.com>
Subject: [PATCH v3 3/5] rust: add #[export] macro
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust has two different tools for generating function declarations to
call across the FFI boundary:

* bindgen. Generates Rust declarations from a C header.
* cbindgen. Generates C headers from Rust declarations.

However, we only use bindgen in the kernel. This means that when C code
calls a Rust function by name, its signature must be duplicated in both
Rust code and a C header, and the signature needs to be kept in sync
manually.

Introducing cbindgen as a mandatory dependency to build the kernel would
be a rather complex and large change, so we do not consider that at this
time. Instead, to eliminate this manual checking, introduce a new macro
that verifies at compile time that the two function declarations use the
same signature. The idea is to run the C declaration through bindgen,
and then have rustc verify that the function pointers have the same
type.

The signature must still be written twice, but at least you can no
longer get it wrong. If the signatures don't match, you will get errors
that look like this:

error[E0308]: `if` and `else` have incompatible types
  --> <linux>/rust/kernel/print.rs:22:22
   |
21 | #[export]
   | --------- expected because of this
22 | unsafe extern "C" fn rust_fmt_argument(
   |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
   |
   = note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
              found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *const c_void) -> *mut i8 {print::rust_fmt_argument}`

It is unfortunate that the error message starts out by saying "`if` and
`else` have incompatible types", but I believe the rest of the error
message is reasonably clear and not too confusing.

Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/prelude.rs |  2 +-
 rust/macros/export.rs  | 29 +++++++++++++++++++++++++++++
 rust/macros/helpers.rs | 19 ++++++++++++++++++-
 rust/macros/lib.rs     | 24 ++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index dde2e0649790..889102f5a81e 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
+pub use macros::{export, module, pin_data, pinned_drop, vtable, Zeroable};
 
 pub use super::{build_assert, build_error};
 
diff --git a/rust/macros/export.rs b/rust/macros/export.rs
new file mode 100644
index 000000000000..a08f6337d5c8
--- /dev/null
+++ b/rust/macros/export.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::helpers::function_name;
+use proc_macro::TokenStream;
+
+/// Please see [`crate::export`] for documentation.
+pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStream {
+    let Some(name) = function_name(ts.clone()) else {
+        return "::core::compile_error!(\"The #[export] attribute must be used on a function.\");"
+            .parse::<TokenStream>()
+            .unwrap();
+    };
+
+    // This verifies that the function has the same signature as the declaration generated by
+    // bindgen. It makes use of the fact that all branches of an if/else must have the same type.
+    let signature_check = quote!(
+        const _: () = {
+            if true {
+                ::kernel::bindings::#name
+            } else {
+                #name
+            };
+        };
+    );
+
+    let no_mangle = quote!(#[no_mangle]);
+
+    TokenStream::from_iter([signature_check, no_mangle, ts])
+}
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 563dcd2b7ace..3e04f8ecfc74 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{token_stream, Group, TokenStream, TokenTree};
+use proc_macro::{token_stream, Group, Ident, TokenStream, TokenTree};
 
 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
     if let Some(TokenTree::Ident(ident)) = it.next() {
@@ -215,3 +215,20 @@ pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
         rest,
     )
 }
+
+/// Given a function declaration, finds the name of the function.
+pub(crate) fn function_name(input: TokenStream) -> Option<Ident> {
+    let mut input = input.into_iter();
+    while let Some(token) = input.next() {
+        match token {
+            TokenTree::Ident(i) if i.to_string() == "fn" => {
+                if let Some(TokenTree::Ident(i)) = input.next() {
+                    return Some(i);
+                }
+                return None;
+            }
+            _ => continue,
+        }
+    }
+    None
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d61bc6a56425..a52443a3dbb9 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -9,6 +9,7 @@
 #[macro_use]
 mod quote;
 mod concat_idents;
+mod export;
 mod helpers;
 mod module;
 mod paste;
@@ -174,6 +175,29 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
     vtable::vtable(attr, ts)
 }
 
+/// Export a function so that C code can call it via a header file.
+///
+/// Functions exported using this macro can be called from C code using the declaration in the
+/// appropriate header file. It should only be used in cases where C calls the function through a
+/// header file; cases where C calls into Rust via a function pointer in a vtable (such as
+/// `file_operations`) should not use this macro.
+///
+/// This macro has the following effect:
+///
+/// * Disables name mangling for this function.
+/// * Verifies at compile-time that the function signature matches the declaration in the header
+///   file.
+///
+/// You must declare the signature of the Rust function in a header file that is included by
+/// `rust/bindings/bindings_helper.h`.
+///
+/// This macro is *not* the same as the C macros `EXPORT_SYMBOL_*`. All Rust symbols are currently
+/// automatically exported with `EXPORT_SYMBOL_GPL`.
+#[proc_macro_attribute]
+pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
+    export::export(attr, ts)
+}
+
 /// Concatenate two identifiers.
 ///
 /// This is useful in macros that need to declare or reference items with names

-- 
2.48.1.711.g2feabab25a-goog


