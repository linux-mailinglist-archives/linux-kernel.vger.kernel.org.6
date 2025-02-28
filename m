Return-Path: <linux-kernel+bounces-539310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6BA4A323
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E6C3BCAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2947230BFD;
	Fri, 28 Feb 2025 19:54:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03500230BD8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772449; cv=none; b=pdSa7smIWEdDlmPWfO4wQKoajRoWkyj+NPsG7PuefajFeyEw0ZF9e44uw567yTKX5j1Q9LSCUVryFRnm8C8qu2WUr9PXgxufz/tvxNfPaST6C0o0jAEWG6dQzQMCImqx654aHEg0Hr3wOOu17E1guB03L/+PTKAlPrM1VIWM2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772449; c=relaxed/simple;
	bh=jOG6JRbOX7kETk8jiCqeZ5lPaJ0cQAuO41k4XsqBrkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCCsHIyhd3IKgZb8CVRDmSnMtiTp3ouZyI0ZWvgAaa9pcwEIvhiC6jpdaJU+MhqhEkwQ8TteTHyolSkvzt+yIXM+yz7Yq8K6AbJxQZVKtvDVRodxCgx7yKzKLSZqNyp5wlnGtLsq8Vznwey113r5EW/leSvIaQjGhiTlTqh8k70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B7A150C;
	Fri, 28 Feb 2025 11:54:22 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117BB3F5A1;
	Fri, 28 Feb 2025 11:53:56 -0800 (PST)
Message-ID: <3e21aab4-d813-4f5b-9f60-74887270f12f@arm.com>
Date: Fri, 28 Feb 2025 19:53:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/42] x86/resctrl: Remove the limit on the number of
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-32-james.morse@arm.com>
 <6c1e02c6-085a-4866-99a3-59b954b687ee@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <6c1e02c6-085a-4866-99a3-59b954b687ee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 04:21, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
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
>>
>> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
>> [ morse: fixed the off-by-one in the allocator and the wrong
>>  not-found value. Removed the limit. Rephrase the commit message. ]
>> Signed-off-by: James Morse <james.morse@arm.com>

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 08fec23a38bf..de79da30d500 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -152,20 +152,30 @@ int closids_supported(void)

>> +static void closid_exit(void)
>> +{
>> +	bitmap_free(closid_free_map);

> With closid_free_map being a global, could this also set
> closid_free_map to NULL?

Makes sense,

> 
>>  }
>>  
>>  static int closid_alloc(void)

>> @@ -2754,20 +2763,22 @@ static int rdt_get_tree(struct fs_context *fc)
>>  		goto out_ctx;
>>  	}
>>  
>> -	closid_init();
>> +	ret = closid_init();
>> +	if (ret)
>> +		goto out_schemata_free;
>>  
>>  	if (resctrl_arch_mon_capable())
>>  		flags |= RFTYPE_MON;
>>  
>>  	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>>  	if (ret)
>> -		goto out_schemata_free;
>> +		goto out_closid_exit;
>>  
>>  	kernfs_activate(rdtgroup_default.kn);
>>  
>>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>>  	if (ret < 0)
>> -		goto out_schemata_free;
>> +		goto out_closid_exit;
>>  
>>  	if (resctrl_arch_mon_capable()) {
>>  		ret = mongroup_create_dir(rdtgroup_default.kn,

> With closid_init() called from rdt_get_tree() during mount I expected
> closid_exit() to be called from rdt_kill_sb() during unmount ?

Ah, I'd missed that - the old version got called multiple times but it was harmless. Now
it potentially leaks the bitmap. Fixed.


Thanks!

James

