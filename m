Return-Path: <linux-kernel+bounces-253712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40E9325B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F2F1F2430F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A50199E87;
	Tue, 16 Jul 2024 11:33:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA25199E80
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129621; cv=none; b=cDT2B/ah5VdG0OO81hBHZ02DrbrqQ7Ce+chBMQGVRh4jWRLvV5rFOGr0xQUKNs8w96ljYKiQcnP8PJU1GE3FJrwH1SJReRlhPey3k125NLuFAoZ51KDmVhQhqPPXp0K3qYcH+Rlv/NDkJOC+17YCNQkyxgAI5u+uSJokY6H+5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129621; c=relaxed/simple;
	bh=+Sa7K6oyaEJG8sRj0dUNOmVD+Y/rPM+1qapKlcIPxTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjdH94Bjs6iVuievRxzgPMDmfQEnCCciWbpqL7mnILXyJ3eLXs6pePmtwca4NPdwU2w/O5yLL9mtDP85OG8jGQVdAY/nh1R94qrRuC2Qb6tDlrxniv010dg+r5mDpiJ04nunAfsMENHo2e+H4tzwYyF7fjBIxt0zoL1YZC/TAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQz-0007kS-8u; Tue, 16 Jul 2024 13:33:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-0007L0-O0; Tue, 16 Jul 2024 13:33:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-009ho5-28;
	Tue, 16 Jul 2024 13:33:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 16 Jul 2024 13:33:27 +0200
Subject: [PATCH 1/2] wifi: mwifiex: simplify WPA flags setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mwifiex-wpa-psk-sha256-v1-1-05ae70f37bb3@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
In-Reply-To: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721129608; l=1966;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=+Sa7K6oyaEJG8sRj0dUNOmVD+Y/rPM+1qapKlcIPxTU=;
 b=ayozP1o3EQ91OLcAe5Vow8JhkCeiY805S76V1YzTurXniqLROYa7uaULeVd4RNLlY17i7Geub
 p/jmTqnUV8kAJbjP+Mdfqz+DE4ZCZxuxhAK0hoxvKAEGJbfilA1WDW9
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The WPA flags setting only depends on the wpa_versions bitfield and not
on the AKM suite, so move it out of the switch/case to simplify the code
a bit. No functional change intended.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 27 +++++++-------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 491e366119096..8d0cd84d27698 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -46,31 +46,18 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 
 	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
 
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+		bss_config->protocol = PROTOCOL_WPA;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+		bss_config->protocol |= PROTOCOL_WPA2;
+
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
+			bss_config->key_mgmt = KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
+			bss_config->key_mgmt = KEY_MGMT_PSK;
 			break;
 		default:
 			break;

-- 
2.39.2


