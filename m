Return-Path: <linux-kernel+bounces-425857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB49DEBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5B163AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410C1A00D1;
	Fri, 29 Nov 2024 18:06:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB5224D6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903618; cv=none; b=NU63mj4GU3BZEuiziktkFfk2kqXMLi7ULzEZlwKUNp+jhyrSkIxAFNHX4/fGpMAc60NhPYGEG7tiEibGW111gk02UcQjEWyHjkpIeUGu2BTIeRYH6qvAgme0uunxZmciPF4LU2GFjmA80hU9TRezIuRey9pqQXIGbmUVUPJ9RyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903618; c=relaxed/simple;
	bh=K7PBpXaY0N4W14mF8ropk77HT3lSSfP+r+INOvWr24U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIUJhxinrPfs1apP/ejR9pZtGtZYyseKl/DlpW0npOS1TLbUVG5w++wnfD8Tjn/ICTgXXFySdf9fbtZqMoGDmRG2CK1yW+rY93QUtpRX6CFtnseRm4HYNRnAlxVxA/Uf4yZO7rgGGdrjQClAkDB9lDCgEipGqlyh1HXOMgzwfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 898C6FEC;
	Fri, 29 Nov 2024 10:07:23 -0800 (PST)
Received: from [10.57.90.216] (unknown [10.57.90.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 498B73F66E;
	Fri, 29 Nov 2024 10:06:52 -0800 (PST)
Message-ID: <7720d275-bc52-49c3-949a-6a6a32157418@arm.com>
Date: Fri, 29 Nov 2024 18:06:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, will@kernel.org, ptesarik@suse.com,
 hch@lst.de, jiangyutang@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
 <87ttbu8q7s.fsf@tarshish>
 <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>
 <Z0dbsRCsWT3hiVds@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z0dbsRCsWT3hiVds@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-27 5:49 pm, Catalin Marinas wrote:
> + Robin
> 
> On Tue, Nov 26, 2024 at 09:38:22AM -0800, Yang Shi wrote:
>> On 11/25/24 10:27 PM, Baruch Siach wrote:
>>> On Mon, Nov 25 2024, Yang Shi wrote:
>>>> The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
>>>> zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
>>>> returns the memsize limit in IORT or device tree instead of U32_MAX if
>>>> the memsize limit is greater than U32_MAX.
>>>
>>> Can you give a concrete example of memory layout and dma-ranges that
>>> demonstrates this issue?
>>
>> Our 2 sockets system has physical memory starts at 0x0 on node 0 and
>> 0x200000000000 on node 1. The memory size limit defined in IORT is 0x30 (48
>> bits).
>>
>> The DMA zone is:
>>
>> pages free     887722
>>          boost    0
>>          min      229
>>          low      1108
>>          high     1987
>>          promo    2866
>>          spanned  983040
>>          present  982034
>>          managed  903238
>>          cma      16384
>>          protection: (0, 0, 124824, 0, 0)
>>   start_pfn:           65536
>>
>> When allocating DMA buffer, dma_direct_optimal_gfp_mask() is called to
>> determine the proper zone constraints. If the phys_limit is less than
>> zone_dma_limit, it will use GFP_DMA. But zone_dma_limit is 0xffffffffffff on
>> v6.12 instead of 4G prior v6.12, it means all DMA buffer allocation will go
>> to DMA zone even though the devices don't require it.
>>
>> DMA zone is on node 0, so we saw excessive remote access on 2 sockets
>> system.
> [...]
>> The physical addr range for DMA zone is correct, the problem is wrong
>> zone_dma_limit. Before commit ba0fb44aed47 zone_dma_limit was 4G, after it
>> it is the whole memory even though DMA zone just covers low 4G.
> 
> Thanks for the details. I agree that zone_dma_limit shouldn't be higher
> than the ZONE_DMA upper boundary, otherwise it gets confusing for
> functions like dma_direct_optimal_gfp_mask() and we may force
> allocations to a specific range unnecessarily.

Oof, indeed the original min3() logic did also result in the 
32-bit-clamped value being written back to zone_dma_bits itself, so 
that's another subtlety overlooked in ba0fb44aed47 *and* the subsequent 
fixes reinstating that clamping (conditionally) within max_zone_phys().
  > If IORT or DT indicate a large mask covering the whole RAM (i.e. no
> restrictions), in an ideal world, we should normally extend ZONE_DMA to
> the same.

That's not right, ZONE_DMA should still be relatively limited in size 
(unless we really do only have a tiny amount of RAM) - just because a DT 
dma-ranges property says the system interconnect can carry >32 address 
bits in general doesn't mean that individual device DMA masks can't 
still be 32-bit or smaller. IIRC we're still implicitly assuming that if 
DT does describe an offset range into "high" RAM, it must represent a 
suitable lowest common denominator for all relevant devices already, and 
therefore we can get away with sizing ZONE_DMA off it blindly. I'm yet 
to hear of any platform having a general offset with no significant 
upper limit, but if we did want to support such a thing then we would 
need to revisit the previously-discussed notion of an accurate 
of_dma_get_min_cpu_address() rather than the assumption based on 
memblock_start_of_DRAM().

After staring at it for long enough, I think $SUBJECT patch is actually 
correct as it is. In fact I'm now wondering why the fix was put inside 
max_zone_phys() in the first place, since it's clearly pointless to 
clamp DMA_BIT_MASK(32) to U32_MAX in the dma32_phys_limit case...
However the commit message is perhaps not as clear as it could be - 
technically we are correctly *calculating* the appropriate effective 
zone_dma_limt value within the scope of zone_sizes_init(), we're just 
failing to properly update the actual zone_dma_limit variable for the 
benefit of other users.

Thanks,
Robin.

> One problem is ZONE_DMA32 (and GFP_DMA32) and the fact that
> ZONE_DMA sits below it. Until we hear otherwise, we assume a DMA offset
> of 0 for such 32-bit devices and therefore define ZONE_DMA32 in the
> lower 4GB if RAM starts below this limit (and an empty ZONE_DMA32 if RAM
> starts above).
> 
> Another aspect to consider is that we don't always have DT or IORT
> information or some devices need a smaller limit than what's advertised
> in the firmware tables (typically 32-bit masks). This code went through
> a couple of fixes already:
> 
> 833bd284a454 ("arm64: mm: fix DMA zone when dma-ranges is missing")
> 122c234ef4e1 ("arm64: mm: keep low RAM dma zone")
> 
> Since our current assumption is to assume ZONE_DMA within 32-bit if RAM
> below 4GB, I'm happy to make this conditional on CONFIG_ZONE_DMA32 also
> being enabled. So, from your patch below:
> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index d21f67d67cf5..ccdef53872a0 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -117,15 +117,6 @@ static void __init arch_reserve_crashkernel(void)
>>    static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>>    {
>> -	/**
>> -	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
>> -	 * bus constraints. Devices using DMA might have their own limitations.
>> -	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
>> -	 * DMA zone on platforms that have RAM there.
>> -	 */
>> -	if (memblock_start_of_DRAM() < U32_MAX)
>> -		zone_limit = min(zone_limit, U32_MAX);
>> -
>>    	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>>    }
> 
> This part is fine.
> 
>> @@ -141,6 +132,14 @@ static void __init zone_sizes_init(void)
>>    	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
>>    	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
>>    	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
>> +	/*
>> +	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
>> +	 * bus constraints. Devices using DMA might have their own limitations.
>> +	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
>> +	 * DMA zone on platforms that have RAM there.
>> +	 */
>> +	if (memblock_start_of_DRAM() < U32_MAX)
>> +		zone_dma_limit = min(zone_dma_limit, U32_MAX);
>>    	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>>    	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>>    #endif
> 
> But I'd move the zone_dma_limit update further down in the
> CONFIG_ZONE_DMA32 block. I think we only need to limit it to
> dma32_phys_limit and ignore the U32_MAX check. The former is already
> capped to 32-bit. For the second hunk, something like below (untested):
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d21f67d67cf5..ffaf5bd8d0a1 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -146,8 +146,10 @@ static void __init zone_sizes_init(void)
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
>   	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
> -	if (!arm64_dma_phys_limit)
> +	if (!arm64_dma_phys_limit || arm64_dma_phys_limit > dma32_phys_limit) {
>   		arm64_dma_phys_limit = dma32_phys_limit;
> +		zone_dma_limit = arm64_dma_phys_limit - 1;
> +	}
>   #endif
>   	if (!arm64_dma_phys_limit)
>   		arm64_dma_phys_limit = PHYS_MASK + 1;
> 
> With some comment on why we do this but most likely not the current
> comment in max_zone_phys() (more like keep ZONE_DMA below ZONE_DMA32).
> 


