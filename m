Return-Path: <linux-kernel+bounces-363546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB999C3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9C3B21231
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77014F9D7;
	Mon, 14 Oct 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eUXjikBZ"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D513D2BC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895496; cv=none; b=CGoKYLST91lm3seNmvwRYaWFwopD8RyLI3F62BgFVLJdsfxWGS/RALAnfkvurwwf7Bb0+sY6ZPl+fdRPIMW/gupbqVRg38Y0onYnLJcV3aQy3HJ55nRdaWcrnUNaj2LxMFkWTndsasyCCxvapUX2UGXYR+lJ+5pA8VpsiabRbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895496; c=relaxed/simple;
	bh=6a1aFNvCP8oSQhfNPDpQjZyDszaUOOVaxqTozcN7CHo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KG3nGoh91PVALMy8rCD26afIT6xn/T8a6/gDGyaKf+zJkTol8qD4M2MAKQ13eYqp2iMGdu6DxhZ+KephWedJFTet0Wf4Avr0USAKsLDB5AaADvDQfGaiijkCDXzZrvzQKHt9y6mFLvUYEfT+3ua3/mGheBCwr0Y83/F/RrXGWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eUXjikBZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728895491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HymtqTchiQpzME33HIhPmrfIpt1fflEw+LjEVZN4OU=;
	b=eUXjikBZo/wbyW+I2zALGFaqZCtk+WaTncA+wFsPHiACMY1PAFz8oeEkbOiudDy+S3gSZd
	m4LICcK5Ao/JkSsyS3x/srpyIwHPxY1kPbbh7cuml4zAv2K45bv0FC0mbNtvK+SUTHyTwC
	gQC1cwKcVsCO8hCuchpY2rCXiVwSrUo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
Date: Mon, 14 Oct 2024 16:43:59 +0800
Cc: akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 chenridong@huawei.com,
 wangweiyang2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <178A7AC8-0BDA-42CA-86B2-E1C13F3E1E8B@linux.dev>
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Chen Ridong <chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 14, 2024, at 16:13, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>=20
>=20
>=20
> On 10/14/24 08:53, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>=20
>> A memleak was found as bellow:
>>=20
>> unreferenced object 0xffff8881010d2a80 (size 32):
>>  comm "mkdir", pid 1559, jiffies 4294932666
>>  hex dump (first 32 bytes):
>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>  backtrace (crc 2e7ef6fa):
>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>=20
>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>> err, the info won't be freed. Just fix it.
>>=20
>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for =
shrinker_info::{map, nr_deferred}")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>> mm/shrinker.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..92270413190d 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>=20
>> err:
>> 	mutex_unlock(&shrinker_mutex);
>> + 	kvfree(info);
>> 	free_shrinker_info(memcg);
>> 	return -ENOMEM;
>> }
>=20
> There are two scenarios when "goto err:" gets called
>=20
> - When shrinker_info allocations fails, no kvfree() is required
> 	- but after this change kvfree() would be called even
> 	  when the allocation had failed originally, which does
>  	  not sound right

Yes. In this case, @info is NULL and kvfree could handle NULL.
It seems strange but the final behaviour correct.

>=20
> - shrinker_unit_alloc() fails, kvfree() is actually required
>=20
> I guess kvfree() should be called just after shrinker_unit_alloc()
> fails but before calling into "goto err".

We could do it like this, which avoids ambiguity (if someone ignores
that kvfree could handle NULL). Something like:

--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
                        goto err;
                info->map_nr_max =3D shrinker_nr_max;
                if (shrinker_unit_alloc(info, NULL, nid))
-                       goto err;
+                       goto free;
                rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, =
info);
        }
        mutex_unlock(&shrinker_mutex);

        return ret;
-
+free:
+       kvfree(info);
 err:
        mutex_unlock(&shrinker_mutex);
        free_shrinker_info(memcg);

Thanks.

>=20
> But curious, should not both kvzalloc_node()/kvfree() be avoided
> while inside mutex lock to avoid possible lockdep issues ?


