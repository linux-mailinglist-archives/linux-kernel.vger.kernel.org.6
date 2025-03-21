Return-Path: <linux-kernel+bounces-570923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90671A6B64A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6318E19C5636
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D81F12F8;
	Fri, 21 Mar 2025 08:50:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23E1F03C5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547029; cv=none; b=a3T4izJ02QniVaarHlsNNDSupzlC/SKcmBdrEwJaGQH6qbfEDc7GycQmnwGE0D2GTO2KuvzabSLLCi+CTCr9wc7SREBkeMIuXQyaHYr5b8VjnTor9IEtHSyb1/m4bBGA03kHUb+Ge/lz3shBdKSS6PjkkJCbrRky2WRqJXAVMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547029; c=relaxed/simple;
	bh=Jv1NSGT2N7HVk3/ySZFtdiSWqxrSSCGwJlYA6fMHMyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMvzCvJpiJbp4AlFSDZaIHZYouHIUqIkQJ6GIh/8C1mI52cJLxeMR/gib12md29KIaYOSDKEgt+S/rcxLL2gWq6BMRes5jCagiQhv6xO7GYUpn18QYyMgvEdSlbdAFV14lO3yT29z5XZaCIvgFP17pwklyhoahLPwrQdvyvsUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Ls-HB; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taM-2X;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-08;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:03 +0100
Subject: [PATCH v4 03/10] wifi: mwifiex: drop unnecessary initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-3-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547013; l=2020;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Jv1NSGT2N7HVk3/ySZFtdiSWqxrSSCGwJlYA6fMHMyo=;
 b=zoCPeuAjsFM0WaqxDJfjMG1A2BzWTNjjlSpI5WXZ8JoyCm2BMDvnn+YL9tZwfpeMnTVESUK/6
 QZ8fInmcgbqA7vTcw5Xia0zG5Fv+WkwvWm/l+HysEplR/16lNCg0Jai
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Several functions initialize the priv * without actually using the
initialized value. Drop the initialization.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++----
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index b318210366f7c..fa2f13c21bea4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -472,8 +472,7 @@ void mwifiex_free_cmd_buffer(struct mwifiex_adapter *adapter)
 int mwifiex_process_event(struct mwifiex_adapter *adapter)
 {
 	int ret, i;
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	struct sk_buff *skb = adapter->event_skb;
 	u32 eventcause;
 	struct mwifiex_rxinfo *rx_info;
@@ -808,8 +807,7 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 {
 	struct host_cmd_ds_command *resp;
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	int ret = 0;
 	uint16_t orig_cmdresp_no;
 	uint16_t cmdresp_no;
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index bd91678d26b49..f44e22f245110 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -24,8 +24,7 @@
 int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 			     struct sk_buff *skb)
 {
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	struct rxpd *local_rx_pd;
 	struct mwifiex_rxinfo *rx_info = MWIFIEX_SKB_RXCB(skb);
 	int ret;

-- 
2.39.5


