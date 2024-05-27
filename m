Return-Path: <linux-kernel+bounces-190402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92F8CFDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D74A1C20A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4E13C3D5;
	Mon, 27 May 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dnj8zF5q"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258913B7A7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804393; cv=none; b=pwAjLuRw3iG+CQsrEEaK3ScxF+RbuxNFCSKTX/Ol5d+TGQSpcsGWe8aZNMRQmN3IJIJaLWveu+nICpqab0NoPUQTvtm+RVoa25aXZCIaCVAcThiQ/K3nUocAfP2l0zIVlFWRZOHMQ4WJfZh7oamYxDWT8Xxe6iDSsEjMbnzxhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804393; c=relaxed/simple;
	bh=WXMFmaCXyOHrCsBpiBVUwdLSoPEMW5xY3pxYv40bbh8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwKzHbjvn5EhMdlmfMvxZZ1FAEzVsmeUYxV9GV0Wk5eWshOmObQ9HQTfOSo6az+PlibFxlLvs/mjMR2lcxkPNdMZdc1GMn7um31Xm/deC5QO71O6Q3gcsEQAJMxumUwgAt2NEUBVBjgIDRy1jaItlp2ytoDpTb/nTUNjrgXCCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dnj8zF5q; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=f2rrrjo2erahtl2gjjputfb44u.protonmail; t=1716804388; x=1717063588;
	bh=hYiUOg3qu0xInrbrlGKtxB4IjvbTEiIJES/QFtLiWqk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dnj8zF5q4gFWHa1KZ5saphR+PTdIniYhjfsQBUA3WlVGPTZIl5wu3G8Ns0MtOMUFK
	 bvqTtmwScdEJahEZBJ391IcHAeqZVEUitEWx0QJCNc5nyRQJ1J8fSS0kmIdaPQoq85
	 1GtktxsUBq3FLDwMa4n5XqYYf0euwTsSQtxNp+T4p8Sxlis8eSUKZBjpGCQDE19dfh
	 NMSckxYWnA1ZEKSCj0UifutS/b8cTRLOZGygZ4brFkLI9jH6fws2vyVJVllY6FDfmN
	 MNqH6w7+xJwq4fPDmgPUfL4V83bWxYcb/yhDTqURAa/XUWbRu3e32CuewJiEx9+g+g
	 0mbohOqAR+Nsw==
Date: Mon, 27 May 2024 10:06:22 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 4/9] rust: list: add macro for implementing ListItem
Message-ID: <a3ea800c-4776-4890-8853-cd5704598a7f@proton.me>
In-Reply-To: <20240506-linked-list-v2-4-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-4-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 001f9e86a32912698f89c7fb9185c64dbef96aed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> Adds a macro for safely implementing the ListItem trait. As part of the
> implementation of the macro, we also provide a HasListLinks trait
> similar to the workqueue's HasWorkItem trait.
>=20
> The HasListLinks trait is only necessary if you are implementing
> ListItem using the impl_list_item macro.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs                    |  3 ++
>  rust/kernel/list/impl_list_item_mod.rs | 99 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 102 insertions(+)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index b5cfbb96a392..f2eca542e090 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -8,6 +8,9 @@
>  use crate::types::Opaque;
>  use core::ptr;
>=20
> +mod impl_list_item_mod;
> +pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, =
HasListLinks};
> +
>  mod arc;
>  pub use self::arc::{
>      impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryN=
ewListArc,
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> new file mode 100644
> index 000000000000..3ff483be89d1
> --- /dev/null
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -0,0 +1,99 @@
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
> +///
> +/// # Safety
> +///
> +/// All values of this type must have a `ListLinks<ID>` field at the giv=
en offset.
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

You could also check for correctness within the expansion of
`impl_has_list_links` (by creating an invisible function there), so you
don't need this function. It still could be useful for `dyn Trait`
though.

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
> +        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>=
)? for
> +            $self $(<$($selfarg),*>)?
> +        {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $($fie=
ld).*) as usize;

AFAIK only a single field is supported on stable.

> +
> +            #[inline]
> +            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate:=
:list::ListLinks$(<$id>)? {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr)$(.$field)*)

Note that this runs into the `Box` issue, but `offset_of` will fail to
compile in that case, so it is fine.
Do we want to note this in a comment?

> +                }
> +            }
> +        }
> +    )*};
> +}
> +pub use impl_has_list_links;
> +
> +/// Implements the [`ListItem`] trait for the given type.
> +///
> +/// Assumes that the type implements [`HasListLinks`].
> +///
> +/// [`ListItem`]: crate::list::ListItem
> +#[macro_export]
> +macro_rules! impl_list_item {
> +    (
> +        impl$({$($generics:tt)*})? $crate::list::ListItem<$num:tt> for $=
t:ty {
> +            using ListLinks;
> +        } $($rest:tt)*
> +    ) =3D> {
> +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for =
$t {

Missing SAFETY comment.

---
Cheers,
Benno

> +            unsafe fn view_links(me: *const Self) -> *mut $crate::list::=
ListLinks<$num> {
> +                unsafe {
> +                    <Self as $crate::list::HasListLinks<$num>>::raw_get_=
list_links(me.cast_mut())
> +                }
> +            }
> +
> +            unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>)=
 -> *const Self {
> +                let offset =3D <Self as $crate::list::HasListLinks<$num>=
>::OFFSET;
> +                unsafe { (me as *const u8).sub(offset) as *const Self }
> +            }
> +
> +            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate:=
:list::ListLinks<$num> {
> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_li=
nks(me) }
> +            }
> +
> +            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>=
) -> *const Self {
> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_va=
lue(me) }
> +            }
> +        }
> +    };
> +}
> +pub use impl_list_item;
>=20
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>=20


