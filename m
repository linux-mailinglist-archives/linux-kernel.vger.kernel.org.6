Return-Path: <linux-kernel+bounces-340425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91D987341
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468642844DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA901741E8;
	Thu, 26 Sep 2024 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ITiA1ON7"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75E15B97B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352500; cv=none; b=GUMcGTywzMMbYa+LhfXw/EpQVnOdrY6YkEiHB1GHWwZ8vuDZdjHsLVxd+ICI19MzSEWCnvfOedG146B/URLQxo485nGh7FVDbMyuf6WbFNgQ2UPbiHPtJljL+f0n0I8g7DrbZHiDCPFjbd0RlHi9A2qnYgstf47oej7rDDwghdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352500; c=relaxed/simple;
	bh=fTUgQXQV+kssQOAHRrXmcSuZwzzq+jYLUFBuk77wDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMc5AM1I5w4bElTa9iNLut3zmu0rrcd2CaEFTnIesmtWe+oOefthM4DcopqM8JMid8x9t8NBl4fRxFhedtGN9C00dtonWgvGEb0JFtQd6bwLoIKOmlLtzGa4XX/uxiP5YFMfvF7cKKmRjP8zpvYejjiDVhjWxwtxiyD88CfmsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ITiA1ON7; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hydKP
	oFUkIXlz7wEGCsFCoDE+OtccpTc+Dc6ACtlA2o=; b=ITiA1ON7XY4bxnHV5JCoK
	pEvNbzY5C2YQtRWxZXnCM5e6UTfwXPZcN5RNHbC7X0sIFYf312Bwgp7RYu4zdwPx
	q0J12r8owzIziQrnL2FsH7wrHIK+IE9S406Mv5dU5JlayLyXIFDP5GL/khfBIHNa
	vdzkD0Ly70JWBG3X63fcBQ=
Received: from localhost.localdomain (unknown [123.149.2.202])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P+ihTvVmYf4FAA--.19120S3;
	Thu, 26 Sep 2024 20:08:03 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] udf: refactor udf_current_aext() to handle error
Date: Thu, 26 Sep 2024 20:07:51 +0800
Message-ID: <20240926120753.3639404-2-zhaomzhao@126.com>
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
X-CM-TRANSID:_____wD3P+ihTvVmYf4FAA--.19120S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr13Ar15tw48Jry3Ww43GFg_yoWxXr4fpF
	W2kasFkw43XrWxuw4IqF4DZF1aqaykGr47Gr12q34rtF4jgr1rtF1Utr4IvFyYgrs5Gw1a
	qFs5tryq9w42y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqYL9UUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6Almd2b1Sv8njwABs-

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

As Jan suggested in links below, refactor udf_current_aext() to
differentiate between error and "hit EOF", it now takes pointer to etype
to store the extent type, return 0 when get etype success; return -ENODATA
when hit EOF; return -EINVAL when i_alloc_type invalid. Add two macroes to
test return value.

Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c    | 37 +++++++++++++++++++++++--------------
 fs/udf/truncate.c | 10 ++++++++--
 fs/udf/udfdecl.h  |  8 ++++++--
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..3be59aa8d4fd 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1955,6 +1955,7 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	struct extent_position nepos;
 	struct kernel_lb_addr neloc;
 	int ver, adsize;
+	int err = 0;
 
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -1999,10 +2000,12 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	if (epos->offset + adsize > sb->s_blocksize) {
 		struct kernel_lb_addr cp_loc;
 		uint32_t cp_len;
-		int cp_type;
+		int8_t cp_type;
 
 		epos->offset -= adsize;
-		cp_type = udf_current_aext(inode, epos, &cp_loc, &cp_len, 0);
+		err = udf_current_aext(inode, epos, &cp_loc, &cp_len, &cp_type, 0);
+		if (err < 0)
+			goto err_out;
 		cp_len |= ((uint32_t)cp_type) << 30;
 
 		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
@@ -2017,6 +2020,9 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	*epos = nepos;
 
 	return 0;
+err_out:
+	brelse(bh);
+	return err;
 }
 
 /*
@@ -2167,9 +2173,12 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 {
 	int8_t etype;
 	unsigned int indirections = 0;
+	int err = 0;
+
+	while ((err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
+		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+			break;
 
-	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
-	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 		udf_pblk_t block;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
@@ -2190,14 +2199,14 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		}
 	}
 
-	return etype;
+	return !err ? etype : -1;
 }
 
-int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
-			struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+int udf_current_aext(struct inode *inode, struct extent_position *epos,
+		     struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		     int inc)
 {
 	int alen;
-	int8_t etype;
 	uint8_t *ptr;
 	struct short_ad *sad;
 	struct long_ad *lad;
@@ -2224,8 +2233,8 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	case ICBTAG_FLAG_AD_SHORT:
 		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
 		if (!sad)
-			return -1;
-		etype = le32_to_cpu(sad->extLength) >> 30;
+			return -ENODATA;
+		*etype = le32_to_cpu(sad->extLength) >> 30;
 		eloc->logicalBlockNum = le32_to_cpu(sad->extPosition);
 		eloc->partitionReferenceNum =
 				iinfo->i_location.partitionReferenceNum;
@@ -2234,17 +2243,17 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	case ICBTAG_FLAG_AD_LONG:
 		lad = udf_get_filelongad(ptr, alen, &epos->offset, inc);
 		if (!lad)
-			return -1;
-		etype = le32_to_cpu(lad->extLength) >> 30;
+			return -ENODATA;
+		*etype = le32_to_cpu(lad->extLength) >> 30;
 		*eloc = lelb_to_cpu(lad->extLocation);
 		*elen = le32_to_cpu(lad->extLength) & UDF_EXTENT_LENGTH_MASK;
 		break;
 	default:
 		udf_debug("alloc_type = %u unsupported\n", iinfo->i_alloc_type);
-		return -1;
+		return -EINVAL;
 	}
 
-	return etype;
+	return 0;
 }
 
 static int udf_insert_aext(struct inode *inode, struct extent_position epos,
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index a686c10fd709..16db2613401d 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -188,6 +188,7 @@ int udf_truncate_extents(struct inode *inode)
 	loff_t byte_offset;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -217,8 +218,8 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		lenalloc -= sizeof(struct allocExtDesc);
 
-	while ((etype = udf_current_aext(inode, &epos, &eloc,
-					 &elen, 0)) != -1) {
+	while (!(err = udf_current_aext(inode, &epos, &eloc, &elen, &etype,
+					0))) {
 		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 			udf_write_aext(inode, &epos, &neloc, nelen, 0);
 			if (indirect_ext_len) {
@@ -253,6 +254,11 @@ int udf_truncate_extents(struct inode *inode)
 		}
 	}
 
+	if (UDF_EXT_ERR(err)) {
+		brelse(epos.bh);
+		return err;
+	}
+
 	if (indirect_ext_len) {
 		BUG_ON(!epos.bh);
 		udf_free_blocks(sb, NULL, &epos.block, 0, indirect_ext_len);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a466..a902652450dd 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -43,6 +43,9 @@ extern __printf(3, 4) void _udf_warn(struct super_block *sb,
 #define UDF_NAME_LEN		254
 #define UDF_NAME_LEN_CS0	255
 
+#define UDF_EXT_EOF(err)        ((err) == -ENODATA)
+#define UDF_EXT_ERR(err)        (((err) < 0) && (!UDF_EXT_EOF(err)))
+
 static inline size_t udf_file_entry_alloc_offset(struct inode *inode)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -171,8 +174,9 @@ extern void udf_write_aext(struct inode *, struct extent_position *,
 extern int8_t udf_delete_aext(struct inode *, struct extent_position);
 extern int8_t udf_next_aext(struct inode *, struct extent_position *,
 			    struct kernel_lb_addr *, uint32_t *, int);
-extern int8_t udf_current_aext(struct inode *, struct extent_position *,
-			       struct kernel_lb_addr *, uint32_t *, int);
+extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
+			    struct kernel_lb_addr *eloc, uint32_t *elen,
+			    int8_t *etype, int inc);
 extern void udf_update_extra_perms(struct inode *inode, umode_t mode);
 
 /* misc.c */
-- 
2.43.0


