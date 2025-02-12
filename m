Return-Path: <linux-kernel+bounces-511530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C79A32C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ED61889263
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695721DEFDD;
	Wed, 12 Feb 2025 16:48:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B15271838
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378887; cv=none; b=uS9+p/LnStEr6zofQ3uNUspwtZxOpI6CgY8PlUacibKkzutye6pLpZBe5i+7pbEyBHgvZqKyhxaaeBdNCAUodGzH94JlgR1VEVKqZEzspzVJqFucmShdS4E80Ckg3mfmi0IvaUOeSqh3RvHypcviyToB7+f97FT6sqfXvG5cK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378887; c=relaxed/simple;
	bh=fYsrdJTCuCPeEcSw2SVj5McEhtV2YYbhYNi5O9k+PUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LHyaK8DwhA/NB47JABXrPDQ2VpsGr0bOcXtzHRolzak81yR+WPCPwk5D6ygGP1b4oroYjo1GahJTMBFBWNwnwOkuilp+eRz9Nq4188BlwAqij7xt0E9AWXRlV5Ttk1OICbGD8SlWs0O3jACUBzxJCengzzH2cJzHdAQc2oBCi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21BCB12FC;
	Wed, 12 Feb 2025 08:48:26 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 928B73F5A1;
	Wed, 12 Feb 2025 08:48:02 -0800 (PST)
Message-ID: <a1604360-3e7f-47af-bba3-f4fea690a861@arm.com>
Date: Wed, 12 Feb 2025 16:48:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/16] arm64/mm: Avoid barriers for invalid or
 userspace mappings
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
 <20250205151003.88959-10-ryan.roberts@arm.com>
 <45717fc1-cd83-4e9e-8ce5-44d306037cc9@arm.com>
 <334bdd4c-f12e-45f3-b4f9-df723889a4f4@arm.com>
In-Reply-To: <334bdd4c-f12e-45f3-b4f9-df723889a4f4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 10:53, Ryan Roberts wrote:
> On 07/02/2025 08:11, Anshuman Khandual wrote:
>> On 2/5/25 20:39, Ryan Roberts wrote:
>>> __set_pte_complete(), set_pmd(), set_pud(), set_p4d() and set_pgd() are
>>> used to write entries into pgtables. And they issue barriers (currently
>>> dsb and isb) to ensure that the written values are observed by the table
>>> walker prior to any program-order-future memory access to the mapped
>>> location.
>>
>> Right.
>>
>>>
>>> Over the years some of these functions have received optimizations: In
>>> particular, commit 7f0b1bf04511 ("arm64: Fix barriers used for page
>>> table modifications") made it so that the barriers were only emitted for
>>> valid-kernel mappings for set_pte() (now __set_pte_complete()). And
>>> commit 0795edaf3f1f ("arm64: pgtable: Implement p[mu]d_valid() and check
>>> in set_p[mu]d()") made it so that set_pmd()/set_pud() only emitted the
>>> barriers for valid mappings. set_p4d()/set_pgd() continue to emit the
>>> barriers unconditionally.
>>
>> Right.
>>
>>>
>>> This is all very confusing to the casual observer; surely the rules
>>> should be invariant to the level? Let's change this so that every level
>>> consistently emits the barriers only when setting valid, non-user
>>> entries (both table and leaf).
>>
>> Agreed.
>>
>>>
>>> It seems obvious that if it is ok to elide barriers all but valid kernel
>>> mappings at pte level, it must also be ok to do this for leaf entries at
>>> other levels: If setting an entry to invalid, a tlb maintenance
>>> operaiton must surely follow to synchronise the TLB and this contains
>>
>> s/operaiton/operation
> 
> Ugh, I really need a spell checker for my editor!
> 
>>
>>> the required barriers. If setting a valid user mapping, the previous
>>> mapping must have been invalid and there must have been a TLB
>>> maintenance operation (complete with barriers) to honour
>>> break-before-make. So the worst that can happen is we take an extra
>>> fault (which will imply the DSB + ISB) and conclude that there is
>>> nothing to do. These are the aguments for doing this optimization at pte
>>
>> s/aguments/arguments
>>
>>> level and they also apply to leaf mappings at other levels.
>>
>> So user the page table updates both for the table and leaf entries remains
>> unchanged for now regarding dsb/isb sync i.e don't do anything ?
> 
> Sorry, this doesn't parse.
> 
>>
>>>
>>> For table entries, the same arguments hold: If unsetting a table entry,
>>> a TLB is required and this will emit the required barriers. If setting a
>>> table entry, the previous value must have been invalid and the table
>>> walker must already be able to observe that. Additionally the contents
>>> of the pgtable being pointed to in the newly set entry must be visible
>>> before the entry is written and this is enforced via smp_wmb() (dmb) in
>>> the pgtable allocation functions and in __split_huge_pmd_locked(). But
>>> this last part could never have been enforced by the barriers in
>>> set_pXd() because they occur after updating the entry. So ultimately,
>>> the wost that can happen by eliding these barriers for user table
>>> entries is an extra fault.
>>
>> Basically nothing needs to be done while setting user page table entries.
>>
>>>
>>> I observe roughly the same number of page faults (107M) with and without
>>> this change when compiling the kernel on Apple M2.
>>
>> These are total page faults or only additional faults caused because there
>> were no dsb/isb sync after the user page table update ?
> 
> total page faults. The experiment was to check that if eliding more barriers for
> valid user space mappings, does this lead to an increase in page faults? This
> very simple experiment suggests no.
> 
>>
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  arch/arm64/include/asm/pgtable.h | 60 ++++++++++++++++++++++++++++----
>>>  1 file changed, 54 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 1d428e9c0e5a..ff358d983583 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -767,6 +767,19 @@ static inline bool in_swapper_pgdir(void *addr)
>>>  	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
>>>  }
>>>  
>>> +static inline bool pmd_valid_not_user(pmd_t pmd)
>>> +{
>>> +	/*
>>> +	 * User-space table pmd entries always have (PXN && !UXN). All other
>>> +	 * combinations indicate it's a table entry for kernel space.
>>> +	 * Valid-not-user leaf entries follow the same rules as
>>> +	 * pte_valid_not_user().
>>> +	 */
>>> +	if (pmd_table(pmd))
>>> +		return !((pmd_val(pmd) & (PMD_TABLE_PXN | PMD_TABLE_UXN)) == PMD_TABLE_PXN);
>>
>> Should not this be abstracted out as pmd_table_not_user_table() which can
>> then be re-used in other levels as well.
> 
> Yeah maybe. Let me mull it over.

I discovered a bug (see below). So decided to keep it simple. I'm defining
pmd_valid_not_user() as an inline function, as is done in this version. But all
other levels are just macros defined to wrap pmd_valid_not_user(). That way all
levels are treated the same way. This means that we might be slightly
over-checking for the higher levels that don't support block mappings, but it's
safe and correct and reuses the maximum amount of code.


> 
>>
>>> +	return pte_valid_not_user(pmd_pte(pmd));
>>> +}
>>> +
>>
>> Something like.
>>
>> static inline bool pmd_valid_not_user_table(pmd_t pmd)
>> {
>> 	return pmd_valid(pmd) &&
>> 	       !((pmd_val(pmd) & (PMD_PMD_TABLE_PXN | PMD_TABLE_UXN)) == PMD_TABLE_PXN);
>> }
>>
>> static inline bool pmd_valid_not_user(pmd_t pmd)
>> {
>> 	if (pmd_table(pmd))
>> 		return pmd_valid_not_user_table(pmd);
>> 	else
>> 		return pte_valid_not_user(pmd_pte(pmd));
>> }
>>
>>>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>  {
>>>  #ifdef __PAGETABLE_PMD_FOLDED
>>> @@ -778,7 +791,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>  
>>>  	WRITE_ONCE(*pmdp, pmd);
>>>  
>>> -	if (pmd_valid(pmd)) {
>>> +	if (pmd_valid_not_user(pmd)) {
>>>  		dsb(ishst);
>>>  		isb();
>>>  	}
>>> @@ -836,6 +849,17 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>>  
>>>  static inline bool pgtable_l4_enabled(void);
>>>  
>>> +
>>> +static inline bool pud_valid_not_user(pud_t pud)
>>> +{
>>> +	/*
>>> +	 * Follows the same rules as pmd_valid_not_user().
>>> +	 */
>>> +	if (pud_table(pud))
>>> +		return !((pud_val(pud) & (PUD_TABLE_PXN | PUD_TABLE_UXN)) == PUD_TABLE_PXN);

This is buggy for configs where pud_table() is hardcoded to return true. In this
case we will assume the pud is valid when it may not be. (actually you could
call that a bug in pud_table(), which should really at least still be checking
that it's valid).

>>> +	return pte_valid_not_user(pud_pte(pud));
>>> +}
>>
>> This can be expressed in terms of pmd_valid_not_user() itself.
>>
>> #define pud_valid_not_user()	pmd_valid_not_user(pud_pmd(pud))
> 
> The trouble with this is that you end up using pmd_table() not pud_table(). For
> some configs pud_table() is hardcoded to true. So we lose the benefit. So I'd
> rather keep it as it's own function.
> 
>>
>>> +
>>>  static inline void set_pud(pud_t *pudp, pud_t pud)
>>>  {
>>>  	if (!pgtable_l4_enabled() && in_swapper_pgdir(pudp)) {
>>> @@ -845,7 +869,7 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
>>>  
>>>  	WRITE_ONCE(*pudp, pud);
>>>  
>>> -	if (pud_valid(pud)) {
>>> +	if (pud_valid_not_user(pud)) {
>>>  		dsb(ishst);
>>>  		isb();
>>>  	}
>>> @@ -917,6 +941,16 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
>>>  #define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & P4D_TABLE_BIT))
>>>  #define p4d_present(p4d)	(!p4d_none(p4d))
>>>  
>>> +static inline bool p4d_valid_not_user(p4d_t p4d)
>>> +{
>>> +	/*
>>> +	 * User-space table p4d entries always have (PXN && !UXN). All other
>>> +	 * combinations indicate it's a table entry for kernel space. p4d block
>>> +	 * entries are not supported.
>>> +	 */
>>> +	return !((p4d_val(p4d) & (P4D_TABLE_PXN | P4D_TABLE_UXN)) == P4D_TABLE_PXN);

This was buggy because we never check valid!

>>> +}
>>
>> Instead
>>
>> #define p4d_valid_not_user_able() pmd_valid_not_user_able(p4d_pmd(p4d))
>>
>>> +
>>>  static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>>>  {
>>>  	if (in_swapper_pgdir(p4dp)) {
>>> @@ -925,8 +959,11 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>>>  	}
>>>  
>>>  	WRITE_ONCE(*p4dp, p4d);
>>> -	dsb(ishst);
>>> -	isb();
>>> +
>>> +	if (p4d_valid_not_user(p4d)) {
>>
>>
>> Check p4d_valid_not_user_able() instead.
> 
> I don't really know why we would want to add table into the name at this level.
> Why not be consistent and continue to use p4d_valid_not_user()? The fact that
> p4d doesn't support leaf entries is just a matter for the implementation.
> 
>>
>>> +		dsb(ishst);
>>> +		isb();
>>> +	}
>>>  }
>>>  
>>>  static inline void p4d_clear(p4d_t *p4dp)
>>> @@ -1044,6 +1081,14 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
>>>  #define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & PGD_TABLE_BIT))
>>>  #define pgd_present(pgd)	(!pgd_none(pgd))
>>>  
>>> +static inline bool pgd_valid_not_user(pgd_t pgd)
>>> +{
>>> +	/*
>>> +	 * Follows the same rules as p4d_valid_not_user().
>>> +	 */
>>> +	return !((pgd_val(pgd) & (PGD_TABLE_PXN | PGD_TABLE_UXN)) == PGD_TABLE_PXN);

Same here!

>>> +}
>>
>> Similarly
>>
>> #define pgd_valid_not_user_able() pmd_valid_not_user_able(pgd_pmd(pgd))
>>
>>
>>> +
>>>  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>>>  {
>>>  	if (in_swapper_pgdir(pgdp)) {
>>> @@ -1052,8 +1097,11 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>>>  	}
>>>  
>>>  	WRITE_ONCE(*pgdp, pgd);
>>> -	dsb(ishst);
>>> -	isb();
>>> +
>>> +	if (pgd_valid_not_user(pgd)) {
>>
>> Check pgd_valid_not_user_able() instead.
>>
>>> +		dsb(ishst);
>>> +		isb();
>>> +	}
>>>  }
>>>  
>>>  static inline void pgd_clear(pgd_t *pgdp)
> 


