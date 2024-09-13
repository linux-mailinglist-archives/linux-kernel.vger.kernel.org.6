Return-Path: <linux-kernel+bounces-328700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49906978786
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010441F266C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA4126C08;
	Fri, 13 Sep 2024 18:08:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544016F31E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250885; cv=none; b=eaniB2fZEQ3q4LjfTyPRI/kZPdCIObCamwQLW6R8UPf/q+4DmCSGW2CHIyvhN9uT/UGpXc6IQhd6i+rnNfrz/ac4MalZtWZytEKlOlT+6idz+UXfCRYslDJ0ljWGtKIRign1QsU/6SYSpGT3tlyiEFeOsPsfrn5CtGNPmym40rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250885; c=relaxed/simple;
	bh=1HpmEuURAlQy4c8T2uGDtdRIDdNyH8rX3iK9jmwPysU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6+cKJYNZ+6tIGAbp1pCTYikoW1KJyUyphPG7o0Fy9uHEGwrZEWZr1L0qZGUdTJpYfnKvmR61Yse6Ppf3vEV/BYNzbMELDCT4UsFWqvS8uApfKlib88QexMX9TvBWtXmZdOX3YNNwT5OT5EIPVbgYdkBhjSylvaVH8rD1OlxIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF8313D5;
	Fri, 13 Sep 2024 11:08:32 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049643F64C;
	Fri, 13 Sep 2024 11:07:59 -0700 (PDT)
Message-ID: <c3c8bd5d-b527-4365-b4d6-3bc126a49f36@arm.com>
Date: Fri, 13 Sep 2024 19:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/39] x86/resctrl: Move data_width to be a schema
 property
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
 <20240802172853.22529-7-james.morse@arm.com>
 <44849590-d35f-4dcf-8744-a0472e6e9e3f@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <44849590-d35f-4dcf-8744-a0472e6e9e3f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 14/08/2024 04:59, Reinette Chatre wrote:
> On 8/2/24 10:28 AM, James Morse wrote:
>> The resctrl architecture code gets to specify the width of the schema
>> entries that are used by resctrl. These are determined by the schema
>> format, e.g. percentage or bitmap.
>>
>> Move this property into struct resctrl_schema and get the filesystem
>> parts of resctrl to set it based on the schema format. Remove
>> rdt_init_padding(), its work is be done by schemata_list_add(),
> 
> "its work is be done by" -> "its work is done by"
> 
>> allowing max_name_width and max_data_width to be moved out of core.c
>> which has no counterpart after the move to fs.
>>
>> The logic for calculating max_name_width was moved in earlier patches,
> 
> ("patches" in changelog can be a trigger, maybe "moved in earlier patches"
> -> "moved earlier"?)
> 
>> but the definition was not moved.


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1ce851447923..ed06384f9161 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -57,6 +57,12 @@ static struct kernfs_node *kn_mongrp;
>>   /* Kernel fs node for "mon_data" directory under root */
>>   static struct kernfs_node *kn_mondata;
>>   +/*
>> + * Used to store the max resource name width and max resource data width
>> + * to display the schemata in a tabular format.
>> + */
>> +int max_name_width, max_data_width;
>> +
>>   static struct seq_buf last_cmd_status;
>>   static char last_cmd_status_buf[512];
>>   @@ -2603,15 +2609,20 @@ static int schemata_list_add(struct rdt_resource *r, enum
>> resctrl_conf_type type
>>       switch (r->schema_fmt) {
>>       case RESCTRL_SCHEMA_BITMAP:
>>           s->fmt_str = "%d=%0*x";
>> +        s->data_width = (r->cache.cbm_len + 3) / 4;
>>           break;
>>       case RESCTRL_SCHEMA_PERCENTAGE:
>>           s->fmt_str = "%d=%0*u";
>> +        s->data_width = 3;
>>           break;
>>       case RESCTRL_SCHEMA_MBPS:
>>           s->fmt_str = "%d=%0*u";
>> +        s->data_width = 4;
>>           break;
>>       }
>>   +    max_data_width = max(max_data_width, s->data_width);
>> +
> 
> To me this emphasizes that RESCTRL_SCHEMA_PERCENTAGE and
> RESCTRL_SCHEMA_MBPS are not appropriate. Note how the minimum data width
> of RESCTRL_SCHEMA_MBPS is 4, this is unexpected from an actual MBps
> value. The choice of "4" is specific to AMD's input but that information
> is lost in this change.

It's preserving the current behaviour, as AMD is currently the only user.
I strongly suspect the value here is quite wrong, and what we should really do is call
snprintf() to tell us how long the string needs to be.


> We are fortunate that data_width is a minimum, allowing the software controller
> to be enabled with longer data values, but that is subtle and already
> breaks the goal of "making things tabular".

> I wonder how useful the data_width actually is. The "make things tabular"
> motivation seems to only apply to resources that have the exact same scope
> and as noted earlier seems to be broken already.

> I am skeptical that user space will be impacted if this is removed.

Makes sense. I think the only argument could be a parser written for a new kernel would be
surprised if it ran against an older kernel - and we might not care about that scenario.

I can't see how this would happen for the zero-padded values - you'd be going out of your
way to remove leading zeros before working with the field as a number.
It may be a problem for the names which have extra spaces. From what I can tell, an AMD
platform with SMBA must look like something like this:
| SMBA:0=2048
|   L3:0=00ff

I'll rip out the data_width - as fixing it, and making it a property resctrl determines
for itself is going to lead to boat over time for no benefit. I'll leave the name_width as
its marginally plausible a regex like "^L3" would misbehave with different kernel versions
on the same machine.


Thanks,

James

