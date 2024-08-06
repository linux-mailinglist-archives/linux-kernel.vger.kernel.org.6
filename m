Return-Path: <linux-kernel+bounces-276497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E9949498
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37401C239D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003FB43147;
	Tue,  6 Aug 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Z6KPdo7W"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C92D057
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958203; cv=none; b=U1zClbWid8HPC+l6d3oEcTpqj2cMb477IqY1Tcsv79bCybckdl/k1H2ZW5QoaNIRGtWHWcxpR4oP5A9gWD/3NM+AlTzLtHXq67n2DLPXpkh5e/WUrV7KE6BQKDnEoHWXaLj+dkeOzDoivQNmzy45akZt/gw21AptEAi5QRK5Nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958203; c=relaxed/simple;
	bh=Twmfj49iW4y3mxD67LY8CqyEjBEyK6M8SFb4xcVMv7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tR5ymzcbVFf7qreIwhYRpeagNGxklWFNNWV3q8k8cIbc1lWtDSv1PyrezbFpWCNpEVSw5G4tzuisJympVUbESG2k2BrkX9BtQSAVkhkE/lliJl8z6TSksVPE27+vHYHynNTgsB2Ru42bKl9KYIhDgEv2pPJAcGt18FodQz/CPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Z6KPdo7W; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722958198; x=1723217398;
	bh=YwudQO0jiK0IfEEbG+5NTyE56VDoSiRqzpb/min5enI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z6KPdo7Whtoka5Yz1+LtMzuW97YzlAzVZNJM1L1mMHmM0OgeboX/Mc1MQdRkf5n8T
	 PAzMJLwAi7wLNMphIwgNxP8X+aCvmRWuycHxccCmZGA5QdnVD3dnZeVFn+3X+X1vrC
	 UCFXkPRs/olR0rOjP+1Y/yI3OtXEOAGLsqQ2wQuJV9qeG+oi+LnExitDf22PwdCtWi
	 HlFYfFxMgZXdJsAgFcDUr72DT8aDWOZyZS6+2CQZOeoWMfRxO+i+euyPhJscygCtQ0
	 KPnkbLLVrzy+KbHqxyEbaBaJ97f5112hNO1P5aXo+I2L8Puk5ZPCJzbSLL5BHtvzy9
	 qTIdT992MZFlg==
Date: Tue, 06 Aug 2024 14:47:16 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 05/10] rust: list: add macro for implementing ListItem
Message-ID: <33fe126b-7517-4f05-8dc6-911e5f59fa58@proton.me>
In-Reply-To: <20240806-linked-list-v4-5-23efc510ec92@google.com>
References: <20240806-linked-list-v4-0-23efc510ec92@google.com> <20240806-linked-list-v4-5-23efc510ec92@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 71e90c82a51fe045827c732fa8d8723a4ae7e20b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:58, Alice Ryhl wrote:
> Adds a macro for safely implementing the ListItem trait. As part of the
> implementation of the macro, we also provide a HasListLinks trait
> similar to the workqueue's HasWorkItem trait.
>=20
> The HasListLinks trait is only necessary if you are implementing
> ListItem using the impl_list_item macro.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs                    |   3 +
>  rust/kernel/list/impl_list_item_mod.rs | 143 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 146 insertions(+)

I found one safety documentation nit below, with that fixed

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 074ae863ff5a..670d53989b8f 100644
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
>  pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcS=
afe, TryNewListArc};
>=20
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> new file mode 100644
> index 000000000000..30886e64b8ef
> --- /dev/null
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -0,0 +1,143 @@
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
> +/// manually, then this trait is not needed. Use the [`impl_has_list_lin=
ks!`] macro to implement
> +/// this trait.
> +///
> +/// # Safety
> +///
> +/// All values of this type must have a `ListLinks<ID>` field at the giv=
en offset.
> +///
> +/// The implementation of `raw_get_list_links` must not be changed.

You require here that the implementation must not be changed, but I
would argue that the implementation is changed in the
`impl_has_list_links!` macro below.

How about 's/implementation/behavior/` in the line above?

---
Cheers,
Benno

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
> +    // `impl_has_list_links!` to be correct.
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


