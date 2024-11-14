Return-Path: <linux-kernel+bounces-409004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2A9C8657
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FE2B225AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203E1F4710;
	Thu, 14 Nov 2024 09:36:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880501991CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576985; cv=none; b=a3U/7FLA2ABoTMUUUltOBQlqpK/AM03awBLuaJc1iRZ5P2oFvM9sclSErCb5hD1/culRnd/ciYnpXWN3ODKWxDzdVv/fofs3W9CDMFDw4OM24JnlCKX7qNpHpAw84RKVrXwarmBTVES6v69SzLSXmb85homWaaFK22nWPdJMJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576985; c=relaxed/simple;
	bh=aZUSogk2CwXx+etiKHmjENwHmDkzyUxo+zF4X6G/r2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2HJTJhaR22mABwaqKTN9OHQWH41vKFrUwYUaaolZWyDGZRcIQp7vdtxecZSGq+YioMTd/uYoINDxTa5Wr6KkKSXcw/0l2SMPqwibOsAlqC8i2DwFlLfqONp16rTLjTC1LHwZhzKA0XDhRawz5ChrO800f7BzgriljH6bj8272w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D061474;
	Thu, 14 Nov 2024 01:36:51 -0800 (PST)
Received: from [10.57.89.178] (unknown [10.57.89.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C74D23F59E;
	Thu, 14 Nov 2024 01:36:18 -0800 (PST)
Message-ID: <0aabbc9e-8808-4aaa-a722-49ed3d45d15e@arm.com>
Date: Thu, 14 Nov 2024 09:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/57] mm/page_alloc: Make page_frag_cache
 boot-time page size compatible
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-4-ryan.roberts@arm.com>
 <1d9f9188-42b1-4f83-87e7-e02a22b67caa@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1d9f9188-42b1-4f83-87e7-e02a22b67caa@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 08:23, Vlastimil Babka wrote:
> On 10/14/24 12:58, Ryan Roberts wrote:
>> "struct page_frag_cache" has some optimizations that depend on page
>> size. Let's refactor it a bit so that those optimizations can be
>> determined at run-time for the case where page size is a boot-time
>> parameter. For compile-time page size, the compiler should dead code
>> strip and the result is very similar to before.
>>
>> One wrinkle is that we don't know if we need the size member until
>> runtime. So remove the ifdeffery and always define offset as u32 (needed
>> if PAGE_SIZE is >= 64K) and size as u16 (only used when PAGE_SIZE <=
>> 32K). We move the members around a bit so that the overall size of the
>> struct remains the same; 24 bytes for 64-bit and 16 bytes on 32 bit.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Looks ok, but ideally the PAGE_FRAG_CACHE_MAX_ORDER #define should also be
> replaced by some variable that's populated just once. It can be static local
> to page_alloc.c as nothing else seems to use it.

I can certainly do that, but wouldn't that be penalizing a compile-time page
size configuration? My current change means that PAGE_FRAG_CACHE_MAX_ORDER still
resolves to a compile-time constant in that situation and the compiler can
eliminate conditional branches it knows will never be taken. Or perhaps you're
suggesting I conditionally make it a variable if PAGE_SIZE_MIN != PAGE_SIZE_MAX?

Thanks,
Ryan

> 
>>
>> page_alloc
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  include/linux/mm_types.h | 13 ++++++-------
>>  mm/page_alloc.c          | 31 ++++++++++++++++++-------------
>>  2 files changed, 24 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 4854249792545..0844ed7cfaa53 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -544,16 +544,15 @@ static inline void *folio_get_private(struct folio *folio)
>>  
>>  struct page_frag_cache {
>>  	void * va;
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -	__u16 offset;
>> -	__u16 size;
>> -#else
>> -	__u32 offset;
>> -#endif
>>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>>  	 * containing page->_refcount every time we allocate a fragment.
>>  	 */
>> -	unsigned int		pagecnt_bias;
>> +	unsigned int pagecnt_bias;
>> +	__u32 offset;
>> +	/* size only used when PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE, in which
>> +	 * case PAGE_FRAG_CACHE_MAX_SIZE is 32K and 16 bits is sufficient.
>> +	 */
>> +	__u16 size;
>>  	bool pfmemalloc;
>>  };
>>  
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 91ace8ca97e21..8678103b1b396 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4822,13 +4822,18 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>  	struct page *page = NULL;
>>  	gfp_t gfp = gfp_mask;
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>> -		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>> -	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>> -				PAGE_FRAG_CACHE_MAX_ORDER);
>> -	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>> -#endif
>> +	if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) {
>> +		gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>> +			   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>> +		page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>> +					PAGE_FRAG_CACHE_MAX_ORDER);
>> +		/*
>> +		 * Cast to silence warning due to 16-bit nc->size. Not real
>> +		 * because PAGE_SIZE only less than PAGE_FRAG_CACHE_MAX_SIZE
>> +		 * when PAGE_FRAG_CACHE_MAX_SIZE is 32K.
>> +		 */
>> +		nc->size = (__u16)(page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE);
>> +	}
>>  	if (unlikely(!page))
>>  		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>>  
>> @@ -4870,10 +4875,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  		if (!page)
>>  			return NULL;
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>  		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>> +		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +			size = nc->size;
>> +
>>  		/* Even if we own the page, we do not use atomic_set().
>>  		 * This would break get_page_unless_zero() users.
>>  		 */
>> @@ -4897,10 +4902,10 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  			goto refill;
>>  		}
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>  		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>> +		if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +			size = nc->size;
>> +
>>  		/* OK, page count is 0, we can safely set it */
>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>  
> 


