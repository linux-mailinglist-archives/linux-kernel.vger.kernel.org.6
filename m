Return-Path: <linux-kernel+bounces-368175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666379A0C45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDFD28633C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145920B1ED;
	Wed, 16 Oct 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="No7MyOSG"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEB1DAC9C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087750; cv=none; b=JKnp1DEwmsLGeuEF6v4hzz7N/plKr9/OpKqBU3062Of7qjUyx394N3Gsrozp0Q2llkg6M1QucoAQFzB0RDq0NSwaekVtNY/jhvGBZLRx53lNBT1yb+lHRvaXrA9Gn0/xnic128Qox3q3eeNDSoHKdXhZkcncYxhrKKaebaQzZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087750; c=relaxed/simple;
	bh=n1HYiTnuAzsJiAQJhhvZoIXYiG5MX6pocnZXnP3Qvyc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=F12ww62NuaGGEFq9Vxu0MVbxaRDH3eQ029Z2x7aKOMPDtAVi2l1u4arjDP8EkYdXYsGx/YfLlsl1nwboKHXD0sS+xHQn26bK52aywpOu3CiJox70tof/wxuaxJZWfH+Ub6/nzn8zfMY+4C2y9KoMuQdexW9s2zGhepHrv7wqgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=No7MyOSG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729087744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojgkOxmba6luUa6VoA9Sj2MjbqaCDVvzM2a89m3TPgU=;
	b=No7MyOSGAVb4uVMJj7v9si4kFKurj5C3b8pWkiGtGTw33yoZXH/u4+T4JB0xzxUjUKAMTI
	aYlKYK1dwtHzdxY+cxuMOaRQ48jb9bAgjZcyKeQ39//KOxVfKW/9kFwOrrmpT67ZIo3J4P
	YYhwEXYDDl9vpEUTHiL3eUHhKtOHZiI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
Cc: chenridong <chenridong@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Date: Wed, 16 Oct 2024 22:08:27 +0800
Message-Id: <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
References: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT



> On Oct 16, 2024, at 19:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> =EF=BB=BFOn 10/16/24 04:21, Muchun Song wrote:
>>=20
>>=20
>>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>>> On 2024/10/15 14:55, Anshuman Khandual wrote:
>>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>> A memleak was found as bellow:
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
>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>>> err, the info won't be freed. Just fix it.
>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinke=
r_info::{map, nr_deferred}")
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>> ---
>>>>>> mm/shrinker.c | 1 +
>>>>>> 1 file changed, 1 insertion(+)
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
>>>>> NAK. If in the future there going to one more error case after
>>>>> rcu_assign_pointer() we will end up with double free.
>>>>> This should be safer:
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
>>> After discussion, it seems that v1 is acceptable.
>>> Hi, Muchun, do you have any other opinions?
>>=20
>> I insist on my opinion, not mixing two different approaches
>> to do release resources.
>=20
> So instead we mix the cleanup of the whole function with the cleanup of wh=
at
> is effectively a per-iteration temporary variable?
>=20
> The fact there was already a confusion in this thread about whether it's
> safe and relies on kvfree(NULL) to be a no-op, should be a hint.

Yes. I think someone is confused about my opinion.
I don=E2=80=99t care about whether we should apply this hit.
If we think the hint is tricky, we could add another
label to fix it like I suggested previously. Because
we already use goto-based approaches to
cleanup the resources, why not keeping
consistent? It will be easier for us to add a new
"if" statement and handle the failure case in the future.
For example, if we use his v1 proposal, we should do
the cleanups again for info. But for goto-based
version, we just add another label to do the
cleanups and go to the new label for failure case. goto-based fix is what I i=
nsisted on. I copied my previous suggested fix here to clarify my opinion.

--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
                      goto err;
              info->map_nr_max =3D shrinker_nr_max;
              if (shrinker_unit_alloc(info, NULL, nid))
-                       goto err;
+                       goto free;
              rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);=

      }
      mutex_unlock(&shrinker_mutex);

      return ret;
-
+free:
+       kvfree(info);
err:
      mutex_unlock(&shrinker_mutex);
      free_shrinker_info(memcg);

Muchun,
Thanks.

>=20
> So no, I a gree with Kirill and others. Ideally the fix would also move th=
e
> declaration of info into the for loop to make its scope more obvious.
>=20
>> Thanks.
>>=20
>>> Best regards,
>>> Ridong

