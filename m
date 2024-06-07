Return-Path: <linux-kernel+bounces-205352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735B8FFAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF201C24104
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78815F303;
	Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836515B967
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734458; cv=none; b=Uz+KkTCOu8GzVJcLVyWNYQiSsMi8AVFTQ4MDhsd+Jz5InaOTVClayifckolTC/Wp/Qr/ns4lzyso33LD9LlXAWuoIgINoo1JTzSTztvqGlER19y+/1INtlVq1Eh1iSLbPXsGcUWwS1Tw0i9TMxmQXbXwa2thqFgpg7sPOndQ4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734458; c=relaxed/simple;
	bh=Akto7R4RdiAnr1AMcXVjW0NlH9pRkPykzW1pP2JPmf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7RPJ+2Z/L5QcZHU3v9Usq3JKeb2Bt5NU4NOA9+ICOCShAKlATDnRQpZOthowjO8PLAj/RYR+5pEme+JjOYQQCSUoHfb1vEI3tAplnFO6C7u4WCLIJu233KCYN4tPen8AVRy2GBR/JdL0nZHDSpCBdCeyYiE7LH3jqR1rqHkHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSnD6nTYzdZLS;
	Fri,  7 Jun 2024 12:26:08 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D8F76140413;
	Fri,  7 Jun 2024 12:27:18 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:04 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 051/110] ubifs-utils: Adapt orphan.c in libubifs
Date: Fri, 7 Jun 2024 12:25:16 +0800
Message-ID: <20240607042615.2069840-52-chengzhihao1@huawei.com>
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

Adapt orphan.c in libubifs, compared with linux kernel implementations:
 1. Keep the commit related implementations, because do_commit depends
    on these functions which will be invoked in fsck.
 2. Keep the orphan replaying implementations, because fsck needs them.
 3. Other implementations are removed which won't be used in mkfs/fsck.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/orphan.c | 357 +-----------------------------------------
 1 file changed, 8 insertions(+), 349 deletions(-)

diff --git a/ubifs-utils/libubifs/orphan.c b/ubifs-utils/libubifs/orphan.c
index fb957d96..2f318748 100644
--- a/ubifs-utils/libubifs/orphan.c
+++ b/ubifs-utils/libubifs/orphan.c
@@ -7,7 +7,14 @@
  * Author: Adrian Hunter
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 /*
  * An orphan is an inode number whose inode node has been committed to the index
@@ -43,137 +50,6 @@
 static int dbg_check_orphans(struct ubifs_info *c);
 
 /**
- * ubifs_add_orphan - add an orphan.
- * @c: UBIFS file-system description object
- * @inum: orphan inode number
- *
- * Add an orphan. This function is called when an inodes link count drops to
- * zero.
- */
-int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
-{
-	struct ubifs_orphan *orphan, *o;
-	struct rb_node **p, *parent = NULL;
-
-	orphan = kzalloc(sizeof(struct ubifs_orphan), GFP_NOFS);
-	if (!orphan)
-		return -ENOMEM;
-	orphan->inum = inum;
-	orphan->new = 1;
-
-	spin_lock(&c->orphan_lock);
-	if (c->tot_orphans >= c->max_orphans) {
-		spin_unlock(&c->orphan_lock);
-		kfree(orphan);
-		return -ENFILE;
-	}
-	p = &c->orph_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct ubifs_orphan, rb);
-		if (inum < o->inum)
-			p = &(*p)->rb_left;
-		else if (inum > o->inum)
-			p = &(*p)->rb_right;
-		else {
-			ubifs_err(c, "orphaned twice");
-			spin_unlock(&c->orphan_lock);
-			kfree(orphan);
-			return -EINVAL;
-		}
-	}
-	c->tot_orphans += 1;
-	c->new_orphans += 1;
-	rb_link_node(&orphan->rb, parent, p);
-	rb_insert_color(&orphan->rb, &c->orph_tree);
-	list_add_tail(&orphan->list, &c->orph_list);
-	list_add_tail(&orphan->new_list, &c->orph_new);
-
-	spin_unlock(&c->orphan_lock);
-	dbg_gen("ino %lu", (unsigned long)inum);
-	return 0;
-}
-
-static struct ubifs_orphan *lookup_orphan(struct ubifs_info *c, ino_t inum)
-{
-	struct ubifs_orphan *o;
-	struct rb_node *p;
-
-	p = c->orph_tree.rb_node;
-	while (p) {
-		o = rb_entry(p, struct ubifs_orphan, rb);
-		if (inum < o->inum)
-			p = p->rb_left;
-		else if (inum > o->inum)
-			p = p->rb_right;
-		else {
-			return o;
-		}
-	}
-	return NULL;
-}
-
-static void __orphan_drop(struct ubifs_info *c, struct ubifs_orphan *o)
-{
-	rb_erase(&o->rb, &c->orph_tree);
-	list_del(&o->list);
-	c->tot_orphans -= 1;
-
-	if (o->new) {
-		list_del(&o->new_list);
-		c->new_orphans -= 1;
-	}
-
-	kfree(o);
-}
-
-static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
-{
-	if (orph->del) {
-		dbg_gen("deleted twice ino %lu", (unsigned long)orph->inum);
-		return;
-	}
-
-	if (orph->cmt) {
-		orph->del = 1;
-		rb_erase(&orph->rb, &c->orph_tree);
-		orph->dnext = c->orph_dnext;
-		c->orph_dnext = orph;
-		dbg_gen("delete later ino %lu", (unsigned long)orph->inum);
-		return;
-	}
-
-	__orphan_drop(c, orph);
-}
-
-/**
- * ubifs_delete_orphan - delete an orphan.
- * @c: UBIFS file-system description object
- * @inum: orphan inode number
- *
- * Delete an orphan. This function is called when an inode is deleted.
- */
-void ubifs_delete_orphan(struct ubifs_info *c, ino_t inum)
-{
-	struct ubifs_orphan *orph;
-
-	spin_lock(&c->orphan_lock);
-
-	orph = lookup_orphan(c, inum);
-	if (!orph) {
-		spin_unlock(&c->orphan_lock);
-		ubifs_err(c, "missing orphan ino %lu", (unsigned long)inum);
-		dump_stack();
-
-		return;
-	}
-
-	orphan_delete(c, orph);
-
-	spin_unlock(&c->orphan_lock);
-}
-
-/**
  * ubifs_orphan_start_commit - start commit of orphans.
  * @c: UBIFS file-system description object
  *
@@ -724,224 +600,7 @@ int ubifs_mount_orphans(struct ubifs_info *c, int unclean, int read_only)
 	return err;
 }
 
-/*
- * Everything below is related to debugging.
- */
-
-struct check_orphan {
-	struct rb_node rb;
-	ino_t inum;
-};
-
-struct check_info {
-	unsigned long last_ino;
-	unsigned long tot_inos;
-	unsigned long missing;
-	unsigned long long leaf_cnt;
-	struct ubifs_ino_node *node;
-	struct rb_root root;
-};
-
-static bool dbg_find_orphan(struct ubifs_info *c, ino_t inum)
-{
-	bool found = false;
-
-	spin_lock(&c->orphan_lock);
-	found = !!lookup_orphan(c, inum);
-	spin_unlock(&c->orphan_lock);
-
-	return found;
-}
-
-static int dbg_ins_check_orphan(struct rb_root *root, ino_t inum)
-{
-	struct check_orphan *orphan, *o;
-	struct rb_node **p, *parent = NULL;
-
-	orphan = kzalloc(sizeof(struct check_orphan), GFP_NOFS);
-	if (!orphan)
-		return -ENOMEM;
-	orphan->inum = inum;
-
-	p = &root->rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct check_orphan, rb);
-		if (inum < o->inum)
-			p = &(*p)->rb_left;
-		else if (inum > o->inum)
-			p = &(*p)->rb_right;
-		else {
-			kfree(orphan);
-			return 0;
-		}
-	}
-	rb_link_node(&orphan->rb, parent, p);
-	rb_insert_color(&orphan->rb, root);
-	return 0;
-}
-
-static int dbg_find_check_orphan(struct rb_root *root, ino_t inum)
-{
-	struct check_orphan *o;
-	struct rb_node *p;
-
-	p = root->rb_node;
-	while (p) {
-		o = rb_entry(p, struct check_orphan, rb);
-		if (inum < o->inum)
-			p = p->rb_left;
-		else if (inum > o->inum)
-			p = p->rb_right;
-		else
-			return 1;
-	}
-	return 0;
-}
-
-static void dbg_free_check_tree(struct rb_root *root)
-{
-	struct check_orphan *o, *n;
-
-	rbtree_postorder_for_each_entry_safe(o, n, root, rb)
-		kfree(o);
-}
-
-static int dbg_orphan_check(struct ubifs_info *c, struct ubifs_zbranch *zbr,
-			    void *priv)
+static int dbg_check_orphans(__unused struct ubifs_info *c)
 {
-	struct check_info *ci = priv;
-	ino_t inum;
-	int err;
-
-	inum = key_inum(c, &zbr->key);
-	if (inum != ci->last_ino) {
-		/*
-		 * Lowest node type is the inode node or xattr entry(when
-		 * selinux/encryption is enabled), so it comes first
-		 */
-		if (key_type(c, &zbr->key) != UBIFS_INO_KEY &&
-		    key_type(c, &zbr->key) != UBIFS_XENT_KEY)
-			ubifs_err(c, "found orphan node ino %lu, type %d",
-				  (unsigned long)inum, key_type(c, &zbr->key));
-		ci->last_ino = inum;
-		ci->tot_inos += 1;
-		err = ubifs_tnc_read_node(c, zbr, ci->node);
-		if (err) {
-			ubifs_err(c, "node read failed, error %d", err);
-			return err;
-		}
-		if (ci->node->nlink == 0)
-			/* Must be recorded as an orphan */
-			if (!dbg_find_check_orphan(&ci->root, inum) &&
-			    !dbg_find_orphan(c, inum)) {
-				ubifs_err(c, "missing orphan, ino %lu",
-					  (unsigned long)inum);
-				ci->missing += 1;
-			}
-	}
-	ci->leaf_cnt += 1;
 	return 0;
 }
-
-static int dbg_read_orphans(struct check_info *ci, struct ubifs_scan_leb *sleb)
-{
-	struct ubifs_scan_node *snod;
-	struct ubifs_orph_node *orph;
-	ino_t inum;
-	int i, n, err;
-
-	list_for_each_entry(snod, &sleb->nodes, list) {
-		cond_resched();
-		if (snod->type != UBIFS_ORPH_NODE)
-			continue;
-		orph = snod->node;
-		n = (le32_to_cpu(orph->ch.len) - UBIFS_ORPH_NODE_SZ) >> 3;
-		for (i = 0; i < n; i++) {
-			inum = le64_to_cpu(orph->inos[i]);
-			err = dbg_ins_check_orphan(&ci->root, inum);
-			if (err)
-				return err;
-		}
-	}
-	return 0;
-}
-
-static int dbg_scan_orphans(struct ubifs_info *c, struct check_info *ci)
-{
-	int lnum, err = 0;
-	void *buf;
-
-	/* Check no-orphans flag and skip this if no orphans */
-	if (c->no_orphs)
-		return 0;
-
-	buf = __vmalloc(c->leb_size, GFP_NOFS);
-	if (!buf) {
-		ubifs_err(c, "cannot allocate memory to check orphans");
-		return 0;
-	}
-
-	for (lnum = c->orph_first; lnum <= c->orph_last; lnum++) {
-		struct ubifs_scan_leb *sleb;
-
-		sleb = ubifs_scan(c, lnum, 0, buf, 0);
-		if (IS_ERR(sleb)) {
-			err = PTR_ERR(sleb);
-			break;
-		}
-
-		err = dbg_read_orphans(ci, sleb);
-		ubifs_scan_destroy(sleb);
-		if (err)
-			break;
-	}
-
-	vfree(buf);
-	return err;
-}
-
-static int dbg_check_orphans(struct ubifs_info *c)
-{
-	struct check_info ci;
-	int err;
-
-	if (!dbg_is_chk_orph(c))
-		return 0;
-
-	ci.last_ino = 0;
-	ci.tot_inos = 0;
-	ci.missing  = 0;
-	ci.leaf_cnt = 0;
-	ci.root = RB_ROOT;
-	ci.node = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
-	if (!ci.node) {
-		ubifs_err(c, "out of memory");
-		return -ENOMEM;
-	}
-
-	err = dbg_scan_orphans(c, &ci);
-	if (err)
-		goto out;
-
-	err = dbg_walk_index(c, &dbg_orphan_check, NULL, &ci);
-	if (err) {
-		ubifs_err(c, "cannot scan TNC, error %d", err);
-		goto out;
-	}
-
-	if (ci.missing) {
-		ubifs_err(c, "%lu missing orphan(s)", ci.missing);
-		err = -EINVAL;
-		goto out;
-	}
-
-	dbg_cmt("last inode number is %lu", ci.last_ino);
-	dbg_cmt("total number of inodes is %lu", ci.tot_inos);
-	dbg_cmt("total number of leaf nodes is %llu", ci.leaf_cnt);
-
-out:
-	dbg_free_check_tree(&ci.root);
-	kfree(ci.node);
-	return err;
-}
-- 
2.13.6


