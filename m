Return-Path: <linux-kernel+bounces-447038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC39F2C64
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF371673B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA12201116;
	Mon, 16 Dec 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="NCcgICdP"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E044200127;
	Mon, 16 Dec 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339310; cv=none; b=JQ4j3wsN/n/RRa++O8bsbf/tYLehsgKSNwb9kTybCTShN/enbWwBlfgMd8wowY0UUZ8XVygQsgTE8XfUST+F3nAB8jTGHK7EaFqg8JhGk6rDUJdMR1gDmtgipGFIz1UCSkshxzxARbn0Jd+K/ME6vr65hCrN3tKxIG2+kB7eISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339310; c=relaxed/simple;
	bh=i74ZeOqyTkqtU7Ljf8y+p+suDgtOLlY1FoychxrY+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoQVFGxmVflP2X6vCK78l4DPves4Cxp7X2NXbYF4RswS9gVr/TwqtghOkUgpPGM5EInK97TzeLkX8efcIt3IYOuse97hTEXa8/hMNldOSelmiicjUFoXVLs8kvEddmziNbA4fc7IxedC5+WiuYO6T/gV+lu4BPPtAUDblXbl2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=NCcgICdP; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QiQITLzxlpsGuZLQWzSojS+g5IEdi3WB/iOZRMZGywE=; b=NCcgICdPjUlCaVK6o1wZpEtJuB
	2GQuxfFJAMPXGr+XIj49PH/b7OC2Io41eIzwwuU35incBwOCteD71NkCHUMyv64FznAo3Ey8HTxhn
	ceRevUHwsdrRWoH5oKjPfkSuLo5uuAoeAoLDG+KvYfTHTsjyJX3FLseupnaE4EXHL6INJsC+CmmF8
	fJdZZuB6vM/rqD7UEHW+zmPVs7ZIK83qMI3SbWMfukB/zaowhgdl4oAmpkS7eGggsPv0cd6J0WF1P
	ibIItda0GBRt+VSZxNqGDN1yWrUgRXyOsdBZIjo0TF83Ej3ccUjIQQus5o1t3KJENf+9eR1nfSyvG
	ShP1rJOA==;
Received: from [89.212.21.243] (port=57844 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tN6sc-0053uC-2X;
	Mon, 16 Dec 2024 09:55:06 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v7 2/3] drm/bridge: ti-sn65dsi83: Add ti,lvds-vod-swing optional properties
Date: Mon, 16 Dec 2024 09:54:09 +0100
Message-Id: <20241216085410.1968634-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216085410.1968634-1-andrej.picej@norik.com>
References: <20241216085410.1968634-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add a optional properties to change LVDS output voltage. This should not
be static as this depends mainly on the connected display voltage
requirement. We have three properties:
- "ti,lvds-termination-ohms", which sets near end termination,
- "ti,lvds-vod-swing-data-microvolt" and
- "ti,lvds-vod-swing-clock-microvolt" which both set LVDS differential
output voltage for data and clock lanes. They are defined as an array
with min and max values. The appropriate bitfield will be set if
selected constraints can be met.

If "ti,lvds-termination-ohms" is not defined the default of 200 Ohm near
end termination will be used. Selecting only one:
"ti,lvds-vod-swing-data-microvolt" or
"ti,lvds-vod-swing-clock-microvolt" can be done, but the output voltage
constraint for only data/clock lanes will be met. Setting both is
recommended.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v7:
- decrement refcount of the endpoint in all error cases,
- add spaces to improve the readability of the long if statement conditions in
sn65dsi83_select_lvds_vod_swing.
Changes in v6:
- rework termination resistor logic, default is now set by resistor value, not
reg value,
- move setting lvds_vod_swing_conf to default value of 0x1 inside if statement
which checks if both properties are not set
Changes in v5:
- specify default values in sn65dsi83_parse_lvds_endpoint,
- move sn65dsi83_parse_lvds_endpoint for channel B up, outside if,
Changes in v4:
- fix typo in commit message bitfiled -> bitfield
- use arrays (lvds_vod_swing_conf and lvds_term_conf) in private data, instead
of separate variables for channel A/B
- add more checks on return value of "of_property_read_u32_array"
Changes in v3:
- use microvolts for default array values 1000 mV -> 1000000 uV.
Changes in v2:
- use datasheet tables to get the proper configuration
- since major change was done change the authorship to myself
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 145 +++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f996..61019eec6e25 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -132,6 +132,16 @@
 #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
 #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
 
+enum sn65dsi83_channel {
+	CHANNEL_A,
+	CHANNEL_B
+};
+
+enum sn65dsi83_lvds_term {
+	OHM_100,
+	OHM_200
+};
+
 enum sn65dsi83_model {
 	MODEL_SN65DSI83,
 	MODEL_SN65DSI84,
@@ -147,6 +157,8 @@ struct sn65dsi83 {
 	struct regulator		*vcc;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	int				lvds_vod_swing_conf[2];
+	int				lvds_term_conf[2];
 };
 
 static const struct regmap_range sn65dsi83_readable_ranges[] = {
@@ -237,6 +249,36 @@ static const struct regmap_config sn65dsi83_regmap_config = {
 	.max_register = REG_IRQ_STAT,
 };
 
+static const int lvds_vod_swing_data_table[2][4][2] = {
+	{	/* 100 Ohm */
+		{ 180000, 313000 },
+		{ 215000, 372000 },
+		{ 250000, 430000 },
+		{ 290000, 488000 },
+	},
+	{	/* 200 Ohm */
+		{ 150000, 261000 },
+		{ 200000, 346000 },
+		{ 250000, 428000 },
+		{ 300000, 511000 },
+	},
+};
+
+static const int lvds_vod_swing_clock_table[2][4][2] = {
+	{	/* 100 Ohm */
+		{ 140000, 244000 },
+		{ 168000, 290000 },
+		{ 195000, 335000 },
+		{ 226000, 381000 },
+	},
+	{	/* 200 Ohm */
+		{ 117000, 204000 },
+		{ 156000, 270000 },
+		{ 195000, 334000 },
+		{ 234000, 399000 },
+	},
+};
+
 static struct sn65dsi83 *bridge_to_sn65dsi83(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct sn65dsi83, bridge);
@@ -435,12 +477,16 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		val |= REG_LVDS_FMT_LVDS_LINK_CFG;
 
 	regmap_write(ctx->regmap, REG_LVDS_FMT, val);
-	regmap_write(ctx->regmap, REG_LVDS_VCOM, 0x05);
+	regmap_write(ctx->regmap, REG_LVDS_VCOM,
+			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_A]) |
+			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_B]));
 	regmap_write(ctx->regmap, REG_LVDS_LANE,
 		     (ctx->lvds_dual_link_even_odd_swap ?
 		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
-		     REG_LVDS_LANE_CHA_LVDS_TERM |
-		     REG_LVDS_LANE_CHB_LVDS_TERM);
+		     (ctx->lvds_term_conf[CHANNEL_A] ?
+			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
+		     (ctx->lvds_term_conf[CHANNEL_B] ?
+			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
 	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
 
 	le16val = cpu_to_le16(mode->hdisplay);
@@ -576,10 +622,103 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
 	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
 };
 
+static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
+	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)
+{
+	int i;
+
+	for (i = 0; i <= 3; i++) {
+		if (lvds_vod_swing_data_table[lvds_term][i][0]  >= lvds_vod_swing_data[0] &&
+		    lvds_vod_swing_data_table[lvds_term][i][1]  <= lvds_vod_swing_data[1] &&
+		    lvds_vod_swing_clock_table[lvds_term][i][0] >= lvds_vod_swing_clk[0] &&
+		    lvds_vod_swing_clock_table[lvds_term][i][1] <= lvds_vod_swing_clk[1])
+			return i;
+	}
+
+	dev_err(dev, "failed to find appropriate LVDS_VOD_SWING configuration\n");
+	return -EINVAL;
+}
+
+static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
+{
+	struct device *dev = ctx->dev;
+	struct device_node *endpoint;
+	int endpoint_reg;
+	/* Set so the property can be freely selected if not defined */
+	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
+	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
+	/* Set default near end terminataion to 200 Ohm */
+	u32 lvds_term = 200;
+	int lvds_vod_swing_conf;
+	int ret = 0;
+	int ret_data;
+	int ret_clock;
+
+	if (channel == CHANNEL_A)
+		endpoint_reg = 2;
+	else
+		endpoint_reg = 3;
+
+	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
+
+	of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term);
+	if (lvds_term == 100)
+		ctx->lvds_term_conf[channel] = OHM_100;
+	else if (lvds_term == 200)
+		ctx->lvds_term_conf[channel] = OHM_200;
+	else {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
+					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
+	if (ret_data != 0 && ret_data != -EINVAL) {
+		ret = ret_data;
+		goto exit;
+	}
+
+	ret_clock = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-clock-microvolt",
+					lvds_vod_swing_clk, ARRAY_SIZE(lvds_vod_swing_clk));
+	if (ret_clock != 0 && ret_clock != -EINVAL) {
+		ret = ret_clock;
+		goto exit;
+	}
+
+	/* Use default value if both properties are NOT defined. */
+	if (ret_data == -EINVAL && ret_clock == -EINVAL)
+		lvds_vod_swing_conf = 0x1;
+
+	/* Use lookup table if any of the two properties is defined. */
+	if (!ret_data || !ret_clock) {
+		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev, lvds_vod_swing_data,
+						lvds_vod_swing_clk, ctx->lvds_term_conf[channel]);
+		if (lvds_vod_swing_conf < 0) {
+			ret = lvds_vod_swing_conf;
+			goto exit;
+		}
+	}
+
+	ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
+	ret = 0;
+exit:
+	of_node_put(endpoint);
+	return ret;
+}
+
 static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
+	int ret;
+
+	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
+	if (ret < 0)
+		return ret;
+
+	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_B);
+	if (ret < 0)
+		return ret;
 
 	ctx->lvds_dual_link = false;
 	ctx->lvds_dual_link_even_odd_swap = false;
-- 
2.34.1


