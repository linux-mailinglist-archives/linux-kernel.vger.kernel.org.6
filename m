Return-Path: <linux-kernel+bounces-553906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2833A59075
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C41716C246
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FE2253EC;
	Mon, 10 Mar 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jMjkmFFl"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057F225765
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600598; cv=none; b=L0ixHy/wk0RxjalWgUGsYC99F1misn+8EZoS0IjZ8P6b/dyTb/Lbrgsv8PiwGP8t/QxBvREGOWyianClnqMyioYTzCNL1IkoyG4AANfppXrdZ6DTO4HS0kO5gb+ZmCLuU0gugOLefO4199x7TN6wLZR7MaRvIewX5tslqXVtVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600598; c=relaxed/simple;
	bh=rPint/XhVsP8Z1f3hHjLyymK3IepZ6F3UIF5xCrRxKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4VEWRmpvCC59p5pg2ru0K9gFd7x4CDsYs9EHwJEAfsBFqz09VBOpYn9+CWoCnAMETpbgUPwMrYKf8hQJRhZIOk3S8MDwFhsrO8r7wqrDcs5ecHCs9H+dBjS++q43F5+dgZoKwhPMHUkCMmYLNAZvblVbdy8TSsYtxyrmU3de9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jMjkmFFl; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=n44x2GIBHkV592zsiETUNG9/RVsDGqeAc5pa7H6OG30=;
	b=jMjkmFFlJMlOOIXZOQerOmrqPvozI0C/77Mr93ATza7N6S3AFtxsLIpYv3NLOsvji7gKe2L7w262dWZOS9qsDY+8JcjYGK7qKdISZ5b0MZt7lhDiLvx0EwdfR2fXbImgBFRuIUG1sjJNzv86pdn31B70EmzMOvL/yfXiG3GeVlM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR0rjXe_1741600587 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:56:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 10/10] erofs: enable 48-bit layout support
Date: Mon, 10 Mar 2025 17:56:25 +0800
Message-ID: <20250310095625.2623817-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both 48-bit block addressing and encoded extents are implemented,
let's enable them formally.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig    | 14 +++++++-------
 fs/erofs/erofs_fs.h |  2 +-
 fs/erofs/super.c    |  2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6ea60661fa55..331e49cd1b8d 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -13,12 +13,12 @@ config EROFS_FS
 	  smartphones with Android OS, LiveCDs and high-density hosts with
 	  numerous containers;
 
-	  It also provides fixed-sized output compression support in order to
-	  improve storage density as well as keep relatively higher compression
-	  ratios and implements in-place decompression to reuse the file page
-	  for compressed data temporarily with proper strategies, which is
-	  quite useful to ensure guaranteed end-to-end runtime decompression
-	  performance under extremely memory pressure without extra cost.
+	  It also provides transparent compression and deduplication support to
+	  improve storage density and maintain relatively high compression
+	  ratios, and it implements in-place decompression to temporarily reuse
+	  page cache for compressed data using proper strategies, which is
+	  quite useful for ensuring guaranteed end-to-end runtime decompression
+	  performance under extreme memory pressure without extra cost.
 
 	  See the documentation at <file:Documentation/filesystems/erofs.rst>
 	  and the web pages at <https://erofs.docs.kernel.org> for more details.
@@ -97,7 +97,7 @@ config EROFS_FS_ZIP
 	select LZ4_DECOMPRESS
 	default y
 	help
-	  Enable fixed-sized output compression for EROFS.
+	  Enable transparent compression support for EROFS file systems.
 
 	  If you don't want to enable compression feature, say N.
 
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 6d461be790bd..9581e9bf8192 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -32,7 +32,7 @@
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0156ee7217c9..a8fc75fd1c74 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -330,6 +330,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	/* handle multiple devices */
 	ret = erofs_scan_devices(sb, dsb);
 
+	if (erofs_sb_has_48bit(sbi))
+		erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
 out:
-- 
2.43.5


