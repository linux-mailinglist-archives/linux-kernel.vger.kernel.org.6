Return-Path: <linux-kernel+bounces-235368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5091D47C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DE8280CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396F82D89;
	Sun, 30 Jun 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xZSmbUIr"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFA15748A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786648; cv=none; b=WZppk8fuxW1XEyDljN01D/ZpWyeRl+1z06bVcGLjLXW0+4xKlxxKL5dJz2UCJGUoAq9Nu3jJv+Ro94GwSc9PXysW/+1J48/9lyoCOFdLZgVNU0JtX8JhbvGDIt5P34MfQirS7XTLM5fAlCHuUOTibgKsXL1CajQAtPitLapf16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786648; c=relaxed/simple;
	bh=FQ+XKkitnfgi2rmixxoz3EPGX5Qp1VqhNR3dZVh3V0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDG+BeulWGr9SyE47hDUR1scERuHZDdksSqUPih2T6/rVq+lCTHpHm3PdvGo4cB0cfvSeEw+lzax5MZN0AJSJX5OBiHOUmv8QmMesJUoWVfTnPMxughdHxoJPVSTHvNcTIyiEafWKv2mjf12TYw4vLGyCb7v4QoEE6L8ygTUg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xZSmbUIr; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3m56FrJzll9fH;
	Sun, 30 Jun 2024 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786643; x=1722378644; bh=AxJ4D
	0xm1BpSwSj4KLJ8NjNjhvUr4DyfcHdrGRJ5yts=; b=xZSmbUIrgpOHqkZqcHVMR
	BdUrGLFffTqeIYvtHDQTvpSpDxZAm4lpUdXddC7kaJTDcLmuJGQSoJSwcKsqyEVX
	EXrieLwttJcY/gRdMIcU/4jC4ClqALB34A4YjC+6WltIPjnItr2QlhHlFWaFczf6
	jc/Od8D/QQnx6mrJbND6bBQyuncrgBuZa+muYLNC+xYKG+d4u2JCmSJ6CvGXUkZc
	WCubns8+OOVtu1lTNHeJ7c+Ey7589h0ae3zHM8Gv08Q2n9wgzvV5KwTEj+TktcEv
	n9TnEuDGLT/Ztq7PCf4pFlFu/Adtz6S8S9mFeYZYp0luv5UYtvv+2hc9iqZi0JJ1
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WjyB8lKMN2oJ; Sun, 30 Jun 2024 22:30:43 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3m15Fcpzll9fB;
	Sun, 30 Jun 2024 22:30:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 19/53] scsi: hisi_sas: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:37 -0700
Message-ID: <20240630222904.627462-20-bvanassche@acm.org>
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

Prepare for removal of the create*_workqueue() macros.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sa=
s/hisi_sas_main.c
index ec1a3e7ee94d..ba6f20baf6ae 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2302,7 +2302,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
=20
 	hisi_hba->last_slot_index =3D 0;
=20
-	hisi_hba->wq =3D create_singlethread_workqueue(dev_name(dev));
+	hisi_hba->wq =3D create_singlethread_workqueue2("%s", dev_name(dev));
 	if (!hisi_hba->wq) {
 		dev_err(dev, "sas_alloc: failed to create workqueue\n");
 		goto err_out;

