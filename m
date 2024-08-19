Return-Path: <linux-kernel+bounces-291367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286295613F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850111C20AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCEB45957;
	Mon, 19 Aug 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TKndoGdk"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20838DE4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035954; cv=none; b=NYGtOr1Jcr1JfbdkUUkQ8LczX9bpE+nBd3KV+D4VZAmmcirXeZx4h9XlJbA8GXvxFb34R+44EnG2gZ/wTMl11Wf5tAfMjxEPmgOlLXH8LiabSgSSt5PTKfxMiFwpD0LGqfh3uKyNFHYa8jlpwC/Vl3hnio3/R2Hoo/1Vu0WRCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035954; c=relaxed/simple;
	bh=gOH4e2hXdlhmKGaEzeYdnS/IZ4cAjijxp5N4id7IZYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unKqzdt03nj+Pbb+o1NFdd/srJ0qe1aVYv8KCsCFrvMmgTUGolXN61iRISWnuraYjcU9SOuWiYXV8q6N6ndqOEAuVXaEpLeVGtv2hWbaDYLaV+g7ZCxICDxWqnQk2KwQxo+WjRU8EqzQ/AY7fWpojld6rf6dVDYyhpGNfAERdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TKndoGdk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724035942; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fSBui4eXgKDMvdVfyLpBwQeHWqC9sk1dCBk95MEHyoA=;
	b=TKndoGdksy2KZuxwpW8sGNPsRVmC1kcyADVvoOKLPvK7kiPvXcBIC3Zno4eZQQaNPwl2JSvv5aghRL+jfIb5ZL2cGVffPOYJ5lHop3X1RMhNBQLNgfcr1iLntmFO1sb8kXcGQw0Jhe3+M5CGfIBDODhp93daT9w1W18SXjIiEFY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WD4y1IG_1724035928)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 10:52:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Barry Song <21cnbao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] erofs: allow large folios for compressed files
Date: Mon, 19 Aug 2024 10:52:07 +0800
Message-ID: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
migrate_pages_batch() on large folios") already landed upstream,
large folios can be safely enabled for compressed inodes since all
prerequisites already landed in 6.11-rc1.

Stress tests has been working on my fleet for > 20 days without any
regression.  Besides, users [1] has requested it for months.  Let's
allow large folios for EROFS full cases upstream now for wider testing.

[1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMCq=A2qFcA@mail.gmail.com
Cc: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/inode.c                    | 18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index cc4626d6ee4f..c293f8e37468 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -75,7 +75,7 @@ Here are the main features of EROFS:
 
  - Support merging tail-end data into a special inode as fragments.
 
- - Support large folios for uncompressed files.
+ - Support large folios to make use of THPs (Transparent Hugepages);
 
  - Support direct I/O on uncompressed files to avoid double caching for loop
    devices;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 43c09aae2afc..419432be3223 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -257,25 +257,23 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 
+	mapping_set_large_folios(inode->i_mapping);
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 		inode->i_mapping->a_ops = &z_erofs_aops;
-		err = 0;
-		goto out_unlock;
-#endif
+#else
 		err = -EOPNOTSUPP;
-		goto out_unlock;
-	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-	mapping_set_large_folios(inode->i_mapping);
+#endif
+	} else {
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
-	if (erofs_is_fscache_mode(inode->i_sb))
-		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+		if (erofs_is_fscache_mode(inode->i_sb))
+			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 #endif
-
+	}
 out_unlock:
 	erofs_put_metabuf(&buf);
 	return err;
-- 
2.43.5


