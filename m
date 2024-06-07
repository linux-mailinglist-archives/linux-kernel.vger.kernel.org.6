Return-Path: <linux-kernel+bounces-205351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C68FFABA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AC1F228CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62615FA86;
	Fri,  7 Jun 2024 04:27:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9715A873
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734456; cv=none; b=RmCGdpCJ72iXW3uB+sfjfs/iRmT4lqVz1R/0ReMt+uf8pV24fae0QSIqixD59ozUhALNV2k/bpBhWPKYSydCIqJfx+9M7F6E1X7TzQzIcc33AabUNVCftedSKAKyCTRFHEHCvLyxoyaG9+leZdv9lncLr89RIIgPrwUaPYdKCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734456; c=relaxed/simple;
	bh=OhiQm/TbVh2/QvrORJZnagyLqnSZZ5+n8VBg1uufxxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lvm+VXwRGmpKyCPlsM55FpGTjedp8HOlJKU6o7sDGYkPf79rg9SEDLenHEBaVvewI+TW2vWjAjETX6SILD96ipf+S9/1rQVrruMTGqGVRGyyckVnCLEhNITRAYkryiik3OPbZxG3A1FsCZkRfvuUNkiuwtEf10EVfyBB0DGs7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjP5628zmYS9;
	Fri,  7 Jun 2024 12:22:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E805180AA6;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:07 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 055/110] ubifs-utils: Replace ubifs related source code with linux kernel implementation
Date: Fri, 7 Jun 2024 12:25:20 +0800
Message-ID: <20240607042615.2069840-56-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Replace ubifs related source code with the implementation of linux kernel.
It makes userspace implementation be same with linux kernel, then
fsck.ubifs can resuse the code.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |  42 ++-
 ubifs-utils/common/README           |   3 -
 ubifs-utils/common/defs.h           |   9 -
 ubifs-utils/common/key.h            | 222 --------------
 ubifs-utils/common/lpt.c            | 595 ------------------------------------
 ubifs-utils/common/lpt.h            |  30 --
 ubifs-utils/common/sign.c           | 148 ++++-----
 ubifs-utils/common/sign.h           |  65 +---
 ubifs-utils/common/super.c          | 123 --------
 ubifs-utils/common/ubifs.h          | 498 ------------------------------
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 236 +++++---------
 11 files changed, 185 insertions(+), 1786 deletions(-)
 delete mode 100644 ubifs-utils/common/key.h
 delete mode 100644 ubifs-utils/common/lpt.c
 delete mode 100644 ubifs-utils/common/lpt.h
 delete mode 100644 ubifs-utils/common/super.c
 delete mode 100644 ubifs-utils/common/ubifs.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index c02ec313..936b49fc 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -24,25 +24,51 @@ common_SOURCES = \
 	ubifs-utils/common/hashtable/hashtable_itr.c \
 	ubifs-utils/common/devtable.h \
 	ubifs-utils/common/devtable.c \
-	ubifs-utils/common/hexdump.c \
-	ubifs-utils/common/ubifs.h \
-	ubifs-utils/common/key.h \
-	ubifs-utils/common/lpt.h \
-	ubifs-utils/common/lpt.c \
-	ubifs-utils/common/super.c \
-	ubifs-utils/common/sign.h \
-	ubifs-utils/libubifs/ubifs-media.h
+	ubifs-utils/common/hexdump.c
+
+libubifs_SOURCES = \
+	ubifs-utils/libubifs/ubifs-media.h \
+	ubifs-utils/libubifs/ubifs.h \
+	ubifs-utils/libubifs/key.h \
+	ubifs-utils/libubifs/misc.h \
+	ubifs-utils/libubifs/io.c \
+	ubifs-utils/libubifs/sb.c \
+	ubifs-utils/libubifs/super.c \
+	ubifs-utils/libubifs/master.c \
+	ubifs-utils/libubifs/debug.h \
+	ubifs-utils/libubifs/debug.c \
+	ubifs-utils/libubifs/scan.c \
+	ubifs-utils/libubifs/find.c \
+	ubifs-utils/libubifs/dir.c \
+	ubifs-utils/libubifs/budget.c \
+	ubifs-utils/libubifs/journal.c \
+	ubifs-utils/libubifs/gc.c \
+	ubifs-utils/libubifs/lpt.c \
+	ubifs-utils/libubifs/lpt_commit.c \
+	ubifs-utils/libubifs/lprops.c \
+	ubifs-utils/libubifs/tnc_misc.c \
+	ubifs-utils/libubifs/tnc.c \
+	ubifs-utils/libubifs/tnc_commit.c \
+	ubifs-utils/libubifs/commit.c \
+	ubifs-utils/libubifs/orphan.c \
+	ubifs-utils/libubifs/log.c \
+	ubifs-utils/libubifs/replay.c \
+	ubifs-utils/libubifs/recovery.c
 
 if WITH_CRYPTO
 common_SOURCES += ubifs-utils/common/crypto.c \
 		ubifs-utils/common/crypto.h \
 		ubifs-utils/common/fscrypt.c \
 		ubifs-utils/common/fscrypt.h \
+		ubifs-utils/common/sign.h \
 		ubifs-utils/common/sign.c
+
+libubifs_SOURCES += ubifs-utils/libubifs/auth.c
 endif
 
 mkfs_ubifs_SOURCES = \
 	$(common_SOURCES) \
+	$(libubifs_SOURCES) \
 	ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
 
 mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
diff --git a/ubifs-utils/common/README b/ubifs-utils/common/README
index 32d04e3a..a93ebd02 100644
--- a/ubifs-utils/common/README
+++ b/ubifs-utils/common/README
@@ -2,10 +2,7 @@ Common Library
 
 * crc16.h and crc16.c were copied from the linux kernel.
 * crc32.h and crc32.c were copied from mtd-utils and amended.
-* ubifs.h is a selection of definitions from fs/ubifs/ubifs.h from the linux kernel.
-* key.h is copied from fs/ubifs/key.h from the linux kernel.
 * defs.h is a bunch of definitions to smooth things over.
-* lpt.c is a selection of functions copied from fs/ubifs/lpt.c from the linux kernel, and amended.
 * hashtable/* was downloaded from http://www.cl.cam.ac.uk/~cwc22/hashtable/
 * atomic.h was downloaded from https://the-linux-channel.the-toffee-project.org/index.php?page=6-tutorials-linux-user-space-atomic-operations
 * bitops.h and bitops.c were copied from the linux kernel.
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 506f752c..79451c40 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -15,7 +15,6 @@
 #include <assert.h>
 #include <execinfo.h>
 
-#include "linux_types.h"
 #include "ubifs.h"
 
 /* common.h requires the PROGRAM_NAME macro */
@@ -27,8 +26,6 @@ extern struct ubifs_info info_;
 
 enum { MKFS_PROGRAM_TYPE = 0 };
 
-enum { ERR_LEVEL = 1, WARN_LEVEL, INFO_LEVEL, DEBUG_LEVEL };
-
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
@@ -114,12 +111,6 @@ static inline u64 div_u64(u64 dividend, u32 divisor)
 	return dividend / divisor;
 }
 
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
 #if INT_MAX != 0x7fffffff
 #error : sizeof(int) must be 4 for this program
 #endif
diff --git a/ubifs-utils/common/key.h b/ubifs-utils/common/key.h
deleted file mode 100644
index 2de530b8..00000000
--- a/ubifs-utils/common/key.h
+++ /dev/null
@@ -1,222 +0,0 @@
-/*
- * This file is part of UBIFS.
- *
- * Copyright (C) 2006-2008 Nokia Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Authors: Artem Bityutskiy (Битюцкий Артём)
- *          Adrian Hunter
- */
-
-/*
- * This header contains various key-related definitions and helper function.
- * UBIFS allows several key schemes, so we access key fields only via these
- * helpers. At the moment only one key scheme is supported.
- *
- * Simple key scheme
- * ~~~~~~~~~~~~~~~~~
- *
- * Keys are 64-bits long. First 32-bits are inode number (parent inode number
- * in case of direntry key). Next 3 bits are node type. The last 29 bits are
- * 4KiB offset in case of inode node, and direntry hash in case of a direntry
- * node. We use "r5" hash borrowed from reiserfs.
- */
-
-#ifndef __UBIFS_KEY_H__
-#define __UBIFS_KEY_H__
-
-#include <assert.h>
-
-/**
- * key_mask_hash - mask a valid hash value.
- * @val: value to be masked
- *
- * We use hash values as offset in directories, so values %0 and %1 are
- * reserved for "." and "..". %2 is reserved for "end of readdir" marker. This
- * function makes sure the reserved values are not used.
- */
-static inline uint32_t key_mask_hash(uint32_t hash)
-{
-	hash &= UBIFS_S_KEY_HASH_MASK;
-	if (unlikely(hash <= 2))
-		hash += 3;
-	return hash;
-}
-
-/**
- * key_r5_hash - R5 hash function (borrowed from reiserfs).
- * @s: direntry name
- * @len: name length
- */
-static inline uint32_t key_r5_hash(const char *s, int len)
-{
-	uint32_t a = 0;
-	const signed char *str = (const signed char *)s;
-
-	while (len--) {
-		a += *str << 4;
-		a += *str >> 4;
-		a *= 11;
-		str++;
-	}
-
-	return key_mask_hash(a);
-}
-
-/**
- * key_test_hash - testing hash function.
- * @str: direntry name
- * @len: name length
- */
-static inline uint32_t key_test_hash(const char *str, int len)
-{
-	uint32_t a = 0;
-
-	len = min_t(uint32_t, len, 4);
-	memcpy(&a, str, len);
-	return key_mask_hash(a);
-}
-
-/**
- * ino_key_init - initialize inode key.
- * @c: UBIFS file-system description object
- * @key: key to initialize
- * @inum: inode number
- */
-static inline void ino_key_init(union ubifs_key *key, ino_t inum)
-{
-	key->u32[0] = inum;
-	key->u32[1] = UBIFS_INO_KEY << UBIFS_S_KEY_BLOCK_BITS;
-}
-
-/**
- * dent_key_init - initialize directory entry key.
- * @c: UBIFS file-system description object
- * @key: key to initialize
- * @inum: parent inode number
- * @nm: direntry name and length
- */
-static inline void dent_key_init(const struct ubifs_info *c,
-				 union ubifs_key *key, ino_t inum,
-				 const void *name, int name_len)
-{
-	uint32_t hash = c->key_hash(name, name_len);
-
-	assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
-	key->u32[0] = inum;
-	key->u32[1] = hash | (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS);
-}
-
-/**
- * xent_key_init - initialize extended attribute entry key.
- * @c: UBIFS file-system description object
- * @key: key to initialize
- * @inum: host inode number
- * @nm: extended attribute entry name and length
- */
-static inline void xent_key_init(const struct ubifs_info *c,
-				 union ubifs_key *key, ino_t inum,
-				 const struct qstr *nm)
-{
-	uint32_t hash = c->key_hash(nm->name, nm->len);
-
-	assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
-	key->u32[0] = inum;
-	key->u32[1] = hash | (UBIFS_XENT_KEY << UBIFS_S_KEY_HASH_BITS);
-}
-
-/**
- * data_key_init - initialize data key.
- * @c: UBIFS file-system description object
- * @key: key to initialize
- * @inum: inode number
- * @block: block number
- */
-static inline void data_key_init(union ubifs_key *key, ino_t inum,
-				 unsigned int block)
-{
-	assert(!(block & ~UBIFS_S_KEY_BLOCK_MASK));
-	key->u32[0] = inum;
-	key->u32[1] = block | (UBIFS_DATA_KEY << UBIFS_S_KEY_BLOCK_BITS);
-}
-
-/**
- * key_write - transform a key from in-memory format.
- * @c: UBIFS file-system description object
- * @from: the key to transform
- * @to: the key to store the result
- */
-static inline void key_write(const union ubifs_key *from, void *to)
-{
-	__le32 x[2];
-
-	x[0] = cpu_to_le32(from->u32[0]);
-	x[1] = cpu_to_le32(from->u32[1]);
-
-	memcpy(to, &x, 8);
-	memset(to + 8, 0, UBIFS_MAX_KEY_LEN - 8);
-}
-
-/**
- * key_write_idx - transform a key from in-memory format for the index.
- * @c: UBIFS file-system description object
- * @from: the key to transform
- * @to: the key to store the result
- */
-static inline void key_write_idx(const union ubifs_key *from, void *to)
-{
-	__le32 x[2];
-
-	x[0] = cpu_to_le32(from->u32[0]);
-	x[1] = cpu_to_le32(from->u32[1]);
-
-	memcpy(to, &x, 8);
-}
-
-/**
- * keys_cmp - compare keys.
- * @c: UBIFS file-system description object
- * @key1: the first key to compare
- * @key2: the second key to compare
- *
- * This function compares 2 keys and returns %-1 if @key1 is less than
- * @key2, 0 if the keys are equivalent and %1 if @key1 is greater than @key2.
- */
-static inline int keys_cmp(const union ubifs_key *key1,
-			   const union ubifs_key *key2)
-{
-	if (key1->u32[0] < key2->u32[0])
-		return -1;
-	if (key1->u32[0] > key2->u32[0])
-		return 1;
-	if (key1->u32[1] < key2->u32[1])
-		return -1;
-	if (key1->u32[1] > key2->u32[1])
-		return 1;
-
-	return 0;
-}
-
-/**
- * key_type - get key type.
- * @c: UBIFS file-system description object
- * @key: key to get type of
- */
-static inline int key_type(const union ubifs_key *key)
-{
-	return key->u32[1] >> UBIFS_S_KEY_BLOCK_BITS;
-}
-
-#endif /* !__UBIFS_KEY_H__ */
diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
deleted file mode 100644
index 0723698d..00000000
--- a/ubifs-utils/common/lpt.c
+++ /dev/null
@@ -1,595 +0,0 @@
-/*
- * This file is part of UBIFS.
- *
- * Copyright (C) 2006, 2007 Nokia Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Authors: Adrian Hunter
- *          Artem Bityutskiy
- */
-
-#ifdef WITH_CRYPTO
-#include <openssl/evp.h>
-#endif
-
-#include "lpt.h"
-#include "bitops.h"
-#include "defs.h"
-#include "ubifs.h"
-#include "crc16.h"
-#include "sign.h"
-
-/**
- * do_calc_lpt_geom - calculate sizes for the LPT area.
- * @c: the UBIFS file-system description object
- *
- * Calculate the sizes of LPT bit fields, nodes, and tree, based on the
- * properties of the flash and whether LPT is "big" (c->big_lpt).
- */
-static void do_calc_lpt_geom(struct ubifs_info *c)
-{
-	int n, bits, per_leb_wastage;
-	long long sz, tot_wastage;
-
-	c->pnode_cnt = (c->main_lebs + UBIFS_LPT_FANOUT - 1) / UBIFS_LPT_FANOUT;
-
-	n = (c->pnode_cnt + UBIFS_LPT_FANOUT - 1) / UBIFS_LPT_FANOUT;
-	c->nnode_cnt = n;
-	while (n > 1) {
-		n = (n + UBIFS_LPT_FANOUT - 1) / UBIFS_LPT_FANOUT;
-		c->nnode_cnt += n;
-	}
-
-	c->lpt_hght = 1;
-	n = UBIFS_LPT_FANOUT;
-	while (n < c->pnode_cnt) {
-		c->lpt_hght += 1;
-		n <<= UBIFS_LPT_FANOUT_SHIFT;
-	}
-
-	c->space_bits = fls(c->leb_size) - 3;
-	c->lpt_lnum_bits = fls(c->lpt_lebs);
-	c->lpt_offs_bits = fls(c->leb_size - 1);
-	c->lpt_spc_bits = fls(c->leb_size);
-
-	n = (c->max_leb_cnt + UBIFS_LPT_FANOUT - 1) / UBIFS_LPT_FANOUT;
-	c->pcnt_bits = fls(n - 1);
-
-	c->lnum_bits = fls(c->max_leb_cnt - 1);
-
-	bits = UBIFS_LPT_CRC_BITS + UBIFS_LPT_TYPE_BITS +
-	       (c->big_lpt ? c->pcnt_bits : 0) +
-	       (c->space_bits * 2 + 1) * UBIFS_LPT_FANOUT;
-	c->pnode_sz = (bits + 7) / 8;
-
-	bits = UBIFS_LPT_CRC_BITS + UBIFS_LPT_TYPE_BITS +
-	       (c->big_lpt ? c->pcnt_bits : 0) +
-	       (c->lpt_lnum_bits + c->lpt_offs_bits) * UBIFS_LPT_FANOUT;
-	c->nnode_sz = (bits + 7) / 8;
-
-	bits = UBIFS_LPT_CRC_BITS + UBIFS_LPT_TYPE_BITS +
-	       c->lpt_lebs * c->lpt_spc_bits * 2;
-	c->ltab_sz = (bits + 7) / 8;
-
-	bits = UBIFS_LPT_CRC_BITS + UBIFS_LPT_TYPE_BITS +
-	       c->lnum_bits * c->lsave_cnt;
-	c->lsave_sz = (bits + 7) / 8;
-
-	/* Calculate the minimum LPT size */
-	c->lpt_sz = (long long)c->pnode_cnt * c->pnode_sz;
-	c->lpt_sz += (long long)c->nnode_cnt * c->nnode_sz;
-	c->lpt_sz += c->ltab_sz;
-	c->lpt_sz += c->lsave_sz;
-
-	/* Add wastage */
-	sz = c->lpt_sz;
-	per_leb_wastage = max_t(int, c->pnode_sz, c->nnode_sz);
-	sz += per_leb_wastage;
-	tot_wastage = per_leb_wastage;
-	while (sz > c->leb_size) {
-		sz += per_leb_wastage;
-		sz -= c->leb_size;
-		tot_wastage += per_leb_wastage;
-	}
-	tot_wastage += ALIGN(sz, c->min_io_size) - sz;
-	c->lpt_sz += tot_wastage;
-}
-
-/**
- * calc_dflt_lpt_geom - calculate default LPT geometry.
- * @c: the UBIFS file-system description object
- * @main_lebs: number of main area LEBs is passed and returned here
- * @big_lpt: whether the LPT area is "big" is returned here
- *
- * The size of the LPT area depends on parameters that themselves are dependent
- * on the size of the LPT area. This function, successively recalculates the LPT
- * area geometry until the parameters and resultant geometry are consistent.
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt)
-{
-	int i, lebs_needed;
-	long long sz;
-
-	/* Start by assuming the minimum number of LPT LEBs */
-	c->lpt_lebs = UBIFS_MIN_LPT_LEBS;
-	c->main_lebs = *main_lebs - c->lpt_lebs;
-	if (c->main_lebs <= 0)
-		return -EINVAL;
-
-	/* And assume we will use the small LPT model */
-	c->big_lpt = 0;
-
-	/*
-	 * Calculate the geometry based on assumptions above and then see if it
-	 * makes sense
-	 */
-	do_calc_lpt_geom(c);
-
-	/* Small LPT model must have lpt_sz < leb_size */
-	if (c->lpt_sz > c->leb_size) {
-		/* Nope, so try again using big LPT model */
-		c->big_lpt = 1;
-		do_calc_lpt_geom(c);
-	}
-
-	/* Now check there are enough LPT LEBs */
-	for (i = 0; i < 64 ; i++) {
-		sz = c->lpt_sz * 4; /* Allow 4 times the size */
-		sz += c->leb_size - 1;
-		do_div(sz, c->leb_size);
-		lebs_needed = sz;
-		if (lebs_needed > c->lpt_lebs) {
-			/* Not enough LPT LEBs so try again with more */
-			c->lpt_lebs = lebs_needed;
-			c->main_lebs = *main_lebs - c->lpt_lebs;
-			if (c->main_lebs <= 0)
-				return -EINVAL;
-			do_calc_lpt_geom(c);
-			continue;
-		}
-		if (c->ltab_sz > c->leb_size) {
-			errmsg("LPT ltab too big");
-			return -EINVAL;
-		}
-		*main_lebs = c->main_lebs;
-		*big_lpt = c->big_lpt;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-/**
- * pack_bits - pack bit fields end-to-end.
- * @addr: address at which to pack (passed and next address returned)
- * @pos: bit position at which to pack (passed and next position returned)
- * @val: value to pack
- * @nrbits: number of bits of value to pack (1-32)
- */
-static void pack_bits(uint8_t **addr, int *pos, uint32_t val, int nrbits)
-{
-	uint8_t *p = *addr;
-	int b = *pos;
-
-	if (b) {
-		*p |= ((uint8_t)val) << b;
-		nrbits += b;
-		if (nrbits > 8) {
-			*++p = (uint8_t)(val >>= (8 - b));
-			if (nrbits > 16) {
-				*++p = (uint8_t)(val >>= 8);
-				if (nrbits > 24) {
-					*++p = (uint8_t)(val >>= 8);
-					if (nrbits > 32)
-						*++p = (uint8_t)(val >>= 8);
-				}
-			}
-		}
-	} else {
-		*p = (uint8_t)val;
-		if (nrbits > 8) {
-			*++p = (uint8_t)(val >>= 8);
-			if (nrbits > 16) {
-				*++p = (uint8_t)(val >>= 8);
-				if (nrbits > 24)
-					*++p = (uint8_t)(val >>= 8);
-			}
-		}
-	}
-	b = nrbits & 7;
-	if (b == 0)
-		p++;
-	*addr = p;
-	*pos = b;
-}
-
-/**
- * pack_pnode - pack all the bit fields of a pnode.
- * @c: UBIFS file-system description object
- * @buf: buffer into which to pack
- * @pnode: pnode to pack
- */
-static void pack_pnode(struct ubifs_info *c, void *buf,
-		       struct ubifs_pnode *pnode)
-{
-	uint8_t *addr = buf + UBIFS_LPT_CRC_BYTES;
-	int i, pos = 0;
-	uint16_t crc;
-
-	pack_bits(&addr, &pos, UBIFS_LPT_PNODE, UBIFS_LPT_TYPE_BITS);
-	if (c->big_lpt)
-		pack_bits(&addr, &pos, pnode->num, c->pcnt_bits);
-	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
-		pack_bits(&addr, &pos, pnode->lprops[i].free >> 3,
-			  c->space_bits);
-		pack_bits(&addr, &pos, pnode->lprops[i].dirty >> 3,
-			  c->space_bits);
-		if (pnode->lprops[i].flags & LPROPS_INDEX)
-			pack_bits(&addr, &pos, 1, 1);
-		else
-			pack_bits(&addr, &pos, 0, 1);
-	}
-	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
-		    c->pnode_sz - UBIFS_LPT_CRC_BYTES);
-	addr = buf;
-	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
-}
-
-/**
- * pack_nnode - pack all the bit fields of a nnode.
- * @c: UBIFS file-system description object
- * @buf: buffer into which to pack
- * @nnode: nnode to pack
- */
-static void pack_nnode(struct ubifs_info *c, void *buf,
-		       struct ubifs_nnode *nnode)
-{
-	uint8_t *addr = buf + UBIFS_LPT_CRC_BYTES;
-	int i, pos = 0;
-	uint16_t crc;
-
-	pack_bits(&addr, &pos, UBIFS_LPT_NNODE, UBIFS_LPT_TYPE_BITS);
-	if (c->big_lpt)
-		pack_bits(&addr, &pos, nnode->num, c->pcnt_bits);
-	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
-		int lnum = nnode->nbranch[i].lnum;
-
-		if (lnum == 0)
-			lnum = c->lpt_last + 1;
-		pack_bits(&addr, &pos, lnum - c->lpt_first, c->lpt_lnum_bits);
-		pack_bits(&addr, &pos, nnode->nbranch[i].offs,
-			  c->lpt_offs_bits);
-	}
-	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
-		    c->nnode_sz - UBIFS_LPT_CRC_BYTES);
-	addr = buf;
-	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
-}
-
-/**
- * pack_ltab - pack the LPT's own lprops table.
- * @c: UBIFS file-system description object
- * @buf: buffer into which to pack
- * @ltab: LPT's own lprops table to pack
- */
-static void pack_ltab(struct ubifs_info *c, void *buf,
-			 struct ubifs_lpt_lprops *ltab)
-{
-	uint8_t *addr = buf + UBIFS_LPT_CRC_BYTES;
-	int i, pos = 0;
-	uint16_t crc;
-
-	pack_bits(&addr, &pos, UBIFS_LPT_LTAB, UBIFS_LPT_TYPE_BITS);
-	for (i = 0; i < c->lpt_lebs; i++) {
-		pack_bits(&addr, &pos, ltab[i].free, c->lpt_spc_bits);
-		pack_bits(&addr, &pos, ltab[i].dirty, c->lpt_spc_bits);
-	}
-	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
-		    c->ltab_sz - UBIFS_LPT_CRC_BYTES);
-	addr = buf;
-	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
-}
-
-/**
- * pack_lsave - pack the LPT's save table.
- * @c: UBIFS file-system description object
- * @buf: buffer into which to pack
- * @lsave: LPT's save table to pack
- */
-static void pack_lsave(struct ubifs_info *c, void *buf, int *lsave)
-{
-	uint8_t *addr = buf + UBIFS_LPT_CRC_BYTES;
-	int i, pos = 0;
-	uint16_t crc;
-
-	pack_bits(&addr, &pos, UBIFS_LPT_LSAVE, UBIFS_LPT_TYPE_BITS);
-	for (i = 0; i < c->lsave_cnt; i++)
-		pack_bits(&addr, &pos, lsave[i], c->lnum_bits);
-	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
-		    c->lsave_sz - UBIFS_LPT_CRC_BYTES);
-	addr = buf;
-	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
-}
-
-/**
- * set_ltab - set LPT LEB properties.
- * @c: UBIFS file-system description object
- * @lnum: LEB number
- * @free: amount of free space
- * @dirty: amount of dirty space
- */
-static void set_ltab(struct ubifs_info *c, int lnum, int free, int dirty)
-{
-	pr_debug("LEB %d free %d dirty %d to %d %d\n",
-		lnum, c->ltab[lnum - c->lpt_first].free,
-		c->ltab[lnum - c->lpt_first].dirty, free, dirty);
-	c->ltab[lnum - c->lpt_first].free = free;
-	c->ltab[lnum - c->lpt_first].dirty = dirty;
-}
-
-/**
- * calc_nnode_num - calculate nnode number.
- * @row: the row in the tree (root is zero)
- * @col: the column in the row (leftmost is zero)
- *
- * The nnode number is a number that uniquely identifies a nnode and can be used
- * easily to traverse the tree from the root to that nnode.
- *
- * This function calculates and returns the nnode number for the nnode at @row
- * and @col.
- */
-static int calc_nnode_num(int row, int col)
-{
-	int num, bits;
-
-	num = 1;
-	while (row--) {
-		bits = (col & (UBIFS_LPT_FANOUT - 1));
-		col >>= UBIFS_LPT_FANOUT_SHIFT;
-		num <<= UBIFS_LPT_FANOUT_SHIFT;
-		num |= bits;
-	}
-	return num;
-}
-
-/**
- * create_lpt - create LPT.
- * @c: UBIFS file-system description object
- *
- * This function returns %0 on success and a negative error code on failure.
- */
-int create_lpt(struct ubifs_info *c)
-{
-	int lnum, err = 0, i, j, cnt, len, alen, row;
-	int blnum, boffs, bsz, bcnt;
-	struct ubifs_pnode *pnode = NULL;
-	struct ubifs_nnode *nnode = NULL;
-	void *buf = NULL, *p;
-	int *lsave = NULL;
-	unsigned int md_len;
-
-	pnode = malloc(sizeof(struct ubifs_pnode));
-	nnode = malloc(sizeof(struct ubifs_nnode));
-	buf = malloc(c->leb_size);
-	lsave = malloc(sizeof(int) * c->lsave_cnt);
-	if (!pnode || !nnode || !buf || !lsave) {
-		err = -ENOMEM;
-		goto out;
-	}
-	memset(pnode, 0 , sizeof(struct ubifs_pnode));
-	memset(nnode, 0 , sizeof(struct ubifs_nnode));
-
-	hash_digest_init();
-
-	c->lscan_lnum = c->main_first;
-
-	lnum = c->lpt_first;
-	p = buf;
-	len = 0;
-	/* Number of leaf nodes (pnodes) */
-	cnt = (c->main_lebs + UBIFS_LPT_FANOUT - 1) >> UBIFS_LPT_FANOUT_SHIFT;
-	//printf("pnode_cnt=%d\n",cnt);
-
-	/*
-	 * To calculate the internal node branches, we keep information about
-	 * the level below.
-	 */
-	blnum = lnum; /* LEB number of level below */
-	boffs = 0; /* Offset of level below */
-	bcnt = cnt; /* Number of nodes in level below */
-	bsz = c->pnode_sz; /* Size of nodes in level below */
-
-	/* Add pnodes */
-	for (i = 0; i < cnt; i++) {
-		if (len + c->pnode_sz > c->leb_size) {
-			alen = ALIGN(len, c->min_io_size);
-			set_ltab(c, lnum, c->leb_size - alen, alen - len);
-			memset(p, 0xff, alen - len);
-			err = write_leb(c, lnum++, alen, buf);
-			if (err)
-				goto out;
-			p = buf;
-			len = 0;
-		}
-		/* Fill in the pnode */
-		for (j = 0; j < UBIFS_LPT_FANOUT; j++) {
-			int k = (i << UBIFS_LPT_FANOUT_SHIFT) + j;
-
-			if (k < c->main_lebs)
-				pnode->lprops[j] = c->lpt[k];
-			else {
-				pnode->lprops[j].free = c->leb_size;
-				pnode->lprops[j].dirty = 0;
-				pnode->lprops[j].flags = 0;
-			}
-		}
-		pack_pnode(c, p, pnode);
-
-		hash_digest_update(p, c->pnode_sz);
-
-		p += c->pnode_sz;
-		len += c->pnode_sz;
-		/*
-		 * pnodes are simply numbered left to right starting at zero,
-		 * which means the pnode number can be used easily to traverse
-		 * down the tree to the corresponding pnode.
-		 */
-		pnode->num += 1;
-	}
-
-	hash_digest_final(c->lpt_hash, &md_len);
-
-	row = c->lpt_hght - 1;
-	/* Add all nnodes, one level at a time */
-	while (1) {
-		/* Number of internal nodes (nnodes) at next level */
-		cnt = (cnt + UBIFS_LPT_FANOUT - 1) / UBIFS_LPT_FANOUT;
-		if (cnt == 0)
-			cnt = 1;
-		for (i = 0; i < cnt; i++) {
-			if (len + c->nnode_sz > c->leb_size) {
-				alen = ALIGN(len, c->min_io_size);
-				set_ltab(c, lnum, c->leb_size - alen,
-					    alen - len);
-				memset(p, 0xff, alen - len);
-				err = write_leb(c, lnum++, alen, buf);
-				if (err)
-					goto out;
-				p = buf;
-				len = 0;
-			}
-			/* The root is on row zero */
-			if (row == 0) {
-				c->lpt_lnum = lnum;
-				c->lpt_offs = len;
-			}
-			/* Set branches to the level below */
-			for (j = 0; j < UBIFS_LPT_FANOUT; j++) {
-				if (bcnt) {
-					if (boffs + bsz > c->leb_size) {
-						blnum += 1;
-						boffs = 0;
-					}
-					nnode->nbranch[j].lnum = blnum;
-					nnode->nbranch[j].offs = boffs;
-					boffs += bsz;
-					bcnt--;
-				} else {
-					nnode->nbranch[j].lnum = 0;
-					nnode->nbranch[j].offs = 0;
-				}
-			}
-			nnode->num = calc_nnode_num(row, i);
-			pack_nnode(c, p, nnode);
-			p += c->nnode_sz;
-			len += c->nnode_sz;
-		}
-		/* Row zero  is the top row */
-		if (row == 0)
-			break;
-		/* Update the information about the level below */
-		bcnt = cnt;
-		bsz = c->nnode_sz;
-		row -= 1;
-	}
-
-	if (c->big_lpt) {
-		/* Need to add LPT's save table */
-		if (len + c->lsave_sz > c->leb_size) {
-			alen = ALIGN(len, c->min_io_size);
-			set_ltab(c, lnum, c->leb_size - alen, alen - len);
-			memset(p, 0xff, alen - len);
-			err = write_leb(c, lnum++, alen, buf);
-			if (err)
-				goto out;
-			p = buf;
-			len = 0;
-		}
-
-		c->lsave_lnum = lnum;
-		c->lsave_offs = len;
-
-		for (i = 0; i < c->lsave_cnt; i++)
-			lsave[i] = c->main_first + i;
-
-		pack_lsave(c, p, lsave);
-		p += c->lsave_sz;
-		len += c->lsave_sz;
-	}
-
-	/* Need to add LPT's own LEB properties table */
-	if (len + c->ltab_sz > c->leb_size) {
-		alen = ALIGN(len, c->min_io_size);
-		set_ltab(c, lnum, c->leb_size - alen, alen - len);
-		memset(p, 0xff, alen - len);
-		err = write_leb(c, lnum++, alen, buf);
-		if (err)
-			goto out;
-		p = buf;
-		len = 0;
-	}
-
-	c->ltab_lnum = lnum;
-	c->ltab_offs = len;
-
-	/* Update ltab before packing it */
-	len += c->ltab_sz;
-	alen = ALIGN(len, c->min_io_size);
-	set_ltab(c, lnum, c->leb_size - alen, alen - len);
-
-	pack_ltab(c, p, c->ltab);
-	p += c->ltab_sz;
-
-	/* Write remaining buffer */
-	memset(p, 0xff, alen - len);
-	err = write_leb(c, lnum, alen, buf);
-	if (err)
-		goto out;
-
-	c->nhead_lnum = lnum;
-	c->nhead_offs = ALIGN(len, c->min_io_size);
-
-	pr_debug("lpt_sz:         %lld\n", c->lpt_sz);
-	pr_debug("space_bits:     %d\n", c->space_bits);
-	pr_debug("lpt_lnum_bits:  %d\n", c->lpt_lnum_bits);
-	pr_debug("lpt_offs_bits:  %d\n", c->lpt_offs_bits);
-	pr_debug("lpt_spc_bits:   %d\n", c->lpt_spc_bits);
-	pr_debug("pcnt_bits:      %d\n", c->pcnt_bits);
-	pr_debug("lnum_bits:      %d\n", c->lnum_bits);
-	pr_debug("pnode_sz:       %d\n", c->pnode_sz);
-	pr_debug("nnode_sz:       %d\n", c->nnode_sz);
-	pr_debug("ltab_sz:        %d\n", c->ltab_sz);
-	pr_debug("lsave_sz:       %d\n", c->lsave_sz);
-	pr_debug("lsave_cnt:      %d\n", c->lsave_cnt);
-	pr_debug("lpt_hght:       %d\n", c->lpt_hght);
-	pr_debug("big_lpt:        %d\n", c->big_lpt);
-	pr_debug("LPT root is at  %d:%d\n", c->lpt_lnum, c->lpt_offs);
-	pr_debug("LPT head is at  %d:%d\n", c->nhead_lnum, c->nhead_offs);
-	pr_debug("LPT ltab is at  %d:%d\n", c->ltab_lnum, c->ltab_offs);
-	if (c->big_lpt)
-		pr_debug("LPT lsave is at %d:%d\n",
-			 c->lsave_lnum, c->lsave_offs);
-out:
-	free(lsave);
-	free(buf);
-	free(nnode);
-	free(pnode);
-	return err;
-}
diff --git a/ubifs-utils/common/lpt.h b/ubifs-utils/common/lpt.h
deleted file mode 100644
index 86148a2a..00000000
--- a/ubifs-utils/common/lpt.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2008 Nokia Corporation.
- * Copyright (C) 2008 University of Szeged, Hungary
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Authors: Artem Bityutskiy
- *          Adrian Hunter
- */
-
-#ifndef __UBIFS_LPT_H__
-#define __UBIFS_LPT_H__
-
-#include "ubifs.h"
-
-int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt);
-int create_lpt(struct ubifs_info *c);
-
-#endif
diff --git a/ubifs-utils/common/sign.c b/ubifs-utils/common/sign.c
index dfbc96bf..032a6acc 100644
--- a/ubifs-utils/common/sign.c
+++ b/ubifs-utils/common/sign.c
@@ -30,8 +30,8 @@
 
 #include "linux_types.h"
 #include "sign.h"
-#include "defs.h"
 #include "ubifs.h"
+#include "defs.h"
 
 extern struct ubifs_info info_;
 static struct ubifs_info *c = &info_;
@@ -39,11 +39,6 @@ static struct ubifs_info *c = &info_;
 EVP_MD_CTX *hash_md;
 const EVP_MD *md;
 
-int authenticated(void)
-{
-	return c->hash_algo_name != NULL;
-}
-
 static int match_string(const char * const *array, size_t n, const char *string)
 {
 	int index;
@@ -242,36 +237,32 @@ out:
 	return x509;
 }
 
-int sign_superblock_node(void *node)
+int hash_sign_node(const char *auth_key_filename, const char *auth_cert_filename,
+		   void *buf, int *len, void *outbuf)
 {
 	EVP_PKEY *private_key;
 	CMS_ContentInfo *cms = NULL;
 	X509 *cert = NULL;
 	BIO *bd, *bm;
 	void *obuf;
-	long len;
 	int ret;
 	void *pret;
-	struct ubifs_sig_node *sig = node + UBIFS_SB_NODE_SZ;
-
-	if (!authenticated())
-		return 0;
 
 	ERR_load_crypto_strings();
 	ERR_clear_error();
 
 	key_pass = getenv("MKFS_UBIFS_SIGN_PIN");
 
-	bm = BIO_new_mem_buf(node, UBIFS_SB_NODE_SZ);
+	bm = BIO_new_mem_buf(buf, UBIFS_SB_NODE_SZ);
 
-	private_key = read_private_key(c->auth_key_filename, &cert);
+	private_key = read_private_key(auth_key_filename, &cert);
 	if (!private_key)
 		return -1;
 
 	if (!cert) {
-		if (!c->auth_cert_filename)
+		if (!auth_cert_filename)
 			return errmsg("authentication certificate not provided (--auth-cert)");
-		cert = read_x509(c->auth_cert_filename);
+		cert = read_x509(auth_cert_filename);
 	}
 
 	if (!cert)
@@ -302,13 +293,9 @@ int sign_superblock_node(void *node)
 	if (!ret)
 		return errmsg("i2d_CMS_bio_stream failed");
 
-	len = BIO_get_mem_data(bd, &obuf);
-
-	sig->type = UBIFS_SIGNATURE_TYPE_PKCS7;
-	sig->len = cpu_to_le32(len);
-	sig->ch.node_type  = UBIFS_SIG_NODE;
+	*len = BIO_get_mem_data(bd, &obuf);
 
-	memcpy(sig + 1, obuf, len);
+	memcpy(outbuf, obuf, *len);
 
 	BIO_free(bd);
 	BIO_free(bm);
@@ -316,83 +303,61 @@ int sign_superblock_node(void *node)
 	return 0;
 }
 
-/**
- * ubifs_node_calc_hash - calculate the hash of a UBIFS node
- * @c: UBIFS file-system description object
- * @node: the node to calculate a hash for
- * @hash: the returned hash
- */
-void ubifs_node_calc_hash(const void *node, uint8_t *hash)
+int hash_digest(const void *buf, unsigned int len, uint8_t *hash)
 {
-	const struct ubifs_ch *ch = node;
+	int err;
 	unsigned int md_len;
 
-	if (!authenticated())
-		return;
+	err = EVP_DigestInit_ex(hash_md, md, NULL);
+	if (!err)
+		return errmsg("Init hash digest failed");
+	err = EVP_DigestUpdate(hash_md, buf, len);
+	if (!err)
+		return errmsg("Update hash digest failed");
+	err = EVP_DigestFinal_ex(hash_md, hash, &md_len);
+	if (!err)
+		return errmsg("Finalize hash digest failed");
 
-	EVP_DigestInit_ex(hash_md, md, NULL);
-	EVP_DigestUpdate(hash_md, node, le32_to_cpu(ch->len));
-	EVP_DigestFinal_ex(hash_md, hash, &md_len);
+	return 0;
 }
 
-/**
- * mst_node_calc_hash - calculate the hash of a UBIFS master node
- * @c: UBIFS file-system description object
- * @node: the node to calculate a hash for
- * @hash: the returned hash
- */
-void mst_node_calc_hash(const void *node, uint8_t *hash)
+int hash_digest_init(void)
 {
-	unsigned int md_len;
+	int err;
 
-	if (!authenticated())
-		return;
+	err = EVP_DigestInit_ex(hash_md, md, NULL);
+	if (!err)
+		return errmsg("Init hash digest failed");
 
-	EVP_DigestInit_ex(hash_md, md, NULL);
-	EVP_DigestUpdate(hash_md, node + sizeof(struct ubifs_ch),
-			 UBIFS_MST_NODE_SZ - sizeof(struct ubifs_ch));
-	EVP_DigestFinal_ex(hash_md, hash, &md_len);
+	return 0;
 }
 
-void hash_digest_init(void)
+int hash_digest_update(const void *buf, int len)
 {
-	if (!authenticated())
-		return;
-
-	EVP_DigestInit_ex(hash_md, md, NULL);
-}
+	int err;
 
-void hash_digest_update(const void *buf, int len)
-{
-	if (!authenticated())
-		return;
+	err = EVP_DigestUpdate(hash_md, buf, len);
+	if (!err)
+		return errmsg("Update hash digest failed");
 
-	EVP_DigestUpdate(hash_md, buf, len);
+	return 0;
 }
 
-void hash_digest_final(void *hash, unsigned int *len)
+int hash_digest_final(void *hash)
 {
-	if (!authenticated())
-		return;
+	int err;
+	unsigned int md_len;
+
+	err = EVP_DigestFinal_ex(hash_md, hash, &md_len);
+	if (!err)
+		return errmsg("Finalize hash digest failed");
 
-	EVP_DigestFinal_ex(hash_md, hash, len);
+	return 0;
 }
 
-int init_authentication(void)
+int init_authentication(const char *algo_name, int *hash_len, int *hash_algo)
 {
-	int hash_algo;
-
-	if (!c->auth_key_filename && !c->auth_cert_filename && !c->hash_algo_name)
-		return 0;
-
-	if (!c->auth_key_filename)
-		return errmsg("authentication key not given (--auth-key)");
-
-	if (!c->hash_algo_name)
-		return errmsg("Hash algorithm not given (--hash-algo)");
-
 	OPENSSL_config(NULL);
-
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 
@@ -401,13 +366,30 @@ int init_authentication(void)
 		return errmsg("Unknown message digest %s", c->hash_algo_name);
 
 	hash_md = EVP_MD_CTX_create();
-	c->hash_len = EVP_MD_size(md);
-
-	hash_algo = match_string(hash_algo_name, HASH_ALGO__LAST, c->hash_algo_name);
-	if (hash_algo < 0)
-		return errmsg("Unsupported message digest %s", c->hash_algo_name);
+	if (!hash_md)
+		return errmsg("Cannot create md ctx");
+
+	*hash_len = EVP_MD_size(md);
+	if (*hash_len < 0) {
+		EVP_MD_CTX_destroy(hash_md);
+		hash_md = NULL;
+		return errmsg("Cannot init hash len");
+	}
 
-	c->hash_algo = hash_algo;
+	*hash_algo = match_string(hash_algo_name, HASH_ALGO__LAST, algo_name);
+	if (*hash_algo < 0) {
+		EVP_MD_CTX_destroy(hash_md);
+		hash_md = NULL;
+		return errmsg("Unsupported message digest %s", algo_name);
+	}
 
 	return 0;
 }
+
+void exit_authentication(void)
+{
+	if (hash_md) {
+		EVP_MD_CTX_destroy(hash_md);
+		hash_md = NULL;
+	}
+}
diff --git a/ubifs-utils/common/sign.h b/ubifs-utils/common/sign.h
index fe9fdd8b..f49c76a3 100644
--- a/ubifs-utils/common/sign.h
+++ b/ubifs-utils/common/sign.h
@@ -20,61 +20,20 @@
 #ifndef __UBIFS_SIGN_H__
 #define __UBIFS_SIGN_H__
 
-#ifdef WITH_CRYPTO
 #include <openssl/evp.h>
 
-void ubifs_node_calc_hash(const void *node, uint8_t *hash);
-void mst_node_calc_hash(const void *node, uint8_t *hash);
-void hash_digest_init(void);
-void hash_digest_update(const void *buf, int len);
-void hash_digest_final(void *hash, unsigned int *len);
-int init_authentication(void);
-int sign_superblock_node(void *node);
-int authenticated(void);
-
-extern EVP_MD_CTX *hash_md;
-extern const EVP_MD *md;
-
-#else
-static inline void ubifs_node_calc_hash(__attribute__((unused)) const void *node,
-					__attribute__((unused)) uint8_t *hash)
-{
-}
-
-static inline void mst_node_calc_hash(__attribute__((unused)) const void *node,
-				      __attribute__((unused)) uint8_t *hash)
-{
-}
-
-static inline void hash_digest_init(void)
-{
-}
-
-static inline void hash_digest_update(__attribute__((unused)) const void *buf,
-				      __attribute__((unused)) int len)
-{
-}
+struct shash_desc {
+	void *ctx;
+};
 
-static inline void hash_digest_final(__attribute__((unused)) void *hash,
-				     __attribute__((unused)) unsigned int *len)
-{
-}
-
-static inline int init_authentication(void)
-{
-	return 0;
-}
-
-static inline int sign_superblock_node(__attribute__((unused)) void *node)
-{
-	return 0;
-}
-
-static inline int authenticated(void)
-{
-	return 0;
-}
-
-#endif
+int hash_digest(const void *buf, unsigned int len, uint8_t *hash);
+int hash_digest_init(void);
+int hash_digest_update(const void *buf, int len);
+int hash_digest_final(void *hash);
+int init_authentication(const char *algo_name, int *hash_len, int *hash_algo);
+void exit_authentication(void);
+void mst_node_calc_hash(const void *node, uint8_t *hash);
+int hash_sign_node(const char *auth_key_filename, const char *auth_cert_filename,
+		   void *buf, int *len, void *outbuf);
 
 #endif /* __UBIFS_SIGN_H__ */
diff --git a/ubifs-utils/common/super.c b/ubifs-utils/common/super.c
deleted file mode 100644
index eee0197d..00000000
--- a/ubifs-utils/common/super.c
+++ /dev/null
@@ -1,123 +0,0 @@
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-#include "defs.h"
-
-/**
- * open_ubi - open the libubi.
- * @c: the UBIFS file-system description object
- * @node: name of the UBI volume character device to fetch information about
- *
- * This function opens libubi, and initialize device & volume information
- * according to @node. Returns %0 in case of success and %-1 in case of failure.
- */
-int open_ubi(struct ubifs_info *c, const char *node)
-{
-	struct stat st;
-
-	if (stat(node, &st) || !S_ISCHR(st.st_mode))
-		return -1;
-
-	c->libubi = libubi_open();
-	if (!c->libubi)
-		return -1;
-	if (ubi_get_vol_info(c->libubi, node, &c->vi))
-		goto out_err;
-	if (ubi_get_dev_info1(c->libubi, c->vi.dev_num, &c->di))
-		goto out_err;
-
-	return 0;
-
-out_err:
-	close_ubi(c);
-	return -1;
-}
-
-void close_ubi(struct ubifs_info *c)
-{
-	if (c->libubi) {
-		libubi_close(c->libubi);
-		c->libubi = NULL;
-	}
-}
-
-/**
- * open_target - open the output target.
- * @c: the UBIFS file-system description object
- *
- * Open the output target. The target can be an UBI volume
- * or a file.
- *
- * Returns %0 in case of success and %-1 in case of failure.
- */
-int open_target(struct ubifs_info *c)
-{
-	if (c->libubi) {
-		c->dev_fd = open(c->dev_name, O_RDWR | O_EXCL);
-
-		if (c->dev_fd == -1)
-			return sys_errmsg("cannot open the UBI volume '%s'",
-					   c->dev_name);
-		if (ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
-			close(c->dev_fd);
-			return sys_errmsg("ubi_set_property(set direct_write) failed");
-		}
-	} else {
-		c->dev_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
-			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
-		if (c->dev_fd == -1)
-			return sys_errmsg("cannot create output file '%s'",
-					   c->dev_name);
-	}
-	return 0;
-}
-
-
-/**
- * close_target - close the output target.
- * @c: the UBIFS file-system description object
- *
- * Close the output target. If the target was an UBI
- * volume, also close libubi.
- *
- * Returns %0 in case of success and %-1 in case of failure.
- */
-int close_target(struct ubifs_info *c)
-{
-	if (c->dev_fd >= 0) {
-		if (c->libubi && ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
-			return sys_errmsg("ubi_set_property(clear direct_write) failed");
-		if (close(c->dev_fd) == -1)
-			return sys_errmsg("cannot close the target '%s'", c->dev_name);
-	}
-	return 0;
-}
-
-/**
- * check_volume_empty - check if the UBI volume is empty.
- * @c: the UBIFS file-system description object
- *
- * This function checks if the UBI volume is empty by looking if its LEBs are
- * mapped or not.
- *
- * Returns %0 in case of success, %1 is the volume is not empty,
- * and a negative error code in case of failure.
- */
-int check_volume_empty(struct ubifs_info *c)
-{
-	int lnum, err;
-
-	for (lnum = 0; lnum < c->vi.rsvd_lebs; lnum++) {
-		err = ubi_is_mapped(c->dev_fd, lnum);
-		if (err < 0)
-			return err;
-		if (err == 1)
-			return 1;
-	}
-	return 0;
-}
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
deleted file mode 100644
index ed297cc7..00000000
--- a/ubifs-utils/common/ubifs.h
+++ /dev/null
@@ -1,498 +0,0 @@
-/*
- * This file is part of UBIFS.
- *
- * Copyright (C) 2008 Nokia Corporation.
- * Copyright (C) 2008 University of Szeged, Hungary
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Authors: Artem Bityutskiy
- *          Adrian Hunter
- *          Zoltan Sogor
- */
-
-#ifndef __UBIFS_H__
-#define __UBIFS_H__
-
-#include "ubifs-media.h"
-#include "libubi.h"
-
-/* Maximum logical eraseblock size in bytes */
-#define UBIFS_MAX_LEB_SZ (2*1024*1024)
-
-/* Minimum amount of data UBIFS writes to the flash */
-#define MIN_WRITE_SZ (UBIFS_DATA_NODE_SZ + 8)
-
-/* Largest key size supported in this implementation */
-#define CUR_MAX_KEY_LEN UBIFS_SK_LEN
-
-/*
- * There is no notion of truncation key because truncation nodes do not exist
- * in TNC. However, when replaying, it is handy to introduce fake "truncation"
- * keys for truncation nodes because the code becomes simpler. So we define
- * %UBIFS_TRUN_KEY type.
- */
-#define UBIFS_TRUN_KEY UBIFS_KEY_TYPES_CNT
-
-/*
- * How much a directory entry/extended attribute entry adds to the parent/host
- * inode.
- */
-#define CALC_DENT_SIZE(name_len) ALIGN(UBIFS_DENT_NODE_SZ + (name_len) + 1, 8)
-
-/* How much an extended attribute adds to the host inode */
-#define CALC_XATTR_BYTES(data_len) ALIGN(UBIFS_INO_NODE_SZ + (data_len) + 1, 8)
-
-/* The below union makes it easier to deal with keys */
-union ubifs_key
-{
-	uint8_t u8[CUR_MAX_KEY_LEN];
-	uint32_t u32[CUR_MAX_KEY_LEN/4];
-	uint64_t u64[CUR_MAX_KEY_LEN/8];
-	__le32 j32[CUR_MAX_KEY_LEN/4];
-};
-
-/*
- * LEB properties flags.
- *
- * LPROPS_UNCAT: not categorized
- * LPROPS_DIRTY: dirty > 0, not index
- * LPROPS_DIRTY_IDX: dirty + free > UBIFS_CH_SZ and index
- * LPROPS_FREE: free > 0, not empty, not index
- * LPROPS_HEAP_CNT: number of heaps used for storing categorized LEBs
- * LPROPS_EMPTY: LEB is empty, not taken
- * LPROPS_FREEABLE: free + dirty == leb_size, not index, not taken
- * LPROPS_FRDI_IDX: free + dirty == leb_size and index, may be taken
- * LPROPS_CAT_MASK: mask for the LEB categories above
- * LPROPS_TAKEN: LEB was taken (this flag is not saved on the media)
- * LPROPS_INDEX: LEB contains indexing nodes (this flag also exists on flash)
- */
-enum {
-	LPROPS_UNCAT     =  0,
-	LPROPS_DIRTY     =  1,
-	LPROPS_DIRTY_IDX =  2,
-	LPROPS_FREE      =  3,
-	LPROPS_HEAP_CNT  =  3,
-	LPROPS_EMPTY     =  4,
-	LPROPS_FREEABLE  =  5,
-	LPROPS_FRDI_IDX  =  6,
-	LPROPS_CAT_MASK  = 15,
-	LPROPS_TAKEN     = 16,
-	LPROPS_INDEX     = 32,
-};
-
-/**
- * struct ubifs_lprops - logical eraseblock properties.
- * @free: amount of free space in bytes
- * @dirty: amount of dirty space in bytes
- * @flags: LEB properties flags (see above)
- */
-struct ubifs_lprops
-{
-	int free;
-	int dirty;
-	int flags;
-};
-
-/**
- * struct ubifs_lpt_lprops - LPT logical eraseblock properties.
- * @free: amount of free space in bytes
- * @dirty: amount of dirty space in bytes
- */
-struct ubifs_lpt_lprops
-{
-	int free;
-	int dirty;
-};
-
-struct ubifs_nnode;
-
-/**
- * struct ubifs_cnode - LEB Properties Tree common node.
- * @parent: parent nnode
- * @cnext: next cnode to commit
- * @flags: flags (%DIRTY_LPT_NODE or %OBSOLETE_LPT_NODE)
- * @iip: index in parent
- * @level: level in the tree (zero for pnodes, greater than zero for nnodes)
- * @num: node number
- */
-struct ubifs_cnode
-{
-	struct ubifs_nnode *parent;
-	struct ubifs_cnode *cnext;
-	unsigned long flags;
-	int iip;
-	int level;
-	int num;
-};
-
-/**
- * struct ubifs_pnode - LEB Properties Tree leaf node.
- * @parent: parent nnode
- * @cnext: next cnode to commit
- * @flags: flags (%DIRTY_LPT_NODE or %OBSOLETE_LPT_NODE)
- * @iip: index in parent
- * @level: level in the tree (always zero for pnodes)
- * @num: node number
- * @lprops: LEB properties array
- */
-struct ubifs_pnode
-{
-	struct ubifs_nnode *parent;
-	struct ubifs_cnode *cnext;
-	unsigned long flags;
-	int iip;
-	int level;
-	int num;
-	struct ubifs_lprops lprops[UBIFS_LPT_FANOUT];
-};
-
-/**
- * struct ubifs_nbranch - LEB Properties Tree internal node branch.
- * @lnum: LEB number of child
- * @offs: offset of child
- * @nnode: nnode child
- * @pnode: pnode child
- * @cnode: cnode child
- */
-struct ubifs_nbranch
-{
-	int lnum;
-	int offs;
-	union
-	{
-		struct ubifs_nnode *nnode;
-		struct ubifs_pnode *pnode;
-		struct ubifs_cnode *cnode;
-	};
-};
-
-/**
- * struct ubifs_nnode - LEB Properties Tree internal node.
- * @parent: parent nnode
- * @cnext: next cnode to commit
- * @flags: flags (%DIRTY_LPT_NODE or %OBSOLETE_LPT_NODE)
- * @iip: index in parent
- * @level: level in the tree (always greater than zero for nnodes)
- * @num: node number
- * @nbranch: branches to child nodes
- */
-struct ubifs_nnode
-{
-	struct ubifs_nnode *parent;
-	struct ubifs_cnode *cnext;
-	unsigned long flags;
-	int iip;
-	int level;
-	int num;
-	struct ubifs_nbranch nbranch[UBIFS_LPT_FANOUT];
-};
-
-/**
- * struct ubifs_lp_stats - statistics of eraseblocks in the main area.
- * @empty_lebs: number of empty LEBs
- * @taken_empty_lebs: number of taken LEBs
- * @idx_lebs: number of indexing LEBs
- * @total_free: total free space in bytes
- * @total_dirty: total dirty space in bytes
- * @total_used: total used space in bytes (includes only data LEBs)
- * @total_dead: total dead space in bytes (includes only data LEBs)
- * @total_dark: total dark space in bytes (includes only data LEBs)
- */
-struct ubifs_lp_stats {
-	int empty_lebs;
-	int taken_empty_lebs;
-	int idx_lebs;
-	long long total_free;
-	long long total_dirty;
-	long long total_used;
-	long long total_dead;
-	long long total_dark;
-};
-
-/**
- * struct ubifs_zbranch - key/coordinate/length branch stored in znodes.
- * @key: key
- * @znode: znode address in memory
- * @lnum: LEB number of the indexing node
- * @offs: offset of the indexing node within @lnum
- * @len: target node length
- */
-struct ubifs_zbranch
-{
-	union ubifs_key key;
-	struct ubifs_znode *znode;
-	int lnum;
-	int offs;
-	int len;
-};
-
-/**
- * struct ubifs_znode - in-memory representation of an indexing node.
- * @parent: parent znode or NULL if it is the root
- * @cnext: next znode to commit
- * @flags: flags
- * @time: last access time (seconds)
- * @level: level of the entry in the TNC tree
- * @child_cnt: count of child znodes
- * @iip: index in parent's zbranch array
- * @alt: lower bound of key range has altered i.e. child inserted at slot 0
- * @zbranch: array of znode branches (@c->fanout elements)
- */
-struct ubifs_znode
-{
-	struct ubifs_znode *parent;
-	struct ubifs_znode *cnext;
-	unsigned long flags;
-	unsigned long time;
-	int level;
-	int child_cnt;
-	int iip;
-	int alt;
-#ifdef CONFIG_UBIFS_FS_DEBUG
-	int lnum, offs, len;
-#endif
-	struct ubifs_zbranch zbranch[];
-};
-
-/**
- * struct ubifs_info - UBIFS file-system description data structure
- * (per-superblock).
- *
- * @highest_inum: highest used inode number
- * @max_sqnum: current global sequence number
- *
- * @debug_level: level of debug messages, 0 - none, 1 - statistics,
- *		 2 - files, 3 - more details
- * @program_type: used to identify the type of current program
- * @program_name: program name
- * @dev_name: device name
- * @dev_fd: opening handler for an UBI volume or an image file
- * @libubi: opening handler for libubi
- *
- * @jhead_cnt: count of journal heads
- * @max_bud_bytes: maximum number of bytes allowed in buds
- *
- * @zroot: zbranch which points to the root index node and znode
- * @ihead_lnum: LEB number of index head
- * @ihead_offs: offset of index head
- *
- * @log_lebs: number of logical eraseblocks in the log
- * @lpt_lebs: number of LEBs used for lprops table
- * @lpt_first: first LEB of the lprops table area
- * @lpt_last: last LEB of the lprops table area
- * @main_lebs: count of LEBs in the main area
- * @main_first: first LEB of the main area
- * @default_compr: default compression type
- * @favor_lzo: favor LZO compression method
- * @favor_percent: lzo vs. zlib threshold used in case favor LZO
- *
- * @key_hash_type: type of the key hash
- * @key_hash: direntry key hash function
- * @key_fmt: key format
- * @key_len: key length
- * @fanout: fanout of the index tree (number of links per indexing node)
- *
- * @min_io_size: minimal input/output unit size
- * @leb_size: logical eraseblock size in bytes
- * @leb_cnt: count of logical eraseblocks
- * @max_leb_cnt: maximum count of logical eraseblocks
- *
- * @old_idx_sz: size of index on flash
- * @lst: lprops statistics
- *
- * @dead_wm: LEB dead space watermark
- * @dark_wm: LEB dark space watermark
- *
- * @di: UBI device information
- * @vi: UBI volume information
- *
- * @gc_lnum: LEB number used for garbage collection
- * @rp_size: reserved pool size
- *
- * @space_bits: number of bits needed to record free or dirty space
- * @lpt_lnum_bits: number of bits needed to record a LEB number in the LPT
- * @lpt_offs_bits: number of bits needed to record an offset in the LPT
- * @lpt_spc_bits: number of bits needed to space in the LPT
- * @pcnt_bits: number of bits needed to record pnode or nnode number
- * @lnum_bits: number of bits needed to record LEB number
- * @nnode_sz: size of on-flash nnode
- * @pnode_sz: size of on-flash pnode
- * @ltab_sz: size of on-flash LPT lprops table
- * @lsave_sz: size of on-flash LPT save table
- * @pnode_cnt: number of pnodes
- * @nnode_cnt: number of nnodes
- * @lpt_hght: height of the LPT
- *
- * @lpt_lnum: LEB number of the root nnode of the LPT
- * @lpt_offs: offset of the root nnode of the LPT
- * @nhead_lnum: LEB number of LPT head
- * @nhead_offs: offset of LPT head
- * @big_lpt: flag that LPT is too big to write whole during commit
- * @space_fixup: flag indicating that free space in LEBs needs to be cleaned up
- * @double_hash: flag indicating that we can do lookups by hash
- * @lpt_sz: LPT size
- *
- * @ltab_lnum: LEB number of LPT's own lprops table
- * @ltab_offs: offset of LPT's own lprops table
- * @lpt: lprops table
- * @ltab: LPT's own lprops table
- * @lsave_cnt: number of LEB numbers in LPT's save table
- * @lsave_lnum: LEB number of LPT's save table
- * @lsave_offs: offset of LPT's save table
- * @lsave: LPT's save table
- * @lscan_lnum: LEB number of last LPT scan
- *
- * @hash_algo_name: the name of the hashing algorithm to use
- * @hash_algo: The hash algo number (from include/linux/hash_info.h)
- * @auth_key_filename: authentication key file name
- * @x509_filename: x509 certificate file name for authentication
- * @hash_len: the length of the hash
- * @root_idx_hash: The hash of the root index node
- * @lpt_hash: The hash of the LPT
- * @mst_hash: The hash of the master node
- */
-struct ubifs_info
-{
-	ino_t highest_inum;
-	unsigned long long max_sqnum;
-
-	int debug_level;
-	int program_type;
-	const char *program_name;
-	char *dev_name;
-	int dev_fd;
-	libubi_t libubi;
-
-	int jhead_cnt;
-	long long max_bud_bytes;
-
-	struct ubifs_zbranch zroot;
-	int ihead_lnum;
-	int ihead_offs;
-
-	int log_lebs;
-	int lpt_lebs;
-	int lpt_first;
-	int lpt_last;
-	int orph_lebs;
-	int main_lebs;
-	int main_first;
-	int default_compr;
-	int favor_lzo;
-	int favor_percent;
-
-	uint8_t key_hash_type;
-	uint32_t (*key_hash)(const char *str, int len);
-	int key_fmt;
-	int key_len;
-	int fanout;
-
-	int min_io_size;
-	int leb_size;
-	int leb_cnt;
-	int max_leb_cnt;
-
-	unsigned long long old_idx_sz;
-	struct ubifs_lp_stats lst;
-
-	int dead_wm;
-	int dark_wm;
-
-	struct ubi_dev_info di;
-	struct ubi_vol_info vi;
-
-	int gc_lnum;
-	long long rp_size;
-
-	int space_bits;
-	int lpt_lnum_bits;
-	int lpt_offs_bits;
-	int lpt_spc_bits;
-	int pcnt_bits;
-	int lnum_bits;
-	int nnode_sz;
-	int pnode_sz;
-	int ltab_sz;
-	int lsave_sz;
-	int pnode_cnt;
-	int nnode_cnt;
-	int lpt_hght;
-
-	int lpt_lnum;
-	int lpt_offs;
-	int nhead_lnum;
-	int nhead_offs;
-	int big_lpt;
-	int space_fixup;
-	int double_hash;
-	int encrypted;
-	long long lpt_sz;
-
-	int ltab_lnum;
-	int ltab_offs;
-	struct ubifs_lprops *lpt;
-	struct ubifs_lpt_lprops *ltab;
-	int lsave_cnt;
-	int lsave_lnum;
-	int lsave_offs;
-	int *lsave;
-	int lscan_lnum;
-
-	char *hash_algo_name;
-	int hash_algo;
-	char *auth_key_filename;
-	char *auth_cert_filename;
-	int hash_len;
-	uint8_t root_idx_hash[UBIFS_MAX_HASH_LEN];
-	uint8_t lpt_hash[UBIFS_MAX_HASH_LEN];
-	uint8_t mst_hash[UBIFS_MAX_HASH_LEN];
-};
-
-/**
- * ubifs_idx_node_sz - return index node size.
- * @c: the UBIFS file-system description object
- * @child_cnt: number of children of this index node
- */
-static inline int ubifs_idx_node_sz(const struct ubifs_info *c, int child_cnt)
-{
-	return UBIFS_IDX_NODE_SZ + (UBIFS_BRANCH_SZ + c->key_len + c->hash_len)
-				    * child_cnt;
-}
-
-/**
- * ubifs_idx_branch - return pointer to an index branch.
- * @c: the UBIFS file-system description object
- * @idx: index node
- * @bnum: branch number
- */
-static inline
-struct ubifs_branch *ubifs_idx_branch(const struct ubifs_info *c,
-				      const struct ubifs_idx_node *idx,
-				      int bnum)
-{
-	return (struct ubifs_branch *)((void *)idx->branches +
-				       (UBIFS_BRANCH_SZ + c->key_len + c->hash_len) * bnum);
-}
-
-int write_leb(struct ubifs_info *c, int lnum, int len, void *buf);
-
-/* super.c */
-int open_ubi(struct ubifs_info *c, const char *node);
-void close_ubi(struct ubifs_info *c);
-int open_target(struct ubifs_info *c);
-int close_target(struct ubifs_info *c);
-int check_volume_empty(struct ubifs_info *c);
-
-#endif /* __UBIFS_H__ */
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index fb99222a..2817b6ce 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -46,15 +46,15 @@
 #include <zstd.h>
 #endif
 
-#include "linux_types.h"
-#include "defs.h"
+#include "bitops.h"
 #include "crypto.h"
 #include "fscrypt.h"
 #include "ubifs.h"
-#include "lpt.h"
-#include "compr.h"
+#include "defs.h"
+#include "debug.h"
 #include "key.h"
-#include "sign.h"
+#include "compr.h"
+#include "misc.h"
 #include "devtable.h"
 
 /* Size (prime number) of hash table for link counting */
@@ -291,11 +291,6 @@ static const char *helptext =
 "mkfs.ubifs supports building signed images. For this the \"--hash-algo\",\n"
 "\"--auth-key\" and \"--auth-cert\" options have to be specified.\n";
 
-static inline uint8_t *ubifs_branch_hash(struct ubifs_branch *br)
-{
-	return (void *)br + sizeof(*br) + c->key_len;
-}
-
 /**
  * make_path - make a path name from a directory and a name.
  * @dir: directory path name
@@ -914,97 +909,13 @@ static int get_options(int argc, char**argv)
 }
 
 /**
- * prepare_node - fill in the common header.
- * @node: node
- * @len: node length
- */
-static void prepare_node(void *node, int len)
-{
-	uint32_t crc;
-	struct ubifs_ch *ch = node;
-
-	ch->magic = cpu_to_le32(UBIFS_NODE_MAGIC);
-	ch->len = cpu_to_le32(len);
-	ch->group_type = UBIFS_NO_NODE_GROUP;
-	ch->sqnum = cpu_to_le64(++c->max_sqnum);
-	ch->padding[0] = ch->padding[1] = 0;
-	crc = mtd_crc32(UBIFS_CRC32_INIT, node + 8, len - 8);
-	ch->crc = cpu_to_le32(crc);
-}
-
-/**
- * write_leb - copy the image of a LEB to the output target.
- * @c: the UBIFS file-system description object
- * @lnum: LEB number
- * @len: length of data in the buffer
- * @buf: buffer (must be at least c->leb_size bytes)
- */
-int write_leb(struct ubifs_info *c, int lnum, int len, void *buf)
-{
-	off_t pos = (off_t)lnum * c->leb_size;
-
-	pr_debug("LEB %d len %d\n", lnum, len);
-	memset(buf + len, 0xff, c->leb_size - len);
-	if (c->libubi)
-		if (ubi_leb_change_start(c->libubi, c->dev_fd, lnum, c->leb_size))
-			return sys_errmsg("ubi_leb_change_start failed");
-
-	if (lseek(c->dev_fd, pos, SEEK_SET) != pos)
-		return sys_errmsg("lseek failed seeking %lld", (long long)pos);
-
-	if (write(c->dev_fd, buf, c->leb_size) != c->leb_size)
-		return sys_errmsg("write failed writing %d bytes at pos %lld",
-				   c->leb_size, (long long)pos);
-
-	return 0;
-}
-
-/**
  * write_empty_leb - copy the image of an empty LEB to the output target.
  * @lnum: LEB number
  */
 static int write_empty_leb(int lnum)
 {
-	return write_leb(c, lnum, 0, leb_buf);
-}
-
-/**
- * do_pad - pad a buffer to the minimum I/O size.
- * @buf: buffer
- * @len: buffer length
- */
-static int do_pad(void *buf, int len)
-{
-	int pad_len, alen = ALIGN(len, 8), wlen = ALIGN(alen, c->min_io_size);
-	uint32_t crc;
-
-	memset(buf + len, 0xff, alen - len);
-	pad_len = wlen - alen;
-	pr_debug("len %d pad_len %d\n", len, pad_len);
-	buf += alen;
-	if (pad_len >= (int)UBIFS_PAD_NODE_SZ) {
-		struct ubifs_ch *ch = buf;
-		struct ubifs_pad_node *pad_node = buf;
-
-		ch->magic      = cpu_to_le32(UBIFS_NODE_MAGIC);
-		ch->node_type  = UBIFS_PAD_NODE;
-		ch->group_type = UBIFS_NO_NODE_GROUP;
-		ch->padding[0] = ch->padding[1] = 0;
-		ch->sqnum      = cpu_to_le64(0);
-		ch->len        = cpu_to_le32(UBIFS_PAD_NODE_SZ);
-
-		pad_len -= UBIFS_PAD_NODE_SZ;
-		pad_node->pad_len = cpu_to_le32(pad_len);
-
-		crc = mtd_crc32(UBIFS_CRC32_INIT, buf + 8,
-				  UBIFS_PAD_NODE_SZ - 8);
-		ch->crc = cpu_to_le32(crc);
-
-		memset(buf + UBIFS_PAD_NODE_SZ, 0, pad_len);
-	} else if (pad_len > 0)
-		memset(buf, UBIFS_PADDING_BYTE, pad_len);
-
-	return wlen;
+	memset(leb_buf, 0xff, c->leb_size);
+	return ubifs_leb_change(c, lnum, leb_buf, c->leb_size);
 }
 
 /**
@@ -1015,13 +926,16 @@ static int do_pad(void *buf, int len)
  */
 static int write_node(void *node, int len, int lnum)
 {
-	prepare_node(node, len);
+	int alen = ALIGN(len, 8), wlen = ALIGN(len, c->min_io_size);
 
+	ubifs_prepare_node(c, node, len, 0);
 	memcpy(leb_buf, node, len);
+	memset(leb_buf + len, 0xff, alen - len);
+	ubifs_pad(c, leb_buf + alen, wlen - alen);
 
-	len = do_pad(leb_buf, len);
+	memset(leb_buf + wlen, 0xff, c->leb_size - wlen);
 
-	return write_leb(c, lnum, len, leb_buf);
+	return ubifs_leb_change(c, lnum, leb_buf, c->leb_size);
 }
 
 /**
@@ -1133,8 +1047,10 @@ static int flush_nodes(void)
 
 	if (!head_offs)
 		return 0;
-	len = do_pad(leb_buf, head_offs);
-	err = write_leb(c, head_lnum, len, leb_buf);
+	len = ALIGN(head_offs, c->min_io_size);
+	ubifs_pad(c, leb_buf + head_offs, len - head_offs);
+	memset(leb_buf + len, 0xff, c->leb_size - len);
+	err = ubifs_leb_change(c, head_lnum, leb_buf, c->leb_size);
 	if (err)
 		return err;
 	set_lprops(head_lnum, head_offs, head_flags);
@@ -1172,7 +1088,7 @@ static int reserve_space(int len, int *lnum, int *offs)
  */
 static int add_node(union ubifs_key *key, char *name, int name_len, void *node, int len)
 {
-	int err, lnum, offs, type = key_type(key);
+	int err, lnum, offs, type = key_type(c, key);
 	uint8_t hash[UBIFS_MAX_HASH_LEN];
 
 	if (type == UBIFS_DENT_KEY || type == UBIFS_XENT_KEY) {
@@ -1184,7 +1100,7 @@ static int add_node(union ubifs_key *key, char *name, int name_len, void *node,
 			return errmsg("Name given for non dir/xattr node!");
 	}
 
-	prepare_node(node, len);
+	ubifs_prepare_node(c, node, len, 0);
 
 	err = reserve_space(len, &lnum, &offs);
 	if (err)
@@ -1193,7 +1109,7 @@ static int add_node(union ubifs_key *key, char *name, int name_len, void *node,
 	memcpy(leb_buf + offs, node, len);
 	memset(leb_buf + offs + len, 0xff, ALIGN(len, 8) - len);
 
-	ubifs_node_calc_hash(node, hash);
+	ubifs_node_calc_hash(c, node, hash);
 
 	add_to_index(key, name, name_len, lnum, offs, len, hash);
 
@@ -1206,43 +1122,43 @@ static int add_xattr(struct ubifs_ino_node *host_ino, struct stat *st,
 {
 	struct ubifs_ino_node *ino;
 	struct ubifs_dent_node *xent;
-	struct qstr nm;
+	struct fscrypt_name nm;
 	char *tmp_name;
 	union ubifs_key xkey, nkey;
 	int len, ret;
 
-	nm.len = strlen(name);
-	tmp_name = xmalloc(nm.len + 1);
-	memcpy(tmp_name, name, nm.len + 1);
-	nm.name = tmp_name;
+	fname_len(&nm) = strlen(name);
+	tmp_name = xmalloc(fname_len(&nm) + 1);
+	memcpy(tmp_name, name, fname_len(&nm) + 1);
+	fname_name(&nm) = tmp_name;
 
 	host_ino->xattr_cnt++;
-	host_ino->xattr_size += CALC_DENT_SIZE(nm.len);
+	host_ino->xattr_size += CALC_DENT_SIZE(fname_len(&nm));
 	host_ino->xattr_size += CALC_XATTR_BYTES(data_len);
-	host_ino->xattr_names += nm.len;
+	host_ino->xattr_names += fname_len(&nm);
 
-	xent = xzalloc(sizeof(*xent) + nm.len + 1);
+	xent = xzalloc(sizeof(*xent) + fname_len(&nm) + 1);
 	ino = xzalloc(sizeof(*ino) + data_len);
 
 	xent_key_init(c, &xkey, inum, &nm);
 	xent->ch.node_type = UBIFS_XENT_NODE;
-	key_write(&xkey, &xent->key);
+	key_write(c, &xkey, &xent->key);
 
-	len = UBIFS_XENT_NODE_SZ + nm.len + 1;
+	len = UBIFS_XENT_NODE_SZ + fname_len(&nm) + 1;
 
 	xent->ch.len = len;
 	xent->padding1 = 0;
 	xent->type = UBIFS_ITYPE_REG;
-	xent->nlen = cpu_to_le16(nm.len);
+	xent->nlen = cpu_to_le16(fname_len(&nm));
 
-	memcpy(xent->name, nm.name, nm.len + 1);
+	memcpy(xent->name, fname_name(&nm), fname_len(&nm) + 1);
 
 	inum = ++c->highest_inum;
 	creat_sqnum = ++c->max_sqnum;
 
 	xent->inum = cpu_to_le64(inum);
 
-	ret = add_node(&xkey, tmp_name, nm.len, xent, len);
+	ret = add_node(&xkey, tmp_name, fname_len(&nm), xent, len);
 	if (ret)
 		goto out;
 
@@ -1263,8 +1179,8 @@ static int add_xattr(struct ubifs_ino_node *host_ino, struct stat *st,
 	ino->compr_type = cpu_to_le16(c->default_compr);
 	ino->ch.node_type = UBIFS_INO_NODE;
 
-	ino_key_init(&nkey, inum);
-	key_write(&nkey, &ino->key);
+	ino_key_init(c, &nkey, inum);
+	key_write(c, &nkey, &ino->key);
 
 	ino->size       = cpu_to_le64(data_len);
 	ino->mode       = cpu_to_le32(S_IFREG);
@@ -1557,9 +1473,9 @@ static int add_inode(struct stat *st, ino_t inum, void *data,
 		use_flags |= UBIFS_CRYPT_FL;
 	memset(ino, 0, UBIFS_INO_NODE_SZ);
 
-	ino_key_init(&key, inum);
+	ino_key_init(c, &key, inum);
 	ino->ch.node_type = UBIFS_INO_NODE;
-	key_write(&key, &ino->key);
+	key_write(c, &key, &ino->key);
 	ino->creat_sqnum = cpu_to_le64(creat_sqnum);
 	ino->size       = cpu_to_le64(st->st_size);
 	ino->nlink      = cpu_to_le32(st->st_nlink);
@@ -1710,6 +1626,7 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 	struct ubifs_dent_node *dent = node_buf;
 	union ubifs_key key;
 	struct qstr dname;
+	struct fscrypt_name nm;
 	char *kname;
 	int len;
 
@@ -1747,13 +1664,15 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 		*kname_len = ret;
 	}
 
-	dent_key_init(c, &key, dir_inum, kname, *kname_len);
+	fname_name(&nm) = kname;
+	fname_len(&nm) = *kname_len;
+	dent_key_init(c, &key, dir_inum, &nm);
 	dent->nlen = cpu_to_le16(*kname_len);
 	memcpy(dent->name, kname, *kname_len);
 	dent->name[*kname_len] = '\0';
 	len = UBIFS_DENT_NODE_SZ + *kname_len + 1;
 
-	key_write(&key, dent->key);
+	key_write(c, &key, dent->key);
 
 	return add_node(&key, kname, *kname_len, dent, len);
 }
@@ -1849,9 +1768,9 @@ static int add_file(const char *path_name, struct stat *st, ino_t inum,
 		}
 		/* Make data node */
 		memset(dn, 0, UBIFS_DATA_NODE_SZ);
-		data_key_init(&key, inum, block_no);
+		data_key_init(c, &key, inum, block_no);
 		dn->ch.node_type = UBIFS_DATA_NODE;
-		key_write(&key, &dn->key);
+		key_write(c, &key, &dn->key);
 		out_len = NODE_BUFFER_SIZE - UBIFS_DATA_NODE_SZ;
 		if (c->default_compr == UBIFS_COMPR_NONE &&
 		    !c->encrypted && (flags & FS_COMPR_FL))
@@ -2313,7 +2232,7 @@ static int cmp_idx(const void *a, const void *b)
 	const struct idx_entry *e2 = *(const struct idx_entry **)b;
 	int cmp;
 
-	cmp = keys_cmp(&e1->key, &e2->key);
+	cmp = keys_cmp(c, &e1->key, &e2->key);
 	if (cmp)
 		return cmp;
 	return namecmp(e1, e2);
@@ -2330,7 +2249,7 @@ static int add_idx_node(void *node, int child_cnt)
 
 	len = ubifs_idx_node_sz(c, child_cnt);
 
-	prepare_node(node, len);
+	ubifs_prepare_node(c, node, len, 0);
 
 	err = reserve_space(len, &lnum, &offs);
 	if (err)
@@ -2339,10 +2258,10 @@ static int add_idx_node(void *node, int child_cnt)
 	memcpy(leb_buf + offs, node, len);
 	memset(leb_buf + offs + len, 0xff, ALIGN(len, 8) - len);
 
-	c->old_idx_sz += ALIGN(len, 8);
+	c->bi.old_idx_sz += ALIGN(len, 8);
 
 	pr_debug("at %d:%d len %d index size %llu\n", lnum, offs, len,
-		 c->old_idx_sz);
+		 c->bi.old_idx_sz);
 
 	/* The last index node written will be the root */
 	c->zroot.lnum = lnum;
@@ -2409,15 +2328,15 @@ static int write_index(void)
 		idx->level = cpu_to_le16(0);
 		for (j = 0; j < child_cnt; j++, p++) {
 			br = ubifs_idx_branch(c, idx, j);
-			key_write_idx(&(*p)->key, &br->key);
+			key_write_idx(c, &(*p)->key, &br->key);
 			br->lnum = cpu_to_le32((*p)->lnum);
 			br->offs = cpu_to_le32((*p)->offs);
 			br->len = cpu_to_le32((*p)->len);
-			memcpy(ubifs_branch_hash(br), (*p)->hash, c->hash_len);
+			memcpy(ubifs_branch_hash(c, br), (*p)->hash, c->hash_len);
 		}
 		add_idx_node(idx, child_cnt);
 
-		ubifs_node_calc_hash(idx, hashes + i * c->hash_len);
+		ubifs_node_calc_hash(c, idx, hashes + i * c->hash_len);
 	}
 	/* Write level 1 index nodes and above */
 	level = 0;
@@ -2484,7 +2403,7 @@ static int write_index(void)
 				 * of the index node from the level below.
 				 */
 				br = ubifs_idx_branch(c, idx, j);
-				key_write_idx(&(*p)->key, &br->key);
+				key_write_idx(c, &(*p)->key, &br->key);
 				br->lnum = cpu_to_le32(blnum);
 				br->offs = cpu_to_le32(boffs);
 				br->len = cpu_to_le32(blen);
@@ -2495,12 +2414,12 @@ static int write_index(void)
 				boffs += ALIGN(blen, 8);
 				p += pstep;
 
-				memcpy(ubifs_branch_hash(br),
+				memcpy(ubifs_branch_hash(c, br),
 				       hashes + bn * c->hash_len,
 				       c->hash_len);
 			}
 			add_idx_node(idx, child_cnt);
-			ubifs_node_calc_hash(idx, hashes + i * c->hash_len);
+			ubifs_node_calc_hash(c, idx, hashes + i * c->hash_len);
 		}
 	}
 
@@ -2571,7 +2490,7 @@ static int finalize_leb_cnt(void)
 	pr_debug("total_used:  %llu\n", c->lst.total_used);
 	pr_debug("total_dead:  %llu\n", c->lst.total_dead);
 	pr_debug("total_dark:  %llu\n", c->lst.total_dark);
-	pr_debug("index size:  %llu\n", c->old_idx_sz);
+	pr_debug("index size:  %llu\n", c->bi.old_idx_sz);
 	pr_debug("empty_lebs:  %d\n", c->lst.empty_lebs);
 	return 0;
 }
@@ -2598,7 +2517,6 @@ static int write_super(void)
 	buf = xzalloc(c->leb_size);
 
 	sup = buf;
-	sig = buf + UBIFS_SB_NODE_SZ;
 
 	sup->ch.node_type  = UBIFS_SB_NODE;
 	sup->key_hash      = c->key_hash_type;
@@ -2634,27 +2552,27 @@ static int write_super(void)
 		sup->flags |= cpu_to_le32(UBIFS_FLG_DOUBLE_HASH);
 	if (c->encrypted)
 		sup->flags |= cpu_to_le32(UBIFS_FLG_ENCRYPTION);
-	if (authenticated()) {
+	if (ubifs_authenticated(c)) {
 		sup->flags |= cpu_to_le32(UBIFS_FLG_AUTHENTICATION);
 		memcpy(sup->hash_mst, c->mst_hash, c->hash_len);
 	}
 
-	prepare_node(sup, UBIFS_SB_NODE_SZ);
+	ubifs_prepare_node(c, sup, UBIFS_SB_NODE_SZ, 0);
 
-	err = sign_superblock_node(sup);
+	err = ubifs_sign_superblock_node(c, sup);
 	if (err)
 		goto out;
 
 	sig = (void *)(sup + 1);
-	prepare_node(sig, UBIFS_SIG_NODE_SZ + le32_to_cpu(sig->len));
+	ubifs_prepare_node(c, sig, UBIFS_SIG_NODE_SZ + le32_to_cpu(sig->len), 1);
 
-	len = do_pad(sig, UBIFS_SIG_NODE_SZ + le32_to_cpu(sig->len));
+	len = ALIGN(ALIGN(UBIFS_SIG_NODE_SZ + le32_to_cpu(sig->len), 8), c->min_io_size);
+	memset(buf + UBIFS_SB_NODE_SZ + len, 0xff, c->leb_size - (UBIFS_SB_NODE_SZ + len));
 
-	err = write_leb(c, UBIFS_SB_LNUM, UBIFS_SB_NODE_SZ + len, sup);
+	err = ubifs_leb_change(c, UBIFS_SB_LNUM, buf, c->leb_size);
 	if (err)
 		goto out;
 
-	err = 0;
 out:
 	free(buf);
 
@@ -2682,7 +2600,7 @@ static int write_master(void)
 	mst.gc_lnum      = cpu_to_le32(c->gc_lnum);
 	mst.ihead_lnum   = cpu_to_le32(c->ihead_lnum);
 	mst.ihead_offs   = cpu_to_le32(c->ihead_offs);
-	mst.index_size   = cpu_to_le64(c->old_idx_sz);
+	mst.index_size   = cpu_to_le64(c->bi.old_idx_sz);
 	mst.lpt_lnum     = cpu_to_le32(c->lpt_lnum);
 	mst.lpt_offs     = cpu_to_le32(c->lpt_offs);
 	mst.nhead_lnum   = cpu_to_le32(c->nhead_lnum);
@@ -2701,7 +2619,7 @@ static int write_master(void)
 	mst.total_dark   = cpu_to_le64(c->lst.total_dark);
 	mst.leb_cnt      = cpu_to_le32(c->leb_cnt);
 
-	if (authenticated()) {
+	if (ubifs_authenticated(c)) {
 		memcpy(mst.hash_root_idx, c->root_idx_hash, c->hash_len);
 		memcpy(mst.hash_lpt, c->lpt_hash, c->hash_len);
 	}
@@ -2714,7 +2632,9 @@ static int write_master(void)
 	if (err)
 		return err;
 
-	mst_node_calc_hash(&mst, c->mst_hash);
+	err = ubifs_master_node_calc_hash(c, &mst, c->mst_hash);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -2754,7 +2674,8 @@ static int write_lpt(void)
 {
 	int err, lnum;
 
-	err = create_lpt(c);
+	c->lscan_lnum = c->main_first;
+	err = ubifs_create_lpt(c, c->lpt, c->main_lebs, c->lpt_hash);
 	if (err)
 		return err;
 
@@ -2789,7 +2710,7 @@ static int write_orphan_area(void)
  */
 static int init(void)
 {
-	int err, i, main_lebs, big_lpt = 0, sz;
+	int err, main_lebs, big_lpt = 0, sz;
 
 	c->highest_inum = UBIFS_FIRST_INO;
 
@@ -2798,7 +2719,7 @@ static int init(void)
 	main_lebs = c->max_leb_cnt - UBIFS_SB_LEBS - UBIFS_MST_LEBS;
 	main_lebs -= c->log_lebs + c->orph_lebs;
 
-	err = calc_dflt_lpt_geom(c, &main_lebs, &big_lpt);
+	err = ubifs_calc_dflt_lpt_geom(c, &main_lebs, &big_lpt);
 	if (err)
 		return err;
 
@@ -2811,13 +2732,6 @@ static int init(void)
 	c->lpt_last = c->lpt_first + c->lpt_lebs - 1;
 
 	c->lpt = xmalloc(c->main_lebs * sizeof(struct ubifs_lprops));
-	c->ltab = xmalloc(c->lpt_lebs * sizeof(struct ubifs_lprops));
-
-	/* Initialize LPT's own lprops */
-	for (i = 0; i < c->lpt_lebs; i++) {
-		c->ltab[i].free = c->leb_size;
-		c->ltab[i].dirty = 0;
-	}
 
 	c->dead_wm = ALIGN(MIN_WRITE_SZ, c->min_io_size);
 	c->dark_wm = ALIGN(UBIFS_MAX_NODE_SZ, c->min_io_size);
@@ -2877,7 +2791,6 @@ static void deinit(void)
 #endif
 
 	free(c->lpt);
-	free(c->ltab);
 	free(leb_buf);
 	free(node_buf);
 	free(block_buf);
@@ -2885,6 +2798,7 @@ static void deinit(void)
 	free(hash_table);
 	destroy_compression();
 	free_devtable_info();
+	ubifs_exit_authentication(c);
 }
 
 /**
@@ -2904,7 +2818,7 @@ static int mkfs(void)
 	if (err)
 		goto out;
 
-	err = init_authentication();
+	err = ubifs_init_authentication(c);
 	if (err)
 		goto out;
 
@@ -2951,9 +2865,7 @@ int main(int argc, char *argv[])
 {
 	int err;
 
-	info_.program_name = MKFS_PROGRAM_NAME;
-	info_.program_type = MKFS_PROGRAM_TYPE;
-	info_.debug_level = WARN_LEVEL;
+	init_ubifs_info(c, MKFS_PROGRAM_TYPE);
 
 	if (crypto_init())
 		return -1;
-- 
2.13.6


