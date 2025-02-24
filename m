Return-Path: <linux-kernel+bounces-529058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03ACA41F68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7646170EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D023BCE2;
	Mon, 24 Feb 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fq+61RY9"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA16221F26
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400685; cv=none; b=ovej8/MhUK7cy+z3P2QzY8tXQJairFBmg614De6+4BIsVxJD085zTP2bb7TvxqteMFyBob406pdwsiBQC5T4vX6KyGtuOJjgblZI0jx5zvhHtWlCyBFkAfRsnksJnMIm6e2/JdqQUp3GPjDG7tXJi923RB/wvlmVmWb+zrWN9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400685; c=relaxed/simple;
	bh=53CFcVm5axX55nnqjVFwo0ziiMGGQBv6RhfpvU2q4h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGUZS6u0XY5nEvjMmpnTBiY6cXtEB6pkCbUFfiNRTPT4aliGMaXsKR6XO7ur9n31g/0o9kcT0JSc40SohEBiWbRUkproqhecVhDIAn0NLgEqxSHdzumQQQXewUs23idsfYMZItzhDOKdubPKsxAUNYSv5S50n7JkNVZYZ7vRnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fq+61RY9; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740400673; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kmX+/KBPQc3cQhROjOMmtM1SZ96Zp/Yb5gAWSXOJdx8=;
	b=fq+61RY97GLDlXZO3f2wnNghrG9ewNw3KUoX4+08PCk0E9IeSnndoAi6OGNgxTB8Me1efv5Hlc+/yjEzGO7NEMSClpY6/0uqzy5wmht7ocjX125euVMfV0Vvsd9s59NkVwzDo77RSO15hQtqsmHhw/QgaT0Zi3GzV3IAf6ym1ps=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQ7ms9G_1740400668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 20:37:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/2] erofs: simplify tail inline pcluster handling
Date: Mon, 24 Feb 2025 20:37:46 +0800
Message-ID: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline
support") introduced the flag `Z_EROFS_ADVISE_INLINE_PCLUSTER`, which is
redundant because `h_idata_size != 0` serves the same purpose.

Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
features are mutually exclusive for a given inode.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
new patch.

 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zmap.c     | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f955793146f4..afce4b03f586 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -265,13 +265,8 @@ struct erofs_inode {
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
index a0c1c6450a55..9518d341cd82 100644
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
+	else
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
-- 
2.43.5


