Return-Path: <linux-kernel+bounces-563370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B804BA64021
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DD188BE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA671DF990;
	Mon, 17 Mar 2025 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EQJ371sv"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8818C33B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190538; cv=none; b=LXvCjsmgfkU3g7WC+Nana7A7GC6j6i2VyLdfbUflYh6GGvkxHpG3BiGVkeuu932BtKfv/6sK8IyCbw9O07ShTvSN0UBQADJYmDUcMC5MG8gK4bBP/ig6iO1F1Bd2Y1fwZkp9me/YDCBTu5SSFJUJsniX1mV5b2VCv4ujoWczHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190538; c=relaxed/simple;
	bh=JVm2I3eEVcuOd8f4J14oDousZLERFkd8o1n+DJN43H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWjdJRqQt7s2R/Evo69KrFD7y6dG1PLaeVE30IUSj8UougzpzDbxqtKtotpnNtGn6E7rtUCJXQ0BGS3K/GG+Ccpk7/etxBffOtJy6dTd72ZKj2pju9g/Rc+QDMLcXYVE2OobqtYhRTAfFVt76bQaYN5kdKwZVakjD5acaiX3APY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EQJ371sv; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742190526; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JH/MtI7nWIdLEx6Tsg9Uphc5JkLI9ry7g3+yzUJaGuM=;
	b=EQJ371svYla0nD1EcG6fAVGDO4NRzAiFhzBAkMvSf//CD/1qKd74kVyZXV+Wrn3lJDJsrvBUOKrOkkjEbSWuBJHMTgAXN1UY1mQmZTxKmJ7uUNsoCKbofuDcSW0wVQ2JNKAR7zIXxdyfmSUE41v/6/KFyP0JyKRkiYPXxZfGhWg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRZQaGx_1742190521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 13:48:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 06/10] erofs: initialize decompression early
Date: Mon, 17 Mar 2025 13:48:40 +0800
Message-ID: <20250317054840.3483000-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250316170729.2325406-1-hsiangkao@linux.alibaba.com>
References: <20250316170729.2325406-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Rename erofs_init_managed_cache() to z_erofs_init_super();
 - Move the initialization of managed_pslots into z_erofs_init_super() too;
 - Move z_erofs_init_super() and packed inode preparation upwards, before
   the root inode initialization.

Therefore, the root directory can also be compressible.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Acked-by: Chao Yu <chao@kernel.org>
---
v3:
 - should handle both .put_super() and .kill_sb(), otherwise VFS will
   report "VFS: Busy inodes after unmount of ..."

 fs/erofs/internal.h |  4 ++--
 fs/erofs/super.c    | 46 ++++++++++++++++++++++-----------------------
 fs/erofs/zdata.c    |  4 ++--
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 91d0b400459c..b35742cf9431 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -436,6 +436,7 @@ int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
+int z_erofs_init_super(struct super_block *sb);
 unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
@@ -445,7 +446,6 @@ void z_erofs_put_gbuf(void *ptr);
 int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
-int erofs_init_managed_cache(struct super_block *sb);
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
@@ -454,7 +454,7 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
-static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
+static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 18445dc8597d..563da5213032 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -636,9 +636,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-#ifdef CONFIG_EROFS_FS_ZIP
-	xa_init(&sbi->managed_pslots);
-#endif
+	err = z_erofs_init_super(sb);
+	if (err)
+		return err;
+
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
+		inode = erofs_iget(sb, sbi->packed_nid);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+		sbi->packed_inode = inode;
+	}
 
 	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
@@ -650,24 +657,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		iput(inode);
 		return -EINVAL;
 	}
-
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		return -ENOMEM;
 
 	erofs_shrinker_register(sb);
-	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
-		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
-		if (IS_ERR(sbi->packed_inode)) {
-			err = PTR_ERR(sbi->packed_inode);
-			sbi->packed_inode = NULL;
-			return err;
-		}
-	}
-	err = erofs_init_managed_cache(sb);
-	if (err)
-		return err;
-
 	err = erofs_xattr_prefixes_init(sb);
 	if (err)
 		return err;
@@ -803,6 +797,16 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void erofs_drop_internal_inodes(struct erofs_sb_info *sbi)
+{
+	iput(sbi->packed_inode);
+	sbi->packed_inode = NULL;
+#ifdef CONFIG_EROFS_FS_ZIP
+	iput(sbi->managed_cache);
+	sbi->managed_cache = NULL;
+#endif
+}
+
 static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -812,6 +816,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
@@ -822,17 +827,10 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
-	DBG_BUGON(!sbi);
-
+	erofs_drop_internal_inodes(sbi);
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
-#ifdef CONFIG_EROFS_FS_ZIP
-	iput(sbi->managed_cache);
-	sbi->managed_cache = NULL;
-#endif
-	iput(sbi->packed_inode);
-	sbi->packed_inode = NULL;
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e4b65070b86..bc6d6842c5c2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -644,18 +644,18 @@ static const struct address_space_operations z_erofs_cache_aops = {
 	.invalidate_folio = z_erofs_cache_invalidate_folio,
 };
 
-int erofs_init_managed_cache(struct super_block *sb)
+int z_erofs_init_super(struct super_block *sb)
 {
 	struct inode *const inode = new_inode(sb);
 
 	if (!inode)
 		return -ENOMEM;
-
 	set_nlink(inode, 1);
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &z_erofs_cache_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
 	EROFS_SB(sb)->managed_cache = inode;
+	xa_init(&EROFS_SB(sb)->managed_pslots);
 	return 0;
 }
 
-- 
2.43.5


