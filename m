Return-Path: <linux-kernel+bounces-205322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D850C8FFA99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34271B25086
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE49156F2C;
	Fri,  7 Jun 2024 04:27:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09015572E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734437; cv=none; b=KW+bOaIl4a+oh8yN+pp8OrRmDaTkr5vbaxfT+Llc6+mlD5E8TEhcN0GK8DZZwitodB3nv56z36IZrzXOe/mBlYeh/n8pnlHRPs6lm8YLOHaM4xXD8YGkvnyruzDzI5PczYZ8MG4+fhqSqpCK/Xkbs3Vb98OAqlLp1eKECc1Qqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734437; c=relaxed/simple;
	bh=dGQlLI1JrHcdJriG0eYniH6YbIeFLcVbIkLDu7LfYXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjW8ket0lity/lkS5i9pdbeBZYYi0v8VCgidNvJlyhJ5ju4EgUmGqjEtwQz5/XhxA/sFZyn93wW8hof2E2Uc5TRIVaN9cBuNPPub8eJLN5ugmMglj8euzltHbfzkuZqwtC9bC/LfS/0TtljaSVketOsa/dDpMoF6pyr3JVStWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkc3Cz8zPpnS;
	Fri,  7 Jun 2024 12:23:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B9618180085;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:02 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 048/110] ubifs-utils: Adapt key.h in libubifs
Date: Fri, 7 Jun 2024 12:25:13 +0800
Message-ID: <20240607042615.2069840-49-chengzhihao1@huawei.com>
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

Adapt key.h in libubifs, compared with linux kernel implementations:
 1. Add '__unused' modifier for unused parameters to avoid compiling
    warnings.
 2. Remove some functions(eg. lowest_dent_key, dent_key_init_flash)
    which won't be used in fsck/mkfs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/key.h | 109 ++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 80 deletions(-)

diff --git a/ubifs-utils/libubifs/key.h b/ubifs-utils/libubifs/key.h
index 8142d9d6..0a35c6bf 100644
--- a/ubifs-utils/libubifs/key.h
+++ b/ubifs-utils/libubifs/key.h
@@ -87,7 +87,7 @@ static inline uint32_t key_test_hash(const char *str, int len)
  * @key: key to initialize
  * @inum: inode number
  */
-static inline void ino_key_init(const struct ubifs_info *c,
+static inline void ino_key_init(__unused const struct ubifs_info *c,
 				union ubifs_key *key, ino_t inum)
 {
 	key->u32[0] = inum;
@@ -100,8 +100,8 @@ static inline void ino_key_init(const struct ubifs_info *c,
  * @k: key to initialize
  * @inum: inode number
  */
-static inline void ino_key_init_flash(const struct ubifs_info *c, void *k,
-				      ino_t inum)
+static inline void ino_key_init_flash(__unused const struct ubifs_info *c,
+				      void *k, ino_t inum)
 {
 	union ubifs_key *key = k;
 
@@ -116,8 +116,8 @@ static inline void ino_key_init_flash(const struct ubifs_info *c, void *k,
  * @key: key to initialize
  * @inum: inode number
  */
-static inline void lowest_ino_key(const struct ubifs_info *c,
-				union ubifs_key *key, ino_t inum)
+static inline void lowest_ino_key(__unused const struct ubifs_info *c,
+				  union ubifs_key *key, ino_t inum)
 {
 	key->u32[0] = inum;
 	key->u32[1] = 0;
@@ -129,8 +129,8 @@ static inline void lowest_ino_key(const struct ubifs_info *c,
  * @key: key to initialize
  * @inum: inode number
  */
-static inline void highest_ino_key(const struct ubifs_info *c,
-				union ubifs_key *key, ino_t inum)
+static inline void highest_ino_key(__unused const struct ubifs_info *c,
+				   union ubifs_key *key, ino_t inum)
 {
 	key->u32[0] = inum;
 	key->u32[1] = 0xffffffff;
@@ -172,40 +172,6 @@ static inline void dent_key_init_hash(const struct ubifs_info *c,
 }
 
 /**
- * dent_key_init_flash - initialize on-flash directory entry key.
- * @c: UBIFS file-system description object
- * @k: key to initialize
- * @inum: parent inode number
- * @nm: direntry name and length
- */
-static inline void dent_key_init_flash(const struct ubifs_info *c, void *k,
-				       ino_t inum,
-				       const struct fscrypt_name *nm)
-{
-	union ubifs_key *key = k;
-	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
-
-	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
-	key->j32[0] = cpu_to_le32(inum);
-	key->j32[1] = cpu_to_le32(hash |
-				  (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS));
-	memset(k + 8, 0, UBIFS_MAX_KEY_LEN - 8);
-}
-
-/**
- * lowest_dent_key - get the lowest possible directory entry key.
- * @c: UBIFS file-system description object
- * @key: where to store the lowest key
- * @inum: parent inode number
- */
-static inline void lowest_dent_key(const struct ubifs_info *c,
-				   union ubifs_key *key, ino_t inum)
-{
-	key->u32[0] = inum;
-	key->u32[1] = UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS;
-}
-
-/**
  * xent_key_init - initialize extended attribute entry key.
  * @c: UBIFS file-system description object
  * @key: key to initialize
@@ -224,32 +190,12 @@ static inline void xent_key_init(const struct ubifs_info *c,
 }
 
 /**
- * xent_key_init_flash - initialize on-flash extended attribute entry key.
- * @c: UBIFS file-system description object
- * @k: key to initialize
- * @inum: host inode number
- * @nm: extended attribute entry name and length
- */
-static inline void xent_key_init_flash(const struct ubifs_info *c, void *k,
-				       ino_t inum, const struct fscrypt_name *nm)
-{
-	union ubifs_key *key = k;
-	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
-
-	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
-	key->j32[0] = cpu_to_le32(inum);
-	key->j32[1] = cpu_to_le32(hash |
-				  (UBIFS_XENT_KEY << UBIFS_S_KEY_HASH_BITS));
-	memset(k + 8, 0, UBIFS_MAX_KEY_LEN - 8);
-}
-
-/**
  * lowest_xent_key - get the lowest possible extended attribute entry key.
  * @c: UBIFS file-system description object
  * @key: where to store the lowest key
  * @inum: host inode number
  */
-static inline void lowest_xent_key(const struct ubifs_info *c,
+static inline void lowest_xent_key(__unused const struct ubifs_info *c,
 				   union ubifs_key *key, ino_t inum)
 {
 	key->u32[0] = inum;
@@ -279,7 +225,7 @@ static inline void data_key_init(const struct ubifs_info *c,
  * @inum: inode number
  */
 static inline void highest_data_key(const struct ubifs_info *c,
-				   union ubifs_key *key, ino_t inum)
+				    union ubifs_key *key, ino_t inum)
 {
 	data_key_init(c, key, inum, UBIFS_S_KEY_BLOCK_MASK);
 }
@@ -293,7 +239,7 @@ static inline void highest_data_key(const struct ubifs_info *c,
  * Note, UBIFS does not have truncation keys on the media and this function is
  * only used for purposes of replay.
  */
-static inline void trun_key_init(const struct ubifs_info *c,
+static inline void trun_key_init(__unused const struct ubifs_info *c,
 				 union ubifs_key *key, ino_t inum)
 {
 	key->u32[0] = inum;
@@ -307,7 +253,7 @@ static inline void trun_key_init(const struct ubifs_info *c,
  *
  * This is a helper function which marks a @key object as invalid.
  */
-static inline void invalid_key_init(const struct ubifs_info *c,
+static inline void invalid_key_init(__unused const struct ubifs_info *c,
 				    union ubifs_key *key)
 {
 	key->u32[0] = 0xDEADBEAF;
@@ -319,7 +265,7 @@ static inline void invalid_key_init(const struct ubifs_info *c,
  * @c: UBIFS file-system description object
  * @key: key to get type of
  */
-static inline int key_type(const struct ubifs_info *c,
+static inline int key_type(__unused const struct ubifs_info *c,
 			   const union ubifs_key *key)
 {
 	return key->u32[1] >> UBIFS_S_KEY_BLOCK_BITS;
@@ -330,7 +276,8 @@ static inline int key_type(const struct ubifs_info *c,
  * @c: UBIFS file-system description object
  * @k: key to get type of
  */
-static inline int key_type_flash(const struct ubifs_info *c, const void *k)
+static inline int key_type_flash(__unused const struct ubifs_info *c,
+				 const void *k)
 {
 	const union ubifs_key *key = k;
 
@@ -342,7 +289,7 @@ static inline int key_type_flash(const struct ubifs_info *c, const void *k)
  * @c: UBIFS file-system description object
  * @k: key to fetch inode number from
  */
-static inline ino_t key_inum(const struct ubifs_info *c, const void *k)
+static inline ino_t key_inum(__unused const struct ubifs_info *c, const void *k)
 {
 	const union ubifs_key *key = k;
 
@@ -354,7 +301,8 @@ static inline ino_t key_inum(const struct ubifs_info *c, const void *k)
  * @c: UBIFS file-system description object
  * @k: key to fetch inode number from
  */
-static inline ino_t key_inum_flash(const struct ubifs_info *c, const void *k)
+static inline ino_t key_inum_flash(__unused const struct ubifs_info *c,
+				   const void *k)
 {
 	const union ubifs_key *key = k;
 
@@ -366,7 +314,7 @@ static inline ino_t key_inum_flash(const struct ubifs_info *c, const void *k)
  * @c: UBIFS file-system description object
  * @key: the key to get hash from
  */
-static inline uint32_t key_hash(const struct ubifs_info *c,
+static inline uint32_t key_hash(__unused const struct ubifs_info *c,
 				const union ubifs_key *key)
 {
 	return key->u32[1] & UBIFS_S_KEY_HASH_MASK;
@@ -377,7 +325,8 @@ static inline uint32_t key_hash(const struct ubifs_info *c,
  * @c: UBIFS file-system description object
  * @k: the key to get hash from
  */
-static inline uint32_t key_hash_flash(const struct ubifs_info *c, const void *k)
+static inline uint32_t key_hash_flash(__unused const struct ubifs_info *c,
+				      const void *k)
 {
 	const union ubifs_key *key = k;
 
@@ -389,7 +338,7 @@ static inline uint32_t key_hash_flash(const struct ubifs_info *c, const void *k)
  * @c: UBIFS file-system description object
  * @key: the key to get the block number from
  */
-static inline unsigned int key_block(const struct ubifs_info *c,
+static inline unsigned int key_block(__unused const struct ubifs_info *c,
 				     const union ubifs_key *key)
 {
 	return key->u32[1] & UBIFS_S_KEY_BLOCK_MASK;
@@ -400,7 +349,7 @@ static inline unsigned int key_block(const struct ubifs_info *c,
  * @c: UBIFS file-system description object
  * @k: the key to get the block number from
  */
-static inline unsigned int key_block_flash(const struct ubifs_info *c,
+static inline unsigned int key_block_flash(__unused const struct ubifs_info *c,
 					   const void *k)
 {
 	const union ubifs_key *key = k;
@@ -414,8 +363,8 @@ static inline unsigned int key_block_flash(const struct ubifs_info *c,
  * @from: the key to transform
  * @to: the key to store the result
  */
-static inline void key_read(const struct ubifs_info *c, const void *from,
-			    union ubifs_key *to)
+static inline void key_read(__unused const struct ubifs_info *c,
+			    const void *from, union ubifs_key *to)
 {
 	const union ubifs_key *f = from;
 
@@ -429,7 +378,7 @@ static inline void key_read(const struct ubifs_info *c, const void *from,
  * @from: the key to transform
  * @to: the key to store the result
  */
-static inline void key_write(const struct ubifs_info *c,
+static inline void key_write(__unused const struct ubifs_info *c,
 			     const union ubifs_key *from, void *to)
 {
 	union ubifs_key *t = to;
@@ -445,7 +394,7 @@ static inline void key_write(const struct ubifs_info *c,
  * @from: the key to transform
  * @to: the key to store the result
  */
-static inline void key_write_idx(const struct ubifs_info *c,
+static inline void key_write_idx(__unused const struct ubifs_info *c,
 				 const union ubifs_key *from, void *to)
 {
 	union ubifs_key *t = to;
@@ -460,7 +409,7 @@ static inline void key_write_idx(const struct ubifs_info *c,
  * @from: the key to copy from
  * @to: the key to copy to
  */
-static inline void key_copy(const struct ubifs_info *c,
+static inline void key_copy(__unused const struct ubifs_info *c,
 			    const union ubifs_key *from, union ubifs_key *to)
 {
 	to->u64[0] = from->u64[0];
@@ -475,7 +424,7 @@ static inline void key_copy(const struct ubifs_info *c,
  * This function compares 2 keys and returns %-1 if @key1 is less than
  * @key2, %0 if the keys are equivalent and %1 if @key1 is greater than @key2.
  */
-static inline int keys_cmp(const struct ubifs_info *c,
+static inline int keys_cmp(__unused const struct ubifs_info *c,
 			   const union ubifs_key *key1,
 			   const union ubifs_key *key2)
 {
@@ -500,7 +449,7 @@ static inline int keys_cmp(const struct ubifs_info *c,
  * This function compares 2 keys and returns %1 if @key1 is equal to @key2 and
  * %0 if not.
  */
-static inline int keys_eq(const struct ubifs_info *c,
+static inline int keys_eq(__unused const struct ubifs_info *c,
 			  const union ubifs_key *key1,
 			  const union ubifs_key *key2)
 {
-- 
2.13.6


