Return-Path: <linux-kernel+bounces-353873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E669933E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCD4B274E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879511DCB02;
	Mon,  7 Oct 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5voKT0C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUfWTlem"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173211DC19E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319798; cv=none; b=EkxxH+EkhaCF4lZRuAGF6MR1P6VBq8sYF9fZFDly7wFhzBc5L0sjtJyJXwFuzY06DrAfzMxzHQ5CImJVc8AEbH2vNUFYHZ84wz8GvVE0scmbg9Xe9EyRL9sHzk4iCIz60QsWVRxrbj4U+ak7SYrDNXKouC53gvdOPyUY55LFx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319798; c=relaxed/simple;
	bh=CDFExI07QVdtD4rjmNZ/S8LS9EUlOppWlLJr4Y2xIM4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MDrDfTpE+daRdXqlhTdah3MUQYWqP6m9H7PgKrQ+ArYoF0ubeJHmasPrnwQdCsR4g/U6c5plsSbtlFJkXUidEuZ7d2cZOfHrALNyEZG5x2AsE29xF6UV5APXfVLTmpH+WtVexqVWTcVs0E+OFcX3nkf86dqsvfxeYk10NdZbbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5voKT0C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUfWTlem; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.137021337@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rwVsd0p+SkppHSCskbEcnj79RSfR5XhMLN6cQUML+8o=;
	b=I5voKT0CnI1KLxFAO/JD1uJsWX8dpRPaD6qGJ3shQHp9gCN2XQYqPrOZVJqxvUl3a0rWuJ
	wFOSwEYtp9Fu84+PrJ3bvL4Q3iftIEklxXrWyFkGBKKgD4VpGv2WHwFOhbU2l6Mio9Lnmt
	dPT3t96vP8RPtvd6a7blOT+G7+yfqlhhaQeUzAx0+QmD9KJxO4LPUwjBo1Y+XXH6o5wk69
	uN/nvLrl5s8b0UUzgQFtXaK64I1L6mKuAwm39BXIhpMOSjIiZwY66/KaPgIflhjfVsu/aB
	iCM+o54d3uJ5vmJFbta2b0Y44qW4Nqc/i8Axfma13ys9Pmpm5agMGf/Rq71NDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rwVsd0p+SkppHSCskbEcnj79RSfR5XhMLN6cQUML+8o=;
	b=GUfWTlem6G6KUraRtn0r1DJgovJNlPsZeh4GoiBf89ZBNQYQbAr6lGtFcvZBUn9apr2DNm
	XoAGYgJnf8okDJBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:54 +0200 (CEST)

debug_objects_mem_init() is invoked from mm_core_init() before work queues
are available. If debug_objects_mem_init() destroys the kmem cache in the
error path it causes an Oops in __queue_work():

 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 RIP: 0010:__queue_work+0x35/0x6a0
  queue_work_on+0x66/0x70
  flush_all_cpus_locked+0xdf/0x1a0
  __kmem_cache_shutdown+0x2f/0x340
  kmem_cache_destroy+0x4e/0x150
  mm_core_init+0x9e/0x120
  start_kernel+0x298/0x800
  x86_64_start_reservations+0x18/0x30
  x86_64_start_kernel+0xc5/0xe0
  common_startup_64+0x12c/0x138

Further the object cache pointer is used in various places to check for
early boot operation. It is exposed before the replacments for the static
boot time objects are allocated and the self test operates on it.

This can be avoided by:

     1) Running the self test with the static boot objects

     2) Exposing it only after the replacement objects have been added to
     	the pool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   68 +++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1211,7 +1211,7 @@ static __initconst const struct debug_ob
 
 static __initdata struct self_test obj = { .static_init = 0 };
 
-static void __init debug_objects_selftest(void)
+static bool __init debug_objects_selftest(void)
 {
 	int fixups, oldfixups, warnings, oldwarnings;
 	unsigned long flags;
@@ -1280,9 +1280,10 @@ static void __init debug_objects_selftes
 	descr_test = NULL;
 
 	local_irq_restore(flags);
+	return !!debug_objects_enabled;
 }
 #else
-static inline void debug_objects_selftest(void) { }
+static inline bool debug_objects_selftest(void) { return true; }
 #endif
 
 /*
@@ -1302,18 +1303,21 @@ void __init debug_objects_early_init(voi
 }
 
 /*
- * Convert the statically allocated objects to dynamic ones:
+ * Convert the statically allocated objects to dynamic ones.
+ * debug_objects_mem_init() is called early so only one CPU is up and
+ * interrupts are disabled, which means it is safe to replace the active
+ * object references.
  */
-static int __init debug_objects_replace_static_objects(void)
+static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	struct debug_obj *obj, *new;
+	struct hlist_node *tmp;
 	HLIST_HEAD(objects);
 	int i, cnt = 0;
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
-		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
+		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
 		hlist_add_head(&obj->node, &objects);
@@ -1322,12 +1326,6 @@ static int __init debug_objects_replace_
 	debug_objects_allocated += i;
 
 	/*
-	 * debug_objects_mem_init() is now called early that only one CPU is up
-	 * and interrupts have been disabled, so it is safe to replace the
-	 * active object references.
-	 */
-
-	/*
 	 * Replace the statically allocated objects list with the allocated
 	 * objects list.
 	 */
@@ -1347,15 +1345,14 @@ static int __init debug_objects_replace_
 		}
 	}
 
-	pr_debug("%d of %d active objects replaced\n",
-		 cnt, obj_pool_used);
-	return 0;
+	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
+	return true;
 free:
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		kmem_cache_free(cache, obj);
 	}
-	return -ENOMEM;
+	return false;
 }
 
 /*
@@ -1366,6 +1363,7 @@ static int __init debug_objects_replace_
  */
 void __init debug_objects_mem_init(void)
 {
+	struct kmem_cache *cache;
 	int cpu, extras;
 
 	if (!debug_objects_enabled)
@@ -1380,29 +1378,33 @@ void __init debug_objects_mem_init(void)
 	for_each_possible_cpu(cpu)
 		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
 
-	obj_cache = kmem_cache_create("debug_objects_cache",
-				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
-				      NULL);
+	if (!debug_objects_selftest())
+		return;
+
+	cache = kmem_cache_create("debug_objects_cache", sizeof (struct debug_obj), 0,
+				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
 
-	if (!obj_cache || debug_objects_replace_static_objects()) {
+	if (!cache || !debug_objects_replace_static_objects(cache)) {
 		debug_objects_enabled = 0;
-		kmem_cache_destroy(obj_cache);
-		pr_warn("out of memory.\n");
+		pr_warn("Out of memory.\n");
 		return;
-	} else
-		debug_objects_selftest();
-
-#ifdef CONFIG_HOTPLUG_CPU
-	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
-					object_cpu_offline);
-#endif
+	}
 
 	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
+	 * Adjust the thresholds for allocating and freeing objects
+	 * according to the number of possible CPUs available in the
+	 * system.
 	 */
 	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
 	debug_objects_pool_size += extras;
 	debug_objects_pool_min_level += extras;
+
+	/* Everything worked. Expose the cache */
+	obj_cache = cache;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+				  object_cpu_offline);
+#endif
+	return;
 }


