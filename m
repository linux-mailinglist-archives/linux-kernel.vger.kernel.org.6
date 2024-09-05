Return-Path: <linux-kernel+bounces-316640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D096D241
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016B31C24C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964FD194ACB;
	Thu,  5 Sep 2024 08:35:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D92194A49
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525310; cv=none; b=HrqWvwYWpH/Ni9Iw8L1luG25rhxubsaXJdtPELwKC+odF1u6Xga7l8Ne/kIukfylbcXGFuNWhsToCB2QzhGy/xcG3LQ6ukG85YuXP8RBksV0nlwI+0IkBHef5d5uOfLvU0IAo5qTL6Lp0EBVVaa0Me2wIdvHnEZLQSuELy5Pm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525310; c=relaxed/simple;
	bh=oCG1FQU0YWBlgb8qgRkyA1fvCArrt+AJpjmWVtsPmRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrbSEaLo/QMuLXDJ2Zu+gQfxiZlEfY1kbHom0IblU19Ao2k3ECPIeL8daYwc9wKWRvboBgF5fxsZAQqFOmUmxnb2H5GUD/pipK6b05LKHynkcqb3bfh+x1rOfWgjrd8Z4nb9GW7jTH1IRS0advQUO1ie+kk0UY9h9HwtJeqjF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3AD9FEC;
	Thu,  5 Sep 2024 01:35:33 -0700 (PDT)
Received: from [10.57.71.124] (unknown [10.57.71.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F703F66E;
	Thu,  5 Sep 2024 01:35:02 -0700 (PDT)
Message-ID: <277bd093-422b-4301-92a3-d0a58eb41af5@arm.com>
Date: Thu, 5 Sep 2024 10:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, bp@alien8.de,
 dave.hansen@linux.intel.com, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
 peterz@infradead.org, tglx@linutronix.de, sudeep.holla@arm.com,
 will@kernel.org, catalin.marinas@arm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, xuwei5@huawei.com,
 guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
 <a998c723-7451-439a-9c88-7c8b5c1b890b@arm.com>
 <00e6110a-462a-c117-0292-e88b57d27a05@huawei.com>
 <3947cb79-3199-4cd6-b784-51a245084581@arm.com>
 <1a7b5ac7-f040-672f-07a0-d7f3dc170c88@huawei.com>
 <6c05e39c-41f3-451c-b119-7b8662c1ceee@arm.com>
 <7f722af2-2969-aae5-1fb5-68d353eb95b9@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <7f722af2-2969-aae5-1fb5-68d353eb95b9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,

>>> Wondering if we can avoid this 2nd loop. Greg express the worries of looping twice on large scale
>>> system in v1. Maybe we could use the hetero_id and get the necessary information in one loop, I need
>>> further think.
>>
>> I found this comments (not sure this is what you are refering to):
>> - https://lore.kernel.org/linux-arm-kernel/20231011103303.00002d8f@Huawei.com/
>> - https://lore.kernel.org/all/20230921150333.c2zqigs3xxwcg4ln@bogus/T/#m406c4c16871ca7ae431beb20feccfb5e14498452
>>
>> I don't see another way to do it right now. Also, I thing the complexity is in
>> O(2n), which should be better than the original O(n**2),
>>
> 
> yes it's less complex. I'm wondering build up the xarray in another way then we can avoid the
> long loops. What about below:

I tried the patch on a ThunderX2 with 4 threads per CPU. PPTT topology describes
2 clusters of 128 cores each. Each cluster is described as independent (i.e. there
is no root node in the PPTT). The PPTT is of revision 1, so the IDENTICAL
flag is not available on the platform.

I also tried it on a faked SMT asymmetric platform and there might be a small
correction required.

> 
>  From 5ff5d0100435982764cd85566a6fe006e60ee98e Mon Sep 17 00:00:00 2001
> From: Yicong Yang <yangyicong@hisilicon.com>
> Date: Fri, 20 Oct 2023 15:38:38 +0800
> Subject: [PATCH] arm64: topology: Support SMT control on ACPI based system
> 
> For ACPI we'll build the topology from PPTT and we cannot directly
> get the SMT number of each core. Instead using a temporary xarray
> to record the heterogeneous information (from ACPI_PPTT_ACPI_IDENTICAL)
> and SMT information of the first core in its heterogeneous CPU cluster
> when building the topology. Then we can know the largest SMT number
> in the system. Warn if heterogeneous SMT topology exists (multiple
> heterogeneous CPU clusters with different SMT thread number) since the
> SMT control cannot handle this well. Then enable the support of SMT
> control.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/kernel/topology.c | 60 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..f6ec30fae70e 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -15,8 +15,10 @@
>   #include <linux/arch_topology.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpufreq.h>
> +#include <linux/cpu_smt.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
> +#include <linux/xarray.h>
> 
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -37,17 +39,29 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>   	return !!is_threaded;
>   }
> 
> +struct cpu_smt_info {
> +	int thread_num;
> +	int core_id;
> +	int cpu;
> +};
> +
>   /*
>    * Propagate the topology information of the processor_topology_node tree to the
>    * cpu_topology array.
>    */
>   int __init parse_acpi_topology(void)
>   {
> +	int max_smt_thread_num = 1;
> +	struct cpu_smt_info *entry;
> +	struct xarray hetero_cpu;
> +	unsigned long hetero_id;
>   	int cpu, topology_id;
> 
>   	if (acpi_disabled)
>   		return 0;
> 
> +	xa_init(&hetero_cpu);
> +
>   	for_each_possible_cpu(cpu) {
>   		topology_id = find_acpi_cpu_topology(cpu, 0);
>   		if (topology_id < 0)
> @@ -57,6 +71,30 @@ int __init parse_acpi_topology(void)
>   			cpu_topology[cpu].thread_id = topology_id;
>   			topology_id = find_acpi_cpu_topology(cpu, 1);
>   			cpu_topology[cpu].core_id   = topology_id;
> +
> +			/*
> +			 * Build up the XArray using the heterogeneous ID of
> +			 * the CPU cluster. Store the CPU and SMT information
> +			 * of the first appeared CPU in the CPU cluster of this
> +			 * heterogeneous ID since the SMT information should be
> +			 * the same in this CPU cluster. Then we can know the
> +			 * SMT information of each heterogeneous CPUs in the
> +			 * system.
> +			 */
> +			hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
> +			entry = (struct cpu_smt_info *)xa_load(&hetero_cpu, hetero_id);
> +			if (!entry) {
> +				entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +				WARN_ON(!entry);
> +
> +				entry->cpu = cpu;
> +				entry->core_id = topology_id;
> +				entry->thread_num = 1;
> +				xa_store(&hetero_cpu, hetero_id,
> +					 entry, GFP_KERNEL);
> +			} else if (entry->core_id == topology_id) {
> +				entry->thread_num++;
> +			}
>   		} else {
>   			cpu_topology[cpu].thread_id  = -1;
>   			cpu_topology[cpu].core_id    = topology_id;
> @@ -67,6 +105,28 @@ int __init parse_acpi_topology(void)
>   		cpu_topology[cpu].package_id = topology_id;
>   	}
> 
> +	/*
> +	 * This should be a short loop depending on the number of heterogeneous
> +	 * CPU clusters. Typically on a homogeneous system there's only one
> +	 * entry in the XArray.
> +	 */
> +	xa_for_each(&hetero_cpu, hetero_id, entry) {
> +		if (entry->thread_num == 1)
> +			continue;

If a platform has CPUs with:
- 1 thread
- X (!= 1) threads
Then I think that the asymmetry is not detected

> +
> +		if (entry->thread_num != max_smt_thread_num &&
> +		    max_smt_thread_num != 1)
> +			pr_warn("Heterogeneous SMT topology not handled");
> +
> +		if (entry->thread_num > max_smt_thread_num)
> +			max_smt_thread_num = entry->thread_num;
> +
> +		xa_erase(&hetero_cpu, hetero_id);
> +		kfree(entry);
> +	}
> +
> +	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +	xa_destroy(&hetero_cpu);
>   	return 0;
>   }
>   #endif

