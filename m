Return-Path: <linux-kernel+bounces-368818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556929A1542
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EBC1C20FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE281DACBF;
	Wed, 16 Oct 2024 21:52:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233C1D5CEE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115555; cv=none; b=cyb/NhCfD2oq0Jy4kSYFMi7b++oUvGMhdsTYj6tb5YwskqB88GKqpARc4zd8FmGFIcJgF+7QwZnjNNeOO5CWDc0JiREpWV+ergQ9zowXYpRuyhqBSLu+sTfIBz+13xx0aX/CMZjX7YmTMwbXRhn821nisn4GUDq8fICZUQmfhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115555; c=relaxed/simple;
	bh=Ke1G/ZKCyRRJ98ZUhFIVjb9Fx2m+IK5e86tb9C1Avr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0ApCtWvcmxllfTSZNiQY39IqWuOBYtAKBacyyG81nD9q3y+I5+6CnrTGBirRWPG8bqnMtfex7nYwCnV3FRrGGPxVnxISWXez0Y1ixahzKaiS4aXRnsNBknFwOtXIh/94kSWX2/pyH5BuaVbvYGiHoRtgI0jnGye5PY4Cj26xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003SA-G1
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OVH-Q5
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 720EF354936
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EBCA5354897;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5b003133;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:52:00 +0200
Subject: [PATCH net-next 12/13] net: fec: fec_enet_rx_queue(): move_call to
 _vlan_hwaccel_put_tag()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Ke1G/ZKCyRRJ98ZUhFIVjb9Fx2m+IK5e86tb9C1Avr4=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWPx5p84klDfyXzAeG6lUq48HMH/LzMiHcqw
 wZKURrN7BCJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1jwAKCRAoOKI+ei28
 b2RgB/9NEMqmM7u51r2Fw5sFLt2J7C1P2pCqzQ8HbOBSlRbAObB6TOH/9rQjDkg5JM0DMJL7MUu
 l/u7wBGnbgCTyx7M9U6ijbdO4I71TeAjkgNVRH1bNLkOU1Od/fW1hCwbhYif04vb6n4yWR79obZ
 m13N9yubGEgxLu+cOfQJopXh/p5XRmkiNY6q4fsEBV4druoZuLywr4MnpB4WQyqBLV5QJP2ZGsx
 xr25q1Olh5Ok4AgNjfkcnqlFpYk4bg9QgFNx3hJMgPV+oGcVQQJNfALpxC1W1x5UXtd8t/dd0ZD
 i2WaafbyRbNBAOvi1/dztNKaUMzTHAa14LU2mFQ7Y3DxDMww
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

To clean up the VLAN handling, move the call to
__vlan_hwaccel_put_tag() into the body of the if statement, which
checks for VLAN handling in the first place.

This allows to remove vlan_packet_rcvd and reduce the scope of
vlan_tag.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 640fbde10861005e7e2eb23358bfeaac49ec1792..d9415c7c16cea3fc3d91e198c21af9fe9e21747e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1688,8 +1688,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	ushort	pkt_len;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
-	bool	vlan_packet_rcvd = false;
-	u16	vlan_tag;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
@@ -1814,18 +1812,18 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			ebdp = (struct bufdesc_ex *)bdp;
 
 		/* If this is a VLAN packet remove the VLAN Tag */
-		vlan_packet_rcvd = false;
 		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
 		    fep->bufdesc_ex &&
 		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
 			/* Push and remove the vlan tag */
 			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
-			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
-
-			vlan_packet_rcvd = true;
+			u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
 
 			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
+			__vlan_hwaccel_put_tag(skb,
+					       htons(ETH_P_8021Q),
+					       vlan_tag);
 		}
 
 		skb->protocol = eth_type_trans(skb, ndev);
@@ -1845,12 +1843,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			}
 		}
 
-		/* Handle received VLAN packets */
-		if (vlan_packet_rcvd)
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-
 		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 

-- 
2.45.2



