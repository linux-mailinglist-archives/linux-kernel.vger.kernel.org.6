Return-Path: <linux-kernel+bounces-205344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A258FFAB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954021C24863
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D715E5D0;
	Fri,  7 Jun 2024 04:27:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D115ADA5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734453; cv=none; b=Fv6PhEk+ECpDUT37xdGxfimJtmMG7cegaNAex3JVkDfLC74fUJOW8b6Hg2Q/LsWkH6XXA+wJdbA34L1WhW7e9UMUabOoDZfU60eEnbh7uYCIJoDjCaY8TAUFZnGQAbO5ZUw93tr8uwTMkx4ml24S507p+D9EGm9vnJ2jYAIVVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734453; c=relaxed/simple;
	bh=X008Pgw+qU8sTBy41rVjAJN0OkshQtjKI1ja8sYelZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6E9zYZ099JIkEMj4icUE/sOqJmEHVrIku2lyfkAmKv/kunu3UgAPAe1kiq7dWAT3zimOTKgzP7aBNV6ryIAVYVHSRbb41XskNVyH7mmsv9aTbqqho2IxtcCORfHamv13cS7YtB5PXhOlGQM7Oz9/jReSZqxNqoUPIQT3YgnN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSk768mlz1SB5L;
	Fri,  7 Jun 2024 12:23:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 94960180AA6;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:19 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 071/110] fsck.ubifs: rebuild_fs: Create new root dir if there are no scanned files
Date: Fri, 7 Jun 2024 12:25:36 +0800
Message-ID: <20240607042615.2069840-72-chengzhihao1@huawei.com>
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

This is a preparation for building TNC, there must at least one file
in filesystem, if not, just create new root dir.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   6 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 213 +++++++++++++++++++++++++++++++++++-
 2 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index f027ec3f..bc1d7503 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -183,11 +183,17 @@ struct scanned_file {
  * @used_lebs: a bitmap used for recording used lebs
  * @lpts: lprops table
  * @scanned_files: tree of all scanned files
+ * @write_buf: write buffer for LEB @head_lnum
+ * @head_lnum: current writing LEB number
+ * @head_offs: current writing position in LEB @head_lnum
  */
 struct ubifs_rebuild_info {
 	unsigned long *used_lebs;
 	struct ubifs_lprops *lpts;
 	struct rb_root scanned_files;
+	void *write_buf;
+	int head_lnum;
+	int head_offs;
 };
 
 /**
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 1b03d6c0..62bd4128 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -65,9 +65,17 @@ static int init_rebuild_info(struct ubifs_info *c)
 		log_err(c, errno, "can not allocate lpts");
 		goto free_used_lebs;
 	}
+	FSCK(c)->rebuild->write_buf = vmalloc(c->leb_size);
+	if (!FSCK(c)->rebuild->write_buf) {
+		err = -ENOMEM;
+		goto free_lpts;
+	}
+	FSCK(c)->rebuild->head_lnum = -1;
 
 	return 0;
 
+free_lpts:
+	kfree(FSCK(c)->rebuild->lpts);
 free_used_lebs:
 	kfree(FSCK(c)->rebuild->used_lebs);
 free_rebuild:
@@ -79,6 +87,7 @@ free_sbuf:
 
 static void destroy_rebuild_info(struct ubifs_info *c)
 {
+	vfree(FSCK(c)->rebuild->write_buf);
 	kfree(FSCK(c)->rebuild->lpts);
 	kfree(FSCK(c)->rebuild->used_lebs);
 	kfree(FSCK(c)->rebuild);
@@ -661,6 +670,197 @@ static void extract_dentry_tree(struct ubifs_info *c)
 	}
 }
 
+static void init_root_ino(struct ubifs_info *c, struct ubifs_ino_node *ino)
+{
+#define S_IRUGO		(S_IRUSR|S_IRGRP|S_IROTH)
+#define S_IXUGO		(S_IXUSR|S_IXGRP|S_IXOTH)
+	__le64 tmp_le64;
+
+	/* Create default root inode */
+	ino_key_init_flash(c, &ino->key, UBIFS_ROOT_INO);
+	ino->ch.node_type = UBIFS_INO_NODE;
+	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
+	ino->nlink = cpu_to_le32(2);
+	tmp_le64 = cpu_to_le64(time(NULL));
+	ino->atime_sec   = tmp_le64;
+	ino->ctime_sec   = tmp_le64;
+	ino->mtime_sec   = tmp_le64;
+	ino->atime_nsec  = 0;
+	ino->ctime_nsec  = 0;
+	ino->mtime_nsec  = 0;
+	ino->mode = cpu_to_le32(S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
+	ino->size = cpu_to_le64(UBIFS_INO_NODE_SZ);
+	/* Set compression enabled by default */
+	ino->flags = cpu_to_le32(UBIFS_COMPR_FL);
+}
+
+/**
+ * get_free_leb - get a free LEB according to @FSCK(c)->rebuild->used_lebs.
+ * @c: UBIFS file-system description object
+ *
+ * This function tries to find a free LEB, %0 is returned if found, otherwise
+ * %ENOSPC is returned.
+ */
+static int get_free_leb(struct ubifs_info *c)
+{
+	int lnum, err;
+
+	lnum = find_next_zero_bit(FSCK(c)->rebuild->used_lebs, c->main_lebs, 0);
+	if (lnum >= c->main_lebs) {
+		ubifs_err(c, "No space left.");
+		return -ENOSPC;
+	}
+	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
+	lnum += c->main_first;
+
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		return err;
+
+	FSCK(c)->rebuild->head_lnum = lnum;
+	FSCK(c)->rebuild->head_offs = 0;
+
+	return 0;
+}
+
+/**
+ * flush_write_buf - flush write buffer.
+ * @c: UBIFS file-system description object
+ *
+ * This function flush write buffer to LEB @FSCK(c)->rebuild->head_lnum, then
+ * set @FSCK(c)->rebuild->head_lnum to '-1'.
+ */
+static int flush_write_buf(struct ubifs_info *c)
+{
+	int len, pad, err;
+
+	if (!FSCK(c)->rebuild->head_offs)
+		return 0;
+
+	len = ALIGN(FSCK(c)->rebuild->head_offs, c->min_io_size);
+	pad = len - FSCK(c)->rebuild->head_offs;
+	if (pad)
+		ubifs_pad(c, FSCK(c)->rebuild->write_buf +
+			  FSCK(c)->rebuild->head_offs, pad);
+
+	err = ubifs_leb_write(c, FSCK(c)->rebuild->head_lnum,
+			      FSCK(c)->rebuild->write_buf, 0, len);
+	if (err)
+		return err;
+
+	FSCK(c)->rebuild->head_lnum = -1;
+
+	return 0;
+}
+
+/**
+ * reserve_space - reserve enough space to write data.
+ * @c: UBIFS file-system description object
+ * @len: the length of written data
+ * @lnum: the write LEB number is returned here
+ * @offs: the write pos in LEB is returned here
+ *
+ * This function finds target position <@lnum, @offs> to write data with
+ * length of @len.
+ */
+static int reserve_space(struct ubifs_info *c, int len, int *lnum, int *offs)
+{
+	int err;
+
+	if (FSCK(c)->rebuild->head_lnum == -1) {
+get_new:
+		err = get_free_leb(c);
+		if (err)
+			return err;
+	}
+
+	if (len > c->leb_size - FSCK(c)->rebuild->head_offs) {
+		err = flush_write_buf(c);
+		if (err)
+			return err;
+
+		goto get_new;
+	}
+
+	*lnum = FSCK(c)->rebuild->head_lnum;
+	*offs = FSCK(c)->rebuild->head_offs;
+	FSCK(c)->rebuild->head_offs += ALIGN(len, 8);
+
+	return 0;
+}
+
+static void copy_node_data(struct ubifs_info *c, void *node, int offs, int len)
+{
+	memcpy(FSCK(c)->rebuild->write_buf + offs, node, len);
+	memset(FSCK(c)->rebuild->write_buf + offs + len, 0xff, ALIGN(len, 8) - len);
+}
+
+/**
+ * create_root - create root dir.
+ * @c: UBIFS file-system description object
+ *
+ * This function creates root dir.
+ */
+static int create_root(struct ubifs_info *c)
+{
+	int err, lnum, offs;
+	struct ubifs_ino_node *ino;
+	struct scanned_file *file;
+
+	ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	if (!ino)
+		return -ENOMEM;
+
+	c->max_sqnum = 0;
+	c->highest_inum = UBIFS_FIRST_INO;
+	init_root_ino(c, ino);
+	err = ubifs_prepare_node_hmac(c, ino, UBIFS_INO_NODE_SZ, -1, 1);
+	if (err)
+		goto out;
+
+	err = reserve_space(c, UBIFS_INO_NODE_SZ, &lnum, &offs);
+	if (err)
+		goto out;
+
+	copy_node_data(c, ino, offs, UBIFS_INO_NODE_SZ);
+
+	err = flush_write_buf(c);
+	if (err)
+		goto out;
+
+	file = kzalloc(sizeof(struct scanned_file), GFP_KERNEL);
+	if (!file) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	file->inum = UBIFS_ROOT_INO;
+	file->dent_nodes = RB_ROOT;
+	file->data_nodes = RB_ROOT;
+	INIT_LIST_HEAD(&file->list);
+
+	file->ino.header.exist = true;
+	file->ino.header.lnum = lnum;
+	file->ino.header.offs = offs;
+	file->ino.header.len = UBIFS_INO_NODE_SZ;
+	file->ino.header.sqnum = le64_to_cpu(ino->ch.sqnum);
+	ino_key_init(c, &file->ino.key, UBIFS_ROOT_INO);
+	file->ino.is_xattr = le32_to_cpu(ino->flags) & UBIFS_XATTR_FL;
+	file->ino.mode = le32_to_cpu(ino->mode);
+	file->calc_nlink = file->ino.nlink = le32_to_cpu(ino->nlink);
+	file->calc_xcnt = file->ino.xcnt = le32_to_cpu(ino->xattr_cnt);
+	file->calc_xsz = file->ino.xsz = le32_to_cpu(ino->xattr_size);
+	file->calc_xnms = file->ino.xnms = le32_to_cpu(ino->xattr_names);
+	file->calc_size = file->ino.size = le64_to_cpu(ino->size);
+
+	rb_link_node(&file->rb, NULL, &FSCK(c)->rebuild->scanned_files.rb_node);
+	rb_insert_color(&file->rb, &FSCK(c)->rebuild->scanned_files);
+
+out:
+	kfree(ino);
+	return err;
+}
+
 static const char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
 {
 	static char name[UBIFS_MAX_NLEN + 1];
@@ -741,9 +941,10 @@ static void record_file_used_lebs(struct ubifs_info *c,
  *
  * This function traverses all nodes from valid files and does following
  * things:
- * 1. Record all used LEBs which may hold useful nodes, then left unused
+ * 1. If there are no scanned files, create default empty filesystem.
+ * 2. Record all used LEBs which may hold useful nodes, then left unused
  *    LEBs could be taken for storing new index tree.
- * 2. Re-write data to prevent failed gc scanning in the subsequent mounting
+ * 3. Re-write data to prevent failed gc scanning in the subsequent mounting
  *    process caused by corrupted data.
  */
 static int traverse_files_and_nodes(struct ubifs_info *c)
@@ -753,6 +954,14 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	struct scanned_file *file;
 	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
 
+	if (rb_first(tree) == NULL) {
+		/* No scanned files. Create root dir. */
+		log_out(c, "No files found, create empty filesystem");
+		err = create_root(c);
+		if (err)
+			return err;
+	}
+
 	log_out(c, "Record used LEBs");
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
-- 
2.13.6


