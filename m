Return-Path: <linux-kernel+bounces-541834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF25A4C22A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB95F170E91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2D211A12;
	Mon,  3 Mar 2025 13:39:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EA212FAD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009144; cv=none; b=LWuCVxzqWOucoVk6HHdJZK6IDpXs8+KNeNQxmYL0RvR54FDIqL9DMJS29+Y0VaDIAfFR+PgffhitvQZj72fyvVHYesu5CiW1cs2myZaRzr3YG93aVVlG2cKJHL8QlzRn/m6i9xDookEMCoBCAnVixYrTp+SWiVTr9ypea4Z6xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009144; c=relaxed/simple;
	bh=Ci4/aSDOpvJg0F7ZQnSv3OCD5rXfkN+3nGg+X1Ri0Eg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pmMwFPN8tz+Gws/YG0DRgFpmEKPzV6lE4F0qfpb6P9rhWcVqboysyy2KqhUfcSWQ2S5rKVlHF/tkhRnLGUOyl1ZyiurQdEk/vnqgSo3Kji90U5n+mlxCYo9TLiHlttjP0l45Q0Qvo79WsTfRdeC44LhkzgK79AOUjQqFFHCtEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z60D32kYsz1ltbN;
	Mon,  3 Mar 2025 21:34:43 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E45D18001B;
	Mon,  3 Mar 2025 21:38:53 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 21:38:52 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Sudeep Holla <sudeep.holla@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-2-yangyicong@huawei.com> <Z8G__C7n4zwje2MW@bogus>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d93e890c-739e-bd1d-8b28-b83d96ec55c0@huawei.com>
Date: Mon, 3 Mar 2025 21:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8G__C7n4zwje2MW@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/2/28 21:54, Sudeep Holla wrote:
> On Tue, Feb 18, 2025 at 10:10:15PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently if architectures want to support HOTPLUG_SMT they need to
>> provide a topology_is_primary_thread() telling the framework which
>> thread in the SMT cannot offline. However arm64 doesn't have a
>> restriction on which thread in the SMT cannot offline, a simplest
>> choice is that just make 1st thread as the "primary" thread. So
>> just make this as the default implementation in the framework and
>> let architectures like x86 that have special primary thread to
>> override this function (which they've already done).
>>
>> There's no need to provide a stub function if !CONFIG_SMP or
>> !CONFIG_HOTPLUG_SMT. In such case the testing CPU is already
>> the 1st CPU in the SMT so it's always the primary thread.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>> Pre questioned in v9 [1] whether this works on architectures not using
>> CONFIG_GENERIC_ARCH_TOPOLOGY, See [2] for demonstration hacking on LoongArch
>> VM and this also works. Architectures should use this on their own situation.
>> [1] https://lore.kernel.org/linux-arm-kernel/427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com/
>> [2] https://lore.kernel.org/linux-arm-kernel/a5690fee-3019-f26c-8bad-1d95e388e877@huawei.com/
>>
>>  arch/powerpc/include/asm/topology.h |  1 +
>>  arch/x86/include/asm/topology.h     |  2 +-
>>  include/linux/topology.h            | 22 ++++++++++++++++++++++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 16bacfe8c7a2..da15b5efe807 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -152,6 +152,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>>  {
>>  	return cpu == cpu_first_thread_sibling(cpu);
>>  }
>> +#define topology_is_primary_thread topology_is_primary_thread
>>  
>>  static inline bool topology_smt_thread_allowed(unsigned int cpu)
>>  {
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>> index ec134b719144..6c79ee7c0957 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -229,11 +229,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>>  {
>>  	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
>>  }
>> +#define topology_is_primary_thread topology_is_primary_thread
>>  
>>  #else /* CONFIG_SMP */
>>  static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
>>  static inline int topology_max_smt_threads(void) { return 1; }
>> -static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
>>  static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
>>  #endif /* !CONFIG_SMP */
>>  
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index 52f5850730b3..b3aba443c4eb 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -240,6 +240,28 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>>  }
>>  #endif
>>  
>> +#ifndef topology_is_primary_thread
>> +
>> +#define topology_is_primary_thread topology_is_primary_thread
>> +
>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>> +{
>> +	/*
>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
> 
> I may be misunderstanding the term "SMT hotplug" above. For me it is
> comparable with logical CPU hotplug, so the above statement may be
> misleading. IIUC, what you mean above is if SMT is disabled, the
> primary thread will always remain enabled/active. Does that make sense
> or am I missing something ?
> 

I just the borrow the term from kconfig HOTPLUG_SMT here, but here the statement
only involves the disable part, so maybe it'll be more accurate to use "SMT
disable" rather than "SMT hotplug" here?

Thanks.


