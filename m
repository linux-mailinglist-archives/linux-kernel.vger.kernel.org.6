Return-Path: <linux-kernel+bounces-235394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE891D496
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B341F21636
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9615EFB9;
	Sun, 30 Jun 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sh8XUGBZ"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56515ECF9
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786752; cv=none; b=Vg/24qu0Xpm4EZPK3RNPtQxU3Psl9UZ8nWn53qwBMFmI4zcVL59i4BmyXgST9miaJUoTAMDOgmjcd4vHnnW3sZkQ4CzF2ANyOd/b9L4QK6G3cIQNhd2uf2O4+5nzphiMqNRy8xyLsidZSZ113UdSTUsz8/zvtlHQFUZzjDwNkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786752; c=relaxed/simple;
	bh=f9Xdj0fdPGj+1XFgr1Km0HAEkcNrA8a+F/U0ITVDNrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjzYbLXvSYfOcLrlwCfISwckfddg83HA6IQ3ak0gFscIhUXYs7b5Ads7otEetacmVFtJmNAM3/q74EHxOS2B0o1OGpmG3W33TzKobjjGdus5wXWcphLPkFKA3SMHxVVcBX/B/TAp1Tf5wbAD+cWr+F4szLMDutshzTrf+2LVsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sh8XUGBZ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3p64GpHzll9fH;
	Sun, 30 Jun 2024 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786748; x=1722378749; bh=w8Ixg
	i3TboA5YkYYZNzpEVQGWOWUom+zySWhuTkewD0=; b=sh8XUGBZfuJmDQfKCLq7a
	NM0t4Q97/xXRPu4vNQHtAneTa5lgkIF/3Cu9omUvx0oYbz3scfpq0yn/hE4xLZcx
	NYYnaqlze2YsCoSzxtPlbBjV/ervRn9tCQ1+DCG49H3C0M8WEH7vi6wzLmTRxJbT
	UQb2xz2yaf7/mu4QIt/lwrcEgcZ0v9Zfa6n32q/r0S9j8+uLE9e6Tluz4vPhVmO1
	WxnlESlkfBiKLEOomMiwpxjucgh+kZ9bCn2a3qFK02P5EwBZ9o/RfcUNi2Y/CCnh
	ML5QjuXkWz5FdD7k+C8owerm2ms/+Dnml0QTGwdzYZ+gWwlG/SFh2kevfTeRVojo
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6B8WLn9WyIVW; Sun, 30 Jun 2024 22:32:28 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3p23rk9zll9fT;
	Sun, 30 Jun 2024 22:32:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 45/53] scsi: scsi_transport_fc: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:03 -0700
Message-ID: <20240630222904.627462-46-bvanassche@acm.org>
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
 drivers/scsi/scsi_transport_fc.c | 4 +---
 include/scsi/scsi_transport_fc.h | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transpo=
rt_fc.c
index 7d088b8da075..d07e82fd82a8 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -441,9 +441,7 @@ static int fc_host_setup(struct transport_container *=
tc, struct device *dev,
 	fc_host->next_vport_number =3D 0;
 	fc_host->npiv_vports_inuse =3D 0;
=20
-	snprintf(fc_host->work_q_name, sizeof(fc_host->work_q_name),
-		 "fc_wq_%d", shost->host_no);
-	fc_host->work_q =3D alloc_workqueue("%s", 0, 0, fc_host->work_q_name);
+	fc_host->work_q =3D alloc_workqueue("fc_wq_%d", 0, 0, shost->host_no);
 	if (!fc_host->work_q)
 		return -ENOMEM;
=20
diff --git a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transpo=
rt_fc.h
index 4b884b8013e0..b0688652ce39 100644
--- a/include/scsi/scsi_transport_fc.h
+++ b/include/scsi/scsi_transport_fc.h
@@ -575,7 +575,6 @@ struct fc_host_attrs {
 	u16 npiv_vports_inuse;
=20
 	/* work queues for rport state manipulation */
-	char work_q_name[20];
 	struct workqueue_struct *work_q;
 	char devloss_work_q_name[20];
 	struct workqueue_struct *devloss_work_q;
@@ -654,8 +653,6 @@ struct fc_host_attrs {
 	(((struct fc_host_attrs *)(x)->shost_data)->next_vport_number)
 #define fc_host_npiv_vports_inuse(x)	\
 	(((struct fc_host_attrs *)(x)->shost_data)->npiv_vports_inuse)
-#define fc_host_work_q_name(x) \
-	(((struct fc_host_attrs *)(x)->shost_data)->work_q_name)
 #define fc_host_work_q(x) \
 	(((struct fc_host_attrs *)(x)->shost_data)->work_q)
 #define fc_host_devloss_work_q_name(x) \

