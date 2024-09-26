Return-Path: <linux-kernel+bounces-340527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96459874B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CF31C21C31
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877D3B1A2;
	Thu, 26 Sep 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Rg7unbVl"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EE73176
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358440; cv=none; b=lYsgeHcrlztk6ZSpTWHCA3uGqZjiJButLvIZf1zJQDiGEIM6s92UfvA5glAmFXsQsW2qnibuaL+1Rjyv2OpX/BrG4pSj663O0whb28CvLUgAMBYeyw80usUR1SuMDBHWxXZRwr5ifbsJLOevlu36fhG9hRalJlTBpCELfLKa+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358440; c=relaxed/simple;
	bh=j82Zi+sVoG6yviym1V43ipn+LTQNelMzYNBt1n7N5ag=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBdwy6pqrdJCpbmJ/lkXbifCSccUWnQK6+3DpXDo/oDBH198gwbY7qwDBqO+c3lBqye84c5cY1/cmLxa9GNLYNgoRChBe0Ox6ctZuzWRE7B1iEtncG7jGZhIhE9RVVRiLtafFwp+fWxe+2A2F6IdJEtCLYHqmKE1bHe30JICLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Rg7unbVl; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727358435; x=1727617635;
	bh=reYH+g6KCG/gHa73Zdx03h/tXwI3z27bHSRd2N/HCi4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Rg7unbVlbcyKVoYq0/S4qJjDQ92NVLTF6O5Llwa2BcaqW9MltTDk652rgMkCHgP77
	 D5DCV4XLVeliLNt0HnppNzkjRxI9VwOITZ7gUFPGsDpfJCXiZhpiBhmg3quEYUQDgE
	 OajZUX11mThe1iRBoA+46ABWfQ75uf7UiKv3/UZYomBeLEWrbJ7b/9gmYppSyV0Dzr
	 TAGDszRxP1l8PM7697tVke2Bv5w6/w9C96woByrFEPv1CMxI/0CmJ0KbE/Edhg/biz
	 kLbZPpALkJfj7LeMs1wwHqV4T8JUB1K53BkPgQvFz6xGO+t4yNeiy5K7GObRg4iyep
	 eeEdkBQxYW6sg==
Date: Thu, 26 Sep 2024 13:47:04 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <1a06b767-ca02-41ec-840a-47e73f7876d8@proton.me>
In-Reply-To: <20240911225449.152928-14-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-14-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: be9e20cea1e424691f0481685a01b085c4c11d7b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> new file mode 100644
> index 000000000000..631a44e19f35
> --- /dev/null
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Vec`].
> +
> +use super::{
> +    allocator::{KVmalloc, Kmalloc, Vmalloc},
> +    AllocError, Allocator, Box, Flags,
> +};
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

I would change this to [`KVec`].

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
> +    () =3D> (
> +        $crate::alloc::KVec::new()
> +    );
> +    ($elem:expr; $n:expr) =3D> (
> +        $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> +    );
> +    ($($x:expr),+ $(,)?) =3D> (
> +        match $crate::alloc::KBox::new_uninit(GFP_KERNEL) {
> +            Ok(b) =3D> Ok($crate::alloc::KVec::from($crate::alloc::KBox:=
:write(b, [$($x),+]))),
> +            Err(e) =3D> Err(e),
> +        }
> +    );
> +}
> +
> +/// The kernel's [`Vec`] type.
> +///
> +/// A contiguous growable array type with contents allocated with the ke=
rnel's allocators (e.g.
> +/// `Kmalloc`, `Vmalloc` or `KVmalloc`), written `Vec<T, A>`.

Can you turn these into links?

> +///
> +/// For non-zero-sized values, a [`Vec`] will use the given allocator `A=
` for its allocation. For
> +/// the most common allocators the type aliases `KVec`, `VVec` and `KVVe=
c` exist.

Ditto.

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
> +/// - `self.ptr` is always properly aligned and either points to memory =
allocated with `A` or, for
> +///   zero-sized types, is a dangling, well aligned pointer.
> +///
> +/// - `self.len` always represents the exact number of elements stored i=
n the vector.
> +///
> +/// - `self.cap` represents the absolute number of elements that can be =
stored within the vector
> +///   without re-allocation. However, it is legal for the backing buffer=
 to be larger than
> +///   `size_of<T>` times the capacity.
> +///
> +/// - The `Allocator` type `A` of the vector is the exact same `Allocato=
r` type the backing buffer
> +///   was allocated with (and must be freed with).
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

[...]

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
> +
> +        // SAFETY:
> +        // - `self.len` is smaller than `self.capacity` and hence, the r=
esulting pointer is
> +        //   guaranteed to be part of the same allocated object.
> +        // - `self.len` can not overflow `isize`.
> +        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
> +
> +        // SAFETY:
> +        // - `ptr` is properly aligned and valid for writes.
> +        unsafe { core::ptr::write(ptr, v) };

Why not use `self.spare_capacity_mut()[0].write(v);`?

If you want to avoid the bounds check, you can do

    let first =3D self.spare_capacity_mut().first();
    // SAFETY: the call to `Vec::reserve` above ensures that `spare_capacit=
y_mut()` is non-empty.
    unsafe { first.unwrap_unchecked() }.write(v);

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

This method can be moved into the other impl block below, it already has
the `T: Clone` bound.

> +    {
> +        self.reserve(other.len(), flags)?;
> +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), o=
ther) {
> +            slot.write(item.clone());
> +        }
> +
> +        // SAFETY:
> +        // - `other.len()` spare entries have just been initialized, so =
it is safe to increase
> +        //   the length by the same number.
> +        // - `self.len() + other.len() <=3D self.capacity()` is guarante=
ed by the preceding `reserve`
> +        //   call.
> +        unsafe { self.set_len(self.len() + other.len()) };
> +        Ok(())
> +    }
> +
> +    /// Creates a Vec<T, A> from a pointer, a length and a capacity usin=
g the allocator `A`.
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
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `T` is a ZST:
> +    ///
> +    /// - `ptr` must be a dangling, well aligned pointer.
> +    ///
> +    /// Otherwise:
> +    ///
> +    /// - `ptr` must have been allocated with the allocator `A`.
> +    /// - `ptr` must satisfy or exceed the alignment requirements of `T`=
.
> +    /// - `ptr` must point to memory with a size of at least `size_of::<=
T>() * capacity`.
> +    ///    bytes.
> +    /// - The allocated size in bytes must not be larger than `isize::MA=
X`.
> +    /// - `length` must be less than or equal to `capacity`.
> +    /// - The first `length` elements must be initialized values of type=
 `T`.
> +    ///
> +    /// It is also valid to create an empty `Vec` passing a dangling poi=
nter for `ptr` and zero for
> +    /// `cap` and `len`.
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

Would be nice to have `debug_assert!(length <=3D capacity)` here. But feel
free to make that a good-first-issue instead of including it in the next
version. (there are probably more asserts elsewhere)

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
> +        let mut me =3D ManuallyDrop::new(self);
> +        let len =3D me.len();
> +        let capacity =3D me.capacity();
> +        let ptr =3D me.as_mut_ptr();
> +        (ptr, len, capacity)
> +    }

[...]

> +macro_rules! impl_slice_eq {
> +    ([$($vars:tt)*] $lhs:ty, $rhs:ty) =3D> {

You could wrap the entire pattern in "$()*", same for the entire body
and then...

> +        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
> +        where
> +            T: PartialEq<U>,
> +        {
> +            #[inline]
> +            fn eq(&self, other: &$rhs) -> bool { self[..] =3D=3D other[.=
.] }
> +        }
> +    }
> +}
> +
> +impl_slice_eq! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2> }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, &[U] }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, &mut [U] }
> +impl_slice_eq! { [A: Allocator] &[T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator] &mut [T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator] Vec<T, A>, [U] }
> +impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
> +impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
> +impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }

...we could have a single `impl_slice_eq` invocation here:

    impl_slice_eq! {
        [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>
        [A: Allocator] Vec<T, A>, &[U]
        [A: Allocator] Vec<T, A>, &mut [U]
        [A: Allocator] &[T], Vec<U, A>
        [A: Allocator] &mut [T], Vec<U, A>
        [A: Allocator] Vec<T, A>, [U]
        [A: Allocator] [T], Vec<U, A>
        [A: Allocator, const N: usize] Vec<T, A>, [U; N]
        [A: Allocator, const N: usize] Vec<T, A>, &[U; N]
    }

Not a huge improvement, but I think it makes it a bit nicer to read.

---
Cheers,
Benno

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


