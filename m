Return-Path: <linux-kernel+bounces-394187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DC9BAB95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71531F21EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CC17DFEF;
	Mon,  4 Nov 2024 03:46:31 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799D1FC3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691990; cv=none; b=BbFIs5Gl46EI3HroHSiSGVvkEewA0faHNLhHzGml05ogCSAYTq1ZtQ3dyH7jzVrQpwFd5Yqvho2gU0fyxWBcKumVN/2ZhqXC2Cpk+EhlkvYAK6OkeXVCkbkjHjp3xMOlmzFCklxnmtJMfowuk/LUCK0dXy3rc7EXAdY2/ZJAn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691990; c=relaxed/simple;
	bh=Nrjs6qyv5g8jvYKvbjoVq88pJkKPP0bIypa/YBGO2zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUbIZePnrmCUBbigW3NsTmCP+c4LkOKHVDqgMglq1Rci4IBDrD36Z40hm+/zKV1bnoaml34qUS60QG7D0RZEMN4RJooGI5T7MRtNgWqUzeDe67mRHVwVGQX2mCNdUGGlcYV23ShC40Lyl/WCT0MCqD60dFSSl16ABz1C5T1rW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A43jpDt085770;
	Mon, 4 Nov 2024 11:45:51 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xhcmc5CJPz2KgRlB;
	Mon,  4 Nov 2024 11:45:04 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 11:45:49 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v3 3/5] f2fs: introduce update_sit_entry_for_release()
Date: Mon, 4 Nov 2024 11:45:43 +0800
Message-ID: <20241104034545.497907-4-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4A43jpDt085770

This function can process some consecutive blocks at a time.

When using update_sit_entry() to release consecutive blocks,
ensure that the consecutive blocks belong to the same segment.
Because after update_sit_entry_for_realese(), @segno is still
in use in update_sit_entry().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/segment.c | 103 ++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5386ae18d808..843171ce414b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2424,6 +2424,70 @@ static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr,
 		SIT_I(sbi)->max_mtime = ctime;
 }
 
+/*
+ * NOTE: when updating multiple blocks at the same time, please ensure
+ * that the consecutive input blocks belong to the same segment.
+ */
+
+static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_entry *se,
+				block_t blkaddr, unsigned int offset, int del)
+{
+	bool exist;
+#ifdef CONFIG_F2FS_CHECK_FS
+	bool mir_exist;
+#endif
+	int i;
+	int del_count = -del;
+
+	f2fs_bug_on(sbi, GET_SEGNO(sbi, blkaddr) != GET_SEGNO(sbi, blkaddr + del_count - 1));
+
+	for (i = 0; i < del_count; i++) {
+		exist = f2fs_test_and_clear_bit(offset + i, se->cur_valid_map);
+#ifdef CONFIG_F2FS_CHECK_FS
+		mir_exist = f2fs_test_and_clear_bit(offset + i,
+						se->cur_valid_map_mir);
+		if (unlikely(exist != mir_exist)) {
+			f2fs_err(sbi, "Inconsistent error when clearing bitmap, blk:%u, old bit:%d",
+				 blkaddr + i, exist);
+			f2fs_bug_on(sbi, 1);
+		}
+#endif
+		if (unlikely(!exist)) {
+			f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u",
+				 blkaddr + i);
+			f2fs_bug_on(sbi, 1);
+			se->valid_blocks++;
+			del += 1;
+		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			/*
+			 * If checkpoints are off, we must not reuse data that
+			 * was used in the previous checkpoint. If it was used
+			 * before, we must track that to know how much space we
+			 * really have.
+			 */
+			if (f2fs_test_bit(offset + i, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
+				sbi->unusable_block_count++;
+				spin_unlock(&sbi->stat_lock);
+			}
+		}
+
+		if (f2fs_block_unit_discard(sbi) &&
+			f2fs_test_and_clear_bit(offset + i, se->discard_map))
+			sbi->discard_blks++;
+
+		if (!f2fs_test_bit(offset + i, se->ckpt_valid_map))
+			se->ckpt_valid_blocks -= 1;
+	}
+
+	return del;
+}
+
+/*
+ * If releasing blocks, this function supports updating multiple consecutive blocks
+ * at one time, but please note that these consecutive blocks need to belong to the
+ * same segment.
+ */
 static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 {
 	struct seg_entry *se;
@@ -2479,43 +2543,12 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
-	} else {
-		exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-		mir_exist = f2fs_test_and_clear_bit(offset,
-						se->cur_valid_map_mir);
-		if (unlikely(exist != mir_exist)) {
-			f2fs_err(sbi, "Inconsistent error when clearing bitmap, blk:%u, old bit:%d",
-				 blkaddr, exist);
-			f2fs_bug_on(sbi, 1);
-		}
-#endif
-		if (unlikely(!exist)) {
-			f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u",
-				 blkaddr);
-			f2fs_bug_on(sbi, 1);
-			se->valid_blocks++;
-			del = 0;
-		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-			/*
-			 * If checkpoints are off, we must not reuse data that
-			 * was used in the previous checkpoint. If it was used
-			 * before, we must track that to know how much space we
-			 * really have.
-			 */
-			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
-				spin_lock(&sbi->stat_lock);
-				sbi->unusable_block_count++;
-				spin_unlock(&sbi->stat_lock);
-			}
-		}
 
-		if (f2fs_block_unit_discard(sbi) &&
-			f2fs_test_and_clear_bit(offset, se->discard_map))
-			sbi->discard_blks++;
+		if (!f2fs_test_bit(offset, se->ckpt_valid_map))
+			se->ckpt_valid_blocks += del;
+	} else {
+		del = update_sit_entry_for_release(sbi, se, blkaddr, offset, del);
 	}
-	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
-		se->ckpt_valid_blocks += del;
 
 	__mark_sit_entry_dirty(sbi, segno);
 
-- 
2.25.1


