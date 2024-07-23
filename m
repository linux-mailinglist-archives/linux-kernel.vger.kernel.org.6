Return-Path: <linux-kernel+bounces-259910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD48939FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7201C21F01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994C14F9F5;
	Tue, 23 Jul 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdib58zJ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7200150996
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733832; cv=none; b=c9VovRxxt4RGIhvpM8gLGkp/q/7ABpwJ+b+WzucK11U6WYcreaq0uOPV0Yr+f/qek0u9PPnS2fiElUHmMiT9q7tMJQIXD49vR56DDOEN9pbKl4CPO3B83FUt4GRUqPS+mCyVcjPFXqiTIKGLQIOVNPNgtZvonLYFW3ubScObOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733832; c=relaxed/simple;
	bh=YCkIsq7P3F+rPZiQ0NDIGx5OElJOJHk9YxJhzHKHOBA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WSSdxi9imIShk6Expf6nDx0GWyXq9Gk5r/aiHkxJqz+FUdDZ7NW5dHlIRr/+1evOkOj11Qg3CPfmiUxLaiHUuhdbMcsvbw2bAKksxLeyphveZ2KdgZNwmYTX4cBLzdr0t8meteF+6ns/sLNjeLzUVE7pH3HxOBDKDodXJo1k+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdib58zJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721733827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdyx0cEZKRWZ4DGe2mzzuU7N0CPsV2wlwnR893l3nCM=;
	b=tdib58zJTPNXUU8cyKFo6+QDxc/o+0e4wa6pTJbHkVZLTqUzfH5Mon7yKK9mVd3UluOZ36
	5DPnxLtVbiFT+nIvr+wkp1/UMPWMhiAltPGMuYPBjxKt/X5qOX+/wVFAWVxXn6nkWqp/0l
	puyq7Opyh7UjeRdigyWZz4ZlkuTFPyI=
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: shakeel.butt@linux.dev
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <E0A7CC1A-B02C-4210-A1DF-0600E027D5D0@linux.dev>
Date: Tue, 23 Jul 2024 19:23:02 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 shakeel.butt@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E56E5B4-7003-4EF4-98F7-C1FC30B2DE1D@linux.dev>
References: <65b7d88b-af4f-4869-9322-e38910abce6d@suse.cz>
 <E0A7CC1A-B02C-4210-A1DF-0600E027D5D0@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT



> On Jul 18, 2024, at 19:20, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On Jul 18, 2024, at 18:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>>=20
>> =EF=BB=BFOn 7/18/24 10:36 AM, Muchun Song wrote:
>>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>>> lock or cgroup_mutex or others which could prevent returned memcg
>>> from being freed. Fix it by adding missing rcu read lock.
>>=20
>> Was the UAF ever observed, or is this due to code review?
>=20
> Just code review.
>=20
> Thanks.
>=20
>> Should there be some lockdep_assert somwhere?
>>=20
>=20
> It=E2=80=99s a good option to improve this. Maybe =
mem_cgroup_from_slab_obj() is a good place.

I added it to obj_cgroup_memcg() [1]. And CC memory cgroup maintainers =
to this thread.


[1] =
https://lore.kernel.org/linux-mm/20859F67-A80C-4FD0-990C-40C70905E55B@linu=
x.dev/T/

>=20
>>> Fixes: 0a97c01cd20bb ("list_lru: allow explicit memcg and NUMA node =
selection)
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>> mm/list_lru.c | 24 ++++++++++++++++++------
>>> 1 file changed, 18 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>>> index 3fd64736bc458..225da0778a3be 100644
>>> --- a/mm/list_lru.c
>>> +++ b/mm/list_lru.c
>>> @@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int =
nid, int idx)
>>> }
>>> #endif /* CONFIG_MEMCG_KMEM */
>>>=20
>>> +/* The caller must ensure the memcg lifetime. */
>>> bool list_lru_add(struct list_lru *lru, struct list_head *item, int =
nid,
>>>           struct mem_cgroup *memcg)
>>> {
>>> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>>>=20
>>> bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>>> {
>>> +    bool ret;
>>>   int nid =3D page_to_nid(virt_to_page(item));
>>> -    struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>>> -        mem_cgroup_from_slab_obj(item) : NULL;
>>> +    struct mem_cgroup *memcg;
>>>=20
>>> -    return list_lru_add(lru, item, nid, memcg);
>>> +    rcu_read_lock();
>>> +    memcg =3D list_lru_memcg_aware(lru) ? =
mem_cgroup_from_slab_obj(item) : NULL;
>>> +    ret =3D list_lru_add(lru, item, nid, memcg);
>>> +    rcu_read_unlock();
>>> +
>>> +    return ret;
>>> }
>>> EXPORT_SYMBOL_GPL(list_lru_add_obj);
>>>=20
>>> +/* The caller must ensure the memcg lifetime. */
>>> bool list_lru_del(struct list_lru *lru, struct list_head *item, int =
nid,
>>>           struct mem_cgroup *memcg)
>>> {
>>> @@ -139,11 +146,16 @@ EXPORT_SYMBOL_GPL(list_lru_del);
>>>=20
>>> bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
>>> {
>>> +    bool ret;
>>>   int nid =3D page_to_nid(virt_to_page(item));
>>> -    struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>>> -        mem_cgroup_from_slab_obj(item) : NULL;
>>> +    struct mem_cgroup *memcg;
>>>=20
>>> -    return list_lru_del(lru, item, nid, memcg);
>>> +    rcu_read_lock();
>>> +    memcg =3D list_lru_memcg_aware(lru) ? =
mem_cgroup_from_slab_obj(item) : NULL;
>>> +    ret =3D list_lru_del(lru, item, nid, memcg);
>>> +    rcu_read_unlock();
>>> +
>>> +    return ret;
>>> }
>>> EXPORT_SYMBOL_GPL(list_lru_del_obj);
>>>=20
>>=20


