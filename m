Return-Path: <linux-kernel+bounces-402679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3909C2A74
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677431F21118
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7BE13C9A9;
	Sat,  9 Nov 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSIQF07w"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F528E8;
	Sat,  9 Nov 2024 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731131692; cv=none; b=cSLNco1DvO9NG6n8AEpYBVZv/6EGIhGBTDAtvYI4EWFvZtJN7w5Jp8+FZRaoyKEFwRPfMkDZhX+TOuij2zFr8ZhZmTyrYyrsfRGxfv0q/CEDVUYiIZnrmHuTsRpleGExtHE+Kw3h7s7jOwgAMxlzxp1TQ7X+i84kTdFiaf1HgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731131692; c=relaxed/simple;
	bh=tKGFk74qCGGzxkCJWKBU9hi9bpofaa60JMPzgXnRJwA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n1D3c34QrbVG4bPeUVOBv4RF2eUOTSWMw2Zk56DEdeEh6cepOBmQUKMhq151ShoxyV2zk0afJ3puHsjPcFKy/FtAUdekV7ZlCO1BezIMGyv0wImVDuzgESQKXIuv/JGIqqv/gy1OpCHpc6c7j643h+968nVl9uyvgMCsjmvS1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSIQF07w; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e9a5ee0384so323571a91.3;
        Fri, 08 Nov 2024 21:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731131690; x=1731736490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM/ZHyMpHDBqNDre7+VZNwQb40sxC85lTLNhhwasbsU=;
        b=WSIQF07w3EXCKYvg2DQBUhc0tz08Vk4E9a2CsZxvTjPf+gRaYQTqnxClZj+GN1NBq1
         uAxWIAx6pr1+7XalIzW5nqzYLnEk4L5VL8onjH7DRRwYTACY/xZZ8dCr5CkgP+lWIVCp
         hNC2dchHbkuhphVpHtpXpZWCuQgIJgrQChXhID/gDmozI6BZi+kN3XCr8BsLGx115XUD
         SukMiKCuSGlBUVamLulWbHXHP2DUtGJZJADuEqJF6rMTDyGbY9qFw38aZGMaKYKUrAY0
         Nz3N6wmX9pFCpPQ7Imy0IcxsFPyrFihOSxhDu7dcy15Hb0XBWuAKYMTaQ7Ib0tKUbhFN
         I9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731131690; x=1731736490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qM/ZHyMpHDBqNDre7+VZNwQb40sxC85lTLNhhwasbsU=;
        b=kGqomEkh6xhKvdYOkeSFF9ol0LQISh2eW+vDIQXCNMR5FCh5LToZ0GEZqjJfjdL8HU
         9JPIsvKtejVUUKqZmkf2IEt/rLr9WVF1jqs28OBLl/A90CdD6N533dEbPj50ipt2x5pG
         rl3sPBnlwo0jQ1yD4xpKpNYBc2h/FT/R/G+N3CSeSjkJFGYxO3VUI/4oI8IaqhJxSu1z
         dUQLYCPmn9kA+sc63nHam2Zj/fZVqL0/vaChkXxRfwKI9GwYH11EhnqfvvudB+0URROt
         5nvUJzk8Qd1hWshPXcv2Q+bczgNz7MnisMoluNsnB60OyOmEEAkPK3Kw1zdR2Y3L2g9C
         l5qA==
X-Forwarded-Encrypted: i=1; AJvYcCU7hgUR51LipJJMAKvDRCFLqxJbpJxqRpq7NapsBk0RbXYCXJ4CWUo1hEoDbT5jfJ2ib9xQOLKVCzn8XfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErHUOeFGg+03Y+YMCTsnDtEpAq9+A7rcJYVHp2X34OSFzjnGg
	d33yxr+outQXbjPnsXwyusrbL7rfZCpphSaw/dlHGKULXayLQ2Ucc84RjP5C/zc=
X-Google-Smtp-Source: AGHT+IHxlpFPFNQLLcu/f3JbOZ4ZpV18P2xoKq76AW3m+ScDj7V26WapsEpk5l37B7+xYn9MV0Mi3A==
X-Received: by 2002:a17:902:eccb:b0:20c:d04f:94ad with SMTP id d9443c01a7336-211834fccd8mr31788265ad.4.1731131689914;
        Fri, 08 Nov 2024 21:54:49 -0800 (PST)
Received: from archlinux.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9bd5ffe03sm560548a91.0.2024.11.08.21.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:54:49 -0800 (PST)
From: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v3] rust: transmute: Add implementation for FromBytes trait
Date: Sat,  9 Nov 2024 02:54:42 -0300
Message-ID: <20241109055442.85190-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation and documentation for FromBytes trait.

Add new feature block in order to allow using ToBytes
and bound to from_bytes_mut function. I'm adding this feature
because is possible create a value with disallowed bit pattern
and as_byte_mut could create such value by mutating the array and
accessing the original value. So adding ToBytes this can be avoided.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
---
Changes in v2:
- Rollback the implementation for the macro in the repository and add implementation of functions in trait

Changes in v3:
- Fix grammar errors
- Remove repeated tests
- Fix alignment errors errors
- Fix tests not building
- Link to v2: https://lore.kernel.org/rust-for-linux/20241012193657.290cc79c@eugeo/T/#t
---
 rust/kernel/lib.rs       |  2 +
 rust/kernel/transmute.rs | 87 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index dc37aef6a008..5215f5744e12 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,8 @@
 #![feature(lint_reasons)]
 #![feature(new_uninit)]
 #![feature(unsize)]
+#![feature(portable_simd)]
+#![feature(trivial_bounds)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..a4b462e07639 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,7 @@
 
 //! Traits for transmuting types.
 
+use core::simd::ToBytes;
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
@@ -9,15 +10,60 @@
 ///
 /// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
+/// # Example
+///
+/// This example is how to use the FromBytes trait
+/// ```
+/// use kernel::transmute::FromBytes;
+/// // Initialize a slice of bytes
+/// let foo = &[1, 2, 3, 4];
+///
+/// //Use the function implemented by trait in integer type
+/// unsafe {
+///     let result = u32::from_bytes(foo);
+///     assert_eq!(*result, 0x4030201);
+/// }
+/// ```
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytes {
+    /// Get an imutable slice of bytes and converts to a reference to Self
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;
+    /// Get a mutable slice of bytes and converts to a reference to Self
+    ///
+    /// # Safety
+    ///
+    /// Bound ToBytes in order to avoid use with disallowed bit patterns
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes;
+}
 
+// Get a reference of slice of bytes and converts into a reference of integer or a slice with a defined size
 macro_rules! impl_frombytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
+        $(unsafe impl$($($generics)*)? FromBytes for $t {
+            unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self
+            {
+                unsafe {
+                    let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+                    &*slice_ptr
+                }
+            }
+
+            unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+            where
+                Self: ToBytes,
+            {
+                unsafe {
+                    let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+                    &mut *slice_ptr
+                }
+
+            }
+        })*
     };
 }
 
@@ -28,10 +74,43 @@ macro_rules! impl_frombytes {
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
     {<T: FromBytes, const N: usize>} [T; N],
 }
 
+/// Get a reference of slice of bytes and converts into a reference of an array of integers
+///
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
+/// reading arbitrary bytes into something that contains a `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no effect.
+///
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        // Safety: Guarantee that all values are initialized
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts(slice_ptr, slice_len)
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        // Safety: Guarantee that all values are initialized
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts_mut(slice_ptr, slice_len)
+        }
+    }
+}
+
 /// Types that can be viewed as an immutable slice of initialized bytes.
 ///
 /// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
@@ -48,7 +127,6 @@ macro_rules! impl_frombytes {
 /// Values of this type may not contain any uninitialized bytes. This type must not have interior
 /// mutability.
 pub unsafe trait AsBytes {}
-
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
@@ -63,7 +141,6 @@ macro_rules! impl_asbytes {
     bool,
     char,
     str,
-
     // SAFETY: If individual values in an array have no uninitialized portions, then the array
     // itself does not have any uninitialized portions either.
     {<T: AsBytes>} [T],
-- 
2.47.0


