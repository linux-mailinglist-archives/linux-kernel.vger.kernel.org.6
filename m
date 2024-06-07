Return-Path: <linux-kernel+bounces-205287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115798FFA75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82041C2320D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425E61FF8;
	Fri,  7 Jun 2024 04:26:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2045008
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734398; cv=none; b=tH4C8tp39+FimqLX99usHOfMsRIqJurFtTMeE0SZ2Tp8vH74YPnnRBPPuDTeArWIsQj3eyhZhFcxaFhiAvgmYPT1l2iEfS+int8x+WaLZA/CzDevZwPUAH2Bzfir60FQp0a7lcrTh9VbK69zAaiWaueakmRFPLszMgawENiacMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734398; c=relaxed/simple;
	bh=N1kMbC809g9N89SKDSnoM9aFHraXb0mrjQPnV7B4QX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABaljtE9F7ofEyIuf/up02jkcj709hQ+rue7yCt4FqZ6KyquVBPvarkSrRZPsJINOYfv64UjNAJ5YiBJ5EeLxpkjWXuA8LtpM3/LKUTXlY/b4H+nJ9TEjcGGiHteFKY2vApJoCUyL3ZwXmoCrxV2JTUz8vhgy9jFojU1uFSsnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShK3nCLzmYL0;
	Fri,  7 Jun 2024 12:21:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B24D140427;
	Fri,  7 Jun 2024 12:26:29 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:28 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 003/110] ubifs-utils: Split common source files from mkfs.ubifs
Date: Fri, 7 Jun 2024 12:24:28 +0800
Message-ID: <20240607042615.2069840-4-chengzhihao1@huawei.com>
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

Split common source files into common dir from mkfs.ubifs, this is a
preparation for importing libubifs(from linux kernel) to replace
current UBIFS libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am                          | 57 ++++++++++++----------
 ubifs-utils/{mkfs.ubifs => common}/README          |  2 +-
 ubifs-utils/{mkfs.ubifs => common}/compr.c         |  0
 ubifs-utils/{mkfs.ubifs => common}/compr.h         |  0
 ubifs-utils/{mkfs.ubifs => common}/crc16.c         |  0
 ubifs-utils/{mkfs.ubifs => common}/crc16.h         |  0
 ubifs-utils/{mkfs.ubifs => common}/crypto.c        |  0
 ubifs-utils/{mkfs.ubifs => common}/crypto.h        |  0
 ubifs-utils/{mkfs.ubifs => common}/defs.h          |  0
 ubifs-utils/{mkfs.ubifs => common}/devtable.c      |  0
 ubifs-utils/{mkfs.ubifs => common}/fscrypt.c       |  0
 ubifs-utils/{mkfs.ubifs => common}/fscrypt.h       |  0
 .../{mkfs.ubifs => common}/hashtable/hashtable.c   |  0
 .../{mkfs.ubifs => common}/hashtable/hashtable.h   |  0
 .../hashtable/hashtable_itr.c                      |  0
 .../hashtable/hashtable_itr.h                      |  0
 .../hashtable/hashtable_private.h                  |  0
 ubifs-utils/{mkfs.ubifs => common}/key.h           |  0
 ubifs-utils/{mkfs.ubifs => common}/lpt.c           |  0
 ubifs-utils/{mkfs.ubifs => common}/lpt.h           |  0
 ubifs-utils/{mkfs.ubifs => common}/sign.c          |  0
 ubifs-utils/{mkfs.ubifs => common}/sign.h          |  0
 ubifs-utils/{mkfs.ubifs => common}/ubifs.h         |  0
 23 files changed, 31 insertions(+), 28 deletions(-)
 rename ubifs-utils/{mkfs.ubifs => common}/README (91%)
 rename ubifs-utils/{mkfs.ubifs => common}/compr.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/compr.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crc16.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crc16.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crypto.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crypto.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/defs.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/devtable.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/fscrypt.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/fscrypt.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_itr.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_itr.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_private.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/key.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/lpt.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/lpt.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/sign.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/sign.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/ubifs.h (100%)

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 6814d47b..4a617c19 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -1,37 +1,40 @@
-mkfs_ubifs_SOURCES = \
-	ubifs-utils/mkfs.ubifs/mkfs.ubifs.c \
-	ubifs-utils/mkfs.ubifs/defs.h \
-	ubifs-utils/mkfs.ubifs/lpt.h \
-	ubifs-utils/mkfs.ubifs/mkfs.ubifs.h \
-	ubifs-utils/mkfs.ubifs/crc16.h \
-	ubifs-utils/mkfs.ubifs/key.h \
-	ubifs-utils/mkfs.ubifs/compr.h \
-	ubifs-utils/mkfs.ubifs/ubifs.h \
-	ubifs-utils/mkfs.ubifs/sign.h \
-	ubifs-utils/mkfs.ubifs/crc16.c \
-	ubifs-utils/mkfs.ubifs/lpt.c \
-	ubifs-utils/mkfs.ubifs/compr.c \
-	ubifs-utils/mkfs.ubifs/hashtable/hashtable.h \
-	ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.h \
-	ubifs-utils/mkfs.ubifs/hashtable/hashtable_private.h \
-	ubifs-utils/mkfs.ubifs/hashtable/hashtable.c \
-	ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.c \
-	ubifs-utils/mkfs.ubifs/devtable.c \
+common_SOURCES = \
+	ubifs-utils/common/defs.h \
+	ubifs-utils/common/crc16.h \
+	ubifs-utils/common/crc16.c \
+	ubifs-utils/common/compr.h \
+	ubifs-utils/common/compr.c \
+	ubifs-utils/common/hashtable/hashtable.h \
+	ubifs-utils/common/hashtable/hashtable_itr.h \
+	ubifs-utils/common/hashtable/hashtable_private.h \
+	ubifs-utils/common/hashtable/hashtable.c \
+	ubifs-utils/common/hashtable/hashtable_itr.c \
+	ubifs-utils/common/devtable.c \
+	ubifs-utils/common/ubifs.h \
+	ubifs-utils/common/key.h \
+	ubifs-utils/common/lpt.h \
+	ubifs-utils/common/lpt.c \
+	ubifs-utils/common/sign.h \
 	include/mtd/ubifs-media.h
 
 if WITH_CRYPTO
-mkfs_ubifs_SOURCES += ubifs-utils/mkfs.ubifs/crypto.c \
-		ubifs-utils/mkfs.ubifs/crypto.h \
-		ubifs-utils/mkfs.ubifs/fscrypt.c \
-		ubifs-utils/mkfs.ubifs/fscrypt.h \
-		ubifs-utils/mkfs.ubifs/sign.c
+common_SOURCES += ubifs-utils/common/crypto.c \
+		ubifs-utils/common/crypto.h \
+		ubifs-utils/common/fscrypt.c \
+		ubifs-utils/common/fscrypt.h \
+		ubifs-utils/common/sign.c
 endif
 
+mkfs_ubifs_SOURCES = \
+	$(common_SOURCES) \
+	ubifs-utils/mkfs.ubifs/mkfs.ubifs.h \
+	ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+
 mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm
-mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS)\
-	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/mkfs.ubifs/
+mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
+	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/mkfs.ubifs/ -I$(top_srcdir)/ubifs-utils/common
 
-EXTRA_DIST += ubifs-utils/mkfs.ubifs/README
+EXTRA_DIST += ubifs-utils/common/README
 
 dist_sbin_SCRIPTS = ubifs-utils/mount.ubifs
 
diff --git a/ubifs-utils/mkfs.ubifs/README b/ubifs-utils/common/README
similarity index 91%
rename from ubifs-utils/mkfs.ubifs/README
rename to ubifs-utils/common/README
index 7e199390..8c10fd4b 100644
--- a/ubifs-utils/mkfs.ubifs/README
+++ b/ubifs-utils/common/README
@@ -1,4 +1,4 @@
-UBIFS File System - Make File System program
+Common Library
 
 * crc16.h and crc16.c were copied from the linux kernel.
 * crc32.h and crc32.c were copied from mtd-utils and amended.
diff --git a/ubifs-utils/mkfs.ubifs/compr.c b/ubifs-utils/common/compr.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/compr.c
rename to ubifs-utils/common/compr.c
diff --git a/ubifs-utils/mkfs.ubifs/compr.h b/ubifs-utils/common/compr.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/compr.h
rename to ubifs-utils/common/compr.h
diff --git a/ubifs-utils/mkfs.ubifs/crc16.c b/ubifs-utils/common/crc16.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/crc16.c
rename to ubifs-utils/common/crc16.c
diff --git a/ubifs-utils/mkfs.ubifs/crc16.h b/ubifs-utils/common/crc16.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/crc16.h
rename to ubifs-utils/common/crc16.h
diff --git a/ubifs-utils/mkfs.ubifs/crypto.c b/ubifs-utils/common/crypto.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/crypto.c
rename to ubifs-utils/common/crypto.c
diff --git a/ubifs-utils/mkfs.ubifs/crypto.h b/ubifs-utils/common/crypto.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/crypto.h
rename to ubifs-utils/common/crypto.h
diff --git a/ubifs-utils/mkfs.ubifs/defs.h b/ubifs-utils/common/defs.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/defs.h
rename to ubifs-utils/common/defs.h
diff --git a/ubifs-utils/mkfs.ubifs/devtable.c b/ubifs-utils/common/devtable.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/devtable.c
rename to ubifs-utils/common/devtable.c
diff --git a/ubifs-utils/mkfs.ubifs/fscrypt.c b/ubifs-utils/common/fscrypt.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/fscrypt.c
rename to ubifs-utils/common/fscrypt.c
diff --git a/ubifs-utils/mkfs.ubifs/fscrypt.h b/ubifs-utils/common/fscrypt.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/fscrypt.h
rename to ubifs-utils/common/fscrypt.h
diff --git a/ubifs-utils/mkfs.ubifs/hashtable/hashtable.c b/ubifs-utils/common/hashtable/hashtable.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/hashtable/hashtable.c
rename to ubifs-utils/common/hashtable/hashtable.c
diff --git a/ubifs-utils/mkfs.ubifs/hashtable/hashtable.h b/ubifs-utils/common/hashtable/hashtable.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/hashtable/hashtable.h
rename to ubifs-utils/common/hashtable/hashtable.h
diff --git a/ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.c b/ubifs-utils/common/hashtable/hashtable_itr.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.c
rename to ubifs-utils/common/hashtable/hashtable_itr.c
diff --git a/ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.h b/ubifs-utils/common/hashtable/hashtable_itr.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/hashtable/hashtable_itr.h
rename to ubifs-utils/common/hashtable/hashtable_itr.h
diff --git a/ubifs-utils/mkfs.ubifs/hashtable/hashtable_private.h b/ubifs-utils/common/hashtable/hashtable_private.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/hashtable/hashtable_private.h
rename to ubifs-utils/common/hashtable/hashtable_private.h
diff --git a/ubifs-utils/mkfs.ubifs/key.h b/ubifs-utils/common/key.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/key.h
rename to ubifs-utils/common/key.h
diff --git a/ubifs-utils/mkfs.ubifs/lpt.c b/ubifs-utils/common/lpt.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/lpt.c
rename to ubifs-utils/common/lpt.c
diff --git a/ubifs-utils/mkfs.ubifs/lpt.h b/ubifs-utils/common/lpt.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/lpt.h
rename to ubifs-utils/common/lpt.h
diff --git a/ubifs-utils/mkfs.ubifs/sign.c b/ubifs-utils/common/sign.c
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/sign.c
rename to ubifs-utils/common/sign.c
diff --git a/ubifs-utils/mkfs.ubifs/sign.h b/ubifs-utils/common/sign.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/sign.h
rename to ubifs-utils/common/sign.h
diff --git a/ubifs-utils/mkfs.ubifs/ubifs.h b/ubifs-utils/common/ubifs.h
similarity index 100%
rename from ubifs-utils/mkfs.ubifs/ubifs.h
rename to ubifs-utils/common/ubifs.h
-- 
2.13.6


