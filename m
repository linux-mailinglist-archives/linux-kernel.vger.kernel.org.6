Return-Path: <linux-kernel+bounces-368813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B344B9A1531
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2511C2166B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EA1D6DB6;
	Wed, 16 Oct 2024 21:52:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742FD1D5CF1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115555; cv=none; b=o14phfR5vwixeHUD1ud6zsviS5T9KlMs+wtTWu/eD+Awr6bU/41nylwuB+9oWlIVl0buog9C4hOMp9BVZxAvwXlGxyqrbvEw8HllpYK2miOEDvZMcVWId7BKgblDpa5ojkXSKsbJA8Xpy3rprr9ODV1ATkK8pXBbfcm8TWE0l7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115555; c=relaxed/simple;
	bh=YPw2JL2s5w3prN2ZMsgN06qSkXXBNnmLw6B+5/kvkXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYBmsuJVJNUSbVITY9+sFuvYQpa4dBph03XPZ7AAu2Kw4Z7XO/BqbpqnJ4Rw5DcNLGtnt2GO8W8eRrmuzUWkDkOPNmW5ne4cZ7s9+1tLriCo4Bhj3jQIRup071jmrbgskBc+02o9uII5ruocXaF9bQFPu8t+7KQ0kLR04Ml6RTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003S9-EH
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OV8-Q4
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6A1F6354930
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CF740354894;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ecf358ac;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:59 +0200
Subject: [PATCH net-next 11/13] net: fec: fec_enet_rx_queue(): reduce scope
 of data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-11-de783bd15e6a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=YPw2JL2s5w3prN2ZMsgN06qSkXXBNnmLw6B+5/kvkXo=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWOmisc9ytow/ZcpSeZ2tFx3MsYjzMge4v8Q
 agcYFkU8EaJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1jgAKCRAoOKI+ei28
 bySFCACb18TtP63Ve+Li29gi+Hsm1N7WagjTE5yjJmySfK20qSg6tKa83UxPiCje2n4ZHQAEgDp
 GRPEfcv+x/QhjTZTREK3ObQd8gK4m6p8EGvxpGF5IXe+fUuSCy+xwIsn0s3Tor3lUryyZa8QFAA
 uMavAUOmenc0XnNLWfadicKHLSqDZanXZwvZScS1cAWxa3Dl13Ard83b+GH0dYcUB48E8lEF5Ie
 cm6xoiBhwPbDfcEV31r3SNmVqyU3Wfyv7bNQx3lAid1BfTWPbgTm7uAbUVXJ/BFGtE37ku2LSOu
 +wszTzNjf2/B+PkCqxnyNrSoK18zRnmzMvcvVUW5vQY2jSlY
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In order to clean up of the VLAN handling, reduce the scope of data.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fd7a78ec5fa8ac0f7d141779938a4690594dbef1..640fbde10861005e7e2eb23358bfeaac49ec1792 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1686,7 +1686,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	unsigned short status;
 	struct  sk_buff *skb;
 	ushort	pkt_len;
-	__u8 *data;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
 	bool	vlan_packet_rcvd = false;
@@ -1803,10 +1802,11 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		skb_mark_for_recycle(skb);
 
 		if (unlikely(need_swap)) {
+			u8 *data;
+
 			data = page_address(page) + FEC_ENET_XDP_HEADROOM;
 			swap_buffer(data, pkt_len);
 		}
-		data = skb->data;
 
 		/* Extract the enhanced buffer descriptor */
 		ebdp = NULL;
@@ -1824,7 +1824,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			vlan_packet_rcvd = true;
 
-			memmove(skb->data + VLAN_HLEN, data, ETH_ALEN * 2);
+			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
 		}
 

-- 
2.45.2



