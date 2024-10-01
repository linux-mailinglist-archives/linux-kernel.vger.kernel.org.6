Return-Path: <linux-kernel+bounces-345835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA298BBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B24B23034
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B2B1C2DD7;
	Tue,  1 Oct 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hFiBNPRa"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198AF1C2459
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783740; cv=none; b=XbbSvjTX+C6m6x8vG6HVuvb+ihRXcJ8r3L9EbWCBqXjQaSxn2w1cHQZCK5KAkFBXwA5vJV3FiQa6BjxvfJUxelhRw+/0RuSHb/FSLfQvzaPxEa0zLTTAmgAma+hcAApCi0w/jIvAfXz6DqUHjEom+2GKOKztWHqAeH09oHezY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783740; c=relaxed/simple;
	bh=8Wvr7dDKo7MbkKFVfenkL1m5Og5AmGR9O4t85Scis78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC8bkeofWgt+hpGopIpvFr0RNOde05x4ehIkQLN+xg4ZfSMs94wvUJG36AkwulwooZwCQgeSIgcTisLLoPKMpwwud1G+XzX+3FjsIDEu1o5S46ZlRPCtSjriZnGIhbdPrzPyI4PnjMBJGZCC/QmvXEuzDQ3iexNBMqujq5gwmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hFiBNPRa; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=rfDbe
	H/Ybr1aTNLHWFFA3i61Uz/IWLG4kn7wsB5BXWs=; b=hFiBNPRaC/m3cPE3gmqPL
	VnzmduaBik3PAYjWiBe/JkvgDnRG2xcp0sfhbKg6C18zG2nsuQWu7bfjPMvfgK2r
	ZJnyxptoKG86uAwkBU+IfS72fmMb1IMBZbQQur5ypHSiaV090ZyHjdSCoqhN7oKL
	phHzlbPZlgxcfUfekq0yvc=
Received: from localhost.localdomain (unknown [39.162.142.163])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33yf24vtm4rdrAA--.18425S5;
	Tue, 01 Oct 2024 19:54:35 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] udf: refactor inode_bmap() to handle error
Date: Tue,  1 Oct 2024 19:54:25 +0800
Message-ID: <20241001115425.266556-4-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001115425.266556-1-zhaomzhao@126.com>
References: <20241001115425.266556-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33yf24vtm4rdrAA--.18425S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr4rAr4UtFykJF4xWFy5CFg_yoW3GFyDpr
	9rKFy2krWrXrWxWF4IqF1kZw1Sg3Z2kr47GryxZ34FyFWvgrn8ta40yrya9Fn8KF4rCw42
	qa15K3yUuw47J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpKZJUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiEA1rd2b732ch1wAAsS

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
 fs/udf/inode.c     | 27 ++++++++++++++++-----------
 fs/udf/partition.c |  6 ++++--
 fs/udf/truncate.c  |  6 ++++--
 fs/udf/udfdecl.h   |  5 +++--
 5 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index c6950050e7ae..632453aa3893 100644
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
+	err = inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
+			 &iter->eloc, &iter->elen, &iter->loffset, &etype);
+	if (err <= 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
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
+	if (err <= 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		udf_err(iter->dir->i_sb,
 			"block %llu not allocated in directory (ino %lu)\n",
 			(unsigned long long)block, iter->dir->i_ino);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 84093f9c71c7..c275a5f3a0f6 100644
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
+		if (err == 1 && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
 			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
 							offset);
 			map->oflags |= UDF_BLK_MAPPED;
@@ -664,8 +665,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	 */
 	udf_discard_prealloc(inode);
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
-	within_last_ext = (etype != -1);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
+	if (err < 0)
+		goto out;
+	within_last_ext = (err == 1);
 	/* We don't expect extents past EOF... */
 	WARN_ON_ONCE(within_last_ext &&
 		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
@@ -2398,13 +2401,15 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 	return (elen >> 30);
 }
 
-int8_t inode_bmap(struct inode *inode, sector_t block,
-		  struct extent_position *pos, struct kernel_lb_addr *eloc,
-		  uint32_t *elen, sector_t *offset)
+/*
+ * Returns 1 on success, -errno on error, 0 on hit EOF.
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
 
@@ -2416,13 +2421,13 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
+		err = udf_next_aext(inode, pos, eloc, elen, etype, 1);
 		if (err <= 0) {
 			if (err == 0) {
 				*offset = (bcount - lbcount) >> blocksize_bits;
 				iinfo->i_lenExtents = lbcount;
 			}
-			return -1;
+			return err;
 		}
 		lbcount += *elen;
 	} while (lbcount <= bcount);
@@ -2430,5 +2435,5 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	udf_update_extent_cache(inode, lbcount - *elen, pos);
 	*offset = (bcount + *elen - lbcount) >> blocksize_bits;
 
-	return etype;
+	return 1;
 }
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index af877991edc1..2b85c9501bed 100644
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
+	if (err <= 0 || etype != (EXT_RECORDED_ALLOCATED >> 30))
 		phyblock = 0xFFFFFFFF;
 	else {
 		map = &UDF_SB(sb)->s_partmaps[partition];
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index b91876a7b53a..03774282361b 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -210,10 +210,12 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		BUG();
 
-	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
+	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
 	byte_offset = (offset << sb->s_blocksize_bits) +
 		(inode->i_size & (sb->s_blocksize - 1));
-	if (etype == -1) {
+	if (err < 0)
+		return err;
+	else if (err == 0) {
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


