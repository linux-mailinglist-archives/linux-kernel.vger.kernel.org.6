Return-Path: <linux-kernel+bounces-410331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BD9CDA04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA45F1F21E85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF218872A;
	Fri, 15 Nov 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OR1fsfO+"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183B537FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656804; cv=none; b=Eod9sFFsWhg6tKct+2aqnsddGEd+qqc6Iq6iqtOODd+0vPbPNq2HiB3uLxBDdaB7QmCqRjPm/c7RNXz2BxHUyYAdQIBLxwvjWegfEbaSlyWSGFs+0ZI7CiEFyFS+g6uZwGTyM6bvgDOc5GBLC9sbioxxlpW0qOnjoOVNCZnLy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656804; c=relaxed/simple;
	bh=jwRyJ0gTeE/nW7cLa60YtrJvyi2EbhJ/61+KBSicJz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cmd5gaJ1hBTCfNoMx4CvbsQiHkWvonqyN73bsVUTAEectLxmurv9DdC63JS9kuQEUPMAC9aDPeYXcCmE9NTuXvEZXsm3XfyCoHvcnTbglEX2t8AfoXTNQErRUmwrL4WxIA3SV1smz3qcEoJCu2LbvtWa2jtTGVGvGf+EdSnZ5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OR1fsfO+; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731656792; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=klSvFmmsqd9sENMEOR6smds4gtQMegD4wv7mVDkLMIg=;
	b=OR1fsfO+bemXp5b8h6Kme8lqnTaK//FUal7TgatA92F5ItSdElXyh3C7NoBV7GkbfMjZCN91Xs4stJVhNwqlQQQqoa4xMd3s9Web2UioDokfJd3uuLDCYWl9T583+4ZgIloywE0EtbGjv2HNEPpBbrVGVKZG/agFVRDu+tU6FpY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJSN0YK_1731656787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 15:46:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: clarify direct I/O support
Date: Fri, 15 Nov 2024 15:46:25 +0800
Message-ID: <20241115074625.2520728-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, only filesystems backed by block devices support direct I/O.

Also remove the unnecessary strict checks that can be supported with iomap.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c  | 15 +--------------
 fs/erofs/inode.c | 12 ++++++------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db4bde4c0852..bb9751f6dea8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -413,22 +413,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct block_device *bdev = inode->i_sb->s_bdev;
-		unsigned int blksize_mask;
-
-		if (bdev)
-			blksize_mask = bdev_logical_block_size(bdev) - 1;
-		else
-			blksize_mask = i_blocksize(inode) - 1;
-
-		if ((iocb->ki_pos | iov_iter_count(to) |
-		     iov_iter_alignment(to)) & blksize_mask)
-			return -EINVAL;
-
+	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, NULL, 0);
-	}
 	return filemap_read(iocb, to, 0);
 }
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index db29190656eb..d4b89407822a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -318,6 +318,7 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	bool compressed =
 		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
 
@@ -330,15 +331,14 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	/*
 	 * Return the DIO alignment restrictions if requested.
 	 *
-	 * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
-	 * compressed files, so in these cases we report no DIO support.
+	 * In EROFS, STATX_DIOALIGN is only supported in bdev-based mode
+	 * and uncompressed inodes, otherwise we report no DIO support.
 	 */
 	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
 		stat->result_mask |= STATX_DIOALIGN;
-		if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
-			stat->dio_mem_align =
-				bdev_logical_block_size(inode->i_sb->s_bdev);
-			stat->dio_offset_align = stat->dio_mem_align;
+		if (bdev && !compressed) {
+			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
 	}
 	generic_fillattr(idmap, request_mask, inode, stat);
-- 
2.43.5


