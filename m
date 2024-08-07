Return-Path: <linux-kernel+bounces-278508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D468094B115
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045BA1C226F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27021145B0B;
	Wed,  7 Aug 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IDQngxhn"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124D14535E;
	Wed,  7 Aug 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061757; cv=none; b=qkW89wwMLz76mAp2gFQiCpGSADkLCdgUMYjV5dDA94gh367Gb6nDA/6xXi0AfRubvdguJZs+M9B7hY6I+w2lsdMgT+sYtypKJHkyI57bTPuSZ0ObCAJN/1bMpT9i5QN87JLgAmPaLRNBGcyIpDZwIzuO7tnaJ4Oyj10ldKxSGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061757; c=relaxed/simple;
	bh=jh0AdcVeeMkdyjYK5lkojynigc94NFXh8QVfdB2Fqys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsOCgNER8xDeZkEAqPC8oPPfRNQvg8ekChIRUvLk33WVuOscg8jl84SGVtEbts3/KheTrfR445Gacfd4w3uQYRK8kYS+P+kvI2EFycrw+TII1p8fdlqphOw8dDO/kIQBlX9UrH2Blz4/Cwr4aIstyKluL3q2lztklK7drxdz5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IDQngxhn; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723061746; x=1723320946;
	bh=HKBMDO7WdEiYnxpR3fe//m4q8iJ7+/+jObANMMOKCPk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IDQngxhnV/TC4ExY1+O39n4TSbTAMaYv9Q3uZHDeFs7bH5rtAf2FAT9wZy2FKaI0z
	 Ek7rZYdl6S50TCSGxzBcYk1yclQcXl8VAouQ2ML0fN6R3wDbZmBsymI/UHoeoL7EMK
	 OatqynJhAmRBFV87Tafn2edESRSR3qm/BLdxOK5emgSBeYDFIMG7E3leP2sw2FEClA
	 SJwxtJsaNlNbs2lqWCw42Emm0hIjQiQVLqOXSvpnPBgQtiJbVwSfO03QA9XaoPWoLB
	 9ukljy07ZLJ559HqigACy3Km6kRQtiM2UfnR2gKg4a2IpnmCx7nQU7zrJTwauaWlz4
	 czgN9hxYcqAwA==
Date: Wed, 07 Aug 2024 20:15:41 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me>
In-Reply-To: <ZrNIaAcGkGU0d8I3@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-5-dakr@kernel.org> <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me> <ZrJxkwF2Y59xln1e@pollux.localdomain> <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me> <ZrNIaAcGkGU0d8I3@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4ea2f0b0fd8cd8905f6ba679d282a0166039e94c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 12:11, Danilo Krummrich wrote:
> On Wed, Aug 07, 2024 at 07:14:13AM +0000, Benno Lossin wrote:
>> On 06.08.24 20:55, Danilo Krummrich wrote:
>>> On Tue, Aug 06, 2024 at 04:51:28PM +0000, Benno Lossin wrote:
>>>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>>>> +        let raw_ptr =3D unsafe {
>>>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory beh=
ind the pointer is freed.
>>>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>>>> +        };
>>>>> +
>>>>> +        let ptr =3D if size =3D=3D 0 {
>>>>> +            NonNull::dangling()
>>>>
>>>> If we call `realloc(Some(ptr), <layout with size =3D 0>, ...)`, then t=
his
>>>> leaks the pointer returned by the call to `self.0` above. I don't know
>>>> what the return value of the different functions are that can appear i=
n
>>>> `self.0`, do they return NULL?
>>>
>>> That is fine, we don't care about the return value. All `ReallocFunc` f=
ree the
>>> memory behind `ptr` if called with a size of zero. But to answer the qu=
estion,
>>> they return either NULL or ZERO_SIZE_PTR.
>>
>> I see, then it's fine. I think it would help if we know the exact
>> behavior of `kmalloc` & friends (either add a link to C docs or write it
>> down on `ReallocFunc`).
>>
>>>> What about the following sequence:
>>>>
>>>>     let ptr =3D realloc(None, <layout with size =3D 0>, ...);
>>>>     let ptr =3D realloc(Some(ptr), <layout with size =3D 0>, ...);
>>>>
>>>> Then the above call to `self.0` is done with a dangling pointer, can t=
he
>>>> functions that appear in `self.0` handle that?
>>>
>>> This would be incorrect.
>>>
>>> Calling `realloc(Some(ptr), <layout with size =3D 0>, ...)` frees the m=
emory
>>> behind `ptr`. This is guranteed behavior for all `ReallocFunc`s, i.e.
>>> krealloc(), vrealloc(), kvrealloc().
>>
>> Note that I don't use `ptr` afterwards, the code snippet above is
>> equivalent to this:
>>
>>     let ptr =3D Kmalloc::alloc(<layout with size =3D 0>, ...);
>>     unsafe { Kmalloc::free(ptr) };
>>
>> internally exactly the realloc calls that I put above should be called.
>=20
> I think I misunderstood what you mean here.
>=20
> So, that's not permitted. `free` can't be called with a dangling pointer.=
 The
> kernel free functions (*1) can't handle it, and I can't detect it, since =
a
> dangling pointer does not have a descrete value.

That is true, but only if we do not have access to the old layout of the
allocation. If we add `old_layout` as a parameter, then we can handle
dangling pointers.

> We can decide for a specific dangling pointer to be allowed, i.e. the dan=
gling
> pointer returned by `alloc` for a zero sized allocation is always
> `dangling<u8>`, so we can assert that `free` is only allowed to be called=
 with
> what was previously returned by `alloc` or `free` and therefore disallow
> dangling pointers with a different alignment.

I don't like that.

> Surely, we could also let the caller pass the old alignment, but this all=
 sounds
> complicated for something that is very trivial for the caller to take car=
e of,
> i.e. just don't try to free something that was never actually allocated.
>=20
> It can also lead to subtle bugs, e.g. what if someone calls `Box::from_ra=
w` for
> a ZST with some other random pointer? Currently, that doesn't hurt us, wh=
ich for
> robustness, seems to be a good thing.

I think we should forbid that. To me it's just plain wrong to take a
random integer literal and cast it to a ZST. IIRC it even is UB if that
points to a previously allocated object that has been freed (but I don't
remember where I read it...).

Also if we use the size of the old layout instead of comparing alignment
with the address of the pointer, then we avoid this issue.

> I think it's better to just let `Box` and `Vec` figure out if calling `fr=
ee` is
> the right thing to do. The code for that is simple and obvious, i.e. chec=
k if
> `T` is a ZST.

I don't think that it is as simple as you make it out to be. To me this
is functionality that we can move into one place and never have to think
about again.
Also if we at some point decide to add some sort of debugging allocator
(am I right in assuming that such a thing already exists for C?) then we
might want to tag on extra data in the allocation, in that case it would
be very useful if the allocator also saw zero-sized allocations, since
we should check all allocations.

> *1: kfree() can handle dangling pointers up to 16 bytes aligned, see
> ZERO_OR_NULL_PTR(x).

I agree with you that we shouldn't rely on that.

---
Cheers,
Benno


