Return-Path: <linux-kernel+bounces-443131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383C9EE7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A300E1888E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DCD21518A;
	Thu, 12 Dec 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X1trIlOb"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6A2144A8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010522; cv=none; b=d61MfAJV7jstzWRlFrCcB0SOzGXBDmvAXUp5hjZqkooEj6/pqZ0HHPr7q2R8jHUq5KobzllhXC+pMxyQ5ln3MH5TRRM8jHct4rEI1/WfeN6PjCmKEwcFZCqrhb+yukIz29Avaz5PS7QmSL+2hZYwxal18Cb/jgtnpS4MJf9CZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010522; c=relaxed/simple;
	bh=mQELmEZTY+F/nXn85f1TGczJdjITkLw9mx5HUBS1N70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIIwY94Ws5VpeMdgpnRbOPouQ3sRXf2Kx+juhWr1lU1FDAsqXN4sNefIjwzd45i7hQJWMZo3VGr0eNT37XrXK1EEjsSM17ik38aVO2xQYvekJjUSJHc92sbJ+n3+z6b+g4Cv9Sjd2VqSGAjfXgd0LOGrFoW7ZkVQiYcOCQmq75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X1trIlOb; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734010510; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bep53u066GuA/RqqrsrzhZPJEa3VMPrE3kZ/DxaEDko=;
	b=X1trIlOboc4SQ/A5T/Z9nw46qFyHfsooAjzgWBmMcOEOuuk52NEY+8fHtRLv7+ZXCwwjHy4Hz9RnZEjSst6MKiJfN7HQarAMgfbWip0pIWzlqmnFnqnsk+3jLX8kKePfFi1FjRf4SPmZDMLgDLmC1XXke8c8YwWM8sV3T6pVH6Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvJn5_1734010505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:35:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs: add erofs_sb_free() helper
Date: Thu, 12 Dec 2024 21:35:01 +0800
Message-ID: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify the common parts of erofs_fc_free() and erofs_kill_sb() as
erofs_sb_free().

Thus, fput() in erofs_fc_get_tree() is no longer needed, too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c235a8e4315e..1ce5ca11d32b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -703,16 +703,19 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			GET_TREE_BDEV_QUIET_LOOKUP : 0);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
+		struct file *file;
+
 		if (!fc->source)
 			return invalf(fc, "No source specified");
-		sbi->fdev = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
-		if (IS_ERR(sbi->fdev))
-			return PTR_ERR(sbi->fdev);
+
+		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+		sbi->fdev = file;
 
 		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
 		    sbi->fdev->f_mapping->a_ops->read_folio)
 			return get_tree_nodev(fc, erofs_fc_fill_super);
-		fput(sbi->fdev);
 	}
 #endif
 	return ret;
@@ -763,19 +766,24 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 	kfree(devs);
 }
 
-static void erofs_fc_free(struct fs_context *fc)
+static void erofs_sb_free(struct erofs_sb_info *sbi)
 {
-	struct erofs_sb_info *sbi = fc->s_fs_info;
-
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
+	if (sbi->fdev)
+		fput(sbi->fdev);
 	kfree(sbi);
 }
 
+static void erofs_fc_free(struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi) /* free here if an error occurs before transferring to sb */
+		erofs_sb_free(sbi);
+}
+
 static const struct fs_context_operations erofs_context_ops = {
 	.parse_param	= erofs_fc_parse_param,
 	.get_tree       = erofs_fc_get_tree,
@@ -813,15 +821,9 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-
-	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-	kfree(sbi->fsid);
-	kfree(sbi->domain_id);
-	if (sbi->fdev)
-		fput(sbi->fdev);
-	kfree(sbi);
+	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
 }
 
-- 
2.43.5


