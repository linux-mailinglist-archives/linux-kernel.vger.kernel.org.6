Return-Path: <linux-kernel+bounces-411199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1179CF47D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520B72817BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE981E103B;
	Fri, 15 Nov 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rf8SisqS"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0217BB32
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697370; cv=none; b=flos48ETZWuVlSJSAngahnaO8Ya1/C9X72HwpOEbno5g8FNme6uVyzilN4nzU0lYZSf4W3Ihz0pLuq66+tjT4qoG5QkNKf/16povEqjGUovLAX9xt/vdZnb8KS4Ejmc5DoDOZfJkMonJgaEGUNHrQy4CHXEUUpHJL1gSq2/ERv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697370; c=relaxed/simple;
	bh=SBhsfuRbWNkIfKVu45f7icBi9k/Dg00fPBiS/Quotvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQ+atXxA2M7Xir3fRJ9hsn0GAjqIovfM0H/b3z3IsrlSdiBnyen1nCZRCRQjrOEINhhjQZiMDb7+QgXeLqCdOcScBuqXOXu3SlLOY0bgC5SaMaR8kgAkURVgoRuJMcaHoeBOM37oJyccs92gO9pCrA/4nkcn4BIq/sBrWpnIV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rf8SisqS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731697365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VzlgiHC0yz0XkmBlZ14ltqdVdQSzRi2uwbEBaytUOF4=;
	b=Rf8SisqSTA/YQBQdIRdZLiQVOG/HVTGj0EDAPzd0PZMPWCxQvcQnN3lG9nrHSBGhTFQSg9
	dWMhNjkT3upesKaai2op5x8//92pP50cZkYFWMq2QnDTzR2LvyL+S6Ez9OXJFf75VIofA7
	N7u44jPUek/fY+RtLeWqrM6HK7DeFsI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 1/2] mm: swap_cgroup: allocate swap_cgroup map using vcalloc()
Date: Fri, 15 Nov 2024 19:02:28 +0000
Message-ID: <20241115190229.676440-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently swap_cgroup's map is constructed as a vmalloc()'s-based
array of pointers to individual struct pages. This brings an
unnecessary complexity into the code.

This patch turns the swap_cgroup's map into a single space
allocated by vcalloc().

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/swap_cgroup.c | 83 ++++++++----------------------------------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index da1278f0563b..18de498c84a4 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -6,17 +6,18 @@
 #include <linux/swapops.h> /* depends on mm.h include */
 
 static DEFINE_MUTEX(swap_cgroup_mutex);
+
+struct swap_cgroup {
+	unsigned short		id;
+};
+
 struct swap_cgroup_ctrl {
-	struct page **map;
-	unsigned long length;
+	struct swap_cgroup *map;
 	spinlock_t	lock;
 };
 
 static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
 
-struct swap_cgroup {
-	unsigned short		id;
-};
 #define SC_PER_PAGE	(PAGE_SIZE/sizeof(struct swap_cgroup))
 
 /*
@@ -33,44 +34,10 @@ struct swap_cgroup {
  * TODO: we can push these buffers out to HIGHMEM.
  */
 
-/*
- * allocate buffer for swap_cgroup.
- */
-static int swap_cgroup_prepare(int type)
-{
-	struct page *page;
-	struct swap_cgroup_ctrl *ctrl;
-	unsigned long idx, max;
-
-	ctrl = &swap_cgroup_ctrl[type];
-
-	for (idx = 0; idx < ctrl->length; idx++) {
-		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (!page)
-			goto not_enough_page;
-		ctrl->map[idx] = page;
-
-		if (!(idx % SWAP_CLUSTER_MAX))
-			cond_resched();
-	}
-	return 0;
-not_enough_page:
-	max = idx;
-	for (idx = 0; idx < max; idx++)
-		__free_page(ctrl->map[idx]);
-
-	return -ENOMEM;
-}
-
 static struct swap_cgroup *__lookup_swap_cgroup(struct swap_cgroup_ctrl *ctrl,
 						pgoff_t offset)
 {
-	struct page *mappage;
-	struct swap_cgroup *sc;
-
-	mappage = ctrl->map[offset / SC_PER_PAGE];
-	sc = page_address(mappage);
-	return sc + offset % SC_PER_PAGE;
+	return &ctrl->map[offset];
 }
 
 static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
@@ -168,32 +135,20 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
 {
-	void *array;
-	unsigned long length;
+	struct swap_cgroup *map;
 	struct swap_cgroup_ctrl *ctrl;
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
-
-	array = vcalloc(length, sizeof(void *));
-	if (!array)
+	map = vcalloc(max_pages, sizeof(struct swap_cgroup));
+	if (!map)
 		goto nomem;
 
 	ctrl = &swap_cgroup_ctrl[type];
 	mutex_lock(&swap_cgroup_mutex);
-	ctrl->length = length;
-	ctrl->map = array;
+	ctrl->map = map;
 	spin_lock_init(&ctrl->lock);
-	if (swap_cgroup_prepare(type)) {
-		/* memory shortage */
-		ctrl->map = NULL;
-		ctrl->length = 0;
-		mutex_unlock(&swap_cgroup_mutex);
-		vfree(array);
-		goto nomem;
-	}
 	mutex_unlock(&swap_cgroup_mutex);
 
 	return 0;
@@ -205,8 +160,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 
 void swap_cgroup_swapoff(int type)
 {
-	struct page **map;
-	unsigned long i, length;
+	struct swap_cgroup *map;
 	struct swap_cgroup_ctrl *ctrl;
 
 	if (mem_cgroup_disabled())
@@ -215,19 +169,8 @@ void swap_cgroup_swapoff(int type)
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl = &swap_cgroup_ctrl[type];
 	map = ctrl->map;
-	length = ctrl->length;
 	ctrl->map = NULL;
-	ctrl->length = 0;
 	mutex_unlock(&swap_cgroup_mutex);
 
-	if (map) {
-		for (i = 0; i < length; i++) {
-			struct page *page = map[i];
-			if (page)
-				__free_page(page);
-			if (!(i % SWAP_CLUSTER_MAX))
-				cond_resched();
-		}
-		vfree(map);
-	}
+	kvfree(map);
 }
-- 
2.47.0.338.g60cca15819-goog


