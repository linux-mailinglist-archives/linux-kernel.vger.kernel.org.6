Return-Path: <linux-kernel+bounces-355196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D62994A83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECC128AC8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1D1DE8AA;
	Tue,  8 Oct 2024 12:33:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7EC1DE894
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390815; cv=none; b=di9xfoNSzGy1NhvPZLPV7EKJ+3tMpAd46bS+jHioVl6himJ/dN460KBXBNUiGw12/ulSe/YlYePriG62xWa/w13WjjUoLB39r4AyasN9D5u3xJEjmPpL+MZ61QB93yTxWZHm77NE6JQuvjZjhL3fa6r/NW0LZCbgirU6M0AOXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390815; c=relaxed/simple;
	bh=NWof8UdFrfKbjohmLF/QcwhkcET8ROXxi1eaNixXJXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6yBdzmMAZ34I5kWBCpyJr91585p8ZmfQU6ORXv6JSWpN4oYkMahwjpG6ZO6tPbBjAyYaJsq4s+qNGZGIl1IJuaIk9nfoOXzhNgmw09T6cM3ckpyceDhWOlWZlV7HV2+EFJz0TnznB2eTrYN8jzPdHmO9I87NSHteWfJOb5ABn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28439DA7;
	Tue,  8 Oct 2024 05:34:02 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17DE3F73F;
	Tue,  8 Oct 2024 05:33:30 -0700 (PDT)
Message-ID: <b54649a0-3bba-4c05-bc53-a5c62e1a36b8@arm.com>
Date: Tue, 8 Oct 2024 13:33:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
To: Pankaj Patil <quic_pankpati@quicinc.com>,
 Doug Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Stephen Boyd <swboyd@chromium.org>,
 Chen Lin <chen45464546@163.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 quic_sibis@quicinc.com
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
 <20240517163742.GA525@willie-the-truck>
 <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
 <b143a3c3-8a12-4ac9-bb0f-3b4b9ea976a1@quicinc.com>
 <98d56e5e-47ca-45d8-8e0e-07c204fcc04b@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <98d56e5e-47ca-45d8-8e0e-07c204fcc04b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/10/2024 11:03 am, Pankaj Patil wrote:
> On 9/4/2024 1:59 PM, Pankaj Patil wrote:
>> On 5/17/2024 10:49 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, May 17, 2024 at 9:37 AM Will Deacon <will@kernel.org> wrote:
>>>>
>>>> Hi Doug,
>>>>
>>>> On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
>>>>> On sc7180 trogdor devices we get a scary warning at bootup:
>>>>>    arm-smmu 15000000.iommu:
>>>>>    Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK
>>>>>
>>>>> We spent some time trying to figure out how we were going to fix these
>>>>> errata and whether we needed to do a firmware update. Upon closer
>>>>> inspection, however, we realized that the errata don't apply to us.
>>>>> Specifically, the errata document says that for these errata:
>>>>> * Found in: r0p0
>>>>> * Fixed in: r2p2
>>>>>
>>>>> ...and trogdor devices appear to be running r2p4. That means that they
>>>>> are unaffected despite the scary warning.
>>>>>
>>>>> The issue is that the kernel unconditionally tries to disable the
>>>>> prefetcher even on unaffected devices and then warns when it's unable
>>>>> to.
>>>>>
>>>>> Let's change the kernel to only disable the prefetcher on affected
>>>>> devices, which will get rid of the scary warning on devices that are
>>>>> unaffected. As per the comment the prefetcher is
>>>>> "not-particularly-beneficial" but it shouldn't hurt to leave it on for
>>>>> devices where it doesn't cause problems.
>>>>>
>>>>> Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>> ---
>>>>>
>>>>>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
>>>>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>>>
>>>>
>>>> Just curious, but did you see any performance impact (good or bad) as a
>>>> result of this patch? The next-page prefetcher has always looked a little
>>>> naive to me and, with a tendency for tiny TLBs in some implementations,
>>>> there's a possibility it could do more harm than good.
>>>
>>> This patch actually makes no difference on trogdor today other than
>>> getting rid of the scary warning. Specifically on trogdor the
>>> ACR.CACHE_LOCK bit seems to be set so the kernel is unable to change
>>> the setting anyway and has never been able to. We are working on
>>> figuring out how to fix the firmware and then we have to get a
>>> firmware spin before we can really see any changes. I'll keep an eye
>>> out to see if performance numbers change when the firmware uprevs.
>>>
>>> BTW: any idea how big of a deal these errata are? We're _just_
>>> finishing a firmware uprev process and there is always pushback
>>> against kicking off a new one unless the issue is important. Given
>>> that we've been living with this issue since devices shipped I'm going
>>> to assume we don't need to rush a firmware update, but if this is
>>> really scary and needs to be addressed sooner we can figure that out.
>>>
>>> -Doug
>>
>> Receiving the warning on pre-silicon platforms as well, despite being unaffected. If merged, it will help in reducing log clutter.
>> The patch applies cleanly on the tip of linux-next, tag: next-20240904.
>>
> Following up on the patch. Please let me know if any additional
> changes are required.

Surely at pre-silicon there's really very little excuse for not just 
fixing the firmware? Anyway, it remains the case that the real issue 
here is the message and comment being misleadingly over-specific, and I 
already sent a patch to address that[1].

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/7c426dc0-4fde-4d1e-bb91-538984bd8b59@arm.com/

