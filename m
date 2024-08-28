Return-Path: <linux-kernel+bounces-304856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737AF9625DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0124E1F23108
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3A172BDC;
	Wed, 28 Aug 2024 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wstjfw6T"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90D16CD2A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844013; cv=none; b=mY+XMlK4MmSJZ++yQxymq0BXtelxbA4I8CELncQotKEHmDHCVc8wrOkX90AGBQ/QPyGTMb/JgF5OA36qZxl77T32y4B8IBIIoqZtoduuBYLRBoGzZZQR0vL/pHfsXGcBMr1sETUFvW05ZaYgzxbHpLJE6x+vylMDmR25gryMTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844013; c=relaxed/simple;
	bh=Ezy4HNFGJSTKEsf5HkYKSrv3EXBYHx9iLfOg4sPe8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIcpKGGLDsALyaZid6bh0b+xa7a4kbrt8iZlLizwL9M7zKb6a8Qdjg4bP3ExAqYVf8z81v7mC8OXaSCm+6R+gXCS3avAomwWtMkDCDRqEpeO2FWIUm/5RoRu+y/m/1T1LQC/D4181+AuC3CQ0ztxVy+7dv4o6dAF2stfDhdbYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wstjfw6T; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844006; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9t26X20wOk6RC/v/5buWxmWBy5+YEGCpdhBhX53OLoo=;
	b=wstjfw6TvPHsYeX1Uz69gPMf1pSogUsRkCsYRb/xJ7UzKleuG/srJJCAmsmfKoSLDpJVdiHVRfJKSZ2daVX6W8dDuTF4cya+cD6pRFFrsSQPInR62Z7rhwopjjTs5JToFuaNriaWQUpZP1M644zeBY02vVasZ7WZmFcM/ONzL3o=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDpbUPx_1724844004)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:20:05 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v3 3/3] erofs: apply the page cache share feature
Date: Wed, 28 Aug 2024 19:19:59 +0800
Message-ID: <20240828111959.3677011-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
References: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This modifies relevant functions to apply the page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Reimplement and add support for compressed files.
v2: https://lore.kernel.org/all/20240731080704.678259-3-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
---
 fs/erofs/data.c  | 34 +++++++++++++++++++++++++++++++++-
 fs/erofs/inode.c | 12 ++++++++++++
 fs/erofs/super.c | 29 +++++++++++++++++++++++++++++
 fs/erofs/zdata.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..ef27b934115f 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -347,12 +347,44 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+	int ret;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			folio->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+	ret = iomap_read_folio(folio, &erofs_iomap_ops);
+	if (vi)
+		folio->mapping->host = file_inode(file);
+	return ret;
+#else
 	return iomap_read_folio(folio, &erofs_iomap_ops);
+#endif
 }
-
 static void erofs_readahead(struct readahead_control *rac)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+	struct file *file = rac->file;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			rac->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+	iomap_readahead(rac, &erofs_iomap_ops);
+	if (vi)
+		rac->mapping->host = file_inode(file);
+#else
 	return iomap_readahead(rac, &erofs_iomap_ops);
+#endif
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 43c09aae2afc..1811f73478b4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #include <trace/events/erofs.h>
 
@@ -229,10 +230,21 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		erofs_pcs_fill_inode(inode);
+		if (vi->ano_inode)
+			inode->i_fop = &erofs_pcs_file_fops;
+		else if (erofs_inode_is_data_compressed(vi->datalayout))
+			inode->i_fop = &generic_ro_fops;
+		else
+			inode->i_fop = &erofs_file_fops;
+#else
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
+#endif
+
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 36291feaa5f6..c61779fe2e3a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -12,6 +12,7 @@
 #include <linux/exportfs.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -103,6 +104,12 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
+		iput(vi->ano_inode);
+		vi->ano_inode = NULL;
+	}
+#endif
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -701,6 +708,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	err = erofs_pcs_init_mnt();
+	if (err)
+		return err;
+#endif
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
@@ -811,6 +824,9 @@ static void erofs_kill_sb(struct super_block *sb)
 	else
 		kill_block_super(sb);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	erofs_pcs_free_mnt();
+#endif
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -849,8 +865,21 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	if (inode->i_private) {
+		kfree(inode->i_private);
+		inode->i_private = NULL;
+	}
+}
+#endif
+
 static const struct super_operations erofs_anon_sops = {
 	.statfs	= simple_statfs,
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	.free_inode = erofs_free_anon_inode,
+#endif
 };
 
 static int erofs_anon_init_fs_context(struct fs_context *fc)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..cd3cabfef462 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1802,6 +1802,17 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			folio->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+#endif
 	struct inode *const inode = folio->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1824,11 +1835,27 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (vi)
+		folio->mapping->host = file_inode(file);
+#endif
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+
+	if (rac->file && rac->file->private_data) {
+		vi = rac->file->private_data;
+		if (vi->ano_inode == file_inode(rac->file))
+			rac->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+#endif
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1863,6 +1890,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (vi)
+		rac->mapping->host = file_inode(rac->file);
+#endif
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.43.5


