Return-Path: <linux-kernel+bounces-235351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0291D46B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31C51C2095D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAF80026;
	Sun, 30 Jun 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vbnhi1wh"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EB76034
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786580; cv=none; b=cehLppH43LeUTblUkrwMv600aPiEM//n2sl3KdCMq3D18joavAD30AU6HcfY4aUjFotEKOS0jqgr+H7B7pRha5YWpSmcMwmN5MJqN5zfKK4vgbkWellm8fXmXRNGzsXM8Ti8jRO0HDX1kwlI81cev3aAqoCpuRm1Dt4UVWlPJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786580; c=relaxed/simple;
	bh=lBmazvfqg6ZVen0cGfTsnBYfvGarT8aR0p3IcEbws/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUybVzNw86riqkVkTo90NKv7c5ckoXhjdDxsqGCWV7HEPgFwpDqn8WSEMg4L5416nJF6WEs7ihz6T/4n7cqzAStzqrDcQ72dqCdcgA+/LGWZCEhAdEfv7+mMmybvcLZvClaheDpaKmDZPba8WFGpmaSDVSss2t2sY2ECzer/T4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vbnhi1wh; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3kk00QNzll9fB;
	Sun, 30 Jun 2024 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786571; x=1722378572; bh=x67hr
	8tR2Pj/qIMztT87Ax8wJsgFJJobUoMtxEKn0dM=; b=vbnhi1whX5qON34fYVCXN
	JRSvo1cbRdX+eDKiaOytmb9R5rZ5eIHrJLIovx6RAeR2jYwuPX2b2H1Fpk8k/Xe7
	qOsN+6jK5M1+oV/b20BqTHtk7d64+CCSs6QARnK8Al8vA4BDD82pDz0bH/COBVZq
	q4LzzCL0wyN3N/A/oNbOmgszIQ5L5iqnzGyMRYvnWVZZq98S86Gs7RWUxr4EnSlu
	Kqs9/8Wta5T1vY3sCgyWqkv4QlhLwaezuSHu/M6Kzw7m5fznOWg3+9BXLCb/5b18
	PQ1dx/FTWtEHFNgAFs+uH/FxvGsh49IUhqXt6qDGZ5GpuOauQIBuxZ3fZyb25mu3
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dqq2F2dhwiYT; Sun, 30 Jun 2024 22:29:31 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kd5vdfzll9fG;
	Sun, 30 Jun 2024 22:29:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 02/53] dmaengine: idxd: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:20 -0700
Message-ID: <20240630222904.627462-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for removal of the create*_workqueue() macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/dma/idxd/cdev.c | 2 +-
 drivers/dma/idxd/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 57f1bf2ab20b..5aef47e5c6e4 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -619,7 +619,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_=
dev)
 		goto wq_err;
 	}
=20
-	wq->wq =3D create_workqueue(dev_name(wq_confdev(wq)));
+	wq->wq =3D create_workqueue2("%s", dev_name(wq_confdev(wq)));
 	if (!wq->wq) {
 		rc =3D -ENOMEM;
 		goto wq_err;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7295943fa22..a3e821090bf2 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -397,7 +397,7 @@ static int idxd_setup_internals(struct idxd_device *i=
dxd)
 	if (rc < 0)
 		goto err_group;
=20
-	idxd->wq =3D create_workqueue(dev_name(dev));
+	idxd->wq =3D create_workqueue2("%s", dev_name(dev));
 	if (!idxd->wq) {
 		rc =3D -ENOMEM;
 		goto err_wkq_create;

