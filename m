Return-Path: <linux-kernel+bounces-439212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9109EAC59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7481657D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21D2080FA;
	Tue, 10 Dec 2024 09:34:14 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F162080FE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823253; cv=none; b=rzySB759upPuUkra5I9uaR7HXOrksWUltmCNbaVXNoaP8t/ww6kEW3Q0O6bsSA9ZthpCWB0MIXzOLintZGkGmFuMEMlYpKPw45gmEZw+HqexMWqVL+QfaiU5TyxFDrARwMm4Ced72DqLBVqCFyAOU1pk6nqJDTfyQ80MPf3q0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823253; c=relaxed/simple;
	bh=hm6xaqy0QrQUpaxQPDIrAp6Ih60vWvrN039A2BDvyQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvAG4ngqc/mulB+u4AyS79PFU0mK6LFAC2NpLwcB1I3nTAfojYBat9PtFFzEB6dz7RbYpOBGUNaXk+OgkbG80qcC0ifx2lAf4CUSrXxMAvr3x0uukjLiYJwIFojamQRokKU5AK02c7xujleUGlzL6qm/Kco0H1V19Xh1+HE+CCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Y6tpT0KZNzYlTHg;
	Tue, 10 Dec 2024 17:33:53 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Dec
 2024 17:34:04 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Dec
 2024 17:34:03 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <shengyong@oppo.com>
CC: <bintian.wang@honor.com>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, wangzijie <wangzijie1@honor.com>
Subject: [PATCH v2] f2fs-tools: Check and fix inline xattr inplace
Date: Tue, 10 Dec 2024 17:34:02 +0800
Message-ID: <20241210093402.3747909-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a011.hihonor.com
 (10.68.31.243)

Currently when we check xattr of inode which dosen't have xnid, we make unnecessary
memory alloc and copy. Followed by ShengYong's suggestion[1], change the behaviors of
read_all_xattrs and write_all_xattrs, and add a new function free_xattrs.

* read_all_xattrs: If xnid dosen't exist and there's no possibility to alloc xnid in next
   steps, return inline_xattr directly without alloc and memcpy.
* write_all_xattrs checks whether inline_xattr and new txattr_addr have the same address
   to avoid copying back.
* free_xattrs checks whether inline_xattr and new txattr_addr have the same address to
   free xattr buffer properly.

After that, instances(except setxattr) where {read|write}_all_xattrs are called can avoid unnecessary
memory alloc and copy.

Use free_xattrs(xattrs) instead of free(xattrs) to free buffer properly.

[1] https://lore.kernel.org/linux-f2fs-devel/502ae396-ae82-44d6-b08d-617e9e9c4092@oppo.com/

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
v1: https://lore.kernel.org/linux-f2fs-devel/20241204122317.3042137-1-wangzijie1@honor.com/
change since v1:
 - Suggestions from ShengYong to change {read|write}_all_xattrs and add free_xattrs
 - If we may need alloc xnid, still alloc xattr buffer in read_all_xattrs
---
 fsck/dump.c  |  4 ++--
 fsck/fsck.c  |  6 +++---
 fsck/fsck.h  |  3 ++-
 fsck/mount.c |  4 ++--
 fsck/xattr.c | 22 ++++++++++++++++++----
 5 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index dc3c199..cc89909 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -399,7 +399,7 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk, int
 	char xattr_name[F2FS_NAME_LEN] = {0};
 	int ret;
 
-	xattr = read_all_xattrs(sbi, node_blk, true);
+	xattr = read_all_xattrs(sbi, node_blk, true, false);
 	if (!xattr)
 		return;
 
@@ -478,7 +478,7 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk, int
 		free(name);
 	}
 
-	free(xattr);
+	free_xattrs(node_blk, xattr);
 }
 #else
 static void dump_xattr(struct f2fs_sb_info *UNUSED(sbi),
diff --git a/fsck/fsck.c b/fsck/fsck.c
index aa3fb97..982defb 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -844,7 +844,7 @@ int chk_extended_attributes(struct f2fs_sb_info *sbi, u32 nid,
 	if (xattr_size == 0)
 		return 0;
 
-	xattr = read_all_xattrs(sbi, inode, false);
+	xattr = read_all_xattrs(sbi, inode, false, false);
 	ASSERT(xattr);
 
 	last_base_addr = (void *)xattr + xattr_size;
@@ -869,10 +869,10 @@ int chk_extended_attributes(struct f2fs_sb_info *sbi, u32 nid,
 		memset(ent, 0, (u8 *)last_base_addr - (u8 *)ent);
 		write_all_xattrs(sbi, inode, xattr_size, xattr);
 		FIX_MSG("[0x%x] nullify wrong xattr entries", nid);
-		free(xattr);
+		free_xattrs(inode, xattr);
 		return 1;
 	}
-	free(xattr);
+	free_xattrs(inode, xattr);
 	return 0;
 }
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b581d3e..2897a5e 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -341,9 +341,10 @@ struct hardlink_cache_entry *f2fs_search_hardlink(struct f2fs_sb_info *sbi,
 						struct dentry *de);
 
 /* xattr.c */
-void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *, bool);
+void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *, bool, bool);
 void write_all_xattrs(struct f2fs_sb_info *sbi,
 		struct f2fs_node *inode, __u32 hsize, void *txattr_addr);
+void free_xattrs(struct f2fs_node *inode, void *txattr_addr);
 
 /* dir.c */
 int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
diff --git a/fsck/mount.c b/fsck/mount.c
index a189ba7..f6085e9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -370,7 +370,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 	DISP_u32(F2FS_INODE_NIDS(inode), i_nid[3]);	/* indirect */
 	DISP_u32(F2FS_INODE_NIDS(inode), i_nid[4]);	/* double indirect */
 
-	xattr_addr = read_all_xattrs(sbi, node, true);
+	xattr_addr = read_all_xattrs(sbi, node, true, false);
 	if (!xattr_addr)
 		goto out;
 
@@ -384,7 +384,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 		}
 		print_xattr_entry(ent);
 	}
-	free(xattr_addr);
+	free_xattrs(node, xattr_addr);
 
 out:
 	printf("\n");
diff --git a/fsck/xattr.c b/fsck/xattr.c
index 6373c06..3abdcd8 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -18,7 +18,7 @@
 #include "xattr.h"
 
 void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
-			bool sanity_check)
+			bool sanity_check, bool may_alloc_xnid)
 {
 	struct f2fs_xattr_header *header;
 	void *txattr_addr;
@@ -30,6 +30,9 @@ void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
 			return NULL;
 	}
 
+	if (!xnid && !may_alloc_xnid)
+		return inline_xattr_addr(&inode->i);
+
 	txattr_addr = calloc(inline_size + F2FS_BLKSIZE, 1);
 	ASSERT(txattr_addr);
 
@@ -97,7 +100,8 @@ void write_all_xattrs(struct f2fs_sb_info *sbi,
 	bool xattrblk_alloced = false;
 	struct seg_entry *se;
 
-	memcpy(inline_xattr_addr(&inode->i), txattr_addr, inline_size);
+	if (inline_xattr_addr(&inode->i) != txattr_addr)
+		memcpy(inline_xattr_addr(&inode->i), txattr_addr, inline_size);
 
 	if (hsize <= inline_size)
 		return;
@@ -137,6 +141,16 @@ free_xattr_node:
 	ASSERT(ret >= 0);
 }
 
+/*
+ * Different address between inline_xattr and txattr_addr means
+ * we newly allocate xattr buffer in read_all_xattrs, free it
+ */
+void free_xattrs(struct f2fs_node *inode, void *txattr_addr)
+{
+	if (inline_xattr_addr(&inode->i) != txattr_addr)
+		free(txattr_addr);
+}
+
 int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *name,
 		const void *value, size_t size, int flags)
 {
@@ -174,7 +188,7 @@ int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *na
 	ret = dev_read_block(inode, ni.blk_addr);
 	ASSERT(ret >= 0);
 
-	base_addr = read_all_xattrs(sbi, inode, true);
+	base_addr = read_all_xattrs(sbi, inode, true, true);
 	ASSERT(base_addr);
 
 	last_base_addr = (void *)base_addr + XATTR_SIZE(&inode->i);
@@ -257,8 +271,8 @@ int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *na
 	/* inode need update */
 	ASSERT(update_inode(sbi, inode, &ni.blk_addr) >= 0);
 exit:
+	free_xattrs(inode, base_addr);
 	free(inode);
-	free(base_addr);
 	return error;
 }
 
-- 
2.25.1


