Return-Path: <linux-kernel+bounces-205320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75468FFA96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4171C24010
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBF156C70;
	Fri,  7 Jun 2024 04:27:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B5225D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734437; cv=none; b=iqaQTmVFM5NnhS5sMewcgPw7mRYGTaNjEQrQjMUzbiiFKlLcJOwwowG8le7dmjkdkNzsvVsn3/nvGG85mdjBhlpbYyMkoRFD8n5zk0iK1/rs9j5fI9ipsemcSm9Msy1xpCc1cCmBr0DXFW1cQOoKnYLeaB8a0XxCrvY/ZH2TJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734437; c=relaxed/simple;
	bh=YicI5KhCJ22NH7hYkcTUeuUxzSeyWrG7QIEbyYvUD58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRxu9Sw8yxJeLCK10UkGu9dsbV8IVk3lCPHJRKEMw6JUbqint9XM+SDe08hYQa8Z174qgL86aG6S4flExJm/mucMh5lqAzdCqYZw1f+VavlUQ6dgD4Mw+bRC8MZqJfWf3ITnqApSZUu1SqMX2LqLnUPv2POKJhX6ezDBjiDwCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSjr4fxJzwSDG;
	Fri,  7 Jun 2024 12:23:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C0DB180085;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:00 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 046/110] ubifs-utils: Adapt commit.c in libubifs
Date: Fri, 7 Jun 2024 12:25:11 +0800
Message-ID: <20240607042615.2069840-47-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Adapt commit.c in libubifs, compared with linux kernel implementations:
 1. Remove debug related implementations(eg. dbg_check_old_index), debug
    functions are not needed by fsck, because fsck will check fs in
    another way.
 2. Remove ubifs background commiting related implementations, there will
    be no background ubifs threads in fsck.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/commit.c | 370 ++----------------------------------------
 1 file changed, 10 insertions(+), 360 deletions(-)

diff --git a/ubifs-utils/libubifs/commit.c b/ubifs-utils/libubifs/commit.c
index 5b3a8400..f3b61136 100644
--- a/ubifs-utils/libubifs/commit.c
+++ b/ubifs-utils/libubifs/commit.c
@@ -31,10 +31,13 @@
  * cache.
  */
 
-#include <linux/freezer.h>
-#include <linux/kthread.h>
-#include <linux/slab.h>
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "debug.h"
+#include "defs.h"
+#include "misc.h"
 
 /*
  * nothing_to_commit - check if there is nothing to commit.
@@ -216,7 +219,6 @@ static int do_commit(struct ubifs_info *c)
 out_cancel:
 	spin_lock(&c->cs_lock);
 	c->cmt_state = COMMIT_RESTING;
-	wake_up(&c->cmt_wq);
 	dbg_cmt("commit end");
 	spin_unlock(&c->cs_lock);
 	return 0;
@@ -227,107 +229,12 @@ out:
 	ubifs_err(c, "commit failed, error %d", err);
 	spin_lock(&c->cs_lock);
 	c->cmt_state = COMMIT_BROKEN;
-	wake_up(&c->cmt_wq);
 	spin_unlock(&c->cs_lock);
 	ubifs_ro_mode(c, err);
 	return err;
 }
 
 /**
- * run_bg_commit - run background commit if it is needed.
- * @c: UBIFS file-system description object
- *
- * This function runs background commit if it is needed. Returns zero in case
- * of success and a negative error code in case of failure.
- */
-static int run_bg_commit(struct ubifs_info *c)
-{
-	spin_lock(&c->cs_lock);
-	/*
-	 * Run background commit only if background commit was requested or if
-	 * commit is required.
-	 */
-	if (c->cmt_state != COMMIT_BACKGROUND &&
-	    c->cmt_state != COMMIT_REQUIRED)
-		goto out;
-	spin_unlock(&c->cs_lock);
-
-	down_write(&c->commit_sem);
-	spin_lock(&c->cs_lock);
-	if (c->cmt_state == COMMIT_REQUIRED)
-		c->cmt_state = COMMIT_RUNNING_REQUIRED;
-	else if (c->cmt_state == COMMIT_BACKGROUND)
-		c->cmt_state = COMMIT_RUNNING_BACKGROUND;
-	else
-		goto out_cmt_unlock;
-	spin_unlock(&c->cs_lock);
-
-	return do_commit(c);
-
-out_cmt_unlock:
-	up_write(&c->commit_sem);
-out:
-	spin_unlock(&c->cs_lock);
-	return 0;
-}
-
-/**
- * ubifs_bg_thread - UBIFS background thread function.
- * @info: points to the file-system description object
- *
- * This function implements various file-system background activities:
- * o when a write-buffer timer expires it synchronizes the appropriate
- *   write-buffer;
- * o when the journal is about to be full, it starts in-advance commit.
- *
- * Note, other stuff like background garbage collection may be added here in
- * future.
- */
-int ubifs_bg_thread(void *info)
-{
-	int err;
-	struct ubifs_info *c = info;
-
-	ubifs_msg(c, "background thread \"%s\" started, PID %d",
-		  c->bgt_name, current->pid);
-	set_freezable();
-
-	while (1) {
-		if (kthread_should_stop())
-			break;
-
-		if (try_to_freeze())
-			continue;
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		/* Check if there is something to do */
-		if (!c->need_bgt) {
-			/*
-			 * Nothing prevents us from going sleep now and
-			 * be never woken up and block the task which
-			 * could wait in 'kthread_stop()' forever.
-			 */
-			if (kthread_should_stop())
-				break;
-			schedule();
-			continue;
-		} else
-			__set_current_state(TASK_RUNNING);
-
-		c->need_bgt = 0;
-		err = ubifs_bg_wbufs_sync(c);
-		if (err)
-			ubifs_ro_mode(c, err);
-
-		run_bg_commit(c);
-		cond_resched();
-	}
-
-	ubifs_msg(c, "background thread \"%s\" stops", c->bgt_name);
-	return 0;
-}
-
-/**
  * ubifs_commit_required - set commit state to "required".
  * @c: UBIFS file-system description object
  *
@@ -364,17 +271,8 @@ void ubifs_commit_required(struct ubifs_info *c)
  * This function is called if the journal is full enough to make a commit
  * worthwhile, so background thread is kicked to start it.
  */
-void ubifs_request_bg_commit(struct ubifs_info *c)
+void ubifs_request_bg_commit(__unused struct ubifs_info *c)
 {
-	spin_lock(&c->cs_lock);
-	if (c->cmt_state == COMMIT_RESTING) {
-		dbg_cmt("old: %s, new: %s", dbg_cstate(c->cmt_state),
-			dbg_cstate(COMMIT_BACKGROUND));
-		c->cmt_state = COMMIT_BACKGROUND;
-		spin_unlock(&c->cs_lock);
-		ubifs_wake_up_bgt(c);
-	} else
-		spin_unlock(&c->cs_lock);
 }
 
 /**
@@ -385,18 +283,11 @@ void ubifs_request_bg_commit(struct ubifs_info *c)
  */
 static int wait_for_commit(struct ubifs_info *c)
 {
-	dbg_cmt("pid %d goes sleep", current->pid);
-
 	/*
-	 * The following sleeps if the condition is false, and will be woken
-	 * when the commit ends. It is possible, although very unlikely, that we
-	 * will wake up and see the subsequent commit running, rather than the
-	 * one we were waiting for, and go back to sleep.  However, we will be
-	 * woken again, so there is no danger of sleeping forever.
+	 * All commit operations are executed in synchronization context,
+	 * so it is impossible that more than one threads doing commit.
 	 */
-	wait_event(c->cmt_wq, c->cmt_state != COMMIT_RUNNING_BACKGROUND &&
-			      c->cmt_state != COMMIT_RUNNING_REQUIRED);
-	dbg_cmt("commit finished, pid %d woke up", current->pid);
+	ubifs_assert(c, 0);
 	return 0;
 }
 
@@ -490,244 +381,3 @@ int ubifs_gc_should_commit(struct ubifs_info *c)
 	spin_unlock(&c->cs_lock);
 	return ret;
 }
-
-/*
- * Everything below is related to debugging.
- */
-
-/**
- * struct idx_node - hold index nodes during index tree traversal.
- * @list: list
- * @iip: index in parent (slot number of this indexing node in the parent
- *       indexing node)
- * @upper_key: all keys in this indexing node have to be less or equivalent to
- *             this key
- * @idx: index node (8-byte aligned because all node structures must be 8-byte
- *       aligned)
- */
-struct idx_node {
-	struct list_head list;
-	int iip;
-	union ubifs_key upper_key;
-	struct ubifs_idx_node idx __aligned(8);
-};
-
-/**
- * dbg_old_index_check_init - get information for the next old index check.
- * @c: UBIFS file-system description object
- * @zroot: root of the index
- *
- * This function records information about the index that will be needed for the
- * next old index check i.e. 'dbg_check_old_index()'.
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_old_index_check_init(struct ubifs_info *c, struct ubifs_zbranch *zroot)
-{
-	struct ubifs_idx_node *idx;
-	int lnum, offs, len, err = 0;
-	struct ubifs_debug_info *d = c->dbg;
-
-	d->old_zroot = *zroot;
-	lnum = d->old_zroot.lnum;
-	offs = d->old_zroot.offs;
-	len = d->old_zroot.len;
-
-	idx = kmalloc(c->max_idx_node_sz, GFP_NOFS);
-	if (!idx)
-		return -ENOMEM;
-
-	err = ubifs_read_node(c, idx, UBIFS_IDX_NODE, len, lnum, offs);
-	if (err)
-		goto out;
-
-	d->old_zroot_level = le16_to_cpu(idx->level);
-	d->old_zroot_sqnum = le64_to_cpu(idx->ch.sqnum);
-out:
-	kfree(idx);
-	return err;
-}
-
-/**
- * dbg_check_old_index - check the old copy of the index.
- * @c: UBIFS file-system description object
- * @zroot: root of the new index
- *
- * In order to be able to recover from an unclean unmount, a complete copy of
- * the index must exist on flash. This is the "old" index. The commit process
- * must write the "new" index to flash without overwriting or destroying any
- * part of the old index. This function is run at commit end in order to check
- * that the old index does indeed exist completely intact.
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
-{
-	int lnum, offs, len, err = 0, last_level, child_cnt;
-	int first = 1, iip;
-	struct ubifs_debug_info *d = c->dbg;
-	union ubifs_key lower_key, upper_key, l_key, u_key;
-	unsigned long long last_sqnum;
-	struct ubifs_idx_node *idx;
-	struct list_head list;
-	struct idx_node *i;
-	size_t sz;
-
-	if (!dbg_is_chk_index(c))
-		return 0;
-
-	INIT_LIST_HEAD(&list);
-
-	sz = sizeof(struct idx_node) + ubifs_idx_node_sz(c, c->fanout) -
-	     UBIFS_IDX_NODE_SZ;
-
-	/* Start at the old zroot */
-	lnum = d->old_zroot.lnum;
-	offs = d->old_zroot.offs;
-	len = d->old_zroot.len;
-	iip = 0;
-
-	/*
-	 * Traverse the index tree preorder depth-first i.e. do a node and then
-	 * its subtrees from left to right.
-	 */
-	while (1) {
-		struct ubifs_branch *br;
-
-		/* Get the next index node */
-		i = kmalloc(sz, GFP_NOFS);
-		if (!i) {
-			err = -ENOMEM;
-			goto out_free;
-		}
-		i->iip = iip;
-		/* Keep the index nodes on our path in a linked list */
-		list_add_tail(&i->list, &list);
-		/* Read the index node */
-		idx = &i->idx;
-		err = ubifs_read_node(c, idx, UBIFS_IDX_NODE, len, lnum, offs);
-		if (err)
-			goto out_free;
-		/* Validate index node */
-		child_cnt = le16_to_cpu(idx->child_cnt);
-		if (child_cnt < 1 || child_cnt > c->fanout) {
-			err = 1;
-			goto out_dump;
-		}
-		if (first) {
-			first = 0;
-			/* Check root level and sqnum */
-			if (le16_to_cpu(idx->level) != d->old_zroot_level) {
-				err = 2;
-				goto out_dump;
-			}
-			if (le64_to_cpu(idx->ch.sqnum) != d->old_zroot_sqnum) {
-				err = 3;
-				goto out_dump;
-			}
-			/* Set last values as though root had a parent */
-			last_level = le16_to_cpu(idx->level) + 1;
-			last_sqnum = le64_to_cpu(idx->ch.sqnum) + 1;
-			key_read(c, ubifs_idx_key(c, idx), &lower_key);
-			highest_ino_key(c, &upper_key, INUM_WATERMARK);
-		}
-		key_copy(c, &upper_key, &i->upper_key);
-		if (le16_to_cpu(idx->level) != last_level - 1) {
-			err = 3;
-			goto out_dump;
-		}
-		/*
-		 * The index is always written bottom up hence a child's sqnum
-		 * is always less than the parents.
-		 */
-		if (le64_to_cpu(idx->ch.sqnum) >= last_sqnum) {
-			err = 4;
-			goto out_dump;
-		}
-		/* Check key range */
-		key_read(c, ubifs_idx_key(c, idx), &l_key);
-		br = ubifs_idx_branch(c, idx, child_cnt - 1);
-		key_read(c, &br->key, &u_key);
-		if (keys_cmp(c, &lower_key, &l_key) > 0) {
-			err = 5;
-			goto out_dump;
-		}
-		if (keys_cmp(c, &upper_key, &u_key) < 0) {
-			err = 6;
-			goto out_dump;
-		}
-		if (keys_cmp(c, &upper_key, &u_key) == 0)
-			if (!is_hash_key(c, &u_key)) {
-				err = 7;
-				goto out_dump;
-			}
-		/* Go to next index node */
-		if (le16_to_cpu(idx->level) == 0) {
-			/* At the bottom, so go up until can go right */
-			while (1) {
-				/* Drop the bottom of the list */
-				list_del(&i->list);
-				kfree(i);
-				/* No more list means we are done */
-				if (list_empty(&list))
-					goto out;
-				/* Look at the new bottom */
-				i = list_entry(list.prev, struct idx_node,
-					       list);
-				idx = &i->idx;
-				/* Can we go right */
-				if (iip + 1 < le16_to_cpu(idx->child_cnt)) {
-					iip = iip + 1;
-					break;
-				} else
-					/* Nope, so go up again */
-					iip = i->iip;
-			}
-		} else
-			/* Go down left */
-			iip = 0;
-		/*
-		 * We have the parent in 'idx' and now we set up for reading the
-		 * child pointed to by slot 'iip'.
-		 */
-		last_level = le16_to_cpu(idx->level);
-		last_sqnum = le64_to_cpu(idx->ch.sqnum);
-		br = ubifs_idx_branch(c, idx, iip);
-		lnum = le32_to_cpu(br->lnum);
-		offs = le32_to_cpu(br->offs);
-		len = le32_to_cpu(br->len);
-		key_read(c, &br->key, &lower_key);
-		if (iip + 1 < le16_to_cpu(idx->child_cnt)) {
-			br = ubifs_idx_branch(c, idx, iip + 1);
-			key_read(c, &br->key, &upper_key);
-		} else
-			key_copy(c, &i->upper_key, &upper_key);
-	}
-out:
-	err = dbg_old_index_check_init(c, zroot);
-	if (err)
-		goto out_free;
-
-	return 0;
-
-out_dump:
-	ubifs_err(c, "dumping index node (iip=%d)", i->iip);
-	ubifs_dump_node(c, idx, ubifs_idx_node_sz(c, c->fanout));
-	list_del(&i->list);
-	kfree(i);
-	if (!list_empty(&list)) {
-		i = list_entry(list.prev, struct idx_node, list);
-		ubifs_err(c, "dumping parent index node");
-		ubifs_dump_node(c, &i->idx, ubifs_idx_node_sz(c, c->fanout));
-	}
-out_free:
-	while (!list_empty(&list)) {
-		i = list_entry(list.next, struct idx_node, list);
-		list_del(&i->list);
-		kfree(i);
-	}
-	ubifs_err(c, "failed, error %d", err);
-	if (err > 0)
-		err = -EINVAL;
-	return err;
-}
-- 
2.13.6


