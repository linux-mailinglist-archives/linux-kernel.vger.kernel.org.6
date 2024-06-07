Return-Path: <linux-kernel+bounces-205375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C444C8FFAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2ACB24454
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089916C848;
	Fri,  7 Jun 2024 04:28:09 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07816C841
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734488; cv=none; b=O7asb9u+Pgz5b5Zy0B5bA4mzhTQstX6g0PCx8Hmfg+Z0tS3g53G5I5jLBQx6LyCrzu96lv2z75tFBs9wRKLSWZQVaQ2jd9NDP2st7Ai3qVo6CJqaNTRQXS4Az7lUDivaIXTYjh527N7n41BsDZEDzH0oS0/qkLiPniAnqJF/Mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734488; c=relaxed/simple;
	bh=sr1vdkK3Wu7aWyzKV1eenYPsp4OoaLXN8fu/9tnV9WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpVAJV6LwkGamMAMsQ60i2h8J3puGZ+SkmPZZ09+Wfw1J3X+xyyWgOByd8DINBLmCwOQGXZggChZ8cPhdX6qgg1nPpRRCyVivuh8M7ETE4J7RD4CTj+/h7VbemSezyvogQCegZ05KvYk0dgY9eGnPsMD4oB9H5N9ZwtEpNL6HoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSlc4mbkzPpnQ;
	Fri,  7 Jun 2024 12:24:44 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id F1F98140336;
	Fri,  7 Jun 2024 12:27:48 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:35 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 093/110] ubifs-utils: libubifs: Support some file operations
Date: Fri, 7 Jun 2024 12:25:58 +0800
Message-ID: <20240607042615.2069840-94-chengzhihao1@huawei.com>
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

Add some file operations, such as ubifs_lookup, ubifs_mkdir, etc., this
is a preparation for recovering disconnected files or root dir in fsck.
File writing operations are based on the journal subsystem, generated
dirty data depends on a new commit in subsequent steps to update disk
content.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/linux_types.h    |   3 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c |   2 -
 ubifs-utils/libubifs/dir.c          | 359 ++++++++++++++++++++++++++++++++++++
 ubifs-utils/libubifs/journal.c      | 194 +++++++++++++++++++
 ubifs-utils/libubifs/misc.h         |   9 +
 ubifs-utils/libubifs/ubifs.h        |  45 +++++
 6 files changed, 610 insertions(+), 2 deletions(-)

diff --git a/ubifs-utils/common/linux_types.h b/ubifs-utils/common/linux_types.h
index 556b2e25..ebf9ecde 100644
--- a/ubifs-utils/common/linux_types.h
+++ b/ubifs-utils/common/linux_types.h
@@ -28,6 +28,9 @@ struct fscrypt_name {
 #define fname_name(p)	((p)->disk_name.name)
 #define fname_len(p)	((p)->disk_name.len)
 
+#define S_IRUGO		(S_IRUSR|S_IRGRP|S_IROTH)
+#define S_IXUGO		(S_IXUSR|S_IXGRP|S_IXOTH)
+
 #define t16(x) ({ \
 	uint16_t __b = (x); \
 	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_16(__b); \
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index e65d655d..b82d7282 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -707,8 +707,6 @@ static void extract_dentry_tree(struct ubifs_info *c)
 
 static void init_root_ino(struct ubifs_info *c, struct ubifs_ino_node *ino)
 {
-#define S_IRUGO		(S_IRUSR|S_IRGRP|S_IROTH)
-#define S_IXUGO		(S_IXUSR|S_IXGRP|S_IXOTH)
 	__le64 tmp_le64;
 
 	/* Create default root inode */
diff --git a/ubifs-utils/libubifs/dir.c b/ubifs-utils/libubifs/dir.c
index 9d5f6446..89f77ebc 100644
--- a/ubifs-utils/libubifs/dir.c
+++ b/ubifs-utils/libubifs/dir.c
@@ -28,4 +28,363 @@
  * write it, but just marks it as dirty.
  */
 
+#include <sys/stat.h>
+
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
+
+/**
+ * inherit_flags - inherit flags of the parent inode.
+ * @c: UBIFS file-system description object
+ * @dir: parent inode
+ * @mode: new inode mode flags
+ *
+ * This is a helper function for 'ubifs_new_inode()' which inherits flag of the
+ * parent directory inode @dir. UBIFS inodes inherit the following flags:
+ * o %UBIFS_COMPR_FL, which is useful to switch compression on/of on
+ *   sub-directory basis;
+ * o %UBIFS_SYNC_FL - useful for the same reasons;
+ * o %UBIFS_DIRSYNC_FL - similar, but relevant only to directories.
+ *
+ * This function returns the inherited flags.
+ */
+static int inherit_flags(struct ubifs_info *c, const struct inode *dir,
+			 unsigned int mode)
+{
+	int flags;
+	const struct ubifs_inode *ui = ubifs_inode(dir);
+
+	ubifs_assert(c, S_ISDIR(dir->mode));
+
+	flags = ui->flags & (UBIFS_COMPR_FL | UBIFS_SYNC_FL | UBIFS_DIRSYNC_FL);
+	if (!S_ISDIR(mode))
+		/* The "DIRSYNC" flag only applies to directories */
+		flags &= ~UBIFS_DIRSYNC_FL;
+	return flags;
+}
+
+/**
+ * ubifs_new_inode - allocate new UBIFS inode object.
+ * @c: UBIFS file-system description object
+ * @dir: parent inode
+ * @mode: inode mode flags
+ *
+ * This function finds an unused inode number, allocates new ubifs inode and
+ * initializes it. Returns new ubifs inode in case of success and an error code
+ * in case of failure.
+ */
+static struct ubifs_inode *ubifs_new_inode(struct ubifs_info *c,
+					   const struct inode *dir,
+					   unsigned int mode)
+{
+	int err;
+	time_t now = time(NULL);
+	struct ubifs_inode *ui;
+	struct inode *inode;
+
+	ui = kzalloc(sizeof(struct ubifs_inode), GFP_KERNEL);
+	if (!ui)
+		return ERR_PTR(-ENOMEM);
+
+	inode = &ui->vfs_inode;
+	inode->atime_sec = inode->ctime_sec = inode->mtime_sec = now;
+	inode->nlink = 1;
+	inode->mode = mode;
+	if (dir) {
+		/* Create non root dir. */
+		inode->uid = dir->uid;
+		inode->gid = dir->gid;
+		if ((dir->mode & S_ISGID) && S_ISDIR(mode))
+			inode->mode |= S_ISGID;
+		ui->flags = inherit_flags(c, dir, mode);
+	}
+	if (S_ISDIR(mode))
+		ui->ui_size = UBIFS_INO_NODE_SZ;
+	if (S_ISREG(mode))
+		ui->compr_type = c->default_compr;
+	else
+		ui->compr_type = UBIFS_COMPR_NONE;
+
+	if (dir) {
+		spin_lock(&c->cnt_lock);
+		/* Inode number overflow is currently not supported */
+		if (c->highest_inum >= INUM_WARN_WATERMARK) {
+			if (c->highest_inum >= INUM_WATERMARK) {
+				spin_unlock(&c->cnt_lock);
+				ubifs_err(c, "out of inode numbers");
+				err = -EINVAL;
+				goto out;
+			}
+			ubifs_warn(c, "running out of inode numbers (current %lu, max %u)",
+				   (unsigned long)c->highest_inum, INUM_WATERMARK);
+		}
+		inode->inum = ++c->highest_inum;
+	} else {
+		/* Create root dir. */
+		inode->inum = UBIFS_ROOT_INO;
+	}
+	/*
+	 * The creation sequence number remains with this inode for its
+	 * lifetime. All nodes for this inode have a greater sequence number,
+	 * and so it is possible to distinguish obsolete nodes belonging to a
+	 * previous incarnation of the same inode number - for example, for the
+	 * purpose of rebuilding the index.
+	 */
+	ui->creat_sqnum = ++c->max_sqnum;
+	spin_unlock(&c->cnt_lock);
+
+	return ui;
+
+out:
+	kfree(ui);
+	return ERR_PTR(err);
+}
+
+/**
+ * ubifs_lookup_by_inum - look up the UBIFS inode according to inode number.
+ * @c: UBIFS file-system description object
+ * @inum: inode number
+ *
+ * This function looks up the UBIFS inode according to a given inode number.
+ * Returns zero in case of success and an error code in case of failure.
+ */
+struct ubifs_inode *ubifs_lookup_by_inum(struct ubifs_info *c, ino_t inum)
+{
+	int err;
+	union ubifs_key key;
+	struct inode *inode;
+	struct ubifs_inode *ui;
+	struct ubifs_ino_node *ino = NULL;
+
+	ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
+	if (!ino)
+		return ERR_PTR(-ENOMEM);
+
+	ui = kzalloc(sizeof(struct ubifs_inode), GFP_KERNEL);
+	if (!ui) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	inode = &ui->vfs_inode;
+	ino_key_init(c, &key, inum);
+	err = ubifs_tnc_lookup(c, &key, ino);
+	if (err) {
+		kfree(ui);
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		goto out;
+	}
+
+	inode = &ui->vfs_inode;
+	inode->inum = inum;
+	inode->uid = le32_to_cpu(ino->uid);
+	inode->gid = le32_to_cpu(ino->gid);
+	inode->mode = le32_to_cpu(ino->mode);
+	inode->nlink = le32_to_cpu(ino->nlink);
+	inode->atime_sec = le64_to_cpu(ino->atime_sec);
+	inode->ctime_sec = le64_to_cpu(ino->ctime_sec);
+	inode->mtime_sec = le64_to_cpu(ino->mtime_sec);
+	inode->atime_nsec = le32_to_cpu(ino->atime_nsec);
+	inode->ctime_nsec = le32_to_cpu(ino->ctime_nsec);
+	inode->mtime_nsec = le32_to_cpu(ino->mtime_nsec);
+	ui->creat_sqnum = le64_to_cpu(ino->creat_sqnum);
+	ui->xattr_size = le32_to_cpu(ino->xattr_size);
+	ui->xattr_cnt = le32_to_cpu(ino->xattr_cnt);
+	ui->xattr_names = le32_to_cpu(ino->xattr_names);
+	ui->compr_type = le16_to_cpu(ino->compr_type);
+	ui->ui_size = le64_to_cpu(ino->size);
+	ui->flags = le32_to_cpu(ino->flags);
+	ui->data_len = le32_to_cpu(ino->data_len);
+
+out:
+	kfree(ino);
+	return err ? ERR_PTR(err) : ui;
+}
+
+struct ubifs_inode *ubifs_lookup(struct ubifs_info *c,
+				 struct ubifs_inode *dir_ui,
+				 const struct fscrypt_name *nm)
+{
+	int err;
+	ino_t inum;
+	union ubifs_key key;
+	struct ubifs_dent_node *dent;
+
+	if (fname_len(nm) > UBIFS_MAX_NLEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	dent = kmalloc(UBIFS_MAX_DENT_NODE_SZ, GFP_NOFS);
+	if (!dent)
+		return ERR_PTR(-ENOMEM);
+
+	dent_key_init(c, &key, dir_ui->vfs_inode.inum, nm);
+	err = ubifs_tnc_lookup_nm(c, &key, dent, nm);
+	if (err) {
+		kfree(dent);
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		return ERR_PTR(err);
+	}
+	inum = le64_to_cpu(dent->inum);
+	kfree(dent);
+
+	return ubifs_lookup_by_inum(c, inum);
+}
+
+int ubifs_mkdir(struct ubifs_info *c, struct ubifs_inode *dir_ui,
+		const struct fscrypt_name *nm, unsigned int mode)
+{
+	struct ubifs_inode *ui;
+	struct inode *inode, *dir = &dir_ui->vfs_inode;
+	int err, sz_change;
+	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
+					.dirtied_ino = 1};
+	/*
+	 * Budget request settings: new inode, new direntry and changing parent
+	 * directory inode.
+	 */
+	dbg_gen("dent '%s', mode %#hx in dir ino %lu",
+		fname_name(nm), mode, dir->inum);
+
+	/* New dir is not allowed to be created under an encrypted directory. */
+	ubifs_assert(c, !(dir_ui->flags & UBIFS_CRYPT_FL));
+
+	err = ubifs_budget_space(c, &req);
+	if (err)
+		return err;
+
+	sz_change = CALC_DENT_SIZE(fname_len(nm));
+
+	ui = ubifs_new_inode(c, dir, S_IFDIR | mode);
+	if (IS_ERR(ui)) {
+		err = PTR_ERR(ui);
+		goto out_budg;
+	}
+
+	inode = &ui->vfs_inode;
+	inode->nlink++;
+	dir->nlink++;
+	dir_ui->ui_size += sz_change;
+	dir->ctime_sec = dir->mtime_sec = inode->ctime_sec;
+	err = ubifs_jnl_update_file(c, dir_ui, nm, ui);
+	if (err) {
+		ubifs_err(c, "cannot create directory, error %d", err);
+		goto out_cancel;
+	}
+
+	kfree(ui);
+	ubifs_release_budget(c, &req);
+	return 0;
+
+out_cancel:
+	dir_ui->ui_size -= sz_change;
+	dir->nlink--;
+	kfree(ui);
+out_budg:
+	ubifs_release_budget(c, &req);
+	return err;
+}
+
+/**
+ * ubifs_link_recovery - link a disconnected file into the target directory.
+ * @c: UBIFS file-system description object
+ * @dir_ui: target directory
+ * @ui: the UBIFS inode of disconnected file
+ * @nm: directory entry name
+ *
+ * This function links the inode of disconnected file to a directory entry name
+ * under the target directory. Returns zero in case of success and an error code
+ * in case of failure.
+ */
+int ubifs_link_recovery(struct ubifs_info *c, struct ubifs_inode *dir_ui,
+			struct ubifs_inode *ui, const struct fscrypt_name *nm)
+{
+	struct inode *inode = &ui->vfs_inode, *dir = &dir_ui->vfs_inode;
+	int err, sz_change;
+	struct ubifs_budget_req req = { .new_dent = 1, .dirtied_ino = 2,
+				.dirtied_ino_d = ALIGN(ui->data_len, 8) };
+	time_t now = time(NULL);
+
+	/*
+	 * Budget request settings: new direntry, changing the target inode,
+	 * changing the parent inode.
+	 */
+	dbg_gen("dent '%s' to ino %lu (nlink %d) in dir ino %lu",
+		fname_name(nm), inode->inum, inode->nlink, dir->inum);
+
+	/* New dir is not allowed to be created under an encrypted directory. */
+	ubifs_assert(c, !(dir_ui->flags & UBIFS_CRYPT_FL));
+
+	sz_change = CALC_DENT_SIZE(fname_len(nm));
+
+	err = ubifs_budget_space(c, &req);
+	if (err)
+		return err;
+
+	inode->ctime_sec = now;
+	dir_ui->ui_size += sz_change;
+	dir->ctime_sec = dir->mtime_sec = now;
+	err = ubifs_jnl_update_file(c, dir_ui, nm, ui);
+	if (err)
+		goto out_cancel;
+
+	ubifs_release_budget(c, &req);
+	return 0;
+
+out_cancel:
+	dir_ui->ui_size -= sz_change;
+	ubifs_release_budget(c, &req);
+	return err;
+}
+
+/**
+ * ubifs_create_root - create the root inode.
+ * @c: UBIFS file-system description object
+ *
+ * This function creates a new inode for the root directory. Returns zero in
+ * case of success and an error code in case of failure.
+ */
+int ubifs_create_root(struct ubifs_info *c)
+{
+	int err;
+	struct inode *inode;
+	struct ubifs_budget_req req = { .new_ino = 1 };
+	struct ubifs_inode *ui;
+
+	/* Budget request settings: new inode. */
+	dbg_gen("create root dir");
+
+	err = ubifs_budget_space(c, &req);
+	if (err)
+		return err;
+
+	ui = ubifs_new_inode(c, NULL, S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
+	if (IS_ERR(ui)) {
+		err = PTR_ERR(ui);
+		goto out_budg;
+	}
+
+	inode = &ui->vfs_inode;
+	inode->nlink = 2;
+	ui->ui_size = UBIFS_INO_NODE_SZ;
+	ui->flags = UBIFS_COMPR_FL;
+	err = ubifs_jnl_update_file(c, NULL, NULL, ui);
+	if (err)
+		goto out_ui;
+
+	kfree(ui);
+	ubifs_release_budget(c, &req);
+	return 0;
+
+out_ui:
+	kfree(ui);
+out_budg:
+	ubifs_release_budget(c, &req);
+	ubifs_err(c, "cannot create root dir, error %d", err);
+	return err;
+}
diff --git a/ubifs-utils/libubifs/journal.c b/ubifs-utils/libubifs/journal.c
index d3fdb76a..e78ea14f 100644
--- a/ubifs-utils/libubifs/journal.c
+++ b/ubifs-utils/libubifs/journal.c
@@ -47,9 +47,11 @@
  */
 
 #include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
 #include "defs.h"
 #include "debug.h"
+#include "key.h"
 #include "misc.h"
 
 /**
@@ -437,3 +439,195 @@ static void set_dent_cookie(struct ubifs_info *c, struct ubifs_dent_node *dent)
 	else
 		dent->cookie = 0;
 }
+
+/**
+ * pack_inode - pack an ubifs inode node.
+ * @c: UBIFS file-system description object
+ * @ino: buffer in which to pack inode node
+ * @ui: ubifs inode to pack
+ * @last: indicates the last node of the group
+ */
+static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
+		       const struct ubifs_inode *ui, int last)
+{
+	const struct inode *inode = &ui->vfs_inode;
+	int data_len = 0, last_reference = !inode->nlink;
+
+	ino->ch.node_type = UBIFS_INO_NODE;
+	ino_key_init_flash(c, &ino->key, inode->inum);
+	ino->creat_sqnum = cpu_to_le64(ui->creat_sqnum);
+	ino->atime_sec  = cpu_to_le64(inode->atime_sec);
+	ino->atime_nsec = cpu_to_le32(inode->atime_nsec);
+	ino->ctime_sec  = cpu_to_le64(inode->ctime_sec);
+	ino->ctime_nsec = cpu_to_le32(inode->ctime_nsec);
+	ino->mtime_sec  = cpu_to_le64(inode->mtime_sec);
+	ino->mtime_nsec = cpu_to_le32(inode->mtime_nsec);
+	ino->uid   = cpu_to_le32(inode->uid);
+	ino->gid   = cpu_to_le32(inode->gid);
+	ino->mode  = cpu_to_le32(inode->mode);
+	ino->flags = cpu_to_le32(ui->flags);
+	ino->size  = cpu_to_le64(ui->ui_size);
+	ino->nlink = cpu_to_le32(inode->nlink);
+	ino->compr_type  = cpu_to_le16(ui->compr_type);
+	ino->data_len    = cpu_to_le32(ui->data_len);
+	ino->xattr_cnt   = cpu_to_le32(ui->xattr_cnt);
+	ino->xattr_size  = cpu_to_le32(ui->xattr_size);
+	ino->xattr_names = cpu_to_le32(ui->xattr_names);
+	zero_ino_node_unused(ino);
+
+	/*
+	 * Drop the attached data if this is a deletion inode, the data is not
+	 * needed anymore.
+	 */
+	if (!last_reference) {
+		memcpy(ino->data, ui->data, ui->data_len);
+		data_len = ui->data_len;
+	}
+
+	ubifs_prep_grp_node(c, ino, UBIFS_INO_NODE_SZ + data_len, last);
+}
+
+/**
+ * ubifs_jnl_update_file - update file.
+ * @c: UBIFS file-system description object
+ * @dir_ui: parent ubifs inode
+ * @nm: directory entry name
+ * @ui: ubifs inode to update
+ *
+ * This function updates an file by writing a directory entry node, the inode
+ * node itself, and the parent directory inode node to the journal. If the
+ * @dir_ui and @nm are NULL, only update @ui.
+ *
+ * Returns zero on success. In case of failure, a negative error code is
+ * returned.
+ */
+int ubifs_jnl_update_file(struct ubifs_info *c,
+			  const struct ubifs_inode *dir_ui,
+			  const struct fscrypt_name *nm,
+			  const struct ubifs_inode *ui)
+{
+	const struct inode *dir = NULL, *inode = &ui->vfs_inode;
+	int err, dlen, ilen, len, lnum, ino_offs, dent_offs, dir_ilen;
+	int aligned_dlen, aligned_ilen;
+	struct ubifs_dent_node *dent;
+	struct ubifs_ino_node *ino;
+	union ubifs_key dent_key, ino_key;
+	u8 hash_dent[UBIFS_HASH_ARR_SZ];
+	u8 hash_ino[UBIFS_HASH_ARR_SZ];
+	u8 hash_ino_dir[UBIFS_HASH_ARR_SZ];
+
+	ubifs_assert(c, (!nm && !dir_ui) || (nm && dir_ui));
+	ubifs_assert(c, inode->nlink != 0);
+
+	ilen = UBIFS_INO_NODE_SZ + ui->data_len;
+
+	if (nm)
+		dlen = UBIFS_DENT_NODE_SZ + fname_len(nm) + 1;
+	else
+		dlen = 0;
+
+	if (dir_ui) {
+		dir = &dir_ui->vfs_inode;
+		ubifs_assert(c, dir->nlink != 0);
+		dir_ilen = UBIFS_INO_NODE_SZ + dir_ui->data_len;
+	} else
+		dir_ilen = 0;
+
+	aligned_dlen = ALIGN(dlen, 8);
+	aligned_ilen = ALIGN(ilen, 8);
+	len = aligned_dlen + aligned_ilen + dir_ilen;
+	if (ubifs_authenticated(c))
+		len += ALIGN(dir_ilen, 8) + ubifs_auth_node_sz(c);
+
+	dent = kzalloc(len, GFP_NOFS);
+	if (!dent)
+		return -ENOMEM;
+
+	/* Make reservation before allocating sequence numbers */
+	err = make_reservation(c, BASEHD, len);
+	if (err)
+		goto out_free;
+
+	if (nm) {
+		dent->ch.node_type = UBIFS_DENT_NODE;
+		dent_key_init(c, &dent_key, dir->inum, nm);
+
+		key_write(c, &dent_key, dent->key);
+		dent->inum = cpu_to_le64(inode->inum);
+		dent->type = ubifs_get_dent_type(inode->mode);
+		dent->nlen = cpu_to_le16(fname_len(nm));
+		memcpy(dent->name, fname_name(nm), fname_len(nm));
+		dent->name[fname_len(nm)] = '\0';
+		set_dent_cookie(c, dent);
+
+		zero_dent_node_unused(dent);
+		ubifs_prep_grp_node(c, dent, dlen, 0);
+		err = ubifs_node_calc_hash(c, dent, hash_dent);
+		if (err)
+			goto out_release;
+	}
+
+	ino = (void *)dent + aligned_dlen;
+	pack_inode(c, ino, ui, dir_ui == NULL ? 1 : 0);
+	err = ubifs_node_calc_hash(c, ino, hash_ino);
+	if (err)
+		goto out_release;
+
+	if (dir_ui) {
+		ino = (void *)ino + aligned_ilen;
+		pack_inode(c, ino, dir_ui, 1);
+		err = ubifs_node_calc_hash(c, ino, hash_ino_dir);
+		if (err)
+			goto out_release;
+	}
+
+	err = write_head(c, BASEHD, dent, len, &lnum, &dent_offs, 0);
+	if (err)
+		goto out_release;
+	release_head(c, BASEHD);
+	kfree(dent);
+	ubifs_add_auth_dirt(c, lnum);
+
+	if (nm) {
+		err = ubifs_tnc_add_nm(c, &dent_key, lnum, dent_offs, dlen,
+				       hash_dent, nm);
+		if (err) {
+			ubifs_assert(c, !get_failure_reason_callback(c));
+			goto out_ro;
+		}
+	}
+
+	ino_key_init(c, &ino_key, inode->inum);
+	ino_offs = dent_offs + aligned_dlen;
+	err = ubifs_tnc_add(c, &ino_key, lnum, ino_offs, ilen, hash_ino);
+	if (err) {
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		goto out_ro;
+	}
+
+	if (dir_ui) {
+		ino_key_init(c, &ino_key, dir->inum);
+		ino_offs += aligned_ilen;
+		err = ubifs_tnc_add(c, &ino_key, lnum, ino_offs, dir_ilen,
+				    hash_ino_dir);
+		if (err) {
+			ubifs_assert(c, !get_failure_reason_callback(c));
+			goto out_ro;
+		}
+	}
+
+	finish_reservation(c);
+	return 0;
+
+out_free:
+	kfree(dent);
+	return err;
+
+out_release:
+	release_head(c, BASEHD);
+	kfree(dent);
+out_ro:
+	ubifs_ro_mode(c, err);
+	finish_reservation(c);
+	return err;
+}
diff --git a/ubifs-utils/libubifs/misc.h b/ubifs-utils/libubifs/misc.h
index 4b718068..1b4404f3 100644
--- a/ubifs-utils/libubifs/misc.h
+++ b/ubifs-utils/libubifs/misc.h
@@ -70,6 +70,15 @@ ubifs_tnc_find_child(struct ubifs_znode *znode, int start)
 }
 
 /**
+ * ubifs_inode - get UBIFS inode information by VFS 'struct inode' object.
+ * @inode: the VFS 'struct inode' pointer
+ */
+static inline struct ubifs_inode *ubifs_inode(const struct inode *inode)
+{
+	return container_of(inode, struct ubifs_inode, vfs_inode);
+}
+
+/**
  * ubifs_wbuf_sync - synchronize write-buffer.
  * @wbuf: write-buffer to synchronize
  *
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index a4b05a66..0908a228 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -262,7 +262,36 @@ struct ubifs_gced_idx_leb {
 };
 
 /**
+ * struct inode - inode description.
+ * @uid: owner ID
+ * @gid: group ID
+ * @mode: access flags
+ * @nlink: number of hard links
+ * @inum: inode number
+ * @atime_sec: access time seconds
+ * @ctime_sec: creation time seconds
+ * @mtime_sec: modification time seconds
+ * @atime_nsec: access time nanoseconds
+ * @ctime_nsec: creation time nanoseconds
+ * @mtime_nsec: modification time nanoseconds
+ */
+struct inode {
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int mode;
+	unsigned int nlink;
+	ino_t inum;
+	unsigned long long atime_sec;
+	unsigned long long ctime_sec;
+	unsigned long long mtime_sec;
+	unsigned int atime_nsec;
+	unsigned int ctime_nsec;
+	unsigned int mtime_nsec;
+};
+
+/**
  * struct ubifs_inode - UBIFS in-memory inode description.
+ * @vfs_inode: VFS inode description object
  * @creat_sqnum: sequence number at time of creation
  * @xattr_size: summarized size of all extended attributes in bytes
  * @xattr_cnt: count of extended attributes this inode has
@@ -275,6 +304,7 @@ struct ubifs_gced_idx_leb {
  * @data: inode's data
  */
 struct ubifs_inode {
+	struct inode vfs_inode;
 	unsigned long long creat_sqnum;
 	unsigned int xattr_size;
 	unsigned int xattr_cnt;
@@ -1640,6 +1670,10 @@ int ubifs_consolidate_log(struct ubifs_info *c);
 
 /* journal.c */
 int ubifs_get_dent_type(int mode);
+int ubifs_jnl_update_file(struct ubifs_info *c,
+			  const struct ubifs_inode *dir_ui,
+			  const struct fscrypt_name *nm,
+			  const struct ubifs_inode *ui);
 
 /* budget.c */
 int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req);
@@ -1823,6 +1857,17 @@ const struct ubifs_lprops *ubifs_fast_find_freeable(struct ubifs_info *c);
 const struct ubifs_lprops *ubifs_fast_find_frdi_idx(struct ubifs_info *c);
 int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 
+/* dir.c */
+struct ubifs_inode *ubifs_lookup_by_inum(struct ubifs_info *c, ino_t inum);
+struct ubifs_inode *ubifs_lookup(struct ubifs_info *c,
+				 struct ubifs_inode *dir_ui,
+				 const struct fscrypt_name *nm);
+int ubifs_mkdir(struct ubifs_info *c, struct ubifs_inode *dir_ui,
+		const struct fscrypt_name *nm, unsigned int mode);
+int ubifs_link_recovery(struct ubifs_info *c, struct ubifs_inode *dir_ui,
+			struct ubifs_inode *ui, const struct fscrypt_name *nm);
+int ubifs_create_root(struct ubifs_info *c);
+
 /* super.c */
 int open_ubi(struct ubifs_info *c, const char *node);
 void close_ubi(struct ubifs_info *c);
-- 
2.13.6


