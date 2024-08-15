Return-Path: <linux-kernel+bounces-288020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D9495309C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DD9288400
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662441A4F1F;
	Thu, 15 Aug 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eM9P/b+6"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BC176ADE;
	Thu, 15 Aug 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729474; cv=none; b=fLWVZI7czB4pidIBYZ6ceuUvuS0evwRgZIgXpMWADQLCPDLfmMZcmgeKl+EXjX2oS7zWaCqzLr3J2cfDPHMNplYG8reE/pwM6OsqNQD9YhJ476pZkndRLUFDZe95GCaIp52X/YMZi5DRi8zat5wahDWCiKbKgta8ezOcxrC4BHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729474; c=relaxed/simple;
	bh=eNphmiHc83AKclX5Kb1J+PRW9v7p2ZiSzVk+iMnUfoQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYEQNOYSbYjOU3TSl3+Eq8WYagpNpEiSIO2DwHkfGh4ajHVx+Qf9cumwLKYwWi50S11pvYD52F5F4xglAO88vkFRkUiVRLs37cWHN9/ijHN3lA9A0FK9JQUJaTrePTQbIXQxnInVltd0i86g1/KEe/JaI8fY/kzCP2Ofe7P8rKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eM9P/b+6; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723729470; x=1723988670;
	bh=3VYeWvujsQ3yDJQHGGKJzkKmIzXIyBmtxkRQaNyIsdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eM9P/b+6X+siK4xfHqXgARV3W6l7uzGO52rWuCPqS2r3k+Xkvhknelzc7IDBfW2iM
	 cp840X0qhvqrl7ti87Xw7mPwoptnpLxslY8PQXoVsdbFyKUiA+ghhM0h1Ofo6DEQ+B
	 Jo9+tlWDDaTkamx64mtJCeyY9pEE5IKkr3y7HN0aeTQaKoUDn9Kdk+XChXulFKnm5h
	 GfdqjuC1wbUPZz559klCZZM9DpRt6PhEv2S9f1OtwruBzc88wwDeGFdqwo+MzQ77E5
	 U7FDg1164NT+gs9/Xdtt5K7QqlN39/zDzp+3MQ7mnmAM9F5/nqlbvrmtWbuDNofeA6
	 cnzBvQhX3g3Cg==
Date: Thu, 15 Aug 2024 13:44:27 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <01a46c6d-0107-4455-8c87-af43426752ff@proton.me>
In-Reply-To: <Zr30pNwc5aanRaqj@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-7-dakr@kernel.org> <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me> <Zr0r6sSFMSQIpHEX@cassiopeiae> <Zr072oSej9KIc1S6@cassiopeiae> <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me> <Zr30pNwc5aanRaqj@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 17ff0a7a46da8fb406562ea9cc13290e07cee10e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 14:29, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 06:48:19AM +0000, Benno Lossin wrote:
>> On 15.08.24 01:20, Danilo Krummrich wrote:
>>> On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
>>>>
>>>>>
>>>>>> +        ptr: Option<NonNull<u8>>,
>>>>>> +        layout: Layout,
>>>>>> +        flags: Flags,
>>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>>> +        // TODO: Support alignments larger than PAGE_SIZE.
>>>>>> +        if layout.align() > bindings::PAGE_SIZE {
>>>>>> +            pr_warn!("Vmalloc does not support alignments larger th=
an PAGE_SIZE yet.\n");
>>>>>> +            return Err(AllocError);
>>>>>
>>>>> I think here we should first try to use `build_error!`, most often th=
e
>>>>> alignment will be specified statically, so it should get optimized aw=
ay.
>>>>
>>>> Sure, we can try that first.
>>>
>>> I think I spoke too soon here. I don't think `build_error!` or `build_a=
ssert!`
>>> can work here, it would also fail the build when the compiler doesn't k=
now the
>>> value of the alignment, wouldn't it? I remember that I wasn't overly ha=
ppy about
>>> failing this on runtime either when I first thought about this case, bu=
t I also
>>> couldn't think of something better.
>>
>> Yes, it might fail even though the alignment at runtime will be fine.
>> But that's why I suggested trying `build_error!`(or `build_assert!`)
>> first, if nobody hits the case where the compiler cannot figure it out,
>> then we can keep it. If there are instances, where it fails, but the
>> alignment would be fine at runtime, then we can change it to the above.
>> (I would add such a comment above the assert).
>=20
> Unfortunately, it already does fail with just the test cases.

Aw that's sad.

> Anyway, even if it would have been fine, I don't think it would have been=
 nice
> for a future user to run into a build error even though the alignment is
> perfectlly within bounds.

I think it would have been better compared to failing with a warning at
runtime.

>>> In the end it's rather unlikely to ever hit this case, and probably eve=
n more
>>> unlikely to hit it for a sane reason.
>>
>> Yeah, but I still prefer the build to fail, rather than emitting a warn
>> message that can be overlooked at runtime.
>>
>>>>> How difficult will it be to support this? (it is a weird requirement,
>>>>> but I dislike just returning an error...)
>>>>
>>>> It's not difficult to support at all. But it requires a C API taking a=
n
>>>> alignment argument (same for `KVmalloc`).
>>
>> I see, that's good to know.
>>
>>>> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_align=
ed() would
>>>> be a bit weird though, because the alignment argument could only be re=
ally
>>>> honored if we run into the vrealloc() case. For the krealloc() case it=
'd still
>>>> depend on the bucket size that is selected for the requested size.
>>
>> Yeah... Maybe some more logic on the Rust side can help with that.
>=20
> Only if we reimplement `KVmalloc` in Rust, However, there are quite some =
special
> cases in __kvmalloc_node_noprof(), i.e. fixup page flags, sanity check th=
e size
> on kmalloc failure, fail on certain page flags, etc.
>=20
> I don't really want to duplicate this code, unless we absolutely have to.

I am under the (probably wrong) impression that kvmalloc has some size
check and selects vmalloc or kmalloc depending on that. I think that we
could check the size and if it is going to allocate via kmalloc, then we
adjust the size for alignment as usual and if it is going to select
vmalloc, then we can just pass the alignment (if the vmalloc alignment
patch is done first).=20

>>>> Adding the C API, I'm also pretty sure someone's gonna ask what we nee=
d an
>>>> alignment larger than PAGE_SIZE for and if we have a real use case for=
 that.
>>>> I'm not entirely sure we have a reasonable answer for that.
>>
>> We could argue that we can remove an "ugly hack" (when we don't have the
>> build assert, if we do have that, I don't mind not supporting it), but I
>> agree that finding a user will be difficult.
>=20
> I'd argue it's not really a hack to fail on something that's not supporte=
d
> (yet). Allocations can (almost) always fail, this is just another case.

I guess since this is a deterministic failure, it's better than other
failures. But I would still say this is hacky.

---
Cheers,
Benno


