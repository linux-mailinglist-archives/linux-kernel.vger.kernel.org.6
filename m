Return-Path: <linux-kernel+bounces-560751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717AA6090B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4173617FCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D937156C71;
	Fri, 14 Mar 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lW53X41+"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA72153808
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932941; cv=none; b=ZmFS8ricgKgFYDJyU3PmKZllMlAM2yEpv6ok7nKGWTalSPuaHHMAqQCJHXQgroa80m7ia57OLP/q+WxQZjo/hARQD81+ADhh9O0CM+rGP99QwaaloDNklku0KrdvvdhmbazAyFw3CT3fikSVRZEs9vgX4YBSSgCQS7pb4t4bAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932941; c=relaxed/simple;
	bh=q7a/l+3dxZyatbmA+x05mtthRfHxYV4Q69VBf6eryFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDvyygzNjhgEt7aL9WNf+rXc6+Z26AlyVhC8njs95STFLQWFcI7YBiBLTezmS+sTqkikbY+1Dz7O8A7N7BFjOCs1Nxs7ygY//7dBBtanP4/JblpEZUdafWq5EbdrnFadAwiP1TNQ1MHUHQdRmJhOZaeVb1CWjGwq6u3qyJYRcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lW53X41+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHfMqiybfg/wadzE/r4pC5kSUqcreJExX0T8UoeIBCE=;
	b=lW53X41+bXtE/Pccr68GzJy8M1OGwPSERF3WpfrSeM1+eRyR6ZO5RUE+LGGoKkOl7MQME4
	6FhWXE8Ek04ZXXxR8nAGVb7rCa4kXqwDs+rNp9NJ0Yia1I8mVy/nQvi2NZZY0xRfeuZimx
	iF9NPX2PD5aazVpGSYv6Fk0c5u38YjU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 04/10] memcg: manually inline __refill_stock
Date: Thu, 13 Mar 2025 23:15:05 -0700
Message-ID: <20250314061511.1308152-5-shakeel.butt@linux.dev>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are no more multiple callers of __refill_stock(), so simply inline
it to refill_stock().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b54e3a1d23bd..7054b0ebd207 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1865,14 +1865,21 @@ static void drain_local_stock(struct work_struct *dummy)
 	obj_cgroup_put(old);
 }
 
-/*
- * Cache charges(val) to local per_cpu area.
- * This will be consumed by consume_stock() function, later.
- */
-static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+/* Should never be called with root_mem_cgroup. */
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
+	unsigned long flags;
+
+	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+		/*
+		 * In case of unlikely failure to lock percpu stock_lock
+		 * uncharge memcg directly.
+		 */
+		memcg_uncharge(memcg, nr_pages);
+		return;
+	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
@@ -1885,22 +1892,7 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
-}
 
-/* Should never be called with root_mem_cgroup. */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
-{
-	unsigned long flags;
-
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-		/*
-		 * In case of unlikely failure to lock percpu stock_lock
-		 * uncharge memcg directly.
-		 */
-		memcg_uncharge(memcg, nr_pages);
-		return;
-	}
-	__refill_stock(memcg, nr_pages);
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
-- 
2.47.1


