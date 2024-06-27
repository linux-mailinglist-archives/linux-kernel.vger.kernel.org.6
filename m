Return-Path: <linux-kernel+bounces-232470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD4491A942
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D93C1C20B07
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C7195FEC;
	Thu, 27 Jun 2024 14:34:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316534C6D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498847; cv=none; b=S05l5yZF5HkVb25LBfCdn7Tc5cq6ELpLD15Wsh4uKhGWvuxFk4u+TS06vooDghOlrJo0tiIhhX1+rFjtdz9K/pU1Z8gWsn0m/iZ5mZyjfaJ4V5qyaRyaVXywhVMng5hJNvAB4bP5T5ngGN+EVUYQM1TMlLqrnds6gc1fvWDakRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498847; c=relaxed/simple;
	bh=/q33qh5O9pNPSaATYpAbeczhLVB1DvmEHCMjLpjZVXg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=toEDgwS7Pb5z7F+4Ttl6QQLY+ZlrzqjopRoOinyay3TxR7+8FbaIoWXvInlxRzAQ065fBpubul+II9NlmdXVUakq8+MRS6Lv8q5SvAGd4KhEnapZ3f2RcMCb09CjR2NrI15Z2RU8DBRgXN5p6hjJOCEal/47Yg6AGoJBUeSuHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W91HY4Q0Kzdf9L;
	Thu, 27 Jun 2024 22:32:25 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CB9F140154;
	Thu, 27 Jun 2024 22:34:00 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 22:33:58 +0800
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Yu Zhao <yuzhao@google.com>
CC: David Rientjes <rientjes@google.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox
	<willy@infradead.org>, <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
	<wangkefeng.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Yosry Ahmed
	<yosryahmed@google.com>, Sourav Panda <souravpanda@google.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org> <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck>
 <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
 <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com>
 <ZnkGps-vQbiynNwP@google.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <17232655-553d-7d48-8ba1-5425e8ab0f8b@huawei.com>
Date: Thu, 27 Jun 2024 22:33:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZnkGps-vQbiynNwP@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)


在 2024/6/24 13:39, Yu Zhao 写道:
> On Mon, Mar 25, 2024 at 11:24:34PM +0800, Nanyong Sun wrote:
>> On 2024/3/14 7:32, David Rientjes wrote:
>>
>>> On Thu, 8 Feb 2024, Will Deacon wrote:
>>>
>>>>> How about take a new lock with irq disabled during BBM, like:
>>>>>
>>>>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
>>>>> +{
>>>>> +     (NEW_LOCK);
>>>>> +    pte_clear(&init_mm, addr, ptep);
>>>>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>>> +    set_pte_at(&init_mm, addr, ptep, pte);
>>>>> +    spin_unlock_irq(NEW_LOCK);
>>>>> +}
>>>> I really think the only maintainable way to achieve this is to avoid the
>>>> possibility of a fault altogether.
>>>>
>>>> Will
>>>>
>>>>
>>> Nanyong, are you still actively working on making HVO possible on arm64?
>>>
>>> This would yield a substantial memory savings on hosts that are largely
>>> configured with hugetlbfs.  In our case, the size of this hugetlbfs pool
>>> is actually never changed after boot, but it sounds from the thread that
>>> there was an idea to make HVO conditional on FEAT_BBM.  Is this being
>>> pursued?
>>>
>>> If so, any testing help needed?
>> I'm afraid that FEAT_BBM may not solve the problem here
> I think so too -- I came cross this while working on TAO [1].
>
> [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
>
>> because from Arm
>> ARM,
>> I see that FEAT_BBM is only used for changing block size. Therefore, in this
>> HVO feature,
>> it can work in the split PMD stage, that is, BBM can be avoided in
>> vmemmap_split_pmd,
>> but in the subsequent vmemmap_remap_pte, the Output address of PTE still
>> needs to be
>> changed. I'm afraid FEAT_BBM is not competent for this stage. Perhaps my
>> understanding
>> of ARM FEAT_BBM is wrong, and I hope someone can correct me.
>> Actually, the solution I first considered was to use the stop_machine
>> method, but we have
>> products that rely on /proc/sys/vm/nr_overcommit_hugepages to dynamically
>> use hugepages,
>> so I have to consider performance issues. If your product does not change
>> the amount of huge
>> pages after booting, using stop_machine() may be a feasible way.
>> So far, I still haven't come up with a good solution.
> I do have a patch that's similar to stop_machine() -- it uses NMI IPIs
> to pause/resume remote CPUs while the local one is doing BBM.
>
> Note that the problem of updating vmemmap for struct page[], as I see
> it, is beyond hugeTLB HVO. I think it impacts virtio-mem and memory
> hot removal in general [2]. On arm64, we would need to support BBM on
> vmemmap so that we can fix the problem with offlining memory (or to be
> precise, unmapping offlined struct page[]), by mapping offlined struct
> page[] to a read-only page of dummy struct page[], similar to
> ZERO_PAGE(). (Or we would have to make extremely invasive changes to
> the reader side, i.e., all speculative PFN walkers.)
>
> In case you are interested in testing my approach, you can swap your
> patch 2 with the following:
I don't have an NMI IPI capable ARM machine on hand, so I think this feature
depends on a higher version of the ARM cpu.
What I worried about was that other cores would occasionally be interrupted
frequently(8 times every 2M and 4096 times every 1G) and then wait for the
update of page table to complete before resuming. If there are workloads
running on other cores, performance may be affected. This implementation
speeds up stopping and resuming other cores, but they still have to wait
for the update to finish.
>
> [2] https://lore.kernel.org/20240621213717.1099079-1-yuzhao@google.com/
>
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 8ff5f2a2579e..1af1aa34a351 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -12,6 +12,7 @@
>   #include <asm/processor.h>
>   #include <asm/cacheflush.h>
>   #include <asm/tlbflush.h>
> +#include <asm/cpu.h>
>   
>   #define __HAVE_ARCH_PGD_FREE
>   #define __HAVE_ARCH_PUD_FREE
> @@ -137,4 +138,58 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
>   	__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TABLE_PXN);
>   }
>   
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +
> +#define vmemmap_update_lock vmemmap_update_lock
> +static inline void vmemmap_update_lock(void)
> +{
> +	cpus_read_lock();
> +}
> +
> +#define vmemmap_update_unlock vmemmap_update_unlock
> +static inline void vmemmap_update_unlock(void)
> +{
> +	cpus_read_unlock();
> +}
> +
> +#define vmemmap_update_pte vmemmap_update_pte
> +static inline void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
> +{
> +	preempt_disable();
> +	pause_remote_cpus();
> +
> +	pte_clear(&init_mm, addr, ptep);
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	set_pte_at(&init_mm, addr, ptep, pte);
> +
> +	resume_remote_cpus();
> +	preempt_enable();
> +}
> +
> +#define vmemmap_update_pmd vmemmap_update_pmd
> +static inline void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep)
> +{
> +	preempt_disable();
> +	pause_remote_cpus();
> +
> +	pmd_clear(pmdp);
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +	pmd_populate_kernel(&init_mm, pmdp, ptep);
> +
> +	resume_remote_cpus();
> +	preempt_enable();
> +}
> +
> +#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
> +static inline void vmemmap_flush_tlb_all(void)
> +{
> +}
> +
> +#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
> +static inline void vmemmap_flush_tlb_range(unsigned long start, unsigned long end)
> +{
> +}
> +
> +#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
> +
>   #endif
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index efb13112b408..544b15948b64 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -144,6 +144,9 @@ bool cpus_are_stuck_in_kernel(void);
>   extern void crash_smp_send_stop(void);
>   extern bool smp_crash_stop_failed(void);
>   
> +void pause_remote_cpus(void);
> +void resume_remote_cpus(void);
> +
>   #endif /* ifndef __ASSEMBLY__ */
>   
>   #endif /* ifndef __ASM_SMP_H */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 31c8b3094dd7..ae0a178db066 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -71,16 +71,25 @@ enum ipi_msg_type {
>   	IPI_RESCHEDULE,
>   	IPI_CALL_FUNC,
>   	IPI_CPU_STOP,
> +	IPI_CPU_PAUSE,
> +#ifdef CONFIG_KEXEC_CORE
>   	IPI_CPU_CRASH_STOP,
> +#endif
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>   	IPI_TIMER,
> +#endif
> +#ifdef CONFIG_IRQ_WORK
>   	IPI_IRQ_WORK,
> +#endif
>   	NR_IPI,
>   	/*
>   	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
>   	 * with trace_ipi_*
>   	 */
>   	IPI_CPU_BACKTRACE = NR_IPI,
> +#ifdef CONFIG_KGDB
>   	IPI_KGDB_ROUNDUP,
> +#endif
>   	MAX_IPI
>   };
>   
> @@ -771,9 +780,16 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>   	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
>   	[IPI_CALL_FUNC]		= "Function call interrupts",
>   	[IPI_CPU_STOP]		= "CPU stop interrupts",
> +	[IPI_CPU_PAUSE]		= "CPU pause interrupts",
> +#ifdef CONFIG_KEXEC_CORE
>   	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
> +#endif
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>   	[IPI_TIMER]		= "Timer broadcast interrupts",
> +#endif
> +#ifdef CONFIG_IRQ_WORK
>   	[IPI_IRQ_WORK]		= "IRQ work interrupts",
> +#endif
>   };
>   
>   static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> @@ -832,6 +848,85 @@ void __noreturn panic_smp_self_stop(void)
>   	local_cpu_stop();
>   }
>   
> +static DEFINE_SPINLOCK(cpu_pause_lock);
> +static cpumask_t paused_cpus;
> +static cpumask_t resumed_cpus;
> +
> +static void pause_local_cpu(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	cpumask_clear_cpu(cpu, &resumed_cpus);
> +	/*
> +	 * Paired with pause_remote_cpus() to confirm that this CPU not only
> +	 * will be paused but also can be reliably resumed.
> +	 */
> +	smp_wmb();
> +	cpumask_set_cpu(cpu, &paused_cpus);
> +	/* A typical example for sleep and wake-up functions. */
> +	smp_mb();
> +	while (!cpumask_test_cpu(cpu, &resumed_cpus)) {
> +		wfe();
> +		barrier();
> +	}
> +	barrier();
> +	cpumask_clear_cpu(cpu, &paused_cpus);
> +}
> +
> +void pause_remote_cpus(void)
> +{
> +	cpumask_t cpus_to_pause;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_preemption_disabled();
> +
> +	cpumask_copy(&cpus_to_pause, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
> +
> +	spin_lock(&cpu_pause_lock);
> +
> +	WARN_ON_ONCE(!cpumask_empty(&paused_cpus));
> +
> +	smp_cross_call(&cpus_to_pause, IPI_CPU_PAUSE);
> +
> +	while (!cpumask_equal(&cpus_to_pause, &paused_cpus)) {
> +		cpu_relax();
> +		barrier();
> +	}
> +	/*
> +	 * Paired pause_local_cpu() to confirm that all CPUs not only will be
> +	 * paused but also can be reliably resumed.
> +	 */
> +	smp_rmb();
> +	WARN_ON_ONCE(cpumask_intersects(&cpus_to_pause, &resumed_cpus));
> +
> +	spin_unlock(&cpu_pause_lock);
> +}
> +
> +void resume_remote_cpus(void)
> +{
> +	cpumask_t cpus_to_resume;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_preemption_disabled();
> +
> +	cpumask_copy(&cpus_to_resume, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &cpus_to_resume);
> +
> +	spin_lock(&cpu_pause_lock);
> +
> +	cpumask_setall(&resumed_cpus);
> +	/* A typical example for sleep and wake-up functions. */
> +	smp_mb();
> +	while (cpumask_intersects(&cpus_to_resume, &paused_cpus)) {
> +		sev();
> +		cpu_relax();
> +		barrier();
> +	}
> +
> +	spin_unlock(&cpu_pause_lock);
> +}
> +
>   #ifdef CONFIG_KEXEC_CORE
>   static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
>   #endif
> @@ -911,6 +1006,11 @@ static void do_handle_IPI(int ipinr)
>   		local_cpu_stop();
>   		break;
>   
> +	case IPI_CPU_PAUSE:
> +		pause_local_cpu();
> +		break;
> +
> +#ifdef CONFIG_KEXEC_CORE
>   	case IPI_CPU_CRASH_STOP:
>   		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
>   			ipi_cpu_crash_stop(cpu, get_irq_regs());
> @@ -918,6 +1018,7 @@ static void do_handle_IPI(int ipinr)
>   			unreachable();
>   		}
>   		break;
> +#endif
>   
>   #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>   	case IPI_TIMER:
> @@ -939,9 +1040,11 @@ static void do_handle_IPI(int ipinr)
>   		nmi_cpu_backtrace(get_irq_regs());
>   		break;
>   
> +#ifdef CONFIG_KGDB
>   	case IPI_KGDB_ROUNDUP:
>   		kgdb_nmicallback(cpu, get_irq_regs());
>   		break;
> +#endif
>   
>   	default:
>   		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
> @@ -971,9 +1074,14 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>   
>   	switch (ipi) {
>   	case IPI_CPU_STOP:
> +	case IPI_CPU_PAUSE:
> +#ifdef CONFIG_KEXEC_CORE
>   	case IPI_CPU_CRASH_STOP:
> +#endif
>   	case IPI_CPU_BACKTRACE:
> +#ifdef CONFIG_KGDB
>   	case IPI_KGDB_ROUNDUP:
> +#endif
>   		return true;
>   	default:
>   		return false;
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 5113753f3ac9..da6f2a7d665e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -46,6 +46,18 @@ struct vmemmap_remap_walk {
>   	unsigned long		flags;
>   };
>   
> +#ifndef vmemmap_update_lock
> +static void vmemmap_update_lock(void)
> +{
> +}
> +#endif
> +
> +#ifndef vmemmap_update_unlock
> +static void vmemmap_update_unlock(void)
> +{
> +}
> +#endif
> +
>   #ifndef vmemmap_update_pmd
>   static inline void vmemmap_update_pmd(unsigned long addr,
>   				      pmd_t *pmdp, pte_t *ptep)
> @@ -194,10 +206,12 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   
>   	VM_BUG_ON(!PAGE_ALIGNED(start | end));
>   
> +	vmemmap_update_lock();
>   	mmap_read_lock(&init_mm);
>   	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
>   				    NULL, walk);
>   	mmap_read_unlock(&init_mm);
> +	vmemmap_update_unlock();
>   	if (ret)
>   		return ret;
>   
>
> .

