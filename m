Return-Path: <linux-kernel+bounces-190442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8008CFE51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F51C1C2156B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DA13B792;
	Mon, 27 May 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b7d3uGhK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347053A8C0;
	Mon, 27 May 2024 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806776; cv=none; b=X7KWwX7zT2vJg5ZEeugYpdA6gTYDwjU5VFwhNnX1yhEwreOH8mnNSTylVRHUVtSXqvVnR2WQvogQrYb2X6rssREhSZc9z7vbUPXbzSl0DmnlCmKns4UCYz9OK8RCxb6kS4IxEBao35oZZT2pOljm/1uYyAqjOstejTp/zEBOEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806776; c=relaxed/simple;
	bh=vNmWK7T3lgZ1t26A7io73KQSEJ/cO1fbiEwR8p/kMyU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3exJE6clPWvdUKWMW/Ii/0kbS3yAP5Z/qQIuoV8HI7ea/cq096xWeTH+U2MRT3W1Uh5xXEfSarw9XTUkz/enJTNsQuE2raLChtcDOTlgb/tg4F86tjIpmcX+Zoq6dMX9VqAhNaXQOl5m0ve1W8gB2NGmSOPH5+QBOfQWC6RpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b7d3uGhK; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716806771; x=1717065971;
	bh=nzpaKt+Rvl81xZ9AXrvQceYpiSpmIvECWBnCpPTlx14=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b7d3uGhK/0QfLVp29lWs6sMNsBu8C584pdSXKF5VGLs1lExS1/C9jmoD3+kpU90C8
	 JcB65lRsUHR/stArQ/ViczVYzZyDRL32RHKDI4cQDC98ySTjCvcbjRroR201mhneU3
	 Y7BKpTwKUsjHMOa4x9uAfr5vwnkCzL2xPIXVKua3eCLVU1BcZ7ICp4DIHusVojBjjY
	 tm9Wdeb+jCY/Uto0MscXRHSurCuHm/cRvwsnbCQD7nfFY+sqYX+CgntKZSu8IEyi8E
	 V/dJC7bqsyRagmJdC+Bt6kf7MfULasBhDKX0D+hn4Lnq+kSNK0IlBVUUMgNoBMgflv
	 PIyFY9NdBKGQA==
Date: Mon, 27 May 2024 10:46:05 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 8/9] rust: list: support heterogeneous lists
Message-ID: <97c6423b-0886-4e79-991e-c40c77452464@proton.me>
In-Reply-To: <20240506-linked-list-v2-8-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-8-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4eee7e13fdfca16d245ffc01ac7f5005560af240
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> Support linked lists that can have many different structs at once. This

have -> hold

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
>  rust/kernel/list.rs                    |  47 ++++++++++++++-
>  rust/kernel/list/impl_list_item_mod.rs | 105 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 151 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index 641b434e3841..3e687401c6d3 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -7,12 +7,16 @@
>  use crate::init::PinInit;
>  use crate::sync::ArcBorrow;
>  use crate::types::Opaque;
> +use core::cell::UnsafeCell;
>  use core::iter::{DoubleEndedIterator, FusedIterator};
>  use core::marker::PhantomData;
> +use core::mem::MaybeUninit;
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
>  pub use self::arc::{
> @@ -180,6 +184,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *=
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
> +    self_ptr: UnsafeCell<MaybeUninit<*const T>>,

Why don't you use `Opaque` instead?

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
> +            self_ptr: UnsafeCell::new(MaybeUninit::zeroed()),
> +        }
> +    }
> +}
> +
>  impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
>      /// Creates a new empty list.
>      pub const fn new() -> Self {
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> index 3ff483be89d1..96e90c0ec587 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -62,6 +62,49 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $=
crate::list::ListLinks$(<$
>  }
>  pub use impl_has_list_links;
>=20
> +/// Declares that the `ListLinks<ID>` field in this struct is inside a `=
ListLinksSelfPtr<T, ID>`.
> +///
> +/// # Safety
> +///
> +/// The `ListLinks<ID>` field of this struct at the offset `HasListLinks=
<ID>::OFFSET` must be
> +/// inside a `ListLinksSelfPtr<T, ID>`.
> +pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 =3D 0>
> +where
> +    Self: HasListLinks<ID>,
> +{
> +}
> +
> +/// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the gi=
ven type.
> +#[macro_export]
> +macro_rules! impl_has_list_links_self_ptr {
> +    ($(impl$({$($implarg:tt)*})?
> +       HasSelfPtr<$item_type:ty $(, $id:tt)?>
> +       for $self:ident $(<$($selfarg:ty),*>)?
> +       { self.$field:ident }
> +    )*) =3D> {$(
> +        // SAFETY: The implementation of `raw_get_list_links` only compi=
les if the field has the
> +        // right type.
> +        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_typ=
e $(, $id)?> for
> +            $self $(<$($selfarg),*>)?
> +        {}
> +
> +        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)=
? for

Missing SAFETY comment.

> +            $self $(<$($selfarg),*>)?
> +        {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate:=
:list::ListLinks$(<$id>)? {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type =
$(, $id)?> =3D
> +                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
> +                ptr.cast()
> +            }
> +        }
> +    )*};
> +}
> +pub use impl_has_list_links_self_ptr;
> +
>  /// Implements the [`ListItem`] trait for the given type.
>  ///
>  /// Assumes that the type implements [`HasListLinks`].
> @@ -95,5 +138,67 @@ unsafe fn post_remove(me: *mut $crate::list::ListLink=
s<$num>) -> *const Self {
>              }
>          }
>      };
> +
> +    (
> +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
> +            using ListLinksSelfPtr;
> +        } $($rest:tt)*
> +    ) =3D> {
> +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for =
$t {

Missing SAFETY comment.

---
Cheers,
Benno

> +            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate:=
:list::ListLinks<$num> {
> +                // SAFETY: The caller promises that `me` points at a val=
id value of type `Self`.
> +                let links_field =3D unsafe { <Self as $crate::list::List=
Item<$num>>::view_links(me) };
> +
> +                let spoff =3D $crate::list::ListLinksSelfPtr::<Self, $nu=
m>::LIST_LINKS_SELF_PTR_OFFSET;
> +                // SAFETY: The constant is equal to `offset_of!(ListLink=
sSelfPtr, self_ptr)`, so
> +                // the pointer stays in bounds of the allocation.
> +                let self_ptr =3D unsafe { (links_field as *const u8).add=
(spoff) }
> +                    as *const ::core::cell::UnsafeCell<*const Self>;
> +                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
> +
> +                // SAFETY: This value is not accessed in any other place=
s than `prepare_to_insert`,
> +                // `post_remove`, or `view_value`. By the safety require=
ments of those methods,
> +                // none of these three methods may be called in parallel=
 with this call to
> +                // `prepare_to_insert`, so this write will not race with=
 any other access to the
> +                // value.
> +                unsafe { ::core::ptr::write(cell_inner, me) };
> +
> +                links_field
> +            }
> +
> +            unsafe fn view_links(me: *const Self) -> *mut $crate::list::=
ListLinks<$num> {
> +                // SAFETY: The caller promises that `me` points at a val=
id value of type `Self`.
> +                unsafe { <Self as HasListLinks<$num>>::raw_get_list_link=
s(me.cast_mut()) }
> +            }
> +
> +            // This function is also used as the implementation of `post=
_remove`, so the caller
> +            // may choose to satisfy the safety requirements of `post_re=
move` instead of the safety
> +            // requirements for `view_value`.
> +            unsafe fn view_value(links_field: *mut $crate::list::ListLin=
ks<$num>) -> *const Self {
> +                let spoff =3D $crate::list::ListLinksSelfPtr::<Self, $nu=
m>::LIST_LINKS_SELF_PTR_OFFSET;
> +                // SAFETY: The constant is equal to `offset_of!(ListLink=
sSelfPtr, self_ptr)`, so
> +                // the pointer stays in bounds of the allocation.
> +                let self_ptr =3D unsafe { (links_field as *const u8).add=
(spoff) }
> +                    as *const ::core::cell::UnsafeCell<*const Self>;
> +                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
> +                // This returns the same pointer as the one passes to th=
e previous call to
> +                // `prepare_to_insert` since that previous call wrote th=
at pointer to this
> +                // location, and the value has not been modified since.
> +                //
> +                // SAFETY: This is not a data race, because the only fun=
ction that writes to this
> +                // value is `prepare_to_insert`, but by the safety requi=
rements the
> +                // `prepare_to_insert` method may not be called in paral=
lel with `view_value` or
> +                // `post_remove`.
> +                unsafe { ::core::ptr::read(cell_inner) }
> +            }
> +
> +            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>=
) -> *const Self {
> +                // SAFETY: This specific implementation of `view_value` =
allows the caller to
> +                // promise the safety requirements of `post_remove` inst=
ead of the safety
> +                // requirements for `view_value`.
> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_va=
lue(me) }
> +            }
> +        }
> +    };
>  }
>  pub use impl_list_item;
>=20
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>=20



