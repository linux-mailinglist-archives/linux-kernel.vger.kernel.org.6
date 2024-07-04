Return-Path: <linux-kernel+bounces-241430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF7927B59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D451C21144
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667A1AE87A;
	Thu,  4 Jul 2024 16:41:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E21AE859
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111306; cv=none; b=Sfepzb9s84920GeI2mrL4ci4QnKDMuErRtTcmVtaRa3VjZPZgs3lLG8elX0hOH3CU/tCXiiApypf+TFmNe9qaM9X20QyUkPJdHkqAsqDfd7NVFyl9lWutXeoObCvZVc3BEaZ5sZTDUj2seCL85kB6Jj09dRen3THyDNI4MBgcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111306; c=relaxed/simple;
	bh=TY0+kJ297uYGOYzfRJlk47uaKgRweqc5jH52d0V6xco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk4eEhv3W0JLNn5UmW4pwkvzNXMCUMG8ZbfDuWu/EgCzn87Todrxm0yj6iS3i+qCWsvBuhdkOO5rUr1Mozv/OYe1YgghfWaIgty8olRsa1a5mrawAO5HU0yQpAQvGrH7b3WqsTtgw3xthYwLxS7/JHmc3UL8cOEJ9vKTPW+YKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08357367;
	Thu,  4 Jul 2024 09:42:09 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77FCF3F762;
	Thu,  4 Jul 2024 09:41:40 -0700 (PDT)
Message-ID: <4b988afb-bc2e-4b4c-8ebe-e1db0b614f24@arm.com>
Date: Thu, 4 Jul 2024 17:41:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-32-james.morse@arm.com>
 <be5bae3d-a192-4ca0-9474-809774011f25@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <be5bae3d-a192-4ca0-9474-809774011f25@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 28/06/2024 17:53, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>> resctrl can't be built as a module, and the kernfs helpers are not exported
>> so this is unlikely to change. MPAM has an error interrupt which indicates
>> the MPAM driver has gone haywire. Should this occur tasks could run with
>> the wrong control values, leading to bad performance for impoartant tasks.
> 
> impoartant -> important
> 
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

> I am not familiar with these flows so I would like to confirm ...
> In this scenario the resctrl filesystem will be unregistered, are
> you saying that it is possible to unmount a filesystem after it has
> been unregistered?

Counter-intuitively: yes.

The rules are described in fs/filesystems.c: We can access the members of the struct
file_system_type if the list lock is held, or a reference is held to the module. This is
how /proc/mounts is able to print the filesystem name from struct file_system_type without
taking the lock - it holds a reference to any module to prevent the structure from being
freed. Because resctrl can't be built as a module, we can say there is always a reference
held, and we can never free struct file_system_type.


Thanks,

James

