Return-Path: <linux-kernel+bounces-316233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCE96CCE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49AF2857E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10A5476B;
	Thu,  5 Sep 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YJi7H1Wh"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978125634
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505432; cv=none; b=LlNlH0Qj8yhX4xCtxewhTywTXCy0RPg1ERhZgIalcRq+K6W+H7HU+blsN8MAgyU/JhlrhYSjbZG5fIXDgBPee3imfEu29qyTX1V4qZk8WeyWeSBiX1hjhIgnB56XxDnrxQfM/2kZ2u8wjTFPKGPBsYti34fGcZ/kECCiPuz+9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505432; c=relaxed/simple;
	bh=gWkUD63ZkNaQ2GYLMWvBVKu0djNvOhsQculrfyl12Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzO5XmtwINzdlz+p7Qf9nOGaVMOlHchHhXhk/i3pzvFIJxDg2xdymI/l2954eX/vKR938J+UwLPzQjCJZ7W0Gk7elEGiwz8a6ApZDmqpeTN+32QY9SGdtglHkPFZVvYBqQ7/G8YnWSTg6ynPM62R5PSePegMMqEiFw0Ecfi4lA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YJi7H1Wh; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505421; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fC+vzKwLthbvHWWaMcb4VLaSEm+2MTEtjuhPVPFwODM=;
	b=YJi7H1Whq8vvsXtMtw69onN7c0+uZFz1Q4cODVnkY8kdxcvlrlo5NU7Azs2sPWjLm5CaYvGa8VmvJ+H5dVJOCz9Ec2BuSJ/OllM6ju6agZhurapfcWsMRh1Y9hqTCUUDCSxM7Sdz8OY+pSRb5QMPe2UOcfXq8MXpVIYPhFGLnRg=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEJdNyJ_1725505419)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:03:40 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: simplify erofs_map_blocks_flatmode()
Date: Thu,  5 Sep 2024 11:03:39 +0800
Message-ID: <20240905030339.1474396-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of redundant variables (nblocks, offset) and a dead branch
(!tailendpacking).

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..b13ef0019c92 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -75,38 +75,28 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 static int erofs_map_blocks_flatmode(struct inode *inode,
 				     struct erofs_map_blocks *map)
 {
-	erofs_blk_t nblocks, lastblk;
-	u64 offset = map->m_la;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+	erofs_blk_t lastblk = erofs_iblks(inode) - tailendpacking;
 
-	nblocks = erofs_iblks(inode);
-	lastblk = nblocks - tailendpacking;
-
-	/* there is no hole in flatmode */
-	map->m_flags = EROFS_MAP_MAPPED;
-	if (offset < erofs_pos(sb, lastblk)) {
+	map->m_flags = EROFS_MAP_MAPPED;	/* no hole in flat inodes */
+	if (map->m_la < erofs_pos(sb, lastblk)) {
 		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(sb, lastblk) - offset;
-	} else if (tailendpacking) {
+		map->m_plen = erofs_pos(sb, lastblk) - map->m_la;
+	} else {
+		DBG_BUGON(!tailendpacking);
 		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(sb, offset);
-		map->m_plen = inode->i_size - offset;
+			vi->xattr_isize + erofs_blkoff(sb, map->m_la);
+		map->m_plen = inode->i_size - map->m_la;
 
 		/* inline data should be located in the same meta block */
 		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "inline data cross block boundary @ nid %llu",
-				  vi->nid);
+			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
 		map->m_flags |= EROFS_MAP_META;
-	} else {
-		erofs_err(sb, "internal error @ nid: %llu (size %llu), m_la 0x%llx",
-			  vi->nid, inode->i_size, map->m_la);
-		DBG_BUGON(1);
-		return -EIO;
 	}
 	return 0;
 }
-- 
2.43.5


