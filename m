Return-Path: <linux-kernel+bounces-371026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A619A3553
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5908FB212DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D57184523;
	Fri, 18 Oct 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM+rKPOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F32BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232808; cv=none; b=tz2Ap2EPkQZY1nUT7Mzan3oWqHe/NFy3CpRKEAbxQAdz2xLtDUGjs7MGhwaWL+fAXsSMagAdPc5yuXS4S5HDaNKqNTatsMQBRQ1VbUW43QeriAds39dO2lMwZA3VFgbvIuf4u7oq/ldsc8wjc/O0mzy+aSprk4q4Vfwy6Bb+0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232808; c=relaxed/simple;
	bh=7A5TJzuMgQQEj4Vo64PmUWu+4ittU4tPXAhcTNhgg34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GcNp6HCd+8SkpOVG671kOpiifg8HhzISApqyOJwBcBCUhpUgB7td5DjQy3FnEm8IfbmcaGlgeN+9o16Ro4hEDUnHmE4pV+d+8TAeKJgKLKplFW9GFJ3lMygEqZ76QNYdFru06RV1FSQRDzdl/+qFscTdeDwaNHmuM6//LdsJ2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM+rKPOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F1BC4CEC3;
	Fri, 18 Oct 2024 06:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729232807;
	bh=7A5TJzuMgQQEj4Vo64PmUWu+4ittU4tPXAhcTNhgg34=;
	h=From:To:Cc:Subject:Date:From;
	b=BM+rKPOtJFDR0IWOy4FPyKzGJpuEhlqEZ8wuFwvOPXpmK9MthKCfKt6uvzNu2cUQY
	 zk6yr4UpqlEqiL540qO0Eh2MXMtSN0RWIR+f5ZBvVIkCW6YQXws6t7i2ZFEJMgumd5
	 BlLPhkrdhpue8Gf8nHYEB9n+ViSsRPxjj7S1joP/HhpNixP2iD75UafIkvHZ1Zyubn
	 XLveugqEiT61zshvJFbDVaD2ArVIzt5CAC1rCKzWM/lH8CtVgRp00teB4yzS2+HqYn
	 0kXytu7s3oDgs7TSLmf+k7IRSdaxGqH75dkuU641TNWWv26S4XFgY8yhnt+ZiI31oQ
	 umY+LU34eddag==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: zone: introduce first_zoned_segno in f2fs_sb_info
Date: Fri, 18 Oct 2024 14:26:36 +0800
Message-Id: <20241018062638.2619214-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

first_zoned_segno() returns a fixed value, let's cache it in
structure f2fs_sb_info to avoid redundant calculation.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/segment.h | 10 ----------
 fs/f2fs/super.c   | 13 +++++++++++++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0ff7f2812312..55bcd411257a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1760,6 +1760,7 @@ struct f2fs_sb_info {
 	unsigned int dirty_device;		/* for checkpoint data flush */
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
+	unsigned int first_zoned_segno;		/* first zoned segno */
 
 	/* For write statistics */
 	u64 sectors_written_start;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e1003e262184..a1806976f4ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2732,7 +2732,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
 			segno = 0;
 		else
-			segno = max(first_zoned_segno(sbi), *newseg);
+			segno = max(sbi->first_zoned_segno, *newseg);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
 #endif
@@ -2744,7 +2744,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
 		/* Write only to sequential zones */
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
-			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			hint = GET_SEC_FROM_SEG(sbi, sbi->first_zoned_segno);
 			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 		} else
 			secno = find_first_zero_bit(free_i->free_secmap,
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index cd6325f3b9ca..838c436266f4 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -971,13 +971,3 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 	dcc->discard_wake = true;
 	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
-
-static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
-{
-	int devi;
-
-	for (devi = 0; devi < sbi->s_ndevs; devi++)
-		if (bdev_is_zoned(FDEV(devi).bdev))
-			return GET_SEGNO(sbi, FDEV(devi).start_blk);
-	return 0;
-}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0d96e352b4ac..9325d8dc7f7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4223,6 +4223,16 @@ static void f2fs_record_error_work(struct work_struct *work)
 	f2fs_record_stop_reason(sbi);
 }
 
+static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sbi)
+{
+	int devi;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++)
+		if (bdev_is_zoned(FDEV(devi).bdev))
+			return GET_SEGNO(sbi, FDEV(devi).start_blk);
+	return 0;
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -4623,6 +4633,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
 
+	/* get segno of first zoned block device */
+	sbi->first_zoned_segno = get_first_zoned_segno(sbi);
+
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	if (__exist_node_summaries(sbi))
-- 
2.40.1


