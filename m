Return-Path: <linux-kernel+bounces-541828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B28A4C221
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D2B3AAB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052EC212B2B;
	Mon,  3 Mar 2025 13:35:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CF53365
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008943; cv=none; b=MBPkEC4FKYqjqw7c5hf0BLHyTAqITDRkPpYIlW4QrWjDz5Zj3w9KySNchvAgJxXfC99jUE2WMtGeqzKhsIz3pkxEP8KBIb3O0yoBzazpvlASrK+Z2zpQko9Pxtk83m7av3wXya5176h3VY7wBND/GEtCl8nyU6VWBN/AvuVOJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008943; c=relaxed/simple;
	bh=LWGfbAM0Oi57epqG0HZfPt9wZvEQRA2SIjtygi0+lBk=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K02GvUrp7I9IgKNNfR//aqPCrhs+V/nyYaOIqfYqeOHk5y8zGjo2CyBlAEJvXYBkJX4tKY//9ZgH/ExSlVQuH5Rl+YBDHewYXSx+xSuyfXvEI7njtfKiea9ENMgvFqNpE5ksgFOp9P+4Nodls1UUbTHABsq5K7p28fSoNlrxop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z609V2G7zz9wF9;
	Mon,  3 Mar 2025 21:32:30 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A48E14037B;
	Mon,  3 Mar 2025 21:35:37 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 21:35:36 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <sudeep.holla@arm.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-2-yangyicong@huawei.com>
 <e3607ed0-bdf5-4fef-8731-b81fae649312@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <af8d364e-a5e0-decb-4463-fd6b7c54a0d9@huawei.com>
Date: Mon, 3 Mar 2025 21:35:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e3607ed0-bdf5-4fef-8731-b81fae649312@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/2/28 19:10, Dietmar Eggemann wrote:
> On 18/02/2025 15:10, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> [...]
> 
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
>> +	 * Architectures do have a special primary thread (e.g. x86) need
>> +	 * to override this function. Otherwise just make the first thread
>> +	 * in the SMT as the primary thread.
>> +	 *
>> +	 * The sibling cpumask of an offline CPU contains always the CPU
>> +	 * itself for architectures using CONFIG_GENERIC_ARCH_TOPOLOGY.
>> +	 * Other architectures should use this depend on their own
>> +	 * situation.
> 
> This sentence is hard to get. Do you want to say that other
> architectures (CONFIG_GENERIC_ARCH_TOPOLOGY or
> !CONFIG_GENERIC_ARCH_TOPOLOGY) have to check whether they can use this
> default implementation or have to override it?
> 

yes exactly, will improve the comments. thanks.


