Return-Path: <linux-kernel+bounces-235389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA391D491
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B609F2812E2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74615DBAF;
	Sun, 30 Jun 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gu2/GLzL"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8B15D5B6
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786739; cv=none; b=NmB+V2AmEl5z1pRD5EsnlSbpCXNZQngctmxz9Lfr3Hp330cF4Xz1Ot0GtjcdKfknuJvXTswF82YiAyG3gA6urgNPOUigNTJ2XLgGLZXq4bZr9yspN8RZHeHnQq0jLp7fETmXvd39xtdUySVPhARXxfXtB7Q5GHbQeCSJL6KTYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786739; c=relaxed/simple;
	bh=1i1NB84afGRmdh++Uorf6DrpSO9XH3uh5/qZQOeo7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXE4CnOTBpm41cfsshuhkP/X1eCuzeUybnjCp/iJg3alFBFmliAUnsW3WvdHTXAMFGpx2kcVC8wYOGkAiZtBnnCONPNrM/UXfWuFeVHiwBDBkuagDS1NSl6OmtiZR+VQnwr2o7lLIqhqeO7Zo6YF5ppC4Y7WLDOWLhNlQq6/p6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gu2/GLzL; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3ns2X6kzll9fH;
	Sun, 30 Jun 2024 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786735; x=1722378736; bh=R6HhT
	j8CjEVoryVHWYPdccbFEjIcnVgyfnGqry54LaY=; b=gu2/GLzLyBJCGkxuJ63k7
	phIMTFW4yqoE61roS1KTHmRJGrzBO0iD1l3qocp7ws6lk43rSi+YTBuovV3O4WJS
	QlwWyCScK4PdL1Jgf3n6e/SwMlKfjw971wLjA/lIVmOxpXLwAKc8bViPkPfDSHbc
	DLyXTXTtshWLNCUXQFrsfafJGU3OUTLaHehrfsK7g6o+BccY7DMi0rO0K+7Acwq9
	R/sHrAhujGdiIbU/O4yGfd6P6S68cmXf9I9+hQmP/e3CTnIVmhyU5lQ+wQTm3hwe
	nSV+uT7TyeoiVGANjzN7bEkfK/6WsPQL1+Lwtc0gTlv/Q6vE3+tC3bK+tRVbWlJ3
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 353jKmIJOZAd; Sun, 30 Jun 2024 22:32:15 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nn1FyZzll9fB;
	Sun, 30 Jun 2024 22:32:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 40/53] scsi: myrb: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:58 -0700
Message-ID: <20240630222904.627462-41-bvanassche@acm.org>
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
 drivers/scsi/myrb.c | 5 ++---
 drivers/scsi/myrb.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index f684eb5e0489..6e8f056c0939 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -112,9 +112,8 @@ static bool myrb_create_mempools(struct pci_dev *pdev=
, struct myrb_hba *cb)
 		return false;
 	}
=20
-	snprintf(cb->work_q_name, sizeof(cb->work_q_name),
-		 "myrb_wq_%d", cb->host->host_no);
-	cb->work_q =3D create_singlethread_workqueue(cb->work_q_name);
+	cb->work_q =3D
+		create_singlethread_workqueue2("myrb_wq_%d", cb->host->host_no);
 	if (!cb->work_q) {
 		dma_pool_destroy(cb->dcdb_pool);
 		cb->dcdb_pool =3D NULL;
diff --git a/drivers/scsi/myrb.h b/drivers/scsi/myrb.h
index fb8eacfceee8..78dc4136fb10 100644
--- a/drivers/scsi/myrb.h
+++ b/drivers/scsi/myrb.h
@@ -712,7 +712,6 @@ struct myrb_hba {
 	struct Scsi_Host *host;
=20
 	struct workqueue_struct *work_q;
-	char work_q_name[20];
 	struct delayed_work monitor_work;
 	unsigned long primary_monitor_time;
 	unsigned long secondary_monitor_time;

