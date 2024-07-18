Return-Path: <linux-kernel+bounces-256153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF379349F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15F51C21D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D97D071;
	Thu, 18 Jul 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LAqiCaYZ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF43B784
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291574; cv=none; b=hWqx+HbwuzlYGNS4rEiLp1RK3VA5Y7eeXF3qZYtY09QzTvLRr+m2ZFNYqb4Rja7WST+CJWb4+735TkiLTo3eZZqMytwF5ZtPAPtRW3FqJfksWz1ApHnO+PG0CuSCuZUe8HB9jlL9QlejL2Mqc1PYfv60RXMdIpqIcwQmfWbxPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291574; c=relaxed/simple;
	bh=O8LpXEZx1J4u1g7+jYqUcspym9TFaj44Xe3WJ9QoSZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dADjjEfonyZLI4br0el6TULzxwr++gyzjAqIw/pu5eOcBMw1Gi3Rnb5ikUJ3HmHu6LUPVI0gqZua8rQvK3I3gERRzy2SHkoF4r7TScocTlJFBmM0/u9UDuWk0KyZZOS3glBv7hzpdbvN5L5hlH6ZumL/VYwvTHJi+GQKRD9sehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LAqiCaYZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721291569; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yeE4Ova5Bd1gXPT3NGRB3DgKWcltl+BFY40NsxJzq/A=;
	b=LAqiCaYZtmetJPDOHAleokNFjnxiiGl2mY4R1eixGjRbkRuqSut3Fg0vulZnvWjHg7xgig/LSsSOdvAaEatCqSc5yNrOohiDQAUGJBJYMzejumHADAmDnJIY7rLw1qsOQMQOOR2paoh/Mp4FcLL5BeIll20jKwmCWSojWJc4aAg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WAns83J_1721291564;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAns83J_1721291564)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 16:32:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs: support STATX_DIOALIGN
Date: Thu, 18 Jul 2024 16:32:43 +0800
Message-ID: <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240718063756.2982763-1-lihongbo22@huawei.com>
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>

Add support for STATX_DIOALIGN to erofs, so that direct I/O
alignment restrictions are exposed to userspace in a generic
way.

[Before]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:0
dio offset align:0
```

[After]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:512
dio offset align:512
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Hongbo,

I tidy up the patch a bit according to the current codebase,
I will apply this later for this cycle.

Also r-v-bs are always welcome...

Thanks,
Gao Xiang

 fs/erofs/inode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..43c09aae2afc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -334,14 +334,29 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
+	bool compressed =
+		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
 
-	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
+	if (compressed)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
-
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
+	/*
+	 * Return the DIO alignment restrictions if requested.
+	 *
+	 * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
+	 * compressed files, so in these cases we report no DIO support.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
+			stat->dio_mem_align =
+				bdev_logical_block_size(inode->i_sb->s_bdev);
+			stat->dio_offset_align = stat->dio_mem_align;
+		}
+	}
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
-- 
2.43.5


