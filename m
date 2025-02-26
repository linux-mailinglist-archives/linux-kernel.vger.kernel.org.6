Return-Path: <linux-kernel+bounces-533515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72DA45B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002EB1895041
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5128224223;
	Wed, 26 Feb 2025 10:19:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327220E302
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565141; cv=none; b=OaJsVAU1sD8NESKjH/LAuG1z62uE2r35Gcjz9DgQesUiADzqhJyCrDGX9g96jRaKU38PLtdQI5BEm0P+PTA4NMJmv219dPcEvMUvuJPodRmg7uUADSe7PAL37NY1Y9wv/WafN9HE3fJXL2M9mxvjZtT7BWDqpmvVBtR5hsz0zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565141; c=relaxed/simple;
	bh=QBD9h35PawRRg3Hu2fMVGX1BDXovZOq2VZ4btu6Yqew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV35V33rXl0a9jFz8UX+azfb9HKuwtDPcf3fi/LCkgdzvhQIKgue79Ri+e/QJ0YgRAAPUNMssuTI1Yx5Mw9+5aitzlXyTR8H2Qekp1xAillRnD1LJBHzUSggto/MPesI24ky7b+xC9cpB6SUoALrVvq3v8hFyHYl4ymgtDRdlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0C0C1BA8;
	Wed, 26 Feb 2025 02:19:14 -0800 (PST)
Received: from [10.57.84.229] (unknown [10.57.84.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C09D3F6A8;
	Wed, 26 Feb 2025 02:18:57 -0800 (PST)
Message-ID: <26a7ba50-e1cd-4c33-8b91-232413790786@arm.com>
Date: Wed, 26 Feb 2025 10:18:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
 <20250226001047.GA24197@willie-the-truck>
 <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
 <b0578d21-95cd-4d8a-add1-87299f36b491@arm.com>
 <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
 <b6b999c9-79cd-4945-9d7a-c5ee8158b7dc@arm.com>
 <CAMj1kXHesY77QhnW_U19UURGUqiBuQrNcL-kWQs7niaMa4nAng@mail.gmail.com>
 <2c465bdf-8028-4b05-8e18-3154735ce906@arm.com>
 <CAMj1kXGQSFh9A_uK6-i1-sd59i+yKg3vZxD+cYQ_vyz-HZJZKg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXGQSFh9A_uK6-i1-sd59i+yKg3vZxD+cYQ_vyz-HZJZKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 10:07, Ard Biesheuvel wrote:
> On Wed, 26 Feb 2025 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/02/2025 09:04, Ard Biesheuvel wrote:
>>> On Wed, 26 Feb 2025 at 09:55, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 26/02/2025 08:33, Ard Biesheuvel wrote:
>>>>> On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 26/02/2025 06:59, Ard Biesheuvel wrote:
>>>>>>> On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
>>>>>>>>> Apologies for the breakage, and thanks for the fix.
>>>>>>>>>
>>>>>>>>> I have to admit that I was a bit overzealous here: there is no point
>>>>>>>>> yet in using the sanitised value, given that we don't actually
>>>>>>>>> override the PA range in the first place.
>>>>>>
>>>>>> But unless I've misunderstood something, parange is overridden; Commit
>>>>>> 62cffa496aac (the same one we are fixing) adds an override to force parange to
>>>>>> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
>>>>>>
>>>>>> I thought it would be preferable to honour that override, hence my use of
>>>>>> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
>>>>>> about that case?
>>>>>>
>>>>>
>>>>> I wouldn't think so (but I'm glad you brought it up because this
>>>>> didn't occur to me at all tbh)
>>>>>
>>>>> With arm64.nolva, both the VA and PA ranges will be reduced, and so
>>>>> the range of the linear map will be 47 bits. So if the PA range is
>>>>> being reduced from 52 to 48, it will still exceed the size of the
>>>>> linear map, and so it should make no difference in this particular
>>>>> case.
>>>>
>>>> OK, so I think you're saying it'll happen to work correctly even if we ignore
>>>> that override? That sounds a bit fragile to me. Surely we should be consistent
>>>> and either always honour the override or remove the override in the first place?
>>>>
>>>
>>> I'm trying to walk a fine line here between consistent use of the
>>> override, and fixing something that I broke in a nasty way all the way
>>> back to 6.12.
>>>
>>> So yes, I agree that it would be better to use the override
>>> consistently, and this is what we should do going forward. But the
>>> purpose of the original patch was mainly to ensure that we
>>> consistently program the MMU either in LPA2 or in non-LPA2 mode, and
>>> not in a mix of the two. The linear mapping randomization change was
>>> kind of secondary.
>>>
>>> So perhaps this should be two patches:
>>> - backing out the use of the sanitised register, as proposed by Will,
>>> with cc:stable
>>> - a follow up based on your proposal, which can be backported later if
>>> needed, but without tagging it for stable.
>>
>> I suspect I'm misunderstanding something crucial about the way the linear map
>> randomization works (TBH the details of the signed comparisons went a little
>> over my head).
>>
>> But my rough understanding is that there are 2 values you want to compare; the
>> size of the linear map and the PA range. If the PA range is significantly bigger
>> than the linear map size then we conclude we have enough room to randomize.
> 
> It is the other way around: the linear map should be able to cover all
> system RAM that may appear anywhere in the PA space, and so if the PA
> space is very large (and memory hotplug is enabled), no randomization
> is possible, as it may end up mapping RAM that appears later past the
> top of the VA space. Note that the same is fundamentally true for
> running a 39-bit VA kernel on hardware that has a PA range that
> exceeds that.
> 
> As for the signed arithmetic: the randomization works by substracting
> from memstart_addr (aka PHYS_OFFSET). Normally, if system RAM starts
> at 1G, memstart_addr will be 1G, and the linear map will associate
> PAGE_OFFSET with PA 1G.
> 
> To randomize the linear mapping, the system RAM has to be moved up in
> the linear map (as this is the only direction it can be moved), and so
> PAGE_OFFSET needs to map to a lower value, and so memstart_addr may
> wrap around and become negative.
> 
>> (I
>> think this assumes that VA size is always GTE PA size). But if linear map size
>> is based on an overridden VA and overridden PA size (which I assume it must be,
>> given the pgtables will be limitted to the overridden VA size) and PA size is
>> not overridden, isn't it possible to wrongly conclude that there is enough room
>> to randomize when there really is not?
>>
> 
> No, if the linear map is only 47 bits, and the PA space is either 52
> or 48 bits, no randomization is possible. We might even run out of
> space without randomization, but this is an existing problem for
> non-LPA2 too.

Ahh that all makes much more sense now! I'm happy to go with the patch Will
proposed.

Thanks,
Ryan




