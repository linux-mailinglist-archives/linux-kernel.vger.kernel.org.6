Return-Path: <linux-kernel+bounces-282904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6B94EA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B671F21205
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98EA16E86F;
	Mon, 12 Aug 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IUNA8MZf"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429716DECC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456535; cv=none; b=kSxyjOQwkIf2YklEdcgsJKDLzIcP09lOJofp19q+4e9fMEGZhhu+n10xRJ0fOFW2HoJRZdu5+urAbAhdrAdIRM+Fy6AOj3w1cWkDdx058L5snAXTmqMQY+VM0d/6sQnnDdpcZs0g1fcSk2zxfal44XPNnO+cIEjbGGM7YkflCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456535; c=relaxed/simple;
	bh=1Zadw76xFYp7Bjmc9PIsBq17Qo7GBd/qn3sY6InQ9rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdjQj16Hws5DmOtzCELjywmKO9NmSMIO0medMz0yhHDqWHTuQgIWf+VdQy25hLQ7eV7Kil35BxuYW5K7yLe0GEOrbuScKGLEtSfeAxSQ5kD0j2XnEAuKQFIIt9E5VgMroNcS5Fp4txtdyJbEUAaBaqk8VfwWzZXjG8YWw0DetmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IUNA8MZf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723456524; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nZqkS7Z96TWLWnJVjQ8HLYQ0F4DVw3Kyu1YxwZNjc/M=;
	b=IUNA8MZfe/epapVjkhn5hzWIe9HxyiX7MuFPHd3O7TWHcKL45y19IFK4IuFmBLfeRpn9SoYO48O1d/RifVxzOa6wBUBrEe+IYhMC2A3Ul1FdtR3baR8vvFxhP4KYi+U33RftuyzSYRRliIkQMsjh51RJFHJJmk+06fJlbh3aF2U=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WChYhe1_1723456517)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 17:55:23 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v2] kfence: Save freeing stack trace at calling time instead of freeing time
Date: Mon, 12 Aug 2024 17:55:17 +0800
Message-Id: <20240812095517.2357-1-dtcccc@linux.alibaba.com>
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
v2:
Rename and inline tiny helper kfence_obj_allocated().
Improve code style and comments.

v1: https://lore.kernel.org/all/20240812065947.6104-1-dtcccc@linux.alibaba.com/
---
 mm/kfence/core.c   | 39 +++++++++++++++++++++++++++++----------
 mm/kfence/kfence.h |  1 +
 mm/kfence/report.c |  7 ++++---
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c3ef7eb8d4dc..67fc321db79b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -273,6 +273,13 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
 	return pageaddr;
 }
 
+static inline bool kfence_obj_allocated(const struct kfence_metadata *meta)
+{
+	enum kfence_object_state state = READ_ONCE(meta->state);
+
+	return state == KFENCE_OBJECT_ALLOCATED || state == KFENCE_OBJECT_RCU_FREEING;
+}
+
 /*
  * Update the object's metadata state, including updating the alloc/free stacks
  * depending on the state transition.
@@ -282,10 +289,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
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
@@ -301,6 +312,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 	track->cpu = raw_smp_processor_id();
 	track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
 
+out:
 	/*
 	 * Pairs with READ_ONCE() in
 	 *	kfence_shutdown_cache(),
@@ -506,7 +518,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 
 	raw_spin_lock_irqsave(&meta->lock, flags);
 
-	if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
+	if (!kfence_obj_allocated(meta) || meta->addr != (unsigned long)addr) {
 		/* Invalid or double-free, bail out. */
 		atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
 		kfence_report_error((unsigned long)addr, false, NULL, meta,
@@ -784,7 +796,7 @@ static void kfence_check_all_canary(void)
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
 		struct kfence_metadata *meta = &kfence_metadata[i];
 
-		if (meta->state == KFENCE_OBJECT_ALLOCATED)
+		if (kfence_obj_allocated(meta))
 			check_canary(meta);
 	}
 }
@@ -1010,12 +1022,11 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 		 * the lock will not help, as different critical section
 		 * serialization will have the same outcome.
 		 */
-		if (READ_ONCE(meta->cache) != s ||
-		    READ_ONCE(meta->state) != KFENCE_OBJECT_ALLOCATED)
+		if (READ_ONCE(meta->cache) != s || !kfence_obj_allocated(meta))
 			continue;
 
 		raw_spin_lock_irqsave(&meta->lock, flags);
-		in_use = meta->cache == s && meta->state == KFENCE_OBJECT_ALLOCATED;
+		in_use = meta->cache == s && kfence_obj_allocated(meta);
 		raw_spin_unlock_irqrestore(&meta->lock, flags);
 
 		if (in_use) {
@@ -1160,11 +1171,19 @@ void __kfence_free(void *addr)
 	 * the object, as the object page may be recycled for other-typed
 	 * objects once it has been freed. meta->cache may be NULL if the cache
 	 * was destroyed.
+	 * Save the stack trace here so that reports show where the user freed
+	 * the object.
 	 */
-	if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
+	if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU))) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&meta->lock, flags);
+		metadata_update_state(meta, KFENCE_OBJECT_RCU_FREEING, NULL, 0);
+		raw_spin_unlock_irqrestore(&meta->lock, flags);
 		call_rcu(&meta->rcu_head, rcu_guarded_free);
-	else
+	} else {
 		kfence_guarded_free(addr, meta, false);
+	}
 }
 
 bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs)
@@ -1188,14 +1207,14 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 		int distance = 0;
 
 		meta = addr_to_metadata(addr - PAGE_SIZE);
-		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
+		if (meta && kfence_obj_allocated(meta)) {
 			to_report = meta;
 			/* Data race ok; distance calculation approximate. */
 			distance = addr - data_race(meta->addr + meta->size);
 		}
 
 		meta = addr_to_metadata(addr + PAGE_SIZE);
-		if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
+		if (meta && kfence_obj_allocated(meta)) {
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


