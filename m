Return-Path: <linux-kernel+bounces-283593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D5694F6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DD01C21A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5861991B0;
	Mon, 12 Aug 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiNDPl/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587941990D3;
	Mon, 12 Aug 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487097; cv=none; b=OTJVXTq2UGYCXtQLO1H7+4IWTBp98hRn3z6XNt0po3i4F5lWJyB+yw+ChId4eN5+CobxJiqRypajryAqDwcc71o9zydJTjnDd0gEW17+rOc/x2lWnAyNPkgoGLd8ZuuOexA0j/Z2UuYcXR+qaTQW3FKuDNzLxjhmIR4pLVkR6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487097; c=relaxed/simple;
	bh=h2D2etA1eZNDRwBqJ9/ejeC1ErIkz2eqBdYlpphzKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMKz3kbvcCglzLlKN9v09AfZyRwP2/tzM2jOwMJOQhd1jItwcmZKln8SMRlYiEkSkO7+oT+OuTf+K4kuiUSVui+a5oWCsHvWKSzdbHRdCQqF9qFdY0q6jNqsf1Z+AugMLNL7ZLXrK0yO5kAhUHIjqjqaXd91D7mVQkGWTYXo3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiNDPl/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BC5C4AF0C;
	Mon, 12 Aug 2024 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487096;
	bh=h2D2etA1eZNDRwBqJ9/ejeC1ErIkz2eqBdYlpphzKNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NiNDPl/BH7gnS+WaQDWmkoUYMZGIY11LwdqswyAFjBtp7nWvam6Qad7zM3WvALbLw
	 Z9Q0Dy+5BO7YvTLFc5wX25MSJV0vrpfVTN1d1GcNc249YnQcaLQDlZpjm/6+hyosgp
	 i/VLiHir3nj/f337rNNFEbuWeURVLXTKIDrv26iubos8SlG+am3grIqvw2rioGrOwd
	 6fmW1vh1dj+KRTGlkGlWV1er8GTI2zt52QeYvAOORZUopb21d4Hg7Wkw+rUMrnOje8
	 5m/QjV5qeBJ9Y7fFGHbKGrosFBHWwiRwenV5ckmAI9W9zSz9/FBccNnnbsf4CSgveT
	 WLkX1y9hJRNrw==
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
Subject: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Date: Mon, 12 Aug 2024 20:22:55 +0200
Message-ID: <20240812182355.11641-10-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 rust/kernel/alloc/kbox.rs | 423 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs    |   2 +-
 3 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/alloc/kbox.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 295107777a12..ed46b69204d0 100644
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
index 000000000000..67bdfc0712d2
--- /dev/null
+++ b/rust/kernel/alloc/kbox.rs
@@ -0,0 +1,423 @@
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
+use core::ptr::NonNull;
+use core::result::Result;
+
+use crate::init::{InPlaceInit, Init, PinInit};
+use crate::types::ForeignOwnable;
+
+/// The kernel's [`Box`] type - a heap allocation for a single value of type `T`.
+///
+/// This is the kernel's version of the Rust stdlib's `Box`. There are a couple of differences,
+/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
+/// supported.
+///
+/// `Box` works with any of the kernel's allocators, e.g. [`super::allocator::Kmalloc`],
+/// [`super::allocator::Vmalloc`] or [`super::allocator::KVmalloc`]. There are aliases for `Box`
+/// with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
+///
+/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+///
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+///
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
+/// ```
+///
+/// # Invariants
+///
+/// The [`Box`]' pointer always properly aligned and either points to memory allocated with `A` or,
+/// for zero-sized types, is a dangling pointer.
+pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
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
+// SAFETY: `Box` is `Send` if `T` is `Send` because the data referenced by `self.0` is unaliased.
+unsafe impl<T, A> Send for Box<T, A>
+where
+    T: Send + ?Sized,
+    A: Allocator,
+{
+}
+
+// SAFETY: `Box` is `Sync` if `T` is `Sync` because the data referenced by `self.0` is unaliased.
+unsafe impl<T, A> Sync for Box<T, A>
+where
+    T: Send + ?Sized,
+    A: Allocator,
+{
+}
+
+impl<T, A> Box<T, A>
+where
+    T: ?Sized,
+    A: Allocator,
+{
+    /// Creates a new `Box<T, A>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `raw` must point to valid memory, previously be allocated with `A`, and provide at least
+    /// the size of type `T`. For ZSTs `raw` must be a dangling pointer.
+    #[inline]
+    pub const unsafe fn from_raw(raw: *mut T) -> Self {
+        // INVARIANT: Validity of `raw` is guaranteed by the safety preconditions of this function.
+        // SAFETY: By the safety preconditions of this function, `raw` is not a NULL pointer.
+        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
+    }
+
+    /// Consumes the `Box<T, A>` and returns a raw pointer.
+    ///
+    /// This will not run the destructor of `T` and for non-ZSTs the allocation will stay alive
+    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop the value and free the
+    /// allocation, if any.
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
+    pub fn into_raw(b: Self) -> *mut T {
+        let b = ManuallyDrop::new(b);
+
+        b.0.as_ptr()
+    }
+
+    /// Consumes and leaks the `Box<T, A>` and returns a mutable reference.
+    ///
+    /// See [Box::into_raw] for more details.
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
+    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then
+    /// `*b` will be pinned in memory and can't be moved.
+    ///
+    /// This moves `b` into `Pin` without moving `*b` or allocating and copying any memory.
+    #[inline]
+    pub fn into_pin(b: Self) -> Pin<Self> {
+        // SAFETY: The value wrapped inside a `Pin<Box<T, A>>` cannot be moved or replaced as long
+        // as `T` does not implement `Unpin`.
+        unsafe { Pin::new_unchecked(b) }
+    }
+}
+
+impl<T, A> Box<MaybeUninit<T>, A>
+where
+    A: Allocator,
+{
+    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the value inside of `b` is in an initialized state. It is
+    /// undefined behavior to call this function while the value inside of `b` is not yet fully
+    /// initialized.
+    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
+        let raw = Self::into_raw(b);
+
+        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
+        // of this function, the value inside the `Box` is in an initialized state. Hence, it is
+        // safe to reconstruct the `Box` as `Box<T, A>`.
+        unsafe { Box::from_raw(raw as *mut T) }
+    }
+
+    /// Writes the value and converts to `Box<T, A>`.
+    pub fn write(mut b: Self, value: T) -> Box<T, A> {
+        (*b).write(value);
+        // SAFETY: We've just initialized `boxed`'s value.
+        unsafe { Self::assume_init(b) }
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
+    /// Creates a new `Box<T, A>` and initializes its contents with `x`.
+    ///
+    /// New memory is allocated with `a`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
+    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit(flags)?;
+        Ok(Box::write(b, x))
+    }
+
+    /// Creates a new `Box<T, A>` with uninitialized contents.
+    ///
+    /// New memory is allocated with `a`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
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
+            NonNull::dangling()
+        } else {
+            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
+            let ptr = A::alloc(layout, flags)?;
+
+            ptr.cast()
+        };
+
+        Ok(Box(ptr, PhantomData::<A>))
+    }
+
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
+    /// pinned in memory and can't be moved.
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
+{
+    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then
+    /// `*b` will be pinned in memory and can't be moved.
+    ///
+    /// See [`Box::into_pin`] for more details.
+    fn from(b: Box<T, A>) -> Self {
+        Box::into_pin(b)
+    }
+}
+
+impl<T, A> InPlaceInit<T> for Box<T, A>
+where
+    A: Allocator + 'static,
+{
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = Box::<_, A>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(this) }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = Box::<_, A>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(this) })
+    }
+}
+
+impl<T: 'static, A> ForeignOwnable for Box<T, A>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        Box::into_raw(self) as _
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
+        unsafe { Box::from_raw(ptr as _) }
+    }
+}
+
+impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = Pin<&'a T>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        // SAFETY: We are still treating the box as pinned.
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        let r = unsafe { &*ptr.cast() };
+
+        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
+        unsafe { Pin::new_unchecked(r) }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
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
+        let size = core::mem::size_of_val::<T>(self);
+
+        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
+        unsafe { core::ptr::drop_in_place(self.0.as_ptr()) };
+
+        if size != 0 {
+            // SAFETY: `ptr` was previously allocated with `A`.
+            unsafe { A::free(self.0.cast()) };
+        }
+    }
+}
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
-- 
2.45.2


