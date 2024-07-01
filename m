Return-Path: <linux-kernel+bounces-236804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668CD91E74B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1958628504B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1C16F0CB;
	Mon,  1 Jul 2024 18:17:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7B2BB04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857862; cv=none; b=H9/8cUB12i20oYQAkpZVTd/TH1gENDPDutUSRxDMeIlzH/+OnxCZMuhRsSylJKZCAvU3RiGKY5+5nhEnHDcRqwf2S5lpXnIyXe+8QLU1ZFL2/w6f6W9iG1nCs7WCuV2klokPqogSK7NYIWOzAjlR6YG8KDQVJ0Cn023Mx8m5IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857862; c=relaxed/simple;
	bh=xA8e05irHXqCsZ89TkSLCa0SpLIUZXyau1omiC9LLW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsC0qlgy+pUMjZ9U7+on7BrG7+4PYRrbn8F71fpsa9Kd5S9zgbwAReftdbomu3CSQh35glvwQmmtSVkIxs7juaD8nvospLreJOkBQI+S0czxMHG/r3X9rTAdiKua76HhseG4hjA3V8N8vVBXKrLOr3vFLefYfxpe1JojRqzzAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457F8367;
	Mon,  1 Jul 2024 11:18:05 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663093F766;
	Mon,  1 Jul 2024 11:17:37 -0700 (PDT)
Message-ID: <d8e30c4f-04ef-4ed0-9d06-7f735c1c5e90@arm.com>
Date: Mon, 1 Jul 2024 19:17:37 +0100
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
From: James Morse <james.morse@arm.com>
In-Reply-To: <62581526-2dfa-44a5-a0bb-8582932b9943@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:43, Reinette Chatre wrote:
> On 6/14/24 7:59 AM, James Morse wrote:
>> resctrl has three types of control, these emerge from the way the
>> architecture initialises a number of properties in struct rdt_resource.
>>
>> A group of these properties need to be set the same on all architectures,
>> it would be better to specify the format the schema entry should use, and
>> allow resctrl to generate all the other properties it needs. This avoids
>> architectures having divergant behaviour here.
> 
> divergant -> divergent ?
> 
>>
>> Add a schema format enum, and as a first use, replace the fflags member
>> of struct rdt_resource.
>>
>> The MBA schema has a different format between AMD and Intel systems.
>> The schema_fmt property is changed by __rdt_get_mem_config_amd() to
>> enable the MBPS format.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e3edc41882dc..b12307d465bc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2162,6 +2162,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>       return ret;
>>   }
>>   +static u32 fflags_from_resource(struct rdt_resource *r)
>> +{
>> +    switch (r->schema_fmt) {
>> +    case RESCTRL_SCHEMA_BITMAP:
>> +        return RFTYPE_RES_CACHE;
>> +    case RESCTRL_SCHEMA_PERCENTAGE:
>> +    case RESCTRL_SCHEMA_MBPS:
>> +        return RFTYPE_RES_MB;
>> +    }
>> +
>> +    return WARN_ON_ONCE(1);
>> +}
>> +
> 
> The fflags returned specifies which files will be associated with the resource
> in the "info" directory. Basing this on a property of the schema does not look
> right to me. I understand that many of the info files relate to, for example,
> information related to the bitmap used by the cache,

Do we agree that some of them are?

One reason for doing this is it decouples the parsing and management of bitmaps from "this
is the L3 cache", which will make it much easier to support bitmaps on some other kind of
resource.

Ultimately I'd like to expose these to user-space, so that user-space can work out how to
configure resources it doesn't recognise. Today '100' could be a percentage, a bitmap, or
a value in MB/s. Today some knowledge of the control type is needed to work this out.


> but that is not the same for
> info files related to the MBA resource (all info files related to MBA resource
> are not about the schema property format).

Hmmm, because the files min_bandwidth and bandwidth_gran both have bandwidth in their name?

I agree 'delay_linear' and 'thread_throttle_mode' are a bit strange.


> I do not think the type of values of a schema should dictate which files
> appear in the info directory.

Longer term I think this will be a problem. We probably only have 3 types of control:
percentage, bitmap and MB/s... but if each resource on each architecture adds files here
the list will quickly grow. User-space won't be able to work out how to configure a
resource type it hadn't seen before.

This may not be the time - but I think eventually resctrl shouldn't have to care about
what resources the architecture is presenting.
For these files, we may need to duplicate 'min_bandwidth' as 'min_percentage'. MBA would
have both, but any new controls using percentage wouldn't expose them.


> Doesn't MPAM support percentage for cache resources
> and bitmaps for memory resources?

It can have fixed-point-fractions and bitmaps for both caches and memory. Unfortunately
everything in MPAM is optional - the driver converts whatever it finds for memory
bandwidth to a percentage as that is what resctrl and user-space expect.
I can't do the same for cache controls as bitmaps implicitly isolate portions, something
that can't be done with the fractional control. So far everyone has built the bitmaps
because its the easiest implementation - but I have had requests to support the cache
fixed-point-fraction. Doing it as a percentage is least invasive to resctrl...


> Can the fflags rather depend on the resource type itself, by using the rid?

Sure.



Thanks,

James

>> @@ -2182,14 +2195,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>>       /* loop over enabled controls, these are all alloc_capable */
>>       list_for_each_entry(s, &resctrl_schema_all, list) {
>>           r = s->res;
>> -        fflags = r->fflags | RFTYPE_CTRL_INFO;
>> +        fflags =  fflags_from_resource(r) | RFTYPE_CTRL_INFO;
> 
> (please watch for extra spaces)
> 
>>           ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
>>           if (ret)
>>               goto out_destroy;
>>       }
>>         for_each_mon_capable_rdt_resource(r) {
>> -        fflags = r->fflags | RFTYPE_MON_INFO;
>> +        fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
> 
> (please watch for extra spaces)
> 
> Reinette


