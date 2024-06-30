Return-Path: <linux-kernel+bounces-235367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EEF91D47B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B53B21305
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2A157481;
	Sun, 30 Jun 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4ldS36Cy"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE882D89
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786646; cv=none; b=il6bVdOUncMpMvR+iCM0HEeIn0983sLa75I9Hd4G3ZbO2Tf+OtGCrPFBprxAdt8d7JzsU2rAFdGyG/33okVBXWG6F1wfYNTvn3+iKxwzGc9RLVSU2DzMo18HRM6d5+ZH770AQumC5PiSvqvGke6zKM4ySjrdPbL0Qbpza/EPeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786646; c=relaxed/simple;
	bh=dsbtsjtvJ/69WT0Tvw75D2RA8LyKCF2WwsTbxBSYNXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmogF2TM1WYGjCwQw1ucAvoF2UQMbmFdicYjRdKA4Wrp23MzMzmjSk/Cp/pDAZKAhIoCULb5m8TKZ53qL1x8O0FtbACwK+tB1sI7lexXbjCBvhUSNd1/Zsr5Jhul6ky8CpC/U1oQtRyYnrFRaAj+xKIgy0XuRFs8FynML5c01wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4ldS36Cy; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3m423Kvzll9fM;
	Sun, 30 Jun 2024 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786641; x=1722378642; bh=JJec8
	dONRky23NgY4NgxzFlIlN+J8B42EWQvz8f61G8=; b=4ldS36CyyampMyaBsUeX7
	+YwVPm6yCWkI76w1JuJLpeYG3SfKlYPrtt5DPVRFN9585ftdHzBIv/iK8rD+7THt
	h1qJIXJrUKooeRfDneI5ezZSkHlJ/fMks5pUWr/DwoQSKGORQlBlIxhi+1TAK1yn
	S29Bte7pNCx+3UkFXCJqPpOOBIcCfNRD4s/UPToKLW4HNipgljroXw5nCZv6AO5G
	3q++HECMzm4nrBbMcepk0hN+RSQdVd67q3k9CChNc/CVGddSuwDj5G20P5SKZJsB
	oaTr3xw46J/ugnFkDFCx+VafuEUORYOXN/nwzEhwUT/dsWeROQTNU30ZUm5GH4X3
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N0ouRI2bVzZP; Sun, 30 Jun 2024 22:30:41 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3ly2WxHzll9f8;
	Sun, 30 Jun 2024 22:30:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 18/53] remoteproc: imx_rproc: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:36 -0700
Message-ID: <20240630222904.627462-19-bvanassche@acm.org>
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
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
index 5a3fb902acc9..14fe2aca50c4 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1064,7 +1064,7 @@ static int imx_rproc_probe(struct platform_device *=
pdev)
 	priv->dev =3D dev;
=20
 	dev_set_drvdata(dev, rproc);
-	priv->workqueue =3D create_workqueue(dev_name(dev));
+	priv->workqueue =3D create_workqueue("%s", dev_name(dev));
 	if (!priv->workqueue) {
 		dev_err(dev, "cannot create workqueue\n");
 		return -ENOMEM;

