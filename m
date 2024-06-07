Return-Path: <linux-kernel+bounces-205319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86F8FFA9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB7228B070
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480A156F3D;
	Fri,  7 Jun 2024 04:27:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD936155725
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734437; cv=none; b=b9AJVH07G9wjN6kEqbMYJBr+/sSwyuWObtqEnlnCsvvZxBrXC1+YWDUn1yhSGEy3g9u4OUGGBNYwxKBmxndycXqVjOXUiKOEQwHzQv5sJaZZ+9nOfIHKHn8ikzc5AjpfaFHcrV0oUCLaY+I1j2PSjua8Vfli6mSH8G9fIyMXCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734437; c=relaxed/simple;
	bh=0ekW811BJTAdhH3L6Rh9dqVnWqig5l1/Fqnxj0JnUzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ2On0zNew1ZsahS/pGeFlxOO/rV/aRnE4DtCXV7+I18vFcI+L1qDEcbLJy8xP0BOEkBkNohlk0m7QrmSMFncEEYaZTs1LDCJe+gCSUt8niF/F91y4HF0JT7zmWWxVnQwZ/2AYy3q5TH5rT/c8atIda6lKOVnd33p6343RZdCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSj7191czmYSJ;
	Fri,  7 Jun 2024 12:22:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id EF14A180085;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:54 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 038/110] ubifs-utils: Adapt tnc subsystem in libubifs
Date: Fri, 7 Jun 2024 12:25:03 +0800
Message-ID: <20240607042615.2069840-39-chengzhihao1@huawei.com>
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

Adapt tnc subsystem(tnc.c,tnc_misc.c,tnc_commit.c) in libubifs, compared
with linux kernel implementations:
 1. Remove debug related functions(eg. dbg_check_inode_size), debug
    functions are not needed by fsck, because fsck will check fs in
    another way.
 2. Remove some functions(eg. ubifs_tnc_bulk_read) which won't be used
    in fsck/mkfs.
 3. Adapt tnc_delete and ubifs_search_zbranch to handle empty TNC case,
    which could happen in fsck.
 4. Don't skip checking the length of non-leaf index node's branch in
    read_znode.
 5. Adapt try_read_node to ignore %-EBADMSG, subsequent steps will check
    nodes carefully.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/tnc.c        | 590 +-------------------------------------
 ubifs-utils/libubifs/tnc_commit.c |  18 +-
 ubifs-utils/libubifs/tnc_misc.c   | 108 ++-----
 3 files changed, 43 insertions(+), 673 deletions(-)

diff --git a/ubifs-utils/libubifs/tnc.c b/ubifs-utils/libubifs/tnc.c
index 0fabecd9..12c56e0a 100644
--- a/ubifs-utils/libubifs/tnc.c
+++ b/ubifs-utils/libubifs/tnc.c
@@ -18,9 +18,15 @@
  * the mutex locked.
  */
 
-#include <linux/crc32.h>
-#include <linux/slab.h>
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
+#include "crc32.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 static int try_read_node(const struct ubifs_info *c, void *buf, int type,
 			 struct ubifs_zbranch *zbr);
@@ -488,7 +494,7 @@ static int try_read_node(const struct ubifs_info *c, void *buf, int type,
 	dbg_io("LEB %d:%d, %s, length %d", lnum, offs, dbg_ntype(type), len);
 
 	err = ubifs_leb_read(c, lnum, buf, offs, len, 1);
-	if (err) {
+	if (err && err != -EBADMSG) {
 		ubifs_err(c, "cannot read node type %d from LEB %d:%d, error %d",
 			  type, lnum, offs, err);
 		return err;
@@ -929,7 +935,7 @@ static int fallible_resolve_collision(struct ubifs_info *c,
 				      int adding)
 {
 	struct ubifs_znode *o_znode = NULL, *znode = *zn;
-	int o_n, err, cmp, unsure = 0, nn = *n;
+	int err, cmp, o_n = 0, unsure = 0, nn = *n;
 
 	cmp = fallible_matches_name(c, &znode->zbranch[nn], nm);
 	if (unlikely(cmp < 0))
@@ -1427,42 +1433,6 @@ static int lookup_level0_dirty(struct ubifs_info *c, const union ubifs_key *key,
 }
 
 /**
- * maybe_leb_gced - determine if a LEB may have been garbage collected.
- * @c: UBIFS file-system description object
- * @lnum: LEB number
- * @gc_seq1: garbage collection sequence number
- *
- * This function determines if @lnum may have been garbage collected since
- * sequence number @gc_seq1. If it may have been then %1 is returned, otherwise
- * %0 is returned.
- */
-static int maybe_leb_gced(struct ubifs_info *c, int lnum, int gc_seq1)
-{
-	int gc_seq2, gced_lnum;
-
-	gced_lnum = c->gced_lnum;
-	smp_rmb();
-	gc_seq2 = c->gc_seq;
-	/* Same seq means no GC */
-	if (gc_seq1 == gc_seq2)
-		return 0;
-	/* Different by more than 1 means we don't know */
-	if (gc_seq1 + 1 != gc_seq2)
-		return 1;
-	/*
-	 * We have seen the sequence number has increased by 1. Now we need to
-	 * be sure we read the right LEB number, so read it again.
-	 */
-	smp_rmb();
-	if (gced_lnum != c->gced_lnum)
-		return 1;
-	/* Finally we can check lnum */
-	if (gced_lnum == lnum)
-		return 1;
-	return 0;
-}
-
-/**
  * ubifs_tnc_locate - look up a file-system node and return it and its location.
  * @c: UBIFS file-system description object
  * @key: node key to lookup
@@ -1512,300 +1482,6 @@ out:
 }
 
 /**
- * ubifs_tnc_get_bu_keys - lookup keys for bulk-read.
- * @c: UBIFS file-system description object
- * @bu: bulk-read parameters and results
- *
- * Lookup consecutive data node keys for the same inode that reside
- * consecutively in the same LEB. This function returns zero in case of success
- * and a negative error code in case of failure.
- *
- * Note, if the bulk-read buffer length (@bu->buf_len) is known, this function
- * makes sure bulk-read nodes fit the buffer. Otherwise, this function prepares
- * maximum possible amount of nodes for bulk-read.
- */
-int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu)
-{
-	int n, err = 0, lnum = -1, offs;
-	int len;
-	unsigned int block = key_block(c, &bu->key);
-	struct ubifs_znode *znode;
-
-	bu->cnt = 0;
-	bu->blk_cnt = 0;
-	bu->eof = 0;
-
-	mutex_lock(&c->tnc_mutex);
-	/* Find first key */
-	err = ubifs_lookup_level0(c, &bu->key, &znode, &n);
-	if (err < 0)
-		goto out;
-	if (err) {
-		/* Key found */
-		len = znode->zbranch[n].len;
-		/* The buffer must be big enough for at least 1 node */
-		if (len > bu->buf_len) {
-			err = -EINVAL;
-			goto out;
-		}
-		/* Add this key */
-		bu->zbranch[bu->cnt++] = znode->zbranch[n];
-		bu->blk_cnt += 1;
-		lnum = znode->zbranch[n].lnum;
-		offs = ALIGN(znode->zbranch[n].offs + len, 8);
-	}
-	while (1) {
-		struct ubifs_zbranch *zbr;
-		union ubifs_key *key;
-		unsigned int next_block;
-
-		/* Find next key */
-		err = tnc_next(c, &znode, &n);
-		if (err)
-			goto out;
-		zbr = &znode->zbranch[n];
-		key = &zbr->key;
-		/* See if there is another data key for this file */
-		if (key_inum(c, key) != key_inum(c, &bu->key) ||
-		    key_type(c, key) != UBIFS_DATA_KEY) {
-			err = -ENOENT;
-			goto out;
-		}
-		if (lnum < 0) {
-			/* First key found */
-			lnum = zbr->lnum;
-			offs = ALIGN(zbr->offs + zbr->len, 8);
-			len = zbr->len;
-			if (len > bu->buf_len) {
-				err = -EINVAL;
-				goto out;
-			}
-		} else {
-			/*
-			 * The data nodes must be in consecutive positions in
-			 * the same LEB.
-			 */
-			if (zbr->lnum != lnum || zbr->offs != offs)
-				goto out;
-			offs += ALIGN(zbr->len, 8);
-			len = ALIGN(len, 8) + zbr->len;
-			/* Must not exceed buffer length */
-			if (len > bu->buf_len)
-				goto out;
-		}
-		/* Allow for holes */
-		next_block = key_block(c, key);
-		bu->blk_cnt += (next_block - block - 1);
-		if (bu->blk_cnt >= UBIFS_MAX_BULK_READ)
-			goto out;
-		block = next_block;
-		/* Add this key */
-		bu->zbranch[bu->cnt++] = *zbr;
-		bu->blk_cnt += 1;
-		/* See if we have room for more */
-		if (bu->cnt >= UBIFS_MAX_BULK_READ)
-			goto out;
-		if (bu->blk_cnt >= UBIFS_MAX_BULK_READ)
-			goto out;
-	}
-out:
-	if (err == -ENOENT) {
-		bu->eof = 1;
-		err = 0;
-	}
-	bu->gc_seq = c->gc_seq;
-	mutex_unlock(&c->tnc_mutex);
-	if (err)
-		return err;
-	/*
-	 * An enormous hole could cause bulk-read to encompass too many
-	 * page cache pages, so limit the number here.
-	 */
-	if (bu->blk_cnt > UBIFS_MAX_BULK_READ)
-		bu->blk_cnt = UBIFS_MAX_BULK_READ;
-	/*
-	 * Ensure that bulk-read covers a whole number of page cache
-	 * pages.
-	 */
-	if (UBIFS_BLOCKS_PER_PAGE == 1 ||
-	    !(bu->blk_cnt & (UBIFS_BLOCKS_PER_PAGE - 1)))
-		return 0;
-	if (bu->eof) {
-		/* At the end of file we can round up */
-		bu->blk_cnt += UBIFS_BLOCKS_PER_PAGE - 1;
-		return 0;
-	}
-	/* Exclude data nodes that do not make up a whole page cache page */
-	block = key_block(c, &bu->key) + bu->blk_cnt;
-	block &= ~(UBIFS_BLOCKS_PER_PAGE - 1);
-	while (bu->cnt) {
-		if (key_block(c, &bu->zbranch[bu->cnt - 1].key) < block)
-			break;
-		bu->cnt -= 1;
-	}
-	return 0;
-}
-
-/**
- * read_wbuf - bulk-read from a LEB with a wbuf.
- * @wbuf: wbuf that may overlap the read
- * @buf: buffer into which to read
- * @len: read length
- * @lnum: LEB number from which to read
- * @offs: offset from which to read
- *
- * This functions returns %0 on success or a negative error code on failure.
- */
-static int read_wbuf(struct ubifs_wbuf *wbuf, void *buf, int len, int lnum,
-		     int offs)
-{
-	const struct ubifs_info *c = wbuf->c;
-	int rlen, overlap;
-
-	dbg_io("LEB %d:%d, length %d", lnum, offs, len);
-	ubifs_assert(c, wbuf && lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(c, !(offs & 7) && offs < c->leb_size);
-	ubifs_assert(c, offs + len <= c->leb_size);
-
-	spin_lock(&wbuf->lock);
-	overlap = (lnum == wbuf->lnum && offs + len > wbuf->offs);
-	if (!overlap) {
-		/* We may safely unlock the write-buffer and read the data */
-		spin_unlock(&wbuf->lock);
-		return ubifs_leb_read(c, lnum, buf, offs, len, 0);
-	}
-
-	/* Don't read under wbuf */
-	rlen = wbuf->offs - offs;
-	if (rlen < 0)
-		rlen = 0;
-
-	/* Copy the rest from the write-buffer */
-	memcpy(buf + rlen, wbuf->buf + offs + rlen - wbuf->offs, len - rlen);
-	spin_unlock(&wbuf->lock);
-
-	if (rlen > 0)
-		/* Read everything that goes before write-buffer */
-		return ubifs_leb_read(c, lnum, buf, offs, rlen, 0);
-
-	return 0;
-}
-
-/**
- * validate_data_node - validate data nodes for bulk-read.
- * @c: UBIFS file-system description object
- * @buf: buffer containing data node to validate
- * @zbr: zbranch of data node to validate
- *
- * This functions returns %0 on success or a negative error code on failure.
- */
-static int validate_data_node(struct ubifs_info *c, void *buf,
-			      struct ubifs_zbranch *zbr)
-{
-	union ubifs_key key1;
-	struct ubifs_ch *ch = buf;
-	int err, len;
-
-	if (ch->node_type != UBIFS_DATA_NODE) {
-		ubifs_err(c, "bad node type (%d but expected %d)",
-			  ch->node_type, UBIFS_DATA_NODE);
-		goto out_err;
-	}
-
-	err = ubifs_check_node(c, buf, zbr->len, zbr->lnum, zbr->offs, 0, 0);
-	if (err) {
-		ubifs_err(c, "expected node type %d", UBIFS_DATA_NODE);
-		goto out;
-	}
-
-	err = ubifs_node_check_hash(c, buf, zbr->hash);
-	if (err) {
-		ubifs_bad_hash(c, buf, zbr->hash, zbr->lnum, zbr->offs);
-		return err;
-	}
-
-	len = le32_to_cpu(ch->len);
-	if (len != zbr->len) {
-		ubifs_err(c, "bad node length %d, expected %d", len, zbr->len);
-		goto out_err;
-	}
-
-	/* Make sure the key of the read node is correct */
-	key_read(c, buf + UBIFS_KEY_OFFSET, &key1);
-	if (!keys_eq(c, &zbr->key, &key1)) {
-		ubifs_err(c, "bad key in node at LEB %d:%d",
-			  zbr->lnum, zbr->offs);
-		dbg_tnck(&zbr->key, "looked for key ");
-		dbg_tnck(&key1, "found node's key ");
-		goto out_err;
-	}
-
-	return 0;
-
-out_err:
-	err = -EINVAL;
-out:
-	ubifs_err(c, "bad node at LEB %d:%d", zbr->lnum, zbr->offs);
-	ubifs_dump_node(c, buf, zbr->len);
-	dump_stack();
-	return err;
-}
-
-/**
- * ubifs_tnc_bulk_read - read a number of data nodes in one go.
- * @c: UBIFS file-system description object
- * @bu: bulk-read parameters and results
- *
- * This functions reads and validates the data nodes that were identified by the
- * 'ubifs_tnc_get_bu_keys()' function. This functions returns %0 on success,
- * -EAGAIN to indicate a race with GC, or another negative error code on
- * failure.
- */
-int ubifs_tnc_bulk_read(struct ubifs_info *c, struct bu_info *bu)
-{
-	int lnum = bu->zbranch[0].lnum, offs = bu->zbranch[0].offs, len, err, i;
-	struct ubifs_wbuf *wbuf;
-	void *buf;
-
-	len = bu->zbranch[bu->cnt - 1].offs;
-	len += bu->zbranch[bu->cnt - 1].len - offs;
-	if (len > bu->buf_len) {
-		ubifs_err(c, "buffer too small %d vs %d", bu->buf_len, len);
-		return -EINVAL;
-	}
-
-	/* Do the read */
-	wbuf = ubifs_get_wbuf(c, lnum);
-	if (wbuf)
-		err = read_wbuf(wbuf, bu->buf, len, lnum, offs);
-	else
-		err = ubifs_leb_read(c, lnum, bu->buf, offs, len, 0);
-
-	/* Check for a race with GC */
-	if (maybe_leb_gced(c, lnum, bu->gc_seq))
-		return -EAGAIN;
-
-	if (err && err != -EBADMSG) {
-		ubifs_err(c, "failed to read from LEB %d:%d, error %d",
-			  lnum, offs, err);
-		dump_stack();
-		dbg_tnck(&bu->key, "key ");
-		return err;
-	}
-
-	/* Validate the nodes read */
-	buf = bu->buf;
-	for (i = 0; i < bu->cnt; i++) {
-		err = validate_data_node(c, buf, &bu->zbranch[i]);
-		if (err)
-			return err;
-		buf = buf + ALIGN(bu->zbranch[i].len, 8);
-	}
-
-	return 0;
-}
-
-/**
  * do_lookup_nm- look up a "hashed" node.
  * @c: UBIFS file-system description object
  * @key: node key to lookup
@@ -1892,110 +1568,6 @@ int ubifs_tnc_lookup_nm(struct ubifs_info *c, const union ubifs_key *key,
 	return do_lookup_nm(c, key, node, nm);
 }
 
-static int search_dh_cookie(struct ubifs_info *c, const union ubifs_key *key,
-			    struct ubifs_dent_node *dent, uint32_t cookie,
-			    struct ubifs_znode **zn, int *n, int exact)
-{
-	int err;
-	struct ubifs_znode *znode = *zn;
-	struct ubifs_zbranch *zbr;
-	union ubifs_key *dkey;
-
-	if (!exact) {
-		err = tnc_next(c, &znode, n);
-		if (err)
-			return err;
-	}
-
-	for (;;) {
-		zbr = &znode->zbranch[*n];
-		dkey = &zbr->key;
-
-		if (key_inum(c, dkey) != key_inum(c, key) ||
-		    key_type(c, dkey) != key_type(c, key)) {
-			return -ENOENT;
-		}
-
-		err = tnc_read_hashed_node(c, zbr, dent);
-		if (err)
-			return err;
-
-		if (key_hash(c, key) == key_hash(c, dkey) &&
-		    le32_to_cpu(dent->cookie) == cookie) {
-			*zn = znode;
-			return 0;
-		}
-
-		err = tnc_next(c, &znode, n);
-		if (err)
-			return err;
-	}
-}
-
-static int do_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
-			struct ubifs_dent_node *dent, uint32_t cookie)
-{
-	int n, err;
-	struct ubifs_znode *znode;
-	union ubifs_key start_key;
-
-	ubifs_assert(c, is_hash_key(c, key));
-
-	lowest_dent_key(c, &start_key, key_inum(c, key));
-
-	mutex_lock(&c->tnc_mutex);
-	err = ubifs_lookup_level0(c, &start_key, &znode, &n);
-	if (unlikely(err < 0))
-		goto out_unlock;
-
-	err = search_dh_cookie(c, key, dent, cookie, &znode, &n, err);
-
-out_unlock:
-	mutex_unlock(&c->tnc_mutex);
-	return err;
-}
-
-/**
- * ubifs_tnc_lookup_dh - look up a "double hashed" node.
- * @c: UBIFS file-system description object
- * @key: node key to lookup
- * @node: the node is returned here
- * @cookie: node cookie for collision resolution
- *
- * This function looks up and reads a node which contains name hash in the key.
- * Since the hash may have collisions, there may be many nodes with the same
- * key, so we have to sequentially look to all of them until the needed one
- * with the same cookie value is found.
- * This function returns zero in case of success, %-ENOENT if the node
- * was not found, and a negative error code in case of failure.
- */
-int ubifs_tnc_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
-			void *node, uint32_t cookie)
-{
-	int err;
-	const struct ubifs_dent_node *dent = node;
-
-	if (!c->double_hash)
-		return -EOPNOTSUPP;
-
-	/*
-	 * We assume that in most of the cases there are no name collisions and
-	 * 'ubifs_tnc_lookup()' returns us the right direntry.
-	 */
-	err = ubifs_tnc_lookup(c, key, node);
-	if (err)
-		return err;
-
-	if (le32_to_cpu(dent->cookie) == cookie)
-		return 0;
-
-	/*
-	 * Unluckily, there are hash collisions and we have to iterate over
-	 * them look at each direntry with colliding name hash sequentially.
-	 */
-	return do_lookup_dh(c, key, node, cookie);
-}
-
 /**
  * correct_parent_keys - correct parent znodes' keys.
  * @c: UBIFS file-system description object
@@ -2540,6 +2112,10 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 	if (znode->child_cnt > 0)
 		return 0;
 
+	/* Different with linux kernel, TNC could become empty. */
+	if (!znode->parent)
+		return 0;
+
 	/*
 	 * This was the last zbranch, we have to delete this znode from the
 	 * parent.
@@ -2697,74 +2273,6 @@ out_unlock:
 }
 
 /**
- * ubifs_tnc_remove_dh - remove an index entry for a "double hashed" node.
- * @c: UBIFS file-system description object
- * @key: key of node
- * @cookie: node cookie for collision resolution
- *
- * Returns %0 on success or negative error code on failure.
- */
-int ubifs_tnc_remove_dh(struct ubifs_info *c, const union ubifs_key *key,
-			uint32_t cookie)
-{
-	int n, err;
-	struct ubifs_znode *znode;
-	struct ubifs_dent_node *dent;
-	struct ubifs_zbranch *zbr;
-
-	if (!c->double_hash)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&c->tnc_mutex);
-	err = lookup_level0_dirty(c, key, &znode, &n);
-	if (err <= 0)
-		goto out_unlock;
-
-	zbr = &znode->zbranch[n];
-	dent = kmalloc(UBIFS_MAX_DENT_NODE_SZ, GFP_NOFS);
-	if (!dent) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
-
-	err = tnc_read_hashed_node(c, zbr, dent);
-	if (err)
-		goto out_free;
-
-	/* If the cookie does not match, we're facing a hash collision. */
-	if (le32_to_cpu(dent->cookie) != cookie) {
-		union ubifs_key start_key;
-
-		lowest_dent_key(c, &start_key, key_inum(c, key));
-
-		err = ubifs_lookup_level0(c, &start_key, &znode, &n);
-		if (unlikely(err < 0))
-			goto out_free;
-
-		err = search_dh_cookie(c, key, dent, cookie, &znode, &n, err);
-		if (err)
-			goto out_free;
-	}
-
-	if (znode->cnext || !ubifs_zn_dirty(znode)) {
-		znode = dirty_cow_bottom_up(c, znode);
-		if (IS_ERR(znode)) {
-			err = PTR_ERR(znode);
-			goto out_free;
-		}
-	}
-	err = tnc_delete(c, znode, n);
-
-out_free:
-	kfree(dent);
-out_unlock:
-	if (!err)
-		err = dbg_check_tnc(c, 0);
-	mutex_unlock(&c->tnc_mutex);
-	return err;
-}
-
-/**
  * key_in_range - determine if a key falls within a range of keys.
  * @c: UBIFS file-system description object
  * @key: key to check
@@ -2905,9 +2413,7 @@ int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum)
 		dbg_tnc("xent '%s', ino %lu", xent->name,
 			(unsigned long)xattr_inum);
 
-		ubifs_evict_xattr_inode(c, xattr_inum);
-
-		fname_name(&nm) = xent->name;
+		fname_name(&nm) = (const char *)xent->name;
 		fname_len(&nm) = le16_to_cpu(xent->nlen);
 		err = ubifs_tnc_remove_nm(c, &key1, &nm);
 		if (err) {
@@ -3485,69 +2991,3 @@ out_unlock:
 	mutex_unlock(&c->tnc_mutex);
 	return err;
 }
-
-/**
- * dbg_check_inode_size - check if inode size is correct.
- * @c: UBIFS file-system description object
- * @inode: inode to check
- * @size: inode size
- *
- * This function makes sure that the inode size (@size) is correct and it does
- * not have any pages beyond @size. Returns zero if the inode is OK, %-EINVAL
- * if it has a data page beyond @size, and other negative error code in case of
- * other errors.
- */
-int dbg_check_inode_size(struct ubifs_info *c, const struct inode *inode,
-			 loff_t size)
-{
-	int err, n;
-	union ubifs_key from_key, to_key, *key;
-	struct ubifs_znode *znode;
-	unsigned int block;
-
-	if (!S_ISREG(inode->i_mode))
-		return 0;
-	if (!dbg_is_chk_gen(c))
-		return 0;
-
-	block = (size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT;
-	data_key_init(c, &from_key, inode->i_ino, block);
-	highest_data_key(c, &to_key, inode->i_ino);
-
-	mutex_lock(&c->tnc_mutex);
-	err = ubifs_lookup_level0(c, &from_key, &znode, &n);
-	if (err < 0)
-		goto out_unlock;
-
-	if (err) {
-		key = &from_key;
-		goto out_dump;
-	}
-
-	err = tnc_next(c, &znode, &n);
-	if (err == -ENOENT) {
-		err = 0;
-		goto out_unlock;
-	}
-	if (err < 0)
-		goto out_unlock;
-
-	ubifs_assert(c, err == 0);
-	key = &znode->zbranch[n].key;
-	if (!key_in_range(c, key, &from_key, &to_key))
-		goto out_unlock;
-
-out_dump:
-	block = key_block(c, key);
-	ubifs_err(c, "inode %lu has size %lld, but there are data at offset %lld",
-		  (unsigned long)inode->i_ino, size,
-		  ((loff_t)block) << UBIFS_BLOCK_SHIFT);
-	mutex_unlock(&c->tnc_mutex);
-	ubifs_dump_inode(c, inode);
-	dump_stack();
-	return -EINVAL;
-
-out_unlock:
-	mutex_unlock(&c->tnc_mutex);
-	return err;
-}
diff --git a/ubifs-utils/libubifs/tnc_commit.c b/ubifs-utils/libubifs/tnc_commit.c
index a55e0482..d797006e 100644
--- a/ubifs-utils/libubifs/tnc_commit.c
+++ b/ubifs-utils/libubifs/tnc_commit.c
@@ -10,8 +10,14 @@
 
 /* This file implements TNC functions for committing */
 
-#include <linux/random.h>
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 /**
  * make_idx_node - make an index node for fill-the-gaps method of TNC commit.
@@ -546,8 +552,8 @@ static int layout_in_empty_space(struct ubifs_info *c)
 		break;
 	}
 
-	c->dbg->new_ihead_lnum = lnum;
-	c->dbg->new_ihead_offs = buf_offs;
+	c->new_ihead_lnum = lnum;
+	c->new_ihead_offs = buf_offs;
 
 	return 0;
 }
@@ -700,7 +706,7 @@ static int alloc_idx_lebs(struct ubifs_info *c, int cnt)
 		c->ilebs[c->ileb_cnt++] = lnum;
 		dbg_cmt("LEB %d", lnum);
 	}
-	if (dbg_is_chk_index(c) && !get_random_u32_below(8))
+	if (dbg_is_chk_index(c))
 		return -ENOSPC;
 	return 0;
 }
@@ -1011,8 +1017,8 @@ static int write_index(struct ubifs_info *c)
 		break;
 	}
 
-	if (lnum != c->dbg->new_ihead_lnum ||
-	    buf_offs != c->dbg->new_ihead_offs) {
+	if (lnum != c->new_ihead_lnum ||
+	    buf_offs != c->new_ihead_offs) {
 		ubifs_err(c, "inconsistent ihead");
 		return -EINVAL;
 	}
diff --git a/ubifs-utils/libubifs/tnc_misc.c b/ubifs-utils/libubifs/tnc_misc.c
index d3f8a6aa..8c38f153 100644
--- a/ubifs-utils/libubifs/tnc_misc.c
+++ b/ubifs-utils/libubifs/tnc_misc.c
@@ -15,97 +15,14 @@
  * putting it all in one file would make that file too big and unreadable.
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
-
-/**
- * ubifs_tnc_levelorder_next - next TNC tree element in levelorder traversal.
- * @c: UBIFS file-system description object
- * @zr: root of the subtree to traverse
- * @znode: previous znode
- *
- * This function implements levelorder TNC traversal. The LNC is ignored.
- * Returns the next element or %NULL if @znode is already the last one.
- */
-struct ubifs_znode *ubifs_tnc_levelorder_next(const struct ubifs_info *c,
-					      struct ubifs_znode *zr,
-					      struct ubifs_znode *znode)
-{
-	int level, iip, level_search = 0;
-	struct ubifs_znode *zn;
-
-	ubifs_assert(c, zr);
-
-	if (unlikely(!znode))
-		return zr;
-
-	if (unlikely(znode == zr)) {
-		if (znode->level == 0)
-			return NULL;
-		return ubifs_tnc_find_child(zr, 0);
-	}
-
-	level = znode->level;
-
-	iip = znode->iip;
-	while (1) {
-		ubifs_assert(c, znode->level <= zr->level);
-
-		/*
-		 * First walk up until there is a znode with next branch to
-		 * look at.
-		 */
-		while (znode->parent != zr && iip >= znode->parent->child_cnt) {
-			znode = znode->parent;
-			iip = znode->iip;
-		}
-
-		if (unlikely(znode->parent == zr &&
-			     iip >= znode->parent->child_cnt)) {
-			/* This level is done, switch to the lower one */
-			level -= 1;
-			if (level_search || level < 0)
-				/*
-				 * We were already looking for znode at lower
-				 * level ('level_search'). As we are here
-				 * again, it just does not exist. Or all levels
-				 * were finished ('level < 0').
-				 */
-				return NULL;
-
-			level_search = 1;
-			iip = -1;
-			znode = ubifs_tnc_find_child(zr, 0);
-			ubifs_assert(c, znode);
-		}
-
-		/* Switch to the next index */
-		zn = ubifs_tnc_find_child(znode->parent, iip + 1);
-		if (!zn) {
-			/* No more children to look at, we have walk up */
-			iip = znode->parent->child_cnt;
-			continue;
-		}
-
-		/* Walk back down to the level we came from ('level') */
-		while (zn->level != level) {
-			znode = zn;
-			zn = ubifs_tnc_find_child(zn, 0);
-			if (!zn) {
-				/*
-				 * This path is not too deep so it does not
-				 * reach 'level'. Try next path.
-				 */
-				iip = znode->iip;
-				break;
-			}
-		}
-
-		if (zn) {
-			ubifs_assert(c, zn->level >= 0);
-			return zn;
-		}
-	}
-}
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 /**
  * ubifs_search_zbranch - search znode branch.
@@ -130,6 +47,12 @@ int ubifs_search_zbranch(const struct ubifs_info *c,
 	int cmp;
 	const struct ubifs_zbranch *zbr = &znode->zbranch[0];
 
+	if (!end) {
+		/* Different with linux kernel, TNC could become empty. */
+		*n = -1;
+		return 0;
+	}
+
 	ubifs_assert(c, end > beg);
 
 	while (end > beg) {
@@ -360,9 +283,10 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 		}
 
 		if (znode->level)
-			continue;
+			type = UBIFS_IDX_NODE;
+		else
+			type = key_type(c, &zbr->key);
 
-		type = key_type(c, &zbr->key);
 		if (c->ranges[type].max_len == 0) {
 			if (zbr->len != c->ranges[type].len) {
 				ubifs_err(c, "bad target node (type %d) length (%d)",
-- 
2.13.6


