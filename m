Return-Path: <linux-kernel+bounces-360208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577C9995E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9B41F246C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB51E3DE6;
	Thu, 10 Oct 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QEsvtV2m"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728126AC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604729; cv=none; b=FJIpm15HxYYeEA/C/RQdzUK8fXsxCXfW9QRHjvmlnstxDuuxdW3TfmySVvq/gasij5t5otIV0RlKK2W7HQLuDNnMIjszbNnzwRideTV83RVoamX/z6UuQjbcAfpRkJcT6x0ZzBOLxDVDHlF6Wct0FIrfTTnDvVFkSR1YCfV8MfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604729; c=relaxed/simple;
	bh=67V5K0LbtQteYuuVLCGG4b8mJeFia1qpUwRglEJXnPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nklzlGyACcB4k8NVAtcMyE9sClGcM7nvKRNUrVA/uCPPwPkdCnZY4gbXu4+9G6PTd6NKahAOLh6s6Cqu3rQypr/n46YRG0hj8vwOeAL/razXQYLOo904hga1nlXqfqBY1WSH8iZnOp8WIo1NEJM+XLQ4E8mJMGfeCxzBbPpFknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QEsvtV2m; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728604718; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zbXq5dUZg+8cBo6+/cLm+yRxdzIzOWWwebxq2zDBn0Q=;
	b=QEsvtV2mT1DJpvvu7nBlFQ6LspOZZKcsUc6H4Fdii7Hu2FFXygEucOHQLGJs135HlF98MA/eM+ijeQIdLQzocK2wljLWNfoVHqkr0p/1pccQfaA/1xleK48B6aMPAcQuh+46EqJ+W4d3N3M2DW+A5EtU24SpW6Ac/LIwVPj5WWY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGnpNaL_1728604712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 07:58:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: get rid of kaddr in `struct z_erofs_maprecorder`
Date: Fri, 11 Oct 2024 07:58:30 +0800
Message-ID: <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
References: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
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
change since v1:
 - shouldn't move `m->lcn` downwards since `lcn` has been changed.

 fs/erofs/zmap.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e980e29873a5..37516d7ea811 100644
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
@@ -255,10 +251,6 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.43.5


