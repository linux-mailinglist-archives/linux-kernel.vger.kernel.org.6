Return-Path: <linux-kernel+bounces-190389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA18CFD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B28F281119
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE4D13AA32;
	Mon, 27 May 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PX5K/wj+"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0F1755A;
	Mon, 27 May 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803906; cv=none; b=XF5rh+QgkNGYF3e+JGwzXSEta5G8+Xc8QIkvt6piyaswgXjWrDANz8PrgbELzyw5yHn99e+ALiqAp4Ka4k6G4puO7N2fas10iQx8VIJlbHGtPy/Wm+ayt9+LGUDCaZQxq9KW7cbhgNwaJqYg+HN8wGXUInJAK+hbsmKNe79dIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803906; c=relaxed/simple;
	bh=Al2pkDUSRqc1rQ6eBN1ZtNx95wDfg2Iwmefz5m22r/4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUDaibqRwKrZ8lJsNTZTiSx1nMdpsurSb0b1GmX8uAqL80KZ2cOSisXJsZL2xW/nPisCstZnNP9JP2ArUZe2UHfDnobGeN+yM1HEvk25IZDqrZDkc/AHzhVl1kf+n9ux1FO8U7aHLtg/zKMz57z6bojsyPtLy1sfnSSd5DN1kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PX5K/wj+; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716803901; x=1717063101;
	bh=bXVeyLZ5rfr6W8gD3PoVwJ5eVkWxrmnOFZgyD6JZRV8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PX5K/wj+GcOIbp4yJGaB7j718f9EmmmMKJpWcubxky2FtqFrbesZF7p6Eoa4/6KRr
	 Bk+qGHtW51qB+F1KScGFdyxnI4IWBZMh8Uw4LqAnwupg/F9Kb79aYRKm/Hmw2k+Odz
	 gEzPXaBzTy9FoTYbtSCbU0jOs2Xw8SI/wjAJHJezuP0piHCU4lcOuDPtssYPqRhrQb
	 tEJI8UcRSzRGRtRzmYiBoLW59qvDSlSBvLLbgt8j5Uw0eNLQq3pZFBX66meSihqUmU
	 8DYkUrwhNNxvvBfXICEpb0csss0vsOgEtOKYhYwslGP6gkDgMCQe+wVMqlBHEXcAvf
	 urxAkDEx1bqwA==
Date: Mon, 27 May 2024 09:58:16 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/9] rust: list: add struct with prev/next pointers
Message-ID: <82220d9b-3f4f-43ba-ad15-412ceb349a56@proton.me>
In-Reply-To: <20240506-linked-list-v2-3-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-3-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bfecf62831420d9cb4d8e4f3085258a6eba4236f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> Define the ListLinks struct, which wraps the prev/next pointers that
> will be used to insert values into a List in a future patch. Also
> define the ListItem trait, which is implemented by structs that have a
> ListLinks field.
>=20
> The ListItem trait provides four different methods that are all
> essentially container_of or the reverse of container_of. Two of them are
> used before inserting/after removing an item from the list, and the two
> others are used when looking at a value without changing whether it is
> in a list. This distinction is introduced because it is needed for the
> patch that adds support for heterogeneous lists, which are implemented
> by adding a third pointer field with a fat pointer to the full struct.
> When inserting into the heterogeneous list, the pointer-to-self is
> updated to have the right vtable, and the container_of operation is
> implemented by just returning that pointer instead of using the real
> container_of operation.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs | 116 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 116 insertions(+)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index c5caa0f6105c..b5cfbb96a392 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -4,7 +4,123 @@
>=20
>  //! A linked list implementation.
>=20
> +use crate::init::PinInit;
> +use crate::types::Opaque;
> +use core::ptr;
> +
>  mod arc;
>  pub use self::arc::{
>      impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryN=
ewListArc,
>  };
> +
> +/// Implemented by types where a [`ListArc<Self>`] can be inserted into =
a `List`.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that they provide the guarantees documented=
 on the three methods

I would not mention the number of methods, since it is difficult to
maintain and doesn't actually provide any value (it already is incorrect :)

> +/// below.
> +///
> +/// [`ListArc<Self>`]: ListArc
> +pub unsafe trait ListItem<const ID: u64 =3D 0>: ListArcSafe<ID> {
> +    /// Views the [`ListLinks`] for this value.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// If there is a previous call to `prepare_to_insert` and there is =
no call to `post_remove`
> +    /// since the most recent such call, then this returns the same poin=
ter as the one returned by
> +    /// the most recent call to `prepare_to_insert`.
> +    ///
> +    /// Otherwise, the returned pointer points at a read-only [`ListLink=
s`] with two null pointers.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid value. (It need not b=
e in an `Arc`.)
> +    unsafe fn view_links(me: *const Self) -> *mut ListLinks<ID>;
> +
> +    /// View the full value given its [`ListLinks`] field.
> +    ///
> +    /// Can only be used when the value is in a list.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// * Returns the same pointer as the one passed to the previous cal=
l to `prepare_to_insert`.
> +    /// * The returned pointer is valid until the next call to `post_rem=
ove`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The provided pointer must originate from the previous call to =
`prepare_to_insert`, or
> +    ///   from a call to `view_links` that happened after the previous c=
all to `prepare_to_insert`.
> +    /// * Since the previous call to `prepare_to_insert`, the `post_remo=
ve` method must not have
> +    ///   been called.
> +    unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
> +
> +    /// This is called when an item is inserted into a `List`.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// The caller is granted exclusive access to the returned [`ListLin=
ks`] until `post_remove` is
> +    /// called.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The provided pointer must point at a valid value in an [`Arc`]=
.
> +    /// * Calls to `prepare_to_insert` and `post_remove` on the same val=
ue must alternate.

Are there any synchronization requirements? Am I allowed to call
`prepare_to_insert` and `post_remove` on different threads without
synchronizing?

> +    /// * The caller must own the [`ListArc`] for this value.
> +    /// * The caller must not give up ownership of the [`ListArc`] unles=
s `post_remove` has been
> +    ///   called after this call to `prepare_to_insert`.
> +    ///
> +    /// [`Arc`]: crate::sync::Arc
> +    unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<ID>;
> +
> +    /// This undoes a previous call to `prepare_to_insert`.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// The returned pointer is the pointer that was originally passed t=
o `prepare_to_insert`.
> +    ///
> +    /// The caller is free to recreate the `ListArc` after this call.

As I read the requirements on `prepare_to_insert`, the caller is not
required to deconstruct the `ListArc`. For example the caller is allowed
to `clone_arc()` and then `into_raw()` and then pass that pointer to
`prepare_to_insert`.
So I would just remove this sentence.

> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must be the pointer returned by the previou=
s call to

Does "most recent call" make more sense? I find previous call a bit
weird. (also in the requirements above)

---
Cheers,
Benno

> +    /// `prepare_to_insert`.
> +    unsafe fn post_remove(me: *mut ListLinks<ID>) -> *const Self;
> +}
> +
> +#[repr(C)]
> +#[derive(Copy, Clone)]
> +struct ListLinksFields {
> +    next: *mut ListLinksFields,
> +    prev: *mut ListLinksFields,
> +}
> +
> +/// The prev/next pointers for an item in a linked list.
> +///
> +/// # Invariants
> +///
> +/// The fields are null if and only if this item is not in a list.
> +#[repr(transparent)]
> +pub struct ListLinks<const ID: u64 =3D 0> {
> +    #[allow(dead_code)]
> +    inner: Opaque<ListLinksFields>,
> +}
> +
> +// SAFETY: The next/prev fields of a ListLinks can be moved across threa=
d boundaries.
> +unsafe impl<const ID: u64> Send for ListLinks<ID> {}
> +// SAFETY: The type is opaque so immutable references to a ListLinks are=
 useless. Therefore, it's
> +// okay to have immutable access to a ListLinks from several threads at =
once.
> +unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
> +
> +impl<const ID: u64> ListLinks<ID> {
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        ListLinks {
> +            inner: Opaque::new(ListLinksFields {
> +                prev: ptr::null_mut(),
> +                next: ptr::null_mut(),
> +            }),
> +        }
> +    }
> +}
>=20
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>=20



