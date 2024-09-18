Return-Path: <linux-kernel+bounces-332528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936A97BAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC31C21039
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E22184528;
	Wed, 18 Sep 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mE33o964"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718E175D54
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655542; cv=none; b=gUE8xHbZ+w7z4O3IuWOGVEQ5vpEMiYPho71fw5lBHE8sAJ8eZ6mlImnnFGcSxxft7oqx1xYYcId57DJ1vL0gI1A2F1YoDURlvL1qsu2wuInYwl+IcwpK16bN/fO1ZED0P65a6XaMpr7w5toEzpnQ6hao9faFWlP5Qv0Gi5S1kFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655542; c=relaxed/simple;
	bh=iEgFLG+KoHI4HRLF/CNf+jA0zaa1OKtL1Gvt8Zfn7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfNz/MLFmPe6IQCoLuy+JCo9OqwnGPE2TB5wijYmi/nzNdv32KjNnxj6Atd3z4CHfO8aycCJVHSUpcR8zEDpG2G9fghETFfKXw21xy6kSeraZqjJOM9ZRpvCCUZYHXw8BH+qiVOJ/LvGpEPS7ByfW8/puIWM/pcHhn/edprxM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mE33o964; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=swiNN
	3cyAG6SEu+a4uyrFOj0upovoKeCEUXK27Sc5WU=; b=mE33o964qHiRkN9TYST6Y
	xu4GaTHbvARIPr/71Y0moJH3SyUeukSaMbO1KroUZV2y7XoHYheaauAURwrqGvyc
	iBvFQgua/ERK+tTmU/wVJDN9AXLziG4DSrQYIIGrbZL1tAm9lBiKe0T3EncrwjGT
	cqf1aYtj3j9vcvESEo2Swc=
Received: from localhost.localdomain (unknown [1.198.30.207])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLyAsn+pm2TCHAA--.46011S4;
	Wed, 18 Sep 2024 17:36:47 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] udf: refactor udf_next_aext() to handle error
Date: Wed, 18 Sep 2024 17:36:33 +0800
Message-ID: <20240918093634.12906-3-zhaomzhao@126.com>
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
X-CM-TRANSID:_____wDnLyAsn+pm2TCHAA--.46011S4
X-Coremail-Antispam: 1Uf129KBjvJXoWfGrW5tryxJw1xtr4DGFyUZFb_yoWktr1Upr
	y7Kas7t343WFW7ur4Iqr4kZr1Sga97CF47Cr1Fq3s3tF40gr15tF1Fyry29F1UWrs5Ww4a
	qw4rK34qkw4xKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI4EiUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimh1ed2bqixWx0QAEsY

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Same as udf_current_aext(), take pointer to etype to store the extent
type, while return 0 for success and <0 on error.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 fs/udf/balloc.c    |  6 +++---
 fs/udf/directory.c |  7 +++++--
 fs/udf/inode.c     | 50 +++++++++++++++++++++++-----------------------
 fs/udf/super.c     |  3 ++-
 fs/udf/truncate.c  |  8 ++++----
 fs/udf/udfdecl.h   |  5 +++--
 6 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index d8fc11765d61..b216c43cf433 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -384,7 +384,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 	epos.bh = oepos.bh = NULL;
 
 	while (count &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	       !udf_next_aext(table, &epos, &eloc, &elen, &etype, 1)) {
 		if (((eloc.logicalBlockNum +
 			(elen >> sb->s_blocksize_bits)) == start)) {
 			if ((0x3FFFFFFF - elen) <
@@ -517,7 +517,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	eloc.logicalBlockNum = 0xFFFFFFFF;
 
 	while (first_block != eloc.logicalBlockNum &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	       !udf_next_aext(table, &epos, &eloc, &elen, &etype, 1)) {
 		udf_debug("eloc=%u, elen=%u, first_block=%u\n",
 			  eloc.logicalBlockNum, elen, first_block);
 		; /* empty loop body */
@@ -584,7 +584,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	epos.bh = goal_epos.bh = NULL;
 
 	while (spread &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	       !udf_next_aext(table, &epos, &eloc, &elen, &etype, 1)) {
 		if (goal >= eloc.logicalBlockNum) {
 			if (goal < eloc.logicalBlockNum +
 					(elen >> sb->s_blocksize_bits))
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 93153665eb37..f865538c985d 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -166,13 +166,16 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
  */
 static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 {
+	int8_t etype;
+	int err = 0;
 	iter->loffset++;
 	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
 		return 0;
 
 	iter->loffset = 0;
-	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
-			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen,
+			    &etype, 1);
+	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (iter->pos == iter->dir->i_size) {
 			iter->elen = 0;
 			return 0;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 6d41ca0e7dba..ba980ce5e13a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -545,6 +545,7 @@ static int udf_do_extend_file(struct inode *inode,
 	} else {
 		struct kernel_lb_addr tmploc;
 		uint32_t tmplen;
+		int8_t tmptype;
 
 		udf_write_aext(inode, last_pos, &last_ext->extLocation,
 				last_ext->extLength, 1);
@@ -555,7 +556,7 @@ static int udf_do_extend_file(struct inode *inode,
 		 * empty indirect extent.
 		 */
 		if (new_block_bytes)
-			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+			udf_next_aext(inode, last_pos, &tmploc, &tmplen, &tmptype, 0);
 	}
 	iinfo->i_lenExtents += add;
 
@@ -674,8 +675,8 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
 	} else {
 		epos.offset -= adsize;
-		etype = udf_next_aext(inode, &epos, &extent.extLocation,
-				      &extent.extLength, 0);
+		udf_next_aext(inode, &epos, &extent.extLocation,
+				&extent.extLength, &etype, 0);
 		extent.extLength |= etype << 30;
 	}
 
@@ -712,7 +713,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	loff_t lbcount = 0, b_off = 0;
 	udf_pblk_t newblocknum;
 	sector_t offset = 0;
-	int8_t etype;
+	int8_t etype, tmpetype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
 	int lastblock = 0;
@@ -748,8 +749,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		prev_epos.offset = cur_epos.offset;
 		cur_epos.offset = next_epos.offset;
 
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
-		if (etype == -1)
+		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
+		if (ret)
 			break;
 
 		c = !c;
@@ -771,8 +772,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	 * Move prev_epos and cur_epos into indirect extent if we are at
 	 * the pointer to it
 	 */
-	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
-	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
+	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
+	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
 
 	/* if the extent is allocated and recorded, return the block
 	   if the extent is not a multiple of the blocksize, round up */
@@ -793,7 +794,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	}
 
 	/* Are we beyond EOF and preallocated extent? */
-	if (etype == -1) {
+	if (ret < 0) {
 		loff_t hole_len;
 
 		isBeyondEOF = true;
@@ -846,8 +847,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 
 		/* if the current block is located in an extent,
 		   read the next extent */
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
-		if (etype != -1) {
+		if (!udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0)) {
 			laarr[c + 1].extLength = (etype << 30) | elen;
 			laarr[c + 1].extLocation = eloc;
 			count++;
@@ -1172,6 +1172,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int8_t tmptype;
 	int err;
 
 	if (startnum > endnum) {
@@ -1190,13 +1191,13 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			if (err < 0)
 				return err;
 			udf_next_aext(inode, epos, &laarr[i].extLocation,
-				      &laarr[i].extLength, 1);
+				      &laarr[i].extLength, &tmptype, 1);
 			start++;
 		}
 	}
 
 	for (i = start; i < endnum; i++) {
-		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
+		udf_next_aext(inode, epos, &tmploc, &tmplen, &tmptype, 0);
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
@@ -2168,15 +2169,15 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
  */
 #define UDF_MAX_INDIR_EXTS 16
 
-int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
-		     struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+int udf_next_aext(struct inode *inode, struct extent_position *epos,
+		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		  int inc)
 {
-	int8_t etype;
 	unsigned int indirections = 0;
 	int err = 0;
 
-	while ((err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
-		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+	while ((err = udf_current_aext(inode, epos, eloc, elen, etype, inc))) {
+		if (err || *etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
 			break;
 
 		udf_pblk_t block;
@@ -2185,7 +2186,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 			udf_err(inode->i_sb,
 				"too many indirect extents in inode %lu\n",
 				inode->i_ino);
-			return -1;
+			return -EFSCORRUPTED;
 		}
 
 		epos->block = *eloc;
@@ -2195,7 +2196,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		epos->bh = sb_bread(inode->i_sb, block);
 		if (!epos->bh) {
 			udf_debug("reading block %u failed!\n", block);
-			return -1;
+			return -EIO;
 		}
 	}
 
@@ -2267,7 +2268,7 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
 	if (epos.bh)
 		get_bh(epos.bh);
 
-	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
+	while (!udf_next_aext(inode, &epos, &oeloc, &oelen, &etype, 0)) {
 		udf_write_aext(inode, &epos, &neloc, nelen, 1);
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
@@ -2302,10 +2303,10 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 		adsize = 0;
 
 	oepos = epos;
-	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
+	if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1))
 		return -1;
 
-	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while (!udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1)) {
 		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
 		if (oepos.bh != epos.bh) {
 			oepos.block = epos.block;
@@ -2379,8 +2380,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		etype = udf_next_aext(inode, pos, eloc, elen, 1);
-		if (etype == -1) {
+		if (udf_next_aext(inode, pos, eloc, elen, &etype, 1)) {
 			*offset = (bcount - lbcount) >> blocksize_bits;
 			iinfo->i_lenExtents = lbcount;
 			return -1;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 3460ecc826d1..8c34224e1aee 100644
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
+	while (!udf_next_aext(table, &epos, &eloc, &elen, &etype, 1))
 		accum += (elen >> table->i_sb->s_blocksize_bits);
 
 	brelse(epos.bh);
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 91b6e2698e7e..b7361222f988 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -85,7 +85,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 		BUG();
 
 	/* Find the last extent in the file */
-	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1)) {
 		etype = netype;
 		lbcount += elen;
 		if (lbcount > inode->i_size) {
@@ -101,7 +101,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 			epos.offset -= adsize;
 			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
 			epos.offset += adsize;
-			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
+			if (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1))
 				udf_err(inode->i_sb,
 					"Extent after EOF in inode %u\n",
 					(unsigned)inode->i_ino);
@@ -132,13 +132,13 @@ void udf_discard_prealloc(struct inode *inode)
 	epos.block = iinfo->i_location;
 
 	/* Find the last extent in the file */
-	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
+	while (!udf_next_aext(inode, &epos, &eloc, &elen, &etype, 0)) {
 		brelse(prev_epos.bh);
 		prev_epos = epos;
 		if (prev_epos.bh)
 			get_bh(prev_epos.bh);
 
-		etype = udf_next_aext(inode, &epos, &eloc, &elen, 1);
+		udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
 		lbcount += elen;
 	}
 	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
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


