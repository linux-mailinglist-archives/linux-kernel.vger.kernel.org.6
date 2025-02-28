Return-Path: <linux-kernel+bounces-539315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE807A4A32F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E33087ABA69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3327603A;
	Fri, 28 Feb 2025 19:54:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB727426D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772473; cv=none; b=fdfI8UmYXPuoscA7+Nce4VT4m6foR5tV2TCgXCtnx38lv3EN+zjV29OMXvnUr4akKfmemAjuVRAjTCf1EJ9fUiqzSQgkcP8GNsMFxFvJeVAn/pw77SxsKOQ2+TfmFMQFPMQcgrp7yxRK9mW++ZON6oxRYxrLClv1QwaB+zOR6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772473; c=relaxed/simple;
	bh=rKktbPZ85PBxwxGNPehvt3caCnGaGLjjLHeFQVdOj+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMfL/dsC7kCPUxJ9EISzUAGzsluhiSCyzqoJGISkFwHR+JvkMJudGWpZAL1Efmdy5NZccRwX4XTD24hA9scDfwOWnM1POhsbQtQZkMeohEVMceeVIozLFKuMI/F7KuxPmkJHsMMmfQHBTHelFhD3jC0r340Mu7Mh6COIWM0rtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53B8D1515;
	Fri, 28 Feb 2025 11:54:46 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BAB3F5A1;
	Fri, 28 Feb 2025 11:54:22 -0800 (PST)
Message-ID: <b3317010-b8bf-46f8-a176-28f810fd9920@arm.com>
Date: Fri, 28 Feb 2025 19:54:20 +0000
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
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <91026839-2f2e-4562-aa77-6901148c89ad@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 04:42, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>> resctrl can't be built as a module, and the kernfs helpers are not exported
>> so this is unlikely to change. MPAM has an error interrupt which indicates
>> the MPAM driver has gone haywire. Should this occur tasks could run with
>> the wrong control values, leading to bad performance for important tasks.
>> The MPAM driver needs a way to tell resctrl that no further configuration
>> should be attempted.
>>
>> Using resctrl_exit() for this leaves the system in a funny state as
>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>> directory that is typically used has been removed. Dave Martin suggests
>> this may cause systemd trouble in the future as not all filesystems
>> can be unmounted.
>>
>> Add calls to remove all the files and directories in resctrl, and
>> remove the sysfs_remove_mount_point() call that leaves the system
>> in a funny state. When triggered, this causes all the resctrl files
>> to disappear. resctrl can be unmounted, but not mounted again.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6e30283358d4..424622d2f959 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -4371,9 +4375,12 @@ int __init resctrl_init(void)
>>  
> 
> Could you please add the kerneldoc you proposed in
> https://lore.kernel.org/lkml/f2ecb501-bc65-49a9-903d-80ba1737845f@arm.com/ ?

Huh. The way that is indented means I copied it out the file - I'm not sure went wrong
there. Thanks for fishing out the link!


>>  void __exit resctrl_exit(void)
>>  {
>> +	mutex_lock(&rdtgroup_mutex);
>> +	rdtgroup_destroy_root();
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>>  	debugfs_remove_recursive(debugfs_resctrl);
>>  	unregister_filesystem(&rdt_fs_type);
>> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>  
>>  	resctrl_mon_resource_exit();
>>  }
> 
> It is difficult for me to follow the kernfs reference counting required
> to make this work. Specifically, the root kn is "destroyed" here but it
> is required to stick around until unmount when the rest of the files
> are removed.

This drops resctrl's reference to all of the files, which would make the files disappear.
unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.


> Have you been able to test this flow? I think you mentioned
> something like this before but I cannot find the details now.

Yes:
https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot%2bextras/v6.14-rc1&id=8c96f858b25aa42694c5db56a2afe255ed8262dd

This is a debugfs file that schedules the threaded bit of the MPAM error interrupt
handler. I figure its MPAM specific because there is no way into this code on x86.
(the aim is to get the CI to tickle this)


Thanks,

James

