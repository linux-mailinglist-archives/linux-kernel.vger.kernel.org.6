Return-Path: <linux-kernel+bounces-430354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62259E2FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1229166ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931020ADEE;
	Tue,  3 Dec 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rhlJfm9I"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2820B7E3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268477; cv=none; b=XrcPsNypxEYLg+WhHr23zhMZN/GDQbLiuPyaco9C/5RQBVtzG6ryPaAd32ghYz3/85k0l3S8YHcPyr5MEtN8z83upTQivJRDy7be7v6xXVJ/6aRuV1uYcGJRlJyBL6liDrIIrhpzgz3p5EqSfFmgPrFrvrVfIhjOFwrXCUY+w+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268477; c=relaxed/simple;
	bh=1Zg6xqKmkaJdB7fF0cwCPNd1LzG3HXrmtryrah+eL1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFYKWjcZiXyFTFoMa/OVQ3UCVS1r8Gc6I3u6+AHqaTCJxEjq9TzuZyDlvq3U6Nw+qoGgLFQKQTJVMTGBhEdderKKpkKRTpmusNyHwXVxv7aDSL8xBAUrzaScmDuRgldrCoRE4eOIlq1hPisIkNaOWxGtL8J5WrZRPm/eVquFZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rhlJfm9I; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733268473;
	bh=1Zg6xqKmkaJdB7fF0cwCPNd1LzG3HXrmtryrah+eL1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rhlJfm9I+Y24cIvjNPGrIKIKnMIHGOtC3kPYU8A5MXyjfAeLBJbeIF/AEpiW1c/fL
	 4iQQ7ojsEXJ3OeEIsdu0D3C/wyArbmkpoUo2gh9olHRjRIrmeOJrhtcyj4B7pWLeJj
	 dyPNfx8BgKwNT5HGKSFQHGYfnZABNLYqDAGGjsBH537ceDbhZTpTA3kQAVibelcppL
	 f8Ed9apcktH9zAaeYeVU7MLc28vic7QRgy6QcYfybPh8vT3+7l7aqyum57oMR6CsPZ
	 bjlQYOYtlAzoEpWU8h/dBDzLtoEOCc0krhUKlN+tYF3NdVQ9kSt3RqVgPAe8FzdKhr
	 iFixSPQv3h44g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y2xf06hYQzVGt;
	Tue,  3 Dec 2024 18:27:52 -0500 (EST)
Message-ID: <4bd16d01-89bf-4c6a-87dc-30f0f6245728@efficios.com>
Date: Tue, 3 Dec 2024 18:27:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86,mm: only trim the mm_cpumask once a second
To: Rik van Riel <riel@surriel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
References: <202411282207.6bd28eae-lkp@intel.com>
 <20241202202213.26a79ed6@fangorn>
 <5dcb4050-f0f3-43d6-b4b1-42fa305a0fba@efficios.com>
 <20241203144845.7093ea1a@fangorn>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241203144845.7093ea1a@fangorn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-03 14:48, Rik van Riel wrote:
> On Tue, 3 Dec 2024 09:57:55 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
>> I'd recommend to rename "last_trimmed_cpumask" to "next_trim_cpumask",
>> and always update it to "jiffies + HZ". Then we can remove the addition
>> from the comparison in the should_flush_tlb() fast-path:
> 
> Thanks Mathieu, I have applied your suggested improvements,
> except for the one you posted as a separate patch earlier.
> 
> ---8<---
> 
>  From c7d04233f15ba217ce6ebd0dcf12fab91c437e96 Mon Sep 17 00:00:00 2001
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

We should add information detailing why tlbflush2 end up
contending on the mmap_sem, and thus schedule often.

> 
> Instead of always sending IPIs to CPUs that are in the mm_cpumask,
> but no longer running the program, send these IPIs only once a second.
> 
> The rest of the time we can skip over CPUs where the loaded_mm is
> different from the target mm.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Much better !

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Reported-by: kernel test roboto <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
> ---
>   arch/x86/include/asm/mmu.h         |  2 ++
>   arch/x86/include/asm/mmu_context.h |  1 +
>   arch/x86/mm/tlb.c                  | 27 ++++++++++++++++++++++++---
>   3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index ce4677b8b735..3b496cdcb74b 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -37,6 +37,8 @@ typedef struct {
>   	 */
>   	atomic64_t tlb_gen;
>   
> +	unsigned long next_trim_cpumask;
> +
>   #ifdef CONFIG_MODIFY_LDT_SYSCALL
>   	struct rw_semaphore	ldt_usr_sem;
>   	struct ldt_struct	*ldt;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 2886cb668d7f..795fdd53bd0a 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *tsk,
>   
>   	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
>   	atomic64_set(&mm->context.tlb_gen, 0);
> +	mm->context.next_trim_cpumask = jiffies + HZ;
>   
>   #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>   	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 1aac4fa90d3d..e90edbbf0188 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -759,8 +759,11 @@ static void flush_tlb_func(void *info)
>   
>   		/* Can only happen on remote CPUs */
>   		if (f->mm && f->mm != loaded_mm) {
> +			unsigned long next_jiffies = jiffies + HZ;
>   			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
>   			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
> +			if (time_after(next_jiffies, READ_ONCE(f->mm->context.next_trim_cpumask)))
> +				WRITE_ONCE(f->mm->context.next_trim_cpumask, next_jiffies);
>   			return;
>   		}
>   	}
> @@ -892,9 +895,27 @@ static void flush_tlb_func(void *info)
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
> +	if (time_after(jiffies, info->mm->context.next_trim_cpumask))
> +		return true;
> +
> +	return false;
>   }
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
> @@ -928,7 +949,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>   	if (info->freed_tables)
>   		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>   	else
> -		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
> +		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>   				(void *)info, 1, cpumask);
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


