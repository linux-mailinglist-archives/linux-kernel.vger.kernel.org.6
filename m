Return-Path: <linux-kernel+bounces-388480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E369B6036
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DBB284987
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995EE1E3DEB;
	Wed, 30 Oct 2024 10:32:36 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A61E3DDB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284356; cv=none; b=trgpx3DE/aRX9PzxRR8IjdGetrXo67jwcCFDN6DfLRdWNfM583d090Pq0MXt219dlUVDBDRIKGXvkk4ax8EowqWbH5VcHhnlQrkpdp/DQrC6EXGEhdyXc4F7ED87bQ2miEj1DIQjQIw0nlBslVmMeT+tr7WOYSx5xJ0EW2YVYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284356; c=relaxed/simple;
	bh=w1mWqRHB0QJil4HOZUPCcylnsuCXHH58MP1R2qHBdzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+u5lCGoOTOyqZNOKqsUtbUQtq85b58eSIETJ1kyn/0FxFVQxP2lazOnVLTy06sRkDddnRZVxvSseQ7vVxhYAZaogwBWVXCMP8WY9Z2mnoZhbg7aIwAL8ZQWrcCKPnQsO8WeU8xc9aLsq2NpQzvyr6XvVpG4lzcSMGg4H+pvO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAVixk026962;
	Wed, 30 Oct 2024 18:31:44 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1Q5J9Rz2K4lHM;
	Wed, 30 Oct 2024 18:31:06 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:42 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
Date: Wed, 30 Oct 2024 18:31:35 +0800
Message-ID: <20241030103136.2874140-5-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030103136.2874140-1-yi.sun@unisoc.com>
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 49UAVixk026962

New function can process some consecutive blocks at a time.

Function f2fs_invalidate_blocks()->down_write() and up_write()
are very time-consuming, so if f2fs_invalidate_blocks() can
process consecutive blocks at one time, it will save a lot of time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/compress.c |  4 +--
 fs/f2fs/f2fs.h     |  3 +-
 fs/f2fs/file.c     |  8 +++---
 fs/f2fs/node.c     |  4 +--
 fs/f2fs/segment.c  | 69 ++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e607a7885b57..02ad0ff29cf2 100644
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
index addd49af57ec..4bb459157adf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3716,7 +3716,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
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
index 75a8b22da664..13594bb502d1 100644
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
index af36c6d6542b..db15d6a90f67 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *dn)
 	}
 
 	/* Deallocate node address */
-	f2fs_invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
 	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
@@ -2761,7 +2761,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
 	if (err)
 		return err;
 
-	f2fs_invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
 	dec_valid_node_count(sbi, inode, false);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 92ddff285a65..67f2bfdeb6ec 100644
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
@@ -2558,29 +2558,76 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
-void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
+static void __f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
+					block_t addr, block_t end)
 {
 	unsigned int segno = GET_SEGNO(sbi, addr);
 	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int seg_num = GET_SEGNO(sbi, end) - segno + 1;
+	unsigned int i = 1, max_blocks = sbi->blocks_per_seg, len;
+	block_t addr_start = addr;
 
-	f2fs_bug_on(sbi, addr == NULL_ADDR);
-	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
-		return;
-
-	f2fs_invalidate_internal_cache(sbi, addr, 1);
+	f2fs_invalidate_internal_cache(sbi, addr, end - addr + 1);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
 
-	update_segment_mtime(sbi, addr, 0);
-	update_sit_entry(sbi, addr, -1);
+	if (seg_num == 1)
+		len = end - addr + 1;
+	else
+		len = max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
 
-	/* add it into dirty seglist */
-	locate_dirty_segment(sbi, segno);
+	do {
+		update_segment_mtime(sbi, addr_start, 0);
+		update_sit_entry(sbi, addr_start, -len);
+
+		/* add it into dirty seglist */
+		locate_dirty_segment(sbi, segno);
+
+		/* update @addr_start and @len and @segno */
+		addr_start = START_BLOCK(sbi, ++segno);
+		if (++i == seg_num)
+			len = GET_BLKOFF_FROM_SEG0(sbi, end) + 1;
+		else
+			len = max_blocks;
+	} while (i <= seg_num);
 
 	up_write(&sit_i->sentry_lock);
 }
 
+void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
+				block_t addr, unsigned int len)
+{
+	unsigned int i;
+	/* Temporary record location */
+	block_t addr_start = addr, addr_end;
+
+	if (len == 0)
+		return;
+
+	for (i = 0; i < len; i++) {
+		addr_end = addr + i;
+
+		f2fs_bug_on(sbi, addr_end == NULL_ADDR);
+
+		if (addr_end == NEW_ADDR || addr_end == COMPRESS_ADDR) {
+			if (addr_start == addr_end) {
+				addr_end = addr_start = addr_end + 1;
+				continue;
+			}
+
+			__f2fs_invalidate_blocks(sbi, addr_start, addr_end - 1);
+			addr_end = addr_start = addr_end + 1;
+		}
+	}
+
+	if (addr_end >= (addr + len))
+		return;
+
+	__f2fs_invalidate_blocks(sbi, addr_start, addr_end);
+
+}
+
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-- 
2.25.1


