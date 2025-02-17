Return-Path: <linux-kernel+bounces-516988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37DA37AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E115216B9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC51531F9;
	Mon, 17 Feb 2025 04:48:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8E33E7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739767716; cv=none; b=IN96ajNGdByNBB2s3dcUVMC57zFkq5Elw4ORjKmfDx8uSJo+B/khvUMg73SzjWzrYsS8gMVi4KkUeiJn4poDj8hGVFtzujt6gGqiX/U8A+xtnLRTnxHTYEfcU+oROCiENQSMaONPbBqpz1XcFbAjjkTnSI4RhRiFC5xLK8lAOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739767716; c=relaxed/simple;
	bh=tAnRQNx2hBIHinDuk0YGXpJJ46RiZ6/vfFidQ1n6swg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br19SKUyzxRE9dz9gVDFsCzXTIJkuFH1eSxX3zJoC8VxF6gGrwXsTK/ba0JKQovSSrU27tUiydRxkBSgYJQW1YvVUR7tw/4bh+hgulHBC05meBRHF09FTuwmlfFGR+KFK4lyvyQG3lfu+2Pb+uL49nQYxPI1WkLSX93R0JZ8XRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723011063;
	Sun, 16 Feb 2025 20:48:53 -0800 (PST)
Received: from [10.162.16.135] (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745A53F59E;
	Sun, 16 Feb 2025 20:48:29 -0800 (PST)
Message-ID: <77dfb8ae-2a57-4d76-a3d2-8a486dd9721b@arm.com>
Date: Mon, 17 Feb 2025 10:18:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/16] arm64/mm: Defer barriers when updating kernel
 mappings
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
 <20250205151003.88959-17-ryan.roberts@arm.com>
 <9bc5527e-16f4-45cc-aced-55b1ace6c143@arm.com>
 <a5d66063-c3a0-46fc-ab88-21ae2448c9f0@arm.com>
 <0052097e-2284-4f9e-b37c-2ca2de527667@arm.com>
 <43d852bb-ab5f-40be-b188-166c57ab795c@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <43d852bb-ab5f-40be-b188-166c57ab795c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 15:08, Ryan Roberts wrote:
> On 13/02/2025 05:30, Anshuman Khandual wrote:
>>
>>
>> On 2/10/25 16:42, Ryan Roberts wrote:
>>> On 10/02/2025 08:03, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 2/5/25 20:39, Ryan Roberts wrote:
>>>>> Because the kernel can't tolerate page faults for kernel mappings, when
>>>>> setting a valid, kernel space pte (or pmd/pud/p4d/pgd), it emits a
>>>>> dsb(ishst) to ensure that the store to the pgtable is observed by the
>>>>> table walker immediately. Additionally it emits an isb() to ensure that
>>>>> any already speculatively determined invalid mapping fault gets
>>>>> canceled.> 
>>>>> We can improve the performance of vmalloc operations by batching these
>>>>> barriers until the end of a set up entry updates. The newly added
>>>>> arch_update_kernel_mappings_begin() / arch_update_kernel_mappings_end()
>>>>> provide the required hooks.
>>>>>
>>>>> vmalloc improves by up to 30% as a result.
>>>>>
>>>>> Two new TIF_ flags are created; TIF_KMAP_UPDATE_ACTIVE tells us if we
>>>>> are in the batch mode and can therefore defer any barriers until the end
>>>>> of the batch. TIF_KMAP_UPDATE_PENDING tells us if barriers are queued to
>>>>> be emited at the end of the batch.
>>>>
>>>> Why cannot this be achieved with a single TIF_KMAP_UPDATE_ACTIVE which is
>>>> set in __begin(), cleared in __end() and saved across a __switch_to().
>>>
>>> So unconditionally emit the barriers in _end(), and emit them in __switch_to()
>>> if TIF_KMAP_UPDATE_ACTIVE is set?
>>
>> Right.
>>
>>>
>>> I guess if calling _begin() then you are definitely going to be setting at least
>>> 1 PTE. So you can definitely emit the barriers unconditionally. I was trying to
>>> protect against the case where you get pre-empted (potentially multiple times)
>>> while in the loop. The TIF_KMAP_UPDATE_PENDING flag ensures you only emit the
>>> barriers when you definitely need to. Without it, you would have to emit on
>>> every pre-emption even if no more PTEs got set.
>>>
>>> But I suspect this is a premature optimization. Probably it will never occur. So
>>
>> Agreed.
> 
> Having done this simplification, I've just noticed that one of the
> arch_update_kernel_mappings_begin/end callsites is __apply_to_page_range() which
> gets called for user space mappings as well as kernel mappings. So actually with
> the simplification I'll be emitting barriers even when only user space mappings
> were touched.

Right, that will not be desirable.

> 
> I think there are a couple of options to fix this:
> 
> - Revert to the 2 flag approach. For the user space case, I'll get to _end() and
> notice that no barriers are queued so will emit nothing.
> 
> - Only set TIF_KMAP_UPDATE_ACTIVE if the address range passed to _begin() is a
> kernel address range. I guess that's just a case of checking if the MSB is set
> in "end"?
> 
> - pass mm to _begin() and only set TIF_KMAP_UPDATE_ACTIVE if mm == &init_mm. I
> guess this should be the same as option 2.
> 
> I'm leaning towards option 2. But I have a niggling feeling that my proposed
> check isn't quite correct. What do you think?

Option 2 and 3 looks better than the two flags approach proposed earlier. But is
not option 3 bit more simplistic than option 2 ? Does getting struct mm argument
into these function create more code churn ?

> 
> Thanks,
> Ryan
> 
> 
>>
>>> I'll simplify as you suggest.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/pgtable.h     | 65 +++++++++++++++++++---------
>>>>>  arch/arm64/include/asm/thread_info.h |  2 +
>>>>>  arch/arm64/kernel/process.c          | 20 +++++++--
>>>>>  3 files changed, 63 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>>> index ff358d983583..1ee9b9588502 100644
>>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>>> @@ -39,6 +39,41 @@
>>>>>  #include <linux/mm_types.h>
>>>>>  #include <linux/sched.h>
>>>>>  #include <linux/page_table_check.h>
>>>>> +#include <linux/pgtable_modmask.h>
>>>>> +
>>>>> +static inline void emit_pte_barriers(void)
>>>>> +{
>>>>> +	dsb(ishst);
>>>>> +	isb();
>>>>> +}
>>>>
>>>> There are many sequence of these two barriers in this particular header,
>>>> hence probably a good idea to factor this out into a common helper.
>>>>>> +
>>>>> +static inline void queue_pte_barriers(void)
>>>>> +{
>>>>> +	if (test_thread_flag(TIF_KMAP_UPDATE_ACTIVE)) {
>>>>> +		if (!test_thread_flag(TIF_KMAP_UPDATE_PENDING))
>>>>> +			set_thread_flag(TIF_KMAP_UPDATE_PENDING);
>>>>> +	} else
>>>>> +		emit_pte_barriers();
>>>>> +}
>>>>> +
>>>>> +#define arch_update_kernel_mappings_begin arch_update_kernel_mappings_begin
>>>>> +static inline void arch_update_kernel_mappings_begin(unsigned long start,
>>>>> +						     unsigned long end)
>>>>> +{
>>>>> +	set_thread_flag(TIF_KMAP_UPDATE_ACTIVE);
>>>>> +}
>>>>> +
>>>>> +#define arch_update_kernel_mappings_end arch_update_kernel_mappings_end
>>>>> +static inline void arch_update_kernel_mappings_end(unsigned long start,
>>>>> +						   unsigned long end,
>>>>> +						   pgtbl_mod_mask mask)
>>>>> +{
>>>>> +	if (test_thread_flag(TIF_KMAP_UPDATE_PENDING))
>>>>> +		emit_pte_barriers();
>>>>> +
>>>>> +	clear_thread_flag(TIF_KMAP_UPDATE_PENDING);
>>>>> +	clear_thread_flag(TIF_KMAP_UPDATE_ACTIVE);
>>>>> +}
>>>>>  
>>>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>>>>> @@ -323,10 +358,8 @@ static inline void __set_pte_complete(pte_t pte)
>>>>>  	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
>>>>>  	 * or update_mmu_cache() have the necessary barriers.
>>>>>  	 */
>>>>> -	if (pte_valid_not_user(pte)) {
>>>>> -		dsb(ishst);
>>>>> -		isb();
>>>>> -	}
>>>>> +	if (pte_valid_not_user(pte))
>>>>> +		queue_pte_barriers();
>>>>>  }
>>>>>  
>>>>>  static inline void __set_pte(pte_t *ptep, pte_t pte)
>>>>> @@ -791,10 +824,8 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>>>  
>>>>>  	WRITE_ONCE(*pmdp, pmd);
>>>>>  
>>>>> -	if (pmd_valid_not_user(pmd)) {
>>>>> -		dsb(ishst);
>>>>> -		isb();
>>>>> -	}
>>>>> +	if (pmd_valid_not_user(pmd))
>>>>> +		queue_pte_barriers();
>>>>>  }
>>>>>  
>>>>>  static inline void pmd_clear(pmd_t *pmdp)
>>>>> @@ -869,10 +900,8 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
>>>>>  
>>>>>  	WRITE_ONCE(*pudp, pud);
>>>>>  
>>>>> -	if (pud_valid_not_user(pud)) {
>>>>> -		dsb(ishst);
>>>>> -		isb();
>>>>> -	}
>>>>> +	if (pud_valid_not_user(pud))
>>>>> +		queue_pte_barriers();
>>>>>  }
>>>>>  
>>>>>  static inline void pud_clear(pud_t *pudp)
>>>>> @@ -960,10 +989,8 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>>>>>  
>>>>>  	WRITE_ONCE(*p4dp, p4d);
>>>>>  
>>>>> -	if (p4d_valid_not_user(p4d)) {
>>>>> -		dsb(ishst);
>>>>> -		isb();
>>>>> -	}
>>>>> +	if (p4d_valid_not_user(p4d))
>>>>> +		queue_pte_barriers();
>>>>>  }
>>>>>  
>>>>>  static inline void p4d_clear(p4d_t *p4dp)
>>>>> @@ -1098,10 +1125,8 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>>>>>  
>>>>>  	WRITE_ONCE(*pgdp, pgd);
>>>>>  
>>>>> -	if (pgd_valid_not_user(pgd)) {
>>>>> -		dsb(ishst);
>>>>> -		isb();
>>>>> -	}
>>>>> +	if (pgd_valid_not_user(pgd))
>>>>> +		queue_pte_barriers();
>>>>>  }
>>>>>  
>>>>>  static inline void pgd_clear(pgd_t *pgdp)
>>>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>>>> index 1114c1c3300a..382d2121261e 100644
>>>>> --- a/arch/arm64/include/asm/thread_info.h
>>>>> +++ b/arch/arm64/include/asm/thread_info.h
>>>>> @@ -82,6 +82,8 @@ void arch_setup_new_exec(void);
>>>>>  #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
>>>>>  #define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
>>>>>  #define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
>>>>> +#define TIF_KMAP_UPDATE_ACTIVE	31	/* kernel map update in progress */
>>>>> +#define TIF_KMAP_UPDATE_PENDING	32	/* kernel map updated with deferred barriers */
>>>>>  
>>>>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>>>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>>>>> index 42faebb7b712..1367ec6407d1 100644
>>>>> --- a/arch/arm64/kernel/process.c
>>>>> +++ b/arch/arm64/kernel/process.c
>>>>> @@ -680,10 +680,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>>>>  	gcs_thread_switch(next);
>>>>>  
>>>>>  	/*
>>>>> -	 * Complete any pending TLB or cache maintenance on this CPU in case
>>>>> -	 * the thread migrates to a different CPU.
>>>>> -	 * This full barrier is also required by the membarrier system
>>>>> -	 * call.
>>>>> +	 * Complete any pending TLB or cache maintenance on this CPU in case the
>>>>> +	 * thread migrates to a different CPU. This full barrier is also
>>>>> +	 * required by the membarrier system call. Additionally it is required
>>>>> +	 * for TIF_KMAP_UPDATE_PENDING, see below.
>>>>>  	 */
>>>>>  	dsb(ish);
>>>>>  
>>>>> @@ -696,6 +696,18 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>>>>  	/* avoid expensive SCTLR_EL1 accesses if no change */
>>>>>  	if (prev->thread.sctlr_user != next->thread.sctlr_user)
>>>>>  		update_sctlr_el1(next->thread.sctlr_user);
>>>>> +	else if (unlikely(test_thread_flag(TIF_KMAP_UPDATE_PENDING))) {
>>>>> +		/*
>>>>> +		 * In unlikely event that a kernel map update is on-going when
>>>>> +		 * preemption occurs, we must emit_pte_barriers() if pending.
>>>>> +		 * emit_pte_barriers() consists of "dsb(ishst); isb();". The dsb
>>>>> +		 * is already handled above. The isb() is handled if
>>>>> +		 * update_sctlr_el1() was called. So only need to emit isb()
>>>>> +		 * here if it wasn't called.
>>>>> +		 */
>>>>> +		isb();
>>>>> +		clear_thread_flag(TIF_KMAP_UPDATE_PENDING);
>>>>> +	}
>>>>>  
>>>>>  	/* the actual thread switch */
>>>>>  	last = cpu_switch_to(prev, next);
>>>
> 

