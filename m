Return-Path: <linux-kernel+bounces-310847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C309681F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED071B21BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B42187323;
	Mon,  2 Sep 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="dmTCNU95"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF30186E3C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265923; cv=none; b=iDgiPVedZHFdstYxMps4gQwW38eTaoAxNsRnVZOU6OHt5cghDckUVkVA/Ja406Y2Mpj+PhK+ghqqlauMyDzq4X8+ueYY27/O2zwNcRbRJQktPuEDzSg0yV1gwkeRYeA3FuDeVYEAd2UYJ7g6lFPKvFx/tmvzAyhCdLt2OdOJvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265923; c=relaxed/simple;
	bh=xnx2PRXMgDxbKZFEDeXCEeQ7X0yvH0Bb5aqn+u+vLEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMNDCitjlUiFJxeIVJ6yG+aX586gVnEqel8M8FHkOmZWNeiJeXeKZFJETWoIeJohcta15+Wv0hHRZa/nj92ZSC1ce3+B/7MoWL2WtzXQr/VjXnxQQ3vfQcG0Cvv3ozzoAbC5RQT2zv3JUVVNXyJlsv2nUoMZCetGc8XgFTT2kTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=dmTCNU95; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B0A569838;
	Mon,  2 Sep 2024 04:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265920; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QflOoS24gJjllSsBpAvZd6hkUmrfZHaYXPMALnugQBE=;
	b=dmTCNU95fKaOMqQFiVUgLJNx1MUHwrgEaErpsA6y6dBQsj82O3h69Bn4sp2rfwn21x4JyB
	I+f/SDwQtpyNfwvgvPU9S978k7B7kvuGbL/E3/S6F8sXMVAr+UsEtn1KmiLrmNda3TWlTR
	FRjmyAvWhfo1/SNz9Zi4sVIDI6B9QrquYrDqc/SmvKvGnnjKnTxOqrK6GpxcW5ifWG3S5U
	YccAVJmQcA3uaiJ710CF72+VyPcFhFZks6xf/c8hKl3v7kCSxyFPCgkgwDl6/G2+ArQ+ex
	rYvZKLLbTbVsLmZsoZ0s6/qBjMbz4t4n18qIYeAJder1NCTn5yL9vBHvzGNXOA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Date: Mon,  2 Sep 2024 16:31:47 +0800
Message-ID: <20240902083147.450558-3-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902083147.450558-1-toolmanp@tlmp.cc>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Refactor out the iop binding behavior out of the erofs_fill_symlink
and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
can only deal with inode operation bindings and can be decoupled from
metabuf operations. This results in better calling conventions.

Note that after this patch, we do not need erofs_buf and ofs as
parameters any more when calling erofs_read_inode as
all the data operations are now included in itself.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 127 +++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 66 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 40d3f4921d81..ae11af82e2ec 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,8 +8,33 @@
 
 #include <trace/events/erofs.h>
 
-static void *erofs_read_inode(struct erofs_buf *buf,
-			      struct inode *inode, unsigned int *ofs)
+static int erofs_fill_symlink(struct inode *inode, void *kaddr,
+			      unsigned int m_pofs)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	unsigned int bsz = i_blocksize(inode);
+
+	/* if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
+	    inode->i_size >= bsz || inode->i_size < 0) {
+		return 0;
+	}
+
+	m_pofs += vi->xattr_isize;
+	/* inline symlink data shouldn't cross block boundary */
+	if (m_pofs + inode->i_size > bsz) {
+		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
+			  vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+
+	return inode->i_link ? 0 : -ENOMEM;
+}
+
+static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -20,20 +45,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	unsigned int ifmt;
-	int err;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	unsigned int ifmt, ofs;
+	int err = 0;
 
 	blkaddr = erofs_blknr(sb, inode_loc);
-	*ofs = erofs_blkoff(sb, inode_loc);
+	ofs = erofs_blkoff(sb, inode_loc);
 
-	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
 			  vi->nid, PTR_ERR(kaddr));
-		return kaddr;
+		return PTR_ERR(kaddr);
 	}
 
-	dic = kaddr + *ofs;
+	dic = kaddr + ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 	if (ifmt & ~EROFS_I_ALL) {
 		erofs_err(sb, "unsupported i_format %u of nid %llu",
@@ -54,11 +80,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 		/* check if the extended inode acrosses block boundary */
-		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
-			*ofs += vi->inode_isize;
+		if (ofs + vi->inode_isize <= sb->s_blocksize) {
+			ofs += vi->inode_isize;
 			die = (struct erofs_inode_extended *)dic;
 		} else {
-			const unsigned int gotten = sb->s_blocksize - *ofs;
+			const unsigned int gotten = sb->s_blocksize - ofs;
 
 			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
 			if (!copied) {
@@ -66,16 +92,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
+			kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr + 1),
 						   EROFS_KMAP);
 			if (IS_ERR(kaddr)) {
 				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
 					  vi->nid, PTR_ERR(kaddr));
 				kfree(copied);
-				return kaddr;
+				return PTR_ERR(kaddr);
 			}
-			*ofs = vi->inode_isize - gotten;
-			memcpy((u8 *)copied + gotten, kaddr, *ofs);
+			ofs = vi->inode_isize - gotten;
+			memcpy((u8 *)copied + gotten, kaddr, ofs);
 			die = copied;
 		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
@@ -91,11 +117,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 		inode->i_size = le64_to_cpu(die->i_size);
 		kfree(copied);
-		copied = NULL;
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
-		*ofs += vi->inode_isize;
+		ofs += vi->inode_isize;
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
@@ -119,6 +144,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
+		if(S_ISLNK(inode->i_mode)) {
+			err = erofs_fill_symlink(inode, kaddr, ofs);
+			if (err)
+				goto err_out;
+		}
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		break;
 	case S_IFCHR:
@@ -165,59 +195,24 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
-	return kaddr;
 
 err_out:
-	DBG_BUGON(1);
-	kfree(copied);
-	erofs_put_metabuf(buf);
-	return ERR_PTR(err);
-}
-
-static int erofs_fill_symlink(struct inode *inode, void *kaddr,
-			      unsigned int m_pofs)
-{
-	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
-
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
-		inode->i_op = &erofs_symlink_iops;
-		return 0;
-	}
-
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-	
-	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
-	if (!inode->i_link)
-		return -ENOMEM;
-
-	inode->i_op = &erofs_fast_symlink_iops;
-	return 0;
+	DBG_BUGON(err);
+	erofs_put_metabuf(&buf);
+	return err;
 }
 
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
-	unsigned int ofs;
 	int err = 0;
 
 	trace_erofs_fill_inode(inode);
 
 	/* read inode base data from disk */
-	kaddr = erofs_read_inode(&buf, inode, &ofs);
-	if (IS_ERR(kaddr))
-		return PTR_ERR(kaddr);
+	err = erofs_read_inode(inode);
+	if (err)
+		return err;
 
 	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
@@ -234,9 +229,11 @@ static int erofs_fill_inode(struct inode *inode)
 		inode_nohighmem(inode);
 		break;
 	case S_IFLNK:
-		err = erofs_fill_symlink(inode, kaddr, ofs);
-		if (err)
-			goto out_unlock;
+		if (inode->i_link)
+			inode->i_op = &erofs_fast_symlink_iops;
+		else
+			inode->i_op = &erofs_symlink_iops;
+
 		inode_nohighmem(inode);
 		break;
 	case S_IFCHR:
@@ -245,10 +242,9 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFSOCK:
 		inode->i_op = &erofs_generic_iops;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
-		goto out_unlock;
+		return 0;
 	default:
-		err = -EFSCORRUPTED;
-		goto out_unlock;
+		return -EFSCORRUPTED;
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
@@ -268,8 +264,7 @@ static int erofs_fill_inode(struct inode *inode)
 			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 #endif
 	}
-out_unlock:
-	erofs_put_metabuf(&buf);
+
 	return err;
 }
 
-- 
2.46.0


