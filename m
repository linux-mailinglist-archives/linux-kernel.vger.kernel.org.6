Return-Path: <linux-kernel+bounces-235373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9B91D481
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C31F21433
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA7158D98;
	Sun, 30 Jun 2024 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Aja4yBR6"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857882C7E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786670; cv=none; b=MKBtCGUiWBmPYjwDlhaLFlLryJ/EAUN33rOXMYNBlip64P7/7dRWArvOHX4wD1ACWptlFLK+QVZEaD2ZC6gkgf64Q8OVi9tGHzFAPkGvlWTMR4GEqMZFcSeLmgHYeHbnQ3HkFksE4j/foJAXanl3RbGNemEgtPpB8MkpfDC4W+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786670; c=relaxed/simple;
	bh=ezLlTU4maR6OueVApYNoPiTBFyu3ffFHuXsLfjbsLp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8NpCwsqtVml77mrZjHFSt28qC+GIvjjiLU6LTzdyacoQpvTSaR2LMOATq/yGSXyF2eCIKcaGpHeXLL75+KkglHceAGfij/0vnktDQXKO6ertZ4geRWpyXGMVOUkO3hUyVlaDfUz324RcudCcn2aZkxWMlZPWUAy7IwIKpjmNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Aja4yBR6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mY1Qskzll9fK;
	Sun, 30 Jun 2024 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786665; x=1722378666; bh=ePYbb
	YHZeTUdcl7fHjq47Yfvtt6Ljg4vrQ2h4XhXRcQ=; b=Aja4yBR6YChKQOGaau2AO
	Obrv4igz8fcPUbbQtu07NULfZpNSb0F9MyG9p8JdHIpt+kQQrmIs047kVksegrmA
	0atQSujVFblBT1olWZJR48zVO9NgDeK5aUzsjv9HMrrLVNyYpadGuaITdn1GEobn
	kr5Lxm5MGHLYKLAQ02Jlgi89IAgzNXAc3HvEqRuAI8ZhmkQur0PgkfVyaSXVFadW
	0bhbRFDtqNXHmfzksG+eckYhJ8WGv5wHKaloA70LAOfrhYzE4nkos7wB8Da3UC5s
	xToCc92dIY0ynFYG3sZ4/+2jjcJ91aXCU8hWYBST2nxPQpCw+qY+RCN0zSD0RZoW
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id A4s102yaZ_eu; Sun, 30 Jun 2024 22:31:05 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mP66lszll9f8;
	Sun, 30 Jun 2024 22:31:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 24/53] net: bna: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:42 -0700
Message-ID: <20240630222904.627462-25-bvanassche@acm.org>
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 4 ++--
 drivers/net/ethernet/brocade/bna/bnad.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethern=
et/brocade/bna/bnad.c
index fe121d36112d..7d482e8b0949 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3488,8 +3488,8 @@ bnad_init(struct bnad *bnad,
 	bnad->tx_coalescing_timeo =3D BFI_TX_COALESCING_TIMEO;
 	bnad->rx_coalescing_timeo =3D BFI_RX_COALESCING_TIMEO;
=20
-	sprintf(bnad->wq_name, "%s_wq_%d", BNAD_NAME, bnad->id);
-	bnad->work_q =3D create_singlethread_workqueue(bnad->wq_name);
+	bnad->work_q =3D
+		create_singlethread_workqueue2("%s_wq_%d", BNAD_NAME, bnad->id);
 	if (!bnad->work_q) {
 		iounmap(bnad->bar0);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethern=
et/brocade/bna/bnad.h
index 10b1e534030e..0d70b1df1793 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.h
+++ b/drivers/net/ethernet/brocade/bna/bnad.h
@@ -346,7 +346,6 @@ struct bnad {
 	char			adapter_name[BNAD_NAME_LEN];
 	char			port_name[BNAD_NAME_LEN];
 	char			mbox_irq_name[BNAD_NAME_LEN];
-	char			wq_name[BNAD_NAME_LEN];
=20
 	/* debugfs specific data */
 	char	*regdata;

