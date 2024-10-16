Return-Path: <linux-kernel+bounces-367086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF299FE72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4E1F22DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823013633F;
	Wed, 16 Oct 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPK5pccp"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CD13BC0E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043393; cv=none; b=TIIos0F3chxb2m/f1MSq8Z+2MekUefBERKRu6aeAfoWvNcUWlouq6B9Yahzi1m0jnyU7eP2JpTDS55mZYpVmkgOmwfeW/LAfDU1c+GFYhzfMDuQL3M3p1daRuavV5KNOglBvjijjEsVutQNU5adOjhR+3kfk2t3dEmu/Ge2F82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043393; c=relaxed/simple;
	bh=NFb6RJhRH4vw1qiChy9leEqNuV7Ff/PVP10REtocUdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhWg9WBpdrk3NNsD3TYHlLazhDBQmPXlQdSblqsoekoYrVtXvdCv/O/FweKOzIZkIqTNQbJVr7YHC5qzQlGxJYSspfqmfiHWRq6njJTEqW9tm7j2Zng6XEixDEwfkfeVq+uS0CHayQJouQ41TariLV5bhK06aIdGRiy/UzDePeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPK5pccp; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729043389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IwuLPiGuUxaZ9zj8hRINT/yuq5YbITHYzmysJbjNlYY=;
	b=mPK5pccppxnM6l1fgR5Cx4RvOYO2Cv/YKJuPA2qA78lgrXme8fM0gsxpeuXKXqlwgFmCYb
	vwZSL8BILr/jQc/4JwtbIyeoLgMz2SGUtXgNBjKAlQBR776tB13zWoFZSsvWM6RbdX40Y2
	ACdPcOkFo1OgmR4tPClx3kSTp0VO9Ys=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2] bcachefs: Simplify code in bch2_dev_alloc()
Date: Wed, 16 Oct 2024 09:49:11 +0800
Message-Id: <20241016014911.1555607-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

- Remove unnecessary variable 'ret'.
- Remove unnecessary bch2_dev_free() operations.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
v2: Keep the 'goto err' style.

 fs/bcachefs/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 843431e58cf5..872e3d144fc4 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1352,7 +1352,6 @@ static int bch2_dev_alloc(struct bch_fs *c, unsigned dev_idx)
 {
 	struct bch_member member = bch2_sb_member_get(c->disk_sb.sb, dev_idx);
 	struct bch_dev *ca = NULL;
-	int ret = 0;
 
 	if (bch2_fs_init_fault("dev_alloc"))
 		goto err;
@@ -1364,10 +1363,8 @@ static int bch2_dev_alloc(struct bch_fs *c, unsigned dev_idx)
 	ca->fs = c;
 
 	bch2_dev_attach(c, ca, dev_idx);
-	return ret;
+	return 0;
 err:
-	if (ca)
-		bch2_dev_free(ca);
 	return -BCH_ERR_ENOMEM_dev_alloc;
 }
 
-- 
2.34.1


