Return-Path: <linux-kernel+bounces-562690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF0A6310E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE7F16C5F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F92063C5;
	Sat, 15 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UCQl96Wa"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61140205E35
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060998; cv=none; b=bB2/JI21JTzQ+os3YwpJujIAlfFEEnBsTX1Eh1qYRJhFFlX6FQp/7LhCn9GJ4NB/ivwpzUM8r+GjCZytoQjJmwum7GV7cc2kUeiL2as6lunoq7Gj5AaCg7dkyODhrohahrXYVV5IlX8l36WU7EgX8OKjD3PYR8bLwnRbmphKsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060998; c=relaxed/simple;
	bh=DBl+8SmuUNvZkuieHKG5QGJI7Ytycb/wKCyDKUFwDHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMqYTjTwSJxCpF4K9Nodm8v4CSG7ADy7CmQl575hS+X0+P9NJglwl8bBLSX7ilMHQ/RfdL8crk/yXYIOp4z/tfag1ZG7Aa/GhbD0WG35PZApJF3n4WXv+SW12TtPiNlP9fDP7HqhQBwlT26XgXzQzAHZsjHgYDwDFD0pvhXIIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UCQl96Wa; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc6pQ9m45TBV5JfKg0PdI6TDpBclbZtCDqtLw9XzNuU=;
	b=UCQl96Wa1/yEqZlafoPIygsX+2cWELzvlzoYrINa1G0wvMDEnFDPIjjN7q4Jw2b+9PzjIQ
	IdojMmemgziZOSXNmvSCv6u3VhSKT8RUTTHb5RfhZ0lRiieq8JAC75DNFjhgeKcfJA0DEC
	/WgjCitdjgMpbaZKjihNY1nTs+Dk+Tc=
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
Subject: [PATCH 4/9] memcg: manually inline __refill_stock
Date: Sat, 15 Mar 2025 10:49:25 -0700
Message-ID: <20250315174930.1769599-5-shakeel.butt@linux.dev>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
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


