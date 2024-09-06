Return-Path: <linux-kernel+bounces-319304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36896FA55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE672284B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83B1D4618;
	Fri,  6 Sep 2024 18:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E0EAE7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645993; cv=none; b=oAiLVgUkXtNEdBCvnQH34B7J3s3oiYhrxetzGIpGL+2BBCxGZ2Kafw2hzK61cv+IfV1qUqIPND1XLPwgGqdrwOjqwi/DQ+1J0HS0eeV3tK+WNV+4TJWKbrQZwVpn3aRM82aogdUduJqYL+LwFrwN75LEFfaDbxeH+E9UMy2NZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645993; c=relaxed/simple;
	bh=BzAJmfbS75UCPQvMJ217+J4hY32LBQlNf5i9BJ9k/KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X75SvgHiPbw/ORcUlNKXR3Mv8ML20wfgPU8Jj+UZZsoCRedEK6Afut+mYUWwC3yJyuQ3JVVViNdoH4UNzlhp/JUzDNiE8ox2+SlqpFUQXCj3Rhm/5vV11FtFAJMTKXAzkuIt+ocwWSVjHlAlThf2/ucOTE9gqee7FVQIJ9IhO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DFF6FEC;
	Fri,  6 Sep 2024 11:06:56 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A70B3F73F;
	Fri,  6 Sep 2024 11:06:26 -0700 (PDT)
Message-ID: <4a1da47f-655a-4ba1-9b68-baaad297dda9@arm.com>
Date: Fri, 6 Sep 2024 19:06:25 +0100
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
From: James Morse <james.morse@arm.com>
In-Reply-To: <5eea2e6a-f062-4ff4-9d11-87d8af0306dd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 14/08/2024 04:56, Reinette Chatre wrote:
> On 8/2/24 10:28 AM, James Morse wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 9ca542a8e2d4..57c88e1c2adf 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c

>> @@ -192,6 +191,18 @@ enum resctrl_scope {
>>       RESCTRL_L3_NODE,
>>   };
>>   +/**
>> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
>> + * @RESCTRL_SCHEMA_BITMAP:    The schema is a bitmap in hex.
>> + * @RESCTRL_SCHEMA_PERCENTAGE:    The schema is a decimal percentage value.
>> + * @RESCTRL_SCHEMA_MBPS:    The schema is a decimal MBps value.
>> + */
>> +enum resctrl_schema_fmt {
>> +    RESCTRL_SCHEMA_BITMAP,
>> +    RESCTRL_SCHEMA_PERCENTAGE,
>> +    RESCTRL_SCHEMA_MBPS,
>> +};
>> +
> 
> I believe that the choice of RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS has
> potential for significant confusion. The closest place to where user space can enter
> a MBps value (which is actually MiBps) is on Intel when resctrl is mounted with mba_MBps,
> and as per above it will have the "RESCTRL_SCHEMA_PERCENTAGE" format.

It was AMD's QOS that I was thinking of. To pick the example from the documentation:
| For example, to allocate 2GB/s limit on the first cache id:
|    MB:0=2048;1=2048;2=2048;3=2048

How does user-space know that its not a percentage? Suck it and see...
If those values aren't in MB/s ... I'm not sure what they are.


The schema format isn't exposed to user-space. (I think we should do that).
I agree if it were, we'd need to report MBps/MiBps for the mba_sc case.


> What is considered
> here as RESCTRL_SCHEMA_MBPS also cannot really be considered as "MBPS" since it is used to
> cover AMD's values that are "multiples of one eighth GB/s". Any new resource that
> _actually_ uses MBPS will thus not be able to use RESCTRL_SCHEMA_MBPS.

Isn't this already covered by the granularity?
AMD platforms are unfortunately reporting '1' as the granularity.
From the 1/8th GB/s it sounds like the granularity should really be 128 MB/s.

Any platform that did have a real MB/s control could report whatever granularity it really
has here.


> Considering that RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS use the same parser,
> could "RESCTRL_SCHEMA_RANGE" be more fitting? I acknowledge that it is very generic and
> better
> ideas are welcome. A "range" does seem to be appropriate considering the later patch
> (x86/resctrl:

> Add max_bw to struct resctrl_membw) that codes an explicit max.

Yes because the AMD platforms have a firmware-advertised maximum value, I presume that is
an achievable bandwidth. (otherwise why advertise it to user-space!).
(I'm not sure why data_width is 4 - it looks like that was the hard coded based on one
 platforms limit ... that probably needs fixing too)

But if you had a MBps control, I'm not sure that implies you know what the maximum
achievable bandwidth is. The control may have a range based on some power of two, which is
unrelated to the bandwidth.
In the arm world the hardware never knows what the achievable bandwidth is - that is
something only the SoC designer can work out.


I agree we can parse both values as a range, as resctrl doesn't need to interpret the
values, its just whatever the hardware does.

I did it like this as I'd like to expose "percentage/MBps/bitmap" to user-space so that
control types user-space doesn't recognised can be programmed. If arm64 and riscv each
want to add new schema types, it would be good to do it in a way that is low-impact for
the resctrl filesystem code, and unaware user-space can do something with.
percentage/MBps/bitmap are the control schemes we already have.

The MBps/range difference matters if the 'maximum bandwidth' isn't actually an achievable
number e.g. ~0, then user-space can't treat it as some kind of percentage.


Thanks,

James

