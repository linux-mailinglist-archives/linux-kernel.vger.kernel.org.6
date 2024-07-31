Return-Path: <linux-kernel+bounces-268749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8469428D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A24FB22500
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA541A8BE3;
	Wed, 31 Jul 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t/RxFkd0"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4531A7F83
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413259; cv=none; b=tUFRevHObpDIkkF0pN44DrC8yaGifiyToeQCwaI7Uju3Nts5SxstR2QL+fIIHI5/dKSiOza3AKdTl8/dBg/dCA3UNS7hL7/SZhET3Wjks3yX9JS/gYNUYOelTDBKzdV9mWZ+kSz9gRnSPBYVWPNZ8loIVh3AfWfIKpvf2vYzGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413259; c=relaxed/simple;
	bh=sJSne7FvUaCGqRE++yqsmdYIUgUzrbYV/gqTygAMAkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS0Loq4N1mOrRakplcx7K7wZuIA+MLJuJPIUS0nkF5h69zR6L2Alciu3AxBvNexppZmTVa8wmxhp+rbHDKra0ILl+UT4idNC7fw02LVIOA9UN5bbOpJ0KXRWVkU/tArs/8dXlsCMZI4z/VPHrZSu9f01aDUybtpSsHQHx91CFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t/RxFkd0; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722413248; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DSxArOXpMYYo5QvLWFHxWEb/Rcp06yq06zBpX4yplY0=;
	b=t/RxFkd03KWda9R0qUqgPt4yADXslPTVVdoZOFPnK0cTaZbbLP34T5qevcybkov1b7wCYAvXMfgpMUkFfy6aeJ5/hrzgasw/R8bLq5Va0LfveAXUYeNht4uLC0vJTAxjAFuxDLMhMa9DFrsLzLojNyM+KFwrgQCg0jgqxliuY44=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WBikPVL_1722413247;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBikPVL_1722413247)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 16:07:28 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
Date: Wed, 31 Jul 2024 16:07:04 +0800
Message-ID: <20240731080704.678259-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
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
v2: Make adjustments based on the latest implementation.
v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
---
 fs/erofs/inode.c | 23 +++++++++++++++++++++++
 fs/erofs/super.c | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..9f1e7332cff9 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #include <trace/events/erofs.h>
 
@@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		erofs_pcs_fill_inode(inode);
+#endif
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		else {
+			if (vi->fprt_len > 0)
+				inode->i_fop = &erofs_pcs_file_fops;
+			else
+				inode->i_fop = &erofs_file_fops;
+		}
+#else
 		else
 			inode->i_fop = &erofs_file_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
@@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 			return ERR_PTR(err);
 		}
 		unlock_new_inode(inode);
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		if ((inode->i_mode & S_IFMT) == S_IFREG &&
+		    EROFS_I(inode)->fprt_len > 0) {
+			err = erofs_pcs_add(inode);
+			if (err) {
+				iget_failed(inode);
+				return ERR_PTR(err);
+			}
+		}
+#endif
 	}
 	return inode;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 35268263aaed..a42e65ef7fc7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
 
 	/* zero out everything except vfs_inode */
 	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	INIT_LIST_HEAD(&vi->pcs_list);
+	init_rwsem(&vi->pcs_rwsem);
+#endif
 	return &vi->vfs_inode;
 }
 
@@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+static void erofs_destroy_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	if ((inode->i_mode & S_IFMT) == S_IFREG &&
+	    EROFS_I(inode)->fprt_len > 0) {
+		if (erofs_pcs_remove(inode))
+			erofs_err(inode->i_sb, "pcs: fail to remove inode.");
+		kfree(vi->fprt);
+		vi->fprt = NULL;
+	}
+}
+#endif
+
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *dsb)
 {
@@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = erofs_alloc_inode,
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	.destroy_inode = erofs_destroy_inode,
+#endif
 	.free_inode = erofs_free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
-- 
2.43.5


