Return-Path: <linux-kernel+bounces-320544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D5970BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E60FB20E25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98521400A;
	Mon,  9 Sep 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i8Wxu5kn"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7851BC39
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848909; cv=none; b=P2MzTTrT1R+LUmt2n+9gtgIOGKJo8a4BbDaXfBDUQgzbvbtqE7fYBR8gra0dsMaZr7d0q0LZwd172TBIsbnBxdMMblULHEQGpJBVsFOhaMRSdpiiFN76XTCvErjpzoDtwYEyp0Hgyb5pdwnEPqMmaW4lyjYdBcILJmkhj7XkonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848909; c=relaxed/simple;
	bh=dun+b2tS5UwAEUb40fqwlBXAf1LnpOHyiv6gVwM9iWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ef6saiLmRcnCqnkrsOT/80CJ48N5IjYnY/F02g41+z0RTrEVmebLz2KhSFZ0oNnd7uwMGYciG7NF4mIAhTyKGhLNheQS6FggBXMrBk5FclWD8EpkV6sFj3uBO3Ihc0WRsH/hZrdEqjDwQGANYvvVQWhSPxZZPfsjYnLlY7O2yPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i8Wxu5kn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725848897; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=m889utn8QsE6CPyNbFisRS2RlR4XYhZBEbtQrDwaS0s=;
	b=i8Wxu5knzb2rwxmCv09Q55C07/1YaRtreJ9toPMSw/7m9VjNylYDFVRjfFydqSp5HmyVFr3OBARTZwOfILrWvZWZu6MzhwPwH0+dvY50PbbyXvZg8l9mPSObkrgvmE6KS5jTzVOE19r9zPQhxiGkEyPkm9BZUkMiGZbAYrpTFyc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEVwP4i_1725848893)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 10:28:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Colin Walters <walters@verbum.org>
Subject: [PATCH] erofs: fix incorrect symlink detection in fast symlink
Date: Mon,  9 Sep 2024 10:28:11 +0800
Message-ID: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fast symlink can be used if the on-disk symlink data is stored
in the same block as the on-disk inode, so we don’t need to trigger
another I/O for symlink data.  However, correctly fs correction could be
reported _incorrectly_ if inode xattrs are too large.

In fact, these should be valid images although they cannot be handled as
fast symlinks.

Many thanks to Colin for reporting this!

Reported-by: Colin Walters <walters@verbum.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..79a29841ae1c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -178,12 +178,13 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow(m_pofs + vi->xattr_isize, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -192,16 +193,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
 	memcpy(lnk, kaddr + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
-- 
2.43.5


