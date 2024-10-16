Return-Path: <linux-kernel+bounces-368203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CACF9A0C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D32822C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50899207A11;
	Wed, 16 Oct 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JGGpC2hI"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E314F114
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088618; cv=none; b=tpwmMkweXYSwUwmOp0706D0oyMYMWBnW3MUl0+GP5G7wqfXhEgZO0Vk8eiZ5T6G5Nf8/gXQNBpAi0XwbZ8brqCbw3NBzdYnic9mOQ1U6GcyA06NrhD6Ba6+JpTiGltK5ptViMvKFfdSi7eSHnZV1DDiFxeRpbNu5Q+JyG3KfzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088618; c=relaxed/simple;
	bh=5yrn50EBvMwYZFVl0AiWeezGaNc/ofdvohU5Vq+Ga0s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=o46F6W2ev9F+ueqbg5dg261GyFLMM9FxaxgN0JBloQY85UnpOF5JgeGmc3ULbkJiJLqCV2uGFCtoEAp1A5Gr0gC0fo6uLvYNxrIjn5rurzox2ixV/QB3X7mVkkv73vE1wkScJUqx+ExkdBrKNp1/zkrkMBjg9WMIsTR6Kbgy0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JGGpC2hI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729088613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUNQin4unXu4FSehtkp+8uSnsrOAxdk1VPYuq9Hwy4k=;
	b=JGGpC2hIyYopRftq394m+BFj5r5QRwjMJd2UZVx1QHb7lY5NOD0yCg79j6zr6QvWbNfU3y
	AQIX2aT09KwyQwmIXlBGejUs0D8MGF7M+GT3mRvZU/ED4JYqlUKWV/0VgCgp3SWvdgrelU
	45rcrigbElxu73HA1WVVwAvhQaWl+XQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Date: Wed, 16 Oct 2024 22:22:57 +0800
Message-Id: <55B22931-34E1-4DAF-B392-A48EC2A9EE1A@linux.dev>
References: <270ca4d5-b35f-4533-87c9-dc15e7b00f6f@suse.cz>
Cc: chenridong <chenridong@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ridong Chen <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
In-Reply-To: <270ca4d5-b35f-4533-87c9-dc15e7b00f6f@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT



> On Oct 16, 2024, at 20:13, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> =EF=BB=BFOn 10/14/24 11:20, Muchun Song wrote:
>>=20
>>=20
>>>> On Oct 14, 2024, at 17:04, chenridong <chenridong@huawei.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2024/10/14 16:43, Muchun Song wrote:
>>>>> On Oct 14, 2024, at 16:13, Anshuman Khandual <anshuman.khandual@arm.co=
m> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 10/14/24 08:53, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>=20
>>>>>> A memleak was found as bellow:
>>>>>>=20
>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>> comm "mkdir", pid 1559, jiffies 4294932666
>>>>>> hex dump (first 32 bytes):
>>>>>>   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>   40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>> backtrace (crc 2e7ef6fa):
>>>>>>   [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>>   [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>>   [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>>   [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>>   [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>>   [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>>   [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>>   [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>>   [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>>   [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>>   [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>>   [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>=20
>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>>> err, the info won't be freed. Just fix it.
>>>>>>=20
>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinke=
r_info::{map, nr_deferred}")
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>> ---
>>>>>> mm/shrinker.c | 1 +
>>>>>> 1 file changed, 1 insertion(+)
>>>>>>=20
>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>>> --- a/mm/shrinker.c
>>>>>> +++ b/mm/shrinker.c
>>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>=20
>>>>>> err:
>>>>>> mutex_unlock(&shrinker_mutex);
>>>>>> + kvfree(info);
>>>>>> free_shrinker_info(memcg);
>>>>>> return -ENOMEM;
>>>>>> }
>>>>>=20
>>>>> There are two scenarios when "goto err:" gets called
>>>>>=20
>>>>> - When shrinker_info allocations fails, no kvfree() is required
>>>>> - but after this change kvfree() would be called even
>>>>> when the allocation had failed originally, which does
>>>>>   not sound right
>>>> Yes. In this case, @info is NULL and kvfree could handle NULL.
>>>> It seems strange but the final behaviour correct.
>>>>>=20
>>>>> - shrinker_unit_alloc() fails, kvfree() is actually required
>>>>>=20
>>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>>> fails but before calling into "goto err".
>>>> We could do it like this, which avoids ambiguity (if someone ignores
>>>> that kvfree could handle NULL). Something like:
>>>> --- a/mm/shrinker.c
>>>> +++ b/mm/shrinker.c
>>>> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>                        goto err;
>>>>                info->map_nr_max =3D shrinker_nr_max;
>>>>                if (shrinker_unit_alloc(info, NULL, nid))
>>>> -                       goto err;
>>>> +                       goto free;
>>>>                rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, i=
nfo);
>>>>        }
>>>>        mutex_unlock(&shrinker_mutex);
>>>>        return ret;
>>>> -
>>>> +free:
>>>> +       kvfree(info);
>>>> err:
>>>>        mutex_unlock(&shrinker_mutex);
>>>>        free_shrinker_info(memcg);
>>>> Thanks.
>>>>>=20
>>>>> But curious, should not both kvzalloc_node()/kvfree() be avoided
>>>>> while inside mutex lock to avoid possible lockdep issues ?
>>> How about:
>>>=20
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index dc5d2a6fcfc4..7baee7f00497 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -87,9 +87,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>                if (!info)
>>>                        goto err;
>>>                info->map_nr_max =3D shrinker_nr_max;
>>> +               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, i=
nfo);
>>>                if (shrinker_unit_alloc(info, NULL, nid))
>>>                        goto err;
>>> -               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, i=
nfo);
>>>        }
>>>        mutex_unlock(&shrinker_mutex);
>>=20
>> No. We should make sure the @info is fully initialized before others
>> could see it. That's why rcu_assign_pointer is used here.
>=20
> If the info is immediately visible, is the failure cleanup
> free_shrinker_info() safe? It uses kvfree(info) and not kvfree_rcu(), and
> shrinker_unit_free() is also doing kfree().

Qi told me that the @info will not visible immediately yesterday.
So non-rcu-based kvfree is safe. Even if this fix could
work properly, it=E2=80=99s a bit strange for me to use
rcu_assign_pointer to assign the @info without full initialization to it.

Muchun,
Thanks.

>=20
>>>=20
>>> I think this is concise.
>>>=20
>>> Best regards,
>>> Ridong
>>=20
>>=20
>=20

