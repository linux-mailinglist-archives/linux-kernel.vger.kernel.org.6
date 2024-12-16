Return-Path: <linux-kernel+bounces-447345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BE9F30EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593DC188266E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BE204F93;
	Mon, 16 Dec 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="by6kvTum"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CA204C0C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353602; cv=none; b=nQZWUS2mOWH4rgv0qNek12Oko3lpL8bcYg9ejqYwc6fSJRurO+vWuwIpw2EgqaAto/H4wDckQz13TfTZz6uXp48iB2PZjFeWSM5D40O3Bm9vfXiw2ltWYum3o48HVteZmYvYiriIKHASi9aDQ44xdQkOyjw2DAQnGCOtaL1TDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353602; c=relaxed/simple;
	bh=0NEaVlSfcKA6VZ14JF6k7UBb0PRxtrSPnyOhzfeZQp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCQ4b5kEGvMwTasaKsY0HRlbz7Mv2es93H0EuwrSoEvhJuH6u5FnhR86YVc2FUvoxnoWu6lmrneZJR0Huj3WFuMmXGALhK9G4t8vYa0rSnDpV5NNOcr7hG4rvrm0BGuUmHCcQzbP9XFKADWOG667l1G4agAcm91q5PbBJHVN3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=by6kvTum; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353597; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=igS+vMvKO7ShxBR7rp8ORXO+whr6YQCKn1xoR3jaKug=;
	b=by6kvTumhpTqFfrztN/2hzw4i00egHZUiryU16Cezenz2mxebLICoo25ucyrdOf8E9OOHLZZ8vK5yd5dZuyIyuhXDSAvyVfk932sHyctk9SUlzVQUFkT4j0gosDM8MdeEAsW7zgcCcQ29iaPcNt3NbgAG+OWAwG5T79rADfj3LU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksKQ_1734353592 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/4] erofs: add erofs_sb_free() helper
Date: Mon, 16 Dec 2024 20:53:07 +0800
Message-ID: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
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

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c235a8e4315e..de8e3ecc6381 100644
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


