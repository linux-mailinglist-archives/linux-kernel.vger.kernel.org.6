Return-Path: <linux-kernel+bounces-325714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68628975D74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575BCB22441
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C11BD514;
	Wed, 11 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUiJEiIQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DD1BC070;
	Wed, 11 Sep 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095349; cv=none; b=SXC1gsCW9TxOUCnFI0V87jQFrzqEjB/yVWHq66o3aRXtrDnXhPAbfSxvZ++OUl1SdJXT+T26V8EnpVm5IJ5sWc4QFBdYG+TwSY1WCw1mjlb66G6fxhc22T7umiHHoZjeUW8apxR+OH8jjfZgHtvQctHLxLHht386onhmYZczE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095349; c=relaxed/simple;
	bh=ONKVPueTm7R2PEVvV8+tCD9cNcEk3jCly02IRQlQKQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSBuR39qXb0sCjZqZkkMHnIHftTnHByi+2ES5DzPyFwa8/hGnS+htQzw9ZK7MwGaaP22xq0Yiu05j3tzZ4khK5/+OovInBA20PqQhBCS4FuA8WmE81sUpaGWRWV+qarEa4PsTi9c+dcUeuynYP9ywlxylrBWfTaO8Ak2xVLrD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUiJEiIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C2EC4CECF;
	Wed, 11 Sep 2024 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095348;
	bh=ONKVPueTm7R2PEVvV8+tCD9cNcEk3jCly02IRQlQKQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUiJEiIQGC8VjeuVStZGt08/gecMgGbA6/Fo846oN4XZsN1GacSC0O/e2hdwKqY4I
	 V/cQVDeymgAllj1Ey5mMJHQl1F/GC7GV5Yt6Q1WeU4iNzkMzP+exjY7BAlreNrqbUd
	 MWGJRxchhyh+qHR5c1CfTeuEUPL7RisF07YbyWGuaf8Ts0N+wzLm6Elp7VP/BNdyxf
	 VykicW0iKU8O1umLdSKlIc8xTXa3wMnlJcDo37urOPv/YBpi5lcq0oyK5wK6Jca5Sj
	 MiWZz7aL5NKXkn6LUXRrA2xKpGHMG3t/s9RmYdje9xUVzoo3EomMT39Xfa064Lmy0K
	 CcQPMS1RGnEUQ==
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
Subject: [PATCH v7 09/26] rust: alloc: implement kernel `Box`
Date: Thu, 12 Sep 2024 00:52:45 +0200
Message-ID: <20240911225449.152928-10-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
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
 rust/kernel/alloc/kbox.rs | 465 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs    |   2 +-
 3 files changed, 472 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/alloc/kbox.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 7a405d6f3034..b1f28334b27a 100644
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
index 000000000000..6188494f040d
--- /dev/null
+++ b/rust/kernel/alloc/kbox.rs
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Box`].
+
+#[allow(unused_imports)] // Used in doc comments.
+use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
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
+use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
+use crate::types::ForeignOwnable;
+
+/// The kernel's [`Box`] type -- a heap allocation for a single value of type `T`.
+///
+/// This is the kernel's version of the Rust stdlib's `Box`. There are several of differences,
+/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
+/// supported. There are also several API differences, e.g. `Box` always requires an [`Allocator`]
+/// implementation to be passed as generic, page [`Flags`] when allocating memory and all functions
+/// that may allocate memory are fallible.
+///
+/// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`].
+/// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
+///
+/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
+/// ```
+///
+/// ```
+/// # use kernel::bindings;
+/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
+/// struct Huge([u8; SIZE]);
+///
+/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
+/// ```
+///
+/// # Invariants
+///
+/// `self.0` is always properly aligned and either points to memory allocated with `A` or, for
+/// zero-sized types, is a dangling, well aligned pointer.
+#[repr(transparent)]
+pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
+
+/// Type alias for [`Box`] with a [`Kmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
+
+/// Type alias for [`Box`] with a [`Vmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = VBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
+
+/// Type alias for [`Box`] with a [`KVmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
+
+// SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
+unsafe impl<T, A> Send for Box<T, A>
+where
+    T: Send + ?Sized,
+    A: Allocator,
+{
+}
+
+// SAFETY: `Box` is `Sync` if `T` is `Sync` because the `Box` owns a `T`.
+unsafe impl<T, A> Sync for Box<T, A>
+where
+    T: Sync + ?Sized,
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
+    /// For non-ZSTs, `raw` must point at an allocation allocated with `A`that is sufficiently
+    /// aligned for and holds a valid `T`. The caller passes ownership of the allocation to the
+    /// `Box`.
+    ///
+    /// For ZSTs, `raw` must be a dangling, well aligned pointer.
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
+    pub fn leak<'a>(b: Self) -> &'a mut T {
+        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
+        // which points to an initialized instance of `T`.
+        unsafe { &mut *Box::into_raw(b) }
+    }
+}
+
+impl<T, A> Box<MaybeUninit<T>, A>
+where
+    A: Allocator,
+{
+    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
+    ///
+    /// It is undefined behavior to call this function while the value inside of `b` is not yet
+    /// fully initialized.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the value inside of `b` is in an initialized state.
+    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
+        let raw = Self::into_raw(b);
+
+        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
+        // of this function, the value inside the `Box` is in an initialized state. Hence, it is
+        // safe to reconstruct the `Box` as `Box<T, A>`.
+        unsafe { Box::from_raw(raw.cast()) }
+    }
+
+    /// Writes the value and converts to `Box<T, A>`.
+    pub fn write(mut b: Self, value: T) -> Box<T, A> {
+        (*b).write(value);
+        // SAFETY: We've just initialized `b`'s value.
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
+    /// New memory is allocated with `A`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
+    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let b = Self::new_uninit(flags)?;
+        Ok(Box::write(b, x))
+    }
+
+    /// Creates a new `Box<T, A>` with uninitialized contents.
+    ///
+    /// New memory is allocated with `A`. The allocation may fail, in which case an error is
+    /// returned. For ZSTs no memory is allocated.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b = KBox::<u64>::new_uninit(GFP_KERNEL)?;
+    /// let b = KBox::write(b, 24);
+    ///
+    /// assert_eq!(*b, 24_u64);
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
+        // INVARIANT: `ptr` is either a dangling pointer or points to memory allocated with `A`,
+        // which is sufficient in size and alignment for storing a `T`.
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
+
+    /// Forgets the contents (does not run the destructor), but keeps the allocation.
+    fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
+        let ptr = Self::into_raw(this);
+
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
+    /// assert_eq!(*value, [0; 32]);
+    /// let value = KBox::drop_contents(value);
+    /// // Now we can re-use `value`:
+    /// let value = KBox::write(value, [1; 32]);
+    /// assert_eq!(*value, [1; 32]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
+        let ptr = this.0.as_ptr();
+
+        // SAFETY: `ptr` is valid, because it came from `this`. After this call we never access the
+        // value stored in `this` again.
+        unsafe { core::ptr::drop_in_place(ptr) };
+
+        Self::forget_contents(this)
+    }
+
+    /// Moves the `Box`' value out of the `Box` and consumes the `Box`.
+    pub fn into_inner(b: Self) -> T {
+        // SAFETY: By the type invariant `&*b` is valid for `read`.
+        let value = unsafe { core::ptr::read(&*b) };
+        let _ = Self::forget_contents(b);
+        value
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
+    /// This moves `b` into `Pin` without moving `*b` or allocating and copying any memory.
+    fn from(b: Box<T, A>) -> Self {
+        // SAFETY: The value wrapped inside a `Pin<Box<T, A>>` cannot be moved or replaced as long
+        // as `T` does not implement `Unpin`.
+        unsafe { Pin::new_unchecked(b) }
+    }
+}
+
+impl<T, A> InPlaceWrite<T> for Box<MaybeUninit<T>, A>
+where
+    A: Allocator + 'static,
+{
+    type Initialized = Box<T, A>;
+
+    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
+        let slot = self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(self) })
+    }
+
+    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
+        let slot = self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Box::assume_init(self) }.into())
+    }
+}
+
+impl<T, A> InPlaceInit<T> for Box<T, A>
+where
+    A: Allocator + 'static,
+{
+    type PinnedSelf = Pin<Self>;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        Box::<_, A>::new_uninit(flags)?.write_pin_init(init)
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Box::<_, A>::new_uninit(flags)?.write_init(init)
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
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Box::from_raw(ptr as _) }
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements of this method ensure that the object remains alive and
+        // immutable for the duration of 'a.
+        unsafe { &*ptr.cast() }
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
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
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
+        // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
+        unsafe { core::ptr::drop_in_place::<T>(self.deref_mut()) };
+
+        if size != 0 {
+            // SAFETY: As `size` is not zero, `self.0` was previously allocated with `A`.
+            unsafe { A::free(self.0.cast()) };
+        }
+    }
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 4571daec0961..a9210634a8c3 100644
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
2.46.0


