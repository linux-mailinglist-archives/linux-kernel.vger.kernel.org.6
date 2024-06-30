Return-Path: <linux-kernel+bounces-235393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE96E91D495
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1CB211BB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BC15ECFA;
	Sun, 30 Jun 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xtJEPovB"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8015ECE9
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786750; cv=none; b=isUK0948OfxjO1YHaS4D9GgW50Th74b3AWS2aHtNQ4LGltnCtNd+Pv5lCIb9/ZKL3/8oe+3ngZOQdufzmZXDAh+5zb5RaYynwq8Okfa7yh+VMOQm1iLOR3EQWYPyvE3lFfM/NXEiaMm4th5zgQTkN+3FWf9ImAKSfOsxGQ6EOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786750; c=relaxed/simple;
	bh=71n/EoGDYzWEgETJpeM/+yo1H7s1yvi2DrLAbmpY2eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk9GtbRNgCSAaLMTO6oli/hzFsOgT7KOSmIEFfUQLuH1wS2H5C9mucdLnabPA0mOyZHAhoLXwZIjhrFk05TZccpN22fshH1BDkFbmDF5SUmXPTtCsIt+NVHCs4UWhd+OyRxUWDuKqJNo2b2Bal2BYS+7EnFZQL8mV5CYHNbgwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xtJEPovB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3p46BHczll9f8;
	Sun, 30 Jun 2024 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786745; x=1722378746; bh=+JTQ7
	poidU9H1Sb7iELMNzC89YiUCfjIfL4v73y52BY=; b=xtJEPovB1GiarHywwq9pB
	rpepKpKu91tLXdoG4ETtyVx/rpnm20SCY4nV1/RMOou3u65AZhUjPflW5tvkmSs2
	ZYthxUNdja4AcTIUgxgdIzTy4xVfpP8Yni2UrV3a0+782pXq7UYWE3r7Nmnjg8UK
	UUWSCQw0Iwrq5N1YZRrU1xfFhMcJ3uc4gpZevmPuszCk6Jo1UBQ7pcdmyYb2/Uw5
	dq86b6FA74O+D1HSeLe0SpDTQABt3Qg6G42D9ZoH06JZpzQeDjngcSlsU+J79VGw
	91kFSD1bllGawjIfGSaeOY503VNa4YAOSK8q+8VvjRaCAannlQD3xLjJD2fdTlz3
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IDRJ28bNtWSL; Sun, 30 Jun 2024 22:32:25 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nz4VgNzll9fH;
	Sun, 30 Jun 2024 22:32:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 44/53] scsi: snic: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:02 -0700
Message-ID: <20240630222904.627462-45-bvanassche@acm.org>
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
workqueue name before create*_workqueue() is called. Not setting
shost->work_q_name is safe because there is no code that reads this
struct member. Additionally, a later patch removes this struct member.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/snic/snic_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.=
c
index cc824dcfe7da..676ccf41b9da 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -300,9 +300,8 @@ snic_add_host(struct Scsi_Host *shost, struct pci_dev=
 *pdev)
 	}
=20
 	SNIC_BUG_ON(shost->work_q !=3D NULL);
-	snprintf(shost->work_q_name, sizeof(shost->work_q_name), "scsi_wq_%d",
-		 shost->host_no);
-	shost->work_q =3D create_singlethread_workqueue(shost->work_q_name);
+	shost->work_q =3D
+		create_singlethread_workqueue2("scsi_wq_%d", shost->host_no);
 	if (!shost->work_q) {
 		SNIC_HOST_ERR(shost, "Failed to Create ScsiHost wq.\n");
=20

