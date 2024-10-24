Return-Path: <linux-kernel+bounces-379503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709609ADF66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB941C21628
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA61B0F12;
	Thu, 24 Oct 2024 08:44:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F21A76AC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759486; cv=none; b=c4FEIoyuB94SFDS8I7jWERUeMRmFCRxasWNthd77TDsesGpQSlvr5aEhlxxgGnmo4b4I2RNcFucmytLIG1QtJsrtwFXe//FPctrDdepo2KvF+k+VecaGgMYKGWdYC6iVRKfYE/+vBsAmgtDbg2yWrjsmjwvBsjUp6OKq6BF5rQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759486; c=relaxed/simple;
	bh=m7MC+6kon7SYcX1VbIFrhUl9sXjpUkyGbaWBugH/hP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz0WNIijaqkT/xnQ8OwwxEDYzaOivhChowM1HdDtbjcYAKMx1oh8zkpvxWHFstugIWURDl36Y16ywc0Oe6SgIgQR+ko0jc5oYtcP+7wamD6Rh/TbAa6vZ3cNsxOwMLAtAUS65pZwKQ7UeXuMq6I0+Pm/cLCyl6CFyMIv4upEzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83312339;
	Thu, 24 Oct 2024 01:45:11 -0700 (PDT)
Received: from [10.57.79.135] (unknown [10.57.79.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B9D3F73B;
	Thu, 24 Oct 2024 01:44:36 -0700 (PDT)
Message-ID: <896f9bb7-7053-4835-8db4-1ff063c268c1@arm.com>
Date: Thu, 24 Oct 2024 10:44:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com
References: <20241015021841.35713-1-yangyicong@huawei.com>
 <20241015021841.35713-4-yangyicong@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241015021841.35713-4-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,

On 10/15/24 04:18, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> For ACPI we'll build the topology from PPTT and we cannot directly
> get the SMT number of each core. Instead using a temporary xarray
> to record the heterogeneous information (from ACPI_PPTT_ACPI_IDENTICAL)
> and SMT information of the first core in its heterogeneous CPU cluster
> when building the topology. Then we can know the largest SMT number
> in the system.

Is it possible to also state that the logic only work for PPTT versions
prior to 6.2. Otherwise find_acpi_cpu_topology_hetero_id() will return
the id of the root node of the PPTT, and all the CPUs of the platform
will be assumed to be identical.

> 
> The core's SMT control provides two interface to the users [1]:
> 1) enable/disable SMT by writing on/off
> 2) enable/disable SMT by writing thread number 1/max_thread_number
> 
> If a system have more than one SMT thread number the 2) may
> not handle it well, since there're multiple thread numbers in the
> system and 2) only accept 1/max_thread_number. So issue a warning
> to notify the users if such system detected.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/kernel/topology.c | 61 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..2fa584b932ee 100644
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

It doesn't seem that the 'cpu' is used. Maybe this should be removed,
or used in the error message (I think this could be removed).

> +};
> +
>   /*
>    * Propagate the topology information of the processor_topology_node tree to the
>    * cpu_topology array.
>    */
>   int __init parse_acpi_topology(void)
>   {
> +	int max_smt_thread_num = 0;
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

A suggestion just in case:
/*
  * In the PPTT, CPUs below a node with the 'identical
  * implementation' flag have the same number of threads.
  * Count the number of threads for only one CPU (i.e.
  * one core_id) among those with the same hetero_id.
  *
  * One entry is created for each node having:
  * - the 'identical implementation' flag
  * - its parent not having the flag
  */


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
> @@ -67,6 +105,29 @@ int __init parse_acpi_topology(void)
>   		cpu_topology[cpu].package_id = topology_id;
>   	}
>   
> +	/*
> +	 * This should be a short loop depending on the number of heterogeneous
> +	 * CPU clusters. Typically on a homogeneous system there's only one
> +	 * entry in the XArray.
> +	 */

I think it should be ok to remove the above/below comments

> +	xa_for_each(&hetero_cpu, hetero_id, entry) {
> +		/*
> +		 * If max_smt_thread_num has been initialized and doesn't match
> +		 * the thread number of this entry, then the system has
> +		 * heterogeneous SMT topology.
> +		 */
> +		if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)
> +			pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
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

Otherwise I tested the SMT detection and it worked well

