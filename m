Return-Path: <linux-kernel+bounces-422431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6989D9993
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5333216460C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9971D5AB5;
	Tue, 26 Nov 2024 14:26:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9E2EAE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631198; cv=none; b=TnPorswsjpRrOabvAWYzM19oxdWBphbHwKfbGj3pU62Km2CaIdupw4Hg7otPVoIIyXeygAno8IwI15zfwetT5IAKMqHzCj0sk7PCcJxjhxyn3EPVzwb18E/5o36BMQlRACIQgHAR3RfQpohk7wJJSv+OppKiBTPL3n51D1yIdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631198; c=relaxed/simple;
	bh=+ML6lXgDwquaXKIIp4MwMHohMsTX5RT5aqMCa30JQtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovjGwdphtlXLWtT6RSLgDW9o0h/vZI55wbQ1t6Dg/s3plNgXhP1taXiZo3XUkVYRI37xXjO6gxFduY08vLZHXAySvsey0gkh7bgULED1rSMetcx0Gw/pyH/WaLIcwJbVcepqfJ48efZPK2HpmvqnM3T41qjGdAD3cgBJKy7S7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8891A00;
	Tue, 26 Nov 2024 06:27:03 -0800 (PST)
Received: from [10.1.29.199] (XHFQ2J9959.cambridge.arm.com [10.1.29.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8A543F5A1;
	Tue, 26 Nov 2024 06:26:32 -0800 (PST)
Message-ID: <eec0427f-5519-400e-ae8e-ba743e1a3f33@arm.com>
Date: Tue, 26 Nov 2024 14:26:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Dave Kleikamp
 <dave.kleikamp@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
 <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
 <9675f4f0-6290-43aa-bf17-6b9c2b461485@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9675f4f0-6290-43aa-bf17-6b9c2b461485@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 12:36, Vlastimil Babka wrote:
> On 11/26/24 13:18, Ryan Roberts wrote:
>> On 14/11/2024 10:09, Vlastimil Babka wrote:
>>> On 11/1/24 21:16, Dave Kleikamp wrote:
>>>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>>>> is no longer optimized out with a constant size, so a build bug may
>>>> occur on a path that won't be reached.
>>>
>>> That's rather unfortunate, the __builtin_constant_p(size) part of
>>> kmalloc_noprof() really expects things to resolve at compile time and it
>>> would be better to keep it that way.
>>>
>>> I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
>>> PAGE_SHIFT_MAX and kept it constant, instead of introducing
>>> KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.
>>>
>>> So if the kernel was built to support 4k to 64k, but booted as 4k, it would
>>> still create and use kmalloc caches up to 128k. SLUB should handle that fine
>>> (if not, please report it :)
>>
>> So when PAGE_SIZE_MAX=64K and PAGE_SIZE=4K, kmalloc will support up to 128K
>> whereas before it only supported up to 8K. I was trying to avoid that since I
>> assumed that would be costly in terms of extra memory allocated for those higher
>> order buckets that will never be used. But I have no idea how SLUB works in
>> practice. Perhaps memory for the cache is only lazily allocated so we won't see
>> an issue in practice?
> 
> Yes the e.g. 128k slabs themselves will be lazily allocated. There will be
> some overhead with the management structures (struct kmem_cache etc) but
> much smaller.
> To be completely honest, some extra overhead might come to be when the slabs
> are allocated ans later the user frees those allocations. kmalloc_large()
> wwould return them immediately, while a regular kmem_cache will keep one or
> more per cpu for reuse. But if that becomes a visible problem we can tune
> those caches to discard slabs more aggressively.
> 
>> I'm happy to make this change if you're certain it's the right approach; please
>> confirm.
> 
> Yes it's much better option than breaking the build-time-constant part of
> kmalloc_noprof().

OK, I'll take this approach as you suggest.

Thanks,
Ryan

> 
>>>
>>> Maybe we could also stop adding + 1 to PAGE_SHIFT_MAX if it's >=64k, so the
>>> cache size is max 64k and not 128k but that should be probably evaluated
>>> separately from this series.
>>
>> I'm inferring from this that perhaps there is a memory cost with having the
>> higher orders defined but unused.
> 
> Yeah as per above, should not be too large and we could tune it down if
> necessary.
> 
>> Thanks,
>> Ryan
>>
>>>
>>> Vlastimil
>>>
>>>> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
>>>>
>>>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>>>> ---
>>>>
>>>> Ryan,
>>>>
>>>> Please consider incorporating this fix or something similar into your
>>>> mm patch in the boot-time pages size patches.
>>>>
>>>>   include/linux/slab.h | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>>> index 9848296ca6ba..a4c7507ab8ec 100644
>>>> --- a/include/linux/slab.h
>>>> +++ b/include/linux/slab.h
>>>> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>>>>   	if (size <= 1024 * 1024) return 20;
>>>>   	if (size <=  2 * 1024 * 1024) return 21;
>>>>   
>>>> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>>> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
>>>> +	    !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>>>   		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>>>>   	else
>>>>   		BUG();
>>>
>>
> 


