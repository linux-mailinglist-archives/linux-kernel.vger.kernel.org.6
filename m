Return-Path: <linux-kernel+bounces-432123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1F9E4581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95272284EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E41F03C8;
	Wed,  4 Dec 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Hx8/tiI5"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E71F03D1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343596; cv=none; b=hBJkopmO8Na44z3OnLn0rv3cF43FZrqHLmc+elNaVS9qFoZilAhFhHvDZGPcsyG9fZJeytZKJHh162XcWjftgqLLwljRTeFZ7DRbXFYVofmIDi6sVUZXMvAVdZqrep7fQCZf5ZEe8Uz4DLfq+CyG5ciptcIRtbCw/LkQ26mV440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343596; c=relaxed/simple;
	bh=+B1oBcmjip8MCv2+oNZlZ/mq046xmivhhOIvQgpgSuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg2F7jqRT/M/d+YhsVHvLK1MUAv/iH1NjDWg3q2bVva5DG4SDpFqH0G3So0pCxE7IgFfd4puHPmnmYKWDZog+hoCqChWoWYlCbazEclRnz2u7Yagb2VkrBjBGPGz5vHEMrkgDPeFY8udyrOXyTbgkyxEfdm4sPTy6ev4xyJPHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Hx8/tiI5; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733343586;
	bh=+B1oBcmjip8MCv2+oNZlZ/mq046xmivhhOIvQgpgSuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hx8/tiI5eYY8Rxea/n9Vta7TH43LVvqNlZZLVn4VX7SpXfHcME7cMd+25TdMWXmNc
	 P5CQ+KK3jZZHnCmn48xg6WfqgWtL5cXKlaNZoRsiIfS44tsM4I4RtECOj6xPP10yqM
	 JXuVx7RZKa9bgXj5HcGg/h/cHdkX4TEBJTY/qo+Fw6fwXgWQPlLiZ4gJfDDlZnBgrD
	 QtwYeBoYB+1Q0X7B/1FqhotLdoN7132+m52w9D7KJ9qLKH41s/3WSk6gsvOTu3/En5
	 fmZ3thMX8dJcUwjB/KrrbBor+lCS85saI2IM6T2/XoiNZwVs7uq7Z62xJfJEriMWnc
	 OFbro8NDVc1bA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y3TQV1tSBzTxh;
	Wed,  4 Dec 2024 15:19:46 -0500 (EST)
Message-ID: <43835b8c-53cd-428f-a46f-554bfa5c2cdd@efficios.com>
Date: Wed, 4 Dec 2024 15:19:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86,mm: only trim the mm_cpumask once a second
To: Rik van Riel <riel@surriel.com>, Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
References: <202411282207.6bd28eae-lkp@intel.com>
 <20241202194358.59089122@fangorn> <Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
 <20241204115634.28964c62@fangorn>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241204115634.28964c62@fangorn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-04 11:56, Rik van Riel wrote:
[...]
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: kernel test roboto <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
> ---
>   arch/x86/include/asm/mmu.h         |  2 ++
>   arch/x86/include/asm/mmu_context.h |  1 +
>   arch/x86/include/asm/tlbflush.h    |  1 +
>   arch/x86/mm/tlb.c                  | 35 +++++++++++++++++++++++++++---
>   4 files changed, 36 insertions(+), 3 deletions(-)
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
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 69e79fff41b8..02fc2aa06e9e 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -222,6 +222,7 @@ struct flush_tlb_info {
>   	unsigned int		initiating_cpu;
>   	u8			stride_shift;
>   	u8			freed_tables;
> +	u8			trim_cpumask;
>   };
>   
>   void flush_tlb_local(void);
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 1aac4fa90d3d..a758143afa01 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -892,9 +892,36 @@ static void flush_tlb_func(void *info)
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
> +	if (info->trim_cpumask)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool should_trim_cpumask(struct mm_struct *mm)
> +{
> +	if (time_after(jiffies, mm->context.next_trim_cpumask)) {
> +		mm->context.next_trim_cpumask = jiffies + HZ;

AFAIU this should_trim_cpumask can be called from many cpus
concurrently for a given mm, so we'd want READ_ONCE/WRITE_ONCE
on the next_trim_cpumask.

Thanks,

Mathieu

> +		return true;
> +	}
> +	return false;
>   }
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
> @@ -928,7 +955,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>   	if (info->freed_tables)
>   		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>   	else
> -		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
> +		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>   				(void *)info, 1, cpumask);
>   }
>   
> @@ -979,6 +1006,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>   	info->freed_tables	= freed_tables;
>   	info->new_tlb_gen	= new_tlb_gen;
>   	info->initiating_cpu	= smp_processor_id();
> +	info->trim_cpumask	= 0;
>   
>   	return info;
>   }
> @@ -1021,6 +1049,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>   	 * flush_tlb_func_local() directly in this case.
>   	 */
>   	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
> +		info->trim_cpumask = should_trim_cpumask(mm);
>   		flush_tlb_multi(mm_cpumask(mm), info);
>   	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
>   		lockdep_assert_irqs_enabled();

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


