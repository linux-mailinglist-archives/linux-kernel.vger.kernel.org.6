Return-Path: <linux-kernel+bounces-511370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0FA32A10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8211168180
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C024CEF1;
	Wed, 12 Feb 2025 15:29:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F6824E4C3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374192; cv=none; b=bdTJ+fAt7HRcM1RLAPNjKRhbBDzw71c4qjukiqQxVsdmFEuJXySRy7g1Wy6xuFq7hZRV/a3+T4ZjeI5J3Ra593vkEf3HBzSDk8SbnO9hbJ2Ji+GSQFcQGzQ4GoABectTfGxI3mk/alrBschjtnLDz1PJ0DfAn+J18xzUOR5g4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374192; c=relaxed/simple;
	bh=CtoZJWGWVJ7eVeqv8Re3KPnDgrE26s/mH4tdu0q02Ho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rnjSvCXWPuZMnx3UFycaLkx1dNrydrVC6mBBJlceS94lRT6oiPAhtSg4w6hRdj0XxilVZ5zaI612TheBCMencTRoCWNzpVWpQlIalGpSr0ymqdUziPVoBUVfl3BUbwp+pf0HtFdMVt8EPzqOEvUcGw+KhtzviQ1+maqx5KFzZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E2112FC;
	Wed, 12 Feb 2025 07:30:10 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED99A3F58B;
	Wed, 12 Feb 2025 07:29:46 -0800 (PST)
Message-ID: <46ca554b-f768-4981-9794-1dbc581a7bdc@arm.com>
Date: Wed, 12 Feb 2025 15:29:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/16] arm64/mm: Refactor __set_ptes() and
 __ptep_get_and_clear()
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
 <20250205151003.88959-7-ryan.roberts@arm.com>
 <bdd08da7-d978-437a-849f-8a6115933e19@arm.com>
 <0538d186-470e-4c4d-974c-0d7f2c96e549@arm.com>
 <0492ed88-673a-435b-bc89-5f35637b4be6@arm.com>
In-Reply-To: <0492ed88-673a-435b-bc89-5f35637b4be6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 09:38, Ryan Roberts wrote:
> On 06/02/2025 13:26, Ryan Roberts wrote:
>> On 06/02/2025 11:48, Anshuman Khandual wrote:
>>> On 2/5/25 20:39, Ryan Roberts wrote:

[...]

>>>>
>>>> While we are at it, refactor __ptep_get_and_clear() and
>>>> pmdp_huge_get_and_clear() to use a common ___ptep_get_and_clear() which
>>>> also takes a pgsize parameter. This will provide the huge_pte API the
>>>> means to clear ptes corresponding with the way they were set.
>>>
>>> __ptep_get_and_clear() refactoring does not seem to be related to the
>>> previous __set_ptes(). Should they be separated out into two different
>>> patches instead - for better clarity and review ? Both these clean ups
>>> have enough change and can stand own their own.
>>
>> Yeah I think you're probably right... I was being lazy... I'll separate them.

When looking at this again, I've decided not to split the patch. The same
approach is being applied to both helper APIs to produce "anysz" versions that
will be used by the huge_pte helpers. So I think it is reasonable to do all the
conversion in a single patch. It just looks too small and bitty if I split it out.

I'll rework the commit log to give both API equal promiance since it currently
sounds like __ptep_get_and_clear is an after thought.

[...]

>>> s/___set_ptes/___set_pxds ? to be more generic for all levels.
>>
>> So now we are into naming... I agree that in some senses pte feels specific to
>> the last level. But it's long form "page table entry" seems more generic than
>> "pxd" which implies only pmd, pud, p4d and pgd. At least to me...
>>
>> I think we got stuck trying to figure out a clear and short term for "page table
>> entry at any level" in the past. I think ttd was the best we got; Translation
>> Table Descriptor, which is the term the Arm ARM uses. But that opens a can of
>> worms as now we need tdd_t and all the converters pte_tdd(), tdd_pte(),
>> pmd_tdd(), ... and probably a bunch more stuff on top.
>>
>> So personally I prefer to take the coward's way out and just reuse pte.
> 
> How about set_ptes_anylvl() and ptep_get_and_clear_anylvl()? I think this makes
> it explicit and has the benefit of removing the leading underscores. It also
> means we can reuse pte_t and friends, and we can exetend this nomenclature to
> other places in future at the expense of a 7 char suffix ("_anylvl").
> 
> What do you think?

I'm going to call them set_ptes_anysz() and ptep_get_and_clear_anysz(). That's
one char shorter and better reflects that we are passing a size parameter in,
not a level parameter.

Thanks,
Ryan

> 
>>
>>>
>>>>  {
>>>> -	__sync_cache_and_tags(pte, nr);
>>>> -	__check_safe_pte_update(mm, ptep, pte);
>>>> -	__set_pte(ptep, pte);
>>>> +	unsigned long stride = pgsize >> PAGE_SHIFT;
>>>> +
>>>> +	switch (pgsize) {
>>>> +	case PAGE_SIZE:
>>>> +		page_table_check_ptes_set(mm, ptep, pte, nr);
>>>> +		break;
>>>> +	case PMD_SIZE:
>>>> +		page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
>>>> +		break;
>>>> +	case PUD_SIZE:
>>>> +		page_table_check_puds_set(mm, (pud_t *)ptep, pte_pud(pte), nr);
>>>> +		break;
>>>
>>> This is where the new page table check APIs get used for batch testing.
>>
>> Yes and I anticipate that the whole switch block should be optimized out when
>> page_table_check is disabled.
>>
>>>
>>>> +	default:
>>>> +		VM_WARN_ON(1);
>>>> +	}
>>>> +
>>>> +	__sync_cache_and_tags(pte, nr * stride);
>>>> +
>>>> +	for (;;) {
>>>> +		__check_safe_pte_update(mm, ptep, pte);
>>>> +		__set_pte(ptep, pte);
>>>> +		if (--nr == 0)
>>>> +			break;
>>>> +		ptep++;
>>>> +		pte = pte_advance_pfn(pte, stride);
>>>> +	}
>>>>  }
>>>
>>> LGTM
>>>
>>>>  
>>>> -static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>>> -			      pmd_t *pmdp, pmd_t pmd)
>>>> +static inline void __set_ptes(struct mm_struct *mm,
>>>> +			      unsigned long __always_unused addr,
>>>> +			      pte_t *ptep, pte_t pte, unsigned int nr)
>>>>  {
>>>> -	page_table_check_pmd_set(mm, pmdp, pmd);
>>>> -	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd),
>>>> -						PMD_SIZE >> PAGE_SHIFT);
>>>> +	___set_ptes(mm, ptep, pte, nr, PAGE_SIZE);
>>>>  }
>>>>  
>>>> -static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>>>> -			      pud_t *pudp, pud_t pud)
>>>> +static inline void __set_pmds(struct mm_struct *mm,
>>>> +			      unsigned long __always_unused addr,
>>>> +			      pmd_t *pmdp, pmd_t pmd, unsigned int nr)
>>>> +{
>>>> +	___set_ptes(mm, (pte_t *)pmdp, pmd_pte(pmd), nr, PMD_SIZE);
>>>> +}
>>>> +#define set_pmd_at(mm, addr, pmdp, pmd) __set_pmds(mm, addr, pmdp, pmd, 1)
>>>> +
>>>> +static inline void __set_puds(struct mm_struct *mm,
>>>> +			      unsigned long __always_unused addr,
>>>> +			      pud_t *pudp, pud_t pud, unsigned int nr)
>>>>  {
>>>> -	page_table_check_pud_set(mm, pudp, pud);
>>>> -	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud),
>>>> -						PUD_SIZE >> PAGE_SHIFT);
>>>> +	___set_ptes(mm, (pte_t *)pudp, pud_pte(pud), nr, PUD_SIZE);
>>>>  }
>>>> +#define set_pud_at(mm, addr, pudp, pud) __set_puds(mm, addr, pudp, pud, 1)
>>>
>>> LGTM
>>>
>>>>  
>>>>  #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
>>>>  #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
>>>> @@ -1276,16 +1288,34 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>>>>  }
>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
>>>>  
>>>> -static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
>>>> -				       unsigned long address, pte_t *ptep)
>>>> +static inline pte_t ___ptep_get_and_clear(struct mm_struct *mm, pte_t *ptep,
>>>> +				       unsigned long pgsize)
>>>
>>> So address got dropped and page size got added as an argument.
>>>
>>>>  {
>>>>  	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
>>>>  
>>>> -	page_table_check_pte_clear(mm, pte);
>>>> +	switch (pgsize) {
>>>> +	case PAGE_SIZE:
>>>> +		page_table_check_pte_clear(mm, pte);
>>>> +		break;
>>>> +	case PMD_SIZE:
>>>> +		page_table_check_pmd_clear(mm, pte_pmd(pte));
>>>> +		break;
>>>> +	case PUD_SIZE:
>>>> +		page_table_check_pud_clear(mm, pte_pud(pte));
>>>> +		break;
>>>> +	default:
>>>> +		VM_WARN_ON(1);
>>>> +	}
>>>>  
>>>>  	return pte;
>>>>  }
>>>>  
>>>> +static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
>>>> +				       unsigned long address, pte_t *ptep)
>>>> +{
>>>> +	return ___ptep_get_and_clear(mm, ptep, PAGE_SIZE);
>>>> +}
>>>> +
>>>>  static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>>>>  				pte_t *ptep, unsigned int nr, int full)
>>>>  {
>>>> @@ -1322,11 +1352,7 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
>>>>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>  					    unsigned long address, pmd_t *pmdp)
>>>>  {
>>>> -	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
>>>> -
>>>> -	page_table_check_pmd_clear(mm, pmd);
>>>> -
>>>> -	return pmd;
>>>> +	return pte_pmd(___ptep_get_and_clear(mm, (pte_t *)pmdp, PMD_SIZE));
>>>>  }
>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>  
>>>
>>> Although currently there is no pudp_huge_get_and_clear() helper on arm64
>>> reworked ___ptep_get_and_clear() will be able to support that as well if
>>> and when required as it now supports PUD_SIZE page size.
>>
>> yep.
>>
>> Thanks for all your review so far!
>>
> 


