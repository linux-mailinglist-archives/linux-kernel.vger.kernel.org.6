Return-Path: <linux-kernel+bounces-414282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913619D25B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2222E1F237C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26731C4A30;
	Tue, 19 Nov 2024 12:27:42 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29131157472
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019262; cv=none; b=DYOGWymI18XwsjSr+LRy8fdrrmyunBmkQ4psU2Uqrwp7nYKOyc2jsdtoO8p7gwf9x5yAGek3jWSDYq6Wc/RvvFDaum8lvpCJS/paMWfRYYTnqMwDYW+G9njLWWltIBJ/tGJ3vkb37qZibTiLE6GbnlLkqZHdpMqO+GZIcdfTjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019262; c=relaxed/simple;
	bh=Eoui92tEFrigEVkiHQgZxtCgAfr0zSH1EIFxFYxcFUI=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zm2gAjy5sC6+SFHb3xmyy4T3sgiHGBJZjevw2Oi8f0BJioMqWw6lkI6dDATnP8OPZCE15k2kQKB3Fxd1xCEzP0dCD5+zueBit+vcR9NoKZX6DmmxcRRFDncpsPmGlp9vnoE3N/WlLzfDVm7WaX5Zu1XdkRffHILSB81LRl74Ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xt3d26qkHz21kWm;
	Tue, 19 Nov 2024 20:26:14 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 17D7014010C;
	Tue, 19 Nov 2024 20:27:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 19 Nov 2024 20:27:35 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <mpe@ellerman.id.au>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <sudeep.holla@arm.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <linux-kernel@vger.kernel.org>,
	<morten.rasmussen@arm.com>, <msuchanek@suse.de>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Pierre Gondois
	<pierre.gondois@arm.com>
References: <20241114141127.23232-1-yangyicong@huawei.com>
 <20241114141127.23232-2-yangyicong@huawei.com>
 <427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com>
 <3876e185-2fcc-25dd-e70d-93fdcbf8fc37@huawei.com>
 <ab5d70ad-d4a4-4116-82c6-908b9e641ee6@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <6d732b89-d3d4-7bd6-d60e-e8bea05d05cf@huawei.com>
Date: Tue, 19 Nov 2024 20:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ab5d70ad-d4a4-4116-82c6-908b9e641ee6@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/11/18 23:04, Dietmar Eggemann wrote:
> On 18/11/2024 11:50, Yicong Yang wrote:
>> On 2024/11/15 17:42, Pierre Gondois wrote:
>>> Hello Yicong,
>>>
>>>
>>> On 11/14/24 15:11, Yicong Yang wrote:
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> [...]
> 
>>>>   diff --git a/include/linux/topology.h b/include/linux/topology.h
>>>> index 52f5850730b3..b8e860276518 100644
>>>> --- a/include/linux/topology.h
>>>> +++ b/include/linux/topology.h
>>>> @@ -240,6 +240,26 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>>>>   }
>>>>   #endif
>>>>   +#ifndef topology_is_primary_thread
>>>> +
>>>> +#define topology_is_primary_thread topology_is_primary_thread
>>>> +
>>>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>>>> +{
>>>> +    /*
>>>> +     * On SMT hotplug the primary thread of the SMT won't be disabled.
>>>> +     * Architectures do have a special primary thread (e.g. x86) need
>>>> +     * to override this function. Otherwise just make the first thread
>>>> +     * in the SMT as the primary thread.
>>>> +     *
>>>> +     * The sibling cpumask of an offline CPU contains always the CPU
>>>> +     * itself.
>>>
>>> As Thomas suggested, would it be possible to check it for other
>>> architectures ?
>>> For instance for loongarch at arch/loongarch/kernel/smp.c,
>>> clear_cpu_sibling_map() seems to completely clear &cpu_sibling_map[cpu]
>>> when a CPU is put offline. This would make topology_sibling_cpumask(cpu)
>>> to be empty and cpu_bootable() return false if the CPU never booted before.
>>>
>>
>> cpu_bootable() only affects architectures select HOTPLUG_SMT, otherwise it'll always
>> return true. Since x86 and powerpc have their own illustration of primary thread and
>> have an override version of this funciton, arm64 is the only user now by this patchset.
>> We have this guarantee for arm64 and also for other architectures using arch_topology.c
>> (see clear_cpu_topology()). So if loogarch has a different implementation, they
>> should implement a topology_is_primary_thread() variant to support HOTPLUG_SMT.
> 
> I also stumbled over this sentence.
> 
> drivers/base/arch_topology.c:
> 
> void clear_cpu_topology(int cpu)                   (2)
> 
>   ...
>   cpumask_set_cpu(cpu, &cpu_topo->thread_sibling)  (4)
> 
> void __init reset_cpu_topology(void)               (1)
> 
>   for_each_possible_cpu(cpu)
> 
>     ...
>     clear_cpu_topology(cpu)                        (2)
> 
> #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV) (3)
> void __init init_cpu_topology(void)
> 
>   reset_cpu_topology()                             (1)
>   ...
> 
> Does this mean the default implementation relies on (4), i.e. is only
> valid for arm64 and riscv? (3)
> Do all the other archs then have to overwrite the default implementation
>  (like x86 and powerpc) if they want to implement CONFIG_HOTPLUG_SMT?
> 

I think yes if they have problems with the default implementation. That's
what used to be to support HOTPLUG_SMT before this, each arthitecture
provides their own variant of topology_is_primary_thread.

The current approach may also work since cpu_bootable() will make all the
CPUs boot at least once:
static inline bool cpu_bootable(unsigned int cpu) {
[...]
	if (topology_is_primary_thread(cpu))
		return true;

	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask); // True if not booted
}

The boot process will be like below. cpu_bootable() is checked twice:
-> cpu_up()
     cpu_bootable() (1)
     [...]
     cpuhp_bringup_ap()
       [ archs usually update the sibling_mask in start_secondary() here ]
       bringup_wait_for_ap_online()
         if (!cpu_bootable(cpu)) (2)
           return -ECANCELED // roll back and offline this CPU

So an empty mask in (1) won't block the CPU going online. And the default
topology_is_primary_thread() should work if sibling mask updated before
the checking in (2). I hacked x86 to use the default topology_is_primary_thread
and tested on a qemu vm and it seems also work (just for test since the
primary thread should not always be the 1st thread in the core on x86,
not quite sure).

Thanks.



