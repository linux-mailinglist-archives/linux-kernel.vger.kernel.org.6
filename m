Return-Path: <linux-kernel+bounces-413415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1AA9D18C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AF61F228E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A11E0DFC;
	Mon, 18 Nov 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXES0ki9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOMlOOma"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4517597
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957718; cv=none; b=QZQi3+S/4QHlKhI0ZX6HXNxqsvTBdQSvLr9PQqIG7mmEPOrsSSkMQzeFSvg02vdk98+cfIqpY/6jCVddJfzo3P/4kq9rdW4wfWxYTX71fxXl9VN7TJOUBTmQPhymzewLZuGPkKFWwENKriMetGx0dSShmzW0bzGFf4HEeA0ky/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957718; c=relaxed/simple;
	bh=eI2z4+4itN8g42Y4NJ4EyEjOgEHu2iIkRwdHmxqfDoE=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=uja2h+50OynI8Xm0cpSOUr1Jsm0IiLIiOyLpnnfdIpba6nDngmUvWwJrnkkU7P5Nw7GXY9qoFFiAoaULn/VJQeNKOA9U7C7WTc/+P2tP/34vuFDJIcjco7DCDjYmteVA88yQrTc8Ej5OaN2nMIhONHesoqqGfT48mICHgGqddD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FXES0ki9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOMlOOma; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731957713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ni2sUIgf41ZFPJUASn6mJguYGf3na9nMzyIBG89/k18=;
	b=FXES0ki9L2ZofrjOP6DR2dSH2Eecpefo6IcS3aEQQ36ZTS6NQ4hp98J13n61F2q7rvWi0d
	SVG+wcxkGlXH4oz6JshVfiZfq8uSffLoF9iD3rRvtLmfWuzMjIQjJUASfICvdoF4U/QwJv
	CAlM+KjpAGrWSwPJ811fvB1mga+Ib3fKabAN/P58972imhgjKOEWFL/9zgIsjw8TGrYTHB
	8oTViyfAvCGuXrtCTpoYqXhm4jAPSzKuvBEWzbQRUAwRKV9r6SLPhA/VkbBr3I5iq/Yi8U
	aZ/ImmpywD8wENV0Omzo9k9nKb24zvKHzyEhTc5YJG85vk0prRR5TNNJJ/NkFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731957713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ni2sUIgf41ZFPJUASn6mJguYGf3na9nMzyIBG89/k18=;
	b=tOMlOOmaTA4GM6S9qMVrtebxNzcIB8R862rG87vZD104z3TTWH0tV8W2tmvHYoHsxwHKTV
	npxZmbsabLdkGfAw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.13-rc1
Message-ID: <173195757899.1896928.6143737920583881655.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 20:21:47 +0100 (CET)

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2024-11-18

up to:  ff8d523cc452: debugobjects: Track object usage to avoid premature fre=
eing of objects

A set of changes for debugobjects:

  - Prevent destroying the kmem_cache on early failure.

    Destroying a kmem_cache requires work queues to be set up, but in the
    early failure case they are not yet initializated. So rather leak the
    cache instead of triggering a BUG.

  - Reduce parallel pool fill attempts.

    Refilling the object pool requires to take the global pool lock, which
    causes a massive performance issue when a large number of CPUs attempt
    to refill concurrently. It turns out that it's sufficient to let one
    CPU handle the refill from the to free list and in case there are not
    enough objects on it to allocate new objects from the kmem cache.

    This also splits the free list handling from the actual allocation path
    as that yields better results on RT where allocation is restricted to
    preemptible code paths. The refill from free list has no such
    restrictions.

  - Consolidate the global and the per CPU pools to use the same data
    structure, so all helper functions can be shared.

  - Simplify the object allocation/free logic.

    The allocation/free logic is an incomprehensible maze, which tries to
    utilize the to free list and the global pool in the best way. This all
    can be simplified into a straight forward comprehensible code flow.

  - Convert the allocation/free mechanism to batch mode.

    Transferring objects from the global pool to the per CPU pools or vice
    versa is done by walking the hlist and moving object by object. That
    not only increases the pool lock held time, it also dirties up to 17
    cache lines.

    This can be avoided by storing the pointer to the first object in a
    batch of 16 objects in the objects themself and propagate it through
    the batch when an object is enqueued into a pool or to a temporary
    hlist head on allocation.

    This allows to move batches of objects with at max four cache lines
    dirtied and reduces the pool lock held time and therefore contention
    significantly.

  - Improve the object reusage

    The current implementation is too agressively freeing unused objects,
    which is counterproductive on bursty workloads like a kernel compile.

    Address this by:

    	* increasing the per CPU pool size

	* refilling the per CPU pool from the to be freed pool when the per
          CPU pool emptied a batch

	* keeping track of object usage with a exponentially wheighted
          moving average which prevents the work queue callback to free
          objects prematuraly.

    This combined reduces the allocation/free rate for a full kernel
    compile significantly:

                kmem_cache_alloc()  kmem_cache_free()
    Baseline:   380k                330k
    Improved:   170k                117k

  - A few cleanups and a more cache line friendly layout of debug
    information on top.

Thanks,

	tglx

------------------>
Thomas Gleixner (22):
      debugobjects: Dont destroy kmem cache in init()
      debugobjects: Remove pointless hlist initialization
      debugobjects: Dont free objects directly on CPU hotplug
      debugobjects: Reuse put_objects() on OOM
      debugobjects: Remove pointless debug printk
      debugobjects: Provide and use free_object_list()
      debugobjects: Make debug_objects_enabled bool
      debugobjects: Move pools into a datastructure
      debugobjects: Use separate list head for boot pool
      debugobjects: Rename and tidy up per CPU pools
      debugobjects: Move min/max count into pool struct
      debugobjects: Rework object allocation
      debugobjects: Rework object freeing
      debugobjects: Rework free_object_work()
      debugobjects: Use static key for boot pool selection
      debugobjects: Prepare for batching
      debugobjects: Prepare kmem_cache allocations for batching
      debugobjects: Implement batch processing
      debugobjects: Move pool statistics into global_pool struct
      debugobjects: Double the per CPU slots
      debugobjects: Refill per CPU pool more agressively
      debugobjects: Track object usage to avoid premature freeing of objects

Zhen Lei (3):
      debugobjects: Delete a piece of redundant code
      debugobjects: Collect newly allocated objects in a list to reduce lock =
contention
      debugobjects: Reduce parallel pool fill attempts


 include/linux/debugobjects.h |  12 +-
 lib/debugobjects.c           | 849 ++++++++++++++++++++++++-----------------=
--
 2 files changed, 486 insertions(+), 375 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 32444686b6ff..8b95545e7924 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -23,13 +23,17 @@ struct debug_obj_descr;
  * @state:	tracked object state
  * @astate:	current active state
  * @object:	pointer to the real object
+ * @batch_last:	pointer to the last hlist node in a batch
  * @descr:	pointer to an object type specific debug description structure
  */
 struct debug_obj {
-	struct hlist_node	node;
-	enum debug_obj_state	state;
-	unsigned int		astate;
-	void			*object;
+	struct hlist_node		node;
+	enum debug_obj_state		state;
+	unsigned int			astate;
+	union {
+		void			*object;
+		struct hlist_node	*batch_last;
+	};
 	const struct debug_obj_descr *descr;
 };
=20
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473ad499b..7f50c4480a4e 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -7,25 +7,30 @@
=20
 #define pr_fmt(fmt) "ODEBUG: " fmt
=20
+#include <linux/cpu.h>
 #include <linux/debugobjects.h>
-#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/hash.h>
+#include <linux/kmemleak.h>
 #include <linux/sched.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seq_file.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
-#include <linux/hash.h>
-#include <linux/kmemleak.h>
-#include <linux/cpu.h>
+#include <linux/static_key.h>
=20
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
=20
-#define ODEBUG_POOL_SIZE	1024
-#define ODEBUG_POOL_MIN_LEVEL	256
-#define ODEBUG_POOL_PERCPU_SIZE	64
+/* Must be power of two */
 #define ODEBUG_BATCH_SIZE	16
=20
+/* Initial values. Must all be a multiple of batch size */
+#define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
+
+#define ODEBUG_POOL_PERCPU_SIZE	(8 * ODEBUG_BATCH_SIZE)
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
@@ -35,7 +40,7 @@
  * frequency of 10Hz and about 1024 objects for each freeing operation.
  * So it is freeing at most 10k debug objects per second.
  */
-#define ODEBUG_FREE_WORK_MAX	1024
+#define ODEBUG_FREE_WORK_MAX	(1024 / ODEBUG_BATCH_SIZE)
 #define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
=20
 struct debug_bucket {
@@ -43,16 +48,24 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
=20
-/*
- * Debug object percpu free list
- * Access is protected by disabling irq
- */
-struct debug_percpu_free {
-	struct hlist_head	free_objs;
-	int			obj_free;
+struct pool_stats {
+	unsigned int		cur_used;
+	unsigned int		max_used;
+	unsigned int		min_fill;
 };
=20
-static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+struct obj_pool {
+	struct hlist_head	objects;
+	unsigned int		cnt;
+	unsigned int		min_cnt;
+	unsigned int		max_cnt;
+	struct pool_stats	stats;
+} ____cacheline_aligned;
+
+
+static DEFINE_PER_CPU_ALIGNED(struct obj_pool, pool_pcpu)  =3D {
+	.max_cnt	=3D ODEBUG_POOL_PERCPU_SIZE,
+};
=20
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
=20
@@ -60,37 +73,32 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE=
] __initdata;
=20
 static DEFINE_RAW_SPINLOCK(pool_lock);
=20
-static HLIST_HEAD(obj_pool);
-static HLIST_HEAD(obj_to_free);
+static struct obj_pool pool_global =3D {
+	.min_cnt		=3D ODEBUG_POOL_MIN_LEVEL,
+	.max_cnt		=3D ODEBUG_POOL_SIZE,
+	.stats			=3D {
+		.min_fill	=3D ODEBUG_POOL_SIZE,
+	},
+};
=20
-/*
- * Because of the presence of percpu free pools, obj_pool_free will
- * under-count those in the percpu free pools. Similarly, obj_pool_used
- * will over-count those in the percpu free pools. Adjustments will be
- * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
- * can be off.
- */
-static int __data_racy		obj_pool_min_free =3D ODEBUG_POOL_SIZE;
-static int __data_racy		obj_pool_free =3D ODEBUG_POOL_SIZE;
-static int			obj_pool_used;
-static int __data_racy		obj_pool_max_used;
+static struct obj_pool pool_to_free =3D {
+	.max_cnt	=3D UINT_MAX,
+};
+
+static HLIST_HEAD(pool_boot);
+
+static unsigned long		avg_usage;
 static bool			obj_freeing;
-/* The number of objs on the global free list */
-static int			obj_nr_tofree;
=20
 static int __data_racy			debug_objects_maxchain __read_mostly;
 static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
-static int __data_racy			debug_objects_enabled __read_mostly
+static bool __data_racy			debug_objects_enabled __read_mostly
 					=3D CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int				debug_objects_pool_size __ro_after_init
-					=3D ODEBUG_POOL_SIZE;
-static int				debug_objects_pool_min_level __ro_after_init
-					=3D ODEBUG_POOL_MIN_LEVEL;
=20
-static const struct debug_obj_descr *descr_test  __read_mostly;
-static struct kmem_cache	*obj_cache __ro_after_init;
+static const struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache		*obj_cache __ro_after_init;
=20
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -101,19 +109,20 @@ static int __data_racy		debug_objects_freed;
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
=20
+static DEFINE_STATIC_KEY_FALSE(obj_cache_enabled);
+
 static int __init enable_object_debug(char *str)
 {
-	debug_objects_enabled =3D 1;
+	debug_objects_enabled =3D true;
 	return 0;
 }
+early_param("debug_objects", enable_object_debug);
=20
 static int __init disable_object_debug(char *str)
 {
-	debug_objects_enabled =3D 0;
+	debug_objects_enabled =3D false;
 	return 0;
 }
-
-early_param("debug_objects", enable_object_debug);
 early_param("no_debug_objects", disable_object_debug);
=20
 static const char *obj_states[ODEBUG_STATE_MAX] =3D {
@@ -125,61 +134,280 @@ static const char *obj_states[ODEBUG_STATE_MAX] =3D {
 	[ODEBUG_STATE_NOTAVAILABLE]	=3D "not available",
 };
=20
-static void fill_pool(void)
+static __always_inline unsigned int pool_count(struct obj_pool *pool)
+{
+	return READ_ONCE(pool->cnt);
+}
+
+static __always_inline bool pool_should_refill(struct obj_pool *pool)
+{
+	return pool_count(pool) < pool->min_cnt;
+}
+
+static __always_inline bool pool_must_refill(struct obj_pool *pool)
+{
+	return pool_count(pool) < pool->min_cnt / 2;
+}
+
+static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
 {
-	gfp_t gfp =3D __GFP_HIGH | __GFP_NOWARN;
+	struct hlist_node *last, *next_batch, *first_batch;
 	struct debug_obj *obj;
-	unsigned long flags;
=20
-	if (likely(READ_ONCE(obj_pool_free) >=3D debug_objects_pool_min_level))
+	if (dst->cnt >=3D dst->max_cnt || !src->cnt)
+		return false;
+
+	first_batch =3D src->objects.first;
+	obj =3D hlist_entry(first_batch, typeof(*obj), node);
+	last =3D obj->batch_last;
+	next_batch =3D last->next;
+
+	/* Move the next batch to the front of the source pool */
+	src->objects.first =3D next_batch;
+	if (next_batch)
+		next_batch->pprev =3D &src->objects.first;
+
+	/* Add the extracted batch to the destination pool */
+	last->next =3D dst->objects.first;
+	if (last->next)
+		last->next->pprev =3D &last->next;
+	first_batch->pprev =3D &dst->objects.first;
+	dst->objects.first =3D first_batch;
+
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
+	return true;
+}
+
+static bool pool_push_batch(struct obj_pool *dst, struct hlist_head *head)
+{
+	struct hlist_node *last;
+	struct debug_obj *obj;
+
+	if (dst->cnt >=3D dst->max_cnt)
+		return false;
+
+	obj =3D hlist_entry(head->first, typeof(*obj), node);
+	last =3D obj->batch_last;
+
+	hlist_splice_init(head, last, &dst->objects);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
+	return true;
+}
+
+static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
+{
+	struct hlist_node *last, *next;
+	struct debug_obj *obj;
+
+	if (!src->cnt)
+		return false;
+
+	/* Move the complete list to the head */
+	hlist_move_list(&src->objects, head);
+
+	obj =3D hlist_entry(head->first, typeof(*obj), node);
+	last =3D obj->batch_last;
+	next =3D last->next;
+	/* Disconnect the batch from the list */
+	last->next =3D NULL;
+
+	/* Move the node after last back to the source pool. */
+	src->objects.first =3D next;
+	if (next)
+		next->pprev =3D &src->objects.first;
+
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
+	return true;
+}
+
+static struct debug_obj *__alloc_object(struct hlist_head *list)
+{
+	struct debug_obj *obj;
+
+	if (unlikely(!list->first))
+		return NULL;
+
+	obj =3D hlist_entry(list->first, typeof(*obj), node);
+	hlist_del(&obj->node);
+	return obj;
+}
+
+static void pcpu_refill_stats(void)
+{
+	struct pool_stats *stats =3D &pool_global.stats;
+
+	WRITE_ONCE(stats->cur_used, stats->cur_used + ODEBUG_BATCH_SIZE);
+
+	if (stats->cur_used > stats->max_used)
+		stats->max_used =3D stats->cur_used;
+
+	if (pool_global.cnt < stats->min_fill)
+		stats->min_fill =3D pool_global.cnt;
+}
+
+static struct debug_obj *pcpu_alloc(void)
+{
+	struct obj_pool *pcp =3D this_cpu_ptr(&pool_pcpu);
+
+	lockdep_assert_irqs_disabled();
+
+	for (;;) {
+		struct debug_obj *obj =3D __alloc_object(&pcp->objects);
+
+		if (likely(obj)) {
+			pcp->cnt--;
+			/*
+			 * If this emptied a batch try to refill from the
+			 * free pool. Don't do that if this was the top-most
+			 * batch as pcpu_free() expects the per CPU pool
+			 * to be less than ODEBUG_POOL_PERCPU_SIZE.
+			 */
+			if (unlikely(pcp->cnt < (ODEBUG_POOL_PERCPU_SIZE - ODEBUG_BATCH_SIZE) &&
+				     !(pcp->cnt % ODEBUG_BATCH_SIZE))) {
+				/*
+				 * Don't try to allocate from the regular pool here
+				 * to not exhaust it prematurely.
+				 */
+				if (pool_count(&pool_to_free)) {
+					guard(raw_spinlock)(&pool_lock);
+					pool_move_batch(pcp, &pool_to_free);
+					pcpu_refill_stats();
+				}
+			}
+			return obj;
+		}
+
+		guard(raw_spinlock)(&pool_lock);
+		if (!pool_move_batch(pcp, &pool_to_free)) {
+			if (!pool_move_batch(pcp, &pool_global))
+				return NULL;
+		}
+		pcpu_refill_stats();
+	}
+}
+
+static void pcpu_free(struct debug_obj *obj)
+{
+	struct obj_pool *pcp =3D this_cpu_ptr(&pool_pcpu);
+	struct debug_obj *first;
+
+	lockdep_assert_irqs_disabled();
+
+	if (!(pcp->cnt % ODEBUG_BATCH_SIZE)) {
+		obj->batch_last =3D &obj->node;
+	} else {
+		first =3D hlist_entry(pcp->objects.first, typeof(*first), node);
+		obj->batch_last =3D first->batch_last;
+	}
+	hlist_add_head(&obj->node, &pcp->objects);
+	pcp->cnt++;
+
+	/* Pool full ? */
+	if (pcp->cnt < ODEBUG_POOL_PERCPU_SIZE)
 		return;
=20
+	/* Remove a batch from the per CPU pool */
+	guard(raw_spinlock)(&pool_lock);
+	/* Try to fit the batch into the pool_global first */
+	if (!pool_move_batch(&pool_global, pcp))
+		pool_move_batch(&pool_to_free, pcp);
+	WRITE_ONCE(pool_global.stats.cur_used, pool_global.stats.cur_used - ODEBUG_=
BATCH_SIZE);
+}
+
+static void free_object_list(struct hlist_head *head)
+{
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+	int cnt =3D 0;
+
+	hlist_for_each_entry_safe(obj, tmp, head, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+		cnt++;
+	}
+	debug_objects_freed +=3D cnt;
+}
+
+static void fill_pool_from_freelist(void)
+{
+	static unsigned long state;
+
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
 	 * reinitialized when allocating.
-	 *
-	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
-	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj =3D hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
+	if (!pool_count(&pool_to_free))
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
+	/* Avoid taking the lock when there is no work to do */
+	while (pool_should_refill(&pool_global) && pool_count(&pool_to_free)) {
+		guard(raw_spinlock)(&pool_lock);
+		/* Move a batch if possible */
+		pool_move_batch(&pool_global, &pool_to_free);
+	}
+	clear_bit(0, &state);
+}
+
+static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cac=
he, gfp_t gfp)
+{
+	struct hlist_node *last =3D NULL;
+	struct debug_obj *obj;
+
+	for (int cnt =3D 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+		obj =3D kmem_cache_zalloc(cache, gfp);
+		if (!obj) {
+			free_object_list(head);
+			return false;
 		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+		debug_objects_allocated++;
+
+		if (!last)
+			last =3D &obj->node;
+		obj->batch_last =3D last;
+
+		hlist_add_head(&obj->node, head);
 	}
+	return true;
+}
+
+static void fill_pool(void)
+{
+	static atomic_t cpus_allocating;
=20
-	if (unlikely(!obj_cache))
+	/*
+	 * Avoid allocation and lock contention when:
+	 *   - One other CPU is already allocating
+	 *   - the global pool has not reached the critical level yet
+	 */
+	if (!pool_must_refill(&pool_global) && atomic_read(&cpus_allocating))
 		return;
=20
-	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
-		int cnt;
+	atomic_inc(&cpus_allocating);
+	while (pool_should_refill(&pool_global)) {
+		HLIST_HEAD(head);
=20
-		for (cnt =3D 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] =3D kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
-				break;
-		}
-		if (!cnt)
-			return;
+		if (!kmem_alloc_batch(&head, obj_cache, __GFP_HIGH | __GFP_NOWARN))
+			break;
=20
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+		guard(raw_spinlock_irqsave)(&pool_lock);
+		if (!pool_push_batch(&pool_global, &head))
+			pool_push_batch(&pool_to_free, &head);
 	}
+	atomic_dec(&cpus_allocating);
 }
=20
 /*
@@ -201,72 +429,37 @@ static struct debug_obj *lookup_object(void *addr, stru=
ct debug_bucket *b)
 	return NULL;
 }
=20
-/*
- * Allocate a new object from the hlist
- */
-static struct debug_obj *__alloc_object(struct hlist_head *list)
+static void calc_usage(void)
 {
-	struct debug_obj *obj =3D NULL;
+	static DEFINE_RAW_SPINLOCK(avg_lock);
+	static unsigned long avg_period;
+	unsigned long cur, now =3D jiffies;
=20
-	if (list->first) {
-		obj =3D hlist_entry(list->first, typeof(*obj), node);
-		hlist_del(&obj->node);
-	}
+	if (!time_after_eq(now, READ_ONCE(avg_period)))
+		return;
=20
-	return obj;
+	if (!raw_spin_trylock(&avg_lock))
+		return;
+
+	WRITE_ONCE(avg_period, now + msecs_to_jiffies(10));
+	cur =3D READ_ONCE(pool_global.stats.cur_used) * ODEBUG_FREE_WORK_MAX;
+	WRITE_ONCE(avg_usage, calc_load(avg_usage, EXP_5, cur));
+	raw_spin_unlock(&avg_lock);
 }
=20
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_desc=
r *descr)
+static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
+				      const struct debug_obj_descr *descr)
 {
-	struct debug_percpu_free *percpu_pool =3D this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
=20
-	if (likely(obj_cache)) {
-		obj =3D __alloc_object(&percpu_pool->free_objs);
-		if (obj) {
-			percpu_pool->obj_free--;
-			goto init_obj;
-		}
-	}
-
-	raw_spin_lock(&pool_lock);
-	obj =3D __alloc_object(&obj_pool);
-	if (obj) {
-		obj_pool_used++;
-		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-
-		/*
-		 * Looking ahead, allocate one batch of debug objects and
-		 * put them into the percpu free pool.
-		 */
-		if (likely(obj_cache)) {
-			int i;
-
-			for (i =3D 0; i < ODEBUG_BATCH_SIZE; i++) {
-				struct debug_obj *obj2;
-
-				obj2 =3D __alloc_object(&obj_pool);
-				if (!obj2)
-					break;
-				hlist_add_head(&obj2->node,
-					       &percpu_pool->free_objs);
-				percpu_pool->obj_free++;
-				obj_pool_used++;
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-			}
-		}
-
-		if (obj_pool_used > obj_pool_max_used)
-			obj_pool_max_used =3D obj_pool_used;
+	calc_usage();
=20
-		if (obj_pool_free < obj_pool_min_free)
-			obj_pool_min_free =3D obj_pool_free;
-	}
-	raw_spin_unlock(&pool_lock);
+	if (static_branch_likely(&obj_cache_enabled))
+		obj =3D pcpu_alloc();
+	else
+		obj =3D __alloc_object(&pool_boot);
=20
-init_obj:
-	if (obj) {
+	if (likely(obj)) {
 		obj->object =3D addr;
 		obj->descr  =3D descr;
 		obj->state  =3D ODEBUG_STATE_NONE;
@@ -276,142 +469,58 @@ alloc_object(void *addr, struct debug_bucket *b, const=
 struct debug_obj_descr *d
 	return obj;
 }
=20
-/*
- * workqueue function to free objects.
- *
- * To reduce contention on the global pool_lock, the actual freeing of
- * debug objects will be delayed if the pool_lock is busy.
- */
+/* workqueue function to free objects. */
 static void free_obj_work(struct work_struct *work)
 {
-	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	unsigned long flags;
-	HLIST_HEAD(tofree);
+	static unsigned long last_use_avg;
+	unsigned long cur_used, last_used, delta;
+	unsigned int max_free =3D 0;
=20
 	WRITE_ONCE(obj_freeing, false);
-	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
-		return;
=20
-	if (obj_pool_free >=3D debug_objects_pool_size)
-		goto free_objs;
+	/* Rate limit freeing based on current use average */
+	cur_used =3D READ_ONCE(avg_usage);
+	last_used =3D last_use_avg;
+	last_use_avg =3D cur_used;
=20
-	/*
-	 * The objs on the pool list might be allocated before the work is
-	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list. As it is likely that a workload
-	 * may be gearing up to use more and more objects, don't free any
-	 * of them until the next round.
-	 */
-	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
-		obj =3D hlist_entry(obj_to_free.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &obj_pool);
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	return;
+	if (!pool_count(&pool_to_free))
+		return;
=20
-free_objs:
-	/*
-	 * Pool list is already full and there are still objs on the free
-	 * list. Move remaining free objs to a temporary list to free the
-	 * memory outside the pool_lock held region.
-	 */
-	if (obj_nr_tofree) {
-		hlist_move_list(&obj_to_free, &tofree);
-		debug_objects_freed +=3D obj_nr_tofree;
-		WRITE_ONCE(obj_nr_tofree, 0);
+	if (cur_used <=3D last_used) {
+		delta =3D (last_used - cur_used) / ODEBUG_FREE_WORK_MAX;
+		max_free =3D min(delta, ODEBUG_FREE_WORK_MAX);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
=20
-	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+	for (int cnt =3D 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
+		HLIST_HEAD(tofree);
+
+		/* Acquire and drop the lock for each batch */
+		scoped_guard(raw_spinlock_irqsave, &pool_lock) {
+			if (!pool_to_free.cnt)
+				return;
+
+			/* Refill the global pool if possible */
+			if (pool_move_batch(&pool_global, &pool_to_free)) {
+				/* Don't free as there seems to be demand */
+				max_free =3D 0;
+			} else if (max_free) {
+				pool_pop_batch(&tofree, &pool_to_free);
+				max_free--;
+			} else {
+				return;
+			}
+		}
+		free_object_list(&tofree);
 	}
 }
=20
 static void __free_object(struct debug_obj *obj)
 {
-	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct debug_percpu_free *percpu_pool;
-	int lookahead_count =3D 0;
-	unsigned long flags;
-	bool work;
-
-	local_irq_save(flags);
-	if (!obj_cache)
-		goto free_to_obj_pool;
-
-	/*
-	 * Try to free it into the percpu pool first.
-	 */
-	percpu_pool =3D this_cpu_ptr(&percpu_obj_pool);
-	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->free_objs);
-		percpu_pool->obj_free++;
-		local_irq_restore(flags);
-		return;
-	}
-
-	/*
-	 * As the percpu pool is full, look ahead and pull out a batch
-	 * of objects from the percpu pool and free them as well.
-	 */
-	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] =3D __alloc_object(&percpu_pool->free_objs);
-		if (!objs[lookahead_count])
-			break;
-		percpu_pool->obj_free--;
-	}
-
-free_to_obj_pool:
-	raw_spin_lock(&pool_lock);
-	work =3D (obj_pool_free > debug_objects_pool_size) && obj_cache &&
-	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
-	obj_pool_used--;
-
-	if (work) {
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-		hlist_add_head(&obj->node, &obj_to_free);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
-			obj_pool_used -=3D lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_to_free);
-			}
-		}
-
-		if ((obj_pool_free > debug_objects_pool_size) &&
-		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
-			int i;
-
-			/*
-			 * Free one more batch of objects from obj_pool.
-			 */
-			for (i =3D 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj =3D __alloc_object(&obj_pool);
-				hlist_add_head(&obj->node, &obj_to_free);
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-			}
-		}
-	} else {
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		hlist_add_head(&obj->node, &obj_pool);
-		if (lookahead_count) {
-			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
-			obj_pool_used -=3D lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_pool);
-			}
-		}
-	}
-	raw_spin_unlock(&pool_lock);
-	local_irq_restore(flags);
+	guard(irqsave)();
+	if (static_branch_likely(&obj_cache_enabled))
+		pcpu_free(obj);
+	else
+		hlist_add_head(&obj->node, &pool_boot);
 }
=20
 /*
@@ -421,63 +530,52 @@ static void __free_object(struct debug_obj *obj)
 static void free_object(struct debug_obj *obj)
 {
 	__free_object(obj);
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
 }
=20
-#ifdef CONFIG_HOTPLUG_CPU
-static int object_cpu_offline(unsigned int cpu)
+static void put_objects(struct hlist_head *list)
 {
-	struct debug_percpu_free *percpu_pool;
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
-	unsigned long flags;
=20
-	/* Remote access is safe as the CPU is dead already */
-	percpu_pool =3D per_cpu_ptr(&percpu_obj_pool, cpu);
-	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+	/*
+	 * Using free_object() puts the objects into reuse or schedules
+	 * them for freeing and it get's all the accounting correct.
+	 */
+	hlist_for_each_entry_safe(obj, tmp, list, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		free_object(obj);
 	}
+}
=20
-	raw_spin_lock_irqsave(&pool_lock, flags);
-	obj_pool_used -=3D percpu_pool->obj_free;
-	debug_objects_freed +=3D percpu_pool->obj_free;
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-
-	percpu_pool->obj_free =3D 0;
+#ifdef CONFIG_HOTPLUG_CPU
+static int object_cpu_offline(unsigned int cpu)
+{
+	/* Remote access is safe as the CPU is dead already */
+	struct obj_pool *pcp =3D per_cpu_ptr(&pool_pcpu, cpu);
=20
+	put_objects(&pcp->objects);
+	pcp->cnt =3D 0;
 	return 0;
 }
 #endif
=20
-/*
- * We run out of memory. That means we probably have tons of objects
- * allocated.
- */
+/* Out of memory. Free all objects from hash */
 static void debug_objects_oom(void)
 {
 	struct debug_bucket *db =3D obj_hash;
-	struct hlist_node *tmp;
 	HLIST_HEAD(freelist);
-	struct debug_obj *obj;
-	unsigned long flags;
-	int i;
=20
 	pr_warn("Out of memory. ODEBUG disabled\n");
=20
-	for (i =3D 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_move_list(&db->list, &freelist);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+	for (int i =3D 0; i < ODEBUG_HASH_SIZE; i++, db++) {
+		scoped_guard(raw_spinlock_irqsave, &db->lock)
+			hlist_move_list(&db->list, &freelist);
=20
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
+		put_objects(&freelist);
 	}
 }
=20
@@ -592,12 +690,24 @@ static struct debug_obj *lookup_object_or_alloc(void *a=
ddr, struct debug_bucket
 	}
=20
 	/* Out of memory. Do the cleanup outside of the locked region */
-	debug_objects_enabled =3D 0;
+	debug_objects_enabled =3D false;
 	return NULL;
 }
=20
 static void debug_objects_fill_pool(void)
 {
+	if (!static_branch_likely(&obj_cache_enabled))
+		return;
+
+	if (likely(!pool_should_refill(&pool_global)))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(!pool_should_refill(&pool_global)))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and
@@ -1007,7 +1117,7 @@ static void __debug_check_no_obj_freed(const void *addr=
ess, unsigned long size)
 		debug_objects_maxchecked =3D objs_checked;
=20
 	/* Schedule work to actually kmem_cache_free() objects */
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -1024,23 +1134,33 @@ void debug_check_no_obj_freed(const void *address, un=
signed long size)
=20
 static int debug_stats_show(struct seq_file *m, void *v)
 {
-	int cpu, obj_percpu_free =3D 0;
+	unsigned int cpu, pool_used, pcp_free =3D 0;
=20
+	/*
+	 * pool_global.stats.cur_used is the number of batches currently
+	 * handed out to per CPU pools. Convert it to number of objects
+	 * and subtract the number of free objects in the per CPU pools.
+	 * As this is lockless the number is an estimate.
+	 */
 	for_each_possible_cpu(cpu)
-		obj_percpu_free +=3D per_cpu(percpu_obj_pool.obj_free, cpu);
-
-	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
-	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
-	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
-	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", READ_ONCE(obj_pool_free) + obj_percpu_=
free);
-	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
-	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
-	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(obj_nr_tofree));
-	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
-	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
+		pcp_free +=3D per_cpu(pool_pcpu.cnt, cpu);
+
+	pool_used =3D READ_ONCE(pool_global.stats.cur_used);
+	pcp_free =3D min(pool_used, pcp_free);
+	pool_used -=3D pcp_free;
+
+	seq_printf(m, "max_chain     : %d\n", debug_objects_maxchain);
+	seq_printf(m, "max_checked   : %d\n", debug_objects_maxchecked);
+	seq_printf(m, "warnings      : %d\n", debug_objects_warnings);
+	seq_printf(m, "fixups        : %d\n", debug_objects_fixups);
+	seq_printf(m, "pool_free     : %u\n", pool_count(&pool_global) + pcp_free);
+	seq_printf(m, "pool_pcp_free : %u\n", pcp_free);
+	seq_printf(m, "pool_min_free : %u\n", data_race(pool_global.stats.min_fill)=
);
+	seq_printf(m, "pool_used     : %u\n", pool_used);
+	seq_printf(m, "pool_max_used : %u\n", data_race(pool_global.stats.max_used)=
);
+	seq_printf(m, "on_free_list  : %u\n", pool_count(&pool_to_free));
+	seq_printf(m, "objs_allocated: %d\n", debug_objects_allocated);
+	seq_printf(m, "objs_freed    : %d\n", debug_objects_freed);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(debug_stats);
@@ -1194,7 +1314,7 @@ check_results(void *addr, enum debug_obj_state state, i=
nt fixups, int warnings)
 out:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 	if (res)
-		debug_objects_enabled =3D 0;
+		debug_objects_enabled =3D false;
 	return res;
 }
=20
@@ -1209,7 +1329,7 @@ static __initconst const struct debug_obj_descr descr_t=
ype_test =3D {
=20
 static __initdata struct self_test obj =3D { .static_init =3D 0 };
=20
-static void __init debug_objects_selftest(void)
+static bool __init debug_objects_selftest(void)
 {
 	int fixups, oldfixups, warnings, oldwarnings;
 	unsigned long flags;
@@ -1278,9 +1398,10 @@ static void __init debug_objects_selftest(void)
 	descr_test =3D NULL;
=20
 	local_irq_restore(flags);
+	return debug_objects_enabled;
 }
 #else
-static inline void debug_objects_selftest(void) { }
+static inline bool debug_objects_selftest(void) { return true; }
 #endif
=20
 /*
@@ -1295,65 +1416,54 @@ void __init debug_objects_early_init(void)
 	for (i =3D 0; i < ODEBUG_HASH_SIZE; i++)
 		raw_spin_lock_init(&obj_hash[i].lock);
=20
+	/* Keep early boot simple and add everything to the boot list */
 	for (i =3D 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
+		hlist_add_head(&obj_static_pool[i].node, &pool_boot);
 }
=20
 /*
- * Convert the statically allocated objects to dynamic ones:
+ * Convert the statically allocated objects to dynamic ones.
+ * debug_objects_mem_init() is called early so only one CPU is up and
+ * interrupts are disabled, which means it is safe to replace the active
+ * object references.
  */
-static int __init debug_objects_replace_static_objects(void)
+static bool __init debug_objects_replace_static_objects(struct kmem_cache *c=
ache)
 {
 	struct debug_bucket *db =3D obj_hash;
 	struct hlist_node *tmp;
-	struct debug_obj *obj, *new;
+	struct debug_obj *obj;
 	HLIST_HEAD(objects);
-	int i, cnt =3D 0;
+	int i;
=20
-	for (i =3D 0; i < ODEBUG_POOL_SIZE; i++) {
-		obj =3D kmem_cache_zalloc(obj_cache, GFP_KERNEL);
-		if (!obj)
+	for (i =3D 0; i < ODEBUG_POOL_SIZE; i +=3D ODEBUG_BATCH_SIZE) {
+		if (!kmem_alloc_batch(&objects, cache, GFP_KERNEL))
 			goto free;
-		hlist_add_head(&obj->node, &objects);
+		pool_push_batch(&pool_global, &objects);
 	}
=20
-	debug_objects_allocated +=3D i;
-
-	/*
-	 * debug_objects_mem_init() is now called early that only one CPU is up
-	 * and interrupts have been disabled, so it is safe to replace the
-	 * active object references.
-	 */
-
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
-	hlist_move_list(&objects, &obj_pool);
+	/* Disconnect the boot pool. */
+	pool_boot.first =3D NULL;
=20
 	/* Replace the active object references */
 	for (i =3D 0; i < ODEBUG_HASH_SIZE; i++, db++) {
 		hlist_move_list(&db->list, &objects);
=20
 		hlist_for_each_entry(obj, &objects, node) {
-			new =3D hlist_entry(obj_pool.first, typeof(*obj), node);
-			hlist_del(&new->node);
+			struct debug_obj *new =3D pcpu_alloc();
+
 			/* copy object data */
 			*new =3D *obj;
 			hlist_add_head(&new->node, &db->list);
-			cnt++;
 		}
 	}
-
-	pr_debug("%d of %d active objects replaced\n",
-		 cnt, obj_pool_used);
-	return 0;
+	return true;
 free:
-	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
+	/* Can't use free_object_list() as the cache is not populated yet */
+	hlist_for_each_entry_safe(obj, tmp, &pool_global.objects, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		kmem_cache_free(cache, obj);
 	}
-	return -ENOMEM;
+	return false;
 }
=20
 /*
@@ -1364,43 +1474,40 @@ static int __init debug_objects_replace_static_object=
s(void)
  */
 void __init debug_objects_mem_init(void)
 {
-	int cpu, extras;
+	struct kmem_cache *cache;
+	int extras;
=20
 	if (!debug_objects_enabled)
 		return;
=20
-	/*
-	 * Initialize the percpu object pools
-	 *
-	 * Initialization is not strictly necessary, but was done for
-	 * completeness.
-	 */
-	for_each_possible_cpu(cpu)
-		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
+	if (!debug_objects_selftest())
+		return;
=20
-	obj_cache =3D kmem_cache_create("debug_objects_cache",
-				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
-				      NULL);
+	cache =3D kmem_cache_create("debug_objects_cache", sizeof (struct debug_obj=
), 0,
+				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
=20
-	if (!obj_cache || debug_objects_replace_static_objects()) {
-		debug_objects_enabled =3D 0;
-		kmem_cache_destroy(obj_cache);
-		pr_warn("out of memory.\n");
+	if (!cache || !debug_objects_replace_static_objects(cache)) {
+		debug_objects_enabled =3D false;
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
=20
 	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
+	 * Adjust the thresholds for allocating and freeing objects
+	 * according to the number of possible CPUs available in the
+	 * system.
 	 */
 	extras =3D num_possible_cpus() * ODEBUG_BATCH_SIZE;
-	debug_objects_pool_size +=3D extras;
-	debug_objects_pool_min_level +=3D extras;
+	pool_global.max_cnt +=3D extras;
+	pool_global.min_cnt +=3D extras;
+
+	/* Everything worked. Expose the cache */
+	obj_cache =3D cache;
+	static_branch_enable(&obj_cache_enabled);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+				  object_cpu_offline);
+#endif
+	return;
 }


