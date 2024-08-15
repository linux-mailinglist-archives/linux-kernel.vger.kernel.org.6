Return-Path: <linux-kernel+bounces-287574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1695297A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE994B231D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77217966F;
	Thu, 15 Aug 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W+dE1+u1"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB7BA53;
	Thu, 15 Aug 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704512; cv=none; b=RLFA8hfnUuEagqOUZNBfzvaSL64vRaIfDIUSspQPqgrWy/Uvlg/UkNPNhxIMRdrViK1nuyS7o5cRiaOXHVz7J2OItwS+JdyU0FTp5lLZTdz2YqlW5qVV7QJItL5GQdZ5bn4vXetj5sQ2hNdAiu9UvEd1fYi9hPwq6nLaJnvd8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704512; c=relaxed/simple;
	bh=Nh33MOapYcsyZSaE72pj/GAoYlZhrWgFlThVWqv5fpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3dt4StqSOXdx9GvYQoXjPdXptyrmTGyskIz+155A7j+RyOfiSonYUa88GBrY600ngF29AWXoGonocMEJApZlycaBYj1t37Pg/A4rg7bTDjPj+wtQOfSP79tlZEUEdJJ06ZwW2B07M7qKHGlayB/WBQWWaSeKRNWVAlc12Jz6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W+dE1+u1; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723704508; x=1723963708;
	bh=5I4uF48/D5iv+622qy+0xU6rTasLnm4ofO5ZVU8Faa0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W+dE1+u19fQ8vRibOHcKr1+/M5xi0Qu9fn4/aAdgRuLu2q2vDQMtjFuZ9NpkM++N2
	 G77L82ThfRUOnNo4JFkYH15EINEmEQRKz+DEJ8EsfOFHQVJQUEHHAm5J4uqC1/sIr7
	 ctQ4KcLFJ0kNXaZzoFba94wUqa8tAPPL2PqP33iHWq1d4cyGa/dl8UfngJXH3fDxiI
	 4MuwDIa87zbydoAvTQ07vrF5/IUydQKPzKyQpgrkUQiy0FD2UmRIMbjySk4WWs7eJY
	 vT+RATNBIvosrqPtmZo0rXAP+hq9cd4L728GKULHaV0FTDcsxT+jOSCBIxtvzNxPhF
	 pHMnPgs5l1uIw==
Date: Thu, 15 Aug 2024 06:48:19 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me>
In-Reply-To: <Zr072oSej9KIc1S6@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-7-dakr@kernel.org> <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me> <Zr0r6sSFMSQIpHEX@cassiopeiae> <Zr072oSej9KIc1S6@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7dce0f614b91ef9b8e959229288c0aba3f8bbc85
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 01:20, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
>>
>>>
>>>> +        ptr: Option<NonNull<u8>>,
>>>> +        layout: Layout,
>>>> +        flags: Flags,
>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>> +        // TODO: Support alignments larger than PAGE_SIZE.
>>>> +        if layout.align() > bindings::PAGE_SIZE {
>>>> +            pr_warn!("Vmalloc does not support alignments larger than=
 PAGE_SIZE yet.\n");
>>>> +            return Err(AllocError);
>>>
>>> I think here we should first try to use `build_error!`, most often the
>>> alignment will be specified statically, so it should get optimized away=
.
>>
>> Sure, we can try that first.
>=20
> I think I spoke too soon here. I don't think `build_error!` or `build_ass=
ert!`
> can work here, it would also fail the build when the compiler doesn't kno=
w the
> value of the alignment, wouldn't it? I remember that I wasn't overly happ=
y about
> failing this on runtime either when I first thought about this case, but =
I also
> couldn't think of something better.

Yes, it might fail even though the alignment at runtime will be fine.
But that's why I suggested trying `build_error!`(or `build_assert!`)
first, if nobody hits the case where the compiler cannot figure it out,
then we can keep it. If there are instances, where it fails, but the
alignment would be fine at runtime, then we can change it to the above.
(I would add such a comment above the assert).

> In the end it's rather unlikely to ever hit this case, and probably even =
more
> unlikely to hit it for a sane reason.

Yeah, but I still prefer the build to fail, rather than emitting a warn
message that can be overlooked at runtime.

>>> How difficult will it be to support this? (it is a weird requirement,
>>> but I dislike just returning an error...)
>>
>> It's not difficult to support at all. But it requires a C API taking an
>> alignment argument (same for `KVmalloc`).

I see, that's good to know.

>> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_aligned=
() would
>> be a bit weird though, because the alignment argument could only be real=
ly
>> honored if we run into the vrealloc() case. For the krealloc() case it'd=
 still
>> depend on the bucket size that is selected for the requested size.

Yeah... Maybe some more logic on the Rust side can help with that.

>> Adding the C API, I'm also pretty sure someone's gonna ask what we need =
an
>> alignment larger than PAGE_SIZE for and if we have a real use case for t=
hat.
>> I'm not entirely sure we have a reasonable answer for that.

We could argue that we can remove an "ugly hack" (when we don't have the
build assert, if we do have that, I don't mind not supporting it), but I
agree that finding a user will be difficult.

>> I got some hacked up patches for that, but I'd rather polish and send th=
em once
>> we actually need it.

Sure, just wanted to check why you don't want to do it this series.

---
Cheers,
Benno


