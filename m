Return-Path: <linux-kernel+bounces-363609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0599C4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EDC285A86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DD154C04;
	Mon, 14 Oct 2024 09:04:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DF1537AC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896672; cv=none; b=BfgAczgA8FoLlYQfMp3fXXUiu495M69sdv1QA5r//ymZhaXhSKHDNMN9oYK2xOI6d6xAUlEW3S21hd+Ps0idyljN8w6UF4DBdBI0MeIMUy1y8q811YR9kd52f6MmovIf6MvEduWZ6ExROwL1Leqag6Rz7BfATDWwm8YblXBzubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896672; c=relaxed/simple;
	bh=7qBoJp5GZOZLZhTDit1ACahYgBfo9sb2TqkPmp3Z0lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceF8xu0YHyLNTC42m+igCF2ArPtbD8PDq4g9+It5y89DbA/X28tvhcbaOgbftT1oG2H8xB63CqivYVI7oXcHoQNprJgTDYMx2ifxpotyBnfkQn6iNxuikOD6476a++W46v4bATRAnBsjoxYeXpv0zgGWABAf3rG4dJKcUh5+t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XRrr10rnzz20qLD;
	Mon, 14 Oct 2024 17:03:45 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 02FFD140158;
	Mon, 14 Oct 2024 17:04:27 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 14 Oct
 2024 17:04:26 +0800
Message-ID: <1dc9acbd-351f-4755-8c56-d3d77aaccfb2@huawei.com>
Date: Mon, 14 Oct 2024 17:04:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Muchun Song <muchun.song@linux.dev>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Chen Ridong <chenridong@huaweicloud.com>
CC: <akpm@linux-foundation.org>, <david@fromorbit.com>,
	<zhengqi.arch@bytedance.com>, <roman.gushchin@linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
 <178A7AC8-0BDA-42CA-86B2-E1C13F3E1E8B@linux.dev>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <178A7AC8-0BDA-42CA-86B2-E1C13F3E1E8B@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/10/14 16:43, Muchun Song wrote:
> 
> 
>> On Oct 14, 2024, at 16:13, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 10/14/24 08:53, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> A memleak was found as bellow:
>>>
>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>   comm "mkdir", pid 1559, jiffies 4294932666
>>>   hex dump (first 32 bytes):
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>   backtrace (crc 2e7ef6fa):
>>>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>> err, the info won't be freed. Just fix it.
>>>
>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>> mm/shrinker.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index dc5d2a6fcfc4..92270413190d 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>
>>> err:
>>> 	mutex_unlock(&shrinker_mutex);
>>> + 	kvfree(info);
>>> 	free_shrinker_info(memcg);
>>> 	return -ENOMEM;
>>> }
>>
>> There are two scenarios when "goto err:" gets called
>>
>> - When shrinker_info allocations fails, no kvfree() is required
>> 	- but after this change kvfree() would be called even
>> 	  when the allocation had failed originally, which does
>>   	  not sound right
> 
> Yes. In this case, @info is NULL and kvfree could handle NULL.
> It seems strange but the final behaviour correct.
> 
>>
>> - shrinker_unit_alloc() fails, kvfree() is actually required
>>
>> I guess kvfree() should be called just after shrinker_unit_alloc()
>> fails but before calling into "goto err".
> 
> We could do it like this, which avoids ambiguity (if someone ignores
> that kvfree could handle NULL). Something like:
> 
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>                          goto err;
>                  info->map_nr_max = shrinker_nr_max;
>                  if (shrinker_unit_alloc(info, NULL, nid))
> -                       goto err;
> +                       goto free;
>                  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>          }
>          mutex_unlock(&shrinker_mutex);
> 
>          return ret;
> -
> +free:
> +       kvfree(info);
>   err:
>          mutex_unlock(&shrinker_mutex);
>          free_shrinker_info(memcg);
> 
> Thanks.
> 
>>
>> But curious, should not both kvzalloc_node()/kvfree() be avoided
>> while inside mutex lock to avoid possible lockdep issues ?
> 
How about:

diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..7baee7f00497 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -87,9 +87,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
                  if (!info)
                          goto err;
                  info->map_nr_max = shrinker_nr_max;
+               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, 
info);
                  if (shrinker_unit_alloc(info, NULL, nid))
                          goto err;
-               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, 
info);
          }
          mutex_unlock(&shrinker_mutex);

I think this is concise.

Best regards,
Ridong

