Return-Path: <linux-kernel+bounces-554415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0382A5976F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9617F16B8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2222D4C9;
	Mon, 10 Mar 2025 14:21:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01422B8D0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616469; cv=none; b=pEaA6JljbDzHKq1LbcGeYBrVW4eiNKXjtG+DOFzYbBznN+bfzF0LRJuSwQuitnydGxJP6PUWkdisxqsT0SH7yJ+KPj+LQvZE3/qpM7fqncI9+n+DJPx5/kVaS/RG/QzGAh6OvdSS7sZ80oOFFNSNKO7g/S8TdUla4eKW4VRG6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616469; c=relaxed/simple;
	bh=bpWXb/FRdwofYskvz7WprVy+0U8vW/XDTuSJzFijw3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLn/YI34hnNr8A4X3UoknZ+xfvU4u3+kcVV2spPFCS41AF9IJ4GUxXAjfW0R/c2rU7VDeb+HzcfmtoCGllBfyFOt0I6aXyY/EIIQLZ6amWUVy/VPi0Sbhy4Jaovko03aXI7dbmf1wIVdMCyMk82oqxJ6yGjCi846WwzPNH2lxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A25516F2;
	Mon, 10 Mar 2025 07:21:17 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D45A3F673;
	Mon, 10 Mar 2025 07:21:00 -0700 (PDT)
Message-ID: <6f2886fa-a563-43e0-b2c5-5de068c41863@arm.com>
Date: Mon, 10 Mar 2025 14:20:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 31/49] x86/resctrl: Remove the limit on the number of
 CLOSID
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-32-james.morse@arm.com>
 <a1a64dd1-7180-4845-828d-0d327d29fde4@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <a1a64dd1-7180-4845-828d-0d327d29fde4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 04:40, Reinette Chatre wrote:
> On 2/28/25 11:58 AM, James Morse wrote:
>> From: Amit Singh Tomar <amitsinght@marvell.com>
>>
>> Resctrl allocates and finds free CLOSID values using the bits of a u32.
>> This restricts the number of control groups that can be created by
>> user-space.
>>
>> MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
>> be extended beyond 32 values. There is at least one MPAM platform which
>> supports more than 32 CLOSID values.
>>
>> Replace the fixed size bitmap with calls to the bitmap API to allocate
>> an array of a sufficient size.
>>
>> ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
>> the index to get the CLOSID value. find_first_bit() returns the bit
>> number which does not need adjusting.

>> @@ -3071,6 +3085,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>  		resctrl_arch_disable_alloc();
>>  	if (resctrl_arch_mon_capable())
>>  		resctrl_arch_disable_mon();
>> +	closid_exit();
>>  	resctrl_mounted = false;
>>  	kernfs_kill_sb(sb);
>>  	mutex_unlock(&rdtgroup_mutex);
> 
> Above is the new change in this patch ... I am trying to understand the choice
> in ordering since I expect that freeing resources is done in opposite
> order from what it was allocated. I thus expected it to be before
> schemata_list_destroy() but it is instead done as the last thing before removing
> the superblock.
> 
> The changelog does not mention dependencies that need to be kept in mind.
> I thought that there may be something going on with open files ... for
> example if user kept "bit_usage" (that calls closid_allocated() that
> depends on the closid_free_map) but a quick test confirmed that
> if a file is open then an attempt to unmount will get a resource
> busy error. So rdt_kill_sb() will not even start while a file is open.
> Specifically, user sees a "umount: /sys/fs/resctrl: target is busy"
> 
> What am I missing?

I just shoved it at the end of the list, but before anything 'outside' resctrl.
I'll change it to be the opposite of the order in rdt_get_tree().


Thanks,

James

