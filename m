Return-Path: <linux-kernel+bounces-306533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE308964030
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7782D1F2626C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E518E379;
	Thu, 29 Aug 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UL7hTeEz"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848218DF69
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923928; cv=none; b=nEveY8lUHSFFzPOIIWtysDlRU5Lqpz4QQJ5/SudDFX5b+PU4db/erCFdsEsNavFrqvipC1PivOTNl60J8jOjnpJ7NB+vdPlo3mH9KdppfZVEqj1UHlb3EtZKlHnFYS4ZHNIrBqD1uwgt/oecEhv0dWrspj7wK77JHkq06Iwutr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923928; c=relaxed/simple;
	bh=ExeF5I81GcpVCCpbhCRZIc3k1af/kCmCzzsLHIrPPmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBo2zoUeAOgrbHXI0y/FbKIu3oEJpTHYDVngaoihHuxcv4JCgg1P5YTcIklfi1e18txeZKt9r566iGNgq6ove/Im7bjlxnzvFuuIL8Ks5WdNuS32cYVt5FXJHIzpylSSmQqk27F+cGBEUlbuNxLBxQOQc3XPpeWXgGIETO7tpkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UL7hTeEz; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923923; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KYMFXlqlUBPY+PML64VVWpiuYOErjUusBKS06cHwT8=;
	b=UL7hTeEzQ+B+rRhwXjyo3ozj0rnmvgf/mcg9l4imHO94fD7axiRcRAqVzt3qJ4efIUg0rm/d0bu8fAk+mHvwm5MTyp/oWkt2kbahZO6O9qVgME6a1D1EeWhQnAos0Nt/bLDQ7ootr0z17c43dWD2EXWvBJD4wVSrmu2RGvf0oxc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXS8_1724923604)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs: mark experimental fscache backend deprecated
Date: Thu, 29 Aug 2024 17:26:14 +0800
Message-ID: <20240829092614.2382457-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
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
index 8e92ad3fbead..9bee2c06a4cd 100644
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


