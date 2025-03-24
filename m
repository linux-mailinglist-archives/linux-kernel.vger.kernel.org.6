Return-Path: <linux-kernel+bounces-573580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C33A6D972
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40751892662
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BB25E453;
	Mon, 24 Mar 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEGwTrFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8E25D54B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816983; cv=none; b=XHIKhQOmMtWXCRer9UqVGIFZiQ7xu0KkfRAqksTtWHYx15ZePpKlzuLsIDWNBelqASm+tKb4eII7cK1s6JZ651honrrLHPVP7exfjsNX+diPJpvXnfipwSNCLG4ivCgBbAbZMxD0MMJib5AKMoucwPCEYFlbdijFB/uh/xuQEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816983; c=relaxed/simple;
	bh=gCNyozYEmcRl2t4cfqrGA2O/KEDU2B95MNyZDaGu6sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfESYGXve5tvO8g7gUkt1iY3VuKjf272RreASDJdrcvKu8e/+ye0CrFHfPumGDZ8iRW9+MdD3ue+seP2tguq8tlcbakqq+MweHpmalrzZgLtK8m11ifjVVDfwl20H63GjxwjJmM5S+IWYtlly6JoHC7fmajqe+nsBcSXEqEuUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEGwTrFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3E0C4CEDD;
	Mon, 24 Mar 2025 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742816983;
	bh=gCNyozYEmcRl2t4cfqrGA2O/KEDU2B95MNyZDaGu6sk=;
	h=From:To:Cc:Subject:Date:From;
	b=eEGwTrFglsvgu048gbfD2qvxYtSfbc7mGzX85Z77ForBb3+nVQZB3JlnYO4W6TXzY
	 ET3b8hfOyCbc+MP/wd4M40J6iCxMumTgt17QQsB5JeBLS1ZClFekt2gt6mwXR4sm6F
	 ACJLKT4dj9Aggm43IcbTj1GCQKTsxP0Ix8tWq5/KxQM1bJhMuiLSAOBgDuJiZknSCs
	 Z8Uqq8DrhZ/qB6iw8YylEnND9pPTKpb+Hb5pY5j6XFM3PRrnZ59zdvSb5fd9AIWorQ
	 XHoTA71xSeQP674KwTcO4xWHTx+7nyQ1NeZXMhTMdP8UKSWTL93tXYK17nh7ITrbcT
	 hBdB+IFbLo6mg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: zone: fix to calculate first_zoned_segno correctly
Date: Mon, 24 Mar 2025 19:49:34 +0800
Message-ID: <20250324114935.3087821-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zoned device can has both conventional zones and sequential zones,
so we should not treat first segment of zoned device as first_zoned_segno,
instead, we need to check zone type for each zone during traversing zoned
device to find first_zoned_segno.

Otherwise, for below case, first_zoned_segno will be 0, which could be
wrong.

create_null_blk 512 2 1024 1024
mkfs.f2fs -m /dev/nullb0

Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 18 +++++++++++++-----
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/super.c   | 32 +++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca884e39a5ff..3dea037faa55 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4630,12 +4630,16 @@ F2FS_FEATURE_FUNCS(readonly, RO);
 F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
-				    block_t blkaddr)
+static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
+							unsigned int zone)
 {
-	unsigned int zno = blkaddr / sbi->blocks_per_blkz;
+	return test_bit(zone, FDEV(devi).blkz_seq);
+}
 
-	return test_bit(zno, FDEV(devi).blkz_seq);
+static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
+								block_t blkaddr)
+{
+	return f2fs_zone_is_seq(sbi, devi, blkaddr / sbi->blocks_per_blkz);
 }
 #endif
 
@@ -4711,9 +4715,13 @@ static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
 					  block_t blkaddr)
 {
 	if (f2fs_sb_has_blkzoned(sbi)) {
+#ifdef CONFIG_BLK_DEV_ZONED
 		int devi = f2fs_target_device_index(sbi, blkaddr);
 
-		return !bdev_is_zoned(FDEV(devi).bdev);
+		return !f2fs_blkz_is_seq(sbi, devi, blkaddr);
+#else
+		return true;
+#endif
 	}
 	return true;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 396ef71f41e3..dc360b4b0569 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3311,7 +3311,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
+		err = f2fs_gc_range(sbi, 0, sbi->first_zoned_segno - 1,
 				true, ZONED_PIN_SEC_REQUIRED_COUNT);
 		f2fs_up_write(&sbi->gc_lock);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 011925ee54f8..b2342366020a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4307,12 +4307,26 @@ static void f2fs_record_error_work(struct work_struct *work)
 
 static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sbi)
 {
-	int devi;
+#ifdef CONFIG_BLK_DEV_ZONED
+	unsigned int segno;
+	int devi, i;
 
-	for (devi = 0; devi < sbi->s_ndevs; devi++)
-		if (bdev_is_zoned(FDEV(devi).bdev))
-			return GET_SEGNO(sbi, FDEV(devi).start_blk);
-	return 0;
+	if (!f2fs_sb_has_blkzoned(sbi))
+		return NULL_SEGNO;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++) {
+		if (!bdev_is_zoned(FDEV(devi).bdev))
+			continue;
+
+		segno = GET_SEGNO(sbi, FDEV(devi).start_blk);
+		for (i = 0; i < FDEV(devi).total_segments; i++) {
+			if (f2fs_zone_is_seq(sbi, devi,
+				GET_ZONE_FROM_SEG(sbi, segno + i)))
+				return segno + i;
+		}
+	}
+#endif
+	return NULL_SEGNO;
 }
 
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
@@ -4349,6 +4363,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 #endif
 
 	for (i = 0; i < max_devices; i++) {
+		if (max_devices == 1) {
+			FDEV(i).total_segments =
+				le32_to_cpu(raw_super->segment_count_main);
+			FDEV(i).start_blk = 0;
+			FDEV(i).end_blk = FDEV(i).total_segments *
+						BLKS_PER_SEG(sbi);
+		}
+
 		if (i == 0)
 			FDEV(0).bdev_file = sbi->sb->s_bdev_file;
 		else if (!RDEV(i).path[0])
-- 
2.48.1


