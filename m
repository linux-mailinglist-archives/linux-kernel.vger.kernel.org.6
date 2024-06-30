Return-Path: <linux-kernel+bounces-235401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EE91D49D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94260281316
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8115572F;
	Sun, 30 Jun 2024 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OeAVOPno"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20562155A59
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786790; cv=none; b=pLPXNRtOJQpO8Hsiio4z7WUPIpcnOnpVbIncaLUlJkCXBx+5M4mVLGV6LH1UYp6xoiMGZwyES1SZ671TmPMaufHFcYGmGNS8ZUVipTXEZCgLyJK5XrDjNC11dtlKrPd8NnpnPH7CJzIfYydFJCVvNECLPS5sxUZikUzg+g6Ucz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786790; c=relaxed/simple;
	bh=Vs4n8HpyeqOevEcTwX+8Pfy3t8nzFNPGF3W0EHNruRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH/RIbw7MhTSi75mZ3c7cQysexGERkGhKGM+ryAVARrcY2C9V9PIKA0cl/Yca4Vj4f1Nj0vCqEflzYJgOm40sON1XJ8sRWpW6RM2RsnNUuZM5lynipkpsJ33bcYk+tF0u1d7JXQIPyXrYQZ3vI4T7Tjf4Ik3bqcBK2xxnSqW+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OeAVOPno; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3pr45RXzll9fK;
	Sun, 30 Jun 2024 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786784; x=1722378785; bh=R/0zN
	ZsiR4GZgYCNYOcb1zVRQoTWT4RaSVlpdwmv+YU=; b=OeAVOPnoix2x2qpHxaNPn
	NeO/cEltdE6MF6BCnbp/paaL/9Y3EpGeMHDvGJ7Ou30SpvIM5VAYo9Yq7xeJpkom
	UdeG35LuV8ptBSotVIPo+a67YplvKYMe5CQuG3/jBhR4KH60XL4jLbnyPRPqAojz
	g2ka7X5vZljgKC58xds/WoJGIOXveLMMH/6kvrAyXO7QS/kCeLql8emSzj8OBnla
	TNeppUWHv42nKbADQj7Xay5FnnTHGdWGuboo2FWpVNxQjJyNuGcmkfPe1QvQbg20
	kUdocBcII6eVKK4MnoJ+42daf3k0XM8VU3TVS9KK2LfxJX0HHxa54DOIDUX6N5sZ
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rrJnAho0uNOB; Sun, 30 Jun 2024 22:33:04 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3ph0CFjzll9fB;
	Sun, 30 Jun 2024 22:32:59 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Jeremy Cline <jeremy@jcline.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 52/53] nfc: nci: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:10 -0700
Message-ID: <20240630222904.627462-53-bvanassche@acm.org>
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

Pass a format string to create*_workqueue() instead of formatting the
workqueue name before create*_workqueue() is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 net/nfc/nci/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index f456a5911e7d..4b5cb2017e39 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1225,29 +1225,28 @@ int nci_register_device(struct nci_dev *ndev)
 {
 	int rc;
 	struct device *dev =3D &ndev->nfc_dev->dev;
-	char name[32];
=20
 	ndev->flags =3D 0;
=20
 	INIT_WORK(&ndev->cmd_work, nci_cmd_work);
-	snprintf(name, sizeof(name), "%s_nci_cmd_wq", dev_name(dev));
-	ndev->cmd_wq =3D create_singlethread_workqueue(name);
+	ndev->cmd_wq =3D
+		create_singlethread_workqueue2("%s_nci_cmd_wq", dev_name(dev));
 	if (!ndev->cmd_wq) {
 		rc =3D -ENOMEM;
 		goto exit;
 	}
=20
 	INIT_WORK(&ndev->rx_work, nci_rx_work);
-	snprintf(name, sizeof(name), "%s_nci_rx_wq", dev_name(dev));
-	ndev->rx_wq =3D create_singlethread_workqueue(name);
+	ndev->rx_wq =3D
+		create_singlethread_workqueue2("%s_nci_rx_wq", dev_name(dev));
 	if (!ndev->rx_wq) {
 		rc =3D -ENOMEM;
 		goto destroy_cmd_wq_exit;
 	}
=20
 	INIT_WORK(&ndev->tx_work, nci_tx_work);
-	snprintf(name, sizeof(name), "%s_nci_tx_wq", dev_name(dev));
-	ndev->tx_wq =3D create_singlethread_workqueue(name);
+	ndev->tx_wq =3D
+		create_singlethread_workqueue2("%s_nci_tx_wq", dev_name(dev));
 	if (!ndev->tx_wq) {
 		rc =3D -ENOMEM;
 		goto destroy_rx_wq_exit;

