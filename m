Return-Path: <linux-kernel+bounces-259680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7C939B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C68B1F22516
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F00C14A636;
	Tue, 23 Jul 2024 07:10:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148614A0AD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718620; cv=none; b=H9TE10kFfXvLnaZpvqNDAaJYb2LxkkA1JxharHoP3buXTcWNJdt8vN0FQpqOpXK3KaM7PXt4/oF8gyoFo+jInAAxKHSImieK/y7jDT34WRqwF/c+vk5sN5Ta6/u0shvOVZbAHgKDW9YNAr+1ffa8MpYaejtOJglAtmzjI2j6isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718620; c=relaxed/simple;
	bh=wzn/r/5WRn+jiDnO4sEyQ2Ina1Q4p7Vzlb7yDTY/sSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdujaRwUwAGgJYi1sr7lsxj45c2MgMunB+nvcR3pcDklenpBYBWMxNngfdh04pNw53rzXPeECEmW7wIjry9h9LjYsDFnyImQB5EtzUGhbtPvfwAa1cGG2zh6dHSYGNGtQ9q7FS8m8SChESSiI9t0j49rXe4ke+ruBxH20aSUht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9ev-0007O8-Fu; Tue, 23 Jul 2024 09:10:05 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-001ZAY-K6; Tue, 23 Jul 2024 09:10:03 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-00FQKO-1j;
	Tue, 23 Jul 2024 09:10:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 23 Jul 2024 09:09:58 +0200
Subject: [PATCH v3 2/3] wifi: mwifiex: fix key_mgmt setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721718603; l=1724;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=wzn/r/5WRn+jiDnO4sEyQ2Ina1Q4p7Vzlb7yDTY/sSc=;
 b=AxKGRepMpo0W0EVZ8c2FWJEiZslEtRkvmjjz/rUcNIdnSOYfifcSBpFb54Iu9i54J5pKUJA2W
 HXe+VeGpYSzA5pEdISkIiliHPg9LAcaDgyEbTqi4QriqoahNW0ff+JS
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

bss_config->key_mgmt specifies the AKM suites that are usable in
hardware. This variable is set to specific values while iterating
over the advertised AKM suites. This means the final value of the
variable depends on the order of the entries in the AKM suites
array. Instead of setting the variable, just set the relevant bits
in the key_mgmt bit field to make us independent of the order of
entries.
This behaviour is derived from the downstream driver that does the
same.
Also, set bss_config->key_mgmt to zero explicitly right before the
loop. bss_config has been zero allocated by the caller already, but
do so again to safe the reader from following the code path.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 7f822660fd955..57280eaae483c 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -52,13 +52,14 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
 		bss_config->protocol |= PROTOCOL_WPA2;
 
+	bss_config->key_mgmt = 0;
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			bss_config->key_mgmt = KEY_MGMT_EAP;
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			bss_config->key_mgmt = KEY_MGMT_PSK;
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
 			break;
 		default:
 			break;

-- 
2.39.2


