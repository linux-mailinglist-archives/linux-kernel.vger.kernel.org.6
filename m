Return-Path: <linux-kernel+bounces-302701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10317960216
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427281C20FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A813FD83;
	Tue, 27 Aug 2024 06:42:53 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FB3A1C4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740972; cv=none; b=JlWfdhXdDruIAC/ZZxFwQdq8/KNy7bUfkP4EMIbqa/dvHPpAdTggB+YBdrghf582o5JWqzzmhq/SniUAS0Mphq8y163rH9RJedLIe9Zxz6NggfpS8cgUJz10iDRPGfeCTsX8iQq5i+Dvj5EeZcgeUS/WXZVsFsx7oFQ4Pl/BAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740972; c=relaxed/simple;
	bh=AfiEjW89m5Om/b3PrLTiuLKQ8Otjo8qrSZ78r00kCoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdBdR05KRu+92FQ+atGPcj8JDzWoY15vXiU/R/evK8HJi8HoigCqK4XO3pGlaiCIVQeqmyh3kz6ET6CSpQhZ+L6TeJc7zcV1m2Kk1wjLh1hFEtjFbHcR3NNVvWTma8VqE5oqZNB3wkgzNTPeCIYw/OAZZcYjJjjHQ/XD0jOFbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4WtHVp4j8xzYl3hf;
	Tue, 27 Aug 2024 14:21:22 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 14:22:45 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 14:22:44 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, wangzijie <wangzijie1@honor.com>
Subject: [RFC PATCH] f2fs: don't set SBI_QUOTA_NEED_REPAIR flag if receive SIGKILL
Date: Tue, 27 Aug 2024 14:22:42 +0800
Message-ID: <20240827062242.776881-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

Thread A
-dquot_initialize
 -dqget
  -f2fs_dquot_acquire
   -v2_read_dquot
    -qtree_read_dquot
     -find_tree_dqentry
      -f2fs_quota_read
       -read_cache_page_gfp
        -do_read_cache_folio
         -fiemap_read_folio
          -folio_wait_locked_killable
           -receive SIGKILL : return -EINTR
       -set SBI_QUOTA_NEED_REPAIR
   -set SBI_QUOTA_NEED_REPAIR

When calling read_cache_page_gfp in quota read, thread may receive SIGKILL and
set SBI_QUOTA_NEED_REPAIR, should we set SBI_QUOTA_NEED_REPAIR in this error path?

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/inode.c | 3 ++-
 fs/f2fs/super.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ed629dabb..2af98e2b7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -837,8 +837,9 @@ void f2fs_evict_inode(struct inode *inode)
 
 	err = f2fs_dquot_initialize(inode);
 	if (err) {
+		if (err != -EINTR)
+			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 		err = 0;
-		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	}
 
 	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f1b3647a..f99a36ff3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2650,8 +2650,8 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 			if (PTR_ERR(page) == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
 				goto repeat;
-			}
-			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+			} else if (PTR_ERR(page) != -EINTR)
+				set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			return PTR_ERR(page);
 		}
 
@@ -3070,7 +3070,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
 
 	f2fs_down_read(&sbi->quota_sem);
 	ret = dquot_acquire(dquot);
-	if (ret < 0)
+	if (ret < 0 && ret != -EINTR)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	f2fs_up_read(&sbi->quota_sem);
 	return ret;
-- 
2.25.1


