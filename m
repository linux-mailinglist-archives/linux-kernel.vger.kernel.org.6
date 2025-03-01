Return-Path: <linux-kernel+bounces-540013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A5A4AC6A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875403B3210
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6F1E3DE0;
	Sat,  1 Mar 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L8iVrfac"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED61E2307
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840626; cv=none; b=RGNYSaej/dJvZmEtV1gHslYcS62yLBTiX0YIaOEqSjnR5lDtlmzfR/gSIiBCCYyti3+9iC1jTVxcqZyPiqXuntPkOejGr174nFmF57i+pUcDnyRrKO+v+zlyI5SAQZDkmUyaGOYnSWHb6qdyP0gK/ynoGv1XPi9eFI4IQ1qTAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840626; c=relaxed/simple;
	bh=tr7tF7qVsTRf8JeqGnQQFgvhRP/lf2ZGRgv+8ERwR9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9xKfbNKtw1zhIilNwFua9o15epNr1YgZcQtogj02S5wwWdwyA4gkKE4gpxP6Px1WA2fFichmHQ2+6BfBSXratgqQlNXU+HECDfBuwBpR33HJMf+/+raNioLmRvmfiqGKWecq8p1vLttSZqX6YIgDjuJc6ZLsX2pyLSEwka6u1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L8iVrfac; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840615; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6USqGVcPTi586mkMaCckvU+yah8nBs9aiwe4n8Cy5OI=;
	b=L8iVrfac2JLdV8zk6cYlUXhwgxFiusr8wmaD5Ox+nLc0CFJ2R0HHcYffnHZjg3iXwaknQqSij5nFOXzrr7yFIZ6lTO07OdqalFGyJPClit7cOKmRkgsGhyVNYAqfEyxtd+D94RmdgPeSSAiW+vPKZfpSC161uVEFXqaXtC3KbVA=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSgWQj_1740840614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:15 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [RFC PATCH v6 3/7] erofs: support domain-specific page cache share
Date: Sat,  1 Mar 2025 22:49:40 +0800
Message-ID: <20250301145002.2420830-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6af02cc8b8c6..ceab0c29b061 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -489,6 +489,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -558,16 +560,16 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !sbi->ishare_key)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
 		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
-	else if (erofs_is_fileio_mode(sbi))
+	else if (!sb->s_bdi || !sb->s_bdi->dev)
+		super_set_sysfs_name_id(sb);
+	else
 		super_set_sysfs_name_generic(sb, "%s",
 					     bdi_dev_name(sb->s_bdi));
-	else
-		super_set_sysfs_name_id(sb);
 }
 
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -965,6 +967,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
-- 
2.43.5


