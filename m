Return-Path: <linux-kernel+bounces-367301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72279A009D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEBF1F222C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C518C012;
	Wed, 16 Oct 2024 05:28:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C618BBB3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056524; cv=none; b=g3Dju30cYip83NvoY6JF7wS4Go0D3dif/3yUPbHSUyrdFUv4XWISuqNlOC3L8qEFMJG8kBp8Nmd0Azcq6WDH//ZUdDK0pjoccasZkP/1Nm2Uw4dYKLX1w6FrWgNpx29FQdglGYQHDK0f/Tzk4xRGKmB8Cm+GsVWwBQJOCxPbm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056524; c=relaxed/simple;
	bh=CVlBHkWG4oQoe8tp2EbQksYyuSlSOrKILqqYX17nPCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKed/T1q+0RAMG3AEnpLEqMad+ib+KKpcvuHRPQJdpTQ/Ge4TtrrG2qOmMHUAitGUU/xjrV+cLl+IT3JrQpOagGtzsKRuS0bBMI/z0BQuHZdNVsc2Z7y3qLBEllgrpoqZSmEWikvormdcivQxIliAMu4jFzO3QaeqA+mux40Frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49G5S4Tx033842;
	Wed, 16 Oct 2024 13:28:04 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XSzy30xyXz2SWtk8;
	Wed, 16 Oct 2024 13:27:55 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 16 Oct 2024 13:28:02 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>
CC: <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <sunyibuaa@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH 1/2] f2fs: introduce update_sit_entry_for_release()
Date: Wed, 16 Oct 2024 13:27:57 +0800
Message-ID: <20241016052758.3400359-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016052758.3400359-1-yi.sun@unisoc.com>
References: <20241016052758.3400359-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 49G5S4Tx033842

This function can process some consecutive blocks at a time.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/segment.c | 91 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d91fbd1b27ba..f118faf36d35 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2424,6 +2424,58 @@ static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr,
 		SIT_I(sbi)->max_mtime = ctime;
 }
 
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
 static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 {
 	struct seg_entry *se;
@@ -2479,43 +2531,12 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
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


