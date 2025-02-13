Return-Path: <linux-kernel+bounces-512357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05666A33803
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A79188C82F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8820765F;
	Thu, 13 Feb 2025 06:36:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23F13B29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428580; cv=none; b=YyGpyHA+IV++brZdt225lMCaK49WqfmRUkXWhRN8njLiY0T9xyXza0kJglGWWQxQN9mOUUqDlhtpOyCwIaPfsEhR9Pn/M7FzntNRr4tJ6cyhAPxASGrDPmxdJmsoxTGhLKGb2RDNLNmNaf09PeqxCPcRASaodACHRqCFOGOnoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428580; c=relaxed/simple;
	bh=P+6n414RxyKfp4s5m1ZMMcWKMEscj1t0ZZK/rIeORQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnpeuU8T5E8f+qrq7jKYpHyF0inkTtHM7DMFdPmHHOpy66xJvalnaTbawBeZknH/X7qUUAau5JJdjpJUYSwXz7H36GMrf3RQX0EWeaJL4y6OBZNj3XH8kvQs2aotlAWHksB+pkzWRYcs+jkjZNJWyWQz/Fn8N8xgGEdbWwN1w5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD961756;
	Wed, 12 Feb 2025 22:36:38 -0800 (PST)
Received: from [10.162.16.135] (a077893.blr.arm.com [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502343F6A8;
	Wed, 12 Feb 2025 22:36:12 -0800 (PST)
Message-ID: <d4fcf981-ea24-4892-9173-2c6f4046c7c1@arm.com>
Date: Thu, 13 Feb 2025 12:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/16] mm/vmalloc: Warn on improper use of
 vunmap_range()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-11-ryan.roberts@arm.com>
 <3bbae070-1ae3-4f5d-86ab-b3221425a1cb@arm.com>
 <faa89fec-4b02-4844-859e-3b0e7f402d89@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <faa89fec-4b02-4844-859e-3b0e7f402d89@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 16:29, Ryan Roberts wrote:
> On 07/02/2025 08:41, Anshuman Khandual wrote:
>> On 2/5/25 20:39, Ryan Roberts wrote:
>>> A call to vmalloc_huge() may cause memory blocks to be mapped at pmd or
>>> pud level. But it is possible to subsquently call vunmap_range() on a
>>
>> s/subsquently/subsequently
>>
>>> sub-range of the mapped memory, which partially overlaps a pmd or pud.
>>> In this case, vmalloc unmaps the entire pmd or pud so that the
>>> no-overlapping portion is also unmapped. Clearly that would have a bad
>>> outcome, but it's not something that any callers do today as far as I
>>> can tell. So I guess it's jsut expected that callers will not do this.
>>
>> s/jsut/just
>>
>>>
>>> However, it would be useful to know if this happened in future; let's
>>> add a warning to cover the eventuality.
>>
>> This is a reasonable check to prevent bad outcomes later.
>>
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  mm/vmalloc.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index a6e7acebe9ad..fcdf67d5177a 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -374,8 +374,10 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>>  		if (cleared || pmd_bad(*pmd))
>>>  			*mask |= PGTBL_PMD_MODIFIED;
>>>  
>>> -		if (cleared)
>>> +		if (cleared) {
>>> +			WARN_ON(next - addr < PMD_SIZE);
>>>  			continue;
>>> +		}
>>>  		if (pmd_none_or_clear_bad(pmd))
>>>  			continue;
>>>  		vunmap_pte_range(pmd, addr, next, mask);
>>> @@ -399,8 +401,10 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>>  		if (cleared || pud_bad(*pud))
>>>  			*mask |= PGTBL_PUD_MODIFIED;
>>>  
>>> -		if (cleared)
>>> +		if (cleared) {
>>> +			WARN_ON(next - addr < PUD_SIZE);
>>>  			continue;
>>> +		}
>>>  		if (pud_none_or_clear_bad(pud))
>>>  			continue;
>>>  		vunmap_pmd_range(pud, addr, next, mask);
>> Why not also include such checks in vunmap_p4d_range() and __vunmap_range_noflush()
>> for corresponding P4D and PGD levels as well ?
> 
> The kernel does not support p4d or pgd leaf entries so there is nothing to check.> 
> Although vunmap_p4d_range() does call p4d_clear_huge(). The function is a stub
> and returns void (unlike p[mu]d_clear_huge()). I suspect we could just remove
> p4d_clear_huge() entirely. But that would be a separate patch to mm tree I think.
> 
> For pgd, there isn't even an equivalent looking function.
> 
> Basically at those 2 levels, it's always a table.

Understood, thanks !

