Return-Path: <linux-kernel+bounces-332476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA48897BA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A09E281227
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A617A5BC;
	Wed, 18 Sep 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PQ4300hq"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEB178377
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652523; cv=none; b=aa04X6i8mQs0azXwWYxLNtRMGDERVSrJo/JGDt6y3U91G9/VZkU1jmacHlk/Fp1WGHm5hA8S0KospRJHioc6M2NJzzq9XdP1AAH/06vitklpKSzz4wCIKOS9bZf46qy2wxtSYBitOObSjEQ0bybuakD0c9arl0iq9UJm8lq/qqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652523; c=relaxed/simple;
	bh=VQ/Y0teW8Qsj0SVJ/e7JuI4FUHMS3eQMkCqkSVzSkiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1C5vhNkViXgrJIdHKctpBkVDQJRZYrLKWGxV+/VFO0NOaiWwyPopXrSDvJ8syz+H+g3PSUyiajKCjdW+fYWVI5tgsLwpLVMr+a/cf01zJRPJUGqNoTQmw9kz27+hI3aXfNkQdkoAhYkj6b7Id3/K9fSYeqYaDDMEmqn8OQCubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PQ4300hq; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=3oMAn
	UeqM5iB/KTwRi2tsIgbHERfZiSx6XRy1OEUILE=; b=PQ4300hqcCupb/eVEps3A
	KTtbI4WhQKgK1YuaanNoVrl9zApbQyuICRuvpWttQuxQB6HcNDpfT+iHmuWqWl9u
	0aXO8IQPVbTRPgjxLpk+rlXCOMsyPcnfFchA2IjywYNGfeM6jAJPqoW6YfSlXJ1Y
	7DWFxr1ElWokJejqgn1vJM=
Received: from localhost.localdomain (unknown [1.198.30.207])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLyAsn+pm2TCHAA--.46011S3;
	Wed, 18 Sep 2024 17:36:46 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] udf: refactor udf_current_aext() to handle error
Date: Wed, 18 Sep 2024 17:36:32 +0800
Message-ID: <20240918093634.12906-2-zhaomzhao@126.com>
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
X-CM-TRANSID:_____wDnLyAsn+pm2TCHAA--.46011S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr13Ar15tw48Jry3Ww43GFg_yoW7Ww45pF
	W2k3sFkw43XrWxur4IqF4DZ3Waqa93Gr4UGr12q34ftF409r15t3WUtr4I9FyUKrs5Ww42
	vrs8tryq9w42y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8xhLUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimh1ed2bqixWx0QADsf

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

As Jan suggested in links below, refactor udf_current_aext() to
differentiate between error and "hit EOF", it now takes pointer to etype
to store the extent type, return 0 when get etype success; return -ENODATA
when hit EOF; return -EINVAL when i_alloc_type invalid.

Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 fs/udf/inode.c    | 37 +++++++++++++++++++++++--------------
 fs/udf/truncate.c |  3 +--
 fs/udf/udfdecl.h  |  5 +++--
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..6d41ca0e7dba 100644
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
+	brelse(epos->bh);
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
+	return err;
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
index a686c10fd709..91b6e2698e7e 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -217,8 +217,7 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		lenalloc -= sizeof(struct allocExtDesc);
 
-	while ((etype = udf_current_aext(inode, &epos, &eloc,
-					 &elen, 0)) != -1) {
+	while (!udf_current_aext(inode, &epos, &eloc, &elen, &etype, 0)) {
 		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 			udf_write_aext(inode, &epos, &neloc, nelen, 0);
 			if (indirect_ext_len) {
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a466..d893db95ac70 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -171,8 +171,9 @@ extern void udf_write_aext(struct inode *, struct extent_position *,
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


