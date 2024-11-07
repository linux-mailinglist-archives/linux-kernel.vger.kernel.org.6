Return-Path: <linux-kernel+bounces-400383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393099C0CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9A31F2138C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF3215F7A;
	Thu,  7 Nov 2024 17:20:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C7212EF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000038; cv=none; b=Am/Smo2bw4X5gNs6G1OX9xsyveWmSffB6j6N8jTE+8ryM0Ff7Wz4pKnRwZTdh4NvfdlVyu7e1LYwYsCYZEK4eATKm8oUktt+6nH6r0MdcTDAxw2r2cSAYv4xEDr5Lz5+/t/HKJs+k2iwSEC101kfsUz26sMv5vkR+aWfoiGrxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000038; c=relaxed/simple;
	bh=Cd3G3aLNDIf8PVa/yj3oxoeHh/xIptXeGwqEHMSDC/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQbWyx7BZDtQQatGeazj7VWCEj4rmrWol/rzcW3e7nhGPNTzOvU2Nbf7J+lXPuYtiN4z15UPMaFlbTk+8QijyQFdcBrxNyFf8I7cc4fipeKLuw6EfY34DIULjHAkmu5BEKwY/n1cFtZ+8T8waJUFVSsGgT07BozAn10MsjB1zDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D0D1063;
	Thu,  7 Nov 2024 09:21:05 -0800 (PST)
Received: from [10.57.26.139] (unknown [10.57.26.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C7C13F6A8;
	Thu,  7 Nov 2024 09:20:30 -0800 (PST)
Message-ID: <a8a41066-e569-44c4-aa96-176d4788c7b6@arm.com>
Date: Thu, 7 Nov 2024 18:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Yicong Yang <yangyicong@huawei.com>, Thomas Gleixner
 <tglx@linutronix.de>, catalin.marinas@arm.com, will@kernel.org,
 sudeep.holla@arm.com, peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com
Cc: yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, xuwei5@huawei.com,
 guohanjun@huawei.com
References: <20241030125415.18994-1-yangyicong@huawei.com>
 <20241030125415.18994-2-yangyicong@huawei.com> <87ttcty71m.ffs@tglx>
 <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/24 13:17, Yicong Yang wrote:
> On 2024/10/30 22:55, Thomas Gleixner wrote:
>> On Wed, Oct 30 2024 at 20:54, Yicong Yang wrote:
>>>   
>>> +#ifndef topology_is_primary_thread
>>> +#define topology_is_primary_thread topology_is_primary_thread
>>
>> Please do not glue defines and functions together w/o a newline in between.
>>
> 
> sure, will add a newline here.
> 
>>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>>> +{
>>> +	/*
>>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
>>> +	 * Architectures do have a special primary thread (e.g. x86) need
>>> +	 * to override this function. Otherwise just make the first thread
>>> +	 * in the SMT as the primary thread.
>>> +	 */
>>> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
>>
>> How is that supposed to work? Assume both siblings are offline, then the
>> sibling mask is empty and you can't boot the CPU anymore.
>>
> 
> For architectures' using arch_topology, topology_sibling_cpumask() will at least
> contain the tested CPU itself. This is initialized in
> drivers/base/arch_topology.c:reset_cpu_topology(). So it won't be empty here.
> 
> Besides we don't need to check topology_is_primary_thread() at boot time:
> -> cpu_up(cpu)
>       cpu_bootable()
>         if (cpu_smt_control == CPU_SMT_ENABLED &&
>             cpu_smt_thread_allowed(cpu)) // will always return true if !CONFIG_SMT_NUM_THREADS_DYNAMIC
>           return true; // we'll always return here and @cpu is always bootable
> 
> Also tested fine in practice.
> 
> Thanks.
> 
> 

FWIW, I also tested the case where:
- setting maxcpus=1 in the kernel cmdline to have CPUs that never booted
- setting smt to off:
   'echo off > /sys/devices/system/cpu/smt/control'
and effectively the primary CPUs can boot and secondary CPUs can't,
so it works as expected.

