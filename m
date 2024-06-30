Return-Path: <linux-kernel+bounces-235397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747791D499
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E4D1F210C2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE0013D2A2;
	Sun, 30 Jun 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GGPV3PWe"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C282485
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786768; cv=none; b=QHv49SJXa6Y1f6a8uRm94FK/RMu6HmkXaZHbMi4+lxhXB8tw/OqNotfI79ovJ6bsAYwGLD5679GErTFGX/RquDxot0mzqmYpgZ+mjx413moLU66FfkG6HuNVfjGFxOiRtgUqjMfw2SefGpu8HvdpXNhlPCcuPy4FQClgg1jZkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786768; c=relaxed/simple;
	bh=ZqQ/uoUeEkZpFn1PgNDHD70wckIUqZXIR8a0aHHsYIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdEzb0ZbeoV6a5WlRzifHIYiNAR9oUbJYd5nWaxiOE9nydYmQ1fKRFrZg29s4eZ6gy+Pqwx+/KUbi42Pbga8Bn8BQr3a2tneGN9ymOehQucANvs8klz+05/QZFReiZdLDETscq5nNplf8Vq2gr+LN6bJXwb4b4BCYPAC4dBhX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GGPV3PWe; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3pQ4LDVzll9fK;
	Sun, 30 Jun 2024 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786763; x=1722378764; bh=19SHi
	eRMzm6A1x+iH4Egxz7GovYOuK6dnCRUNVgAeCQ=; b=GGPV3PWeZBBrtk1f3grE4
	XmBxCkx8p8O/TP4ezWj2/evGMVcOYp7BfO+J/oen5mZmu4xx7aAbX/sEjb2YIMhf
	HBoET7FkJ6UUe5ryxiY/8LSo2Fnzq60X+yvuWbc2XIRqd5uS0rzG4DCSRQK3xSmw
	l/vg2m4CwWrmAGHxgM9S0hW6DW/+VQBYYPk/NZ1EDXo8w/hYr3hBm9SzKM2a+ZH4
	KzglhBH8W0mEf9Zyg7SGYYz0+sKpbGKAu4m8HB4g7Dwy+SE0KDIYWbduQuuVroTI
	HCEi2f2crwOFZZA3KLXZvotYbLZI6keDFWpYxIgY0EKtdHz3HSbEKexoOMzHiBg9
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Wz8knQTuUCSq; Sun, 30 Jun 2024 22:32:43 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3pJ0N5dzll9fB;
	Sun, 30 Jun 2024 22:32:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Avri Altman <avri.altman@wdc.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH 48/53] scsi: ufs: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:06 -0700
Message-ID: <20240630222904.627462-49-bvanassche@acm.org>
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
 drivers/ufs/core/ufshcd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1b65e6ae4137..9df5b82a6790 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1783,8 +1783,6 @@ static void ufshcd_remove_clk_scaling_sysfs(struct =
ufs_hba *hba)
=20
 static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
 {
-	char wq_name[sizeof("ufs_clkscaling_00")];
-
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return;
=20
@@ -1796,9 +1794,8 @@ static void ufshcd_init_clk_scaling(struct ufs_hba =
*hba)
 	INIT_WORK(&hba->clk_scaling.resume_work,
 		  ufshcd_clk_scaling_resume_work);
=20
-	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
-		 hba->host->host_no);
-	hba->clk_scaling.workq =3D create_singlethread_workqueue(wq_name);
+	hba->clk_scaling.workq =3D create_singlethread_workqueue2(
+		"ufs_clkscaling_%d", hba->host->host_no);
=20
 	hba->clk_scaling.is_initialized =3D true;
 }
@@ -10328,7 +10325,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem=
 *mmio_base, unsigned int irq)
 	int err;
 	struct Scsi_Host *host =3D hba->host;
 	struct device *dev =3D hba->dev;
-	char eh_wq_name[sizeof("ufs_eh_wq_00")];
=20
 	/*
 	 * dev_set_drvdata() must be called before any callbacks are registered
@@ -10395,9 +10391,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem=
 *mmio_base, unsigned int irq)
 	hba->max_pwr_info.is_valid =3D false;
=20
 	/* Initialize work queues */
-	snprintf(eh_wq_name, sizeof(eh_wq_name), "ufs_eh_wq_%d",
-		 hba->host->host_no);
-	hba->eh_wq =3D create_singlethread_workqueue(eh_wq_name);
+	hba->eh_wq =3D create_singlethread_workqueue2("ufs_eh_wq_%d",
+						    hba->host->host_no);
 	if (!hba->eh_wq) {
 		dev_err(hba->dev, "%s: failed to create eh workqueue\n",
 			__func__);

