Return-Path: <linux-kernel+bounces-293923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE8958685
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657AD1C24C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891A194AFA;
	Tue, 20 Aug 2024 12:00:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2218FC67
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155236; cv=none; b=QtP95EXpWLVQ8NCSatIQaBl3x57zSJQDtI1E/qxcFvAgtYPEn7czGAsHv8uGAtpy0Ib19CQAAe2zrVoBcmfHEKpWBYzlNJ1c63nffSdywHIiSK/Omr2Majtd9bEH4ePDE2fxYlieJyoOFhc+nVICyZKS8Z25SszrPEP0Jos751Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155236; c=relaxed/simple;
	bh=s36KVY/Eo8CMBTbTA6p/cUDom9ZOuOO/I+ZP4Ffayd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J69otRbgVzIGZBIgv9bTiyEsF+qJZ7uZ7iNR8T/x3IlxEKmILVG5/3STHvWr130IsYwM/DwYhv1c4JocsTn08/jwJykZmf5zUmR5M56LXcA+l23zdjMNVrbu/bf+j5fCa8S/o5BU+iPqCVNmS2T2lXhi9sDC3du2mjWLc/F96TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000yw-R9; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-001lO7-9t; Tue, 20 Aug 2024 14:00:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1b;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:56 +0200
Subject: [PATCH 31/31] wifi: mwifiex: allow to set MAC address in
 add_virtual_intf()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-31-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=1449;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=s36KVY/Eo8CMBTbTA6p/cUDom9ZOuOO/I+ZP4Ffayd8=;
 b=JjZAXsGkpHCFJYcgcuHWqcbIaxTpmE4KKPrNwL4D7QJMn9iZTeUiuRdAG+WJUjecdpyke2/IO
 xs69E+J06OcAbB//564CTQUN58KHc1SzSnCWYsmExYDOSJ/DVKLFtf8
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The MAC address of a newly created virtual interface can be specified
via struct vif_params *. Add support for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 45f85493985b9..cd9594c18ed6c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2927,7 +2927,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	priv->netdev = dev;
 
 	if (!adapter->mfg_mode) {
-		mwifiex_set_default_mac_address(priv, dev);
+
+		if (params && !is_zero_ether_addr(params->macaddr))
+			mwifiex_set_mac_address(priv, dev, params->macaddr);
+		else
+			mwifiex_set_default_mac_address(priv, dev);
 
 		ret = mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
 				       HostCmd_ACT_GEN_SET, 0, NULL, true);
@@ -4637,7 +4641,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	wiphy->features |= NL80211_FEATURE_INACTIVITY_TIMER |
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
-			   NL80211_FEATURE_NEED_OBSS_SCAN;
+			   NL80211_FEATURE_NEED_OBSS_SCAN |
+			   NL80211_FEATURE_MAC_ON_CREATE;
 
 	if (adapter->host_mlme_enabled)
 		wiphy->features |= NL80211_FEATURE_SAE;

-- 
2.39.2


