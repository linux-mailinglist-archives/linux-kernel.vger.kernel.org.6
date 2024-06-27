Return-Path: <linux-kernel+bounces-231976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3DB91A110
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C1B1F22009
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29777F15;
	Thu, 27 Jun 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="onetD7Ma"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAE31758
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475282; cv=none; b=iE0SWWtdASwnMro9sQvKI8WS40WMLWHRqLWZxj+s/S6QBMvDT5do+KnTgTTqkT+NyospiETjqPwXSyYeGlRO/jm+4kkzJegyLSld2Tn3RtS/jMnZdQb0Gn+qDX4rY9gKs/AKnEcRGHNgYHY07eUfIorRbprWzkdtXw7DoUFmxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475282; c=relaxed/simple;
	bh=vMuEhhSyXUZ3tM2qDXva3YSqbJlRLmXGFGoGXqgtvK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuKGnFipARVav/G1rp6qBlkEw/auIILUsglqk98iOEqBmg7palPUuHmcADBIsE/w1n4slBbcbZ2tU3WosxcU0J5euoVATlmcnCc+VFSSYK0haPKoD2FstYb3CT9yRKJeOAPVJaJDZuzGYzWsiulvXdhUvNnRyPWRjZn4IWcKMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=onetD7Ma; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: minchan@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719475278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLaVUbIzK4uy17+aNn995y1ea9NwFkc4qJomwmgNMH0=;
	b=onetD7MadjrwiRohJi7DIxKPhHmIiojjfSQSPlRGIFGOdstA62rHNjHOpdis3341h4iEJ4
	mpoA/KOV+fyTEipHhyH4PAfAo5BXP6ii137lGk7O5MWOnpeVnwc5QeLasHHL/DMeejhxz5
	zCx7TZ/1auPzMNE/v/PrtM8qurAKbDQ=
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev
Subject: [PATCH 2/2] mm/zsmalloc: move record_obj() into obj_malloc()
Date: Thu, 27 Jun 2024 15:59:59 +0800
Message-Id: <20240627075959.611783-2-chengming.zhou@linux.dev>
In-Reply-To: <20240627075959.611783-1-chengming.zhou@linux.dev>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We always record_obj() to make handle points to object after obj_malloc(),
so simplify the code by moving record_obj() into obj_malloc(). There
should be no functional change.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zsmalloc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7fc25fa4e6b3..c2f4e62ffb46 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1306,7 +1306,6 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	void *vaddr;
 
 	class = pool->size_class[zspage->class];
-	handle |= OBJ_ALLOCATED_TAG;
 	obj = get_freeobj(zspage);
 
 	offset = obj * class->size;
@@ -1322,15 +1321,16 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
 	if (likely(!ZsHugePage(zspage)))
 		/* record handle in the header of allocated chunk */
-		link->handle = handle;
+		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
 		/* record handle to page->index */
-		zspage->first_page->index = handle;
+		zspage->first_page->index = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
 	obj = location_to_obj(m_page, obj);
+	record_obj(handle, obj);
 
 	return obj;
 }
@@ -1348,7 +1348,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  */
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 {
-	unsigned long handle, obj;
+	unsigned long handle;
 	struct size_class *class;
 	int newfg;
 	struct zspage *zspage;
@@ -1371,10 +1371,9 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj = obj_malloc(pool, zspage, handle);
+		obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
-		record_obj(handle, obj);
 		class_stat_inc(class, ZS_OBJS_INUSE, 1);
 
 		goto out;
@@ -1389,10 +1388,9 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	}
 
 	spin_lock(&class->lock);
-	obj = obj_malloc(pool, zspage, handle);
+	obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
-	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
 	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	class_stat_inc(class, ZS_OBJS_INUSE, 1);
@@ -1591,7 +1589,6 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 		free_obj = obj_malloc(pool, dst_zspage, handle);
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
-		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj);
 
 		/* Stop if there is no more space */
-- 
2.20.1


