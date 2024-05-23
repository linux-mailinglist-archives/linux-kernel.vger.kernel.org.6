Return-Path: <linux-kernel+bounces-187855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20D18CD99C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E561F21947
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD457E766;
	Thu, 23 May 2024 18:04:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B57E572
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487469; cv=none; b=gFmp7BkcpeWdi4aRf3AQLFUtXsCT9mhvpNxnwM8dZfbUm0W0YZOrlP5UNfaRPFY4oaoDF4HPEzHcCyih96263zPjiNx6K4MQBXb4J1TNud/RWciwGlwn/fIs5kcB7BgN3KfErR6syvO97201h9Yk6lNOMKMpVSUOC76jzdJbue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487469; c=relaxed/simple;
	bh=VArtKFADycTBtUc2k1p191hfe6fEx4bvXMBA3xP4wgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiwrG9bvuZ81x99up1Rcdsaujrlzhb8N0n75qqqJtThbEcCp6+ODjG+dIXkGYfSAln/2fqXieW/UIWLtlnpEt+rLX8YmQE0f7C6NUoKpi9UB6Y4K7KKhaqA8vk7d/Z9kXUzz8XX9vVsLkeFcHh1qyDOhMSEe+YSPNv9H1VqKDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD37C339;
	Thu, 23 May 2024 11:04:49 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC3E3F762;
	Thu, 23 May 2024 11:04:22 -0700 (PDT)
Message-ID: <acefb432-6388-44ed-b444-1e52335c6c3d@arm.com>
Date: Thu, 23 May 2024 19:04:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-4-james.morse@arm.com>
 <e85e7786-7995-42d5-a5ac-1e08a84492fe@intel.com>
 <ZhleZ2q60ysIRapv@e133380.arm.com>
 <9daa5c12-c43d-4069-b2a6-c505217e2387@intel.com>
 <Zh6kRMkqVpu0Km4l@e133380.arm.com>
 <b2595743-c7dc-4946-884f-ff159bc4865e@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <b2595743-c7dc-4946-884f-ff159bc4865e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette, Dave,

On 18/04/2024 06:34, Reinette Chatre wrote:
> On 4/16/2024 9:16 AM, Dave Martin wrote:
>> On Mon, Apr 15, 2024 at 10:44:34AM -0700, Reinette Chatre wrote:
>>> On 4/12/2024 9:16 AM, Dave Martin wrote:
>>>> On Mon, Apr 08, 2024 at 08:14:47PM -0700, Reinette Chatre wrote:
>>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>
>>>>>> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
>>>>>> +{
>>>>>> +	if (res->fflags & RFTYPE_RES_CACHE)
>>>>>> +		return &parse_cbm;
>>>>>> +	else
>>>>>> +		return &parse_bw;
>>>>>> +}
>>>>>
>>>>> This is borderline ... at minimum it expands what fflags means and how it
>>>>> is intended to be used and that needs to be documented because it reads:
>>>>>
>>>>> 	* @fflags:		flags to choose base and info files

Hmm, true this is used to day to select which groups of files appear.


>>>>> I am curious why you picked fflags instead of an explicit check against
>>>>> rid?

Simply because it would need to match both L2 and L3 to parse_cbm, I didn't think that
would scale if other cache resources get added. However, with an enum of types we can get
the compiler to bark if an entry is needed here, which is probably good enough.

more background: {
	In the arm world the cache hierarchy isn't something we can reason about. We
	have funny names for where different things converge, (Point of Coherency,
	Point of Unification etc), but its up to the platform designer if/where the
	L2/L3 or even L9 live. The cache topology is fed to the kernel via an ACPI
	table.

	I anticipate a 'System Cache' resource and schema eventually being added to
	resctrl as it looks to be a popular hardware design. These system-cache live
	after the L3 (if there is one).
}


>>>> Is fflags already somewhat overloaded?  There seem to be a mix of things
>>>> that are independent Boolean flags, while other things seem mutually
>>>> exclusive or enum-like.
>>>>
>>>> Do we expect RFTYPE_RES_CACHE | RFTYPE_RES_MB ever to make sense,
>>>> as David points out?
>>>>
>>>>
>>>> With MPAM, we could in theory have cache population control and egress
>>>> memory bandwidth controls on a single interconnect component.
>>>>
>>>> If that would always be represented through resctrl as two components
>>>> with the MB controls considered one level out from the CACHE controls,
>>>> then I guess these control types remain mutually exclusive from
>>>> resctrl's point of view.
>>>>
>>>> Allowing a single rdt_resource to sprout multiple control types looks
>>>> more invasive in the code, even if it logically makes sense in terms of
>>>> the hardware.

MPAM allows this, but it doesn't fit with resctrl. The MPAM drivers resctrl glue code has
a load of stuff to present these as separate resources to resctrl, even if they are the
same piece of hardware underneath.

So far it looks possible to hide this, I don't think its worth changing resctrl's
behaviour to try and cover this.

RFTYPE_RES_CACHE and RFTYPE_RES_MB would remain mutually-exclusive.


>>>> Anyway, for this patch, there seem to be a couple of assumptions:
>>>>
>>>> a) get_parser() doesn't get called except for rdt_resources that
>>>> represent resource controls (so, fflags = RFTYPE_RES_foo for some "foo",
>>>> with no other flags set), and
>>>>
>>>> b) there are exactly two kinds of "foo", so whatever isn't a CACHE is
>>>> a BW.
>>>>
>>>> These assumptions seem to hold today (?)
>>>
>>> (c) the parser for user provided data is based on the resource type.
>>>
>>> As I understand (c) may not be true for MPAM that supports different
>>> partitioning controls for a single resource. For example, for a cache
>>> MPAM supports portion as well as maximum capacity controls that
>>> I expect would need different parsers (perhaps mapping to different
>>> schemata entries?) from user space but will be used to control the
>>> same resource.

Exactly - to maintain compatibility with existing software the driver has to present it as
a totally new thing. I guess it will look something like this:
| L3:0=0xffff;1=0xffff;
| L3_CAP:0=1048576;1=;1048576

Where existing software knows about 'L3', and should ignore 'L3_CAP'.


>>> I do now know if the goal is to support this MPAM capability via
>>> resctrl but do accomplish this I wonder if it may not be more appropriate
>>> to associate the parser with the schema entry that is presented to user space.

Even better.

For Tony's resctrl2 I had mused on exposing to user-space whether the controls were a
bitmap/percentage/MBps-value/raw-number. As there is a parser for the first two (or three)
today I think keying these from something in the schemata makes the most sense.


>>>> But the semantics of fflags already look a bit complicated, so I can
>>>> see why it might be best to avoid anything that may add more
>>>> complexity.
>>>
>>> ack.
>>>
>>>> If the main aim is to avoid silly copy-paste errors when coding up
>>>> resources for a new arch, would it make sense to go for a more low-
>>>> tech approach and just bundle up related fields in a macro?
>>>
>>> I understand this as more than avoiding copy-paste errors. I understand
>>> the goal is to prevent architectures from having architecture specific
>>> parsers.

[...]

>>> You do highlight another point though, shouldn't the fs code own the
>>> format_str also? I do not think we want arch code to control the
>>> print format, this is also something that should be consistent between
>>> all archs and owned by fs code, again perhaps more appropriate for
>>> a schema entry.

Good point ... I've still got that as a "TODO: kill these properties off as they are
derivatives" in the MPAM code.

I agree they should live together. We can also pull in data_width too, as it is calculated
based on the format used here.

Moving default_ctrl is tricky as on AMD platforms the {S,}MBA default value is discovered
from cpuid. But it only makes sense for an architecture to provides this for MBps controls
- bitmaps and percentages have an obvious maximum/default value. Putting that in  struct
resctrl_membw as 'max_bw' makes bw_validate()s use of it clearer.

bw_validate() has always caught me out as it doesn't just parse percentages, but AMDs MBps
values. I don't think this needs changing, but having MBps as a control type will make
this less surprising.

Finally, core.c will end up keeping default_ctrl as an arch-specific thing as its
convenient for the init and reset code.

[...]

> What I was thinking about was something like below that uses the
> enum you introduce later and lets the RF flags stay internal to fs code:
> 
> rdtgroup_create_info_dir()
> {
> 
> 	...
> 	list_for_each_entry(s, &resctrl_schema_all, list) {
> 		r = s->res;
> 		if (r->res_type == RRESTYPE_CACHE)
> 			fflags = RFTYPE_RES_CACHE;
> 		else if (r->res_type == RRESTYPE_MB)
> 			fflags = RFTYPE_RES_MB;
> 		else /* fail */
> 		
> 		fflags |= RFTYPE_CTRL_INFO;
> 
> 		...
> 	}
> 	/* same idea for monitor info files */

Good point, that would let us remove fflags from the arch code too.


> For this patch the resource type can be used to initialize the schema
> entry.
> 
>>
>>
>> /* In include/linux/resctrl_types.h */
>>
>> +#define RFTYPE_RES			BIT(8)
>> -#define RFTYPE_RES_CACHE		BIT(8)
>> -#define RFTYPE_RES_MB			BIT(9)
> 
> The goal is to not have to expose any of the RFTYPE flags internals to
> the architecture. RFTYPE_RES_CACHE and RFTYPE_RES_MB stays, but is
> not exposed to arch code. I do not see need for RFTYPE_RES.
> All the RFTYPE flags can be defined in fs/resctrl/internal.h

Yup, these should stay in internal.h - they got swept up as there are #defines either side
that are needed for MPAM to build.


>> /* For RFTYPE_RES: */
>> enum resctrl_resource_type {
>> 	RRESTYPE_INVALID,
>> 	RRESTYPE_MB,
>> 	RRESTYPE_CACHE,
>> };
> 
> (I find naming hard ... note the names changed from the beginning of
> pseudo code to here where RESTYPE changing to RRESTYPE)

Before I saw this my attempt has:
| enum resctrl_schema_fmt {
| 	RESCTRL_SCHEMA_BITMAP,
| 	RESCTRL_SCHEMA_PERCENTAGE,
| 	RESCTRL_SCHEMA_MBPS,
| };

Invalid as value '0' would catch the arch code missing this - but means any switch over
this enum has to handle it... I'd prefer to leave that out so the compiler can bark about
any place that needs updating when a new control scheme is added.



Thanks,

James

