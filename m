Return-Path: <linux-kernel+bounces-205803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F7900082
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796561F213A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172B15A4B0;
	Fri,  7 Jun 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6beQo6V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110C433C7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755516; cv=none; b=ARvviFpPDuJXKLmtrTd5Q9yp2GW+ly+NTnZUCAIqhrN2U7r6rMos5wuLYH2VGMjuVI/S+c4ThLQuWTdLXzrBF6fGExCRy3G77rVV1VHrwl+17iWfffQzwYujl52ojCSqCcg5ya/lzNWLnGw+KT2A/d90QqX8qZ3/qScSSdF928s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755516; c=relaxed/simple;
	bh=TW2wiTfuTlbYUnpER0Vim/g+rQKIAPfrDih2M9Ix9Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCPQf8hHB6oISvW00JU00AytRboq1c5dL9YUac/1eIthC1Gn1pcksd8hMSmqnnRtXtjbHNU/IJNiTdfK1omhgst1JPK8dYQm/3Yi2QCtkeLe7ByA/W2lkHfZlyiryL5zMdMjjrknUyF2mzxfS8vPfdI1BeBfI+rVcXZwWzLD7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6beQo6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07FC2BBFC;
	Fri,  7 Jun 2024 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755516;
	bh=TW2wiTfuTlbYUnpER0Vim/g+rQKIAPfrDih2M9Ix9Ac=;
	h=From:To:Cc:Subject:Date:From;
	b=k6beQo6VAwPxVAevZapDPBPbidCRK3/WHQM8luCpgrWAljreQMyI6Ox2oza1bs/+0
	 bTCbD8/u7wYMtyre5V6TehFIt3y7be2MWU70oyXWa3K7PQLExmJMWU1UgWDa+zOeJQ
	 F2NQ1kH/e/wCm67sQQtlm6l134HELjqUFty9xhHIfyEeehEEwkzjjhjnSObYFVSqGY
	 U4L/tLd7A/rTdrVctl/Gxpwfri5CyuEdiMpFuJ7O4eH4ct3cx+DIcHw2dpDoF0aWkS
	 spBEbAU8/IhKyPJYFdSig7COjPITkFeFKsy/9Y8CM+zQnMIereC3Xc0aRFaTgvx4SB
	 t55Bu2G4CiMDA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] f2fs: get rid of buffer_head use
Date: Fri,  7 Jun 2024 18:18:29 +0800
Message-Id: <20240607101829.389015-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio and related functionality.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- convert to use folio rather than page suggested by Matthew.
 fs/f2fs/data.c  |  1 -
 fs/f2fs/f2fs.h  |  7 +++-
 fs/f2fs/file.c  |  1 -
 fs/f2fs/inode.c |  1 -
 fs/f2fs/super.c | 94 +++++++++++++++++++++++++++++--------------------
 5 files changed, 62 insertions(+), 42 deletions(-)

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
index 9688df332147..c82d2050890d 100644
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
@@ -1990,6 +1989,12 @@ static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 	return (struct f2fs_super_block *)(sbi->raw_super);
 }
 
+static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio)
+{
+	return (struct f2fs_super_block *)(page_address(folio_page(folio, 0)) +
+							F2FS_SUPER_OFFSET);
+}
+
 static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_checkpoint *)(sbi->ckpt);
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
index 4a1bc8f40f9a..f14eba4cbbf7 100644
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
@@ -3333,24 +3332,42 @@ loff_t max_file_blocks(struct inode *inode)
 	return result;
 }
 
-static int __f2fs_commit_super(struct buffer_head *bh,
-			struct f2fs_super_block *super)
+static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
+								bool update)
 {
-	lock_buffer(bh);
-	if (super)
-		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
-
+	struct bio *bio;
 	/* it's rare case, we can do fua all the time */
-	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA;
+	int ret;
+
+	folio_lock(folio);
+	folio_wait_writeback(folio);
+	if (update)
+		memcpy(F2FS_SUPER_BLOCK(folio), F2FS_RAW_SUPER(sbi),
+					sizeof(struct f2fs_super_block));
+	folio_mark_dirty(folio);
+	folio_clear_dirty_for_io(folio);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
+
+	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
+
+	/* it doesn't need to set crypto context for superblock update */
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(folio_index(folio));
+
+	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
+		f2fs_bug_on(sbi, 1);
+
+	ret = submit_bio_wait(bio);
+	folio_end_writeback(folio);
+
+	return ret;
 }
 
 static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
-					struct buffer_head *bh)
+							struct folio *folio)
 {
-	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
-					(bh->b_data + F2FS_SUPER_OFFSET);
+	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio);
 	struct super_block *sb = sbi->sb;
 	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
@@ -3425,7 +3442,7 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
 		} else {
-			err = __f2fs_commit_super(bh, NULL);
+			err = __f2fs_commit_super(sbi, folio, false);
 			res = err ? "failed" : "done";
 		}
 		f2fs_info(sbi, "Fix alignment : %s, start(%u) end(%llu) block(%u)",
@@ -3438,12 +3455,11 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 }
 
 static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
-				struct buffer_head *bh)
+						struct folio *folio)
 {
 	block_t segment_count, segs_per_sec, secs_per_zone, segment_count_main;
 	block_t total_sections, blocks_per_seg;
-	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
-					(bh->b_data + F2FS_SUPER_OFFSET);
+	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio);
 	size_t crc_offset = 0;
 	__u32 crc = 0;
 
@@ -3601,7 +3617,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
-	if (sanity_check_area_boundary(sbi, bh))
+	if (sanity_check_area_boundary(sbi, folio))
 		return -EFSCORRUPTED;
 
 	return 0;
@@ -3948,7 +3964,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 {
 	struct super_block *sb = sbi->sb;
 	int block;
-	struct buffer_head *bh;
+	struct folio *folio;
 	struct f2fs_super_block *super;
 	int err = 0;
 
@@ -3957,32 +3973,32 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 		return -ENOMEM;
 
 	for (block = 0; block < 2; block++) {
-		bh = sb_bread(sb, block);
-		if (!bh) {
+		folio = read_mapping_folio(sb->s_bdev->bd_inode->i_mapping,
+								block, NULL);
+		if (IS_ERR(folio)) {
 			f2fs_err(sbi, "Unable to read %dth superblock",
 				 block + 1);
-			err = -EIO;
+			err = PTR_ERR(folio);
 			*recovery = 1;
 			continue;
 		}
 
 		/* sanity checking of raw super */
-		err = sanity_check_raw_super(sbi, bh);
+		err = sanity_check_raw_super(sbi, folio);
 		if (err) {
 			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
 				 block + 1);
-			brelse(bh);
+			folio_put(folio);
 			*recovery = 1;
 			continue;
 		}
 
 		if (!*raw_super) {
-			memcpy(super, bh->b_data + F2FS_SUPER_OFFSET,
-							sizeof(*super));
+			memcpy(super, F2FS_SUPER_BLOCK(folio), sizeof(*super));
 			*valid_super_block = block;
 			*raw_super = super;
 		}
-		brelse(bh);
+		folio_put(folio);
 	}
 
 	/* No valid superblock */
@@ -3996,7 +4012,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
-	struct buffer_head *bh;
+	struct folio *folio;
 	__u32 crc = 0;
 	int err;
 
@@ -4014,22 +4030,24 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	}
 
 	/* write back-up superblock first */
-	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
-	if (!bh)
-		return -EIO;
-	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
-	brelse(bh);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_inode->i_mapping,
+				sbi->valid_super_block ? 0 : 1, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	err = __f2fs_commit_super(sbi, folio, true);
+	folio_put(folio);
 
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
 
 	/* write current valid superblock */
-	bh = sb_bread(sbi->sb, sbi->valid_super_block);
-	if (!bh)
-		return -EIO;
-	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
-	brelse(bh);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_inode->i_mapping,
+					sbi->valid_super_block, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	err = __f2fs_commit_super(sbi, folio, true);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.40.1


