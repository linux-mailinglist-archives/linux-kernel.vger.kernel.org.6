Return-Path: <linux-kernel+bounces-553897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3BA59061
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652A63AD79C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A27225793;
	Mon, 10 Mar 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TkpyQdT/"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A67225771
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600519; cv=none; b=K7GVnvGBkcbny3fb9ZsK2E1sIOD8z12MD40MTGfTo957PjKF3mZo/A6c4Fi7WRp1BlYyQrauGLqs2kU5EVtF2l8hE1v4LpXonamfLBAn38Z8YsxoOizctbkgkH16k8C2cPnaVvm2V1cbB5uR0WlubvFTiR5yt+oW7gqv93EiR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600519; c=relaxed/simple;
	bh=2LZRQgJepG5MTqai5nqPWj80Uh21MZ5qVNIFCnF62SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ8u5bhOgQ5lfBYslRV5VOIphfbgqTRx+NJbMcjd09Bk6njcvrPJRQfI+mAPF/XOmYQM3pBbKoLWUjv9cW8ztmJ6JcHtS05AMjZfKZ/2loEjUxlu+920fBXk2LuraWhDXts8lHdlaQWUV9tIFjM2Bi9trJaCEJUaovk1dxNje90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TkpyQdT/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600506; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XkR7fIg1S/Lk9bWN6A3/iG9/WpYW4a9EMWzI9Z0Fxtk=;
	b=TkpyQdT/9mlpH1L58bPYAzaR8TEBplmCqGiuB10AZwatrz+JPZaGxQ7p0zHkgfAZlj/zliq/v/M3gCqGI+XChBkh92r9WrnjYWTtmHfAwjGVkJTiTLJcN7PdUSr7c23Qdy8Q4i8uUU98QMXdEYONLb3m996lzZqFw0WJEr04aPA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3xk_1741600505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 02/10] erofs: simplify erofs_{read,fill}_inode()
Date: Mon, 10 Mar 2025 17:54:52 +0800
Message-ID: <20250310095459.2620647-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Switch to on-stack `copied` since it's just 64 bytes;

 - Get rid of `nblks` and derive `i_blocks` directly;

 - Use `inode_set_mtime()` instead of `inode_set_ctime()`
   to follow the ondisk naming;

 - Rearrange the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 92 ++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 57 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4936bd43c438..c8ede541c239 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -27,29 +27,27 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode));
+	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
-	const erofs_off_t inode_loc = erofs_iloc(inode);
-	erofs_blk_t blkaddr, nblks = 0;
-	void *kaddr;
+	struct erofs_inode_extended *die, copied;
 	struct erofs_inode_compact *dic;
-	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int ifmt, ofs;
+	unsigned int ifmt;
+	void *ptr;
 	int err = 0;
 
-	blkaddr = erofs_blknr(sb, inode_loc);
-	ofs = erofs_blkoff(sb, inode_loc);
-
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
-	if (IS_ERR(kaddr)) {
-		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
-			  vi->nid, PTR_ERR(kaddr));
-		return PTR_ERR(kaddr);
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
+	if (IS_ERR(ptr)) {
+		err = PTR_ERR(ptr);
+		erofs_err(sb, "failed to get inode (nid: %llu) page, err %d",
+			  vi->nid, err);
+		goto err_out;
 	}
 
-	dic = kaddr + ofs;
+	dic = ptr + ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 	if (ifmt & ~EROFS_I_ALL) {
 		erofs_err(sb, "unsupported i_format %u of nid %llu",
@@ -76,23 +74,18 @@ static int erofs_read_inode(struct inode *inode)
 		} else {
 			const unsigned int gotten = sb->s_blocksize - ofs;
 
-			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
-			if (!copied) {
-				err = -ENOMEM;
-				goto err_out;
-			}
-			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(&buf, sb,
+			memcpy(&copied, dic, gotten);
+			ptr = erofs_read_metabuf(&buf, sb,
 					erofs_pos(sb, blkaddr + 1), true);
-			if (IS_ERR(kaddr)) {
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
-					  vi->nid, PTR_ERR(kaddr));
-				kfree(copied);
-				return PTR_ERR(kaddr);
+			if (IS_ERR(ptr)) {
+				err = PTR_ERR(ptr);
+				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %d",
+					  vi->nid, err);
+				goto err_out;
 			}
 			ofs = vi->inode_isize - gotten;
-			memcpy((u8 *)copied + gotten, kaddr, ofs);
-			die = copied;
+			memcpy((u8 *)&copied + gotten, ptr, ofs);
+			die = &copied;
 		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 
@@ -101,12 +94,10 @@ static int erofs_read_inode(struct inode *inode)
 		i_uid_write(inode, le32_to_cpu(die->i_uid));
 		i_gid_write(inode, le32_to_cpu(die->i_gid));
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
-		/* each extended inode has its own timestamp */
-		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
+		inode_set_mtime(inode, le64_to_cpu(die->i_mtime),
 				le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
-		kfree(copied);
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
@@ -118,8 +109,7 @@ static int erofs_read_inode(struct inode *inode)
 		i_uid_write(inode, le16_to_cpu(dic->i_uid));
 		i_gid_write(inode, le16_to_cpu(dic->i_gid));
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
-		/* use build time for compact inodes */
-		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
+		inode_set_mtime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		break;
@@ -141,7 +131,7 @@ static int erofs_read_inode(struct inode *inode)
 	case S_IFLNK:
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		if(S_ISLNK(inode->i_mode)) {
-			err = erofs_fill_symlink(inode, kaddr, ofs);
+			err = erofs_fill_symlink(inode, ptr, ofs);
 			if (err)
 				goto err_out;
 		}
@@ -161,10 +151,13 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 
-	/* total blocks for compressed files */
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		nblks = le32_to_cpu(iu.compressed_blocks);
-	} else if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		inode->i_blocks = le32_to_cpu(iu.compressed_blocks) <<
+					(sb->s_blocksize_bits - 9);
+	else
+		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
+
+	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
 		/* fill chunked inode summary info */
 		vi->chunkformat = le16_to_cpu(iu.c.format);
 		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
@@ -176,22 +169,15 @@ static int erofs_read_inode(struct inode *inode)
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
+	inode_set_atime_to_ts(inode,
+			      inode_set_ctime_to_ts(inode, inode_get_mtime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
 	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
 	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
-
-	if (!nblks)
-		/* measure inode.i_blocks as generic filesystems */
-		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
-	else
-		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
 err_out:
-	DBG_BUGON(err);
 	erofs_put_metabuf(&buf);
 	return err;
 }
@@ -202,13 +188,10 @@ static int erofs_fill_inode(struct inode *inode)
 	int err;
 
 	trace_erofs_fill_inode(inode);
-
-	/* read inode base data from disk */
 	err = erofs_read_inode(inode);
 	if (err)
 		return err;
 
-	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
@@ -229,15 +212,10 @@ static int erofs_fill_inode(struct inode *inode)
 			inode->i_op = &erofs_symlink_iops;
 		inode_nohighmem(inode);
 		break;
-	case S_IFCHR:
-	case S_IFBLK:
-	case S_IFIFO:
-	case S_IFSOCK:
+	default:
 		inode->i_op = &erofs_generic_iops;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 		return 0;
-	default:
-		return -EFSCORRUPTED;
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-- 
2.43.5


