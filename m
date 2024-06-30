Return-Path: <linux-kernel+bounces-235385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40ED91D48D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F91F215D5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246315B149;
	Sun, 30 Jun 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o88b9PIx"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00615B125
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786728; cv=none; b=LuRBxf4ZPolIFUAldLehvNACjY6cn1bqpzIn8Ke51B+hdZUZxq1bYsJqbckdUOzpY9Wa0brg8VIHZyoujkNTgeoJFn/pf9Uk75fBnMQlhXd0Yr15wdn+SCms1LPeUH0eipsLkcimNNNR20vYkyZCtWJT2oLrjSCOKYqornMHvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786728; c=relaxed/simple;
	bh=UeriToCd4xlwwpgbjv1k9k0BSoePYBI/Y6CS9katNrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1vQEBW+lMVY339e7ri+lU7HwaPGd3DoDsj48i4WOzdEmH+0Q/j8XUWyTR+nVytOdqThJ7YDYFSM1yekilNQaHaDNVlt0qdoif4rKIFM9OmbztsrRsN5V53Z7zlciQpNi09643OVV9ZDt0pCYyrK3qbdulZnpgJ18THqpF1cRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o88b9PIx; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nf4WvQzll9fB;
	Sun, 30 Jun 2024 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786723; x=1722378724; bh=GuVQ/
	cuP3fZifq9mpfnD/3Hrj+LQWLdlzBly2R32pVo=; b=o88b9PIxJOPDpfeq4mHYM
	mxq6Yg31n7G5/qTlNSDd7zr9wXLiWCMlPFm2uuNfrt8pb94X+FknKTaaOk9qJgOO
	bDCRYzd73hkRQ86Em93THpixaJBYrw+8c3wGA7OltCfs5d1O00f37GM5SVNgLLnX
	0WiYY2stWTpKjl9epq7F6kC9oxLF6CjYkVWDEVJj7qhxD+wPIWzo+KkRYTINJ5zq
	9LZ8cUI3V9+T9PzVwWxj/xROgPkCp4zI9LiU5yx/Pdq9n51BaOgevxWW5mtOOobi
	5kQ12hn7EZEqMWid2m5AI+7a50ZB3fEqRJOjulNYrinT39G0auni4FbrgPP3+D7d
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uDimX2FGYpfP; Sun, 30 Jun 2024 22:32:03 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nY07JPzll9fT;
	Sun, 30 Jun 2024 22:32:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 36/53] scsi: qedi: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:54 -0700
Message-ID: <20240630222904.627462-37-bvanassche@acm.org>
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
 drivers/scsi/qedi/qedi_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.=
c
index cd0180b1f5b9..09da8209095a 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2766,8 +2766,8 @@ static int __qedi_probe(struct pci_dev *pdev, int m=
ode)
 			goto free_cid_que;
 		}
=20
-		sprintf(host_buf, "host_%d", qedi->shost->host_no);
-		qedi->tmf_thread =3D create_singlethread_workqueue(host_buf);
+		qedi->tmf_thread =3D create_singlethread_workqueue2(
+			"host_%d", qedi->shost->host_no);
 		if (!qedi->tmf_thread) {
 			QEDI_ERR(&qedi->dbg_ctx,
 				 "Unable to start tmf thread!\n");
@@ -2775,8 +2775,8 @@ static int __qedi_probe(struct pci_dev *pdev, int m=
ode)
 			goto free_cid_que;
 		}
=20
-		sprintf(host_buf, "qedi_ofld%d", qedi->shost->host_no);
-		qedi->offload_thread =3D create_workqueue(host_buf);
+		qedi->offload_thread =3D
+			create_workqueue2("qedi_ofld%d", qedi->shost->host_no);
 		if (!qedi->offload_thread) {
 			QEDI_ERR(&qedi->dbg_ctx,
 				 "Unable to start offload thread!\n");

