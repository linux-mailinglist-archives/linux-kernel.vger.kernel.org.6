Return-Path: <linux-kernel+bounces-205285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0B8FFA70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67A61F24750
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF13FB87;
	Fri,  7 Jun 2024 04:26:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2512572
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734395; cv=none; b=EAJbqlw6kKOoM+zlPciHtXrgcyUT0cX0uDFvEvmsK3KtiNdaW6j8G1I38CXiFL3qmeeTl4lpQB8x5XCqxWZ8w40M2JjAlKAp8k56vtdOP/Z9yvwTJlyN3Dk2mLDvm+3y7g9hhX3V6AjM72gME4sUxsPBgVLQlFhvDrs7HFtpsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734395; c=relaxed/simple;
	bh=75HbCZk//LrvHnZLaB9Vry/DXpzHkczqVJ4JAuINjgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLjBDfaEQ1SLGh2dxjPWhw+LX2I7bDFJ9KW8UKgpxhtM4s8ibGZJoAsMoA1zNM0AFX6P2amvU325Y9VViszoLfLiac6SriMw00soVnK2A7hySAFkGGzo07CQnlBukv4Krc8l50fP+E593/Vxw7Q/BDdGixBhE27xR2nTTfSSKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSjp5yDpzPpnF;
	Fri,  7 Jun 2024 12:23:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 234B6140427;
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
Subject: [RFC PATCH mtd-utils 004/110] ubifs-utils: Decouple mkfs.ubifs.h out of other modules
Date: Fri, 7 Jun 2024 12:24:29 +0800
Message-ID: <20240607042615.2069840-5-chengzhihao1@huawei.com>
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

Header file mkfs.ubifs.h is included in other modules(eg. compr.c, lpt.c,
fscrypt.h, sign.c), decouple it out of other modules.

There are two parts in mkfs.ubifs.h:
1. common functions, for example dbg_msg, err_msg and write_leb, move
   these functions into common/defs.h and common/ubifs.h.
2. devtable related definations, move them into a new header file
   common/devtable.h.

Splitting common functions from mkfs.ubifs.h is also a preparation for
importing libubifs(from linux kernel) to replace current UBIFS libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am                          |  4 +-
 ubifs-utils/common/compr.c                         | 19 ++---
 ubifs-utils/common/compr.h                         |  8 --
 ubifs-utils/common/crypto.c                        |  6 +-
 ubifs-utils/common/defs.h                          | 24 ++++++
 ubifs-utils/common/devtable.c                      |  9 ++-
 .../{mkfs.ubifs/mkfs.ubifs.h => common/devtable.h} | 85 +---------------------
 ubifs-utils/common/fscrypt.c                       |  4 +
 ubifs-utils/common/fscrypt.h                       |  8 +-
 ubifs-utils/common/lpt.c                           | 10 ++-
 ubifs-utils/common/lpt.h                           |  2 +
 ubifs-utils/common/sign.c                          |  9 ++-
 ubifs-utils/common/ubifs.h                         |  5 ++
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c                | 21 +++++-
 14 files changed, 99 insertions(+), 115 deletions(-)
 rename ubifs-utils/{mkfs.ubifs/mkfs.ubifs.h => common/devtable.h} (53%)

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 4a617c19..8af65be7 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -9,6 +9,7 @@ common_SOURCES = \
 	ubifs-utils/common/hashtable/hashtable_private.h \
 	ubifs-utils/common/hashtable/hashtable.c \
 	ubifs-utils/common/hashtable/hashtable_itr.c \
+	ubifs-utils/common/devtable.h \
 	ubifs-utils/common/devtable.c \
 	ubifs-utils/common/ubifs.h \
 	ubifs-utils/common/key.h \
@@ -27,12 +28,11 @@ endif
 
 mkfs_ubifs_SOURCES = \
 	$(common_SOURCES) \
-	ubifs-utils/mkfs.ubifs/mkfs.ubifs.h \
 	ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
 
 mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
-	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/mkfs.ubifs/ -I$(top_srcdir)/ubifs-utils/common
+	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common
 
 EXTRA_DIST += ubifs-utils/common/README
 
diff --git a/ubifs-utils/common/compr.c b/ubifs-utils/common/compr.c
index e4324f34..6f901511 100644
--- a/ubifs-utils/common/compr.c
+++ b/ubifs-utils/common/compr.c
@@ -39,11 +39,12 @@
 #endif
 
 #include "compr.h"
-#include "mkfs.ubifs.h"
+#include "ubifs.h"
 
 static void *lzo_mem;
 static unsigned long long errcnt = 0;
 #ifdef WITH_LZO
+extern struct ubifs_info info_;
 static struct ubifs_info *c = &info_;
 #endif
 
@@ -181,12 +182,12 @@ static int favor_lzo_compress(void *in_buf, size_t in_len, void *out_buf,
 
 select_lzo:
 	*out_len = lzo_len;
-	*type = MKFS_UBIFS_COMPR_LZO;
+	*type = UBIFS_COMPR_LZO;
 	return 0;
 
 select_zlib:
 	*out_len = zlib_len;
-	*type = MKFS_UBIFS_COMPR_ZLIB;
+	*type = UBIFS_COMPR_ZLIB;
 	memcpy(out_buf, zlib_buf, zlib_len);
 	return 0;
 }
@@ -199,7 +200,7 @@ int compress_data(void *in_buf, size_t in_len, void *out_buf, size_t *out_len,
 
 	if (in_len < UBIFS_MIN_COMPR_LEN) {
 		no_compress(in_buf, in_len, out_buf, out_len);
-		return MKFS_UBIFS_COMPR_NONE;
+		return UBIFS_COMPR_NONE;
 	}
 
 #if defined(WITH_LZO) && defined(WITH_ZLIB)
@@ -211,21 +212,21 @@ int compress_data(void *in_buf, size_t in_len, void *out_buf, size_t *out_len,
 #endif
 		switch (type) {
 #ifdef WITH_LZO
-		case MKFS_UBIFS_COMPR_LZO:
+		case UBIFS_COMPR_LZO:
 			ret = lzo_compress(in_buf, in_len, out_buf, out_len);
 			break;
 #endif
 #ifdef WITH_ZLIB
-		case MKFS_UBIFS_COMPR_ZLIB:
+		case UBIFS_COMPR_ZLIB:
 			ret = zlib_deflate(in_buf, in_len, out_buf, out_len);
 			break;
 #endif
 #ifdef WITH_ZSTD
-		case MKFS_UBIFS_COMPR_ZSTD:
+		case UBIFS_COMPR_ZSTD:
 			ret = zstd_compress(in_buf, in_len, out_buf, out_len);
 			break;
 #endif
-		case MKFS_UBIFS_COMPR_NONE:
+		case UBIFS_COMPR_NONE:
 			ret = 1;
 			break;
 		default:
@@ -236,7 +237,7 @@ int compress_data(void *in_buf, size_t in_len, void *out_buf, size_t *out_len,
 	}
 	if (ret || *out_len >= in_len) {
 		no_compress(in_buf, in_len, out_buf, out_len);
-		return MKFS_UBIFS_COMPR_NONE;
+		return UBIFS_COMPR_NONE;
 	}
 	return type;
 }
diff --git a/ubifs-utils/common/compr.h b/ubifs-utils/common/compr.h
index d58c7c7b..3e8e9b61 100644
--- a/ubifs-utils/common/compr.h
+++ b/ubifs-utils/common/compr.h
@@ -31,14 +31,6 @@
  */
 #define WORST_COMPR_FACTOR 4
 
-enum compression_type
-{
-	MKFS_UBIFS_COMPR_NONE,
-	MKFS_UBIFS_COMPR_LZO,
-	MKFS_UBIFS_COMPR_ZLIB,
-	MKFS_UBIFS_COMPR_ZSTD,
-};
-
 int compress_data(void *in_buf, size_t in_len, void *out_buf, size_t *out_len,
 		  int type);
 int init_compression(void);
diff --git a/ubifs-utils/common/crypto.c b/ubifs-utils/common/crypto.c
index 19c445e8..60a67a4e 100644
--- a/ubifs-utils/common/crypto.c
+++ b/ubifs-utils/common/crypto.c
@@ -17,14 +17,16 @@
  * Authors: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
  */
 
-#define PROGRAM_NAME "mkfs.ubifs"
 #include <openssl/evp.h>
 #include <openssl/err.h>
+#include <openssl/rand.h>
 #include <string.h>
 #include <assert.h>
 
-#include "fscrypt.h"
+#define PROGRAM_NAME "mkfs.ubifs"
 #include "common.h"
+#include "defs.h"
+#include "fscrypt.h"
 
 static int do_hash(const EVP_MD *md, const unsigned char *in, size_t len, unsigned char *out)
 {
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 8db52776..e1aded03 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -6,6 +6,30 @@
 #ifndef __UBIFS_DEFS_H__
 #define __UBIFS_DEFS_H__
 
+#include <stdlib.h>
+#include <stdio.h>
+#include <limits.h>
+#include <byteswap.h>
+#include <errno.h>
+
+extern int debug_level;
+
+#define dbg_msg(lvl, fmt, ...) do {if (debug_level >= lvl)                \
+	printf("mkfs.ubifs: %s: " fmt "\n", __FUNCTION__, ##__VA_ARGS__); \
+} while(0)
+
+#define err_msg(fmt, ...) ({                                \
+	fprintf(stderr, "Error: " fmt "\n", ##__VA_ARGS__); \
+	-1;                                                 \
+})
+
+#define sys_err_msg(fmt, ...) ({                                         \
+	int err_ = errno;                                                \
+	fprintf(stderr, "Error: " fmt "\n", ##__VA_ARGS__);              \
+	fprintf(stderr, "       %s (error %d)\n", strerror(err_), err_); \
+	-1;                                                              \
+})
+
 #define t16(x) ({ \
 	uint16_t __b = (x); \
 	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_16(__b); \
diff --git a/ubifs-utils/common/devtable.c b/ubifs-utils/common/devtable.c
index aa815fbb..2b9c6ef2 100644
--- a/ubifs-utils/common/devtable.c
+++ b/ubifs-utils/common/devtable.c
@@ -45,7 +45,14 @@
  * for more information about what the device table is.
  */
 
-#include "mkfs.ubifs.h"
+#include <string.h>
+#include <ctype.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/sysmacros.h>
+
+#include "devtable.h"
+#include "defs.h"
 #include "hashtable/hashtable.h"
 #include "hashtable/hashtable_itr.h"
 
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.h b/ubifs-utils/common/devtable.h
similarity index 53%
rename from ubifs-utils/mkfs.ubifs/mkfs.ubifs.h
rename to ubifs-utils/common/devtable.h
index 56909842..97585f2b 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.h
+++ b/ubifs-utils/common/devtable.h
@@ -20,86 +20,8 @@
  *          Zoltan Sogor
  */
 
-#ifndef __MKFS_UBIFS_H__
-#define __MKFS_UBIFS_H__
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <limits.h>
-#include <string.h>
-#include <stdint.h>
-#include <endian.h>
-#include <byteswap.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-
-#include <getopt.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <fcntl.h>
-#include <dirent.h>
-#include <errno.h>
-#include <libgen.h>
-#include <ctype.h>
-#include <uuid.h>
-#include <sys/file.h>
-
-#ifdef WITH_CRYPTO
-#include <openssl/rand.h>
-#endif
-
-#include <mtd/ubifs-media.h>
-
-/* common.h requires the PROGRAM_NAME macro */
-#define PROGRAM_NAME "mkfs.ubifs"
-#include "common.h"
-
-#include "libubi.h"
-#include "defs.h"
-#include "crc16.h"
-#include "ubifs.h"
-#include "key.h"
-#include "lpt.h"
-#include "compr.h"
-#include "sign.h"
-
-/*
- * Compression flags are duplicated so that compr.c can compile without ubifs.h.
- * Here we make sure they are the same.
- */
-#if MKFS_UBIFS_COMPR_NONE != UBIFS_COMPR_NONE
-#error MKFS_UBIFS_COMPR_NONE != UBIFS_COMPR_NONE
-#endif
-#if MKFS_UBIFS_COMPR_LZO != UBIFS_COMPR_LZO
-#error MKFS_UBIFS_COMPR_LZO != UBIFS_COMPR_LZO
-#endif
-#if MKFS_UBIFS_COMPR_ZLIB != UBIFS_COMPR_ZLIB
-#error MKFS_UBIFS_COMPR_ZLIB != UBIFS_COMPR_ZLIB
-#endif
-#if MKFS_UBIFS_COMPR_ZSTD != UBIFS_COMPR_ZSTD
-#error MKFS_UBIFS_COMPR_ZSTD != UBIFS_COMPR_ZSTD
-#endif
-
-extern int verbose;
-extern int debug_level;
-
-#define dbg_msg(lvl, fmt, ...) do {if (debug_level >= lvl)                \
-	printf("mkfs.ubifs: %s: " fmt "\n", __FUNCTION__, ##__VA_ARGS__); \
-} while(0)
-
-#define err_msg(fmt, ...) ({                                \
-	fprintf(stderr, "Error: " fmt "\n", ##__VA_ARGS__); \
-	-1;                                                 \
-})
-
-#define sys_err_msg(fmt, ...) ({                                         \
-	int err_ = errno;                                                \
-	fprintf(stderr, "Error: " fmt "\n", ##__VA_ARGS__);              \
-	fprintf(stderr, "       %s (error %d)\n", strerror(err_), err_); \
-	-1;                                                              \
-})
+#ifndef __DEVTABLE_H__
+#define __DEVTABLE_H__
 
 /**
  * struct path_htbl_element - an element of the path hash table.
@@ -136,11 +58,8 @@ struct name_htbl_element {
 	dev_t dev;
 };
 
-extern struct ubifs_info info_;
-
 struct hashtable_itr;
 
-int write_leb(int lnum, int len, void *buf);
 int parse_devtable(const char *tbl_file);
 struct path_htbl_element *devtbl_find_path(const char *path);
 struct name_htbl_element *devtbl_find_name(struct path_htbl_element *ph_elt,
diff --git a/ubifs-utils/common/fscrypt.c b/ubifs-utils/common/fscrypt.c
index b75bdf76..94c6c377 100644
--- a/ubifs-utils/common/fscrypt.c
+++ b/ubifs-utils/common/fscrypt.c
@@ -18,8 +18,12 @@
  *          David Oberhollenzer <david.oberhollenzer@sigma-star.at>
  */
 
+#include <endian.h>
+
 #define PROGRAM_NAME "mkfs.ubifs"
+#include "common.h"
 #include "fscrypt.h"
+#include "defs.h"
 
 
 static __u8 fscrypt_masterkey[FS_MAX_KEY_SIZE];
diff --git a/ubifs-utils/common/fscrypt.h b/ubifs-utils/common/fscrypt.h
index ff3d326b..908a5041 100644
--- a/ubifs-utils/common/fscrypt.h
+++ b/ubifs-utils/common/fscrypt.h
@@ -21,9 +21,11 @@
 #ifndef FSCRYPT_H
 #define FSCRYPT_H
 
-
-#include "mkfs.ubifs.h"
-#include <sys/types.h>
+#ifdef WITH_CRYPTO
+#include <openssl/rand.h>
+#endif
+#include <assert.h>
+#include "ubifs.h"
 #include "crypto.h"
 
 #ifndef FS_KEY_DESCRIPTOR_SIZE
diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
index 7ee739a9..23ffe7f7 100644
--- a/ubifs-utils/common/lpt.c
+++ b/ubifs-utils/common/lpt.c
@@ -20,12 +20,18 @@
  *          Artem Bityutskiy
  */
 
-#include "mkfs.ubifs.h"
-
 #ifdef WITH_CRYPTO
 #include <openssl/evp.h>
 #endif
 
+#define PROGRAM_NAME "mkfs.ubifs"
+#include "common.h"
+#include "lpt.h"
+#include "defs.h"
+#include "ubifs.h"
+#include "crc16.h"
+#include "sign.h"
+
 /**
  * do_calc_lpt_geom - calculate sizes for the LPT area.
  * @c: the UBIFS file-system description object
diff --git a/ubifs-utils/common/lpt.h b/ubifs-utils/common/lpt.h
index 4cde59d9..86148a2a 100644
--- a/ubifs-utils/common/lpt.h
+++ b/ubifs-utils/common/lpt.h
@@ -22,6 +22,8 @@
 #ifndef __UBIFS_LPT_H__
 #define __UBIFS_LPT_H__
 
+#include "ubifs.h"
+
 int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt);
 int create_lpt(struct ubifs_info *c);
 
diff --git a/ubifs-utils/common/sign.c b/ubifs-utils/common/sign.c
index 7f284f8e..93399ff7 100644
--- a/ubifs-utils/common/sign.c
+++ b/ubifs-utils/common/sign.c
@@ -17,9 +17,7 @@
  * Author: Sascha Hauer
  */
 
-#include "mkfs.ubifs.h"
-#include "common.h"
-
+#include <string.h>
 #include <openssl/evp.h>
 #include <openssl/opensslv.h>
 #include <openssl/bio.h>
@@ -30,6 +28,11 @@
 #include <openssl/conf.h>
 #include <err.h>
 
+#include "sign.h"
+#include "defs.h"
+#include "ubifs.h"
+
+extern struct ubifs_info info_;
 static struct ubifs_info *c = &info_;
 
 EVP_MD_CTX *hash_md;
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 55937cee..0eef31ac 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -25,6 +25,9 @@
 #ifndef __UBIFS_H__
 #define __UBIFS_H__
 
+#include <mtd/ubifs-media.h>
+#include "libubi.h"
+
 /* Maximum logical eraseblock size in bytes */
 #define UBIFS_MAX_LEB_SZ (2*1024*1024)
 
@@ -468,4 +471,6 @@ struct ubifs_branch *ubifs_idx_branch(const struct ubifs_info *c,
 				       (UBIFS_BRANCH_SZ + c->key_len + c->hash_len) * bnum);
 }
 
+int write_leb(int lnum, int len, void *buf);
+
 #endif /* __UBIFS_H__ */
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index b91a3e2d..a440bc4b 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -22,10 +22,17 @@
 
 #define _XOPEN_SOURCE 500 /* For realpath() */
 
-#include "mkfs.ubifs.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <libgen.h>
+#include <getopt.h>
+#include <dirent.h>
 #include <crc32.h>
-#include "common.h"
+#include <uuid.h>
+#include <linux/fs.h>
 #include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
 #ifdef WITH_XATTR
 #include <sys/xattr.h>
 #endif
@@ -39,8 +46,18 @@
 #include <zstd.h>
 #endif
 
+/* common.h requires the PROGRAM_NAME macro */
+#define PROGRAM_NAME "mkfs.ubifs"
+#include "common.h"
+#include "defs.h"
 #include "crypto.h"
 #include "fscrypt.h"
+#include "ubifs.h"
+#include "lpt.h"
+#include "compr.h"
+#include "key.h"
+#include "sign.h"
+#include "devtable.h"
 
 /* Size (prime number) of hash table for link counting */
 #define HASH_TABLE_SIZE 10099
-- 
2.13.6


