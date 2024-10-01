Return-Path: <linux-kernel+bounces-346190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3998C107
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240281C219A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3E1CCB3F;
	Tue,  1 Oct 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYqvZ+st"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B651CCB29;
	Tue,  1 Oct 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794887; cv=none; b=spZ8MgIjioL9GXPPD/tp3G6nVQjmRrEVSrypi4Z1xrP4pXhibHsekTViPkdY778m93BrHK97g901sT5r8t/C1rpL7rb15eSxaOyMXqZHvHthR+EWHBU+nsO8ni7Ly6Jo1iuP2gxdQ46TjlRoS8oJaH4bk9OT8PqVF7J9m0DerbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794887; c=relaxed/simple;
	bh=Zu8P7MuHt7+xm2sEdwuDsQEd5JSKWYbaqyjWfsTh9ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulTbfD65Jd3E/v4bkuEoc1hBoNf2TfLUXq6ZfOBqO0YtTVHABhXR8HFmt4c5uqYP+odXzSj0R1VXl9zNtANmahlpl5EcuylQxDyLq6mCdwdfxJ8tvA71yCKv0/DIe8ob1MebcfRzSnJThti0TVwAym/E+bU2eXlZjKTzhghLGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYqvZ+st; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE1C4CED2;
	Tue,  1 Oct 2024 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794887;
	bh=Zu8P7MuHt7+xm2sEdwuDsQEd5JSKWYbaqyjWfsTh9ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYqvZ+sthieCtuiBhk7fCt/Why2VKoE45Gis6Ra+HG3EvVij1GQl/pC6Es4E9LDNs
	 nqvylaoLi7ei34TFV1bt5SXkGxuynbhJiI67vsT3fRxpWx8F/fiNGgFEm9z6AeQAJJ
	 hxOv1j1a9+RiRqHvMOe9RjTfqw3b/mZCj5qJGa0dfREgqZoFEG72P4HB+AJXcxImsd
	 D3vxOhvWAqZghudDcFQ0d25mf2EyRrsGMWVu+GJLaFHiJpyp9ipn58OcNDUopcL3Cl
	 ecf73h0UmY6x7iOnWP5HzHxneMU8FRbzFK8N1oIY921Cm7HeReBeWi+LsMRoWhBzXv
	 QZqDQnGeysaKw==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v8 13/29] rust: alloc: remove extension of std's `Box`
Date: Tue,  1 Oct 2024 16:59:48 +0200
Message-ID: <20241001150008.183102-14-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all existing `Box` users were moved to the kernel `Box` type,
remove the `BoxExt` extension and all other related extensions.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs         |  1 -
 rust/kernel/alloc/box_ext.rs | 89 ------------------------------------
 rust/kernel/init.rs          | 46 +------------------
 rust/kernel/lib.rs           |  1 -
 rust/kernel/prelude.rs       |  4 +-
 rust/kernel/types.rs         | 50 --------------------
 6 files changed, 3 insertions(+), 188 deletions(-)
 delete mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 12cd52f83222..ebe58247504f 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,6 @@
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-pub mod box_ext;
 pub mod kbox;
 pub mod vec_ext;
 
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
deleted file mode 100644
index 7009ad78d4e0..000000000000
--- a/rust/kernel/alloc/box_ext.rs
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Box`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::boxed::Box;
-use core::{mem::MaybeUninit, ptr, result::Result};
-
-/// Extensions to [`Box`].
-pub trait BoxExt<T>: Sized {
-    /// Allocates a new box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Allocates a new uninitialised box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
-
-    /// Drops the contents, but keeps the allocation.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use kernel::alloc::{flags, box_ext::BoxExt};
-    /// let value = Box::new([0; 32], flags::GFP_KERNEL)?;
-    /// assert_eq!(*value, [0; 32]);
-    /// let mut value = Box::drop_contents(value);
-    /// // Now we can re-use `value`:
-    /// value.write([1; 32]);
-    /// // SAFETY: We just wrote to it.
-    /// let value = unsafe { value.assume_init() };
-    /// assert_eq!(*value, [1; 32]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
-}
-
-impl<T> BoxExt<T> for Box<T> {
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
-        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
-        b.write(x);
-        // SAFETY: We just wrote to it.
-        Ok(unsafe { b.assume_init() })
-    }
-
-    #[cfg(any(test, testlib))]
-    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        Ok(Box::new_uninit())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
-            core::ptr::NonNull::<_>::dangling().as_ptr()
-        } else {
-            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
-
-            // SAFETY: Memory is being allocated (first arg is null). The only other source of
-            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
-            // the type is not a SZT (checked above).
-            let ptr =
-                unsafe { super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags) };
-            if ptr.is_null() {
-                return Err(AllocError);
-            }
-
-            ptr.cast::<MaybeUninit<T>>()
-        };
-
-        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
-        // zero-sized types, we use `NonNull::dangling`.
-        Ok(unsafe { Box::from_raw(ptr) })
-    }
-
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
-        let ptr = Box::into_raw(this);
-        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
-        unsafe { ptr::drop_in_place(ptr) };
-
-        // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
-        let ptr = ptr.cast::<MaybeUninit<T>>();
-
-        // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
-        // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
-        unsafe { Box::from_raw(ptr) }
-    }
-}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index e057b374f255..2f562642e9a4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,13 +211,12 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
+    alloc::{AllocError, Flags, KBox},
     error::{self, Error},
     sync::Arc,
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -590,7 +589,6 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust
-/// # #![feature(new_uninit)]
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
@@ -1244,26 +1242,6 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-impl<T> InPlaceInit<T> for Box<T> {
-    type PinnedSelf = Pin<Self>;
-
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_pin_init(init)
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_init(init)
-    }
-}
-
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     type PinnedSelf = Pin<Self>;
 
@@ -1300,28 +1278,6 @@ pub trait InPlaceWrite<T> {
     fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E>;
 }
 
-impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
-    type Initialized = Box<T>;
-
-    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() })
-    }
-
-    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() }.into())
-    }
-}
-
 impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
     type Initialized = UniqueArc<T>;
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..e6e0f748f8a8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,7 +14,6 @@
 #![no_std]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
-#![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index a9210634a8c3..c1f8e5c832e2 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,10 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
 
 #[doc(no_inline)]
-pub use alloc::{boxed::Box, vec::Vec};
+pub use alloc::vec::Vec;
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355c..53d3ddc0b98c 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -3,13 +3,11 @@
 //! Kernel types.
 
 use crate::init::{self, PinInit};
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
-    pin::Pin,
     ptr::NonNull,
 };
 
@@ -71,54 +69,6 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Box<T> {
-    type Borrowed<'a> = &'a T;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
-    }
-}
-
-impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
-    type Borrowed<'a> = Pin<&'a T>;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
-
-        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
-        unsafe { Pin::new_unchecked(r) }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
-    }
-}
-
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-- 
2.46.1


