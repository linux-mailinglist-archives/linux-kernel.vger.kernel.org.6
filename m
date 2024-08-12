Return-Path: <linux-kernel+bounces-282680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D949D94E74F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2251C2150E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317015F41F;
	Mon, 12 Aug 2024 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wRJPCz82"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311515C129
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446007; cv=none; b=a2cCa+Lsix7rdCKhi3grfraGED69mwetWLxh2jQUyaAdNuMFcP7CTewrMd982sza6ycR3Om5f8AcpAXz3Oo0gFU5H9o62VnWswUoqjT3hk0DJ1qM/K8LNpxLkd9Oi7FcMuSlgUly7lkWv559eN3uwpjbHrnRbWnUUU81PID4vQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446007; c=relaxed/simple;
	bh=Hl3o28OEHxharHUo5EPEcmIKtXI10Pywg9Bpi+sw9DE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZWOyK3p4UQz17Is/z9Gp0MJlZpfO8o2tK/w7t4biA9IEMx4ifpUimWr7xo1u+vk5Jr6NertTzTD3sRpXHxM2yK323nxBl+T3wKwjxoLWwWH8EO1Mop0D4ng34ifmytPhcj0ALHyXw0zLz8M3P1EvqCaBitpqDhz4p3wragJfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wRJPCz82; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723445996; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2sB5TDcVkqlobWIVqrnBXmc0iuAglrquanWdPCiDDFo=;
	b=wRJPCz82B0LAOgJIjLAlwtGWlNx6UJhyKGXE78VBMy1q6xnt728Sd7mzk0LNqHHT/bR6k3z2cIIXtez301jFStsUW7EML+HnMLmyHZEm4esYzPSuHHbnswB4bKVsILJdC66HqFz/4NenkwKnvA64pUYK5l0f8tRAUVPRsG/pRgM=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WCaX4Nj_1723445987)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 14:59:55 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH] kfence: Save freeing stack trace at calling time instead of freeing time
Date: Mon, 12 Aug 2024 14:59:47 +0800
Message-Id: <20240812065947.6104-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kmem_cache with SLAB_TYPESAFE_BY_RCU, the freeing trace stack at
calling kmem_cache_free() is more useful. While the following stack is
meaningless and provides no help:
  freed by task 46 on cpu 0 at 656.840729s:
   rcu_do_batch+0x1ab/0x540
   nocb_cb_wait+0x8f/0x260
   rcu_nocb_cb_kthread+0x25/0x80
   kthread+0xd2/0x100
   ret_from_fork+0x34/0x50
   ret_from_fork_asm+0x1a/0x30

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
I'm not sure whether we should keep KFENCE_OBJECT_FREED info remained
(maybe the exact free time can be helpful?). But add a new kfence_track
will cost more memory, so I prefer to reuse free_track and drop the info
when when KFENCE_OBJECT_RCU_FREEING -> KFENCE_OBJECT_FREED.
---
 mm/kfence/core.c   | 35 ++++++++++++++++++++++++++---------
 mm/kfence/kfence.h |  1 +
 mm/kfence/report.c |  7 ++++---
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c5cb54fc696d..89469d4f2d95 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -269,6 +269,13 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
 	return pageaddr;
 }
 
+static bool kfence_obj_inuse(const struct kfence_metadata *meta)
+{
+	enum kfence_object_state state = READ_ONCE(meta->state);
+
+	return state == KFENCE_OBJECT_ALLOCATED || state == KFENCE_OBJECT_RCU_FREEING;
+}
+
 /*
  * Update the object's metadata state, including updating the alloc/free stacks
  * depending on the state transition.
@@ -278,10 +285,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 		      unsigned long *stack_entries, size_t num_stack_entries)
 {
 	struct kfence_track *track =
-		next == KFENCE_OBJECT_FREED ? &meta->free_track : &meta->alloc_track;
+		next == KFENCE_OBJECT_ALLOCATED ? &meta->alloc_track : &meta->free_track;
 
 	lockdep_assert_held(&meta->lock);
 
+	/* Stack has been saved when calling rcu, skip. */
+	if (READ_ONCE(meta->state) == KFENCE_OBJECT_RCU_FREEING)
+		goto out;
+
 	if (stack_entries) {
 		memcpy(track->stack_entries, stack_entries,
 		       num_stack_entries * sizeof(stack_entries[0]));
@@ -297,6 +308,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	track->cpu = raw_smp_processor_id();
 	track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
 
+out:
 	/*
 	 * Pairs with READ_ONCE() in
 	 *	kfence_shutdown_cache(),
@@ -502,7 +514,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 
 	raw_spin_lock_irqsave(&meta->lock, flags);
 
-	if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
+	if (!kfence_obj_inuse(meta) || meta->addr != (unsigned long)addr) {
 		/* Invalid or double-free, bail out. */
 		atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
 		kfence_report_error((unsigned long)addr, false, NULL, meta,
@@ -780,7 +792,7 @@ static void kfence_check_all_canary(void)
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
 		struct kfence_metadata *meta = &kfence_metadata[i];
 
-		if (meta->state == KFENCE_OBJECT_ALLOCATED)
+		if (kfence_obj_inuse(meta))
 			check_canary(meta);
 	}
 }
@@ -1006,12 +1018,11 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 		 * the lock will not help, as different critical section
 		 * serialization will have the same outcome.
 		 */
-		if (READ_ONCE(meta->cache) != s ||
-		    READ_ONCE(meta->state) != KFENCE_OBJECT_ALLOCATED)
+		if (READ_ONCE(meta->cache) != s || !kfence_obj_inuse(meta))
 			continue;
 
 		raw_spin_lock_irqsave(&meta->lock, flags);
-		in_use = meta->cache == s && meta->state == KFENCE_OBJECT_ALLOCATED;
+		in_use = meta->cache == s && kfence_obj_inuse(meta);
 		raw_spin_unlock_irqrestore(&meta->lock, flags);
 
 		if (in_use) {
@@ -1145,6 +1156,7 @@ void *kfence_object_start(const void *addr)
 void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
+	unsigned long flags;
 
 #ifdef CONFIG_MEMCG
 	KFENCE_WARN_ON(meta->obj_exts.objcg);
@@ -1154,9 +1166,14 @@ void __kfence_free(void *addr)
 	 * the object, as the object page may be recycled for other-typed
 	 * objects once it has been freed. meta->cache may be NULL if the cache
 	 * was destroyed.
+	 * Save the stack trace here. It is more useful.
 	 */
-	if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
+	if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU))) {
+		raw_spin_lock_irqsave(&meta->lock, flags);
+		metadata_update_state(meta, KFENCE_OBJECT_RCU_FREEING, NULL, 0);
+		raw_spin_unlock_irqrestore(&meta->lock, flags);
 		call_rcu(&meta->rcu_head, rcu_guarded_free);
+	}
 	else
 		kfence_guarded_free(addr, meta, false);
 }
@@ -1182,14 +1199,14 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 		int distance = 0;
 
 		meta = addr_to_metadata(addr - PAGE_SIZE);
-		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
+		if (meta && kfence_obj_inuse(meta)) {
 			to_report = meta;
 			/* Data race ok; distance calculation approximate. */
 			distance = addr - data_race(meta->addr + meta->size);
 		}
 
 		meta = addr_to_metadata(addr + PAGE_SIZE);
-		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
+		if (meta && kfence_obj_inuse(meta)) {
 			/* Data race ok; distance calculation approximate. */
 			if (!to_report || distance > data_race(meta->addr) - addr)
 				to_report = meta;
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index db87a05047bd..dfba5ea06b01 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -38,6 +38,7 @@
 enum kfence_object_state {
 	KFENCE_OBJECT_UNUSED,		/* Object is unused. */
 	KFENCE_OBJECT_ALLOCATED,	/* Object is currently allocated. */
+	KFENCE_OBJECT_RCU_FREEING,	/* Object was allocated, and then being freed by rcu. */
 	KFENCE_OBJECT_FREED,		/* Object was allocated, and then freed. */
 };
 
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 73a6fe42845a..451991a3a8f2 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -114,7 +114,8 @@ static void kfence_print_stack(struct seq_file *seq, const struct kfence_metadat
 
 	/* Timestamp matches printk timestamp format. */
 	seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus (%lu.%06lus ago):\n",
-		       show_alloc ? "allocated" : "freed", track->pid,
+		       show_alloc ? "allocated" : meta->state == KFENCE_OBJECT_RCU_FREEING ?
+		       "rcu freeing" : "freed", track->pid,
 		       track->cpu, (unsigned long)ts_sec, rem_nsec / 1000,
 		       (unsigned long)interval_nsec, rem_interval_nsec / 1000);
 
@@ -149,7 +150,7 @@ void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *met
 
 	kfence_print_stack(seq, meta, true);
 
-	if (meta->state == KFENCE_OBJECT_FREED) {
+	if (meta->state == KFENCE_OBJECT_FREED || meta->state == KFENCE_OBJECT_RCU_FREEING) {
 		seq_con_printf(seq, "\n");
 		kfence_print_stack(seq, meta, false);
 	}
@@ -318,7 +319,7 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *sla
 	kpp->kp_slab_cache = meta->cache;
 	kpp->kp_objp = (void *)meta->addr;
 	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
-	if (meta->state == KFENCE_OBJECT_FREED)
+	if (meta->state == KFENCE_OBJECT_FREED || meta->state == KFENCE_OBJECT_RCU_FREEING)
 		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
 	/* get_stack_skipnr() ensures the first entry is outside allocator. */
 	kpp->kp_ret = kpp->kp_stack[0];
-- 
2.39.3


