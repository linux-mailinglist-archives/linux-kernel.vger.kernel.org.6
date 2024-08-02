Return-Path: <linux-kernel+bounces-272892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA6946260
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FCCB21D95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0215C12B;
	Fri,  2 Aug 2024 17:22:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6C1537AA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619378; cv=none; b=V718JBd8ukTY+g2vJinCS30JsqgdRX3yjoLRF51sdoa0BoADh1eFYKGuyiANmK9TIL5cUd6MnHkVFi1ebLLIIgLxJb++XAa2OggFVAmUZ2sy/dFB2TMKok41/uQdj33FLOfvh4Fiq1AH9r21GQOApW43av4vo3cFo8NqlnW2Ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619378; c=relaxed/simple;
	bh=kP2jdXigBGYHMl/tM45FgrB/PsAo4pfzUM40VJii90U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0kulYC5gSOPbpuWdvKcFQk9BB7IIQGaTBNRu2269vlzRcyHaUGmoqgTIx2tbyat0W7KzsYf7aKwGtl3mZ1p369+EUV5wA8JNnZkyDRbYWk+wfHdNipWYmnji3dGz+QtaBctSuUn5kkBgSjmb73t3NF7p1AuhG4hhaz9Uk/D+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F14DA7;
	Fri,  2 Aug 2024 10:23:21 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A6D3F64C;
	Fri,  2 Aug 2024 10:22:52 -0700 (PDT)
Message-ID: <17f72974-d824-487e-98b9-428d96cff0f6@arm.com>
Date: Fri, 2 Aug 2024 18:22:52 +0100
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
 <68cc21ed-71dd-4ac4-8af2-434f34988a51@arm.com>
 <f629e958-39c0-48cf-870f-8f76cfa7b815@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <f629e958-39c0-48cf-870f-8f76cfa7b815@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 01/07/2024 22:10, Reinette Chatre wrote:
> On 7/1/24 11:16 AM, James Morse wrote:
>> On 28/06/2024 17:48, Reinette Chatre wrote:
>>> On 6/14/24 8:00 AM, James Morse wrote:
>>>> The for_each_*_rdt_resource() helpers walk the architecture's array
>>>> of structures, using the resctrl visible part as an iterator. These
>>>> became over-complex when the structures were split into a
>>>> filesystem and architecture-specific struct. This approach avoided
>>>> the need to touch every call site.
>>>>
>>>> Once the filesystem parts of resctrl are moved to /fs/, both the
>>>> architecture's resource array, and the definition of those structures
>>>> is no longer accessible. To support resctrl, each architecture would
>>>> have to provide equally complex macros.
>>>>
>>>> Change the resctrl code that uses these to walk through the resource_level
>>>> enum and check the mon/alloc capable flags instead. Instances in core.c,
>>>> and resctrl_arch_reset_resources() remain part of x86's architecture
>>>> specific code.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>>> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>>> index aacf236dfe3b..ad20822bb64e 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>>> @@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>>>>         * First determine which cpus have pseudo-locked regions
>>>>         * associated with them.
>>>>         */
>>>> -    for_each_alloc_capable_rdt_resource(r) {
>>>> +    for (i = 0; i < RDT_NUM_RESOURCES; i++) {
>>>> +        r = resctrl_arch_get_resource(i);
>>>> +        if (!r->alloc_capable)
>>>> +            continue;
>>>> +
>>>
>>> This looks like enough duplicate boilerplate for a new macro. For simplicity the
>>> macro could require two arguments with enum resctrl_res_level also provided?
>>
>> I was hoping to escape from these clever macros! If you think this is too much:
>> - we'd need to come up with another name, as the arch code keeps the existing definition.
>> - to avoid touching every caller, it needs doing without an explicit iterator variable.
>>
>> I guess the cleanest thing is to redefine the existing macros to use
>> resctrl_arch_get_resource(). Putting this in include/linxu/resctrl.h at least avoids each
>> architecture needing to define these, or forcing it to use an array.
>>
>> The result is slightly more readable than the current version:
>> | #define for_each_rdt_resource(_r)                              \
>> |        for (_r = resctrl_arch_get_resource(0);                 \
>> |             _r->rid < RDT_NUM_RESOURCES;                       \
>> |             _r = resctrl_arch_get_resource(_r->rid + 1))
>>
>> This leans heavily on resctrl_arch_get_resource() not being able to return NULL, and
>> having to return a dummy resource that is neither alloc nor mon capable. We may need to
>> revisit that if it becomes a burden for the arch code.
> 
> Replacing the repetitive four lines of code with a single line seems good to me.

> resctrl_arch_get_resource() being able to return NULL is introduced in this series but
> I am not seeing any handling of a possible NULL value. Not being able to return NULL thus
> already seems a requirement?

It's currently implicit because until this point resctrl has just reached into the
rdt_resources_all[] array - and can never get a NULL pointer. Replacing that with a helper
needed to preserve the no-NULLs behaviour.
Changing this created too much churn so the resctrl idiom is to check
alloc_enabled/mon_enabled to see if the resource actually exists....

If we wanted to change this, that for_each_rdt_resource() would need an index variable as
_r could be NULL.


Thanks,

James

