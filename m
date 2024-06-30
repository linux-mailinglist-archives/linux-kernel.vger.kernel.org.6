Return-Path: <linux-kernel+bounces-235371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BC91D47F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C1280DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570784039;
	Sun, 30 Jun 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y0nWq8Y5"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185B83CD4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786662; cv=none; b=VJVReR0eAto+hatlnpvGhqr5uSOA9N0Z+5kwXR1Lu9WPcLMsWjBh8GujH9/NMlsajRD5Lzh4k9IHJVJqYKfjFsH+ilpICkZv7erAU6YedpciFNSfGYJXLLZ4/u/MQR1V+q4n1wfl6498biaa9T09aJtl2CCQCsjPkUd+TkBI+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786662; c=relaxed/simple;
	bh=J694ELdfjLmdyGInb68OzeENWwGlOimhQBp+pEVZY9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzlqFEZxKnTzvQUT1aXYrY0yw7PCjsduvrp75LpEKRjnL6D53j+NDo1aTPrHQaITQ/eTMnMhiXN+T9kC9hDGw+0IP+5GMthti8TBSbqPfhPlwEyzl57kWAHa0EwdwDak8RiBvbjXjMj9vYdocprS0qUnaSp5sEED08ItT0VHkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y0nWq8Y5; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mN2Tg4zll9fH;
	Sun, 30 Jun 2024 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786653; x=1722378654; bh=2dTgy
	G95XyM7oFtp5b7rQCxQjmLlGb8T3I8dEwaTlbg=; b=Y0nWq8Y5PnUO0+2oYkOgl
	+ujXeqaHmIKnyUr/a4IWy9WoXIV9ZgXy0kCl93JboSoyil6sGQ+I1jLUoMdVRkDi
	lGVMhAtcAcS1taxBWEShNvZpB7u1ParDdC9g2ACOdIIkkeQ6RC1euwMwn6jXof1c
	5ec9BDtdpetBqB7or14sTZuH8kq/JZWIuZOKVfGTvOPYc0ZI6tlRpiiH9VximJ08
	9Hgx/CVroawRBcugFoCrPMs0RMiV63WQkB/35bRJhjdeBLs9RafjVo42pxXjz8sg
	oO6GVMbAadY9IONlMietUd0+jQYoQudGsOLf+LUzwo1xyqorR9OKD6yb9WengM1y
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5-UlTGUs2Vtm; Sun, 30 Jun 2024 22:30:53 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mB03jczll9f8;
	Sun, 30 Jun 2024 22:30:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Oded Gabbay <ogabbay@kernel.org>,
	Tomer Tayar <ttayar@habana.ai>,
	Farah Kassabri <fkassabri@habana.ai>,
	Ofir Bitton <obitton@habana.ai>,
	Koby Elbaz <kelbaz@habana.ai>,
	Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Ohad Sharabi <osharabi@habana.ai>,
	Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 21/53] accel/habanalabs: Simplify the workqueue creation calls
Date: Sun, 30 Jun 2024 15:26:39 -0700
Message-ID: <20240630222904.627462-22-bvanassche@acm.org>
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

Pass a format string to the workqueue creation calls instead of formattin=
g
the workqueue name before a workqueue creation macro is used.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/accel/habanalabs/common/device.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/hab=
analabs/common/device.c
index 8f92445c5a90..e44c8352c1da 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -831,7 +831,6 @@ static void device_release_watchdog_func(struct work_=
struct *work)
 static int device_early_init(struct hl_device *hdev)
 {
 	int i, rc;
-	char workq_name[32];
=20
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
@@ -883,8 +882,8 @@ static int device_early_init(struct hl_device *hdev)
 	}
=20
 	for (i =3D 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
-		snprintf(workq_name, 32, "hl%u-free-jobs-%u", hdev->cdev_idx, (u32) i)=
;
-		hdev->cq_wq[i] =3D create_singlethread_workqueue(workq_name);
+		hdev->cq_wq[i] =3D create_singlethread_workqueue2(
+			"hl%u-free-jobs-%u", hdev->cdev_idx, i);
 		if (hdev->cq_wq[i] =3D=3D NULL) {
 			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
 			rc =3D -ENOMEM;
@@ -892,16 +891,16 @@ static int device_early_init(struct hl_device *hdev=
)
 		}
 	}
=20
-	snprintf(workq_name, 32, "hl%u-events", hdev->cdev_idx);
-	hdev->eq_wq =3D create_singlethread_workqueue(workq_name);
+	hdev->eq_wq =3D
+		create_singlethread_workqueue2("hl%u-events", hdev->cdev_idx);
 	if (hdev->eq_wq =3D=3D NULL) {
 		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
 		rc =3D -ENOMEM;
 		goto free_cq_wq;
 	}
=20
-	snprintf(workq_name, 32, "hl%u-cs-completions", hdev->cdev_idx);
-	hdev->cs_cmplt_wq =3D alloc_workqueue(workq_name, WQ_UNBOUND, 0);
+	hdev->cs_cmplt_wq =3D alloc_workqueue("hl%u-cs-completions", WQ_UNBOUND=
,
+					    0, hdev->cdev_idx);
 	if (!hdev->cs_cmplt_wq) {
 		dev_err(hdev->dev,
 			"Failed to allocate CS completions workqueue\n");
@@ -909,8 +908,8 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_eq_wq;
 	}
=20
-	snprintf(workq_name, 32, "hl%u-ts-free-obj", hdev->cdev_idx);
-	hdev->ts_free_obj_wq =3D alloc_workqueue(workq_name, WQ_UNBOUND, 0);
+	hdev->ts_free_obj_wq =3D alloc_workqueue("hl%u-ts-free-obj", WQ_UNBOUND=
,
+					       0, hdev->cdev_idx);
 	if (!hdev->ts_free_obj_wq) {
 		dev_err(hdev->dev,
 			"Failed to allocate Timestamp registration free workqueue\n");
@@ -918,8 +917,8 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cs_cmplt_wq;
 	}
=20
-	snprintf(workq_name, 32, "hl%u-prefetch", hdev->cdev_idx);
-	hdev->prefetch_wq =3D alloc_workqueue(workq_name, WQ_UNBOUND, 0);
+	hdev->prefetch_wq =3D
+		alloc_workqueue("hl%u-prefetch", WQ_UNBOUND, 0, hdev->cdev_idx);
 	if (!hdev->prefetch_wq) {
 		dev_err(hdev->dev, "Failed to allocate MMU prefetch workqueue\n");
 		rc =3D -ENOMEM;
@@ -938,8 +937,8 @@ static int device_early_init(struct hl_device *hdev)
=20
 	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
=20
-	snprintf(workq_name, 32, "hl%u_device_reset", hdev->cdev_idx);
-	hdev->reset_wq =3D create_singlethread_workqueue(workq_name);
+	hdev->reset_wq =3D create_singlethread_workqueue2("hl%u_device_reset",
+							hdev->cdev_idx);
 	if (!hdev->reset_wq) {
 		rc =3D -ENOMEM;
 		dev_err(hdev->dev, "Failed to create device reset WQ\n");

