Return-Path: <linux-kernel+bounces-358610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D9998192
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C11C245B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EEC1BD003;
	Thu, 10 Oct 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MHUBDQYK"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FB1946C8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551084; cv=none; b=gye0HeQD3AQW9J8Ug62fZPmjDP65JGA0Xuoyc/ZR06ouy2h8zuAuvcqHa3cWO0xa5a2whVBkA5SjWjLHryWoXyK1PKU9CtC+GWIbhshyh+7v+hciuDwHSL7zpQnbSpJK4z6M+czg7x6/+B2jcniSq01Ztxkm1HlN1Vcj13RIiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551084; c=relaxed/simple;
	bh=LvmAsQrux/14zdm671O9GvGoUvOEHR1Knj+Pg+ggooU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQGv7wkw+lyxaixVahKmO7JeIgIm5ixDkC40+p5FZAawtAH3SsDbeGbM5emYA+cQTjhiOsMOBbGezAhJibFkHRBikfSp1TwiWbz8Zq78x6E8gUrRBh5TAcMSZaBwTK3RxS1aHZBXw2w8pA1XY/FwTIwuHkqQtN+i8QnPMGlU6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MHUBDQYK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728551079; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OhN43jmqgscvViJHTKkxcG9hhjOllYEZaG+SvYfOIwg=;
	b=MHUBDQYKAi96YXIM4T3TpGvWS7oSbd6fRAHox3WeSufxCqHPgVZm2JXfILhoW3+rlGO28PipDrZUyjwfkOAIBQ4MSadrk4dfrN2JBIcYIKTdfZ6MN5wZQ5Dv/545E/psxVGJ8n32IQgHx08O5UNePsXK84BM0QTdvD4fq8aTrsc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGlkDys_1728551062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:04:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: get rid of z_erofs_try_to_claim_pcluster()
Date: Thu, 10 Oct 2024 17:04:19 +0800
Message-ID: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just fold it into the caller for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8936790618c6..a569ff9dfd04 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -710,24 +710,6 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
-static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
-{
-	struct z_erofs_pcluster *pcl = f->pcl;
-	z_erofs_next_pcluster_t *owned_head = &f->owned_head;
-
-	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
-	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
-		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
-		*owned_head = &pcl->next;
-		/* so we can attach this pcluster to our submission chain. */
-		f->mode = Z_EROFS_PCLUSTER_FOLLOWED;
-		return;
-	}
-
-	/* type 2, it belongs to an ongoing chain */
-	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
-}
-
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -803,7 +785,6 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	int ret;
 
 	DBG_BUGON(fe->pcl);
-
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
@@ -823,7 +804,15 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
-		z_erofs_try_to_claim_pcluster(fe);
+		/* check if this pcluster hasn't been linked into any chain. */
+		if (cmpxchg(&fe->pcl->next, Z_EROFS_PCLUSTER_NIL,
+			    fe->owned_head) == Z_EROFS_PCLUSTER_NIL) {
+			/* .. so it can be attached to our submission chain */
+			fe->owned_head = &fe->pcl->next;
+			fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
+		} else {	/* otherwise, it belongs to an inflight chain */
+			fe->mode = Z_EROFS_PCLUSTER_INFLIGHT;
+		}
 	} else if (ret) {
 		return ret;
 	}
-- 
2.43.5


