Return-Path: <linux-kernel+bounces-235388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B691D490
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70794B20901
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59E15CD79;
	Sun, 30 Jun 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ONmqs96i"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C315B984
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786736; cv=none; b=h+hGxZdSXySOm4htUCXCZKyKIudJB8EDulMrLvD4Aq4JHVoEjjXlek/Z45PJ+Qnnyzm0igvEcASaTZCPI4I7kxRds400KRKEK163G4q2EIJuOymMLtT7e2TNnDrZAtesHfb8Hp4oZxnNXCUlA9bzpS/dgGsP5U+Nm22+CqgKVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786736; c=relaxed/simple;
	bh=vkH8hZUY9cXFv7LkbVkGYa6EgSPPMM/5rV3WR0xbitI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVIBW+gymdrEujt77DQc/YrM49unBPPMT+Kmp5om8fmxAVASpbE355qfPbY9g+a42g+1jBr2r1AogWpfmoNdu6upRAuC7aANHN9RQJnjPTOmaPD+28Tf6V1ztHS+l6/HD0f/6t5QiRKsM0HzPKHUM9rshJ+tWGlqLUaiQMjKW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ONmqs96i; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3np6kGpzll9fM;
	Sun, 30 Jun 2024 22:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786732; x=1722378733; bh=bkBQK
	kTa34CihjBvX0RJ09hhIGM+KEH8plFaUTdp144=; b=ONmqs96i9CqZsYF7FNISl
	hImIVOXVGQDP/dvnUB4IiPXZfftyDmSnMpHDgM0bfsNduAju9sUu6ENxAMc/OjGv
	MJmGGAZfn3vIfGd33lMm4n6w61Vf/ZbaF8eOxSUq3dkoN2MFCFWRh6gzEuf748t0
	kzkDQKtQsqYa6Z1neDerZxEiAmDVLIRSur4DyG5R1Vmym8l24ayUdqBvJkkLuMEF
	yzJaa7HgQBmpG9ZWRjP3hY6P+Cu5Y5i1flY+327oA4iXwWtWex7ZYjMoZZPlIYm8
	lc/ernvl6BWPGmblNn/OuPmzBC2NXRB6qwPpZjDDkaZPgBSpxwyLALpadojH3HVk
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aFfFc4YqMLsa; Sun, 30 Jun 2024 22:32:12 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nk4PJJzll9fW;
	Sun, 30 Jun 2024 22:32:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 39/53] scsi: vmw_pvscsi: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:57 -0700
Message-ID: <20240630222904.627462-40-bvanassche@acm.org>
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
 drivers/scsi/vmw_pvscsi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index c4fea077265e..40ad8a3a32e0 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1123,8 +1123,6 @@ static void pvscsi_msg_workqueue_handler(struct wor=
k_struct *data)
=20
 static int pvscsi_setup_msg_workqueue(struct pvscsi_adapter *adapter)
 {
-	char name[32];
-
 	if (!pvscsi_use_msg)
 		return 0;
=20
@@ -1134,10 +1132,8 @@ static int pvscsi_setup_msg_workqueue(struct pvscs=
i_adapter *adapter)
 	if (pvscsi_reg_read(adapter, PVSCSI_REG_OFFSET_COMMAND_STATUS) =3D=3D -=
1)
 		return 0;
=20
-	snprintf(name, sizeof(name),
-		 "vmw_pvscsi_wq_%u", adapter->host->host_no);
-
-	adapter->workqueue =3D create_singlethread_workqueue(name);
+	adapter->workqueue =3D create_singlethread_workqueue2(
+		"vmw_pvscsi_wq_%u", adapter->host->host_no);
 	if (!adapter->workqueue) {
 		printk(KERN_ERR "vmw_pvscsi: failed to create work queue\n");
 		return 0;

