Return-Path: <linux-kernel+bounces-553896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3141A5905E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0216BF17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6C225775;
	Mon, 10 Mar 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uvFj1rIT"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2521D585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600517; cv=none; b=KVWlRUF03CsG4e9aRNcQSlaAcLhKB7OANIH7ZDHwgXngW7AFN1x9Vd3gVbq4jTSIuka8URrCMpwwpE3Nps+JSXCVQcsmNBwWMiyaDDCh8+MYBrRRnR/9WGr57QmFbfL/Si4wq+EwqsyQzD7A/6BLmC0C0IqafcE7vCFEDWK+m4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600517; c=relaxed/simple;
	bh=WKpqO9OcjV7tlcK2QY16WFcZDtgVwKHQ0/Hr3soYA5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCorGnqbs2igzYEpRSyfi7H4Kb+0ZiNivgRQlXSmVWWc9pypKwCjeW6rSmEvzBivjKaihi0hnDB6ombXAtVpuZ6QUdXlWCb0KES/9T/6nJclf3bIPl8y9IAhBdrAYVlE60lfNwclyaJN2wEdXqCHEzMARHRX8nApiATHsaGmuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uvFj1rIT; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600505; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uroFFZkg+9TmfgPuBM9ZBqZ5Jlq2UIuIm35LWHZSJMM=;
	b=uvFj1rITMbGXpsaYdJi7hAytlyWqWGtk/EvABF2Ym521jbO4nD0gWKGdRv2BiT3N1rl2xOHI83aQwhdoLSwvrAX9FUenjizVv7caalmPBQVMBXJUXzhja4g1crBmeRv9UdDNGe65Q8E3CQ4Gta46DGc57uBaN3zMQRK0UpejCPc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3x1_1741600504 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 01/10] erofs: get rid of erofs_map_blocks_flatmode()
Date: Mon, 10 Mar 2025 17:54:51 +0800
Message-ID: <20250310095459.2620647-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's simple enough to be folded into erofs_map_blocks().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 117 +++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 70 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1d2cb0fa1baf..2f45e39ce8c7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -70,58 +70,39 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 	return erofs_bread(buf, offset, need_kmap);
 }
 
-static int erofs_map_blocks_flatmode(struct inode *inode,
-				     struct erofs_map_blocks *map)
-{
-	struct erofs_inode *vi = EROFS_I(inode);
-	struct super_block *sb = inode->i_sb;
-	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
-	erofs_blk_t lastblk = erofs_iblks(inode) - tailendpacking;
-
-	map->m_flags = EROFS_MAP_MAPPED;	/* no hole in flat inodes */
-	if (map->m_la < erofs_pos(sb, lastblk)) {
-		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(sb, lastblk) - map->m_la;
-	} else {
-		DBG_BUGON(!tailendpacking);
-		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(sb, map->m_la);
-		map->m_plen = inode->i_size - map->m_la;
-
-		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		map->m_flags |= EROFS_MAP_META;
-	}
-	return 0;
-}
-
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 {
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = inode->i_sb;
+	unsigned int unit, blksz = sb->s_blocksize;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_chunk_index *idx;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	u64 chunknr;
-	unsigned int unit;
+	erofs_blk_t startblk;
+	bool tailpacking;
 	erofs_off_t pos;
-	void *kaddr;
+	u64 chunknr;
 	int err = 0;
 
 	trace_erofs_map_blocks_enter(inode, map, 0);
 	map->m_deviceid = 0;
-	if (map->m_la >= inode->i_size) {
-		/* leave out-of-bound access unmapped */
-		map->m_flags = 0;
-		map->m_plen = map->m_llen;
+	map->m_flags = 0;
+	if (map->m_la >= inode->i_size)
 		goto out;
-	}
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
-		err = erofs_map_blocks_flatmode(inode, map);
+		tailpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+		pos = erofs_pos(sb, erofs_iblks(inode) - tailpacking);
+
+		map->m_flags = EROFS_MAP_MAPPED;
+		if (map->m_la < pos) {
+			map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
+			map->m_llen = pos - map->m_la;
+		} else {
+			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+				vi->xattr_isize + erofs_blkoff(sb, map->m_la);
+			map->m_llen = inode->i_size - map->m_la;
+			map->m_flags |= EROFS_MAP_META;
+		}
 		goto out;
 	}
 
@@ -134,45 +115,41 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, pos, true);
-	if (IS_ERR(kaddr)) {
-		err = PTR_ERR(kaddr);
+	idx = erofs_read_metabuf(&buf, sb, pos, true);
+	if (IS_ERR(idx)) {
+		err = PTR_ERR(idx);
 		goto out;
 	}
 	map->m_la = chunknr << vi->chunkbits;
-	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
-			round_up(inode->i_size - map->m_la, sb->s_blocksize));
-
-	/* handle block map */
-	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = kaddr;
-
-		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
-			map->m_flags = 0;
-		} else {
-			map->m_pa = erofs_pos(sb, le32_to_cpu(*blkaddr));
+	map->m_llen = min_t(erofs_off_t, 1UL << vi->chunkbits,
+			    round_up(inode->i_size - map->m_la, blksz));
+	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
+		startblk = le32_to_cpu(idx->blkaddr);
+		if (startblk != EROFS_NULL_ADDR) {
+			map->m_deviceid = le16_to_cpu(idx->device_id) &
+				EROFS_SB(sb)->device_id_mask;
+			map->m_pa = erofs_pos(sb, startblk);
+			map->m_flags = EROFS_MAP_MAPPED;
+		}
+	} else {
+		startblk = le32_to_cpu(*(__le32 *)idx);
+		if (startblk != EROFS_NULL_ADDR) {
+			map->m_pa = erofs_pos(sb, startblk);
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
-		goto out_unlock;
-	}
-	/* parse chunk indexes */
-	idx = kaddr;
-	switch (le32_to_cpu(idx->blkaddr)) {
-	case EROFS_NULL_ADDR:
-		map->m_flags = 0;
-		break;
-	default:
-		map->m_deviceid = le16_to_cpu(idx->device_id) &
-			EROFS_SB(sb)->device_id_mask;
-		map->m_pa = erofs_pos(sb, le32_to_cpu(idx->blkaddr));
-		map->m_flags = EROFS_MAP_MAPPED;
-		break;
 	}
-out_unlock:
 	erofs_put_metabuf(&buf);
 out:
-	if (!err)
-		map->m_llen = map->m_plen;
+	if (!err) {
+		map->m_plen = map->m_llen;
+		/* inline data should be located in the same meta block */
+		if ((map->m_flags & EROFS_MAP_META) &&
+		    erofs_blkoff(sb, map->m_pa) + map->m_plen > blksz) {
+			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+	}
 	trace_erofs_map_blocks_exit(inode, map, 0, err);
 	return err;
 }
-- 
2.43.5


