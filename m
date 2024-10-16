Return-Path: <linux-kernel+bounces-368820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7B9A1544
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3EDB25493
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF71DB54C;
	Wed, 16 Oct 2024 21:52:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7131D5CFF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115556; cv=none; b=OxRQDKUraZQwbnb/7KlmURydDXWFnVXjk2a3Byk0xRvcXRJxLFj8p2N4vnfl7LShM1UiNWW9hjzELICuLeUW2MhGx5XrmcXtdDn+drR7260OY2shd4lOFuqAlBgk4UJ79cDTxZkxBVEs8/PjgdijSzY2yCCXQV6BYgommt1to9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115556; c=relaxed/simple;
	bh=3modV2VgvYS7hcnK3euWQGrdAXopfGcsu0hX01ZRK1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7eTtcoplkVDH9aXIJ3iKZLB2K5xu4bvsqdofI46v5HN1RRdi33PNAeWOHwNA9OxS7AQSZtzhtbHf7yd/SDnNM/2aGSnCcTCW0BN+v8rOzB/AWzx6jc07hRX+0eknJciWp6JtbWKFXfamfZY0A5LyRr+fr5NYZMyBgjwVBXMRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003Rn-GK
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OUk-Hb
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 34BBC354929
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 997B735488D;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 41ec2a27;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:57 +0200
Subject: [PATCH net-next 09/13] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-9-de783bd15e6a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3modV2VgvYS7hcnK3euWQGrdAXopfGcsu0hX01ZRK1c=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWLMUCGJ7B2kmVE/4WclSRlu7dyPVT/hNfsr
 ocFFQgxc46JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1iwAKCRAoOKI+ei28
 b4LNB/41HL9fHYATnmHoSeZtgD0bcPKt5OCG3/ZY3CkYfgfed0ASifgg+x6sBSTdITW3XL3wn71
 4svi7TKDHgKm0dwJKTyBI3SoJdCWvpQniQZbOKmW0rJ35vdeNhXikfju31MdteUMmSDNDnja4kZ
 CLtHdHTnkcoRT9v2pMC/Wt+m46OC+JqU/piQDe7z0CnlnFe6DkjBCbfPL2VDxmlxidizwpcIyys
 idH0dBroUK2n0g4+srD9iJUJDvJT2VmcgTHCUPb4hVKX3nOUID/oz/f4i9wM0ERbkXCEs+aXxSu
 OsSvUdmzxKRsmNeCzLls0wTqM8jIeM4mKB4HehoEoIWW1rqR
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
one for handling the RX queue the other one handles the TX queue.

However they don't have the same signature. To make the code more
readable make the signature of fec_enet_rx_queue() identical to the
signature of fec_enet_tx_queue().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c8b2170735e599cd10492169ab32d0e20b28311b..eb26e869c026225194f4df66db145494408bfe8a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1678,7 +1678,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
  * effectively tossing the packet.
  */
 static int
-fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
+fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct fec_enet_priv_rx_q *rxq;
@@ -1899,7 +1899,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, budget - done, i);
+		done += fec_enet_rx_queue(ndev, i, budget - done);
 
 	return done;
 }

-- 
2.45.2



