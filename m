Return-Path: <linux-kernel+bounces-532267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E21A44ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5418A4235D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8D1A727D;
	Tue, 25 Feb 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="waLc+/pz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68D18B46C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509152; cv=none; b=i4x/D8dmy/okgAh9ewuqr4xwilNvBkTQb5q2PEBDcp4uknoxa/bgDrI4NFNOKhBR6rp6NZ5tuatsjL726ZEJb1U7k/qd98Y+qXF//xtlVf4KTbJNgTNe2ySkPCmuDGqsEcMBblO3XgVjnQi729ZcYyzIhfNoNZPJwMqiNZPIMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509152; c=relaxed/simple;
	bh=TnaFHs+imcpAOeBkebelwQ6tPmd1SeYf73yltp04lu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZsNCJ9U9Ju+y5Gpqd28IOBYTmm8IovCHQFj4N57MRVybBzK/Z6xm8mJCXQGLiH/ovvpG9sfMhLQCTkdkKUwMwRrNNce4fmmDN+nskNqGNrC9FttcDNeFTJKqv2YuF3ng+bsFqSzLCtEQT0MZcit72AN0pzCCviVeylT9Xf7Uzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=waLc+/pz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/+beY3V9/dsi/eMagTUtxWvMmsE568RPkT0UJ+9W24k=; b=waLc+/pzfueh2JBlw6t6cI5SrM
	OSmvOm0bhEWmdDHaP9/XmcmztaOdGrkcmpyRwMBj9O5QDN1gFz99v0szxP3InL9jW6vxCSmAhNk/f
	MsttMJ+Grp6AIklxFpjYvzYxNyGr9vvU6mnc0wwNK849+O671VRSV0yfgLfrL+bl6Py7enDpA0fW9
	OdEbxCDPH5WehSBT7haFOLNsOzHJUD4tRZQKf80VYVJDl+FGCslchjPkVBLBZNp0Q1tAdoGxOPQGo
	ezwa6XjOZ29LWfJF9mQ9fXLjPC6VU/sZtJSKYJPfP/Q7cWudAaRfXMMRJM2J2zcBdfTjeIsUhIBG1
	MMSHBHXg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmzw8-0006r3-7b; Tue, 25 Feb 2025 19:45:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] phy: rockchip: usbdp: re-init the phy on orientation-change
Date: Tue, 25 Feb 2025 19:45:19 +0100
Message-ID: <20250225184519.3586926-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225184519.3586926-1-heiko@sntech.de>
References: <20250225184519.3586926-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Until now the usbdp in the orientation-handler set the new lane setup in
its internal state variables and adapted the sbu gpios as needed.
It never actually updated the phy itself though, but relied on the
controlling usb-controller to disable and re-enable the phy.

And while on the vendor-kernel, I could see that on every unplug the dwc3
did go to its suspend and woke up on the next device plug-in event,
thus toggling the phy as needed, this does not happen in all cases and we
should not rely on that behaviour.

This results in the usb2 always working, as it's not affected by the
orientation, but usb3 only working in one direction right now.

So similar to how the update works in the power-on callback, just re-init
the phy if it's already running when the orientation-event happens.

Both the power-on/-off functions as well as the orientation-set callback
work with the usbdp-mutex held, so can't conflict.

The behaviour is similar to how the qcom qmp phys handle the orientaton
re-init - by re-initting the phy.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 7b17c82ebcfc..b63259a90d85 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1277,6 +1277,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
 				 enum typec_orientation orien)
 {
 	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
+	int ret = 0;
 
 	mutex_lock(&udphy->mutex);
 
@@ -1292,6 +1293,12 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
 	rk_udphy_set_typec_default_mapping(udphy);
 	rk_udphy_usb_bvalid_enable(udphy, true);
 
+	/* re-init the phy if already on */
+	if (udphy->status != UDPHY_MODE_NONE) {
+		rk_udphy_disable(udphy);
+		ret = rk_udphy_setup(udphy);
+	}
+
 unlock_ret:
 	mutex_unlock(&udphy->mutex);
 	return ret;
-- 
2.47.2


