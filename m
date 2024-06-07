Return-Path: <linux-kernel+bounces-205339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6351B8FFAAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A05B2392E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C39815B546;
	Fri,  7 Jun 2024 04:27:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE015AAD8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734452; cv=none; b=aFrrTE95lFh2ZJFGoSuWxlWsMuVAUL6frm0qMp9LpNnta/grke1yEQfvHTG2UDKuqCvm75y77fFsk9i29uqqmKq/ycaW6cvU56eZ4dUZYeKfqynxHDRkSuTvVSoxs1gT7vS8DcQL/OYGcLM3ybSnAsbGsPvPgNY93AvD51Jf5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734452; c=relaxed/simple;
	bh=uiNzvde071gvOkaEDPv796rwgGMkt8g5p/0317fU/c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5EzRMBB7T54cBzYruUpY7AUl7S/BoLIfh1imWMlRmT1I+XfYZSI/1YG+AWpcUMJmD/V+zbCWu3/GabydSAfoz8NV7uIfj6zbcRFXX4K9kKCRHF0FMTYr6Ay10mIEPHnPH+SX6Mh2oNFNkqYqA6hb205f/8zvbJMV4QE5cHTNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSn50h7pzdZdd;
	Fri,  7 Jun 2024 12:26:01 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 03E8C180085;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:12 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 062/110] fsck.ubifs: Add file organization realization
Date: Fri, 7 Jun 2024 12:25:27 +0800
Message-ID: <20240607042615.2069840-63-chengzhihao1@huawei.com>
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

In order to check the consistency of each file and the reachability of
the whole dentry tree, fsck orginizes all nodes into files. And the
final recovered file(xattr is treated as a file) is organized as:
   (rbtree, inum indexed)
        /    \
     file1   file2
     /    \
  file3  file4

file {
        inode node // each file has 1 inode node
        dentry (sub rb_tree, sqnum indexed) // '/' has no dentries,
                                            // otherwise at least 1
                                            // dentry is required.
        trun node // the newest one truncation node
        data (sub rb_tree, block number indexed) // Each file may have 0
                                                 // or many data nodes
	xattrs (sub rb_tree, inum indexed) // Each file may have 0 or
                                           // many xattr files
}

Each file from file rb_tree is constructed by scanning nodes(eg. inode,
dentry, etc.) from the TNC or the UBI volume. File's xattrs will be
initialized in subsequent steps.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/extract_files.c | 275 +++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |  43 ++++++
 2 files changed, 318 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index dd52ef84..58aa9db8 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -403,3 +403,278 @@ bool parse_trun_node(struct ubifs_info *c, int lnum, int offs, void *node,
 out:
 	return valid;
 }
+
+/**
+ * insert_file_dentry - insert dentry according to scanned dent node.
+ * @file: file object
+ * @n_dent: scanned dent node
+ *
+ * Insert file dentry information. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_file_dentry(struct scanned_file *file,
+			      struct scanned_dent_node *n_dent)
+{
+	struct scanned_dent_node *dent;
+	struct rb_node **p, *parent = NULL;
+
+	p = &file->dent_nodes.rb_node;
+	while (*p) {
+		parent = *p;
+		dent = rb_entry(parent, struct scanned_dent_node, rb);
+		if (n_dent->header.sqnum < dent->header.sqnum)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	dent = kmalloc(sizeof(struct scanned_dent_node), GFP_KERNEL);
+	if (!dent)
+		return -ENOMEM;
+
+	*dent = *n_dent;
+	rb_link_node(&dent->rb, parent, p);
+	rb_insert_color(&dent->rb, &file->dent_nodes);
+
+	return 0;
+}
+
+/**
+ * update_file_data - insert/update data according to scanned data node.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @n_dn: scanned data node
+ *
+ * Insert or update file data information. Returns zero in case of success,
+ * a negative error code in case of failure.
+ */
+static int update_file_data(struct ubifs_info *c, struct scanned_file *file,
+			    struct scanned_data_node *n_dn)
+{
+	int cmp;
+	struct scanned_data_node *dn, *o_dn = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &file->data_nodes.rb_node;
+	while (*p) {
+		parent = *p;
+		dn = rb_entry(parent, struct scanned_data_node, rb);
+		cmp = keys_cmp(c, &n_dn->key, &dn->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			o_dn = dn;
+			break;
+		}
+	}
+
+	if (o_dn) {
+		/* found data node with same block no. */
+		if (o_dn->header.sqnum < n_dn->header.sqnum) {
+			o_dn->header = n_dn->header;
+			o_dn->size = n_dn->size;
+		}
+
+		return 0;
+	}
+
+	dn = kmalloc(sizeof(struct scanned_data_node), GFP_KERNEL);
+	if (!dn)
+		return -ENOMEM;
+
+	*dn = *n_dn;
+	INIT_LIST_HEAD(&dn->list);
+	rb_link_node(&dn->rb, parent, p);
+	rb_insert_color(&dn->rb, &file->data_nodes);
+
+	return 0;
+}
+
+/**
+ * update_file - update file information.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @sn: scanned node
+ * @key_type: type of @sn
+ *
+ * Update inode/dent/truncation/data node information of @file. Returns
+ * zero in case of success, a negative error code in case of failure.
+ */
+static int update_file(struct ubifs_info *c, struct scanned_file *file,
+		       struct scanned_node *sn, int key_type)
+{
+	int err = 0;
+
+	switch (key_type) {
+	case UBIFS_INO_KEY:
+	{
+		struct scanned_ino_node *o_ino, *n_ino;
+
+		o_ino = &file->ino;
+		n_ino = (struct scanned_ino_node *)sn;
+		if (o_ino->header.exist && o_ino->header.sqnum > sn->sqnum)
+			goto out;
+
+		*o_ino = *n_ino;
+		break;
+	}
+	case UBIFS_DENT_KEY:
+	case UBIFS_XENT_KEY:
+	{
+		struct scanned_dent_node *dent = (struct scanned_dent_node *)sn;
+
+		err = insert_file_dentry(file, dent);
+		break;
+	}
+	case UBIFS_DATA_KEY:
+	{
+		struct scanned_data_node *dn = (struct scanned_data_node *)sn;
+
+		err = update_file_data(c, file, dn);
+		break;
+	}
+	case UBIFS_TRUN_KEY:
+	{
+		struct scanned_trun_node *o_trun, *n_trun;
+
+		o_trun = &file->trun;
+		n_trun = (struct scanned_trun_node *)sn;
+		if (o_trun->header.exist && o_trun->header.sqnum > sn->sqnum)
+			goto out;
+
+		*o_trun = *n_trun;
+		break;
+	}
+	default:
+		err = -EINVAL;
+		log_err(c, 0, "unknown key type %d", key_type);
+	}
+
+out:
+	return err;
+}
+
+/**
+ * insert_or_update_file - insert or update file according to scanned node.
+ * @c: UBIFS file-system description object
+ * @file_tree: tree of all scanned files
+ * @sn: scanned node
+ * @key_type: key type of @sn
+ * @inum: inode number
+ *
+ * According to @sn, this function inserts file into the tree, or updates
+ * file information if it already exists in the tree. Returns zero in case
+ * of success, a negative error code in case of failure.
+ */
+int insert_or_update_file(struct ubifs_info *c, struct rb_root *file_tree,
+			  struct scanned_node *sn, int key_type, ino_t inum)
+{
+	int err;
+	struct scanned_file *file, *old_file = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &file_tree->rb_node;
+	while (*p) {
+		parent = *p;
+		file = rb_entry(parent, struct scanned_file, rb);
+		if (inum < file->inum) {
+			p = &(*p)->rb_left;
+		} else if (inum > file->inum) {
+			p = &(*p)->rb_right;
+		} else {
+			old_file = file;
+			break;
+		}
+	}
+	if (old_file)
+		return update_file(c, old_file, sn, key_type);
+
+	file = kzalloc(sizeof(struct scanned_file), GFP_KERNEL);
+	if (!file)
+		return -ENOMEM;
+
+	file->inum = inum;
+	file->dent_nodes = RB_ROOT;
+	file->data_nodes = RB_ROOT;
+	file->xattr_files = RB_ROOT;
+	INIT_LIST_HEAD(&file->list);
+	err = update_file(c, file, sn, key_type);
+	if (err) {
+		kfree(file);
+		return err;
+	}
+	rb_link_node(&file->rb, parent, p);
+	rb_insert_color(&file->rb, file_tree);
+
+	return 0;
+}
+
+/**
+ * destroy_file_content - destroy scanned data/dentry nodes in give file.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * Destroy all data/dentry nodes and xattrs attached to @file.
+ */
+void destroy_file_content(struct ubifs_info *c, struct scanned_file *file)
+{
+	struct scanned_data_node *data_node;
+	struct scanned_dent_node *dent_node;
+	struct scanned_file *xattr_file;
+	struct rb_node *this;
+
+	this = rb_first(&file->data_nodes);
+	while (this) {
+		data_node = rb_entry(this, struct scanned_data_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&data_node->rb, &file->data_nodes);
+		kfree(data_node);
+	}
+
+	this = rb_first(&file->dent_nodes);
+	while (this) {
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent_node->rb, &file->dent_nodes);
+		kfree(dent_node);
+	}
+
+	this = rb_first(&file->xattr_files);
+	while (this) {
+		xattr_file = rb_entry(this, struct scanned_file, rb);
+		this = rb_next(this);
+
+		ubifs_assert(c, !rb_first(&xattr_file->xattr_files));
+		destroy_file_content(c, xattr_file);
+		rb_erase(&xattr_file->rb, &file->xattr_files);
+		kfree(xattr_file);
+	}
+}
+
+/**
+ * destroy_file_tree - destroy files from a given tree.
+ * @c: UBIFS file-system description object
+ * @file_tree: tree of all scanned files
+ *
+ * Destroy scanned files from a given tree.
+ */
+void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree)
+{
+	struct scanned_file *file;
+	struct rb_node *this;
+
+	this = rb_first(file_tree);
+	while (this) {
+		file = rb_entry(this, struct scanned_file, rb);
+		this = rb_next(this);
+
+		destroy_file_content(c, file);
+
+		rb_erase(&file->rb, file_tree);
+		kfree(file);
+	}
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 3511d90e..80d3af84 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -136,6 +136,45 @@ struct scanned_trun_node {
 };
 
 /**
+ * scanned_file - file info scanned from UBIFS volume.
+ *
+ * @calc_nlink: calculated count of directory entries refer this inode
+ * @calc_xcnt: calculated count of extended attributes
+ * @calc_xsz: calculated summary size of all extended attributes
+ * @calc_xnms: calculated sum of lengths of all extended attribute names
+ * @calc_size: calculated file size
+ * @has_encrypted_info: whether the file has encryption related xattrs
+ *
+ * @inum: inode number
+ * @ino: inode node
+ * @trun: truncation node
+ *
+ * @rb: link in the tree of all scanned files
+ * @list: link in the list files for kinds of processing
+ * @dent_nodes: tree of all scanned dentry nodes
+ * @data_nodes: tree of all scanned data nodes
+ * @xattr_files: tree of all scanned xattr files
+ */
+struct scanned_file {
+	unsigned int calc_nlink;
+	unsigned int calc_xcnt;
+	unsigned int calc_xsz;
+	unsigned int calc_xnms;
+	unsigned long long calc_size;
+	bool has_encrypted_info;
+
+	ino_t inum;
+	struct scanned_ino_node ino;
+	struct scanned_trun_node trun;
+
+	struct rb_node rb;
+	struct list_head list;
+	struct rb_root dent_nodes;
+	struct rb_root data_nodes;
+	struct rb_root xattr_files;
+};
+
+/**
  * struct ubifs_fsck_info - UBIFS fsck information.
  * @mode: working mode
  * @failure_reason: reasons for failed operations
@@ -208,5 +247,9 @@ bool parse_data_node(struct ubifs_info *c, int lnum, int offs, void *node,
 		     union ubifs_key *key, struct scanned_data_node *data_node);
 bool parse_trun_node(struct ubifs_info *c, int lnum, int offs, void *node,
 		     union ubifs_key *key, struct scanned_trun_node *trun_node);
+int insert_or_update_file(struct ubifs_info *c, struct rb_root *file_tree,
+			  struct scanned_node *sn, int key_type, ino_t inum);
+void destroy_file_content(struct ubifs_info *c, struct scanned_file *file);
+void destroy_file_tree(struct ubifs_info *c, struct rb_root *file_tree);
 
 #endif
-- 
2.13.6


