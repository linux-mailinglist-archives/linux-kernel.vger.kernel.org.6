Return-Path: <linux-kernel+bounces-205284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9428FFA6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB65B22E13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347A38DFC;
	Fri,  7 Jun 2024 04:26:36 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0512B95
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734395; cv=none; b=GW//il9pAhFeC5n99Mmr8v4+gmYdLq45d1WzrXaS1qqPVgK0lDijPHFIRQo1LPEZxiOxApkX4zafG1LtBNy0AGm0nrtNGi1OIISdIh/4jHOBkwx0Iri0ZpFC7mmulHiSmBnlHtPx1grkiMZ4+RvciaRQldxvgK7DC+/2p+6KJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734395; c=relaxed/simple;
	bh=FdiaUlmFDo9fP2tbb38ldLY0+uOVDRwRdm1Ua2i2ke0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pL41j0jlABEKoFZOcdbLzNhHuI0fmwOxiBZ+v2sMiTSJvsRvllPrOr8wOP9ZLQPz3oDgiXTSGAF2aBx4l0hC3siHyqDE+rKfetPfe2gV19ZdDMANOfFk9hCB8gAxr50A65YCpIgVyUDNHYo0i+DlZoSUmqpjVoid6N7eMI7aal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSj41ZmNzsRgt;
	Fri,  7 Jun 2024 12:22:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D52C818007E;
	Fri,  7 Jun 2024 12:26:30 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:29 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 005/110] ubifs-utils: Define PROGRAM_NAME as variable
Date: Fri, 7 Jun 2024 12:24:30 +0800
Message-ID: <20240607042615.2069840-6-chengzhihao1@huawei.com>
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

PROGRAM_NAME is defined as a const string "mkfs.ubifs", which won't be
suitable for fsck.ubifs. Add 'program_name' member in ubifs_info
structure, define PROGRAM_NAME as ubifs_info.program_name. Then, error
messages will display right program name if fsck.ubifs is supported.
Besides, add 'program_type' member in ubifs_info structure to identify
which current program type is, without comparing program name.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/crypto.c              | 10 +++++++---
 ubifs-utils/common/defs.h                |  4 ++++
 ubifs-utils/common/fscrypt.c             |  7 +++++--
 ubifs-utils/common/hashtable/hashtable.c | 14 +++++++++-----
 ubifs-utils/common/lpt.c                 |  7 +++++--
 ubifs-utils/common/ubifs.h               |  6 ++++++
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c      |  3 +++
 7 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/ubifs-utils/common/crypto.c b/ubifs-utils/common/crypto.c
index 60a67a4e..614a16de 100644
--- a/ubifs-utils/common/crypto.c
+++ b/ubifs-utils/common/crypto.c
@@ -23,10 +23,14 @@
 #include <string.h>
 #include <assert.h>
 
-#define PROGRAM_NAME "mkfs.ubifs"
-#include "common.h"
-#include "defs.h"
 #include "fscrypt.h"
+#include "defs.h"
+#include "ubifs.h"
+
+/* common.h requires the PROGRAM_NAME macro */
+extern struct ubifs_info info_;
+#define PROGRAM_NAME (info_.program_name)
+#include "common.h"
 
 static int do_hash(const EVP_MD *md, const unsigned char *in, size_t len, unsigned char *out)
 {
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index e1aded03..143f6c65 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -12,6 +12,10 @@
 #include <byteswap.h>
 #include <errno.h>
 
+#define MKFS_PROGRAM_NAME "mkfs.ubifs"
+
+enum { MKFS_PROGRAM_TYPE = 0 };
+
 extern int debug_level;
 
 #define dbg_msg(lvl, fmt, ...) do {if (debug_level >= lvl)                \
diff --git a/ubifs-utils/common/fscrypt.c b/ubifs-utils/common/fscrypt.c
index 94c6c377..cc989638 100644
--- a/ubifs-utils/common/fscrypt.c
+++ b/ubifs-utils/common/fscrypt.c
@@ -20,11 +20,14 @@
 
 #include <endian.h>
 
-#define PROGRAM_NAME "mkfs.ubifs"
-#include "common.h"
 #include "fscrypt.h"
 #include "defs.h"
+#include "ubifs.h"
 
+/* common.h requires the PROGRAM_NAME macro */
+extern struct ubifs_info info_;
+#define PROGRAM_NAME (info_.program_name)
+#include "common.h"
 
 static __u8 fscrypt_masterkey[FS_MAX_KEY_SIZE];
 static struct cipher *fscrypt_cipher;
diff --git a/ubifs-utils/common/hashtable/hashtable.c b/ubifs-utils/common/hashtable/hashtable.c
index c1f99edd..071afd22 100644
--- a/ubifs-utils/common/hashtable/hashtable.c
+++ b/ubifs-utils/common/hashtable/hashtable.c
@@ -1,15 +1,19 @@
 /* Copyright (C) 2004 Christopher Clark <firstname.lastname@cl.cam.ac.uk> */
 
-#define PROGRAM_NAME "hashtable"
-
-#include "common.h"
-#include "hashtable.h"
-#include "hashtable_private.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <math.h>
 
+#include "ubifs.h"
+#include "hashtable.h"
+#include "hashtable_private.h"
+
+/* common.h requires the PROGRAM_NAME macro */
+extern struct ubifs_info info_;
+#define PROGRAM_NAME (info_.program_name)
+#include "common.h"
+
 /*
 Credit for primes table: Aaron Krowne
  http://br.endernet.org/~akrowne/
diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
index 23ffe7f7..746fc7db 100644
--- a/ubifs-utils/common/lpt.c
+++ b/ubifs-utils/common/lpt.c
@@ -24,14 +24,17 @@
 #include <openssl/evp.h>
 #endif
 
-#define PROGRAM_NAME "mkfs.ubifs"
-#include "common.h"
 #include "lpt.h"
 #include "defs.h"
 #include "ubifs.h"
 #include "crc16.h"
 #include "sign.h"
 
+/* common.h requires the PROGRAM_NAME macro */
+extern struct ubifs_info info_;
+#define PROGRAM_NAME (info_.program_name)
+#include "common.h"
+
 /**
  * do_calc_lpt_geom - calculate sizes for the LPT area.
  * @c: the UBIFS file-system description object
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 0eef31ac..2b0ffe56 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -273,6 +273,9 @@ struct ubifs_znode
  * @highest_inum: highest used inode number
  * @max_sqnum: current global sequence number
  *
+ * @program_type: used to identify the type of current program
+ * @program_name: program name
+ *
  * @jhead_cnt: count of journal heads
  * @max_bud_bytes: maximum number of bytes allowed in buds
  *
@@ -360,6 +363,9 @@ struct ubifs_info
 	ino_t highest_inum;
 	unsigned long long max_sqnum;
 
+	int program_type;
+	const char *program_name;
+
 	int jhead_cnt;
 	long long max_bud_bytes;
 
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index a440bc4b..b4bed018 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -3056,6 +3056,9 @@ int main(int argc, char *argv[])
 {
 	int err;
 
+	info_.program_name = MKFS_PROGRAM_NAME;
+	info_.program_type = MKFS_PROGRAM_TYPE;
+
 	if (crypto_init())
 		return -1;
 
-- 
2.13.6


