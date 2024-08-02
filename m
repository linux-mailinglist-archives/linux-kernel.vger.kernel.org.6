Return-Path: <linux-kernel+bounces-272891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291B94625F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2900F1F21EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8215C128;
	Fri,  2 Aug 2024 17:22:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88771537A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619357; cv=none; b=LNwagjfIKOv5heSCOz4dqTqBbwj1Zy/xd8MDrwYA7GSXDEUUEsh8G0lz8/dA3GTTtnK32b4pSWwf4eZ5TPB08ztgZBxp5aADnxTm3yiwczApZotvh1zJ2Wnk1tH/LzpvTqMzAJ8JjvaumvksLkz/iJJT9d6F8BUF/CDttBwoHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619357; c=relaxed/simple;
	bh=taiWfWuuFYQpiIfZvOQkFnmOLnlL4KSF7mBsvJ7oTJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpE2Mx6XIUqwEeo+cG3xxQdjI28CtzTZf4TYpTD0yOzn3Q2BNgn3RGupw0NrNwGDGxlx+pOT2A7j5k8YE7mhvTfJLhCY0KZv+RdHevygUqmdCgqxO0YeS5MLZVCh6JHu+sQHoKq4c58IpXcQFi8o75urFFH3WhMGkmaQUWTozUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3CD31007;
	Fri,  2 Aug 2024 10:22:59 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B25A3F64C;
	Fri,  2 Aug 2024 10:22:30 -0700 (PDT)
Message-ID: <fd3005fc-4d8f-4e55-a325-7a8681d6ebe2@arm.com>
Date: Fri, 2 Aug 2024 18:22:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/38] x86/resctrl: Allow an architecture to disable
 pseudo lock
Content-Language: en-GB
To: Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-24-james.morse@arm.com>
 <87frsfd362.fsf@rasp.cworth.amperemail.amperecomputing.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <87frsfd362.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carl,

On 11/07/2024 22:33, Carl Worth wrote:
> James Morse <james.morse@arm.com> writes:
>> diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
>> index 4a06c37b9cf1..0c13b0befd8a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/Makefile
>> +++ b/arch/x86/kernel/cpu/resctrl/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
>> -obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
>> +obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
>> +obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
>> +obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
>>  CFLAGS_pseudo_lock.o = -I$(src)
> 
> Now that pseudo_lock.c is only conditionally compiled, the work it's
> doing to define tracepoints, (that is, #define CREATE_TRACE_POINTS),
> should be moved to monitor.c which is unconditionally compiled.
> 
> And then, the CFLAGS line above should be adjusted to apply to
> the compilation of monitor.c, that is:
> 
> CFLAGS_monitor.o = -I$(src)

> Without these changes, compiling without CONFIG_RESCTRL_FS_PSEUDO_LOCK
> will fail due to undefined tracepoint functions.

Thanks for catching this - I bashed my head against it for a while.

I've split trace.h in two: monitor_trace.h and pseudo_lock_trace.h. When the code gets
moved to /fs/ only one of those files moves.


Thanks,

James

