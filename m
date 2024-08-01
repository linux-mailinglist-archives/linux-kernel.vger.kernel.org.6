Return-Path: <linux-kernel+bounces-270500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015C9440CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97928B2D23E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACD1A3BCE;
	Thu,  1 Aug 2024 01:36:26 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED11A38F5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476186; cv=none; b=DLJSi3GJ5Lw4FEKrbG8pNjU/bQJTyLfeHzgNabfLE+I3re9qQebAdAzT/MzNOpO++a29kZYYM5cuOnZBe3LSbh2AmMtn7LmWEHX/7ul+FEWy46apSiSBT94aMjZquifSeJROtS53j7kmuW3DE2ZZxt86BUhN+8KqqS2eVqT3NHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476186; c=relaxed/simple;
	bh=697mVutHsKW1pMq0+PVbYa6Uyloscwt9252oykAczQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEbxX3tMxYOaQBjf2PlRGn6KYeLCxDX/9Nn1XxOrqIYrJi9tAaThlyer1KX8l62tFTAcdomgdCgs45CSznBSLvbyiKxnTv6U/t0sC1VRj83nyLrlgoILA5dq/w4LVT46LXPaUbLCrWnsmuT6+O+fTL84SUdQheXPnmsUzsT0a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4711YTAU036418;
	Thu, 1 Aug 2024 09:34:29 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WZBDz2gzhz2M40TH;
	Thu,  1 Aug 2024 09:28:35 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 1 Aug 2024 09:34:26 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
Date: Thu, 1 Aug 2024 09:33:51 +0800
Message-ID: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4711YTAU036418

Use F2FS_BYTES_TO_BLK(bytes) and F2FS_BLK_TO_BYTES(blk) for cleanup

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/checkpoint.c    | 2 +-
 fs/f2fs/debug.c         | 2 +-
 fs/f2fs/file.c          | 6 +++---
 fs/f2fs/node.c          | 4 ++--
 fs/f2fs/super.c         | 2 +-
 include/linux/f2fs_fs.h | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bdd9632..f3d22b8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1551,7 +1551,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		blk = start_blk + BLKS_PER_SEG(sbi) - nm_i->nat_bits_blocks;
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
 			f2fs_update_meta_page(sbi, nm_i->nat_bits +
-					(i << F2FS_BLKSIZE_BITS), blk + i);
+					F2FS_BLK_TO_BYTES(i), blk + i);
 	}
 
 	/* write out checkpoint buffer at block 0 */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8b0e1e7..546b8ba 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -275,7 +275,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	/* build nm */
 	si->base_mem += sizeof(struct f2fs_nm_info);
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
-	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
+	si->base_mem += F2FS_BLK_TO_BYTES(NM_I(sbi)->nat_bits_blocks);
 	si->base_mem += NM_I(sbi)->nat_blocks *
 				f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK);
 	si->base_mem += NM_I(sbi)->nat_blocks / 8;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 41ef3ad..7709aed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2984,9 +2984,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	f2fs_lock_op(sbi);
-	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
-				pos_out >> F2FS_BLKSIZE_BITS,
-				len >> F2FS_BLKSIZE_BITS, false);
+	ret = __exchange_data_block(src, dst, F2FS_BYTES_TO_BLK(pos_in),
+				F2FS_BYTES_TO_BLK(pos_out),
+				F2FS_BYTES_TO_BLK(len), false);
 
 	if (!ret) {
 		if (dst_max_i_size)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2fe182f..9e7a6e2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3166,7 +3166,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 
 	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kvzalloc(sbi,
-			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
+			F2FS_BLK_TO_BYTES(nm_i->nat_bits_blocks), GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;
 
@@ -3185,7 +3185,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
+		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(i),
 					page_address(page), F2FS_BLKSIZE);
 		f2fs_put_page(page, 1);
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4d2f3bb..977f038 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3317,7 +3317,7 @@ loff_t max_file_blocks(struct inode *inode)
 	 * fit within U32_MAX + 1 data units.
 	 */
 
-	result = min(result, (((loff_t)U32_MAX + 1) * 4096) >> F2FS_BLKSIZE_BITS);
+	result = min(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));
 
 	return result;
 }
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 01bee2b..f17f89a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -19,7 +19,6 @@
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
-#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) >> F2FS_BLKSIZE_BITS)
 
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
@@ -28,6 +27,7 @@
 #define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
+#define F2FS_BLK_ALIGN(x)			(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
 
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
-- 
1.9.1


