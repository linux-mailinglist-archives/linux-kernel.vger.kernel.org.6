Return-Path: <linux-kernel+bounces-533553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99BA45BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3996F1886AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028624E00D;
	Wed, 26 Feb 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jQC9vgkx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC891ACEA6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566310; cv=none; b=KbHXG0Fg375czGvquav5cgAu7BcpWtJ5vlJxMyrwh/QMRgECVQlC7vGoLE67Jhh6c5PP1x6ytnKvTtA7FiPOXD/NOWQYtrl7gHsgzzEtdPQ5jpTDOVcOG3SN3EgHEOMslNN59YIxo5+rdP1dU6PFLBZxaA2WQlN9f8LNGSx0d74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566310; c=relaxed/simple;
	bh=bX0Dhp/77Twr0Hq83smdM+lYe1IN/WVSkMiowXkfuvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/jG+IM94hEehF/CcX1MyPlDltR0LR8FlJLk9QG0TYybHPAijZkOGB2mwuIHYhSopaOtj0lX+vKGg1RU0swiTytQ3lEDh7Olsln9qz+GyWtkMydA0QkEjZmdHEwzaav36bHI+pH4xZADnJUIdczMylz1PaTYjuVo0ylujoG8pI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jQC9vgkx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mRmd87Bt4r/gRs/8A2tyjVoJarc357y7FoApmSgOrbg=; b=jQC9vgkx1+0En9VesSDoKW11QF
	BmNxkXGLOF8S0n62Y3KY7U7t3vdTq+yN6cRLw61ZoG/U6DLQiSBxemp0n+xUBkAEBFNhYqZ3ADFMh
	ChXOQe9ujdrerGH8jiLvisoMfcR+rYYx/2gHsSvAnTulNvyJlQo2vUvpwolh6GIsn0gBEOMb3udSz
	D+VmoOwmU9EMnDDXRYC22pJAm6u2WaSjq84Aucra6/hHtJrviNhxT5UFz/1CAzW8GjCzoBxnVB3uK
	Q8f2p5lKQURAgUJZe7gbGqafZRNG4yTGclhAwSy0zoL8wullQu4u42sE3utdawakSmkMFEVCLP8cs
	uUwjyURQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnEo3-0006aJ-Fw; Wed, 26 Feb 2025 11:38:23 +0100
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
	christophe.jaillet@wanadoo.fr,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on orientation-change
Date: Wed, 26 Feb 2025 11:38:10 +0100
Message-ID: <20250226103810.3746018-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226103810.3746018-1-heiko@sntech.de>
References: <20250226103810.3746018-1-heiko@sntech.de>
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
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 960cad5b01a9..c07b79da5b6b 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1277,6 +1277,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
 				 enum typec_orientation orien)
 {
 	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
+	int ret = 0;
 
 	mutex_lock(&udphy->mutex);
 
@@ -1292,9 +1293,13 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
 	rk_udphy_set_typec_default_mapping(udphy);
 	rk_udphy_usb_bvalid_enable(udphy, true);
 
+	/* re-init the phy if already on */
+	if (udphy->status != UDPHY_MODE_NONE)
+		ret = rk_udphy_init(udphy);
+
 unlock_ret:
 	mutex_unlock(&udphy->mutex);
-	return 0;
+	return ret;
 }
 
 static void rk_udphy_orien_switch_unregister(void *data)
-- 
2.47.2


