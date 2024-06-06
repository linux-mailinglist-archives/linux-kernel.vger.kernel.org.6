Return-Path: <linux-kernel+bounces-204549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3B48FF058
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC26A1C22D14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530219B5BD;
	Thu,  6 Jun 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tONNOKmR"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980C19B5A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686361; cv=none; b=O09qGAhuCveHBUyG5YNraISpYon/eRFBjE/Gl0i1GrR7cZrUYqRZ3IA2wKI/8Onf5cT1yE0frefZaoFjuPneE/CdH5slv3d/d14pH4XirQHNUnfrDmOpseCJ435cBPzUozJPOVNy9i54DBnd9ZKdtSt71FX7iUZQiJgiXGi5Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686361; c=relaxed/simple;
	bh=uHuK5cxCqNVkYxGJWDP/1f30u93vV/WBYZH9iUJYV3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJLbHMJzhE/16vLrV3eFzRh19hAV3R3H8DQmI6nnmgbUjRluHcJcFI37OCNeFCtlqRIoETc7mhkI/LN9HeeL7pm7dcOnYF02ZN/MX66oEM4Gdl+P5XSpMJN7XLA5l8EGubqoHjeb2RiRMNz3JrCxZXDNzxPaDi1cFFTl4BMfScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tONNOKmR; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ea93c06e3cso9373881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717686358; x=1718291158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9QSHkAsTwIK08A93jjRpyw8x8o2l5o1Rlv7tR4OejU=;
        b=tONNOKmRnShWw1pN3jV8h5u7NS1xBpvlPM1qFtK+n8OlBbLxtchQejcg85QjO3BJYw
         0KFdzKOvIgaxw249tccwh4mt7HwX0FjZqpKa55J0YbYSvuphgxkozM3pi5m4ZhHA+Hxc
         wf2+VCYfST+G+HZbySr+NjGFsbEHU01d654k3Shn+MLBqhGq+V/v3BFYkTAbm1dj8t1t
         gU1sr6Z+XaE9l+7ST9XyNcklS/kGRkv4V94gaxLZ5LqxYwNHdG1cjE0xts01Wq7Db9ie
         RjxszmU1BXtqxBJWemT46HWsKUlJYMwpD5UyLwBBjrp9Z3Eoh+2KTqHXzraNWLfwyEqY
         BTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686358; x=1718291158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9QSHkAsTwIK08A93jjRpyw8x8o2l5o1Rlv7tR4OejU=;
        b=H8uhNCgxu5Rgo/jZUx26egayWD3XluYfK26EEISCslM1/vi7fZJqUEeGdl4xZcCC5N
         m+ZfFJU6WV9vf+HvD0qMcFPOmgUb0Yeg0U4NRZCwmvkfglFKqyTia8o6HN4+jwFCnQhq
         Ilk+xofVtd6WHZ2X1S42MsiHeb4sWB3T1bjZb4T7PBtpT8dYvUj3Hiq3U7Trgq+R5GaY
         P6EMFQpmnhZQzfdzobahd7GNbwQF/Zmsjjzto6NSWk6fHuIJZdxKlLrrR4LBShjzAU3j
         anK9fWsVx/61n6Ea5gmCbFG477diwNl3gPe3gp9F7XJ4IOjNOhS/7qPVZ9oEdRa6q6Ef
         Qdog==
X-Forwarded-Encrypted: i=1; AJvYcCVFImm4gQGttzfjyU4N2KWjHd88tY3DTeXQzjjqN8U9M3MqFxzMl09TydI3dkqQcbmgUzzwBU3WO/spECqFfeR48HkxYRR6mhOgnOJM
X-Gm-Message-State: AOJu0Yxj7oBVaJ7UlGcA0ZiDYhNt7rD9lxZn14kuoFS5ObY6Ird9MdFG
	SRn4pAFVHgQy8ZCPHLRhi4/Ii5+QuyEUl15YmK5lOsm5/cd0o3DISq9xQyVg+USYRprokpB6/1E
	QYhvJF0vGiSemXA==
X-Google-Smtp-Source: AGHT+IEkXpPuontDmJFUZKaqvGblSitXXKIgIsSGBnTpCuf/+wnRYsTU/LOByO7Ao309s/06RJ1U2FmGmlwULhM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:8082:0:b0:2ea:82c7:33cf with SMTP id
 38308e7fff4ca-2eac7a97074mr62471fa.10.1717686357499; Thu, 06 Jun 2024
 08:05:57 -0700 (PDT)
Date: Thu, 06 Jun 2024 15:05:25 +0000
In-Reply-To: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4222; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uHuK5cxCqNVkYxGJWDP/1f30u93vV/WBYZH9iUJYV3U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmYdBKoUoIL/G+5ecJleyzv9Uh17RVRQHXMZ0gd
 s0xAlyPxmSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmHQSgAKCRAEWL7uWMY5
 RhvJD/9oQToFBgs8kw4XgbLrWL0zjwaOWrckWwvD8cwzPfnmq/2ghW6DoVOXs8w8J4rxycXTOjV
 fCXOenZ0frK62IFBwcQxpcK43worsfjN8LGzgkmFy675pdJZQOGI/HOKc7Z4yvVSp/1uWMB6tSy
 2pUwJbqFzh7oKCAnHDl72zt0NmoAo6CUlPSntj7nzvhZH94zijFtT7DqjSm91WHbT+OgMRRJPTw
 WQqzLHjkP+u7Weg03ftuFndJGB0y0LSySMsFJ67qHYyD9R8i8jnRn44srHPu5Mt5osUX7XC3B9W
 WrSINyhKQOEpJ+nBmLTLJWyQo2Zlu1yFh6ODt3mT56RNXjziApotIyXnkcDpW7bGWFhw+5OtS0b
 Xy1JsusGh+oWIDWRFRa6JdzHQ0IPgUwWEj7zoPT6XGQFpc7Yxi4mMwBb+OEU2mbAKJ77oTSJkiG
 d+rGxeS0fjVx82l8Ta22js8ZQx8NmLja+wC/Q33Po2WYZoYNV5NItlLMp2wxZewMe8PdcaHpUoY
 8pvQncs8ZCntY/nkhLt9BnEiUye4/5kr7HOplUPZtCd8+zFGYlGcyDw7jNf0MBXnb4LbZEwfs3A
 aCHDZC+ds2RxbxhUksw3YnCInW6cFgHYfBz85OgBwKaSFuWvwyylOkYFMNabqtLaIEVNgdyW8Ga 4drFLhl+VtNBx7A==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240606-tracepoint-v1-2-6551627bf51b@google.com>
Subject: [PATCH 2/3] rust: add static_key_false
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

Add just enough support for static key so that we can use it from
tracepoints. Tracepoints rely on `static_key_false` even though it is
deprecated, so we add the same functionality to Rust.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs        |  1 +
 rust/kernel/static_key.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build    |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d534b1178955..22e1fedd0774 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 pub mod print;
 mod static_assert;
 pub mod static_call;
+pub mod static_key;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
new file mode 100644
index 000000000000..6c3dbe14c98a
--- /dev/null
+++ b/rust/kernel/static_key.rs
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static keys.
+
+use crate::bindings::*;
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "x86_64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: .byte 0x0f,0x1f,0x44,0x00,0x00
+
+            .pushsection __jump_table,  "aw"
+            .balign 8
+            .long 1b - .
+            .long {0} - .
+            .quad {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "aarch64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: nop
+
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .quad {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+/// Branch based on a static key.
+///
+/// Takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+#[macro_export]
+macro_rules! static_key_false {
+    // Forward to the real implementation. Separated like this so that we don't have to duplicate
+    // the documentation.
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        // Assert that `$key` has type `$keytyp` and that `$key.$field` has type `static_key`.
+        //
+        // SAFETY: We know that `$key` is a static because otherwise the inline assembly will not
+        // compile. The raw pointers created in this block are in-bounds of `$key`.
+        static _TY_ASSERT: () = unsafe {
+            let key: *const $keytyp = ::core::ptr::addr_of!($key);
+            let _: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*key).$field);
+        };
+
+        $crate::static_key::_static_key_false! { $key, $keytyp, $field }
+    }};
+}
+
+pub use {_static_key_false, static_key_false};
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index efacca63c897..60197c1c063f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := asm_const,asm_goto,new_uninit
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree

-- 
2.45.2.505.gda0bf45e8d-goog


