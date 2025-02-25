Return-Path: <linux-kernel+bounces-532266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18AA44AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF73A936F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37E1A8F6E;
	Tue, 25 Feb 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="G4w/ryyC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB7198831
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509152; cv=none; b=XyGeVAsWhh15bO0O8fZfwt8buj6UY8Wpiyet5y4AqaBOVefRciF+B07xZB7E4krOkjHb0vxwYBy4wR389FBdAMqYzQP/3euwtuF5iWsolLwiIN91DIkG4hlINKH8StcDGqUiPE2vFnvXjzhttsdAB2K5USOUs+xSuYJNU4bfW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509152; c=relaxed/simple;
	bh=xeFL9wUs59was7//NbLd0nLZZhiyNOZtpvSK1Qn9NdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo0WeBbOGJw8nCg9uRiKzS8/k5MzHDNfrII9zGIpB1gjFlUozKbtoGGq8HurtuUX72/OHAAa4fLEtX0Bogq4BxmZ2qPfdK7JkQiamgHuHKkBtqZ3xsN6vKVrM5TN481OEIjOCLlJ2bOUTXP1PqLe4dsGLzW5wgYA5GzcSxIGBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=G4w/ryyC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XeSCoetpG/SJX3eWF6c3URGWyxwIKqpjVdjc1wvJfqo=; b=G4w/ryyC1YyWT1pGEHP6owKkVE
	depvliKv+XPgjl87c5JJ4ue/1Z4D2aPKOMq09HYD1brPFC4dHBjx1h/8d/RMq1BW/t6u1xqoFqZPn
	vkrUc9wHNZ1FHjGG1CTjtLVu1Bf3Mdr1UWd+N3EnyoAoBQBHyvW/oFTc1VxnVblbTuQINrunJAEe4
	s86KeXChNghQEjzUNnlitV/7pPRDQliYA2Yu0FaTZdjGhs2VL99JV3/nHCDt8gvaS7zEQ01uThRn5
	ATS70U7MIUnTHmJP52jVa9TQxw6z1Y1ohqwEPY5QVlxgczlQppPZ5/AEc2y3sMU5S6/8eKnrcCj21
	O0s5wTVA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmzw7-0006r3-PJ; Tue, 25 Feb 2025 19:45:43 +0100
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
Subject: [PATCH 1/2] phy: rockchip: usbdp: move type-orientation-switch further down
Date: Tue, 25 Feb 2025 19:45:18 +0100
Message-ID: <20250225184519.3586926-2-heiko@sntech.de>
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

Move the typec-orientation-switch functionality further down, next to
the typec-mux code. Not only brings this the typec-related functionality
closer together, but also the following change needs access to other
driver functions, that are below the current position.

No functional change.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 166 +++++++++++-----------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 5b1e8a3806ed..7b17c82ebcfc 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -616,89 +616,6 @@ static void rk_udphy_dp_hpd_event_trigger(struct rk_udphy *udphy, bool hpd)
 	rk_udphy_grfreg_write(udphy->vogrf, &cfg->vogrfcfg[udphy->id].hpd_trigger, hpd);
 }
 
-static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
-{
-	if (udphy->flip) {
-		udphy->dp_lane_sel[0] = 0;
-		udphy->dp_lane_sel[1] = 1;
-		udphy->dp_lane_sel[2] = 3;
-		udphy->dp_lane_sel[3] = 2;
-		udphy->lane_mux_sel[0] = PHY_LANE_MUX_DP;
-		udphy->lane_mux_sel[1] = PHY_LANE_MUX_DP;
-		udphy->lane_mux_sel[2] = PHY_LANE_MUX_USB;
-		udphy->lane_mux_sel[3] = PHY_LANE_MUX_USB;
-		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_INVERT;
-		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_INVERT;
-		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
-		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
-	} else {
-		udphy->dp_lane_sel[0] = 2;
-		udphy->dp_lane_sel[1] = 3;
-		udphy->dp_lane_sel[2] = 1;
-		udphy->dp_lane_sel[3] = 0;
-		udphy->lane_mux_sel[0] = PHY_LANE_MUX_USB;
-		udphy->lane_mux_sel[1] = PHY_LANE_MUX_USB;
-		udphy->lane_mux_sel[2] = PHY_LANE_MUX_DP;
-		udphy->lane_mux_sel[3] = PHY_LANE_MUX_DP;
-		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_NORMAL;
-		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_NORMAL;
-		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
-		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
-	}
-
-	udphy->mode = UDPHY_MODE_DP_USB;
-}
-
-static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
-				 enum typec_orientation orien)
-{
-	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
-
-	mutex_lock(&udphy->mutex);
-
-	if (orien == TYPEC_ORIENTATION_NONE) {
-		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
-		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
-		/* unattached */
-		rk_udphy_usb_bvalid_enable(udphy, false);
-		goto unlock_ret;
-	}
-
-	udphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
-	rk_udphy_set_typec_default_mapping(udphy);
-	rk_udphy_usb_bvalid_enable(udphy, true);
-
-unlock_ret:
-	mutex_unlock(&udphy->mutex);
-	return 0;
-}
-
-static void rk_udphy_orien_switch_unregister(void *data)
-{
-	struct rk_udphy *udphy = data;
-
-	typec_switch_unregister(udphy->sw);
-}
-
-static int rk_udphy_setup_orien_switch(struct rk_udphy *udphy)
-{
-	struct typec_switch_desc sw_desc = { };
-
-	sw_desc.drvdata = udphy;
-	sw_desc.fwnode = dev_fwnode(udphy->dev);
-	sw_desc.set = rk_udphy_orien_sw_set;
-
-	udphy->sw = typec_switch_register(udphy->dev, &sw_desc);
-	if (IS_ERR(udphy->sw)) {
-		dev_err(udphy->dev, "Error register typec orientation switch: %ld\n",
-			PTR_ERR(udphy->sw));
-		return PTR_ERR(udphy->sw);
-	}
-
-	return devm_add_action_or_reset(udphy->dev,
-					rk_udphy_orien_switch_unregister, udphy);
-}
-
 static int rk_udphy_refclk_set(struct rk_udphy *udphy)
 {
 	unsigned long rate;
@@ -1323,6 +1240,89 @@ static const struct phy_ops rk_udphy_usb3_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
+{
+	if (udphy->flip) {
+		udphy->dp_lane_sel[0] = 0;
+		udphy->dp_lane_sel[1] = 1;
+		udphy->dp_lane_sel[2] = 3;
+		udphy->dp_lane_sel[3] = 2;
+		udphy->lane_mux_sel[0] = PHY_LANE_MUX_DP;
+		udphy->lane_mux_sel[1] = PHY_LANE_MUX_DP;
+		udphy->lane_mux_sel[2] = PHY_LANE_MUX_USB;
+		udphy->lane_mux_sel[3] = PHY_LANE_MUX_USB;
+		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_INVERT;
+		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_INVERT;
+		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
+		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
+	} else {
+		udphy->dp_lane_sel[0] = 2;
+		udphy->dp_lane_sel[1] = 3;
+		udphy->dp_lane_sel[2] = 1;
+		udphy->dp_lane_sel[3] = 0;
+		udphy->lane_mux_sel[0] = PHY_LANE_MUX_USB;
+		udphy->lane_mux_sel[1] = PHY_LANE_MUX_USB;
+		udphy->lane_mux_sel[2] = PHY_LANE_MUX_DP;
+		udphy->lane_mux_sel[3] = PHY_LANE_MUX_DP;
+		udphy->dp_aux_dout_sel = PHY_AUX_DP_DATA_POL_NORMAL;
+		udphy->dp_aux_din_sel = PHY_AUX_DP_DATA_POL_NORMAL;
+		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
+		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
+	}
+
+	udphy->mode = UDPHY_MODE_DP_USB;
+}
+
+static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
+				 enum typec_orientation orien)
+{
+	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
+
+	mutex_lock(&udphy->mutex);
+
+	if (orien == TYPEC_ORIENTATION_NONE) {
+		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
+		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
+		/* unattached */
+		rk_udphy_usb_bvalid_enable(udphy, false);
+		goto unlock_ret;
+	}
+
+	udphy->flip = (orien == TYPEC_ORIENTATION_REVERSE) ? true : false;
+	rk_udphy_set_typec_default_mapping(udphy);
+	rk_udphy_usb_bvalid_enable(udphy, true);
+
+unlock_ret:
+	mutex_unlock(&udphy->mutex);
+	return ret;
+}
+
+static void rk_udphy_orien_switch_unregister(void *data)
+{
+	struct rk_udphy *udphy = data;
+
+	typec_switch_unregister(udphy->sw);
+}
+
+static int rk_udphy_setup_orien_switch(struct rk_udphy *udphy)
+{
+	struct typec_switch_desc sw_desc = { };
+
+	sw_desc.drvdata = udphy;
+	sw_desc.fwnode = dev_fwnode(udphy->dev);
+	sw_desc.set = rk_udphy_orien_sw_set;
+
+	udphy->sw = typec_switch_register(udphy->dev, &sw_desc);
+	if (IS_ERR(udphy->sw)) {
+		dev_err(udphy->dev, "Error register typec orientation switch: %ld\n",
+			PTR_ERR(udphy->sw));
+		return PTR_ERR(udphy->sw);
+	}
+
+	return devm_add_action_or_reset(udphy->dev,
+					rk_udphy_orien_switch_unregister, udphy);
+}
+
 static int rk_udphy_typec_mux_set(struct typec_mux_dev *mux,
 				  struct typec_mux_state *state)
 {
-- 
2.47.2


