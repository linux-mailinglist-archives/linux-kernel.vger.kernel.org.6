Return-Path: <linux-kernel+bounces-269563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B61943458
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DDC1C219F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504B1BC09A;
	Wed, 31 Jul 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="i+0frub6"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376E12E5D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444465; cv=none; b=usSb1IVN78uA4RAoTtMwMWEGd8gfJtemEClwcVRqv007/VA7JvG5IKfxMBtVeA/x0PhFX8WZ8iRB98TcGKVZyd2IzpWWTwvhF9Yf9fpX6AmyyWffSYVbwRikp8aNPeNaRA3e+2Z7WsBhl36I2NVfquHmYkCyddy/LLQ0YJvbhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444465; c=relaxed/simple;
	bh=edgvm2Q3OZYieY5CspNnSLWxLbxk2yKGuPsYgCmOjmk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bp4lqGA3U6U2ND0BhLAE1KFSk3RWAzl+M1lRVWPnxskoPzKye6Td7gcX/CHW6nH+91agiEqfS5+pFkMs7yTEuR87mGiO4i7ztbVKXixizkme7wKwlm+IqV/1q5nWJ2M6e3A1wazJ+ZROtZfH1xseh9gKRI0CohdHD4KH6/4/1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=i+0frub6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=f4buewgm5nel5i5zajc23htsmm.protonmail; t=1722444455; x=1722703655;
	bh=edOmevzsP+AiSRfaNCtnPpPP2xx1h3JfYBiL6PV3izg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i+0frub6IBBNbBEcMppbgPL8u/90kCNSm+tAWgx8GSq9+tqzE3dt2BzKG+Qjrnqm0
	 WA9YgIjykf0OVQUV0fzU3w5LAfyDUOFAe2PqlpHFcu3Vq+4Yizzh0lCcS3M2rTNbV8
	 6N3JR03yol39ft//g6kLB4ImCuX58oK4HF2x4HXgSTYlOPZ7cpLQ808hIKEDYDgy/6
	 4t/6IuvPkiAFnw8h+wcUZ45ZgkWwojaI0S8gQkWZuFeiCN4KHpjLucTCwrNC+InwGU
	 WFbrL9Gp4D9Lk4ZXuAlTJ/h1BG8NTrSqE4CUqrbTSpx+hN7YUE3IyMGRGQ3HaloT32
	 xWtyZEeTjdV/g==
Date: Wed, 31 Jul 2024 16:47:27 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 02/10] rust: list: add ListArc
Message-ID: <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me>
In-Reply-To: <20240723-linked-list-v3-2-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-2-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4696937061c3af902ab0f34209c7f5ccd75e6a44
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
> The `ListArc` type can be thought of as a special reference to a
> refcounted object that owns the permission to manipulate the
> `next`/`prev` pointers stored in the refcounted object. By ensuring that
> each object has only one `ListArc` reference, the owner of that
> reference is assured exclusive access to the `next`/`prev` pointers.
> When a `ListArc` is inserted into a `List`, the `List` takes ownership
> of the `ListArc` reference.
>=20
> There are various strategies for ensuring that a value has only one
> `ListArc` reference. The simplest is to convert a `UniqueArc` into a
> `ListArc`. However, the refcounted object could also keep track of
> whether a `ListArc` exists using a boolean, which could allow for the
> creation of new `ListArc` references from an `Arc` reference. Whatever
> strategy is used, the relevant tracking is referred to as "the tracking
> inside `T`", and the `ListArcSafe` trait (and its subtraits) are used to
> update the tracking when a `ListArc` is created or destroyed.
>=20
> Note that we allow the case where the tracking inside `T` thinks that a
> `ListArc` exists, but actually, there isn't a `ListArc`. However, we do
> not allow the opposite situation where a `ListArc` exists, but the
> tracking thinks it doesn't. This is because the former can at most
> result in us failing to create a `ListArc` when the operation could
> succeed, whereas the latter can result in the creation of two `ListArc`
> references.

You could add at the end of this paragraph that the latter is a
soundness issue and could lead to memory bugs, but the former cannot.

> This patch introduces the `impl_list_arc_safe!` macro that allows you to
> implement `ListArcSafe` for types using the strategy where a `ListArc`
> can only be created from a `UniqueArc`. Other strategies are introduced
> in later patches.

[...]

> diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
> new file mode 100644
> index 000000000000..3b7072e58256
> --- /dev/null
> +++ b/rust/kernel/list/arc.rs
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! A wrapper around `Arc` for linked lists.
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::prelude::*;
> +use crate::sync::{Arc, ArcBorrow, UniqueArc};
> +use core::marker::Unsize;
> +use core::ops::Deref;
> +use core::pin::Pin;
> +
> +/// Declares that this type has some way to ensure that there is exactly=
 one `ListArc` instance for
> +/// this id.
> +///
> +/// Types that implement this trait should include some kind of logic fo=
r keeping track of whether
> +/// a [`ListArc`] exists or not. We refer to this logic as "the tracking=
 inside `T`".
> +///
> +/// We allow the case where the tracking inside `T` thinks that a [`List=
Arc`] exists, but actually,
> +/// there isn't a [`ListArc`]. However, we do not allow the opposite sit=
uation where a [`ListArc`]
> +/// exists, but the tracking thinks it doesn't. This is because the form=
er can at most result in us
> +/// failing to create a [`ListArc`] when the operation could succeed, wh=
ereas the latter can result
> +/// in the creation of two [`ListArc`] references.

Would be good to also add it here.

> +///
> +/// A consequence of the above is that you may implement the tracking in=
side `T` by not actually
> +/// keeping track of anything. To do this, you always claim that a [`Lis=
tArc`] exists, even if
> +/// there isn't one. This implementation is allowed by the above rule, b=
ut it means that
> +/// [`ListArc`] references can only be created if you have ownership of =
*all* references to the
> +/// refcounted object, as you otherwise have no way of knowing whether a=
 [`ListArc`] exists.
> +pub trait ListArcSafe<const ID: u64 =3D 0> {
> +    /// Informs the tracking inside this type that it now has a [`ListAr=
c`] reference.
> +    ///
> +    /// This method may be called even if the tracking inside this type =
thinks that a `ListArc`
> +    /// reference exists. (But only if that's not actually the case.)
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must not be called if a [`ListArc`] already exist for this value=
.
> +    unsafe fn on_create_list_arc_from_unique(self: Pin<&mut Self>);
> +
> +    /// Informs the tracking inside this type that there is no [`ListArc=
`] reference anymore.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must only be called if there is no [`ListArc`] reference, but th=
e tracking thinks there is.
> +    unsafe fn on_drop_list_arc(&self);
> +}
> +
> +/// Declares that this type supports [`ListArc`].
> +///
> +/// When using this macro, it will only be possible to create a [`ListAr=
c`] from a [`UniqueArc`].
> +#[macro_export]
> +macro_rules! impl_list_arc_safe {
> +    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untrack=
ed; } $($rest:tt)*) =3D> {
> +        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
> +            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::=
Pin<&mut Self>) {}
> +            unsafe fn on_drop_list_arc(&self) {}
> +        }
> +        $crate::list::impl_list_arc_safe! { $($rest)* }
> +    };
> +
> +    () =3D> {};
> +}
> +pub use impl_list_arc_safe;
> +
> +/// A wrapper around [`Arc`] that's guaranteed unique for the given id.
> +///
> +/// The `ListArc` type can be thought of as a special reference to a ref=
counted object that owns the
> +/// permission to manipulate the `next`/`prev` pointers stored in the re=
fcounted object. By ensuring
> +/// that each object has only one `ListArc` reference, the owner of that=
 reference is assured
> +/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is =
inserted into a `List`, the
> +/// `List` takes ownership of the `ListArc` reference.
> +///
> +/// There are various strategies to ensuring that a value has only one `=
ListArc` reference. The
> +/// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, th=
e refcounted object could
> +/// also keep track of whether a `ListArc` exists using a boolean, which=
 could allow for the
> +/// creation of new `ListArc` references from an [`Arc`] reference. What=
ever strategy is used, the
> +/// relevant tracking is referred to as "the tracking inside `T`", and t=
he [`ListArcSafe`] trait
> +/// (and its subtraits) are used to update the tracking when a `ListArc`=
 is created or destroyed.
> +///
> +/// Note that we allow the case where the tracking inside `T` thinks tha=
t a `ListArc` exists, but
> +/// actually, there isn't a `ListArc`. However, we do not allow the oppo=
site situation where a
> +/// `ListArc` exists, but the tracking thinks it doesn't. This is becaus=
e the former can at most
> +/// result in us failing to create a `ListArc` when the operation could =
succeed, whereas the latter
> +/// can result in the creation of two `ListArc` references.
> +///
> +/// # Invariants
> +///
> +/// * Each reference counted object has at most one `ListArc` for each v=
alue of `ID`.
> +/// * The tracking inside `T` is aware that a `ListArc` reference exists=
.

I am not entirely sure where to put this, but I think it might be good
as the first paragraph or directly after the first:
   =20
    While this `ListArc` is unique for the given id, there still might
    exist normal `Arc` references to the object.

Feel free to modify it (I am not really happy with "object").

> +#[repr(transparent)]
> +pub struct ListArc<T, const ID: u64 =3D 0>
> +where
> +    T: ListArcSafe<ID> + ?Sized,
> +{
> +    arc: Arc<T>,
> +}

[...]

> +    /// Transmutes an [`Arc`] into a `ListArc` without updating the trac=
king inside `T`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The value must not already have a `ListArc` reference.
> +    /// * The tracking inside `T` must think that there is a `ListArc` r=
eference.
> +    #[inline]
> +    unsafe fn transmute_from_arc(arc: Arc<T>) -> Self {

I think the name is inaccurate now, since it is no longer a transmute,
so maybe `from_arc_unchecked`?

> +        // INVARIANT: By the safety requirements, the invariants on `Lis=
tArc` are satisfied.
> +        Self { arc }
> +    }
> +
> +    /// Transmutes a `ListArc` into an [`Arc`] without updating the trac=
king inside `T`.
> +    ///
> +    /// After this call, the tracking inside `T` will still think that t=
here is a `ListArc`
> +    /// reference.
> +    #[inline]
> +    fn transmute_to_arc(self) -> Arc<T> {

Maybe also change this then to be consistent, since the name `transmute`
carries a "dangerous" feel to it, but this is actually totally safe.

> +        // Use a transmute to skip destructor.
> +        //
> +        // SAFETY: ListArc is repr(transparent).
> +        unsafe { core::mem::transmute(self) }
> +    }

[...]

> +// This is to allow [`ListArc`] (and variants) to be used as the type of=
 `self`.
> +impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T: L=
istArcSafe<ID> + ?Sized {}
> +
> +// This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` ca=
n be converted to the
> +// dynamically-sized type (DST) `U`.
> +impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for L=
istArc<T, ID>
> +where
> +    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
> +    U: ListArcSafe<ID> + ?Sized,
> +{
> +}
> +
> +// This is to allow `ListArc<U>` to be dispatched on when `ListArc<T>` c=
an be coerced into
> +// `ListArc<U>`.
> +impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for=
 ListArc<T, ID>
> +where
> +    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
> +    U: ListArcSafe<ID> + ?Sized,
> +{
> +}

Can we start using `feature(derive_smart_pointer)` on new enough
compiler versions? (I guess you probably want it as a separate patch
series to avoid delaying this in case it needs anything [eg the new
build system])
Do we need any Makefile modifications for that or could we just do
`#[cfg_attr(compiler-is-new-enough, derive(SmartPointer))` on the struct
and then cfg these impls away? (and what would "compiler-is-new-enough"
be?)


Aside from my docs nits, this looks good:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

(feel free to discuss any changes, I am not set on the exact phrasing)

---
Cheers,
Benno


