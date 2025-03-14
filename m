Return-Path: <linux-kernel+bounces-560754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79168A6090F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D6317FD00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FEE19004B;
	Fri, 14 Mar 2025 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7191N8V"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDA18C039
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932949; cv=none; b=qUPQGmTKskSUhIPImbYKFgowIJ4ry1EXYPh4Lqy9UfvNQ/fDDpZvSxSTic93U05GA8Z2wtfNPRnGXvy8jkPPEqRZ9XgXtLyylmxVGm7uuMeNyr9EVlpg5OEJz6eibrwkSrAT+2r5c7Wmoj1SPu8flO5AE0cGq2qxkMVEcQTu7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932949; c=relaxed/simple;
	bh=zuchniEhDmUBC9X7u8R4xdltILbNO0cwprPM/OBuxLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RanDjRvGw51KYWIoYnyS6eXVEenmBxvIozj8tf054tf1T4E/OT+0kctpuTig/2AnSrkgH/VLZ5H+5aEojBm31DGFXJ6aLyD+cxZHfq+hj7q38bX5Xgiu2Fn1mrAmR9hJdKOREXZHF4cYEODMX48dgbxcoQBNI5pe0I3eaVQf+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7191N8V; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc+pYdC/xOdelwTJP89jkCPlJBy7KhpTV1fBT5yIKFQ=;
	b=K7191N8VG4pwJwKAtbd57HzRApbLYVKRwODKb5dG+bBi82YQH9CObHi+r08ica5eqBu7tJ
	xD77JPOtkH2IbGmEsx+h8XqYr/yBfI8NF7nycM1cLg4A2nsTvABOYTPnxQkKGJENlzd59V
	yqtmNKe3bpW0fqRXy5bQUx64hkyFLiY=
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
Subject: [RFC PATCH 03/10] memcg: introduce memcg_uncharge
Date: Thu, 13 Mar 2025 23:15:04 -0700
Message-ID: <20250314061511.1308152-4-shakeel.butt@linux.dev>
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

At multiple places in memcontrol.c, the memory and memsw page counters
are being uncharged. This is error-prone. Let's move the functionality
to a newly introduced memcg_uncharge and call it from all those places.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 28cb75b5bc66..b54e3a1d23bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1816,6 +1816,13 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	return ret;
 }
 
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
+
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -1828,10 +1835,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock_pages) {
-		page_counter_uncharge(&old->memory, stock_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock_pages);
-
+		memcg_uncharge(old, stock_pages);
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
 
@@ -1893,9 +1897,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
 		 */
-		page_counter_uncharge(&memcg->memory, nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 		return;
 	}
 	__refill_stock(memcg, nr_pages);
@@ -2855,12 +2857,8 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
-			if (!mem_cgroup_is_root(memcg)) {
-				page_counter_uncharge(&memcg->memory, nr_pages);
-				if (do_memsw_account())
-					page_counter_uncharge(&memcg->memsw,
-							      nr_pages);
-			}
+			if (!mem_cgroup_is_root(memcg))
+				memcg_uncharge(memcg, nr_pages);
 
 			css_put(&memcg->css);
 		}
@@ -4689,9 +4687,7 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
-		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+		memcg_uncharge(ug->memcg, ug->nr_memory);
 		if (ug->nr_kmem) {
 			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
-- 
2.47.1


