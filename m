Return-Path: <linux-kernel+bounces-363672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D839C99C57A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C481F23CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437C156C71;
	Mon, 14 Oct 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RnPu2CZJ"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8E149011
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897685; cv=none; b=utg5zszIeDfyH6a9chR9v5WZAetl9WmSPFIexTuuO1IWb6P/fCNJLzQvkocM+sGjkU7tM5qjQbRhMag188mF1fLiM5gIzTc7n4HXE6HMb90uXJT2JJN3EAvwxeBPkrxHeYxAQQur1wU10kCt4FrmEqxT+Et9qetUwquJPIv/pcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897685; c=relaxed/simple;
	bh=WbdRHsABvw9rRtX0jHr8qhzyc9rMEgmKP9p0cpEXH0Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HlEDrWIS0sDo9YTkAHHJ9p1M7Rsi1dNg7LCNUf38D8KLAK8WmZZICce/olVhudF5ntq3FMwv2kXjIK6bYgMxKswR94TRFQQj3DRNfBfPLyvmbH5+AiJrl2rmSSUPfIHcqeeJn0WDRrUPhHjDjIhFyvfkDGQ9lQZUG9Codp7BNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RnPu2CZJ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728897680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDLvmbpwBfA3AyjgpvHbE9AIuFgUDlphGRxMHgOTuB0=;
	b=RnPu2CZJK1y9rgidOoDUE41DYexoIQHwu1m4rL2edEVGUlvaLF1jS/vVvSgnzkRjd/LFNo
	F/C2rCh6h5bp8no4vRbgzRcgm9cKqyXcUXyxuEpl+g7TxlL8zRDPaXKXwCNM1MTrWC+DIz
	nqsaas5VhiDqO3d/X19wvqSlTaaejck=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1dc9acbd-351f-4755-8c56-d3d77aaccfb2@huawei.com>
Date: Mon, 14 Oct 2024 17:20:34 +0800
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 wangweiyang2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8EBBED0-6D7D-4A23-AC8C-3E395EA1BF12@linux.dev>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
 <178A7AC8-0BDA-42CA-86B2-E1C13F3E1E8B@linux.dev>
 <1dc9acbd-351f-4755-8c56-d3d77aaccfb2@huawei.com>
To: chenridong <chenridong@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 14, 2024, at 17:04, chenridong <chenridong@huawei.com> wrote:
>=20
>=20
>=20
> On 2024/10/14 16:43, Muchun Song wrote:
>>> On Oct 14, 2024, at 16:13, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 10/14/24 08:53, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>=20
>>>> A memleak was found as bellow:
>>>>=20
>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>  comm "mkdir", pid 1559, jiffies 4294932666
>>>>  hex dump (first 32 bytes):
>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
@...............
>>>>  backtrace (crc 2e7ef6fa):
>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>=20
>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc =
return
>>>> err, the info won't be freed. Just fix it.
>>>>=20
>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for =
shrinker_info::{map, nr_deferred}")
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>> mm/shrinker.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>> --- a/mm/shrinker.c
>>>> +++ b/mm/shrinker.c
>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>=20
>>>> err:
>>>> mutex_unlock(&shrinker_mutex);
>>>> + kvfree(info);
>>>> free_shrinker_info(memcg);
>>>> return -ENOMEM;
>>>> }
>>>=20
>>> There are two scenarios when "goto err:" gets called
>>>=20
>>> - When shrinker_info allocations fails, no kvfree() is required
>>> - but after this change kvfree() would be called even
>>>  when the allocation had failed originally, which does
>>>    not sound right
>> Yes. In this case, @info is NULL and kvfree could handle NULL.
>> It seems strange but the final behaviour correct.
>>>=20
>>> - shrinker_unit_alloc() fails, kvfree() is actually required
>>>=20
>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>> fails but before calling into "goto err".
>> We could do it like this, which avoids ambiguity (if someone ignores
>> that kvfree could handle NULL). Something like:
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>                         goto err;
>>                 info->map_nr_max =3D shrinker_nr_max;
>>                 if (shrinker_unit_alloc(info, NULL, nid))
>> -                       goto err;
>> +                       goto free;
>>                 =
rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>         }
>>         mutex_unlock(&shrinker_mutex);
>>         return ret;
>> -
>> +free:
>> +       kvfree(info);
>>  err:
>>         mutex_unlock(&shrinker_mutex);
>>         free_shrinker_info(memcg);
>> Thanks.
>>>=20
>>> But curious, should not both kvzalloc_node()/kvfree() be avoided
>>> while inside mutex lock to avoid possible lockdep issues ?
> How about:
>=20
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..7baee7f00497 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -87,9 +87,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>                 if (!info)
>                         goto err;
>                 info->map_nr_max =3D shrinker_nr_max;
> +               =
rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>                 if (shrinker_unit_alloc(info, NULL, nid))
>                         goto err;
> -               =
rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>         }
>         mutex_unlock(&shrinker_mutex);

No. We should make sure the @info is fully initialized before others
could see it. That's why rcu_assign_pointer is used here.

>=20
> I think this is concise.
>=20
> Best regards,
> Ridong


