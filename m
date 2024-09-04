Return-Path: <linux-kernel+bounces-314372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601B96B269
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001931F25756
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD641145FEB;
	Wed,  4 Sep 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yj0xEcb9"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E214659C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433816; cv=none; b=a7wj04kP1LLUjaMSc512Cr+U42xUicv3nXEevtxMBEqbdBwmGR8hgXJGDFtmoPB9Ncb87J+Yo75dlq+ZUI+FAjGoTqM1uRWsLS6dnIuL7xf6uoPuMbVy96IHD8xj/mY/0WxXi3E4PZjJL1LbZncBEXKMg+nAKlC25vNNlRjjga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433816; c=relaxed/simple;
	bh=FAsJlFuEXg96m3eEmDlt+U58YwVf+hRfLm45Q9DMBuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egeWjQ+NKD6ROqozLzOVsbTapokwxEtIn4kIWLGN6n0alkOXseN0lKOk2EAQD6U+AQ1Dkw4F0ERIxxhzxjRFa5+QLMMCFVXIkLpGCG/7sPBdB3Pnos/cNNqygUblYS1AtEZCwg/FtC/tWJVDEZX4knSDbH5HzBPv2EW2fidbOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yj0xEcb9; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725433806; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vqyV76VlKKLAdbpgVAg9s1oydzR37v674r2y+KbzX3c=;
	b=yj0xEcb9GD8yTdM/DVkecTmvvBqYqGR9PDcQ11LBxFjR7IZ82INwGoS7wzRlAfCro+3IpHmHHZZ6mi+S1F20QLj2lXSQQN5NmLAUPLNK7OkAEPzWYaSa16fq7Mz4RyU1FGtFpfRtEcYg1eA7djc239x5+n6+0aydF2pwlPHkkCA=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WEGYp4O_1725433804)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 15:10:05 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] ocfs2: cancel dqi_sync_work before freeing oinfo
Date: Wed,  4 Sep 2024 15:10:03 +0800
Message-Id: <20240904071004.2067695-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2_global_read_info() will initialize and schedule dqi_sync_work at
the end, if error occurs after successfully reading global quota, it
will trigger the following warning with CONFIG_DEBUG_OBJECTS_* enabled:

ODEBUG: free active (active state 0) object: 00000000d8b0ce28 object type: timer_list hint: qsync_work_fn+0x0/0x16c

This blames there is an active delayed work when freeing oinfo in error
handling, so cancel dqi_sync_work first. BTW, return status instead of
-1 when .read_file_info fails.

Link: https://syzkaller.appspot.com/bug?extid=f7af59df5d6b25f0febd
Reported-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
Tested-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
Fixes: 171bf93ce11f ("ocfs2: Periodic quota syncing")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/quota_local.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 8ce462c64c51..73d3367c533b 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -692,7 +692,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	int status;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_quota_recovery *rec;
-	int locked = 0;
+	int locked = 0, global_read = 0;
 
 	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
 	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
@@ -700,6 +700,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	if (!oinfo) {
 		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
 			       " info.");
+		status = -ENOMEM;
 		goto out_err;
 	}
 	info->dqi_priv = oinfo;
@@ -712,6 +713,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	status = ocfs2_global_read_info(sb, type);
 	if (status < 0)
 		goto out_err;
+	global_read = 1;
 
 	status = ocfs2_inode_lock(lqinode, &oinfo->dqi_lqi_bh, 1);
 	if (status < 0) {
@@ -782,10 +784,12 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 		if (locked)
 			ocfs2_inode_unlock(lqinode, 1);
 		ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
+		if (global_read)
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
 		kfree(oinfo);
 	}
 	brelse(bh);
-	return -1;
+	return status;
 }
 
 /* Write local info to quota file */
-- 
2.39.3


