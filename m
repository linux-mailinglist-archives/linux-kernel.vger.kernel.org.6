Return-Path: <linux-kernel+bounces-324465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26E974CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1FBB25E69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9816F8E9;
	Wed, 11 Sep 2024 08:35:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1316DC12
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043753; cv=none; b=LfelyCZxSz7FKvt697uUThTjfO7beuyK255QHKnjwTSwIr2vdqMweV5e+s8Vzxh0xjpHtO3ryEVRD3NdGPGKu+dW5I+o5FF22uqNk4Vngj1NfvyIcHFRLxLCex2FuZ3u3kMEL43fOSZKlMnLfXjqN3v2+Gcxzp1LL+2q5TZbeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043753; c=relaxed/simple;
	bh=vi6ucJQyh1SziQ4nbh4q8HN3DFL1YqUMlKaTP+VcH1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPKDeS6iQel05jy5H/pPykiN4ybleRvorbHnWgCGjnUZplV4OLcmIqyTkMFw7OFF/2XnSbQNclBR6HjgQNimM8gZhtc+7DSNq8L0snOPimkyDrzEXCX1aYQwqf+EghVuMBoRejjkjmMGD3ObRQ9u3TEf+ANFIsr8we5cnyYm514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X3YkW1f0CzmYWg;
	Wed, 11 Sep 2024 16:33:39 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B84618006C;
	Wed, 11 Sep 2024 16:35:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 16:35:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in fill_pool()
Date: Wed, 11 Sep 2024 16:35:21 +0800
Message-ID: <20240911083521.2257-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240911083521.2257-1-thunder.leizhen@huawei.com>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

If the conditions for starting fill are met, it means that all cores that
call fill() later are blocked until the first core completes the fill
operation.

Since it is low cost to move a set of free nodes from list obj_to_free
into obj_pool, once it is necessary to fill, trying to move regardless
of whether the context is preemptible. To reduce contention on pool
lock, use atomic operation to test state. Only the first comer is allowed
to try. If the last comer finds that someone is already trying, it will
give up.

Scenarios that use allocated node filling can also be applied lockless
mechanisms, but slightly different. The global list obj_to_free can only
be operated exclusively by one core, while kmem_cache_zalloc() can be
invoked by multiple cores simultaneously. Use atomic counting to mark how
many cores are filling, to reduce atomic write conflicts during check. In
principle, only the first comer is allowed to fill, but there is a very
low probability that multiple comers may fill at the time.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 79 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 19a91c6bc67eb9c..568aae9cd9c3c4f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -125,14 +125,10 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
-static void fill_pool(void)
+static void fill_pool_from_freelist(void)
 {
-	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static unsigned long state;
 	struct debug_obj *obj;
-	unsigned long flags;
-
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
-		return;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -141,25 +137,53 @@ static void fill_pool(void)
 	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
 	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	if (!READ_ONCE(obj_nr_tofree))
+		return;
+
+	/*
+	 * Prevent the context from being scheduled or interrupted after
+	 * setting the state flag;
+	 */
+	guard(irqsave)();
+
+	/*
+	 * Avoid lock contention on &pool_lock and avoid making the cache
+	 * line exclusive by testing the bit before attempting to set it.
+	 */
+	if (test_bit(0, &state) || test_and_set_bit(0, &state))
+		return;
+
+	guard(raw_spinlock)(&pool_lock);
+	/*
+	 * Recheck with the lock held as the worker thread might have
+	 * won the race and freed the global free list already.
+	 */
+	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+		hlist_add_head(&obj->node, &obj_pool);
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 	}
+	clear_bit(0, &state);
+}
+
+static void fill_pool(void)
+{
+	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static atomic_t cpus_allocating;
 
 	if (unlikely(!obj_cache))
 		return;
 
+	/*
+	 * Avoid allocation and lock contention when another CPU is already
+	 * in the allocation path.
+	 */
+	if (atomic_read(&cpus_allocating))
+		return;
+
+	atomic_inc(&cpus_allocating);
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(freelist);
@@ -174,14 +198,14 @@ static void fill_pool(void)
 				last = new;
 		}
 		if (!cnt)
-			return;
+			break;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		guard(raw_spinlock_irqsave)(&pool_lock);
 		hlist_splice_init(&freelist, &last->node, &obj_pool);
 		debug_objects_allocated += cnt;
 		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
+	atomic_dec(&cpus_allocating);
 }
 
 /*
@@ -600,6 +624,15 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 
 static void debug_objects_fill_pool(void)
 {
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and
-- 
2.34.1


