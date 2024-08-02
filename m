Return-Path: <linux-kernel+bounces-272895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A7946264
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A520B21DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888F15C12C;
	Fri,  2 Aug 2024 17:24:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB21537A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619458; cv=none; b=qQX4Ge2391lCy214wfB9G2n/xDF03EofkMbiMvZBgQYfr0e/vpqfSBmYXrWjD0gRixI56yYR3qhucfhV/CIWyn/9b6HHDnvcYsogjE/PMNa05hc5cQfTprRe+QN4Ird/xiHZLQYXoz7XTg6AIPFYxwHbdN1u3Q4oyNxC1z6n4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619458; c=relaxed/simple;
	bh=H8txR3jjbUbidD/le7pIChXcbihmrAugfmXCT0nv9dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioSpMJ4nyWzclSWpMrgYzTXbNSAoIlQLFy+ZfqlWnB8fNcbXjFIj3UvpyKXw5RIhIVpkpKIzRCVGOx7DSvQbNqVR1dwnVZhIMxt7nOKNgK53qpZ2qFxhrIsHvjCUrsDSPtTDl2xZc5kvKKqDo4q49ih/NH9xYwPqlTQFurDxJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0708EDA7;
	Fri,  2 Aug 2024 10:24:41 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7ED83F64C;
	Fri,  2 Aug 2024 10:24:11 -0700 (PDT)
Message-ID: <8c3dd90d-475d-47e9-8691-a447d8042596@arm.com>
Date: Fri, 2 Aug 2024 18:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/38] x86/resctrl: Add a schema format enum and use
 this for fflags
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
 Dave Martin <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-4-james.morse@arm.com>
 <62581526-2dfa-44a5-a0bb-8582932b9943@intel.com>
 <d8e30c4f-04ef-4ed0-9d06-7f735c1c5e90@arm.com>
 <c79a1aae-6ab7-48d2-93fb-7b78198b5954@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <c79a1aae-6ab7-48d2-93fb-7b78198b5954@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 01/07/2024 22:09, Reinette Chatre wrote:
> On 7/1/24 11:17 AM, James Morse wrote:
>> On 28/06/2024 17:43, Reinette Chatre wrote:
>>> On 6/14/24 7:59 AM, James Morse wrote:
>>>> resctrl has three types of control, these emerge from the way the
>>>> architecture initialises a number of properties in struct rdt_resource.
>>>>
>>>> A group of these properties need to be set the same on all architectures,
>>>> it would be better to specify the format the schema entry should use, and
>>>> allow resctrl to generate all the other properties it needs. This avoids
>>>> architectures having divergant behaviour here.
>>>
>>> divergant -> divergent ?
>>>
>>>>
>>>> Add a schema format enum, and as a first use, replace the fflags member
>>>> of struct rdt_resource.
>>>>
>>>> The MBA schema has a different format between AMD and Intel systems.
>>>> The schema_fmt property is changed by __rdt_get_mem_config_amd() to
>>>> enable the MBPS format.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index e3edc41882dc..b12307d465bc 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -2162,6 +2162,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>>>        return ret;
>>>>    }
>>>>    +static u32 fflags_from_resource(struct rdt_resource *r)
>>>> +{
>>>> +    switch (r->schema_fmt) {
>>>> +    case RESCTRL_SCHEMA_BITMAP:
>>>> +        return RFTYPE_RES_CACHE;
>>>> +    case RESCTRL_SCHEMA_PERCENTAGE:
>>>> +    case RESCTRL_SCHEMA_MBPS:
>>>> +        return RFTYPE_RES_MB;
>>>> +    }
>>>> +
>>>> +    return WARN_ON_ONCE(1);
>>>> +}
>>>> +
>>>
>>> The fflags returned specifies which files will be associated with the resource
>>> in the "info" directory. Basing this on a property of the schema does not look
>>> right to me. I understand that many of the info files relate to, for example,
>>> information related to the bitmap used by the cache,
>>
>> Do we agree that some of them are?
>>
>> One reason for doing this is it decouples the parsing and management of bitmaps from "this
>> is the L3 cache", which will make it much easier to support bitmaps on some other kind of
>> resource.

> The way I see it is that it changes the meaning of the RFTYPE_RES_CACHE flag from "this is a
> file related to the cache resource" to "this is a file containing a bitmap property".
> It prevents us from easily adding a file related to the cache resource, which
> the info directory is intended to contain.

I struggled to find something that is a property of a "cache control", but is neither a
property of the control (e.g. bitmap size) or the cache. I guess the 'bit_usage' stuff is
the best example.

Maybe we end up with two sets of flags - this will be for the distant future. Currently I
taking your 'base fflags on resource id'.


>> Ultimately I'd like to expose these to user-space, so that user-space can work out how to
>> configure resources it doesn't recognise. Today '100' could be a percentage, a bitmap, or
>> a value in MB/s. Today some knowledge of the control type is needed to work this out.
>>
>>
>>> but that is not the same for
>>> info files related to the MBA resource (all info files related to MBA resource
>>> are not about the schema property format).
>>
>> Hmmm, because the files min_bandwidth and bandwidth_gran both have bandwidth in their name?
>>
>> I agree 'delay_linear' and 'thread_throttle_mode' are a bit strange.
> 
> Right. This is not a clean association.
> 
>>
>>
>>> I do not think the type of values of a schema should dictate which files
>>> appear in the info directory.
>>
>> Longer term I think this will be a problem. We probably only have 3 types of control:
>> percentage, bitmap and MB/s... but if each resource on each architecture adds files here
>> the list will quickly grow. User-space won't be able to work out how to configure a
>> resource type it hadn't seen before.
> 
> That is fair. This makes the type of control a property of the resource as is done in this
> series. Perhaps this can be exposed to user space via the info directory?

Yes, that is something I intend to look at. I eventually need to get MPAM's "cache
capacity" controls working as there are a number of hardware platforms that have it. This
would probably be a percentage control for 'L2' or 'L3', exposing an "info/schema_format"
file makes the most sense. I can't convert the existing bitmap as it implies isolation,
which this control format can't do, so it does need to be separate.
But! - to prevent confusing existing software, I don't think the L2/L3 should be touched -
those will forever have to be implicitly a bitmap, so anything in this area would have to
be an additional schema.


> Possibly the files related to control can have new flags that that reflect the control type
> instead of the resource. For example, "bit_usage" currently has
> "RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE" and that could be (for lack of better
> term) "RFTYPE_CTRL_INFO | RFTYPE_CTRL_BITMAP" to disconnect the control type from the
> resource. Doing so may then map nicely to the fflags_from_resource() in this patch that
> connects the schema format to the _control_ type flag. As we have found there is not
> a clear mapping between the control type and the resource type so I expect RFTYPE_RES_CACHE
> and RFTYPE_RES_MB to remain and be associated with files that contain information
> specific to that resource. This enables future additions of files containing cache specific
> (non-bitmap) properties to still be added (with RFTYPE_RES_CACHE flag) without impacting
> everything that uses a bitmap.
> 
> What do you think?

Makes sense!


Thanks,

James

