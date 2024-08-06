Return-Path: <linux-kernel+bounces-276241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FD9490D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3766C1C20CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50821D54C2;
	Tue,  6 Aug 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPnAOfAD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61141D1F74
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950225; cv=none; b=BI3slZNdliYTJtkdNtRKTnHS0zXXofUxVeeQR973OMhL5JPlskWUa1qBy95kkrV+nFu8xHWCQNwBnYqEOFL9QRcg/+ghNei1Rwv75bEvpi+R5Qb8eAMIOURpl8KPzf6/eNpdJcj/T7HqGVYk1E6M5XV9Y3PoJLPhWIio99tx/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950225; c=relaxed/simple;
	bh=cTRTyIDMn3MXYks3WINnYxjGOWhl+xHAxsmO0ve25FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMbsmrs97SDDN4D0b4K47sKXWxIRo63ZiGRMIsol37DhvclRPNwxboTS3LE/puu+SaUqVkhfOOmP5F499HjIPptf0wHmUW0HULr0vJuJe2VYbDzwbn6TVDoMip7tDRERumSqoHteG6UONBIXiUvpq4A65kmO7hc8Q7vZvHq/fJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPnAOfAD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1d6369acso4714575b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722950223; x=1723555023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vknjE8oI0ISNoQVSLMAjTHw98TAliTm25RV1z5lh2k=;
        b=vPnAOfADtQPBvseZ0vrvAlf9lyX3wBRrItho4VP2qkayukJKrdFDXZwS9RE797kvhd
         //SgVDkMSol0IEBSkZB6YXdakMyvj7/gVM75HXjuB9zz5rineXE7oM2YJ/2pdfN7dwsj
         cCS/VjobRy+MJXOj2D5laxP//cjK59Ek5cw+sj9tXEkpuKqJXZutThOpx3Vv/V8ZbJYT
         JjrColPXODFx7KnQLTVzR+xnNA4IrRYni9hKRrpkA/AeKzNJbL6nDcUN/YaldRG0Z15A
         T+YRetDejYGtIJowWvGigs+rqdcbXYwZvBpbhrNud4fqTlD2znQhs/5VrxNEiFU3mf30
         AOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950223; x=1723555023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vknjE8oI0ISNoQVSLMAjTHw98TAliTm25RV1z5lh2k=;
        b=A2r6KnB+BaqsPllGZ4imTJexIkAwbVDHqXkluz2HXIEhLo8rx6RttbjXFT2QLy7BSK
         HUqgiGnr8XkpAlOcL0sGfqlHcWR1kOmLNYbOvevduL0g1bUdCIV3uklQJblUKvKth5VA
         aHu6eWWf9Wufs1u0c/ZtFe7mvcQWNbwUfeBDBMBJ47X5r4kohPqIMrcXld1+4g+rCf6U
         xMMbtSzHxi+BUjkcWEj2rfykX1ehL9ZpzSvX5aS+4YY3fuP9/wLBNonG/mQS6HA7yNjX
         naMNFtLcExpg2ecECnfdncMoLcFa6YA8QFKoLF29IIoUKosR3Wx4c75y0Ik2uzyA7Hkx
         /Vtw==
X-Forwarded-Encrypted: i=1; AJvYcCVD2/PflNclpKe41mtuBkA3Uw7tWh7DityKipzFgBUsCtbZchpXqjcwdFMWSeOeVaBVvK7YDRU7I9MewWQWe7ig0Ej/Arvs4tUiJsT1
X-Gm-Message-State: AOJu0Yy/uIy52Yw82CgNd0J9NZdziSSVaLKpN37eFPZgo1zCOALIhiCJ
	V2cYqwVf5EgfaejONZv3EjnoiloL3nqxtkR0AEtHUyUpk9SjZF9iE+dBbPmuKBN0kFBCwNl43/r
	VFdOMN5qlRg9QgBZr1oPXQrDwV6KITbtZoEDn
X-Google-Smtp-Source: AGHT+IGFgEjy6yNcS10S4+ojZ0Kd1MXYEExVKiQlwySOuNMHXzHi7+k+ftBKSW3/awNZvBa4RRr3LrPh+aqMNMAdTUg=
X-Received: by 2002:a05:6a20:3d90:b0:1c4:a4f2:6f77 with SMTP id
 adf61e73a8af0-1c69a5f2e5dmr19563161637.15.1722950222416; Tue, 06 Aug 2024
 06:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-2-89db92c7dbf4@google.com> <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me>
In-Reply-To: <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 15:16:47 +0200
Message-ID: <CAH5fLgj3VNyw054Bw9OrPp3QLKTv+k8+_LWCdQTuCPxV2Vg6Rw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] rust: list: add ListArc
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:47=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 23.07.24 10:22, Alice Ryhl wrote:
> > The `ListArc` type can be thought of as a special reference to a
> > refcounted object that owns the permission to manipulate the
> > `next`/`prev` pointers stored in the refcounted object. By ensuring tha=
t
> > each object has only one `ListArc` reference, the owner of that
> > reference is assured exclusive access to the `next`/`prev` pointers.
> > When a `ListArc` is inserted into a `List`, the `List` takes ownership
> > of the `ListArc` reference.
> >
> > There are various strategies for ensuring that a value has only one
> > `ListArc` reference. The simplest is to convert a `UniqueArc` into a
> > `ListArc`. However, the refcounted object could also keep track of
> > whether a `ListArc` exists using a boolean, which could allow for the
> > creation of new `ListArc` references from an `Arc` reference. Whatever
> > strategy is used, the relevant tracking is referred to as "the tracking
> > inside `T`", and the `ListArcSafe` trait (and its subtraits) are used t=
o
> > update the tracking when a `ListArc` is created or destroyed.
> >
> > Note that we allow the case where the tracking inside `T` thinks that a
> > `ListArc` exists, but actually, there isn't a `ListArc`. However, we do
> > not allow the opposite situation where a `ListArc` exists, but the
> > tracking thinks it doesn't. This is because the former can at most
> > result in us failing to create a `ListArc` when the operation could
> > succeed, whereas the latter can result in the creation of two `ListArc`
> > references.
>
> You could add at the end of this paragraph that the latter is a
> soundness issue and could lead to memory bugs, but the former cannot.

Will do.

> > This patch introduces the `impl_list_arc_safe!` macro that allows you t=
o
> > implement `ListArcSafe` for types using the strategy where a `ListArc`
> > can only be created from a `UniqueArc`. Other strategies are introduced
> > in later patches.
>
> [...]
>
> > diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
> > new file mode 100644
> > index 000000000000..3b7072e58256
> > --- /dev/null
> > +++ b/rust/kernel/list/arc.rs
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! A wrapper around `Arc` for linked lists.
> > +
> > +use crate::alloc::{AllocError, Flags};
> > +use crate::prelude::*;
> > +use crate::sync::{Arc, ArcBorrow, UniqueArc};
> > +use core::marker::Unsize;
> > +use core::ops::Deref;
> > +use core::pin::Pin;
> > +
> > +/// Declares that this type has some way to ensure that there is exact=
ly one `ListArc` instance for
> > +/// this id.
> > +///
> > +/// Types that implement this trait should include some kind of logic =
for keeping track of whether
> > +/// a [`ListArc`] exists or not. We refer to this logic as "the tracki=
ng inside `T`".
> > +///
> > +/// We allow the case where the tracking inside `T` thinks that a [`Li=
stArc`] exists, but actually,
> > +/// there isn't a [`ListArc`]. However, we do not allow the opposite s=
ituation where a [`ListArc`]
> > +/// exists, but the tracking thinks it doesn't. This is because the fo=
rmer can at most result in us
> > +/// failing to create a [`ListArc`] when the operation could succeed, =
whereas the latter can result
> > +/// in the creation of two [`ListArc`] references.
>
> Would be good to also add it here.

Will do.

> > +///
> > +/// A consequence of the above is that you may implement the tracking =
inside `T` by not actually
> > +/// keeping track of anything. To do this, you always claim that a [`L=
istArc`] exists, even if
> > +/// there isn't one. This implementation is allowed by the above rule,=
 but it means that
> > +/// [`ListArc`] references can only be created if you have ownership o=
f *all* references to the
> > +/// refcounted object, as you otherwise have no way of knowing whether=
 a [`ListArc`] exists.
> > +pub trait ListArcSafe<const ID: u64 =3D 0> {
> > +    /// Informs the tracking inside this type that it now has a [`List=
Arc`] reference.
> > +    ///
> > +    /// This method may be called even if the tracking inside this typ=
e thinks that a `ListArc`
> > +    /// reference exists. (But only if that's not actually the case.)
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Must not be called if a [`ListArc`] already exist for this val=
ue.
> > +    unsafe fn on_create_list_arc_from_unique(self: Pin<&mut Self>);
> > +
> > +    /// Informs the tracking inside this type that there is no [`ListA=
rc`] reference anymore.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Must only be called if there is no [`ListArc`] reference, but =
the tracking thinks there is.
> > +    unsafe fn on_drop_list_arc(&self);
> > +}
> > +
> > +/// Declares that this type supports [`ListArc`].
> > +///
> > +/// When using this macro, it will only be possible to create a [`List=
Arc`] from a [`UniqueArc`].
> > +#[macro_export]
> > +macro_rules! impl_list_arc_safe {
> > +    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untra=
cked; } $($rest:tt)*) =3D> {
> > +        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t=
 {
> > +            unsafe fn on_create_list_arc_from_unique(self: ::core::pin=
::Pin<&mut Self>) {}
> > +            unsafe fn on_drop_list_arc(&self) {}
> > +        }
> > +        $crate::list::impl_list_arc_safe! { $($rest)* }
> > +    };
> > +
> > +    () =3D> {};
> > +}
> > +pub use impl_list_arc_safe;
> > +
> > +/// A wrapper around [`Arc`] that's guaranteed unique for the given id=
.
> > +///
> > +/// The `ListArc` type can be thought of as a special reference to a r=
efcounted object that owns the
> > +/// permission to manipulate the `next`/`prev` pointers stored in the =
refcounted object. By ensuring
> > +/// that each object has only one `ListArc` reference, the owner of th=
at reference is assured
> > +/// exclusive access to the `next`/`prev` pointers. When a `ListArc` i=
s inserted into a `List`, the
> > +/// `List` takes ownership of the `ListArc` reference.
> > +///
> > +/// There are various strategies to ensuring that a value has only one=
 `ListArc` reference. The
> > +/// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, =
the refcounted object could
> > +/// also keep track of whether a `ListArc` exists using a boolean, whi=
ch could allow for the
> > +/// creation of new `ListArc` references from an [`Arc`] reference. Wh=
atever strategy is used, the
> > +/// relevant tracking is referred to as "the tracking inside `T`", and=
 the [`ListArcSafe`] trait
> > +/// (and its subtraits) are used to update the tracking when a `ListAr=
c` is created or destroyed.
> > +///
> > +/// Note that we allow the case where the tracking inside `T` thinks t=
hat a `ListArc` exists, but
> > +/// actually, there isn't a `ListArc`. However, we do not allow the op=
posite situation where a
> > +/// `ListArc` exists, but the tracking thinks it doesn't. This is beca=
use the former can at most
> > +/// result in us failing to create a `ListArc` when the operation coul=
d succeed, whereas the latter
> > +/// can result in the creation of two `ListArc` references.
> > +///
> > +/// # Invariants
> > +///
> > +/// * Each reference counted object has at most one `ListArc` for each=
 value of `ID`.
> > +/// * The tracking inside `T` is aware that a `ListArc` reference exis=
ts.
>
> I am not entirely sure where to put this, but I think it might be good
> as the first paragraph or directly after the first:
>
>     While this `ListArc` is unique for the given id, there still might
>     exist normal `Arc` references to the object.
>
> Feel free to modify it (I am not really happy with "object").

I added something about that above the heading.

> > +#[repr(transparent)]
> > +pub struct ListArc<T, const ID: u64 =3D 0>
> > +where
> > +    T: ListArcSafe<ID> + ?Sized,
> > +{
> > +    arc: Arc<T>,
> > +}
>
> [...]
>
> > +    /// Transmutes an [`Arc`] into a `ListArc` without updating the tr=
acking inside `T`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * The value must not already have a `ListArc` reference.
> > +    /// * The tracking inside `T` must think that there is a `ListArc`=
 reference.
> > +    #[inline]
> > +    unsafe fn transmute_from_arc(arc: Arc<T>) -> Self {
>
> I think the name is inaccurate now, since it is no longer a transmute,
> so maybe `from_arc_unchecked`?

I think it's fine to keep the transmute name. It gives the right connotatio=
ns.

> > +        // INVARIANT: By the safety requirements, the invariants on `L=
istArc` are satisfied.
> > +        Self { arc }
> > +    }
> > +
> > +    /// Transmutes a `ListArc` into an [`Arc`] without updating the tr=
acking inside `T`.
> > +    ///
> > +    /// After this call, the tracking inside `T` will still think that=
 there is a `ListArc`
> > +    /// reference.
> > +    #[inline]
> > +    fn transmute_to_arc(self) -> Arc<T> {
>
> Maybe also change this then to be consistent, since the name `transmute`
> carries a "dangerous" feel to it, but this is actually totally safe.

I want it to carry a dangerous feel! Yes, it's safe to leak the
ListArc, but you don't want people to think it's a generic ListArc ->
Arc conversion function.

> > +        // Use a transmute to skip destructor.
> > +        //
> > +        // SAFETY: ListArc is repr(transparent).
> > +        unsafe { core::mem::transmute(self) }
> > +    }
>
> [...]
>
> > +// This is to allow [`ListArc`] (and variants) to be used as the type =
of `self`.
> > +impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T:=
 ListArcSafe<ID> + ?Sized {}
> > +
> > +// This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` =
can be converted to the
> > +// dynamically-sized type (DST) `U`.
> > +impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for=
 ListArc<T, ID>
> > +where
> > +    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
> > +    U: ListArcSafe<ID> + ?Sized,
> > +{
> > +}
> > +
> > +// This is to allow `ListArc<U>` to be dispatched on when `ListArc<T>`=
 can be coerced into
> > +// `ListArc<U>`.
> > +impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> f=
or ListArc<T, ID>
> > +where
> > +    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
> > +    U: ListArcSafe<ID> + ?Sized,
> > +{
> > +}
>
> Can we start using `feature(derive_smart_pointer)` on new enough
> compiler versions? (I guess you probably want it as a separate patch
> series to avoid delaying this in case it needs anything [eg the new
> build system])
> Do we need any Makefile modifications for that or could we just do
> `#[cfg_attr(compiler-is-new-enough, derive(SmartPointer))` on the struct
> and then cfg these impls away? (and what would "compiler-is-new-enough"
> be?)

That probably won't be until 1.83 or something like that. It will have
to be a follow-up.

> Aside from my docs nits, this looks good:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

Alice

