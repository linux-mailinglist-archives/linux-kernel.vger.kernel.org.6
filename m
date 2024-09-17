Return-Path: <linux-kernel+bounces-331259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0434997AA69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725D31F27FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439F24B2F;
	Tue, 17 Sep 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq0ES3py"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63315AF6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726542138; cv=none; b=txO4ETc+UcRqerdAE4Q+3TtychHMhhHHeRtIMPERZaDTbljC8LqeJ4+HoPzl9K5tmS7yA/sZUp3EFXijyu0ppTqzoV52BKvJ+CUfpPUUqmZWz6jUDPZ2WPDBFHc6YTLEoYF808T/f4ZOVoMlve8ODtAKFlcLmVeyzIEgagGSkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726542138; c=relaxed/simple;
	bh=SN3Bma6WEiNHDJRwyJJzprAfckeuVXglXOyioJ3V5vU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZUmvw+AP3fe17QKvjC7J8RSf15StdwVdpn2kRFsCMLQrp8TuIcuRTGLDj+M29KymMkM7P//Ww0ji78nrx+lM1TUlRsutttCqhUpJO8sh+t48SXZp35k2bnzwh/0rNV3vfsV7+SzznXer6tPYZNF92Eee6Te/X+1QDEHlqjtTUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq0ES3py; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71798661a52so3874362b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726542136; x=1727146936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCtV/xzadjTdnOPeusMvzkSllObOYwmcEnOt/38RcU=;
        b=hq0ES3pyaQCTTHDLLRRuMP3dbA1P/h/7mDS+pS8kfSbcKGWScj9Ap0Kj8I4z+IKIe1
         qLHwcud+RVFxAP4Ma4b2BIJ6xQUfCCD5AbmOwLKlj0q2XcZmT1aCf9389dXMUccS9imH
         MO1+xZTKXS+A4w9YNa6tTI8hBaevgBYviXRvajAFuEfp3yv0Y+DZZ4ojuymNBzM4DsMH
         Ay4bINNd5iI+SddoGO/4EAYkBkQZbnaif/hUzIyd5ikw7mZdF6sF6FVnQ66/kcPgujtS
         oEQIQ54NdjmL42VsiA0kqmkQhmeoqDtZ/1Q5NUPI2Wm+xYyxVJ83Yb3ID1JbqMpHIw4e
         VQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726542136; x=1727146936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaCtV/xzadjTdnOPeusMvzkSllObOYwmcEnOt/38RcU=;
        b=t2L2cdIE26DriNFeARi5cNt+9IOk2z9OacoM95vJE1Qn/A6AHhg9+sVBazGYgTiKrd
         YLTvhYftMel2JEJIHl5yplNhSKldz3FED5aVADbU5G0UfaRDreCS3QMaGQEGbYmuKYsH
         mZJF/KkLpyAaWPsOZvCGtCEnc3901lkfXHLpZaTA5/d6RqrpzKGILurkg+JdWwP2qI9G
         UBdpPMbDCnoVBupCNy+Rh41s3top1p6IqHxhXMes/7n8pw2p2IF2zwPSjKDbj0ce0Aul
         lihUdAAbf96pF4XYbEuTE12uY4V9uk9DEdDJ20ob6lE05V0/QO1WoxnJG28eZ5U3uEx7
         Q6nw==
X-Gm-Message-State: AOJu0YzQK6QcbBvTNH1IKUDZVL00p/bmLq9hTNIG01hsmW5ZEfFBgW4F
	5BI6L8eDbwZyjuLqqqbPVMqob6AtM5/SRKa07EpTFWUILKBp0NBL
X-Google-Smtp-Source: AGHT+IHSubpEQKpVsMybOHymGrI4+xKJaA3ApGLOKGjHn9hN4LS0g+t95RU6Adr0D3/gUHRualDTTQ==
X-Received: by 2002:a05:6a00:3d14:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-719263ea9d0mr27530303b3a.7.1726542135346;
        Mon, 16 Sep 2024 20:02:15 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944abaa98sm4388068b3a.68.2024.09.16.20.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 20:02:14 -0700 (PDT)
From: Shu Han <ebpqwerty472123@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] binder: use augmented rb-tree for faster descriptor lookup
Date: Tue, 17 Sep 2024 11:02:03 +0800
Message-Id: <20240917030203.286-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The advantages of accelerating descriptor lookup were explained in the
commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup").
However, the time complexity of the bitmap is still O(n), and performance
can still be slow when there are too many references. In addition,
additional allocation/free calls are required.
Since there is already an rb-tree with the key 'desc' on 'binder_proc', an
augmented rb-tree with a subtree-size field can easily search for the
smallest non-existent 'desc' in O(logn) time. This lookup can be merged
with the subsequent rb-tree lookup for insertion, so there is no
additional overhead except for maintaining the size field. And there is no
need to maintain the fast path and slow path at the same time since this
method is good enough for all cases.
The core idea of this algorithm is to maintain the count of nodes whose
descriptor is smaller than the current node, except the left subtree of
the current node, when searching downwards from the root. To achieve this,
simply add the size of the left subtree and the current node itself to the
maintained value before moving to the right child. If the count of nodes
whose descriptor is smaller than the current node (the sum of maintained
value and the size of the left subtree of the current node) reaches the
current node's descriptor, it means that there are no descriptors smaller
than the current node waiting for allocation, so we should move to the
right subtree. Otherwise, we should move to the left subtree.
In order to be compatible with the behavior that only the context manager
can be assigned by 0, an additional bool value is maintained on the proc
to indicate whether there is a ref assigned as 0 and some adjustments to
the search algorithm made.
Another consideration is that as the descriptor allocation speed
increases, integer overflow may become feasible.

Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
 drivers/android/binder.c          | 160 +++++++++++++---------------
 drivers/android/binder_internal.h |  10 +-
 drivers/android/dbitmap.h         | 168 ------------------------------
 3 files changed, 76 insertions(+), 262 deletions(-)
 delete mode 100644 drivers/android/dbitmap.h

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e8643c69d426..c1a9268aacb5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -54,6 +54,7 @@
 #include <linux/poll.h>
 #include <linux/debugfs.h>
 #include <linux/rbtree.h>
+#include <linux/rbtree_augmented.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/seq_file.h>
@@ -1043,63 +1044,43 @@ static struct binder_ref *binder_get_ref_olocked(struct binder_proc *proc,
 	return NULL;
 }
 
-/* Find the smallest unused descriptor the "slow way" */
-static u32 slow_desc_lookup_olocked(struct binder_proc *proc, u32 offset)
-{
-	struct binder_ref *ref;
-	struct rb_node *n;
-	u32 desc;
-
-	desc = offset;
-	for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n)) {
-		ref = rb_entry(n, struct binder_ref, rb_node_desc);
-		if (ref->data.desc > desc)
-			break;
-		desc = ref->data.desc + 1;
-	}
-
-	return desc;
-}
-
-/*
- * Find an available reference descriptor ID. The proc->outer_lock might
- * be released in the process, in which case -EAGAIN is returned and the
- * @desc should be considered invalid.
+/**
+ * binder_ref_rb_node_desc_compute_size() - Maintain the rb_node_desc_size
+ * @ref:         struct binder_ref to maintain
+ *
+ * Maintain the rb_node_desc_size of the ref_by_desc map in binder_proc for
+ * key as desc and value as binder_ref.
+ * Using augmented rb_tree functions with binder_ref_rb_node_desc_callbacks.
  */
-static int get_ref_desc_olocked(struct binder_proc *proc,
-				struct binder_node *node,
-				u32 *desc)
+static inline bool
+binder_ref_rb_node_desc_compute_size(struct binder_ref *ref, bool exit)
 {
-	struct dbitmap *dmap = &proc->dmap;
-	unsigned int nbits, offset;
-	unsigned long *new, bit;
+	struct binder_ref *child;
+	size_t size = 1;
 
-	/* 0 is reserved for the context manager */
-	offset = (node == proc->context->binder_context_mgr_node) ? 0 : 1;
-
-	if (!dbitmap_enabled(dmap)) {
-		*desc = slow_desc_lookup_olocked(proc, offset);
-		return 0;
+	if (ref->rb_node_desc.rb_left) {
+		child = rb_entry(ref->rb_node_desc.rb_left, struct binder_ref,
+				 rb_node_desc);
+		size += child->rb_node_desc_size;
 	}
 
-	if (dbitmap_acquire_next_zero_bit(dmap, offset, &bit) == 0) {
-		*desc = bit;
-		return 0;
+	if (ref->rb_node_desc.rb_right) {
+		child = rb_entry(ref->rb_node_desc.rb_right, struct binder_ref,
+				 rb_node_desc);
+		size += child->rb_node_desc_size;
 	}
 
-	/*
-	 * The dbitmap is full and needs to grow. The proc->outer_lock
-	 * is briefly released to allocate the new bitmap safely.
-	 */
-	nbits = dbitmap_grow_nbits(dmap);
-	binder_proc_unlock(proc);
-	new = bitmap_zalloc(nbits, GFP_KERNEL);
-	binder_proc_lock(proc);
-	dbitmap_grow(dmap, new, nbits);
+	if (exit && ref->rb_node_desc_size == size)
+		return true;
 
-	return -EAGAIN;
+	ref->rb_node_desc_size = size;
+	return false;
 }
 
+RB_DECLARE_CALLBACKS(static, binder_ref_rb_node_desc_callbacks,
+		     struct binder_ref, rb_node_desc, rb_node_desc_size,
+		     binder_ref_rb_node_desc_compute_size)
+
 /**
  * binder_get_ref_for_node_olocked() - get the ref associated with given node
  * @proc:	binder_proc that owns the ref
@@ -1123,14 +1104,12 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 					struct binder_node *node,
 					struct binder_ref *new_ref)
 {
-	struct binder_ref *ref;
-	struct rb_node *parent;
-	struct rb_node **p;
-	u32 desc;
+	struct binder_context *context = proc->context;
+	struct rb_node **p = &proc->refs_by_node.rb_node;
+	struct rb_node *parent = NULL;
+	struct binder_ref *ref, *left;
+	uint32_t desc = 0, smaller_count;
 
-retry:
-	p = &proc->refs_by_node.rb_node;
-	parent = NULL;
 	while (*p) {
 		parent = *p;
 		ref = rb_entry(parent, struct binder_ref, rb_node_node);
@@ -1145,9 +1124,13 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 	if (!new_ref)
 		return NULL;
 
-	/* might release the proc->outer_lock */
-	if (get_ref_desc_olocked(proc, node, &desc) == -EAGAIN)
-		goto retry;
+	/* Avoid integer overflow, zero may reserved */
+	if (!RB_EMPTY_ROOT(&proc->refs_by_desc)) {
+		ref = rb_entry(proc->refs_by_desc.rb_node, struct binder_ref,
+		       rb_node_desc);
+		if (ref->rb_node_desc_size >= U32_MAX - 1)
+			return NULL;
+	}
 
 	binder_stats_created(BINDER_STAT_REF);
 	new_ref->data.debug_id = atomic_inc_return(&binder_last_id);
@@ -1156,21 +1139,35 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 	rb_link_node(&new_ref->rb_node_node, parent, p);
 	rb_insert_color(&new_ref->rb_node_node, &proc->refs_by_node);
 
-	new_ref->data.desc = desc;
+	if (node != context->binder_context_mgr_node &&
+	    !proc->have_ref_with_zero_desc)
+		desc = 1;
 	p = &proc->refs_by_desc.rb_node;
 	while (*p) {
 		parent = *p;
 		ref = rb_entry(parent, struct binder_ref, rb_node_desc);
-
-		if (new_ref->data.desc < ref->data.desc)
+		smaller_count = desc;
+		ref->rb_node_desc_size++;
+		if (parent->rb_left) {
+			left = rb_entry(parent->rb_left, struct binder_ref,
+					rb_node_desc);
+			smaller_count += left->rb_node_desc_size;
+		}
+		if (smaller_count < ref->data.desc) {
 			p = &(*p)->rb_left;
-		else if (new_ref->data.desc > ref->data.desc)
+		} else {
+			desc = smaller_count + 1;
 			p = &(*p)->rb_right;
-		else
-			BUG();
+		}
 	}
+
+	if (desc == 0)
+		proc->have_ref_with_zero_desc = true;
+	new_ref->data.desc = desc;
+	new_ref->rb_node_desc_size = 1;
 	rb_link_node(&new_ref->rb_node_desc, parent, p);
-	rb_insert_color(&new_ref->rb_node_desc, &proc->refs_by_desc);
+	rb_insert_augmented(&new_ref->rb_node_desc, &proc->refs_by_desc,
+			    &binder_ref_rb_node_desc_callbacks);
 
 	binder_node_lock(node);
 	hlist_add_head(&new_ref->node_entry, &node->refs);
@@ -1185,7 +1182,6 @@ static struct binder_ref *binder_get_ref_for_node_olocked(
 
 static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 {
-	struct dbitmap *dmap = &ref->proc->dmap;
 	bool delete_node = false;
 
 	binder_debug(BINDER_DEBUG_INTERNAL_REFS,
@@ -1193,9 +1189,10 @@ static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 		      ref->proc->pid, ref->data.debug_id, ref->data.desc,
 		      ref->node->debug_id);
 
-	if (dbitmap_enabled(dmap))
-		dbitmap_clear_bit(dmap, ref->data.desc);
-	rb_erase(&ref->rb_node_desc, &ref->proc->refs_by_desc);
+	if (ref->data.desc == 0)
+		ref->proc->have_ref_with_zero_desc = false;
+	rb_erase_augmented(&ref->rb_node_desc, &ref->proc->refs_by_desc,
+			   &binder_ref_rb_node_desc_callbacks);
 	rb_erase(&ref->rb_node_node, &ref->proc->refs_by_node);
 
 	binder_node_inner_lock(ref->node);
@@ -1355,25 +1352,6 @@ static void binder_free_ref(struct binder_ref *ref)
 	kfree(ref);
 }
 
-/* shrink descriptor bitmap if needed */
-static void try_shrink_dmap(struct binder_proc *proc)
-{
-	unsigned long *new;
-	int nbits;
-
-	binder_proc_lock(proc);
-	nbits = dbitmap_shrink_nbits(&proc->dmap);
-	binder_proc_unlock(proc);
-
-	if (!nbits)
-		return;
-
-	new = bitmap_zalloc(nbits, GFP_KERNEL);
-	binder_proc_lock(proc);
-	dbitmap_shrink(&proc->dmap, new, nbits);
-	binder_proc_unlock(proc);
-}
-
 /**
  * binder_update_ref_for_handle() - inc/dec the ref for given handle
  * @proc:	proc containing the ref
@@ -1412,7 +1390,6 @@ static int binder_update_ref_for_handle(struct binder_proc *proc,
 
 	if (delete_ref) {
 		binder_free_ref(ref);
-		try_shrink_dmap(proc);
 	}
 	return ret;
 
@@ -1471,6 +1448,11 @@ static int binder_inc_ref_for_node(struct binder_proc *proc,
 			return -ENOMEM;
 		binder_proc_lock(proc);
 		ref = binder_get_ref_for_node_olocked(proc, node, new_ref);
+		if (!ref) {
+			binder_proc_unlock(proc);
+			kfree(new_ref);
+			return -ENOSPC;
+		}
 	}
 	ret = binder_inc_ref_olocked(ref, strong, target_list);
 	*rdata = ref->data;
@@ -5010,7 +4992,6 @@ static void binder_free_proc(struct binder_proc *proc)
 	put_task_struct(proc->tsk);
 	put_cred(proc->cred);
 	binder_stats_deleted(BINDER_STAT_PROC);
-	dbitmap_free(&proc->dmap);
 	kfree(proc);
 }
 
@@ -5715,7 +5696,6 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	if (proc == NULL)
 		return -ENOMEM;
 
-	dbitmap_init(&proc->dmap);
 	spin_lock_init(&proc->inner_lock);
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 7d4fc53f7a73..8d4d90c08d77 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -14,7 +14,6 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/android/binderfs.h>
 #include "binder_alloc.h"
-#include "dbitmap.h"
 
 struct binder_context {
 	struct binder_node *binder_context_mgr_node;
@@ -299,6 +298,7 @@ struct binder_ref_data {
  * struct binder_ref - struct to track references on nodes
  * @data:        binder_ref_data containing id, handle, and current refcounts
  * @rb_node_desc: node for lookup by @data.desc in proc's rb_tree
+ * @rb_node_desc_size: size of the subtree of @rb_node_desc
  * @rb_node_node: node for lookup by @node in proc's rb_tree
  * @node_entry:  list entry for node->refs list in target node
  *               (protected by @node->lock)
@@ -319,6 +319,7 @@ struct binder_ref {
 	/*   node => refs + procs (proc exit) */
 	struct binder_ref_data data;
 	struct rb_node rb_node_desc;
+	uint32_t rb_node_desc_size;
 	struct rb_node rb_node_node;
 	struct hlist_node node_entry;
 	struct binder_proc *proc;
@@ -369,8 +370,6 @@ struct binder_ref {
  * @freeze_wait:          waitqueue of processes waiting for all outstanding
  *                        transactions to be processed
  *                        (protected by @inner_lock)
- * @dmap                  dbitmap to manage available reference descriptors
- *                        (protected by @outer_lock)
  * @todo:                 list of work for this process
  *                        (protected by @inner_lock)
  * @stats:                per-process binder statistics
@@ -399,6 +398,9 @@ struct binder_ref {
  * @binderfs_entry:       process-specific binderfs log file
  * @oneway_spam_detection_enabled: process enabled oneway spam detection
  *                        or not
+ * @have_ref_with_zero_desc: have a binder_ref reverse for context manager
+ *                        with desc zero.
+ *                        (protected by @outer_lock)
  *
  * Bookkeeping structure for binder processes
  */
@@ -420,7 +422,6 @@ struct binder_proc {
 	bool sync_recv;
 	bool async_recv;
 	wait_queue_head_t freeze_wait;
-	struct dbitmap dmap;
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
@@ -436,6 +437,7 @@ struct binder_proc {
 	spinlock_t outer_lock;
 	struct dentry *binderfs_entry;
 	bool oneway_spam_detection_enabled;
+	bool have_ref_with_zero_desc;
 };
 
 /**
diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
deleted file mode 100644
index 956f1bd087d1..000000000000
--- a/drivers/android/dbitmap.h
+++ /dev/null
@@ -1,168 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2024 Google LLC
- *
- * dbitmap - dynamically sized bitmap library.
- *
- * Used by the binder driver to optimize the allocation of the smallest
- * available descriptor ID. Each bit in the bitmap represents the state
- * of an ID.
- *
- * A dbitmap can grow or shrink as needed. This part has been designed
- * considering that users might need to briefly release their locks in
- * order to allocate memory for the new bitmap. These operations then,
- * are verified to determine if the grow or shrink is sill valid.
- *
- * This library does not provide protection against concurrent access
- * by itself. Binder uses the proc->outer_lock for this purpose.
- */
-
-#ifndef _LINUX_DBITMAP_H
-#define _LINUX_DBITMAP_H
-#include <linux/bitmap.h>
-
-#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
-
-struct dbitmap {
-	unsigned int nbits;
-	unsigned long *map;
-};
-
-static inline int dbitmap_enabled(struct dbitmap *dmap)
-{
-	return !!dmap->nbits;
-}
-
-static inline void dbitmap_free(struct dbitmap *dmap)
-{
-	dmap->nbits = 0;
-	kfree(dmap->map);
-}
-
-/* Returns the nbits that a dbitmap can shrink to, 0 if not possible. */
-static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
-{
-	unsigned int bit;
-
-	if (dmap->nbits <= NBITS_MIN)
-		return 0;
-
-	/*
-	 * Determine if the bitmap can shrink based on the position of
-	 * its last set bit. If the bit is within the first quarter of
-	 * the bitmap then shrinking is possible. In this case, the
-	 * bitmap should shrink to half its current size.
-	 */
-	bit = find_last_bit(dmap->map, dmap->nbits);
-	if (bit < (dmap->nbits >> 2))
-		return dmap->nbits >> 1;
-
-	/* find_last_bit() returns dmap->nbits when no bits are set. */
-	if (bit == dmap->nbits)
-		return NBITS_MIN;
-
-	return 0;
-}
-
-/* Replace the internal bitmap with a new one of different size */
-static inline void
-dbitmap_replace(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
-{
-	bitmap_copy(new, dmap->map, min(dmap->nbits, nbits));
-	kfree(dmap->map);
-	dmap->map = new;
-	dmap->nbits = nbits;
-}
-
-static inline void
-dbitmap_shrink(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
-{
-	if (!new)
-		return;
-
-	/*
-	 * Verify that shrinking to @nbits is still possible. The @new
-	 * bitmap might have been allocated without locks, so this call
-	 * could now be outdated. In this case, free @new and move on.
-	 */
-	if (!dbitmap_enabled(dmap) || dbitmap_shrink_nbits(dmap) != nbits) {
-		kfree(new);
-		return;
-	}
-
-	dbitmap_replace(dmap, new, nbits);
-}
-
-/* Returns the nbits that a dbitmap can grow to. */
-static inline unsigned int dbitmap_grow_nbits(struct dbitmap *dmap)
-{
-	return dmap->nbits << 1;
-}
-
-static inline void
-dbitmap_grow(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
-{
-	/*
-	 * Verify that growing to @nbits is still possible. The @new
-	 * bitmap might have been allocated without locks, so this call
-	 * could now be outdated. In this case, free @new and move on.
-	 */
-	if (!dbitmap_enabled(dmap) || nbits <= dmap->nbits) {
-		kfree(new);
-		return;
-	}
-
-	/*
-	 * Check for ENOMEM after confirming the grow operation is still
-	 * required. This ensures we only disable the dbitmap when it's
-	 * necessary. Once the dbitmap is disabled, binder will fallback
-	 * to slow_desc_lookup_olocked().
-	 */
-	if (!new) {
-		dbitmap_free(dmap);
-		return;
-	}
-
-	dbitmap_replace(dmap, new, nbits);
-}
-
-/*
- * Finds and sets the next zero bit in the bitmap. Upon success @bit
- * is populated with the index and 0 is returned. Otherwise, -ENOSPC
- * is returned to indicate that a dbitmap_grow() is needed.
- */
-static inline int
-dbitmap_acquire_next_zero_bit(struct dbitmap *dmap, unsigned long offset,
-			      unsigned long *bit)
-{
-	unsigned long n;
-
-	n = find_next_zero_bit(dmap->map, dmap->nbits, offset);
-	if (n == dmap->nbits)
-		return -ENOSPC;
-
-	*bit = n;
-	set_bit(n, dmap->map);
-
-	return 0;
-}
-
-static inline void
-dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
-{
-	clear_bit(bit, dmap->map);
-}
-
-static inline int dbitmap_init(struct dbitmap *dmap)
-{
-	dmap->map = bitmap_zalloc(NBITS_MIN, GFP_KERNEL);
-	if (!dmap->map) {
-		dmap->nbits = 0;
-		return -ENOMEM;
-	}
-
-	dmap->nbits = NBITS_MIN;
-
-	return 0;
-}
-#endif

base-commit: a430d95c5efa2b545d26a094eb5f624e36732af0
-- 
2.34.1


