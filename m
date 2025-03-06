Return-Path: <linux-kernel+bounces-549744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521DA556BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D34D1899616
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C5E26FDBF;
	Thu,  6 Mar 2025 19:29:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037D26FA7D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289343; cv=none; b=XQrE22X1ZS7ZiVVMwZFAGzmULtKwE+BCLizA4el1JM9TkM6xkux1oftSlKKOJx0K4qQRPLjK8xIDktudNWq2vs5Kr7HndFOWYVLVmjq74p23YUp4ibhAAN95m1E7GjGWKtqVfU/gH8b7GsqPaQW3FE/uaINBs1Bs0PV3dyA44r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289343; c=relaxed/simple;
	bh=a9kHyK8nwvFJXwd1zDqQ2DnutTrv0U8n+tTp0ncr3NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1Q6XPuCEf64GCo45MYkfvneMn+hm2WQNKK44PaHb/sVuaYOU7Y5PTRfBO5irFthPciQcjk6aARwyg4Oebz1Fh6YloruOLK+XUdJpOVjMfWPJEWilFfdpBvno3Aj3CYkayz8jGgWoJ0sb2FQouKUoOEzTh4TvPGXAFhKMQ1gzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2BE9169E;
	Thu,  6 Mar 2025 11:29:12 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2BED3F5A1;
	Thu,  6 Mar 2025 11:28:51 -0800 (PST)
Message-ID: <0b2c17fe-3998-4def-81eb-a910d79fbc0f@arm.com>
Date: Thu, 6 Mar 2025 19:28:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 33/42] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 <20250207181823.6378-34-james.morse@arm.com>
 <91026839-2f2e-4562-aa77-6901148c89ad@intel.com>
 <b3317010-b8bf-46f8-a176-28f810fd9920@arm.com>
 <c7e9f509-404b-48c5-bda3-ecff80f95242@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <c7e9f509-404b-48c5-bda3-ecff80f95242@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 01/03/2025 02:35, Reinette Chatre wrote:
> On 2/28/25 11:54 AM, James Morse wrote:
>> On 20/02/2025 04:42, Reinette Chatre wrote:
>>> On 2/7/25 10:18 AM, James Morse wrote:
>>>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>>>> resctrl can't be built as a module, and the kernfs helpers are not exported
>>>> so this is unlikely to change. MPAM has an error interrupt which indicates
>>>> the MPAM driver has gone haywire. Should this occur tasks could run with
>>>> the wrong control values, leading to bad performance for important tasks.
>>>> The MPAM driver needs a way to tell resctrl that no further configuration
>>>> should be attempted.
>>>>
>>>> Using resctrl_exit() for this leaves the system in a funny state as
>>>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>>>> directory that is typically used has been removed. Dave Martin suggests
>>>> this may cause systemd trouble in the future as not all filesystems
>>>> can be unmounted.
>>>>
>>>> Add calls to remove all the files and directories in resctrl, and
>>>> remove the sysfs_remove_mount_point() call that leaves the system
>>>> in a funny state. When triggered, this causes all the resctrl files
>>>> to disappear. resctrl can be unmounted, but not mounted again.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 6e30283358d4..424622d2f959 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -4371,9 +4375,12 @@ int __init resctrl_init(void)
>>>>  
>>>
>>> Could you please add the kerneldoc you proposed in
>>> https://lore.kernel.org/lkml/f2ecb501-bc65-49a9-903d-80ba1737845f@arm.com/ ?
>>
>> Huh. The way that is indented means I copied it out the file - I'm not sure went wrong
>> there. Thanks for fishing out the link!
>>
>>
>>>>  void __exit resctrl_exit(void)
>>>>  {
>>>> +	mutex_lock(&rdtgroup_mutex);
>>>> +	rdtgroup_destroy_root();
>>>> +	mutex_unlock(&rdtgroup_mutex);
>>>> +
>>>>  	debugfs_remove_recursive(debugfs_resctrl);
>>>>  	unregister_filesystem(&rdt_fs_type);
>>>> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>>>  
>>>>  	resctrl_mon_resource_exit();
>>>>  }
>>>
>>> It is difficult for me to follow the kernfs reference counting required
>>> to make this work. Specifically, the root kn is "destroyed" here but it
>>> is required to stick around until unmount when the rest of the files
>>> are removed.
>>
>> This drops resctrl's reference to all of the files, which would make the files disappear.
>> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.
> 
> My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
> flow. For example:
> 	kernfs_remove(kn_info);
> 	kernfs_remove(kn_mongrp);
> 	kernfs_remove(kn_mondata);
> 
> As I understand the above require the destroyed root to still be around.

Right - because rdt_get_tree() has these global pointers into the hierarchy, but doesn't
take a reference. rmdir_all_sub() relies on always being called before
rdtgroup_destroy_root().

The point hack would be for rdtgroup_destroy_root() to NULL out those global pointers, (I
note they are left dangling) - that would make a subsequent call to rmdir_all_sub() harmless.

A better fix would be to pull out all the filesystem relevant parts from rdt_kill_sb(),
make that safe for multiple calls and get resctrl_exit() to call that.
A call to rdt_kill_sb() after resctrl_exit() would just cleanup the super-block.
This will leave things in a more predictable state.


>>> Have you been able to test this flow? I think you mentioned
>>> something like this before but I cannot find the details now.
>>
>> Yes:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot%2bextras/v6.14-rc1&id=8c96f858b25aa42694c5db56a2afe255ed8262dd
>>
>> This is a debugfs file that schedules the threaded bit of the MPAM error interrupt
>> handler. I figure its MPAM specific because there is no way into this code on x86.
>> (the aim is to get the CI to tickle this)



Thanks,

James

