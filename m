Return-Path: <linux-kernel+bounces-389523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284949B6E07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47C6282F01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D11F1309;
	Wed, 30 Oct 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIewImVw"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD921764F;
	Wed, 30 Oct 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321214; cv=none; b=QtWnu8dmE9L0QK05RTnVGF3NP7/Z/4xjRkjCq8LtRiffGK6xZZBGv/p6nFp/YJWnFdbaMuZPVxJIBj+JiXgr6EJgXAci3pscjQaKIykSFhf3VZWGe+zUOMtU29ps+7W/7FcTcFiHESEkh/UpK7E/ZzWQtMguMKXBT6SvAY4fpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321214; c=relaxed/simple;
	bh=W4MnTSRZDNO9E61wQewB+RTJNY8Ad1FjU0v7XnbB2GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYb44oVrjQFKZq7enm0U3WWJ79bfbbVGORafj4OTQs4ENb5oNNSlFWRqu7UZGL5d3iZQL43q86T2f7DeDlYfYpx7Es3TOZylcuSCoNayJpcHYTIg9MNwhh71euRGPSHOJsYoIhmRNykTvOf6tcQFjHKhE28CJMPW3vfi9g8/SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIewImVw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4609beb631aso1971071cf.2;
        Wed, 30 Oct 2024 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321211; x=1730926011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7EQG/Q6VbC722wpvCuI4LW8lAPiBh2mzpjGaHeNXNA=;
        b=YIewImVwwMh48QcsWhAj2MxG3RBA7laoDyVeRZf2QtglobplOUM+WJn0AVq43lnqoA
         suRBseXnloCFxIC4Pv6S3OOD0RSYu7cSAf6SlN5vlCYjEUIBUDUxq4bYByj2hYN6nWqm
         Cb3XqebVZEoCq3CuJsJcVeSqVhIPzz/evD3kK8ceJJvK2XwsKNW4R2ICVTk0VkwCu46k
         jjQsYI1emV+JT8jNhDUhDf7H7f23wHShtOCVl4NlhEjnLHu56SDpVabX1zVjdS+pCMVJ
         xND6gRQts/be0lhr5T4TuwtH58gv8r6KsjKTofasqSc7Ihvao6KGF9t10bYjLBGkcX4r
         w4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321211; x=1730926011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7EQG/Q6VbC722wpvCuI4LW8lAPiBh2mzpjGaHeNXNA=;
        b=EVbvCfKIrVX68gUIlTRQtuUqqbdvhbuD8Z+OeP9eqV01w0p4byVS9X5+YNWwIce3H6
         LxfJbI9ed6ZAdp5OTlqYkMj1ZYfXjKFELJYrcjuLQO9UqhQPPKzrpoxpBN3ec5xLVmuH
         9/ecFVjNRwaGfT322sp/FiccrlAH4ZHa6zX2LTg0xE+8JKh/NXdYgXfxW8A3imMR9EJ1
         QH0a833BwZ/JsrCZBTPKznEV7eVyoSCqJWHd4+lnpO5JOSVWnNA6RoUV2GoJi3LFj6jv
         mGoP1LZ7reA5GhjUDAi2Hm4b6gewZNsfiHqh/nRhcN9xRxp/TcN/I0XepL+5K6eceAXo
         ZoOg==
X-Forwarded-Encrypted: i=1; AJvYcCXF/PQyuJrTh++qvZdU7/Ub8a1UadBQpg3fkK91y7WJqwbYBCy56Y+zsAm0cx+1Q1yMFyQbZjaVBCBgrwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLd+Ic6iKHyD/xrS1Q9GbhINybaZDrlO4aFLzhLGudmUAMz3u
	xQUlMAOor+RHdg3LyZpF69amn7ZHFJIM1rCnteSRJjGfEPsc+sle
X-Google-Smtp-Source: AGHT+IHmc4EhWRojtL4gb+xI0AsEzjyGtJ4Yf30hx5KKYzliFhLnMGO2r8R7H0l9WI0/7zYE5exRbg==
X-Received: by 2002:ac8:584f:0:b0:460:a730:3176 with SMTP id d75a77b69052e-4613bfb6ce8mr260600811cf.11.1730321210672;
        Wed, 30 Oct 2024 13:46:50 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 16:46:42 -0400
Subject: [PATCH 5/5] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
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

---

Source: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.com/
---
 rust/kernel/alloc/kbox.rs | 21 ++++++++++++++
 rust/kernel/sync/arc.rs   |  7 +++++
 rust/kernel/types.rs      | 71 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index de7fadeb7fdf5cf6742c2e9749e959ac5f82359e..6ae81d4f74e9f7cf228385490f3a065082c1f4f6 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -354,6 +354,7 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     A: Allocator,
 {
     type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a mut T;
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         Box::into_raw(self).cast()
@@ -372,6 +373,13 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> &'a T {
         // immutable for the duration of 'a.
         unsafe { &*ptr }
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
@@ -379,6 +387,7 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
     A: Allocator,
 {
     type Borrowed<'a> = Pin<&'a T>;
+    type BorrowedMut<'a> = Pin<&'a mut T>;
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
@@ -403,6 +412,18 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a T> {
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
index 4552913c75f747d646bf408c1e8a1a883afb4b6a..8b21197ceba3508bcac6f1b54d73244d9bdfd5a7 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -334,6 +334,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
+    type BorrowedMut<'a> = Self::Borrowed<'a>;
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
@@ -363,6 +364,12 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
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
index b8a7b2ee96a17081ad31e1bb73cb0513bcd05ef4..d742544da793a08eaf342ba88722dfb1319b93d6 100644
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
     fn into_foreign(self) -> *mut core::ffi::c_void;
 
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
     unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self;
 
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
     unsafe fn try_from_foreign(ptr: *mut core::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
@@ -60,17 +68,53 @@ unsafe fn try_from_foreign(ptr: *mut core::ffi::c_void) -> Option<Self> {
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
     unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
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
+    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> Self::BorrowedMut<'a>;
 }
 
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
+    type BorrowedMut<'a> = ();
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
@@ -79,6 +123,7 @@ fn into_foreign(self) -> *mut core::ffi::c_void {
     unsafe fn from_foreign(_: *mut core::ffi::c_void) -> Self {}
 
     unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut core::ffi::c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


