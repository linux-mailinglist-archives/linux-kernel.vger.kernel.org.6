Return-Path: <linux-kernel+bounces-323545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653B973F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C027D1F252A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443611B5315;
	Tue, 10 Sep 2024 17:15:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDB1B2503
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988543; cv=none; b=LpiY21JPLrRWNcAYN9YQdXvDstpQ/lI7cLo2z+EoYI6Z2cahEeSIYHeOOUkA+D7TqWV7qVBPYcNRW/430Y90qZExMzyVsrnvBlk3RHhvD5G3v49JbQEiWAJi/SO6NC8o5WYprW0ulynkthRkSQRwxsc4uUIrl4JPX8WXO0Fvv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988543; c=relaxed/simple;
	bh=cciAGwr6AOyIXgxx/NJC0frSUvK3iv1I4zhWUP9vrT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSrm1Uf7uj04EsYnZ449z69KSdnXKxaig64UVByFNYn5C7bTa02K+LSZaOHQiX6bQyul51IuRED7e3Ionv8CORQ3FNc61h+uXIuhpcVrz7j7QpRuMvQMVnYdzU42Nu7oVWMPL7Ifp1kc36LCWdf0xEY5lpmQZtSDAHL+DeI+65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4So-0005CY-Gw
	for linux-kernel@vger.kernel.org; Tue, 10 Sep 2024 19:15:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4Sn-006wUE-UJ
	for linux-kernel@vger.kernel.org; Tue, 10 Sep 2024 19:15:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8E2B9337A3C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:15:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E26D1337A1C;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0ac342a2;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Sep 2024 19:15:29 +0200
Subject: [PATCH can v3 2/2] can: m_can: m_can_close(): stop clocks after
 device has been shut down
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-can-m_can-fix-ifup-v3-2-6c1720ba45ce@pengutronix.de>
References: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
In-Reply-To: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
To: Jake Hamby <Jake.Hamby@Teledyne.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=cciAGwr6AOyIXgxx/NJC0frSUvK3iv1I4zhWUP9vrT8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4H60AP5jFx/sHn8bOrTBsvMXnGQVlLW/73fY0
 MLqNgvB1bCJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuB+tAAKCRAoOKI+ei28
 b9ZlB/0a5BccL7/BgOb/9Syvsph1JvVwUVKfb5/2GSXfsVelmcuXKZxXSxPM8tF2SrYbU58DLfl
 69OuingQZbMlooZ3zQlGiVoPWU/hc+xoTG7EZCJxcYg+T43RzGy9j6Gd7iPDjEi06iY0p7rvHIW
 Hz6k+ux6d+/DY/dui8OQeAXcUDDcTjhrP4AGaIsxiE5A03XqbqKdyW9cnXvrwR9obw/PkH8BQgY
 hQQaklqE/pwwjmjq7lA0NfJKwiyD7imng+tRuJUwVFYGLDrOulmsrPto2Sx1V5zLc0Zmq6bH4cN
 4oiGqRix8W4LHM1tknI/3MfF5sWv9j9xvdIPWOWucvERAEit
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

After calling m_can_stop() an interrupt may be pending or NAPI might
still be executed. This means the driver might still touch registers
of the IP core after the clocks have been disabled. This is not good
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
index c1a07013433eb7b863eee072b959f46c1d5b008d..7fec04b024d5b83eece7a0b9c70a1352ee05138a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1764,7 +1764,6 @@ static int m_can_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	m_can_stop(dev);
-	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
 	m_can_clean(dev);
@@ -1779,6 +1778,7 @@ static int m_can_close(struct net_device *dev)
 
 	close_candev(dev);
 
+	m_can_clk_stop(cdev);
 	phy_power_off(cdev->transceiver);
 
 	return 0;

-- 
2.45.2



