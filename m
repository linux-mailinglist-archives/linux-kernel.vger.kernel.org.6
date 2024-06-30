Return-Path: <linux-kernel+bounces-235386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD991D48E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BE280C66
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46C12BE91;
	Sun, 30 Jun 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hXpZYijm"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732115B542
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786731; cv=none; b=i6fIfFDqqn95lrm+b1xArmuv1PJKic17QL0rRx2dX7K0Yy0IsOzFItttYYyEA8I//k1/GQJKrAcIrj7HJQazwOgEov4yoF+LdOXQbhfSBKrkCVTUPbknEQWyLfeRd+SGFRU96DDV4KVBDj75DWaEyiZQpz6mN9r17gxlfdWNgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786731; c=relaxed/simple;
	bh=im4ccDaP6cQK3ISCu1eFsSQDCXWqsImPyYzwcQLTJPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4BcPTF+LWi4918JA68avm21wxzNNOsmrSRlvSOqd49h0i0Rxl5zU9B2wZRwdcD2Qxe7NmOdS6cFWfuPshZNGjN6nhRSGk3Jwx6MNDz9zzVbax+u7t5i7B2exuW6+oP/hWNY9Amenlk4NOe8J9Lwyrdn5f2mq6yMshK4e97BVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hXpZYijm; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nj54Tkzll9fB;
	Sun, 30 Jun 2024 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786726; x=1722378727; bh=JmwcS
	856Hhimm6mFyoc/N2c37eWnPQzPr87O6ssw5RA=; b=hXpZYijmkTpsLw3m+abx6
	dQ8AyWUz3vTaWguQEZ8LtmSYLG27SXy65NtpysBB48BFqXFnynyNDGvA3ChxEoUM
	cmPl9ZED99OdJ1rXxVSqax/nl5L0l5o3TqglX10/qGSEVjPcwmzu9b+BEC7Otdh1
	KRpV1LPZcGrQKKUWCICiI+GV/j9F/LOGmmSWJUixu0VmZ3NxyPpKDQrrlIVD+6S5
	OKV1eN0hnlRuvL6L6FeaW+o6f67lpmHDC5DGS60D9zXLH+ss1VTnL5XcCTZF3fuW
	3r3nS0xvo/jDUZkLvNNi3PAsn6oIoAJA+JqbF4bccffU36hyQBG6LHOaShOZfbOC
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7Oi1tTGDz27s; Sun, 30 Jun 2024 22:32:06 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nc2mZrzll9f8;
	Sun, 30 Jun 2024 22:32:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 37/53] scsi: qla2xxx: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:55 -0700
Message-ID: <20240630222904.627462-38-bvanassche@acm.org>
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
 drivers/scsi/qla2xxx/qla_os.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
index fcb06df2ce4e..f3f4972962f0 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2915,7 +2915,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struc=
t pci_device_id *id)
 	scsi_qla_host_t *base_vha =3D NULL;
 	struct qla_hw_data *ha;
 	char pci_info[30];
-	char fw_str[30], wq_name[30];
+	char fw_str[30];
 	struct scsi_host_template *sht;
 	int bars, mem_only =3D 0;
 	uint16_t req_length =3D 0, rsp_length =3D 0;
@@ -3505,12 +3505,12 @@ qla2x00_probe_one(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	INIT_WORK(&ha->board_disable, qla2x00_disable_board_on_pci_error);
=20
 	if (IS_QLA8031(ha) || IS_MCTP_CAPABLE(ha)) {
-		sprintf(wq_name, "qla2xxx_%lu_dpc_lp_wq", base_vha->host_no);
-		ha->dpc_lp_wq =3D create_singlethread_workqueue(wq_name);
+		ha->dpc_lp_wq =3D create_singlethread_workqueue2(
+			"qla2xxx_%lu_dpc_lp_wq", base_vha->host_no);
 		INIT_WORK(&ha->idc_aen, qla83xx_service_idc_aen);
=20
-		sprintf(wq_name, "qla2xxx_%lu_dpc_hp_wq", base_vha->host_no);
-		ha->dpc_hp_wq =3D create_singlethread_workqueue(wq_name);
+		ha->dpc_hp_wq =3D create_singlethread_workqueue2(
+			"qla2xxx_%lu_dpc_hp_wq", base_vha->host_no);
 		INIT_WORK(&ha->nic_core_reset, qla83xx_nic_core_reset_work);
 		INIT_WORK(&ha->idc_state_handler,
 		    qla83xx_idc_state_handler_work);

