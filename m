Return-Path: <linux-kernel+bounces-233928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F891BF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836A01C210AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5261BE86E;
	Fri, 28 Jun 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQGuf6YD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218701BE863
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581050; cv=none; b=flYTOMcrY5vU3BOHPKMYA7udysHsbHTADhXU5zNlNZ/TljKmLYUlHftGiHRT3xR0HkLJOv75cV0WmyzyjkqqMhKhIqIlvZMSaGADObSE2+K+ZIcFmc9IJwNKU6bOiLoZvX6xU4136kuu1D7yAkBMbxrURVhEAVDA8fCAWDHF13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581050; c=relaxed/simple;
	bh=smlzFG650Bjyj/G17d9Nx6uQENcjy/0hVqprbqaAZSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfPTiH7OrYRWAXjIddledsPavWFTRX29bJuh3szYzCsiN0ZQkcYtIMhoB7gjJLZSF12lcbJeHxq9qn1Yl2RGqKTOQmXuoIHr4PgAhK7HRDUrixnhMFLC2rYN7MOd4jWryVeXMhc6lmQ/sz4cfmzSTPpsVOwjL+5aeV8fnbeifE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQGuf6YD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035d85f403so933456276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719581048; x=1720185848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/a2ZCUdqZnx3gcLssluxRqmW7oZjQjPUNJsEztKYUiU=;
        b=EQGuf6YDaIc1yCZjuh9ZPQaCDH0boIuy00WO0StqDMFQNLXsb5TEqX6GxCPsYCyisu
         84hmNU3WSiMlr71+ldF3NxMI/z/u1dvowTxUK2cg2I05vr8mvjbqBHwL2lb1iNY3Zoyt
         SK7R2lZ064jqifNwSngsBNF0AEi9++HJGWsW6c1LXxfHRE06WLCmW4/qC2wLutaHd6UX
         XmZsQa01DOWGedpqAHaVo1/c8hD7ooEQ3UbKUireP5ffhsdC9Q1rQYMQTtoUjygSQ8DB
         uY+rilsBbBbBLNZyX9YbY7ogcHik3H9dbAFxSK0yudaKpstnX6MgzCwmrlEahNLDMLGB
         zIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581048; x=1720185848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a2ZCUdqZnx3gcLssluxRqmW7oZjQjPUNJsEztKYUiU=;
        b=PZRDozXb4MN/li5AxRlOT/8p5lEpfHK2Y5Ke2J6k3fJkXgpUEGbNyv/6xYu7o/Nse/
         wF3RPw0/1KXqC/lA5Z+zNsYysgUqlD+3eb4pFz0P+97o513RgL2KNwoqVUZi4c1JYb1Y
         qeCO8ENB8Y8yt70NLNIHJd8ZCzo5wOmJM2SQF++wJJ16Ygt7jjPZ9ZudUz1C0mtAwCEy
         kLXYzJFRvtMp1CegVVjNu4hrYGnpXYtOY76pjLdiGWwW2uK4oD7afXZk7huvbNV+r1Ou
         /MqC14HN7UAVqghUUNYHRiE3pJOoxSe2/OlfaeRWEznwmcDNumq2YkLGUn3Al4qNRWly
         f0iA==
X-Forwarded-Encrypted: i=1; AJvYcCU9kfkCwX63FQDdAR7usNP6SmmymJolhsG30JGrQaIX00vMYbgxtLXKJEWk/CHXQ8UFp6UoVnwv8VCyVo40MCWqKz+ErALZmdz/yp0J
X-Gm-Message-State: AOJu0Yw3eV3fsZ7YFR5mBs8BsmutDHFoopFg1Ig/jrdZOSSYYa2Xnxba
	Nh0NG6hPXJseRY53hte3wew013juvRVVeCiE0OGOG7VdxfBzJxLwbX/UOve4IuAYwaDyovCjOut
	6+woKdBJ0ZdhXyw==
X-Google-Smtp-Source: AGHT+IGK2JbrDPOIj4UtdPPGCRvHLr6NwiAv2YDbVcCcknMSROVSjrnV3BiQa7tDUYtaKr8A5oiO1msI8gMbuL0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1009:b0:e03:252a:f931 with SMTP
 id 3f1490d57ef6-e03252afca1mr21180276.1.1719581048085; Fri, 28 Jun 2024
 06:24:08 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:23:31 +0000
In-Reply-To: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9288; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=smlzFG650Bjyj/G17d9Nx6uQENcjy/0hVqprbqaAZSk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfrlw3bHKyORe0dE0EbrR0xejztmzSskCkdb1q
 8YpniSF/amJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn65cAAKCRAEWL7uWMY5
 RmF6D/4s+/xnuVSiUlgtEsduacVpUm4pE1jcx/Do8fGJ9OQfkiODdmUNe7KHShGgcJff1bKG5jr
 J0ZxJr/GVN2vslbojoTLkBHwhCEfY/aXJcT6/dmCWylHIKd1Z8xSA4Uf0fVDCph0gmr0+3fDl+3
 ND1WW57X9ZfVHYrNw53br5PavOcA/zTYzyyqoXKzUwHYXuRfPlWF+KGCAh5vHSPp+xJMUNJ9/rd
 xe6DRQ2I6mNjE14bZDgjixPJMnYetZDsn7OHtfGhTcxWNCeOCO+AtkETX+DPb1YywcwJQkbpBSC
 HT0GMYoa4klrOEj/1IL5aAtIQJjaWuqgOHYOS9+TvHqhfxBq8Zx6n4zibWP23zxPcTOyJect/An
 uVR+SRz9sbdH0HI2vVszXlm51cx5gNGxIFRYc81pbGbPGO6jLOvkEqPEeYUCCY5nnguSgWDqpjA
 9TYpro/ubpYC45Ry9XzS2m2iHQPBaaj4QPYiKO86g1vpdUlp0+FLAoJqyu1WZNk08i8+smeXe7U
 3mLF114P0UL1tpd1dwL8eOsFkoHg02AAy6IvTvcCxOR/fDqaT0blCbsr7FFTCyhuuF9EkQrNCW7
 xzvTGAOLliUGNSDFfoW/wnVuxKy4GxlwizdVQnlf3CvIZug0MGICixjVL8aALVEQDDweYf5BJGG DAULc4DNwd64I9Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-tracepoint-v4-1-353d523a9c15@google.com>
Subject: [PATCH v4 1/2] rust: add static_key_false
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add just enough support for static key so that we can use it from
tracepoints. Tracepoints rely on `static_key_false` even though it is
deprecated, so we add the same functionality to Rust.

It is not possible to use the existing C implementation of
arch_static_branch because it passes the argument `key` to inline
assembly as an 'i' parameter, so any attempt to add a C helper for this
function will fail to compile because the value of `key` must be known
at compile-time.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++++++++
 rust/kernel/arch/loongarch/jump_label.rs | 35 +++++++++++++++++++++++++++++
 rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++++++
 rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++++++++++
 rust/kernel/arch/x86/jump_label.rs       | 35 +++++++++++++++++++++++++++++
 rust/kernel/lib.rs                       |  2 ++
 rust/kernel/static_key.rs                | 32 +++++++++++++++++++++++++++
 scripts/Makefile.build                   |  2 +-
 8 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/arch/arm64/jump_label.rs b/rust/kernel/arch/arm64/jump_label.rs
new file mode 100644
index 000000000000..5eede2245718
--- /dev/null
+++ b/rust/kernel/arch/arm64/jump_label.rs
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Arm64 Rust implementation of jump_label.h
+
+/// arm64 implementation of arch_static_branch
+#[macro_export]
+#[cfg(target_arch = "aarch64")]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: nop
+
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .quad {1} + {2} + {3} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+            const $crate::arch::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+pub use arch_static_branch;
diff --git a/rust/kernel/arch/loongarch/jump_label.rs b/rust/kernel/arch/loongarch/jump_label.rs
new file mode 100644
index 000000000000..8d31318aeb11
--- /dev/null
+++ b/rust/kernel/arch/loongarch/jump_label.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Loongarch Rust implementation of jump_label.h
+
+/// loongarch implementation of arch_static_branch
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "loongarch64")]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: nop
+
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .quad {1} + {2} + {3} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+            const $crate::arch::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+pub use arch_static_branch;
diff --git a/rust/kernel/arch/mod.rs b/rust/kernel/arch/mod.rs
new file mode 100644
index 000000000000..14271d2530e9
--- /dev/null
+++ b/rust/kernel/arch/mod.rs
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Architecture specific code.
+
+#[cfg_attr(target_arch = "aarch64", path = "arm64")]
+#[cfg_attr(target_arch = "x86_64", path = "x86")]
+#[cfg_attr(target_arch = "loongarch64", path = "loongarch")]
+#[cfg_attr(target_arch = "riscv64", path = "riscv")]
+mod inner {
+    pub mod jump_label;
+}
+
+pub use self::inner::*;
+
+/// A helper used by inline assembly to pass a boolean to as a `const` parameter.
+///
+/// Using this function instead of a cast lets you assert that the input is a boolean, rather than
+/// some other type that can be cast to an integer.
+#[doc(hidden)]
+pub const fn bool_to_int(b: bool) -> i32 {
+    b as i32
+}
diff --git a/rust/kernel/arch/riscv/jump_label.rs b/rust/kernel/arch/riscv/jump_label.rs
new file mode 100644
index 000000000000..2672e0c6f033
--- /dev/null
+++ b/rust/kernel/arch/riscv/jump_label.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! RiscV Rust implementation of jump_label.h
+
+/// riscv implementation of arch_static_branch
+#[macro_export]
+#[cfg(target_arch = "riscv64")]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            .align  2
+            .option push
+            .option norelax
+            .option norvc
+            1: nop
+            .option pop
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .dword {1} + {2} + {3} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+            const $crate::arch::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+pub use arch_static_branch;
diff --git a/rust/kernel/arch/x86/jump_label.rs b/rust/kernel/arch/x86/jump_label.rs
new file mode 100644
index 000000000000..383bed273c50
--- /dev/null
+++ b/rust/kernel/arch/x86/jump_label.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! X86 Rust implementation of jump_label.h
+
+/// x86 implementation of arch_static_branch
+#[macro_export]
+#[cfg(target_arch = "x86_64")]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: .byte 0x0f,0x1f,0x44,0x00,0x00
+
+            .pushsection __jump_table,  "aw"
+            .balign 8
+            .long 1b - .
+            .long {0} - .
+            .quad {1} + {2} + {3} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+            const $crate::arch::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+pub use arch_static_branch;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..fffd4e1dd1c1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,6 +27,7 @@
 extern crate self as kernel;
 
 pub mod alloc;
+pub mod arch;
 mod build_assert;
 pub mod error;
 pub mod init;
@@ -38,6 +39,7 @@
 pub mod prelude;
 pub mod print;
 mod static_assert;
+pub mod static_key;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
new file mode 100644
index 000000000000..32cf027ef091
--- /dev/null
+++ b/rust/kernel/static_key.rs
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static keys.
+
+use crate::bindings::*;
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
+        $crate::arch::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
+    }};
+}
+
+pub use static_key_false;
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
2.45.2.803.g4e1b14247a-goog


