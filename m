Return-Path: <linux-kernel+bounces-205333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9C8FFAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A491C239E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A815B0F2;
	Fri,  7 Jun 2024 04:27:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457FE15A876
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734449; cv=none; b=L2+cbFwFj/2Hl+jVjGjBFx9H8fp+1r7oU5qW20ZaekFQ7Kss3OfuJA4zo4WHIMxGFrZBxwxxmghR9g/+DYXiY9H1a9Ejt77zqCSS/HXtvHcd3abZbb+4kErdi1UlP8+HX6qqUYvvfDSm4gxwZa7nkJW4EoL3uVDM7SMmL7FOtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734449; c=relaxed/simple;
	bh=XQPyQMojxW5RtOF3L7ouQNOfNKX1oIYNKutrjAC9qr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgJ+k+NK5kLjSTfWPDyEzO62pBf0akJLy6BFQmw079baZsEkCt0Nl2pA627X/M3YWBh6puwTPkgqFdM7+IBfSdmOTQRHaFS8i98zdHfax4nDQWs4gUuxk1plOOh2iLocQ1626CsUCIR2xqI3X3ekRGdJPR/xefFSdHly7cl1lSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSk63LHtzwPFT;
	Fri,  7 Jun 2024 12:23:26 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EC5D180AA6;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:06 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 053/110] ubifs-utils: Move ubifs-media.h in libubifs
Date: Fri, 7 Jun 2024 12:25:18 +0800
Message-ID: <20240607042615.2069840-54-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Since ubifs-media.h is only used for ubifs-utils, move it under
ubifs-utils/libubifs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am                           | 4 ++--
 ubifs-utils/common/ubifs.h                          | 2 +-
 {include/mtd => ubifs-utils/libubifs}/ubifs-media.h | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename {include/mtd => ubifs-utils/libubifs}/ubifs-media.h (100%)

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index cb4e1cf1..d297f7a2 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -31,7 +31,7 @@ common_SOURCES = \
 	ubifs-utils/common/lpt.c \
 	ubifs-utils/common/super.c \
 	ubifs-utils/common/sign.h \
-	include/mtd/ubifs-media.h
+	ubifs-utils/libubifs/ubifs-media.h
 
 if WITH_CRYPTO
 common_SOURCES += ubifs-utils/common/crypto.c \
@@ -47,7 +47,7 @@ mkfs_ubifs_SOURCES = \
 
 mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
-	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -rdynamic
+	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -I $(top_srcdir)/ubifs-utils/libubifs -rdynamic
 
 EXTRA_DIST += ubifs-utils/common/README
 
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 5a909f63..ed297cc7 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -25,7 +25,7 @@
 #ifndef __UBIFS_H__
 #define __UBIFS_H__
 
-#include <mtd/ubifs-media.h>
+#include "ubifs-media.h"
 #include "libubi.h"
 
 /* Maximum logical eraseblock size in bytes */
diff --git a/include/mtd/ubifs-media.h b/ubifs-utils/libubifs/ubifs-media.h
similarity index 100%
rename from include/mtd/ubifs-media.h
rename to ubifs-utils/libubifs/ubifs-media.h
-- 
2.13.6


