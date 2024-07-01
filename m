Return-Path: <linux-kernel+bounces-236801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2791E746
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5D1C217A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480E16EB6E;
	Mon,  1 Jul 2024 18:16:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D72BB04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857777; cv=none; b=nZVI1zk/YcS4X5D+3xflz8liPTpL5ctgbC51a5TPfbFpyEnkq7NRI7kfs5/PVtF/7Z0RU8A9Xy4dPbna1S4lfqDj4V6ddXjiEx0Qk2UHnhbhamS8UwqtobXN3G7yF9cIamb4kyD7xw0drS4Yl/vNiCChOBQZf6udefkvKymy7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857777; c=relaxed/simple;
	bh=axkdCODL3Hth1+7z3voamns3fCaG+Sd7v8yxLePMS64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED3IA7ZmcNhzyM8h07frkvaxltKbOaQzp6aeUHn9a4ihu2QU50XSujQMd25b7roIOMLZaZ4w+bj48k6eORHIktbELWuQWYQG0s35gYD2esuLCxGNsG17UNd8HkuhDecelqH8YXOIG2EaPkLVhvZ7mxhX5ta1Izxo5AD8rVmnd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC11339;
	Mon,  1 Jul 2024 11:16:39 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9081C3F766;
	Mon,  1 Jul 2024 11:16:11 -0700 (PDT)
Message-ID: <68cc21ed-71dd-4ac4-8af2-434f34988a51@arm.com>
Date: Mon, 1 Jul 2024 19:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] x86/resctrl: Stop using the
 for_each_*_rdt_resource() walkers
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-18-james.morse@arm.com>
 <2b163af7-12d5-443d-a302-22d98c1facf1@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <2b163af7-12d5-443d-a302-22d98c1facf1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:48, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> The for_each_*_rdt_resource() helpers walk the architecture's array
>> of structures, using the resctrl visible part as an iterator. These
>> became over-complex when the structures were split into a
>> filesystem and architecture-specific struct. This approach avoided
>> the need to touch every call site.
>>
>> Once the filesystem parts of resctrl are moved to /fs/, both the
>> architecture's resource array, and the definition of those structures
>> is no longer accessible. To support resctrl, each architecture would
>> have to provide equally complex macros.
>>
>> Change the resctrl code that uses these to walk through the resource_level
>> enum and check the mon/alloc capable flags instead. Instances in core.c,
>> and resctrl_arch_reset_resources() remain part of x86's architecture
>> specific code.

>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> index aacf236dfe3b..ad20822bb64e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>> @@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>>        * First determine which cpus have pseudo-locked regions
>>        * associated with them.
>>        */
>> -    for_each_alloc_capable_rdt_resource(r) {
>> +    for (i = 0; i < RDT_NUM_RESOURCES; i++) {
>> +        r = resctrl_arch_get_resource(i);
>> +        if (!r->alloc_capable)
>> +            continue;
>> +
> 
> This looks like enough duplicate boilerplate for a new macro. For simplicity the
> macro could require two arguments with enum resctrl_res_level also provided?

I was hoping to escape from these clever macros! If you think this is too much:
- we'd need to come up with another name, as the arch code keeps the existing definition.
- to avoid touching every caller, it needs doing without an explicit iterator variable.

I guess the cleanest thing is to redefine the existing macros to use
resctrl_arch_get_resource(). Putting this in include/linxu/resctrl.h at least avoids each
architecture needing to define these, or forcing it to use an array.

The result is slightly more readable than the current version:
| #define for_each_rdt_resource(_r)                              \
|        for (_r = resctrl_arch_get_resource(0);                 \
|             _r->rid < RDT_NUM_RESOURCES;                       \
|             _r = resctrl_arch_get_resource(_r->rid + 1))

This leans heavily on resctrl_arch_get_resource() not being able to return NULL, and
having to return a dummy resource that is neither alloc nor mon capable. We may need to
revisit that if it becomes a burden for the arch code.


Thanks,

James

