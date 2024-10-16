Return-Path: <linux-kernel+bounces-367068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521699FE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147F6B25EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08F14F12C;
	Wed, 16 Oct 2024 01:25:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2113633F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041940; cv=none; b=kfcjF94LD51IDyJp4LDmOddTQujsPcTFD2G2izYnujGJXaFIPwCqzfDZa0OS0n5KdprYfAmOZOOr5nqInJyyZ24TUES97kyOJ3FA72Ru+zjzMRLD5EQVyfs1PMMe/S9liSznJHQLuIMc4WbA2pWxdfkHDcvz2Az8B1bGhQ8tQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041940; c=relaxed/simple;
	bh=XgaUC5ekKLsytnPS231NZ0ExKIN/6afzoYhrLXC6Z5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WuTdQXRD/t7GCmLqHGT95iYNQPSDAmmVkk0diFPoQh1lFRhN3CmmdO8c3/ZzhDGHpqlpQqtmFXw2wapakE9ZgzTQRXfJUeD/Nh5sj4pU76NTQvqGp68hRD2fvysYg2tUP7VkXSE1Sz+QOnEMa6Ez4YrcN3l8Aedw/QYTT/YvkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XStXJ2bJQz10Nf8;
	Wed, 16 Oct 2024 09:23:44 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 97969140157;
	Wed, 16 Oct 2024 09:25:36 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 16 Oct
 2024 09:25:35 +0800
Message-ID: <4a18e997-3a94-4248-8923-c3764d12b0d6@huawei.com>
Date: Wed, 16 Oct 2024 09:25:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Anshuman Khandual <anshuman.khandual@arm.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, Muchun Song <muchun.song@linux.dev>
CC: <akpm@linux-foundation.org>, <david@fromorbit.com>,
	<zhengqi.arch@bytedance.com>, <roman.gushchin@linux.dev>,
	<muchun.song@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
 <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/10/15 14:55, Anshuman Khandual wrote:
> 
> 
> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> A memleak was found as bellow:
>>>
>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>    comm "mkdir", pid 1559, jiffies 4294932666
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>      40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>    backtrace (crc 2e7ef6fa):
>>>      [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>      [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>      [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>      [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>      [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>      [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>      [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>      [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>      [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>      [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>      [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>      [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>> err, the info won't be freed. Just fix it.
>>>
>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>   mm/shrinker.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index dc5d2a6fcfc4..92270413190d 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>   
>>>   err:
>>>   	mutex_unlock(&shrinker_mutex);
>>> +	kvfree(info);
>>>   	free_shrinker_info(memcg);
>>>   	return -ENOMEM;
>>>   }
>>
>> NAK. If in the future there going to one more error case after
>> rcu_assign_pointer() we will end up with double free.
>>
>> This should be safer:
>>
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..763fd556bc7d 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>   		if (!info)
>>   			goto err;
>>   		info->map_nr_max = shrinker_nr_max;
>> -		if (shrinker_unit_alloc(info, NULL, nid))
>> +		if (shrinker_unit_alloc(info, NULL, nid)) {
>> +			kvfree(info);
>>   			goto err;
>> +		}
>>   		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>   	}
>>   	mutex_unlock(&shrinker_mutex);
> 
> Agreed, this is what I mentioned earlier as well.
> 
> ------------------------------------------------------------------
> I guess kvfree() should be called just after shrinker_unit_alloc()
> fails but before calling into "goto err"
> ------------------------------------------------------------------
> 

After discussion, it seems that v1 is acceptable.
Hi, Muchun, do you have any other opinions?

Best regards,
Ridong

