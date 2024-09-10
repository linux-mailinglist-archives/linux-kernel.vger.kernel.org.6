Return-Path: <linux-kernel+bounces-323790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2560974383
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AF028CD04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351A17C21B;
	Tue, 10 Sep 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ykg86yuc"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7417BED4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996744; cv=none; b=VukO9xpUBTkCi11sarHJut4yWycqa4xP9BvPknWKs7jwitUqoFffVaoKGLxLe9g/nU3IugV4FFQ5qK0ecFbQjnmQj6cqpgVaUQkNQNEcwW081mbbGciEBzSaYPe7YQ/H8uOCScCrN24oklQcxadaeBcyiSMsdlZuPNataykU5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996744; c=relaxed/simple;
	bh=koshJY5im1TaxorZ1iaxQtNHUg6Lw3sdbLr+jqMo9jI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy/yPPXmQUPEBPU4YgMzMW5+RhxPpxa4+a3hgYh+0KX5gq8llQhif6Cu61+ziUFP2MvyEJBzHyVUuRiBFFzJYmmVi/Lb0Xgh/hzgp2iMneEeODZROQObSmejwstvI0pHhM4aMSwkPKe2fAnIt75aI+D6D85ptQXiZMQxUY+C60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ykg86yuc; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5oknvsffsbcidc7ci7bxkq6hym.protonmail; t=1725996732; x=1726255932;
	bh=SVru0WIrGTVRLhFIrTrQzFIUmXosxsHkIP6EJpKuEHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ykg86yucpZKgs+KuWi4LjY4SQHFJNGcdmm8/4zdDZW+AAaZ0KvOCrG4I3Et/8nEoY
	 3vgsyhtqAA+/mPGuHyCG2Xy/osU/nqQJGtsXuQOs2OEoHmTpCAucvHn2Vpe7un1n3K
	 SwR8gwwQMfmDP+NSNtOsELheInmUSlLYD0MTu4OOc9k9qupyVdwHaCo9OruzX+KaBQ
	 oc0UkxiHnXL7s2a65RNg4TXpVRw6Q799C21ddwSkd/44BQfF4NVgRlVMZ7GrsKM3ha
	 6w5ZJSv2aBNhGwQXcppPdWLLBNVaLZhsvOvvu4IDmIeuR/rPHvFYYJX8NFiqFTQquE
	 Mf17ox43F5Yxg==
Date: Tue, 10 Sep 2024 19:32:06 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <fe19f450-ddb4-4f50-a016-9f213b22f633@proton.me>
In-Reply-To: <20240816001216.26575-14-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-14-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 69cbdccfe78fa93350904e5891b0a7ef021d4dd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> `Vec` provides a contiguous growable array type (such as `Vec`) with

"`Vec` [...] such as `Vec`"? What do you want to say? I think without
the parenthesis it works better.

> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> `Vmalloc` or `KVmalloc`).
>=20
> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the

I would add "stdlib" after "Rust's".

> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kvec.rs | 629 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 636 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index d248390345ec..e88c7e10ee9b 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod kbox;
> +pub mod kvec;
>  pub mod vec_ext;
>=20
>  #[cfg(any(test, testlib))]
> @@ -18,6 +19,11 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>=20
> +pub use self::kvec::KVVec;
> +pub use self::kvec::KVec;
> +pub use self::kvec::VVec;
> +pub use self::kvec::Vec;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> new file mode 100644
> index 000000000000..89afc0f25bd4
> --- /dev/null
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -0,0 +1,629 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Vec`].
> +
> +use super::{AllocError, Allocator, Box, Flags};
> +use core::{
> +    fmt,
> +    marker::PhantomData,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::Deref,
> +    ops::DerefMut,
> +    ops::Index,
> +    ops::IndexMut,
> +    ptr::NonNull,
> +    slice,
> +    slice::SliceIndex,
> +};
> +
> +/// Create a [`Vec`] containing the arguments.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v =3D kernel::kvec![];
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(v, [1]);
> +///
> +/// let mut v =3D kernel::kvec![1; 3]?;
> +/// v.push(4, GFP_KERNEL)?;
> +/// assert_eq!(v, [1, 1, 1, 4]);
> +///
> +/// let mut v =3D kernel::kvec![1, 2, 3]?;
> +/// v.push(4, GFP_KERNEL)?;
> +/// assert_eq!(v, [1, 2, 3, 4]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[macro_export]
> +macro_rules! kvec {

Do we only want to support creating `KVec` via a macro?

> +    () =3D> (
> +        {
> +            $crate::alloc::KVec::new()
> +        }
> +    );

Why do you have parenthesis and braces? IIRC just braces/parenthesis or
brackets should be enough.

> +    ($elem:expr; $n:expr) =3D> (
> +        {
> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)

Hmm, could it be that one might want to use `kvec!` without
`GFP_KERNEL`?
Or add additional flags, eg __GFP_ZERO?

If you think that supporting this is not immediately necessary or if
this is too much for this patchset, then we can also postpone it (maybe
it could be a good-first-issue). Do you keep a list of future
improvements for the new allocator API somewhere? If not, then I think
we should create one (best place would be the issue tracker on GH).

> +        }
> +    );
> +    ($($x:expr),+ $(,)?) =3D> (
> +        {
> +            match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
> +                Ok(b) =3D> Ok($crate::alloc::KVec::from($crate::alloc::K=
Box::write(b, [$($x),+]))),
> +                Err(e) =3D> Err(e),
> +            }
> +        }
> +    );
> +}
> +
> +/// The kernel's [`Vec`] type.
> +///
> +/// A contiguous growable array type with contents allocated with the ke=
rnel's allocators (e.g.
> +/// `Kmalloc`, `Vmalloc` or `KVmalloc`), written `Vec<T, A>`.

New folks might get confused as to which allocator they should choose.
Do we have a sensible default for `Vec`?
If yes, then we at least should document that here. We might also want
to make it the default value for the generic parameter.
This is also a good idea for `Box`.

> +///
> +/// For non-zero-sized values, a [`Vec`] will use the given allocator `A=
` for its allocation. For
> +/// the most common allocators the type aliases `KVec`, `VVec` and `KVVe=
c` exist.
> +///
> +/// For zero-sized types the [`Vec`]'s pointer must be `dangling_mut::<T=
>`; no memory is allocated.
> +///
> +/// Generally, [`Vec`] consists of a pointer that represents the vector'=
s backing buffer, the
> +/// capacity of the vector (the number of elements that currently fit in=
to the vector), it's length
> +/// (the number of elements that are currently stored in the vector) and=
 the `Allocator` type used
> +/// to allocate (and free) the backing buffer.
> +///
> +/// A [`Vec`] can be deconstructed into and (re-)constructed from it's p=
reviously named raw parts
> +/// and manually modified.
> +///
> +/// [`Vec`]'s backing buffer gets, if required, automatically increased =
(re-allocated) when elements
> +/// are added to the vector.
> +///
> +/// # Invariants
> +///
> +/// The [`Vec`] backing buffer's pointer is always properly aligned and =
either points to memory
> +/// allocated with `A` or, for zero-sized types, is a dangling pointer.

Just use `self.ptr` instead of "backing buffer".

> +///
> +/// The length of the vector always represents the exact number of eleme=
nts stored in the vector.

Same here, `self.len`.

> +///
> +/// The capacity of the vector always represents the absolute number of =
elements that can be stored

Ditto.

> +/// within the vector without re-allocation. However, it is legal for th=
e backing buffer to be
> +/// larger than `size_of<T>` times the capacity.
> +///
> +/// The `Allocator` type `A` of the vector is the exact same `Allocator`=
 type the backing buffer was
> +/// allocated with (and must be freed with).

Please turn this into a bullet-point list.

> +pub struct Vec<T, A: Allocator> {
> +    ptr: NonNull<T>,
> +    /// Represents the actual buffer size as `cap` times `size_of::<T>` =
bytes.
> +    ///
> +    /// Note: This isn't quite the same as `Self::capacity`, which in co=
ntrast returns the number of
> +    /// elements we can still store without reallocating.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// `cap` must be in the `0..=3Disize::MAX` range.
> +    cap: usize,
> +    len: usize,
> +    _p: PhantomData<A>,
> +}
> +
> +/// Type alias for `Vec` with a `Kmalloc` allocator.

Can you turn these into links?

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v =3D KVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVec<T> =3D Vec<T, super::allocator::Kmalloc>;
> +
> +/// Type alias for `Vec` with a `Vmalloc` allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v =3D VVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type VVec<T> =3D Vec<T, super::allocator::Vmalloc>;
> +
> +/// Type alias for `Vec` with a `KVmalloc` allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut v =3D KVVec::new();
> +/// v.push(1, GFP_KERNEL)?;
> +/// assert_eq!(&v, &[1]);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVVec<T> =3D Vec<T, super::allocator::KVmalloc>;
> +
> +// SAFETY: `Vec` is `Send` if `T` is `Send` because `Vec` owns its eleme=
nts.
> +unsafe impl<T, A> Send for Vec<T, A>
> +where
> +    T: Send,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Vec` is `Sync` if `T` is `Sync` because `Vec` owns its eleme=
nts.
> +unsafe impl<T, A> Sync for Vec<T, A>
> +where
> +    T: Sync,
> +    A: Allocator,
> +{
> +}
> +
> +impl<T, A> Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn is_zst() -> bool {
> +        core::mem::size_of::<T>() =3D=3D 0
> +    }
> +
> +    /// Returns the number of elements that can be stored within the vec=
tor without allocating
> +    /// additional memory.
> +    pub fn capacity(&self) -> usize {
> +        if Self::is_zst() {
> +            usize::MAX
> +        } else {
> +            self.cap
> +        }
> +    }
> +
> +    /// Returns the number of elements stored within the vector.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.len
> +    }
> +
> +    /// Forcefully sets `self.len` to `new_len`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `new_len` must be less than or equal to [`Self::capacity`].
> +    /// - If `new_len` is greater than `self.len`, all elements within t=
he interval
> +    ///   [`self.len`,`new_len`] must be initialized.
> +    #[inline]
> +    pub unsafe fn set_len(&mut self, new_len: usize) {

Can you add a `debug_assert!(new_len < self.cap)`

> +        self.len =3D new_len;
> +    }
> +
> +    /// Returns a slice of the entire vector.
> +    ///
> +    /// Equivalent to `&s[..]`.
> +    #[inline]
> +    pub fn as_slice(&self) -> &[T] {
> +        self
> +    }
> +
> +    /// Returns a mutable slice of the entire vector.
> +    ///
> +    /// Equivalent to `&mut s[..]`.
> +    #[inline]
> +    pub fn as_mut_slice(&mut self) -> &mut [T] {
> +        self
> +    }
> +
> +    /// Returns a mutable raw pointer to the vector's backing buffer, or=
, if `T` is a ZST, a
> +    /// dangling raw pointer.
> +    #[inline]
> +    pub fn as_mut_ptr(&self) -> *mut T {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the vector's backing buffer, or, if `T`=
 is a ZST, a dangling raw
> +    /// pointer.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const T {
> +        self.as_mut_ptr()
> +    }
> +
> +    /// Returns `true` if the vector contains no elements, `false` other=
wise.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// assert!(v.is_empty());
> +    ///
> +    /// v.push(1, GFP_KERNEL);
> +    /// assert!(!v.is_empty());
> +    /// ```
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.len() =3D=3D 0
> +    }
> +
> +    /// Creates a new, empty Vec<T, A>.
> +    ///
> +    /// This method does not allocate by itself.
> +    #[inline]
> +    pub const fn new() -> Self {
> +        Self {
> +            ptr: NonNull::dangling(),
> +            cap: 0,
> +            len: 0,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capa=
city of the vector.

Returns=20

> +    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
> +        // SAFETY: The memory between `self.len` and `self.capacity` is =
guaranteed to be allocated
> +        // and valid, but uninitialized.
> +        unsafe {
> +            slice::from_raw_parts_mut(
> +                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
> +                self.capacity() - self.len,
> +            )
> +        }

There are two `unsafe` operations in this block, please split it into
two blocks.

> +    }
> +
> +    /// Appends an element to the back of the [`Vec`] instance.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// v.push(2, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 2]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>=
 {
> +        Vec::reserve(self, 1, flags)?;
> +        let s =3D self.spare_capacity_mut();
> +        s[0].write(v);

The slice access will check the size, I don't know if it will be
optimized out, if not, I would use a raw pointer here instead.

> +
> +        // SAFETY: We just initialised the first spare entry, so it is s=
afe to increase the length
> +        // by 1. We also know that the new length is <=3D capacity becau=
se of the previous call to
> +        // `reserve` above.
> +        unsafe { self.set_len(self.len() + 1) };
> +        Ok(())
> +    }
> +
> +    /// Creates a new [`Vec`] instance with at least the given capacity.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v =3D KVec::<u32>::with_capacity(20, GFP_KERNEL)?;
> +    ///
> +    /// assert!(v.capacity() >=3D 20);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, =
AllocError> {
> +        let mut v =3D Vec::new();
> +
> +        Self::reserve(&mut v, capacity, flags)?;
> +
> +        Ok(v)
> +    }
> +
> +    /// Pushes clones of the elements of slice into the [`Vec`] instance=
.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    ///
> +    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 20, 30, 40]);
> +    ///
> +    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Re=
sult<(), AllocError>
> +    where
> +        T: Clone,
> +    {
> +        self.reserve(other.len(), flags)?;
> +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), o=
ther) {
> +            slot.write(item.clone());
> +        }
> +
> +        // SAFETY: We just initialised the `other.len()` spare entries, =
so it is safe to increase
> +        // the length by the same amount. We also know that the new leng=
th is <=3D capacity because
> +        // of the previous call to `reserve` above.

Please use a bullet point list and avoid natural language filler words.

> +        unsafe { self.set_len(self.len() + other.len()) };
> +        Ok(())
> +    }
> +
> +    /// Creates a Vec<T, A> from a pointer, a length and a capacity usin=
g the allocator `A`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `T` is a ZST:
> +    ///
> +    /// - `ptr` must be a dangling pointer.
> +    /// - `capacity` must be zero.

When `T` is a ZST, `into_raw_parts` returns `usize::MAX` for `capacity`,
so one can't just pipe its output to this function? That seems strange.

Also below you discard the value of `capacity`, when `T` is a ZST, so I
think you can just remove this line.

> +    /// - `length` must be smaller than or equal to `usize::MAX`.

This is always true.

> +    ///
> +    /// Otherwise:
> +    ///
> +    /// - `ptr` must have been allocated with the allocator `A`.
> +    /// - `ptr` must satisfy or exceed the alignment requirements of `T`=
.
> +    /// - `ptr` must point to memory with a size of at least `size_of::<=
T>` times the `capacity`
> +    ///    bytes.

Just write "`size_of::<T>() * capacity` bytes".

> +    /// - The allocated size in bytes must not be larger than `isize::MA=
X`.

Should we make this a safety requirement of `Allocator`? I think this is
generally the maximum size other allocated things can have anyways.

> +    /// - `length` must be less than or equal to `capacity`.
> +    /// - The first `length` elements must be initialized values of type=
 `T`.
> +    ///
> +    /// It is also valid to create an empty `Vec` passing a dangling poi=
nter for `ptr` and zero for
> +    /// `cap` and `len`.

Can you make this last sentence part of the `if` chain that you have
above (ie the one started with "If `T` is a ZST:").


Just to experiment with the suggestion from Kangrejos to use Rust as the
language for safety documentation, here is what it could look like (we
should discuss it more before we start using it):

    /// # Safety
    ///
    /// ```ignore
    /// assert!(ptr.is_aligned_to(align_of::<T>()));
    /// assert!(!ptr.is_null());
    /// assert!(length <=3D capacity);
    /// if capacity !=3D 0 && size_of::<T>() !=3D 0 {
    ///     assert!(A::did_allocate(ptr));
    ///     assert!(size_of::<T>() * capacity <=3D A::layout_of(ptr).len())=
;
    ///     assert!(is_initialized(ptr::slice_from_raw_parts(ptr, length)))=
;
    /// }
    /// ```

I really like how this looks! We might want to add labels/names to each
of the conditions and then one could use those in the justifications. A
tool could then read those and match them to the requirements of the
unsafe operation.

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D kernel::kvec![1, 2, 3]?;
> +    /// v.reserve(1, GFP_KERNEL)?;
> +    ///
> +    /// let (mut ptr, mut len, cap) =3D v.into_raw_parts();
> +    ///
> +    /// // SAFETY: We've just reserved memory for another element.
> +    /// unsafe { ptr.add(len).write(4) };
> +    /// len +=3D 1;
> +    ///
> +    /// // SAFETY: We only wrote an additional element at the end of the=
 `KVec`'s buffer and
> +    /// // correspondingly increased the length of the `KVec` by one. Ot=
herwise, we construct it
> +    /// // from the exact same raw parts.
> +    /// let v =3D unsafe { KVec::from_raw_parts(ptr, len, cap) };
> +    ///
> +    /// assert_eq!(v, [1, 2, 3, 4]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```

Please reorder the sections to be `# Examples` followed by `# Safety`.

> +    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: u=
size) -> Self {
> +        let cap =3D if Self::is_zst() { 0 } else { capacity };
> +
> +        Self {
> +            // SAFETY: By the safety requirements, `ptr` is either dangl=
ing or pointing to a valid
> +            // memory allocation, allocated with `A`.
> +            ptr: unsafe { NonNull::new_unchecked(ptr) },
> +            cap,
> +            len: length,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Consumes the `Vec<T, A>` and returns its raw components `pointer=
`, `length` and `capacity`.
> +    ///
> +    /// This will not run the destructor of the contained elements and f=
or non-ZSTs the allocation
> +    /// will stay alive indefinitely. Use [`Vec::from_raw_parts`] to rec=
over the [`Vec`], drop the
> +    /// elements and free the allocation, if any.
> +    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
> +        let me =3D ManuallyDrop::new(self);
> +        let len =3D me.len();
> +        let capacity =3D me.capacity();
> +        let ptr =3D me.as_mut_ptr();
> +        (ptr, len, capacity)
> +    }
> +
> +    /// Ensures that the capacity exceeds the length by at least `additi=
onal`
> +    /// elements.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    ///
> +    /// v.reserve(10, GFP_KERNEL)?;
> +    /// let cap =3D v.capacity();
> +    /// assert!(cap >=3D 10);
> +    ///
> +    /// v.reserve(10, GFP_KERNEL)?;
> +    /// let new_cap =3D v.capacity();
> +    /// assert_eq!(new_cap, cap);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result=
<(), AllocError> {
> +        let len =3D self.len();
> +        let cap =3D self.capacity();
> +
> +        if cap - len >=3D additional {
> +            return Ok(());
> +        }
> +
> +        if Self::is_zst() {
> +            // The capacity is already `usize::MAX` for SZTs, we can't g=
o higher.

Typo: SZTs -> ZSTs

> +            return Err(AllocError);
> +        }
> +
> +        // We know `cap` is <=3D `isize::MAX` because of it's type invar=
iant. So the multiplication by

"it's type invariant" -> "type invariants of Self"

> +        // two won't overflow.
> +        let new_cap =3D core::cmp::max(cap * 2, len.checked_add(addition=
al).ok_or(AllocError)?);
> +        let layout =3D core::alloc::Layout::array::<T>(new_cap).map_err(=
|_| AllocError)?;
> +
> +        // We need to make sure that `ptr` is either NULL or comes from =
a previous call to
> +        // `realloc_flags`. A `Vec<T, A>`'s `ptr` value is not guarantee=
d to be NULL and might be
> +        // dangling after being created with `Vec::new`. Instead, we can=
 rely on `Vec<T, A>`'s
> +        // capacity to be zero if no memory has been allocated yet.
> +        let ptr =3D if cap =3D=3D 0 {
> +            None
> +        } else {
> +            Some(self.ptr.cast())
> +        };
> +
> +        // SAFETY: `ptr` is valid because it's either `None` or comes fr=
om a previous call to
> +        // `A::realloc`. We also verified that the type is not a ZST.
> +        let ptr =3D unsafe { A::realloc(ptr, layout, flags)? };
> +
> +        self.ptr =3D ptr.cast();
> +
> +        // INVARIANT: `Layout::array` fails if the resulting byte size i=
s greater than `isize::MAX`.
> +        self.cap =3D new_cap;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T: Clone, A: Allocator> Vec<T, A> {
> +    /// Extend the vector by `n` clones of value.

value -> `value`

> +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> R=
esult<(), AllocError> {
> +        if n =3D=3D 0 {
> +            return Ok(());
> +        }
> +
> +        self.reserve(n, flags)?;
> +
> +        let spare =3D self.spare_capacity_mut();
> +
> +        for item in spare.iter_mut().take(n - 1) {
> +            item.write(value.clone());
> +        }
> +
> +        // We can write the last element directly without cloning needle=
ssly.
> +        spare[n - 1].write(value);
> +
> +        // SAFETY: `self.reserve` not bailing out with an error guarante=
es that we're not
> +        // exceeding the capacity of this `Vec`.

This safety comment needs to be improved, how about using bullet points:
- `self.len() + n < capacity` due to the call to reserve above,
- the loop and the line above initialized the next `n` elements.

> +        unsafe { self.set_len(self.len() + n) };
> +
> +        Ok(())
> +    }
> +
> +    /// Create a new `Vec<T, A> and extend it by `n` clones of `value`.
> +    pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, A=
llocError> {
> +        let mut v =3D Self::with_capacity(n, flags)?;
> +
> +        v.extend_with(n, value, flags)?;
> +
> +        Ok(v)
> +    }
> +}
> +
> +impl<T, A> Drop for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        // SAFETY: We need to drop the vector's elements in place, befor=
e we free the backing
> +        // memory.
> +        unsafe {
> +            core::ptr::drop_in_place(core::ptr::slice_from_raw_parts_mut=
(

You are using `core::ptr` a bunch, consider using it, then you don't
need to write the prefix `core::`.

> +                self.as_mut_ptr(),
> +                self.len,
> +            ))
> +        };
> +
> +        // If `cap =3D=3D 0` we never allocated any memory in the first =
place.
> +        if self.cap !=3D 0 {
> +            // SAFETY: `self.ptr` was previously allocated with `A`.
> +            unsafe { A::free(self.ptr.cast()) };
> +        }
> +    }
> +}
> +
> +impl<T, A, const N: usize> From<Box<[T; N], A>> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn from(b: Box<[T; N], A>) -> Vec<T, A> {
> +        let len =3D b.len();
> +        let ptr =3D Box::into_raw(b);
> +
> +        unsafe { Vec::from_raw_parts(ptr as _, len, len) }

Missing SAFETY comment.

> +    }
> +}
> +
> +impl<T> Default for KVec<T> {
> +    #[inline]
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(&**self, f)
> +    }
> +}
> +
> +impl<T, A> Deref for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Target =3D [T];
> +
> +    #[inline]
> +    fn deref(&self) -> &[T] {
> +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to co=
ntain `self.len`
> +        // initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
> +    }
> +}
> +
> +impl<T, A> DerefMut for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut [T] {
> +        // SAFETY: The memory behind `self.as_ptr()` is guaranteed to co=
ntain `self.len`
> +        // initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) =
}
> +    }
> +}
> +
> +impl<T: Eq, A> Eq for Vec<T, A> where A: Allocator {}
> +
> +impl<T, I: SliceIndex<[T]>, A> Index<I> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Output =3D I::Output;
> +
> +    #[inline]
> +    fn index(&self, index: I) -> &Self::Output {
> +        Index::index(&**self, index)
> +    }
> +}
> +
> +impl<T, I: SliceIndex<[T]>, A> IndexMut<I> for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn index_mut(&mut self, index: I) -> &mut Self::Output {
> +        IndexMut::index_mut(&mut **self, index)
> +    }
> +}
> +
> +macro_rules! __impl_slice_eq {

I wouldn't begin this macro with `__`, it is already private.

> +    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?) =3D=
> {

You don't use the optional `where` part in the code below, if you don't
use it later, then remove it (if you do use it later, I would move it
into that patch).

---
Cheers,
Benno

> +        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
> +        where
> +            T: PartialEq<U>,
> +            $($ty: $bound)?
> +        {
> +            #[inline]
> +            fn eq(&self, other: &$rhs) -> bool { self[..] =3D=3D other[.=
.] }
> +        }
> +    }
> +}
> +
> +__impl_slice_eq! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>=
 }
> +__impl_slice_eq! { [A: Allocator] Vec<T, A>, &[U] }
> +__impl_slice_eq! { [A: Allocator] Vec<T, A>, &mut [U] }
> +__impl_slice_eq! { [A: Allocator] &[T], Vec<U, A> }
> +__impl_slice_eq! { [A: Allocator] &mut [T], Vec<U, A> }
> +__impl_slice_eq! { [A: Allocator] Vec<T, A>, [U] }
> +__impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
> +__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
> +__impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index d5f2fe42d093..80223cdaa485 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>=20
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox=
};
> +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVe=
c, KVec, VBox, VVec};
>=20
>  #[doc(no_inline)]
>  pub use alloc::vec::Vec;
> --
> 2.46.0
>=20


