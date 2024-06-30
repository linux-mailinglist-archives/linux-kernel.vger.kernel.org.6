Return-Path: <linux-kernel+bounces-235382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AC91D48A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC74280FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822E129E66;
	Sun, 30 Jun 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rtU2QAzw"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B838F83
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786718; cv=none; b=vFy0VGLZYZ/wZUoqAtWcqYztibij4q1Vt2vLLp25/dxNBNFseCzQc+4PztMBKl0BBrOcAB8cJcPvuJl9j/GHSgqpIpEZbthWbuL63Sb2HTPEijIqwlwKLTc8xCRlHEGf2kQZc2WNN9H7Z3HoyPXVvpaUoKAjujTsj5uwyV54Ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786718; c=relaxed/simple;
	bh=oFMF2/wEdaMmtpk/x+N+ZdNJtad2x/fHWkSaiGptDA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTuUPTtQAsItUDOYiLxPX6lNLUxPtGWg2uaagOSN/kYc6fGx7Kqr7G+1wwmJE6MtHI0XgFsAsLk4EwA7NizEqeiLSTGe+HsoeW0rEJ++MRYTG1zdwG9rfaLAMU9Eh4DwYyN99/E6vZeh7xtdvjvhljIhURfngcu3tfriDz/DHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rtU2QAzw; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nS3Ltqzll9fH;
	Sun, 30 Jun 2024 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786713; x=1722378714; bh=fttYv
	POYXB8GVk1K43AHS8yl316uQIoQJbn7WEo8uxM=; b=rtU2QAzwpQEP4M1O94nBv
	DVUe213QSN7Tnr21olnc+CuthcRPVo1YIDRYvboP5pxbavtGGyuTf9o6ueL2Nh5o
	IxIRobuZdwEc0/nOivcStTD00yfeX/+b/v7BRjfbcnmjcHoVUof4QrAeQUAErVea
	5lCWSJ1X00YZ3nXas1STs2D6t9thCIgBCPqAvcuTGpd97sJMbqr+nDf7CC4h6Oxl
	XcInGjZsvJQ4DDHjXhN4CJ9mHLHxNRXyN0RrBF1g2eQjt8uzdnGL4wrJPXor/591
	Y9YHacm7nfUa1bxAV+CJNOXVAH6MKB/crqRIyuu0vzA/7v3o7gh+k/AdoI/KSJJ7
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SraOW9vgERWB; Sun, 30 Jun 2024 22:31:53 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nL3x2bzll9f8;
	Sun, 30 Jun 2024 22:31:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 33/53] scsi: libsas: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:51 -0700
Message-ID: <20240630222904.627462-34-bvanassche@acm.org>
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
 drivers/scsi/libsas/sas_init.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_ini=
t.c
index 9c8cc723170d..e7d2edf9e635 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -92,7 +92,6 @@ void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
=20
 int sas_register_ha(struct sas_ha_struct *sas_ha)
 {
-	char name[64];
 	int error =3D 0;
=20
 	mutex_init(&sas_ha->disco_mutex);
@@ -121,13 +120,13 @@ int sas_register_ha(struct sas_ha_struct *sas_ha)
 	}
=20
 	error =3D -ENOMEM;
-	snprintf(name, sizeof(name), "%s_event_q", dev_name(sas_ha->dev));
-	sas_ha->event_q =3D create_singlethread_workqueue(name);
+	sas_ha->event_q =3D create_singlethread_workqueue2("%s_event_q",
+							 dev_name(sas_ha->dev));
 	if (!sas_ha->event_q)
 		goto Undo_ports;
=20
-	snprintf(name, sizeof(name), "%s_disco_q", dev_name(sas_ha->dev));
-	sas_ha->disco_q =3D create_singlethread_workqueue(name);
+	sas_ha->disco_q =3D create_singlethread_workqueue2("%s_disco_q",
+							 dev_name(sas_ha->dev));
 	if (!sas_ha->disco_q)
 		goto Undo_event_q;
=20

