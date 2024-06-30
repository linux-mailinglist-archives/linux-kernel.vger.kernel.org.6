Return-Path: <linux-kernel+bounces-235374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DC91D482
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A421CB21C18
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2A84A57;
	Sun, 30 Jun 2024 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="C14UQYPS"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67B79B87
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786681; cv=none; b=Q+99ukI+Mng3w4gLcjlcniIHU1pZBU66+vxO9CxACQqgOw+0nAOtvfAl9rSWrDvG7DwcLrmsWY0vpJfv45dnAGT/gB1xgB/wSQJjErt4n3CiUQpjTEpjwW/7n0tv4CGRKghI1qhk6GkcOvQBryZaFJDWO/dxdRbSer4OaLUBIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786681; c=relaxed/simple;
	bh=kpuHtQvhUUzizlEXf6/J5m15icRylhYtPQG9lsbiFG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfHbsREVgnhBjhBqzNG+l6ch+T22v4u6kf5ttPA6YtVhSpxYeG4E9f1C2ewiWDt55RtBiW/QjXJh3fo2qg+sSXhUPGwcaoF6/DoA5vNk5zsJCncUWrjASjtcfkoAep2HmtvGRz89rYUjLW5plosN+sEg2eq3BOEl2POn/RUy58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=C14UQYPS; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mm1bQBzll9fK;
	Sun, 30 Jun 2024 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786676; x=1722378677; bh=Dh90t
	P0y+grgItk8JX+V9Z9Y44qky8kCiYoXqFCere4=; b=C14UQYPS/hfFCOt1uuun7
	5/Rcyy0lH4lvAlLSh079frwxDScXYdQqH1iOo754bu/Mz+wdte9kaWUZn6wNhOty
	F15Kb0WFdtyi0AlO/Nbq57zrtVfFGwwby9F3ybQ2SMrW4YJasYSwfIF2WMBhfcxh
	6uAiG2lbmF0k+2MsN3qs0piGjkeI6nwn98q9AYY0qKZ/xf8BS35NHjE9ps8XoGCS
	W4mhTP7ntIiJPyDIaWsjaOITuCw2XixwwEtJ8Cq34ftRpSG28GlgoQZ6xxu4PUqj
	P1YpZamP1R2KqfkL9Bjx/0hIy+MDlTxwKSCCaVcCVIRXkfVI/ZUvjnh4NvgRoX0U
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1-ukRkhupoQx; Sun, 30 Jun 2024 22:31:16 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3md2w9tzll9f8;
	Sun, 30 Jun 2024 22:31:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 26/53] net: lan966x: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:44 -0700
Message-ID: <20240630222904.627462-27-bvanassche@acm.org>
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
 drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/d=
rivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
index 06811c60d598..69e6bb0cc44d 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
@@ -701,8 +701,6 @@ void lan966x_stats_get(struct net_device *dev,
=20
 int lan966x_stats_init(struct lan966x *lan966x)
 {
-	char queue_name[32];
-
 	lan966x->stats_layout =3D lan966x_stats_layout;
 	lan966x->num_stats =3D ARRAY_SIZE(lan966x_stats_layout);
 	lan966x->stats =3D devm_kcalloc(lan966x->dev, lan966x->num_phys_ports *
@@ -713,9 +711,8 @@ int lan966x_stats_init(struct lan966x *lan966x)
=20
 	/* Init stats worker */
 	mutex_init(&lan966x->stats_lock);
-	snprintf(queue_name, sizeof(queue_name), "%s-stats",
-		 dev_name(lan966x->dev));
-	lan966x->stats_queue =3D create_singlethread_workqueue(queue_name);
+	lan966x->stats_queue =3D create_singlethread_workqueue2(
+		"%s-stats", dev_name(lan966x->dev));
 	if (!lan966x->stats_queue)
 		return -ENOMEM;
=20

