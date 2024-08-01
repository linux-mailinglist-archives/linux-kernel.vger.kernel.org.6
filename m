Return-Path: <linux-kernel+bounces-271505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C918B944F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495231F286A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF041AED4D;
	Thu,  1 Aug 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWCaZ4hj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946C19F48D;
	Thu,  1 Aug 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526079; cv=none; b=mLl6aAa1g+ybsiNf1sLEgEIIQEfoQYcSVQc21U9gi9DlUPz06hHQoxoDIBdcPdq9MqA+PV7ursp+3BOU2Dl2Ppdnflone4Pbym0D7oLobfgVbJCgpAQXM57C1g5NZnfv7IzcLJvXwSebTao3+T5I5HsyGWI1To4q8FC4BysNhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526079; c=relaxed/simple;
	bh=iz+2e6JgJth3KxOmfApRmGMtI9o1YiybDKeep3K6Wb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex95BeBxFFH15rsGtJKkwPKamaqhG35LU0gX189RY71yo/utMtDfEShfVEvrba+x1tpBJEO9jltucn8BgpZYlAoxTf5mHttPGTlOOxF6WZeCI7VFmQ3xNdFycyBlyPmi5feDZPBuOiK3yCZL+5FUT8beTBAEZWCy/qIChZvz9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWCaZ4hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1605AC32786;
	Thu,  1 Aug 2024 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526079;
	bh=iz+2e6JgJth3KxOmfApRmGMtI9o1YiybDKeep3K6Wb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWCaZ4hjFSFOwLsaPSwwBIF+8PstT65RlrhknzEDteRjk7qf7EQ+X8gA/AL4XLdek
	 D9c5RaaioBTYnglpFOzanc2iqRs9/oSmzP7kFIyI4BtUxz2tmI9Yhf8hOoT0kLWBYq
	 8GLoAQo9sOgkg7JguZYEMeq2jNqH9xCm7gPKm6dK9KSRSe2eTeXYbhiEgO1Nmj/QBP
	 0FsfltfqIl79UBbOHeektTdGTKXr6pkDomA3bRTLTkvdx3+7P2DVSv3wSUIU5E9z3/
	 gGuuQ6ZLvEyVYjPaX7txBKGWXWi986/ZZ/07+Ogxa5sfMFYAJCvc1XnXKzM1KyZFzS
	 ZGwBuF/hinDAA==
Date: Thu, 1 Aug 2024 17:27:51 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 15/25] rust: alloc: implement kernel `Vec` type
Message-ID: <Zqupdzgoqg5vqaA5@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-16-dakr@kernel.org>
 <CAH5fLghHwv7-4NviGUA4dtL4EA+Wi380mY4MxvyH=+5=guc-Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghHwv7-4NviGUA4dtL4EA+Wi380mY4MxvyH=+5=guc-Og@mail.gmail.com>

On Thu, Aug 01, 2024 at 05:05:41PM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:08 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > `Vec` provides a contiguous growable array type (such as `Vec`) with
> > contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> > `Vmalloc` or `KVmalloc`).
> >
> > In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs      |   6 +
> >  rust/kernel/alloc/kbox.rs |  16 +-
> >  rust/kernel/alloc/kvec.rs | 583 ++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/prelude.rs    |   2 +-
> >  4 files changed, 605 insertions(+), 2 deletions(-)
> >  create mode 100644 rust/kernel/alloc/kvec.rs
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 4bddd023aa7f..bd93140f3094 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -5,6 +5,7 @@
> >  #[cfg(not(any(test, testlib)))]
> >  pub mod allocator;
> >  pub mod kbox;
> > +pub mod kvec;
> >  pub mod vec_ext;
> >
> >  #[cfg(any(test, testlib))]
> > @@ -18,6 +19,11 @@
> >  pub use self::kbox::KVBox;
> >  pub use self::kbox::VBox;
> >
> > +pub use self::kvec::KVVec;
> > +pub use self::kvec::KVec;
> > +pub use self::kvec::VVec;
> > +pub use self::kvec::Vec;
> > +
> >  /// Indicates an allocation error.
> >  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >  pub struct AllocError;
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > index 7074f00e07bc..39feaed4a8f8 100644
> > --- a/rust/kernel/alloc/kbox.rs
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -2,7 +2,7 @@
> >
> >  //! Implementation of [`Box`].
> >
> > -use super::{AllocError, Allocator, Flags};
> > +use super::{AllocError, Allocator, Flags, Vec};
> >  use core::fmt;
> >  use core::marker::PhantomData;
> >  use core::mem::ManuallyDrop;
> > @@ -169,6 +169,20 @@ pub fn into_pin(b: Self) -> Pin<Self>
> >      }
> >  }
> >
> > +impl<T, A, const N: usize> Box<[T; N], A>
> > +where
> > +    A: Allocator,
> > +{
> > +    /// Convert a `Box<[T], A>` to a `Vec<T, A>`.
> > +    pub fn into_vec(b: Self) -> Vec<T, A> {
> 
> This doc-comment seems wrong. [T] and [T; N] are not the same thing.

Indeed, gonna fix.

> 
> > +        let len = b.len();
> > +        unsafe {
> > +            let ptr = Self::into_raw(b);
> > +            Vec::from_raw_parts(ptr as _, len, len)
> > +        }
> > +    }
> > +}
> > +
> >  impl<T, A> Box<MaybeUninit<T>, A>
> >  where
> >      A: Allocator,
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > new file mode 100644
> > index 000000000000..04cc85f7d92c
> > --- /dev/null
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -0,0 +1,583 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Implementation of [`Vec`].
> > +
> > +use super::{AllocError, Allocator, Flags};
> > +use crate::types::Unique;
> > +use core::{
> > +    fmt,
> > +    marker::PhantomData,
> > +    mem::{ManuallyDrop, MaybeUninit},
> > +    ops::Deref,
> > +    ops::DerefMut,
> > +    ops::Index,
> > +    ops::IndexMut,
> > +    slice,
> > +    slice::SliceIndex,
> > +};
> > +
> > +/// Create a [`Vec`] containing the arguments.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let mut v = kernel::kvec![];
> > +/// v.push(1, GFP_KERNEL)?;
> > +/// assert_eq!(v, [1]);
> > +///
> > +/// let mut v = kernel::kvec![1; 3]?;
> > +/// v.push(4, GFP_KERNEL)?;
> > +/// assert_eq!(v, [1, 1, 1, 4]);
> > +///
> > +/// let mut v = kernel::kvec![1, 2, 3]?;
> > +/// v.push(4, GFP_KERNEL)?;
> > +/// assert_eq!(v, [1, 2, 3, 4]);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +#[macro_export]
> > +macro_rules! kvec {
> > +    () => (
> > +        {
> > +            $crate::alloc::KVec::new()
> > +        }
> > +    );
> > +    ($elem:expr; $n:expr) => (
> > +        {
> > +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> > +        }
> > +    );
> > +    ($($x:expr),+ $(,)?) => (
> > +        {
> > +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> > +                Ok(b) => Ok($crate::alloc::KBox::into_vec(b)),
> > +                Err(e) => Err(e),
> > +            }
> > +        }
> > +    );
> > +}
> > +
> > +/// The kernel's [`Vec`] type.
> > +///
> > +/// A contiguous growable array type with contents allocated with the kernel's allocators (e.g.
> > +/// `Kmalloc`, `Vmalloc` or `KVmalloc`, written `Vec<T, A>`.
> 
> A closing bracket is missing in this sentence.

Gonna fix.

> 
> > +/// For non-zero-sized values, a [`Vec`] will use the given allocator `A` for its allocation. For
> > +/// the most common allocators the type aliases `KVec`, `VVec` and `KVVec` exist.
> > +///
> > +/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::<T>`; no memory is allocated.
> > +///
> > +/// Generally, [`Vec`] consists of a pointer that represents the vector's backing buffer, the
> > +/// capacity of the vector (the number of elements that currently fit into the vector), it's length
> > +/// (the number of elements that are currently stored in the vector) and the `Allocator` used to
> > +/// allocate (and free) the backing buffer.
> > +///
> > +/// A [`Vec`] can be deconstructed into and (re-)constructed from it's previously named raw parts
> > +/// and manually modified.
> > +///
> > +/// [`Vec`]'s backing buffer gets, if required, automatically increased (re-allocated) when elements
> > +/// are added to the vector.
> > +///
> > +/// # Invariants
> > +///
> > +/// The [`Vec`] backing buffer's pointer always properly aligned and either points to memory
> > +/// allocated with `A` or, for zero-sized types, is a dangling pointer.
> > +///
> > +/// The length of the vector always represents the exact number of elements stored in the vector.
> > +///
> > +/// The capacity of the vector always represents the absolute number of elements that can be stored
> > +/// within the vector without re-allocation. However, it is legal for the backing buffer to be
> > +/// larger than `size_of<T>` times the capacity.
> > +///
> > +/// The `Allocator` of the vector is the exact allocator the backing buffer was allocated with (and
> > +/// must be freed with).
> > +pub struct Vec<T, A: Allocator> {
> > +    ptr: Unique<T>,
> > +    /// Never used for ZSTs; it's `capacity()`'s responsibility to return usize::MAX in that case.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `cap` must be in the `0..=isize::MAX` range.
> > +    cap: usize,
> 
> This section header should say Invariants, not Safety.

Agreed.

> 
> > +    len: usize,
> > +    _p: PhantomData<A>,
> > +}
> > +
> > +/// Type alias for `Vec` with a `Kmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let mut v = KVec::new();
> > +/// v.push(1, GFP_KERNEL)?;
> > +/// assert_eq!(&v, &[1]);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KVec<T> = Vec<T, super::allocator::Kmalloc>;
> > +
> > +/// Type alias for `Vec` with a `Vmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let mut v = VVec::new();
> > +/// v.push(1, GFP_KERNEL)?;
> > +/// assert_eq!(&v, &[1]);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type VVec<T> = Vec<T, super::allocator::Vmalloc>;
> > +
> > +/// Type alias for `Vec` with a `KVmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let mut v = KVVec::new();
> > +/// v.push(1, GFP_KERNEL)?;
> > +/// assert_eq!(&v, &[1]);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KVVec<T> = Vec<T, super::allocator::KVmalloc>;
> > +
> > +impl<T, A> Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    #[inline]
> > +    fn is_zst() -> bool {
> > +        core::mem::size_of::<T>() == 0
> > +    }
> > +
> > +    /// Returns the total number of elements the vector can hold without
> > +    /// reallocating.
> > +    pub fn capacity(&self) -> usize {
> > +        if Self::is_zst() {
> > +            usize::MAX
> > +        } else {
> > +            self.cap
> > +        }
> > +    }
> 
> I would consider always storing usize::MAX in the capacity field for zst types?

This wouldn't work. `self.cap` is supposed to represent the actual capacity of
the vector, which for ZSTs is zero.

> 
> > +
> > +    /// Returns the number of elements in the vector, also referred to
> > +    /// as its 'length'.
> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        self.len
> > +    }
> > +
> > +    /// Forces the length of the vector to new_len.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - `new_len` must be less than or equal to [`Self::capacity()`].
> > +    /// - The elements at `old_len..new_len` must be initialized.
> > +    #[inline]
> > +    pub unsafe fn set_len(&mut self, new_len: usize) {
> > +        self.len = new_len;
> > +    }
> > +
> > +    /// Extracts a slice containing the entire vector.
> > +    ///
> > +    /// Equivalent to `&s[..]`.
> > +    #[inline]
> > +    pub fn as_slice(&self) -> &[T] {
> > +        self
> > +    }
> > +
> > +    /// Extracts a mutable slice of the entire vector.
> > +    ///
> > +    /// Equivalent to `&mut s[..]`.
> > +    #[inline]
> > +    pub fn as_mut_slice(&mut self) -> &mut [T] {
> > +        self
> > +    }
> > +
> > +    /// Returns an unsafe mutable pointer to the vector's buffer, or a dangling
> > +    /// raw pointer valid for zero sized reads if the vector didn't allocate.
> > +    #[inline]
> > +    pub fn as_mut_ptr(&self) -> *mut T {
> > +        self.ptr.as_ptr()
> > +    }
> > +
> > +    /// Returns a raw pointer to the slice's buffer.
> > +    #[inline]
> > +    pub fn as_ptr(&self) -> *const T {
> > +        self.as_mut_ptr()
> > +    }
> > +
> > +    /// Returns `true` if the vector contains no elements.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// assert!(v.is_empty());
> > +    ///
> > +    /// v.push(1, GFP_KERNEL);
> > +    /// assert!(!v.is_empty());
> > +    /// ```
> > +    #[inline]
> > +    pub fn is_empty(&self) -> bool {
> > +        self.len() == 0
> > +    }
> > +
> > +    /// Constructs a new, empty Vec<T, A>.
> > +    ///
> > +    /// This method does not allocate by itself.
> > +    #[inline]
> > +    pub const fn new() -> Self {
> > +        Self {
> > +            ptr: Unique::dangling(),
> > +            cap: 0,
> > +            len: 0,
> > +            _p: PhantomData::<A>,
> > +        }
> > +    }
> > +
> > +    /// Returns the remaining spare capacity of the vector as a slice of `MaybeUninit<T>`.
> > +    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
> > +        // SAFETY: The memory between `self.len` and `self.capacity` is guaranteed to be allocated
> > +        // and valid, but uninitialized.
> > +        unsafe {
> > +            slice::from_raw_parts_mut(
> > +                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
> > +                self.capacity() - self.len,
> > +            )
> > +        }
> 
> Is this correct for ZSTs?

Yes, it gives us a slice of ZSTs with the maximum possible length usize::MAX.

> 
> > +    }
> > +
> > +    /// Appends an element to the back of the [`Vec`] instance.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1]);
> > +    ///
> > +    /// v.push(2, GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1, 2]);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> > +        Vec::reserve(self, 1, flags)?;
> > +        let s = self.spare_capacity_mut();
> > +        s[0].write(v);
> > +
> > +        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
> > +        // by 1. We also know that the new length is <= capacity because of the previous call to
> > +        // `reserve` above.
> > +        unsafe { self.set_len(self.len() + 1) };
> > +        Ok(())
> > +    }
> > +
> > +    /// Creates a new [`Vec`] instance with at least the given capacity.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v = KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
> > +    ///
> > +    /// assert!(v.capacity() >= 20);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
> > +        let mut v = Vec::new();
> > +
> > +        Self::reserve(&mut v, capacity, flags)?;
> > +
> > +        Ok(v)
> > +    }
> > +
> > +    /// Pushes clones of the elements of slice into the [`Vec`] instance.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL)?;
> > +    ///
> > +    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1, 20, 30, 40]);
> > +    ///
> > +    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
> > +    where
> > +        T: Clone,
> > +    {
> > +        self.reserve(other.len(), flags)?;
> > +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
> > +            slot.write(item.clone());
> > +        }
> > +
> > +        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
> > +        // the length by the same amount. We also know that the new length is <= capacity because
> > +        // of the previous call to `reserve` above.
> > +        unsafe { self.set_len(self.len() + other.len()) };
> > +        Ok(())
> > +    }
> > +
> > +    /// Creates a Vec<T, A> directly from a pointer, a length, a capacity, and an allocator.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This is highly unsafe, due to the number of invariants that aren’t checked:
> > +    ///
> > +    /// - `ptr` must be currently allocated via the given allocator `A`.
> > +    /// - `T` needs to have the same alignment as what `ptr` was allocated with. (`T` having a less
> > +    ///   strict alignment is not sufficient, the alignment really needs to be equal to satisfy the
> > +    ///   `dealloc` requirement that memory must be allocated and deallocated with the same layout.)
> > +    /// - The size of `T` times the `capacity` (i.e. the allocated size in bytes) needs to be
> > +    ///   smaller or equal the size the pointer was allocated with.
> > +    /// - `length` needs to be less than or equal to `capacity`.
> > +    /// - The first `length` values must be properly initialized values of type `T`.
> > +    /// - The allocated size in bytes must be no larger than `isize::MAX`. See the safety
> > +    ///   documentation of `pointer::offset`.
> > +    ///
> > +    /// It is also valid to create an empty `Vec` passing a dangling pointer for `ptr` and zero for
> > +    /// `cap` and `len`.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = kernel::kvec![1, 2, 3]?;
> > +    /// v.reserve(1, GFP_KERNEL)?;
> > +    ///
> > +    /// let (mut ptr, mut len, cap) = v.into_raw_parts();
> > +    ///
> > +    /// // SAFETY: We've just reserved memory for another element.
> > +    /// unsafe { ptr.add(len).write(4) };
> > +    /// len += 1;
> > +    ///
> > +    /// // SAFETY: We only wrote an additional element at the end of the `KVec`'s buffer and
> > +    /// // correspondingly increased the length of the `KVec` by one. Otherwise, we construct it
> > +    /// // from the exact same raw parts.
> > +    /// let v = unsafe { KVec::from_raw_parts(ptr, len, cap) };
> > +    ///
> > +    /// assert_eq!(v, [1, 2, 3, 4]);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
> > +        let cap = if Self::is_zst() { 0 } else { capacity };
> > +
> > +        Self {
> > +            // SAFETY: By the safety requirements, `ptr` is either dangling or pointing to a valid
> > +            // memory allocation, allocated with `A`.
> > +            ptr: unsafe { Unique::new_unchecked(ptr) },
> > +            cap,
> > +            len: length,
> > +            _p: PhantomData::<A>,
> > +        }
> > +    }
> > +
> > +    /// Decomposes a `Vec<T, A>` into its raw components: (`pointer`, `length`, `capacity`).
> > +    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
> > +        let me = ManuallyDrop::new(self);
> > +        let len = me.len();
> > +        let capacity = me.capacity();
> > +        let ptr = me.as_mut_ptr();
> > +        (ptr, len, capacity)
> > +    }
> > +
> > +    /// Ensures that the capacity exceeds the length by at least `additional` elements.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL)?;
> > +    ///
> > +    /// v.reserve(10, GFP_KERNEL)?;
> > +    /// let cap = v.capacity();
> > +    /// assert!(cap >= 10);
> > +    ///
> > +    /// v.reserve(10, GFP_KERNEL)?;
> > +    /// let new_cap = v.capacity();
> > +    /// assert_eq!(new_cap, cap);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
> > +        let len = self.len();
> > +        let cap = self.capacity();
> > +
> > +        if cap - len >= additional {
> > +            return Ok(());
> > +        }
> > +
> > +        if Self::is_zst() {
> > +            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
> > +            return Err(AllocError);
> > +        }
> > +
> > +        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
> > +        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
> 
> You know it won't overflow because of the type invariants. The thing
> about Layout::array should instead be used to argue why setting
> self.cap below does not break the invariants.

Good point, I will reword it.

> 
> > +        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> > +        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
> > +
> > +        // We need to make sure that `ptr` is either NULL or comes from a previous call to
> > +        // `realloc_flags`. A `Vec<T, A>`'s `ptr` value is not guaranteed to be NULL and might be
> > +        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T, A>`'s
> > +        // capacity to be zero if no memory has been allocated yet.
> > +        let ptr = if cap == 0 {
> > +            None
> > +        } else {
> > +            Some(self.ptr.as_non_null().cast())
> > +        };
> > +
> > +        // SAFETY: `ptr` is valid because it's either `None` or comes from a previous call to
> > +        // `A::realloc`. We also verified that the type is not a ZST.
> > +        let ptr = unsafe { A::realloc(ptr, layout, flags)? };
> > +
> > +        self.ptr = ptr.cast().into();
> > +        self.cap = new_cap;
> > +
> > +        Ok(())
> > +    }
> > +}
> > +
> > +impl<T: Clone, A: Allocator> Vec<T, A> {
> > +    /// Extend the vector by `n` clones of value.
> > +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), AllocError> {
> > +        self.reserve(n, flags)?;
> > +
> > +        let spare = self.spare_capacity_mut();
> > +
> > +        for i in 0..spare.len() - 1 {
> > +            spare[i].write(value.clone());
> > +        }
> 
> Minus one? Shouldn't this instead loop for `0..n`?

We can indeed just use `n` instead of `slice::len` here.

Minus one, because we create clones for the first n - 1 elements and for the
last one we just use the value itself.

> 
> > +
> > +        // We can write the last element directly without cloning needlessly
> > +        spare[spare.len() - 1].write(value);
> 
> spare[n-1].write(value);

Yep, works too.

> 
> > +
> > +        // SAFETY: `self.reserve` not bailing out with an error guarantees that we're not
> > +        // exceeding the capacity of this `Vec`.
> > +        unsafe { self.set_len(self.len() + n) };
> > +
> > +        Ok(())
> > +    }
> > +
> > +    /// Create a new `Vec<T, A> and extend it by `n` clones of `value`.
> > +    pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
> > +        let mut v = Self::with_capacity(n, flags)?;
> > +
> > +        v.extend_with(n, value, flags)?;
> > +
> > +        Ok(v)
> > +    }
> > +}
> > +
> > +impl<T, A> Drop for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    fn drop(&mut self) {
> > +        // SAFETY: We need to drop the vector's elements in place, before we free the backing
> > +        // memory.
> > +        unsafe {
> > +            core::ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut(
> > +                self.as_mut_ptr(),
> > +                self.len,
> > +            ))
> > +        };
> > +
> > +        // If `cap == 0` we never allocated any memory in the first place.
> > +        if self.cap != 0 {
> > +            // SAFETY: `self.ptr` was previously allocated with `A`.
> > +            unsafe { A::free(self.ptr.as_non_null().cast()) };
> 
> Do you need a ZST check here?

No, for ZST `self.cap` is always zero.

> 
> > +        }
> > +    }
> > +}
> > +
> > +impl<T> Default for KVec<T> {
> > +    #[inline]
> > +    fn default() -> Self {
> > +        Self::new()
> > +    }
> > +}
> > +
> > +impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> > +        fmt::Debug::fmt(&**self, f)
> > +    }
> > +}
> > +
> > +impl<T, A> Deref for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Target = [T];
> > +
> > +    #[inline]
> > +    fn deref(&self) -> &[T] {
> > +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
> > +        // initialized elements of type `T`.
> > +        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
> > +    }
> > +}
> > +
> > +impl<T, A> DerefMut for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    #[inline]
> > +    fn deref_mut(&mut self) -> &mut [T] {
> > +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to contain `self.len`
> > +        // initialized elements of type `T`.
> > +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
> > +    }
> > +}
> > +
> > +impl<T: Eq, A> Eq for Vec<T, A> where A: Allocator {}
> > +
> > +impl<T, I: SliceIndex<[T]>, A> Index<I> for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Output = I::Output;
> > +
> > +    #[inline]
> > +    fn index(&self, index: I) -> &Self::Output {
> > +        Index::index(&**self, index)
> > +    }
> > +}
> > +
> > +impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    #[inline]
> > +    fn index_mut(&mut self, index: I) -> &mut Self::Output {
> > +        IndexMut::index_mut(&mut **self, index)
> > +    }
> > +}
> > +
> > +macro_rules! __impl_slice_eq {
> > +    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?) => {
> > +        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
> > +        where
> > +            T: PartialEq<U>,
> > +            $($ty: $bound)?
> > +        {
> > +            #[inline]
> > +            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
> > +        }
> > +    }
> > +}
> > +
> > +__impl_slice_eq! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2> }
> > +__impl_slice_eq! { [A: Allocator] Vec<T, A>, &[U] }
> > +__impl_slice_eq! { [A: Allocator] Vec<T, A>, &mut [U] }
> > +__impl_slice_eq! { [A: Allocator] &[T], Vec<U, A> }
> > +__impl_slice_eq! { [A: Allocator] &mut [T], Vec<U, A> }
> > +__impl_slice_eq! { [A: Allocator] Vec<T, A>, [U] }
> > +__impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
> > +__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
> > +__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index 6bf77577eae7..bb80a43d20fb 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -14,7 +14,7 @@
> >  #[doc(no_inline)]
> >  pub use core::pin::Pin;
> >
> > -pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
> > +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
> >
> >  #[doc(no_inline)]
> >  pub use alloc::vec::Vec;
> > --
> > 2.45.2
> >
> 

