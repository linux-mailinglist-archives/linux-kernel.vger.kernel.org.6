Return-Path: <linux-kernel+bounces-204055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E48FE3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2079B2B0E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB417E8FA;
	Thu,  6 Jun 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYWhVL9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED417DE2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667444; cv=none; b=KdicVArQuY+DMu0LtZ9tOLW87XNu1t/pbHBTwMBbRONAC96P7UFMBCFdHfUQjL1ydaHFoWFpDExTZhE+D7x3u5Srkqcrv5QmKqxF7psauvpTRkz0u4cnCSbiJpvfqqpsfUSqSGfZxwUVPgWp+6RUXZInM0Bl25dIMSiDePaEdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667444; c=relaxed/simple;
	bh=vDQ3PStLIYhurpJfOiarmGGp2OrAZI9nxuIm6i+FjVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cenytAeI06MUuqkFiBF/O6dfV+UQF2p35t7Zlrg8knp1MhYIG+a8mAiHCIaVDWuUjsz3Du4faGfbQQVvehOmy0bDXg781fAkzKc50YG3sJvMho7ujhBTwDZFo3tPnWQ6W3RzazhtNfat8NgkPKUmmKh9J8qqBSvWZn0bDST/mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYWhVL9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88755C4AF10;
	Thu,  6 Jun 2024 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667443;
	bh=vDQ3PStLIYhurpJfOiarmGGp2OrAZI9nxuIm6i+FjVY=;
	h=From:To:Cc:Subject:Date:From;
	b=CYWhVL9sZXFjZbArdYnCVrWQcbpkgfn/D8ZaLF65iMp9YKKCDYFxPFKQ1UqSoqTe9
	 X1YdaF29LohXn7daDhpV6jASPTVHnSdwnkKT7y9t1L3q0Swg14wkbZVoIliygwL6Rk
	 75A8WNwrYh7A8VYJvsW+RSTr0mLj1PXwQOSJZrutxxyOqfmGueH/TUIM9YU+93yj4k
	 fncVWGSFGkWQRvTu7pZv76H1fY9NE7k8HKumckTvnNZQdi2BpVtqwAi9OX1Kz9hA1Q
	 IR8xLIDLFMrCk4rRBXvb1LKeefVoO9GLTOevq4XcVLWI9ZD4swe6ng6/U47oJdxVG5
	 yg455KSEYraUw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] f2fs: get rid of buffer_head use
Date: Thu,  6 Jun 2024 17:50:37 +0800
Message-Id: <20240606095037.4086881-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For later folio conversion.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v1:
- I checked recovery flow of superblock w/ below testcase, it passes.
1. mkfs.f2fs /dev/vdd
2. dd if=/dev/zero of=/dev/vdd bs=4k count=1
3. mount /dev/vdd /mnt/f2fs
4. umount /mnt/f2fs
5. dd if=/dev/zero of=/dev/vdd bs=4k count=1 seek=1
6. mount /dev/vdd /mnt/f2fs
7. umount /mnt/f2fs

 fs/f2fs/data.c  |  1 -
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/file.c  |  1 -
 fs/f2fs/inode.c |  1 -
 fs/f2fs/super.c | 95 ++++++++++++++++++++++++++++++-------------------
 5 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..ad495ea87b32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -7,7 +7,6 @@
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
-#include <linux/buffer_head.h>
 #include <linux/sched/mm.h>
 #include <linux/mpage.h>
 #include <linux/writeback.h>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df332147..5ed6b689f6b3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -11,7 +11,6 @@
 #include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/page-flags.h>
-#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/crc32.h>
 #include <linux/magic.h>
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c50213da474d..efc676bc7800 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -8,7 +8,6 @@
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/stat.h>
-#include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 #include <linux/falloc.h>
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index dbfebbddf675..87982e06bbe7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -7,7 +7,6 @@
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
-#include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
 #include <linux/lz4.h>
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4a1bc8f40f9a..e67f0ac78c00 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -11,7 +11,6 @@
 #include <linux/fs_context.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
-#include <linux/buffer_head.h>
 #include <linux/kthread.h>
 #include <linux/parser.h>
 #include <linux/mount.h>
@@ -3333,24 +3332,45 @@ loff_t max_file_blocks(struct inode *inode)
 	return result;
 }
 
-static int __f2fs_commit_super(struct buffer_head *bh,
-			struct f2fs_super_block *super)
+static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct page *page,
+								bool update)
 {
-	lock_buffer(bh);
-	if (super)
-		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
-
+	struct f2fs_super_block *super;
+	struct bio *bio;
 	/* it's rare case, we can do fua all the time */
-	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA;
+	int ret;
+
+	lock_page(page);
+	if (update) {
+		super = F2FS_RAW_SUPER(sbi);
+		memcpy(page_address(page) + F2FS_SUPER_OFFSET,
+						super, sizeof(*super));
+	}
+	set_page_dirty(page);
+	clear_page_dirty_for_io(page);
+	set_page_writeback(page);
+	unlock_page(page);
+
+	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
+
+	/* it doesn't need to set crypto context for superblock update */
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(page->index);
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
+		f2fs_bug_on(sbi, 1);
+
+	ret = submit_bio_wait(bio);
+	end_page_writeback(page);
+
+	return ret;
 }
 
 static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
-					struct buffer_head *bh)
+							struct page *page)
 {
 	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
-					(bh->b_data + F2FS_SUPER_OFFSET);
+				(page_address(page) + F2FS_SUPER_OFFSET);
 	struct super_block *sb = sbi->sb;
 	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
@@ -3425,7 +3445,7 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
 		} else {
-			err = __f2fs_commit_super(bh, NULL);
+			err = __f2fs_commit_super(sbi, page, false);
 			res = err ? "failed" : "done";
 		}
 		f2fs_info(sbi, "Fix alignment : %s, start(%u) end(%llu) block(%u)",
@@ -3437,13 +3457,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 	return false;
 }
 
-static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
-				struct buffer_head *bh)
+static int sanity_check_raw_super(struct f2fs_sb_info *sbi, struct page *page)
 {
 	block_t segment_count, segs_per_sec, secs_per_zone, segment_count_main;
 	block_t total_sections, blocks_per_seg;
 	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
-					(bh->b_data + F2FS_SUPER_OFFSET);
+				(page_address(page) + F2FS_SUPER_OFFSET);
 	size_t crc_offset = 0;
 	__u32 crc = 0;
 
@@ -3601,7 +3620,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
-	if (sanity_check_area_boundary(sbi, bh))
+	if (sanity_check_area_boundary(sbi, page))
 		return -EFSCORRUPTED;
 
 	return 0;
@@ -3948,7 +3967,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 {
 	struct super_block *sb = sbi->sb;
 	int block;
-	struct buffer_head *bh;
+	struct page *page;
 	struct f2fs_super_block *super;
 	int err = 0;
 
@@ -3957,32 +3976,32 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 		return -ENOMEM;
 
 	for (block = 0; block < 2; block++) {
-		bh = sb_bread(sb, block);
-		if (!bh) {
+		page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping,
+								block, NULL);
+		if (IS_ERR(page)) {
 			f2fs_err(sbi, "Unable to read %dth superblock",
 				 block + 1);
-			err = -EIO;
+			err = PTR_ERR(page);
 			*recovery = 1;
-			continue;
 		}
 
 		/* sanity checking of raw super */
-		err = sanity_check_raw_super(sbi, bh);
+		err = sanity_check_raw_super(sbi, page);
 		if (err) {
 			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
 				 block + 1);
-			brelse(bh);
+			put_page(page);
 			*recovery = 1;
 			continue;
 		}
 
 		if (!*raw_super) {
-			memcpy(super, bh->b_data + F2FS_SUPER_OFFSET,
+			memcpy(super, page_address(page) + F2FS_SUPER_OFFSET,
 							sizeof(*super));
 			*valid_super_block = block;
 			*raw_super = super;
 		}
-		brelse(bh);
+		put_page(page);
 	}
 
 	/* No valid superblock */
@@ -3996,7 +4015,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
-	struct buffer_head *bh;
+	struct page *page;
 	__u32 crc = 0;
 	int err;
 
@@ -4014,22 +4033,24 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	}
 
 	/* write back-up superblock first */
-	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
-	if (!bh)
-		return -EIO;
-	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
-	brelse(bh);
+	page = read_mapping_page(sbi->sb->s_bdev->bd_inode->i_mapping,
+				sbi->valid_super_block ? 0 : 1, NULL);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	err = __f2fs_commit_super(sbi, page, true);
+	put_page(page);
 
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
 
 	/* write current valid superblock */
-	bh = sb_bread(sbi->sb, sbi->valid_super_block);
-	if (!bh)
-		return -EIO;
-	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
-	brelse(bh);
+	page = read_mapping_page(sbi->sb->s_bdev->bd_inode->i_mapping,
+					sbi->valid_super_block, NULL);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	err = __f2fs_commit_super(sbi, page, true);
+	put_page(page);
 	return err;
 }
 
-- 
2.40.1


