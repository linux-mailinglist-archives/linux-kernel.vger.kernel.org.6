Return-Path: <linux-kernel+bounces-235360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168EF91D474
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BFD28128C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258F6BFD4;
	Sun, 30 Jun 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fSZ4/3Wc"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74412BE9E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786612; cv=none; b=rrmcEgPcd8TyGZpMKmFbPzn/cNIRVDX2HlrX4x3yEQqW/YAxOHhfOzkEqaY38Ahcd+Kux6yMw21OX3vYs49yvwP9mKxDACVH400j94mRsaTtyFX+0atPs0BbHq/lN6f3iobH8E2weSMQuqFNN9wfaooZOOP0e+IakzsAJ2NMvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786612; c=relaxed/simple;
	bh=VrxxK4RAw3BAvCP2ZOVpbxYPljfPJWoaD8h45xLvjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT8gG+2pq2u1AGtaF6x6jblU43vMXGO+WRlno7jtr3QcaIcDMr3iUhTy/8GT8lFCoooC5vAFMVLu6BtYnNoa6ltgQ0tnOyjKSiCqgwHvshRS7452XPYvqilOT2Oeh7RV9ORaZZKsxSBEzHO+MPnh4wsKR3fG7kB241ejF1Hufpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fSZ4/3Wc; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lP1b5yzll9fH;
	Sun, 30 Jun 2024 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786606; x=1722378607; bh=Z/5Xf
	K50ktgZtMszK0e60lXAytSO2Y0hg/cRKl/BA9U=; b=fSZ4/3WcThpeonlxu7g2v
	XrXwlMBAXjGmbEefFCSLXI+xE/5IwpoJ0WHuRy8uK5bKb8tlEkLsXZIdxv1kyHsU
	vbvQZeSDoAgpun1fFX8DVsEStGTzpHVCi2LUrTdbbKM2rY411EbfmGEJ6JTsGTYg
	ZEtk03Eug02H4EvP2Kh4NWBv8i+qpRU2H274JiRffZrAI8yzqjBV6LxLva+mRFE5
	zNkpVfyq8xcQWCXjBoJyhiNblqFkOTcD6T0PG/d6nK5wd8mLFa6JI4mmUF0r1Gbt
	8MDMSsgYkLb+Lgg8jgG7ANy/1iE6Y3c1SbvYuVQuSsqrIQX+5JmrGgpGkTDBSakW
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id R54kdu8OoeVS; Sun, 30 Jun 2024 22:30:06 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lH6hB9zll9fK;
	Sun, 30 Jun 2024 22:30:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH 11/53] remoteproc: stm32: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:29 -0700
Message-ID: <20240630222904.627462-12-bvanassche@acm.org>
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

Prepare for removal of the create*_workqueue() macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_=
rproc.c
index 88623df7d0c3..5af6fdc6881c 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -867,7 +867,7 @@ static int stm32_rproc_probe(struct platform_device *=
pdev)
 		rproc->state =3D RPROC_DETACHED;
=20
 	rproc->has_iommu =3D false;
-	ddata->workqueue =3D create_workqueue(dev_name(dev));
+	ddata->workqueue =3D create_workqueue2("%s", dev_name(dev));
 	if (!ddata->workqueue) {
 		dev_err(dev, "cannot create workqueue\n");
 		ret =3D -ENOMEM;

