Return-Path: <linux-kernel+bounces-235387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B977991D48F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF7A1C20C15
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7D15B99E;
	Sun, 30 Jun 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="n/k+j6Hk"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D515B96E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786734; cv=none; b=KQSjWac8aADSmF1tQasysvErb/D5W2UZRKHfhoAXrMdpAPdFl78Bs+NnnSNPNgAgDpKDSyOoug4uv4RLflpCliIU3lHyLA1gKCVWcxp/jhnPqAfHOpJ1YEOtuxuNj903oxHzHWSZ8pTPuJ3ypiuI8W5Vp3LotLuHgiD1Z4XbMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786734; c=relaxed/simple;
	bh=18MR/FQ3h2rlLSEmyjYypZHCy2VIOnIFSm8pwMMxD7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLhKuov6qcVVBAhSNESXOFgJ1eyzbWpEOE5xzbW8dP2zcDX++UtL4d2y6EnXom1iZGrrIIN5AgdQTZ1xZj7TEBhRpisIpbFNKp03gwaXK9FKGj3q9nd2cItzwRwG88qKritNEwpvntY6/YZl0e/D3USo5GwuEzcGTXZ66thO5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=n/k+j6Hk; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nm6z51zll9f8;
	Sun, 30 Jun 2024 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786730; x=1722378731; bh=KSGEh
	DwC1s25Oya+Eb9GvOtJ7xeTFDEwgZ136rOq/SM=; b=n/k+j6HkToZlBTuEjvp2j
	z1xoxDpZhUtmmYC0TrpKCL8iBZ0PbtlFT1yK28cc53Y/Petw3+jrw6qv9mjQqEoM
	1bnYiLX0L0leRQF5Ye+W1pMq/G8BQZqXJQxiZwen5URbDT07I1RtyIShwSqgw77e
	42MWVmTtm56P+7fX19M8SUA11Xxv3sUmz/l+sN+4VIFK0Fv23bZi4H0ku3xNoFrw
	0yGI6jdzjK+QOTizAovkEqWjzV3cuG+hOywDpJ7d9cXCqSjhH4Sr04XLCW+MCfQ7
	oJSo4RHLkRef8drglnebCuposxKf0ICIBIS916WUjPUIEJ7DjlVK3k3e0gCVrcCe
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Q5fR_TXDEyuk; Sun, 30 Jun 2024 22:32:10 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3ng2bY2zll9fH;
	Sun, 30 Jun 2024 22:32:07 +0000 (UTC)
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
Subject: [PATCH 38/53] scsi: qla4xxx: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:56 -0700
Message-ID: <20240630222904.627462-39-bvanassche@acm.org>
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
 drivers/scsi/qla4xxx/ql4_os.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.=
c
index 17cccd14765f..267c459376ed 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -8630,7 +8630,6 @@ static int qla4xxx_probe_adapter(struct pci_dev *pd=
ev,
 	struct Scsi_Host *host;
 	struct scsi_qla_host *ha;
 	uint8_t init_retry_count =3D 0;
-	char buf[34];
 	struct qla4_8xxx_legacy_intr_set *nx_legacy_intr;
 	uint32_t dev_state;
=20
@@ -8805,8 +8804,8 @@ static int qla4xxx_probe_adapter(struct pci_dev *pd=
ev,
 	/* Startup the kernel thread for this host adapter. */
 	DEBUG2(printk("scsi: %s: Starting kernel thread for "
 		      "qla4xxx_dpc\n", __func__));
-	sprintf(buf, "qla4xxx_%lu_dpc", ha->host_no);
-	ha->dpc_thread =3D create_singlethread_workqueue(buf);
+	ha->dpc_thread =3D
+		create_singlethread_workqueue2("qla4xxx_%lu_dpc", ha->host_no);
 	if (!ha->dpc_thread) {
 		ql4_printk(KERN_WARNING, ha, "Unable to start DPC thread!\n");
 		ret =3D -ENODEV;

