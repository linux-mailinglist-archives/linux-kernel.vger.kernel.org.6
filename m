Return-Path: <linux-kernel+bounces-293919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21938958682
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07151F21C51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E0193082;
	Tue, 20 Aug 2024 12:00:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAE18F2C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155234; cv=none; b=ANP5OC4gL72PsZNFlEWVWADoczVp5XWJOAxK7zv1r1Hg8VnqDySG2N5SjsqePqSQGfKwURO/JK2L3AlC3MwtS9iutt+SGyza2Dj+rkeCGCPxaYQExpjc10n9MJ15i//1Z55XcENPyu/rWtDbXnq1N/n0o94Spd7o8R/mH+DPi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155234; c=relaxed/simple;
	bh=813Z8f7kVRykMfTiH/TEg9N5o+7rH3yWTypXr1KkaKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shJXcGDEd6CnJUYzCQ1rz0OCSBBbPgCHd9WkiaAsKF7rodu7LcqFjAjdqco8cbOl7RfhTL1K+BaWAMlK69xNp5pimh64lTQ9uHO/+TEUOi3XTnsFomsVgq2fP4X0iZvpbK9v5puroIcyNLSW2oINkMbkHhL1YbGk4iH4akFUDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000xK-Bb; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNo-Rl; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1P;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:44 +0200
Subject: [PATCH 19/31] wifi: mwifiex: add function to send command specific
 to the adapter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-19-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=6556;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=813Z8f7kVRykMfTiH/TEg9N5o+7rH3yWTypXr1KkaKc=;
 b=cilVeq2sFDwvN7oKYrqmQQ7Q2izS4hlBcXGp/Ajj4cY1PeDKPuB+WgRLxeENdqjBIXBq0UqT7
 dFg4omWrDgaCNBueHMAY/QapUUi+CLQGbrt9bEhAvS8sX/+iT7H+7YX
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Current mwifiex_send_command() takes a struct mwifiex_private * as
context pointer. There are several commands though that are specific
to the whole adapter and not to priv *. For these commands introduce
a mwifiex_adapter_send_command() function that takes the adapter as
context pointer. Some users are updated to use this function, more
will be converted in followup patches.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 13 ++++---------
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/main.c     | 11 ++++-------
 drivers/net/wireless/marvell/mwifiex/main.h     |  4 ++++
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 4c63b849e3809..8efb3b444cabc 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -562,7 +562,6 @@ int mwifiex_send_domain_info_cmd_fw(struct wiphy *wiphy)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_channel *ch;
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv;
 	struct mwifiex_802_11d_domain_reg *domain_info = &adapter->domain_reg;
 
 	/* Set country code */
@@ -620,9 +619,7 @@ int mwifiex_send_domain_info_cmd_fw(struct wiphy *wiphy)
 
 	domain_info->no_of_triplet = no_of_triplet;
 
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
-	if (mwifiex_send_cmd(priv, HostCmd_CMD_802_11D_DOMAIN_INFO,
+	if (mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_802_11D_DOMAIN_INFO,
 			     HostCmd_ACT_GEN_SET, 0, NULL, false)) {
 		mwifiex_dbg(adapter, INFO,
 			    "11D: setting domain info in FW\n");
@@ -1814,8 +1811,6 @@ static int
 mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
-							MWIFIEX_BSS_ROLE_ANY);
 	struct mwifiex_ds_ant_cfg ant_cfg;
 
 	if (!tx_ant || !rx_ant)
@@ -1833,7 +1828,7 @@ mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 			return -EOPNOTSUPP;
 
 		if ((tx_ant == BIT(adapter->number_of_antenna) - 1) &&
-		    (priv->adapter->number_of_antenna > 1)) {
+		    (adapter->number_of_antenna > 1)) {
 			tx_ant = RF_ANTENNA_AUTO;
 			rx_ant = RF_ANTENNA_AUTO;
 		}
@@ -1869,8 +1864,8 @@ mwifiex_cfg80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
 	ant_cfg.tx_ant = tx_ant;
 	ant_cfg.rx_ant = rx_ant;
 
-	return mwifiex_send_cmd(priv, HostCmd_CMD_RF_ANTENNA,
-				HostCmd_ACT_GEN_SET, 0, &ant_cfg, true);
+	return mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_RF_ANTENNA,
+					HostCmd_ACT_GEN_SET, 0, &ant_cfg, true);
 }
 
 static int
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 34e2dcb77c14d..445fca5c43a6c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -670,6 +670,20 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 	return ret;
 }
 
+/*
+ * This function prepares a command and send it to the firmware.
+ *
+ * This function is meant to be used when a command is not specific
+ * to a struct mwifiex_private *priv, but globally to the adapter.
+ */
+int mwifiex_adapter_send_cmd(struct mwifiex_adapter *adapter, u16 cmd_no,
+			     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync)
+{
+	struct mwifiex_private *priv = adapter->priv[0];
+
+	return mwifiex_send_cmd(priv, cmd_no, cmd_action, cmd_oid, data_buf, sync);
+}
+
 /*
  * This function queues a command to the command pending queue.
  *
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index c1f9b483cb5da..6f4815f83af84 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -215,7 +215,6 @@ static int mwifiex_process_rx(struct mwifiex_adapter *adapter)
 
 static void maybe_quirk_fw_disable_ds(struct mwifiex_adapter *adapter)
 {
-	struct mwifiex_private *priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
 	struct mwifiex_ver_ext ver_ext;
 
 	if (test_and_set_bit(MWIFIEX_IS_REQUESTING_FW_VEREXT, &adapter->work_flags))
@@ -223,9 +222,9 @@ static void maybe_quirk_fw_disable_ds(struct mwifiex_adapter *adapter)
 
 	memset(&ver_ext, 0, sizeof(ver_ext));
 	ver_ext.version_str_sel = 1;
-	if (mwifiex_send_cmd(priv, HostCmd_CMD_VERSION_EXT,
+	if (mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_VERSION_EXT,
 			     HostCmd_ACT_GEN_GET, 0, &ver_ext, false)) {
-		mwifiex_dbg(priv->adapter, MSG,
+		mwifiex_dbg(adapter, MSG,
 			    "Checking hardware revision failed.\n");
 	}
 }
@@ -1054,7 +1053,6 @@ mwifiex_tx_timeout(struct net_device *dev, unsigned int txqueue)
 void mwifiex_multi_chan_resync(struct mwifiex_adapter *adapter)
 {
 	struct usb_card_rec *card = adapter->card;
-	struct mwifiex_private *priv;
 	u16 tx_buf_size;
 	int i, ret;
 
@@ -1068,9 +1066,8 @@ void mwifiex_multi_chan_resync(struct mwifiex_adapter *adapter)
 
 	card->mc_resync_flag = false;
 	tx_buf_size = 0xffff;
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-	ret = mwifiex_send_cmd(priv, HostCmd_CMD_RECONFIGURE_TX_BUFF,
-			       HostCmd_ACT_GEN_SET, 0, &tx_buf_size, false);
+	ret = mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_RECONFIGURE_TX_BUFF,
+				       HostCmd_ACT_GEN_SET, 0, &tx_buf_size, false);
 	if (ret)
 		mwifiex_dbg(adapter, ERROR,
 			    "send reconfig tx buf size cmd err\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index d3c04402a4f22..bd8bf1f5e2653 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1086,6 +1086,10 @@ int mwifiex_complete_cmd(struct mwifiex_adapter *adapter,
 int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 		     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync);
 
+int mwifiex_adapter_send_cmd(struct mwifiex_adapter *adapter, u16 cmd_no,
+			     u16 cmd_action, u32 cmd_oid, void *data_buf,
+			     bool sync);
+
 void mwifiex_cmd_timeout_func(struct timer_list *t);
 
 int mwifiex_get_debug_info(struct mwifiex_private *,

-- 
2.39.2


