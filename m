Return-Path: <linux-kernel+bounces-413138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64059D1404
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA2D28345B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35881C07FC;
	Mon, 18 Nov 2024 15:05:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905851C07DC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942310; cv=none; b=Sjrdi7rjds1asAfqMGC5QLJ58bLLyZWF8nU7zTZrgVJiGDATOrMHCy2jud10Iq2cA5CczIhZqXZI0z26rtQlrSo/N7WtfJr5JBnKUG7LPDVcGYpkPK0CpY+3UD9K8g1iCsd7V2BJAvyTL6KSY56O2bZ4eaejrwWvAouOspQC/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942310; c=relaxed/simple;
	bh=Pw5tVrj09QQVD4OJ//x6WYKexk701huXAeOGX39PDCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlIPZuByjI260S5CjTpyn33zUo+OX7sJFG2IMCa7bkZCMJsEVOmRi9J9b4lxBwwGCJT6q0eGNTggcoaRWY2uvpCWnCD7PR1/+Gk/Ici2HySK+6r4Z7C/K7OPFWo7uafkIoRVNHxXaVIjxhxpHUOKSvT2zmkvWXt8shbFDAwhezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 685B611FB;
	Mon, 18 Nov 2024 07:05:36 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3183F5A1;
	Mon, 18 Nov 2024 07:05:01 -0800 (PST)
Message-ID: <ab5d70ad-d4a4-4116-82c6-908b9e641ee6@arm.com>
Date: Mon, 18 Nov 2024 16:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Yicong Yang <yangyicong@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 bp@alien8.de, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 mpe@ellerman.id.au, peterz@infradead.org, tglx@linutronix.de,
 sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, xuwei5@huawei.com,
 guohanjun@huawei.com, dave.hansen@linux.intel.com
References: <20241114141127.23232-1-yangyicong@huawei.com>
 <20241114141127.23232-2-yangyicong@huawei.com>
 <427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com>
 <3876e185-2fcc-25dd-e70d-93fdcbf8fc37@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <3876e185-2fcc-25dd-e70d-93fdcbf8fc37@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/11/2024 11:50, Yicong Yang wrote:
> On 2024/11/15 17:42, Pierre Gondois wrote:
>> Hello Yicong,
>>
>>
>> On 11/14/24 15:11, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

>>>   diff --git a/include/linux/topology.h b/include/linux/topology.h
>>> index 52f5850730b3..b8e860276518 100644
>>> --- a/include/linux/topology.h
>>> +++ b/include/linux/topology.h
>>> @@ -240,6 +240,26 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>>>   }
>>>   #endif
>>>   +#ifndef topology_is_primary_thread
>>> +
>>> +#define topology_is_primary_thread topology_is_primary_thread
>>> +
>>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>>> +{
>>> +    /*
>>> +     * On SMT hotplug the primary thread of the SMT won't be disabled.
>>> +     * Architectures do have a special primary thread (e.g. x86) need
>>> +     * to override this function. Otherwise just make the first thread
>>> +     * in the SMT as the primary thread.
>>> +     *
>>> +     * The sibling cpumask of an offline CPU contains always the CPU
>>> +     * itself.
>>
>> As Thomas suggested, would it be possible to check it for other
>> architectures ?
>> For instance for loongarch at arch/loongarch/kernel/smp.c,
>> clear_cpu_sibling_map() seems to completely clear &cpu_sibling_map[cpu]
>> when a CPU is put offline. This would make topology_sibling_cpumask(cpu)
>> to be empty and cpu_bootable() return false if the CPU never booted before.
>>
> 
> cpu_bootable() only affects architectures select HOTPLUG_SMT, otherwise it'll always
> return true. Since x86 and powerpc have their own illustration of primary thread and
> have an override version of this funciton, arm64 is the only user now by this patchset.
> We have this guarantee for arm64 and also for other architectures using arch_topology.c
> (see clear_cpu_topology()). So if loogarch has a different implementation, they
> should implement a topology_is_primary_thread() variant to support HOTPLUG_SMT.

I also stumbled over this sentence.

drivers/base/arch_topology.c:

void clear_cpu_topology(int cpu)                   (2)

  ...
  cpumask_set_cpu(cpu, &cpu_topo->thread_sibling)  (4)

void __init reset_cpu_topology(void)               (1)

  for_each_possible_cpu(cpu)

    ...
    clear_cpu_topology(cpu)                        (2)

#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV) (3)
void __init init_cpu_topology(void)

  reset_cpu_topology()                             (1)
  ...

Does this mean the default implementation relies on (4), i.e. is only
valid for arm64 and riscv? (3)
Do all the other archs then have to overwrite the default implementation
 (like x86 and powerpc) if they want to implement CONFIG_HOTPLUG_SMT?

[...]

