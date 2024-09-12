Return-Path: <linux-kernel+bounces-326171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31FF97643C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFDC283BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F781917E8;
	Thu, 12 Sep 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZUS5ChCC"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CC18E764;
	Thu, 12 Sep 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129143; cv=none; b=eXp2ojDirbFDsuX8L4nthQ/VyvMmYEtm1Cxk011jtLQMk10hOZz0eIegN2Os7LCRUCm1ZvecdYrsJqCnozzCSAftqO9Grl2fKjTnzQm6cHV15DieUa9pG+MUKvbFZT5d3Dbed5suHjMIqbmc6LTLK4LTd1D5mtiYFSJg+ll3q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129143; c=relaxed/simple;
	bh=C7bGRTs5k0M/c+01U+T4gd19hO54MhrssoK3Lu0cgn8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdv4HS3G3xIxub/C3CzaGIN1QJMMwrfwLHl79TJkpoLH2B4TWHWNT/312yBw2Y3U9G0uiZzOqP/I0pvnZu3BNWiICqHTeWO3ApvhySsc+c2RahBUD3ZqJ2nRhklXwh9kNPkEy/a0BnhgnQtQI7wwph2r4McMgVvGSPpFggheynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZUS5ChCC; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rm764jmzjrfdlpu23jcgp3ybda.protonmail; t=1726129133; x=1726388333;
	bh=4BCBkUymeOe6HphWwcmNL8sLnaSR+aRCcfpXpcPxwcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZUS5ChCC71JlgP0VafuBMNeaejGL/HBp/Pkfvrj5+IFLW8uLTnn+7Y+vdLWFYQaj1
	 5DM/MsgtJy6N4RMMPWe0cLWdBWfEMmuG/jusPJWzcoJxbJRvUdfxOeagrAtEqhhKk0
	 Xt3SWtlmA9CIbENxMX+U4QHVL91FvgXl0LUHURVOSlUWzjrpJHMqFIFbCUMML6Z7H4
	 XCm+ttKk6Wrt2HdhXd535JBtlDrVvD70KjmalaBmGAbwijpb2Hia9IvN4dZJqutclv
	 AP1VlkFzhjv+sD5REWcxLByDqwiHFwy7RthhsbtNFW5NEBcnniEJfA1dOXnN0I2lco
	 3j2UT5uswxilA==
Date: Thu, 12 Sep 2024 08:18:49 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <9561eb0e-796c-4a39-b49a-00013052fe4b@proton.me>
In-Reply-To: <ZuGrQcLwXi-tiK8l@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-23-dakr@kernel.org> <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me> <ZtD1TsGm0swi7gyv@pollux.localdomain> <ZuGNlFluwAmTG19R@cassiopeiae> <bf158e23-4123-419b-a2ce-a27c4ea51219@proton.me> <ZuGrQcLwXi-tiK8l@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 290574dee1d25111830bc8a59bafc078c55d9c5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 16:37, Danilo Krummrich wrote:
> On Wed, Sep 11, 2024 at 01:32:31PM +0000, Benno Lossin wrote:
>> On 11.09.24 14:31, Danilo Krummrich wrote:
>>> On Fri, Aug 30, 2024 at 12:25:27AM +0200, Danilo Krummrich wrote:
>>>> On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
>>>>> On 16.08.24 02:11, Danilo Krummrich wrote:
>>>>>> +
>>>>>> +        if layout.size() =3D=3D 0 {
>>>>>> +            // SAFETY: `src` has been created by `Self::alloc_store=
_data`.
>>>>>
>>>>> This is not true, consider:
>>>>>
>>>>>     let ptr =3D alloc(size =3D 0);
>>>>>     free(ptr)
>>>>>
>>>>> Alloc will return a dangling pointer due to the first if statement an=
d
>>>>> then this function will pass it to `free_read_data`, even though it
>>>>> wasn't created by `alloc_store_data`.
>>>>> This isn't forbidden by the `Allocator` trait function's safety
>>>>> requirements.
>>>>>
>>>>>> +            unsafe { Self::free_read_data(src) };
>>>>>> +
>>>>>> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangli=
ng(), 0));
>>>>>> +        }
>>>>>> +
>>>>>> +        let dst =3D Self::alloc(layout, flags)?;
>>>>>> +
>>>>>> +        // SAFETY: `src` has been created by `Self::alloc_store_dat=
a`.
>>>>>> +        let data =3D unsafe { Self::data(src) };
>>>>>
>>>>> Same issue here, if the allocation passed in is zero size. I think yo=
u
>>>>> have no other choice than to allocate even for zero size requests...
>>>>> Otherwise how would you know that they are zero-sized.
>>>>
>>>> Good catch - gonna fix it.
>>>
>>> Almost got me. :) I think the code is fine, callers are not allowed to =
pass
>>> pointers to `realloc` and `free`, which haven't been allocated with the=
 same
>>> corresponding allocator or are dangling.
>>
>> But what about the example above (ie the `alloc(size =3D 0)` and then
>> `free`)?
>=20
> This never has been valid for the `Allocator` trait. Look at `Kmalloc`,
> `Vmalloc` and `KVmalloc`, they don't allow this either.

That is true.

> We've discussed this already in previous versions of this series, where f=
or this
> purpose, you asked for `old_layout` for `free`. Such that `free` can chec=
k if
> the `size` was zero and therefore return without doing anything.

Yes, but that was only about the old_layout parameter (at least that's
what I thought).

>> I guess this all depends on how one interprets the term
>> "existing, valid memory allocation". To me that describes anything an
>> `Allocator` returns via `alloc` and `realloc`, including zero-sized
>> allocations.
>=20
> I argue that the dangling pointer returned for `size =3D=3D 0` does not p=
oint to any
> allocation in the sense of those allocators. It's just a dangling `[u8]`
> pointer.

Sure, but to me the concept of zero-sized allocations does exist.

>> But if you argue that those are not valid allocations from that
>> allocator, then that is not properly documented in the safety
>> requirements of `Allocator`.
>=20
> The safety requirements of `Allocator` where proposed by you and I though=
t they
> consider this aspect?

No, they did not consider this aspect. I was under the impression, that
we would still allow zero-sized allocations (in retrospect, this is
stupid, since dangling pointers shouldn't be passed to `krealloc` etc.).

> `realloc` has:
>=20
> "If `ptr =3D=3D Some(p)`, then `p` must point to an existing and valid me=
mory
> allocation created by this allocator."
>=20
> `free` has:
>=20
> "`ptr` must point to an existing and valid memory allocation created by t=
his
> `Allocator` and must not be a dangling pointer."
>=20
> We can add the part about the dangling pointer to `realloc` if you want.

So I think we should do the following:=20
(1) Add a paragraph to the `Allocator` trait that explains that
    zero-sized allocations are not supported.
(2) Add a check to `realloc` for zero-sized allocations + null pointer
    (ie a new allocation request) that prints a warning and returns an
    error
(3) Instead of writing "existing and valid memory allocation created by
    this allocator", I think "valid non-zero-sized memory allocation
    created by this allocator" fits better.

---
Cheers,
Benno


