Return-Path: <linux-kernel+bounces-235390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C326091D492
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A172281303
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10F15D5B6;
	Sun, 30 Jun 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZDYr6JsW"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4715DBC0
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786741; cv=none; b=rJPAbB0vIz1EDJbXeJcUVi1rEevJk9BLeWovTS8h0mSY2pl3pvaFUIPbbcZKMGgB1TmkqozT+ALLeGTKFh0Z5gBPhBuWBU97IqgEfSzKpRHUnIbeve4kKiUVB3n7v7+Y1MmyXQwPWiTjnegKmlSdyS1Qffzh9Mgax0w/YqFrHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786741; c=relaxed/simple;
	bh=BgrX2Pf38CdSI7MqtFzK64HH3Ds82UpU7zzARZdtPKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI3HW7FCYRfZHc1Aa5ww52+Sa8Y1rzeIsJRMFFMx91DNXYKqmYcyRqdVPikbetPavuGjqt40UgD+zy1PR1WjIFrWUc5xYE+550Kt3/pnTYnBUB3DuJ9rYC0Z7OZ6iOn9dBfzJDodqETUfDzF2fj7fZ+qUMd3g3IM3FI9FPvC7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZDYr6JsW; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nw0d5nzll9fH;
	Sun, 30 Jun 2024 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786737; x=1722378738; bh=MJumS
	RMGp5eWFvpuFDWpltu1THr/SowLh2z32d+piQI=; b=ZDYr6JsWdE1wJ49599FLS
	Q2/o57nXdJMjILdmXwBj5pXBmJXCJZLrTKXQXn+TxVv6wjiBonUYKpKtbmJwfWc5
	MoXAxqANp0WMYXk/cTOP/HPQukdhvviEV1oxNAgSnF95yIrlktWi/eBjU57OAD/9
	jc2Zx+H9aXilOPlOz5vSd5S+dsxcPN1N632/+oEGkXQRnPWCUcxcKV5W0i4oSAY5
	Ez2K/zlwqzydiCQw+3lPxiYT4wKo+qTXzA4Aznkz9g2bjAs0yslVm+kf4dRIohk4
	N+3gGX0chXMlj3pHshgLidvLorWjP9Dn/LPpiO7GAXc83kF/gdoRGEvijd+D91iq
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YcMRwMCigbTL; Sun, 30 Jun 2024 22:32:17 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nq4w3Gzll9f8;
	Sun, 30 Jun 2024 22:32:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 41/53] scsi: myrs: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:59 -0700
Message-ID: <20240630222904.627462-42-bvanassche@acm.org>
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
 drivers/scsi/myrs.c | 5 ++---
 drivers/scsi/myrs.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index e824be9d9bbb..768475f1b3d8 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2206,9 +2206,8 @@ static bool myrs_create_mempools(struct pci_dev *pd=
ev, struct myrs_hba *cs)
 		return false;
 	}
=20
-	snprintf(cs->work_q_name, sizeof(cs->work_q_name),
-		 "myrs_wq_%d", shost->host_no);
-	cs->work_q =3D create_singlethread_workqueue(cs->work_q_name);
+	cs->work_q =3D
+		create_singlethread_workqueue2("myrs_wq_%d", shost->host_no);
 	if (!cs->work_q) {
 		dma_pool_destroy(cs->dcdb_pool);
 		cs->dcdb_pool =3D NULL;
diff --git a/drivers/scsi/myrs.h b/drivers/scsi/myrs.h
index 9f6696d0ddd5..e1d6b123de7b 100644
--- a/drivers/scsi/myrs.h
+++ b/drivers/scsi/myrs.h
@@ -904,7 +904,6 @@ struct myrs_hba {
 	bool disable_enc_msg;
=20
 	struct workqueue_struct *work_q;
-	char work_q_name[20];
 	struct delayed_work monitor_work;
 	unsigned long primary_monitor_time;
 	unsigned long secondary_monitor_time;

