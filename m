Return-Path: <linux-kernel+bounces-442523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68D9EDDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8587167D74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8913D52B;
	Thu, 12 Dec 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CSYMEVdF"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104918643
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733971196; cv=none; b=B5KU4I0JEMUUWJyN8L2Z5Pz0w1svQdevlAea92ItaFvKVFu2Rx7tUc55+PXgz95p83qDRG/lgSY9S3J8cI6gJVxn/6GC5HLPFm33kdhAbtM9yYdyMkbvCBrd3gaJ9rW5IB0HhUpAIaRGN64zQJMzSzpAyvRU/VVEylxlLPjpN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733971196; c=relaxed/simple;
	bh=PH/HPH5qEjtvASdTMHwhsYCijcX0WeqTdbGf669KTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCpFBE8mvEpzrJzPs6OfqTqT7zLAFVzpVKO2fxy+Tu34e2QGH0Iq3TMhAfaeiFXWh7heF0kFKC/oE7BlOIqiOq5fyyOOiDfRvs3zSYCuXSM6YV/uVbc83i0S8Jq2RPlHNv/iXGn0JbcH3fjEyZGMwNtbcxTPzqZCKTfXcAQBgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CSYMEVdF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733971190; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zvwBAjm4sRjF6VmYTwkZE+OC+nmPpYLZaHaDGt4Pxe8=;
	b=CSYMEVdF0qe4vjOQpA39oYnUP2DIvK7Fk9N1I2KSzcUE3Ga9ANP+qhd7ZUOgiQEw/cy23SRzi7ja4J5K7R98gxp4KWk5UOHvTagbHpLvhzj+101xyCMRkbz1pEfIfsBBGCm9WSikJLg6DMyQvyuuPwYO1nRRdfI0bDAoC9dl8sw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLK-wx5_1733971189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 10:39:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH RESEND] erofs: micro-optimize superblock checksum
Date: Thu, 12 Dec 2024 10:39:48 +0800
Message-ID: <20241212023948.1143038-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
References: <20241212023737.1138989-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just verify the remaining unknown on-disk data instead of allocating a
temporary buffer for the whole superblock and zeroing out the checksum
field since .magic(EROFS_SUPER_MAGIC_V1) is verified and .checksum(0)
is fixed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  3 ++-
 fs/erofs/super.c    | 30 +++++++++++-------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index c8f2ae845bd2..199395ed1c1f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -9,6 +9,7 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
+/* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
@@ -54,7 +55,7 @@ struct erofs_deviceslot {
 /* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
-	__le32 checksum;        /* crc32c(super_block) */
+	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
 	__le32 feature_compat;
 	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9166054370aa..faf1506c47f5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -39,29 +39,21 @@ void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-	size_t len = 1 << EROFS_SB(sb)->blkszbits;
-	struct erofs_super_block *dsb;
-	u32 expected_crc, crc;
+	struct erofs_super_block *dsb = sbdata + EROFS_SUPER_OFFSET;
+	u32 len = 1 << EROFS_SB(sb)->blkszbits, crc;
 
 	if (len > EROFS_SUPER_OFFSET)
 		len -= EROFS_SUPER_OFFSET;
+	len -= offsetof(struct erofs_super_block, checksum) +
+			sizeof(dsb->checksum);
 
-	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
-	if (!dsb)
-		return -ENOMEM;
-
-	expected_crc = le32_to_cpu(dsb->checksum);
-	dsb->checksum = 0;
-	/* to allow for x86 boot sectors and other oddities. */
-	crc = crc32c(~0, dsb, len);
-	kfree(dsb);
-
-	if (crc != expected_crc) {
-		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
-			  crc, expected_crc);
-		return -EBADMSG;
-	}
-	return 0;
+	/* skip .magic(pre-verified) and .checksum(0) fields */
+	crc = crc32c(0x5045B54A, (&dsb->checksum) + 1, len);
+	if (crc == le32_to_cpu(dsb->checksum))
+		return 0;
+	erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
+		  crc, le32_to_cpu(dsb->checksum));
+	return -EBADMSG;
 }
 
 static void erofs_inode_init_once(void *ptr)
-- 
2.43.5


