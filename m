Return-Path: <linux-kernel+bounces-410448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A359CDBC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9B1F2338D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D418FDAA;
	Fri, 15 Nov 2024 09:42:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC1189F39
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663762; cv=none; b=MA8jx4FgUM65X2GzNwMdimZgbO2Vkp+4RlvKJwoHCbNn5aYi7ha+Mdtsiu6HtgfZbE/Q2uJOL0U+giCvDPZqJn/DEecYZkDd0z+nrV2Q+rG+SHJNvLNuS0rE35LFh8F7V6yhAXfGTwklmXyKIZmj5vpT5ODHKK8A9H+uGIcsIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663762; c=relaxed/simple;
	bh=UCmw2gnxr2XgJSyaNbbuk8r6urTWz7yILJ/u2+wr4hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBe/dsFjMnQXCRdcf7nVEw5lCOS9yfj6iioh+L7iPbF2PUOZ1tE2mrnoWairZPFGfKcL/+vC779bKoTwsXRE0fjEShXmgp02xSpE4+wcv+FSyjhbop7Ob45X3U8gt9TmgD6gtTXqYc8yrdpa3HpDDCXUpK7+2fKuTEpa0m89zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034591476;
	Fri, 15 Nov 2024 01:43:09 -0800 (PST)
Received: from [10.34.125.21] (unknown [10.34.125.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069423F66E;
	Fri, 15 Nov 2024 01:42:33 -0800 (PST)
Message-ID: <427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com>
Date: Fri, 15 Nov 2024 10:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Yicong Yang <yangyicong@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, dietmar.eggemann@arm.com, x86@kernel.org,
 bp@alien8.de, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 mpe@ellerman.id.au, peterz@infradead.org, tglx@linutronix.de,
 sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com, dave.hansen@linux.intel.com
References: <20241114141127.23232-1-yangyicong@huawei.com>
 <20241114141127.23232-2-yangyicong@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241114141127.23232-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,


On 11/14/24 15:11, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently if architectures want to support HOTPLUG_SMT they need to
> provide a topology_is_primary_thread() telling the framework which
> thread in the SMT cannot offline. However arm64 doesn't have a
> restriction on which thread in the SMT cannot offline, a simplest
> choice is that just make 1st thread as the "primary" thread. So
> just make this as the default implementation in the framework and
> let architectures like x86 that have special primary thread to
> override this function (which they've already done).
> 
> There's no need to provide a stub function if !CONFIG_SMP or
> !CONFIG_HOTPLUG_SMP. In such case the testing CPU is already
> the 1st CPU in the SMT so it's always the primary thread.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/powerpc/include/asm/topology.h |  1 +
>   arch/x86/include/asm/topology.h     |  2 +-
>   include/linux/topology.h            | 20 ++++++++++++++++++++
>   3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 16bacfe8c7a2..da15b5efe807 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -152,6 +152,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>   {
>   	return cpu == cpu_first_thread_sibling(cpu);
>   }
> +#define topology_is_primary_thread topology_is_primary_thread
>   
>   static inline bool topology_smt_thread_allowed(unsigned int cpu)
>   {
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 92f3664dd933..d84d9b6d8678 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -219,11 +219,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>   {
>   	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
>   }
> +#define topology_is_primary_thread topology_is_primary_thread
>   
>   #else /* CONFIG_SMP */
>   static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
>   static inline int topology_max_smt_threads(void) { return 1; }
> -static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
>   static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
>   #endif /* !CONFIG_SMP */
>   
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..b8e860276518 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -240,6 +240,26 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>   }
>   #endif
>   
> +#ifndef topology_is_primary_thread
> +
> +#define topology_is_primary_thread topology_is_primary_thread
> +
> +static inline bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	/*
> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
> +	 * Architectures do have a special primary thread (e.g. x86) need
> +	 * to override this function. Otherwise just make the first thread
> +	 * in the SMT as the primary thread.
> +	 *
> +	 * The sibling cpumask of an offline CPU contains always the CPU
> +	 * itself.

As Thomas suggested, would it be possible to check it for other
architectures ?
For instance for loongarch at arch/loongarch/kernel/smp.c,
clear_cpu_sibling_map() seems to completely clear &cpu_sibling_map[cpu]
when a CPU is put offline. This would make topology_sibling_cpumask(cpu)
to be empty and cpu_bootable() return false if the CPU never booted before.

Personal note:
cpu_bootable() is called from an already online CPU:
cpu_bootable (kernel/cpu.c:678)
cpu_up (kernel/cpu.c:1722 kernel/cpu.c:1702)
bringup_nonboot_cpus (kernel/cpu.c:1793 kernel/cpu.c:1901)
smp_init (./include/linux/bitmap.h:445 ./include/linux/nodemask.h:241 ./include/linux/nodemask.h:438 kernel/smp.c:1011)
kernel_init_freeable (init/main.c:1573)
kernel_init (init/main.c:1473)
ret_from_fork (arch/arm64/kernel/entry.S:861)

store_cpu_topology() for arm64 is called from the booting CPU:
store_cpu_topology (drivers/base/arch_topology.c:921)
secondary_start_kernel (arch/arm64/kernel/smp.c:251)
__secondary_switched (arch/arm64/kernel/head.S:418)

> +	 */
> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
> +}
> +
> +#endif
> +
>   static inline const struct cpumask *cpu_cpu_mask(int cpu)
>   {
>   	return cpumask_of_node(cpu_to_node(cpu));

