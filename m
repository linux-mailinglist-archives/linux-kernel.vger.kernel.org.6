Return-Path: <linux-kernel+bounces-368135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE169A0BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A814B25BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09628209F3C;
	Wed, 16 Oct 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HeYSRjAL"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F69443
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085874; cv=none; b=TUe93/6WCfXt3SBwrAvXeIMZcBQYHkkPR1DYSwym7qWWKA25sgAl96F1PtacX7LTrlKBxEMw8/orR8TCtam8qdlPUXXkEdUftoVOebIzawozQUXXa8LA+T3dh25ddXaipF0aYT8Y78DsdNRiDLYYR3yeZZH+JOY3DuZZpQ6oV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085874; c=relaxed/simple;
	bh=w7l6asNAB+IXf3xSILsNWj95t8bKKOOG+TdMSDxQivg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=uNHWWpv1HMAEzcjZyr9+3zgsToxG6/vHOmH4zsIyPZiX09ZE6+oO1SSuxWYfvJFtkU4wHsS0gugthNXjxoHjCB1hd3CZAzZos7Sdc2P4xDXv4iXeEcXdqAQu6GfDmphsHD+VWqBD47D9dVZw567hpdyWDAXOuc1yqgWvvEkv41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HeYSRjAL; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729085869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+YCI0FG5lB9iVVjcZez+WFS1g8KiaYrOyP2QC4tp1U=;
	b=HeYSRjALVBtGVaDE+xkFIO4yjC3UOmFyNMXKPrldmjVg2aq2/R9O57J91Z0MM0eSwlFFvH
	7lQrqE9GNjSQjrrbunLetcD+TJ8U802vNJLIOOBNp4H4oMohSn2OE/Yg6CHBionX0R7rdg
	sQCQ7yMJdi5dznzZGJB+Gwa1dML5W4k=
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
Date: Wed, 16 Oct 2024 21:37:13 +0800
Message-Id: <14475D72-33E6-4E50-87C8-7044C09C93E3@linux.dev>
References: <w7x2gzrpluandokbym2y7sbmfshbfb5wgh4lt4d72bnorb26la@cyavgpacqwhh>
Cc: chenridong <chenridong@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
In-Reply-To: <w7x2gzrpluandokbym2y7sbmfshbfb5wgh4lt4d72bnorb26la@cyavgpacqwhh>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-Migadu-Flow: FLOW_OUT



> On Oct 16, 2024, at 18:17, Kirill A. Shutemov <kirill@shutemov.name> wrote=
:
>=20
> =EF=BB=BFOn Wed, Oct 16, 2024 at 10:21:30AM +0800, Muchun Song wrote:
>>=20
>>=20
>>>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2024/10/15 14:55, Anshuman Khandual wrote:
>>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>=20
>>>>>> A memleak was found as bellow:
>>>>>>=20
>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>>  comm "mkdir", pid 1559, jiffies 4294932666
>>>>>>  hex dump (first 32 bytes):
>>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>>  backtrace (crc 2e7ef6fa):
>>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
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
>>>>>>   err:
>>>>>>  mutex_unlock(&shrinker_mutex);
>>>>>> + kvfree(info);
>>>>>>  free_shrinker_info(memcg);
>>>>>>  return -ENOMEM;
>>>>>> }
>>>>>=20
>>>>> NAK. If in the future there going to one more error case after
>>>>> rcu_assign_pointer() we will end up with double free.
>>>>>=20
>>>>> This should be safer:
>>>>>=20
>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>> index dc5d2a6fcfc4..763fd556bc7d 100644
>>>>> --- a/mm/shrinker.c
>>>>> +++ b/mm/shrinker.c
>>>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>  if (!info)
>>>>>  goto err;
>>>>>  info->map_nr_max =3D shrinker_nr_max;
>>>>> - if (shrinker_unit_alloc(info, NULL, nid))
>>>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
>>>>> + kvfree(info);
>>>>>  goto err;
>>>>> + }
>>>>>  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>>  }
>>>>>  mutex_unlock(&shrinker_mutex);
>>>> Agreed, this is what I mentioned earlier as well.
>>>> ------------------------------------------------------------------
>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>> fails but before calling into "goto err"
>>>> ------------------------------------------------------------------
>>>=20
>>> After discussion, it seems that v1 is acceptable.
>>> Hi, Muchun, do you have any other opinions?
>>=20
>> I insist on my opinion, not mixing two different approaches
>> to do release resources.
>=20
> It makes no sense.
>=20
> This kvfree() is specifically to handle the case when 'info' is allocated,=

> but not yet assigned to ->shrinker_info. And 'err:' block handles all
> other error cases. Putting kvfree() in 'err:' section is double-free
> timebomb.

Please carefully read my previous reply. I don=E2=80=99t think there is any d=
ouble-free. FYI, I pasted my previous suggested fix here. Thanks.

--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
                       goto err;
               info->map_nr_max =3D shrinker_nr_max;
               if (shrinker_unit_alloc(info, NULL, nid))
-                       goto err;
+                       goto free;
               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info)=
;
       }
       mutex_unlock(&shrinker_mutex);

       return ret;
-
+free:
+       kvfree(info);
err:
       mutex_unlock(&shrinker_mutex);
       free_shrinker_info(memcg);

>=20
> --
>  Kiryl Shutsemau / Kirill A. Shutemov

