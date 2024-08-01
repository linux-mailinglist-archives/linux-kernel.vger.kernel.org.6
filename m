Return-Path: <linux-kernel+bounces-271110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FE9449AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC020B29028
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701218453A;
	Thu,  1 Aug 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XRRm4+Z2"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85761FD7;
	Thu,  1 Aug 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509317; cv=none; b=i66prL73JzcRBKaTRLYD61tzNPyGUPiEupPYVTL4FKKMjx8HLykjwFJ3XfPoUiQz4frjAc8oK2ei833m113/6wwcBZW6PYFLQ5tPE+M7CH/XjKnD1M8vaAJ3tdX0gTsRq+o2HQH8IPLtadnEcKT15DndkDLD5dDIA9gFTG9bbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509317; c=relaxed/simple;
	bh=zMj2kaT0XKsS7rrqSElo8aaZ9plwjhN+xqQDheijjKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gleK/P4mLej/b8GqhSty7GCUf6fY2i733L/Hq3MT0kzl+PU0rF0Elvy8lP/sU3S8FCojw+KQ/Tq2H9n5iRXO2X73wUDGzLl12joHmvRczNsxywCTQlCIJUCNWecPAMzeqhEhjClPCR1dRb0jhxRJOmERqDvg7x5mSu05Caq6Sds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XRRm4+Z2; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722509314; x=1722768514;
	bh=lWoM4Uz32+QjRNv6Qi2IgDlBu29MBNkhXDzxAE4VsL4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XRRm4+Z20OuyFz9Qn2mTNc6lEwkbkHOj1NkEaYimZWVpIbEnvVmJKo+fsnU4hsBTS
	 QGZWT0ZmfmN0Gw3pndD2LQenC+0MoyQRacuiEVR+/KygBQ/nGl4iJuC7v3l0e5wjV3
	 EF2DhL0fDsI/CQ03u6S/qj2V29mjXOO3lhN+0vPfMCc5zwgU+AnVmbEKEAhtfFHJIa
	 QIlHw2m3pG6kYltPMI1no6cliIlutLOAVtbmlknnr0gLuGxmI7fNgybPAkbMV6H4nK
	 +TanZcRwz3n0+0CBJTq8NipYwMRsXysw8Om7N8ACwU1c+WmCD5D8PodOgKBfvP2hVj
	 iPmdp0bfNc9sg==
Date: Thu, 01 Aug 2024 10:48:29 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 06/10] rust: list: add List
Message-ID: <f94ec0db-9504-447d-8432-b3dc7015e63a@proton.me>
In-Reply-To: <CAH5fLgjNCXwhUaHh7dxm-5LmFe-TtiizK2cWscSp9bkdknRywQ@mail.gmail.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-6-89db92c7dbf4@google.com> <3e6a37d1-2460-42ce-8bc3-0b210759efa8@proton.me> <CAH5fLgjNCXwhUaHh7dxm-5LmFe-TtiizK2cWscSp9bkdknRywQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6e482b44ff1c2a8fd13b02dea0f1282d1ed39457
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 11:40, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 11:11=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 23.07.24 10:22, Alice Ryhl wrote:
>>> +    /// Add the provided item to the back of the list.
>>> +    pub fn push_back(&mut self, item: ListArc<T, ID>) {
>>> +        let raw_item =3D ListArc::into_raw(item);
>>> +        // SAFETY:
>>> +        // * We just got `raw_item` from a `ListArc`, so it's in an `A=
rc`.
>>> +        // * If this requirement is violated, then the previous caller=
 of `prepare_to_insert`
>>> +        //   violated the safety requirement that they can't give up o=
wnership of the `ListArc`
>>> +        //   until they call `post_remove`.
>>
>> I don't like this negative phrasing, what about "Since we have ownership
>> of the `ListArc`, `post_remove` must have been called after each
>> previous call to `prepare_to_insert`."?
>=20
> I think we just need to argue about the most recent call to
> prepare_to_insert but ok.

I would argue that's exactly what my version does. Maybe "Since we have
ownership of the `ListArc`, the most recent call to `prepare_to_insert`
must have had a matching `post_remove` call afterwards."
But I liked the above version more.

>>> +        // * We own the `ListArc`.
>>> +        // * Removing items from this list is always done using `remov=
e_internal_inner`, which
>>> +        //   calls `post_remove` before giving up ownership.
>>> +        let list_links =3D unsafe { T::prepare_to_insert(raw_item) };
>>> +        // SAFETY: We have not yet called `post_remove`, so `list_link=
s` is still valid.
>>> +        let item =3D unsafe { ListLinks::fields(list_links) };
>>> +
>>> +        if self.first.is_null() {
>>> +            self.first =3D item;
>>> +            // SAFETY: The caller just gave us ownership of these fiel=
ds.
>>> +            // INVARIANT: A linked list with one item should be cyclic=
.
>>> +            unsafe {
>>> +                (*item).next =3D item;
>>> +                (*item).prev =3D item;
>>> +            }
>>> +        } else {
>>> +            let next =3D self.first;
>>> +            // SAFETY: By the type invariant, this pointer is valid or=
 null. We just checked that
>>> +            // it's not null, so it must be valid.
>>> +            let prev =3D unsafe { (*next).prev };
>>> +            // SAFETY: Pointers in a linked list are never dangling, a=
nd the caller just gave us
>>> +            // ownership of the fields on `item`.
>>> +            // INVARIANT: This correctly inserts `item` between `prev`=
 and `next`.
>>> +            unsafe {
>>> +                (*item).next =3D next;
>>> +                (*item).prev =3D prev;
>>> +                (*prev).next =3D item;
>>> +                (*next).prev =3D item;
>>> +            }
>>
>> You have this pattern several times, maybe make a function for this?
>=20
> It's just two times. I think it's fine.

Sure, it seemed more in my mind.

>>> +        if !next.is_null() {
>>> +            // This is really a no-op, but this ensures that `item` is=
 a raw pointer that was
>>> +            // obtained without going through a pointer->reference->po=
inter conversion rountrip.
>>> +            // This ensures that the list is valid under the more rest=
rictive strict provenance
>>> +            // ruleset.
>>> +            //
>>> +            // SAFETY: We just checked that `next` is not null, and it=
's not dangling by the
>>> +            // list invariants.
>>> +            unsafe {
>>> +                debug_assert_eq!(item, (*next).prev);
>>> +                item =3D (*next).prev;
>>> +            }
>>
>> How bad do you reckon is this for performance?
>=20
> I don't think it's a problem at all.

Sounds good.

---
Cheers,
Benno


