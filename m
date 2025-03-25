Return-Path: <linux-kernel+bounces-575390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27868A701FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DF188819F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5725B69D;
	Tue, 25 Mar 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0K9I9Up"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0E257455;
	Tue, 25 Mar 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908259; cv=none; b=hItNESMelIA6PXjOLNPFS7vxwcrcWtHDN3Gc0sSeP7eK6BfW15Ftca09W57jrJYM9tbnLOjxz99gbt3yuJAvv34VBtDiMLAz7g1JzcKdIyqN6tJI/7YZCHz1/IuxuOHcWc0wLEwhCZNzDbhDUIiX4z3zi87NawFTGMQYzhHJAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908259; c=relaxed/simple;
	bh=rrfaQ3tdVDSvSvJwIWSHVurE1j0Pvow2Lh2aFt+z9vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V9fVLKI3UBMwCPoXehZ+ApQqfd35C+kpVpCvqPEpKwSTDOdB+8+R7TEG3VzDKcDIPxJIVMyK6T3J8MjAk3PggjxFfJxIWlSjWOHczFW5I+AJyt96tahRGL6C0RP1o0eT/24nq+i411qzcjMGR8l9hbalgeQLgZWR+q5146zim5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0K9I9Up; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223f4c06e9fso93249835ad.1;
        Tue, 25 Mar 2025 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742908257; x=1743513057; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=718yhfW//Mn3iY8Lmfx30kySEx2J2S2e2Ce9hQGo+1Y=;
        b=e0K9I9Up+KHElm4sjnWh22CYzVcbH3rJIm1Lhb41F7etGmvt5gFQtpmlBauOmaCBw8
         b0OK8ko2ggEDS/nYBlUSJndNg8JvDQQNkVrq7Ka4PKSJbN8fjH8jw7b3xQeHnaVvIktb
         V1pP/ndk0/WbgFKA3f+zZn02tF6AaiXYEA4OBPEMv0/V0ZsXRGdNe+2+TcPS42X+iyUK
         oSzZ9Fj8whQ4YZA7yxmiEncdwP2hGTftLHfXQ9/cHbiAYDiJheWBZV/Gq+OSdnQxcFg9
         L5PVrhW5Gt1mPDeHzuwgPTCdp2m1vJtIO6GPI4V3Du1YEzg2zFJ6BNa0RwIzA6YRavTz
         M+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742908257; x=1743513057;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=718yhfW//Mn3iY8Lmfx30kySEx2J2S2e2Ce9hQGo+1Y=;
        b=ZMh9Kh3y/yEGZYxm6zxN2uodGNg/KcQ9Ta41BW8bcRwR0sc5KZ+UZ09glb4UkDYOjE
         HGsd8eb0R/M2Pv/J5u6VIa+WAILUmWdW+1bq3t6nOs8OBbUXDPUaU8A3Spmd5I5rMD3Z
         5c81d9Iax/8Box1gyWgNMDpR5wmwoOcL2dE8kbII8YJySns8S9C2/qJY4BPHICA8qHnD
         JGU7LaUhwkac9Z/ZaJTwZrXDQwZ7WtdElyn6RjRmKJGkfrL4smrZ1yE89sOZ2CrMqjW8
         zWKqPNKOEO6bk0QKrDr4+34+rCFNv3uhSdd8/083t8MCAHJ+UO1v/tXpyaHr23mXSRAj
         jsxg==
X-Forwarded-Encrypted: i=1; AJvYcCVKfW+hl8ceUUSEsE8cSBtOTTP/9TtIqOfnBgklYCttIGGP2jnYkHnJ9N0WPPAZspUBk1ivviwq3iuUchQ=@vger.kernel.org, AJvYcCVoYqsxxn37F4HUDAFeROMNyRix5Z9tgIEpCt38iJHL7mQsgs/2WkySNrSG/H35LrPPrlS0phE5cDFJPg7SbWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxkCMp4mhr2Ai4cjQR5LNztt1/DgiWtjsWjnptKZK/v+2skZAK
	MK5Nv5AX4mBohORT9zZnBK6Bdimn8eUKd4i17+8Mkz5P5zHnE6wx
X-Gm-Gg: ASbGnctAUMlIlW+4tU5FgXpCGGluboWzkllQxeQitUj4wpbeFfxlYy9R48vmyDdu2A4
	euMXSr0AWfxdqtxO3H4Dnavy9RVsk3vgxFbOWFqHMQmjtmWjVB36wiFQ46vo2/MXygA/RDgnViI
	bsdUsaOJMJ4JcwrG908aS0mAD1zLInYOiyydiqSYoAXyP4kpzf69dx7QePS7+0canGHDT5mAYMs
	GZodxhkyqi3rDLpSif9upbpwn2lpYe9j9S9MfaL3hPaGxI6neEsTgkSnpyrILGI3TCtD/gi5I+V
	YWJ2BUd0IE93TRC1jpYNN84AZt+7WaMOIKxDx8hweyQ0WxOoVmSM
X-Google-Smtp-Source: AGHT+IEm2+kzUc71unqBDC6EYHCoAQXcOJUjGGlcB9EitOapNGUnH/xveNXXKh1nulB0axYy3o3bkg==
X-Received: by 2002:a17:902:c949:b0:21f:2e:4e4e with SMTP id d9443c01a7336-2278067c0a6mr251195795ad.5.1742908257054;
        Tue, 25 Mar 2025 06:10:57 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f6937sm89271375ad.235.2025.03.25.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:10:56 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Tue, 25 Mar 2025 10:10:25 -0300
Subject: [PATCH v2] rust: add new macro for common bitmap operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAECr4mcC/4WNTQ6CMBCFr0Jm7Rg6VEhceQ/Doj8DTLTUtIRoC
 He3cgHzVt9L3vc2yJyEM1yrDRKvkiXOBehUgZvMPDKKLwxU06Vuao0DmwWN92hlCSY/MBiXIra
 atFWuUR0TlPEr8SDvQ3zvC0+Sl5g+x8+qfu1f5aqwxJEn66zuWnsbg5Hn2cUA/b7vX5hVoFa8A
 AAA
X-Change-ID: 20250304-feat-add-bitmask-macro-6424b1c317e2
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
 felipe_life@live.com, linux-kernel@vger.kernel.org, 
 Filipe Xavier <felipeaggger@gmail.com>, Lyude Paul <lyude@redhat.com>
X-Mailer: b4 0.14.2

We have seen a proliferation of mod_whatever::foo::Flags
being defined with essentially the same implementation
for BitAnd, BitOr, contains and etc.

This macro aims to bring a solution for this,
allowing to generate these methods for user-defined structs.
With some use cases in KMS and VideoCodecs.

Small use sample:
`
const READ: Permission = Permission(1 << 0);
const WRITE: Permission = Permission(1 << 1);

impl_flags!(Permissions, Permission, u32);

let read_write = Permissions::from(READ) | WRITE;
let read_only = read_write & READ;
`

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/We.20really.20need.20a.20common.20.60Flags.60.20type
Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Suggested-by: Lyude Paul <lyude@redhat.com>
---
Changes in v2:
- rename: change macro and file name to impl_flags.
- negation sign: change char for negation to `!`. 
- transpose docs: add support to transpose user provided docs.
- visibility: add support to use user defined visibility.
- operations: add new operations for flag, 
to support use between bit and bitmap, eg: flag & flags.
- code style: small fixes to remove warnings.
- Link to v1: https://lore.kernel.org/r/20250304-feat-add-bitmask-macro-v1-1-1c2d2bcb476b@gmail.com
---
 rust/kernel/impl_flags.rs | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/prelude.rs    |   1 +
 3 files changed, 216 insertions(+)

diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
new file mode 100644
index 0000000000000000000000000000000000000000..e7cf00e14bdcd2acea47b8c158a984ac0206568b
--- /dev/null
+++ b/rust/kernel/impl_flags.rs
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! impl_flags utilities for working with flags.
+
+/// Declares a impl_flags type with its corresponding flag type.
+///
+/// This macro generates:
+/// - Implementations of common bitmask operations ([`BitOr`], [`BitAnd`], etc.).
+/// - Utility methods such as `.contains()` to check flags.
+///
+/// # Examples
+///
+/// Defining and using impl_flags:
+///
+/// ```
+/// impl_flags!(
+///     /// Represents multiple permissions.
+///     pub Permissions,
+///     /// Represents a single permission.
+///     pub Permission,
+///     u32
+/// );
+///
+/// // Define some individual permissions.
+/// const READ: Permission = Permission(1 << 0);
+/// const WRITE: Permission = Permission(1 << 1);
+/// const EXECUTE: Permission = Permission(1 << 2);
+///
+/// // Combine multiple permissions using operation OR (`|`).
+/// let read_write = Permissions::from(READ) | WRITE;
+///
+/// assert!(read_write.contains(READ));
+/// assert!(read_write.contains(WRITE));
+/// assert!(!read_write.contains(EXECUTE));
+///
+/// // Removing a permission with operation AND (`&`).
+/// let read_only = read_write & READ;
+/// assert!(read_only.contains(READ));
+/// assert!(!read_only.contains(WRITE));
+///
+/// // Toggling permissions with XOR (`^`).
+/// let toggled = read_only ^ Permissions::from(READ);
+/// assert!(!toggled.contains(READ));
+///
+/// // Inverting permissions with negation (`!`).
+/// let negated = !read_only;
+/// assert!(negated.contains(WRITE));
+/// ```
+#[macro_export]
+macro_rules! impl_flags {
+    (
+        $(#[$outer_flags:meta])* $vis_flags:vis $flags:ident,
+        $(#[$outer_flag:meta])* $vis_flag:vis $flag:ident,
+        $ty:ty
+    ) => {
+        $(#[$outer_flags])*
+        #[repr(transparent)]
+        #[derive(Copy, Clone, Default, PartialEq, Eq)]
+        $vis_flags struct $flags($ty);
+
+        $(#[$outer_flag])*
+        #[derive(Copy, Clone, PartialEq, Eq)]
+        $vis_flag struct $flag($ty);
+
+        impl From<$flag> for $flags {
+            #[inline]
+            fn from(value: $flag) -> Self {
+                Self(value.0)
+            }
+        }
+
+        impl From<$flags> for $ty {
+            #[inline]
+            fn from(value: $flags) -> Self {
+                value.0
+            }
+        }
+
+        impl core::ops::BitOr for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
+            }
+        }
+
+        impl core::ops::BitOrAssign for $flags {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: Self) {
+                *self = *self | rhs;
+            }
+        }
+
+        impl core::ops::BitAnd for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn bitand(self, rhs: Self) -> Self::Output {
+                Self(self.0 & rhs.0)
+            }
+        }
+
+        impl core::ops::BitAndAssign for $flags {
+            #[inline]
+            fn bitand_assign(&mut self, rhs: Self) {
+                *self = *self & rhs;
+            }
+        }
+
+        impl core::ops::BitOr<$flag> for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn bitor(self, rhs: $flag) -> Self::Output {
+                self | Self::from(rhs)
+            }
+        }
+
+        impl core::ops::BitOrAssign<$flag> for $flags {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: $flag) {
+                *self = *self | rhs;
+            }
+        }
+
+        impl core::ops::BitAnd<$flag> for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn bitand(self, rhs: $flag) -> Self::Output {
+                self & Self::from(rhs)
+            }
+        }
+
+        impl core::ops::BitAndAssign<$flag> for $flags {
+            #[inline]
+            fn bitand_assign(&mut self, rhs: $flag) {
+                *self = *self & rhs;
+            }
+        }
+
+        impl core::ops::BitXor for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn bitxor(self, rhs: Self) -> Self::Output {
+                Self(self.0 ^ rhs.0)
+            }
+        }
+
+        impl core::ops::BitXorAssign for $flags {
+            #[inline]
+            fn bitxor_assign(&mut self, rhs: Self) {
+                *self = *self ^ rhs;
+            }
+        }
+
+        impl core::ops::Not for $flags {
+            type Output = Self;
+
+            #[inline]
+            fn not(self) -> Self::Output {
+                Self(!self.0)
+            }
+        }
+
+        impl core::ops::BitOr for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitor(self, rhs: Self) -> Self::Output {
+                $flags(self.0 | rhs.0)
+            }
+        }
+
+        impl core::ops::BitAnd for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitand(self, rhs: Self) -> Self::Output {
+                $flags(self.0 & rhs.0)
+            }
+        }
+
+        impl core::ops::BitXor for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitxor(self, rhs: Self) -> Self::Output {
+                $flags(self.0 ^ rhs.0)
+            }
+        }
+
+        impl core::ops::Not for $flag {
+            type Output = $flags;
+            #[inline]
+            fn not(self) -> Self::Output {
+                $flags(!self.0)
+            }
+        }
+
+        impl $flags {
+            /// Returns an empty instance of `type` where no flags are set.
+            #[inline]
+            pub const fn empty() -> Self {
+                Self(0)
+            }
+
+            /// Checks if a specific flag is set.
+            #[inline]
+            pub fn contains(self, flag: $flag) -> bool {
+                (self.0 & flag.0) == flag.0
+            }
+        }
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911a9fdbce5d26738b9cf7ef910b269..7653485a456ae5aa51becbf04153ea54a7067d9e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -49,6 +49,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+pub mod impl_flags;
 pub mod init;
 pub mod io;
 pub mod ioctl;
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index dde2e0649790ca24e6c347b29465ea0a1c3e503b..0f691dd2df71d821265fae01555ba50e6a76f372 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -25,6 +25,7 @@
 #[doc(no_inline)]
 pub use super::dbg;
 pub use super::fmt;
+pub use super::impl_flags;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 

---
base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
change-id: 20250304-feat-add-bitmask-macro-6424b1c317e2

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


