Return-Path: <linux-kernel+bounces-205342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F818FFAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B9E1C244BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234B15B57E;
	Fri,  7 Jun 2024 04:27:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFA15AD9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734453; cv=none; b=G5dyPD1WVcso0CPx2V3ue21XKhZv/5uIqC3SSqpLoGLAKFJ+nRkOiJMxlTcznAJdZI6QjO8NbdEiNVkJF1i2ugb8zvoI5HcPNkj9cFJP9CWqO8ey9WHbcgU8GHihyrEyl+r5jo/O//edVu6kLmqvgE2pq9kp17oAuLm265vHo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734453; c=relaxed/simple;
	bh=JjJcN9iWyNonrHwgWIIfqfaiLq6dkNPRPMNX5nCV5bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSU2U4NDoTkTiPK29qwwvIYkALj5QSS5DFeyZdz7fKtXNSHEckwrJA3TJ/dNamTfMBUi6/0QmRP/fIjFufFHkp+XdXSDuMgmUaYKMmenv3SW/Z6xvn85C1ysliobr0uVs/3VH37QoHx1tS+Sv5Nh4S/EJe17PJnrnbutRnqGHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjQ45gTzmYTL;
	Fri,  7 Jun 2024 12:22:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6378E180085;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:17 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 068/110] fsck.ubifs: rebuild_fs: Check and correct files' information
Date: Fri, 7 Jun 2024 12:25:33 +0800
Message-ID: <20240607042615.2069840-69-chengzhihao1@huawei.com>
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

This is the 6/12 step of rebuilding. Correct the file information.
Traverse all files and calculate information (nlink, size, xattr_cnt,
etc.) for each file just like check_leaf() does, correct inode node
based on the calculated information.
Now, all files are consistent, and UBIFS will pass chk_fs after mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/extract_files.c | 270 +++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |   1 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c    |   6 +
 ubifs-utils/libubifs/debug.c           |   2 +-
 ubifs-utils/libubifs/debug.h           |   1 +
 5 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index dd5cb310..b8777f6c 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -13,6 +13,7 @@
 #include "linux_err.h"
 #include "bitops.h"
 #include "kmem.h"
+#include "crc32.h"
 #include "ubifs.h"
 #include "defs.h"
 #include "debug.h"
@@ -982,3 +983,272 @@ reachable:
 	dbg_fsck("file %lu is reachable, in %s", file->inum, c->dev_name);
 	return true;
 }
+
+/**
+ * calculate_file_info - calculate the information of file
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @file_tree: tree of all scanned files
+ *
+ * This function calculates file information according to dentry nodes,
+ * data nodes and truncation node. The calculated informaion will be used
+ * to correct inode node.
+ */
+static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
+				struct rb_root *file_tree)
+{
+	int nlink = 0;
+	bool corrupted_truncation = false;
+	unsigned long long ino_sqnum, trun_size = 0, new_size = 0, trun_sqnum = 0;
+	struct rb_node *node;
+	struct scanned_file *parent_file, *xattr_file;
+	struct scanned_dent_node *dent_node;
+	struct scanned_data_node *data_node;
+	LIST_HEAD(drop_list);
+
+	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
+		xattr_file = rb_entry(node, struct scanned_file, rb);
+
+		ubifs_assert(c, !rb_first(&xattr_file->xattr_files));
+		calculate_file_info(c, xattr_file, file_tree);
+	}
+
+	if (file->inum == UBIFS_ROOT_INO) {
+		file->calc_nlink += 2;
+		file->calc_size += UBIFS_INO_NODE_SZ;
+		return;
+	}
+
+	if (S_ISDIR(file->ino.mode)) {
+		file->calc_nlink += 2;
+		file->calc_size += UBIFS_INO_NODE_SZ;
+
+		dent_node = rb_entry(rb_first(&file->dent_nodes),
+				     struct scanned_dent_node, rb);
+		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
+		if (!parent_file) {
+			ubifs_assert(c, 0);
+			return;
+		}
+		parent_file->calc_nlink += 1;
+		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
+		return;
+	}
+
+	if (file->ino.is_xattr) {
+		file->calc_nlink = 1;
+		file->calc_size = file->ino.size;
+
+		dent_node = rb_entry(rb_first(&file->dent_nodes),
+				     struct scanned_dent_node, rb);
+		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
+		if (!parent_file) {
+			ubifs_assert(c, 0);
+			return;
+		}
+		parent_file->calc_xcnt += 1;
+		parent_file->calc_xsz += CALC_DENT_SIZE(dent_node->nlen);
+		parent_file->calc_xsz += CALC_XATTR_BYTES(file->ino.size);
+		parent_file->calc_xnms += dent_node->nlen;
+		return;
+	}
+
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		nlink++;
+
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
+		if (!parent_file) {
+			ubifs_assert(c, 0);
+			return;
+		}
+		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
+	}
+	file->calc_nlink = nlink;
+
+	if (!S_ISREG(file->ino.mode)) {
+		/* No need to verify i_size for symlink/sock/block/char/fifo. */
+		file->calc_size = file->ino.size;
+		return;
+	}
+
+	/*
+	 * Process i_size and data content, following situations should
+	 * be considered:
+	 * 1. Sequential writing or overwriting, i_size should be
+	 *    max(i_size, data node size), pick larger sqnum one from
+	 *    data nodes with same block index.
+	 * 2. Mixed truncation and writing, i_size depends on the latest
+	 *    truncation node or inode node or last data node, pick data
+	 *    nodes which are not truncated.
+	 * 3. Setting bigger i_size attr, pick inode size or biggest
+	 *    i_size calculated by data nodes.
+	 */
+	if (file->trun.header.exist) {
+		trun_size = file->trun.new_size;
+		trun_sqnum = file->trun.header.sqnum;
+	}
+	ino_sqnum = file->ino.header.sqnum;
+	for (node = rb_first(&file->data_nodes); node; node = rb_next(node)) {
+		unsigned long long d_sz, d_sqnum;
+		unsigned int block_no;
+
+		data_node = rb_entry(node, struct scanned_data_node, rb);
+
+		d_sqnum = data_node->header.sqnum;
+		block_no = key_block(c, &data_node->key);
+		d_sz = data_node->size + block_no * UBIFS_BLOCK_SIZE;
+		if ((trun_sqnum > d_sqnum && trun_size < d_sz) ||
+		    (ino_sqnum > d_sqnum && file->ino.size < d_sz)) {
+			/*
+			 * The truncated data nodes are not gced after
+			 * truncating, just remove them.
+			 */
+			list_add(&data_node->list, &drop_list);
+		} else {
+			new_size = max_t(unsigned long long, new_size, d_sz);
+		}
+	}
+	/*
+	 * Truncation node is written successful, but inode node is not. It
+	 * won't happen because inode node is written before truncation node
+	 * according to ubifs_jnl_truncate(), unless only inode is corrupted.
+	 * In this case, data nodes could have been removed in history mounting
+	 * recovery, so i_size needs to be updated.
+	 */
+	if (trun_sqnum > ino_sqnum && trun_size < file->ino.size) {
+		if (trun_size < new_size) {
+			corrupted_truncation = true;
+			/*
+			 * Appendant writing after truncation and newest inode
+			 * is not fell on disk.
+			 */
+			goto update_isize;
+		}
+
+		/*
+		 * Overwriting happens after truncation and newest inode is
+		 * not fell on disk.
+		 */
+		file->calc_size = trun_size;
+		goto drop_data;
+	}
+update_isize:
+	/*
+	 * The file cannot use 'new_size' directly when the file may have ever
+	 * been set i_size. For example:
+	 *  1. echo 123 > file		# i_size = 4
+	 *  2. truncate -s 100 file	# i_size = 100
+	 * After scanning, new_size is 4. Apperantly the size of 'file' should
+	 * be 100. So, the calculated new_size according to data nodes should
+	 * only be used for extending i_size, like ubifs_recover_size() does.
+	 */
+	if (new_size > file->ino.size || corrupted_truncation)
+		file->calc_size = new_size;
+	else
+		file->calc_size = file->ino.size;
+
+drop_data:
+	while (!list_empty(&drop_list)) {
+		data_node = list_entry(drop_list.next, struct scanned_data_node,
+				       list);
+
+		list_del(&data_node->list);
+		rb_erase(&data_node->rb, &file->data_nodes);
+		kfree(data_node);
+	}
+}
+
+/**
+ * correct_file_info - correct the information of file
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * This function corrects file information according to calculated fields,
+ * eg. 'calc_nlink', 'calc_xcnt', 'calc_xsz', 'calc_xnms' and 'calc_size'.
+ * Corrected inode node will be re-written.
+ */
+static int correct_file_info(struct ubifs_info *c, struct scanned_file *file)
+{
+	uint32_t crc;
+	int err, lnum, len;
+	struct rb_node *node;
+	struct ubifs_ino_node *ino;
+	struct scanned_file *xattr_file;
+
+	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
+		xattr_file = rb_entry(node, struct scanned_file, rb);
+
+		err = correct_file_info(c, xattr_file);
+		if (err)
+			return err;
+	}
+
+	if (file->calc_nlink == file->ino.nlink &&
+	    file->calc_xcnt == file->ino.xcnt &&
+	    file->calc_xsz == file->ino.xsz &&
+	    file->calc_xnms == file->ino.xnms &&
+	    file->calc_size == file->ino.size)
+		return 0;
+
+	lnum = file->ino.header.lnum;
+	dbg_fsck("correct file(inum:%lu type:%s), nlink %u->%u, xattr cnt %u->%u, xattr size %u->%u, xattr names %u->%u, size %llu->%llu, at %d:%d, in %s",
+		 file->inum, file->ino.is_xattr ? "xattr" :
+		 ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
+		 file->ino.nlink, file->calc_nlink,
+		 file->ino.xcnt, file->calc_xcnt,
+		 file->ino.xsz, file->calc_xsz,
+		 file->ino.xnms, file->calc_xnms,
+		 file->ino.size, file->calc_size,
+		 lnum, file->ino.header.offs, c->dev_name);
+
+	err = ubifs_leb_read(c, lnum, c->sbuf, 0, c->leb_size, 0);
+	if (err && err != -EBADMSG)
+		return err;
+
+	ino = c->sbuf + file->ino.header.offs;
+	ino->nlink = cpu_to_le32(file->calc_nlink);
+	ino->xattr_cnt = cpu_to_le32(file->calc_xcnt);
+	ino->xattr_size = cpu_to_le32(file->calc_xsz);
+	ino->xattr_names = cpu_to_le32(file->calc_xnms);
+	ino->size = cpu_to_le64(file->calc_size);
+	len = le32_to_cpu(ino->ch.len);
+	crc = crc32(UBIFS_CRC32_INIT, (void *)ino + 8, len - 8);
+	ino->ch.crc = cpu_to_le32(crc);
+
+	/* Atomically write the fixed LEB back again */
+	return ubifs_leb_change(c, lnum, c->sbuf, c->leb_size);
+}
+
+/**
+ * check_and_correct_files - check and correct information of files.
+ * @c: UBIFS file-system description object
+ *
+ * This function does similar things with dbg_check_filesystem(), besides,
+ * it also corrects file information if the calculated information is not
+ * consistent with information from flash.
+ */
+int check_and_correct_files(struct ubifs_info *c)
+{
+	int err;
+	struct rb_node *node;
+	struct scanned_file *file;
+	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		calculate_file_info(c, file, tree);
+	}
+
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		err = correct_file_info(c, file);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index d378a06c..124c8f12 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -272,6 +272,7 @@ bool file_is_valid(struct ubifs_info *c, struct scanned_file *file,
 		   struct rb_root *file_tree);
 bool file_is_reachable(struct ubifs_info *c, struct scanned_file *file,
 		       struct rb_root *file_tree);
+int check_and_correct_files(struct ubifs_info *c);
 
 /* rebuild_fs.c */
 int ubifs_rebuild_filesystem(struct ubifs_info *c);
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 669b61d1..ecf6b0c6 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -677,6 +677,12 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	log_out(c, "Extract reachable files");
 	extract_dentry_tree(c);
 
+	/* Step 6: Check & correct files' information. */
+	log_out(c, "Check & correct file information");
+	err = check_and_correct_files(c);
+	if (err)
+		exit_code |= FSCK_ERROR;
+
 out:
 	destroy_scanned_info(c, &si);
 	destroy_rebuild_info(c);
diff --git a/ubifs-utils/libubifs/debug.c b/ubifs-utils/libubifs/debug.c
index 94928da3..eaf403f9 100644
--- a/ubifs-utils/libubifs/debug.c
+++ b/ubifs-utils/libubifs/debug.c
@@ -69,7 +69,7 @@ static const char *get_key_type(int type)
 	}
 }
 
-static const char *get_dent_type(int type)
+const char *ubifs_get_type_name(int type)
 {
 	switch (type) {
 	case UBIFS_ITYPE_REG:
diff --git a/ubifs-utils/libubifs/debug.h b/ubifs-utils/libubifs/debug.h
index 8da79f80..400b4759 100644
--- a/ubifs-utils/libubifs/debug.h
+++ b/ubifs-utils/libubifs/debug.h
@@ -85,6 +85,7 @@ static inline int dbg_is_chk_index(__unused const struct ubifs_info *c)
 { return 0; }
 
 /* Dump functions */
+const char *ubifs_get_type_name(int type);
 const char *dbg_ntype(int type);
 const char *dbg_cstate(int cmt_state);
 const char *dbg_jhead(int jhead);
-- 
2.13.6


