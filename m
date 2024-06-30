Return-Path: <linux-kernel+bounces-235391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F4391D493
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3128DB22399
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13A15E5D2;
	Sun, 30 Jun 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ger4gZnS"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E815E5B0
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786743; cv=none; b=jQmd+NeyEXSpm5yokWSI56Cw4QAI8HBLM+p/A8cFTyFAlw2vrWN+E0JDZ5eyJLxv3GBRlrBo/u6OokjaGygkMCn0JVcqcv9sTg9VPJEtsK69EceEQtFXGSn3WQnYo2k9ZKgA3zXehlktHeZbcSKRMLJyMMCbNvnXl2aqbaF5hXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786743; c=relaxed/simple;
	bh=UDiec6lzF34xUzGPfTi7+wXUsLrYRVUiPd4bTwtKalU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxT+lbDyJQ6vNijmRFPMNYUF+BOWlu5ckh5P1vPHaCOQKkbiRAeFdJJ8viW0GJf3QPxzJBcBis9zgrseQlkaTb6Z2ttLy5eGRhuVnGyosp4M5C80rcseXko0j36Qs0i135fbiD//1Zvo9vGq/0tMfoiK9TR1qWWx4Wlb8nHY1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ger4gZnS; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3ny0SQmzll9fM;
	Sun, 30 Jun 2024 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786740; x=1722378741; bh=TxTA7
	ddFgZDfsGTBYrqL4nnED7fyVYqKoG4FTXo1Ew8=; b=ger4gZnSV6kxTnsrBWKMa
	GL8ZcE82PVQiSzu8j5K9xPwo5UMknKA28P19/IrgJE/C9GRwbvWvL3bv/Qn9uIQM
	/SZ4j3HebazZRxt2mnRKxAIoBlgjPYhKrifw37fEfZQUgB3FF29mVeEttO5ILFW7
	oF4m4VFy119M/G+5qgmw18PST+YksMKU92+a31RAnmPbGw+34imuNCwlX2oWKKOs
	EkwOj4jqD9GjmWJMqObaw1KTesomlyMJx8kB40jTZWD78V75pSHLAYKcQiIk3phc
	tbnsxlFr69H/bjT2/NNYRNw1z1nO3diCuUj/vVl6fxD1r3ZZgqcywHZ/zf6YGTj5
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 64PNFogfXEWA; Sun, 30 Jun 2024 22:32:20 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nt2Brlzll9fS;
	Sun, 30 Jun 2024 22:32:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 42/53] scsi: stex: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:00 -0700
Message-ID: <20240630222904.627462-43-bvanassche@acm.org>
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

Pass a format string to create*_workqueue2() instead of formatting the
workqueue name before create*_workqueue() is called.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/stex.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 8ffb75be99bc..5c88f6a8249e 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -334,7 +334,6 @@ struct st_hba {
 	struct st_ccb *wait_ccb;
 	__le32 *scratch;
=20
-	char work_q_name[20];
 	struct workqueue_struct *work_q;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_waitq;
@@ -1795,9 +1794,8 @@ static int stex_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	hba->pdev =3D pdev;
 	init_waitqueue_head(&hba->reset_waitq);
=20
-	snprintf(hba->work_q_name, sizeof(hba->work_q_name),
-		 "stex_wq_%d", host->host_no);
-	hba->work_q =3D create_singlethread_workqueue(hba->work_q_name);
+	hba->work_q =3D
+		create_singlethread_workqueue2("stex_wq_%d", host->host_no);
 	if (!hba->work_q) {
 		printk(KERN_ERR DRV_NAME "(%s): create workqueue failed\n",
 			pci_name(pdev));

