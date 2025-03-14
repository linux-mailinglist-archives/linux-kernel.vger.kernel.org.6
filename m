Return-Path: <linux-kernel+bounces-561903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D61A61855
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D771899364
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382120459A;
	Fri, 14 Mar 2025 17:42:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BA204582
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974147; cv=none; b=CUPNyaab0ScyoO3z925G+cou40/AMBNF+y+bft2rXIPBZQA3feM6NEPMyfpilqT80Jn+9JDbCC4nVYxOcoCtWTgyT4osRLGeJnNSJv85Jqm0Lf56eJFH9osRbYgkCksqEzoaEQKx4kw9D7fqg634wECyvov6065inU6PjuOVmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974147; c=relaxed/simple;
	bh=DO4ObBTU4MJ4CqUcLrkahUs2weSN5R2EbdcWni1cF9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oedIbtB7Cp4WRNSlVaazJMq/6+y9Jmc5zHInMXP8GUq00LltbjnX5F9P3HgsyG50lAEbCjUB9y6mDXW4B5z8Rx08LEzkR1Tc6rtGDcREG6pWnyyRyf8lXhAUuawyjwhpZpZp/hkptxodoPsY4v2xI43I6Ea/J2HUe3+moWMLlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC301424;
	Fri, 14 Mar 2025 10:42:32 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96A93F673;
	Fri, 14 Mar 2025 10:42:18 -0700 (PDT)
Message-ID: <97aeaf87-b2db-4efb-9d81-43769c6f27b0@arm.com>
Date: Fri, 14 Mar 2025 17:42:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 45/49] x86,fs/resctrl: Move the resctrl filesystem code
 to live in /fs/resctrl
To: Fenghua Yu <fenghuay@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-46-james.morse@arm.com>
 <901c5cca-9a9b-4c45-b7bd-e7ce48c39282@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <901c5cca-9a9b-4c45-b7bd-e7ce48c39282@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 06/03/2025 20:35, Fenghua Yu wrote:
> On 2/28/25 11:59, James Morse wrote:
>> Resctrl is a filesystem interface to hardware that provides cache
>> allocation policy and bandwidth control for groups of tasks or CPUs.
>>
>> To support more than one architecture, resctrl needs to live in /fs/.
>>
>> Move the code that is concerned with the filesystem interface to
>> /fs/resctrl.

>>   14 files changed, 7535 insertions(+), 7285 deletions(-)

(this patch is large - please trim it in your reply!)

[...]


>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/
>> monitor_trace.h
>> index ade67daf42c2..b5a142dd0f0e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
>> @@ -7,2m5 +7,11 @@
>>     #include <linux/tracepoint.h>
>>   -TRACE_EVENT(mon_llc_occupancy_limbo,
>> -        TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
>> -        TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
>> -        TP_STRUCT__entry(__field(u32, ctrl_hw_id)
>> -                 __field(u32, mon_hw_id)
>> -                 __field(int, domain_id)
>> -                 __field(u64, llc_occupancy_bytes)),
>> -        TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
>> -               __entry->mon_hw_id = mon_hw_id;
>> -               __entry->domain_id = domain_id;
>> -               __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
>> -        TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
>> -              __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
>> -              __entry->llc_occupancy_bytes)
>> -       );
>> -
>>   #endif /* _FS_RESCTRL_MONITOR_TRACE_H */
>>     #undef TRACE_INCLUDE_PATH
>>   #define TRACE_INCLUDE_PATH .
>> +
>>   #define TRACE_INCLUDE_FILE monitor_trace
>> +
>>   #include <trace/define_trace.h>

> Similarly this file doesn't define any trace event. make W=1 complains it:
> 
>                 from arch/x86/kernel/cpu/resctrl/monitor.c:32:
> ./include/trace/stages/init.h:2:23: error: ‘str__resctrl__trace_system_name’ defined but
> not used [-Werror=unused-const-variable=]
>     2 | #define __app__(x, y) str__##x##y
>       |                       ^~~~~
> ./include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
>     3 | #define __app(x, y) __app__(x, y)
>       |                     ^~~~~~~
> ./include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
>     5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>       |                             ^~~~~
> ./include/trace/stages/init.h:8:27: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
>     8 |         static const char TRACE_SYSTEM_STRING[] =       \
>       |                           ^~~~~~~~~~~~~~~~~~~
> ./include/trace/stages/init.h:11:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
>    11 | TRACE_MAKE_SYSTEM_STR();
>       | ^~~~~~~~~~~~~~~~~~~~~
>   CC      fs/proc/consoles.o
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:207: arch/x86/kernel/cpu/resctrl/monitor.o] Error 1
> make[6]: *** Waiting for unfinished jobs....


> The above two compilation errors only happen when first 45 patches are applied. The whole
> patch set won't have the errors because patch 46 removes these empty trace events.
> 
> The fix is simple: just merge this patch and patch 46 together. Then there is no empty
> trace event in trace.h files and thus no compilation errors.

The intent is that these last few patches are merged together by the person that applies
them. I thought I'd described that in the cover-letter, but that text got lost.

It's like this because this patch is too large to review - but it is generated by a
script. If I merge these patches together, then its even harder to have confidence that
some hunk isn't getting reverted to an older version.


Thanks,

James

