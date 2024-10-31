Return-Path: <linux-kernel+bounces-390474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B119B7A65
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EE21F243D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49819CC0B;
	Thu, 31 Oct 2024 12:18:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236219AD87
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377085; cv=none; b=NJhyGGlnAATS8Ae+PBD0iXfWyFpWHgHuqxsIQpChppqx8mufOKySzGr1zd6DBjbi+OC+Pn8Y9grggTYhq0mqvefdly6qGgTN70QK/9Xj8hEWa+wpas/N3jvx3YorFtEh6Vwl8zXRrCBOWsWiZG1ImbTe9yMutloOXLJ7bjWu3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377085; c=relaxed/simple;
	bh=vRd6y3hx9oLXXeVCTOCKqwMZVsJ9DWbSKPqNtqMUUQ8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uyCNJI0hqHxi10pMsWOb/ycsjtmrw+XsyvN57pSLF5AssnEIU10KwByFFMEyHzHJ+C+Rf/DzR7R28hMqwuF5tPWhXaX/rKQmVG+X6v504qUGtXS8nVsXaxzWAJ4f5ET6UjUfaSAelJuz+VuyS6coebB7+5I9eAJue5yBoxmbISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XfNHJ4SqXzdkPl;
	Thu, 31 Oct 2024 20:15:24 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id B2FC918009B;
	Thu, 31 Oct 2024 20:17:58 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 20:17:57 +0800
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
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com>
Date: Thu, 31 Oct 2024 20:17:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87ttcty71m.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/10/30 22:55, Thomas Gleixner wrote:
> On Wed, Oct 30 2024 at 20:54, Yicong Yang wrote:
>>  
>> +#ifndef topology_is_primary_thread
>> +#define topology_is_primary_thread topology_is_primary_thread
> 
> Please do not glue defines and functions together w/o a newline in between.
> 

sure, will add a newline here.

>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>> +{
>> +	/*
>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
>> +	 * Architectures do have a special primary thread (e.g. x86) need
>> +	 * to override this function. Otherwise just make the first thread
>> +	 * in the SMT as the primary thread.
>> +	 */
>> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
> 
> How is that supposed to work? Assume both siblings are offline, then the
> sibling mask is empty and you can't boot the CPU anymore.
> 

For architectures' using arch_topology, topology_sibling_cpumask() will at least
contain the tested CPU itself. This is initialized in
drivers/base/arch_topology.c:reset_cpu_topology(). So it won't be empty here.

Besides we don't need to check topology_is_primary_thread() at boot time:
-> cpu_up(cpu)
     cpu_bootable()
       if (cpu_smt_control == CPU_SMT_ENABLED &&
           cpu_smt_thread_allowed(cpu)) // will always return true if !CONFIG_SMT_NUM_THREADS_DYNAMIC
         return true; // we'll always return here and @cpu is always bootable

Also tested fine in practice.

Thanks.



