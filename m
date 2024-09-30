Return-Path: <linux-kernel+bounces-344469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522698AA19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F91B269E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F430198848;
	Mon, 30 Sep 2024 16:42:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07688193078
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714563; cv=none; b=iz5pa0P1U6fmJTUZD6AwOoZnfjL3EDNqa+2OGIDRvYRxiz64gYnT200F0r9qks1o0tcB2EuXpIR/qzRIB5YnAX0gXCnqkdsnCV1Ff+Yld8kswZVlSaglUoE/jLbUN2/uTgV55cMbIUj+m83HGmd1ORnDXB7eZE0VmyOtQDb8so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714563; c=relaxed/simple;
	bh=uuIfrU0Nd7yh/I0/hTdWo5ExH8Vk9P1atUcZUssls1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHe9z/syt8EbZ4Jl/S0XXNGvmEH9emZ3Ybvu+JhpO7r/n6bvyoa5c800RsGS/DOUQ0idifclgiURg+h6eHJ/76yJV59J0sPrjtVQ0ig9LCJhGBEdmaF4b5vdaQiOHjZa3RoChOcneNXznmqZFMYrLcbjZzzcG+Gbd8Hy2Ug2QY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74D8FEC;
	Mon, 30 Sep 2024 09:43:10 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1A353F8C6;
	Mon, 30 Sep 2024 09:42:35 -0700 (PDT)
Message-ID: <696a9ad8-133a-430c-917e-16e0a9a39fee@arm.com>
Date: Mon, 30 Sep 2024 17:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/39] x86/resctrl: Use schema type to determine how to
 parse schema values
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
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-5-james.morse@arm.com>
 <5eea2e6a-f062-4ff4-9d11-87d8af0306dd@intel.com>
 <4a1da47f-655a-4ba1-9b68-baaad297dda9@arm.com>
 <6941deab-0bec-41e1-975b-274fc9d6b8e1@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <6941deab-0bec-41e1-975b-274fc9d6b8e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 16/09/2024 23:33, Reinette Chatre wrote:
> On 9/6/24 11:06 AM, James Morse wrote:
>> On 14/08/2024 04:56, Reinette Chatre wrote:
>>> On 8/2/24 10:28 AM, James Morse wrote:
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index 9ca542a8e2d4..57c88e1c2adf 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c

>>>> @@ -192,6 +191,18 @@ enum resctrl_scope {
>>>>        RESCTRL_L3_NODE,
>>>>    };
>>>>    +/**
>>>> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
>>>> + * @RESCTRL_SCHEMA_BITMAP:    The schema is a bitmap in hex.
>>>> + * @RESCTRL_SCHEMA_PERCENTAGE:    The schema is a decimal percentage value.
>>>> + * @RESCTRL_SCHEMA_MBPS:    The schema is a decimal MBps value.
>>>> + */
>>>> +enum resctrl_schema_fmt {
>>>> +    RESCTRL_SCHEMA_BITMAP,
>>>> +    RESCTRL_SCHEMA_PERCENTAGE,
>>>> +    RESCTRL_SCHEMA_MBPS,
>>>> +};
>>>> +
>>>
>>> I believe that the choice of RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS has
>>> potential for significant confusion. The closest place to where user space can enter
>>> a MBps value (which is actually MiBps) is on Intel when resctrl is mounted with mba_MBps,
>>> and as per above it will have the "RESCTRL_SCHEMA_PERCENTAGE" format.
>>
>> It was AMD's QOS that I was thinking of. To pick the example from the documentation:
>> | For example, to allocate 2GB/s limit on the first cache id:
>> |    MB:0=2048;1=2048;2=2048;3=2048
>>
>> How does user-space know that its not a percentage? Suck it and see...
>> If those values aren't in MB/s ... I'm not sure what they are.
> 
> I agree that this is an issue.
> 
>>
>>
>> The schema format isn't exposed to user-space. (I think we should do that).
>> I agree if it were, we'd need to report MBps/MiBps for the mba_sc case.
> 
> I agree that it would be ideal to expose the schema format to user space.
> 
>>> What is considered
>>> here as RESCTRL_SCHEMA_MBPS also cannot really be considered as "MBPS" since it is used to
>>> cover AMD's values that are "multiples of one eighth GB/s". Any new resource that
>>> _actually_ uses MBPS will thus not be able to use RESCTRL_SCHEMA_MBPS.
>>
>> Isn't this already covered by the granularity?
>> AMD platforms are unfortunately reporting '1' as the granularity.
>>  From the 1/8th GB/s it sounds like the granularity should really be 128 MB/s.
> 
> Unfortunately the existing interface makes consistent use of granularity (by user
> space) difficult.
> 
> As the doc highlights:
>     "bandwidth_gran":
>         ...
>         available bandwidth control steps are
>         min_bandwidth + N * bandwidth_gran.
> 
> 
> You are correct that setting AMD's granularity to 128 MB/s would make the expected
> bandwidth clear to user space. The problem is that the existing schemata displays to
> user space and expects from user space the value of "N" for MB on AMD while it
> displays to user space and expects from user space the value of "min_bandwidth + N *
> bandwidth_gran" from user space for MB on Intel.

Huh, I missed this in the datasheet:
(p21 of 56375_1_03_PUB.pdf)
| an absolute number expressed in 1/8 GB/s increments

I assumed the value was in MB/s but the precision of existing implementations was 128MB -
meaning they could change the precision without breaking user-space. Oh well.

Fixing this would also break user-space, so I guess this has to count in 'platform' units,
folk will need to know intimate details of their platform to configure this ...

As you suggest, its handled as a 'range' for now, and we can unpick this later.


>> Any platform that did have a real MB/s control could report whatever granularity it really
>> has here.
>>
>>
>>> Considering that RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS use the same parser,
>>> could "RESCTRL_SCHEMA_RANGE" be more fitting? I acknowledge that it is very generic and
>>> better
>>> ideas are welcome. A "range" does seem to be appropriate considering the later patch
>>> (x86/resctrl:
>>
>>> Add max_bw to struct resctrl_membw) that codes an explicit max.
>>
>> Yes because the AMD platforms have a firmware-advertised maximum value, I presume that is
>> an achievable bandwidth. (otherwise why advertise it to user-space!).
>> (I'm not sure why data_width is 4 - it looks like that was the hard coded based on one
>>   platforms limit ... that probably needs fixing too)
>>
>> But if you had a MBps control, I'm not sure that implies you know what the maximum
>> achievable bandwidth is. The control may have a range based on some power of two, which is
>> unrelated to the bandwidth.
> 
> I believe that is the current resctrl mechanism, with the huge caveat that the only
> implementation is actually software defined range limit.

True. MPAM doesn't have one - but does allow implementers to add their own scheme. Some of
this is to ensure resctrl doesn't have to know about this, but can also tell user-space
what the configurations mean.


>> In the arm world the hardware never knows what the achievable bandwidth is - that is
>> something only the SoC designer can work out.
>>
>>
>> I agree we can parse both values as a range, as resctrl doesn't need to interpret the
>> values, its just whatever the hardware does.
>>
>> I did it like this as I'd like to expose "percentage/MBps/bitmap" to user-space so that
>> control types user-space doesn't recognised can be programmed. If arm64 and riscv each
>> want to add new schema types, it would be good to do it in a way that is low-impact for
>> the resctrl filesystem code, and unaware user-space can do something with.
>> percentage/MBps/bitmap are the control schemes we already have.
> 
> Adding bitmap will need more thought, since resctrl does not support that today for
> MB there is some flexibility when adding support for it.

True, and architecture shouldn't specify this - and shouldn't expect it to work properly
if it does


>> The MBps/range difference matters if the 'maximum bandwidth' isn't actually an achievable
>> number e.g. ~0, then user-space can't treat it as some kind of percentage.
> 
> This last statement is not clear to me. It sounds as though you are considering the
> underlying implementation treating provided bandwidth as percentage as opposed to
> the interface itself being bandwidth or percentage? hmmm ... or are you referring to
> the software controller?

> I wonder if bandwidth and percentage can continue using the same interface as today
> by using bandwidth_gran as you hinted to ... but with the backward compatibility of
> needing to distinguish between schemata interface expecting the total or the steps.

My thinking was that the architecture should specify MBps or percentage to resctrl - even
if resctrl just treats these are numbers, because the difference matters to user-space.
If user-space doesn't know what an 'SLC' is - but it takes a percentage, then values that
add up to 100% is going to do something meaningful.
If the value is between 0 and ~0 as MBps - user-space needs to be smart enough to know
that numbers that add up to ~0 is unlikely to do what they want....


> I do not know what (if any) impact there will be if AMD's bandwidth_gran is
> changed to 128 MB/s.

I don't think we can do that without regressing existing user-space - the values written
into the schemata file would change their meaning.


Thanks,

James

