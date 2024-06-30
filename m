Return-Path: <linux-kernel+bounces-235357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018991D471
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDE0B212CD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430D7CF39;
	Sun, 30 Jun 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="g3YW6D9s"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03F84E0A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786600; cv=none; b=naO5PardJnuTRZmcrvWX0GMrjZbcoX5GpS+7LaLdKYk47ACG2jnDfca1ztm/er0a8/PiWXWTkBxRbph3gmUVD9yPaUTMiUovoCNvcEvhmXgG2tftIJtoQ9tywQqLARcgrpt7Dxdi5qqPdirQ8X6yMaeLYAegw0ideuAXTGCxOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786600; c=relaxed/simple;
	bh=n4CP8L2fykCqhBIo7DkJIttXgETQTq5Tn14caQ18Rzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/I1/w1xPOu7YLQUkEpaZtWT/EKBNiAffm4YszfCa1tEIfS7ozsmSYMxMCPWNkSgIUCOyld5kBdasVY0Dw1CuL7lJAGXGjkQKRX39mxCaxMwDvS1ccMUP6v5hOZn3J5tpQ1qlb8s+x94dX5ybJSbQQ7TOCWg3dfVROFyFU3SPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=g3YW6D9s; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lB53Czzll9fG;
	Sun, 30 Jun 2024 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786595; x=1722378596; bh=ifeLk
	0VYnhyNhlPueG9eIQpvMfIkcGsS/uPrsAO+t/U=; b=g3YW6D9sFOYWkZRK/1iqv
	plIaZmpGJhDsxYu+09RkLZ5iT8M1Y1nJdlDQHzLXLSd8cWRIDF3IgnvRo+3SLSR+
	AII1lpHw3X08TRiIoZe3eGW2ZHjdkQUjIoHItpdSEqlGpTu+MvcHt2PkzUbrZJKL
	3G8ki41u5RhQGGanK4k/MSJ0aQ/v9pmYHIb8PAnOhh4T0p266EgEQQr2ytlNBcWA
	9A1/j0u2RRNzxUAxVKHuajMol6alvkq7zU3NCJGPpsim0RHck83cksdJwtiaDFHZ
	yR9AFd8dj5S8pgVv0/jhZkLUbQb5OGK1/sLQetBLBKntSx+D0Ymkg7HXzly0PGCT
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L-GoKxKb7Phv; Sun, 30 Jun 2024 22:29:55 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3l46L9dzll9f5;
	Sun, 30 Jun 2024 22:29:52 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 08/53] net: amd-xgbe: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:26 -0700
Message-ID: <20240630222904.627462-9-bvanassche@acm.org>
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
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ether=
net/amd/xgbe/xgbe-drv.c
index c4a4e316683f..20281f0381be 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1846,14 +1846,14 @@ static int xgbe_open(struct net_device *netdev)
=20
 	/* Create workqueues */
 	pdata->dev_workqueue =3D
-		create_singlethread_workqueue(netdev_name(netdev));
+		create_singlethread_workqueue2("%s", netdev_name(netdev));
 	if (!pdata->dev_workqueue) {
 		netdev_err(netdev, "device workqueue creation failed\n");
 		return -ENOMEM;
 	}
=20
 	pdata->an_workqueue =3D
-		create_singlethread_workqueue(pdata->an_name);
+		create_singlethread_workqueue2("%s", pdata->an_name);
 	if (!pdata->an_workqueue) {
 		netdev_err(netdev, "phy workqueue creation failed\n");
 		ret =3D -ENOMEM;

