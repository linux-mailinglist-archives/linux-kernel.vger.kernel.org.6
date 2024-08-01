Return-Path: <linux-kernel+bounces-271001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C268D944838
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3128784B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09295189525;
	Thu,  1 Aug 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kNBqTYLs"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A28187FF1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504292; cv=none; b=iZCp5ej0pSbm3e3tWdzRCwuKC+5ERgbkkASdFqTgbmhiRXQcEe6prXUQUuk6G6vknVjNiOdEMM9ZFX4pCcwyAzWQe71D5HP61/amrlrEpgkm9VnjwnTCiuQHsNEA1yFl8AYfrOGO0tMs9P2LV23MlnLuI9evePMpgUONcUMvkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504292; c=relaxed/simple;
	bh=d4ri9VfNgOiIrNVI1mCsreFc8GM8GpdEhbrZ+wzLFdU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9pMqcnDGLw/+LCzvl8TRAf/Bv9Vs+BRvGZ3beDJZzmMyflS9WtYHDjwPa94V3XRV+Cln8IomAhASBHQ5h4FP9CmaQUHSIdnuD1hTUl6zsJs69wsMTVndLedLPndrPyaSy4nsyDqKYsSdtSZmfh/XIUI+7drJou+IVQCjFn7F1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kNBqTYLs; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722504285; x=1722763485;
	bh=TbpqkHCw4lSda76FTheLHxuqma8moDcQD3e3Tnu05W0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kNBqTYLsCQO5X8OAHsXsa240Ow150ROzeJ+JPeRpl497PcCYtB8B4cS8aKXYaMPqz
	 b6c/Z71Q5htytWJN1o8hVhO1HTIHWiJJm4Fm0JNQJGLo3NR9GsH8gVfH1vIhvFfQDy
	 i3zjr4PLbrHxNrtB/GvISVe4BM9JHXTGqr7j/YDfCRnWvNdvBYD5V7P4uz8PaliCwy
	 1C81TZXLr3SZejjLdk87Gyz4D5dM2Q9IIy8CWN7e1d43r6ut+OdOQeeddnlaz8jnTo
	 roWYGaEcUrMM8p40QnQcDQuGQt2Mnb7IvuL3n58FuFULZm7AQwshCiV4HexCM0j4DW
	 +F0fnamftCMAw==
Date: Thu, 01 Aug 2024 09:24:40 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/10] rust: list: support heterogeneous lists
Message-ID: <2b548226-e323-466d-9f6d-762f6cbb5474@proton.me>
In-Reply-To: <20240723-linked-list-v3-9-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-9-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6d7728b66dbd427ed3379353002f5530636f60ad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
> @@ -181,6 +185,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *=
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

Why do you need `MaybeUninit`?

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

[...]

> @@ -135,5 +178,91 @@ unsafe fn post_remove(me: *mut $crate::list::ListLin=
ks<$num>) -> *const Self {
>              }
>          }
>      };
> +
> +    (
> +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
> +            using ListLinksSelfPtr;
> +        } $($rest:tt)*
> +    ) =3D> {
> +        // SAFETY: See GUARANTEES comment on each method.
> +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for =
$t {
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

A bit confused why you need to do it this way, can't you just do this?:

    let links_self_field =3D links_field.cast::<$crate::list::ListLinksSelf=
Ptr>();
    // SAFETY: ...
    let self_ptr =3D unsafe { ::core::ptr::addr_of_mut!((*links_self_field)=
.self_ptr) };

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
> +            // GUARANTEES:
> +            // * This returns the same pointer as `prepare_to_insert` be=
cause `prepare_to_insert`
> +            //   returns the return value of `view_links`.
> +            // * By the type invariants of `ListLinks`, the `ListLinks` =
has two null pointers when
> +            //   this value is not in a list.
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

This almost sounds like a magic card :)

> +            //
> +            // GUARANTEES:

Can you also put in "()" here that this satisfies the guarantees of
`post_remove`?

> +            // * This returns the same pointer as the one passed to the =
most recent call to
> +            //   `prepare_to_insert` since that call wrote that pointer =
to this location. The value
> +            //   is only modified in `prepare_to_insert`, so it has not =
been modified since the
> +            //   most recent call.
> +            //
> +            // GUARANTEES: (when using the `view_value` safety requireme=
nts)
> +            // * The pointer remains valid until the next call to `post_=
remove` because the caller
> +            //   of the most recent call to `prepare_to_insert` promised=
 to retain ownership of the
> +            //   `ListArc` containing `Self` until the next call to `pos=
t_remove`. The value cannot
> +            //   be destroyed while a `ListArc` reference exists.
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
> +            // GUARANTEES:
> +            // The first guarantee of `view_value` is exactly what `post=
_remove` guarantees.
> +            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>=
) -> *const Self {
> +                // SAFETY: This specific implementation of `view_value` =
allows the caller to
> +                // promise the safety requirements of `post_remove` inst=
ead of the safety
> +                // requirements for `view_value`.

I like this solution better than what you have for `impl_list_item`
"using ListLinks;"

---
Cheers,
Benno

> +                unsafe { <Self as $crate::list::ListItem<$num>>::view_va=
lue(me) }
> +            }
> +        }
> +    };
>  }
>  pub use impl_list_item;
>=20
> --
> 2.45.2.1089.g2a221341d9-goog
>=20


