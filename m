Return-Path: <linux-kernel+bounces-293891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A624958637
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BCE28409C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28F18F2CA;
	Tue, 20 Aug 2024 11:55:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24A18CC0E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154939; cv=none; b=nmM2IG+EgC0bg3dEitVCk/NqkJAWZICgFOw1l0uLvzMBMeFMuGCEY3HbYkXmk7eloc0ndG64KYBQ0UVfatgrMlm0r7GSr8e8bhDGieCoEM4cZIg1zE56fD8iY8InFx/2qte8YNbxvW33/VmtIUpt94ey16+4cn0kaMbw3cKDY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154939; c=relaxed/simple;
	bh=4l8aTmB4Yh2mmWzYmdKq+bEDqq6/Dn/miS3I5NOxC9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRsVTgYABZ6TyUfHNRU2I4KOifR/TIH9ZF0YJAkmZyyey2TqdJ6a6QiCG5e49izL2AMifNIIAZyhBw3YCFDzq670ZntufKySa5P2GkxNatHdkdOL6z3Oib2D7oaH2KIIq2wVAQsuzxWdyWN/D4bn3qofbJhmw4w9gEhMyy+Miw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSS-0000Ah-5X; Tue, 20 Aug 2024 13:55:28 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-001lLg-DY; Tue, 20 Aug 2024 13:55:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-16;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:27 +0200
Subject: [PATCH 02/31] wifi: mwifiex: use adapter as context pointer for
 mwifiex_hs_activated_event()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-2-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=7272;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=4l8aTmB4Yh2mmWzYmdKq+bEDqq6/Dn/miS3I5NOxC9k=;
 b=kCSh3U31oKporlY3WKjHjcmrwNJWZzVyYLa+begVORdws3FuNwBSUefHv3caRufO5RuF1MkFP
 GvqJzeEwVXSDeKsI3PubQBdGySL+2ZzLjQexe/uPabTTav8nmmJ+x4E
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

mwifiex_hs_activated_event() takes a struct mwifiex_private * as
context pointer which this function doesn't need directly and the callers
don't have. Use struct mwifiex_adapter * instead to simplify both the
function and the callers.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 44 ++++++++++++---------------
 drivers/net/wireless/marvell/mwifiex/main.c   | 15 ++-------
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 7894102f03eb0..48c0d9e9dff71 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -367,8 +367,7 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 	    (test_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags) &&
 	     !adapter->sleep_period.period)) {
 		adapter->pm_wakeup_card_req = true;
-		mwifiex_hs_activated_event(mwifiex_get_priv
-				(adapter, MWIFIEX_BSS_ROLE_ANY), true);
+		mwifiex_hs_activated_event(adapter, true);
 	}
 
 	return ret;
@@ -784,17 +783,16 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 	ret = mwifiex_dnld_cmd_to_fw(priv, cmd_node);
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+
 	/* Any command sent to the firmware when host is in sleep
 	 * mode should de-configure host sleep. We should skip the
 	 * host sleep configuration command itself though
 	 */
-	if (priv && (host_cmd->command !=
-	     cpu_to_le16(HostCmd_CMD_802_11_HS_CFG_ENH))) {
+	if (host_cmd->command != cpu_to_le16(HostCmd_CMD_802_11_HS_CFG_ENH)) {
 		if (adapter->hs_activated) {
 			clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 				  &adapter->work_flags);
-			mwifiex_hs_activated_event(priv, false);
+			mwifiex_hs_activated_event(adapter, false);
 		}
 	}
 
@@ -1158,27 +1156,27 @@ mwifiex_check_ps_cond(struct mwifiex_adapter *adapter)
  * This event is generated by the driver, with a blank event body.
  */
 void
-mwifiex_hs_activated_event(struct mwifiex_private *priv, u8 activated)
+mwifiex_hs_activated_event(struct mwifiex_adapter *adapter, u8 activated)
 {
 	if (activated) {
 		if (test_bit(MWIFIEX_IS_HS_CONFIGURED,
-			     &priv->adapter->work_flags)) {
-			priv->adapter->hs_activated = true;
-			mwifiex_update_rxreor_flags(priv->adapter,
+			     &adapter->work_flags)) {
+			adapter->hs_activated = true;
+			mwifiex_update_rxreor_flags(adapter,
 						    RXREOR_FORCE_NO_DROP);
-			mwifiex_dbg(priv->adapter, EVENT,
+			mwifiex_dbg(adapter, EVENT,
 				    "event: hs_activated\n");
-			priv->adapter->hs_activate_wait_q_woken = true;
+			adapter->hs_activate_wait_q_woken = true;
 			wake_up_interruptible(
-				&priv->adapter->hs_activate_wait_q);
+				&adapter->hs_activate_wait_q);
 		} else {
-			mwifiex_dbg(priv->adapter, EVENT,
+			mwifiex_dbg(adapter, EVENT,
 				    "event: HS not configured\n");
 		}
 	} else {
-		mwifiex_dbg(priv->adapter, EVENT,
+		mwifiex_dbg(adapter, EVENT,
 			    "event: hs_deactivated\n");
-		priv->adapter->hs_activated = false;
+		adapter->hs_activated = false;
 	}
 }
 
@@ -1202,7 +1200,7 @@ int mwifiex_ret_802_11_hs_cfg(struct mwifiex_private *priv,
 
 	if (phs_cfg->action == cpu_to_le16(HS_ACTIVATE) &&
 	    adapter->iface_type != MWIFIEX_USB) {
-		mwifiex_hs_activated_event(priv, true);
+		mwifiex_hs_activated_event(adapter, true);
 		return 0;
 	} else {
 		mwifiex_dbg(adapter, CMD,
@@ -1215,11 +1213,11 @@ int mwifiex_ret_802_11_hs_cfg(struct mwifiex_private *priv,
 	if (conditions != HS_CFG_CANCEL) {
 		set_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 		if (adapter->iface_type == MWIFIEX_USB)
-			mwifiex_hs_activated_event(priv, true);
+			mwifiex_hs_activated_event(adapter, true);
 	} else {
 		clear_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 		if (adapter->hs_activated)
-			mwifiex_hs_activated_event(priv, false);
+			mwifiex_hs_activated_event(adapter, false);
 	}
 
 	return 0;
@@ -1248,9 +1246,7 @@ mwifiex_process_hs_config(struct mwifiex_adapter *adapter)
 	adapter->hs_activated = false;
 	clear_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
-	mwifiex_hs_activated_event(mwifiex_get_priv(adapter,
-						    MWIFIEX_BSS_ROLE_ANY),
-				   false);
+	mwifiex_hs_activated_event(adapter, false);
 }
 EXPORT_SYMBOL_GPL(mwifiex_process_hs_config);
 
@@ -1300,9 +1296,7 @@ mwifiex_process_sleep_confirm_resp(struct mwifiex_adapter *adapter,
 	}
 	adapter->pm_wakeup_card_req = true;
 	if (test_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags))
-		mwifiex_hs_activated_event(mwifiex_get_priv
-						(adapter, MWIFIEX_BSS_ROLE_ANY),
-					   true);
+		mwifiex_hs_activated_event(adapter, true);
 	adapter->ps_state = PS_STATE_SLEEP;
 	cmd->command = cpu_to_le16(command);
 	cmd->seq_num = cpu_to_le16(seq_num);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 96d1f6039fbca..f6b0060dc87dd 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -415,10 +415,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					(adapter, MWIFIEX_BSS_ROLE_ANY),
-					false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
@@ -438,10 +435,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					 (adapter, MWIFIEX_BSS_ROLE_ANY),
-					 false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
@@ -460,10 +454,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					 (adapter, MWIFIEX_BSS_ROLE_ANY),
-					 false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 529863edd7a25..846320514583b 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1129,7 +1129,7 @@ int mwifiex_ret_enh_power_mode(struct mwifiex_private *priv,
 			       struct host_cmd_ds_command *resp,
 			       struct mwifiex_ds_pm_cfg *pm_cfg);
 void mwifiex_process_hs_config(struct mwifiex_adapter *adapter);
-void mwifiex_hs_activated_event(struct mwifiex_private *priv,
+void mwifiex_hs_activated_event(struct mwifiex_adapter *adapter,
 					u8 activated);
 int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
 			  int cmd_type, struct mwifiex_ds_hs_cfg *hs_cfg);

-- 
2.39.2


