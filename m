Return-Path: <linux-kernel+bounces-307966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C19655AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ED21F2439A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F714A4EA;
	Fri, 30 Aug 2024 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iIs3oOca"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391513635E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988537; cv=none; b=KQfYArq1VKqNSB2oXz5FaQ2bRoP6uEd5NcnEHSaGDVZYNWvhRNeupBiEKMR2YpyDVeSFU5oc8dCbDptpIGi9no10SLxxLpfrOmwLHoKlvTVIFiH5ApMcmQ38opX3jhb6mGaOiVm/u4WaF2Tvrmrer3XTOhki8OkFwZ/NvMozoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988537; c=relaxed/simple;
	bh=khC5vxu2nfERxVWnzpbXz4p0MXKp1tZuKfyaeoCwnM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZC97OVIVICJAaiJlPoGbJpBfiYPoKtQCscMAAj/q5V1DbDVHlbstFqQGS2X9czmJJhqG//I36D4objtrtBhMjF2skh37td5XThC/BSmjNteeLDrOQEQFh0HOKNTMiGYiJFSoftP0EuW88Nuj/AlRM2fFNrH51rrR4fdua9840Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iIs3oOca; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724988532; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R2o1Xvz//mBMciOPxIeDZEVRY86N9pEjsxHkBqVbrhc=;
	b=iIs3oOcaIN2S/tSjBeLaL8FZL5JDbKH+2dxdEP17aCa7TproNwdhLbL/62a3/tqL3m+LQOFS1yLbQz88bNDgzbBtfsuZuBB+cF5Vzs6+fPFDCP6tx3QXMLckmgSLXhzODltZDTOyU8o7FXOkENyPlQbG7zFOv6iHoCbGFVAHOlc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDv3lt0_1724988530)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 11:28:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 4/4] erofs: mark experimental fscache backend deprecated
Date: Fri, 30 Aug 2024 11:28:40 +0800
Message-ID: <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although fscache is still described as "General Filesystem Caching" for
network filesystems and other things such as ISO9660 filesystems, it has
actually become a part of netfslib recently, which was unexpected at the
time when "EROFS over fscache" proposed (2021) since EROFS is entirely a
disk filesystem and the dependency is redundant.

Mark it deprecated and it will be removed after "fanotify pre-content
hooks" lands, which will provide the same functionality for EROFS.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig | 5 ++++-
 fs/erofs/super.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1428d0530e1c..6ea60661fa55 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -145,7 +145,7 @@ config EROFS_FS_ZIP_ZSTD
 	  If unsure, say N.
 
 config EROFS_FS_ONDEMAND
-	bool "EROFS fscache-based on-demand read support"
+	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
 	select NETFS_SUPPORT
 	select FSCACHE
@@ -155,6 +155,9 @@ config EROFS_FS_ONDEMAND
 	  This permits EROFS to use fscache-backed data blobs with on-demand
 	  read support.
 
+	  It is now deprecated and scheduled to be removed from the kernel
+	  after fanotify pre-content hooks are landed.
+
 	  If unsure, say N.
 
 config EROFS_FS_PCPU_KTHREAD
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9a7e67eceed4..666873f745da 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -353,7 +353,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_is_fscache_mode(sb))
-		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
-- 
2.43.5


