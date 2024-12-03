Return-Path: <linux-kernel+bounces-430327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1C9E2F32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991CF161A87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9220ADDC;
	Tue,  3 Dec 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDLelqTy"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B7207A33;
	Tue,  3 Dec 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265845; cv=none; b=ReH2//q3+WYfbuIQBdC3oiokqoKQjnec4ar3/Gn4J3AEmFOwjLfr7qZufbne95K1NMCdI/FAWMUat1EpM/rItKZ4ux52D5h5iED6Z7ENFpZx/qe9nnqZylDp0h1KISm2UFAcifTT96NIUBdxbPz6t3KM82mvP0eu8cb/IKLBdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265845; c=relaxed/simple;
	bh=vcA0/cRUJDq8fEnBd8BZ5ptOA4cTepV39kADJgFaWhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WglvOsxGJA5utVZjQRpoNVoxp/M6c+1rxPggPbd4nz0xDbWm64zwpjRlQKUfQ+o+VYWb90IxULfLA3HOEQjbKY4tkBruOdp9xcTfv9L0mXQ8gRuWQvjFVuR5wXbX6dSfd0XaPwSrmFJ+9l93nOKCoK1UKkrRHlRTF4PFAPm0EU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDLelqTy; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4addd900de1so1628690137.3;
        Tue, 03 Dec 2024 14:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265842; x=1733870642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8esf/7QZXouMr7p2ENilxF+QnuMFeyQdGO61yRTVrw=;
        b=BDLelqTy9Ap/0C6Ba0/nYWYPTi9dy/7o9EGVtXqSbjDPb50+USM0cwRKQzKLi/XmiN
         0779dV9SgIhXRkVpq8mOfwjHWAEM3w6wengpLoQLcIdsrdtI1bTrgG7XpgYO75NngIao
         gI2O8mXXKqedjYr6f/w2WJo+P+RId5TcrJl7O4WLYcsBMmbW5nx6N52A4u6pNPxK3UA3
         w6x2do7Y+38VPt46sb9X4yGvLy4JSA7/H1eUQdEomTwQ3yqFXN9MPAByoMmrV/GzygwK
         WPDbA5X5IuNH53GsjPesE01hEoKJazQG34sxHQquMV+LyxAsTG38xGl5QfujD8tXwmnw
         3xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265842; x=1733870642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8esf/7QZXouMr7p2ENilxF+QnuMFeyQdGO61yRTVrw=;
        b=sba/x0H8zl1F+RYWvTmMgqDn7anJlOUWHFiTBbbVNhU1ryo5nrrPI509+ChPpS8pBV
         QPPdRQXMj8LWAwIryad4xrzUXm/k0Kss1sxVQy+FmywA8Gch36yD0NAGT5toBYUu8Udi
         UXpMzwdqdhdV5UzE+e7gX78xYQ0gIdTjqkGW8jMKNrs3fleDlAD0AYZsvalRZhg9Ec5E
         3Rf5UBcdQJBqTZGxNMYdcS/ltWBb83bXeXvIylQEaEUZ7Nsj9zx8+dqDdDU3GEpuOzzd
         u3CwPwVPIBm7nuXloBZaPMG2ZEcEUz200RBXhlrl80YU6sBzDovMAkUFfdwvBeJbw7ex
         p6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj8Hsojpd80YNGDGA9U9ZSi47CVcMr49p0cKsU+r2OvupzbiKsh9Sy3srIp2sQomimCSmIrHApqr3n6pE=@vger.kernel.org, AJvYcCWDj29J9mqehRK70hEqMycBlhMSLVrt6I9RaNdfVAGI9su/NYF0Ahp3HGAceXfNlX41i9aCp1XGYRCap5JE4mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uXxsQuPAGdk5n65m8uXVBL0DaCECQvarYoCvO4KDf1yaf/4i
	MjdfzayM+/guwa8HJKwfBWsYqbh4h7KCEHq1QQrfxDjDFPQADl4+
X-Gm-Gg: ASbGncv/eNFiQHAEa6YnEvxh9c52vpIyxOYdyU4nWJO6wrJkmRMDvbYwgI3OK3hfbya
	xmSL/3gfuK4O7iTqR1dMVQyDd37aNE2FXwIEbNgyXEz2q3KC2P/6yGPXO7Mz6TpgFK7CkiiqSg6
	pM/6s1x99UfoCsERk29L5KqW72F+xWHU0gRbhaaqu6Leqz0MVO80Po8K/Sl9+IJcpdwf3U/d0Bs
	Er4RHntPsreAVYcuySJN50YjA6oFR15qh+qotkl81w1B1ga6fcrDB3skFcYndtPA0DnQ+jKUoqG
	9pIMZRHqBYZ4MWYUwq9lcbgSuEKIeWaibC/qQALTNb6qzDNW1PxTPA==
X-Google-Smtp-Source: AGHT+IHGfdBGFFuPs1uTYUtQudU2rGCO7znsYtqa3yDm1nuL79AKUFOz09/JaceDMPaqrgQrPxQKuQ==
X-Received: by 2002:a05:6102:2ac2:b0:4af:4101:fd53 with SMTP id ada2fe7eead31-4af9735e090mr6623441137.22.1733265842490;
        Tue, 03 Dec 2024 14:44:02 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:352d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849495d2sm555516185a.68.2024.12.03.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:44:02 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 03 Dec 2024 17:43:50 -0500
Subject: [PATCH v11 1/2] rust: types: add `ForeignOwnable::PointedTo`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-rust-xarray-bindings-v11-1-58a95d137ec2@gmail.com>
References: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
In-Reply-To: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Allow implementors to specify the foreign pointer type; this exposes
information about the pointed-to type such as its alignment.

This requires the trait to be `unsafe` since it is now possible for
implementors to break soundness by returning a misaligned pointer.

Encoding the pointer type in the trait (and avoiding pointer casts)
allows the compiler to check that implementors return the correct
pointer type. This is preferable to directly encoding the alignment in
the trait using a constant as the compiler would be unable to check it.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs |  6 +++---
 rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
 rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
 4 files changed, 66 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 4ffc4e1b22b2b7c2ea8e8ed5b7f7a8534625249f..4e7a0ce9cc9c24f2e828f41e9105acc4048333d5 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -349,68 +349,70 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for Box<T, A>
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
+    type PointedTo = T;
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
-        Box::into_raw(self).cast()
+    fn into_foreign(self) -> *mut Self::PointedTo {
+        Box::into_raw(self)
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr.cast()) }
+        unsafe { Box::from_raw(ptr) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
-        unsafe { &*ptr.cast() }
+        unsafe { &*ptr }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> &'a mut T {
-        let ptr = ptr.cast();
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> &'a mut T {
         // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
         // nothing else will access the value for the duration of 'a.
         unsafe { &mut *ptr }
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
+    type PointedTo = T;
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
+    fn into_foreign(self) -> *mut Self::PointedTo {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
         // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
+        let r = unsafe { &*ptr };
 
         // SAFETY: This pointer originates from a `Pin<Box<T>>`.
         unsafe { Pin::new_unchecked(r) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a mut T> {
-        let ptr = ptr.cast();
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a mut T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index e58807ad28dc644fa384e9c1fb41fd6e53abea7a..ac6b591a83ad558f12ce2746b54e7f76d8b99c6f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -193,7 +193,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     };
 
     // SAFETY: The open call of a file owns the private data.
-    unsafe { (*file).private_data = ptr.into_foreign() };
+    unsafe { (*file).private_data = ptr.into_foreign().cast() };
 
     0
 }
@@ -209,7 +209,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The release call of a file owns the private data.
     let private = unsafe { (*file).private_data };
     // SAFETY: The release call of a file owns the private data.
-    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
+    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private.cast()) };
 
     T::release(ptr);
 
@@ -227,7 +227,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The ioctl call of a file can access the private data.
     let private = unsafe { (*file).private_data };
     // SAFETY: Ioctl calls can borrow the private data of the file.
-    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private.cast()) };
 
     match T::ioctl(device, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index eb5cd8b360a3507a527978aaf96dbc3a80d4ae2c..8e29c332db86ae869d81f75de9c21fa73174de9a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -130,9 +130,10 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }
 
+#[doc(hidden)]
 #[pin_data]
 #[repr(C)]
-struct ArcInner<T: ?Sized> {
+pub struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -330,18 +331,20 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Arc<T> {
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
+    type PointedTo = ArcInner<T>;
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr().cast()
+    fn into_foreign(self) -> *mut Self::PointedTo {
+        ManuallyDrop::new(self).ptr.as_ptr()
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -349,17 +352,17 @@ unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
         // requirements for `borrow`.
         unsafe { Self::borrow(ptr) }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 0dfaf45a755c7ce702027918e5fd3e97c407fda4..0cf93c293b884004a6ed64c2c09723efa7986270 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -18,7 +18,19 @@
 ///
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
-pub trait ForeignOwnable: Sized {
+///
+/// # Safety
+///
+/// Implementers must ensure that [`into_foreign`] returns a pointer which meets the alignment
+/// requirements of [`PointedTo`].
+///
+/// [`into_foreign`]: Self::into_foreign
+/// [`PointedTo`]: Self::PointedTo
+pub unsafe trait ForeignOwnable: Sized {
+    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
+    /// the pointer.
+    type PointedTo;
+
     /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
 
@@ -27,16 +39,18 @@ pub trait ForeignOwnable: Sized {
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-    /// The foreign representation is a pointer to void. There are no guarantees for this pointer.
-    /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
-    /// any way except for [`from_foreign`], [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can
-    /// result in undefined behavior.
+    /// # Guarantees
+    ///
+    /// The return value is guaranteed to be well-aligned, but there are no other guarantees for
+    /// this pointer. For example, it might be null, dangling, or point to uninitialized memory.
+    /// Using it in any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
+    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     ///
     /// [`from_foreign`]: Self::from_foreign
     /// [`try_from_foreign`]: Self::try_from_foreign
     /// [`borrow`]: Self::borrow
     /// [`borrow_mut`]: Self::borrow_mut
-    fn into_foreign(self) -> *mut crate::ffi::c_void;
+    fn into_foreign(self) -> *mut Self::PointedTo;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -46,7 +60,7 @@ pub trait ForeignOwnable: Sized {
     /// must not be passed to `from_foreign` more than once.
     ///
     /// [`into_foreign`]: Self::into_foreign
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -58,7 +72,7 @@ pub trait ForeignOwnable: Sized {
     /// `ptr` must either be null or satisfy the safety requirements for [`from_foreign`].
     ///
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -81,7 +95,7 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
     ///
     /// [`into_foreign`]: Self::into_foreign
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
 
     /// Borrows a foreign-owned object mutably.
     ///
@@ -109,21 +123,23 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
     /// [`from_foreign`]: Self::from_foreign
     /// [`borrow`]: Self::borrow
     /// [`Arc`]: crate::sync::Arc
-    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a>;
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Self::BorrowedMut<'a>;
 }
 
-impl ForeignOwnable for () {
+// SAFETY: The `into_foreign` function returns a pointer that is dangling, but well-aligned.
+unsafe impl ForeignOwnable for () {
+    type PointedTo = ();
     type Borrowed<'a> = ();
     type BorrowedMut<'a> = ();
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
+    fn into_foreign(self) -> *mut Self::PointedTo {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *mut Self::PointedTo) -> Self {}
 
-    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
-    unsafe fn borrow_mut<'a>(_: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a> {}
+    unsafe fn borrow<'a>(_: *mut Self::PointedTo) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut Self::PointedTo) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


