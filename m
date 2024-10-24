Return-Path: <linux-kernel+bounces-380186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A859AE9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DAF1C25044
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB81E378A;
	Thu, 24 Oct 2024 15:10:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A141EC004
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782612; cv=none; b=p3BrsOJZrOagEbDXrAQzr/adjdlamUCxQsF7u5Gi9/DU596VMfBElrrZDo8uzsBuKM9IKQTPQkYWcBx2531u7EANPOyAuPd4Jui1OngzoLulqGXuW0JHOFL5gRSZwTI2Ueioxdz+waIboI3EQu7kFTpAfqVS/9LJ5UqbaZxQzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782612; c=relaxed/simple;
	bh=n1wQhgvqWk0aLZ5jmlmNCvHHTeItKR4Bhh5nTU/Lquw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=euXefcBSAbKKuvTHPYdsurv4GFTQYTtB/rH4Qy7IRabr1fNkJYPyDBHK1COId8Eu+4P/6i0XM+RK+P1S6Ca5dTui00wYvrFQKxUKPF1YDxjOgZw7bxcpA4oca18F9tXpAjMua4Di1uVbjhnvxNTqSibjEYKJfs+FAf7jluRpVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XZ8Rf1Mv4z10N2T;
	Thu, 24 Oct 2024 23:07:58 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id A77E51401E9;
	Thu, 24 Oct 2024 23:10:01 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 24 Oct 2024 23:10:00 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <dietmar.eggemann@arm.com>,
	<yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH v6 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Pierre Gondois <pierre.gondois@arm.com>
References: <20241015021841.35713-1-yangyicong@huawei.com>
 <20241015021841.35713-4-yangyicong@huawei.com>
 <896f9bb7-7053-4835-8db4-1ff063c268c1@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3181577e-d6dd-fd91-f51f-ae6ca0413687@huawei.com>
Date: Thu, 24 Oct 2024 23:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <896f9bb7-7053-4835-8db4-1ff063c268c1@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/10/24 16:44, Pierre Gondois wrote:
> Hello Yicong,
> 
> On 10/15/24 04:18, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> For ACPI we'll build the topology from PPTT and we cannot directly
>> get the SMT number of each core. Instead using a temporary xarray
>> to record the heterogeneous information (from ACPI_PPTT_ACPI_IDENTICAL)
>> and SMT information of the first core in its heterogeneous CPU cluster
>> when building the topology. Then we can know the largest SMT number
>> in the system.
> 
> Is it possible to also state that the logic only work for PPTT versions
> prior to 6.2. Otherwise find_acpi_cpu_topology_hetero_id() will return
> the id of the root node of the PPTT, and all the CPUs of the platform
> will be assumed to be identical.
> 

sure. of course.

>>
>> The core's SMT control provides two interface to the users [1]:
>> 1) enable/disable SMT by writing on/off
>> 2) enable/disable SMT by writing thread number 1/max_thread_number
>>
>> If a system have more than one SMT thread number the 2) may
>> not handle it well, since there're multiple thread numbers in the
>> system and 2) only accept 1/max_thread_number. So issue a warning
>> to notify the users if such system detected.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   arch/arm64/kernel/topology.c | 61 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 1a2c72f3e7f8..2fa584b932ee 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -15,8 +15,10 @@
>>   #include <linux/arch_topology.h>
>>   #include <linux/cacheinfo.h>
>>   #include <linux/cpufreq.h>
>> +#include <linux/cpu_smt.h>
>>   #include <linux/init.h>
>>   #include <linux/percpu.h>
>> +#include <linux/xarray.h>
>>     #include <asm/cpu.h>
>>   #include <asm/cputype.h>
>> @@ -37,17 +39,29 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>>       return !!is_threaded;
>>   }
>>   +struct cpu_smt_info {
>> +    int thread_num;
>> +    int core_id;
>> +    int cpu;
> 
> It doesn't seem that the 'cpu' is used. Maybe this should be removed,
> or used in the error message (I think this could be removed).
> 

sure. will remove..

>> +};
>> +
>>   /*
>>    * Propagate the topology information of the processor_topology_node tree to the
>>    * cpu_topology array.
>>    */
>>   int __init parse_acpi_topology(void)
>>   {
>> +    int max_smt_thread_num = 0;
>> +    struct cpu_smt_info *entry;
>> +    struct xarray hetero_cpu;
>> +    unsigned long hetero_id;
>>       int cpu, topology_id;
>>         if (acpi_disabled)
>>           return 0;
>>   +    xa_init(&hetero_cpu);
>> +
>>       for_each_possible_cpu(cpu) {
>>           topology_id = find_acpi_cpu_topology(cpu, 0);
>>           if (topology_id < 0)
>> @@ -57,6 +71,30 @@ int __init parse_acpi_topology(void)
>>               cpu_topology[cpu].thread_id = topology_id;
>>               topology_id = find_acpi_cpu_topology(cpu, 1);
>>               cpu_topology[cpu].core_id   = topology_id;
>> +
>> +            /*
>> +             * Build up the XArray using the heterogeneous ID of
>> +             * the CPU cluster. Store the CPU and SMT information
>> +             * of the first appeared CPU in the CPU cluster of this
>> +             * heterogeneous ID since the SMT information should be
>> +             * the same in this CPU cluster. Then we can know the
>> +             * SMT information of each heterogeneous CPUs in the
>> +             * system.
>> +             */
> 
> A suggestion just in case:
> /*
>  * In the PPTT, CPUs below a node with the 'identical
>  * implementation' flag have the same number of threads.
>  * Count the number of threads for only one CPU (i.e.
>  * one core_id) among those with the same hetero_id.
>  *
>  * One entry is created for each node having:
>  * - the 'identical implementation' flag
>  * - its parent not having the flag
>  */
> 

ok maybe we can also refer to the comments of find_acpi_cpu_topology_hetero_id() [1] to lead
reader there if they want more details.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c#n794

> 
>> +            hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
>> +            entry = (struct cpu_smt_info *)xa_load(&hetero_cpu, hetero_id);
>> +            if (!entry) {
>> +                entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +                WARN_ON(!entry);
>> +
>> +                entry->cpu = cpu;
>> +                entry->core_id = topology_id;
>> +                entry->thread_num = 1;
>> +                xa_store(&hetero_cpu, hetero_id,
>> +                     entry, GFP_KERNEL);
>> +            } else if (entry->core_id == topology_id) {
>> +                entry->thread_num++;
>> +            }
>>           } else {
>>               cpu_topology[cpu].thread_id  = -1;
>>               cpu_topology[cpu].core_id    = topology_id;
>> @@ -67,6 +105,29 @@ int __init parse_acpi_topology(void)
>>           cpu_topology[cpu].package_id = topology_id;
>>       }
>>   +    /*
>> +     * This should be a short loop depending on the number of heterogeneous
>> +     * CPU clusters. Typically on a homogeneous system there's only one
>> +     * entry in the XArray.
>> +     */
> 
> I think it should be ok to remove the above/below comments
> 

I'd leave the above comment since this won't make people who are awared of the efficiency feel
nervous about the loop here...

will drop the below comment.

>> +    xa_for_each(&hetero_cpu, hetero_id, entry) {
>> +        /*
>> +         * If max_smt_thread_num has been initialized and doesn't match
>> +         * the thread number of this entry, then the system has
>> +         * heterogeneous SMT topology.
>> +         */
>> +        if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)
>> +            pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
>> +
>> +        if (entry->thread_num > max_smt_thread_num)
>> +            max_smt_thread_num = entry->thread_num;
>> +
>> +        xa_erase(&hetero_cpu, hetero_id);
>> +        kfree(entry);
>> +    }
>> +
>> +    cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>> +    xa_destroy(&hetero_cpu);
>>       return 0;
>>   }
>>   #endif
> 
> Otherwise I tested the SMT detection and it worked well
> 

appreciated for the tests!

Thanks.




