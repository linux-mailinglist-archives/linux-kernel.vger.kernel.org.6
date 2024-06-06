Return-Path: <linux-kernel+bounces-204548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AF8FF053
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA428D93E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006119B59A;
	Thu,  6 Jun 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxRKjxuX"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DA1990AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686358; cv=none; b=kSaVqXVFD9dKNXPGaXzqfyYOSpGRmxOkZPaGh7P8Z2YSWxNCadVFrERC6azflamMdeBLQcbI+iso+OIj/DBO891sww9Zs4YPbKTGYFSaqfy/K0afjqSRmmeM4JEODepbspHo19OU/FfBQev+Xi0hjAjIYT8p6tTp1vusHv3YZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686358; c=relaxed/simple;
	bh=VFFXazztmY9tR8xMGIPWOtLDs5Ye6yzjN07cIKwKBuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lSlFjXTBK6/4nhB8HppJZacXutotkr/Xv2cOgl4LfSKQeJ/DMSUafNjPbobc4jgmBwfc7E0COg+0QYd2BeIb4jflbdAhu2Iu5FQpaaG+JUqZ3RBA4aBWT6RfYTeQUIsbdJ/pQX4a4AmWK6dBCYohwvklDcwBO3RO6NOHnhUXD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxRKjxuX; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52b85bc3216so881378e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717686355; x=1718291155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfXZTl4B3xvX6SOW1W7GHYUYqMo3gKS0xEQFx1y1p+8=;
        b=OxRKjxuXoH0O+4c3qpv+GxnAa7eXCuu+sfzZfM8MAObycZKs51zCHzjiT2dvDkHkJv
         nau1AYQqHOqHTo5dT6Msh/DuN2r2iGpOToeWyzi+n+o2qMcN0fGV0LZoOm07ouDfJmCD
         hGmtgoAXbQzPX9dv8IHkVhayIxOZS5NZiLi7TahStC7tf9EnrX2twh9LMBb3YB2Lcnwb
         nXcLrmEc+NQILml+UixTSvXINmoFoqOa2pww0lQ+dyi8LPg1luEZrJPzQb39h33xaPLR
         FzIKTwzDI5hkFrci/09WIPBEXarP+pF2fQw0c/LLMXmRxHbVCuvuCr/lSBeupqTeg8r5
         D96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686355; x=1718291155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfXZTl4B3xvX6SOW1W7GHYUYqMo3gKS0xEQFx1y1p+8=;
        b=U+GOo4HZfFtqYPHhfbiMbpA2rkMNvf97/vDfNbRn5/kdBAf5JULi/ap+oetYzOz96o
         6TffKP96qgrfaOyfeqaysV98zolmrEjz7qXEA35xNTaE1+4x52B3ZuoG6uVL3S3bxc0q
         ZF+B05u9NWfAu27osfMjsKGX26al8T6o6wafzqOwSwl6mnM/1nrebRjNb+2buuW3Y//A
         DsT809fUyYJzQAhYTsniJlBmmFOw8CRSxU36/rDMOLZtUGKWcMVL5JyndlZAQGTtQkQ7
         hzbYFuw1c6yO+P45MNCDF1W5L2mCv2F2u0WlMqgd5gwMClNUra4GsgUyfv6pbzTE82xV
         t8LA==
X-Forwarded-Encrypted: i=1; AJvYcCUuecK0z00iRn74b5D7cquUXc4yG5Y9Z9YYSvnfNLHIY/5q2C07ul6ddUyxlvyMmumRYLKXW2csXXOBGO66QtLftZbx1RVkY6Cn8lnR
X-Gm-Message-State: AOJu0YxPKIHX3ybx/PGfGVAYs7RiYlUjQ2tbLDi28c8vaS2vzLw5wcHu
	nmWX30ro+U/oqzXVRcK3ISZE9HU1YowQpHOzsLHPR+Um9pkwyj+Sqvb7FkhNS1WFewiAyeLd+mE
	cMKbeOQvHcJainA==
X-Google-Smtp-Source: AGHT+IEmhbHPuo49cWbozLCcAw8HPDoOUQPCCoJ5U1tZ9t3BRAJIEYeV4n48VgOfQlUamRkSC+ASE//k2dJAcvc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:228d:b0:522:e17:7a21 with SMTP
 id 2adb3069b0e04-52bab508fb8mr6516e87.11.1717686354408; Thu, 06 Jun 2024
 08:05:54 -0700 (PDT)
Date: Thu, 06 Jun 2024 15:05:24 +0000
In-Reply-To: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3993; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=VFFXazztmY9tR8xMGIPWOtLDs5Ye6yzjN07cIKwKBuk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmYdBKrNLgiljlOwRqSiSG7++Zael6mAiUfC69m
 MDnQpixko6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmHQSgAKCRAEWL7uWMY5
 RnFND/4kQp/lkvYAvaa5P9e1hZkXiQfV7GjO7L5daH8gg0x2AH9hOaDIsuJ9OKsgXf0IrEXeR+u
 WagKY23uHT1Vy8PHm1+Gjbv8QpVLtt+rURgrVYZqakdhx1gQ0bYFFNz1E7AHG4X788rWDT/pJi9
 tr57IbW6Hf2eU5/lyP5InJfKnkSnJp3hSuMwsF2MgAh/PkTS4d3SuhPweqkt/eenc7n3n6JJdAH
 avROWCoC+vs//Nt0ZYcKcTPB1jRoxMaj3zue2HS2fSPmxmIS5aI/v3lvgJXBjOF+5EH1w/YoCE1
 slYDA2A8bt5If2MzjcNcdaCaUEGPRJDnhORdZ4ysoaEwkjriaXURmXuxT9oO+bpoWjzaptU0pPo
 hgRz43xAHV0X2edmAQzf/HvfnYSumrcItOTWup9e5lzsg47KnZRZpVN0Tf/mqOLpuOwKIN/inGP
 Fhyoz5tLNaYYcEsWS21J5TbvpjrzW527UM2djAEmrkkNaICAyQ6KtAxiRTMzFTGNQ0aZM1TmwiP
 yKQ4/cBKWuzr2dWkVAjEw7pkrit2unrQfpJ4bf+CB7HIxslDOl3FVZ5iZiqPq+H1FB5mUYDOt45
 gzQMzj9ncgyOP4eezGebUDOMQHrSGNpJAb4OQrqC6UtwOzneoscChotPyCsjsyYDX+GlThZ0796 UlPjVePCTZ/KMNw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240606-tracepoint-v1-1-6551627bf51b@google.com>
Subject: [PATCH 1/3] rust: add static_call support
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add static_call support by mirroring how C does. When the platform does
not support static calls (right now, that means that it is not x86),
then the function pointer is loaded from a global and called. Otherwise,
we generate a call to a trampoline function, and objtool is used to make
these calls patchable at runtime.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs         |  1 +
 rust/kernel/static_call.rs | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..d534b1178955 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod prelude;
 pub mod print;
 mod static_assert;
+pub mod static_call;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/static_call.rs b/rust/kernel/static_call.rs
new file mode 100644
index 000000000000..f7b8ba7bf1fb
--- /dev/null
+++ b/rust/kernel/static_call.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static calls.
+
+#[macro_export]
+#[doc(hidden)]
+macro_rules! ty_underscore_for {
+    ($arg:expr) => {
+        _
+    };
+}
+
+#[doc(hidden)]
+#[repr(transparent)]
+pub struct AddressableStaticCallKey {
+    _ptr: *const bindings::static_call_key,
+}
+unsafe impl Sync for AddressableStaticCallKey {}
+impl AddressableStaticCallKey {
+    pub const fn new(ptr: *const bindings::static_call_key) -> Self {
+        Self { _ptr: ptr }
+    }
+}
+
+#[cfg(CONFIG_HAVE_STATIC_CALL)]
+#[doc(hidden)]
+#[macro_export]
+macro_rules! _static_call {
+    ($name:ident($($args:expr),* $(,)?)) => {{
+        // Symbol mangling will give this symbol a unique name.
+        #[cfg(CONFIG_HAVE_STATIC_CALL_INLINE)]
+        #[link_section = ".discard.addressable"]
+        #[used]
+        static __ADDRESSABLE: $crate::static_call::AddressableStaticCallKey = unsafe {
+            $crate::static_call::AddressableStaticCallKey::new(::core::ptr::addr_of!(
+                $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }
+            ))
+        };
+
+        let fn_ptr: unsafe extern "C" fn($($crate::static_call::ty_underscore_for!($args)),*) -> _ =
+            $crate::macros::paste! { $crate::bindings:: [<__SCT__ $name >]; };
+        (fn_ptr)($($args),*)
+    }};
+}
+
+#[cfg(not(CONFIG_HAVE_STATIC_CALL))]
+#[doc(hidden)]
+#[macro_export]
+macro_rules! _static_call {
+    ($name:ident($($args:expr),* $(,)?)) => {{
+        let void_ptr_fn: *mut ::core::ffi::c_void =
+            $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }.func;
+
+        let fn_ptr: unsafe extern "C" fn($($crate::static_call::ty_underscore_for!($args)),*) -> _ =
+            if true {
+                ::core::mem::transmute(void_ptr_fn)
+            } else {
+                // This is dead code, but it influences type inference on `fn_ptr` so that we
+                // transmute the function pointer to the right type.
+                $crate::macros::paste! { $crate::bindings:: [<__SCT__ $name >]; }
+            };
+
+        (fn_ptr)($($args),*)
+    }};
+}
+
+/// Statically call a global function.
+///
+/// # Safety
+///
+/// This macro will call the provided function. It is up to the caller to uphold the safety
+/// guarantees of the function.
+///
+/// # Examples
+///
+/// ```ignore
+/// fn call_static() {
+///     unsafe {
+///         static_call! { your_static_call() };
+///     }
+/// }
+/// ```
+#[macro_export]
+macro_rules! static_call {
+    // Forward to the real implementation. Separated like this so that we don't have to duplicate
+    // the documentation.
+    ($($args:tt)*) => { $crate::static_call::_static_call! { $($args)* } };
+}
+
+pub use {_static_call, static_call, ty_underscore_for};

-- 
2.45.2.505.gda0bf45e8d-goog


