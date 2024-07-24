Return-Path: <linux-kernel+bounces-260583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A506A93AB30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C801F23305
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C717571;
	Wed, 24 Jul 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALgziQ//"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25076134B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787870; cv=none; b=G3DTSMIjY9Cpb9nKxlr1curBF7GcIqqjD+rTbCJmXc5PH/rIrkaVyQau+7nqSoMO+cwZzy4nTdAPhc1TQRU1pPIDFZsSkfB9zrwSVDy+Uu+d7GSuN0Ipm2Q5inggy/dl0QMl2mTxLUkTGf97Tn9r+Q3rRv3YxtNad4fMleuwXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787870; c=relaxed/simple;
	bh=BvGsXL/JgX6GUqmfolhYf92QKVOLf/UNa/GGiX9WbJs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F3tKhTsurr4j7pL0LReqs6huIyqiktbKCogMOXFmnaBfM+gKehzqIm7GtsKiY56eL+87dgzgmFdqmC8xzisBfaB2ycDRPV4STlBwtuu5QRKKp829K4fhLuV/tx2lCwLaGHloIj0dNOI/svCzy/wNTg3o5fvRPTBVJNk4PJdCSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALgziQ//; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721787866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpolYlv0Jnv1Ymoo+FfzdPp8dy1j/5y+7C6zCgpN3ac=;
	b=ALgziQ//EGixEzlmfUfTyzaAIpYyVX0IwvtL6gVujv50Ji/oypOgovc4ddjnCrf5LatyGW
	zbTbzlz7FrsxNqFXal5qeimKflmVYnqxvKo8BTjvX+zepZev4qJ6ICnvWDfQAMAggTxyA0
	B29MieaNH1cWGXJqgJa0iVe84tgmrZg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240723174540.18992614c476d77e7d9fb1e6@linux-foundation.org>
Date: Wed, 24 Jul 2024 10:23:43 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62BBC2A6-D6C3-48B8-B049-932E3BC16F31@linux.dev>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
 <20240723174540.18992614c476d77e7d9fb1e6@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 24, 2024, at 08:45, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>> lock or cgroup_mutex or others which could prevent returned memcg
>> from being freed. Fix it by adding missing rcu read lock.
>=20
> "or others" is rather vague.  What others?

Like objcg_lock. I have added this one into obj_cgroup_memcg().

>=20
>> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>>=20
>> bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>> {
>> + 	bool ret;
>> 	int nid =3D page_to_nid(virt_to_page(item));
>> - 	struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
>> - 	mem_cgroup_from_slab_obj(item) : NULL;
>> + 	struct mem_cgroup *memcg;
>>=20
>> - 	return list_lru_add(lru, item, nid, memcg);
>> + 	rcu_read_lock();
>> + 	memcg =3D list_lru_memcg_aware(lru) ? =
mem_cgroup_from_slab_obj(item) : NULL;
>> + 	ret =3D list_lru_add(lru, item, nid, memcg);
>> + 	rcu_read_unlock();
>=20
> We don't need rcu_read_lock() to evaluate NULL.
>=20
> 	memcg =3D NULL;
> 	if (list_lru_memcg_aware(lru)) {
> 		rcu_read_lock();
> 		memcg =3D mem_cgroup_from_slab_obj(item);
> 		rcu_read_unlock();

Actually, the access to memcg is in list_lru_add(), so the rcu lock =
should
also cover this function rather than only mem_cgroup_from_slab_obj().
Something like:

memcg =3D NULL;
if (list_lru_memcg_aware(lru)) {
	rcu_read_lock();
	memcg =3D mem_cgroup_from_slab_obj(item);
}
ret =3D list_lru_add(lru, item, nid, memcg);
if (list_lru_memcg_aware(lru))
	rcu_read_unlock();

Not concise. I don't know if this is good.

> 	}
>=20
> Seems worthwhile?
>=20
>=20


