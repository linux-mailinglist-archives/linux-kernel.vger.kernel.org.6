Return-Path: <linux-kernel+bounces-274880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76829947DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3AF2816B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4A15EFBF;
	Mon,  5 Aug 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZTuri7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401F158DD2;
	Mon,  5 Aug 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871275; cv=none; b=e++Pxan6FOp7aXgvR1Lr7tLCliPNhB77DqcxH5s2W7DFMP5vy6+X//KF6eYL2zMPRjE3O57Wbz6kyCuyZ/yVUwnAKRNBig5bVHzWEEyZShZFfPu7w75fiOscdk39U4VvOp+bayjozBsNEs3nwOGCySKAT8Ygx4CaIa9dN3UDWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871275; c=relaxed/simple;
	bh=A4qZq0jLBGmSr7W8ys6nCHz+lSRSI4/dq4nSwiqm/08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/YyaiopsJ6z44Fh+uqpBfEE8QrVR3JEpfO9gYsDX7CBlZgLk2S2BnlXVLpaJ8P8nl1fA98KiaRjH4Hj69dCaq9myuPLD5SXxMKSMtw1rRyVlSUP4wNLFj4oIUc7xNPFz7hfgdgQ3/5SZRXB8plch5p+LVAz7cTjP2BT9VySvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZTuri7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AD8C32782;
	Mon,  5 Aug 2024 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871274;
	bh=A4qZq0jLBGmSr7W8ys6nCHz+lSRSI4/dq4nSwiqm/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZTuri7Q9pVK1y336Rl+9BIudUi4Dtxb/4ueoJsMygn/Qz1UmoueAnLaQ1E+2sAuM
	 6oqjcTTXrSUYNa51oCpWuWi+hfQpB+GuoemZy1HgkSaH0wYq0x4J99m0urEdClI+LH
	 EY53DYm9XTRkQXtkfI6IfByOK+ayHdZ+Wi6gJNlIDrLgmj9AfNDeemuPH0s4z6qHYV
	 NgXmFBdx7MfhsmfkQ4nqJQhj51B/7w487MhEMBGnrsqxunuJ8QTZdEtFU5tpArnPo5
	 s9/W8DYH+oz5876dvkSxyl8WU44lxGVZpi0GEF8RSL9u8MvujKq25qCcpTp9aLE4La
	 YQvQAMPOHV6GA==
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
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 11/28] rust: alloc: remove `BoxExt` extension
Date: Mon,  5 Aug 2024 17:19:30 +0200
Message-ID: <20240805152004.5039-12-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all existing `Box` users were moved to the kernel `Box` type,
remove the `BoxExt` extension.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs         |  1 -
 rust/kernel/alloc/box_ext.rs | 56 ------------------------------------
 rust/kernel/init.rs          | 34 +---------------------
 rust/kernel/lib.rs           |  1 -
 rust/kernel/prelude.rs       |  4 +--
 rust/kernel/types.rs         | 23 ---------------
 6 files changed, 3 insertions(+), 116 deletions(-)
 delete mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index d7beaf0372af..f578175ff010 100644
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
index 829cb1c1cf9e..000000000000
--- a/rust/kernel/alloc/box_ext.rs
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Box`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::boxed::Box;
-use core::mem::MaybeUninit;
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
-}
-
-impl<T> BoxExt<T> for Box<T> {
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
-        let b = <Self as BoxExt<_>>::new_uninit(flags)?;
-        Ok(Box::write(b, x))
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
-}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b3159eb1eb02..ae533305d40e 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,12 +211,11 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Allocator, Flags, KBox},
+    alloc::{AllocError, Allocator, Flags, KBox},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -589,7 +588,6 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust
-/// # #![feature(new_uninit)]
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
@@ -1149,36 +1147,6 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
-impl<T> InPlaceInit<T> for Box<T> {
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
-    where
-        E: From<AllocError>,
-    {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot = this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot = this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
-    }
-}
-
 impl<T, A> InPlaceInit<T> for crate::alloc::Box<T, A>
 where
     A: Allocator + 'static,
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..042f05c45214 100644
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
index 39f9331a48e2..a8018ef2e691 100644
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
index 9fe87528d129..b80a3b2b62ac 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -4,7 +4,6 @@
 
 use crate::alloc::Allocator;
 use crate::init::{self, PinInit};
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
@@ -69,28 +68,6 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
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
 impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
 where
     A: Allocator,
-- 
2.45.2


