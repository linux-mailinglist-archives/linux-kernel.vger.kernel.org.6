Return-Path: <linux-kernel+bounces-368812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2159A152B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60B1281BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5691D63C2;
	Wed, 16 Oct 2024 21:52:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925171D417B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115553; cv=none; b=TTnEoQLC064j0C7chxM4er0b1rQw3aXIotYnAK/P/em5fUy4n67xebMdF2sioAUvT+afasouG5FLMOfTPzEg7G7mOVZ6SGTC6tfyMsajk3b2S0C/oz6wEjAZKprGAIF+5r3KNLemDN2nWEYGikKmHOIjvxCTL4z1on7s0ofOxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115553; c=relaxed/simple;
	bh=zoqa4/qjUTosQu+UdqhFvWMUmsFqzpqM7mynr9fdngM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KX/zofWkOhixd2eDyCsjZjRk/oZ9WUx4q6KobInyZSeIiJFbMjBIEiSvRomVKib40GPVMKASla2Avh50cI/eGNIcrrA99QhHNDWOQyI5StjGQN1/v+Udv/7cEn/sdOCgxAKUEjU34CaDzIdwfyFXnaYOHYHK8yL+D4bqX4xMnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwO-0003JP-1L
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwN-002OOz-6Z
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D0E443548BC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B77E0354878;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7f775bdc;
	Wed, 16 Oct 2024 21:52:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 00/13] net: fec: cleanups, update quirk, update
 IRQ naming
Date: Wed, 16 Oct 2024 23:51:48 +0200
Message-Id: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHU1EGcC/x3MQQqDMBBG4avIrB1IQwJNryJd6PTXDpRREhVBv
 HuDy2/x3kkFWVHo1ZyUsWvR2SoebUPy7W0C66eavPPBJR95hLD80Nu2FJY0xBjCIM8YqCZLxqj
 HvevIsLLhWOl9XX8a8EwKaAAAAA==
X-Change-ID: 20240925-fec-cleanups-c9b5544bc854
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zoqa4/qjUTosQu+UdqhFvWMUmsFqzpqM7mynr9fdngM=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhnQB0/IMITvTkurphZ7SLPePMr7m7roouuZH+K7Te+INS
 7LEGkQ7GY1ZGBi5GGTFFFkCHHa1PdjGcldzj108zCBWJpApDFycAjCRhG0cDNPbL09WqTb/ufil
 6yEPnTPZHxWF7sWZTpl49lhq59VqWdezXk+UQt91L3kR0/NQ/mjsvZXVU67p9x/oEmDI+x7uYr2
 69Z4us3DqrndVwbs/nZAP8eBjLa2I5Jkf4hTmfPrusiLf2e5Sc645rrvM0lWTW2icGz/L5l/Kta
 z/zFMto85+zqkyOPtd0sVj450dWSbX+b4ITmLkWhR1jq8xV0qmSag4d2FXjeB9T58unro0ZRX9R
 pV/8tUfdR4pT2eTP1iZ+PBh9odGtXS2da5mbE9aK/fOO/vob8qGhew+6y52XXlk9Dr/xeyr/nF6
 LYZ2Uy9MMz3wcUe+w+5Ct9XGL43N51mn7FwaxnhI9JgCAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series first cleans up the fec driver a bit (typos, obsolete
comments, add missing header files, rename struct, replace magic
number by defines).

The next 2 patches update the order of IRQs in the driver and gives
them names that reflect their function.

The last 5 patches clean up the fec_enet_rx_queue() function,
including VLAN handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (13):
      net: fec: fix typos found by codespell
      net: fec: struct fec_enet_private: remove obsolete comment
      net: fec: add missing header files
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
      net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
      net: fec: fec_restart(): make use of FEC_ECR_RESET
      net: fec: fec_probe(): update quirk: bring IRQs in correct order
      net: fec: fec_probe(): let IRQ name reflect its function
      net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
      net: fec: fec_enet_rx_queue(): replace open coded cast by skb_vlan_eth_hdr()
      net: fec: fec_enet_rx_queue(): reduce scope of data
      net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
      net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()

 drivers/net/ethernet/freescale/fec.h      | 35 ++++++++++---
 drivers/net/ethernet/freescale/fec_main.c | 85 +++++++++++++++++--------------
 drivers/net/ethernet/freescale/fec_ptp.c  |  9 ++--
 3 files changed, 81 insertions(+), 48 deletions(-)
---
base-commit: 53bac8330865417332d4cf80cb671b15956b049d
change-id: 20240925-fec-cleanups-c9b5544bc854

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



