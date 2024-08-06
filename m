Return-Path: <linux-kernel+bounces-276493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A141949487
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821AD1C2388E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989992C6BB;
	Tue,  6 Aug 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cTWSk3Sa"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BD29408
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958013; cv=none; b=PrYzhOZaheC110t+kbpwD8hwUq2bqb1HxjbOMsKKF4czP5m3PJYvtxuVMsQ0t2fhUgwXEO9F2D0R2/9ILUgFWrIv/YWxxooXXhQhE0RGNWLjbr2V+LI3kErvByNwcMHq7VSMXzzhaWWdMsjZE93Ypkj0MNKDeEQNTYfm32nGZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958013; c=relaxed/simple;
	bh=zRyVYewZfJ6vbOqTtDN9VwPuL0s3ORHF8Dgbx8cWW5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjlAMvIPaRYDJMF0pGccxCAr87hUW5hMshtVtgyIhMarNOYBDWKcnChawg/MVsTCWKiC+rhl91TXHcHUeupgHaNks6hcoOjYHJMrumRWKozsd0ZF2eHKEg1blkllg2NeHyLxQNIte/NhhBsBSQCgSWV3D1tAmVNEahyq1wcykgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cTWSk3Sa; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xjnzteocszdshk7n4mljwybxaa.protonmail; t=1722958010; x=1723217210;
	bh=tpBGENrMupqVDMgdnTEoGfZ9qLS+bFFaxLGIQUvax4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cTWSk3SaQg0XywrFIDCaxqG/NC6pD5u2vWS5YBrN9PibKcUe5+p3LRmf6f5X8oPK4
	 QGzo3TMSeCAWDy8BpuseO0uZQy70z7RUoyHXH+YRISriayZafJJmFbN0+gewG3HIpY
	 lqtJz3vcP4TkN5W7EVET1mS1D7ph/+mnktodp+wEn+oppLbLrsgFR0MNRs/h7VHOfg
	 fF15DWpGHjcGic37wjH0v6DWVsGshslm71cUm/T9O+nLYr8YSJ/7qe9T0bGPNut4By
	 SnAgCPCKY0i2M1BTFiGSP/KOzBvKYun38Z7GfqAOU876EbgFl1GY6yDEs2bzkxVuaN
	 2ppe68CR9JyvA==
Date: Tue, 06 Aug 2024 14:47:21 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 09/10] rust: list: support heterogeneous lists
Message-ID: <4858fbdc-f1d4-48bf-b884-4db1b1ffbf1b@proton.me>
In-Reply-To: <20240806-linked-list-v4-9-23efc510ec92@google.com>
References: <20240806-linked-list-v4-0-23efc510ec92@google.com> <20240806-linked-list-v4-9-23efc510ec92@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8ea67c05bb2c7315f6812cabc22daabfc76cecc4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:59, Alice Ryhl wrote:
> Support linked lists that can hold many different structs at once. This
> is generally done using trait objects. The main challenge is figuring
> what the struct is given only a pointer to the ListLinks.
>=20
> We do this by storing a pointer to the struct next to the ListLinks
> field. The container_of operation will then just read that pointer. When
> the type is a trait object, that pointer will be a fat pointer whose
> metadata is a vtable that tells you what kind of struct it is.
>=20
> Heterogeneous lists are heavily used by Rust Binder. There are a lot of
> so-called todo lists containing various events that need to be delivered
> to userspace next time userspace calls into the driver. And there are
> quite a few different todo item types: incoming transaction, changes to
> refcounts, death notifications, and more.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs                    |  47 +++++++++++-
>  rust/kernel/list/impl_list_item_mod.rs | 131 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 177 insertions(+), 1 deletion(-)

One nit below, with that fixed,

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 904cfa454dff..cf26fec37c1e 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -12,7 +12,9 @@
>  use core::ptr;
>=20
>  mod impl_list_item_mod;
> -pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, =
HasListLinks};
> +pub use self::impl_list_item_mod::{
> +    impl_has_list_links, impl_has_list_links_self_ptr, impl_list_item, H=
asListLinks, HasSelfPtr,
> +};
>=20
>  mod arc;
>  pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcS=
afe, TryNewListArc};
> @@ -183,6 +185,49 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *=
mut Self {
>      }
>  }
>=20
> +/// Similar to [`ListLinks`], but also contains a pointer to the full va=
lue.
> +///
> +/// This type can be used instead of [`ListLinks`] to support lists with=
 trait objects.
> +#[repr(C)]
> +pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 =3D 0> {
> +    /// The `ListLinks` field inside this value.
> +    ///
> +    /// This is public so that it can be used with `impl_has_list_links!=
`.
> +    pub inner: ListLinks<ID>,
> +    // UnsafeCell is not enough here because we need `Opaque::zeroed` as=
 a dummy value, and

You say that you need `Opaque::zeroed`, but below you use `uninit`, so
just 's/zeroed/uninit/' in the above line should fix it.

---
Cheers,
Benno

> +    // `ptr::null()` doesn't work for `T: ?Sized`.
> +    self_ptr: Opaque<*const T>,
> +}
> +
> +// SAFETY: The fields of a ListLinksSelfPtr can be moved across thread b=
oundaries.
> +unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T=
, ID> {}
> +// SAFETY: The type is opaque so immutable references to a ListLinksSelf=
Ptr are useless. Therefore,
> +// it's okay to have immutable access to a ListLinks from several thread=
s at once.
> +//
> +// Note that `inner` being a public field does not prevent this type fro=
m being opaque, since
> +// `inner` is a opaque type.
> +unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T=
, ID> {}
> +
> +impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
> +    /// The offset from the [`ListLinks`] to the self pointer field.
> +    pub const LIST_LINKS_SELF_PTR_OFFSET: usize =3D core::mem::offset_of=
!(Self, self_ptr);
> +
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        Self {
> +            inner: ListLinks {
> +                inner: Opaque::new(ListLinksFields {
> +                    prev: ptr::null_mut(),
> +                    next: ptr::null_mut(),
> +                }),
> +            },
> +            self_ptr: Opaque::uninit(),
> +        }
> +    }
> +}
> +
>  impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
>      /// Creates a new empty list.
>      pub const fn new() -> Self {


