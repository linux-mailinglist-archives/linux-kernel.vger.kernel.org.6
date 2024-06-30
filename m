Return-Path: <linux-kernel+bounces-235372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6691D480
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0FE1F21433
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19D158D6D;
	Sun, 30 Jun 2024 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zn7Yo3ze"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7B158D63
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786666; cv=none; b=u++NU0bxJGqgcXtc6D5iUSXW2S5/D/lBVQ0aczc1P30B+YZdIZiPjS9lzYtXmTPH5tTFOVBTC1va1AUZR4bSPX9kfaCddjIgmqabGdKHotJUJg9GNgd2Fzpn5A0UJiZTQmvEmPgUTidT43tGrYhWptMdr4g53vCalth3Q1b13Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786666; c=relaxed/simple;
	bh=UuDxY7u22AzS9M8sN4VU94lU+LE25fGLXnui4eBkQDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLeS84/KwL5iv4WiFYNLByoSoJi97hNQOUaRrTAGXo6r6Tl1khsJsFtAJU+KnJFmEMLJ9MkDZP8d8DzOy+14MN3lOSK0zP+JuxYrv03+isBdfhiWNTFGsuJkfp0veYBOUQZj67d8e2L35bMPuIj81znsR9w9YxvoFZGLd/sYb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zn7Yo3ze; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mS4p2fzll9fB;
	Sun, 30 Jun 2024 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786661; x=1722378662; bh=4+o4R
	oKEIfzeDvfKwNjqXAX+FHCNFVnsQV8PCPGFeDw=; b=zn7Yo3ze/Vxb9PERoIgVK
	aa4/+nPA3pWVej/CzonDv4K+bcdVVzw+dLpug8Nr2yBoj5oazP+434MNUz3j/OMN
	ZWnu78khYwbpsUnrdVLJPqhc2V9HSK+xvecVpSZvnNRTp6DADC7gHGCwNG3RREb4
	LYTq+RwgW7S9eFSNwxmyucUfjoWuRNB0jFu0wbNr/FfPKacJ1KkJvAFP0HM3ROP4
	HDPKupwjiCwT+dJgeu6qfC9EzhmGfyBbbxrBPBhXOzbCko/RhXvTxY7tyTh61tok
	jiTCN8RCsve7fOrSfmFMFwN1KE6F+nH98WbLW00TiyI+Q6BC5ux9qJkGhqJokHsX
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eGb5JTo8pDoq; Sun, 30 Jun 2024 22:31:01 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mK4KtHzll9fM;
	Sun, 30 Jun 2024 22:30:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 23/53] pds_core: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:41 -0700
Message-ID: <20240630222904.627462-24-bvanassche@acm.org>
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
 drivers/net/ethernet/amd/pds_core/main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ether=
net/amd/pds_core/main.c
index 660268ff9562..e2e49656c111 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -213,12 +213,9 @@ static const struct devlink_param pdsc_dl_params[] =3D=
 {
 			      pdsc_dl_enable_validate),
 };
=20
-#define PDSC_WQ_NAME_LEN 24
-
 static int pdsc_init_pf(struct pdsc *pdsc)
 {
 	struct devlink_health_reporter *hr;
-	char wq_name[PDSC_WQ_NAME_LEN];
 	struct devlink *dl;
 	int err;
=20
@@ -236,8 +233,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 		goto err_out_release_regions;
=20
 	/* General workqueue and timer, but don't start timer yet */
-	snprintf(wq_name, sizeof(wq_name), "%s.%d", PDS_CORE_DRV_NAME, pdsc->ui=
d);
-	pdsc->wq =3D create_singlethread_workqueue(wq_name);
+	pdsc->wq =3D create_singlethread_workqueue2("%s.%d", PDS_CORE_DRV_NAME,
+						  pdsc->uid);
 	INIT_WORK(&pdsc->health_work, pdsc_health_thread);
 	INIT_WORK(&pdsc->pci_reset_work, pdsc_pci_reset_thread);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);

