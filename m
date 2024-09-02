Return-Path: <linux-kernel+bounces-310792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF3968146
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2B01F21228
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8976617E01B;
	Mon,  2 Sep 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="XW5H+dBh"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8F17C9A3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264278; cv=none; b=dKj4/ZbqdHNPkhk40LQAWJIuKMkWsdyl4+trQv9ZIgBeDHp9AEqF+riEk3CUo6HY6RLcIjn/fJyBDmX4fE349Ur3UZEbyYG52iXbLbsTgR7+dUObE6Hrt4rpfh6OT1efz0fYAvS7kmO673uHIWNpNERm7KAt7XzEFrYooCV3a2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264278; c=relaxed/simple;
	bh=ow+4SDCxIVP7wXCPLjVIbOF8vjB9uJiyQMv5eVxiyUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arvYa8xoDwvsjhc65AksIvL2Y0eggUWUeiT6aihizkuGEvu6Nqup57KrZSkRKfnO7Y8al81aVmmAJ8HAtsWqizR+KOskC4gkdCHvsoLHzGCbmWOZAhym60WN6KYqpgQlBwXwQ37jkE5YRSQVEVZ6rWy+5A+kqEts0iF9IqHrL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=XW5H+dBh; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BF886983F;
	Mon,  2 Sep 2024 04:04:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725264274; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	b=XW5H+dBh2d8Qk64ukrUeSGFRl3Rvmah7aJVV/PMOlHtGFeEdDuAhFQgHDOY6W9H4+krQQg
	WjIzaqc9RjvVfrEDRtUkCAKE0vxM+wQAa3Hr41IaqHjP8T8ttoU3abzD0iXc2Yd45sGqXI
	uV3/yjWrGvIQEg0G1ACJb6ZFwAFmQzk560pd2FwxH/X7bHrJe8bNneLNO9IMJMcN8NfHUg
	2kbiAoAme3mWyx3lpYfDN9+JjQhox1jnr6YpEfAclKNet3nVO49QWmJ5V8F8+1ZHHaNuTj
	G0miduPNuVTLjciIBGeQsbHobUO4KYAWPsJ1UrrZNyjHwRSebmjU/E9ze0fKuA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yiyang Wu <toolmanp@tlmp.cc>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH V3 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 16:04:16 +0800
Message-ID: <20240902080417.427993-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902080417.427993-1-toolmanp@tlmp.cc>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
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


