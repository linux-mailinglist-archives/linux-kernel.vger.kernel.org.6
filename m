Return-Path: <linux-kernel+bounces-235384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EE91D48C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12734280DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268B15B118;
	Sun, 30 Jun 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="syaeuU/Q"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16515B108
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786726; cv=none; b=pgAvqcdZxoG+nHFgV13FG1I3bWft8tRtAEkBkOVwgXzXufgHC585QjCj696WduM1UMX0bwM6VtGDLP2pZIcVlX3aatmabfhPz/xtF8tKkcvUFstnKtaeNOnw2MrpJmtw1z1yVR3Y6d/TgR2mx7F0nKKpTCJPN1NxVWvvjRg9hDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786726; c=relaxed/simple;
	bh=TneBPbw3uXru2yYfiFyQoRa9gqFRXN+nWUKJKmWMs5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT3wf5xLRKZz8LyAohWjS6uwEDnFtngxkYi2GuS8/e0pt8Ugct7j3hdJY9TcxLZneJY3Hmc3YjKWUP2Kr7Q7S4SirgKToW6NNRllgIZnIftsvUaCZcxr59uxIFcuq3NVlCFnEnTrh7IP2484wF3TkyO3bIkcln6hMwic/mUr4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=syaeuU/Q; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nc24BVzll9fS;
	Sun, 30 Jun 2024 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786720; x=1722378721; bh=B6PsK
	KUQxP1i/s+FEy0TaGIQVipuAHAx4ixvCMwIktU=; b=syaeuU/Q8MXQyXtyXvaxh
	8qH20Ma6zB/VOngjvW0Nsgy0Rl+5Z+w8HlwBLXo0pXMcAZtrYDe0Z0gpmDQU1vWW
	JxzoaacjlHfXjDb6NOmyK6TEAbcP0xTo1dwnnTL/lf1sOqYsdhUOznwJ7FlJBFO8
	rm+IAskIkOOHrzX1QLWgb8U/2FBxQCua/bMLXX6NcDOYsW0IK5fW3mlbtn95PQGB
	JqA8YQ4hBVw78wcT75nHJi18x9dYsdI9ifElIlhH1NJpoHWVKpZjrPrSoE6fH4Ss
	Zd4fMlkaQLOHCc0ay+norxugQexEUC5K2MYTxaPxW8h23FdUGCpiUWuwOru0rZp2
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wgHrXG60SrEY; Sun, 30 Jun 2024 22:32:00 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nT55mwzll9f8;
	Sun, 30 Jun 2024 22:31:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 35/53] scsi: qedf: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:53 -0700
Message-ID: <20240630222904.627462-36-bvanassche@acm.org>
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
 drivers/scsi/qedf/qedf_main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.=
c
index 49adddf978cc..ffbd67a46368 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3372,9 +3372,8 @@ static int __qedf_probe(struct pci_dev *pdev, int m=
ode)
 	QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_INFO, "qedf->io_mempool=3D%p.\n",
 	    qedf->io_mempool);
=20
-	sprintf(host_buf, "qedf_%u_link",
-	    qedf->lport->host->host_no);
-	qedf->link_update_wq =3D create_workqueue(host_buf);
+	qedf->link_update_wq =3D
+		create_workqueue2("qedf_%u_link", qedf->lport->host->host_no);
 	INIT_DELAYED_WORK(&qedf->link_update, qedf_handle_link_update);
 	INIT_DELAYED_WORK(&qedf->link_recovery, qedf_link_recovery);
 	INIT_DELAYED_WORK(&qedf->grcdump_work, qedf_wq_grcdump);
@@ -3584,9 +3583,7 @@ static int __qedf_probe(struct pci_dev *pdev, int m=
ode)
 	ether_addr_copy(params.ll2_mac_address, qedf->mac);
=20
 	/* Start LL2 processing thread */
-	snprintf(host_buf, 20, "qedf_%d_ll2", host->host_no);
-	qedf->ll2_recv_wq =3D
-		create_workqueue(host_buf);
+	qedf->ll2_recv_wq =3D create_workqueue2("qedf_%d_ll2", host->host_no);
 	if (!qedf->ll2_recv_wq) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Failed to LL2 workqueue.\n");
 		rc =3D -ENOMEM;
@@ -3627,9 +3624,8 @@ static int __qedf_probe(struct pci_dev *pdev, int m=
ode)
 		}
 	}
=20
-	sprintf(host_buf, "qedf_%u_timer", qedf->lport->host->host_no);
 	qedf->timer_work_queue =3D
-		create_workqueue(host_buf);
+		create_workqueue2("qedf_%u_timer", qedf->lport->host->host_no);
 	if (!qedf->timer_work_queue) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Failed to start timer "
 			  "workqueue.\n");
@@ -3639,9 +3635,8 @@ static int __qedf_probe(struct pci_dev *pdev, int m=
ode)
=20
 	/* DPC workqueue is not reaped during recovery unload */
 	if (mode !=3D QEDF_MODE_RECOVERY) {
-		sprintf(host_buf, "qedf_%u_dpc",
-		    qedf->lport->host->host_no);
-		qedf->dpc_wq =3D create_workqueue(host_buf);
+		qedf->dpc_wq =3D create_workqueue2("qedf_%u_dpc",
+						 qedf->lport->host->host_no);
 	}
 	INIT_DELAYED_WORK(&qedf->recovery_work, qedf_recovery_handler);
=20

