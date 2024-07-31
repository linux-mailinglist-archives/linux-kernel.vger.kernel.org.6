Return-Path: <linux-kernel+bounces-268959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F5942B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE791C20EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42B1AAE16;
	Wed, 31 Jul 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbqpl8h5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555118DF88
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420405; cv=none; b=a4p4nYXJPk0FI1T6P4eBI/+Bd7vf88jZm1AY4SRlTy6My1ikPfIO1HeJkLfJrzYP4fHB/3Reb3xsUlK2zdfSAZ6DabOiqte5BndxG4ne7UNtVu5DMr51yqqVMA7gPKpPFkjiVW13jpWDV38fVAmZ1l6aED+3LGqgxmlegwVkvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420405; c=relaxed/simple;
	bh=AvjBWHvaQdv61maw9aImbeXOicW4mkIR+r2NHBwTos8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC2/MOnNoYLOWKgDyx4F9p7UrBPiW0XcEJsh5GQ+JJoEQikqPagOs0qJ50cWOgM9bnMNQc2qhtI+T+T8zW2tf/9d3WtNbSXOrjc1eX1lOcViS1rn8Jc1uQgRZ7KIlQaDO6HnXiY+kfHtb81wWT44vXlVDx+KT40pk4M/eT7bzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbqpl8h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEC4C116B1;
	Wed, 31 Jul 2024 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722420405;
	bh=AvjBWHvaQdv61maw9aImbeXOicW4mkIR+r2NHBwTos8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qbqpl8h5FcDPo9O0ygf4AR9FnAyWIdcLjjhithvfG4xnOgVWojiDlSdoVN+e7DHMr
	 +YaXXZosDcT+Em9sMDft4T+LdZMsqAUfAcBguJ1fnAPZq49Tg7SvaqSsWp2c/0NgvF
	 deEU1VG0fjnM88vxbKOCyz9OHHI0k6TMC7LepvivV3rwZpQLAE6H6ZbSM2vN/vuqd6
	 vNENol7GTiX8LDr5SvdX2e7Kbhhy6R6g/3iZwoiwLJ7naylEiU3gQKplSnHq9LpHBa
	 Z0v4+yc9oJjDcU/uz8OtGHM3XtNFp8WWXUGYvEYW5pK60lzwlKywLqjiYlb78NYqPw
	 T+oiIwECAxHhA==
Message-ID: <e3415fe1-e5de-49a6-a0bc-5684aa0a4ac1@kernel.org>
Date: Wed, 31 Jul 2024 12:06:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
 <20240723174540.18992614c476d77e7d9fb1e6@linux-foundation.org>
 <62BBC2A6-D6C3-48B8-B049-932E3BC16F31@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <62BBC2A6-D6C3-48B8-B049-932E3BC16F31@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 4:23 AM, Muchun Song wrote:
> 
> 
>> On Jul 24, 2024, at 08:45, Andrew Morton <akpm@linux-foundation.org> wrote:
>> 
>> On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>> 
>>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>>> lock or cgroup_mutex or others which could prevent returned memcg
>>> from being freed. Fix it by adding missing rcu read lock.
>> 
>> "or others" is rather vague.  What others?
> 
> Like objcg_lock. I have added this one into obj_cgroup_memcg().
> 
>> 
>>> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>>> 
>>> bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>>> {
>>> + 	bool ret;
>>> 	int nid = page_to_nid(virt_to_page(item));
>>> - 	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
>>> - 	mem_cgroup_from_slab_obj(item) : NULL;
>>> + 	struct mem_cgroup *memcg;
>>> 
>>> - 	return list_lru_add(lru, item, nid, memcg);
>>> + 	rcu_read_lock();
>>> + 	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
>>> + 	ret = list_lru_add(lru, item, nid, memcg);
>>> + 	rcu_read_unlock();
>> 
>> We don't need rcu_read_lock() to evaluate NULL.
>> 
>> 	memcg = NULL;
>> 	if (list_lru_memcg_aware(lru)) {
>> 		rcu_read_lock();
>> 		memcg = mem_cgroup_from_slab_obj(item);
>> 		rcu_read_unlock();
> 
> Actually, the access to memcg is in list_lru_add(), so the rcu lock should
> also cover this function rather than only mem_cgroup_from_slab_obj().
> Something like:
> 
> memcg = NULL;
> if (list_lru_memcg_aware(lru)) {
> 	rcu_read_lock();
> 	memcg = mem_cgroup_from_slab_obj(item);
> }
> ret = list_lru_add(lru, item, nid, memcg);
> if (list_lru_memcg_aware(lru))
> 	rcu_read_unlock();
> 
> Not concise. I don't know if this is good.

At such point, it's probably best to just:

if (list_lru_memcg_aware(lru)) {
	rcu_read_lock();
	ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
	rcu_read_unlock();
} else {
	list_lru_add(lru, item, nid, NULL);
}

?

> 
>> 	}
>> 
>> Seems worthwhile?
>> 
>> 
> 
> 


