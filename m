Return-Path: <linux-kernel+bounces-539312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A37A4A327
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053893BCFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408452777FE;
	Fri, 28 Feb 2025 19:54:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47D230BD8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772455; cv=none; b=tcBe/LAFb3tdSqxr0KR2dcpzXIsWmuPlvliyNjedYAOOndB7TlQtLsVrrRoTf+cqG1tZ5hIOmwfNSN5Xgsrvep/R+2ovk67tghXKddHQhAmAlikhVCKg4BobEpb6/rH7GacRSMIY74kpqjAOwSwVzlNNhLgY8ZHMynovtqcbgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772455; c=relaxed/simple;
	bh=Tb5Lz3mkoJ7fKRhNwvCWieexrNp9HImYEJir/hIzTC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHNJ8LYI7Wyvc6gUqAWnRWWWTYk/g9OqKK3WJwwWoSzcVdUwBnc30Xa0ww/zgOmwEoc+0QjEx1Acc0TRQz4gFkjZOBfC//yks/gLR5uU7WgrygCkAUZvrjFCtZKUq8ydIH4OI3GAio5xe65ni2zzJg5MIj8XtBi3dn4MdlxSGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1461515;
	Fri, 28 Feb 2025 11:54:28 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF0703F5A1;
	Fri, 28 Feb 2025 11:54:07 -0800 (PST)
Message-ID: <674314d0-d480-4bce-b12d-72c3b9fed1c0@arm.com>
Date: Fri, 28 Feb 2025 19:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/42] x86/resctrl: Split trace.h
To: Fenghua Yu <fenghuay@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
 <20250207181823.6378-40-james.morse@arm.com>
 <c481185c-9fbf-4c85-b1e2-ff95fc4cc18c@intel.com>
 <289351cf-7fc7-428a-8faf-f0763e85a8fd@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <289351cf-7fc7-428a-8faf-f0763e85a8fd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua, Reinette,

On 25/02/2025 04:36, Fenghua Yu wrote:
> * # Be careful, this email looks suspicious; * Out of Character: The sender is exhibiting
> a significant deviation from their usual behavior, this may indicate that their account
> has been compromised. Be extra cautious before opening links or attachments. *
> Hi, Reinette and James,
> 
> On 2/19/25 21:45, Reinette Chatre wrote:
>> Hi James,
>>
>> On 2/7/25 10:18 AM, James Morse wrote:
>>> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
>>> of these will be left behind. All the pseudo_lock tracepoints remain part
>>> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
>>>
>>> Split trace.h so that each C file includes a different trace header file.
>>> This means the trace header files are not modified when they are moved.

>> I did not investigate if this originates here or after the code move but
>> when compiling the series (after running the file move script) with W=1

> The issues happen after running the move script.
> 
> It's because no trace event is defined in fs/resctrl/pseudo_lock_trace.h or arch/x86/
> kernel/cpu/resctrl/monitor_trace.h.
> 
> One way to fix them is to add empty events in the trace files. But seems that may cause
> the script difficulty because it cannot handle empty events easily.
> 
> Another way is to remove the two files and their inclusions in .c files. Please see my
> comment and fix in patch #42.

Yup, I have a followup patch that does this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.14-rc1&id=3d0430324a0c7e7ad765140f9e78a9a312a13573

I assumed this was harmless, evidently it has some way of upsetting kbuild.

I'll post the version with the followup patches so they can be reviewed and squashed together.


Thanks,

James

