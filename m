Return-Path: <linux-kernel+bounces-388307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A69B5D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBB0B22104
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1171E0DD5;
	Wed, 30 Oct 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOx+MpUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11E1E0DAA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276229; cv=none; b=Zk88Yow/q+2yKxCRQyskBy7+V3R7b91jbdkvVU6jXayGQDZo/Yv7mNxpCEWyKzZI/mFaRPdEPZ+Gkye45w5ncc7/Qp9CQNAbuEvf+svMfz+XyfdB/DWNQVxUXsl1ZpzwN0hFkhr/tgiGKEgm/RB/g+yDNplvJZZic5Omfc8vShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276229; c=relaxed/simple;
	bh=G0Jc5GwhCoQ+HTn/PbQQjj+Skqf8rx5u84YAdDP62Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cbS5e/7xUasuCrVRwajXfi/dXUPq5dXYVQvPHf6WefYL7K2oYcFkPBQivUW1rCEEkubwhSKXCi3A0qXRKozOPDeq8ziLfMu+J9Kl+xKcTwh5IxrWuOIuxU9cNOMfSYiJtH1+x/CcOcivSNNthlBiTw04mVmnTP0GrXJ5op6NmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOx+MpUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFF5C4CEE4;
	Wed, 30 Oct 2024 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730276229;
	bh=G0Jc5GwhCoQ+HTn/PbQQjj+Skqf8rx5u84YAdDP62Sc=;
	h=From:To:Cc:Subject:Date:From;
	b=dOx+MpUyPE4FK0GEJyZlgAS4dCoAOUAd/yPHA/RxZ2KEqFrsmKs4meZWnlYVnW+ro
	 Cvc45xXgBRoiIaLphFODANzSc4KWr8yeXMTYAX/72+mqMBRsF8MIXQb3NY2dDC1mWO
	 yrcgcsSSy2G+ZUeYv7o+YPVL/g8pfXJC1/qSuPrFjAGp5c4KxrUkPST+udrJps32Bq
	 SOtgsosPs7dw3VHwIzi8ndDiQoa5NOdFrine7xsCklrSjZOsEevtKD9wIPSCtdtmLO
	 U4vibdYffmVUAFYkpC2Nx4Ns7Ax6SkaIZmhVvGyCpuA/p+7bfyAxFZY2HMTWoKo6b1
	 NOn7x/srXUQYw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to convert log type to segment data type correctly
Date: Wed, 30 Oct 2024 16:17:01 +0800
Message-Id: <20241030081701.1853020-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new helper log_type_to_seg_type() to convert
log type to segment data type, and uses it to clean up opened codes
in build_curseg(), and also it fixes to convert log type before use
in do_write_page().

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no logic change, just rebase to last dev-test branch
 fs/f2fs/segment.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a0347a59be6c..279ce3bd6ddd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3833,10 +3833,35 @@ void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 	}
 }
 
+static int log_type_to_seg_type(enum log_type type)
+{
+	int seg_type = CURSEG_COLD_DATA;
+
+	switch (type) {
+	case CURSEG_HOT_DATA:
+	case CURSEG_WARM_DATA:
+	case CURSEG_COLD_DATA:
+	case CURSEG_HOT_NODE:
+	case CURSEG_WARM_NODE:
+	case CURSEG_COLD_NODE:
+		seg_type = (int)type;
+		break;
+	case CURSEG_COLD_DATA_PINNED:
+	case CURSEG_ALL_DATA_ATGC:
+		seg_type = CURSEG_COLD_DATA;
+		break;
+	default:
+		break;
+	}
+	return seg_type;
+}
+
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(fio);
-	bool keep_order = (f2fs_lfs_mode(fio->sbi) && type == CURSEG_COLD_DATA);
+	enum log_type type = __get_segment_type(fio);
+	int seg_type = log_type_to_seg_type(type);
+	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
+				seg_type == CURSEG_COLD_DATA);
 
 	if (keep_order)
 		f2fs_down_read(&fio->sbi->io_order_lock);
@@ -4818,12 +4843,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 				sizeof(struct f2fs_journal), GFP_KERNEL);
 		if (!array[i].journal)
 			return -ENOMEM;
-		if (i < NR_PERSISTENT_LOG)
-			array[i].seg_type = CURSEG_HOT_DATA + i;
-		else if (i == CURSEG_COLD_DATA_PINNED)
-			array[i].seg_type = CURSEG_COLD_DATA;
-		else if (i == CURSEG_ALL_DATA_ATGC)
-			array[i].seg_type = CURSEG_COLD_DATA;
+		array[i].seg_type = log_type_to_seg_type(i);
 		reset_curseg_fields(&array[i]);
 	}
 	return restore_curseg_summaries(sbi);
-- 
2.40.1


