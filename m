Return-Path: <linux-kernel+bounces-254610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BD393356A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2205A1C211BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763234C99;
	Wed, 17 Jul 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="er4erhwE"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D406116
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183150; cv=none; b=sa0/wielKH+Dfx5JxCa7AsOCCc6JmNnJ079eqICOqwae985lHxm1szOcA90iIwJzibDLiFP9bXbnmQw8VNHqd4feRiiYnmbtdXrCVmVrjD9Imi8RNlQRQu6hNmls8g62kyjh++1KdYddmMIjPS+HZPJ3LYO6Vd5DdBpbxylivcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183150; c=relaxed/simple;
	bh=2UiDmW4igchQm6oe53x5GQGKaEqQAnUkMkC5FHPjhYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UezNL7H9GE+Epbd0rzyI3bV7ZSFTAOAvyC/5D/2APgBjbSQgJuKMJ9SOqWP3AdIIVuj8DKwWvLkBciuEBeAXDrENgqxY1cO+5emfNYr/OX1ybCMx27zDaXBzlhuuZoF52y3HDQ8o2HDVae4Y/Idhpc82z+fDs12iRIQ8UBnwJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=er4erhwE; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zhengqi.arch@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721183144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30BQG0YFrLuwyR4GyhsvLZYo3tePM7M64A2WhdMUMM=;
	b=er4erhwEyw0FD29E5+7gNWVG6CwtegTTz5txeEu/JmbaD5DMnhSNQsROOVDXesbgSl3TjC
	oyKowVzXFgwgO19PmP3LirCvqQ1vJoox+asytPlN9BTXzw7kWeMLonYcgTNbZsntDUCqJR
	zPt373jfZohVCqViRcrA+NcSjxZ6uOA=
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Message-ID: <68e2ecad-e8ee-4dd5-a49e-8f8507d4e03c@linux.dev>
Date: Wed, 17 Jul 2024 10:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
 <56a81429-4e1e-46f9-8844-acb1afd66952@bytedance.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <56a81429-4e1e-46f9-8844-acb1afd66952@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 15/07/2024 11:27, Qi Zheng wrote:
>
>
> On 2024/7/12 12:07, Kent Overstreet wrote:
>> On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>
>>> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
>>> to error handle the return value to avoid triggering NULL pointer
>>> dereference BUG.
>>>
>>> The issue was triggered for discussion [1],
>>> Link [1]: 
>>> https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
>>
>> I see no explanation for why this is the correct fix, and I doubt it is.
>> What's the real reason for the NULL lru_list_one, and why doesn't this
>> come up on other filesystems?
>
> Agree, IIRC, the list_lru_one will be pre-allocated in the allocation
> path of inode/dentry etc.
Yes, this issue does not fix why lru_list_one is NULL.

lru_list_one is NULL because the inode is allocated using kmem_cache_alloc()
instead of kmem_cache_alloc_lru(), and the lru argument passed to
slab_alloc_node() is NULL. See [1] for the actual fix.

However, the return value of list_lru_from_memcg_idx() may be NULL. When
list_lru_one is NULL, the kernel will panic directly. Do we need to add
error handling when list_lru_one is NULL in list_lru_{add, del}?

To avoid hiding the actual BUG(previous changes), we might make the 
following
changes,

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 3fd64736bc45..fa86d3eff90b 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -94,6 +94,9 @@ bool list_lru_add(struct list_lru *lru, struct 
list_head *item, int nid,
         spin_lock(&nlru->lock);
         if (list_empty(item)) {
                 l = list_lru_from_memcg_idx(lru, nid, 
memcg_kmem_id(memcg));
+               if (WARN_ON_ONCE(!l))
+                       goto out;
+
                 list_add_tail(item, &l->list);
                 /* Set shrinker bit if the first element was added */
                 if (!l->nr_items++)
@@ -102,6 +105,7 @@ bool list_lru_add(struct list_lru *lru, struct 
list_head *item, int nid,
                 spin_unlock(&nlru->lock);
                 return true;
         }
+out:
         spin_unlock(&nlru->lock);
         return false;
  }
@@ -126,12 +130,16 @@ bool list_lru_del(struct list_lru *lru, struct 
list_head *item, int nid,
         spin_lock(&nlru->lock);
         if (!list_empty(item)) {
                 l = list_lru_from_memcg_idx(lru, nid, 
memcg_kmem_id(memcg));
+               if (WARN_ON_ONCE(!l))
+                       goto out;
+
                 list_del_init(item);
                 l->nr_items--;
                 nlru->nr_items--;
                 spin_unlock(&nlru->lock);
                 return true;
         }
+out:
         spin_unlock(&nlru->lock);
         return false;
  }

Link:
[1]: 
https://lore.kernel.org/all/20240716025816.52156-1-youling.tang@linux.dev/

Thanks,
Youling.

