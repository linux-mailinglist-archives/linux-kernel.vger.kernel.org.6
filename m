Return-Path: <linux-kernel+bounces-280541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BCA94CBE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCD2862D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1118C93F;
	Fri,  9 Aug 2024 08:11:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E5C8D1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191108; cv=none; b=mmBQ0aAhcuq4jE9FiskbBIMl60FqR0tOBAPpO6th6dlEHoibPov9/HZp1Tr2VStH5sT3kNe4NpDZpp2xE5J28CCqKb0vbfo5tXsEtb6uTjn2R5kn1wzmZu3CmBPFKiLZC//4S4PxoKx4pxW+AFxEmHRxFG0SkFlmiDAovnf79sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191108; c=relaxed/simple;
	bh=UChDSJoOms2RnfjZHswkOIinWo6xfxR2a6fsIAsboOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L2sGfeF+OGtqZT0fDWhu0gRNFM4ueog9UbzP+vr0VmYvJPBNSUMg83b+gSTVBRDZ9ARWfLlnZpgkRaOQc/5frIIBhkJC3h+POjmYUtat/7LwpNXBH7BGPSI85Qxe3XeC17yVi5ODc5al0G5j0VJfIbQJR8lAVzmgpUSD9M2He64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scKil-0005Ly-Tl; Fri, 09 Aug 2024 10:11:35 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scKik-005cSk-Ip; Fri, 09 Aug 2024 10:11:34 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1scKik-003KfP-1Y;
	Fri, 09 Aug 2024 10:11:34 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 09 Aug 2024 10:11:33 +0200
Subject: [PATCH] mwifiex: duplicate static structs used in driver instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADTPtWYC/x2NzQqDMBAGX0X23IWotWpfRTyEZNN+0Kpk4w+I7
 97Q0zCXmZNUIkTpWZwUZYNinrKUt4Lc204vYfjsVJnqbjrT83dHgBzs1+UDZ5OwJpvgMuLqknJ
 41E0jnbdt31LOLFECjv9iGK/rBwZUc9RyAAAA
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, 
 Yogesh Ashok Powar <yogeshp@marvell.com>, Bing Zhao <bzhao@marvell.com>, 
 "John W. Linville" <linville@tuxdriver.com>, 
 Amitkumar Karwar <akarwar@marvell.com>, Avinash Patil <patila@marvell.com>
Cc: Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723191094; l=2774;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=UChDSJoOms2RnfjZHswkOIinWo6xfxR2a6fsIAsboOI=;
 b=vLLkxwiOVBMPUUy2aHzMDW4JLeM8VpJOoqr8x3Vc/I5Q7mRf7J61w9SeQr8Qp5msOXIrJWyfy
 CeDUbRSjcLIAk44gpEf8iyGuNlqoVREcOu6+DSNy3KRVLIEemPQz5xY
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
used and modified in driver instances. Duplicate them before using
them in driver instances so that different driver instances do not
influence each other.

This was observed on a board which has one PCIe and one SDIO mwifiex
adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
the statically allocated struct which is modified in this function.

Cc: stable@vger.kernel.org
Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 32 ++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b909a7665e9cc..d2e4153192032 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4361,11 +4361,27 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
 
-	wiphy->bands[NL80211_BAND_2GHZ] = &mwifiex_band_2ghz;
-	if (adapter->config_bands & BAND_A)
-		wiphy->bands[NL80211_BAND_5GHZ] = &mwifiex_band_5ghz;
-	else
+	wiphy->bands[NL80211_BAND_2GHZ] = devm_kmemdup(adapter->dev,
+						       &mwifiex_band_2ghz,
+						       sizeof(mwifiex_band_2ghz),
+						       GFP_KERNEL);
+	if (!wiphy->bands[NL80211_BAND_2GHZ]) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (adapter->config_bands & BAND_A) {
+		wiphy->bands[NL80211_BAND_5GHZ] = devm_kmemdup(adapter->dev,
+							       &mwifiex_band_5ghz,
+							       sizeof(mwifiex_band_5ghz),
+							       GFP_KERNEL);
+		if (!wiphy->bands[NL80211_BAND_5GHZ]) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	} else {
 		wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+	}
 
 	if (adapter->drcs_enabled && ISSUPP_DRCS_ENABLED(adapter->fw_cap_info))
 		wiphy->iface_combinations = &mwifiex_iface_comb_ap_sta_drcs;
@@ -4459,8 +4475,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	if (ret < 0) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: wiphy_register failed: %d\n", __func__, ret);
-		wiphy_free(wiphy);
-		return ret;
+		goto err;
 	}
 
 	if (!adapter->regd) {
@@ -4502,4 +4517,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	adapter->wiphy = wiphy;
 	return ret;
+
+err:
+	wiphy_free(wiphy);
+
+	return ret;
 }

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240809-mwifiex-duplicate-static-structs-f6355e8da797

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


