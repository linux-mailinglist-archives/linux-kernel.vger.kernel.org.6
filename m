Return-Path: <linux-kernel+bounces-363033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6425799BD24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF621C208F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8044683;
	Mon, 14 Oct 2024 00:48:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019FEAD5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728866879; cv=none; b=Z3mFS/OP93EzS3QTNAS32BjX/vvXMErUN8TXU2gVbVe716T0nsx0sklphP1wSdIR7DKs7XbmtYFe9JkwXJYxVcZR+dQ9j0JSHMp7lbizbFEBH7xf7UrcPS7FWBPxsezk6vWtxOgokIx728fqm5KwAUAZoqqmrnYMZTj8nO4oZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728866879; c=relaxed/simple;
	bh=uhgspVG8xD/klVA9BlyZvwT5u5ZI/CkBG6XB0/a+uFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TXGJEx6y7xRXpSH9ydfY9PNo4QA6W3ZavYQGgw/GiKcKlYCO7jWn8olPSPcGodbB1pmqBb0LcmxYLSkb+KB2GuVl4lnrzD81x7IXghUUgT4wofjv9pU5f4UWanMmXjmGZiSyoGJqWU7qfjzk9ksTS5bTqXbvuOuziaKFIS3MQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XRdpP3FbXz2DdP3;
	Mon, 14 Oct 2024 08:46:37 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F1101A016C;
	Mon, 14 Oct 2024 08:47:48 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 14 Oct
 2024 08:47:47 +0800
Message-ID: <4184c61f-80f7-4adc-8929-c29f959cb8df@huawei.com>
Date: Mon, 14 Oct 2024 08:47:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Muchun Song <muchun.song@linux.dev>, Chen Ridong
	<chenridong@huaweicloud.com>
CC: <akpm@linux-foundation.org>, <david@fromorbit.com>,
	<zhengqi.arch@bytedance.com>, <roman.gushchin@linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>
References: <20241011142105.391157-1-chenridong@huaweicloud.com>
 <63593DC0-21DD-40C1-A4D8-6082F2BB4222@linux.dev>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <63593DC0-21DD-40C1-A4D8-6082F2BB4222@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/10/12 10:42, Muchun Song wrote:
> 
> 
>> On Oct 11, 2024, at 22:21, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A memleak was found as bellow:
>>
>> unreferenced object 0xffff8881010d2a80 (size 32):
>>   comm "mkdir", pid 1559, jiffies 4294932666
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>   backtrace (crc 2e7ef6fa):
>>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>> err, the info won't be freed. Just fix it.
>>
>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>> mm/shrinker.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..e4b795ee6d2e 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>> 		if (!info)
>> 			goto err;
>> 		info->map_nr_max = shrinker_nr_max;
>> - 		if (shrinker_unit_alloc(info, NULL, nid))
>> + 		if (shrinker_unit_alloc(info, NULL, nid)) {
>> + 			kvfree(info);
>> 			goto err;
> 
> Since we already use goto to do the cleanup for failure, I don't like
> to mix two different ways to do the similar thing. I suggest adding
> the kvfree (BTW, it could handle NULL argument) to the label of err.
> 
> Muchun,
> Thanks.
> 
Thanks, I will update soon.

Best regards,
Ridong

>> + 		}
>> 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>> 	}
>> 	mutex_unlock(&shrinker_mutex);
>> -- 
>> 2.34.1
>>
> 

