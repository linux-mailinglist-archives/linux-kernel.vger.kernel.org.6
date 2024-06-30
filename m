Return-Path: <linux-kernel+bounces-235395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739291D497
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3951C20C28
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121A15F30F;
	Sun, 30 Jun 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AnfwOvHw"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376F15EFC5
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786754; cv=none; b=PmspxBYHMVM5QG0EgkN+8dSJ4zIyMvlXC2GkzR8EFth02tzUWIgdMtFcQ7mI4eH4FijmZd3ieULZfoyi9Kb0pbaVeiQcGaOr+kiiUt2IRg+mzRRgOWDA2aKV5McgebGd1KAbV4qyDsO2JiQs8XrItSOTO7gJYp+rxVHQZvHj03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786754; c=relaxed/simple;
	bh=t5AAEwINeWexrCES2c+PGUU6tGYhoc1t9W67Po8RaKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpl3TfpOfxolD104k6Sgip0Ktr3ZlThiZLKrXR+C8v/Dv90h52+xHSXMlZkaBU2lk17nrpwnB5bp3MCEEzAswsuGyRC0ufyIZ+jThGzqpUgQ7lDTtc/QTFBsdxqwQvU/rHJlWYTiLNlqhpawKz9ufyEd9Shz8g9d2arhdGw0u1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AnfwOvHw; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3p8646Vzll9f8;
	Sun, 30 Jun 2024 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786750; x=1722378751; bh=zmf2L
	2XJYAXAuFcOM9Aj8scqypN12DmjiGX8ibydvzo=; b=AnfwOvHwjTXKuE+GRNTwt
	49RZuHkOZmMCEI5LVMHcUEZ1ZOIgFz3JsCZSSN+m+aKxXLBiWrsMvl7AMobev8cE
	ueu7G3NTDM94Hw22Czq3Bsh2nOxlTfUMy9U2UVEBfC0leHoYunNUe9KwCRc8r5Yd
	X0SMUm7DNHpCxbnC8B37zM+lxrAqJBDYXa7l2jbP85oznYf/rn0XA2jWNbsQBUIM
	bb+Qg/BOFzN6pjoEzq73av3N9uAg+9TsGyEPQkOMIqDuC5viYEjA8zcB98vm6RXF
	p0C9DgevZMpolSQT/he5q94FJIeBfaH3khYEQ9DWVOnFlcwvDxIYVCtP/wCigw9M
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 88IV8wjDyOQh; Sun, 30 Jun 2024 22:32:30 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3p506F8zll9fB;
	Sun, 30 Jun 2024 22:32:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 46/53] scsi: core: Simplify the alloc_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:04 -0700
Message-ID: <20240630222904.627462-47-bvanassche@acm.org>
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

Pass a format string to alloc_workqueue2() instead of formatting the
workqueue name before alloc_workqueue() is called.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hosts.c     | 9 ++++-----
 include/scsi/scsi_host.h | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 7f987335b44c..e021f1106bea 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -292,11 +292,10 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost,=
 struct device *dev,
 	}
=20
 	if (shost->transportt->create_work_queue) {
-		snprintf(shost->work_q_name, sizeof(shost->work_q_name),
-			 "scsi_wq_%d", shost->host_no);
-		shost->work_q =3D alloc_workqueue("%s",
-			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
-			1, shost->work_q_name);
+		shost->work_q =3D alloc_workqueue(
+			"scsi_wq_%d",
+			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND, 1,
+			shost->host_no);
=20
 		if (!shost->work_q) {
 			error =3D -EINVAL;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 19a1c5c48935..2b4ab0369ffb 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -677,7 +677,6 @@ struct Scsi_Host {
 	/*
 	 * Optional work queue to be utilized by the transport
 	 */
-	char work_q_name[20];
 	struct workqueue_struct *work_q;
=20
 	/*

