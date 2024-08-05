Return-Path: <linux-kernel+bounces-274878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75A947DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A03B24470
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3E156C74;
	Mon,  5 Aug 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge0Xaxvi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D45156F36;
	Mon,  5 Aug 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871264; cv=none; b=u6/1WgpLn3Z+uhR7wW2hMQtCOpVuP6myh2VK+oMlkuGfv8a4ss6+faBmUwl4rHeVQusUOte6u15xJJQJ0BYiqFu3cKsJOvwIaYheToszFmnQtMbYVm8GSBnjugE96Mx+W9kzrjChguxOFy5AuEnO+2sg/eIETrBddRSEQQs10f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871264; c=relaxed/simple;
	bh=3qegzxF0CAqZElJOf/fc4vi4CYGZNhd1qrq8DwG4IkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knHOAVG5G9aDBOgSHgRMTEvq7kfTVuciC/0o/DcSpFVkpKeGoq3I1i18J0dnYsYe4QKZCgt6oImO1b/wq+ZYjRTkwwSxTroG/GEokRGZCU10F8t7+tSV22yJjE9Qsz242ojGlwDueU8WnGK/f0Ob+twC1xrhqmPo9lvhh5xlnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge0Xaxvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F7C4AF0E;
	Mon,  5 Aug 2024 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871263;
	bh=3qegzxF0CAqZElJOf/fc4vi4CYGZNhd1qrq8DwG4IkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ge0Xaxvikgpg6uiVTL9CSOEiG0ZMde5q5iorlV3mzzxtuB9522yCoHvEra9TMh/la
	 i8InoGWDWVn2GqE5XkTEJk1g9s3cimELmk6kxrJ8JsfCTy2JerBeH1aQAIWoVLAqKY
	 cj/13OE5hWdx/D7RDfa1t3m5N1w5efVQl8//szQZ6p4XpORhTzZB3vTSIQKR4kTX0s
	 IXxjKV5jzUr3qWtDu5pibl0djk6NIDJZ3uinepRykeeaMX0cn1WVAegsNQAhJCYnYG
	 vT6w/pPWtPrTUCdm0gBLYBeCX+5C/JZUPmtJHb1YFE8jHacqc01fV6WEoxqButYT50
	 UCtNC59Ebnz3A==
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
Subject: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Date: Mon,  5 Aug 2024 17:19:28 +0200
Message-ID: <20240805152004.5039-10-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
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
 rust/kernel/init.rs       |  35 +++-
 rust/kernel/prelude.rs    |   2 +-
 rust/kernel/types.rs      |  56 +++++++
 5 files changed, 427 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/kbox.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 942e2755f217..d7beaf0372af 100644
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
index 000000000000..4a4379980745
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
+use core::result::Result;
+
+use crate::types::Unique;
+
+/// The kernel's [`Box`] type.
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
+/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
+///
+/// assert_eq!(*b, 24_u64);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ```
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
+    pub const unsafe fn from_raw(raw: *mut T) -> Self {
+        // SAFETY: Validity of `raw` is guaranteed by the safety preconditions of this function.
+        Self(unsafe { Unique::new_unchecked(raw) }, PhantomData::<A>)
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
+    pub fn into_raw(b: Self) -> *mut T {
+        let b = ManuallyDrop::new(b);
+
+        b.0.as_ptr()
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
+    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`.
+    #[inline]
+    pub fn into_pin(b: Self) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        // SAFETY: It's not possible to move or replace the insides of a `Pin<Box<T, A>>` when
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
+    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
+        let raw = Self::into_raw(b);
+        // SAFETY: Reconstruct the `Box<MaybeUninit<T>, A>` as Box<T, A> now that has been
+        // initialized. `raw` and `alloc` are safe by the invariants of `Box`.
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
+        let ptr = Box::into_raw(this);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { core::ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
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
+        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
+        // instance of `T`.
+        let size = unsafe { core::mem::size_of_val(&*ptr) };
+
+        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
+        unsafe { core::ptr::drop_in_place(ptr) };
+
+        if size != 0 {
+            // SAFETY: `ptr` was previously allocated with `A`.
+            unsafe { A::free(self.0.as_non_null().cast()) };
+        }
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 495c09ebe3a3..5fd7a0ffabd2 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Allocator, Flags},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -1178,6 +1178,39 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
+impl<T, A> InPlaceInit<T> for crate::alloc::Box<T, A>
+where
+    A: Allocator + 'static,
+{
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { crate::alloc::Box::assume_init(this) }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
+        let slot = this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { crate::alloc::Box::assume_init(this) })
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
index 7cf89067b5fc..9fe87528d129 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@
 
 //! Kernel types.
 
+use crate::alloc::Allocator;
 use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
@@ -9,6 +10,7 @@
     marker::{PhantomData, PhantomPinned},
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
+    pin::Pin,
     ptr::NonNull,
 };
 
@@ -89,6 +91,60 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
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
+impl<T: 'static, A> ForeignOwnable for Pin<crate::alloc::Box<T, A>>
+where
+    A: Allocator,
+{
+    type Borrowed<'a> = Pin<&'a T>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        // SAFETY: We are still treating the box as pinned.
+        crate::alloc::Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
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
+        unsafe { Pin::new_unchecked(crate::alloc::Box::from_raw(ptr as _)) }
+    }
+}
+
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-- 
2.45.2


