Return-Path: <linux-kernel+bounces-310670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E926967FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A971F21E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC0E15D5D9;
	Mon,  2 Sep 2024 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="m7QQ4tkm"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32F32C85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260462; cv=none; b=hDKFOKGXoUtZA32v5dpYT5A4xN2Zb6TTtpOcjoKtK+QQCmn26WNfIJPV9GJmwoabyPI8TC1XQzQ0LN1PPyHEvU4vh+/olBLXWbmegegObGrv20jBxrhYkWQvuz/pu1fexre/w3p+jWDWVTZDxKaABj8J3GsRUg/GZkmrzcdSDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260462; c=relaxed/simple;
	bh=rtitSi5k0tRvOnm5tSLW03txJ7He0Sba/3Hmfp445gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBhqqT0Z4naFuOZumEHFhcyWG7PlU79BnZrdni6Eqj5aJprPb3xQWaOehLdFUNVac/ZTzFVqtvGZ+zKkn0hMzkHYFHlpsZoZbgaB6I0NDsXrd+VOjkN+0shSJw/dXBoB/GRD5ceZ0Gj6dWW9C/+1dE+K8h0ilEMua+ZHlzLFx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=m7QQ4tkm; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4522269843;
	Mon,  2 Sep 2024 03:00:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260457; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8fgtuvRFIXezToFGm8qZZqVkmscpF7rZyoJRM+DZI0s=;
	b=m7QQ4tkmO4/FMHc4YtQFF2v+IvtVqyyJO3x7VjvfdMoYD8nJPzOPgYNYCaelX9qCVz1Keb
	qKPClzkXJKZSFI97qn4vLCDtysYQDjmnMd23lwVl75ymXlRpFKjQOymYIEvsfiRPKcfAt1
	yLkKECXIhuNUC26YIJSnFZ2HTxBJ3AOZwZ3f/ZCDvwNXJIWMEAQDPwuC9uqGZwmadcL2d2
	LX4fvySdT8QdstAqp+BYjIgM7iEQhHbZsZxVZ3CQUccFuyqR7wFEkMzvxVYbqNd8bbPFSJ
	QIUF/dTGblz6r677DvOx7zyDlpNT8dMlca28beKsXkQ+xrToim/hQPcnh/Q3eg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yiyang Wu <toolmanp@tlmp.cc>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 15:00:46 +0800
Message-ID: <20240902070047.384952-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902070047.384952-1-toolmanp@tlmp.cc>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
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
 fs/erofs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..d051afe39670 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
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
 		erofs_err(inode->i_sb,
 			  "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
+
+	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+
+	if (!lnk)
+		return -ENOMEM;
 
 	inode->i_link = lnk;
 	inode->i_op = &erofs_fast_symlink_iops;
-- 
2.46.0


