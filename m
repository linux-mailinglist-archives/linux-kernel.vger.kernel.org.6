Return-Path: <linux-kernel+bounces-291558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF5956410
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0053F1F219AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976A15622E;
	Mon, 19 Aug 2024 07:03:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072F1B960
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051008; cv=none; b=uyFpL/YVYZORYnOMhGfO5D72JCzoSRO4YBi4HGEi/t/DKUQI1n20s2CorXeXkA5BxrgkNZO08NWEkXKIn/osReXccjLbSwNWqF36ORcxwHFWgE00sE1j2YncfvkqnoChVO+4Ar+Xtzhw0byaS0e5VBhyzclnZjeLRStOc7k/Zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051008; c=relaxed/simple;
	bh=bXw7ZVNbrwBZ9kAXKkPOwsWSAUlWc/BHoKi3IBojdrQ=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DYoadNZUjSJcp3ouhP+SFUGkwVTgBqE7kH0TgolX19zvVKSsTSAPrLdM0Gnh3l77h1FQx3jXmowA5vOq33BhnU3NFIDDI0xIsgzqauuUTlKIkB8ajTOZRWHUc+aCANxY/4lQ3KPurmoaG43Fm5/EYZHq3545C0+wwtvix87RtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnNnG5bhFzpTMS;
	Mon, 19 Aug 2024 15:01:54 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D883C180101;
	Mon, 19 Aug 2024 15:03:22 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 19 Aug 2024 15:03:21 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <yangyicong@hisilicon.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
 <ec8c46f2-d819-43d7-a866-d272169178d3@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <04ed0569-5026-9c4f-b09f-3e8798d5b551@huawei.com>
Date: Mon, 19 Aug 2024 15:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec8c46f2-d819-43d7-a866-d272169178d3@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/16 23:55, Dietmar Eggemann wrote:
> On 06/08/2024 10:53, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> For ACPI we'll build the topology from PPTT and we cannot directly
>> get the SMT number of each core. Instead using a temporary xarray
>> to record the SMT number of each core when building the topology
>> and we can know the largest SMT number in the system. Then we can
>> enable the support of SMT control.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  arch/arm64/kernel/topology.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 1a2c72f3e7f8..f72e1e55b05e 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -15,8 +15,10 @@
>>  #include <linux/arch_topology.h>
>>  #include <linux/cacheinfo.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/cpu_smt.h>
>>  #include <linux/init.h>
>>  #include <linux/percpu.h>
>> +#include <linux/xarray.h>
>>  
>>  #include <asm/cpu.h>
>>  #include <asm/cputype.h>
>> @@ -43,11 +45,16 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>>   */
>>  int __init parse_acpi_topology(void)
>>  {
>> +	int thread_num, max_smt_thread_num = 1;
>> +	struct xarray core_threads;
>>  	int cpu, topology_id;
>> +	void *entry;
>>  
>>  	if (acpi_disabled)
>>  		return 0;
>>  
>> +	xa_init(&core_threads);
>> +
>>  	for_each_possible_cpu(cpu) {
>>  		topology_id = find_acpi_cpu_topology(cpu, 0);
>>  		if (topology_id < 0)
>> @@ -57,6 +64,20 @@ int __init parse_acpi_topology(void)
>>  			cpu_topology[cpu].thread_id = topology_id;
>>  			topology_id = find_acpi_cpu_topology(cpu, 1);
>>  			cpu_topology[cpu].core_id   = topology_id;
>> +
>> +			entry = xa_load(&core_threads, topology_id);
>> +			if (!entry) {
>> +				xa_store(&core_threads, topology_id,
>> +					 xa_mk_value(1), GFP_KERNEL);
>> +			} else {
>> +				thread_num = xa_to_value(entry);
>> +				thread_num++;
>> +				xa_store(&core_threads, topology_id,
>> +					 xa_mk_value(thread_num), GFP_KERNEL);
>> +
>> +				if (thread_num > max_smt_thread_num)
>> +					max_smt_thread_num = thread_num;
>> +			}
> 
> So the xarray contains one element for each core_id with the information
> how often the core_id occurs? I assume you have to iterate over all
> possible CPUs since you don't know which logical CPUs belong to the same
> core_id.
> 

Each xarray element counts the thread number of a certain core id. so the logic is like below:
1. if the "core id" entry doesn't exists, then we're accessing this core for the 1st time. create
   one and make the thread number to 1
2. otherwise increment the thread number of "core id" this cpu belongs (PPTT already
   told us which core this CPU belongs to). Update the max_smt_thread_num if necessary.

Then we can know max_smt_thread_num by meanwhile iterating the PPTT table and
build the topology for all the possible CPUs.

Otherwise we need to do a second scan for the max thread number after built the
topology. This way is implemented in v1 and it's complained about the overhead on large
scale systems since we need to loop the CPUs twice.

>>  		} else {
>>  			cpu_topology[cpu].thread_id  = -1;
>>  			cpu_topology[cpu].core_id    = topology_id;
>> @@ -67,6 +88,9 @@ int __init parse_acpi_topology(void)
>>  		cpu_topology[cpu].package_id = topology_id;
>>  	}
>>  
>> +	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
>> +
>> +	xa_destroy(&core_threads);
>>  	return 0;
>>  }
>>  #endif
> 
> Tested on ThunderX2:
> 
> $ cat /proc/schedstat | head -6 | tail -4 | awk '{ print $1, $2 }'
> cpu0 0
> domain0 00000000,00000000,00000000,00000000,00000001,00000001,00000001,00000001
>                                                    ^        ^        ^        ^
> domain1 00000000,00000000,00000000,00000000,ffffffff,ffffffff,ffffffff,ffffffff
> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> 
> detecting 'max_smt_thread_num = 4' correctly.
> 

Thanks for the testing. ok for a tag?

Thanks.


