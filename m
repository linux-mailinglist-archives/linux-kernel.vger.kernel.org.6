Return-Path: <linux-kernel+bounces-368825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F29A1546
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35931F244F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC91DB938;
	Wed, 16 Oct 2024 21:52:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672B1D6191
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115558; cv=none; b=OuVFjgw0LORsJ3TZ+jaXezjdeJW4M0AaGy659rTgc7Y8IKut9hom2LRIhxVW5hK79Xdltp/oXfTw1RUDeP0eXX2mB8XWhQl+9Uc1mLvo1mTxlIKhiVAAVXhSrCpj5RNbX8HjkPCmKdNvOIBJ7QlCHfchvBuXbuQgEjfBJGt7dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115558; c=relaxed/simple;
	bh=7GtJji14G3kifWiJdk4fDCF5TSs2sCvgJBeyE6WDGs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myG6KmkCM8/iimFTS/AD0kelgHMiWhUy9kQ+8427j/A2LmRMIL7vyymkYQMNgkiMG9kVAslm5NhrzmitgaRvc0S85WJbJQXRluXXUKkJtEDxc44kXQm32aJ+GfXziwspGDvrTpasWhxVmaAbQxdmUTHcvoucT/g4cASANYWAEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003RY-VU
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OUa-FU
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 306AF354928
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3627C354880;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id be551a47;
	Wed, 16 Oct 2024 21:52:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:53 +0200
Subject: [PATCH net-next 05/13] net: fec: fec_restart(): introduce a define
 for FEC_ECR_SPEED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7GtJji14G3kifWiJdk4fDCF5TSs2sCvgJBeyE6WDGs0=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWFQWZhrYZZkfdVhV0Jk/Nfh9q7WlZQzjSul
 hPTCO1BEJaJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1hQAKCRAoOKI+ei28
 byqWB/0afSRnTRSECfSjxdtzoGolxiFb4HYpV2P73zfe1yozkI6gXgDXT18McR6n3aAWF4L4bx5
 Nn89bAutGj1L/8DXa95MBR5ZBZu9nQ1fkrrRz+JAQL+ipm8WQTk+2EcCDQOCjBVQiV8TYEouwaU
 cVHaECBe48qFKg2mXcJ32kHi6YypNnolHI6BeYGVHgbb5gk58O0uoFs0k7a5egU0E2Y1LkEDI6O
 3rIEw0I2Ec8rgoQFFMvCqIkUStsQtrnqqr0hmVojY/iHj76TKNZQDXVFZfBChWF1uU53ebx2Irm
 XPvVhjR9gM/LphVHnPX4JtVrrPeyZ+X+YzpScGXg+M+Hu5jZ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Instead of open coding the bit mask to configure for 1000 MBit/s add a
define for it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c57039cc83228dcd980a8fdbc18cd3eab2dfe1a5..2ee7e4765ba3163fb0d158e60b534b171da26c22 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -276,6 +276,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_ECR_MAGICEN         BIT(2)
 #define FEC_ECR_SLEEP           BIT(3)
 #define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_SPEED           BIT(5)
 #define FEC_ECR_BYTESWP         BIT(8)
 /* FEC RCR bits definition */
 #define FEC_RCR_LOOP            BIT(0)
@@ -1160,7 +1161,7 @@ fec_restart(struct net_device *ndev)
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
-				ecntl |= (1 << 5);
+				ecntl |= FEC_ECR_SPEED;
 			else if (ndev->phydev->speed == SPEED_100)
 				rcntl &= ~FEC_RCR_10BASET;
 			else

-- 
2.45.2



