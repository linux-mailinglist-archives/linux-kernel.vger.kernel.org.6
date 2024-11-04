Return-Path: <linux-kernel+bounces-394185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B89BAB90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188641C208FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C816C695;
	Mon,  4 Nov 2024 03:46:16 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EB20326
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691976; cv=none; b=WdGnRe+o/LN4wOXZNXhgpzyELm+2BcOrQBnY000fJPIBPm+ws4SReDwmfSL+nqCWsEl32f3EXD6tCSd4+B+V9KcR5rWFlaOKSjd8wxeNpuLRvAtjM6Htw/122nz96Kq80Ec3sG5FGTlZejZ5V3Dys6jrMSs1bRjRUh2h75LdGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691976; c=relaxed/simple;
	bh=+/mKjJn4vmhxxqOvHbpXFbay9dQ90CfcPe1S+iiLcQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLDTXY3ZlW2ltM+UhBssPqnAW2yYtYennc0/XTGx/RnXvnv71aWjpUc9hi/amwEXVLHIQp5I7p+RqkzAKnxorH9mqc3YNsvkL24vcC6Gw/XNSe9qz50VjTPKZZRzbSWN15ko09WP+N+r5cdopDU2Yv6l7002aRoWTZjQ8/wuy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A43jogb085708;
	Mon, 4 Nov 2024 11:45:50 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xhcmb5PkDz2KgRl5;
	Mon,  4 Nov 2024 11:45:03 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 11:45:48 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v3 2/5] f2fs: add parameter @len to f2fs_invalidate_internal_cache()
Date: Mon, 4 Nov 2024 11:45:42 +0800
Message-ID: <20241104034545.497907-3-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4A43jogb085708

New function can process some consecutive blocks at a time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/f2fs.h    | 6 +++---
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/segment.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 306b86b0595d..4f295b6b3c3f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1420,7 +1420,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		return err;
 
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
 
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 	return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b32443d06a3..a1c9341789a1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4756,10 +4756,10 @@ static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
 }
 
 static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
-								block_t blkaddr)
+						block_t blkaddr, unsigned int len)
 {
-	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
-	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
+	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
+	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3e1b6d2ff3a7..7cc7a77d13f6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1412,7 +1412,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				page_address(mpage), PAGE_SIZE);
 	f2fs_put_page(mpage, 1);
 
-	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr);
+	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr, 1);
 
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index edf2a74207b3..5386ae18d808 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2535,7 +2535,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 		return;
 
-	f2fs_invalidate_internal_cache(sbi, addr);
+	f2fs_invalidate_internal_cache(sbi, addr, 1);
 
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
@@ -3855,7 +3855,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto out;
 	}
 	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
-		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
+		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr, 1);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_write(fio);
@@ -4047,7 +4047,7 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		update_sit_entry(sbi, new_blkaddr, 1);
 	}
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
-		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
+		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
 		if (!from_gc)
 			update_segment_mtime(sbi, old_blkaddr, 0);
 		update_sit_entry(sbi, old_blkaddr, -1);
-- 
2.25.1


