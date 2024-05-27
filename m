Return-Path: <linux-kernel+bounces-190423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B8F8CFE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF230B239F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF69213B5B8;
	Mon, 27 May 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cjqoJETM"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88B13AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805536; cv=none; b=fvj2eteJXpcdGr1znMC5N/GL2jzaMClqCMZ5q+2R9bZ3q9TKJDBHS3sWLTe728S6OowLty8xKAtsRPsx8iqoGt07e9fntEWP9sD05XYX4KEGC6gZCehgl5TO7VWediKTjxQUC3hRSAoI0gZZwmM5pTKhoSRLelNP401DoJ91Lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805536; c=relaxed/simple;
	bh=h4KF1MyhQtxXRTJqBhywhOIOuwPX5lcByBeK96ZC+Jw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awrATvzqWB4jmt9NZO33VpJPzbF5PGy+bKjw9noMvJNUhRgnZatL2LWgPxokMWNjCNzL1BJ4gcGnm24j+Z1oaWy3cJT79K+v0giAYisxM154dyAud9Ky3yW+hCtBpR3kzIjuI8YL3G2O4jcBjCn24Ai3MTx1Cy89V9m9HbQsRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cjqoJETM; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=s6e5qoitzjaaljvvrq47ks55b4.protonmail; t=1716805531; x=1717064731;
	bh=kIx8JlpRBz/d6bFUo2zbegrAZT5ZXq16dZqERzuTQ+s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cjqoJETMxCKs43D2aEDYr2pv11evCdFtx/Y1bg2OHOZ/e79yrwPpjJTAJwQHzTF8w
	 RfZfgRdktOJ4QwjtfkpXEoDhxhzW4cj78Gelel55uPo+t/LlwPl3Il90PTb+Y5OANX
	 oS6m37rQn7h4uk9oX+ngO/RUCCsgJRT3H1Bv7p8T1JDn6L0nSsFPWptbjuDAzLHYSd
	 R8spkR0e/qINw35D2Ku3kUkN9QmgGLoEuh414FGh2OCFi6Pwj0vfI+JSzL9QCZA/jt
	 VrPKhe5QRSqIYTo29kdpnL59XzewE3SG97lTvxqW3fwm2NZGrdwesUNwEZEbUY5OK8
	 x5JheuIAD9p4w==
Date: Mon, 27 May 2024 10:25:24 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 5/9] rust: list: add List
Message-ID: <4635b96c-66ab-4974-8ff9-0cd9516d42b1@proton.me>
In-Reply-To: <20240506-linked-list-v2-5-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-5-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 96fd6029a6ec51394d9db0e047cdb81f8abe70a2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> Add the actual linked list itself.
>=20
> The linked list uses the following design: The List type itself just has
> a single pointer to the first element of the list. And the actual list
> items then form a cycle. So the last item is `first->prev`.
>=20
> This is slightly different from the usual kernel linked list. Matching
> that exactly would amount to giving List two pointers, and having it be
> part of the cycle of items. This alternate design has the advantage that
> the cycle is never completely empty, which can reduce the number of
> branches in some cases. However, it also has the disadvantage that List
> must be pinned, which this design is trying to avoid.
>=20
> Having the list items form a cycle rather than having null pointers at
> the beginning/end is convenient for several reasons. For one, it lets us
> store only one pointer in List, and it simplifies the implementation of
> several functions.
>=20
> Unfortunately, the `remove` function that removes an arbitrary element
> from the list has to be unsafe. This is needed because there is no way
> to handle the case where you pass an element from the wrong list. For
> example, if it is the first element of some other list, then that other
> list's `first` pointer would not be updated. Similarly, it could be a
> data race if you try to remove it from two different lists in parallel.
> (There's no problem with passing `remove` an item that's not in any
> list. Additionally, other removal methods such as `pop_front` need not
> be unsafe, as they can't be used to remove items from another list.)

I would also mention that later in this patch series you introduce
cursors for the list, which can be used to safely remove arbitrary items
(although you need to iterate the list).

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs     | 329 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  rust/kernel/list/arc.rs |   6 +-
>  2 files changed, 330 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index f2eca542e090..d0ff29a3e5d1 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -6,6 +6,7 @@
>=20
>  use crate::init::PinInit;
>  use crate::types::Opaque;
> +use core::marker::PhantomData;
>  use core::ptr;
>=20
>  mod impl_list_item_mod;
> @@ -16,7 +17,40 @@
>      impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryN=
ewListArc,
>  };
>=20
> -/// Implemented by types where a [`ListArc<Self>`] can be inserted into =
a `List`.
> +/// A linked list.
> +///
> +/// All elements in this linked list will be [`ListArc`] references to t=
he value. Since a value can
> +/// only have one `ListArc` (for each pair of prev/next pointers), this =
ensures that the same
> +/// prev/next pointers are not used for several linked lists.
> +///
> +/// # Invariants
> +///
> +/// * If the list is empty, then `first` is null. Otherwise, `first` poi=
nts at the links field of
> +///   the first element in the list.
> +/// * All prev/next pointers of items in the list are valid and form a c=
ycle.

I think that you additionally need "The list has exclusive access to all
`prev`/`next` pointers of items in the list." or "For every item in the
list, the list owns the associated `ListArc<T, ID>`."

> +pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> +    first: *mut ListLinksFields,
> +    _ty: PhantomData<ListArc<T, ID>>,
> +}

[...]

> +    /// Add the provided item to the back of the list.
> +    pub fn push_back(&mut self, item: ListArc<T, ID>) {
> +        let raw_item =3D ListArc::into_raw(item);
> +        // SAFETY:
> +        // * We just got `raw_item` from a `ListArc`, so it's in an `Arc=
`.
> +        // * If this requirement is violated, then the previous caller o=
f `prepare_to_insert`
> +        //   violated the safety requirement that they can't give up own=
ership of the `ListArc`
> +        //   until they call `post_remove`.
> +        // * We own the `ListArc`.
> +        // * Removing items from this list is always done using `remove_=
internal_inner`, which
> +        //   calls `post_remove` before giving up ownership.
> +        let list_links =3D unsafe { T::prepare_to_insert(raw_item) };
> +        // SAFETY: We have not yet called `post_remove`, so `list_links`=
 is still valid.
> +        let item =3D unsafe { ListLinks::fields(list_links) };
> +
> +        if self.first.is_null() {
> +            self.first =3D item;
> +            // SAFETY: The caller just gave us ownership of these fields=
.
> +            // INVARIANT: A linked list with one item should be cyclic.
> +            unsafe {
> +                (*item).next =3D item;
> +                (*item).prev =3D item;
> +            }
> +        } else {
> +            let next =3D self.first;
> +            // SAFETY: By the type invariant, this pointer is valid or n=
ull. We just checked that
> +            // it's not null, so it must be valid.
> +            let prev =3D unsafe { (*next).prev };
> +            // SAFETY: Pointers in a linked list are never dangling, and=
 the caller just gave us
> +            // ownership of the fields on `item`.

Here you need that new invariant: the list needs exclusive access to all
of the `next`/`prev` pointers.

> +            // INVARIANT: This correctly inserts `item` between `prev` a=
nd `next`.
> +            unsafe {
> +                (*item).next =3D next;
> +                (*item).prev =3D prev;
> +                (*prev).next =3D item;
> +                (*next).prev =3D item;
> +            }
> +        }
> +    }
> +
> +    /// Add the provided item to the front of the list.
> +    pub fn push_front(&mut self, item: ListArc<T, ID>) {
> +        let raw_item =3D ListArc::into_raw(item);
> +        // SAFETY:
> +        // * We just got `raw_item` from a `ListArc`, so it's in an `Arc=
`.
> +        // * If this requirement is violated, then the previous caller o=
f `prepare_to_insert`
> +        //   violated the safety requirement that they can't give up own=
ership of the `ListArc`
> +        //   until they call `post_remove`.
> +        // * We own the `ListArc`.
> +        // * Removing items from this list is always done using `remove_=
internal_inner`, which
> +        //   calls `post_remove` before giving up ownership.
> +        let list_links =3D unsafe { T::prepare_to_insert(raw_item) };
> +        // SAFETY: We have not yet called `post_remove`, so `list_links`=
 is still valid.
> +        let item =3D unsafe { ListLinks::fields(list_links) };
> +
> +        if self.first.is_null() {
> +            // SAFETY: The caller just gave us ownership of these fields=
.
> +            // INVARIANT: A linked list with one item should be cyclic.
> +            unsafe {
> +                (*item).next =3D item;
> +                (*item).prev =3D item;
> +            }
> +        } else {
> +            let next =3D self.first;
> +            // SAFETY: We just checked that `next` is non-null.
> +            let prev =3D unsafe { (*next).prev };
> +            // SAFETY: Pointers in a linked list are never dangling, and=
 the caller just gave us
> +            // ownership of the fields on `item`.
> +            // INVARIANT: This correctly inserts `item` between `prev` a=
nd `next`.
> +            unsafe {
> +                (*item).next =3D next;
> +                (*item).prev =3D prev;
> +                (*prev).next =3D item;
> +                (*next).prev =3D item;
> +            }
> +        }

This code is the same as in `push_back`, can you refactor it?

> +        self.first =3D item;
> +    }
> +
> +    /// Removes the last item from this list.
> +    pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
> +        if self.first.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: We just checked that the list is not empty.
> +        let last =3D unsafe { (*self.first).prev };
> +        // SAFETY: The last item of this list is in this list.
> +        Some(unsafe { self.remove_internal(last) })
> +    }
> +
> +    /// Removes the first item from this list.
> +    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
> +        if self.first.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The first item of this list is in this list.
> +        Some(unsafe { self.remove_internal(self.first) })
> +    }
> +
> +    /// Removes the provided item from this list and returns it.
> +    ///
> +    /// This returns `None` if the item is not in the list. (Note that b=
y the safety requirements,
> +    /// this means that the item is not in any list.)
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided item must not be in a different linked list (with t=
he same id).

"`item` must not be ..." also other instances below.

---
Cheers,
Benno

> +    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> =
{
> +        let mut item =3D unsafe { ListLinks::fields(T::view_links(item))=
 };
> +        // SAFETY: The user provided a reference, and reference are neve=
r dangling.
> +        //
> +        // As for why this is not a data race, there are two cases:
> +        //
> +        //  * If `item` is not in any list, then these fields are read-o=
nly and null.
> +        //  * If `item` is in this list, then we have exclusive access t=
o these fields since we
> +        //    have a mutable reference to the list.
> +        //
> +        // In either case, there's no race.
> +        let ListLinksFields { next, prev } =3D unsafe { *item };
> +
> +        debug_assert_eq!(next.is_null(), prev.is_null());
> +        if !next.is_null() {
> +            // This is really a no-op, but this ensures that `item` is a=
 raw pointer that was
> +            // obtained without going through a pointer->reference->poin=
ter conversion rountrip.
> +            // This ensures that the list is valid under the more restri=
ctive strict provenance
> +            // ruleset.
> +            //
> +            // SAFETY: We just checked that `next` is not null, and it's=
 not dangling by the
> +            // list invariants.
> +            unsafe {
> +                debug_assert_eq!(item, (*next).prev);
> +                item =3D (*next).prev;
> +            }
> +
> +            // SAFETY: We just checked that `item` is in a list, so the =
caller guarantees that it
> +            // is in this list. The pointers are in the right order.
> +            Some(unsafe { self.remove_internal_inner(item, next, prev) }=
)
> +        } else {
> +            None
> +        }
> +    }

[...]


