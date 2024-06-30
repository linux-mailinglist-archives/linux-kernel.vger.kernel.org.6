Return-Path: <linux-kernel+bounces-235379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93991D487
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A087F1F2158C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1015A85A;
	Sun, 30 Jun 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QKOIP7bB"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45D15A4BD
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786705; cv=none; b=qVZMZq4uG0H0e6CxM9amWBr/HRRmGPPTJg0/X2I/K7UME9BPRpTkTJOponnMQuHRCibpSxogAtpQ8HEmxk1APQEri44/KVhQozVlpdxmRuS+NMt93izAQ/DE1infJarLfSpWJHB5xzBJ/X3+gaQ8gMzoPoe0w/wIj2HmuvrxcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786705; c=relaxed/simple;
	bh=JSkHTlB7yZdplM/7G/qXLRG1GoBd+Q4wowBKQDCYLto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fivj5ov1rwWEoRAyJUBmh0ADHVe+vAr4t7/iDgPH2mDYJxvNpWoIF4y/Cmx5L4VXoFd1pHr+NYF0fMYtMZNSYgKqncpxD/zRMqmvzPhKG6Fy3HtYaSHp6imv//IN2uB54ZbRwwcxiRRoDK/DeDbudYg6TfZDbak25SwXFbkqkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QKOIP7bB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nC71Tnzll9fS;
	Sun, 30 Jun 2024 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786699; x=1722378700; bh=75WFP
	EdUXWblentuwvT78l/3oziSfkIkIK6jAXwSd+Q=; b=QKOIP7bB64mbQCfxJ/3LY
	DNpqXrQ2nSmZjHFU+rgWrKDcQJZ/NUgaH6xaJrDweyuv19cXhZkj3yc+R0CqhpGM
	JbBB8QzFJhx4gmZpdA9bewesZXLR4rVzAlHgaHhY0YVsriLIqKpChd0desOHMKxy
	M+jt44JsvhdjuBsFNbJMH95J68z6Vfp300ZEBWo89mCV23fJcTt7qhjdkgJH3o99
	ONqwKv4+0VpPwwrOynmJnLUYkOZPdZWgN8JqDWyj+EJksTrLsJtEWDEXS4931CAf
	S0XBkIF/4bW4E8h7oeMz6hAqxX46P3kJ+wivp7OIpltngR+BlZyFRut77nTeeDGK
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YIvhKeFffLTI; Sun, 30 Jun 2024 22:31:39 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3n41pQ3zll9fB;
	Sun, 30 Jun 2024 22:31:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 30/53] net: stmmac: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:48 -0700
Message-ID: <20240630222904.627462-31-bvanassche@acm.org>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..b47528ad4fb6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -343,7 +343,6 @@ struct stmmac_priv {
 	unsigned long fpe_task_state;
 	struct workqueue_struct *fpe_wq;
 	struct work_struct fpe_task;
-	char wq_name[IFNAMSIZ + 4];
=20
 	/* TC Handling */
 	unsigned int tc_entries_max;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..42d0e2e630c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3362,17 +3362,14 @@ static void stmmac_safety_feat_configuration(stru=
ct stmmac_priv *priv)
=20
 static int stmmac_fpe_start_wq(struct stmmac_priv *priv)
 {
-	char *name;
-
 	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
 	clear_bit(__FPE_REMOVING,  &priv->fpe_task_state);
=20
-	name =3D priv->wq_name;
-	sprintf(name, "%s-fpe", priv->dev->name);
-
-	priv->fpe_wq =3D create_singlethread_workqueue(name);
+	priv->fpe_wq =3D
+		create_singlethread_workqueue2("%s-fpe", priv->dev->name);
 	if (!priv->fpe_wq) {
-		netdev_err(priv->dev, "%s: Failed to create workqueue\n", name);
+		netdev_err(priv->dev, "%s: Failed to create workqueue\n",
+			   __func__);
=20
 		return -ENOMEM;
 	}

