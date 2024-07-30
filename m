Return-Path: <linux-kernel+bounces-267538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BC94129B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E26B23B37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B91A2C0F;
	Tue, 30 Jul 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y2GQymQN"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1B1A0704
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343845; cv=none; b=MeuPqs4voJJFQwEdWTdedTIUzXFaL9z3i6WUzOqAoqhyOo1x5zQCjJfGeidLEMabcdzWImydEGfBZJPDdd07XXBUWCcsnpjKqxU35/mZWLdPTXfs1GCV3e9IdPeme6Isd+rNEimSvyBjzKijm/BtkFkFuUDw/DwhxM83ClAfW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343845; c=relaxed/simple;
	bh=dFSFPzrPi0cLz73B27dR1OqohQ3ddqXnD18oVNyswMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXbjhTaHMHl/8WzByLm+b0sJOcipjOPoxsHPixB1BkCNDrF+8DR0kohvL+BNMeWyXq0hsp41w7L44S486ra7x39zjLmO+70+6U8tAqxi2kxB7YruZfAHFWwHjM0pEaE9LXx7rKJ5k13gmrEEf9zi2oxCbnyh3cDfhxlBL161FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y2GQymQN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367990aaef3so2334332f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343841; x=1722948641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mASIbGHgicNkpjEZJDVQTMm2DP0XPbvH1Sd0GVs1rHs=;
        b=y2GQymQNahHpqO3OwIYXINQwFajNhqN/MLPqXYqbDOkKEp2hCNdUoKAunz+jKSsIxY
         7ekNKcx4auLQtBrZd16IAuN5EJ/VWtCWL7/Cxte9kwgH1aeuh4M9sL0nY7CbAmsDik1w
         aRh6jwE4vj8YSPQRSQdn3WzxBTUPjV2obfJQwaZZ0Lq3MugdhSSg5VzdsHaY3ISbSBO9
         Jtk6KFD9Z4OpQ4CaP7H/jnZ7qW05eADUhqXWFa+0p0POWjKib1pRgnEThSSCD3NEPVwp
         FEUvetnquv0Q4vdXsBdlHTQwxM08dyBXMpAifsSHJcM1r8VZm90NycHBTL169abx3BUH
         /wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343841; x=1722948641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mASIbGHgicNkpjEZJDVQTMm2DP0XPbvH1Sd0GVs1rHs=;
        b=cSZPDhsxbT6BHPdeWj2c5YMo8W4c68OhGgsamNeEASXxD1Aq7gecxPK0h5anCyXMsP
         dJ/x24ep6l+e3Bo/p7HH2jiMRkXO0srK84PRvgsuepuFONxd09aeZyav7VlAhtDEeVkB
         APssJrumuiEqayoj6Z5fP8PmcQw5eNujk3UzJI4oMakWip4h7Sfp4EYsx/kILzPH6TMi
         NFJ7dfTRRDcT7A5oOMlsJzenB+BIxEHpWKQDYKBNTw1jzzzI8Az7GZp5jutfqBKOiQQG
         0E08E+cZIiE/k8lf7fW7KrO61R335aq5FoeyCXe+hOUJhuNf6BySQ1FuA33zemZQ4i1p
         cMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWRxnxlxEQryyfHCGvXuuDssd7swAeY7VwuRNDOXVrAKrVoO9njucTX7efDCGpJdJyn9H//c0hQjF9M7Ht92qe3uSqbIOa80V+WI1pb
X-Gm-Message-State: AOJu0YzBPt3z45eitcPzvqpAWF8ukBABUkfgJkCxwUAL4m1Ge7T+AH67
	lwX3NT721PptGC6d0GUxwH8TOjGaj1uVIc0d0xsCf2rn78y68tALe7Lpmtz37LE=
X-Google-Smtp-Source: AGHT+IGgAowgwPOjeaL86WpoU9wRwRtqxrk1rp/DYm6nll47JN9ogSrFK3ue1xuiQZz1zSdyf7rnBg==
X-Received: by 2002:a05:6000:11cb:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36b5cee9bfdmr7815247f8f.7.1722343840573;
        Tue, 30 Jul 2024 05:50:40 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] drm/meson: dw-hdmi: use matched data
Date: Tue, 30 Jul 2024 14:50:17 +0200
Message-ID: <20240730125023.710237-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Using several string comparisons with if/else if/else clauses
is fairly inefficient and does not scale well.

Use matched data to tweak the driver depending on the matched
SoC instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 209 +++++++++++++++++---------
 1 file changed, 139 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 7c39e5c99043..ef059c5ef520 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -125,8 +125,17 @@
 #define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
 #define HHI_HDMI_PHY_CNTL5	0x3b4 /* 0xed */
 
+struct meson_dw_hdmi_speed {
+	const struct reg_sequence *regs;
+	unsigned int reg_num;
+	unsigned int limit;
+};
+
 struct meson_dw_hdmi_data {
 	int (*reg_init)(struct device *dev);
+	const struct meson_dw_hdmi_speed *speeds;
+	unsigned int speed_num;
+	bool use_drm_infoframe;
 	u32 cntl0_init;
 	u32 cntl1_init;
 };
@@ -185,78 +194,33 @@ struct meson_dw_hdmi {
 	struct regmap *top;
 };
 
-static inline int dw_hdmi_is_compatible(struct meson_dw_hdmi *dw_hdmi,
-					const char *compat)
-{
-	return of_device_is_compatible(dw_hdmi->dev->of_node, compat);
-}
-
-/* Bridge */
-
 /* Setup PHY bandwidth modes */
-static void meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
+static int meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
 				      const struct drm_display_mode *mode,
 				      bool mode_is_420)
 {
 	struct meson_drm *priv = dw_hdmi->priv;
 	unsigned int pixel_clock = mode->clock;
+	int i;
 
 	/* For 420, pixel clock is half unlike venc clock */
-	if (mode_is_420) pixel_clock /= 2;
-
-	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi")) {
-		if (pixel_clock >= 371250) {
-			/* 5.94Gbps, 3.7125Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x333d3282);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2136315b);
-		} else if (pixel_clock >= 297000) {
-			/* 2.97Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33303382);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2036315b);
-		} else if (pixel_clock >= 148500) {
-			/* 1.485Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33303362);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2016315b);
-		} else {
-			/* 742.5Mbps, and below */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33604142);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x0016315b);
-		}
-	} else if (dw_hdmi_is_compatible(dw_hdmi,
-					 "amlogic,meson-gxbb-dw-hdmi")) {
-		if (pixel_clock >= 371250) {
-			/* 5.94Gbps, 3.7125Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33353245);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2100115b);
-		} else if (pixel_clock >= 297000) {
-			/* 2.97Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33634283);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0xb000115b);
-		} else {
-			/* 1.485Gbps, and below */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33632122);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2000115b);
-		}
-	} else if (dw_hdmi_is_compatible(dw_hdmi,
-					 "amlogic,meson-g12a-dw-hdmi")) {
-		if (pixel_clock >= 371250) {
-			/* 5.94Gbps, 3.7125Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x37eb65c4);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x0000080b);
-		} else if (pixel_clock >= 297000) {
-			/* 2.97Gbps */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33eb6262);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x00000003);
-		} else {
-			/* 1.485Gbps, and below */
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33eb4242);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
-			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x00000003);
-		}
+	if (mode_is_420)
+		pixel_clock /= 2;
+
+	for (i = 0; i < dw_hdmi->data->speed_num; i++) {
+		if (pixel_clock >= dw_hdmi->data->speeds[i].limit)
+			break;
 	}
+
+	/* No match found - Last entry should have a 0 limit */
+	if (WARN_ON(i == dw_hdmi->data->speed_num))
+		return -EINVAL;
+
+	regmap_multi_reg_write(priv->hhi,
+			       dw_hdmi->data->speeds[i].regs,
+			       dw_hdmi->data->speeds[i].reg_num);
+
+	return 0;
 }
 
 static inline void meson_dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
@@ -543,22 +507,133 @@ static int meson_dw_init_regmap_g12(struct device *dev)
 	return 0;
 }
 
+static const struct reg_sequence gxbb_3g7_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33353245 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2100115b },
+};
+
+static const struct reg_sequence gxbb_3g_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33634283 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0xb000115b },
+};
+
+static const struct reg_sequence gxbb_def_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33632122 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2000115b },
+};
+
+static const struct meson_dw_hdmi_speed gxbb_speeds[] = {
+	{
+		.limit = 371250,
+		.regs = gxbb_3g7_regs,
+		.reg_num = ARRAY_SIZE(gxbb_3g7_regs)
+	}, {
+		.limit = 297000,
+		.regs = gxbb_3g_regs,
+		.reg_num = ARRAY_SIZE(gxbb_3g_regs)
+	}, {
+		.regs = gxbb_def_regs,
+		.reg_num = ARRAY_SIZE(gxbb_def_regs)
+	}
+};
+
 static const struct meson_dw_hdmi_data meson_dw_hdmi_gxbb_data = {
 	.reg_init = meson_dw_init_regmap_gx,
 	.cntl0_init = 0x0,
 	.cntl1_init = PHY_CNTL1_INIT | PHY_INVERT,
+	.use_drm_infoframe = false,
+	.speeds = gxbb_speeds,
+	.speed_num = ARRAY_SIZE(gxbb_speeds),
+};
+
+static const struct reg_sequence gxl_3g7_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x333d3282 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2136315b },
+};
+
+static const struct reg_sequence gxl_3g_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33303382 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2036315b },
+};
+
+static const struct reg_sequence gxl_def_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33303362 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2016315b },
+};
+
+static const struct reg_sequence gxl_270m_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33604142 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x0016315b },
+};
+
+static const struct meson_dw_hdmi_speed gxl_speeds[] = {
+	{
+		.limit = 371250,
+		.regs = gxl_3g7_regs,
+		.reg_num = ARRAY_SIZE(gxl_3g7_regs)
+	}, {
+		.limit = 297000,
+		.regs = gxl_3g_regs,
+		.reg_num = ARRAY_SIZE(gxl_3g_regs)
+	}, {
+		.limit = 148500,
+		.regs = gxl_def_regs,
+		.reg_num = ARRAY_SIZE(gxl_def_regs)
+	}, {
+		.regs = gxl_270m_regs,
+		.reg_num = ARRAY_SIZE(gxl_270m_regs)
+	}
 };
 
 static const struct meson_dw_hdmi_data meson_dw_hdmi_gxl_data = {
 	.reg_init = meson_dw_init_regmap_gx,
 	.cntl0_init = 0x0,
 	.cntl1_init = PHY_CNTL1_INIT,
+	.use_drm_infoframe = true,
+	.speeds = gxl_speeds,
+	.speed_num = ARRAY_SIZE(gxl_speeds),
+};
+
+static const struct reg_sequence g12a_3g7_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x37eb65c4 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2ab0ff3b },
+	{ .reg = HHI_HDMI_PHY_CNTL5, .def = 0x0000080b },
+};
+
+static const struct reg_sequence g12a_3g_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33eb6262 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2ab0ff3b },
+	{ .reg = HHI_HDMI_PHY_CNTL5, .def = 0x00000003 },
+};
+
+static const struct reg_sequence g12a_def_regs[] = {
+	{ .reg = HHI_HDMI_PHY_CNTL0, .def = 0x33eb4242 },
+	{ .reg = HHI_HDMI_PHY_CNTL3, .def = 0x2ab0ff3b },
+	{ .reg = HHI_HDMI_PHY_CNTL5, .def = 0x00000003 },
+};
+
+static const struct meson_dw_hdmi_speed g12a_speeds[] = {
+	{
+		.limit = 371250,
+		.regs = g12a_3g7_regs,
+		.reg_num = ARRAY_SIZE(g12a_3g7_regs)
+	}, {
+		.limit = 297000,
+		.regs = g12a_3g_regs,
+		.reg_num = ARRAY_SIZE(g12a_3g_regs)
+	}, {
+		.regs = g12a_def_regs,
+		.reg_num = ARRAY_SIZE(g12a_def_regs)
+	}
 };
 
 static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
 	.reg_init = meson_dw_init_regmap_g12,
 	.cntl0_init = 0x000b4242, /* Bandgap */
 	.cntl1_init = PHY_CNTL1_INIT,
+	.use_drm_infoframe = true,
+	.speeds = g12a_speeds,
+	.speed_num = ARRAY_SIZE(g12a_speeds),
 };
 
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
@@ -590,7 +665,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	platform_set_drvdata(pdev, meson_dw_hdmi);
 
 	meson_dw_hdmi->priv = priv;
-	meson_dw_hdmi->dev = dev;
 	meson_dw_hdmi->data = match;
 	dw_plat_data = &meson_dw_hdmi->dw_plat_data;
 
@@ -650,7 +724,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	meson_dw_hdmi_init(meson_dw_hdmi);
 
 	/* Bridge / Connector */
-
 	dw_plat_data->priv_data = meson_dw_hdmi;
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
@@ -659,11 +732,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->ycbcr_420_allowed = true;
 	dw_plat_data->disable_cec = true;
 	dw_plat_data->output_port = 1;
-
-	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
-	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
-		dw_plat_data->use_drm_infoframe = true;
+	dw_plat_data->use_drm_infoframe = meson_dw_hdmi->data->use_drm_infoframe;
 
 	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
 	if (IS_ERR(meson_dw_hdmi->hdmi))
-- 
2.43.0


