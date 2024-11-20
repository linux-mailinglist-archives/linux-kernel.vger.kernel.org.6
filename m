Return-Path: <linux-kernel+bounces-415684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B343E9D39DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742F6281E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A91AE014;
	Wed, 20 Nov 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNwM/mbA"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA21AB6CD;
	Wed, 20 Nov 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103190; cv=none; b=LoF+4jLuRqoytaj/ohuFQoTVX5tqScvfm/1i9IEi2NUQv4hdSzLU1BWsUsFXWeBz9M19os+wkLzZuvGiJuhw3hrTPY5QL8RBiZmCA/hNb7HHWN5Nq/uHH9KkLlFB6hQPvKOIbekqG6IOpS7OttrvccJKJXfKg04LkHzHnKu837o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103190; c=relaxed/simple;
	bh=eriiqR6Dqx15OewfJ6/J7anxwKEo1pQayQbYfxnaSrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4BFQCm/55RcENv/IG7Q640sbveHgc6vbPjsckVma89MGu3YybvZTdrr4EqQd0QsfTiKxPdaNkwngaJgjsgO7GqoP8LS310x0WT7ve/3xfDLHK7v7kre4uyMylWSFUC+dEDRAj3dtdGGrifQFSObLhoDaY+qwz8eb881yQ2ln1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNwM/mbA; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e600add5dcso1672838b6e.2;
        Wed, 20 Nov 2024 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103186; x=1732707986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SONU16xHBNjBt4uYb6vytstSCR1xGbZXHyoVwR4jlYI=;
        b=NNwM/mbAb07sAmPxXw/1kAUXGil68JaQBwYrK9b/v+7UKo/DgA4715aRMqu1OXxEiL
         YaruwWcGQ+tlZjNOftnKuSO9/5u0aKYAfmAH57/QOn+Wgx2NIDx3Ux1Bs3aCk27ciXSJ
         BqlrdzeC5BmsNVK+yQDrPigIij0vmdT+qGx5L13IbjeCYdKO/fxdswtc3N+QdeHYq2ML
         VLGVFe+12bLR+fjXI/wFrJrOI3Fc6hhn3GtUa+pq8EHzKNYhYz3r1Jm9tzWwqR7ZQhBX
         LugpFMLPiy3qBwhHqERNuJl/61EvMpnrCtRLvMrGqWSVR6337DRNKnYmv0WFwvTyy7K4
         O4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103186; x=1732707986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SONU16xHBNjBt4uYb6vytstSCR1xGbZXHyoVwR4jlYI=;
        b=emlwJdVDQNta3s5fSsaPPs2B45kbuZBouBT56TdkM6KnPezFL4YCHa8PPQ90s1H6Z1
         h0Nmnpmh0spyVL+XjloIV7Vg7JmQDL1pgmM1pTWtaUUdLq+Eq6msLp07xkj9n00vLjSZ
         E4rtJy8cGXzaxPvU9tNJI1OSn8y2H79Iljg9WMPMsHJ/AaMRfDQ5f919v0oB9hneRVoQ
         +R+r4xgXvSQPUz9t8jaYc5VmMp1Mwplo88YIWUDApd8ZWGx/kCNefj6DQMuIFzj+JlIj
         70o7JXR8XF8fkuK5KbK4k6I9UNt/6Pf4tPbqCeAU3In/usTBfZW54kXcq2CbES2c5OHB
         SYHg==
X-Forwarded-Encrypted: i=1; AJvYcCXXLp4vnpGl6EulX1kU9oeNedIBFX8mXsqel42csmAUjmODPuSjTFkZl9lSIeGsUeqst5vrtSotKBlCGAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LAQd59fGVQg6QrghmfEV0oVP+9q/oAmcHqVVSZMd8eQLsQXX
	IOglQEzkLFkfbpyM6ljsqB7Z5a6Ye6CM+MN5r7/HanjpYpXOZGx7
X-Google-Smtp-Source: AGHT+IE1D+e4Yva8zfTtR1PCBPexgWEfjfKtCs0QNMiVx5PMkxksQjm/JmzzEjUuPaG7Xtt8wPQVvg==
X-Received: by 2002:a05:6808:318f:b0:3e7:b7f8:f9ac with SMTP id 5614622812f47-3e7eb6cb78dmr2586532b6e.12.1732103185836;
        Wed, 20 Nov 2024 03:46:25 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:24 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:05 -0500
Subject: [PATCH v6 6/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-6-80dbadd00951@gmail.com>
References: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
In-Reply-To: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
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
index af316e291908123407f08c665c91113a666fc593..0dfaf45a755c7ce702027918e5fd3e97c407fda4 100644
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


