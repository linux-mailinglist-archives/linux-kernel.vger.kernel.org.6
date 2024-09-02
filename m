Return-Path: <linux-kernel+bounces-310846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29DD9681F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605A5282DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9E186E46;
	Mon,  2 Sep 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="OOZ72e7c"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD84186E32
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265920; cv=none; b=RJ1WYkeEm3e4ly+J/R10pLXPoWHJUi4iba7tFqgiIwSlsjIxzeaNlHTy7nc9+iOkc6kt6B32/FSmJDas9kSulityPhAzqKAsENpBGnRX8P+7BWnQWV13oI/u5nKH9QyvX1fGnKMCS+FJFlta5IQf2x4wcFGuta9nolLA0nVeqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265920; c=relaxed/simple;
	bh=ow+4SDCxIVP7wXCPLjVIbOF8vjB9uJiyQMv5eVxiyUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb60/EMC+WVfFCpZWUqc/D9YbYBgz4l6RWTrQZMP+eChe5Q44rz+ey+myUxiclJ5GMJmGw9o5PuN2kIBsL/XWDbIAnputrv2W4ilrqQ7mWUS0piE/eUq+kDEwg8uodMpHYAZ0D0H/pz0xzAYN0t0Yw04hKT5gVwye3TlGnckpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=OOZ72e7c; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9073B69905;
	Mon,  2 Sep 2024 04:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265917; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	b=OOZ72e7cFDgwNfu4uNlpwiwQk4L75e6RvGKd5aCs2xXjaT9NU87UatWDF/mP8ZjeW1pHTx
	uycGp4OYNBlwKPei4zbrqatgDFu2o+hf13Yk3J6s+8s92Gs9r5Hvo9DRec5t27SoUqZVZx
	MSq8HBLFqwSGhD+ZFMf1HqTBGXpEjTh+hZiKFz8+MyKGe4FkmiikSW58fbwS3DsblI2+eO
	l1vpLdBJUame8RmM777lJCgexC9XG/xbQ526iuCBXY7Pvjklm3rqY1Jq8aGLw8GSbrTaFP
	SSTOGVYcx+LjD+BG60M2Q+GZas2xbY9OUT11TjA6DnC2E6/ZaDPBtQQvMWN/3Q==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 16:31:46 +0800
Message-ID: <20240902083147.450558-2-toolmanp@tlmp.cc>
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

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..40d3f4921d81 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -179,7 +179,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
@@ -188,24 +187,19 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
+		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
+	
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+	if (!inode->i_link)
+		return -ENOMEM;
 
-	inode->i_link = lnk;
 	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }
-- 
2.46.0


