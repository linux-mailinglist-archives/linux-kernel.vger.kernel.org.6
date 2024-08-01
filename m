Return-Path: <linux-kernel+bounces-270950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF194478C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4D2282A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25618170A17;
	Thu,  1 Aug 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XWK7aPPS"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBB16C87B;
	Thu,  1 Aug 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503516; cv=none; b=tJ/0A76VfStWeB2RmQrMWfcqn9uk7DeGTd+X0bLVthDbyrA0jYe06pHTntFqAaywpkfOjBvEDhMBzD+z1/NjEx+NAVro8EULvK/9zbAcJQzWUtHN6sTflXSyDR1TDDBraiaxQLgcsp1qV26UdJWbCqDg4Ojvdg5GnA7u5oQXm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503516; c=relaxed/simple;
	bh=wUrOrezRYrP4/dh2WiSRWKh4K1ZwTdQujgqtUYD4WUw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxHEiOCaVofxejDWRWCUxgyvEwWIR/0CMsF+XzJPCgFrGvHwCDIR1j3jkPw/nkFvwbCe6PlEG7FPlZ2DheM3tOVSBfwGwX/DYlbW5IBOWPb2+GatMthz3ZLsnGWOLRzld9AYuOiB6SIlqWLX27S/u9CJWJpNnpaZZsrAyNdLGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XWK7aPPS; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722503509; x=1722762709;
	bh=iZtejEgOwUEDu5fFayTCiRxlXEYx2USjuF1rBVMv5/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XWK7aPPSpBTbbVlymssfjKcPtZSsRfPw952kJtGwJbUKEN/7icU8vQmFfWMuYffqc
	 Zj+4NAU3+p9HtMex28+k60au2bc/pbh1BYtXM6yiddgPTEneA/6b49nnSLu4xJ3kLP
	 xk/hTu+I0nYO1UjJi57ectKx5Zy2wYzPcgdtSiVIy4+twsZEImRZWuXaWiOxHgD2YA
	 Ox3RTmLkgib1xFaW/Hz8mZvTGVmw9nbcR36QN3fb043fXrQiJMx/0UebDNNpMij9HE
	 XNm70ngPQFlFYkHcPqwoQo0qjBWbQxM4s4nOw76mtvYRqymADrrAohTz0zjxw39Epe
	 Mq47O58tZMeTQ==
Date: Thu, 01 Aug 2024 09:11:43 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 06/10] rust: list: add List
Message-ID: <3e6a37d1-2460-42ce-8bc3-0b210759efa8@proton.me>
In-Reply-To: <20240723-linked-list-v3-6-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-6-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8f87a6cabbbebf3d7d90fe65198a99e9076a5c4f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
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

I don't like this negative phrasing, what about "Since we have ownership
of the `ListArc`, `post_remove` must have been called after each
previous call to `prepare_to_insert`."?

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
> +            // INVARIANT: This correctly inserts `item` between `prev` a=
nd `next`.
> +            unsafe {
> +                (*item).next =3D next;
> +                (*item).prev =3D prev;
> +                (*prev).next =3D item;
> +                (*next).prev =3D item;
> +            }

You have this pattern several times, maybe make a function for this?

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
> +        // * Removing items] from this list is always done using `remove=
_internal_inner`, which

Typo: "]".

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

Additionally you need the type invariant that pointers in linked lists
are valid... This is a bit annoying, maybe in the future, we can have a
`ValidPtr` type that we could use here instead to avoid these
comments...

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
> +    /// `item` must not be in a different linked list (with the same id)=
.
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

How bad do you reckon is this for performance?

---
Cheers,
Benno

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


