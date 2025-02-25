Return-Path: <linux-kernel+bounces-531238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85550A43DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E239119C61CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B713267B95;
	Tue, 25 Feb 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BLRwzqVs"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73D267B68
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483651; cv=none; b=nTZfPl8ghvy6EID3/XZFUecg0+B+MTEvxt6dbOMwL9J66avomMQ//HZ4XRjtnLPufUCsav/Ta7+LC/NMa12yImepGaoAXCjXf1eqQRFUEzNNfN0ZC5qXlJN7KmyYPw6Qmc29WgG2uzncvS1LZXT/pbRedqSOzR1W6lv9uXqn5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483651; c=relaxed/simple;
	bh=6AOMWyYHwhOoyM3jkg8YvJSXZhcpS3YlYGNMshb9yVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2ofnXzi39NEMLI6isQgHWlGlV7FPUTukXV+YVAf/UqMvNLR8lbZ42vKFtDghJu+GLTIBCCKIEcgiL5EmIMAo/ff6tL19BilQneA9cJXOYZpwX04xzf+BbuH9UMnHB+QleHcUlyICBenZ+l39u/e+yNS9YTOuP9/CDFRd1TJ/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BLRwzqVs; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740483643; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7gz1sWlPL/imZ77uyvUW1lHoH0Aq1FR0LZkvlkecKL0=;
	b=BLRwzqVsupd8QZIw0UoymbcrePf1lAnE780vfLaWzKGFDkHdl9zYWao2VsIaJytzt7zj+k1d4RWQ2ouNDOPsjDnrPx2QnwJOGuaqx2YDuynxw1oYxhiSP6IY/8MkfNeGzIqKnTKUq9VCY7cR+VV5/uLe9B2E362WJzEtdbUxZAg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQEf9J3_1740483638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 19:40:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs: simplify tail inline pcluster handling
Date: Tue, 25 Feb 2025 19:40:38 +0800
Message-ID: <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
References: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `z_idata_size != 0` to indicate that ztailpacking is enabled.
`Z_EROFS_ADVISE_INLINE_PCLUSTER` cannot be ignored, as `h_idata_size`
could be non-zero prior to erofs-utils 1.6 [1].

Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
features are mutually exclusive for a given inode.

[1] https://git.kernel.org/xiang/erofs-utils/c/547bea3cb71a
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v2:
 - should not ignore `Z_EROFS_ADVISE_INLINE_PCLUSTER` as mentioned in
   the new commit message.

 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zmap.c     | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b452b6557aa5..b357cbbce764 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -263,13 +263,8 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			union {
-				struct {
-					erofs_off_t    z_idataoff;
-					unsigned short z_idata_size;
-				};
-				erofs_off_t z_fragmentoff;
-			};
+			erofs_off_t    z_fragmentoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a0c1c6450a55..ba4533eabc6a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -395,8 +395,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -415,9 +415,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -472,7 +471,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
@@ -565,6 +564,10 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -593,18 +596,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+	if (vi->z_idata_size) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
+		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
 			erofs_err(sb, "invalid tail-packing pclustersize %llu",
 				  map.m_plen);
 			err = -EFSCORRUPTED;
@@ -619,7 +620,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.43.5


