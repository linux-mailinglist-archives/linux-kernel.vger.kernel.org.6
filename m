Return-Path: <linux-kernel+bounces-235392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27291D494
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983D91F2158B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427D15ECDF;
	Sun, 30 Jun 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UAQgHuBJ"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353815ECCA
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786746; cv=none; b=AETR82DuHKZQyw/vCENeGvN3+b/Zm/85BPQiic6nhn9Ji1OHAZJyYK9xqqAlqvbK5Rva+7FQFoaIeh4Cqj2aSdryuWqunX5RPk32mMSfJH0yWSvlVZH4DpLmIgNA49Qw5GuXbxFkdcosYE1rzEu4vqp9dGBYNUhmNdTBhLYoGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786746; c=relaxed/simple;
	bh=k2trLsMOA31pjCa29RBBCvkqJQJ+nH1AAxxBJ5CJINU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx0RMQcWiACCuIX0vTB8pWWiGvk8Ei1/IL+jmu7Tg+cdLnK9bBpaLIqggDQIa7W4ViXsawiDfsYAjedBFJiGKD0+lLGU2jauWR4lX0aa77HC2iqDBAtuEV0hb9bh7TwJAuQgroPIpX4E37ztBvr6OZzcncqFBUudTZ3bqEdyO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UAQgHuBJ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3p12qyjzll9fS;
	Sun, 30 Jun 2024 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786743; x=1722378744; bh=JlTnq
	jTszJXpQsv1V/W6evOa8QZEQk72FGtxKzWEViE=; b=UAQgHuBJZTjHAFpZMQIqz
	W0oPx4zCI/wat54aK5mBmikZn5qiIs5bF6nbuOSPCRr/kSmRaYJZ1hDBJPEcWc0S
	AnlnmyLLNWQDFjBmw4nEHKTaZRu2NyoUY3GywMUgIG3MIMeRyvaM8vpFQZ1gVuKk
	c30PX3fmQYw91CB/GzLhPNuVgPp++2bWpDhlTjZJ9t+0Ha0erNpm+FY0znAPX51G
	nsOU4LV8hJQub0siVZKnaHVlWd1XHn0YLxMl1DiqIsXsc6nOXGvP0H4lRiZBem1A
	LwwRh+YxY2azacpOG4f0cYjT+NyixS53AHOku5xJsolRTecdvwaMVl5ZgaataKZH
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tqQziNQuTTbW; Sun, 30 Jun 2024 22:32:23 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nw6QPZzll9fB;
	Sun, 30 Jun 2024 22:32:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 43/53] scsi: fcoe: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:01 -0700
Message-ID: <20240630222904.627462-44-bvanassche@acm.org>
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
 drivers/scsi/fcoe/fcoe_sysfs.c | 7 +------
 include/scsi/fcoe_sysfs.h      | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysf=
s.c
index 453665ac6020..d534f4007399 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -45,8 +45,6 @@ MODULE_PARM_DESC(fcf_dev_loss_tmo,
  */
 #define fcoe_ctlr_id(x)				\
 	((x)->id)
-#define fcoe_ctlr_work_q_name(x)		\
-	((x)->work_q_name)
 #define fcoe_ctlr_work_q(x)			\
 	((x)->work_q)
 #define fcoe_ctlr_devloss_work_q_name(x)	\
@@ -797,10 +795,7 @@ struct fcoe_ctlr_device *fcoe_ctlr_device_add(struct=
 device *parent,
=20
 	ctlr->fcf_dev_loss_tmo =3D fcoe_fcf_dev_loss_tmo;
=20
-	snprintf(ctlr->work_q_name, sizeof(ctlr->work_q_name),
-		 "ctlr_wq_%d", ctlr->id);
-	ctlr->work_q =3D create_singlethread_workqueue(
-		ctlr->work_q_name);
+	ctlr->work_q =3D create_singlethread_workqueue2("ctlr_wq_%d", ctlr->id)=
;
 	if (!ctlr->work_q)
 		goto out_del;
=20
diff --git a/include/scsi/fcoe_sysfs.h b/include/scsi/fcoe_sysfs.h
index 4b1216de3f22..45b1e9ca92e9 100644
--- a/include/scsi/fcoe_sysfs.h
+++ b/include/scsi/fcoe_sysfs.h
@@ -50,7 +50,6 @@ struct fcoe_ctlr_device {
 	struct fcoe_sysfs_function_template *f;
=20
 	struct list_head		fcfs;
-	char				work_q_name[20];
 	struct workqueue_struct		*work_q;
 	char				devloss_work_q_name[20];
 	struct workqueue_struct		*devloss_work_q;

