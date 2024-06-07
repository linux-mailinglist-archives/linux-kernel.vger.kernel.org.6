Return-Path: <linux-kernel+bounces-205297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4668FFA80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A4C1C236D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AD13E041;
	Fri,  7 Jun 2024 04:26:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52C13E3F2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734415; cv=none; b=eNbo+Sg/TIwyt8dY+/YRoYuFPPJ9/iobD4gTaTgoTueja7JioRfxGpOVaCKsZDE5j5DTvH2vzPlO5TNZkNrFFAWIDQLeUgeyG3cxgkmMOJctKIqzgjIioP4fJ6AAzix9PZzFIJaoDIqp95CRKfaFvCK0Tfc5LkXzRoGnIzBRPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734415; c=relaxed/simple;
	bh=3aUqBoDI9TJI8uywQ+vjApH/7H+Tswt28IIEqBix3kQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozAebvL4kPEACoIvTfjSeDeFhu5u+sBr1pYV5jvYnjGQEaq7e2S75NsArw94cRDXJ35UsKgdmvxsUBIEKQsOMxJd0T1ic3Y/+qZCLOs0NXEmxG5o1qHkoPQNz+j/7z/v7AEZ3sym+44OYxrYSYhItQJnIEBwgw+ieGterG4FiYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShl4fRFzmYRQ;
	Fri,  7 Jun 2024 12:22:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B15D14038F;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:41 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 020/110] ubifs-utils: Add linux type definitions
Date: Fri, 7 Jun 2024 12:24:45 +0800
Message-ID: <20240607042615.2069840-21-chengzhihao1@huawei.com>
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

Add linux type definitions, because there are many types
(eg. u8/u16/u64) used in UBIFS linux kernel libs. Besides
move type conversions (eg. cpu_to_le16, cpu_to_le32, etc.)
into type definitions header file.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |  1 +
 ubifs-utils/common/crypto.c         |  1 +
 ubifs-utils/common/defs.h           | 30 -------------
 ubifs-utils/common/fscrypt.c        |  3 +-
 ubifs-utils/common/fscrypt.h        |  7 +--
 ubifs-utils/common/linux_types.h    | 89 +++++++++++++++++++++++++++++++++++++
 ubifs-utils/common/sign.c           |  2 +-
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c |  9 ++--
 8 files changed, 104 insertions(+), 38 deletions(-)
 create mode 100644 ubifs-utils/common/linux_types.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index d58570fe..0f9c0fa6 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -1,5 +1,6 @@
 common_SOURCES = \
 	ubifs-utils/common/compiler_attributes.h \
+	ubifs-utils/common/linux_types.h \
 	ubifs-utils/common/defs.h \
 	ubifs-utils/common/crc16.h \
 	ubifs-utils/common/crc16.c \
diff --git a/ubifs-utils/common/crypto.c b/ubifs-utils/common/crypto.c
index 2ecd8da1..e4ef3491 100644
--- a/ubifs-utils/common/crypto.c
+++ b/ubifs-utils/common/crypto.c
@@ -23,6 +23,7 @@
 #include <string.h>
 #include <assert.h>
 
+#include "linux_types.h"
 #include "fscrypt.h"
 #include "defs.h"
 #include "ubifs.h"
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index cafc94af..dd3b806e 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <limits.h>
-#include <byteswap.h>
 #include <errno.h>
 
 #include "ubifs.h"
@@ -27,37 +26,8 @@ enum { MKFS_PROGRAM_TYPE = 0 };
 	printf("%s: %s: " fmt "\n", PROGRAM_NAME, __FUNCTION__, ##__VA_ARGS__); \
 } while(0)
 
-#define t16(x) ({ \
-	uint16_t __b = (x); \
-	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_16(__b); \
-})
-
-#define t32(x) ({ \
-	uint32_t __b = (x); \
-	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_32(__b); \
-})
-
-#define t64(x) ({ \
-	uint64_t __b = (x); \
-	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_64(__b); \
-})
-
-#define cpu_to_le16(x) ((__le16){t16(x)})
-#define cpu_to_le32(x) ((__le32){t32(x)})
-#define cpu_to_le64(x) ((__le64){t64(x)})
-
-#define le16_to_cpu(x) (t16((x)))
-#define le32_to_cpu(x) (t32((x)))
-#define le64_to_cpu(x) (t64((x)))
-
 #define unlikely(x) (x)
 
-struct qstr
-{
-	char *name;
-	size_t len;
-};
-
 /**
  * fls - find last (most-significant) bit set
  * @x: the word to search
diff --git a/ubifs-utils/common/fscrypt.c b/ubifs-utils/common/fscrypt.c
index 895d5c72..f39faa76 100644
--- a/ubifs-utils/common/fscrypt.c
+++ b/ubifs-utils/common/fscrypt.c
@@ -20,6 +20,7 @@
 
 #include <endian.h>
 
+#include "linux_types.h"
 #include "fscrypt.h"
 #include "defs.h"
 #include "ubifs.h"
@@ -88,7 +89,7 @@ unsigned int fscrypt_fname_encrypted_size(struct fscrypt_context *fctx,
 	return round_up(ilen, padding);
 }
 
-int encrypt_path(void **outbuf, void *data, unsigned int data_len,
+int encrypt_path(void **outbuf, const void *data, unsigned int data_len,
 		unsigned int max_namelen, struct fscrypt_context *fctx)
 {
 	void *inbuf, *crypt_key;
diff --git a/ubifs-utils/common/fscrypt.h b/ubifs-utils/common/fscrypt.h
index b8a599de..4a073e97 100644
--- a/ubifs-utils/common/fscrypt.h
+++ b/ubifs-utils/common/fscrypt.h
@@ -107,7 +107,7 @@ struct fscrypt_context *inherit_fscrypt_context(struct fscrypt_context *fctx);
 void free_fscrypt_context(struct fscrypt_context *fctx);
 unsigned int fscrypt_fname_encrypted_size(struct fscrypt_context *fctx,
 					  unsigned int ilen);
-int encrypt_path(void **outbuf, void *data, unsigned int data_len,
+int encrypt_path(void **outbuf, const void *data, unsigned int data_len,
 		 unsigned int max_namelen, struct fscrypt_context *fctx);
 int encrypt_data_node(struct fscrypt_context *fctx, unsigned int block_no,
 		      struct ubifs_data_node *dn, size_t length);
@@ -138,8 +138,9 @@ static inline void free_fscrypt_context(struct fscrypt_context *fctx)
 	assert(!fctx);
 }
 
-static inline int encrypt_path(void **outbuf, void *data, unsigned int data_len,
-		 unsigned int max_namelen, struct fscrypt_context *fctx)
+static inline int encrypt_path(void **outbuf, const void *data,
+			unsigned int data_len, unsigned int max_namelen,
+			struct fscrypt_context *fctx)
 {
 	(void)outbuf;
 	(void)data;
diff --git a/ubifs-utils/common/linux_types.h b/ubifs-utils/common/linux_types.h
new file mode 100644
index 00000000..556b2e25
--- /dev/null
+++ b/ubifs-utils/common/linux_types.h
@@ -0,0 +1,89 @@
+#ifndef __LINUX_TYPES_H__
+#define __LINUX_TYPES_H__
+
+#include <linux/types.h>
+#include <sys/types.h>
+#include <byteswap.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include "compiler_attributes.h"
+
+typedef __u8		u8;
+typedef __u16		u16;
+typedef __u32		u32;
+typedef __u64		u64;
+
+typedef __s64		time64_t;
+
+struct qstr {
+	const char *name;
+	size_t len;
+};
+
+struct fscrypt_name {
+	struct qstr disk_name;
+};
+
+#define fname_name(p)	((p)->disk_name.name)
+#define fname_len(p)	((p)->disk_name.len)
+
+#define t16(x) ({ \
+	uint16_t __b = (x); \
+	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_16(__b); \
+})
+
+#define t32(x) ({ \
+	uint32_t __b = (x); \
+	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_32(__b); \
+})
+
+#define t64(x) ({ \
+	uint64_t __b = (x); \
+	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_64(__b); \
+})
+
+#define cpu_to_le16(x) ((__le16){t16(x)})
+#define cpu_to_le32(x) ((__le32){t32(x)})
+#define cpu_to_le64(x) ((__le64){t64(x)})
+
+#define le16_to_cpu(x) (t16((x)))
+#define le32_to_cpu(x) (t32((x)))
+#define le64_to_cpu(x) (t64((x)))
+
+#define check_mul_overflow(a, b, d) ({		\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	__builtin_mul_overflow(__a, __b, __d);	\
+})
+
+static inline __must_check size_t array_size(size_t a, size_t b)
+{
+	size_t bytes;
+	if (check_mul_overflow(a, b, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+static inline int int_log2(unsigned int arg)
+{
+	int  l = 0;
+
+	arg >>= 1;
+	while (arg) {
+		l++;
+		arg >>= 1;
+	}
+	return l;
+}
+
+#undef PAGE_SIZE
+#define PAGE_SIZE (getpagesize())
+#undef PAGE_SHIFT
+#define PAGE_SHIFT (int_log2(PAGE_SIZE))
+
+#endif
diff --git a/ubifs-utils/common/sign.c b/ubifs-utils/common/sign.c
index 7530503a..dfbc96bf 100644
--- a/ubifs-utils/common/sign.c
+++ b/ubifs-utils/common/sign.c
@@ -28,7 +28,7 @@
 #include <openssl/conf.h>
 #include <err.h>
 
-#include "compiler_attributes.h"
+#include "linux_types.h"
 #include "sign.h"
 #include "defs.h"
 #include "ubifs.h"
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 2181595e..c2f5a29d 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -46,6 +46,7 @@
 #include <zstd.h>
 #endif
 
+#include "linux_types.h"
 #include "defs.h"
 #include "crypto.h"
 #include "fscrypt.h"
@@ -1207,12 +1208,14 @@ static int add_xattr(struct ubifs_ino_node *host_ino, struct stat *st,
 	struct ubifs_ino_node *ino;
 	struct ubifs_dent_node *xent;
 	struct qstr nm;
+	char *tmp_name;
 	union ubifs_key xkey, nkey;
 	int len, ret;
 
 	nm.len = strlen(name);
-	nm.name = xmalloc(nm.len + 1);
-	memcpy(nm.name, name, nm.len + 1);
+	tmp_name = xmalloc(nm.len + 1);
+	memcpy(tmp_name, name, nm.len + 1);
+	nm.name = tmp_name;
 
 	host_ino->xattr_cnt++;
 	host_ino->xattr_size += CALC_DENT_SIZE(nm.len);
@@ -1240,7 +1243,7 @@ static int add_xattr(struct ubifs_ino_node *host_ino, struct stat *st,
 
 	xent->inum = cpu_to_le64(inum);
 
-	ret = add_node(&xkey, nm.name, nm.len, xent, len);
+	ret = add_node(&xkey, tmp_name, nm.len, xent, len);
 	if (ret)
 		goto out;
 
-- 
2.13.6


