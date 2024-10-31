Return-Path: <linux-kernel+bounces-390031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E419B74B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0301F24D34
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9B146D59;
	Thu, 31 Oct 2024 06:49:15 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0A14658C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357355; cv=none; b=UHyMPnEG/7EulC0B9BknbAVXulOFcDHTmZNNMrEHmisL5dRxtrsPoILJa4Dn2Xx49+vReaq8xVkmbxufBfmokXcHIgBjYi8MmFbzvGdNQ00D2kNa7OFnh52jNgv6HjrGWOueafwMFunIO6RkX8+BiczwgkYQTkoQ/tQtxz7k30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357355; c=relaxed/simple;
	bh=QRqzZoAa+uJkjRdmaiG2qG8eeoWvvqL+ID5dorhR7mA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtV5cuhQQUqJDHGIGYwVN59AaxxhQ650Trewz0iey9G0VtSY2WPuyadJwoFhUD/1nE6XcdBVNPDDo0vjxfQg2LO9XTk5MQPQzAPvvfO0pXGDBBoburb6gwFQlJB9kJ17eF2XJ7k0eUagz9KJWdSYKqpwdfDFxzv9yWsv4mZdsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfDxg6jNPz1HLfd;
	Thu, 31 Oct 2024 14:44:39 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 612E61401F3;
	Thu, 31 Oct 2024 14:49:09 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 14:49:08 +0800
From: Long Li <leo.lilong@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <leo.lilong@huawei.com>, <yangerkun@huawei.com>,
	<lonuxli.64@gmail.com>
Subject: [PATCH 2/2] Revert "f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()"
Date: Thu, 31 Oct 2024 14:45:53 +0800
Message-ID: <20241031064553.55283-2-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241031064553.55283-1-leo.lilong@huawei.com>
References: <20241031064553.55283-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

This reverts commit c7f114d864ac91515bb07ac271e9824a20f5ed95.

The race conditions between concurrent f2fs_stop_gc_thread() calls
are now protected by a dedicated lock, making the additional s_umount
lock protection unnecessary. Therefore, revert this patch.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/file.c  | 11 ++---------
 fs/f2fs/super.c |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ae1e2a4789f..2143604ce416 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3522,7 +3522,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-						bool readonly, bool need_lock);
+							bool readonly);
 int f2fs_precache_extents(struct inode *inode);
 int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int f2fs_fileattr_set(struct mnt_idmap *idmap,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 75a8b22da664..5d7b4fdae9c4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2318,7 +2318,7 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 }
 
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
-						bool readonly, bool need_lock)
+							bool readonly)
 {
 	struct super_block *sb = sbi->sb;
 	int ret = 0;
@@ -2365,19 +2365,12 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	if (readonly)
 		goto out;
 
-	/* grab sb->s_umount to avoid racing w/ remount() */
-	if (need_lock)
-		down_read(&sbi->sb->s_umount);
-
 	f2fs_stop_gc_thread(sbi);
 	f2fs_stop_discard_thread(sbi);
 
 	f2fs_drop_discard_cmd(sbi);
 	clear_opt(sbi, DISCARD);
 
-	if (need_lock)
-		up_read(&sbi->sb->s_umount);
-
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 
@@ -2414,7 +2407,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 	}
 
-	ret = f2fs_do_shutdown(sbi, in, readonly, true);
+	ret = f2fs_do_shutdown(sbi, in, readonly);
 
 	if (need_drop)
 		mnt_drop_write_file(filp);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 47a15050ea9c..a720fb9ef196 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2569,7 +2569,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 static void f2fs_shutdown(struct super_block *sb)
 {
-	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false, false);
+	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false);
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.39.2


