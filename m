Return-Path: <linux-kernel+bounces-340427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F7987343
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FBA2848B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883217C9A9;
	Thu, 26 Sep 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="O4icN9kS"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03314F9FD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352502; cv=none; b=Z2BrQJc3joJCTbndCM3JmEdrCg+tX+mdBg4TlAKTR+5PHRxD7s77UOtE03Cw7HnW9c8Q8b49Xg8tHwF2AlD1d+2QwWgHVAY5CuWklviaZke54bMd2SbqNjqs/Is3aSaCzfNIkPVv/S/mMXdSYiCgHcdbxQTKUGnRf3AqJYIw/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352502; c=relaxed/simple;
	bh=90LRmv33v7TFDcoqTqqk0m5qenGojYQWD4buTFXUGTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q58t8fuTp8trnv7yLcqJ+QRW28dNqBkPRyfBfSBmkl7G1XUrlGFBFZC1dJJCm2aSA7iD5PiYuJRWgUMYRfsdJN7O9nxQE/fPGwr9Aa0A0behGNNGMOU0o9L/tQa5so6ebW2xnd54JFAV1/8ltsdIRUPAgeZj3fVN9E+eLVsGp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=O4icN9kS; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=COwbb
	HNK6umIK0MrnLDcZHu2dGbVjHVmuS26XPzQiHU=; b=O4icN9kSm95kqTEZ8upTD
	a7TvyBPFwePC9ZfWJ3M1+VdkfN/X+1ndV5Dhep2hkgBvzcdVl2Fhjz8Q4boaR6z5
	OLNSIclmReKeD6GP+ekn93GqsBdlZEYA+bH/baZTLDzFES6uNoXpaI9dRgaHqH7I
	OgA/BuXMT3k8saopKuDTH8=
Received: from localhost.localdomain (unknown [123.149.2.202])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P+ihTvVmYf4FAA--.19120S5;
	Thu, 26 Sep 2024 20:08:07 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] udf: refactor inode_bmap() to handle error
Date: Thu, 26 Sep 2024 20:07:53 +0800
Message-ID: <20240926120753.3639404-4-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926120753.3639404-1-zhaomzhao@126.com>
References: <20240926120753.3639404-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+ihTvVmYf4FAA--.19120S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr4rAr4UtFykGr15uFyDZFb_yoW3XFy7pr
	9rKa42kr4rXrWxWF4IqF1kZw1Fga92kr47GrWxu34SyFWvgr1rKFy0yry29Fn8KF4rCa12
	qa15K3y5uw17JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jncTQUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6AZmd2b1Sv8nqwAAsV

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Refactor inode_bmap() to handle error since udf_next_aext() can return
error now. On situations like ftruncate, udf_extend_file() can now
detect errors and bail out early without resorting to checking for
particular offsets and assuming internal behavior of these functions.

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c | 13 ++++++++-----
 fs/udf/inode.c     | 29 ++++++++++++++++++-----------
 fs/udf/partition.c |  6 ++++--
 fs/udf/truncate.c  |  8 +++++---
 fs/udf/udfdecl.h   |  5 +++--
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 82922a4ae425..4b8bb77eaffa 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -246,6 +246,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 {
 	struct udf_inode_info *iinfo = UDF_I(dir);
 	int err = 0;
+	int8_t etype;
 
 	iter->dir = dir;
 	iter->bh[0] = iter->bh[1] = NULL;
@@ -265,9 +266,9 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
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
@@ -463,6 +464,7 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
 	sector_t block;
 	uint32_t old_elen = iter->elen;
 	int err;
+	int8_t etype;
 
 	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
 		return -EINVAL;
@@ -477,8 +479,9 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
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
index 6c4f104e2bf7..be9356f0eecf 100644
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
+		err = inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype);
+		if (!err && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
 			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
 							offset);
 			map->oflags |= UDF_BLK_MAPPED;
@@ -664,8 +665,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	 */
 	udf_discard_prealloc(inode);
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
-	within_last_ext = (etype != -1);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
+	if (UDF_EXT_ERR(err))
+		goto out;
+	within_last_ext = (!err);
 	/* We don't expect extents past EOF... */
 	WARN_ON_ONCE(within_last_ext &&
 		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
@@ -2391,13 +2394,17 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
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
 	int err = 0;
 
@@ -2409,18 +2416,18 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
+		err = udf_next_aext(inode, pos, eloc, elen, etype, 1);
 		if (UDF_EXT_EOF(err)) {
 			*offset = (bcount - lbcount) >> blocksize_bits;
 			iinfo->i_lenExtents = lbcount;
 		}
 		if (err < 0)
-			return -1;
+			return err;
 		lbcount += *elen;
 	} while (lbcount <= bcount);
 	/* update extent cache */
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
index af06f7101859..d13ba9fd1309 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -208,10 +208,12 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		BUG();
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
 	byte_offset = (offset << sb->s_blocksize_bits) +
-		(inode->i_size & (sb->s_blocksize - 1));
-	if (etype == -1) {
+		      (inode->i_size & (sb->s_blocksize - 1));
+	if (UDF_EXT_ERR(err))
+		return err;
+	if (UDF_EXT_EOF(err)) {
 		/* We should extend the file? */
 		WARN_ON(byte_offset);
 		return 0;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 206077da9968..a156ed95189a 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -160,8 +160,9 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
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


