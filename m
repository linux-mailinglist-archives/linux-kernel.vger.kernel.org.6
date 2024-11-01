Return-Path: <linux-kernel+bounces-391654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EE9B89EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191031C20F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5CC14658D;
	Fri,  1 Nov 2024 03:18:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC071465AE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431129; cv=none; b=SXeZ6e31WptOmVDiJumezcfU2y/wOAZ6mdx9ChrpqFXiVEIYjg6L1gagT7akdfBkVfw5VGM+jPGnCXphUrly6nBlNVP/6IO9nXzqEoFpZcJ4FId4/6Svi5PjutMtNIR3tjH14H74PZJDCfYcwxo2eLMewy0io7Rmji5XEf8wSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431129; c=relaxed/simple;
	bh=VykksD7jTKJEG3JTp9qBLxc323IZvtnM7tTMAa2Ug/0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EgdfQqMlts8nhOoy+hASmEYwXS7XLUA/0y/fH1rXjtqBqQhHsHO3BA0w1WJudNlAEbIJY+KwfI1fnTgBsjLEEzliX0Bakp6Q25foCnFIq7GteQUpEI6KJmNwfUUtMrOy6oEN8w+scfIUYMw8U8Nhlpea9usCgpkAHmWYqR7nsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XfmGt1n6Xz10P7K;
	Fri,  1 Nov 2024 11:16:22 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BAE71402D0;
	Fri,  1 Nov 2024 11:18:35 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 11:18:34 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH v7 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Thomas Gleixner <tglx@linutronix.de>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <sudeep.holla@arm.com>, <peterz@infradead.org>,
	<mpe@ellerman.id.au>, <linux-arm-kernel@lists.infradead.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<pierre.gondois@arm.com>, <dietmar.eggemann@arm.com>
References: <20241030125415.18994-1-yangyicong@huawei.com>
 <20241030125415.18994-2-yangyicong@huawei.com> <87ttcty71m.ffs@tglx>
 <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com> <87frocwg64.ffs@tglx>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <5617934d-45ac-509a-510e-d96d52a2ebf9@huawei.com>
Date: Fri, 1 Nov 2024 11:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87frocwg64.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/10/31 21:33, Thomas Gleixner wrote:
> On Thu, Oct 31 2024 at 20:17, Yicong Yang wrote:
>> On 2024/10/30 22:55, Thomas Gleixner wrote:
>>>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>>>> +{
>>>> +	/*
>>>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
>>>> +	 * Architectures do have a special primary thread (e.g. x86) need
>>>> +	 * to override this function. Otherwise just make the first thread
>>>> +	 * in the SMT as the primary thread.
>>>> +	 */
>>>> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
>>>
>>> How is that supposed to work? Assume both siblings are offline, then the
>>> sibling mask is empty and you can't boot the CPU anymore.
>>>
>>
>> For architectures' using arch_topology, topology_sibling_cpumask() will at least
>> contain the tested CPU itself. This is initialized in
>> drivers/base/arch_topology.c:reset_cpu_topology(). So it won't be
>> empty here.
> 
> Fair enough. Can you please expand the comment and say:
> 
>      The sibling cpumask of a offline CPU contains always the CPU
>      itself.
> 

Sure, will make it clear.

>> Besides we don't need to check topology_is_primary_thread() at boot time:
>> -> cpu_up(cpu)
>>      cpu_bootable()
>>        if (cpu_smt_control == CPU_SMT_ENABLED &&
>>            cpu_smt_thread_allowed(cpu)) // will always return true if !CONFIG_SMT_NUM_THREADS_DYNAMIC
>>          return true; // we'll always return here and @cpu is always bootable
> 
> cpu_smt_control is not guaranteed to have CPU_SMT_ENABLED state, so this
> argument is bogus.
> 

sorry for didn't explain all the cases here.

For cpu_sm_control == {CPU_SMT_ENABLED, CPU_SMT_NOT_SUPPORTED, CPU_SMT_NOT_IMPLEMENTED},
all the cpu's bootable and we won't check topology_is_primary_thread().

static inline bool cpu_bootable(unsigned int cpu)
{
	if (cpu_smt_control == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
		return true;

	/* All CPUs are bootable if controls are not configured */
	if (cpu_smt_control == CPU_SMT_NOT_IMPLEMENTED)
		return true;

	/* All CPUs are bootable if CPU is not SMT capable */
	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
		return true;

	if (topology_is_primary_thread(cpu)) // Will be true for all the CPUs when thread sibling's not built
                                             // Only true for primary thread if thread sibling's updated
                                             // thread sibling will be updated once the CPU's bootup, for arm64
                                             // in secondary_start_kernel()
		return true;

	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask); // Also be updated once the CPU's bootup, in
                                                               // secondary_start_kernel() for arm64
                                                               // Will return false in the second check of
                                                               // cpu_bootable() in the call chain below
}

For cpu_smt_control == {CPUS_SMT_DISABLED, CPU_SMT_FORCE_DISABLED} if user specified the
boot option "nosmt" or "nosmt=force", it'll be a bit more complex. For a non-primary
thread CPU, cpu_bootable() will return true and it'll be boot. Then after thread sibling's
built cpu_bootable() will be checked secondly it the cpuhp callbacks, since it'll return
false then and we'll roll back and offline it.

// for a non-primary thread CPU, system boot with "nosmt" or "nosmt=force"
-> cpu_up()
     cpu_bootable() -> true, since the thread sibling mask only coutains CPU itself
     [...]
     cpuhp_bringup_ap()
       bringup_wait_for_ap_online()
         if (!cpu_bootable(cpu)) // target CPU has been bringup, thread sibling mask's updated
                                 // then this non-primay thread won't be bootable in this case
           return -ECANCELED // roll back and offline this CPU

Thanks.





