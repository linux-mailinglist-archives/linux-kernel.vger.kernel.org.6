Return-Path: <linux-kernel+bounces-389520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B79B6E04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A4A1F22037
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB171E0E00;
	Wed, 30 Oct 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5jl6PzN"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D871BD9E2;
	Wed, 30 Oct 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321208; cv=none; b=lGWkUqnthYHRwNxdRF+TwdSqcXHOkLjUCxjWyD1eWoewWfm2pEOcd/lTOOVumrKlhhR58xS9CC3m7+bYmKN1AGje3by3VJRIDQT1O/ub3jpwsjz3kz2gG+mbc7T4iHsAS1RgX0MV3X+HrDBmuWneu/L4rMu63ebSzP+5tzmC/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321208; c=relaxed/simple;
	bh=s+JOsokl8HTzsLJu0YwhoCbFGKiWcJDGG6609M+g3TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiW0bmMF5MII7HIsqBLuH9AX3Es0HTN9FJ6R4aK5aGJZ8blyk1AKZ3CZ5zHnB9Zp+2i4274kheCMUh/S1V4jPFCRjgDNaGjXdAzOjolc4/zhEikaJt5LQGFiGO7legibKCkRp8jaPjvsmNQNPJVepq0Eewp/0wykLBBJ3ljgVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5jl6PzN; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc22e6362so177140eaf.2;
        Wed, 30 Oct 2024 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321204; x=1730926004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW45e7gx4fvje5qEi3cakB/2Tqj9cnWab4H35fyWZ0I=;
        b=A5jl6PzNrHVmrXgKcPMvwa9J5KYDxB6HJR7Vk1VyGpvrlcDPsiHHBGqUiB8fbuMYcn
         j6FRaJEGJ5GCxrSxnFBUpabl5r6pN7mR7KswSDkbzG3UQ8lHiiHmop4JTls2MBAPSbYp
         D8QMje78Zd4RCPEOVOop8y6uOovVTiLllMqLcCY+bAhn0SjVSrMs+fcjNvl0tPPGXfsV
         g5TwphyRyIQL6sUyYOw318nq8OBuvyHh6Z53ohXWF+TFK1nW7Bt+cId1n6jEiv49+FGC
         U0FSwYHwaJyGXRZwIn1cL7xg8ULTq9q5WwrO+WBhh8MsPS79ukv7jApEBILhc666HEQl
         +W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321204; x=1730926004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW45e7gx4fvje5qEi3cakB/2Tqj9cnWab4H35fyWZ0I=;
        b=aDSdqrtXFZ7LbtVXWxTtMldlFBjrTuknVRwIas+3jTc3F8uqNohglvpI6zSt84OuES
         /dC61LueMUyIU9qXj+Iq3KTus1YTOUHgv/AF6j+hAgE1Zssu9nQQKhpiYJ9jAbZCYVIm
         ymzroy1aM6xV4NKAgVioTmSpC3aymMWPyE2PouhGSLgv+bC9LxPlKJj5tnYM4F9MBnC1
         0QYVqb2642VIMWn8hSepHa4i13MFwJMVphNWXpPVdB1fpuqKjEqQWGx+DTOyQNaLSTe7
         X7UwrCM9Gquik0j7I2MUaHpqkLmtiMMyhEqkz7DoCzaUJ8Ajuw1yKfpxqcoWBe1FAjyj
         HoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu07Nwyvm0MurhYLAif+Dlvf1qE15bGa2qXHcRz7HWN3Je0RwlLRLKn+YU9r2wqQdvRZdNwiaImhw+CmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFaFOJjGpbuOB2Yr2WJZZzjyPTtxXdEWTVcsKF93td4SwSgbm
	HnrUDu00tkk9mWJXc8057AWnVkEYD4oOUgegIhq+RvCxhj7li2We
X-Google-Smtp-Source: AGHT+IEdneqM5xabBYVFBPR9NlxPfCAAwq2JkQfVv3RZABU0fxOGjJbduxuNWiZU/u66i4/TE9lO6A==
X-Received: by 2002:a05:6358:7e06:b0:1c5:e2ea:8993 with SMTP id e5c5f4694b2df-1c5ee958a69mr97166155d.11.1730321204360;
        Wed, 30 Oct 2024 13:46:44 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 16:46:39 -0400
Subject: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.

Reduce the scope of unsafe blocks and add missing safety comments where
an unsafe block has been split into several unsafe blocks.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 32 +++++++++++++++----------
 rust/kernel/sync/arc.rs   | 59 +++++++++++++++++++++++++++++------------------
 rust/kernel/types.rs      |  5 ++--
 3 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..7a5fdf7b660fb91ca2a8e5023d69d629b0d66062 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -182,12 +182,12 @@ impl<T, A> Box<MaybeUninit<T>, A>
     ///
     /// Callers must ensure that the value inside of `b` is in an initialized state.
     pub unsafe fn assume_init(self) -> Box<T, A> {
-        let raw = Self::into_raw(self);
+        let raw = Self::into_raw(self).cast();
 
         // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
         // of this function, the value inside the `Box` is in an initialized state. Hence, it is
         // safe to reconstruct the `Box` as `Box<T, A>`.
-        unsafe { Box::from_raw(raw.cast()) }
+        unsafe { Box::from_raw(raw) }
     }
 
     /// Writes the value and converts to `Box<T, A>`.
@@ -247,10 +247,10 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
 
     /// Forgets the contents (does not run the destructor), but keeps the allocation.
     fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
-        let ptr = Self::into_raw(this);
+        let ptr = Self::into_raw(this).cast();
 
         // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
-        unsafe { Box::from_raw(ptr.cast()) }
+        unsafe { Box::from_raw(ptr) }
     }
 
     /// Drops the contents, but keeps the allocation.
@@ -356,19 +356,21 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
+        Box::into_raw(self).cast_const().cast()
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        let ptr = ptr.cast_mut().cast();
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr) }
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
-        unsafe { &*ptr.cast() }
+        unsafe { &*ptr }
     }
 }
 
@@ -380,21 +382,25 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
+            .cast_const()
+            .cast()
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        let ptr = ptr.cast_mut().cast();
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
         // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
+        let r = unsafe { &*ptr };
 
         // SAFETY: This pointer originates from a `Pin<Box<T>>`.
         unsafe { Pin::new_unchecked(r) }
@@ -445,12 +451,14 @@ impl<T, A> Drop for Box<T, A>
     fn drop(&mut self) {
         let layout = Layout::for_value::<T>(self);
 
+        let ptr = self.0.as_ptr();
         // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
-        unsafe { core::ptr::drop_in_place::<T>(self.deref_mut()) };
+        unsafe { core::ptr::drop_in_place(ptr) };
 
+        let addr = self.0.cast();
         // SAFETY:
         // - `self.0` was previously allocated with `A`.
         // - `layout` is equal to the `Layout´ `self.0` was allocated with.
-        unsafe { A::free(self.0.cast(), layout) };
+        unsafe { A::free(addr, layout) };
     }
 }
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4857230bd8d410bcca97b2081c3ce2f617ee7921..88e5208369e40bdeebc6f758e89f836a97790d89 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -148,9 +148,10 @@ unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
         let refcount_layout = Layout::new::<bindings::refcount_t>();
         // SAFETY: The caller guarantees that the pointer is valid.
         let val_layout = Layout::for_value(unsafe { &*ptr });
+        let val_offset = refcount_layout.extend(val_layout);
         // SAFETY: We're computing the layout of a real struct that existed when compiling this
         // binary, so its layout is not so large that it can trigger arithmetic overflow.
-        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
+        let (_, val_offset) = unsafe { val_offset.unwrap_unchecked() };
 
         // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
         // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
@@ -164,9 +165,10 @@ unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
         // still valid.
         let ptr = unsafe { ptr.byte_sub(val_offset) };
 
+        let ptr = ptr.cast_mut();
         // SAFETY: The pointer can't be null since you can't have an `ArcInner<T>` value at the null
         // address.
-        unsafe { NonNull::new_unchecked(ptr.cast_mut()) }
+        unsafe { NonNull::new_unchecked(ptr) }
     }
 }
 
@@ -201,10 +203,11 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         };
 
         let inner = KBox::new(value, flags)?;
+        let inner = KBox::leak(inner).into();
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-        Ok(unsafe { Self::from_inner(KBox::leak(inner).into()) })
+        Ok(unsafe { Self::from_inner(inner) })
     }
 }
 
@@ -333,13 +336,15 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr() as _
+        ManuallyDrop::new(self).ptr.as_ptr().cast_const().cast()
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        let ptr = ptr.cast_mut().cast();
+
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as _) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -347,9 +352,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        let ptr = ptr.cast_mut().cast();
+
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as _) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -376,10 +383,14 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { bindings::refcount_inc(refcount) };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -399,10 +410,11 @@ fn drop(&mut self) {
         // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
         let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
         if is_zero {
+            let ptr = self.ptr.as_ptr();
             // The count reached zero, we must free the memory.
             //
             // SAFETY: The pointer was initialised from the result of `KBox::leak`.
-            unsafe { drop(KBox::from_raw(self.ptr.as_ptr())) };
+            unsafe { drop(KBox::from_raw(ptr)) };
         }
     }
 }
@@ -550,7 +562,7 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant, the underlying object is still alive with no mutable
         // references to it, so it is safe to create a shared reference.
-        unsafe { &self.inner.as_ref().data }
+        &unsafe { self.inner.as_ref() }.data
     }
 }
 
@@ -652,11 +664,11 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
             }? AllocError),
             flags,
         )?;
-        Ok(UniqueArc {
-            // INVARIANT: The newly-created object has a refcount of 1.
-            // SAFETY: The pointer from the `KBox` is valid.
-            inner: unsafe { Arc::from_inner(KBox::leak(inner).into()) },
-        })
+        let inner = KBox::leak(inner).into();
+        // INVARIANT: The newly-created object has a refcount of 1.
+        // SAFETY: The pointer from the `KBox` is valid.
+        let inner = unsafe { Arc::from_inner(inner) };
+        Ok(UniqueArc { inner })
     }
 }
 
@@ -675,18 +687,18 @@ pub fn write(mut self, value: T) -> UniqueArc<T> {
     /// The caller guarantees that the value behind this pointer has been initialized. It is
     /// *immediate* UB to call this when the value is not initialized.
     pub unsafe fn assume_init(self) -> UniqueArc<T> {
-        let inner = ManuallyDrop::new(self).inner.ptr;
-        UniqueArc {
-            // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be
-            // dropped). The types are compatible because `MaybeUninit<T>` is compatible with `T`.
-            inner: unsafe { Arc::from_inner(inner.cast()) },
-        }
+        let inner = ManuallyDrop::new(self).inner.ptr.cast();
+        // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be
+        // dropped). The types are compatible because `MaybeUninit<T>` is compatible with `T`.
+        let inner = unsafe { Arc::from_inner(inner) };
+        UniqueArc { inner }
     }
 
     /// Initialize `self` using the given initializer.
     pub fn init_with<E>(mut self, init: impl Init<T, E>) -> core::result::Result<UniqueArc<T>, E> {
+        let ptr = self.as_mut_ptr();
         // SAFETY: The supplied pointer is valid for initialization.
-        match unsafe { init.__init(self.as_mut_ptr()) } {
+        match unsafe { init.__init(ptr) } {
             // SAFETY: Initialization completed successfully.
             Ok(()) => Ok(unsafe { self.assume_init() }),
             Err(err) => Err(err),
@@ -698,9 +710,10 @@ pub fn pin_init_with<E>(
         mut self,
         init: impl PinInit<T, E>,
     ) -> core::result::Result<Pin<UniqueArc<T>>, E> {
+        let ptr = self.as_mut_ptr();
         // SAFETY: The supplied pointer is valid for initialization and we will later pin the value
         // to ensure it does not move.
-        match unsafe { init.__pinned_init(self.as_mut_ptr()) } {
+        match unsafe { init.__pinned_init(ptr) } {
             // SAFETY: Initialization completed successfully.
             Ok(()) => Ok(unsafe { self.assume_init() }.into()),
             Err(err) => Err(err),
@@ -729,7 +742,7 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: By the `Arc` type invariant, there is necessarily a reference to the object, so
         // it is safe to dereference it. Additionally, we know there is only one reference when
         // it's inside a `UniqueArc`, so it is safe to get a mutable reference.
-        unsafe { &mut self.inner.ptr.as_mut().data }
+        &mut unsafe { self.inner.ptr.as_mut() }.data
     }
 }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fae80814fa1c5e0f11933f2f15e173f0e3a10fe0..e8b7ff1387381e50d7963978e57b1d567113b035 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -418,7 +418,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     /// }
     ///
     /// let mut data = Empty {};
-    /// let ptr = NonNull::<Empty>::new(&mut data as *mut _).unwrap();
+    /// let ptr = NonNull::new(&mut data).unwrap();
     /// # // SAFETY: TODO.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
@@ -450,8 +450,9 @@ fn deref(&self) -> &Self::Target {
 impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
     fn from(b: &T) -> Self {
         b.inc_ref();
+        let b = b.into();
         // SAFETY: We just incremented the refcount above.
-        unsafe { Self::from_raw(NonNull::from(b)) }
+        unsafe { Self::from_raw(b) }
     }
 }
 

-- 
2.47.0


