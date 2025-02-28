Return-Path: <linux-kernel+bounces-539331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC2A4A34C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A2F7AA09D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A078274275;
	Fri, 28 Feb 2025 19:57:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21726E140
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772665; cv=none; b=qd1KNNY+QGxx9Midi9JVOyf7RlOYtHQ9k4+RT8lSbOsU3rwGIV1xsXL79F51WIl7C1BfmoSGViIGzDbLDSOfGNX++Uhd+DqIcJcF/S6a79zn1Ahbpc5xqcWgiiCyMIiK9TYGba97Tk2w3q6W3PRlVGltoa4+4dIimZS/GVGK/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772665; c=relaxed/simple;
	bh=M3Geb5rqxlv3C2sUQe/HlxCDuxcdfeIoByMychjQPJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpCn4TUdcdfQmuN0WMgrkqqgqLEBuhwXz+Dpf02sfKUfuNtcUs8hU4uyywHBG6rbTEwYpos7nXKr7UaHri2kadHKST7zx9qgZR2Se78Bf0lnZYyamgQdZf1M6y9RtL3ZGpD92SDe3gVDO7k3iqtaWpulO8Pg5llBU3b9AHh3oCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AE3B1515;
	Fri, 28 Feb 2025 11:57:58 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0CF3F5A1;
	Fri, 28 Feb 2025 11:57:35 -0800 (PST)
Message-ID: <9d4bc823-28d2-4ab4-a573-894109b51845@arm.com>
Date: Fri, 28 Feb 2025 19:57:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
 <baa225e6-65bd-49ec-baf9-166ae4f2926c@intel.com>
 <545e4e79-e309-4bda-9a70-204d83749308@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <545e4e79-e309-4bda-9a70-204d83749308@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 25/02/2025 16:16, Reinette Chatre wrote:
> On 2/19/25 10:10 PM, Reinette Chatre wrote:
>> On 2/7/25 10:18 AM, James Morse wrote:
>>> To support more than one architecture resctrl needs to move from arch/x86
>>> to live under fs. Moving all the code breaks any series on the mailing
>>> list, so needs scheduling carefully.
>>>
>>> Maintaining the patch that moves all this code has proved labour intensive.
>>> It's also near-impossible to review that no inadvertent changes have
>>> crept in.
>>>
>>> To solve these problems, temporarily add a hacky python program that
>>> lists all the functions that should move, and those that should stay.
>>>
>>> No attempt to parse C code is made, this thing tries to name 'blocks'
>>> based on hueristics about the kernel coding style. It's fragile, but
>>
>> (heuristics)
>>
>>> good enough for its single use here.
>>>
>>> This only exists to show I have nothing up my sleeve.
>>> I don't suggested this gets merged.
>>>
>>> The patch this script generaets has the following corner cases:
>> (generates)
>>
>>> * The original files are regenerated, which will add newlines that are
>>>   not present in the original file.
>>> * An trace-point header file the only contains boiler-plate is created
>>>   in the arch and filesystem code. The parser doesn't know how to remove
>>>   the includes for these - but its easy to 'keep' the file contents on
>>>   the correct side. A follow-up patch will remove these files and their
>>>   includes.
>>
>> Related to the tracepoints I also noticed that there are some leftover
>> tracing defines in files that no longer make use of tracing.
>> For example, arch/x86/kernel/cpu/resctrl/monitor.c contains:
>> #define CREATE_TRACE_POINTS
>> #include monitor_trace.h
>>
>> and fs/resctrl/pseudo_lock.c contains:
>> #define CREATE_TRACE_POINTS
>> #include "pseudo_lock_trace.h"
>>
>> I assumed this will also be removed in this follow-up patch?

Yup:
https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.14-rc1&id=3d0430324a0c7e7ad765140f9e78a9a312a13573

I'll include this patch in v7, you found a case where its not as harmless as I thought.


>>> * asm/cpu_device_id.h and a relative path for 'X86_CONFIG()' are kept
>>>   in the filesystem code to ensure x86 builds. A follow-up patch will
>>>   remove these.
>>> * This script doesn't know how to move the documentation, and update the
>>>   links in comments. A follow-up patch does this.
>>
>> One unexpected thing I noticed is that fs/resctr/internal.h contains:
>> #ifndef _ASM_X86_RESCTRL_INTERNAL_H
>> #define _ASM_X86_RESCTRL_INTERNAL_H
>> ...
>> #endif /* _ASM_X86_RESCTRL_INTERNAL_H */

That's a new one - I'll add a follow-up patch to change those.


> It looks like another item for this list of "corner cases" is that the
> #include of all files need to be reviewed after the code move. There are
> functions depending on a particular #include that are moved out of the .c
> file but the (no longer needed) #include remains.

Indeed, that is one of the followups that I'll include in v7.
https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.14-rc1&id=9e2bd53f5e2b33fef69db1aae2dd7aeeaf1dd24c

I suggest all these get merged into the patch that moves the code - but I'll post them
separately in case anyone is interested in regenerating the patch using this script.


Thanks,

James

