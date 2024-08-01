Return-Path: <linux-kernel+bounces-270552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD50944155
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090B61C227BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C941386D8;
	Thu,  1 Aug 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CXut+z9v"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB41369B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480188; cv=none; b=leLgzUqKKas+VbAyWGPsf+/fI9klROCwpA7v5CN+NzC/FZFNqxk8MziKfposxq5opfRuiV2l5ZCjdccaiaP5gTwMFLnKwvImlTi/K5aRlxjk5TwV4hdRsPkB9IyCb8GN93Qntmw+UfBZzEdfErOzXs7TFHNdhhwqySfxzWSCdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480188; c=relaxed/simple;
	bh=fVIuLuTl5OGi9WKgnfgPL4/3K+1IPxdSwrutsPmreSM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cZiIBLLnmQmfowsUIc2kdiRYCeZk3WCpbO/pM9aDvsKL314KDW7pswPBOJQgHkt7C8r67N0rKxbv0E5A/l5kGL3adwuPgYuT96ztgp2OZGXuNmLSljDGZ2VbAse8VvQ8VaekIdtBU2v68tzJ+QdLYSOzX2IiFPYz7/jLAJaPCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXut+z9v; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722480184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1pmdeYWa+Lzpv2pjdW1po1MDOe6cIk4/35GzfdEkQk=;
	b=CXut+z9v81ShKg7s0PJUKYgpbAXt+JbA3Ns89bC8sDIWAJJHT6Z+lAiAQ+Q/rm70pUHHS4
	6s9xrN+l5dlsHnA5ihhJwHPtK1yW3XIwEArReJxUSZKksJ3nDrpEgriTqzGsAHEMl9W8AU
	yhnI93siI8DwuwXmAvERcCYs2oGS6jk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e3415fe1-e5de-49a6-a0bc-5684aa0a4ac1@kernel.org>
Date: Thu, 1 Aug 2024 10:42:31 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F44A592F-15BF-4406-A073-9CF7741956A0@linux.dev>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
 <20240723174540.18992614c476d77e7d9fb1e6@linux-foundation.org>
 <62BBC2A6-D6C3-48B8-B049-932E3BC16F31@linux.dev>
 <e3415fe1-e5de-49a6-a0bc-5684aa0a4ac1@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 31, 2024, at 18:06, Vlastimil Babka (SUSE) <vbabka@kernel.org> =
wrote:
>=20
> On 7/24/24 4:23 AM, Muchun Song wrote:
>>=20
>>=20
>>> On Jul 24, 2024, at 08:45, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>>>=20
>>> On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>>>=20
>>>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>>>> lock or cgroup_mutex or others which could prevent returned memcg
>>>> from being freed. Fix it by adding missing rcu read lock.
>>>=20
>>> "or others" is rather vague.  What others?
>>=20
>> Like objcg_lock. I have added this one into obj_cgroup_memcg().
>>=20
>>>=20
>>>> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>>>>=20
>>>> bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>>>> {
>>>> +  bool ret;
>>>> int nid =3D page_to_nid(virt_to_page(item));
>>>> -  struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>>>> -  mem_cgroup_from_slab_obj(item) : NULL;
>>>> +  struct mem_cgroup *memcg;
>>>>=20
>>>> -  return list_lru_add(lru, item, nid, memcg);
>>>> +  rcu_read_lock();
>>>> +  memcg =3D list_lru_memcg_aware(lru) ? =
mem_cgroup_from_slab_obj(item) : NULL;
>>>> +  ret =3D list_lru_add(lru, item, nid, memcg);
>>>> +  rcu_read_unlock();
>>>=20
>>> We don't need rcu_read_lock() to evaluate NULL.
>>>=20
>>> memcg =3D NULL;
>>> if (list_lru_memcg_aware(lru)) {
>>> rcu_read_lock();
>>> memcg =3D mem_cgroup_from_slab_obj(item);
>>> rcu_read_unlock();
>>=20
>> Actually, the access to memcg is in list_lru_add(), so the rcu lock =
should
>> also cover this function rather than only mem_cgroup_from_slab_obj().
>> Something like:
>>=20
>> memcg =3D NULL;
>> if (list_lru_memcg_aware(lru)) {
>> rcu_read_lock();
>> memcg =3D mem_cgroup_from_slab_obj(item);
>> }
>> ret =3D list_lru_add(lru, item, nid, memcg);
>> if (list_lru_memcg_aware(lru))
>> rcu_read_unlock();
>>=20
>> Not concise. I don't know if this is good.
>=20
> At such point, it's probably best to just:
>=20
> if (list_lru_memcg_aware(lru)) {
> 	rcu_read_lock();
> 	ret =3D list_lru_add(lru, item, nid, =
mem_cgroup_from_slab_obj(item));
> 	rcu_read_unlock();
> } else {
> 	list_lru_add(lru, item, nid, NULL);
> }

Good. Will update v2.

Thanks.

>=20
> ?
>=20
>>=20
>>> }
>>>=20
>>> Seems worthwhile?



