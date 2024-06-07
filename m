Return-Path: <linux-kernel+bounces-205330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2F8FFAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB312873E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15315ADA4;
	Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D38F96
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734441; cv=none; b=ZOAbWK4ALaZMRWmUu2d4cppMzVuRPqM2IbdK/NCrKbtfJvpDaq8HH9rkpGFEXEEoL+x9J6kYFA25bJiKMwRKjpGAM9g03jIuiYjcVUA0S+H5VBQPNd0Jb9TvSF1lGPoM8QcnkXgZs0Bxn5LqiDwjF609Msrb9d38wfLP+/kk0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734441; c=relaxed/simple;
	bh=IlqcS8EUYpSF6RdoGEB1jAueJ5qsOK/aqU0ez2A1jFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdTkrmhqsGYPn4AIrKy5akgSUfNBsLdjnbb2GCGpi+Y1NO8tAJh+Ur6wC9d9S/2XXmGRWAtirVUrhEwaWGlIXPJa1RZ3L9cXsFK+grNGBR6SZS4V46G5SgQxNOcCofiHxMCUUBPQhmLOcTcEYDuaQfC2xKbWDT/25iHjLB7Yde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjr6lxhz1SB3b;
	Fri,  7 Jun 2024 12:23:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B1F318007E;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:01 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 047/110] ubifs-utils: Adapt debug subsystem in libubifs
Date: Fri, 7 Jun 2024 12:25:12 +0800
Message-ID: <20240607042615.2069840-48-chengzhihao1@huawei.com>
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

Adapt debug subsystem(debug.c, debug.h) in libubifs, compared with
linux kernel implementations:
 1. Only keep the disk data and space statistics dumping implementations,
    dbg_walk_index and add_size which are used by fsck, other debuging
    related implementations and sysfs interfaces are removed, because
    fsck will check fs in another way.
 2. Change the behavior of ubifs_assert_failed(), make filesystem
    readonly when assertion is failed.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/debug.c | 2090 +-----------------------------------------
 ubifs-utils/libubifs/debug.h |  259 ++----
 ubifs-utils/libubifs/ubifs.h |    2 -
 3 files changed, 95 insertions(+), 2256 deletions(-)

diff --git a/ubifs-utils/libubifs/debug.c b/ubifs-utils/libubifs/debug.c
index ac77ac1f..a2109906 100644
--- a/ubifs-utils/libubifs/debug.c
+++ b/ubifs-utils/libubifs/debug.c
@@ -15,13 +15,17 @@
  * various local functions of those subsystems.
  */
 
-#include <linux/module.h>
-#include <linux/debugfs.h>
-#include <linux/math64.h>
-#include <linux/uaccess.h>
-#include <linux/random.h>
-#include <linux/ctype.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 static DEFINE_SPINLOCK(dbg_lock);
 
@@ -221,76 +225,6 @@ static void dump_ch(const struct ubifs_ch *ch)
 	pr_err("\tlen            %u\n", le32_to_cpu(ch->len));
 }
 
-void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
-{
-	const struct ubifs_inode *ui = ubifs_inode(inode);
-	struct fscrypt_name nm = {0};
-	union ubifs_key key;
-	struct ubifs_dent_node *dent, *pdent = NULL;
-	int count = 2;
-
-	pr_err("Dump in-memory inode:");
-	pr_err("\tinode          %lu\n", inode->i_ino);
-	pr_err("\tsize           %llu\n",
-	       (unsigned long long)i_size_read(inode));
-	pr_err("\tnlink          %u\n", inode->i_nlink);
-	pr_err("\tuid            %u\n", (unsigned int)i_uid_read(inode));
-	pr_err("\tgid            %u\n", (unsigned int)i_gid_read(inode));
-	pr_err("\tatime          %u.%u\n",
-	       (unsigned int) inode_get_atime_sec(inode),
-	       (unsigned int) inode_get_atime_nsec(inode));
-	pr_err("\tmtime          %u.%u\n",
-	       (unsigned int) inode_get_mtime_sec(inode),
-	       (unsigned int) inode_get_mtime_nsec(inode));
-	pr_err("\tctime          %u.%u\n",
-	       (unsigned int) inode_get_ctime_sec(inode),
-	       (unsigned int) inode_get_ctime_nsec(inode));
-	pr_err("\tcreat_sqnum    %llu\n", ui->creat_sqnum);
-	pr_err("\txattr_size     %u\n", ui->xattr_size);
-	pr_err("\txattr_cnt      %u\n", ui->xattr_cnt);
-	pr_err("\txattr_names    %u\n", ui->xattr_names);
-	pr_err("\tdirty          %u\n", ui->dirty);
-	pr_err("\txattr          %u\n", ui->xattr);
-	pr_err("\tbulk_read      %u\n", ui->bulk_read);
-	pr_err("\tsynced_i_size  %llu\n",
-	       (unsigned long long)ui->synced_i_size);
-	pr_err("\tui_size        %llu\n",
-	       (unsigned long long)ui->ui_size);
-	pr_err("\tflags          %d\n", ui->flags);
-	pr_err("\tcompr_type     %d\n", ui->compr_type);
-	pr_err("\tlast_page_read %lu\n", ui->last_page_read);
-	pr_err("\tread_in_a_row  %lu\n", ui->read_in_a_row);
-	pr_err("\tdata_len       %d\n", ui->data_len);
-
-	if (!S_ISDIR(inode->i_mode))
-		return;
-
-	pr_err("List of directory entries:\n");
-	ubifs_assert(c, !mutex_is_locked(&c->tnc_mutex));
-
-	lowest_dent_key(c, &key, inode->i_ino);
-	while (1) {
-		dent = ubifs_tnc_next_ent(c, &key, &nm);
-		if (IS_ERR(dent)) {
-			if (PTR_ERR(dent) != -ENOENT)
-				pr_err("error %ld\n", PTR_ERR(dent));
-			break;
-		}
-
-		pr_err("\t%d: inode %llu, type %s, len %d\n",
-		       count++, (unsigned long long) le64_to_cpu(dent->inum),
-		       get_dent_type(dent->type),
-		       le16_to_cpu(dent->nlen));
-
-		fname_name(&nm) = dent->name;
-		fname_len(&nm) = le16_to_cpu(dent->nlen);
-		kfree(pdent);
-		pdent = dent;
-		key_read(c, &dent->key, &key);
-	}
-	kfree(pdent);
-}
-
 void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 {
 	int i, n, type, safe_len, max_node_len, min_node_len;
@@ -301,7 +235,7 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 	/* If the magic is incorrect, just hexdump the first bytes */
 	if (le32_to_cpu(ch->magic) != UBIFS_NODE_MAGIC) {
 		pr_err("Not a node, first %zu bytes:", UBIFS_CH_SZ);
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 32, 1,
+		print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 1,
 			       (void *)node, UBIFS_CH_SZ, 1);
 		return;
 	}
@@ -331,7 +265,7 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 		       safe_len > UBIFS_CH_SZ ?
 		       safe_len - (int)UBIFS_CH_SZ : 0);
 		if (safe_len > UBIFS_CH_SZ)
-			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 32, 1,
+			print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 1,
 				       (void *)node + UBIFS_CH_SZ,
 				       safe_len - UBIFS_CH_SZ, 0);
 		goto out_unlock;
@@ -509,7 +443,7 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 		       le32_to_cpu(ch->len) - (unsigned int)UBIFS_DATA_NODE_SZ);
 		pr_err("\tdata (length = %d):\n",
 		       safe_len - (int)UBIFS_DATA_NODE_SZ);
-		print_hex_dump(KERN_ERR, "\t", DUMP_PREFIX_OFFSET, 32, 1,
+		print_hex_dump("\t", DUMP_PREFIX_OFFSET, 32, 1,
 			       (void *)&dn->data,
 			       safe_len - (int)UBIFS_DATA_NODE_SZ, 0);
 		break;
@@ -580,28 +514,11 @@ out_unlock:
 	spin_unlock(&dbg_lock);
 }
 
-void ubifs_dump_budget_req(const struct ubifs_budget_req *req)
-{
-	spin_lock(&dbg_lock);
-	pr_err("Budgeting request: new_ino %d, dirtied_ino %d\n",
-	       req->new_ino, req->dirtied_ino);
-	pr_err("\tnew_ino_d   %d, dirtied_ino_d %d\n",
-	       req->new_ino_d, req->dirtied_ino_d);
-	pr_err("\tnew_page    %d, dirtied_page %d\n",
-	       req->new_page, req->dirtied_page);
-	pr_err("\tnew_dent    %d, mod_dent     %d\n",
-	       req->new_dent, req->mod_dent);
-	pr_err("\tidx_growth  %d\n", req->idx_growth);
-	pr_err("\tdata_growth %d dd_growth     %d\n",
-	       req->data_growth, req->dd_growth);
-	spin_unlock(&dbg_lock);
-}
-
 void ubifs_dump_lstats(const struct ubifs_lp_stats *lst)
 {
 	spin_lock(&dbg_lock);
 	pr_err("(pid %d) Lprops statistics: empty_lebs %d, idx_lebs  %d\n",
-	       current->pid, lst->empty_lebs, lst->idx_lebs);
+	       getpid(), lst->empty_lebs, lst->idx_lebs);
 	pr_err("\ttaken_empty_lebs %d, total_free %lld, total_dirty %lld\n",
 	       lst->taken_empty_lebs, lst->total_free, lst->total_dirty);
 	pr_err("\ttotal_used %lld, total_dark %lld, total_dead %lld\n",
@@ -620,7 +537,7 @@ void ubifs_dump_budg(struct ubifs_info *c, const struct ubifs_budg_info *bi)
 	spin_lock(&c->space_lock);
 	spin_lock(&dbg_lock);
 	pr_err("(pid %d) Budgeting info: data budget sum %lld, total budget sum %lld\n",
-	       current->pid, bi->data_growth + bi->dd_growth,
+	       getpid(), bi->data_growth + bi->dd_growth,
 	       bi->data_growth + bi->dd_growth + bi->idx_growth);
 	pr_err("\tbudg_data_growth %lld, budg_dd_growth %lld, budg_idx_growth %lld\n",
 	       bi->data_growth, bi->dd_growth, bi->idx_growth);
@@ -774,7 +691,7 @@ void ubifs_dump_lprops(struct ubifs_info *c)
 	struct ubifs_lprops lp;
 	struct ubifs_lp_stats lst;
 
-	pr_err("(pid %d) start dumping LEB properties\n", current->pid);
+	pr_err("(pid %d) start dumping LEB properties\n", getpid());
 	ubifs_get_lp_stats(c, &lst);
 	ubifs_dump_lstats(&lst);
 
@@ -787,7 +704,7 @@ void ubifs_dump_lprops(struct ubifs_info *c)
 
 		ubifs_dump_lprop(c, &lp);
 	}
-	pr_err("(pid %d) finish dumping LEB properties\n", current->pid);
+	pr_err("(pid %d) finish dumping LEB properties\n", getpid());
 }
 
 void ubifs_dump_lpt_info(struct ubifs_info *c)
@@ -795,7 +712,7 @@ void ubifs_dump_lpt_info(struct ubifs_info *c)
 	int i;
 
 	spin_lock(&dbg_lock);
-	pr_err("(pid %d) dumping LPT information\n", current->pid);
+	pr_err("(pid %d) dumping LPT information\n", getpid());
 	pr_err("\tlpt_sz:        %lld\n", c->lpt_sz);
 	pr_err("\tpnode_sz:      %d\n", c->pnode_sz);
 	pr_err("\tnnode_sz:      %d\n", c->nnode_sz);
@@ -834,7 +751,7 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 	struct ubifs_scan_node *snod;
 	void *buf;
 
-	pr_err("(pid %d) start dumping LEB %d\n", current->pid, lnum);
+	pr_err("(pid %d) start dumping LEB %d\n", getpid(), lnum);
 
 	buf = __vmalloc(c->leb_size, GFP_NOFS);
 	if (!buf) {
@@ -858,7 +775,7 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 		ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
 	}
 
-	pr_err("(pid %d) finish dumping LEB %d\n", current->pid, lnum);
+	pr_err("(pid %d) finish dumping LEB %d\n", getpid(), lnum);
 	ubifs_scan_destroy(sleb);
 
 out:
@@ -905,12 +822,13 @@ void ubifs_dump_znode(const struct ubifs_info *c,
 	spin_unlock(&dbg_lock);
 }
 
-void ubifs_dump_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat)
+void ubifs_dump_heap(__unused struct ubifs_info *c, struct ubifs_lpt_heap *heap,
+		     int cat)
 {
 	int i;
 
 	pr_err("(pid %d) start dumping heap cat %d (%d elements)\n",
-	       current->pid, cat, heap->cnt);
+	       getpid(), cat, heap->cnt);
 	for (i = 0; i < heap->cnt; i++) {
 		struct ubifs_lprops *lprops = heap->arr[i];
 
@@ -918,15 +836,15 @@ void ubifs_dump_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat)
 		       i, lprops->lnum, lprops->hpos, lprops->free,
 		       lprops->dirty, lprops->flags);
 	}
-	pr_err("(pid %d) finish dumping heap\n", current->pid);
+	pr_err("(pid %d) finish dumping heap\n", getpid());
 }
 
-void ubifs_dump_pnode(struct ubifs_info *c, struct ubifs_pnode *pnode,
+void ubifs_dump_pnode(__unused struct ubifs_info *c, struct ubifs_pnode *pnode,
 		      struct ubifs_nnode *parent, int iip)
 {
 	int i;
 
-	pr_err("(pid %d) dumping pnode:\n", current->pid);
+	pr_err("(pid %d) dumping pnode:\n", getpid());
 	pr_err("\taddress %zx parent %zx cnext %zx\n",
 	       (size_t)pnode, (size_t)parent, (size_t)pnode->cnext);
 	pr_err("\tflags %lu iip %d level %d num %d\n",
@@ -939,632 +857,6 @@ void ubifs_dump_pnode(struct ubifs_info *c, struct ubifs_pnode *pnode,
 	}
 }
 
-void ubifs_dump_tnc(struct ubifs_info *c)
-{
-	struct ubifs_znode *znode;
-	int level;
-
-	pr_err("\n");
-	pr_err("(pid %d) start dumping TNC tree\n", current->pid);
-	znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, NULL);
-	level = znode->level;
-	pr_err("== Level %d ==\n", level);
-	while (znode) {
-		if (level != znode->level) {
-			level = znode->level;
-			pr_err("== Level %d ==\n", level);
-		}
-		ubifs_dump_znode(c, znode);
-		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
-	}
-	pr_err("(pid %d) finish dumping TNC tree\n", current->pid);
-}
-
-static int dump_znode(struct ubifs_info *c, struct ubifs_znode *znode,
-		      void *priv)
-{
-	ubifs_dump_znode(c, znode);
-	return 0;
-}
-
-/**
- * ubifs_dump_index - dump the on-flash index.
- * @c: UBIFS file-system description object
- *
- * This function dumps whole UBIFS indexing B-tree, unlike 'ubifs_dump_tnc()'
- * which dumps only in-memory znodes and does not read znodes which from flash.
- */
-void ubifs_dump_index(struct ubifs_info *c)
-{
-	dbg_walk_index(c, NULL, dump_znode, NULL);
-}
-
-/**
- * dbg_save_space_info - save information about flash space.
- * @c: UBIFS file-system description object
- *
- * This function saves information about UBIFS free space, dirty space, etc, in
- * order to check it later.
- */
-void dbg_save_space_info(struct ubifs_info *c)
-{
-	struct ubifs_debug_info *d = c->dbg;
-	int freeable_cnt;
-
-	spin_lock(&c->space_lock);
-	memcpy(&d->saved_lst, &c->lst, sizeof(struct ubifs_lp_stats));
-	memcpy(&d->saved_bi, &c->bi, sizeof(struct ubifs_budg_info));
-	d->saved_idx_gc_cnt = c->idx_gc_cnt;
-
-	/*
-	 * We use a dirty hack here and zero out @c->freeable_cnt, because it
-	 * affects the free space calculations, and UBIFS might not know about
-	 * all freeable eraseblocks. Indeed, we know about freeable eraseblocks
-	 * only when we read their lprops, and we do this only lazily, upon the
-	 * need. So at any given point of time @c->freeable_cnt might be not
-	 * exactly accurate.
-	 *
-	 * Just one example about the issue we hit when we did not zero
-	 * @c->freeable_cnt.
-	 * 1. The file-system is mounted R/O, c->freeable_cnt is %0. We save the
-	 *    amount of free space in @d->saved_free
-	 * 2. We re-mount R/W, which makes UBIFS to read the "lsave"
-	 *    information from flash, where we cache LEBs from various
-	 *    categories ('ubifs_remount_fs()' -> 'ubifs_lpt_init()'
-	 *    -> 'lpt_init_wr()' -> 'read_lsave()' -> 'ubifs_lpt_lookup()'
-	 *    -> 'ubifs_get_pnode()' -> 'update_cats()'
-	 *    -> 'ubifs_add_to_cat()').
-	 * 3. Lsave contains a freeable eraseblock, and @c->freeable_cnt
-	 *    becomes %1.
-	 * 4. We calculate the amount of free space when the re-mount is
-	 *    finished in 'dbg_check_space_info()' and it does not match
-	 *    @d->saved_free.
-	 */
-	freeable_cnt = c->freeable_cnt;
-	c->freeable_cnt = 0;
-	d->saved_free = ubifs_get_free_space_nolock(c);
-	c->freeable_cnt = freeable_cnt;
-	spin_unlock(&c->space_lock);
-}
-
-/**
- * dbg_check_space_info - check flash space information.
- * @c: UBIFS file-system description object
- *
- * This function compares current flash space information with the information
- * which was saved when the 'dbg_save_space_info()' function was called.
- * Returns zero if the information has not changed, and %-EINVAL if it has
- * changed.
- */
-int dbg_check_space_info(struct ubifs_info *c)
-{
-	struct ubifs_debug_info *d = c->dbg;
-	struct ubifs_lp_stats lst;
-	long long free;
-	int freeable_cnt;
-
-	spin_lock(&c->space_lock);
-	freeable_cnt = c->freeable_cnt;
-	c->freeable_cnt = 0;
-	free = ubifs_get_free_space_nolock(c);
-	c->freeable_cnt = freeable_cnt;
-	spin_unlock(&c->space_lock);
-
-	if (free != d->saved_free) {
-		ubifs_err(c, "free space changed from %lld to %lld",
-			  d->saved_free, free);
-		goto out;
-	}
-
-	return 0;
-
-out:
-	ubifs_msg(c, "saved lprops statistics dump");
-	ubifs_dump_lstats(&d->saved_lst);
-	ubifs_msg(c, "saved budgeting info dump");
-	ubifs_dump_budg(c, &d->saved_bi);
-	ubifs_msg(c, "saved idx_gc_cnt %d", d->saved_idx_gc_cnt);
-	ubifs_msg(c, "current lprops statistics dump");
-	ubifs_get_lp_stats(c, &lst);
-	ubifs_dump_lstats(&lst);
-	ubifs_msg(c, "current budgeting info dump");
-	ubifs_dump_budg(c, &c->bi);
-	dump_stack();
-	return -EINVAL;
-}
-
-/**
- * dbg_check_synced_i_size - check synchronized inode size.
- * @c: UBIFS file-system description object
- * @inode: inode to check
- *
- * If inode is clean, synchronized inode size has to be equivalent to current
- * inode size. This function has to be called only for locked inodes (@i_mutex
- * has to be locked). Returns %0 if synchronized inode size if correct, and
- * %-EINVAL if not.
- */
-int dbg_check_synced_i_size(const struct ubifs_info *c, struct inode *inode)
-{
-	int err = 0;
-	struct ubifs_inode *ui = ubifs_inode(inode);
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-	if (!S_ISREG(inode->i_mode))
-		return 0;
-
-	mutex_lock(&ui->ui_mutex);
-	spin_lock(&ui->ui_lock);
-	if (ui->ui_size != ui->synced_i_size && !ui->dirty) {
-		ubifs_err(c, "ui_size is %lld, synced_i_size is %lld, but inode is clean",
-			  ui->ui_size, ui->synced_i_size);
-		ubifs_err(c, "i_ino %lu, i_mode %#x, i_size %lld", inode->i_ino,
-			  inode->i_mode, i_size_read(inode));
-		dump_stack();
-		err = -EINVAL;
-	}
-	spin_unlock(&ui->ui_lock);
-	mutex_unlock(&ui->ui_mutex);
-	return err;
-}
-
-/*
- * dbg_check_dir - check directory inode size and link count.
- * @c: UBIFS file-system description object
- * @dir: the directory to calculate size for
- * @size: the result is returned here
- *
- * This function makes sure that directory size and link count are correct.
- * Returns zero in case of success and a negative error code in case of
- * failure.
- *
- * Note, it is good idea to make sure the @dir->i_mutex is locked before
- * calling this function.
- */
-int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
-{
-	unsigned int nlink = 2;
-	union ubifs_key key;
-	struct ubifs_dent_node *dent, *pdent = NULL;
-	struct fscrypt_name nm = {0};
-	loff_t size = UBIFS_INO_NODE_SZ;
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-
-	if (!S_ISDIR(dir->i_mode))
-		return 0;
-
-	lowest_dent_key(c, &key, dir->i_ino);
-	while (1) {
-		int err;
-
-		dent = ubifs_tnc_next_ent(c, &key, &nm);
-		if (IS_ERR(dent)) {
-			err = PTR_ERR(dent);
-			if (err == -ENOENT)
-				break;
-			kfree(pdent);
-			return err;
-		}
-
-		fname_name(&nm) = dent->name;
-		fname_len(&nm) = le16_to_cpu(dent->nlen);
-		size += CALC_DENT_SIZE(fname_len(&nm));
-		if (dent->type == UBIFS_ITYPE_DIR)
-			nlink += 1;
-		kfree(pdent);
-		pdent = dent;
-		key_read(c, &dent->key, &key);
-	}
-	kfree(pdent);
-
-	if (i_size_read(dir) != size) {
-		ubifs_err(c, "directory inode %lu has size %llu, but calculated size is %llu",
-			  dir->i_ino, (unsigned long long)i_size_read(dir),
-			  (unsigned long long)size);
-		ubifs_dump_inode(c, dir);
-		dump_stack();
-		return -EINVAL;
-	}
-	if (dir->i_nlink != nlink) {
-		ubifs_err(c, "directory inode %lu has nlink %u, but calculated nlink is %u",
-			  dir->i_ino, dir->i_nlink, nlink);
-		ubifs_dump_inode(c, dir);
-		dump_stack();
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * dbg_check_key_order - make sure that colliding keys are properly ordered.
- * @c: UBIFS file-system description object
- * @zbr1: first zbranch
- * @zbr2: following zbranch
- *
- * In UBIFS indexing B-tree colliding keys has to be sorted in binary order of
- * names of the direntries/xentries which are referred by the keys. This
- * function reads direntries/xentries referred by @zbr1 and @zbr2 and makes
- * sure the name of direntry/xentry referred by @zbr1 is less than
- * direntry/xentry referred by @zbr2. Returns zero if this is true, %1 if not,
- * and a negative error code in case of failure.
- */
-static int dbg_check_key_order(struct ubifs_info *c, struct ubifs_zbranch *zbr1,
-			       struct ubifs_zbranch *zbr2)
-{
-	int err, nlen1, nlen2, cmp;
-	struct ubifs_dent_node *dent1, *dent2;
-	union ubifs_key key;
-	char key_buf[DBG_KEY_BUF_LEN];
-
-	ubifs_assert(c, !keys_cmp(c, &zbr1->key, &zbr2->key));
-	dent1 = kmalloc(UBIFS_MAX_DENT_NODE_SZ, GFP_NOFS);
-	if (!dent1)
-		return -ENOMEM;
-	dent2 = kmalloc(UBIFS_MAX_DENT_NODE_SZ, GFP_NOFS);
-	if (!dent2) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-
-	err = ubifs_tnc_read_node(c, zbr1, dent1);
-	if (err)
-		goto out_free;
-	err = ubifs_validate_entry(c, dent1);
-	if (err)
-		goto out_free;
-
-	err = ubifs_tnc_read_node(c, zbr2, dent2);
-	if (err)
-		goto out_free;
-	err = ubifs_validate_entry(c, dent2);
-	if (err)
-		goto out_free;
-
-	/* Make sure node keys are the same as in zbranch */
-	err = 1;
-	key_read(c, &dent1->key, &key);
-	if (keys_cmp(c, &zbr1->key, &key)) {
-		ubifs_err(c, "1st entry at %d:%d has key %s", zbr1->lnum,
-			  zbr1->offs, dbg_snprintf_key(c, &key, key_buf,
-						       DBG_KEY_BUF_LEN));
-		ubifs_err(c, "but it should have key %s according to tnc",
-			  dbg_snprintf_key(c, &zbr1->key, key_buf,
-					   DBG_KEY_BUF_LEN));
-		ubifs_dump_node(c, dent1, UBIFS_MAX_DENT_NODE_SZ);
-		goto out_free;
-	}
-
-	key_read(c, &dent2->key, &key);
-	if (keys_cmp(c, &zbr2->key, &key)) {
-		ubifs_err(c, "2nd entry at %d:%d has key %s", zbr1->lnum,
-			  zbr1->offs, dbg_snprintf_key(c, &key, key_buf,
-						       DBG_KEY_BUF_LEN));
-		ubifs_err(c, "but it should have key %s according to tnc",
-			  dbg_snprintf_key(c, &zbr2->key, key_buf,
-					   DBG_KEY_BUF_LEN));
-		ubifs_dump_node(c, dent2, UBIFS_MAX_DENT_NODE_SZ);
-		goto out_free;
-	}
-
-	nlen1 = le16_to_cpu(dent1->nlen);
-	nlen2 = le16_to_cpu(dent2->nlen);
-
-	cmp = memcmp(dent1->name, dent2->name, min_t(int, nlen1, nlen2));
-	if (cmp < 0 || (cmp == 0 && nlen1 < nlen2)) {
-		err = 0;
-		goto out_free;
-	}
-	if (cmp == 0 && nlen1 == nlen2)
-		ubifs_err(c, "2 xent/dent nodes with the same name");
-	else
-		ubifs_err(c, "bad order of colliding key %s",
-			  dbg_snprintf_key(c, &key, key_buf, DBG_KEY_BUF_LEN));
-
-	ubifs_msg(c, "first node at %d:%d\n", zbr1->lnum, zbr1->offs);
-	ubifs_dump_node(c, dent1, UBIFS_MAX_DENT_NODE_SZ);
-	ubifs_msg(c, "second node at %d:%d\n", zbr2->lnum, zbr2->offs);
-	ubifs_dump_node(c, dent2, UBIFS_MAX_DENT_NODE_SZ);
-
-out_free:
-	kfree(dent2);
-	kfree(dent1);
-	return err;
-}
-
-/**
- * dbg_check_znode - check if znode is all right.
- * @c: UBIFS file-system description object
- * @zbr: zbranch which points to this znode
- *
- * This function makes sure that znode referred to by @zbr is all right.
- * Returns zero if it is, and %-EINVAL if it is not.
- */
-static int dbg_check_znode(struct ubifs_info *c, struct ubifs_zbranch *zbr)
-{
-	struct ubifs_znode *znode = zbr->znode;
-	struct ubifs_znode *zp = znode->parent;
-	int n, err, cmp;
-
-	if (znode->child_cnt <= 0 || znode->child_cnt > c->fanout) {
-		err = 1;
-		goto out;
-	}
-	if (znode->level < 0) {
-		err = 2;
-		goto out;
-	}
-	if (znode->iip < 0 || znode->iip >= c->fanout) {
-		err = 3;
-		goto out;
-	}
-
-	if (zbr->len == 0)
-		/* Only dirty zbranch may have no on-flash nodes */
-		if (!ubifs_zn_dirty(znode)) {
-			err = 4;
-			goto out;
-		}
-
-	if (ubifs_zn_dirty(znode)) {
-		/*
-		 * If znode is dirty, its parent has to be dirty as well. The
-		 * order of the operation is important, so we have to have
-		 * memory barriers.
-		 */
-		smp_mb();
-		if (zp && !ubifs_zn_dirty(zp)) {
-			/*
-			 * The dirty flag is atomic and is cleared outside the
-			 * TNC mutex, so znode's dirty flag may now have
-			 * been cleared. The child is always cleared before the
-			 * parent, so we just need to check again.
-			 */
-			smp_mb();
-			if (ubifs_zn_dirty(znode)) {
-				err = 5;
-				goto out;
-			}
-		}
-	}
-
-	if (zp) {
-		const union ubifs_key *min, *max;
-
-		if (znode->level != zp->level - 1) {
-			err = 6;
-			goto out;
-		}
-
-		/* Make sure the 'parent' pointer in our znode is correct */
-		err = ubifs_search_zbranch(c, zp, &zbr->key, &n);
-		if (!err) {
-			/* This zbranch does not exist in the parent */
-			err = 7;
-			goto out;
-		}
-
-		if (znode->iip >= zp->child_cnt) {
-			err = 8;
-			goto out;
-		}
-
-		if (znode->iip != n) {
-			/* This may happen only in case of collisions */
-			if (keys_cmp(c, &zp->zbranch[n].key,
-				     &zp->zbranch[znode->iip].key)) {
-				err = 9;
-				goto out;
-			}
-			n = znode->iip;
-		}
-
-		/*
-		 * Make sure that the first key in our znode is greater than or
-		 * equal to the key in the pointing zbranch.
-		 */
-		min = &zbr->key;
-		cmp = keys_cmp(c, min, &znode->zbranch[0].key);
-		if (cmp == 1) {
-			err = 10;
-			goto out;
-		}
-
-		if (n + 1 < zp->child_cnt) {
-			max = &zp->zbranch[n + 1].key;
-
-			/*
-			 * Make sure the last key in our znode is less or
-			 * equivalent than the key in the zbranch which goes
-			 * after our pointing zbranch.
-			 */
-			cmp = keys_cmp(c, max,
-				&znode->zbranch[znode->child_cnt - 1].key);
-			if (cmp == -1) {
-				err = 11;
-				goto out;
-			}
-		}
-	} else {
-		/* This may only be root znode */
-		if (zbr != &c->zroot) {
-			err = 12;
-			goto out;
-		}
-	}
-
-	/*
-	 * Make sure that next key is greater or equivalent then the previous
-	 * one.
-	 */
-	for (n = 1; n < znode->child_cnt; n++) {
-		cmp = keys_cmp(c, &znode->zbranch[n - 1].key,
-			       &znode->zbranch[n].key);
-		if (cmp > 0) {
-			err = 13;
-			goto out;
-		}
-		if (cmp == 0) {
-			/* This can only be keys with colliding hash */
-			if (!is_hash_key(c, &znode->zbranch[n].key)) {
-				err = 14;
-				goto out;
-			}
-
-			if (znode->level != 0 || c->replaying)
-				continue;
-
-			/*
-			 * Colliding keys should follow binary order of
-			 * corresponding xentry/dentry names.
-			 */
-			err = dbg_check_key_order(c, &znode->zbranch[n - 1],
-						  &znode->zbranch[n]);
-			if (err < 0)
-				return err;
-			if (err) {
-				err = 15;
-				goto out;
-			}
-		}
-	}
-
-	for (n = 0; n < znode->child_cnt; n++) {
-		if (!znode->zbranch[n].znode &&
-		    (znode->zbranch[n].lnum == 0 ||
-		     znode->zbranch[n].len == 0)) {
-			err = 16;
-			goto out;
-		}
-
-		if (znode->zbranch[n].lnum != 0 &&
-		    znode->zbranch[n].len == 0) {
-			err = 17;
-			goto out;
-		}
-
-		if (znode->zbranch[n].lnum == 0 &&
-		    znode->zbranch[n].len != 0) {
-			err = 18;
-			goto out;
-		}
-
-		if (znode->zbranch[n].lnum == 0 &&
-		    znode->zbranch[n].offs != 0) {
-			err = 19;
-			goto out;
-		}
-
-		if (znode->level != 0 && znode->zbranch[n].znode)
-			if (znode->zbranch[n].znode->parent != znode) {
-				err = 20;
-				goto out;
-			}
-	}
-
-	return 0;
-
-out:
-	ubifs_err(c, "failed, error %d", err);
-	ubifs_msg(c, "dump of the znode");
-	ubifs_dump_znode(c, znode);
-	if (zp) {
-		ubifs_msg(c, "dump of the parent znode");
-		ubifs_dump_znode(c, zp);
-	}
-	dump_stack();
-	return -EINVAL;
-}
-
-/**
- * dbg_check_tnc - check TNC tree.
- * @c: UBIFS file-system description object
- * @extra: do extra checks that are possible at start commit
- *
- * This function traverses whole TNC tree and checks every znode. Returns zero
- * if everything is all right and %-EINVAL if something is wrong with TNC.
- */
-int dbg_check_tnc(struct ubifs_info *c, int extra)
-{
-	struct ubifs_znode *znode;
-	long clean_cnt = 0, dirty_cnt = 0;
-	int err, last;
-
-	if (!dbg_is_chk_index(c))
-		return 0;
-
-	ubifs_assert(c, mutex_is_locked(&c->tnc_mutex));
-	if (!c->zroot.znode)
-		return 0;
-
-	znode = ubifs_tnc_postorder_first(c->zroot.znode);
-	while (1) {
-		struct ubifs_znode *prev;
-		struct ubifs_zbranch *zbr;
-
-		if (!znode->parent)
-			zbr = &c->zroot;
-		else
-			zbr = &znode->parent->zbranch[znode->iip];
-
-		err = dbg_check_znode(c, zbr);
-		if (err)
-			return err;
-
-		if (extra) {
-			if (ubifs_zn_dirty(znode))
-				dirty_cnt += 1;
-			else
-				clean_cnt += 1;
-		}
-
-		prev = znode;
-		znode = ubifs_tnc_postorder_next(c, znode);
-		if (!znode)
-			break;
-
-		/*
-		 * If the last key of this znode is equivalent to the first key
-		 * of the next znode (collision), then check order of the keys.
-		 */
-		last = prev->child_cnt - 1;
-		if (prev->level == 0 && znode->level == 0 && !c->replaying &&
-		    !keys_cmp(c, &prev->zbranch[last].key,
-			      &znode->zbranch[0].key)) {
-			err = dbg_check_key_order(c, &prev->zbranch[last],
-						  &znode->zbranch[0]);
-			if (err < 0)
-				return err;
-			if (err) {
-				ubifs_msg(c, "first znode");
-				ubifs_dump_znode(c, prev);
-				ubifs_msg(c, "second znode");
-				ubifs_dump_znode(c, znode);
-				return -EINVAL;
-			}
-		}
-	}
-
-	if (extra) {
-		if (clean_cnt != atomic_long_read(&c->clean_zn_cnt)) {
-			ubifs_err(c, "incorrect clean_zn_cnt %ld, calculated %ld",
-				  atomic_long_read(&c->clean_zn_cnt),
-				  clean_cnt);
-			return -EINVAL;
-		}
-		if (dirty_cnt != atomic_long_read(&c->dirty_zn_cnt)) {
-			ubifs_err(c, "incorrect dirty_zn_cnt %ld, calculated %ld",
-				  atomic_long_read(&c->dirty_zn_cnt),
-				  dirty_cnt);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * dbg_walk_index - walk the on-flash index.
  * @c: UBIFS file-system description object
@@ -1711,7 +1003,7 @@ out_unlock:
  * every indexing node and adds its size to the 'long long' variable pointed to
  * by @priv.
  */
-static int add_size(struct ubifs_info *c, struct ubifs_znode *znode, void *priv)
+int add_size(struct ubifs_info *c, struct ubifs_znode *znode, void *priv)
 {
 	long long *idx_size = priv;
 	int add;
@@ -1722,1330 +1014,14 @@ static int add_size(struct ubifs_info *c, struct ubifs_znode *znode, void *priv)
 	return 0;
 }
 
-/**
- * dbg_check_idx_size - check index size.
- * @c: UBIFS file-system description object
- * @idx_size: size to check
- *
- * This function walks the UBIFS index, calculates its size and checks that the
- * size is equivalent to @idx_size. Returns zero in case of success and a
- * negative error code in case of failure.
- */
-int dbg_check_idx_size(struct ubifs_info *c, long long idx_size)
+void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
+			 const char *file, int line)
 {
-	int err;
-	long long calc = 0;
-
-	if (!dbg_is_chk_index(c))
-		return 0;
-
-	err = dbg_walk_index(c, NULL, add_size, &calc);
-	if (err) {
-		ubifs_err(c, "error %d while walking the index", err);
-		goto out_err;
-	}
-
-	if (calc != idx_size) {
-		ubifs_err(c, "index size check failed: calculated size is %lld, should be %lld",
-			  calc, idx_size);
-		dump_stack();
-		err = -EINVAL;
-		goto out_err;
-	}
-
-	return 0;
-
-out_err:
-	ubifs_destroy_tnc_tree(c);
-	return err;
-}
+	ubifs_err(c, "UBIFS assert failed: %s, in %s:%u", expr, file, line);
 
-/**
- * struct fsck_inode - information about an inode used when checking the file-system.
- * @rb: link in the RB-tree of inodes
- * @inum: inode number
- * @mode: inode type, permissions, etc
- * @nlink: inode link count
- * @xattr_cnt: count of extended attributes
- * @references: how many directory/xattr entries refer this inode (calculated
- *              while walking the index)
- * @calc_cnt: for directory inode count of child directories
- * @size: inode size (read from on-flash inode)
- * @xattr_sz: summary size of all extended attributes (read from on-flash
- *            inode)
- * @calc_sz: for directories calculated directory size
- * @calc_xcnt: count of extended attributes
- * @calc_xsz: calculated summary size of all extended attributes
- * @xattr_nms: sum of lengths of all extended attribute names belonging to this
- *             inode (read from on-flash inode)
- * @calc_xnms: calculated sum of lengths of all extended attribute names
- */
-struct fsck_inode {
-	struct rb_node rb;
-	ino_t inum;
-	umode_t mode;
-	unsigned int nlink;
-	unsigned int xattr_cnt;
-	int references;
-	int calc_cnt;
-	long long size;
-	unsigned int xattr_sz;
-	long long calc_sz;
-	long long calc_xcnt;
-	long long calc_xsz;
-	unsigned int xattr_nms;
-	long long calc_xnms;
-};
-
-/**
- * struct fsck_data - private FS checking information.
- * @inodes: RB-tree of all inodes (contains @struct fsck_inode objects)
- */
-struct fsck_data {
-	struct rb_root inodes;
-};
-
-/**
- * add_inode - add inode information to RB-tree of inodes.
- * @c: UBIFS file-system description object
- * @fsckd: FS checking information
- * @ino: raw UBIFS inode to add
- *
- * This is a helper function for 'check_leaf()' which adds information about
- * inode @ino to the RB-tree of inodes. Returns inode information pointer in
- * case of success and a negative error code in case of failure.
- */
-static struct fsck_inode *add_inode(struct ubifs_info *c,
-				    struct fsck_data *fsckd,
-				    struct ubifs_ino_node *ino)
-{
-	struct rb_node **p, *parent = NULL;
-	struct fsck_inode *fscki;
-	ino_t inum = key_inum_flash(c, &ino->key);
-	struct inode *inode;
-	struct ubifs_inode *ui;
-
-	p = &fsckd->inodes.rb_node;
-	while (*p) {
-		parent = *p;
-		fscki = rb_entry(parent, struct fsck_inode, rb);
-		if (inum < fscki->inum)
-			p = &(*p)->rb_left;
-		else if (inum > fscki->inum)
-			p = &(*p)->rb_right;
-		else
-			return fscki;
-	}
-
-	if (inum > c->highest_inum) {
-		ubifs_err(c, "too high inode number, max. is %lu",
-			  (unsigned long)c->highest_inum);
-		return ERR_PTR(-EINVAL);
-	}
-
-	fscki = kzalloc(sizeof(struct fsck_inode), GFP_NOFS);
-	if (!fscki)
-		return ERR_PTR(-ENOMEM);
-
-	inode = ilookup(c->vfs_sb, inum);
-
-	fscki->inum = inum;
 	/*
-	 * If the inode is present in the VFS inode cache, use it instead of
-	 * the on-flash inode which might be out-of-date. E.g., the size might
-	 * be out-of-date. If we do not do this, the following may happen, for
-	 * example:
-	 *   1. A power cut happens
-	 *   2. We mount the file-system R/O, the replay process fixes up the
-	 *      inode size in the VFS cache, but on on-flash.
-	 *   3. 'check_leaf()' fails because it hits a data node beyond inode
-	 *      size.
+	 * Different from linux kernel.
+	 * There is only one action(readonly) when assertion is failed.
 	 */
-	if (!inode) {
-		fscki->nlink = le32_to_cpu(ino->nlink);
-		fscki->size = le64_to_cpu(ino->size);
-		fscki->xattr_cnt = le32_to_cpu(ino->xattr_cnt);
-		fscki->xattr_sz = le32_to_cpu(ino->xattr_size);
-		fscki->xattr_nms = le32_to_cpu(ino->xattr_names);
-		fscki->mode = le32_to_cpu(ino->mode);
-	} else {
-		ui = ubifs_inode(inode);
-		fscki->nlink = inode->i_nlink;
-		fscki->size = inode->i_size;
-		fscki->xattr_cnt = ui->xattr_cnt;
-		fscki->xattr_sz = ui->xattr_size;
-		fscki->xattr_nms = ui->xattr_names;
-		fscki->mode = inode->i_mode;
-		iput(inode);
-	}
-
-	if (S_ISDIR(fscki->mode)) {
-		fscki->calc_sz = UBIFS_INO_NODE_SZ;
-		fscki->calc_cnt = 2;
-	}
-
-	rb_link_node(&fscki->rb, parent, p);
-	rb_insert_color(&fscki->rb, &fsckd->inodes);
-
-	return fscki;
-}
-
-/**
- * search_inode - search inode in the RB-tree of inodes.
- * @fsckd: FS checking information
- * @inum: inode number to search
- *
- * This is a helper function for 'check_leaf()' which searches inode @inum in
- * the RB-tree of inodes and returns an inode information pointer or %NULL if
- * the inode was not found.
- */
-static struct fsck_inode *search_inode(struct fsck_data *fsckd, ino_t inum)
-{
-	struct rb_node *p;
-	struct fsck_inode *fscki;
-
-	p = fsckd->inodes.rb_node;
-	while (p) {
-		fscki = rb_entry(p, struct fsck_inode, rb);
-		if (inum < fscki->inum)
-			p = p->rb_left;
-		else if (inum > fscki->inum)
-			p = p->rb_right;
-		else
-			return fscki;
-	}
-	return NULL;
-}
-
-/**
- * read_add_inode - read inode node and add it to RB-tree of inodes.
- * @c: UBIFS file-system description object
- * @fsckd: FS checking information
- * @inum: inode number to read
- *
- * This is a helper function for 'check_leaf()' which finds inode node @inum in
- * the index, reads it, and adds it to the RB-tree of inodes. Returns inode
- * information pointer in case of success and a negative error code in case of
- * failure.
- */
-static struct fsck_inode *read_add_inode(struct ubifs_info *c,
-					 struct fsck_data *fsckd, ino_t inum)
-{
-	int n, err;
-	union ubifs_key key;
-	struct ubifs_znode *znode;
-	struct ubifs_zbranch *zbr;
-	struct ubifs_ino_node *ino;
-	struct fsck_inode *fscki;
-
-	fscki = search_inode(fsckd, inum);
-	if (fscki)
-		return fscki;
-
-	ino_key_init(c, &key, inum);
-	err = ubifs_lookup_level0(c, &key, &znode, &n);
-	if (!err) {
-		ubifs_err(c, "inode %lu not found in index", (unsigned long)inum);
-		return ERR_PTR(-ENOENT);
-	} else if (err < 0) {
-		ubifs_err(c, "error %d while looking up inode %lu",
-			  err, (unsigned long)inum);
-		return ERR_PTR(err);
-	}
-
-	zbr = &znode->zbranch[n];
-	if (zbr->len < UBIFS_INO_NODE_SZ) {
-		ubifs_err(c, "bad node %lu node length %d",
-			  (unsigned long)inum, zbr->len);
-		return ERR_PTR(-EINVAL);
-	}
-
-	ino = kmalloc(zbr->len, GFP_NOFS);
-	if (!ino)
-		return ERR_PTR(-ENOMEM);
-
-	err = ubifs_tnc_read_node(c, zbr, ino);
-	if (err) {
-		ubifs_err(c, "cannot read inode node at LEB %d:%d, error %d",
-			  zbr->lnum, zbr->offs, err);
-		kfree(ino);
-		return ERR_PTR(err);
-	}
-
-	fscki = add_inode(c, fsckd, ino);
-	kfree(ino);
-	if (IS_ERR(fscki)) {
-		ubifs_err(c, "error %ld while adding inode %lu node",
-			  PTR_ERR(fscki), (unsigned long)inum);
-		return fscki;
-	}
-
-	return fscki;
-}
-
-/**
- * check_leaf - check leaf node.
- * @c: UBIFS file-system description object
- * @zbr: zbranch of the leaf node to check
- * @priv: FS checking information
- *
- * This is a helper function for 'dbg_check_filesystem()' which is called for
- * every single leaf node while walking the indexing tree. It checks that the
- * leaf node referred from the indexing tree exists, has correct CRC, and does
- * some other basic validation. This function is also responsible for building
- * an RB-tree of inodes - it adds all inodes into the RB-tree. It also
- * calculates reference count, size, etc for each inode in order to later
- * compare them to the information stored inside the inodes and detect possible
- * inconsistencies. Returns zero in case of success and a negative error code
- * in case of failure.
- */
-static int check_leaf(struct ubifs_info *c, struct ubifs_zbranch *zbr,
-		      void *priv)
-{
-	ino_t inum;
-	void *node;
-	struct ubifs_ch *ch;
-	int err, type = key_type(c, &zbr->key);
-	struct fsck_inode *fscki;
-
-	if (zbr->len < UBIFS_CH_SZ) {
-		ubifs_err(c, "bad leaf length %d (LEB %d:%d)",
-			  zbr->len, zbr->lnum, zbr->offs);
-		return -EINVAL;
-	}
-
-	node = kmalloc(zbr->len, GFP_NOFS);
-	if (!node)
-		return -ENOMEM;
-
-	err = ubifs_tnc_read_node(c, zbr, node);
-	if (err) {
-		ubifs_err(c, "cannot read leaf node at LEB %d:%d, error %d",
-			  zbr->lnum, zbr->offs, err);
-		goto out_free;
-	}
-
-	/* If this is an inode node, add it to RB-tree of inodes */
-	if (type == UBIFS_INO_KEY) {
-		fscki = add_inode(c, priv, node);
-		if (IS_ERR(fscki)) {
-			err = PTR_ERR(fscki);
-			ubifs_err(c, "error %d while adding inode node", err);
-			goto out_dump;
-		}
-		goto out;
-	}
-
-	if (type != UBIFS_DENT_KEY && type != UBIFS_XENT_KEY &&
-	    type != UBIFS_DATA_KEY) {
-		ubifs_err(c, "unexpected node type %d at LEB %d:%d",
-			  type, zbr->lnum, zbr->offs);
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	ch = node;
-	if (le64_to_cpu(ch->sqnum) > c->max_sqnum) {
-		ubifs_err(c, "too high sequence number, max. is %llu",
-			  c->max_sqnum);
-		err = -EINVAL;
-		goto out_dump;
-	}
-
-	if (type == UBIFS_DATA_KEY) {
-		long long blk_offs;
-		struct ubifs_data_node *dn = node;
-
-		ubifs_assert(c, zbr->len >= UBIFS_DATA_NODE_SZ);
-
-		/*
-		 * Search the inode node this data node belongs to and insert
-		 * it to the RB-tree of inodes.
-		 */
-		inum = key_inum_flash(c, &dn->key);
-		fscki = read_add_inode(c, priv, inum);
-		if (IS_ERR(fscki)) {
-			err = PTR_ERR(fscki);
-			ubifs_err(c, "error %d while processing data node and trying to find inode node %lu",
-				  err, (unsigned long)inum);
-			goto out_dump;
-		}
-
-		/* Make sure the data node is within inode size */
-		blk_offs = key_block_flash(c, &dn->key);
-		blk_offs <<= UBIFS_BLOCK_SHIFT;
-		blk_offs += le32_to_cpu(dn->size);
-		if (blk_offs > fscki->size) {
-			ubifs_err(c, "data node at LEB %d:%d is not within inode size %lld",
-				  zbr->lnum, zbr->offs, fscki->size);
-			err = -EINVAL;
-			goto out_dump;
-		}
-	} else {
-		int nlen;
-		struct ubifs_dent_node *dent = node;
-		struct fsck_inode *fscki1;
-
-		ubifs_assert(c, zbr->len >= UBIFS_DENT_NODE_SZ);
-
-		err = ubifs_validate_entry(c, dent);
-		if (err)
-			goto out_dump;
-
-		/*
-		 * Search the inode node this entry refers to and the parent
-		 * inode node and insert them to the RB-tree of inodes.
-		 */
-		inum = le64_to_cpu(dent->inum);
-		fscki = read_add_inode(c, priv, inum);
-		if (IS_ERR(fscki)) {
-			err = PTR_ERR(fscki);
-			ubifs_err(c, "error %d while processing entry node and trying to find inode node %lu",
-				  err, (unsigned long)inum);
-			goto out_dump;
-		}
-
-		/* Count how many direntries or xentries refers this inode */
-		fscki->references += 1;
-
-		inum = key_inum_flash(c, &dent->key);
-		fscki1 = read_add_inode(c, priv, inum);
-		if (IS_ERR(fscki1)) {
-			err = PTR_ERR(fscki1);
-			ubifs_err(c, "error %d while processing entry node and trying to find parent inode node %lu",
-				  err, (unsigned long)inum);
-			goto out_dump;
-		}
-
-		nlen = le16_to_cpu(dent->nlen);
-		if (type == UBIFS_XENT_KEY) {
-			fscki1->calc_xcnt += 1;
-			fscki1->calc_xsz += CALC_DENT_SIZE(nlen);
-			fscki1->calc_xsz += CALC_XATTR_BYTES(fscki->size);
-			fscki1->calc_xnms += nlen;
-		} else {
-			fscki1->calc_sz += CALC_DENT_SIZE(nlen);
-			if (dent->type == UBIFS_ITYPE_DIR)
-				fscki1->calc_cnt += 1;
-		}
-	}
-
-out:
-	kfree(node);
-	return 0;
-
-out_dump:
-	ubifs_msg(c, "dump of node at LEB %d:%d", zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, node, zbr->len);
-out_free:
-	kfree(node);
-	return err;
-}
-
-/**
- * free_inodes - free RB-tree of inodes.
- * @fsckd: FS checking information
- */
-static void free_inodes(struct fsck_data *fsckd)
-{
-	struct fsck_inode *fscki, *n;
-
-	rbtree_postorder_for_each_entry_safe(fscki, n, &fsckd->inodes, rb)
-		kfree(fscki);
-}
-
-/**
- * check_inodes - checks all inodes.
- * @c: UBIFS file-system description object
- * @fsckd: FS checking information
- *
- * This is a helper function for 'dbg_check_filesystem()' which walks the
- * RB-tree of inodes after the index scan has been finished, and checks that
- * inode nlink, size, etc are correct. Returns zero if inodes are fine,
- * %-EINVAL if not, and a negative error code in case of failure.
- */
-static int check_inodes(struct ubifs_info *c, struct fsck_data *fsckd)
-{
-	int n, err;
-	union ubifs_key key;
-	struct ubifs_znode *znode;
-	struct ubifs_zbranch *zbr;
-	struct ubifs_ino_node *ino;
-	struct fsck_inode *fscki;
-	struct rb_node *this = rb_first(&fsckd->inodes);
-
-	while (this) {
-		fscki = rb_entry(this, struct fsck_inode, rb);
-		this = rb_next(this);
-
-		if (S_ISDIR(fscki->mode)) {
-			/*
-			 * Directories have to have exactly one reference (they
-			 * cannot have hardlinks), although root inode is an
-			 * exception.
-			 */
-			if (fscki->inum != UBIFS_ROOT_INO &&
-			    fscki->references != 1) {
-				ubifs_err(c, "directory inode %lu has %d direntries which refer it, but should be 1",
-					  (unsigned long)fscki->inum,
-					  fscki->references);
-				goto out_dump;
-			}
-			if (fscki->inum == UBIFS_ROOT_INO &&
-			    fscki->references != 0) {
-				ubifs_err(c, "root inode %lu has non-zero (%d) direntries which refer it",
-					  (unsigned long)fscki->inum,
-					  fscki->references);
-				goto out_dump;
-			}
-			if (fscki->calc_sz != fscki->size) {
-				ubifs_err(c, "directory inode %lu size is %lld, but calculated size is %lld",
-					  (unsigned long)fscki->inum,
-					  fscki->size, fscki->calc_sz);
-				goto out_dump;
-			}
-			if (fscki->calc_cnt != fscki->nlink) {
-				ubifs_err(c, "directory inode %lu nlink is %d, but calculated nlink is %d",
-					  (unsigned long)fscki->inum,
-					  fscki->nlink, fscki->calc_cnt);
-				goto out_dump;
-			}
-		} else {
-			if (fscki->references != fscki->nlink) {
-				ubifs_err(c, "inode %lu nlink is %d, but calculated nlink is %d",
-					  (unsigned long)fscki->inum,
-					  fscki->nlink, fscki->references);
-				goto out_dump;
-			}
-		}
-		if (fscki->xattr_sz != fscki->calc_xsz) {
-			ubifs_err(c, "inode %lu has xattr size %u, but calculated size is %lld",
-				  (unsigned long)fscki->inum, fscki->xattr_sz,
-				  fscki->calc_xsz);
-			goto out_dump;
-		}
-		if (fscki->xattr_cnt != fscki->calc_xcnt) {
-			ubifs_err(c, "inode %lu has %u xattrs, but calculated count is %lld",
-				  (unsigned long)fscki->inum,
-				  fscki->xattr_cnt, fscki->calc_xcnt);
-			goto out_dump;
-		}
-		if (fscki->xattr_nms != fscki->calc_xnms) {
-			ubifs_err(c, "inode %lu has xattr names' size %u, but calculated names' size is %lld",
-				  (unsigned long)fscki->inum, fscki->xattr_nms,
-				  fscki->calc_xnms);
-			goto out_dump;
-		}
-	}
-
-	return 0;
-
-out_dump:
-	/* Read the bad inode and dump it */
-	ino_key_init(c, &key, fscki->inum);
-	err = ubifs_lookup_level0(c, &key, &znode, &n);
-	if (!err) {
-		ubifs_err(c, "inode %lu not found in index",
-			  (unsigned long)fscki->inum);
-		return -ENOENT;
-	} else if (err < 0) {
-		ubifs_err(c, "error %d while looking up inode %lu",
-			  err, (unsigned long)fscki->inum);
-		return err;
-	}
-
-	zbr = &znode->zbranch[n];
-	ino = kmalloc(zbr->len, GFP_NOFS);
-	if (!ino)
-		return -ENOMEM;
-
-	err = ubifs_tnc_read_node(c, zbr, ino);
-	if (err) {
-		ubifs_err(c, "cannot read inode node at LEB %d:%d, error %d",
-			  zbr->lnum, zbr->offs, err);
-		kfree(ino);
-		return err;
-	}
-
-	ubifs_msg(c, "dump of the inode %lu sitting in LEB %d:%d",
-		  (unsigned long)fscki->inum, zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, ino, zbr->len);
-	kfree(ino);
-	return -EINVAL;
-}
-
-/**
- * dbg_check_filesystem - check the file-system.
- * @c: UBIFS file-system description object
- *
- * This function checks the file system, namely:
- * o makes sure that all leaf nodes exist and their CRCs are correct;
- * o makes sure inode nlink, size, xattr size/count are correct (for all
- *   inodes).
- *
- * The function reads whole indexing tree and all nodes, so it is pretty
- * heavy-weight. Returns zero if the file-system is consistent, %-EINVAL if
- * not, and a negative error code in case of failure.
- */
-int dbg_check_filesystem(struct ubifs_info *c)
-{
-	int err;
-	struct fsck_data fsckd;
-
-	if (!dbg_is_chk_fs(c))
-		return 0;
-
-	fsckd.inodes = RB_ROOT;
-	err = dbg_walk_index(c, check_leaf, NULL, &fsckd);
-	if (err)
-		goto out_free;
-
-	err = check_inodes(c, &fsckd);
-	if (err)
-		goto out_free;
-
-	free_inodes(&fsckd);
-	return 0;
-
-out_free:
-	ubifs_err(c, "file-system check failed with error %d", err);
-	dump_stack();
-	free_inodes(&fsckd);
-	return err;
-}
-
-/**
- * dbg_check_data_nodes_order - check that list of data nodes is sorted.
- * @c: UBIFS file-system description object
- * @head: the list of nodes ('struct ubifs_scan_node' objects)
- *
- * This function returns zero if the list of data nodes is sorted correctly,
- * and %-EINVAL if not.
- */
-int dbg_check_data_nodes_order(struct ubifs_info *c, struct list_head *head)
-{
-	struct list_head *cur;
-	struct ubifs_scan_node *sa, *sb;
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-
-	for (cur = head->next; cur->next != head; cur = cur->next) {
-		ino_t inuma, inumb;
-		uint32_t blka, blkb;
-
-		cond_resched();
-		sa = container_of(cur, struct ubifs_scan_node, list);
-		sb = container_of(cur->next, struct ubifs_scan_node, list);
-
-		if (sa->type != UBIFS_DATA_NODE) {
-			ubifs_err(c, "bad node type %d", sa->type);
-			ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
-			return -EINVAL;
-		}
-		if (sb->type != UBIFS_DATA_NODE) {
-			ubifs_err(c, "bad node type %d", sb->type);
-			ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
-			return -EINVAL;
-		}
-
-		inuma = key_inum(c, &sa->key);
-		inumb = key_inum(c, &sb->key);
-
-		if (inuma < inumb)
-			continue;
-		if (inuma > inumb) {
-			ubifs_err(c, "larger inum %lu goes before inum %lu",
-				  (unsigned long)inuma, (unsigned long)inumb);
-			goto error_dump;
-		}
-
-		blka = key_block(c, &sa->key);
-		blkb = key_block(c, &sb->key);
-
-		if (blka > blkb) {
-			ubifs_err(c, "larger block %u goes before %u", blka, blkb);
-			goto error_dump;
-		}
-		if (blka == blkb) {
-			ubifs_err(c, "two data nodes for the same block");
-			goto error_dump;
-		}
-	}
-
-	return 0;
-
-error_dump:
-	ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
-	ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
-	return -EINVAL;
-}
-
-/**
- * dbg_check_nondata_nodes_order - check that list of data nodes is sorted.
- * @c: UBIFS file-system description object
- * @head: the list of nodes ('struct ubifs_scan_node' objects)
- *
- * This function returns zero if the list of non-data nodes is sorted correctly,
- * and %-EINVAL if not.
- */
-int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
-{
-	struct list_head *cur;
-	struct ubifs_scan_node *sa, *sb;
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-
-	for (cur = head->next; cur->next != head; cur = cur->next) {
-		ino_t inuma, inumb;
-		uint32_t hasha, hashb;
-
-		cond_resched();
-		sa = container_of(cur, struct ubifs_scan_node, list);
-		sb = container_of(cur->next, struct ubifs_scan_node, list);
-
-		if (sa->type != UBIFS_INO_NODE && sa->type != UBIFS_DENT_NODE &&
-		    sa->type != UBIFS_XENT_NODE) {
-			ubifs_err(c, "bad node type %d", sa->type);
-			ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
-			return -EINVAL;
-		}
-		if (sb->type != UBIFS_INO_NODE && sb->type != UBIFS_DENT_NODE &&
-		    sb->type != UBIFS_XENT_NODE) {
-			ubifs_err(c, "bad node type %d", sb->type);
-			ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
-			return -EINVAL;
-		}
-
-		if (sa->type != UBIFS_INO_NODE && sb->type == UBIFS_INO_NODE) {
-			ubifs_err(c, "non-inode node goes before inode node");
-			goto error_dump;
-		}
-
-		if (sa->type == UBIFS_INO_NODE && sb->type != UBIFS_INO_NODE)
-			continue;
-
-		if (sa->type == UBIFS_INO_NODE && sb->type == UBIFS_INO_NODE) {
-			/* Inode nodes are sorted in descending size order */
-			if (sa->len < sb->len) {
-				ubifs_err(c, "smaller inode node goes first");
-				goto error_dump;
-			}
-			continue;
-		}
-
-		/*
-		 * This is either a dentry or xentry, which should be sorted in
-		 * ascending (parent ino, hash) order.
-		 */
-		inuma = key_inum(c, &sa->key);
-		inumb = key_inum(c, &sb->key);
-
-		if (inuma < inumb)
-			continue;
-		if (inuma > inumb) {
-			ubifs_err(c, "larger inum %lu goes before inum %lu",
-				  (unsigned long)inuma, (unsigned long)inumb);
-			goto error_dump;
-		}
-
-		hasha = key_block(c, &sa->key);
-		hashb = key_block(c, &sb->key);
-
-		if (hasha > hashb) {
-			ubifs_err(c, "larger hash %u goes before %u",
-				  hasha, hashb);
-			goto error_dump;
-		}
-	}
-
-	return 0;
-
-error_dump:
-	ubifs_msg(c, "dumping first node");
-	ubifs_dump_node(c, sa->node, c->leb_size - sa->offs);
-	ubifs_msg(c, "dumping second node");
-	ubifs_dump_node(c, sb->node, c->leb_size - sb->offs);
-	return -EINVAL;
-}
-
-static inline int chance(unsigned int n, unsigned int out_of)
-{
-	return !!(get_random_u32_below(out_of) + 1 <= n);
-
-}
-
-static int power_cut_emulated(struct ubifs_info *c, int lnum, int write)
-{
-	struct ubifs_debug_info *d = c->dbg;
-
-	ubifs_assert(c, dbg_is_tst_rcvry(c));
-
-	if (!d->pc_cnt) {
-		/* First call - decide delay to the power cut */
-		if (chance(1, 2)) {
-			unsigned long delay;
-
-			if (chance(1, 2)) {
-				d->pc_delay = 1;
-				/* Fail within 1 minute */
-				delay = get_random_u32_below(60000);
-				d->pc_timeout = jiffies;
-				d->pc_timeout += msecs_to_jiffies(delay);
-				ubifs_warn(c, "failing after %lums", delay);
-			} else {
-				d->pc_delay = 2;
-				delay = get_random_u32_below(10000);
-				/* Fail within 10000 operations */
-				d->pc_cnt_max = delay;
-				ubifs_warn(c, "failing after %lu calls", delay);
-			}
-		}
-
-		d->pc_cnt += 1;
-	}
-
-	/* Determine if failure delay has expired */
-	if (d->pc_delay == 1 && time_before(jiffies, d->pc_timeout))
-			return 0;
-	if (d->pc_delay == 2 && d->pc_cnt++ < d->pc_cnt_max)
-			return 0;
-
-	if (lnum == UBIFS_SB_LNUM) {
-		if (write && chance(1, 2))
-			return 0;
-		if (chance(19, 20))
-			return 0;
-		ubifs_warn(c, "failing in super block LEB %d", lnum);
-	} else if (lnum == UBIFS_MST_LNUM || lnum == UBIFS_MST_LNUM + 1) {
-		if (chance(19, 20))
-			return 0;
-		ubifs_warn(c, "failing in master LEB %d", lnum);
-	} else if (lnum >= UBIFS_LOG_LNUM && lnum <= c->log_last) {
-		if (write && chance(99, 100))
-			return 0;
-		if (chance(399, 400))
-			return 0;
-		ubifs_warn(c, "failing in log LEB %d", lnum);
-	} else if (lnum >= c->lpt_first && lnum <= c->lpt_last) {
-		if (write && chance(7, 8))
-			return 0;
-		if (chance(19, 20))
-			return 0;
-		ubifs_warn(c, "failing in LPT LEB %d", lnum);
-	} else if (lnum >= c->orph_first && lnum <= c->orph_last) {
-		if (write && chance(1, 2))
-			return 0;
-		if (chance(9, 10))
-			return 0;
-		ubifs_warn(c, "failing in orphan LEB %d", lnum);
-	} else if (lnum == c->ihead_lnum) {
-		if (chance(99, 100))
-			return 0;
-		ubifs_warn(c, "failing in index head LEB %d", lnum);
-	} else if (c->jheads && lnum == c->jheads[GCHD].wbuf.lnum) {
-		if (chance(9, 10))
-			return 0;
-		ubifs_warn(c, "failing in GC head LEB %d", lnum);
-	} else if (write && !RB_EMPTY_ROOT(&c->buds) &&
-		   !ubifs_search_bud(c, lnum)) {
-		if (chance(19, 20))
-			return 0;
-		ubifs_warn(c, "failing in non-bud LEB %d", lnum);
-	} else if (c->cmt_state == COMMIT_RUNNING_BACKGROUND ||
-		   c->cmt_state == COMMIT_RUNNING_REQUIRED) {
-		if (chance(999, 1000))
-			return 0;
-		ubifs_warn(c, "failing in bud LEB %d commit running", lnum);
-	} else {
-		if (chance(9999, 10000))
-			return 0;
-		ubifs_warn(c, "failing in bud LEB %d commit not running", lnum);
-	}
-
-	d->pc_happened = 1;
-	ubifs_warn(c, "========== Power cut emulated ==========");
-	dump_stack();
-	return 1;
-}
-
-static int corrupt_data(const struct ubifs_info *c, const void *buf,
-			unsigned int len)
-{
-	unsigned int from, to, ffs = chance(1, 2);
-	unsigned char *p = (void *)buf;
-
-	from = get_random_u32_below(len);
-	/* Corruption span max to end of write unit */
-	to = min(len, ALIGN(from + 1, c->max_write_size));
-
-	ubifs_warn(c, "filled bytes %u-%u with %s", from, to - 1,
-		   ffs ? "0xFFs" : "random data");
-
-	if (ffs)
-		memset(p + from, 0xFF, to - from);
-	else
-		get_random_bytes(p + from, to - from);
-
-	return to;
-}
-
-int dbg_leb_write(struct ubifs_info *c, int lnum, const void *buf,
-		  int offs, int len)
-{
-	int err, failing;
-
-	if (dbg_is_power_cut(c))
-		return -EROFS;
-
-	failing = power_cut_emulated(c, lnum, 1);
-	if (failing) {
-		len = corrupt_data(c, buf, len);
-		ubifs_warn(c, "actually write %d bytes to LEB %d:%d (the buffer was corrupted)",
-			   len, lnum, offs);
-	}
-	err = ubi_leb_write(c->ubi, lnum, buf, offs, len);
-	if (err)
-		return err;
-	if (failing)
-		return -EROFS;
-	return 0;
-}
-
-int dbg_leb_change(struct ubifs_info *c, int lnum, const void *buf,
-		   int len)
-{
-	int err;
-
-	if (dbg_is_power_cut(c))
-		return -EROFS;
-	if (power_cut_emulated(c, lnum, 1))
-		return -EROFS;
-	err = ubi_leb_change(c->ubi, lnum, buf, len);
-	if (err)
-		return err;
-	if (power_cut_emulated(c, lnum, 1))
-		return -EROFS;
-	return 0;
-}
-
-int dbg_leb_unmap(struct ubifs_info *c, int lnum)
-{
-	int err;
-
-	if (dbg_is_power_cut(c))
-		return -EROFS;
-	if (power_cut_emulated(c, lnum, 0))
-		return -EROFS;
-	err = ubi_leb_unmap(c->ubi, lnum);
-	if (err)
-		return err;
-	if (power_cut_emulated(c, lnum, 0))
-		return -EROFS;
-	return 0;
-}
-
-int dbg_leb_map(struct ubifs_info *c, int lnum)
-{
-	int err;
-
-	if (dbg_is_power_cut(c))
-		return -EROFS;
-	if (power_cut_emulated(c, lnum, 0))
-		return -EROFS;
-	err = ubi_leb_map(c->ubi, lnum);
-	if (err)
-		return err;
-	if (power_cut_emulated(c, lnum, 0))
-		return -EROFS;
-	return 0;
-}
-
-/*
- * Root directory for UBIFS stuff in debugfs. Contains sub-directories which
- * contain the stuff specific to particular file-system mounts.
- */
-static struct dentry *dfs_rootdir;
-
-static int dfs_file_open(struct inode *inode, struct file *file)
-{
-	file->private_data = inode->i_private;
-	return nonseekable_open(inode, file);
-}
-
-/**
- * provide_user_output - provide output to the user reading a debugfs file.
- * @val: boolean value for the answer
- * @u: the buffer to store the answer at
- * @count: size of the buffer
- * @ppos: position in the @u output buffer
- *
- * This is a simple helper function which stores @val boolean value in the user
- * buffer when the user reads one of UBIFS debugfs files. Returns amount of
- * bytes written to @u in case of success and a negative error code in case of
- * failure.
- */
-static int provide_user_output(int val, char __user *u, size_t count,
-			       loff_t *ppos)
-{
-	char buf[3];
-
-	if (val)
-		buf[0] = '1';
-	else
-		buf[0] = '0';
-	buf[1] = '\n';
-	buf[2] = 0x00;
-
-	return simple_read_from_buffer(u, count, ppos, buf, 2);
-}
-
-static ssize_t dfs_file_read(struct file *file, char __user *u, size_t count,
-			     loff_t *ppos)
-{
-	struct dentry *dent = file->f_path.dentry;
-	struct ubifs_info *c = file->private_data;
-	struct ubifs_debug_info *d = c->dbg;
-	int val;
-
-	if (dent == d->dfs_chk_gen)
-		val = d->chk_gen;
-	else if (dent == d->dfs_chk_index)
-		val = d->chk_index;
-	else if (dent == d->dfs_chk_orph)
-		val = d->chk_orph;
-	else if (dent == d->dfs_chk_lprops)
-		val = d->chk_lprops;
-	else if (dent == d->dfs_chk_fs)
-		val = d->chk_fs;
-	else if (dent == d->dfs_tst_rcvry)
-		val = d->tst_rcvry;
-	else if (dent == d->dfs_ro_error)
-		val = c->ro_error;
-	else
-		return -EINVAL;
-
-	return provide_user_output(val, u, count, ppos);
-}
-
-/**
- * interpret_user_input - interpret user debugfs file input.
- * @u: user-provided buffer with the input
- * @count: buffer size
- *
- * This is a helper function which interpret user input to a boolean UBIFS
- * debugfs file. Returns %0 or %1 in case of success and a negative error code
- * in case of failure.
- */
-static int interpret_user_input(const char __user *u, size_t count)
-{
-	size_t buf_size;
-	char buf[8];
-
-	buf_size = min_t(size_t, count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, u, buf_size))
-		return -EFAULT;
-
-	if (buf[0] == '1')
-		return 1;
-	else if (buf[0] == '0')
-		return 0;
-
-	return -EINVAL;
-}
-
-static ssize_t dfs_file_write(struct file *file, const char __user *u,
-			      size_t count, loff_t *ppos)
-{
-	struct ubifs_info *c = file->private_data;
-	struct ubifs_debug_info *d = c->dbg;
-	struct dentry *dent = file->f_path.dentry;
-	int val;
-
-	if (file->f_path.dentry == d->dfs_dump_lprops) {
-		ubifs_dump_lprops(c);
-		return count;
-	}
-	if (file->f_path.dentry == d->dfs_dump_budg) {
-		ubifs_dump_budg(c, &c->bi);
-		return count;
-	}
-	if (file->f_path.dentry == d->dfs_dump_tnc) {
-		mutex_lock(&c->tnc_mutex);
-		ubifs_dump_tnc(c);
-		mutex_unlock(&c->tnc_mutex);
-		return count;
-	}
-
-	val = interpret_user_input(u, count);
-	if (val < 0)
-		return val;
-
-	if (dent == d->dfs_chk_gen)
-		d->chk_gen = val;
-	else if (dent == d->dfs_chk_index)
-		d->chk_index = val;
-	else if (dent == d->dfs_chk_orph)
-		d->chk_orph = val;
-	else if (dent == d->dfs_chk_lprops)
-		d->chk_lprops = val;
-	else if (dent == d->dfs_chk_fs)
-		d->chk_fs = val;
-	else if (dent == d->dfs_tst_rcvry)
-		d->tst_rcvry = val;
-	else if (dent == d->dfs_ro_error)
-		c->ro_error = !!val;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static const struct file_operations dfs_fops = {
-	.open = dfs_file_open,
-	.read = dfs_file_read,
-	.write = dfs_file_write,
-	.owner = THIS_MODULE,
-	.llseek = no_llseek,
-};
-
-/**
- * dbg_debugfs_init_fs - initialize debugfs for UBIFS instance.
- * @c: UBIFS file-system description object
- *
- * This function creates all debugfs files for this instance of UBIFS.
- *
- * Note, the only reason we have not merged this function with the
- * 'ubifs_debugging_init()' function is because it is better to initialize
- * debugfs interfaces at the very end of the mount process, and remove them at
- * the very beginning of the mount process.
- */
-void dbg_debugfs_init_fs(struct ubifs_info *c)
-{
-	int n;
-	const char *fname;
-	struct ubifs_debug_info *d = c->dbg;
-
-	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
-		     c->vi.ubi_num, c->vi.vol_id);
-	if (n > UBIFS_DFS_DIR_LEN) {
-		/* The array size is too small */
-		return;
-	}
-
-	fname = d->dfs_dir_name;
-	d->dfs_dir = debugfs_create_dir(fname, dfs_rootdir);
-
-	fname = "dump_lprops";
-	d->dfs_dump_lprops = debugfs_create_file(fname, S_IWUSR, d->dfs_dir, c,
-						 &dfs_fops);
-
-	fname = "dump_budg";
-	d->dfs_dump_budg = debugfs_create_file(fname, S_IWUSR, d->dfs_dir, c,
-					       &dfs_fops);
-
-	fname = "dump_tnc";
-	d->dfs_dump_tnc = debugfs_create_file(fname, S_IWUSR, d->dfs_dir, c,
-					      &dfs_fops);
-
-	fname = "chk_general";
-	d->dfs_chk_gen = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					     d->dfs_dir, c, &dfs_fops);
-
-	fname = "chk_index";
-	d->dfs_chk_index = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					       d->dfs_dir, c, &dfs_fops);
-
-	fname = "chk_orphans";
-	d->dfs_chk_orph = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					      d->dfs_dir, c, &dfs_fops);
-
-	fname = "chk_lprops";
-	d->dfs_chk_lprops = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-						d->dfs_dir, c, &dfs_fops);
-
-	fname = "chk_fs";
-	d->dfs_chk_fs = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					    d->dfs_dir, c, &dfs_fops);
-
-	fname = "tst_recovery";
-	d->dfs_tst_rcvry = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					       d->dfs_dir, c, &dfs_fops);
-
-	fname = "ro_error";
-	d->dfs_ro_error = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					      d->dfs_dir, c, &dfs_fops);
-}
-
-/**
- * dbg_debugfs_exit_fs - remove all debugfs files.
- * @c: UBIFS file-system description object
- */
-void dbg_debugfs_exit_fs(struct ubifs_info *c)
-{
-	debugfs_remove_recursive(c->dbg->dfs_dir);
-}
-
-struct ubifs_global_debug_info ubifs_dbg;
-
-static struct dentry *dfs_chk_gen;
-static struct dentry *dfs_chk_index;
-static struct dentry *dfs_chk_orph;
-static struct dentry *dfs_chk_lprops;
-static struct dentry *dfs_chk_fs;
-static struct dentry *dfs_tst_rcvry;
-
-static ssize_t dfs_global_file_read(struct file *file, char __user *u,
-				    size_t count, loff_t *ppos)
-{
-	struct dentry *dent = file->f_path.dentry;
-	int val;
-
-	if (dent == dfs_chk_gen)
-		val = ubifs_dbg.chk_gen;
-	else if (dent == dfs_chk_index)
-		val = ubifs_dbg.chk_index;
-	else if (dent == dfs_chk_orph)
-		val = ubifs_dbg.chk_orph;
-	else if (dent == dfs_chk_lprops)
-		val = ubifs_dbg.chk_lprops;
-	else if (dent == dfs_chk_fs)
-		val = ubifs_dbg.chk_fs;
-	else if (dent == dfs_tst_rcvry)
-		val = ubifs_dbg.tst_rcvry;
-	else
-		return -EINVAL;
-
-	return provide_user_output(val, u, count, ppos);
-}
-
-static ssize_t dfs_global_file_write(struct file *file, const char __user *u,
-				     size_t count, loff_t *ppos)
-{
-	struct dentry *dent = file->f_path.dentry;
-	int val;
-
-	val = interpret_user_input(u, count);
-	if (val < 0)
-		return val;
-
-	if (dent == dfs_chk_gen)
-		ubifs_dbg.chk_gen = val;
-	else if (dent == dfs_chk_index)
-		ubifs_dbg.chk_index = val;
-	else if (dent == dfs_chk_orph)
-		ubifs_dbg.chk_orph = val;
-	else if (dent == dfs_chk_lprops)
-		ubifs_dbg.chk_lprops = val;
-	else if (dent == dfs_chk_fs)
-		ubifs_dbg.chk_fs = val;
-	else if (dent == dfs_tst_rcvry)
-		ubifs_dbg.tst_rcvry = val;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static const struct file_operations dfs_global_fops = {
-	.read = dfs_global_file_read,
-	.write = dfs_global_file_write,
-	.owner = THIS_MODULE,
-	.llseek = no_llseek,
-};
-
-/**
- * dbg_debugfs_init - initialize debugfs file-system.
- *
- * UBIFS uses debugfs file-system to expose various debugging knobs to
- * user-space. This function creates "ubifs" directory in the debugfs
- * file-system.
- */
-void dbg_debugfs_init(void)
-{
-	const char *fname;
-
-	fname = "ubifs";
-	dfs_rootdir = debugfs_create_dir(fname, NULL);
-
-	fname = "chk_general";
-	dfs_chk_gen = debugfs_create_file(fname, S_IRUSR | S_IWUSR, dfs_rootdir,
-					  NULL, &dfs_global_fops);
-
-	fname = "chk_index";
-	dfs_chk_index = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					    dfs_rootdir, NULL, &dfs_global_fops);
-
-	fname = "chk_orphans";
-	dfs_chk_orph = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					   dfs_rootdir, NULL, &dfs_global_fops);
-
-	fname = "chk_lprops";
-	dfs_chk_lprops = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					     dfs_rootdir, NULL, &dfs_global_fops);
-
-	fname = "chk_fs";
-	dfs_chk_fs = debugfs_create_file(fname, S_IRUSR | S_IWUSR, dfs_rootdir,
-					 NULL, &dfs_global_fops);
-
-	fname = "tst_recovery";
-	dfs_tst_rcvry = debugfs_create_file(fname, S_IRUSR | S_IWUSR,
-					    dfs_rootdir, NULL, &dfs_global_fops);
-}
-
-/**
- * dbg_debugfs_exit - remove the "ubifs" directory from debugfs file-system.
- */
-void dbg_debugfs_exit(void)
-{
-	debugfs_remove_recursive(dfs_rootdir);
-}
-
-void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
-			 const char *file, int line)
-{
-	ubifs_err(c, "UBIFS assert failed: %s, in %s:%u", expr, file, line);
-
-	switch (c->assert_action) {
-		case ASSACT_PANIC:
-		BUG();
-		break;
-
-		case ASSACT_RO:
-		ubifs_ro_mode(c, -EINVAL);
-		break;
-
-		case ASSACT_REPORT:
-		default:
-		dump_stack();
-		break;
-
-	}
-}
-
-/**
- * ubifs_debugging_init - initialize UBIFS debugging.
- * @c: UBIFS file-system description object
- *
- * This function initializes debugging-related data for the file system.
- * Returns zero in case of success and a negative error code in case of
- * failure.
- */
-int ubifs_debugging_init(struct ubifs_info *c)
-{
-	c->dbg = kzalloc(sizeof(struct ubifs_debug_info), GFP_KERNEL);
-	if (!c->dbg)
-		return -ENOMEM;
-
-	return 0;
-}
-
-/**
- * ubifs_debugging_exit - free debugging data.
- * @c: UBIFS file-system description object
- */
-void ubifs_debugging_exit(struct ubifs_info *c)
-{
-	kfree(c->dbg);
+	ubifs_ro_mode(c, -EINVAL);
 }
diff --git a/ubifs-utils/libubifs/debug.h b/ubifs-utils/libubifs/debug.h
index ed966108..3a553627 100644
--- a/ubifs-utils/libubifs/debug.h
+++ b/ubifs-utils/libubifs/debug.h
@@ -17,125 +17,6 @@ typedef int (*dbg_leaf_callback)(struct ubifs_info *c,
 typedef int (*dbg_znode_callback)(struct ubifs_info *c,
 				  struct ubifs_znode *znode, void *priv);
 
-/*
- * The UBIFS debugfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
- */
-#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
-#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
-
-/**
- * ubifs_debug_info - per-FS debugging information.
- * @old_zroot: old index root - used by 'dbg_check_old_index()'
- * @old_zroot_level: old index root level - used by 'dbg_check_old_index()'
- * @old_zroot_sqnum: old index root sqnum - used by 'dbg_check_old_index()'
- *
- * @pc_happened: non-zero if an emulated power cut happened
- * @pc_delay: 0=>don't delay, 1=>delay a time, 2=>delay a number of calls
- * @pc_timeout: time in jiffies when delay of failure mode expires
- * @pc_cnt: current number of calls to failure mode I/O functions
- * @pc_cnt_max: number of calls by which to delay failure mode
- *
- * @chk_lpt_sz: used by LPT tree size checker
- * @chk_lpt_sz2: used by LPT tree size checker
- * @chk_lpt_wastage: used by LPT tree size checker
- * @chk_lpt_lebs: used by LPT tree size checker
- * @new_nhead_offs: used by LPT tree size checker
- * @new_ihead_lnum: used by debugging to check @c->ihead_lnum
- * @new_ihead_offs: used by debugging to check @c->ihead_offs
- *
- * @saved_lst: saved lprops statistics (used by 'dbg_save_space_info()')
- * @saved_bi: saved budgeting information
- * @saved_free: saved amount of free space
- * @saved_idx_gc_cnt: saved value of @c->idx_gc_cnt
- *
- * @chk_gen: if general extra checks are enabled
- * @chk_index: if index xtra checks are enabled
- * @chk_orph: if orphans extra checks are enabled
- * @chk_lprops: if lprops extra checks are enabled
- * @chk_fs: if UBIFS contents extra checks are enabled
- * @tst_rcvry: if UBIFS recovery testing mode enabled
- *
- * @dfs_dir_name: name of debugfs directory containing this file-system's files
- * @dfs_dir: direntry object of the file-system debugfs directory
- * @dfs_dump_lprops: "dump lprops" debugfs knob
- * @dfs_dump_budg: "dump budgeting information" debugfs knob
- * @dfs_dump_tnc: "dump TNC" debugfs knob
- * @dfs_chk_gen: debugfs knob to enable UBIFS general extra checks
- * @dfs_chk_index: debugfs knob to enable UBIFS index extra checks
- * @dfs_chk_orph: debugfs knob to enable UBIFS orphans extra checks
- * @dfs_chk_lprops: debugfs knob to enable UBIFS LEP properties extra checks
- * @dfs_chk_fs: debugfs knob to enable UBIFS contents extra checks
- * @dfs_tst_rcvry: debugfs knob to enable UBIFS recovery testing
- * @dfs_ro_error: debugfs knob to switch UBIFS to R/O mode (different to
- *                re-mounting to R/O mode because it does not flush any buffers
- *                and UBIFS just starts returning -EROFS on all write
- *               operations)
- */
-struct ubifs_debug_info {
-	struct ubifs_zbranch old_zroot;
-	int old_zroot_level;
-	unsigned long long old_zroot_sqnum;
-
-	int pc_happened;
-	int pc_delay;
-	unsigned long pc_timeout;
-	unsigned int pc_cnt;
-	unsigned int pc_cnt_max;
-
-	long long chk_lpt_sz;
-	long long chk_lpt_sz2;
-	long long chk_lpt_wastage;
-	int chk_lpt_lebs;
-	int new_nhead_offs;
-	int new_ihead_lnum;
-	int new_ihead_offs;
-
-	struct ubifs_lp_stats saved_lst;
-	struct ubifs_budg_info saved_bi;
-	long long saved_free;
-	int saved_idx_gc_cnt;
-
-	unsigned int chk_gen:1;
-	unsigned int chk_index:1;
-	unsigned int chk_orph:1;
-	unsigned int chk_lprops:1;
-	unsigned int chk_fs:1;
-	unsigned int tst_rcvry:1;
-
-	char dfs_dir_name[UBIFS_DFS_DIR_LEN + 1];
-	struct dentry *dfs_dir;
-	struct dentry *dfs_dump_lprops;
-	struct dentry *dfs_dump_budg;
-	struct dentry *dfs_dump_tnc;
-	struct dentry *dfs_chk_gen;
-	struct dentry *dfs_chk_index;
-	struct dentry *dfs_chk_orph;
-	struct dentry *dfs_chk_lprops;
-	struct dentry *dfs_chk_fs;
-	struct dentry *dfs_tst_rcvry;
-	struct dentry *dfs_ro_error;
-};
-
-/**
- * ubifs_global_debug_info - global (not per-FS) UBIFS debugging information.
- *
- * @chk_gen: if general extra checks are enabled
- * @chk_index: if index xtra checks are enabled
- * @chk_orph: if orphans extra checks are enabled
- * @chk_lprops: if lprops extra checks are enabled
- * @chk_fs: if UBIFS contents extra checks are enabled
- * @tst_rcvry: if UBIFS recovery testing mode enabled
- */
-struct ubifs_global_debug_info {
-	unsigned int chk_gen:1;
-	unsigned int chk_index:1;
-	unsigned int chk_orph:1;
-	unsigned int chk_lprops:1;
-	unsigned int chk_fs:1;
-	unsigned int tst_rcvry:1;
-};
-
 void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 	const char *file, int line);
 
@@ -154,16 +35,15 @@ void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 	}                                                                      \
 } while (0)
 
-#define ubifs_dbg_msg(type, fmt, ...) \
-	pr_debug("UBIFS DBG " type " (pid %d): " fmt "\n", current->pid,       \
-		 ##__VA_ARGS__)
+#define ubifs_dbg_msg(type, fmt, ...) do {				    \
+	pr_debug("UBIFS DBG " type " " fmt "\n",##__VA_ARGS__);		    \
+} while (0)
 
 #define DBG_KEY_BUF_LEN 48
-#define ubifs_dbg_msg_key(type, key, fmt, ...) do {                            \
-	char __tmp_key_buf[DBG_KEY_BUF_LEN];                                   \
-	pr_debug("UBIFS DBG " type " (pid %d): " fmt "%s\n", current->pid,     \
-		 ##__VA_ARGS__,                                                \
-		 dbg_snprintf_key(c, key, __tmp_key_buf, DBG_KEY_BUF_LEN));    \
+#define ubifs_dbg_msg_key(type, key, fmt, ...) do {			    \
+	char __tmp_key_buf[DBG_KEY_BUF_LEN];				    \
+	pr_debug("UBIFS DBG " type " " fmt "%s\n", ##__VA_ARGS__,	    \
+		 dbg_snprintf_key(c, key, __tmp_key_buf, DBG_KEY_BUF_LEN)); \
 } while (0)
 
 /* General messages */
@@ -199,39 +79,8 @@ void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 /* Additional recovery messages */
 #define dbg_rcvry(fmt, ...) ubifs_dbg_msg("rcvry", fmt, ##__VA_ARGS__)
 
-extern struct ubifs_global_debug_info ubifs_dbg;
-
-static inline int dbg_is_chk_gen(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.chk_gen || c->dbg->chk_gen);
-}
-static inline int dbg_is_chk_index(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.chk_index || c->dbg->chk_index);
-}
-static inline int dbg_is_chk_orph(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.chk_orph || c->dbg->chk_orph);
-}
-static inline int dbg_is_chk_lprops(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.chk_lprops || c->dbg->chk_lprops);
-}
-static inline int dbg_is_chk_fs(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.chk_fs || c->dbg->chk_fs);
-}
-static inline int dbg_is_tst_rcvry(const struct ubifs_info *c)
-{
-	return !!(ubifs_dbg.tst_rcvry || c->dbg->tst_rcvry);
-}
-static inline int dbg_is_power_cut(const struct ubifs_info *c)
-{
-	return !!c->dbg->pc_happened;
-}
-
-int ubifs_debugging_init(struct ubifs_info *c);
-void ubifs_debugging_exit(struct ubifs_info *c);
+static inline int dbg_is_chk_index(__unused const struct ubifs_info *c)
+{ return 0; }
 
 /* Dump functions */
 const char *dbg_ntype(int type);
@@ -241,10 +90,8 @@ const char *dbg_get_key_dump(const struct ubifs_info *c,
 			     const union ubifs_key *key);
 const char *dbg_snprintf_key(const struct ubifs_info *c,
 			     const union ubifs_key *key, char *buffer, int len);
-void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode);
 void ubifs_dump_node(const struct ubifs_info *c, const void *node,
 		     int node_len);
-void ubifs_dump_budget_req(const struct ubifs_budget_req *req);
 void ubifs_dump_lstats(const struct ubifs_lp_stats *lst);
 void ubifs_dump_budg(struct ubifs_info *c, const struct ubifs_budg_info *bi);
 void ubifs_dump_lprop(const struct ubifs_info *c,
@@ -258,47 +105,65 @@ void ubifs_dump_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap,
 		     int cat);
 void ubifs_dump_pnode(struct ubifs_info *c, struct ubifs_pnode *pnode,
 		      struct ubifs_nnode *parent, int iip);
-void ubifs_dump_tnc(struct ubifs_info *c);
 void ubifs_dump_index(struct ubifs_info *c);
 void ubifs_dump_lpt_lebs(const struct ubifs_info *c);
 
 int dbg_walk_index(struct ubifs_info *c, dbg_leaf_callback leaf_cb,
 		   dbg_znode_callback znode_cb, void *priv);
+int add_size(struct ubifs_info *c, struct ubifs_znode *znode, void *priv);
 
 /* Checking functions */
-void dbg_save_space_info(struct ubifs_info *c);
-int dbg_check_space_info(struct ubifs_info *c);
-int dbg_check_lprops(struct ubifs_info *c);
-int dbg_old_index_check_init(struct ubifs_info *c, struct ubifs_zbranch *zroot);
-int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot);
-int dbg_check_cats(struct ubifs_info *c);
-int dbg_check_ltab(struct ubifs_info *c);
-int dbg_chk_lpt_free_spc(struct ubifs_info *c);
-int dbg_chk_lpt_sz(struct ubifs_info *c, int action, int len);
-int dbg_check_synced_i_size(const struct ubifs_info *c, struct inode *inode);
-int dbg_check_dir(struct ubifs_info *c, const struct inode *dir);
-int dbg_check_tnc(struct ubifs_info *c, int extra);
-int dbg_check_idx_size(struct ubifs_info *c, long long idx_size);
-int dbg_check_filesystem(struct ubifs_info *c);
-void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
-		    int add_pos);
-int dbg_check_lpt_nodes(struct ubifs_info *c, struct ubifs_cnode *cnode,
-			int row, int col);
-int dbg_check_inode_size(struct ubifs_info *c, const struct inode *inode,
-			 loff_t size);
-int dbg_check_data_nodes_order(struct ubifs_info *c, struct list_head *head);
-int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head);
-
-int dbg_leb_write(struct ubifs_info *c, int lnum, const void *buf, int offs,
-		  int len);
-int dbg_leb_change(struct ubifs_info *c, int lnum, const void *buf, int len);
-int dbg_leb_unmap(struct ubifs_info *c, int lnum);
-int dbg_leb_map(struct ubifs_info *c, int lnum);
-
-/* Debugfs-related stuff */
-void dbg_debugfs_init(void);
-void dbg_debugfs_exit(void);
-void dbg_debugfs_init_fs(struct ubifs_info *c);
-void dbg_debugfs_exit_fs(struct ubifs_info *c);
+static inline void dbg_save_space_info(__unused struct ubifs_info *c) {}
+static inline int dbg_check_space_info(__unused struct ubifs_info *c)
+{ return 0; }
+static inline int dbg_check_lprops(__unused struct ubifs_info *c) { return 0; }
+static inline int dbg_old_index_check_init(__unused struct ubifs_info *c,
+					   __unused struct ubifs_zbranch *zroot)
+{ return 0; }
+static inline int dbg_check_old_index(__unused struct ubifs_info *c,
+				      __unused struct ubifs_zbranch *zroot)
+{ return 0; }
+static inline int dbg_check_cats(__unused struct ubifs_info *c) { return 0; }
+static inline int dbg_check_ltab(__unused struct ubifs_info *c) { return 0; }
+static inline int dbg_chk_lpt_free_spc(__unused struct ubifs_info *c)
+{ return 0; }
+static inline int dbg_chk_lpt_sz(__unused struct ubifs_info *c,
+				 __unused int action, __unused int len)
+{ return 0; }
+static inline int dbg_check_tnc(__unused struct ubifs_info *c,
+				__unused int extra) { return 0; }
+static inline int dbg_check_idx_size(__unused struct ubifs_info *c,
+				     __unused long long idx_size) { return 0; }
+static inline int dbg_check_filesystem(__unused struct ubifs_info *c)
+{ return 0; }
+static inline void dbg_check_heap(__unused struct ubifs_info *c,
+				  __unused struct ubifs_lpt_heap *heap,
+				  __unused int cat,
+				  __unused int add_pos) {}
+static inline int dbg_check_lpt_nodes(__unused struct ubifs_info *c,
+				      __unused struct ubifs_cnode *cnode,
+				      __unused int row,
+				      __unused int col) { return 0; }
+static inline int dbg_check_data_nodes_order(__unused struct ubifs_info *c,
+					     __unused struct list_head *head)
+{ return 0; }
+static inline int dbg_check_nondata_nodes_order(__unused struct ubifs_info *c,
+						__unused struct list_head *head)
+{ return 0; }
+static inline int dbg_leb_write(__unused struct ubifs_info *c,
+				__unused int lnum, __unused const void *buf,
+				__unused int offs, __unused int len)
+{ return 0; }
+static inline int dbg_leb_change(__unused struct ubifs_info *c,
+				 __unused int lnum, __unused const void *buf,
+				 __unused int len) { return 0; }
+static inline int dbg_leb_unmap(__unused struct ubifs_info *c,
+				__unused int lnum) { return 0; }
+static inline int dbg_leb_map(__unused struct ubifs_info *c, __unused int lnum)
+{ return 0; }
+
+extern void print_hex_dump(const char *prefix_str,
+			   int prefix_type, int rowsize, int groupsize,
+			   const void *buf, size_t len, bool ascii);
 
 #endif /* !__UBIFS_DEBUG_H__ */
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index f32818dc..2af9d87b 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -786,8 +786,6 @@ struct ubifs_budg_info {
 	int dent_budget;
 };
 
-struct ubifs_debug_info;
-
 /**
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
-- 
2.13.6


