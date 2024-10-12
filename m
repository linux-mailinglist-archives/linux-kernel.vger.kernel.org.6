Return-Path: <linux-kernel+bounces-362126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4799B163
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B1F1C21932
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DF13B586;
	Sat, 12 Oct 2024 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGCmGGR8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA184A5B;
	Sat, 12 Oct 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716492; cv=none; b=I77ArMsjDVC0gFPTBqo3hBqHAt7imDv7J0OnjUEDzk60ThSQVINMr/zgZK402GpZyIpdcpGHnnHbXKpOtxt8EyFAGG0a4Fc/4zjgvYg7veOUqtSDQ7aswHifKaEx7+6+rhuXiSJ6KvmgB3Tfl7NnzwTGjn87qhiIGod5YEOd0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716492; c=relaxed/simple;
	bh=cjo/SuvHqrEjGeaAmKU8a4/83En+ovDfojqOPquyNfQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o6Ynb3zW6sA7wsGEPkMlsjRPATgfOka2Whp94EX/n5hVFpCTac1+u+3r7U0pO1+X1B/lKujvfXqSUAWO5rfGqTaCcIwpck+spUBzW/YA3taJBvNk4EVkmxHEsXCLfh79X5k6okIc4NqWGJ7t1sFblbW4E7cbkSEk3bekxmQeM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGCmGGR8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71def8af0d9so307423b3a.1;
        Sat, 12 Oct 2024 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728716489; x=1729321289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJkygPwSYc8Q99TWvuHeC8/tLQITs33tZMlrL9dwFKw=;
        b=GGCmGGR8FM31Fn+GrwnN7A5sPlg9dspohf9ckQvZf938XcbXmsthlDViXj/3l/Th3j
         xci/WNtkgqkMX2Ho35P9nPi2ePnqp6Hw4eKF/HL0fktwLwDcLrP+14j1+3nRYQimiQ+T
         fG61V52L+0ZMUJ/klJl8EPmDG1IQXNcV4S6qtqMjzjNgENazQ6AsuovM3b8HM09ubKH4
         T+gspkKU+nagKtX0I/dml1S4rpbbpEBZ6R6YeMsWbIkywn2KyVylWqgr4LC1W1C3Gdd4
         +UsUsF9YlYk+yb4pYs8LGmTbLfAGSH0rG8nKM6X0IVBs/XI4esLjbAgRFXZUWyBqEsff
         F54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728716489; x=1729321289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJkygPwSYc8Q99TWvuHeC8/tLQITs33tZMlrL9dwFKw=;
        b=E01NHgPSFHXEwiLKebAdV7Kd+16UMuphy93LmZpyLCTkI5LQJyJRXY60qqyPNclCBS
         87xFN2mED2sv+OEbjkcBhNsj5N/7YAbBoCyVbzxgZuDORugLKzmsflR92zkCgHfBerSB
         Qe0M2SYW1jt+ksQNqVw94vkbAalELcs1sbxYO6G2ugEZf8lNP+D3+8WUZ3dr8zUr6lTZ
         D4fDyzF73y67dwLbLp7W/YqvLNfDaugLDrd3rfcM9K/Xj8rm/eEeNk/1iCwH15xIeLvK
         TY6oEBuAE7GFStpDHBxKLWkFbLiRKmipAc6S7ucUgfAwla/+SpPz+8lSFY7MgWY2b1G0
         oNlw==
X-Forwarded-Encrypted: i=1; AJvYcCVcrGf+dTCkDziQFVVw/bz5LUF6/YKVTaHCQFJuibd/DFvY9Oq2IeeXNqH46aidHDjwV4jWO/Zu429OaMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPTyAJHV0MoGtZjxm4tJQ6IdLy5rTrpgU9bFvEA0Dzy180I6t
	hG/hi7ZVfbCFESJmLlj1oeqm1/g3dk4oGp9bszVmBreTXverjZEdShvagMkQ
X-Google-Smtp-Source: AGHT+IFxo4jVlEUozmskPxgiinf0ASTmsMPgSskbhST8zZPMZoN0+FWIrPhwjiBxz2upTQ4eFCoyxQ==
X-Received: by 2002:a05:6a00:1794:b0:71e:4bda:71ec with SMTP id d2e1a72fcca58-71e4bda72e7mr1431414b3a.4.1728716489334;
        Sat, 12 Oct 2024 00:01:29 -0700 (PDT)
Received: from archlinux.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b0a2sm3435130a12.92.2024.10.12.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:01:28 -0700 (PDT)
From: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] rust: transmute: Add implementation for FromBytes trait
Date: Sat, 12 Oct 2024 04:01:21 -0300
Message-ID: <20241012070121.110481-1-christiansantoslima21@gmail.com>
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
acessing the original value. So adding ToBytes this can be avoided.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
---
changes in v2:
     - Rollback the implementation for the macro in the repository and add implementation of functions in trait
---
 rust/kernel/lib.rs       |   2 +
 rust/kernel/transmute.rs | 120 ++++++++++++++++++++++++++++-----------
 2 files changed, 88 insertions(+), 34 deletions(-)

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
index 1c7d43771a37..bce42cc7265e 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,7 @@
 
 //! Traits for transmuting types.
 
+use core::simd::ToBytes;
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
@@ -9,15 +10,58 @@
 ///
 /// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
+/// # Example
+///
+/// This example is how to use the FromBytes trait
+/// ```
+/// // Initialize a slice of bytes
+/// let foo = &[1, 2, 3, 4];
+///
+/// //Use the function implemented by trait in integer type
+/// let result = u8::from_bytes(foo);
+///
+/// assert_eq!(*result, 0x4030201);
+/// ```
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytes {
+    ///Get an imutable slice of bytes and converts to a reference to Self
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;
+    /// Get a mutable slice of bytes and converts to a reference to Self
+    ///
+    /// # Safety
+    ///
+    ///  Bound ToBytes in order to avoid use with disallowed bit patterns
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes;
+}
 
+//Get a reference of slice of bytes and converts into a reference of integer or a slice with a defined size
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
 
@@ -28,44 +72,52 @@ macro_rules! impl_frombytes {
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
     {<T: FromBytes, const N: usize>} [T; N],
 }
 
-/// Types that can be viewed as an immutable slice of initialized bytes.
+/// Get a reference of slice of bytes and converts into a reference of an array of integers
 ///
-/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
-/// means that it should not have any padding, as padding bytes are uninitialized. Reading
-/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
-/// information on the stack to userspace.
+/// Types for which any bit pattern is valid.
 ///
-/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
-/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
-/// this is a correctness requirement, but not a safety requirement.
+/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
+/// reading arbitrary bytes into something that contains a `bool` is not okay.
 ///
-/// # Safety
+/// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
-/// Values of this type may not contain any uninitialized bytes. This type must not have interior
-/// mutability.
-pub unsafe trait AsBytes {}
-
-macro_rules! impl_asbytes {
-    ($($({$($generics:tt)*})? $t:ty, )*) => {
-        // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? AsBytes for $t {})*
-    };
-}
-
-impl_asbytes! {
-    // SAFETY: Instances of the following types have no uninitialized portions.
-    u8, u16, u32, u64, usize,
-    i8, i16, i32, i64, isize,
-    bool,
-    char,
-    str,
+/// # Example
+///
+/// This example is how to use the FromBytes trait
+/// ```
+/// // Initialize a slice of bytes
+/// let foo = &[1, 2, 3, 4];
+///
+/// //Use the function implemented by trait in integer type
+/// let result = <[u32]>::from_bytes(slice_of_bytes);
+///
+/// assert_eq!(*result, 0x4030201);
+/// ```
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        //Safety: Guarantee that all values are initiliazed
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts(slice_ptr, slice_len)
+        }
+    }
 
-    // SAFETY: If individual values in an array have no uninitialized portions, then the array
-    // itself does not have any uninitialized portions either.
-    {<T: AsBytes>} [T],
-    {<T: AsBytes, const N: usize>} [T; N],
+    //Safety: Guarantee that all values are initiliazed
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        //Safety: Guarantee that all values are initiliazed
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts_mut(slice_ptr, slice_len)
+        }
+    }
 }
-- 
2.47.0


