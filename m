Return-Path: <linux-kernel+bounces-235380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915491D488
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8D2B2194B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4115A87B;
	Sun, 30 Jun 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4aeXEHnu"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E015A855
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786707; cv=none; b=XQfkI7NRrEhX5Hz058Twzu2d5wks60LjfSuceKgwEFIHsVf99DmxQH9LE59/ukNf31ARMMSi0Gaf/FsvOA30v6+0iVyAj8J4dO+V6y6bW8hZRRs8i5RdkaSny04vSeYU4ri0B/aosjfGXxFOh8ocUJIEnlX0wZtVX/ZivUn0ml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786707; c=relaxed/simple;
	bh=sYyCLLXaZf4K4662DqmBj9hCIfKy0skn+SDezo6wwQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvKYWCR3rDJl4V+kMzS1owFdlwoXBWQXZ0CqRShJq32nLAc6NgIQVstJR43+Eu6+bn0w5Yln6PMYt2AgPKGhFiYuau0dvPvmvLjKk65U/ssREKVv163os5/8cLqf9/QUcPnWCAr4mLyyhpKn0LH4t+NdGPPjBPyt4753e6E2pHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4aeXEHnu; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nG3QXRzll9fW;
	Sun, 30 Jun 2024 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786704; x=1722378705; bh=YsPc4
	PIyuGAwa6uSs/HRuEGvP6H88N7zTJtjlB2Ymto=; b=4aeXEHnurEGLdV8cYt/2h
	w1Yxr6ichXBKOwVpV3psYD9dQLsZfK5hV9vg9z8qEAtJs2+oTAB7E9w7uQoKh1Mn
	o+6cVQV2EPcba98MxN/E7XXEgsoPpN78OnTdUTv723eU8TsvL8DZobJLZbpTf447
	hcfjwEAfyP2YRpr8DjNU5cFLot0FdpzCdmvnVyfJC8QUOV3+FvUSLNDc6bXCa0EK
	ct4jplOpnfeOveU5hI0fhfhDB6uyFgHy7hil9rFFjCky5LfPH9qS70GFmpme4NI4
	gznlXrgaipMptxXcsB/v8WdjP0VuUDO2yaIb9bV/JwV0ktCSC7zbCRdGF5XMC9UI
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t2VE_kcCd1pc; Sun, 30 Jun 2024 22:31:44 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nB6rJjzll9fM;
	Sun, 30 Jun 2024 22:31:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 31/53] nfc: mrvl: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:49 -0700
Message-ID: <20240630222904.627462-32-bvanassche@acm.org>
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
 drivers/nfc/nfcmrvl/fw_dnld.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.=
c
index e83f65596a88..fc8d9466422d 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -442,12 +442,10 @@ static void fw_dnld_rx_work(struct work_struct *wor=
k)
=20
 int nfcmrvl_fw_dnld_init(struct nfcmrvl_private *priv)
 {
-	char name[32];
-
 	INIT_WORK(&priv->fw_dnld.rx_work, fw_dnld_rx_work);
-	snprintf(name, sizeof(name), "%s_nfcmrvl_fw_dnld_rx_wq",
-		 dev_name(&priv->ndev->nfc_dev->dev));
-	priv->fw_dnld.rx_wq =3D create_singlethread_workqueue(name);
+	priv->fw_dnld.rx_wq =3D create_singlethread_workqueue2(
+		"%s_nfcmrvl_fw_dnld_rx_wq",
+		dev_name(&priv->ndev->nfc_dev->dev));
 	if (!priv->fw_dnld.rx_wq)
 		return -ENOMEM;
 	skb_queue_head_init(&priv->fw_dnld.rx_q);

