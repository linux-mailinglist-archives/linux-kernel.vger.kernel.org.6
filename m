Return-Path: <linux-kernel+bounces-309701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A4C966F72
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6DF282C14
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9514B968;
	Sat, 31 Aug 2024 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HE7AO8Vi"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055D8468;
	Sat, 31 Aug 2024 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082758; cv=none; b=J0j5KCkf4iLTrSeopvppAauHfa/72qdKGFbEnBwI/c0VKI55mGfs9bl6rVbHyZbSW+paQ60EsduBU26zs9RZjQmRjUJGqJta8nwygFlM3AzqZh/tMPqstmLvQD5OuTju4Ry2rzhjAoSgzxJh9VrGHAOxcRolxm90kTYux89MJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082758; c=relaxed/simple;
	bh=nVTvmuFsiMH7S3o2lPBdbIJ/ylJBLCeluk9F3OG8QmA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhftuGTvjoEgXcyc0e6rfbu93ZfDbuIUt8wY9FIBsEbFsGxOEAFr0fklltmCMm9+uw1a8id8mdW7TiyFDnPK5bU9TFuYkxi9F+vNf8WZfUaVyGx/GIcqFk0DNYoGnFY/XC1k9wRi6+TzsPtHAGWRnb0qKsLZjYd2lrkDOFIeHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HE7AO8Vi; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725082753; x=1725341953;
	bh=H0yhunYtVRJSRKYFJ1oR8mA4txjPQQLzLVyKGXLbgQw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HE7AO8Vi8VdhtuYn2MrDdC+iDn1DisKqFwwCfE+hI4fXCXk0EnLoXihOTHOyl2uHc
	 L7P1tVQX5LB8vRKuH8Adj7Kea9FSGCKR25ZTwnlqMUX304PKVqfesD5WO9YUi1dKNr
	 6SY0rybcldbSRTLNll9cCEulSWm+IJoSZs55q7EZb5TGz5gaZxRjyPuqvOXTrmIs9T
	 NupZfN0+ByG0JW75Hqlm0nfiBoZiRtv/f9FIfWxyosHFRfU8pVRybpnP86ogwxzgJQ
	 0FmftV8e9OsgQV2jM5FpieFuJc29D9k+XkZrfbp9LUany8oFuBFaqx+VhS2DtLqTen
	 iAsvEJtRRVRDg==
Date: Sat, 31 Aug 2024 05:39:07 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>
In-Reply-To: <20240816001216.26575-10-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-10-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 698fe482ee03c71dfbffcc1aecbcd36dd1de7e9e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> new file mode 100644
> index 000000000000..93b1ab9de6e8
> --- /dev/null
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -0,0 +1,480 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Box`].
> +
> +#[allow(unused_imports)] // Used in doc comments.
> +use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
> +use super::{AllocError, Allocator, Flags};
> +use core::fmt;
> +use core::marker::PhantomData;
> +use core::mem::ManuallyDrop;
> +use core::mem::MaybeUninit;
> +use core::ops::{Deref, DerefMut};
> +use core::pin::Pin;
> +use core::ptr::NonNull;
> +use core::result::Result;
> +
> +use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
> +use crate::types::ForeignOwnable;
> +
> +/// The kernel's [`Box`] type - a heap allocation for a single value of =
type `T`.

A single `-` doesn't really render nicely in markdown, instead use a
double or triple dash (`--` or `---`).

> +///
> +/// This is the kernel's version of the Rust stdlib's `Box`. There are s=
everal of differences,
> +/// for example no `noalias` attribute is emitted and partially moving o=
ut of a `Box` is not
> +/// supported. There are also several API differences, e.g. `Box` always=
 requires an [`Allocator`]
> +/// implementation to be passed as generic, page [`Flags`] when allocati=
ng memory and all functions
> +/// that may allocate memory are failable.

Do you mean fallible?

> +///
> +/// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [=
`Vmalloc`] or [`KVmalloc`].
> +/// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`=
], [`KVBox`]).
> +///
> +/// When dropping a [`Box`], the value is also dropped and the heap memo=
ry is automatically freed.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err()=
);
> +/// ```

It would be nice if you could add something like "KBox can't handle big
allocations:" above this example, so that people aren't confused why
this example expects an error.

> +///
> +/// ```
> +/// # use kernel::bindings;
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> +/// ```

Similarly, you could then say above this one "Instead use either `VBox`
or `KVBox`:"

> +///
> +/// # Invariants
> +///
> +/// The [`Box`]' pointer is always properly aligned and either points to=
 memory allocated with `A`

Please use `self.0` instead of "[`Box`]'".

> +/// or, for zero-sized types, is a dangling pointer.

Probably "dangling, well aligned pointer.".

> +#[repr(transparent)]
> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> +
> +/// Type alias for `Box` with a [`Kmalloc`] allocator.

Can you make these `Box` references links?

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KBox<T> =3D Box<T, super::allocator::Kmalloc>;
> +
> +/// Type alias for `Box` with a [`Vmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D VBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type VBox<T> =3D Box<T, super::allocator::Vmalloc>;
> +
> +/// Type alias for `Box` with a [`KVmalloc`] allocator.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KVBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
> +
> +// SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`=
.
> +unsafe impl<T, A> Send for Box<T, A>
> +where
> +    T: Send + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the `Box` owns a `T`=
.
> +unsafe impl<T, A> Sync for Box<T, A>
> +where
> +    T: Sync + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Creates a new `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For non-ZSTs, `raw` must point at an allocation allocated with `=
A`that is sufficiently
> +    /// aligned for and holds a valid `T`. The caller passes ownership o=
f the allocation to the
> +    /// `Box`.

You don't say what must happen for ZSTs.

> +    #[inline]
> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> +        // INVARIANT: Validity of `raw` is guaranteed by the safety prec=
onditions of this function.
> +        // SAFETY: By the safety preconditions of this function, `raw` i=
s not a NULL pointer.
> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
> +    }
> +
> +    /// Consumes the `Box<T, A>` and returns a raw pointer.
> +    ///
> +    /// This will not run the destructor of `T` and for non-ZSTs the all=
ocation will stay alive
> +    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop=
 the value and free the
> +    /// allocation, if any.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let x =3D KBox::new(24, GFP_KERNEL)?;
> +    /// let ptr =3D KBox::into_raw(x);
> +    /// let x =3D unsafe { KBox::from_raw(ptr) };
> +    ///
> +    /// assert_eq!(*x, 24);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn into_raw(b: Self) -> *mut T {
> +        let b =3D ManuallyDrop::new(b);
> +
> +        b.0.as_ptr()
> +    }
> +
> +    /// Consumes and leaks the `Box<T, A>` and returns a mutable referen=
ce.
> +    ///
> +    /// See [Box::into_raw] for more details.
> +    #[inline]
> +    pub fn leak<'a>(b: Self) -> &'a mut T {
> +        // SAFETY: `Box::into_raw` always returns a properly aligned and=
 dereferenceable pointer
> +        // which points to an initialized instance of `T`.
> +        unsafe { &mut *Box::into_raw(b) }
> +    }
> +}
> +
> +impl<T, A> Box<MaybeUninit<T>, A>
> +where
> +    A: Allocator,
> +{
> +    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
> +    ///
> +    /// It is undefined behavior to call this function while the value i=
nside of `b` is not yet
> +    /// fully initialized.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the value inside of `b` is in an initia=
lized state.
> +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
> +        let raw =3D Self::into_raw(b);
> +
> +        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. =
By the safety requirements
> +        // of this function, the value inside the `Box` is in an initial=
ized state. Hence, it is
> +        // safe to reconstruct the `Box` as `Box<T, A>`.
> +        unsafe { Box::from_raw(raw as *mut T) }

You should be able to use `.cast()` instead.

> +    }
> +
> +    /// Writes the value and converts to `Box<T, A>`.
> +    pub fn write(mut b: Self, value: T) -> Box<T, A> {
> +        (*b).write(value);
> +        // SAFETY: We've just initialized `boxed`'s value.

The variable is called `b`.

> +        unsafe { Self::assume_init(b) }
> +    }
> +}

[...]

> +impl<T, A> Drop for Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        let size =3D core::mem::size_of_val::<T>(self);
> +
> +        // SAFETY: We need to drop `self.0` in place, before we free the=
 backing memory.

This is the reason you are calling this function, not the justification
why it is OK to do so. (the pointer is valid)

> +        unsafe { core::ptr::drop_in_place(self.0.as_ptr()) };

Instead of using the raw pointer directly, you can also just use
`deref_mut`.

> +
> +        if size !=3D 0 {
> +            // SAFETY: `ptr` was previously allocated with `A`.

There is no variable `ptr`, this is guaranteed by the type invariant of
`Self`.

---
Cheers,
Benno

> +            unsafe { A::free(self.0.cast()) };
> +        }
> +    }
> +}
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 4571daec0961..a9210634a8c3 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>=20
> -pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
> +pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox,=
 KVBox, VBox};
>=20
>  #[doc(no_inline)]
>  pub use alloc::{boxed::Box, vec::Vec};
> --
> 2.46.0
>=20


