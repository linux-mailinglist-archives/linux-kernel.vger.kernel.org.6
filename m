Return-Path: <linux-kernel+bounces-260282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A693A559
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DF9B235EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1415B0E3;
	Tue, 23 Jul 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1x1UV6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461C158D81;
	Tue, 23 Jul 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758304; cv=none; b=HDUIU28Zaehx002YNBc0CpOs/awLoAbZt39DnwHeWPOjfYlRuPT9fMOMFdSsz+s8zsChJoqbyUlE7q0HSAYUh4/9liysN83prNgI9W6dGONLmYzIoQnB9sAr5P7Kh/SeKnIjtDaaCQcCuwKY4NxwsxlamALRhXjwVppMpGY3Yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758304; c=relaxed/simple;
	bh=ITmzVZ1ozdPC3EpkKUw5PXAHmRHl6f/OyV+G/hFt6go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyuoACzFmvYq9ovJ3Zjflhr9GaAF3fkgm5OlcgWxXy+w1fLge2E1qysEkNi68SSRzq+lyjFp9L4ECPyuMxXwwBeaDGp4c17edNz1ka72OZUJQ66oEp3yelw8Zlshj2tGC0RgLp4giny7DseuPsCYUkcyjz7NDR29d7zoW/Q1GJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1x1UV6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE6C4AF0E;
	Tue, 23 Jul 2024 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758304;
	bh=ITmzVZ1ozdPC3EpkKUw5PXAHmRHl6f/OyV+G/hFt6go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1x1UV6QZQmFQm9ajyXyqUWSDF8heHOtbK3W22bT6fY/vpirKkHlsBsc28w26zpyg
	 IIZ1TnM4Ubox+kwaKEr+69eGZEBh65kwS2yt5KbWIw888g3KGVSvNiGEloahoNvXoO
	 /LjzTfcpJfaK240ZGJr1c+5krXZ/GRU2tNdwU/RS8q9HBp4KgGyLIQRrah+cUXAE7d
	 QHXxwKoctXEF9TB3h+/K3TWfGVY3PfzH3O62bbtYGzANqksggSqNuTJQI5XjSPiLuL
	 IDQ8JPmt0+I5dMCEtBtpcV6VwMo4vYUDY3Od94KgLw2AUbySs16aIFQi/Cxm1I4ZI9
	 KzUkEqOAKpvlA==
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
Subject: [PATCH v2 09/23] rust: alloc: implement kernel `Box`
Date: Tue, 23 Jul 2024 20:09:58 +0200
Message-ID: <20240723181024.21168-10-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`Box` provides the simplest way to allocate memory for a generic type
with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
`KVmalloc`.

In contrast to Rust's `Box` type, the kernel `Box` type considers the
kernel's GFP flags for all appropriate functions, always reports
allocation failures through `Result<_, AllocError>` and remains
independent from unstable features.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs      |   6 +
 rust/kernel/alloc/kbox.rs | 330 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/init.rs       |  32 +++-
 rust/kernel/prelude.rs    |   2 +-
 rust/kernel/types.rs      |  26 +++
 5 files changed, 394 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/kbox.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 90ebe79e86cb..d9809368643e 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod box_ext;
+pub mod kbox;
 pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
@@ -13,6 +14,11 @@
 #[cfg(any(test, testlib))]
 pub use self::allocator_test as allocator;
 
+pub use self::kbox::Box;
+pub use self::kbox::KBox;
+pub use self::kbox::KVBox;
+pub use self::kbox::VBox;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
new file mode 100644
index 000000000000..eb4a5ff500b8
--- /dev/null
+++ b/rust/kernel/alloc/kbox.rs
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Box`].
+
+use super::{AllocError, Allocator, Flags};
+use core::fmt;
+use core::marker::PhantomData;
+use core::mem::ManuallyDrop;
+use core::mem::MaybeUninit;
+use core::ops::{Deref, DerefMut};
+use core::pin::Pin;
+use core::ptr;
+use core::result::Result;
+
+use crate::types::Unique;
+
+/// The kernel's `Box` type named [`Box`].
+///
+/// `Box` provides the simplest way to allocate memory for a generic type with one of the kernel's
+/// allocators, e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`.
+///
+/// For non-zero-sized values, a [`Box`] will use the given allocator `A` for its allocation. For
+/// the most common allocators the type aliases `KBox`, `VBox` and `KVBox` exist.
+///
+/// It is valid to convert both ways between a [`Box`] and a raw pointer allocated with any
+/// `Allocator`, given that the `Layout` used with the allocator is correct for the type.
+///
+/// For zero-sized values the [`Box`]' pointer must be `dangling_mut::<T>`; no memory is allocated.
+///
+/// So long as `T: Sized`, a `Box<T>` is guaranteed to be represented as a single pointer and is
+/// also ABI-compatible with C pointers (i.e. the C type `T*`).
+///
+/// # Invariants
+///
+/// The [`Box`]' pointer always properly aligned and either points to memory allocated with `A` or,
+/// for zero-sized types, is a dangling pointer.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::alloc::allocator::Kmalloc;
+///
+/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
+/// use kernel::alloc::allocator::KVmalloc;
+///
+/// struct Huge([u8; 1 << 24]);
+///
+/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
+/// ```
+pub struct Box<T: ?Sized, A: Allocator>(Unique<T>, PhantomData<A>);
+
+/// Type alias for `Box` with a `Kmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
+
+/// Type alias for `Box` with a `Vmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = VBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
+
+/// Type alias for `Box` with a `KVmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
+
+impl<T, A> Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    /// Constructs a `Box<T, A>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
+    /// type `T`.
+    #[inline]
+    pub const unsafe fn from_raw_alloc(raw: *mut T, alloc: PhantomData<A>) -> Self {
+        // SAFETY: Safe by the requirements of this function.
+        Box(unsafe { Unique::new_unchecked(raw) }, alloc)
+    }
+
+    /// Consumes the `Box<T, A>`, returning a wrapped raw pointer and the allocator it was
+    /// allocated with.
+    pub fn into_raw_alloc(self) -> (*mut T, PhantomData<A>) {
+        let b = ManuallyDrop::new(self);
+        let alloc = unsafe { ptr::read(&b.1) };
+        (b.0.as_ptr(), alloc)
+    }
+
+    /// Constructs a `Box<T, A>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
+    /// type `T`.
+    #[inline]
+    pub const unsafe fn from_raw(raw: *mut T) -> Self {
+        // SAFETY: Validity of `raw` is guaranteed by the safety preconditions of this function.
+        unsafe { Box::from_raw_alloc(raw, PhantomData::<A>) }
+    }
+
+    /// Consumes the `Box<T>`, returning a wrapped raw pointer.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = KBox::new(24, GFP_KERNEL)?;
+    /// let ptr = KBox::into_raw(x);
+    /// let x = unsafe { KBox::from_raw(ptr) };
+    ///
+    /// assert_eq!(*x, 24);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn into_raw(self) -> *mut T {
+        self.into_raw_alloc().0
+    }
+
+    /// Consumes and leaks the `Box<T>`, returning a mutable reference, &'a mut T.
+    #[inline]
+    pub fn leak<'a>(b: Self) -> &'a mut T
+    where
+        T: 'a,
+    {
+        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
+        // which points to an initialized instance of `T`.
+        unsafe { &mut *Box::into_raw(b) }
+    }
+
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`.
+    #[inline]
+    pub fn into_pin(b: Self) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        // SAFETY: It's not possible to move or replace the insides of a `Pin<Box<T>>` when
+        // `T: !Unpin`, so it's safe to pin it directly without any additional requirements.
+        unsafe { Pin::new_unchecked(b) }
+    }
+}
+
+impl<T, A> Box<MaybeUninit<T>, A>
+where
+    A: Allocator,
+{
+    /// Converts to `Box<T, A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with MaybeUninit::assume_init, it is up to the caller to guarantee that the value really
+    /// is in an initialized state. Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    pub unsafe fn assume_init(self) -> Box<T, A> {
+        let raw = Box::into_raw(self);
+        // SAFETY: Reconstruct the `Box<MaybeUninit<T>, A>` as Box<T, A> now that has been
+        // initialized. `raw` and `alloc` are safe by the invariants of `Box`.
+        unsafe { Box::from_raw(raw as *mut T) }
+    }
+
+    /// Writes the value and converts to `Box<T, A>`.
+    pub fn write(mut boxed: Self, value: T) -> Box<T, A> {
+        (*boxed).write(value);
+        // SAFETY: We've just initialized `boxed`'s value.
+        unsafe { boxed.assume_init() }
+    }
+}
+
+impl<T, A> Box<T, A>
+where
+    A: Allocator,
+{
+    fn is_zst() -> bool {
+        core::mem::size_of::<T>() == 0
+    }
+
+    /// Allocates memory with the allocator `A` and then places `x` into it.
+    ///
+    /// This doesn’t actually allocate if T is zero-sized.
+    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit(flags)?;
+        Ok(Box::write(b, x))
+    }
+
+    /// Constructs a new `Box<T, A>` with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b = KBox::<u64>::new_uninit(GFP_KERNEL)?;
+    /// let b = KBox::write(b, 24);
+    ///
+    /// assert_eq!(*b, 24_u64);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
+        let ptr = if Self::is_zst() {
+            Unique::dangling()
+        } else {
+            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
+            let ptr = A::alloc(layout, flags)?;
+
+            ptr.cast().into()
+        };
+
+        Ok(Box(ptr, PhantomData::<A>))
+    }
+
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
+    /// pinned in memory and unable to be moved.
+    #[inline]
+    pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
+    where
+        A: 'static,
+    {
+        Ok(Self::new(x, flags)?.into())
+    }
+}
+
+impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
+where
+    T: ?Sized,
+    A: Allocator,
+    A: 'static,
+{
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
+    /// `*boxed` will be pinned in memory and unable to be moved.
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// This is also available via [`Box::into_pin`].
+    ///
+    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::from([Box::new]\(x))</code>
+    /// can also be written more concisely using <code>[Box::pin]\(x)</code>.
+    /// This `From` implementation is useful if you already have a `Box<T>`, or you are
+    /// constructing a (pinned) `Box` in a different way than with [`Box::new`].
+    fn from(b: Box<T, A>) -> Self {
+        Box::into_pin(b)
+    }
+}
+
+impl<T, A> Deref for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_ref() }
+    }
+}
+
+impl<T, A> DerefMut for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn deref_mut(&mut self) -> &mut T {
+        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        unsafe { self.0.as_mut() }
+    }
+}
+
+impl<T, A> fmt::Debug for Box<T, A>
+where
+    T: ?Sized + fmt::Debug,
+    A: Allocator,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Drop for Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        let ptr = self.0.as_ptr();
+
+        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
+        unsafe { core::ptr::drop_in_place(ptr) };
+
+        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        if unsafe { core::mem::size_of_val(&*ptr) } != 0 {
+            // SAFETY: `ptr` was previously allocated with `A`.
+            unsafe { A::free(self.0.as_non_null().cast()) };
+        }
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633e73..b34c8127b76d 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -1183,6 +1183,36 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
+impl<T> InPlaceInit<T> for KBox<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = KBox::<_>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = KBox::<_>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     #[inline]
     fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..39f9331a48e2 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
+pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9cd20fe41c20..dd602b2efd90 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@
 
 //! Kernel types.
 
+use crate::alloc::Allocator;
 use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
@@ -89,6 +90,31 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
     }
 }
 
+impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        crate::alloc::Box::into_raw(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { crate::alloc::Box::from_raw(ptr as _) }
+    }
+}
+
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-- 
2.45.2


