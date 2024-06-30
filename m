Return-Path: <linux-kernel+bounces-235363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3A91D477
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E851C20AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242B1153836;
	Sun, 30 Jun 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AYehQa2w"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F61824AD
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786623; cv=none; b=HQHGuFuvr6kF/w/0JMAUJj6dnJWhtAvzCRuiuqTNsUmxCy31J/2uEqZ8LEmlot2ZDp4ZdnRL+3yB6bvaxjekIu7NHn3iL95+DPhaJdwU4FeHIKFf5xPOr3hCZ0Il8/EpqBAT3qB0r793KEyejTu3Ty6R0pClFRpumTQwRjjlMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786623; c=relaxed/simple;
	bh=WU534ClNdXk5JX/gPWYXe+52AFdoCTHzM1e8sZxqVzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmPad3J10nqHlnSEzrsQihkakRP0zio7aischm543hZ2z+DPNzv/CRANQj/nu6BPMeOHDTblLjp5wjR7P2yIZnsJfXQQiAmRaJsCb3y86LdrcZruMNIF5lPw6gumgDIpu8/QgmThrB0rG3nIwojaQcs8lc6OpLWLhwYclgZE9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AYehQa2w; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3ld4bfzzll9fQ;
	Sun, 30 Jun 2024 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786618; x=1722378619; bh=VNIux
	PNAuCCMGeI7ny9nSvFqXmjQgR2HZxca6zdyYZQ=; b=AYehQa2wftNfL26GWCWkS
	oUd+0X37atXAJQkzN/ce9E+BFSGDhNwCTpL4CrR9Lcrau0uqJKQGxttmjMv8185u
	kTh6NSRtZ/YfOcDZXVv0siUcPwdhRC+RIYBkzVKKhnUrRwlHfBzrJgArR14yWLQW
	yjRq5jETu4+vs/wme920OVIduKg1oG8UYOm037EIklWVRqZ9gLai9KqVC/ahHoMa
	sPR5/A5zwAkFVFs738qLs20hWJ42FMX46ze2WFtNH3kxG1yBY0PLB7LG835NN/Vk
	0sQG4hnCJmwQI2TI48HJsIC+Ab2BdiNLAuHQ0jHvVWYySOlnFE98lZuoFX8mv1Gm
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n-JqdjXUcqEf; Sun, 30 Jun 2024 22:30:18 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lW6rB9zll9fH;
	Sun, 30 Jun 2024 22:30:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 14/53] net/qla3xxx: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:32 -0700
Message-ID: <20240630222904.627462-15-bvanassche@acm.org>
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
 drivers/net/ethernet/qlogic/qla3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet=
/qlogic/qla3xxx.c
index fc78bc959ded..5912679bd2f0 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3862,7 +3862,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	netif_carrier_off(ndev);
 	netif_stop_queue(ndev);
=20
-	qdev->workqueue =3D create_singlethread_workqueue(ndev->name);
+	qdev->workqueue =3D create_singlethread_workqueue2("%s", ndev->name);
 	if (!qdev->workqueue) {
 		unregister_netdev(ndev);
 		err =3D -ENOMEM;

