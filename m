Return-Path: <linux-kernel+bounces-235359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A291D473
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A675E2813D4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2F80026;
	Sun, 30 Jun 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="q2tAX2f5"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2128624A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786608; cv=none; b=FnVP7yGfqF1cqC3uCj1P9MYUPXD2pIhs9lXtKHPR35QSx4medNfaQCmT8VRE71JZCjx3sbs0tshBv1mtEd25uVvViQ7HiDeooEXzH+yPwT2auD7AqmqBZOXp364N7ss9Z0ju9wYAIha5PRrSSn9XmgFdTX0evF1uE50nwOPzmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786608; c=relaxed/simple;
	bh=q4FDaCENCotKPSfwslVLUAA1Ser1FnTfGGfLfoPTebM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHQQFCov6478USNyTPOfJHRGavuns8n606Rl2qXzJQrDQzUhL6gy0CgCOlm6qPRztQJdlBe/QBdNxZoe4lFMtZoLNqRZLUA9sArVA7OCvlYiUaApzDSX2VITF8MSxuzR6JFMsLNYZpoiye28d3qUD3ET84obM/Uu6btFSHAJbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=q2tAX2f5; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lL2lr9zll9fL;
	Sun, 30 Jun 2024 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786603; x=1722378604; bh=/Qb3Y
	SBw3En6vtyNzCSJi/Dv0n52h34BgQzTQ9ny/Fc=; b=q2tAX2f50MqvcUsqzKDs3
	MofC3tjx62H4NHPeMiW+lK6iAdO/6Dz8cSMRJo0Lwy9hXfUAhlZ+Ob/FyqJthNZk
	i+ef1ck4aERdicCnj8UwEAqDOxCDuWljknGjyiHLazPxx6vXdIcgxBjLzAarzJpH
	Kb35/bk0mmX5rUvb3BfS6m9MXJtBU7rABdBUbydNYAiCEB9Frnsd/wiKguYCS8lU
	SKjcc6pa+Gb22lcFgP0dqLvrhcXTzB1TkAHHo8SHnZIMrlAYculzsOhMb8iQs0+a
	vbKHrqk5R9XT4BJKuwtzPTf5dfsTdHWn5PH27y+TNMTKJqEiI+BMncYIg4PQiZMb
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x2_Fgjso-tfL; Sun, 30 Jun 2024 22:30:03 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lD0BMGzll9fH;
	Sun, 30 Jun 2024 22:29:59 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 10/53] net: mvpp2: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:28 -0700
Message-ID: <20240630222904.627462-11-bvanassche@acm.org>
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
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index 9adf4301c9b1..58b104d2f24c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7635,7 +7635,8 @@ static int mvpp2_probe(struct platform_device *pdev=
)
 	snprintf(priv->queue_name, sizeof(priv->queue_name),
 		 "stats-wq-%s%s", netdev_name(priv->port_list[0]->dev),
 		 priv->port_count > 1 ? "+" : "");
-	priv->stats_queue =3D create_singlethread_workqueue(priv->queue_name);
+	priv->stats_queue =3D
+		create_singlethread_workqueue2("%s", priv->queue_name);
 	if (!priv->stats_queue) {
 		err =3D -ENOMEM;
 		goto err_port_probe;

