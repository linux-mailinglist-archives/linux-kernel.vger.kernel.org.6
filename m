Return-Path: <linux-kernel+bounces-401912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C69C20F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B16D1F25128
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70881227B83;
	Fri,  8 Nov 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/BIjW8"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE721FD99;
	Fri,  8 Nov 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080811; cv=none; b=Q08CM/eC61k67QVaymQwYZPAc/KYbLt7V9JE/U/gxslqNry3ROoZTFtKK/ONqfxJ3MM3ZZ7P0fyDh1X5sGf+t3qHxJ131banmPv8NUPMS3EpebOJ0DzsIv6eJuIO7VpLG4d2faqK/OHk3vZgCLoLUHnNiG3T6LJ30KNaVkdLmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080811; c=relaxed/simple;
	bh=u+NEbyOJWpdDSeZChuV1qe4SlZNC/slJCrEWdMuLbS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jn7Lb3K2K2UbN33oYlsph99Fbb7LKbeIhHj84QVbJ7QZQmfqSCOzoMs6OuZgMttn3MLrDu479Al6RGF0QX7zCew5lQ5msmriwjFk2Fk3zjqh1abu3TBu9egCr0A0ZPNrlIImDh9HMH1xWvJD9+YikVGWhprmCJqt/6Fz46TziiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3/BIjW8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b147a2ff04so129150585a.3;
        Fri, 08 Nov 2024 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080808; x=1731685608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVSKDJntyrJ4XBJ4eP6/vgd1kjKfRwF8eMDahS+L+uU=;
        b=F3/BIjW8eCNI/FlttUEk+3gAycQP0WSKz5Yx4rgofy0XblmLuJfARgza1ZCRFpdD3s
         piDcfNAP+ldVhAn9t2/ginM+huTzeMT9MD1+ROKYjU/BPh2FCENdxDByTsk+oMiD6APc
         Yz1gsA3SN3RjypT19e9KQcJSIsKjnL0vAyVycBUVwMcIYPGi9OLFfa3jcV65oTqjt2uQ
         srNnfsib1UX1ad9T7cYE7h0TY1uy68rxkQXtwN+3nameswKv0JcGN/XMKSUbk6eQo+Wq
         m7LEyWRDGYW/cP60UhOvOkuEK11G3y67gVGmgmIEc0OptdoPDnVNBkUY+F1Dx8MeQm/4
         Q6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080808; x=1731685608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVSKDJntyrJ4XBJ4eP6/vgd1kjKfRwF8eMDahS+L+uU=;
        b=Jj6kmkp3kxPQjSxruBdQ13+zOEtPa3nUIplNVVFVdZV31+PLLyR6wOrd+ENlU9x5cn
         f0iWSUw+A1CNtT3uoLNt7YvfgCTf3HigE4FY618/7p1zWx3yfVR/IPDMRlGy46sNqvnV
         N227a2ISpk8ArgiasbIxVXRdNfe1r6nlBuIjwT5hmeZRRFxG/BADI2fB8Mo6jbtzpKYk
         NVSN5IZOtJe4flIil/vLfKkmmHNxTEg6FyS+TyUXyj//lqZRcVjugtYI06FZDgy0vOoh
         12LCQyo7t5swGCPPEBOrAeHimAN89TJWJheicMSPREtA+yWfxCmsF52f/73enGaHTNAI
         vZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUD6AKGXvI4TpXtOEbsXErn/kpWoNc30ykNg6jkD/J1TGH6ulLjHcT8+0atBMeV2I7Qlt4Eb8HGbmf7A3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfS+K/wFdtnWnrg7ujih0LSpthUtBaHZkbboS4uhKRZdgEaTA+
	b5btdcjG8A+XPNYEs+vQ0OkxTjXad/19RJs5Zn8kF1gDR41LHxKZ
X-Google-Smtp-Source: AGHT+IF2qY/fn8FyBjqItC0Y7+MTALIJTw8ex96uVtE07xNxxWZ7Y18IuStyPkBO+ihvKjFcJ7FxWw==
X-Received: by 2002:a05:6214:4387:b0:6cb:82fc:2741 with SMTP id 6a1803df08f44-6d39e1abb1fmr43490716d6.49.1731080808377;
        Fri, 08 Nov 2024 07:46:48 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:21 -0500
Subject: [PATCH v3 6/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-6-b7144945714e@gmail.com>
References: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
In-Reply-To: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
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


