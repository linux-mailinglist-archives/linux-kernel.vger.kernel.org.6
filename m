Return-Path: <linux-kernel+bounces-288748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19394953E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC051C2012B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D5B1E519;
	Fri, 16 Aug 2024 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzXXO1iQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73771DFCF;
	Fri, 16 Aug 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767214; cv=none; b=MERqI5tFPVQfkG//ANvNNtfFcKAEmI5ei7L3TzglBt1U4IJw45BnIBOaUr80ugNeyJJJROxIxSAv98hEgmqeCVeqpNl8WJlVHODYDy9kh9tKvEP6DDODPt5DkQ4ETlLy7agrS1418H2ZmBx2KBU6Tzu3fxcpJza6hadh+5SE4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767214; c=relaxed/simple;
	bh=J0k0A1d0DfZcl7vq8Plu0pAdB0VKQLkiHCwAo9u7XJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQK4UywpGzVmc/weRu4dkqskOrkoDO1U9TP+19C776ayGnyI1M1WmsogORd79g8ZRUTw8PnC3Urj8hb+tmCD0r0yRC9LhUUKrf844qid3eIeJRgplTNhMALyk7OOdMz2x0Yaia1sGL9PsskLrh+Q54NUUfUghdvJRaRkAyrog9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzXXO1iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57829C4AF12;
	Fri, 16 Aug 2024 00:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767214;
	bh=J0k0A1d0DfZcl7vq8Plu0pAdB0VKQLkiHCwAo9u7XJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzXXO1iQyjRZm+jA/2haO1aUE5kI3F856bfUQDO+kkgkAqlZgKaug06bOd+2cpF13
	 VsBntvFUJBOVSCEYX7P5Bj3qvUFKy/H2eGU2cYvLOgrxQ4AO4jFCCfNXzlg5FhGlju
	 G9j2TYOtIWjYeKxLNiDBrt3mIFC2LLxb4YkREQTDvQG2p7r7jkhQRjrOniB7i5VWd+
	 /PgK2q9P2TRN+PLBKl4MujhloLpz4QSPxX5g+8qCkqLLFBNojchojHNflWQ+tHQfaC
	 yu3jMHscpHzzamF+CAtPhHJ3G/WFDQco6MfvXT/dJ5LKyIpFORFNxsGdh8qATdQgVY
	 2qlT7lwH6lcWQ==
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
Subject: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Date: Fri, 16 Aug 2024 02:10:55 +0200
Message-ID: <20240816001216.26575-14-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`Vec` provides a contiguous growable array type (such as `Vec`) with
contents allocated with the kernel's allocators (e.g. `Kmalloc`,
`Vmalloc` or `KVmalloc`).

In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
kernel's GFP flags for all appropriate functions, always reports
allocation failures through `Result<_, AllocError>` and remains
independent from unstable features.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs      |   6 +
 rust/kernel/alloc/kvec.rs | 629 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs    |   2 +-
 3 files changed, 636 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/alloc/kvec.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index d248390345ec..e88c7e10ee9b 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod kbox;
+pub mod kvec;
 pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
@@ -18,6 +19,11 @@
 pub use self::kbox::KVBox;
 pub use self::kbox::VBox;
 
+pub use self::kvec::KVVec;
+pub use self::kvec::KVec;
+pub use self::kvec::VVec;
+pub use self::kvec::Vec;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
new file mode 100644
index 000000000000..89afc0f25bd4
--- /dev/null
+++ b/rust/kernel/alloc/kvec.rs
@@ -0,0 +1,629 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`Vec`].
+
+use super::{AllocError, Allocator, Box, Flags};
+use core::{
+    fmt,
+    marker::PhantomData,
+    mem::{ManuallyDrop, MaybeUninit},
+    ops::Deref,
+    ops::DerefMut,
+    ops::Index,
+    ops::IndexMut,
+    ptr::NonNull,
+    slice,
+    slice::SliceIndex,
+};
+
+/// Create a [`Vec`] containing the arguments.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = kernel::kvec![];
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(v, [1]);
+///
+/// let mut v = kernel::kvec![1; 3]?;
+/// v.push(4, GFP_KERNEL)?;
+/// assert_eq!(v, [1, 1, 1, 4]);
+///
+/// let mut v = kernel::kvec![1, 2, 3]?;
+/// v.push(4, GFP_KERNEL)?;
+/// assert_eq!(v, [1, 2, 3, 4]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[macro_export]
+macro_rules! kvec {
+    () => (
+        {
+            $crate::alloc::KVec::new()
+        }
+    );
+    ($elem:expr; $n:expr) => (
+        {
+            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
+        }
+    );
+    ($($x:expr),+ $(,)?) => (
+        {
+            match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
+                Ok(b) => Ok($crate::alloc::KVec::from($crate::alloc::KBox::write(b, [$($x),+]))),
+                Err(e) => Err(e),
+            }
+        }
+    );
+}
+
+/// The kernel's [`Vec`] type.
+///
+/// A contiguous growable array type with contents allocated with the kernel's allocators (e.g.
+/// `Kmalloc`, `Vmalloc` or `KVmalloc`), written `Vec<T, A>`.
+///
+/// For non-zero-sized values, a [`Vec`] will use the given allocator `A` for its allocation. For
+/// the most common allocators the type aliases `KVec`, `VVec` and `KVVec` exist.
+///
+/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::<T>`; no memory is allocated.
+///
+/// Generally, [`Vec`] consists of a pointer that represents the vector's backing buffer, the
+/// capacity of the vector (the number of elements that currently fit into the vector), it's length
+/// (the number of elements that are currently stored in the vector) and the `Allocator` type used
+/// to allocate (and free) the backing buffer.
+///
+/// A [`Vec`] can be deconstructed into and (re-)constructed from it's previously named raw parts
+/// and manually modified.
+///
+/// [`Vec`]'s backing buffer gets, if required, automatically increased (re-allocated) when elements
+/// are added to the vector.
+///
+/// # Invariants
+///
+/// The [`Vec`] backing buffer's pointer is always properly aligned and either points to memory
+/// allocated with `A` or, for zero-sized types, is a dangling pointer.
+///
+/// The length of the vector always represents the exact number of elements stored in the vector.
+///
+/// The capacity of the vector always represents the absolute number of elements that can be stored
+/// within the vector without re-allocation. However, it is legal for the backing buffer to be
+/// larger than `size_of<T>` times the capacity.
+///
+/// The `Allocator` type `A` of the vector is the exact same `Allocator` type the backing buffer was
+/// allocated with (and must be freed with).
+pub struct Vec<T, A: Allocator> {
+    ptr: NonNull<T>,
+    /// Represents the actual buffer size as `cap` times `size_of::<T>` bytes.
+    ///
+    /// Note: This isn't quite the same as `Self::capacity`, which in contrast returns the number of
+    /// elements we can still store without reallocating.
+    ///
+    /// # Invariants
+    ///
+    /// `cap` must be in the `0..=isize::MAX` range.
+    cap: usize,
+    len: usize,
+    _p: PhantomData<A>,
+}
+
+/// Type alias for `Vec` with a `Kmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = KVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVec<T> = Vec<T, super::allocator::Kmalloc>;
+
+/// Type alias for `Vec` with a `Vmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = VVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type VVec<T> = Vec<T, super::allocator::Vmalloc>;
+
+/// Type alias for `Vec` with a `KVmalloc` allocator.
+///
+/// # Examples
+///
+/// ```
+/// let mut v = KVVec::new();
+/// v.push(1, GFP_KERNEL)?;
+/// assert_eq!(&v, &[1]);
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub type KVVec<T> = Vec<T, super::allocator::KVmalloc>;
+
+// SAFETY: `Vec` is `Send` if `T` is `Send` because `Vec` owns its elements.
+unsafe impl<T, A> Send for Vec<T, A>
+where
+    T: Send,
+    A: Allocator,
+{
+}
+
+// SAFETY: `Vec` is `Sync` if `T` is `Sync` because `Vec` owns its elements.
+unsafe impl<T, A> Sync for Vec<T, A>
+where
+    T: Sync,
+    A: Allocator,
+{
+}
+
+impl<T, A> Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn is_zst() -> bool {
+        core::mem::size_of::<T>() == 0
+    }
+
+    /// Returns the number of elements that can be stored within the vector without allocating
+    /// additional memory.
+    pub fn capacity(&self) -> usize {
+        if Self::is_zst() {
+            usize::MAX
+        } else {
+            self.cap
+        }
+    }
+
+    /// Returns the number of elements stored within the vector.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Forcefully sets `self.len` to `new_len`.
+    ///
+    /// # Safety
+    ///
+    /// - `new_len` must be less than or equal to [`Self::capacity`].
+    /// - If `new_len` is greater than `self.len`, all elements within the interval
+    ///   [`self.len`,`new_len`] must be initialized.
+    #[inline]
+    pub unsafe fn set_len(&mut self, new_len: usize) {
+        self.len = new_len;
+    }
+
+    /// Returns a slice of the entire vector.
+    ///
+    /// Equivalent to `&s[..]`.
+    #[inline]
+    pub fn as_slice(&self) -> &[T] {
+        self
+    }
+
+    /// Returns a mutable slice of the entire vector.
+    ///
+    /// Equivalent to `&mut s[..]`.
+    #[inline]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        self
+    }
+
+    /// Returns a mutable raw pointer to the vector's backing buffer, or, if `T` is a ZST, a
+    /// dangling raw pointer.
+    #[inline]
+    pub fn as_mut_ptr(&self) -> *mut T {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns a raw pointer to the vector's backing buffer, or, if `T` is a ZST, a dangling raw
+    /// pointer.
+    #[inline]
+    pub fn as_ptr(&self) -> *const T {
+        self.as_mut_ptr()
+    }
+
+    /// Returns `true` if the vector contains no elements, `false` otherwise.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push(1, GFP_KERNEL);
+    /// assert!(!v.is_empty());
+    /// ```
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Creates a new, empty Vec<T, A>.
+    ///
+    /// This method does not allocate by itself.
+    #[inline]
+    pub const fn new() -> Self {
+        Self {
+            ptr: NonNull::dangling(),
+            cap: 0,
+            len: 0,
+            _p: PhantomData::<A>,
+        }
+    }
+
+    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the vector.
+    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
+        // and valid, but uninitialized.
+        unsafe {
+            slice::from_raw_parts_mut(
+                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
+                self.capacity() - self.len,
+            )
+        }
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 2]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
+        Vec::reserve(self, 1, flags)?;
+        let s = self.spare_capacity_mut();
+        s[0].write(v);
+
+        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
+        // by 1. We also know that the new length is <= capacity because of the previous call to
+        // `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
+        Ok(())
+    }
+
+    /// Creates a new [`Vec`] instance with at least the given capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
+    ///
+    /// assert!(v.capacity() >= 20);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
+        let mut v = Vec::new();
+
+        Self::reserve(&mut v, capacity, flags)?;
+
+        Ok(v)
+    }
+
+    /// Pushes clones of the elements of slice into the [`Vec`] instance.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40]);
+    ///
+    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
+    where
+        T: Clone,
+    {
+        self.reserve(other.len(), flags)?;
+        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
+            slot.write(item.clone());
+        }
+
+        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
+        // the length by the same amount. We also know that the new length is <= capacity because
+        // of the previous call to `reserve` above.
+        unsafe { self.set_len(self.len() + other.len()) };
+        Ok(())
+    }
+
+    /// Creates a Vec<T, A> from a pointer, a length and a capacity using the allocator `A`.
+    ///
+    /// # Safety
+    ///
+    /// If `T` is a ZST:
+    ///
+    /// - `ptr` must be a dangling pointer.
+    /// - `capacity` must be zero.
+    /// - `length` must be smaller than or equal to `usize::MAX`.
+    ///
+    /// Otherwise:
+    ///
+    /// - `ptr` must have been allocated with the allocator `A`.
+    /// - `ptr` must satisfy or exceed the alignment requirements of `T`.
+    /// - `ptr` must point to memory with a size of at least `size_of::<T>` times the `capacity`
+    ///    bytes.
+    /// - The allocated size in bytes must not be larger than `isize::MAX`.
+    /// - `length` must be less than or equal to `capacity`.
+    /// - The first `length` elements must be initialized values of type `T`.
+    ///
+    /// It is also valid to create an empty `Vec` passing a dangling pointer for `ptr` and zero for
+    /// `cap` and `len`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = kernel::kvec![1, 2, 3]?;
+    /// v.reserve(1, GFP_KERNEL)?;
+    ///
+    /// let (mut ptr, mut len, cap) = v.into_raw_parts();
+    ///
+    /// // SAFETY: We've just reserved memory for another element.
+    /// unsafe { ptr.add(len).write(4) };
+    /// len += 1;
+    ///
+    /// // SAFETY: We only wrote an additional element at the end of the `KVec`'s buffer and
+    /// // correspondingly increased the length of the `KVec` by one. Otherwise, we construct it
+    /// // from the exact same raw parts.
+    /// let v = unsafe { KVec::from_raw_parts(ptr, len, cap) };
+    ///
+    /// assert_eq!(v, [1, 2, 3, 4]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
+        let cap = if Self::is_zst() { 0 } else { capacity };
+
+        Self {
+            // SAFETY: By the safety requirements, `ptr` is either dangling or pointing to a valid
+            // memory allocation, allocated with `A`.
+            ptr: unsafe { NonNull::new_unchecked(ptr) },
+            cap,
+            len: length,
+            _p: PhantomData::<A>,
+        }
+    }
+
+    /// Consumes the `Vec<T, A>` and returns its raw components `pointer`, `length` and `capacity`.
+    ///
+    /// This will not run the destructor of the contained elements and for non-ZSTs the allocation
+    /// will stay alive indefinitely. Use [`Vec::from_raw_parts`] to recover the [`Vec`], drop the
+    /// elements and free the allocation, if any.
+    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
+        let me = ManuallyDrop::new(self);
+        let len = me.len();
+        let capacity = me.capacity();
+        let ptr = me.as_mut_ptr();
+        (ptr, len, capacity)
+    }
+
+    /// Ensures that the capacity exceeds the length by at least `additional`
+    /// elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let cap = v.capacity();
+    /// assert!(cap >= 10);
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let new_cap = v.capacity();
+    /// assert_eq!(new_cap, cap);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let len = self.len();
+        let cap = self.capacity();
+
+        if cap - len >= additional {
+            return Ok(());
+        }
+
+        if Self::is_zst() {
+            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
+            return Err(AllocError);
+        }
+
+        // We know `cap` is <= `isize::MAX` because of it's type invariant. So the multiplication by
+        // two won't overflow.
+        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
+        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+
+        // We need to make sure that `ptr` is either NULL or comes from a previous call to
+        // `realloc_flags`. A `Vec<T, A>`'s `ptr` value is not guaranteed to be NULL and might be
+        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T, A>`'s
+        // capacity to be zero if no memory has been allocated yet.
+        let ptr = if cap == 0 {
+            None
+        } else {
+            Some(self.ptr.cast())
+        };
+
+        // SAFETY: `ptr` is valid because it's either `None` or comes from a previous call to
+        // `A::realloc`. We also verified that the type is not a ZST.
+        let ptr = unsafe { A::realloc(ptr, layout, flags)? };
+
+        self.ptr = ptr.cast();
+
+        // INVARIANT: `Layout::array` fails if the resulting byte size is greater than `isize::MAX`.
+        self.cap = new_cap;
+
+        Ok(())
+    }
+}
+
+impl<T: Clone, A: Allocator> Vec<T, A> {
+    /// Extend the vector by `n` clones of value.
+    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
+        if n == 0 {
+            return Ok(());
+        }
+
+        self.reserve(n, flags)?;
+
+        let spare = self.spare_capacity_mut();
+
+        for item in spare.iter_mut().take(n - 1) {
+            item.write(value.clone());
+        }
+
+        // We can write the last element directly without cloning needlessly.
+        spare[n - 1].write(value);
+
+        // SAFETY: `self.reserve` not bailing out with an error guarantees that we're not
+        // exceeding the capacity of this `Vec`.
+        unsafe { self.set_len(self.len() + n) };
+
+        Ok(())
+    }
+
+    /// Create a new `Vec<T, A> and extend it by `n` clones of `value`.
+    pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
+        let mut v = Self::with_capacity(n, flags)?;
+
+        v.extend_with(n, value, flags)?;
+
+        Ok(v)
+    }
+}
+
+impl<T, A> Drop for Vec<T, A>
+where
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        // SAFETY: We need to drop the vector's elements in place, before we free the backing
+        // memory.
+        unsafe {
+            core::ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut(
+                self.as_mut_ptr(),
+                self.len,
+            ))
+        };
+
+        // If `cap == 0` we never allocated any memory in the first place.
+        if self.cap != 0 {
+            // SAFETY: `self.ptr` was previously allocated with `A`.
+            unsafe { A::free(self.ptr.cast()) };
+        }
+    }
+}
+
+impl<T, A, const N: usize> From<Box<[T; N], A>> for Vec<T, A>
+where
+    A: Allocator,
+{
+    fn from(b: Box<[T; N], A>) -> Vec<T, A> {
+        let len = b.len();
+        let ptr = Box::into_raw(b);
+
+        unsafe { Vec::from_raw_parts(ptr as _, len, len) }
+    }
+}
+
+impl<T> Default for KVec<T> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+impl<T, A> Deref for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &[T] {
+        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
+        // initialized elements of type `T`.
+        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
+    }
+}
+
+impl<T, A> DerefMut for Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn deref_mut(&mut self) -> &mut [T] {
+        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
+        // initialized elements of type `T`.
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
+    }
+}
+
+impl<T: Eq, A> Eq for Vec<T, A> where A: Allocator {}
+
+impl<T, I: SliceIndex<[T]>, A> Index<I> for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Output = I::Output;
+
+    #[inline]
+    fn index(&self, index: I) -> &Self::Output {
+        Index::index(&**self, index)
+    }
+}
+
+impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for Vec<T, A>
+where
+    A: Allocator,
+{
+    #[inline]
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+macro_rules! __impl_slice_eq {
+    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?) => {
+        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
+        where
+            T: PartialEq<U>,
+            $($ty: $bound)?
+        {
+            #[inline]
+            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
+        }
+    }
+}
+
+__impl_slice_eq! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2> }
+__impl_slice_eq! { [A: Allocator] Vec<T, A>, &[U] }
+__impl_slice_eq! { [A: Allocator] Vec<T, A>, &mut [U] }
+__impl_slice_eq! { [A: Allocator] &[T], Vec<U, A> }
+__impl_slice_eq! { [A: Allocator] &mut [T], Vec<U, A> }
+__impl_slice_eq! { [A: Allocator] Vec<T, A>, [U] }
+__impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
+__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
+__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index d5f2fe42d093..80223cdaa485 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
 
 #[doc(no_inline)]
 pub use alloc::vec::Vec;
-- 
2.46.0


