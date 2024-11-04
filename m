Return-Path: <linux-kernel+bounces-394189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D267F9BAB97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023151C20F39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE86189910;
	Mon,  4 Nov 2024 03:46:42 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01341188CA1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692001; cv=none; b=S6g5ZpWYNY9U9132gGrzoVwhTS1RNeSYEIXs0XVtoF1Zv7PzNMN3Ib6I5ubjhKL74/Hj4d1HgeOjqqSTV0YIYu1P8ZFMcWo+wm1vLpaCc5CsKOzs543qK8as6ZvtkqRQfxs+3xLSe+Wzl+J5ufsHER2w/u8kRYl6oqBmbLI85TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692001; c=relaxed/simple;
	bh=u/7RADR4hugZ8T7Y1+cWFjejj69wCIPQJjKNNgbjmCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+21242DFZiEXyYVzw31YiZKKxFQSkII9u+mjw9bWxrKOQJLxUPWYLcQwS42VkW2lWuQigBaHAbvtWgiNJYfGdXDRyMYs/L7iAizghVkkw9xGsx1356W+oLxBZooY6L+OR0zxJra4FDJwMvY/oAGy4ZYn8UrFTXSIcQDc/RpMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A43jrUo085789;
	Mon, 4 Nov 2024 11:45:53 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xhcmd5Ljlz2KgRl5;
	Mon,  4 Nov 2024 11:45:05 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 11:45:50 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v3 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
Date: Mon, 4 Nov 2024 11:45:44 +0800
Message-ID: <20241104034545.497907-5-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104034545.497907-1-yi.sun@unisoc.com>
References: <20241104034545.497907-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4A43jrUo085789

New function can process some consecutive blocks at a time.

Function f2fs_invalidate_blocks()->down_write() and up_write()
are very time-consuming, so if f2fs_invalidate_blocks() can
process consecutive blocks at one time, it will save a lot of time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/compress.c |  4 ++--
 fs/f2fs/f2fs.h     |  3 ++-
 fs/f2fs/file.c     |  8 ++++----
 fs/f2fs/node.c     |  4 ++--
 fs/f2fs/segment.c  | 32 +++++++++++++++++++++++++-------
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f6626f2feb0c..666912c1293e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1374,7 +1374,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			if (blkaddr == COMPRESS_ADDR)
 				fio.compr_blocks++;
 			if (__is_valid_data_blkaddr(blkaddr))
-				f2fs_invalidate_blocks(sbi, blkaddr);
+				f2fs_invalidate_blocks(sbi, blkaddr, 1);
 			f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
 			goto unlock_continue;
 		}
@@ -1384,7 +1384,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		if (i > cc->valid_nr_cpages) {
 			if (__is_valid_data_blkaddr(blkaddr)) {
-				f2fs_invalidate_blocks(sbi, blkaddr);
+				f2fs_invalidate_blocks(sbi, blkaddr, 1);
 				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
 			}
 			goto unlock_continue;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a1c9341789a1..d8691b834aaf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3714,7 +3714,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
-void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
+void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
+						unsigned int len);
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b619f7e55640..9366e7fc7c39 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -652,7 +652,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 				valid_blocks++;
 		}
 
-		f2fs_invalidate_blocks(sbi, blkaddr);
+		f2fs_invalidate_blocks(sbi, blkaddr, 1);
 
 		if (!released || blkaddr != COMPRESS_ADDR)
 			nr_free++;
@@ -750,7 +750,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		unsigned int i;
 
 		for (i = 0; i < ei.len; i++)
-			f2fs_invalidate_blocks(sbi, ei.blk + i);
+			f2fs_invalidate_blocks(sbi, ei.blk + i, 1);
 
 		dec_valid_block_count(sbi, inode, ei.len);
 		f2fs_update_time(sbi, REQ_TIME);
@@ -1319,7 +1319,7 @@ static int __roll_back_blkaddrs(struct inode *inode, block_t *blkaddr,
 		ret = f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_NODE_RA);
 		if (ret) {
 			dec_valid_block_count(sbi, inode, 1);
-			f2fs_invalidate_blocks(sbi, *blkaddr);
+			f2fs_invalidate_blocks(sbi, *blkaddr, 1);
 		} else {
 			f2fs_update_data_blkaddr(&dn, *blkaddr);
 		}
@@ -1571,7 +1571,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 			break;
 		}
 
-		f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
+		f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
 		f2fs_set_data_blkaddr(dn, NEW_ADDR);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7d904f2bd5b6..bb0261db5fd3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *dn)
 	}
 
 	/* Deallocate node address */
-	f2fs_invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
 	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
@@ -2758,7 +2758,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
 	if (err)
 		return err;
 
-	f2fs_invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
 	dec_valid_node_count(sbi, inode, false);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 843171ce414b..ad0007294a3f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -245,7 +245,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 		if (!__is_valid_data_blkaddr(new_addr)) {
 			if (new_addr == NULL_ADDR)
 				dec_valid_block_count(sbi, inode, 1);
-			f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
+			f2fs_invalidate_blocks(sbi, dn.data_blkaddr, 1);
 			f2fs_update_data_blkaddr(&dn, new_addr);
 		} else {
 			f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
@@ -2559,25 +2559,43 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
-void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
+void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
+				unsigned int len)
 {
 	unsigned int segno = GET_SEGNO(sbi, addr);
 	struct sit_info *sit_i = SIT_I(sbi);
+	block_t addr_start = addr, addr_end = addr + len - 1;
+	unsigned int seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
+	unsigned int i = 1, max_blocks = sbi->blocks_per_seg, cnt;
 
 	f2fs_bug_on(sbi, addr == NULL_ADDR);
 	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 		return;
 
-	f2fs_invalidate_internal_cache(sbi, addr, 1);
+	f2fs_invalidate_internal_cache(sbi, addr, len);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
 
-	update_segment_mtime(sbi, addr, 0);
-	update_sit_entry(sbi, addr, -1);
+	if (seg_num == 1)
+		cnt = len;
+	else
+		cnt = max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
 
-	/* add it into dirty seglist */
-	locate_dirty_segment(sbi, segno);
+	do {
+		update_segment_mtime(sbi, addr_start, 0);
+		update_sit_entry(sbi, addr_start, -cnt);
+
+		/* add it into dirty seglist */
+		locate_dirty_segment(sbi, segno);
+
+		/* update @addr_start and @cnt and @segno */
+		addr_start = START_BLOCK(sbi, ++segno);
+		if (++i == seg_num)
+			cnt = GET_BLKOFF_FROM_SEG0(sbi, addr_end) + 1;
+		else
+			cnt = max_blocks;
+	} while (i <= seg_num);
 
 	up_write(&sit_i->sentry_lock);
 }
-- 
2.25.1


