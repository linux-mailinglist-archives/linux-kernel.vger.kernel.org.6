Return-Path: <linux-kernel+bounces-308444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E34965D08
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1215C1C23D50
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDD171650;
	Fri, 30 Aug 2024 09:35:12 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0477165F05
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010511; cv=none; b=YFd/UVNfe/N3pZQ4V9Q2blgErVa0IWQBb58c/Jqp0FeE+ABSP2P4/3e4hqTaxNBIthQ1hdJm8w3byAoZZxECxhPi8EtSdc+w8Wd0/ntyS2qRI2HmCksXLDtheKhB2suFT8r507vCIokT1EzvD0uUmD/JR+xb1+cnCZ8DJQKMv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010511; c=relaxed/simple;
	bh=cgAGbYJkQRnnj6pKzx/NtP8zycynWZsZTLPfq5n/XIg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nJJt7kMEB3jVIhtINglRZqsVyu6RmrUH2XceYSkiP0Y9R/txRHFt/M9YxGxv9jNlyJDa6WJJ12dR9kPgK95XTSxV0/pZ6A7F7Ye95UsvhE/RC5tVqwanFw9EB254E5FFbxqyNT3muX/8c3ZwysLEko3JLxVjVvA6IM2IpFOsgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WwCYL2qw7zQr52;
	Fri, 30 Aug 2024 17:30:14 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A826140360;
	Fri, 30 Aug 2024 17:35:06 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 30 Aug 2024 17:35:05 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <mpe@ellerman.id.au>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <sudeep.holla@arm.com>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Pierre Gondois <pierre.gondois@arm.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
 <a998c723-7451-439a-9c88-7c8b5c1b890b@arm.com>
 <00e6110a-462a-c117-0292-e88b57d27a05@huawei.com>
 <3947cb79-3199-4cd6-b784-51a245084581@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <1a7b5ac7-f040-672f-07a0-d7f3dc170c88@huawei.com>
Date: Fri, 30 Aug 2024 17:35:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3947cb79-3199-4cd6-b784-51a245084581@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/29 20:46, Pierre Gondois wrote:
> Hello Yicong,
> 
> On 8/29/24 09:40, Yicong Yang wrote:
>> Hi Pierre,
>>
>> On 2024/8/27 23:40, Pierre Gondois wrote:
>>> Hello Yicong,
>>> IIUC we are looking for the maximum number of threads a CPU can have
>>> in the platform. But is is actually possible to have a platform with
>>> CPUs not having the same number of threads ?
>>>
>>
>> I was thinking of the heterogenous platforms, for example part of the
>> cores have SMT and others don't (I don't have any though, but there
>> should be some such platforms for arm64).
>>
>>> For instance kernel/cpu.c::cpu_smt_num_threads_valid() will check
>>> that the number of threads is either 1 or cpu_smt_max_threads (as
>>> CONFIG_SMT_NUM_THREADS_DYNAMIC is not enabled for arm64). However
>>> a (hypothetical) platform with:
>>> - CPU0: 2 threads
>>> - CPU1: 4 threads
>>> should not be able to set the number of threads to 2, as
>>> 1 < 2 < cpu_smt_max_threads (cf. cpu_smt_num_threads_valid()).
>>>
>>
>> It's a bit more complex. If we enable/disable the SMT using on/off control
>> then we won't have this problem. We'll online all the CPUs on enabling and
>> offline CPUs which is not primary thread and don't care about the thread
>> number of each core.
>>
>> Control using thread number is introduced by CONFIG_SMT_NUM_THREADS_DYNAMIC
>> and only enabled on powerpc. I think this interface is not enough to handle
>> the hypothetical we assumed, since it assumes the homogenous platform that
>> all the CPUs have the same thread number. But this should be fine for
>> the platforms with SMT(with same thread number) and non-SMT cores, since it do
>> indicates the real thread number of the SMT cores.
>>
>>> So if there is an assumption that all the CPUs have the same number of
>>> threads, it should be sufficient to count the number of threads for one
>>> CPU right ?
>>>
>>
>> Naturally and conveniently I may think use of the threads number of CPU0 (boot
>> cpu) in such a solution. But this will be wrong if CPU0 is non-SMT on a heterogenous
>> platform :(
>>
>>> In the other (unlikely) case (i.e. CPUs can have various number of threads),
>>> I think we should either:
>>> - use your method and check that all the CPUs have the same number of threads
>>> - get the number of threads for one CPU and check that all the CPUs are
>>>     identical using the ACPI_PPTT_ACPI_IDENTICAL tag
>>
>> I think this won't be simpler since we still need to iterate all the CPUs to see
>> if they have the same hetero_id (checked how we're using this ACPI tag in
>> arm_acpi_register_pmu_device()). We could already know if they're identical by
>> comparing the thread number and do the update if necessary.
>>
>>> - have a per-cpu cpu_smt_max_threads value ?
>>
>> This should be unnecessary in currently stage if there's no platforms
>> with several kind cores have different thread number like in your assumption
>> and enable CONFIG_SMT_NUM_THREADS_DYNAMIC on such platforms. Otherwise using
>> a global cpu_smt_max_threads to enable the SMT control should be enough.
>> Does it make sense?
> 
> Yes, I agree with all the things you said:
> - the current smt/control interface cannot handle asymmetric SMT platforms
> - I am not aware if such platform exist so far
> 
> I think it would still be good to check all the CPUs have the same number of
> threads. I tried to enable the SMT_NUM_THREADS_DYNAMIC Kconfig with the
> patch attached (and to check CPUs have the same number of threads). Feel free
> to take what you like/ignore what is inside the attached patch, or let me know
> if I should submit a part in a separate patchset,
> 

Checked the changes, we can make this series as the basic support and a separate
series of yours as a further support of SMT control on arm64:
- support thread_id on ACPI based arm64 platform
- support partial SMT control by enable CONFIG_SMT_NUM_THREADS_DYNAMIC

some minor comments below.

> ----------------------------
> 
>     [RFC] arm64: topology: Enable CONFIG_SMT_NUM_THREADS_DYNAMIC
>         - On arm64 ACPI systems, change the thread_id assignment to have
>       increasing values starting from 0. This is already the case for DT
>       based systems. Doing so allows to uniformly identify the n-th
>       thread of a given CPU.
>     - Check that all CPUs have the same number of threads (for DT/ACPI)
>     - Enable CONFIG_SMT_NUM_THREADS_DYNAMIC
>         On a Tx2, with 256 CPUs, threads siblings being 0,32,64,96
>     for socket0 and 128 + (0,32,64,96) for socket1:
>     $ cd /sys/devices/system/cpu/smt/
>     $ cat ../online
>     0-255
>     $ echo 2 > control
>     $ cat ../online
>     0-63,128-191
>     $ echo 3 > control
>     $ cat ../online
>     0-95,128-223
>     $ echo on > control
>     $ cat ../online
>     0-255
> 

So it's a real SMT4 system, it does make sense to have this partial SMT control
support.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bd3bc2f5e0ec..1d8521483065 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -239,6 +239,7 @@ config ARM64
>         select HAVE_GENERIC_VDSO
>         select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>         select HOTPLUG_SMT if (SMP && HOTPLUG_CPU)
> +       select SMT_NUM_THREADS_DYNAMIC if HOTPLUG_SMT
>         select IRQ_DOMAIN
>         select IRQ_FORCED_THREADING
>         select KASAN_VMALLOC if KASAN
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 0f6ef432fb84..7dd211f81687 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -39,6 +39,14 @@ void update_freq_counters_refs(void);
>  #define arch_scale_hw_pressure topology_get_hw_pressure
>  #define arch_update_hw_pressure        topology_update_hw_pressure
>  
> +#ifdef CONFIG_SMT_NUM_THREADS_DYNAMIC
> +#include <linux/cpu_smt.h>
> +static inline bool topology_smt_thread_allowed(unsigned int cpu)
> +{
> +       return topology_thread_id(cpu) < cpu_smt_num_threads;
> +}
> +#endif
> +
>  #include <asm-generic/topology.h>
>  
>  #endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index f72e1e55b05e..a83babe19972 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -47,7 +47,9 @@ int __init parse_acpi_topology(void)
>  {
>         int thread_num, max_smt_thread_num = 1;
>         struct xarray core_threads;
> +       bool have_thread = false;
>         int cpu, topology_id;
> +       unsigned long i;
>         void *entry;
>  
>         if (acpi_disabled)
> @@ -61,6 +63,8 @@ int __init parse_acpi_topology(void)
>                         return topology_id;
>  
>                 if (acpi_cpu_is_threaded(cpu)) {
> +                       have_thread = true;
> +
>                         cpu_topology[cpu].thread_id = topology_id;
>                         topology_id = find_acpi_cpu_topology(cpu, 1);
>                         cpu_topology[cpu].core_id   = topology_id;
> @@ -69,9 +73,10 @@ int __init parse_acpi_topology(void)
>                         if (!entry) {
>                                 xa_store(&core_threads, topology_id,
>                                          xa_mk_value(1), GFP_KERNEL);
> +                               cpu_topology[cpu].thread_id = 0;
>                         } else {
>                                 thread_num = xa_to_value(entry);
> -                               thread_num++;
> +                               cpu_topology[cpu].thread_id = thread_num++;
>                                 xa_store(&core_threads, topology_id,
>                                          xa_mk_value(thread_num), GFP_KERNEL);
>  
> @@ -86,8 +91,17 @@ int __init parse_acpi_topology(void)
>                 cpu_topology[cpu].cluster_id = topology_id;
>                 topology_id = find_acpi_cpu_topology_package(cpu);
>                 cpu_topology[cpu].package_id = topology_id;
> +
> +               pr_debug("CPU%u: package=0x%x cluster=0x%x core=0x%x thread=0x%x\n",
> +                       cpu, cpu_topology[cpu].package_id, cpu_topology[cpu].cluster_id,
> +                       cpu_topology[cpu].core_id, cpu_topology[cpu].thread_id);
>         }
>  
> +       if (have_thread)

we could know this from max_smt_thread_num so have_thread maybe unnecessary.

> +               xa_for_each(&core_threads, i, entry)
> +                       if (xa_to_value(entry) != max_smt_thread_num)
> +                               pr_warn("Heterogeneous SMT topology not handled");\

Wondering if we can avoid this 2nd loop. Greg express the worries of looping twice on large scale
system in v1. Maybe we could use the hetero_id and get the necessary information in one loop, I need
further think.

Thanks.

> +
>         cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>  
>         xa_destroy(&core_threads);
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 95513abd664f..20d7f5b72ddd 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -532,13 +532,15 @@ static int __init get_cpu_for_node(struct device_node *node)
>         return cpu;
>  }
>  
> -static void __init update_smt_num_threads(unsigned int num_threads)
> +static void __init update_smt_num_threads(int num_threads)
>  {
> -       static unsigned int max_smt_thread_num = 1;
> +       static int max_smt_thread_num = -1;
>  
> -       if (num_threads > max_smt_thread_num) {
> +       if (max_smt_thread_num < 0) {
>                 max_smt_thread_num = num_threads;
>                 cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> +       } else if (num_threads != max_smt_thread_num) {
> +               pr_warn("Heterogeneous SMT topology not handled");
>         }
>  }
>  
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index b721f360d759..afdfdc64a0a1 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -87,6 +87,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>  #define topology_physical_package_id(cpu)      (cpu_topology[cpu].package_id)
>  #define topology_cluster_id(cpu)       (cpu_topology[cpu].cluster_id)
>  #define topology_core_id(cpu)          (cpu_topology[cpu].core_id)
> +#define topology_thread_id(cpu)                (cpu_topology[cpu].thread_id)
>  #define topology_core_cpumask(cpu)     (&cpu_topology[cpu].core_sibling)
>  #define topology_sibling_cpumask(cpu)  (&cpu_topology[cpu].thread_sibling)
>  #define topology_cluster_cpumask(cpu)  (&cpu_topology[cpu].cluster_sibling)
> 
> ----------------------------
> 
> 
> Regards,
> Pierre
> 
>>
>> Thanks,
>> Yicong
>>
>>>
>>> Same comment for the DT patch. If there is an assumption that all CPUs have
>>> the same number of threads, then update_smt_num_threads() could only be called
>>> once I suppose,
>>>
>>> Regards,
>>> Pierre
>>>
>>>
>>> On 8/6/24 10:53, Yicong Yang wrote:
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> For ACPI we'll build the topology from PPTT and we cannot directly
>>>> get the SMT number of each core. Instead using a temporary xarray
>>>> to record the SMT number of each core when building the topology
>>>> and we can know the largest SMT number in the system. Then we can
>>>> enable the support of SMT control.
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>>    arch/arm64/kernel/topology.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>>> index 1a2c72f3e7f8..f72e1e55b05e 100644
>>>> --- a/arch/arm64/kernel/topology.c
>>>> +++ b/arch/arm64/kernel/topology.c
>>>> @@ -15,8 +15,10 @@
>>>>    #include <linux/arch_topology.h>
>>>>    #include <linux/cacheinfo.h>
>>>>    #include <linux/cpufreq.h>
>>>> +#include <linux/cpu_smt.h>
>>>>    #include <linux/init.h>
>>>>    #include <linux/percpu.h>
>>>> +#include <linux/xarray.h>
>>>>      #include <asm/cpu.h>
>>>>    #include <asm/cputype.h>
>>>> @@ -43,11 +45,16 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>>>>     */
>>>>    int __init parse_acpi_topology(void)
>>>>    {
>>>> +    int thread_num, max_smt_thread_num = 1;
>>>> +    struct xarray core_threads;
>>>>        int cpu, topology_id;
>>>> +    void *entry;
>>>>          if (acpi_disabled)
>>>>            return 0;
>>>>    +    xa_init(&core_threads);
>>>> +
>>>>        for_each_possible_cpu(cpu) {
>>>>            topology_id = find_acpi_cpu_topology(cpu, 0);
>>>>            if (topology_id < 0)
>>>> @@ -57,6 +64,20 @@ int __init parse_acpi_topology(void)
>>>>                cpu_topology[cpu].thread_id = topology_id;
>>>>                topology_id = find_acpi_cpu_topology(cpu, 1);
>>>>                cpu_topology[cpu].core_id   = topology_id;
>>>> +
>>>> +            entry = xa_load(&core_threads, topology_id);
>>>> +            if (!entry) {
>>>> +                xa_store(&core_threads, topology_id,
>>>> +                     xa_mk_value(1), GFP_KERNEL);
>>>> +            } else {
>>>> +                thread_num = xa_to_value(entry);
>>>> +                thread_num++;
>>>> +                xa_store(&core_threads, topology_id,
>>>> +                     xa_mk_value(thread_num), GFP_KERNEL);
>>>> +
>>>> +                if (thread_num > max_smt_thread_num)
>>>> +                    max_smt_thread_num = thread_num;
>>>> +            }
>>>>            } else {
>>>>                cpu_topology[cpu].thread_id  = -1;
>>>>                cpu_topology[cpu].core_id    = topology_id;
>>>> @@ -67,6 +88,9 @@ int __init parse_acpi_topology(void)
>>>>            cpu_topology[cpu].package_id = topology_id;
>>>>        }
>>>>    +    cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>>>> +
>>>> +    xa_destroy(&core_threads);
>>>>        return 0;
>>>>    }
>>>>    #endif
>>>
>>> .

