Return-Path: <linux-kernel+bounces-173221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D18BFD38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F94C283641
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E65646E;
	Wed,  8 May 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ft47RNiP"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D155E58
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171651; cv=none; b=bMFA5dgs56/0akX5CWvlEvRhuhGkHMRqOAtN9xppGAYBj1uPzwcHmzT0UfRZcEaoHSJbd3VE4trVNVM2NtXwiaEkbIe2ukrZC1RTNJfHI/ngMfoi2j//g/48o7IiaF6qooNpQcqkuR3gYvqoySv7R11HQDKe0pGcACE2b1jAYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171651; c=relaxed/simple;
	bh=DiF+oR2Mfi2GH39WI0QdXSCh3Dt7vn1cAK3BuRqWzvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SgPOd3LSyUgUH0ZIxMwph+1hlQMCeOxjtRizs/nc1Hfy+eleZarmOXkHZSGVxK97ZXmIZC86u8uiStJV1muudMHHr+TkkdBroiDQZSYi+XBs+uuJBXNe3fLOI8e7F2y/wAdWlLC1hyO1uSpQX1WCJ4Vgup4OroYuO05Eyjoie6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ft47RNiP; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715171644; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yw11G1gLE8iNd8Cfpyqtd9XhzkVzZPbalt0cTW63xQw=;
	b=Ft47RNiPD34fR71qxFw7ts0MS5rRhSftdwBPPuCtGHJ6+JNaXgaZY2RkmCwfMh0lJdXRelC0QC1Tt5xfz+uHErfUhyrpgqCtE2OGT1sK8wk+24EBi+I247Kq/YtVhNj2Zu5cuOizcmRYfSSxVa1RqA4M7hT+ammpeVghtep8eZY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W63ZZzu_1715171638;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W63ZZzu_1715171638)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 20:34:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: clean up z_erofs_load_full_lcluster()
Date: Wed,  8 May 2024 20:33:57 +0800
Message-Id: <20240508123357.3266173-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only four lcluster types here, remove redundant code.
No real logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Some random cleanup out of the upcoming big lclusters..

 fs/erofs/erofs_fs.h |  5 +----
 fs/erofs/zmap.c     | 21 +++++----------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 4bc11602aac8..6c0c270c42e1 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -406,8 +406,7 @@ enum {
 	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
-#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_MASK	(Z_EROFS_LCLUSTER_TYPE_MAX - 1)
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
 #define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
@@ -461,8 +460,6 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
-		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
 		     fmh != cpu_to_le64(1ULL << 63) : 0);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..26637a60eba5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -31,7 +31,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
 	struct z_erofs_lcluster_index *di;
-	unsigned int advise, type;
+	unsigned int advise;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
 				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
@@ -43,10 +43,8 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
-	switch (type) {
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
@@ -60,24 +58,15 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
-		if (advise & Z_EROFS_LI_PARTIAL_REF)
-			m->partialref = true;
+	} else {
+		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
-		break;
-	default:
-		DBG_BUGON(1);
-		return -EOPNOTSUPP;
 	}
-	m->type = type;
 	return 0;
 }
 
-- 
2.39.3


