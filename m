Return-Path: <linux-kernel+bounces-365191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409A99DED2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954791C21996
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2818A6DB;
	Tue, 15 Oct 2024 06:55:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E21185936
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975346; cv=none; b=jYW3Qb/oR2ErXfn5F5p8x4O+KleQ3UA02YWOzjtunCTU8ABeyAVQiIbC7OFd8e2XwU+N/4UF/gBNPG/YlKwGT19uN50CBf0moBOn6OJarn89THN9QCSqJ0yaEFr6fQZcO7Yj6XRFgDrmLv/nDffUYOpTEvBi+2gAicul4CYpjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975346; c=relaxed/simple;
	bh=XFtOcK6cW5q2TN85YbMm7gAqu9WmsY9zhmgQ56U0ysI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNlmyQbZLG8eyQzhUGRU+NfLmbCsg2KY6IjpCMKUHHqqSdHShNdXrqRAF602jZIbsR5O6WLaLeYutBxAa5y0tOnCqeCSqIciJNE9URqAtzk9BUGaCDWfjrJE2NJJuxFlT64Cb0itB2gafxAs3ePgZg7UYzZN3ideMkOfdwSgPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 761811063;
	Mon, 14 Oct 2024 23:56:13 -0700 (PDT)
Received: from [10.162.16.109] (a077893.blr.arm.com [10.162.16.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0CB23F51B;
	Mon, 14 Oct 2024 23:55:40 -0700 (PDT)
Message-ID: <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
Date: Tue, 15 Oct 2024 12:25:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com,
 zhengqi.arch@bytedance.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/24 16:59, Kirill A. Shutemov wrote:
> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
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
>>  mm/shrinker.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..92270413190d 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>  
>>  err:
>>  	mutex_unlock(&shrinker_mutex);
>> +	kvfree(info);
>>  	free_shrinker_info(memcg);
>>  	return -ENOMEM;
>>  }
> 
> NAK. If in the future there going to one more error case after
> rcu_assign_pointer() we will end up with double free.
> 
> This should be safer:
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..763fd556bc7d 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  		if (!info)
>  			goto err;
>  		info->map_nr_max = shrinker_nr_max;
> -		if (shrinker_unit_alloc(info, NULL, nid))
> +		if (shrinker_unit_alloc(info, NULL, nid)) {
> +			kvfree(info);
>  			goto err;
> +		}
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
>  	mutex_unlock(&shrinker_mutex);

Agreed, this is what I mentioned earlier as well.

------------------------------------------------------------------
I guess kvfree() should be called just after shrinker_unit_alloc()
fails but before calling into "goto err"
------------------------------------------------------------------

