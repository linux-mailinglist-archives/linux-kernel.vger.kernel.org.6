Return-Path: <linux-kernel+bounces-367112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117F99FEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE1286C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126C15821A;
	Wed, 16 Oct 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULTqGZWT"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECA13B2A9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045347; cv=none; b=XJxKx+1aIfIrAocZ0XxYwp82pFhKQVpQ+yYx6kE1a+auz57ZTBxOJ0T8lxd1FARBwko8VGU2xQQt+NzUuRAo2A/NlUDyQzgZT9RjFXI2dpJ6u8ZTOcaN3jgTB+7vkgdCzCVj25qgMUY9UGKG6cZ0FqIuffBo5hPngVzhSeJ1fmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045347; c=relaxed/simple;
	bh=NOynqRfViNtUhFapJiYI60gq2G1E0ZSreychgvI/3bM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W3Shyr3L4Q89WE2Wq7YzcxOdarWOzwYf6AK0pJlAy5qm7FpXhW8Z+jmQXPHPwe3NMCTMbv8a++CT/SMmDGfUIeJ5kmz5vl4rpPzGx1kYCGQiYqDNU0ETUaF4t2cAtciRtsqM/0D060MRM8+K9AriHvEWyEWAWeEmwtpBtGuHcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULTqGZWT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729045340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqMEPBv9cbTNi1dL6eZXF7Kd8dswrfA1mgY3e9zu5E4=;
	b=ULTqGZWThzVRjIWzTix80c/Piy17H6duMu8563CHHIeupJaV4GSfC7AxlxVGVX+NBgTEtK
	z0vpjt0Lx9eVYZQiLhM8Gvm/5mKCLaAUw+PulHntAgIcfglI8I2mDUr/uvPAqFUeveQAe2
	aHzFN1dk53JF/pJwKn/LBaMZVfTFIBw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <4a18e997-3a94-4248-8923-c3764d12b0d6@huawei.com>
Date: Wed, 16 Oct 2024 10:21:30 +0800
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 wangweiyang2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD2AA126-5885-41C7-ACFD-85C764170B9E@linux.dev>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
 <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
 <4a18e997-3a94-4248-8923-c3764d12b0d6@huawei.com>
To: chenridong <chenridong@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>=20
>=20
>=20
> On 2024/10/15 14:55, Anshuman Khandual wrote:
>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>=20
>>>> A memleak was found as bellow:
>>>>=20
>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>   comm "mkdir", pid 1559, jiffies 4294932666
>>>>   hex dump (first 32 bytes):
>>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>>>>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
@...............
>>>>   backtrace (crc 2e7ef6fa):
>>>>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>=20
>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc =
return
>>>> err, the info won't be freed. Just fix it.
>>>>=20
>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for =
shrinker_info::{map, nr_deferred}")
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>  mm/shrinker.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>> --- a/mm/shrinker.c
>>>> +++ b/mm/shrinker.c
>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>    err:
>>>>   mutex_unlock(&shrinker_mutex);
>>>> + kvfree(info);
>>>>   free_shrinker_info(memcg);
>>>>   return -ENOMEM;
>>>>  }
>>>=20
>>> NAK. If in the future there going to one more error case after
>>> rcu_assign_pointer() we will end up with double free.
>>>=20
>>> This should be safer:
>>>=20
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index dc5d2a6fcfc4..763fd556bc7d 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>   if (!info)
>>>   goto err;
>>>   info->map_nr_max =3D shrinker_nr_max;
>>> - if (shrinker_unit_alloc(info, NULL, nid))
>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
>>> + kvfree(info);
>>>   goto err;
>>> + }
>>>   rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>   }
>>>   mutex_unlock(&shrinker_mutex);
>> Agreed, this is what I mentioned earlier as well.
>> ------------------------------------------------------------------
>> I guess kvfree() should be called just after shrinker_unit_alloc()
>> fails but before calling into "goto err"
>> ------------------------------------------------------------------
>=20
> After discussion, it seems that v1 is acceptable.
> Hi, Muchun, do you have any other opinions?

I insist on my opinion, not mixing two different approaches
to do release resources.

Thanks.

>=20
> Best regards,
> Ridong


