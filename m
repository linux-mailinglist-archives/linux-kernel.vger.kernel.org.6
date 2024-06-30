Return-Path: <linux-kernel+bounces-235381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B391D489
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCB11F215B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F515ADA3;
	Sun, 30 Jun 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LwOY+8NK"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFBC15AACD
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786710; cv=none; b=igXtrdRN/n4KP09w6Ux7iuGfWFfDHS87mhdQcku5+pDrM4DML70VNzW6qCwXM4hdzFI7Slv14QcaP56ez3/RYPrD+1pe0UNUk/xV/62Z7SrvkC7P4SrRO/mDR1iSNC9OEanHOJsc5QT/INfxNikwFbChVmnbbLXDjqsrnWx0c5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786710; c=relaxed/simple;
	bh=8WP2CyD/eeUBJQMg6KJTyhSJvud5ipPCy0eTGhXCaV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH967y1fEDm06TjFhjpgCO2Z9ISsS9Cks6N8QgyaygnRJex9owE9X3mWUKrE3i977V/0MB6XfFh3NbI5M+KbC1yK6zQIG0Gmy3E9eMS7ICfyLTjZttRw9TCCy4WoTQoT0+LbSmiQDy5rSxngnY4w+pH4uGYGFHLkA31lwDvCfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LwOY+8NK; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nK21HSzll9fB;
	Sun, 30 Jun 2024 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786707; x=1722378708; bh=MfvdD
	/vV2k3KsmYIcyRbgY7Wqr6Wu+EBiBG3hsjdFMk=; b=LwOY+8NKidTxtOJtLii3K
	kdjDWCsOmpvKYWQTAWF5sece9N+pVeW2sfK6aSUmggXiflTrSg7yW7uELfNhYWji
	PxcHy9+wB6tFcPTbFUv7u+VgjkTvQPOD62IOxP8vXEHicR9mGMUlA7afOOFvIRRD
	XCEvcZ65J+0Q+mCS4egp+zxX6lmXf3ygywY5GWOUhmv3s1nX+xQbdR2SE7kpOKsw
	A8n/FdBSjsIHdPqyFdcNhBypJD47sAAWd6kpeD1XkfUA9fkv7DoP3v0ppvfbanez
	mWDTNIFEkbs46TQ4xyHbuJEVOLtu1709xVzxtx3IaLGxoLeaY044OSLEx1ilONkr
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Jv0N9-sF-0Wd; Sun, 30 Jun 2024 22:31:47 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nF1Dy0zll9f8;
	Sun, 30 Jun 2024 22:31:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 32/53] scsi: ibmvscsi_tgt: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:50 -0700
Message-ID: <20240630222904.627462-33-bvanassche@acm.org>
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
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmv=
scsi_tgt/ibmvscsi_tgt.c
index 2fca17cf8b51..a106e3a1b833 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3425,7 +3425,6 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	struct scsi_info *vscsi;
 	int rc =3D 0;
 	long hrc =3D 0;
-	char wq_name[24];
=20
 	vscsi =3D kzalloc(sizeof(*vscsi), GFP_KERNEL);
 	if (!vscsi) {
@@ -3536,8 +3535,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	init_completion(&vscsi->wait_idle);
 	init_completion(&vscsi->unconfig);
=20
-	snprintf(wq_name, 24, "ibmvscsis%s", dev_name(&vdev->dev));
-	vscsi->work_q =3D create_workqueue(wq_name);
+	vscsi->work_q =3D create_workqueue2("ibmvscsis%s", dev_name(&vdev->dev)=
);
 	if (!vscsi->work_q) {
 		rc =3D -ENOMEM;
 		dev_err(&vscsi->dev, "create_workqueue failed\n");

