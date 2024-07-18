Return-Path: <linux-kernel+bounces-256311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E2934C54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E821E28284E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA119137905;
	Thu, 18 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bqD0ebCp"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A312D1FA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301657; cv=none; b=ocSbpBCAbW190ZSjFpKmEOVgMIxwxSyHsauw6WswgKj7IJveVKaw6wRyp9X8KXkW3ziPK3D2IatfTLmcOpwIiyIK1rO0GBtcLDw+JTgFDZninDyTsmPUzQZZCvw77AG9Srtl/LlDEGmCvZdjcHRBx40+cEV1TZayrL5Gqx/291Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301657; c=relaxed/simple;
	bh=IfHDXa9N/+7SF+YoRUEpyGweRKIae/m5inzkjl9K83w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=r2TguJTAdkU3+CeeQog9dGSvCcYjM8yL6+Ui8x1qKZQfOI1OLexaU5YWh4bgNWKuDbpBcK1M9/GRWNaMHVc6+nxM/kntizQZ2+jUfKNclaDduLpZNkSmJrHQTOWtzWcLROI4wpFHydy6SHhN9ZJo51jc/0T4KKcvcGXsURwXwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bqD0ebCp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721301652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PnGey5McE5FQao9lIF/IWdEuDxFp9LqXLKRL3lwW64=;
	b=bqD0ebCpwiJakwQbd+nu95d613nzy6ckidLCqOh2xzUWixV8sspQhYrFGmBO4lP2F8YbaV
	vJsJcRBQpJz1J6bGdbQ6zZzGHdqteuftrI4r/zUckUk7tJaFoaU/TPsRcH/Cogx77BP7LD
	/PFM+cvX0x1spMxK4SPBiwDisYj3KgM=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: mhocko@kernel.org
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Date: Thu, 18 Jul 2024 19:20:14 +0800
Message-Id: <E0A7CC1A-B02C-4210-A1DF-0600E027D5D0@linux.dev>
References: <65b7d88b-af4f-4869-9322-e38910abce6d@suse.cz>
Cc: Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, nphamcs@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
In-Reply-To: <65b7d88b-af4f-4869-9322-e38910abce6d@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT



> On Jul 18, 2024, at 18:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> =EF=BB=BFOn 7/18/24 10:36 AM, Muchun Song wrote:
>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>> lock or cgroup_mutex or others which could prevent returned memcg
>> from being freed. Fix it by adding missing rcu read lock.
>=20
> Was the UAF ever observed, or is this due to code review?

Just code review.

Thanks.

> Should there be some lockdep_assert somwhere?
>=20

It=E2=80=99s a good option to improve this. Maybe mem_cgroup_from_slab_obj()=
 is a good place.

>> Fixes: 0a97c01cd20bb ("list_lru: allow explicit memcg and NUMA node selec=
tion)
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/list_lru.c | 24 ++++++++++++++++++------
>> 1 file changed, 18 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>> index 3fd64736bc458..225da0778a3be 100644
>> --- a/mm/list_lru.c
>> +++ b/mm/list_lru.c
>> @@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, i=
nt idx)
>> }
>> #endif /* CONFIG_MEMCG_KMEM */
>>=20
>> +/* The caller must ensure the memcg lifetime. */
>> bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
>>            struct mem_cgroup *memcg)
>> {
>> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>>=20
>> bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>> {
>> +    bool ret;
>>    int nid =3D page_to_nid(virt_to_page(item));
>> -    struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>> -        mem_cgroup_from_slab_obj(item) : NULL;
>> +    struct mem_cgroup *memcg;
>>=20
>> -    return list_lru_add(lru, item, nid, memcg);
>> +    rcu_read_lock();
>> +    memcg =3D list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item)=
 : NULL;
>> +    ret =3D list_lru_add(lru, item, nid, memcg);
>> +    rcu_read_unlock();
>> +
>> +    return ret;
>> }
>> EXPORT_SYMBOL_GPL(list_lru_add_obj);
>>=20
>> +/* The caller must ensure the memcg lifetime. */
>> bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
>>            struct mem_cgroup *memcg)
>> {
>> @@ -139,11 +146,16 @@ EXPORT_SYMBOL_GPL(list_lru_del);
>>=20
>> bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
>> {
>> +    bool ret;
>>    int nid =3D page_to_nid(virt_to_page(item));
>> -    struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>> -        mem_cgroup_from_slab_obj(item) : NULL;
>> +    struct mem_cgroup *memcg;
>>=20
>> -    return list_lru_del(lru, item, nid, memcg);
>> +    rcu_read_lock();
>> +    memcg =3D list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item)=
 : NULL;
>> +    ret =3D list_lru_del(lru, item, nid, memcg);
>> +    rcu_read_unlock();
>> +
>> +    return ret;
>> }
>> EXPORT_SYMBOL_GPL(list_lru_del_obj);
>>=20
>=20

