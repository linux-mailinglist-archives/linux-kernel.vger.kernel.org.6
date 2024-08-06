Return-Path: <linux-kernel+bounces-276037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B895948D93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017821F24AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A531C0DCF;
	Tue,  6 Aug 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g4hjkXxn"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A313B2AC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943341; cv=none; b=uX0J7DbQrabk6B0fj/YoSy4wjWpaf3T+lTIBzggmmhELvT96TdOgvTV5+cezbZcF707WlBDm41k9mWDJd/t3Qio4VVtg6varfeUj7eY4ob/t9VaUKNfubbjeleZ/Ti3Xp5GFkaISbdFtGWlSGIUTrXmmyFYy2SiUT7NprfwPA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943341; c=relaxed/simple;
	bh=aaqmlaElTof071/RPXxGsTNi5vU5SclLQP5P+EdQahs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4QGEQlAReq/rJSU6KizA1C3hHBTrqUkJhrORXQ4R4t+9UdGyKIcWYjq2adHHt+fyrOs8GYGSWGWMUUSMdMZR8xns7xqpjp6iAEtzuRYsQrIYMwoagHChK0AV+4aZqyA5CRfjTRAbngWoyurzT2adW+um+RmTAmxrozfqJWw2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g4hjkXxn; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722943331; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WOJsl5d16hB4z/FHaK4q8Q1Y8rTOZLkXiP+T1sEI0QQ=;
	b=g4hjkXxnPlowDJD9r+bHQpEhuAyDAtEofn2X2e0KN7zX//q5/TTdWC4hNrEdHO/a/u4VRN7digQ0vEAv/BRybBdysIU/s1LZneVpJGwJvRpGO2hXcoGN8GQ1BYCUUC0/8HFH+JEQg55kvXnk9RkqUsFPuIg6PTv1mPsMTWaXZvw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WCFH63g_1722943329;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCFH63g_1722943329)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 19:22:10 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: get rid of check_layout_compatibility()
Date: Tue,  6 Aug 2024 19:22:08 +0800
Message-ID: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple enough to just open-code it.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 32ce5b35e1df..6cb5c8916174 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -108,22 +108,6 @@ static void erofs_free_inode(struct inode *inode)
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
-static bool check_layout_compatibility(struct super_block *sb,
-				       struct erofs_super_block *dsb)
-{
-	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
-
-	EROFS_SB(sb)->feature_incompat = feature;
-
-	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
-		erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
-			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
-		return false;
-	}
-	return true;
-}
-
 /* read variable-sized metadata, offset will be aligned by 4-byte */
 void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 			  erofs_off_t *offset, int *lengthp)
@@ -279,7 +263,7 @@ static int erofs_scan_devices(struct super_block *sb,
 
 static int erofs_read_superblock(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
 	void *data;
@@ -291,9 +275,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		return PTR_ERR(data);
 	}
 
-	sbi = EROFS_SB(sb);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err(sb, "cannot find valid erofs superblock");
@@ -318,8 +300,12 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	ret = -EINVAL;
-	if (!check_layout_compatibility(sb, dsb))
+	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
+	if (sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT) {
+		erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
+			  sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
 		goto out;
+	}
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
 	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
-- 
2.43.5


