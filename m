Return-Path: <linux-kernel+bounces-410968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA89CF0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E67A1F2B11A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF001E2304;
	Fri, 15 Nov 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikWoDf34"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949A1E0DEC;
	Fri, 15 Nov 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686460; cv=none; b=IszFrVSEksbKynzCGBdDCzR9e7GaYExkN5T3q9e/u081FRby6pgnIZgIOPrtlbx5OjkNKfg0JqEJLjTX6c44G0NVVguHNJjt9XLE5qA8z6Ch483qzm2Kk0QIB5m26tX1+GmYAV2FAjCcy+ujb6MjZ1jlxexbchYS2eUM5OZZeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686460; c=relaxed/simple;
	bh=98Pj0Z9DLydkYx2nVYCuGoX4eIzcDL77SCfZfWGm6rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zhk6YO9OGJ4vbNkrGOOtXk/oe/CMo7itep/LKEt9Tl8Ivy3GRjvCIWYXQux+GrhoAj9i4gOLBWEeoasTNfsnkMSDTvdp7GHxjDb2qSy4RaSmG1om3K2WPLAIDaoZbpz/QTFew3SiPdNYMo1mkC9xw4lmAXoKa+dBXmhk1G/ujgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikWoDf34; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d3f64df14aso10366706d6.1;
        Fri, 15 Nov 2024 08:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686457; x=1732291257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7nAvvaPKLedoC6lSOgYyDXcfx4J0P0Lmm09BFLkS4A=;
        b=ikWoDf34bAJWeqWSJrozXupdElgVGQuwMsYezl5Za1ld03RnG8MUvQJ2o0U2E8n47j
         ZRbuPjQCORAtBddAdhNV6NOm+JIoRnXksgWuxzsqhcP0GfCVi0vOJnfGfHOU0UQYSHJ0
         /vUHQUe3KY+acnOkAvGxfCiTaVfcKg3UXzjCJt69YzLPEDP8NMfQ80Gkl2un4ACW8xRX
         jneCNoPmkF4ixfI56t4bQZPGJMoq+JEczhRO1jBGD+eav11qzgryfaM/yA7T9FTYAy+R
         9dMgFdCIUkuyhIoW/0cRL8lNM4wCSEp/QYTEXV3KgOwTWWCe+P6kO4njKgjUWKo/2R0/
         9LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686457; x=1732291257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7nAvvaPKLedoC6lSOgYyDXcfx4J0P0Lmm09BFLkS4A=;
        b=IwzLVhLeT+dzIgPZDAUybik4t0I9ckecT3fOQJyAd86Vz7v8WPWTuMalY17NaW3IO9
         Pw8cSJW3WmlnNgtA8ZKD9+rA4vjCP2n2yf1RB9IL4yEQOpYXrGoav7iy3pXRX77YpoMp
         pRkIP1cg5sDKCFV2s3vOdqcMJJP7sw1n1A/fFKRGKQLeYkSVDIq8qsOkCJ6PO8lssfFp
         ho3/5RLgqqu0YIrgrWm4i+7jyoyh47tEBBBqec5VkUznSbC5PKOuECuEGNrE4SBZxFOJ
         rJTDGOGSBs4o/fHUbMVQxI14Paua/kW29c6/4J5IeSSYdzcCvFfxhVIXi4ggTAd9aYPp
         /Fiw==
X-Forwarded-Encrypted: i=1; AJvYcCUefyLS3rstGez5m+koH1tTSIVtOI99lAr8f+WBADmYOFwEfHYEqLFAsIFZYyGzOTVN2sAp5wEVLZUYv9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3rCq8wrMUKRztZzocx4OEojP1rKDbZvi8DwiTxrwUakCW7Zk
	5MFwkzOQlPpoG/gX+p1gAAetDyselrsoM2Ce2R7WJxeyZO8lhGjn
X-Google-Smtp-Source: AGHT+IGWn9ZH9qRY/Dzpua105ZqOkSOHO+Gq3Cst9kcedFv7AUHtwlHBWhrB4e1nYjZ5nJQ8jzbLBg==
X-Received: by 2002:a05:6214:451d:b0:6d3:fa75:e9ed with SMTP id 6a1803df08f44-6d3fb8579afmr40413746d6.41.1731686457358;
        Fri, 15 Nov 2024 08:00:57 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:56 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:49 -0500
Subject: [PATCH v5 6/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-6-86204b249667@gmail.com>
References: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
In-Reply-To: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: b4 0.15-dev

From: Alice Ryhl <aliceryhl@google.com>

Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
that was intended to provide mutable access to the inner value. However,
the method accidentally made it possible to change the address of the
object being modified, which usually isn't what we want. (And when we
want that, it can be done by calling `from_foreign` and `into_foreign`,
like how the old `borrow_mut` was implemented.)

In this patch, we introduce an alternate definition of `borrow_mut` that
solves the previous problem. Conceptually, given a pointer type `P` that
implements `ForeignOwnable`, the `borrow_mut` method gives you the same
kind of access as an `&mut P` would, except that it does not let you
change the pointer `P` itself.

This is analogous to how the existing `borrow` method provides the same
kind of access to the inner value as an `&P`.

Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
immutable access to the inner `T`. This is because mutable references
assume exclusive access, but there might be other handles to the same
reference counted value, so the access isn't exclusive. The `Arc` type
implements this by making `borrow_mut` return the same type as `borrow`.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 21 ++++++++++++++
 rust/kernel/sync/arc.rs   |  7 +++++
 rust/kernel/types.rs      | 71 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index e00c14053efbfb08d053e0f0b11247fa25d9d516..4ffc4e1b22b2b7c2ea8e8ed5b7f7a8534625249f 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -354,6 +354,7 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     A: Allocator,
 {
     type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a mut T;
 
     fn into_foreign(self) -> *mut crate::ffi::c_void {
         Box::into_raw(self).cast()
@@ -370,6 +371,13 @@ unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
         // immutable for the duration of 'a.
         unsafe { &*ptr.cast() }
     }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> &'a mut T {
+        let ptr = ptr.cast();
+        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
+        // nothing else will access the value for the duration of 'a.
+        unsafe { &mut *ptr }
+    }
 }
 
 impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
@@ -377,6 +385,7 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
     A: Allocator,
 {
     type Borrowed<'a> = Pin<&'a T>;
+    type BorrowedMut<'a> = Pin<&'a mut T>;
 
     fn into_foreign(self) -> *mut crate::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
@@ -399,6 +408,18 @@ unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a T> {
         // SAFETY: This pointer originates from a `Pin<Box<T>>`.
         unsafe { Pin::new_unchecked(r) }
     }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a mut T> {
+        let ptr = ptr.cast();
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        let r = unsafe { &mut *ptr };
+
+        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
+        unsafe { Pin::new_unchecked(r) }
+    }
 }
 
 impl<T, A> Deref for Box<T, A>
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 1d26c309d21db53f1fc769562c2afb4e881c3b5b..eb5cd8b360a3507a527978aaf96dbc3a80d4ae2c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -332,6 +332,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
+    type BorrowedMut<'a> = Self::Borrowed<'a>;
 
     fn into_foreign(self) -> *mut crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
@@ -357,6 +358,12 @@ unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
+        // requirements for `borrow`.
+        unsafe { Self::borrow(ptr) }
+    }
 }
 
 impl<T: ?Sized> Deref for Arc<T> {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index c2ac1626f8ddff7397ec00f502abcfe78829b532..c150cf509d52fd5006834cf1c6745e4ea3504a55 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -19,26 +19,33 @@
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
 pub trait ForeignOwnable: Sized {
-    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
-    /// [`ForeignOwnable::from_foreign`].
+    /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
 
+    /// Type used to mutably borrow a value that is currently foreign-owned.
+    type BorrowedMut<'a>;
+
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
     /// The foreign representation is a pointer to void. There are no guarantees for this pointer.
     /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
-    /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
-    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
+    /// any way except for [`from_foreign`], [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can
+    /// result in undefined behavior.
+    ///
+    /// [`from_foreign`]: Self::from_foreign
+    /// [`try_from_foreign`]: Self::try_from_foreign
+    /// [`borrow`]: Self::borrow
+    /// [`borrow_mut`]: Self::borrow_mut
     fn into_foreign(self) -> *mut crate::ffi::c_void;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
     ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
-    /// this object must have been dropped.
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and it
+    /// must not be passed to `from_foreign` more than once.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
     unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
@@ -48,8 +55,9 @@ pub trait ForeignOwnable: Sized {
     ///
     /// # Safety
     ///
-    /// `ptr` must either be null or satisfy the safety requirements for
-    /// [`ForeignOwnable::from_foreign`].
+    /// `ptr` must either be null or satisfy the safety requirements for [`from_foreign`].
+    ///
+    /// [`from_foreign`]: Self::from_foreign
     unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
@@ -60,17 +68,53 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
         }
     }
 
-    /// Borrows a foreign-owned object.
+    /// Borrows a foreign-owned object immutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust immutably. It provides
+    /// you with exactly the same abilities as an `&Self` when the value is Rust-owned.
     ///
     /// # Safety
     ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
     unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
+
+    /// Borrows a foreign-owned object mutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust mutably. It provides
+    /// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
+    /// that the address of the object must not be changed.
+    ///
+    /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you immutable access to the
+    /// inner value, so this method also only provides immutable access in that case.
+    ///
+    /// In the case of `Box<T>`, this method gives you the ability to modify the inner `T`, but it
+    /// does not let you change the box itself. That is, you cannot change which allocation the box
+    /// points at.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// The lifetime 'a must not overlap with the lifetime of any other call to [`borrow`] or
+    /// `borrow_mut` on the same object.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
+    /// [`borrow`]: Self::borrow
+    /// [`Arc`]: crate::sync::Arc
+    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a>;
 }
 
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
+    type BorrowedMut<'a> = ();
 
     fn into_foreign(self) -> *mut crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
@@ -79,6 +123,7 @@ fn into_foreign(self) -> *mut crate::ffi::c_void {
     unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
 
     unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


