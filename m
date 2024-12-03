Return-Path: <linux-kernel+bounces-428830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E508D9E140A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E4128301D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3741E1336;
	Tue,  3 Dec 2024 07:22:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EA18C03A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210529; cv=none; b=NCksbQEEvsUKQXM8WPnm0o5E5BJAMqP1g/eein6wAEGf2O1FZQ+z65hTQBj5nayLO/7YYof7gDJ5MkxBuYKHF/0iS7NpwIMexiv00MJ2EaJ7rq1V840u+xrN2VU1gLkiwIP3vx5UUMGVxeZuxMogJXsdfpWtr7E16H9duVZU0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210529; c=relaxed/simple;
	bh=P4TjaIKGSZHezFy00zzFiYLSOnURtxLh21+nrJq0HhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4N30aQ/Y89uEh33T93YNUKgwkHe8xqr8TJID7SeBpPwMpYhg1Fsv7j3CwrZBBh/46TWiODW4BTcAUsqyqwJZIzyc1dZgsmAvP/U9iEGtbDzIvLMLHuamzfRXs+d13eSnqzLMotqZ9zu8iQfsrTfE4ivwbPZSm4jkpIech1Cbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004sG-6D; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzC-1L;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEp8-34;
	Tue, 03 Dec 2024 08:21:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 16/21] net: usb: lan78xx: Fix return value handling in lan78xx_set_features
Date: Tue,  3 Dec 2024 08:21:49 +0100
Message-Id: <20241203072154.2440034-17-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Update `lan78xx_set_features` to correctly return the result of
`lan78xx_write_reg`. This ensures that errors during register writes
are propagated to the caller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b6e6c090a072..2966f7e63617 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2837,9 +2837,7 @@ static int lan78xx_set_features(struct net_device *netdev,
 
 	spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
 
-	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
-
-	return 0;
+	return lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
 }
 
 static void lan78xx_deferred_vlan_write(struct work_struct *param)
-- 
2.39.5


