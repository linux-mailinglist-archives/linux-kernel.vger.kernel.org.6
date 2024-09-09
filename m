Return-Path: <linux-kernel+bounces-321594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9E971C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4B4283BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE41BA89C;
	Mon,  9 Sep 2024 14:29:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D31BA28B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892193; cv=none; b=oE/6gouRbcFtlbSpBLbxxcOFwPxtT0SFpKDqS99IpWQqg/BUaNENojcSWK+fRMUnbksiUQAz6vQOzMCy7LBFIoLOzJWcZkANPqLsHChsMavKUNIRDJ4agUb23H5MKaCGZJ6fW7uKUTcsFlFwmnFSJ7f0Le6sZ1ZpYkIF7m70dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892193; c=relaxed/simple;
	bh=148obTx++Y3V8ypuU2N7MV5+sIrN7E4EKA3l8o4GR7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H2zz/Vda8o0FAgLTsDYuESHHtNzL6rP/CKiH8GGM7d6nMqBXbO+WgYKBuYyDQNw7FZEvrhR/JFNn5GRDsD6y2sj/ue7ol1bkfU0kxrlNv4j3XwWsyDy/hmfa9PaFP74gF6iU7gftK0/Fsj/ETU0XOXpgDLvPqBD0Tv97MKBUeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-00026v-KM
	for linux-kernel@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-006g3P-4D
	for linux-kernel@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C7D7A336B32
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 14:29:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3227C336B12;
	Mon, 09 Sep 2024 14:29:45 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b502aa44;
	Mon, 9 Sep 2024 14:29:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 09 Sep 2024 16:29:36 +0200
Subject: [PATCH can v2 2/2] can: m_can: m_can_close(): stop clocks after
 device has been shut down
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-can-m_can-fix-ifup-v2-2-2b35e624a089@pengutronix.de>
References: <20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de>
In-Reply-To: <20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=148obTx++Y3V8ypuU2N7MV5+sIrN7E4EKA3l8o4GR7I=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm3wZVz0ZMV16OHcZFLF6AUqux4obsFEjdjJ5ip
 OzO/4D82n2JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZt8GVQAKCRAoOKI+ei28
 b1UPCACXZlb+a6UZUK9oa6Djs9b0NCr/yHH2ee04hXM3eCzPMLzaDfNtF3c/w/tHDCs5qs98g4e
 LnbQX6ud4ev8uBYN1UJVeJRwNPXt9WmM3cd01mULGwvuWKMjraSzGrxTaSP7fWm1zZqiRZuIoED
 Atm/BuHiPX3bCvEszTqwlcRAs3SyD5FQzgkVHXUjc9mR5D2r4xrAe47JxTg9Jaxuv72YQUNFE0s
 dkFFwmGStSxq0criNZY4SBy8tjfeXDEyamp2PIJbnXJU8+jDWDXi5Ykim/360xj0yDhlliqwnK6
 3H9j1xKjTIyAMinzxLT2EqEjBJlu/0x3wRu2PYwe6yjiAMVG
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

After calling m_can_stop() an interrupt may be pending or NAPI might
still be executed. This means the driver might still touch registers
of the IP core after the clocks has been disabled. This is not good
practice and might lead to aborts depending on the SoC integration.

To avoid these potential problems, make m_can_close() symmetric to
m_can_open(), i.e. stop the clocks at the end, right before shutting
down the transceiver.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7754dd2d4cb110eee5b83885f5381aed9c67ce03..7aeb56bcd1d660e592b527919d3708add62bfb75 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1764,7 +1764,6 @@ static int m_can_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	m_can_stop(dev);
-	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
 	/* disable NAPI after disabling interrupts */
@@ -1781,6 +1780,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
 	return 0;

-- 
2.45.2



