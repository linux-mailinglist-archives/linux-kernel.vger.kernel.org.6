Return-Path: <linux-kernel+bounces-429700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DA9E2085
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7D116831B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346DB1F6698;
	Tue,  3 Dec 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P+t19iLL"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377461F7094
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237887; cv=none; b=SuTNTNo0kA8FS+vWMPqKU5MgWPokEtF8Tp5l1NbUsjDk+b895GPCUkIuBGCHrjs+wOlmi8z7KF/qR+O+bUbdgKQvEv1K/Gq/qtUFG/vcMU+5uyeLzXYKff3qVUmPBCTKawcc+TeDSRNgBuz3sdnu6vPsJ68Kgx0l6yL68FMwTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237887; c=relaxed/simple;
	bh=4cjEyZE6HVGSeimBj6FLHI+LLqiVp5XwxzP/YEyqIW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddIJOPXgRjHrP8qT9dlXN79TpBtFpLIfvFSTIdlyHLeKHGGCDl8C1OhxEHPtkoGtUZFpoLY1G+K5B8IrLlQ0ljaCBuPAYS/5k1dUShXZLlAlLdHHtO3khI4ddDlavyziZHO5TFnk+VMTFI9hcR+E5gDy7qfiKhIfUAQE8i5hHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P+t19iLL; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733237876;
	bh=4cjEyZE6HVGSeimBj6FLHI+LLqiVp5XwxzP/YEyqIW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+t19iLL72hDOrPHeyxh7syweP2E1xdh8/ANKVlXRYRvGO9pbypQBn/wQLfW9pnjd
	 twCiKbXbvhyBpTjodZTBCvIQqyYC8h8KvY22XVi2TmYHOKpDOimw0nbGIYefr6yRe+
	 Uc7o5hqhLU6HOISB4OWVJF7pkDQFzg/7nBjx4S4RaBw4PikuW9VzQPkABdHDJjiWaC
	 f4QE9EPZrlkGzKWowfWRRGMiGGsjxnRAIbxdvzbSDMPPkmlSxn/6EyRqsXgWBSJFTZ
	 2YHVpbEu7y3icelPYDBKFRcJWmeNyjC+8uV036uRhfZcnMNFXDiWTMVWP86T0ZaYBV
	 nZaspvdxmpAcw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y2kKc0ytVzVMN;
	Tue,  3 Dec 2024 09:57:56 -0500 (EST)
Message-ID: <5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
Date: Tue, 3 Dec 2024 09:57:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86,mm: only trim the mm_cpumask once a second
To: Rik van Riel <riel@surriel.com>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
References: <202411282207.6bd28eae-lkp@intel.com>
 <20241202202213.26a79ed6@fangorn>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241202202213.26a79ed6@fangorn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-02 20:22, Rik van Riel wrote:
> On Thu, 28 Nov 2024 22:57:35 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
> 
>> Hello,
>>
>> kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_ops on:
>>
>>
>> commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> 
> [UGH - of course I mailed out the version I tested with, rather than
>   the version that I merged into -tip.  Here's the right one.]
> 
> The patch below should fix the will-it-scale performance regression,
> while still allowing us to keep the lazy mm_cpumask updates that help
> workloads in other ways.
> 
> I do not have the same hardware as the Intel guys have access to, and
> could only test this on one two socket system, but hopefully this
> provides a simple (enough) compromise that allows us to keep both
> the lazier context switch code, and a limited mm_cpumask to keep
> TLB flushing work bounded.
> 
> ---8<---
> 
>  From dec4a588077563b86dbfe547737018b881e1f6c2 Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@fb.com>
> Date: Mon, 2 Dec 2024 09:57:31 -0800
> Subject: [PATCH] x86,mm: only trim the mm_cpumask once a second
> 
> Setting and clearing CPU bits in the mm_cpumask is only ever done
> by the CPU itself, from the context switch code or the TLB flush
> code.
> 
> Synchronization is handled by switch_mm_irqs_off blocking interrupts.
> 
> Sending TLB flush IPIs to CPUs that are in the mm_cpumask, but no
> longer running the program causes a regression in the will-it-scale
> tlbflush2 test. This test is contrived, but a large regression here
> might cause a small regression in some real world workload.
> 
> Instead of always sending IPIs to CPUs that are in the mm_cpumask,
> but no longer running the program, send these IPIs only once a second.
> 
> The rest of the time we can skip over CPUs where the loaded_mm is
> different from the target mm.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: kernel test roboto <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
> ---
>   arch/x86/include/asm/mmu.h         |  2 ++
>   arch/x86/include/asm/mmu_context.h |  1 +
>   arch/x86/mm/tlb.c                  | 25 ++++++++++++++++++++++---
>   3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index ce4677b8b735..2c7e3855b88b 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -37,6 +37,8 @@ typedef struct {
>   	 */
>   	atomic64_t tlb_gen;
>   
> +	unsigned long last_trimmed_cpumask;

I'd recommend to rename "last_trimmed_cpumask" to "next_trim_cpumask",
and always update it to "jiffies + HZ". Then we can remove the addition
from the comparison in the should_flush_tlb() fast-path:

     if (time_after(jiffies, READ_ONCE(info->mm->context.next_trim_cpumask)))
         return true;

> +
>   #ifdef CONFIG_MODIFY_LDT_SYSCALL
>   	struct rw_semaphore	ldt_usr_sem;
>   	struct ldt_struct	*ldt;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 2886cb668d7f..086af641d19a 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *tsk,
>   
>   	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
>   	atomic64_set(&mm->context.tlb_gen, 0);
> +	mm->context.last_trimmed_cpumask = jiffies;

mm->context.next_trim_cpumask = jiffies + HZ;

>   
>   #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>   	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 1aac4fa90d3d..19ae8ca34cb8 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -761,6 +761,7 @@ static void flush_tlb_func(void *info)
>   		if (f->mm && f->mm != loaded_mm) {
>   			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
>   			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
> +			f->mm->context.last_trimmed_cpumask = jiffies;

mm->context.next_trim_cpumask is stored/loaded without any locks.
READ_ONCE()/WRITE_ONCE() would be relevant here.

This is likely introducing a burst of mostly useless
f->mm->context.next_trim_cpumask updates. When reaching the threshold
where trimming is permitted, IPIs are sent to a set of CPUs which are
allowed to trim. Each CPU performing the tlb flush for trimming
will end up updating the f->mm->context.next_trim_cpumask
concurrently, when in fact we only care about the first update.

We should change this to

     unsigned long next_jiffies = jiffies + HZ;

     if (time_after(next_jiffies, READ_ONCE(f->mm->context.next_trim_cpumask))
         WRITE_ONCE(f->mm->context.next_trim_cpumask, next_jiffies);

>   			return;
>   		}
>   	}
> @@ -892,9 +893,27 @@ static void flush_tlb_func(void *info)
>   			nr_invalidate);
>   }
>   
> -static bool tlb_is_not_lazy(int cpu, void *data)
> +static bool should_flush_tlb(int cpu, void *data)
>   {
> -	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> +	struct flush_tlb_info *info = data;
> +
> +	/* Lazy TLB will get flushed at the next context switch. */
> +	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
> +		return false;
> +
> +	/* No mm means kernel memory flush. */
> +	if (!info->mm)
> +		return true;
> +
> +	/* The target mm is loaded, and the CPU is not lazy. */
> +	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
> +		return true;
> +
> +	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
> +	if (jiffies > info->mm->context.last_trimmed_cpumask + HZ)

When jiffies overflow on 32-bit architectures, it will go back to a
near-zero value and chances are that

   info->mm->context.last_trimmed_cpumask + HZ

is a near-overflow large value. Therefore, in that state, the comparison
will stay false for quite a while, which is unexpected.

This will prevent trimming the mm_cpumask for as long as that state
persists.

I'd recommend using the following overflow-safe comparison instead:

     if (time_after(jiffies, info->mm->context.next_trim_cpumask)
         return true;

> +		return true;
> +
> +	return false;
>   }
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
> @@ -928,7 +947,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>   	if (info->freed_tables)
>   		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>   	else
> -		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
> +		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>   				(void *)info, 1, cpumask);

I'm concerned about the following race in smp_call_function_many_cond():

1) cond_func() is called for all remote cpus,
2) IPIs are sent.
3) cond_func() is called for the local cpu.

(3) is loading the next_trim_cpumask value after other cpus had a chance to
trim, and thus bump the next_trim_cpumask. This appears to be unwanted.

I would be tempted to move the evaluation of cond_func() before sending the
IPIs to other cpus in that function.

Thanks,

Mathieu

>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


