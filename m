Return-Path: <linux-kernel+bounces-395569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B959F9BBFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE711F211D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC51FEFCB;
	Mon,  4 Nov 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2SJRzNi"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F81FEFAC;
	Mon,  4 Nov 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755251; cv=none; b=dGqQBu8mhcL4HF2Jk0pl8dyqebCkoUeUrc4N7Lw9V9KeplUVKYNXQfaLagOl12/iS3TRQZGryL1zzDg+tyZGHKWA5Y0vvIb5RDPOPryksdInHvs7czpPaTh5SSmzSmCi5zlP+rB6WD5ZI38/8R4XDMuMruX6Rwp+kikICmpLCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755251; c=relaxed/simple;
	bh=f3MKNdusBU+qI++nsu6jkpiNIt8+1NpPzHrMQRx7A2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quflKZc/D4B8foHGKBbKhKWMIdMridhf43X6va6VOBlWZjh1gm0qy31zxfWQzPR6HPDM//rOIdCFbtSBSOlg9GR1OvgT/jG+kRjSKTJ3UrmLKC+++ELx7Hgzi/iJvYnwveBVxnIQtnvvNwIp7IRQy4Tb5u3crL01R9wX/wYOb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2SJRzNi; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso4088801276.3;
        Mon, 04 Nov 2024 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755248; x=1731360048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDLscm5IVmeNMDAedQjw2Ix2zCFH6FABN7zMEqlV7Uc=;
        b=H2SJRzNiyqYMrKYK+UF3X+lcdnSdOA7Rq8x4mXzb5CQgSQWQLUcDdXKOazFeP5zNNU
         Dwa5YU2WeCi7hW7nVeeJ4ihmxyOqfT/YQjV3uV3ywDzsyXtj9Z3MECq/BBY5JJM8yuR3
         J5GeF//aXrvINdCoMzFn4Z1uPzHpUamRhDqWjvG/sfC4uvUWZwDO33RCOhC1gO5s2jME
         0ph8byyHT10O9H8iHTwT1HP33ahcQR91iTb/UQQsdxWRemslQzXvTp2LwCKDNu8nB9tW
         xSVfEgPmZaNhhwqodXMqU/r6ikNWJau/zkmh99J+Dt1kpdAUONBoPTauYIcv/8U/zEhl
         Wy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755248; x=1731360048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDLscm5IVmeNMDAedQjw2Ix2zCFH6FABN7zMEqlV7Uc=;
        b=K80BOrTPVdRUPJ2FSAAb2WKj46VoEw2Va71UKb2FKyETVOSRejxX181KFLzL3LObt/
         uRtl4LHsAeR28Q9RKLx4/3U5Y5C03j5IkUtgOl5s+LWkyaCASVJrKaT1b5m+TbkniUU4
         de2/8pCDPFwJS8XoaCCk+yVEjbuYUiHUEvoKfj942WLfdSIz9gStQYadetY0hGQqQLES
         SynB1Hbt/8PQ71aP+f7YtfuYztZzZ8L9TjnT/I48BsEhheFZPLyyT6YkUDZkTnI4Z6k9
         QIkoomqr8tO4/1Ue7LeYTuKSQ5+RRAFx1UhSAj2Wdk59F/HEYYrGSmggmcmXEctLq4zy
         jBBw==
X-Forwarded-Encrypted: i=1; AJvYcCVpdSDepf+AzAOlmCtq0ZADkuDsZYLkzlGTaNdwM+Q9qhgPtPAtaf0wAhRNWPuge8p79cQ1R7NgZX0rkus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhPrf9qY6FOIjuaEHbVn7cgr5BfyqNuSxc/l/pFYIzqQCa2G/
	UkI+S3KY/VCGb2fw3FIQkcZgTRe/bZoccKjOiDEC7g5rw3UmUMyn
X-Google-Smtp-Source: AGHT+IHlJDWGbNKg/6rLSRDtR0vIz6P0lPq4F4HQ7af1kEE8IpA3r9j3oYK8eJauW2F7A0fA0RcO3g==
X-Received: by 2002:a05:690c:4b09:b0:6ea:258f:a4a9 with SMTP id 00721157ae682-6ea523215d3mr179730057b3.9.1730755248372;
        Mon, 04 Nov 2024 13:20:48 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:32 -0400
Subject: [PATCH v2 6/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-6-de650678648d@gmail.com>
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
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
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 21 ++++++++++++++
 rust/kernel/sync/arc.rs   |  7 +++++
 rust/kernel/types.rs      | 71 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 99d0fc0148bb8779e5a769a6e74291ef8101bf77..c7edcd970fe6abe2afce5364a5f6c565452da85e 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -354,6 +354,7 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     A: Allocator,
 {
     type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a mut T;
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         Box::into_raw(self).cast()
@@ -370,6 +371,13 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> &'a T {
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
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
@@ -399,6 +408,18 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a T> {
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
index 3c779b343aa8c396d2d4b7efdbc0f1ef524a0f1c..8a0f44da8f732afca6009a078e90bd7a14034240 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -332,6 +332,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
+    type BorrowedMut<'a> = Self::Borrowed<'a>;
 
     fn into_foreign(self) -> *mut core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
@@ -357,6 +358,12 @@ unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
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
index b8f3594737401a3df841f30a20c4bd85743853ef..c74223579111fe36c7c7cd135ba95f25f0b33fab 100644
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


