Return-Path: <linux-kernel+bounces-408607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03C9C8101
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E751F21A26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773621E412E;
	Thu, 14 Nov 2024 02:47:49 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD96AAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552469; cv=none; b=D9rSXCHdZPGKJ8ciSsyA1i4lYGgH/epWIZ4TLgtCN5jbKdBK6ggzeR4FiKkNJCr0rX0Rg52jXFLbCTRZPz0OnrEJv0mkE4RpM+LWqSPq50PHkLuK3So3NBhk84dPn+dGrogb2hY8Kt2+r7PtJ1U3msirDUqacNqetwaN4G4bdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552469; c=relaxed/simple;
	bh=UXVNszelyeb3iVqgor+oDRpxrv4n1d0NR/9X78xSBXE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P/Eb+PIqs4Oo2oKIKHkRpyeHtVnTGEqbDE+Wu2/a50N+chGXmNjAolJ2ehi9b1x4BmFNQYq3N18BW4l86wAgis6qnZkgIsPE0G6d+Xu3UabRQQ6Afv4jwo+qe7HFiAo42RWzqmhTM3wjJFgPFCgSrl3frsXwYwfa/bDyimT6iiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xpl2243dKz1yqBC;
	Thu, 14 Nov 2024 10:47:54 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id DDD341A0188;
	Thu, 14 Nov 2024 10:47:42 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 10:47:42 +0800
Subject: Re: [PATCH] topology: Keep the cpumask unchanged when printing cpumap
To: Greg KH <gregkh@linuxfoundation.org>
CC: <tiantao6@hisilicon.com>, <rafael@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <baohua@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241113165900.78095-1-lihuafei1@huawei.com>
 <2024111347-buggy-cranium-61c3@gregkh>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <359b85aa-714f-f3cb-7096-28296dc2ea72@huawei.com>
Date: Thu, 14 Nov 2024 10:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024111347-buggy-cranium-61c3@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/11/13 21:50, Greg KH wrote:
> On Thu, Nov 14, 2024 at 12:59:00AM +0800, Li Huafei wrote:
>> During fuzz testing, the following warning was discovered:
>>
>>  different return values (15 and 11) from vsnprintf("%*pbl
>>  ", ...)
>>
>>  test:keyward is WARNING in kvasprintf
>>  WARNING: CPU: 55 PID: 1168477 at lib/kasprintf.c:30 kvasprintf+0x121/0x130
>>  Call Trace:
>>   kvasprintf+0x121/0x130
>>   kasprintf+0xa6/0xe0
>>   bitmap_print_to_buf+0x89/0x100
>>   core_siblings_list_read+0x7e/0xb0
>>   kernfs_file_read_iter+0x15b/0x270
>>   new_sync_read+0x153/0x260
>>   vfs_read+0x215/0x290
>>   ksys_read+0xb9/0x160
>>   do_syscall_64+0x56/0x100
>>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> What is happening when this fuzzing is going on?  Removing/adding cpus?
> 

Yes, logs of CPU offline also appeared before the warning.


>> The call trace shows that kvasprintf() reported this warning during the
>> printing of core_siblings_list. kvasprintf() has several steps:
>>
>>  (1) First, calculate the length of the resulting formatted string.
>>
>>  (2) Allocate a buffer based on the returned length.
>>
>>  (3) Then, perform the actual string formatting.
>>
>>  (4) Check whether the lengths of the formatted strings returned in
>>      steps (1) and (2) are consistent.
>>
>> If the core_cpumask is modified between steps (1) and (3), the lengths
>> obtained in these two steps may not match. Indeed our test includes cpu
>> hotplugging, which should modify core_cpumask while printing.
> 
> Ah, yes.  Good catch.
> 
>> To fix this issue, cache the cpumask into a temporary variable before
>> calling cpumap_print_{list, cpumask}_to_buf(), to keep it unchanged
>> during the printing process.
> 
> Nice, but:
> 
>>
>> Fixes: bb9ec13d156e ("topology: use bin_attribute to break the size limitation of cpumap ABI")
> 
> No cc: stable?

Thanks for the reminder, v2 will be cc'd to stable.

> 
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  drivers/base/topology.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
>> index 89f98be5c5b9..70dbd7ef038d 100644
>> --- a/drivers/base/topology.c
>> +++ b/drivers/base/topology.c
>> @@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
>>  			   loff_t off, size_t count)				\
>>  {										\
>>  	struct device *dev = kobj_to_dev(kobj);                                 \
>> +	cpumask_var_t mask;							\
>> +	ssize_t n;								\
>>  										\
>> -	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
>> -					   off, count);                         \
>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
>> +		return 0;							\
> 
> If this fails, return the error please.  Don't return a size of 0, which
> will just confuse userspace as to why the read succeeded yet did not
> return any data?
> 

Okay, v2 will change to return -ENOMEM, and the same applies to the
following places.

Thanks,
Huafei

>> +										\
>> +	cpumask_copy(mask, topology_##mask(dev->id));				\
>> +	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
>> +	free_cpumask_var(mask);							\
>> +										\
>> +	return n;								\
>>  }										\
>>  										\
>>  static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
>> @@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
>>  				loff_t off, size_t count)			\
>>  {										\
>>  	struct device *dev = kobj_to_dev(kobj);					\
>> +	cpumask_var_t mask;							\
>> +	ssize_t n;								\
>> +										\
>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
>> +		return 0;							\
> 
> Same here, please return the error.
> 
> thanks,
> 
> greg k-h
> .
> 

