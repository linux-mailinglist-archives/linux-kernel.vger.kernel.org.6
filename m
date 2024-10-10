Return-Path: <linux-kernel+bounces-358611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59B998193
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E82B1C21427
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC291C3F00;
	Thu, 10 Oct 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S1RiBeI2"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB91BD51F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551088; cv=none; b=SaCbIGray7uN1cbr/RrorhMobJZhec7Cx7lL4AfQ0ITeDOvndFtlBi7qCA4ZTt8WJZ5Acgo2J5+hdneQmna2WKBU4XMe+cM2OXd5bZdqwa1nO7SzwiA78rtUz5JM9OWJzSBrKnIQ5GznDWSocv2HSM4cPhz+97X3VWrR+Vy8bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551088; c=relaxed/simple;
	bh=9BemIHVkwFnZXsrs4ApAwKmSNWzb/ytWkzgUD5HrqEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZRuhnfZn759/TVuYVGZIsXyjjTrm45wqC530BLy04tQS8UdBJSXCUIwD7NXs3/qV9+dD0LbDicp/t25whWI33lmFLVMH5PR5bpkZ0tcyjOA1OZ0tcD/6esYVmng85qqwn+8aUm+OFQK7JV/sY+1v8gYwgp6PGo9q7V1NVg4nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S1RiBeI2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728551084; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rY5VPsaO1H3ZA4xnMlRJLB6Hi8aGa4Y6EA1p+XeRCfQ=;
	b=S1RiBeI2SV83b5bMxy+NAISBV+VyenWo78jHBore8kH49Yeq1564lfF0oH7sHUQCi+M/gmG5YhZXVh4T9ahcq1J9HY1cqJsXFXEGzIa3XVvIaRKzmWDV3+us3Xxj2pgiVn22JGW4T0Mch7Rg47F7JI3yuIo0q16u8a+MjWKUenQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGlkE6t_1728551079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:04:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: get rid of kaddr in `struct z_erofs_maprecorder`
Date: Thu, 10 Oct 2024 17:04:20 +0800
Message-ID: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
References: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`kaddr` becomes useless after switching to metabuf.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e980e29873a5..d329a38de1b9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -10,8 +10,6 @@
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-	void *kaddr;
-
 	unsigned long lcn;
 	/* compression extent information gathered */
 	u8  type, headtype;
@@ -33,14 +31,11 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
-
-	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(di))
+		return PTR_ERR(di);
 	m->lcn = lcn;
-	di = m->kaddr;
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
@@ -53,8 +48,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = m->delta[0] &
-				~Z_EROFS_LI_D0_CBLKCNT;
+			m->compressedblks = m->delta[0] & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
@@ -110,9 +104,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	int i;
-	u8 *in, type;
 	bool big_pcluster;
+	u8 *in, type;
+	int i;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
@@ -121,6 +115,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(in))
+		return PTR_ERR(in);
+
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
@@ -128,9 +126,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
-
-	in = m->kaddr - bytes;
-
+	in -= bytes;
 	i = bytes >> amortizedshift;
 
 	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
@@ -226,7 +222,6 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	if (lcn >= totalidx)
 		return -EINVAL;
 
-	m->lcn = lcn;
 	/* used to align to 32-byte (compacted_2b) alignment */
 	compacted_4b_initial = (32 - ebase % 32) / 4;
 	if (compacted_4b_initial == 32 / 4)
@@ -254,11 +249,8 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	lcn -= compacted_2b;
 	amortizedshift = 2;
 out:
+	m->lcn = lcn;
 	pos += lcn * (1 << amortizedshift);
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.43.5


