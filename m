Return-Path: <linux-kernel+bounces-332475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F997BA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5739281C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B1178CE8;
	Wed, 18 Sep 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CuqgpTzZ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C615C150
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652522; cv=none; b=ZvMDBVAxOC6/8IB57EpTxdEJ5s3acdcRtaKzzParAFrbWMslPu8lEU2ipZ+c8T9NMWyNOAmjXiW3eIU5hbhSEgx6x3q3mTeWIw4xNWXWqvBDnj7FhTiI8K39sB30J9HuT9IAYiCUhz/pFW1556ngXoF7++GiYGw7yYA8HmitUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652522; c=relaxed/simple;
	bh=o2s2bG1SZhgxcuh4iQVSHqpNoiT8wFAGfCKoKy9QDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J69u7QWvdHyQMzR20Pa0d1tgpTuVjgBpogEqTI/vPODQ+O47zvjxtjFQOuFtV7z8dZcZadNG0i4Q8gb6XQlZH9XCi/sfirokrUe3tFwYvqeyP/S9WbIgc/hgurI0Y7ASTW3sSUNcIbzRZ32kzzXqtKlZXsyHELgyrZ03J24c72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CuqgpTzZ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=zr///
	QynWF49C7UazH7BA3F6E/XqkNgjR8scwptDljA=; b=CuqgpTzZWvvWbphD0Cz6s
	iy/rUH0c7iZsC7WYY56P2qIHfNBzeAHYEz2cNkUF7hn0RPUEYjYVUj6Cq1m9M10u
	KfFJeLLISUyF97Q6vXlIlw86kFnSo/8Qkb/kUp6796wtt6mEC08f6lDYPGh4QHwi
	Zysb59scAwI41I3oUuL4ro=
Received: from localhost.localdomain (unknown [1.198.30.207])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLyAsn+pm2TCHAA--.46011S5;
	Wed, 18 Sep 2024 17:36:50 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] udf: refactor inode_bmap() to handle error
Date: Wed, 18 Sep 2024 17:36:34 +0800
Message-ID: <20240918093634.12906-4-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918093634.12906-1-zhaomzhao@126.com>
References: <20240918093634.12906-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLyAsn+pm2TCHAA--.46011S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFy3CrW8ZFy3ArW7ur43GFg_yoW3AFWkpr
	9rKFyjkw4rXrWxWF4IqF1kZw1Sga92kr47GryIv34SyrWvgr1rKa40yry29F15KFs5Cw4a
	qa15K3yUuw17J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpKZJUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiEBded2bqmPlnEwAAs3

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Same as udf_current_aext(), take pointer to etype to store the extent
type, while return 0 for success and <0 on error. On situations like
ftruncate, udf_extend_file() can detect errors and bail out early
without resorting to checking for particular offsets and
assuming internal behavior of these functions.

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 fs/udf/directory.c | 13 ++++++++-----
 fs/udf/inode.c     | 31 ++++++++++++++++++++-----------
 fs/udf/partition.c |  6 ++++--
 fs/udf/truncate.c  |  5 +++--
 fs/udf/udfdecl.h   |  5 +++--
 5 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index f865538c985d..cb40e1ade9f6 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -243,6 +243,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 {
 	struct udf_inode_info *iinfo = UDF_I(dir);
 	int err = 0;
+	int8_t etype;
 
 	iter->dir = dir;
 	iter->bh[0] = iter->bh[1] = NULL;
@@ -262,9 +263,9 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 		goto out;
 	}
 
-	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
-		       &iter->eloc, &iter->elen, &iter->loffset) !=
-	    (EXT_RECORDED_ALLOCATED >> 30)) {
+	err = inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos, &iter->eloc,
+		   &iter->elen, &iter->loffset, &etype);
+	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (pos == dir->i_size)
 			return 0;
 		udf_err(dir->i_sb,
@@ -460,6 +461,7 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
 	sector_t block;
 	uint32_t old_elen = iter->elen;
 	int err;
+	int8_t etype;
 
 	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
 		return -EINVAL;
@@ -474,8 +476,9 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
 		udf_fiiter_update_elen(iter, old_elen);
 		return err;
 	}
-	if (inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
-		       &iter->loffset) != (EXT_RECORDED_ALLOCATED >> 30)) {
+	err = inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
+		   &iter->loffset, &etype);
+	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		udf_err(iter->dir->i_sb,
 			"block %llu not allocated in directory (ino %lu)\n",
 			(unsigned long long)block, iter->dir->i_ino);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ba980ce5e13a..f1b8f0a0d202 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -418,10 +418,11 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 		uint32_t elen;
 		sector_t offset;
 		struct extent_position epos = {};
+		int8_t etype;
 
 		down_read(&iinfo->i_data_sem);
-		if (inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset)
-				== (EXT_RECORDED_ALLOCATED >> 30)) {
+		inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype);
+		if (etype == (EXT_RECORDED_ALLOCATED >> 30)) {
 			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
 							offset);
 			map->oflags |= UDF_BLK_MAPPED;
@@ -660,8 +661,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	 */
 	udf_discard_prealloc(inode);
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
-	within_last_ext = (etype != -1);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
+	if (err < 0 && err != -ENODATA)
+		goto out;
+	within_last_ext = (!err);
 	/* We don't expect extents past EOF... */
 	WARN_ON_ONCE(within_last_ext &&
 		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
@@ -2363,14 +2366,19 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 	return (elen >> 30);
 }
 
-int8_t inode_bmap(struct inode *inode, sector_t block,
-		  struct extent_position *pos, struct kernel_lb_addr *eloc,
-		  uint32_t *elen, sector_t *offset)
+/*
+ * return 0 when iudf_next_aext() loop success.
+ * return err < 0 and err != -ENODATA indicates error.
+ * return err == -ENODATA indicates hit EOF.
+ */
+int inode_bmap(struct inode *inode, sector_t block, struct extent_position *pos,
+	       struct kernel_lb_addr *eloc, uint32_t *elen, sector_t *offset,
+	       int8_t *etype)
 {
 	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
-	int8_t etype;
 	struct udf_inode_info *iinfo;
+	int err = 0;
 
 	iinfo = UDF_I(inode);
 	if (!udf_read_extent_cache(inode, bcount, &lbcount, pos)) {
@@ -2380,10 +2388,11 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		if (udf_next_aext(inode, pos, eloc, elen, &etype, 1)) {
+		err = udf_next_aext(inode, pos, eloc, elen, etype, 1);
+		if (err < 0) {
 			*offset = (bcount - lbcount) >> blocksize_bits;
 			iinfo->i_lenExtents = lbcount;
-			return -1;
+			return err;
 		}
 		lbcount += *elen;
 	} while (lbcount <= bcount);
@@ -2391,5 +2400,5 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	udf_update_extent_cache(inode, lbcount - *elen, pos);
 	*offset = (bcount + *elen - lbcount) >> blocksize_bits;
 
-	return etype;
+	return 0;
 }
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index af877991edc1..c441d4ae1f96 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -282,9 +282,11 @@ static uint32_t udf_try_read_meta(struct inode *inode, uint32_t block,
 	sector_t ext_offset;
 	struct extent_position epos = {};
 	uint32_t phyblock;
+	int8_t etype;
+	int err = 0;
 
-	if (inode_bmap(inode, block, &epos, &eloc, &elen, &ext_offset) !=
-						(EXT_RECORDED_ALLOCATED >> 30))
+	err = inode_bmap(inode, block, &epos, &eloc, &elen, &ext_offset, &etype);
+	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30))
 		phyblock = 0xFFFFFFFF;
 	else {
 		map = &UDF_SB(sb)->s_partmaps[partition];
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index b7361222f988..a70b6ae4ab8a 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -188,6 +188,7 @@ int udf_truncate_extents(struct inode *inode)
 	loff_t byte_offset;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -196,10 +197,10 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		BUG();
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
 	byte_offset = (offset << sb->s_blocksize_bits) +
 		(inode->i_size & (sb->s_blocksize - 1));
-	if (etype == -1) {
+	if (err < 0) {
 		/* We should extend the file? */
 		WARN_ON(byte_offset);
 		return 0;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 5067ed68a8b4..d159f20d61e8 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -157,8 +157,9 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 extern int udf_setsize(struct inode *, loff_t);
 extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
-extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
-			 struct kernel_lb_addr *, uint32_t *, sector_t *);
+extern int inode_bmap(struct inode *inode, sector_t block,
+		      struct extent_position *pos, struct kernel_lb_addr *eloc,
+		      uint32_t *elen, sector_t *offset, int8_t *etype);
 int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 				   struct extent_position *epos);
-- 
2.43.0


