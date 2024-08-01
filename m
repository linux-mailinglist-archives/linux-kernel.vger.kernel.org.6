Return-Path: <linux-kernel+bounces-271475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9256944EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F473282FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1913C8E8;
	Thu,  1 Aug 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vqj5ak5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CC13B7AA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524758; cv=none; b=rdizp52wKPHXt8HDAn28TU7aqTqr2wMVSsrqRtA0Lu/o4V18WVsf67Bqdot8mk7ok3r2ha0MTZ8PwtFWeFb3Nxl5+kk/HgzlKRyWGLHXclRxqk2OwtTnSHi0Ju4w5jTGIwZWNLHGPeTZj5j6PlvscK1pbtU9wt1+EWl9l56VVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524758; c=relaxed/simple;
	bh=ePo8GkeM4nVFloYEazW3BpDzOCWSRAHTqlN2DHgv4KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdDhbV/mDL2/1AvJ1rRZxTVzxuHSwovhCrjehJVMX6LSZdPwV6EhA8TcGUUrZMI2HztNS/T+jQL++cR4x6ns1L5ld440bd80t5t0/cwy3EZHgGTXldL8Rxt9zbAR+mrbtM0zGH4mSUzJmbBDaFp3ZE85HVLrQvm5Q7FIOKfmyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vqj5ak5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso83133101fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524754; x=1723129554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtjrYtBRW7HPHuNWK2QADXB0spXw5Ixm3gzQ1LJWqtc=;
        b=1vqj5ak5hhS7dF/1ShXBHEK/p8/RAXkE2ySLQJSj7Jh3NzXBR4kno2b/gSUmfDEDXT
         4C1ueqzAuGyNMxupXaGK4+E1x2UoxoILtRJkO30nEX9mtwn4GNOASKzEwcUuCoNWPein
         7aGoTo5tO75Mz+fwPUfu6y4FaC3kb4ujW9tbyAIdqQ51WgqcT2UCeZyqVNARg27UEvE0
         jt30waCfv1iJtZx+Jsj3tb7IYSJ8jSX6CHzUmogzVX8IgPcekzmo/qtnY6R3bPWc0Mcv
         01d1ZOIlKKBxi0vnNdhOYxeadqWoSLpk8bQxmR/e7akAesxyd+6gjZLgCGCeIZxfdoSm
         yYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524754; x=1723129554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtjrYtBRW7HPHuNWK2QADXB0spXw5Ixm3gzQ1LJWqtc=;
        b=S4asiLkeRu0zde3CJrrRwyRNKGeRT0p8ayRuB+iHVYrmXGyt9vlQaYqZV1NRSRczyG
         MPdaAJHX9Dzk30//Js1Nlp+HTC08KQfs0bOqTDXzqe15xIphxeCa22yiVzhK+YnmdPIw
         1W3av+LLeQcVY8TwTqJwMyBJaUnKgD/UuI/Gava43/burPcEuq87Tgvo0xFve4YEDqUj
         6/i1lKzDOiEuRYWPkSGd1UZc41zaYD7LyyvisIUc3wPIE4ydFZpxwyuduxnSjJd2PKl/
         DXq8xot+LtfRiwEi2BZx1p6M5K6iw/fQJlzvlBMRuN20fH1JQHYZbiL3N/06JrZrdJi4
         ISXg==
X-Forwarded-Encrypted: i=1; AJvYcCWgEJgxkO475y2XTm9I39zFA6g6nkVXAn4kMuRGNsFdlF2FziQKTsFSfky8A8UpuUyrwDdEWLtyr2V6i13IZ+jkmFFT/YcTP3FF/bZF
X-Gm-Message-State: AOJu0YzTRlfWT1I8yaaY8gLvUpNiEd6yTHlOSmPh6LdQStfLO3aqRlDu
	smmOJjvwN11xDrBEfL0LEkqq+lWYk2KP8miA09hX3Rr3py+RhEueDvVQNu4xMDKpV0onL627c4S
	NumqGrQnQgi+o5foA6hm8jDiz8Ux4zSfy6ob2
X-Google-Smtp-Source: AGHT+IFqCfiWfHfsKweigVZQ35+EcPbZAMHufT97KmZwepGFYhVqs3IGhjWfwd37yvqLFfvKIH+/7K6zBPvPsEocSpk=
X-Received: by 2002:a05:6512:4004:b0:52c:e312:2082 with SMTP id
 2adb3069b0e04-530bb3b527fmr109611e87.54.1722524752929; Thu, 01 Aug 2024
 08:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-16-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-16-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 17:05:41 +0200
Message-ID: <CAH5fLghHwv7-4NviGUA4dtL4EA+Wi380mY4MxvyH=+5=guc-Og@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] rust: alloc: implement kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:08=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> `Vec` provides a contiguous growable array type (such as `Vec`) with
> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> `Vmalloc` or `KVmalloc`).
>
> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs |  16 +-
>  rust/kernel/alloc/kvec.rs | 583 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  4 files changed, 605 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs
>
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 4bddd023aa7f..bd93140f3094 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod kbox;
> +pub mod kvec;
>  pub mod vec_ext;
>
>  #[cfg(any(test, testlib))]
> @@ -18,6 +19,11 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>
> +pub use self::kvec::KVVec;
> +pub use self::kvec::KVec;
> +pub use self::kvec::VVec;
> +pub use self::kvec::Vec;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 7074f00e07bc..39feaed4a8f8 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -2,7 +2,7 @@
>
>  //! Implementation of [`Box`].
>
> -use super::{AllocError, Allocator, Flags};
> +use super::{AllocError, Allocator, Flags, Vec};
>  use core::fmt;
>  use core::marker::PhantomData;
>  use core::mem::ManuallyDrop;
> @@ -169,6 +169,20 @@ pub fn into_pin(b: Self) -> Pin<Self>
>      }
>  }
>
> +impl<T, A, const N: usize> Box<[T; N], A>
> +where
> +    A: Allocator,
> +{
> +    /// Convert a `Box<[T], A>` to a `Vec<T, A>`.
> +    pub fn into_vec(b: Self) -> Vec<T, A> {

This doc-comment seems wrong. [T] and [T; N] are not the same thing.

> +        let len =3D b.len();
> +        unsafe {
> +            let ptr =3D Self::into_raw(b);
> +            Vec::from_raw_parts(ptr as _, len, len)
> +        }
> +    }
> +}
> +
>  impl<T, A> Box<MaybeUninit<T>, A>
>  where
>      A: Allocator,
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> new file mode 100644
> index 000000000000..04cc85f7d92c
> --- /dev/null
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -0,0 +1,583 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Vec`].
> +
> +use super::{AllocError, Allocator, Flags};
> +use crate::types::Unique;
> +use core::{
> +    fmt,
> +    marker::PhantomData,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::Deref,
> +    ops::DerefMut,
> +    ops::Index,
> +    ops::IndexMut,
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
> +    () =3D> (
> +        {
> +            $crate::alloc::KVec::new()
> +        }
> +    );
> +    ($elem:expr; $n:expr) =3D> (
> +        {
> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> +        }
> +    );
> +    ($($x:expr),+ $(,)?) =3D> (
> +        {
> +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> +                Ok(b) =3D> Ok($crate::alloc::KBox::into_vec(b)),
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
> +/// `Kmalloc`, `Vmalloc` or `KVmalloc`, written `Vec<T, A>`.

A closing bracket is missing in this sentence.

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
 the `Allocator` used to
> +/// allocate (and free) the backing buffer.
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
> +/// The [`Vec`] backing buffer's pointer always properly aligned and eit=
her points to memory
> +/// allocated with `A` or, for zero-sized types, is a dangling pointer.
> +///
> +/// The length of the vector always represents the exact number of eleme=
nts stored in the vector.
> +///
> +/// The capacity of the vector always represents the absolute number of =
elements that can be stored
> +/// within the vector without re-allocation. However, it is legal for th=
e backing buffer to be
> +/// larger than `size_of<T>` times the capacity.
> +///
> +/// The `Allocator` of the vector is the exact allocator the backing buf=
fer was allocated with (and
> +/// must be freed with).
> +pub struct Vec<T, A: Allocator> {
> +    ptr: Unique<T>,
> +    /// Never used for ZSTs; it's `capacity()`'s responsibility to retur=
n usize::MAX in that case.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `cap` must be in the `0..=3Disize::MAX` range.
> +    cap: usize,

This section header should say Invariants, not Safety.

> +    len: usize,
> +    _p: PhantomData<A>,
> +}
> +
> +/// Type alias for `Vec` with a `Kmalloc` allocator.
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
> +impl<T, A> Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    #[inline]
> +    fn is_zst() -> bool {
> +        core::mem::size_of::<T>() =3D=3D 0
> +    }
> +
> +    /// Returns the total number of elements the vector can hold without
> +    /// reallocating.
> +    pub fn capacity(&self) -> usize {
> +        if Self::is_zst() {
> +            usize::MAX
> +        } else {
> +            self.cap
> +        }
> +    }

I would consider always storing usize::MAX in the capacity field for zst ty=
pes?

> +
> +    /// Returns the number of elements in the vector, also referred to
> +    /// as its 'length'.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.len
> +    }
> +
> +    /// Forces the length of the vector to new_len.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `new_len` must be less than or equal to [`Self::capacity()`].
> +    /// - The elements at `old_len..new_len` must be initialized.
> +    #[inline]
> +    pub unsafe fn set_len(&mut self, new_len: usize) {
> +        self.len =3D new_len;
> +    }
> +
> +    /// Extracts a slice containing the entire vector.
> +    ///
> +    /// Equivalent to `&s[..]`.
> +    #[inline]
> +    pub fn as_slice(&self) -> &[T] {
> +        self
> +    }
> +
> +    /// Extracts a mutable slice of the entire vector.
> +    ///
> +    /// Equivalent to `&mut s[..]`.
> +    #[inline]
> +    pub fn as_mut_slice(&mut self) -> &mut [T] {
> +        self
> +    }
> +
> +    /// Returns an unsafe mutable pointer to the vector's buffer, or a d=
angling
> +    /// raw pointer valid for zero sized reads if the vector didn't allo=
cate.
> +    #[inline]
> +    pub fn as_mut_ptr(&self) -> *mut T {
> +        self.ptr.as_ptr()
> +    }
> +
> +    /// Returns a raw pointer to the slice's buffer.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const T {
> +        self.as_mut_ptr()
> +    }
> +
> +    /// Returns `true` if the vector contains no elements.
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
> +    /// Constructs a new, empty Vec<T, A>.
> +    ///
> +    /// This method does not allocate by itself.
> +    #[inline]
> +    pub const fn new() -> Self {
> +        Self {
> +            ptr: Unique::dangling(),
> +            cap: 0,
> +            len: 0,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Returns the remaining spare capacity of the vector as a slice of=
 `MaybeUninit<T>`.
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

Is this correct for ZSTs?

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
> +        unsafe { self.set_len(self.len() + other.len()) };
> +        Ok(())
> +    }
> +
> +    /// Creates a Vec<T, A> directly from a pointer, a length, a capacit=
y, and an allocator.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This is highly unsafe, due to the number of invariants that aren=
=E2=80=99t checked:
> +    ///
> +    /// - `ptr` must be currently allocated via the given allocator `A`.
> +    /// - `T` needs to have the same alignment as what `ptr` was allocat=
ed with. (`T` having a less
> +    ///   strict alignment is not sufficient, the alignment really needs=
 to be equal to satisfy the
> +    ///   `dealloc` requirement that memory must be allocated and deallo=
cated with the same layout.)
> +    /// - The size of `T` times the `capacity` (i.e. the allocated size =
in bytes) needs to be
> +    ///   smaller or equal the size the pointer was allocated with.
> +    /// - `length` needs to be less than or equal to `capacity`.
> +    /// - The first `length` values must be properly initialized values =
of type `T`.
> +    /// - The allocated size in bytes must be no larger than `isize::MAX=
`. See the safety
> +    ///   documentation of `pointer::offset`.
> +    ///
> +    /// It is also valid to create an empty `Vec` passing a dangling poi=
nter for `ptr` and zero for
> +    /// `cap` and `len`.
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
> +    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: u=
size) -> Self {
> +        let cap =3D if Self::is_zst() { 0 } else { capacity };
> +
> +        Self {
> +            // SAFETY: By the safety requirements, `ptr` is either dangl=
ing or pointing to a valid
> +            // memory allocation, allocated with `A`.
> +            ptr: unsafe { Unique::new_unchecked(ptr) },
> +            cap,
> +            len: length,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +
> +    /// Decomposes a `Vec<T, A>` into its raw components: (`pointer`, `l=
ength`, `capacity`).
> +    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
> +        let me =3D ManuallyDrop::new(self);
> +        let len =3D me.len();
> +        let capacity =3D me.capacity();
> +        let ptr =3D me.as_mut_ptr();
> +        (ptr, len, capacity)
> +    }
> +
> +    /// Ensures that the capacity exceeds the length by at least `additi=
onal` elements.
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
> +            return Err(AllocError);
> +        }
> +
> +        // We know cap is <=3D `isize::MAX` because `Layout::array` fail=
s if the resulting byte size
> +        // is greater than `isize::MAX`. So the multiplication by two wo=
n't overflow.

You know it won't overflow because of the type invariants. The thing
about Layout::array should instead be used to argue why setting
self.cap below does not break the invariants.

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
> +            Some(self.ptr.as_non_null().cast())
> +        };
> +
> +        // SAFETY: `ptr` is valid because it's either `None` or comes fr=
om a previous call to
> +        // `A::realloc`. We also verified that the type is not a ZST.
> +        let ptr =3D unsafe { A::realloc(ptr, layout, flags)? };
> +
> +        self.ptr =3D ptr.cast().into();
> +        self.cap =3D new_cap;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T: Clone, A: Allocator> Vec<T, A> {
> +    /// Extend the vector by `n` clones of value.
> +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> R=
esult<(), AllocError> {
> +        self.reserve(n, flags)?;
> +
> +        let spare =3D self.spare_capacity_mut();
> +
> +        for i in 0..spare.len() - 1 {
> +            spare[i].write(value.clone());
> +        }

Minus one? Shouldn't this instead loop for `0..n`?

> +
> +        // We can write the last element directly without cloning needle=
ssly
> +        spare[spare.len() - 1].write(value);

spare[n-1].write(value);

> +
> +        // SAFETY: `self.reserve` not bailing out with an error guarante=
es that we're not
> +        // exceeding the capacity of this `Vec`.
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
> +                self.as_mut_ptr(),
> +                self.len,
> +            ))
> +        };
> +
> +        // If `cap =3D=3D 0` we never allocated any memory in the first =
place.
> +        if self.cap !=3D 0 {
> +            // SAFETY: `self.ptr` was previously allocated with `A`.
> +            unsafe { A::free(self.ptr.as_non_null().cast()) };

Do you need a ZST check here?

> +        }
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
> +    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?) =3D=
> {
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
> index 6bf77577eae7..bb80a43d20fb 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox=
};
> +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVe=
c, KVec, VBox, VVec};
>
>  #[doc(no_inline)]
>  pub use alloc::vec::Vec;
> --
> 2.45.2
>

