Return-Path: <linux-kernel+bounces-181963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4AD8C8458
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CD2284F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512E36137;
	Fri, 17 May 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FgjE81uD"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079C2E852
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939820; cv=none; b=TyGMWYk1aBjRITrkSTYiin929pEqOBvB+0JxzVXLCog4FKuBzDKyOaFHKjuXpkRUVeYTBedgMmy+NDqhO/KxRRf9mxYLe/BW1ZU3wZA21m2wIRjU2NoPwxbGnMTx1zwxvEGF4npeBzCduT3HhJLDJWqD00KlSO1IB87AGYny5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939820; c=relaxed/simple;
	bh=6dv1ARr8AfSeat6L7IDqLiV12HzGwVJ0hWWWehC6BRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PaMsVMJWqm79tfvrcZRvAUBPxBwoSfnR9B74k3vEMgqJpDWPCpWwcarnFiFn6Zv4vE0ab7+tbfwMg7GWp0gEYhnLdw2mk+2830WMN0rSPc/WLYojmpUuMqPTpU/hDXIZCqU3KdGCvf+GTC8ylqBZr9BgxhsEdvuqL5BD2UWq2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FgjE81uD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715939815; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hdb/3TvARJVZ7RhOX63ITgXZ/E5Lk4N24+C/9grOEmc=;
	b=FgjE81uDttziQ+J8maIJEwy1a+FLXj+8UVYShcOWqcIhNSAoQWKD8ELDGocbVH8DuFQKx1HlKbXtV4cyyYyPiHTwvjFoaSFzqoY0hxm7GYYCiCrRoslPjUDg7TySttS4ByOglcTyGfq/DpHScI+EU/RbzhQTtxasWJdQaOsKw64=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eF9U7_1715939813;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W6eF9U7_1715939813)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:56:55 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: clean up erofs_show_options()
Date: Fri, 17 May 2024 17:56:52 +0800
Message-Id: <20240517095652.2282972-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid unnecessary #ifdefs and simplify the code a bit.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 ---
 fs/erofs/super.c    | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..16097d95501a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -64,15 +64,12 @@ enum {
 };
 
 struct erofs_mount_opts {
-#ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
 	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
 	unsigned int sync_decompress;
-
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
-#endif
 	unsigned int mount_opt;
 };
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 69308fd73e4a..14822642e2f6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -948,26 +948,14 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
 	struct erofs_mount_opts *opt = &sbi->opt;
 
-#ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(opt, XATTR_USER))
-		seq_puts(seq, ",user_xattr");
-	else
-		seq_puts(seq, ",nouser_xattr");
-#endif
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(opt, POSIX_ACL))
-		seq_puts(seq, ",acl");
-	else
-		seq_puts(seq, ",noacl");
-#endif
-#ifdef CONFIG_EROFS_FS_ZIP
-	if (opt->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
-		seq_puts(seq, ",cache_strategy=disabled");
-	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
-		seq_puts(seq, ",cache_strategy=readahead");
-	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
-		seq_puts(seq, ",cache_strategy=readaround");
-#endif
+	if (IS_ENABLED(CONFIG_EROFS_FS_XATTR))
+		seq_puts(seq, test_opt(opt, XATTR_USER) ?
+				",user_xattr" : ",nouser_xattr");
+	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
+		seq_puts(seq, test_opt(opt, POSIX_ACL) ? ",acl" : ",noacl");
+	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+		seq_printf(seq, ",cache_strategy=%s",
+			  erofs_param_cache_strategy[opt->cache_strategy].name);
 	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
-- 
2.39.3


