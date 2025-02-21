Return-Path: <linux-kernel+bounces-525517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F10A3F0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB769701ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A4204C13;
	Fri, 21 Feb 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VHujdgUa"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F0204691
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130874; cv=none; b=Mt6b3BnEbVtHRHF2upxIZ12j4FP3BKrA2zpCLpEVc6Aa6rGHTxdYoNCUP48Nmd/9wdMDslThK1F1WZ0uvnDRz56D6VC7Z2QMBHkikEZeFupDRO6H+93V0XTE1l+h/H5XHKATCXlLJZpEa9LEDCdKk7/2EDSSwei/+qioPo0OJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130874; c=relaxed/simple;
	bh=Z4gSATjDv+lcwqTbelOzKBbrCrbG/Kse5oPqtpGwrxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNAy+CnvmDIKTTwLKCfYdP8E5wQa669rJpM2wRWHAWOyg14XvqNaSI7+48F8thFdLy5CtfS22noNN/v+RdDZMQJXdIB2zmF7d/n6s4rNeWABjyCkuXmFdHwu48FoCvUF00QvAQxkFiP7XFDhmBzHYNGUwoupTBfscBLpdHDkXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VHujdgUa; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740130861; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TfkidDMxPMlQA/XL/XYnY8kMut3kWfLopLNxuBD/amA=;
	b=VHujdgUaDz08uGHPKssMR84kp/+rHnjWZKjT5aqtJ2Q4K9gXtbw6+ynLdfdXyHYr045u/ZNwpJcBQgYWvmx66FoaGZpwh+o0szE/0GBSTkjawyyhlQREbSDbrt7lNritlu2vvHnwRuZhpJRfEgTHMVpsG82JVxQMjidNcfqLbRY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPvxQPd_1740130856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 17:41:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: clean up header parsing for ztailpacking and fragments
Date: Fri, 21 Feb 2025 17:40:55 +0800
Message-ID: <20250221094055.4014984-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the logic in z_erofs_fill_inode_lazy() by combining the
handling of ztailpacking and fragments, as they are mutually exclusive.

Note that `h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT` is handled
above, so no need to duplicate the check.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a0c1c6450a55..bdac20800ded 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,7 +394,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
@@ -439,7 +440,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
+			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -455,7 +456,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
@@ -474,10 +475,17 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+		if (!map->m_plen ||
+		    erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map->m_plen);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
+		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto unmap_out;
@@ -496,7 +504,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
 				  afmt, vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -593,33 +601,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map.m_plen);
-			err = -EFSCORRUPTED;
-		}
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+	if (vi->z_advise & (Z_EROFS_ADVISE_INLINE_PCLUSTER |
+			    Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+			vi->z_idata_size = le16_to_cpu(h->h_idata_size);
+		else
+			vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.43.5


