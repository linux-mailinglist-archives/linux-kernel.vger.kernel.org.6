Return-Path: <linux-kernel+bounces-546651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3CA4FD46
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574673A5405
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C43230BD9;
	Wed,  5 Mar 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFbd3KHI"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40422D4E5;
	Wed,  5 Mar 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173035; cv=none; b=XYgBBKae+xNDmRaGwbV927CvAsB9YSRnPpaHPrjG2CIEpd5UJU9gsp+n4K/zJkcSa2V1BUav3iL3iz4qqeNqKa63tBYuazPSZvapVYoIsvDCvW9UhPRyrkqk5Pj2Gp50jN8msOSUYff8O/wsCwFxCaj3ixCtWZ3zc1aECBgmX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173035; c=relaxed/simple;
	bh=mUCIiJMFdRqa4UAz/nNpJz2MgPI0oX2+OeDuzzGcydE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKeeGYqIHgT+49OLbTYYghr+qTHfcmrqetqIPZ4apCc/IswjhrfCFMIxXeuH0KPUXOsTQ/SgMSeOJvNV3T7Ge6UtguUtI96A62mCIHDpjWsc6VI2EeQofXwK0bTk5DRu/mIEWg+bgxBKwy0MMmvHtY0ulRmhr9Zmi1vKoPGjGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFbd3KHI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb9078888so11197067a91.3;
        Wed, 05 Mar 2025 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741173033; x=1741777833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZIVwfRNHK6kNeOdoFYJVwWZHHm2mKiUA2qVfu9IUvI=;
        b=MFbd3KHILPK0WQQFsQUR6M1+LbhPQfGSneG84iIa0i7aQ/s8zLuURW0uWsEOLkuoBH
         k44s8eguSJQd38MFIqImRbsu//h6oj8EDZ2dLcprMcgX3wjVoYU5KINk8oygV6TBA4Db
         G72FZX2JghnXsFCbxbXD4oR+9ItYm2l6PAz2bA8LyYv1IjJVMMbXBDNaTFcmKDbRfsCl
         mhVlOJXIpk+j7DifrVrxmce1IY9NRrpaptWM0KUGDm6ZCFvL/PrLYtRMKR0v2kl/m/vc
         CpaA10IEDXa/y9Jz3D8ICRBHGbZ6zTv/e6mgLCGTIkHP/KWXPw1TyIQpvzSkrHGe+mY6
         dH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173033; x=1741777833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZIVwfRNHK6kNeOdoFYJVwWZHHm2mKiUA2qVfu9IUvI=;
        b=LVbN3Sg2YjfvSULDwutjIkTCqTRX5oPT/nMZ/HXZG9enash61bOi2y2ci2g9rsm+jq
         mZbCjFJNUribmJxpX5k1wcgmJ9WdqCNgfHB6ZSA4b9b9nVOxcG9t9Ulg/lByDiGBqKWe
         a0Pm5U/2to/XG4EdTdO87BqdWUQu7/38HlJWhrLGjv5NLBRRloj9XFx8n4GxDtzSCXP0
         Z217p7QvmusK/AZkEaP3iiqbMhUf1KB8hOZX/99zQP/yqXNODpiUUmG8Oz3O4nM/kxSu
         x433sdBxh7BS+NCaN565/PND4GOETLvFWGJuDdA8ofEIobHY5H+7VW1iVm0mihPk2lTH
         yiqw==
X-Forwarded-Encrypted: i=1; AJvYcCW5C4WJSiP9diQJVL/jNqWmJmNj7EanDgDwxqE/+jQ/NTQ2H6h18XUSY9hsZUgPE48DDI5bXFV99J2MfZsQqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzhw5fT1DVE4QMvs9NlOXGhOWTm7Is32K4lPreTZD0rddW6vU
	athlTxV9b16//R3SkjpWGI5+bnmp6jjIxeAWHFlz446mqy/h8JCUgLq5f6NB
X-Gm-Gg: ASbGncs6NWCsE35u6UcZJu1CL3l3g+UZpfMWbyQhjZ2c49w+toDOQ+sPYh0Gq+sq9JM
	ncH0xlwv8ZH5++o/16yIS5qqxLwZGgRGU44xTt5sMFo8RIo3zw/YH2CF8Gnyl2jG9fb/K69YU1n
	PpTiPkVMRrqWrMgEjh2NGHVrD9X2QvvzuXmPpdSPOT0Eox7XJJXQPRS4aH6YpG3la0Snc5GPckn
	DwQTiUKP30oz1rjS4JlGOuyJwAcCHUE93acD92y8oU3kd5UiA3D8zb1tIp0kUGshXym+AbsKcqS
	Ga0r5rKLAewlrlU2MARlIkA/X/r9dBUzSrYO8+T6tsLCom4cyP4BqZRt6iq9GMsnWBxPTzP+jWf
	fOmaS52cAm4tx5IQfhHY5eA==
X-Google-Smtp-Source: AGHT+IEVpBJoZMey/oq7KQx8VoCm5/CPecSnmaQRffQchUbmPSyo23fN5Nngz82dlmdkqtYGVJHxoA==
X-Received: by 2002:a17:90a:d648:b0:2f8:49ad:4079 with SMTP id 98e67ed59e1d1-2ff4978a5efmr4417181a91.6.1741173032744;
        Wed, 05 Mar 2025 03:10:32 -0800 (PST)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm1060925a91.13.2025.03.05.03.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:10:32 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
	hpa@zytor.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tangyouling@loongson.cn,
	hejinyang@loongson.cn,
	yangtiezhu@loongson.cn,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Subject: [PATCH v4 4/4] rust: Add warn_on macro
Date: Wed,  5 Mar 2025 20:08:14 +0900
Message-ID: <20250305110814.272792-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305110814.272792-1-fujita.tomonori@gmail.com>
References: <20250305110814.272792-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add warn_on macro, uses the BUG/WARN feature (lib/bug.c) via assembly
for x86_64/arm64/riscv.

The current Rust code simply wraps BUG() macro but doesn't provide the
proper debug information. The BUG/WARN feature can only be used from
assembly.

This uses the assembly code exported by the C side via ARCH_WARN_ASM
macro. To avoid duplicating the assembly code, this approach follows
the same strategy as the static branch code: it generates the assembly
code for Rust using the C preprocessor at compile time.

Similarly, ARCH_WARN_REACHABLE is also used at compile time to
generate the assembly code; objtool's reachable anotation code. It's
used for only architectures that use objtool.

For now, Loongarch just uses a wrapper for WARN macro.

UML doesn't use the assembly BUG/WARN feature; just wrapping generic
BUG/WARN functions implemented in C works.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/Makefile                                 |   8 ++
 rust/helpers/bug.c                            |   5 +
 rust/kernel/.gitignore                        |   2 +
 rust/kernel/bug.rs                            | 113 ++++++++++++++++++
 rust/kernel/generated_arch_reachable_asm.rs.S |   7 ++
 rust/kernel/generated_arch_warn_asm.rs.S      |   7 ++
 rust/kernel/lib.rs                            |   1 +
 7 files changed, 143 insertions(+)
 create mode 100644 rust/kernel/bug.rs
 create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
 create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S

diff --git a/rust/Makefile b/rust/Makefile
index 8fcfd60447bc..a295b65c43f3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -34,6 +34,9 @@ obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
 
 always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/generated_arch_static_branch_asm.rs
+ifndef CONFIG_UML
+always-$(subst y,$(CONFIG_RUST),$(CONFIG_BUG)) += kernel/generated_arch_warn_asm.rs kernel/generated_arch_reachable_asm.rs
+endif
 
 # Avoids running `$(RUSTC)` when it may not be available.
 ifdef CONFIG_RUST
@@ -481,5 +484,10 @@ $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o \
 ifdef CONFIG_JUMP_LABEL
 $(obj)/kernel.o: $(obj)/kernel/generated_arch_static_branch_asm.rs
 endif
+ifndef CONFIG_UML
+ifdef CONFIG_BUG
+$(obj)/kernel.o: $(obj)/kernel/generated_arch_warn_asm.rs $(obj)/kernel/generated_arch_reachable_asm.rs
+endif
+endif
 
 endif # CONFIG_RUST
diff --git a/rust/helpers/bug.c b/rust/helpers/bug.c
index e2d13babc737..a62c96f507d1 100644
--- a/rust/helpers/bug.c
+++ b/rust/helpers/bug.c
@@ -6,3 +6,8 @@ __noreturn void rust_helper_BUG(void)
 {
 	BUG();
 }
+
+bool rust_helper_WARN_ON(bool cond)
+{
+	return WARN_ON(cond);
+}
diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
index 6ba39a178f30..f636ad95aaf3 100644
--- a/rust/kernel/.gitignore
+++ b/rust/kernel/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 /generated_arch_static_branch_asm.rs
+/generated_arch_warn_asm.rs
+/generated_arch_reachable_asm.rs
diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
new file mode 100644
index 000000000000..a010033be5a2
--- /dev/null
+++ b/rust/kernel/bug.rs
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024, 2025 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Support for BUG and WARN functionality.
+//!
+//! C header: [`include/asm-generic/bug.h`](srctree/include/asm-generic/bug.h)
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(all(CONFIG_BUG, not(CONFIG_UML), not(CONFIG_LOONGARCH)))]
+#[cfg(CONFIG_DEBUG_BUGVERBOSE)]
+macro_rules! warn_flags {
+    ($flags:expr) => {
+        const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
+        const _FILE: &[u8] = file!().as_bytes();
+        // Plus one for null-terminator.
+        static FILE: [u8; _FILE.len() + 1] = {
+            let mut bytes = [0; _FILE.len() + 1];
+            let mut i = 0;
+            while i < _FILE.len() {
+                bytes[i] = _FILE[i];
+                i += 1;
+            }
+            bytes
+        };
+        // SAFETY: Just an FFI call.
+        unsafe {
+            $crate::asm!(concat!(
+                "/* {size} */",
+                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
+            file = sym FILE,
+            line = const line!(),
+            flags = const FLAGS,
+            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
+            );
+        }
+    }
+}
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(all(CONFIG_BUG, not(CONFIG_UML), not(CONFIG_LOONGARCH)))]
+#[cfg(not(CONFIG_DEBUG_BUGVERBOSE))]
+macro_rules! warn_flags {
+    ($flags:expr) => {
+        const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
+        // SAFETY: Just an FFI call.
+        unsafe {
+            $crate::asm!(
+            concat!(
+                "/* {size} */",
+                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
+                include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")));
+            flags = const FLAGS,
+            size = const ::core::mem::size_of::<$crate::bindings::bug_entry>(),
+            );
+        }
+    }
+}
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(all(CONFIG_BUG, CONFIG_UML))]
+macro_rules! warn_flags {
+    ($flags:expr) => {
+        // SAFETY: Just an FFI call.
+        unsafe {
+            $crate::bindings::warn_slowpath_fmt(
+                $crate::c_str!(::core::file!()).as_ptr() as *const ::core::ffi::c_uchar,
+                line!() as i32,
+                $flags as u32,
+                ::core::ptr::null() as *const ::core::ffi::c_uchar,
+            );
+        }
+    };
+}
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(all(CONFIG_BUG, CONFIG_LOONGARCH))]
+macro_rules! warn_flags {
+    ($flags:expr) => {
+        // SAFETY: Just an FFI call.
+        unsafe { $crate::bindings::WARN_ON(true) }
+    };
+}
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(not(CONFIG_BUG))]
+macro_rules! warn_flags {
+    ($flags:expr) => {};
+}
+
+#[doc(hidden)]
+pub const fn bugflag_taint(value: u32) -> u32 {
+    value << 8
+}
+
+/// Report a warning if `cond` is true and return the condition's evaluation result.
+#[macro_export]
+macro_rules! warn_on {
+    ($cond:expr) => {{
+        if $cond {
+            const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
+
+            $crate::warn_flags!(WARN_ON_FLAGS);
+        }
+        $cond
+    }};
+}
diff --git a/rust/kernel/generated_arch_reachable_asm.rs.S b/rust/kernel/generated_arch_reachable_asm.rs.S
new file mode 100644
index 000000000000..3886a9ad3a99
--- /dev/null
+++ b/rust/kernel/generated_arch_reachable_asm.rs.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/bug.h>
+
+// Cut here.
+
+::kernel::concat_literals!(ARCH_WARN_REACHABLE)
diff --git a/rust/kernel/generated_arch_warn_asm.rs.S b/rust/kernel/generated_arch_warn_asm.rs.S
new file mode 100644
index 000000000000..409eb4c2d3a1
--- /dev/null
+++ b/rust/kernel/generated_arch_warn_asm.rs.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/bug.h>
+
+// Cut here.
+
+::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}",  "{flags}", "{size}"))
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..c0720846b249 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod alloc;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
+pub mod bug;
 #[doc(hidden)]
 pub mod build_assert;
 pub mod cred;
-- 
2.43.0


