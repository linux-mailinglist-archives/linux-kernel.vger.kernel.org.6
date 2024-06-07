Return-Path: <linux-kernel+bounces-205286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B018FFA76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8A1F2594F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A717345D;
	Fri,  7 Jun 2024 04:26:40 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40F17582
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734398; cv=none; b=uOhkvD+Nx8uqA/VQuo8t/vz4fM6+9XGArR30UPH58FPXcXaPTwPv8h6oRQUl3kZVEMgPaMvCSeEuLWRHcJesshp86nSsgDqrH91kgteIjExyslyV6RABFo8mXhnp4XSJDOezPZoYuz8y2dJZrAleBcgZF/pi7qx0sOpC+syIZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734398; c=relaxed/simple;
	bh=yCx/NLkHOVXHMI9pcsBfXfwqJQDpJs+Gr8YNvfcrLAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trZpm4ehOAH9aNzp6lCoXSVo/15cyBwjzgeu0m318V+xmPnKRwddFVYpi+jxecu+dH/eSsoSZNekZ5/QFtnYwGTpOHZErALa6nb9U6/aWE6iWuI1kmb64xoBwuqmvBIABwomHR+5QEbbH5rIIXXB+2QdidFtA13KKG3x3+8Wp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VwSjN323zz1S6L0;
	Fri,  7 Jun 2024 12:22:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A4E6C1400D3;
	Fri,  7 Jun 2024 12:26:31 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:30 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 006/110] ubifs-utils: Clean up error message printing functions
Date: Fri, 7 Jun 2024 12:24:31 +0800
Message-ID: <20240607042615.2069840-7-chengzhihao1@huawei.com>
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

Functions 'err_msg' and 'sys_err_msg' are almost same with 'errmsg' and
'sys_errmsg', since 'errmsg' and 'sys_errmsg' can print programe name,
so replace error message printing functions (ubifs-utils) with common
lib functions(include/common.h).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/crypto.c              |   5 -
 ubifs-utils/common/defs.h                |  19 ++--
 ubifs-utils/common/devtable.c            |  59 ++++++-----
 ubifs-utils/common/fscrypt.c             |  25 ++---
 ubifs-utils/common/hashtable/hashtable.c |   5 -
 ubifs-utils/common/lpt.c                 |   7 +-
 ubifs-utils/common/sign.c                |  24 ++---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c      | 177 +++++++++++++++----------------
 8 files changed, 146 insertions(+), 175 deletions(-)

diff --git a/ubifs-utils/common/crypto.c b/ubifs-utils/common/crypto.c
index 614a16de..2ecd8da1 100644
--- a/ubifs-utils/common/crypto.c
+++ b/ubifs-utils/common/crypto.c
@@ -27,11 +27,6 @@
 #include "defs.h"
 #include "ubifs.h"
 
-/* common.h requires the PROGRAM_NAME macro */
-extern struct ubifs_info info_;
-#define PROGRAM_NAME (info_.program_name)
-#include "common.h"
-
 static int do_hash(const EVP_MD *md, const unsigned char *in, size_t len, unsigned char *out)
 {
 	unsigned int out_len;
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 143f6c65..56336b6a 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -12,6 +12,11 @@
 #include <byteswap.h>
 #include <errno.h>
 
+/* common.h requires the PROGRAM_NAME macro */
+extern struct ubifs_info info_;
+#define PROGRAM_NAME (info_.program_name)
+#include "common.h"
+
 #define MKFS_PROGRAM_NAME "mkfs.ubifs"
 
 enum { MKFS_PROGRAM_TYPE = 0 };
@@ -19,21 +24,9 @@ enum { MKFS_PROGRAM_TYPE = 0 };
 extern int debug_level;
 
 #define dbg_msg(lvl, fmt, ...) do {if (debug_level >= lvl)                \
-	printf("mkfs.ubifs: %s: " fmt "\n", __FUNCTION__, ##__VA_ARGS__); \
+	printf("%s: %s: " fmt "\n", PROGRAM_NAME, __FUNCTION__, ##__VA_ARGS__); \
 } while(0)
 
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
-
 #define t16(x) ({ \
 	uint16_t __b = (x); \
 	(__LITTLE_ENDIAN==__BYTE_ORDER) ? __b : bswap_16(__b); \
diff --git a/ubifs-utils/common/devtable.c b/ubifs-utils/common/devtable.c
index 2b9c6ef2..39032646 100644
--- a/ubifs-utils/common/devtable.c
+++ b/ubifs-utils/common/devtable.c
@@ -52,6 +52,7 @@
 #include <sys/sysmacros.h>
 
 #include "devtable.h"
+#include "ubifs.h"
 #include "defs.h"
 #include "hashtable/hashtable.h"
 #include "hashtable/hashtable_itr.h"
@@ -117,7 +118,7 @@ static int separate_last(const char *buf, int len, char **path, char **name)
 
 	*path = malloc(path_len + 1);
 	if (!*path)
-		return err_msg("cannot allocate %d bytes of memory",
+		return errmsg("cannot allocate %d bytes of memory",
 			       path_len + 1);
 	memcpy(*path, buf, path_len);
 	(*path)[path_len] = '\0';
@@ -125,7 +126,7 @@ static int separate_last(const char *buf, int len, char **path, char **name)
 	*name = malloc(name_len + 1);
 	if (!*name) {
 		free(*path);
-		return err_msg("cannot allocate %d bytes of memory",
+		return errmsg("cannot allocate %d bytes of memory",
 			       name_len + 1);
 	}
 	memcpy(*name, n, name_len + 1);
@@ -145,7 +146,7 @@ static int interpret_table_entry(const char *line)
 	if (sscanf(line, "%1023s %c %o %u %u %u %u %u %u %u",
 		   buf, &type, &mode, &uid, &gid, &major, &minor,
 		   &start, &increment, &count) < 0)
-		return sys_err_msg("sscanf failed");
+		return sys_errmsg("sscanf failed");
 
 	dbg_msg(3, "name %s, type %c, mode %o, uid %u, gid %u, major %u, "
 		"minor %u, start %u, inc %u, cnt %u",
@@ -154,20 +155,20 @@ static int interpret_table_entry(const char *line)
 
 	len = strnlen(buf, 1024);
 	if (len == 0)
-		return err_msg("empty path");
+		return errmsg("empty path");
 	if (len == 1024)
-		return err_msg("too long path");
+		return errmsg("too long path");
 
 	if (buf[0] != '/')
-		return err_msg("device table entries require absolute paths");
+		return errmsg("device table entries require absolute paths");
 	if (strstr(buf, "//"))
-		return err_msg("'//' cannot be used in the path");
+		return errmsg("'//' cannot be used in the path");
 	if (len > 1 && buf[len - 1] == '/')
-		return err_msg("do not put '/' at the end");
+		return errmsg("do not put '/' at the end");
 
 	if (strstr(buf, "/./") || strstr(buf, "/../") ||
 	    !strcmp(buf + len - 2, "/.") || !strcmp(buf + len - 3, "/.."))
-		return err_msg("'.' and '..' cannot be used in the path");
+		return errmsg("'.' and '..' cannot be used in the path");
 
 	switch (type) {
 		case 'd':
@@ -188,10 +189,10 @@ static int interpret_table_entry(const char *line)
 		case 'l':
 			mode |= S_IFLNK;
 			if ((mode & 0777) != 0777)
-				return err_msg("link permission must be 0777");
+				return errmsg("link permission must be 0777");
 			break;
 		default:
-			return err_msg("unsupported file type '%c'", type);
+			return errmsg("unsupported file type '%c'", type);
 	}
 
 	if (separate_last(buf, len, &path, &name))
@@ -206,13 +207,13 @@ static int interpret_table_entry(const char *line)
 		dbg_msg(3, "inserting '%s' into path hash table", path);
 		ph_elt = malloc(sizeof(struct path_htbl_element));
 		if (!ph_elt) {
-			err_msg("cannot allocate %zd bytes of memory",
+			errmsg("cannot allocate %zd bytes of memory",
 				sizeof(struct path_htbl_element));
 			goto out_free;
 		}
 
 		if (!hashtable_insert(path_htbl, path, ph_elt)) {
-			err_msg("cannot insert into path hash table");
+			errmsg("cannot insert into path hash table");
 			goto out_free;
 		}
 
@@ -221,13 +222,13 @@ static int interpret_table_entry(const char *line)
 		ph_elt->name_htbl = create_hashtable(128, &r5_hash,
 						     &is_equivalent);
 		if (!ph_elt->name_htbl) {
-			err_msg("cannot create name hash table");
+			errmsg("cannot create name hash table");
 			goto out_free;
 		}
 	}
 
 	if (increment != 0 && count == 0) {
-		err_msg("count cannot be zero if increment is non-zero");
+		errmsg("count cannot be zero if increment is non-zero");
 		goto out_free;
 	}
 
@@ -241,7 +242,7 @@ static int interpret_table_entry(const char *line)
 		/* This entry does not require any iterating */
 		nh_elt = malloc(sizeof(struct name_htbl_element));
 		if (!nh_elt) {
-			err_msg("cannot allocate %zd bytes of memory",
+			errmsg("cannot allocate %zd bytes of memory",
 				sizeof(struct name_htbl_element));
 			goto out_free;
 		}
@@ -255,13 +256,13 @@ static int interpret_table_entry(const char *line)
 			name, major(nh_elt->dev), minor(nh_elt->dev));
 
 		if (hashtable_search(ph_elt->name_htbl, name)) {
-			err_msg("'%s' is referred twice", buf);
+			errmsg("'%s' is referred twice", buf);
 			goto out_free;
 		}
 
 		nh_elt->name = name;
 		if (!hashtable_insert(ph_elt->name_htbl, name, nh_elt)) {
-			err_msg("cannot insert into name hash table");
+			errmsg("cannot insert into name hash table");
 			goto out_free;
 		}
 	} else {
@@ -271,7 +272,7 @@ static int interpret_table_entry(const char *line)
 		for (i = start; i < num; i++) {
 			nh_elt = malloc(sizeof(struct name_htbl_element));
 			if (!nh_elt) {
-				err_msg("cannot allocate %zd bytes of memory",
+				errmsg("cannot allocate %zd bytes of memory",
 					sizeof(struct name_htbl_element));
 				goto out_free;
 			}
@@ -283,7 +284,7 @@ static int interpret_table_entry(const char *line)
 
 			nm = malloc(len);
 			if (!nm) {
-				err_msg("cannot allocate %d bytes of memory", len);
+				errmsg("cannot allocate %d bytes of memory", len);
 				goto out_free;
 			}
 
@@ -294,13 +295,13 @@ static int interpret_table_entry(const char *line)
 			        nm, major(nh_elt->dev), minor(nh_elt->dev));
 
 			if (hashtable_search(ph_elt->name_htbl, nm)) {
-				err_msg("'%s' is referred twice", buf);
+				errmsg("'%s' is referred twice", buf);
 				free (nm);
 				goto out_free;
 			}
 
 			if (!hashtable_insert(ph_elt->name_htbl, nm, nh_elt)) {
-				err_msg("cannot insert into name hash table");
+				errmsg("cannot insert into name hash table");
 				free (nm);
 				goto out_free;
 			}
@@ -339,19 +340,19 @@ int parse_devtable(const char *tbl_file)
 
 	path_htbl = create_hashtable(128, &r5_hash, &is_equivalent);
 	if (!path_htbl)
-		return err_msg("cannot create path hash table");
+		return errmsg("cannot create path hash table");
 
 	f = fopen(tbl_file, "r");
 	if (!f)
-		return sys_err_msg("cannot open '%s'", tbl_file);
+		return sys_errmsg("cannot open '%s'", tbl_file);
 
 	if (fstat(fileno(f), &st) < 0) {
-		sys_err_msg("cannot stat '%s'", tbl_file);
+		sys_errmsg("cannot stat '%s'", tbl_file);
 		goto out_close;
 	}
 
 	if (st.st_size < 10) {
-		sys_err_msg("'%s' is too short", tbl_file);
+		sys_errmsg("'%s' is too short", tbl_file);
 		goto out_close;
 	}
 
@@ -376,7 +377,7 @@ int parse_devtable(const char *tbl_file)
 		/* If this is not a comment line, try to interpret it */
 		if (len && *line != '#') {
 			if (interpret_table_entry(line)) {
-				err_msg("cannot parse '%s'", line);
+				errmsg("cannot parse '%s'", line);
 				goto out_close;
 			}
 		}
@@ -448,13 +449,13 @@ int override_attributes(struct stat *st, struct path_htbl_element *ph_elt,
 
 	if (S_ISCHR(st->st_mode) || S_ISBLK(st->st_mode) ||
 	    S_ISFIFO(st->st_mode))
-		return err_msg("%s/%s both exists at UBIFS root at host, "
+		return errmsg("%s/%s both exists at UBIFS root at host, "
 			       "and is referred from the device table",
 			       strcmp(ph_elt->path, "/") ? ph_elt->path : "",
 			       nh_elt->name);
 
 	if ((st->st_mode & S_IFMT) != (nh_elt->mode & S_IFMT))
-		return err_msg("%s/%s is referred from the device table also exists in "
+		return errmsg("%s/%s is referred from the device table also exists in "
 			       "the UBIFS root directory at host, but the file type is "
 			       "different", strcmp(ph_elt->path, "/") ? ph_elt->path : "",
 			       nh_elt->name);
diff --git a/ubifs-utils/common/fscrypt.c b/ubifs-utils/common/fscrypt.c
index cc989638..895d5c72 100644
--- a/ubifs-utils/common/fscrypt.c
+++ b/ubifs-utils/common/fscrypt.c
@@ -24,11 +24,6 @@
 #include "defs.h"
 #include "ubifs.h"
 
-/* common.h requires the PROGRAM_NAME macro */
-extern struct ubifs_info info_;
-#define PROGRAM_NAME (info_.program_name)
-#include "common.h"
-
 static __u8 fscrypt_masterkey[FS_MAX_KEY_SIZE];
 static struct cipher *fscrypt_cipher;
 
@@ -40,7 +35,7 @@ unsigned char *calc_fscrypt_subkey(struct fscrypt_context *fctx)
 
 	ret = derive_key_aes(fctx->nonce, fscrypt_masterkey, fscrypt_cipher->key_length, new_key);
 	if (ret < 0) {
-		err_msg("derive_key_aes failed: %i\n", ret);
+		errmsg("derive_key_aes failed: %i\n", ret);
 
 		free(new_key);
 		new_key = NULL;
@@ -116,7 +111,7 @@ int encrypt_path(void **outbuf, void *data, unsigned int data_len,
 	if (!crypt_key) {
 		free(inbuf);
 		free(*outbuf);
-		return err_msg("could not compute subkey");
+		return errmsg("could not compute subkey");
 	}
 
 	ret = fscrypt_cipher->encrypt_fname(inbuf, cryptlen,
@@ -124,7 +119,7 @@ int encrypt_path(void **outbuf, void *data, unsigned int data_len,
 	if (ret < 0) {
 		free(inbuf);
 		free(*outbuf);
-		return err_msg("could not encrypt filename");
+		return errmsg("could not encrypt filename");
 	}
 
 	free(crypt_key);
@@ -149,7 +144,7 @@ int encrypt_data_node(struct fscrypt_context *fctx, unsigned int block_no,
 	if (!crypt_key) {
 		free(inbuf);
 		free(outbuf);
-		return err_msg("could not compute subkey");
+		return errmsg("could not compute subkey");
 	}
 
 	ret = fscrypt_cipher->encrypt_block(inbuf, pad_len,
@@ -159,7 +154,7 @@ int encrypt_data_node(struct fscrypt_context *fctx, unsigned int block_no,
 		free(inbuf);
 		free(outbuf);
 		free(crypt_key);
-		return err_msg("encrypt_block returned %zi "
+		return errmsg("encrypt_block returned %zi "
 				"instead of %zi", ret, pad_len);
 	}
 
@@ -189,11 +184,11 @@ static int parse_key_descriptor(const char *desc, __u8 *dst)
 
 	for (i = 0; i < FS_KEY_DESCRIPTOR_SIZE; ++i) {
 		if (!desc[i * 2] || !desc[i * 2 + 1]) {
-			err_msg("key descriptor '%s' is too short", desc);
+			errmsg("key descriptor '%s' is too short", desc);
 			return -1;
 		}
 		if (!isxdigit(desc[i * 2]) || !isxdigit(desc[i * 2 + 1])) {
-			err_msg("invalid key descriptor '%s'", desc);
+			errmsg("invalid key descriptor '%s'", desc);
 			return -1;
 		}
 
@@ -204,7 +199,7 @@ static int parse_key_descriptor(const char *desc, __u8 *dst)
 	}
 
 	if (desc[i * 2]) {
-		err_msg("key descriptor '%s' is too long", desc);
+		errmsg("key descriptor '%s' is too long", desc);
 		return -1;
 	}
 	return 0;
@@ -227,11 +222,11 @@ static int load_master_key(const char *key_file, struct cipher *fsc)
 		goto fail;
 	}
 	if (keysize == 0) {
-		err_msg("loading key from '%s': file is empty", key_file);
+		errmsg("loading key from '%s': file is empty", key_file);
 		goto fail;
 	}
 	if (keysize < fsc->key_length) {
-		err_msg("key '%s' is too short (at least %u bytes required)",
+		errmsg("key '%s' is too short (at least %u bytes required)",
 			key_file, fsc->key_length);
 		goto fail;
 	}
diff --git a/ubifs-utils/common/hashtable/hashtable.c b/ubifs-utils/common/hashtable/hashtable.c
index 071afd22..a3bae166 100644
--- a/ubifs-utils/common/hashtable/hashtable.c
+++ b/ubifs-utils/common/hashtable/hashtable.c
@@ -9,11 +9,6 @@
 #include "hashtable.h"
 #include "hashtable_private.h"
 
-/* common.h requires the PROGRAM_NAME macro */
-extern struct ubifs_info info_;
-#define PROGRAM_NAME (info_.program_name)
-#include "common.h"
-
 /*
 Credit for primes table: Aaron Krowne
  http://br.endernet.org/~akrowne/
diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
index 746fc7db..9c1143f6 100644
--- a/ubifs-utils/common/lpt.c
+++ b/ubifs-utils/common/lpt.c
@@ -30,11 +30,6 @@
 #include "crc16.h"
 #include "sign.h"
 
-/* common.h requires the PROGRAM_NAME macro */
-extern struct ubifs_info info_;
-#define PROGRAM_NAME (info_.program_name)
-#include "common.h"
-
 /**
  * do_calc_lpt_geom - calculate sizes for the LPT area.
  * @c: the UBIFS file-system description object
@@ -166,7 +161,7 @@ int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt)
 			continue;
 		}
 		if (c->ltab_sz > c->leb_size) {
-			err_msg("LPT ltab too big");
+			errmsg("LPT ltab too big");
 			return -EINVAL;
 		}
 		*main_lebs = c->main_lebs;
diff --git a/ubifs-utils/common/sign.c b/ubifs-utils/common/sign.c
index 93399ff7..9c53e671 100644
--- a/ubifs-utils/common/sign.c
+++ b/ubifs-utils/common/sign.c
@@ -110,7 +110,7 @@ static void drain_openssl_errors(void)
 
 #define ssl_err_msg(fmt, ...) ({			\
 	display_openssl_errors(__LINE__);		\
-	err_msg(fmt, ## __VA_ARGS__);			\
+	errmsg(fmt, ## __VA_ARGS__);			\
 	-1;						\
 })
 
@@ -215,9 +215,9 @@ static X509 *read_x509(const char *x509_name)
 	n = BIO_read(b, buf, 2);
 	if (n != 2) {
 		if (BIO_should_retry(b))
-			err_msg("%s: Read wanted retry", x509_name);
+			errmsg("%s: Read wanted retry", x509_name);
 		if (n >= 0)
-			err_msg("%s: Short read", x509_name);
+			errmsg("%s: Short read", x509_name);
 		goto out;
 	}
 
@@ -270,7 +270,7 @@ int sign_superblock_node(void *node)
 
 	if (!cert) {
 		if (!c->auth_cert_filename)
-			return err_msg("authentication certificate not provided (--auth-cert)");
+			return errmsg("authentication certificate not provided (--auth-cert)");
 		cert = read_x509(c->auth_cert_filename);
 	}
 
@@ -284,23 +284,23 @@ int sign_superblock_node(void *node)
 		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
 		       CMS_DETACHED | CMS_STREAM);
 	if (!cms)
-		return err_msg("CMS_sign failed");
+		return errmsg("CMS_sign failed");
 
 	pret = CMS_add1_signer(cms, cert, private_key, md,
 			      CMS_NOCERTS | CMS_BINARY |
 			      CMS_NOSMIMECAP | CMS_NOATTR);
 	if (!pret)
-		return err_msg("CMS_add1_signer failed");
+		return errmsg("CMS_add1_signer failed");
 
 	ret = CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY);
 	if (!ret)
-		return err_msg("CMS_final failed");
+		return errmsg("CMS_final failed");
 
 	bd = BIO_new(BIO_s_mem());
 
 	ret = i2d_CMS_bio_stream(bd, cms, NULL, 0);
 	if (!ret)
-		return err_msg("i2d_CMS_bio_stream failed");
+		return errmsg("i2d_CMS_bio_stream failed");
 
 	len = BIO_get_mem_data(bd, &obuf);
 
@@ -386,10 +386,10 @@ int init_authentication(void)
 		return 0;
 
 	if (!c->auth_key_filename)
-		return err_msg("authentication key not given (--auth-key)");
+		return errmsg("authentication key not given (--auth-key)");
 
 	if (!c->hash_algo_name)
-		return err_msg("Hash algorithm not given (--hash-algo)");
+		return errmsg("Hash algorithm not given (--hash-algo)");
 
 	OPENSSL_config(NULL);
 
@@ -398,14 +398,14 @@ int init_authentication(void)
 
 	md = EVP_get_digestbyname(c->hash_algo_name);
 	if (!md)
-		return err_msg("Unknown message digest %s", c->hash_algo_name);
+		return errmsg("Unknown message digest %s", c->hash_algo_name);
 
 	hash_md = EVP_MD_CTX_create();
 	c->hash_len = EVP_MD_size(md);
 
 	hash_algo = match_string(hash_algo_name, HASH_ALGO__LAST, c->hash_algo_name);
 	if (hash_algo < 0)
-		return err_msg("Unsupported message digest %s", c->hash_algo_name);
+		return errmsg("Unsupported message digest %s", c->hash_algo_name);
 
 	c->hash_algo = hash_algo;
 
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index b4bed018..0bcaa5e4 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -46,9 +46,6 @@
 #include <zstd.h>
 #endif
 
-/* common.h requires the PROGRAM_NAME macro */
-#define PROGRAM_NAME "mkfs.ubifs"
-#include "common.h"
 #include "defs.h"
 #include "crypto.h"
 #include "fscrypt.h"
@@ -413,61 +410,61 @@ static int validate_options(void)
 	int tmp;
 
 	if (!output)
-		return err_msg("no output file or UBI volume specified");
+		return errmsg("no output file or UBI volume specified");
 	if (root) {
 		tmp = is_contained(output, root);
 		if (tmp < 0)
-			return err_msg("failed to perform output file root check");
+			return errmsg("failed to perform output file root check");
 		else if (tmp)
-			return err_msg("output file cannot be in the UBIFS root "
+			return errmsg("output file cannot be in the UBIFS root "
 			               "directory");
 	}
 	if (!is_power_of_2(c->min_io_size))
-		return err_msg("min. I/O unit size should be power of 2");
+		return errmsg("min. I/O unit size should be power of 2");
 	if (c->leb_size < c->min_io_size)
-		return err_msg("min. I/O unit cannot be larger than LEB size");
+		return errmsg("min. I/O unit cannot be larger than LEB size");
 	if (c->leb_size < UBIFS_MIN_LEB_SZ)
-		return err_msg("too small LEB size %d, minimum is %d",
+		return errmsg("too small LEB size %d, minimum is %d",
 			       c->leb_size, UBIFS_MIN_LEB_SZ);
 	if (c->leb_size % c->min_io_size)
-		return err_msg("LEB should be multiple of min. I/O units");
+		return errmsg("LEB should be multiple of min. I/O units");
 	if (c->leb_size % 8)
-		return err_msg("LEB size has to be multiple of 8");
+		return errmsg("LEB size has to be multiple of 8");
 	if (c->leb_size > UBIFS_MAX_LEB_SZ)
-		return err_msg("too large LEB size %d, maximum is %d",
+		return errmsg("too large LEB size %d, maximum is %d",
 				c->leb_size, UBIFS_MAX_LEB_SZ);
 	if (c->max_leb_cnt < UBIFS_MIN_LEB_CNT)
-		return err_msg("too low max. count of LEBs, minimum is %d",
+		return errmsg("too low max. count of LEBs, minimum is %d",
 			       UBIFS_MIN_LEB_CNT);
 	if (c->fanout < UBIFS_MIN_FANOUT)
-		return err_msg("too low fanout, minimum is %d",
+		return errmsg("too low fanout, minimum is %d",
 			       UBIFS_MIN_FANOUT);
 	tmp = c->leb_size - UBIFS_IDX_NODE_SZ;
 	tmp /= UBIFS_BRANCH_SZ + UBIFS_MAX_KEY_LEN;
 	if (c->fanout > tmp)
-		return err_msg("too high fanout, maximum is %d", tmp);
+		return errmsg("too high fanout, maximum is %d", tmp);
 	if (c->log_lebs < UBIFS_MIN_LOG_LEBS)
-		return err_msg("too few log LEBs, minimum is %d",
+		return errmsg("too few log LEBs, minimum is %d",
 			       UBIFS_MIN_LOG_LEBS);
 	if (c->log_lebs >= c->max_leb_cnt - UBIFS_MIN_LEB_CNT)
-		return err_msg("too many log LEBs, maximum is %d",
+		return errmsg("too many log LEBs, maximum is %d",
 			       c->max_leb_cnt - UBIFS_MIN_LEB_CNT);
 	if (c->orph_lebs < UBIFS_MIN_ORPH_LEBS)
-		return err_msg("too few orphan LEBs, minimum is %d",
+		return errmsg("too few orphan LEBs, minimum is %d",
 			       UBIFS_MIN_ORPH_LEBS);
 	if (c->orph_lebs >= c->max_leb_cnt - UBIFS_MIN_LEB_CNT)
-		return err_msg("too many orphan LEBs, maximum is %d",
+		return errmsg("too many orphan LEBs, maximum is %d",
 			       c->max_leb_cnt - UBIFS_MIN_LEB_CNT);
 	tmp = UBIFS_SB_LEBS + UBIFS_MST_LEBS + c->log_lebs + c->lpt_lebs;
 	tmp += c->orph_lebs + 4;
 	if (tmp > c->max_leb_cnt)
-		return err_msg("too low max. count of LEBs, expected at "
+		return errmsg("too low max. count of LEBs, expected at "
 			       "least %d", tmp);
 	tmp = calc_min_log_lebs(c->max_bud_bytes);
 	if (c->log_lebs < calc_min_log_lebs(c->max_bud_bytes))
-		return err_msg("too few log LEBs, expected at least %d", tmp);
+		return errmsg("too few log LEBs, expected at least %d", tmp);
 	if (c->rp_size >= ((long long)c->leb_size * c->max_leb_cnt) / 2)
-		return err_msg("too much reserved space %lld", c->rp_size);
+		return errmsg("too much reserved space %lld", c->rp_size);
 	return 0;
 }
 
@@ -513,13 +510,13 @@ static long long get_bytes(const char *str)
 	long long bytes = strtoull(str, &endp, 0);
 
 	if (endp == str || bytes < 0)
-		return err_msg("incorrect amount of bytes: \"%s\"", str);
+		return errmsg("incorrect amount of bytes: \"%s\"", str);
 
 	if (*endp != '\0') {
 		int mult = get_multiplier(endp);
 
 		if (mult == -1)
-			return err_msg("bad size specifier: \"%s\" - "
+			return errmsg("bad size specifier: \"%s\" - "
 				       "should be 'KiB', 'MiB' or 'GiB'", endp);
 		bytes *= mult;
 	}
@@ -613,23 +610,23 @@ static int get_options(int argc, char**argv)
 
 			/* Make sure the root directory exists */
 			if (stat(root, &st))
-				return sys_err_msg("bad root directory '%s'",
+				return sys_errmsg("bad root directory '%s'",
 						   root);
 			break;
 		case 'm':
 			c->min_io_size = get_bytes(optarg);
 			if (c->min_io_size <= 0)
-				return err_msg("bad min. I/O size");
+				return errmsg("bad min. I/O size");
 			break;
 		case 'e':
 			c->leb_size = get_bytes(optarg);
 			if (c->leb_size <= 0)
-				return err_msg("bad LEB size");
+				return errmsg("bad LEB size");
 			break;
 		case 'c':
 			c->max_leb_cnt = get_bytes(optarg);
 			if (c->max_leb_cnt <= 0)
-				return err_msg("bad maximum LEB count");
+				return errmsg("bad maximum LEB count");
 			break;
 		case 'o':
 			output = xstrdup(optarg);
@@ -637,7 +634,7 @@ static int get_options(int argc, char**argv)
 		case 'D':
 			tbl_file = optarg;
 			if (stat(tbl_file, &st) < 0)
-				return sys_err_msg("bad device table file '%s'",
+				return sys_errmsg("bad device table file '%s'",
 						   tbl_file);
 			break;
 		case 'y':
@@ -663,13 +660,13 @@ static int get_options(int argc, char**argv)
 			debug_level = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg ||
 			    debug_level < 0 || debug_level > 3)
-				return err_msg("bad debugging level '%s'",
+				return errmsg("bad debugging level '%s'",
 					       optarg);
 			break;
 		case 'f':
 			c->fanout = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg || c->fanout <= 0)
-				return err_msg("bad fanout %s", optarg);
+				return errmsg("bad fanout %s", optarg);
 			break;
 		case 'F':
 			c->space_fixup = 1;
@@ -677,14 +674,14 @@ static int get_options(int argc, char**argv)
 		case 'l':
 			c->log_lebs = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg || c->log_lebs <= 0)
-				return err_msg("bad count of log LEBs '%s'",
+				return errmsg("bad count of log LEBs '%s'",
 					       optarg);
 			break;
 		case 'p':
 			c->orph_lebs = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg ||
 			    c->orph_lebs <= 0)
-				return err_msg("bad orphan LEB count '%s'",
+				return errmsg("bad orphan LEB count '%s'",
 					       optarg);
 			break;
 		case 'k':
@@ -695,7 +692,7 @@ static int get_options(int argc, char**argv)
 				c->key_hash = key_test_hash;
 				c->key_hash_type = UBIFS_KEY_HASH_TEST;
 			} else
-				return err_msg("bad key hash");
+				return errmsg("bad key hash");
 			break;
 		case 'x':
 			if (strcmp(optarg, "none") == 0)
@@ -719,28 +716,28 @@ static int get_options(int argc, char**argv)
 			}
 #endif
 			else
-				return err_msg("bad compressor name");
+				return errmsg("bad compressor name");
 			break;
 		case 'X':
 #if !defined(WITH_LZO) && !defined(WITH_ZLIB)
-			return err_msg("built without LZO or ZLIB support");
+			return errmsg("built without LZO or ZLIB support");
 #else
 			c->favor_percent = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg ||
 			    c->favor_percent <= 0 || c->favor_percent >= 100)
-				return err_msg("bad favor LZO percent '%s'",
+				return errmsg("bad favor LZO percent '%s'",
 					       optarg);
 #endif
 			break;
 		case 'j':
 			c->max_bud_bytes = get_bytes(optarg);
 			if (c->max_bud_bytes <= 0)
-				return err_msg("bad maximum amount of buds");
+				return errmsg("bad maximum amount of buds");
 			break;
 		case 'R':
 			c->rp_size = get_bytes(optarg);
 			if (c->rp_size < 0)
-				return err_msg("bad reserved bytes count");
+				return errmsg("bad reserved bytes count");
 			break;
 		case 'U':
 			squash_owner = 1;
@@ -753,24 +750,24 @@ static int get_options(int argc, char**argv)
 			context_len = strlen(optarg);
 			context = (char *) xmalloc(context_len + 1);
 			if (!context)
-				return err_msg("xmalloc failed\n");
+				return errmsg("xmalloc failed\n");
 			memcpy(context, optarg, context_len);
 			context[context_len] = '\0';
 
 			/* Make sure root directory exists */
 			if (stat(context, &context_st))
-				return sys_err_msg("bad file context %s\n",
+				return sys_errmsg("bad file context %s\n",
 								   context);
 			break;
 		case 'K':
 			if (key_file) {
-				return err_msg("key file specified more than once");
+				return errmsg("key file specified more than once");
 			}
 			key_file = optarg;
 			break;
 		case 'b':
 			if (key_desc) {
-				return err_msg("key descriptor specified more than once");
+				return errmsg("key descriptor specified more than once");
 			}
 			key_desc = optarg;
 			break;
@@ -821,7 +818,7 @@ static int get_options(int argc, char**argv)
 		case HASH_ALGO_OPTION:
 		case AUTH_KEY_OPTION:
 		case AUTH_CERT_OPTION:
-			return err_msg("mkfs.ubifs was built without crypto support.");
+			return errmsg("mkfs.ubifs was built without crypto support.");
 #endif
 		}
 	}
@@ -830,7 +827,7 @@ static int get_options(int argc, char**argv)
 		output = xstrdup(argv[optind]);
 
 	if (!output)
-		return err_msg("not output device or file specified");
+		return errmsg("not output device or file specified");
 
 	out_ubi = !open_ubi(output);
 
@@ -843,7 +840,7 @@ static int get_options(int argc, char**argv)
 	if (key_file || key_desc) {
 #ifdef WITH_CRYPTO
 		if (!key_file)
-			return err_msg("no key file specified");
+			return errmsg("no key file specified");
 
 		c->double_hash = 1;
 		c->encrypted = 1;
@@ -856,7 +853,7 @@ static int get_options(int argc, char**argv)
 		if (!root_fctx)
 			return -1;
 #else
-		return err_msg("mkfs.ubifs was built without crypto support.");
+		return errmsg("mkfs.ubifs was built without crypto support.");
 #endif
 	}
 
@@ -864,14 +861,14 @@ static int get_options(int argc, char**argv)
 		select_default_compr();
 
 	if (c->min_io_size == -1)
-		return err_msg("min. I/O unit was not specified "
+		return errmsg("min. I/O unit was not specified "
 			       "(use -h for help)");
 
 	if (c->leb_size == -1)
-		return err_msg("LEB size was not specified (use -h for help)");
+		return errmsg("LEB size was not specified (use -h for help)");
 
 	if (c->max_leb_cnt == -1)
-		return err_msg("Maximum count of LEBs was not specified "
+		return errmsg("Maximum count of LEBs was not specified "
 			       "(use -h for help)");
 
 	if (c->max_bud_bytes == -1) {
@@ -938,7 +935,7 @@ static int get_options(int argc, char**argv)
 		return -1;
 
 	if (tbl_file && parse_devtable(tbl_file))
-		return err_msg("cannot parse device table file '%s'", tbl_file);
+		return errmsg("cannot parse device table file '%s'", tbl_file);
 
 	return 0;
 }
@@ -976,13 +973,13 @@ int write_leb(int lnum, int len, void *buf)
 	memset(buf + len, 0xff, c->leb_size - len);
 	if (out_ubi)
 		if (ubi_leb_change_start(ubi, out_fd, lnum, c->leb_size))
-			return sys_err_msg("ubi_leb_change_start failed");
+			return sys_errmsg("ubi_leb_change_start failed");
 
 	if (lseek(out_fd, pos, SEEK_SET) != pos)
-		return sys_err_msg("lseek failed seeking %lld", (long long)pos);
+		return sys_errmsg("lseek failed seeking %lld", (long long)pos);
 
 	if (write(out_fd, buf, c->leb_size) != c->leb_size)
-		return sys_err_msg("write failed writing %d bytes at pos %lld",
+		return sys_errmsg("write failed writing %d bytes at pos %lld",
 				   c->leb_size, (long long)pos);
 
 	return 0;
@@ -1207,11 +1204,11 @@ static int add_node(union ubifs_key *key, char *name, int name_len, void *node,
 
 	if (type == UBIFS_DENT_KEY || type == UBIFS_XENT_KEY) {
 		if (!name)
-			return err_msg("Directory entry or xattr "
+			return errmsg("Directory entry or xattr "
 					"without name!");
 	} else {
 		if (name)
-			return err_msg("Name given for non dir/xattr node!");
+			return errmsg("Name given for non dir/xattr node!");
 	}
 
 	prepare_node(node, len);
@@ -1364,7 +1361,7 @@ static int inode_add_xattr(struct ubifs_ino_node *host_ino,
 		if (errno == ENOENT || errno == EOPNOTSUPP)
 			return 0;
 
-		sys_err_msg("llistxattr failed on %s", path_name);
+		sys_errmsg("llistxattr failed on %s", path_name);
 
 		return len;
 	}
@@ -1376,7 +1373,7 @@ static int inode_add_xattr(struct ubifs_ino_node *host_ino,
 
 	len = llistxattr(path_name, buf, len);
 	if (len < 0) {
-		sys_err_msg("llistxattr failed on %s", path_name);
+		sys_errmsg("llistxattr failed on %s", path_name);
 		goto out_free;
 	}
 
@@ -1390,7 +1387,7 @@ static int inode_add_xattr(struct ubifs_ino_node *host_ino,
 
 		attrsize = lgetxattr(path_name, name, attrbuf, sizeof(attrbuf) - 1);
 		if (attrsize < 0) {
-			sys_err_msg("lgetxattr failed on %s", path_name);
+			sys_errmsg("lgetxattr failed on %s", path_name);
 			goto out_free;
 		}
 
@@ -1400,7 +1397,7 @@ static int inode_add_xattr(struct ubifs_ino_node *host_ino,
 			inum_from_xattr = strtoull(attrbuf, NULL, 10);
 			if (inum != inum_from_xattr) {
 				errno = EINVAL;
-				sys_err_msg("calculated inum (%llu) doesn't match inum from xattr (%llu) size (%zd) on %s",
+				sys_errmsg("calculated inum (%llu) doesn't match inum from xattr (%llu) size (%zd) on %s",
 					    (unsigned long long)inum,
 					    (unsigned long long)inum_from_xattr,
 					    attrsize,
@@ -1456,7 +1453,7 @@ static int inode_add_selinux_xattr(struct ubifs_ino_node *host_ino,
 		sepath = NULL;
 
 	if (!sepath)
-		return sys_err_msg("could not get sepath\n");
+		return sys_errmsg("could not get sepath\n");
 
 	if (selabel_lookup(sehnd, &secontext, sepath, st->st_mode) < 0) {
 		/* Failed to lookup context, assume unlabeled */
@@ -1612,7 +1609,7 @@ static int add_inode(struct stat *st, ino_t inum, void *data,
 		} else {
 			/* TODO: what about device files? */
 			if (!S_ISLNK(st->st_mode))
-				return err_msg("Expected symlink");
+				return errmsg("Expected symlink");
 
 			ret = encrypt_symlink(&ino->data, data, data_len, fctx);
 			if (ret < 0)
@@ -1667,7 +1664,7 @@ static int add_dir_inode(const char *path_name, DIR *dir, ino_t inum, loff_t siz
 	if (dir) {
 		fd = dirfd(dir);
 		if (fd == -1)
-			return sys_err_msg("dirfd failed");
+			return sys_errmsg("dirfd failed");
 		if (ioctl(fd, FS_IOC_GETFLAGS, &flags) == -1)
 			flags = 0;
 	}
@@ -1705,9 +1702,9 @@ static int add_symlink_inode(const char *path_name, struct stat *st, ino_t inum,
 	/* Take the symlink as is */
 	len = readlink(path_name, buf, UBIFS_MAX_INO_DATA + 1);
 	if (len <= 0)
-		return sys_err_msg("readlink failed for %s", path_name);
+		return sys_errmsg("readlink failed for %s", path_name);
 	if (len > UBIFS_MAX_INO_DATA)
-		return err_msg("symlink too long for %s", path_name);
+		return errmsg("symlink too long for %s", path_name);
 
 	return add_inode(st, inum, buf, len, flags, path_name, fctx);
 }
@@ -1757,7 +1754,7 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 		kname_len = dname.len;
 		kname = strdup(name);
 		if (!kname)
-			return err_msg("cannot allocate memory");
+			return errmsg("cannot allocate memory");
 	} else {
 		unsigned int max_namelen = UBIFS_MAX_NLEN;
 		int ret;
@@ -1850,7 +1847,7 @@ static int add_file(const char *path_name, struct stat *st, ino_t inum,
 
 	fd = open(path_name, O_RDONLY | O_LARGEFILE);
 	if (fd == -1)
-		return sys_err_msg("failed to open file '%s'", path_name);
+		return sys_errmsg("failed to open file '%s'", path_name);
 	do {
 		/* Read next block */
 		bytes_read = 0;
@@ -1858,7 +1855,7 @@ static int add_file(const char *path_name, struct stat *st, ino_t inum,
 			ret = read(fd, buf + bytes_read,
 				   UBIFS_BLOCK_SIZE - bytes_read);
 			if (ret == -1) {
-				sys_err_msg("failed to read file '%s'",
+				sys_errmsg("failed to read file '%s'",
 					    path_name);
 				close(fd);
 				return 1;
@@ -1918,9 +1915,9 @@ static int add_file(const char *path_name, struct stat *st, ino_t inum,
 	} while (ret != 0);
 
 	if (close(fd) == -1)
-		return sys_err_msg("failed to close file '%s'", path_name);
+		return sys_errmsg("failed to close file '%s'", path_name);
 	if (file_size != st->st_size)
-		return err_msg("file size changed during writing file '%s'",
+		return errmsg("file size changed during writing file '%s'",
 			       path_name);
 
 	return add_inode(st, inum, NULL, 0, flags, path_name, fctx);
@@ -1946,12 +1943,12 @@ static int add_non_dir(const char *path_name, ino_t *inum, unsigned int nlink,
 	if (S_ISREG(st->st_mode)) {
 		fd = open(path_name, O_RDONLY);
 		if (fd == -1)
-			return sys_err_msg("failed to open file '%s'",
+			return sys_errmsg("failed to open file '%s'",
 					   path_name);
 		if (ioctl(fd, FS_IOC_GETFLAGS, &flags) == -1)
 			flags = 0;
 		if (close(fd) == -1)
-			return sys_err_msg("failed to close file '%s'",
+			return sys_errmsg("failed to close file '%s'",
 					   path_name);
 		*type = UBIFS_ITYPE_REG;
 	} else if (S_ISCHR(st->st_mode))
@@ -1965,7 +1962,7 @@ static int add_non_dir(const char *path_name, ino_t *inum, unsigned int nlink,
 	else if (S_ISFIFO(st->st_mode))
 		*type = UBIFS_ITYPE_FIFO;
 	else
-		return err_msg("file '%s' has unknown inode type", path_name);
+		return errmsg("file '%s' has unknown inode type", path_name);
 
 	if (nlink)
 		st->st_nlink = nlink;
@@ -1979,7 +1976,7 @@ static int add_non_dir(const char *path_name, ino_t *inum, unsigned int nlink,
 
 		im = lookup_inum_mapping(st->st_dev, st->st_ino);
 		if (!im)
-			return err_msg("out of memory");
+			return errmsg("out of memory");
 		if (im->use_nlink == 0) {
 			/* New entry */
 			im->use_inum = *inum;
@@ -2014,7 +2011,7 @@ static int add_non_dir(const char *path_name, ino_t *inum, unsigned int nlink,
 	if (S_ISFIFO(st->st_mode))
 		return add_inode(st, *inum, NULL, 0, flags, NULL, NULL);
 
-	return err_msg("file '%s' has unknown inode type", path_name);
+	return errmsg("file '%s' has unknown inode type", path_name);
 }
 
 /**
@@ -2046,7 +2043,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 	if (existing) {
 		dir = opendir(dir_name);
 		if (dir == NULL)
-			return sys_err_msg("cannot open directory '%s'",
+			return sys_errmsg("cannot open directory '%s'",
 					   dir_name);
 	}
 
@@ -2070,7 +2067,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 		if (!entry) {
 			if (errno == 0)
 				break;
-			sys_err_msg("error reading directory '%s'", dir_name);
+			sys_errmsg("error reading directory '%s'", dir_name);
 			goto out_free;
 		}
 
@@ -2097,7 +2094,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 		free(name);
 		name = make_path(dir_name, entry->d_name);
 		if (lstat(name, &dent_st) == -1) {
-			sys_err_msg("lstat failed for file '%s'", name);
+			sys_errmsg("lstat failed for file '%s'", name);
 			goto out_free;
 		}
 
@@ -2171,7 +2168,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 		 * files.
 		 */
 		if (S_ISREG(nh_elt->mode)) {
-			err_msg("Bad device table entry %s/%s - it is "
+			errmsg("Bad device table entry %s/%s - it is "
 				"prohibited to create regular files "
 				"via device table",
 				strcmp(ph_elt->path, "/") ? ph_elt->path : "",
@@ -2237,7 +2234,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 
 	free(name);
 	if (existing && closedir(dir) == -1)
-		return sys_err_msg("error closing directory '%s'", dir_name);
+		return sys_errmsg("error closing directory '%s'", dir_name);
 
 	return 0;
 
@@ -2284,7 +2281,7 @@ static int write_data(void)
 	if (root) {
 		err = stat(root, &root_st);
 		if (err)
-			return sys_err_msg("bad root file-system directory '%s'",
+			return sys_errmsg("bad root file-system directory '%s'",
 					   root);
 		if (squash_owner)
 			root_st.st_uid = root_st.st_gid = 0;
@@ -2400,7 +2397,7 @@ static int write_index(void)
 	sz = idx_cnt * sizeof(struct idx_entry *);
 	if (sz / sizeof(struct idx_entry *) != idx_cnt) {
 		free(idx);
-		return err_msg("index is too big (%zu entries)", idx_cnt);
+		return errmsg("index is too big (%zu entries)", idx_cnt);
 	}
 	idx_ptr = xmalloc(sz);
 	idx_ptr[0] = idx_list_first;
@@ -2578,7 +2575,7 @@ static int finalize_leb_cnt(void)
 {
 	c->leb_cnt = head_lnum;
 	if (c->leb_cnt > c->max_leb_cnt)
-		return err_msg("max_leb_cnt too low (%d needed)", c->leb_cnt);
+		return errmsg("max_leb_cnt too low (%d needed)", c->leb_cnt);
 	c->main_lebs = c->leb_cnt - c->main_first;
 	if (verbose) {
 		printf("\tsuper lebs:   %d\n", UBIFS_SB_LEBS);
@@ -2846,20 +2843,20 @@ static int open_target(void)
 		out_fd = open(output, O_RDWR | O_EXCL);
 
 		if (out_fd == -1)
-			return sys_err_msg("cannot open the UBI volume '%s'",
+			return sys_errmsg("cannot open the UBI volume '%s'",
 					   output);
 		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1))
-			return sys_err_msg("ubi_set_property(set direct_write) failed");
+			return sys_errmsg("ubi_set_property(set direct_write) failed");
 
 		if (!yes && check_volume_empty()) {
 			if (!prompt("UBI volume is not empty.  Format anyways?", false))
-				return err_msg("UBI volume is not empty");
+				return errmsg("UBI volume is not empty");
 		}
 	} else {
 		out_fd = open(output, O_CREAT | O_RDWR | O_TRUNC,
 			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
 		if (out_fd == -1)
-			return sys_err_msg("cannot create output file '%s'",
+			return sys_errmsg("cannot create output file '%s'",
 					   output);
 	}
 	return 0;
@@ -2878,9 +2875,9 @@ static int close_target(void)
 {
 	if (out_fd >= 0) {
 		if (ubi && ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
-			return sys_err_msg("ubi_set_property(clear direct_write) failed");
+			return sys_errmsg("ubi_set_property(clear direct_write) failed");
 		if (close(out_fd) == -1)
-			return sys_err_msg("cannot close the target '%s'", output);
+			return sys_errmsg("cannot close the target '%s'", output);
 	}
 	if (ubi)
 		libubi_close(ubi);
@@ -2947,7 +2944,7 @@ static int init(void)
 
 		sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
 		if (!sehnd)
-			return err_msg("could not open selinux context\n");
+			return errmsg("could not open selinux context\n");
 	}
 #endif
 
-- 
2.13.6


