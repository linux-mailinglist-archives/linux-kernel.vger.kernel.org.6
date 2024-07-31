Return-Path: <linux-kernel+bounces-269804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A61943704
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E371C219DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFD1662E4;
	Wed, 31 Jul 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hh/i3Lwm"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA461BC4E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457040; cv=none; b=Oiv7dfuTZQDtBH7Nwt/B13vIlfoYBe+xgElJqqLk2bdXMAd97inXj5ZxokJusnsVNa3kJkP+J8NFY6doMja60Hs1nH7XP3RGd7+Hw2I4iUEE3atAON1qX6zY3Otadh3WDXB5AWwoEGMTWnBu9HK41TfY0S3NVzN8NaUAHNDBfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457040; c=relaxed/simple;
	bh=rtPReYgUCOMcmx4myo8PVnbSVrj8vp20QDkHXW5qH0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQebOuGcYSBBqS/EPfThBgztODJeUftsd0tnM468xgj6GAlHn1ax2BHHP7N42WD7j6QcWVlkiKzI5m3Hfzg48Mqw3seaKirVPL8kz4y/eqZQEFws5PqBpApxPU/GwRcSZgZozUXfScANDTP4LAcMXD9+3v0Wm4iAgRgBfeR2Sxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hh/i3Lwm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722457035; x=1722716235;
	bh=kf2q8momx2ZD5HVKaMvEvPSC4bck0pCQ/m0sAo85WOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hh/i3Lwm+GAtM9uR1ixhQDYNrqceUi5px1y/FctTwUalK8gi9CLqNnk/iD/YNsQRj
	 hWym0O20/DOhqtw/XxkhykXFph6ryxVcCg312fvs/FVzTU+FbjQ6i5GKa8bwrMZgqm
	 ZlHZjkYsDNgk81q5j7YjEwYq3pVz5vWkQnlEjJ5b/u7xXLoVELMOCzU+qxSg9V4nM2
	 mOBWUHZQ7udNjiQyvtTCCTOINnOCkitP+wfmN4a5ERr1X/j8sygbRNUZ5gnwrZ6rVa
	 +oAK1vGFQmTJn7o9FzMtWN/8Fsp/s38XHk3Uw1SQRRuPfZ/S88Ht9XREXnSO7nrTlm
	 4dD6QGS8HtkBA==
Date: Wed, 31 Jul 2024 20:17:09 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 05/10] rust: list: add macro for implementing ListItem
Message-ID: <e6a57401-7b44-4ba5-ba9a-7948e5f7c7a1@proton.me>
In-Reply-To: <20240723-linked-list-v3-5-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-5-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e356b171cb6342f75d19d8892a66e00bf5fcd4d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> new file mode 100644
> index 000000000000..9b1947371c63
> --- /dev/null
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Helpers for implementing list traits safely.
> +
> +use crate::list::ListLinks;
> +
> +/// Declares that this type has a `ListLinks<ID>` field at a fixed offse=
t.
> +///
> +/// This trait is only used to help implement `ListItem` safely. If `Lis=
tItem` is implemented
> +/// manually, then this trait is not needed.

Can you reference the `impl_has_list_links!` macro here to guide the
user to the safe version?

> +///
> +/// # Safety
> +///
> +/// All values of this type must have a `ListLinks<ID>` field at the giv=
en offset.
> +///
> +/// The implementation of `raw_get_list_links` must not be changed.
> +pub unsafe trait HasListLinks<const ID: u64 =3D 0> {
> +    /// The offset of the `ListLinks` field.
> +    const OFFSET: usize;
> +
> +    /// Returns a pointer to the [`ListLinks<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`=
.
> +    ///
> +    /// [`ListLinks<T, ID>`]: ListLinks
> +    // We don't really need this method, but it's necessary for the impl=
ementation of
> +    // `impl_has_work!` to be correct.

Stale comment (this has nothing to do with `impl_has_work!`).

> +    #[inline]
> +    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
> +        // SAFETY: The caller promises that the pointer is valid. The im=
plementer promises that the
> +        // `OFFSET` constant is correct.
> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID=
> }
> +    }
> +}
> +
> +/// Implements the [`HasListLinks`] trait for the given type.
> +#[macro_export]
> +macro_rules! impl_has_list_links {
> +    ($(impl$(<$($implarg:ident),*>)?
> +       HasListLinks$(<$id:tt>)?
> +       for $self:ident $(<$($selfarg:ty),*>)?
> +       { self$(.$field:ident)* }
> +    )*) =3D> {$(
> +        // SAFETY: The implementation of `raw_get_list_links` only compi=
les if the field has the
> +        // right type.
> +        //
> +        // The implementation of `raw_get_list_links` is not changed sin=
ce the `addr_of_mut!` macro
> +        // is equivalent to the pointer offset operation in the trait de=
finition.
> +        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>=
)? for
> +            $self $(<$($selfarg),*>)?
> +        {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $($fie=
ld).*) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate:=
:list::ListLinks$(<$id>)? {
> +                // SAFETY: The caller promises that the pointer is not d=
angling. We know that this
> +                // expression doesn't follow any pointers, as the `offse=
t_of!` invocation above
> +                // would otherwise not compile.
> +                unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) }
> +            }
> +        }
> +    )*};
> +}
> +pub use impl_has_list_links;
> +
> +/// Implements the [`ListItem`] trait for the given type.
> +///
> +/// Assumes that the type implements [`HasListLinks`].

I would write "Requires", since "Assumes" sounds as if it isn't checked.

Can you also reference the `impl_has_list_links!` macro here to guide
the user to the safe version?

> +///
> +/// [`ListItem`]: crate::list::ListItem
> +#[macro_export]
> +macro_rules! impl_list_item {
> +    (
> +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
> +            using ListLinks;
> +        } $($rest:tt)*
> +    ) =3D> {
> +        // SAFETY: See GUARANTEES comment on each method.
> +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for =
$t {
> +            // GUARANTEES:
> +            // * This returns the same pointer as `prepare_to_insert` be=
cause `prepare_to_insert`
> +            //   is implemented in terms of `view_links`.
> +            // * By the type invariants of `ListLinks`, the `ListLinks` =
has two null pointers when
> +            //   this value is not in a list.
> +            unsafe fn view_links(me: *const Self) -> *mut $crate::list::=
ListLinks<$num> {
> +                // SAFETY: The caller guarantees that `me` points at a v=
alid value of type `Self`.
> +                unsafe {
> +                    <Self as $crate::list::HasListLinks<$num>>::raw_get_=
list_links(me.cast_mut())
> +                }
> +            }
> +
> +            // GUARANTEES:
> +            // * `me` originates from the most recent call to `prepare_t=
o_insert`, which just added
> +            //   `offset` to the pointer passed to `prepare_to_insert`. =
This method subtracts
> +            //   `offset` from `me` so it returns the pointer originally=
 passed to
> +            //   `prepare_to_insert`.
> +            // * The pointer remains valid until the next call to `post_=
remove` because the caller
> +            //   of the most recent call to `prepare_to_insert` promised=
 to retain ownership of the
> +            //   `ListArc` containing `Self` until the next call to `pos=
t_remove`. The value cannot
> +            //   be destroyed while a `ListArc` reference exists.
> +            unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>)=
 -> *const Self {
> +                let offset =3D <Self as $crate::list::HasListLinks<$num>=
>::OFFSET;
> +                // SAFETY: `me` originates from the most recent call to =
`prepare_to_insert`, so it
> +                // points at the field at offset `offset` in a value of =
type `Self`. Thus,
> +                // subtracting `offset` from `me` is still in-bounds of =
the allocation.
> +                unsafe { (me as *const u8).sub(offset) as *const Self }
> +            }
> +
> +            // GUARANTEES:
> +            // This implementation of `ListItem` will not give out exclu=
sive access to the same
> +            // `ListLinks` several times because calls to `prepare_to_in=
sert` and `post_remove`
> +            // must alternate and exclusive access is given up when `pos=
t_remove` is called.
> +            //
> +            // Other invocations of `impl_list_item!` also cannot give o=
ut exclusive access to the
> +            // same `ListLinks` because you can only implement `ListItem=
` once for each value of
> +            // `ID`, and the `ListLinks` fields only work with the speci=
fied `ID`.
> +            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate:=
:list::ListLinks<$num> {
> +                // SAFETY: The caller promises that `me` points at a val=
id value.
> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_li=
nks(me) }
> +            }
> +
> +            // GUARANTEES:
> +            // The first guarantee of `view_value` is exactly what `post=
_remove` guarantees.
> +            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>=
) -> *const Self {
> +                // SAFETY: This violates the safety requirement that `po=
st_remove` has not been
> +                // called since the most recent call to `prepare_to_inse=
rt`, but that is okay
> +                // because the concrete implementation of `view_value` a=
bove does not rely on that
> +                // requirement anywhere except for its second guarantee,=
 and we don't need its
> +                // second guarantee.

I don't like the "this isn't correct, but if you look closely at the
implementations, it's fine". Do you think it would be better if you just
copy paste the impl of `view_value`?

---
Cheers,
Benno

> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_va=
lue(me) }
> +            }
> +        }
> +    };
> +}
> +pub use impl_list_item;
>=20
> --
> 2.45.2.1089.g2a221341d9-goog
>=20


