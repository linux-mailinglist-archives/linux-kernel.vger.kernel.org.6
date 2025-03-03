Return-Path: <linux-kernel+bounces-541947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FDBA4C3AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E77916E909
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C69213E62;
	Mon,  3 Mar 2025 14:42:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8C2139D2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012962; cv=none; b=JUrw6IqYELmKjEOBKmUulaH5hriAvc9SDEIKy0wrFy+B7diR5qGknGm6KK+tOE8xUWUBfzD8RKGxXSnCJS1+R607Z0YgBHQgvtI0gui9ixk8E4f2ypHF09HRXeSGLJa7zla5E7hacwMy6Chs03zbLmz2VROtPFRE/e/PxEGXHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012962; c=relaxed/simple;
	bh=f5hEZ5Vpy+rTyOoxKrjCP/8O20T2PKrNAaGBJMa8gag=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qG9s0c170PR804SJu7I7TwERG5VjXnPE2tLF6oCHER3vRLy6N1Y43sjCxJdT43BhgUa+qeBBDlyBAHnapnjDDe0P7/QWrvKeddpRDLReDFpNL9K32Npxq53KgXZwcWrbj4ygb6xZneTQvqnQDxnad76UD9xByvdlrPnLdHLKhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z61fM48jHzCs7q;
	Mon,  3 Mar 2025 22:39:07 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A0071401F0;
	Mon,  3 Mar 2025 22:42:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:42:35 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>, <yangyicong@hisilicon.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
To: Hanjun Guo <guohanjun@huawei.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-4-yangyicong@huawei.com>
 <92193a09-271e-895e-f77f-d3952bdfdf49@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <5f56d0fc-7ca8-cc52-9747-aec981e42bdc@huawei.com>
Date: Mon, 3 Mar 2025 22:42:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <92193a09-271e-895e-f77f-d3952bdfdf49@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/2/25 14:08, Hanjun Guo wrote:
> On 2025/2/18 22:10, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> For ACPI we'll build the topology from PPTT and we cannot directly
>> get the SMT number of each core. Instead using a temporary xarray
>> to record the heterogeneous information (from ACPI_PPTT_ACPI_IDENTICAL)
>> and SMT information of the first core in its heterogeneous CPU cluster
>> when building the topology. Then we can know the largest SMT number
>> in the system. If a homogeneous system's using ACPI 6.2 or later,
>> all the CPUs should be under the root node of PPTT. There'll be
>> only one entry in the xarray and all the CPUs in the system will
>> be assumed identical.
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
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   arch/arm64/kernel/topology.c | 66 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 1a2c72f3e7f8..6eba1ac091ee 100644
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
>> @@ -37,17 +39,28 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>>       return !!is_threaded;
>>   }
>>   +struct cpu_smt_info {
>> +    unsigned int thread_num;
>> +    int core_id;
>> +};
>> +
>>   /*
>>    * Propagate the topology information of the processor_topology_node tree to the
>>    * cpu_topology array.
>>    */
>>   int __init parse_acpi_topology(void)
>>   {
>> +    unsigned int max_smt_thread_num = 0;
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
>> @@ -57,6 +70,34 @@ int __init parse_acpi_topology(void)
>>               cpu_topology[cpu].thread_id = topology_id;
>>               topology_id = find_acpi_cpu_topology(cpu, 1);
>>               cpu_topology[cpu].core_id   = topology_id;
>> +
>> +            /*
>> +             * In the PPTT, CPUs below a node with the 'identical
>> +             * implementation' flag have the same number of threads.
>> +             * Count the number of threads for only one CPU (i.e.
>> +             * one core_id) among those with the same hetero_id.
>> +             * See the comment of find_acpi_cpu_topology_hetero_id()
>> +             * for more details.
>> +             *
>> +             * One entry is created for each node having:
>> +             * - the 'identical implementation' flag
>> +             * - its parent not having the flag
>> +             */
>> +            hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
>> +            entry = xa_load(&hetero_cpu, hetero_id);
>> +            if (!entry) {
>> +                entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +                WARN_ON_ONCE(!entry);
>> +
>> +                if (entry) {
>> +                    entry->core_id = topology_id;
>> +                    entry->thread_num = 1;
>> +                    xa_store(&hetero_cpu, hetero_id,
>> +                         entry, GFP_KERNEL);
>> +                }
>> +            } else if (entry->core_id == topology_id) {
>> +                entry->thread_num++;
>> +            }
>>           } else {
>>               cpu_topology[cpu].thread_id  = -1;
>>               cpu_topology[cpu].core_id    = topology_id;
>> @@ -67,6 +108,31 @@ int __init parse_acpi_topology(void)
>>           cpu_topology[cpu].package_id = topology_id;
>>       }
>>   +    /*
>> +     * This should be a short loop depending on the number of heterogeneous
>> +     * CPU clusters. Typically on a homogeneous system there's only one
>> +     * entry in the XArray.
>> +     */
>> +    xa_for_each(&hetero_cpu, hetero_id, entry) {
>> +        if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)
>> +            pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
>> +
>> +        max_smt_thread_num = max(max_smt_thread_num, entry->thread_num);
>> +        xa_erase(&hetero_cpu, hetero_id);
>> +        kfree(entry);
>> +    }
>> +
>> +    /*
>> +     * Notify the CPU framework of the SMT support. Initialize the
>> +     * max_smt_thread_num to 1 if no SMT support detected. A thread
>> +     * number of 1 can be handled by the framework so we don't need
>> +     * to check max_smt_thread_num to see we support SMT or not.
>> +     */
>> +    if (!max_smt_thread_num)
>> +        max_smt_thread_num = 1;
>> +
>> +    cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>> +    xa_destroy(&hetero_cpu);
>>       return 0;
>>   }
>>   #endif
> 
> Looks good to me,
> 
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> 

Thanks a lot for taking a look :)



