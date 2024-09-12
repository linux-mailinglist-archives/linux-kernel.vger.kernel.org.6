Return-Path: <linux-kernel+bounces-326194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30F9764B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262E91F24830
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CA18E043;
	Thu, 12 Sep 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R3SENIc9"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D118DF7E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130150; cv=none; b=FA2qmk0182rWnxDYIu9SWin+ulmua5LubVdoKdsJEK22QXpuY2XLVryWUnZCIFubZrIdS6ATSgeI96ocHbEyb+qFuY0YmHwRImgrp+j2T7jpTUUqLYaSNMKjLzFB257LGEr4T/NUsfJvadRrliVW43+xEhmo5FIHgC0h9vE7UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130150; c=relaxed/simple;
	bh=ZEx96hX+IVzX9eBls9qnYMt3qL509Yd9oe3lmkexG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqvcq4g1LH6Azd0tKVfVSXTqjFfOisuxKpX2xwjg1L2LyerHvn0OldRAvWvIb1DQHjiIWAhQ3f3ohrOYO6oj0ms4i5yIGjrR00Ypd9gH1hLsyr96+TcQMj0zscmTfnmWNU4H0dFymBZFlylRedCOcUyW0d+v2jpvGIWIWNbwNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R3SENIc9; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726130144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OQSX4JcrAXPvNnaJnPYb8rHWwXAA63xuZRYJXlbO310=;
	b=R3SENIc9+mbguhn5LeapFRB5/yQ9JAjUaKf6Sc+30RsmWSrYJpArBS4ejHNUTC1xLD+4+JmUEheqFqnHE5wqkatt3Hn7cvTJdLCo13mvn8sTejnt3DzDCWRzNjexTgsRa1GzACPBJUAk/1ydDHS7ynH9UziMDz+eGuiN+M2Tbgs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEqlyhG_1726130140)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 16:35:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: reject inodes with negative i_size
Date: Thu, 12 Sep 2024 16:35:38 +0800
Message-ID: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Negative i_size is never supported, although crafted images with inodes
having negative i_size will not lead to security issues in our current
codebase:

The following image can verify this (gzip+base64 encoded):

H4sICCmk4mYAA3Rlc3QuaW1nAGNgGAWjYBSMVPDo4dcH3jP2aTED2TwMKgxMUHHNJY/SQDQX
LxcDIw3tZwXit44MDNpQ/n8gQJZ/vxjijosPuSyZ0DUDgQqcZoKzVYFsDShbHeh6PT29ktTi
Eqz2g/y2pBFiLxDMh4lhs5+W4TAKRsEoGAWjYBSMglEwCkYBPQAAS2DbowAQAAA=

Mark as bad inodes for such corrupted inodes explicitly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7a98df664814..db29190656eb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
-
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
@@ -16,7 +15,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 
 	m_pofs += vi->xattr_isize;
 	/* check if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
 	    check_add_overflow(m_pofs, inode->i_size, &off) ||
 	    off > i_blocksize(inode))
 		return 0;
@@ -131,6 +130,11 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 
+	if (unlikely(inode->i_size < 0)) {
+		erofs_err(sb, "negative i_size @ nid %llu", vi->nid);
+		err = -EFSCORRUPTED;
+		goto err_out;
+	}
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 	case S_IFDIR:
@@ -186,7 +190,6 @@ static int erofs_read_inode(struct inode *inode)
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
-
 err_out:
 	DBG_BUGON(err);
 	erofs_put_metabuf(&buf);
-- 
2.43.5


