Return-Path: <linux-kernel+bounces-511435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992AA32B09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72485167C45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D6253B49;
	Wed, 12 Feb 2025 16:00:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A522333F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376032; cv=none; b=Jc8JdeORkxB4yz+bje88AWg0D3OqkW3Ewjl7GwJdYSRaZy82jQQDFkQR6TQK9yvpfQA4xUrA+9nNr6dOGZTrBSvuNg1zvtFh+ludw5xIfCgcXXcysXiz0PDnd/9lQYXvYfZRdWlJAfdnvew3nXlveekpoSJHXgPfZBwFt3c4T+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376032; c=relaxed/simple;
	bh=joLO9v/8cNWLxylCqQoACHdMoKnJz4vJUD1BNrVyQUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LvnxRQGnwSj/scenOL5kUHjNaI964x9WDEgTtxMY7hHiZ7nafI8G7VpSyIt9gAU5W6hibOscPk/BbaL/dLpqalD1HcmTok+G4bPuTFQ9DL8HZtJsxDMYoEuaCvVeLHAXI/adY2Mvux1AnjxNlgJsCQPNSE1au4S7/+mOs+8VBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89BF12FC;
	Wed, 12 Feb 2025 08:00:50 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12BD23F6A8;
	Wed, 12 Feb 2025 08:00:26 -0800 (PST)
Message-ID: <6b3ad437-04df-41c6-81f4-c0fec5a099ec@arm.com>
Date: Wed, 12 Feb 2025 16:00:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/16] arm64/mm: Hoist barriers out of ___set_ptes()
 loop
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
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
 <20250205151003.88959-9-ryan.roberts@arm.com>
 <858ecac5-9ba7-48da-8f34-ffda28d17609@arm.com>
 <e0400886-d4bc-40f5-8375-fc3d515fd386@arm.com>
In-Reply-To: <e0400886-d4bc-40f5-8375-fc3d515fd386@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 10:38, Ryan Roberts wrote:
> On 07/02/2025 05:35, Anshuman Khandual wrote:
>>
>>
>> On 2/5/25 20:39, Ryan Roberts wrote:
>>> ___set_ptes() previously called __set_pte() for each PTE in the range,
>>> which would conditionally issue a DSB and ISB to make the new PTE value
>>> immediately visible to the table walker if the new PTE was valid and for
>>> kernel space.
>>>
>>> We can do better than this; let's hoist those barriers out of the loop
>>> so that they are only issued once at the end of the loop. We then reduce
>>> the cost by the number of PTEs in the range.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  arch/arm64/include/asm/pgtable.h | 14 ++++++++++----
>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 3b55d9a15f05..1d428e9c0e5a 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -317,10 +317,8 @@ static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>>>  	WRITE_ONCE(*ptep, pte);
>>>  }
>>>  
>>> -static inline void __set_pte(pte_t *ptep, pte_t pte)
>>> +static inline void __set_pte_complete(pte_t pte)
>>>  {
>>> -	__set_pte_nosync(ptep, pte);
>>> -
>>>  	/*
>>>  	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
>>>  	 * or update_mmu_cache() have the necessary barriers.
>>> @@ -331,6 +329,12 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
>>>  	}
>>>  }
>>>  
>>> +static inline void __set_pte(pte_t *ptep, pte_t pte)
>>> +{
>>> +	__set_pte_nosync(ptep, pte);
>>> +	__set_pte_complete(pte);
>>> +}
>>> +
>>>  static inline pte_t __ptep_get(pte_t *ptep)
>>>  {
>>>  	return READ_ONCE(*ptep);
>>> @@ -647,12 +651,14 @@ static inline void ___set_ptes(struct mm_struct *mm, pte_t *ptep, pte_t pte,
>>>  
>>>  	for (;;) {
>>>  		__check_safe_pte_update(mm, ptep, pte);
>>> -		__set_pte(ptep, pte);
>>> +		__set_pte_nosync(ptep, pte);
>>>  		if (--nr == 0)
>>>  			break;
>>>  		ptep++;
>>>  		pte = pte_advance_pfn(pte, stride);
>>>  	}
>>> +
>>> +	__set_pte_complete(pte);
>>
>> Given that the loop now iterates over number of page table entries without corresponding
>> consecutive dsb/isb sync, could there be a situation where something else gets scheduled
>> on the cpu before __set_pte_complete() is called ? Hence leaving the entire page table
>> entries block without desired mapping effect. IOW how __set_pte_complete() is ensured to
>> execute once the loop above completes. Otherwise this change LGTM.
> 
> I don't think this changes the model. Previously, __set_pte() was called, which
> writes the pte to the pgtable, then issues the barriers. So there is still a
> window where the thread could be unscheduled after the write but before the
> barriers. Yes, my change makese that window bigger, but if it is a bug now, it
> was a bug before.
> 
> Additionally, the spec for set_ptes() is:
> 
> /**
>  * set_ptes - Map consecutive pages to a contiguous range of addresses.
>  * @mm: Address space to map the pages into.
>  * @addr: Address to map the first page at.
>  * @ptep: Page table pointer for the first entry.
>  * @pte: Page table entry for the first page.
>  * @nr: Number of pages to map.
>  *
>  * When nr==1, initial state of pte may be present or not present, and new state
>  * may be present or not present. When nr>1, initial state of all ptes must be
>  * not present, and new state must be present.
>  *
>  * May be overridden by the architecture, or the architecture can define
>  * set_pte() and PFN_PTE_SHIFT.
>  *
>  * Context: The caller holds the page table lock.  The pages all belong
>  * to the same folio.  The PTEs are all in the same PMD.
>  */
> 
> Note that the caller is required to hold the page table lock. That's a spin lock
> so should be non-preemptible at this point (perhaps not for RT?)
> 
> Although actually, vmalloc doesn't hold a lock when calling these helpers; it
> has a lock when allocating the VA space, then drops it.
> 
> So yes, I think there is a chance of preemption after writing the pgtable entry
> but before issuing the barriers.
> 
> But in that case, we get saved by the DSB in the context switch path. There is
> no guarrantee of an ISB in that path (AFAIU). But the need for an ISB is a bit
> whooly anyway. My rough understanding is that the ISB is there to prevent
> previous speculation from determining that a given translation was invalid and
> "caching" that determination in the pipeline. That could still (theoretically)
> happen on remote CPUs I think, and we have the spurious fault handler to detect
> that. Anyway, once you context switch, the local CPU becomes remote and we don't
> have the ISB there, so what's the difference... There's a high chance I've
> misunderstood a bunch of this.

I thought about this some more; The ISB is there to ensure that the "speculative
invalid translation marker" cached in the pipeline gets removed prior to any
code that runs after set_ptes() returns which accesses an address now mapped by
the pte that was set. Even if preemption occurs, the ISB will still execute when
the thread runs again, before the return from set_ptes(). So all is well.

> 
> 
> In conclusion, I don't think I've made things any worse.
> 
> Thanks,
> Ryan
> 
>>
>>>  }
>>>  
>>>  static inline void __set_ptes(struct mm_struct *mm,
> 


