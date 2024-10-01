Return-Path: <linux-kernel+bounces-345839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76798BBAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38192284557
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3291C174F;
	Tue,  1 Oct 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RnIZiTpb"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1CB1C1ACF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783840; cv=none; b=melK78J/WOopAIpxrZfBItiMnmkekqE04XHWUlMTSZROXJMnffHD+EjMDgQpfPBq+SoE7a27ahY1XZKCi+oAgKwWJ3uQTfPdBvO3wCINCl5/s+Cn4InsAfI1HIGD4ChEZRqF9X1yevBOKVQkQuIeYPy2zq+wWJOkvZNuYFNhEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783840; c=relaxed/simple;
	bh=2Z9PVmNg/tmv3AYSNZB8QI2JRp2QbWtgYO5ajVK/LRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjKm2/ess4bP8rVni7QU4CeKYS+UcK7gaASzajkd510WQYdIF3UD5LXbJKIDHRENDDJ5mIEnZJAh+lPofgiNEOUKTLUOpmskXskADlCU9d5yEGwfphhIWOso0ibtlTejNOLapTU+Oxv7WmjQtlYSRNmiNyRMpyi99BFrHq0aIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RnIZiTpb; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=xLJEZ
	i+6vv8jpgVYUKMt79L7sgztdS3mDzDAP7hCxqI=; b=RnIZiTpbaRqhgvBVdvK4d
	DT9Lq7N8FgJ8L3B2Hc/vol8umdiKAQGAVJAxPlStCENYpgNmZXxF8T4lr6I49F1X
	yMh53O0R5aOG146INhcKNTRxahmj7p7hJO6IaoSIxGpmfycBO3CCBIxywMoRGI3y
	kte8kbDSPVPU4oUapyPDmI=
Received: from localhost.localdomain (unknown [39.162.142.163])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33yf24vtm4rdrAA--.18425S4;
	Tue, 01 Oct 2024 19:54:31 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] udf: refactor udf_next_aext() to handle error
Date: Tue,  1 Oct 2024 19:54:24 +0800
Message-ID: <20241001115425.266556-3-zhaomzhao@126.com>
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
X-CM-TRANSID:_____wD33yf24vtm4rdrAA--.18425S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfJr4fJF4fZw1DJFyxXw1fZwb_yoW8AFWkuo
	W5Aan8K3Z5XrWfAFW8C348tFyUZ39aka1xJr1Uur909w1xG3y5XwnIg3W5Zay7WrW0grWk
	Z34xWw45JF4kCrs8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0xR6DUUUU
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimgZrd2b74GcXdQABs5

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Since udf_current_aext() has error handling, udf_next_aext() should have
error handling too. Besides, when too many indirect extents found in one
inode, return -EFSCORRUPTED; when reading block failed, return -EIO.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c    |  27 ++++++++----
 fs/udf/directory.c |  10 ++++-
 fs/udf/inode.c     | 108 ++++++++++++++++++++++++++++++---------------
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  25 ++++++++---
 fs/udf/udfdecl.h   |   5 ++-
 6 files changed, 122 insertions(+), 56 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index d8fc11765d61..efa110545e59 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -370,6 +370,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct extent_position oepos, epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo;
+	int err = 0;
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	iinfo = UDF_I(table);
@@ -383,8 +384,8 @@ static void udf_table_free_blocks(struct super_block *sb,
 	epos.block = oepos.block = iinfo->i_location;
 	epos.bh = oepos.bh = NULL;
 
-	while (count &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	while (count && ((err = udf_next_aext(table, &epos, &eloc, &elen,
+					      &etype, 1)) == 1)) {
 		if (((eloc.logicalBlockNum +
 			(elen >> sb->s_blocksize_bits)) == start)) {
 			if ((0x3FFFFFFF - elen) <
@@ -435,6 +436,9 @@ static void udf_table_free_blocks(struct super_block *sb,
 		}
 	}
 
+	if (err < 0)
+		goto error_return;
+
 	if (count) {
 		/*
 		 * NOTE: we CANNOT use udf_add_aext here, as it can try to
@@ -460,8 +464,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 		else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
 			adsize = sizeof(struct long_ad);
 		else {
-			brelse(oepos.bh);
-			brelse(epos.bh);
 			goto error_return;
 		}
 
@@ -479,10 +481,10 @@ static void udf_table_free_blocks(struct super_block *sb,
 			__udf_add_aext(table, &epos, &eloc, elen, 1);
 	}
 
+error_return:
 	brelse(epos.bh);
 	brelse(oepos.bh);
 
-error_return:
 	mutex_unlock(&sbi->s_alloc_mutex);
 	return;
 }
@@ -498,6 +500,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	struct extent_position epos;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo;
+	int err = 0;
 
 	if (first_block >= sbi->s_partmaps[partition].s_partition_len)
 		return 0;
@@ -517,12 +520,16 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	eloc.logicalBlockNum = 0xFFFFFFFF;
 
 	while (first_block != eloc.logicalBlockNum &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	       (err = udf_next_aext(table, &epos, &eloc,
+				    &elen, &etype, 1)) == 1) {
 		udf_debug("eloc=%u, elen=%u, first_block=%u\n",
 			  eloc.logicalBlockNum, elen, first_block);
 		; /* empty loop body */
 	}
 
+	if (err < 0)
+		goto err_out;
+
 	if (first_block == eloc.logicalBlockNum) {
 		epos.offset -= adsize;
 
@@ -539,6 +546,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 		alloc_count = 0;
 	}
 
+err_out:
 	brelse(epos.bh);
 
 	if (alloc_count)
@@ -560,6 +568,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	struct extent_position epos, goal_epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(table);
+	int ret = 0;
 
 	*err = -ENOSPC;
 
@@ -583,8 +592,8 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	epos.block = iinfo->i_location;
 	epos.bh = goal_epos.bh = NULL;
 
-	while (spread &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	while (spread && (ret = udf_next_aext(table, &epos, &eloc, &elen,
+					      &etype, 1)) == 1) {
 		if (goal >= eloc.logicalBlockNum) {
 			if (goal < eloc.logicalBlockNum +
 					(elen >> sb->s_blocksize_bits))
@@ -612,7 +621,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 
 	brelse(epos.bh);
 
-	if (spread == 0xFFFFFFFF) {
+	if (ret < 0 || spread == 0xFFFFFFFF) {
 		brelse(goal_epos.bh);
 		mutex_unlock(&sbi->s_alloc_mutex);
 		return 0;
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 93153665eb37..c6950050e7ae 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -166,13 +166,19 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
  */
 static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 {
+	int8_t etype = -1;
+	int err = 0;
+
 	iter->loffset++;
 	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
 		return 0;
 
 	iter->loffset = 0;
-	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
-			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc,
+			    &iter->elen, &etype, 1);
+	if (err < 0)
+		return err;
+	else if (err == 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (iter->pos == iter->dir->i_size) {
 			iter->elen = 0;
 			return 0;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 70a27d2bfd29..84093f9c71c7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -545,6 +545,7 @@ static int udf_do_extend_file(struct inode *inode,
 	} else {
 		struct kernel_lb_addr tmploc;
 		uint32_t tmplen;
+		int8_t tmptype;
 
 		udf_write_aext(inode, last_pos, &last_ext->extLocation,
 				last_ext->extLength, 1);
@@ -554,8 +555,12 @@ static int udf_do_extend_file(struct inode *inode,
 		 * more extents, we may need to enter possible following
 		 * empty indirect extent.
 		 */
-		if (new_block_bytes)
-			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+		if (new_block_bytes) {
+			err = udf_next_aext(inode, last_pos, &tmploc, &tmplen,
+					    &tmptype, 0);
+			if (err < 0)
+				goto out_err;
+		}
 	}
 	iinfo->i_lenExtents += add;
 
@@ -674,8 +679,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
 	} else {
 		epos.offset -= adsize;
-		etype = udf_next_aext(inode, &epos, &extent.extLocation,
-				      &extent.extLength, 0);
+		err = udf_next_aext(inode, &epos, &extent.extLocation,
+				    &extent.extLength, &etype, 0);
+		if (err != 1)
+			goto out;
 		extent.extLength |= etype << 30;
 	}
 
@@ -712,11 +719,11 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	loff_t lbcount = 0, b_off = 0;
 	udf_pblk_t newblocknum;
 	sector_t offset = 0;
-	int8_t etype;
+	int8_t etype, tmpetype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
 	int lastblock = 0;
-	bool isBeyondEOF;
+	bool isBeyondEOF = false;
 	int ret = 0;
 
 	prev_epos.offset = udf_file_entry_alloc_offset(inode);
@@ -748,9 +755,13 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		prev_epos.offset = cur_epos.offset;
 		cur_epos.offset = next_epos.offset;
 
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
-		if (etype == -1)
+		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
+		if (ret < 0)
+			goto out_free;
+		else if (ret == 0) {
+			isBeyondEOF = true;
 			break;
+		}
 
 		c = !c;
 
@@ -771,13 +782,17 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	 * Move prev_epos and cur_epos into indirect extent if we are at
 	 * the pointer to it
 	 */
-	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
-	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
+	if (udf_next_aext(inode, &prev_epos, &tmpeloc,
+			  &tmpelen, &tmpetype, 0) < 0)
+		goto out_free;
+	if (udf_next_aext(inode, &cur_epos, &tmpeloc,
+			  &tmpelen, &tmpetype, 0) < 0)
+		goto out_free;
 
 	/* if the extent is allocated and recorded, return the block
 	   if the extent is not a multiple of the blocksize, round up */
 
-	if (etype == (EXT_RECORDED_ALLOCATED >> 30)) {
+	if (ret == 1 && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (elen & (inode->i_sb->s_blocksize - 1)) {
 			elen = EXT_RECORDED_ALLOCATED |
 				((elen + inode->i_sb->s_blocksize - 1) &
@@ -793,10 +808,9 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	}
 
 	/* Are we beyond EOF and preallocated extent? */
-	if (etype == -1) {
+	if (isBeyondEOF) {
 		loff_t hole_len;
 
-		isBeyondEOF = true;
 		if (count) {
 			if (c)
 				laarr[0] = laarr[1];
@@ -832,7 +846,6 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		endnum = c + 1;
 		lastblock = 1;
 	} else {
-		isBeyondEOF = false;
 		endnum = startnum = ((count > 2) ? 2 : count);
 
 		/* if the current extent is in position 0,
@@ -846,15 +859,17 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 
 		/* if the current block is located in an extent,
 		   read the next extent */
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
-		if (etype != -1) {
+		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0);
+		if (ret == 1) {
 			laarr[c + 1].extLength = (etype << 30) | elen;
 			laarr[c + 1].extLocation = eloc;
 			count++;
 			startnum++;
 			endnum++;
-		} else
+		} else if (ret == 0)
 			lastblock = 1;
+		else
+			goto out_free;
 	}
 
 	/* if the current extent is not recorded but allocated, get the
@@ -1172,6 +1187,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int8_t tmpetype;
 	int err;
 
 	if (startnum > endnum) {
@@ -1189,14 +1205,19 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			 */
 			if (err < 0)
 				return err;
-			udf_next_aext(inode, epos, &laarr[i].extLocation,
-				      &laarr[i].extLength, 1);
+			err = udf_next_aext(inode, epos, &laarr[i].extLocation,
+				      &laarr[i].extLength, &tmpetype, 1);
+			if (err < 0)
+				return err;
 			start++;
 		}
 	}
 
 	for (i = start; i < endnum; i++) {
-		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
+		err = udf_next_aext(inode, epos, &tmploc, &tmplen, &tmpetype, 0);
+		if (err < 0)
+			return err;
+
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
@@ -2168,16 +2189,19 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
  */
 #define UDF_MAX_INDIR_EXTS 16
 
-int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
-		     struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+/*
+ * Returns 1 on success, -errno on error, 0 on hit EOF.
+ */
+int udf_next_aext(struct inode *inode, struct extent_position *epos,
+		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		  int inc)
 {
-	int8_t etype;
 	unsigned int indirections = 0;
 	int err = 0;
 
 	while ((err = udf_current_aext(inode, epos, eloc, elen,
-				       &etype, inc)) == 1) {
-		if (etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+				       etype, inc)) == 1) {
+		if (*etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
 			break;
 		udf_pblk_t block;
 
@@ -2185,7 +2209,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 			udf_err(inode->i_sb,
 				"too many indirect extents in inode %lu\n",
 				inode->i_ino);
-			return -1;
+			return -EFSCORRUPTED;
 		}
 
 		epos->block = *eloc;
@@ -2195,11 +2219,11 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		epos->bh = sb_bread(inode->i_sb, block);
 		if (!epos->bh) {
 			udf_debug("reading block %u failed!\n", block);
-			return -1;
+			return -EIO;
 		}
 	}
 
-	return err == 1 ? etype : -1;
+	return err;
 }
 
 /*
@@ -2270,12 +2294,14 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
 	if (epos.bh)
 		get_bh(epos.bh);
 
-	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
+	while ((err = udf_next_aext(inode, &epos, &oeloc,
+				     &oelen, &etype, 0)) == 1) {
 		udf_write_aext(inode, &epos, &neloc, nelen, 1);
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	if (err == 0)
+		err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
 	brelse(epos.bh);
 
 	return err;
@@ -2290,6 +2316,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 	struct udf_inode_info *iinfo;
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
+	int err = 0;
 
 	if (epos.bh) {
 		get_bh(epos.bh);
@@ -2305,10 +2332,11 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 		adsize = 0;
 
 	oepos = epos;
-	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
+	if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1) <= 0)
 		return -1;
 
-	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while ((err = udf_next_aext(inode, &epos, &eloc,
+				    &elen, &etype, 1)) == 1) {
 		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
 		if (oepos.bh != epos.bh) {
 			oepos.block = epos.block;
@@ -2318,6 +2346,11 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 			oepos.offset = epos.offset - adsize;
 		}
 	}
+	if (err < 0) {
+		brelse(epos.bh);
+		brelse(oepos.bh);
+		return -1;
+	}
 	memset(&eloc, 0x00, sizeof(struct kernel_lb_addr));
 	elen = 0;
 
@@ -2373,6 +2406,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
 	int8_t etype;
 	struct udf_inode_info *iinfo;
+	int err = 0;
 
 	iinfo = UDF_I(inode);
 	if (!udf_read_extent_cache(inode, bcount, &lbcount, pos)) {
@@ -2382,10 +2416,12 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		etype = udf_next_aext(inode, pos, eloc, elen, 1);
-		if (etype == -1) {
-			*offset = (bcount - lbcount) >> blocksize_bits;
-			iinfo->i_lenExtents = lbcount;
+		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
+		if (err <= 0) {
+			if (err == 0) {
+				*offset = (bcount - lbcount) >> blocksize_bits;
+				iinfo->i_lenExtents = lbcount;
+			}
 			return -1;
 		}
 		lbcount += *elen;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 3460ecc826d1..4bb7f600b99f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2482,13 +2482,14 @@ static unsigned int udf_count_free_table(struct super_block *sb,
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
 	struct extent_position epos;
+	int8_t etype;
 
 	mutex_lock(&UDF_SB(sb)->s_alloc_mutex);
 	epos.block = UDF_I(table)->i_location;
 	epos.offset = sizeof(struct unallocSpaceEntry);
 	epos.bh = NULL;
 
-	while (udf_next_aext(table, &epos, &eloc, &elen, 1) != -1)
+	while (udf_next_aext(table, &epos, &eloc, &elen, &etype, 1) == 1)
 		accum += (elen >> table->i_sb->s_blocksize_bits);
 
 	brelse(epos.bh);
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 76186b211efe..b91876a7b53a 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -69,6 +69,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 	int8_t etype = -1, netype;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    inode->i_size == iinfo->i_lenExtents)
@@ -85,7 +86,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 		BUG();
 
 	/* Find the last extent in the file */
-	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while ((err = udf_next_aext(inode, &epos, &eloc,
+				    &elen, &netype, 1)) == 1) {
 		etype = netype;
 		lbcount += elen;
 		if (lbcount > inode->i_size) {
@@ -101,7 +103,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 			epos.offset -= adsize;
 			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
 			epos.offset += adsize;
-			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
+			if (udf_next_aext(inode, &epos, &eloc, &elen,
+					  &netype, 1) == 1)
 				udf_err(inode->i_sb,
 					"Extent after EOF in inode %u\n",
 					(unsigned)inode->i_ino);
@@ -110,7 +113,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 	}
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
-	iinfo->i_lenExtents = inode->i_size;
+	if (err == 0)
+		iinfo->i_lenExtents = inode->i_size;
 	brelse(epos.bh);
 }
 
@@ -124,6 +128,8 @@ void udf_discard_prealloc(struct inode *inode)
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int bsize = i_blocksize(inode);
+	int8_t tmpetype = -1;
+	int err = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
@@ -132,16 +138,22 @@ void udf_discard_prealloc(struct inode *inode)
 	epos.block = iinfo->i_location;
 
 	/* Find the last extent in the file */
-	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
+	while ((err = udf_next_aext(inode, &epos, &eloc,
+				    &elen, &tmpetype, 0)) == 1) {
 		brelse(prev_epos.bh);
 		prev_epos = epos;
 		if (prev_epos.bh)
 			get_bh(prev_epos.bh);
 
-		etype = udf_next_aext(inode, &epos, &eloc, &elen, 1);
+		err = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
+		if (err <= 0)
+			break;
 		lbcount += elen;
 	}
-	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
+	if (err < 0)
+		goto out;
+
+	if (err == 1 && etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
 		lbcount -= elen;
 		udf_delete_aext(inode, prev_epos);
 		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
@@ -150,6 +162,7 @@ void udf_discard_prealloc(struct inode *inode)
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
 	iinfo->i_lenExtents = lbcount;
+out:
 	brelse(epos.bh);
 	brelse(prev_epos.bh);
 }
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d893db95ac70..5067ed68a8b4 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -169,8 +169,9 @@ extern int udf_add_aext(struct inode *, struct extent_position *,
 extern void udf_write_aext(struct inode *, struct extent_position *,
 			   struct kernel_lb_addr *, uint32_t, int);
 extern int8_t udf_delete_aext(struct inode *, struct extent_position);
-extern int8_t udf_next_aext(struct inode *, struct extent_position *,
-			    struct kernel_lb_addr *, uint32_t *, int);
+extern int udf_next_aext(struct inode *inode, struct extent_position *epos,
+			 struct kernel_lb_addr *eloc, uint32_t *elen,
+			 int8_t *etype, int inc);
 extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
 			    struct kernel_lb_addr *eloc, uint32_t *elen,
 			    int8_t *etype, int inc);
-- 
2.43.0


