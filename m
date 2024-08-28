Return-Path: <linux-kernel+bounces-305212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1A962B17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633E11C23A51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA219FA94;
	Wed, 28 Aug 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+nsf/6z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB501A08A1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857471; cv=none; b=GX+Y3SdobakQzgMszPISJNKPxx40aTZwcSdEMLxeOuv7dwIJ9Zutwlz1V/k94Clfq+QwS6wLqMaEcyiBFriX0cVNkgjwg4MvymzBD3GXHbGsDhuDJ+KDTSZDwzZ98x4MI7JoqpT6fI66LL9f5F891ElycZfnz7ENua4GRjfMMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857471; c=relaxed/simple;
	bh=2Njn5bNaQDufIW+OX+YZ1RHg5HJaiNzkyAOoSbvzm8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWmaavoyZLJsxiPb9D89WpFMIsZd2n+t3tfxFAq7y73TJ1Ap6FN0XdTteG8noVVBBidZgDWeh9BhnlW0HfwTaz+ORXVD0FmExADwDFFa4B0Uf0Jpl5XWgPqxd1GyxuZCc7AL9VnwGqQ2skZjIpN+alCor2r2/Nev6dxv96B8kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+nsf/6z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso59199105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724857467; x=1725462267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovFCnXvXr8jSZA7XeyMiJX7sAb3C0j4/FiJJH8aoN9E=;
        b=m+nsf/6ziNLym4Lhy8zVodk1C0kid1tQW+aBzuOCQMzZTMlcaxI1NH4O3A6/RhSOCV
         4SjZfRWZpC8RRmVc+01ZlHeYKsnrv6Z4ES12VTxh5XMbCB+8EB01lCJKA39c334MJKeQ
         wML7YXSJz2kf0XiNx6fvCxppayr9RcY9og4Z3PyMVPBwEf4ARueO3N/i5n/9NWB4pRzg
         iiUgRblaJnfLdIKpeCc3TF640w1GgZtRxDxzpMYdcd+AlsBi9p/97uDL/ayyke8CNmvv
         gnJ0xprwgitvLKTEUHTgnK/UXGFH5dNXbcI/Q8JOhNgCLkTIUbs99xp+8m4zZFnNvk1V
         cmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857467; x=1725462267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovFCnXvXr8jSZA7XeyMiJX7sAb3C0j4/FiJJH8aoN9E=;
        b=rKoYokzAhjMUfbJk3ZUL3jtqUgcHQjJcoeQHElbKoQFf9nc8Pwq0cQaiSKB0lP8waq
         oMBRwLOUKdngJdEybQlk30bEaA28OZ9tii9FmEHQTurZ/dnSDB/IFk53lHe0h+vdmbR8
         CJxuMNiVxG1ba7zp9D0AsUt7dL/iEYyHtklAoj8408w5I1ad6Nsdi9rgaubZM1Y7MXYo
         fXfPNoV6zuAb1xFkSg1iCor0z11TDbm2ogY269zEF24zAuJalsfZxWLjh13MfyhT4lCX
         dST4brK9wI8cPZn46gobja0khlbxzaw9qS8oyVwxLqX7qhf+kAJVKsBI/dVTG4d5pmqd
         DnqA==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ1xBMOWpa0+aey8og+EhB35rOivVsrpjGb/QDXSUBfRgl6PNsEGUHjbtzPmY68GNTkppMcsl8EIDvlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTgUIE2icjnYCp20L4CCTNysZZiLyc/Kc28tdTlCEONCd1RD5
	rkMhAHjrCMTebYW9YG72kzc/rpL6qNe8Gl3/kgi6g5GPfUr+Ll9iofCioOh0lOU=
X-Google-Smtp-Source: AGHT+IE6zqtBhAAQfpcPokgm5Mts8rJbMaxLDUR63S0+1NLH/qHkR7S6ZQbrGMKZ9f6ycKFE6rSf9w==
X-Received: by 2002:a05:600c:1c18:b0:426:8884:2c54 with SMTP id 5b1f17b1804b1-42bb01fb929mr35665e9.35.1724857466545;
        Wed, 28 Aug 2024 08:04:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63acd66sm24079315e9.23.2024.08.28.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:04:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 28 Aug 2024 17:04:20 +0200
Subject: [PATCH v3 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-topic-sdm450-upstream-tbx605f-panel-v3-2-b792f93e1d6b@linaro.org>
References: <20240828-topic-sdm450-upstream-tbx605f-panel-v3-0-b792f93e1d6b@linaro.org>
In-Reply-To: <20240828-topic-sdm450-upstream-tbx605f-panel-v3-0-b792f93e1d6b@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Doug Anderson <dianders@chromium.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9332;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2Njn5bNaQDufIW+OX+YZ1RHg5HJaiNzkyAOoSbvzm8A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmzzx2xzIgzzTwbmLl1TAR13hy/J92QkAtloCMVy+f
 DdrPbSSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZs88dgAKCRB33NvayMhJ0SX4D/
 48U+QXmG//5nMaaLesF5mp91A/N/oSn7DBF39+qK/eNzZgM01q7hClqJfJM1mNZAxYQpyZBOc2mzP9
 6DN+TpY9rqiohpjDnNKdkly+N7cl//qMRZfK8d25fRSFjIZAq12BjAUJXbyfUFW39eg2rewYyYZcX8
 yRGQNYvDFTS2D1+x1B+cu269ExM0CGMFDoR8h8MkHIluSgoOrbHxDOWDVKeAdMV+dA2mBD9Ldxdvbq
 3PjW8hG/6YaFAAbQzA1XEkfP562YNc1PWBalN3NyGs69N77fqBpzu4Eofo0/QmaBUIdExy2QR21G/l
 3hoN3G2SnDFTdN8ibgFV0M/y6CQyRJnkEfqhznMPUZYU8xYra5pl0RW5SAYWHYzxWYKtcjpt/wpj4i
 4kGoo2/qTb4mUWdoCR2rKu6srRvOkLHXwnfdx91tNpvdfpAUZqHRuUeKi1qUwopi++AViFt/EjiUy/
 jmat3F3QB+inXbOfQitOkTSHgtt2kJ2F+PJWTL0T9wduBxtqyn7GitlWD7U1O/LNfdA9l2/UHnK5aj
 LRGoniKjMxp9dYcNDl3UzjuDT1uqiMsfLrTAaITF1DbJa4EFLpquwVVmKyZSOmhM2mMbSZaIWg6+LF
 rktnXfBMFKGYlciQnbWBINV7QuJK6PXHp45AvSwumDs0wxDGFqHINaw6Fspg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add support for the 1200x1920 BOE TV101WUM-LL2 DSI Display Panel found
in the Lenovo Smart Tab M10 tablet. The controller is unknown.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig                  |   9 +
 drivers/gpu/drm/panel/Makefile                 |   1 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c | 241 +++++++++++++++++++++++++
 3 files changed, 251 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 5d83ddc06ece..d3a9a9fafe4e 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -87,6 +87,15 @@ config DRM_PANEL_BOE_TV101WUM_NL6
 	  Say Y here if you want to support for BOE TV101WUM and AUO KD101N80
 	  45NA WUXGA PANEL DSI Video Mode panel
 
+config DRM_PANEL_BOE_TV101WUM_LL2
+	tristate "BOE TV101WUM LL2 1200x1920 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to support for BOE TV101WUM-LL2
+	  WUXGA PANEL DSI Video Mode panel
+
 config DRM_PANEL_EBBG_FT8719
 	tristate "EBBG FT8719 panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 5581387707c6..987a08702410 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_DRM_PANEL_AUO_A030JTN01) += panel-auo-a030jtn01.o
 obj-$(CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0) += panel-boe-bf060y8m-aj0.o
 obj-$(CONFIG_DRM_PANEL_BOE_HIMAX8279D) += panel-boe-himax8279d.o
 obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
+obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
 obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
 obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
new file mode 100644
index 000000000000..50e4a5341bc6
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+//   Copyright (c) 2013, The Linux Foundation. All rights reserved.
+//   Copyright (c) 2024, Neil Armstrong <neil.armstrong@linaro.org>
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct boe_tv101wum_ll2 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data *supplies;
+};
+
+static const struct regulator_bulk_data boe_tv101wum_ll2_supplies[] = {
+	{ .supply = "vsp" },
+	{ .supply = "vsn" },
+};
+
+static inline struct boe_tv101wum_ll2 *to_boe_tv101wum_ll2(struct drm_panel *panel)
+{
+	return container_of(panel, struct boe_tv101wum_ll2, panel);
+}
+
+static void boe_tv101wum_ll2_reset(struct boe_tv101wum_ll2 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+
+	msleep(120);
+}
+
+static int boe_tv101wum_ll2_on(struct boe_tv101wum_ll2 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x5a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0xff, 0x81, 0x68, 0x6c, 0x22,
+				     0x6d, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x5a, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x94, 0x2c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x5a, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa2, 0x38);
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x50, 0x5a, 0x0c);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0xfd);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x50, 0x00);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	return dsi_ctx.accum_err;
+}
+
+static void boe_tv101wum_ll2_off(struct boe_tv101wum_ll2 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 70);
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5a);
+
+	mipi_dsi_msleep(&dsi_ctx, 150);
+}
+
+static int boe_tv101wum_ll2_prepare(struct drm_panel *panel)
+{
+	struct boe_tv101wum_ll2 *ctx = to_boe_tv101wum_ll2(panel);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(boe_tv101wum_ll2_supplies),
+				    ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	boe_tv101wum_ll2_reset(ctx);
+
+	ret = boe_tv101wum_ll2_on(ctx);
+	if (ret < 0) {
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(boe_tv101wum_ll2_supplies),
+				       ctx->supplies);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int boe_tv101wum_ll2_unprepare(struct drm_panel *panel)
+{
+	struct boe_tv101wum_ll2 *ctx = to_boe_tv101wum_ll2(panel);
+
+	/* Ignore errors on failure, in any case set gpio and disable regulators */
+	boe_tv101wum_ll2_off(ctx);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(boe_tv101wum_ll2_supplies),
+			       ctx->supplies);
+
+	return 0;
+}
+
+static const struct drm_display_mode boe_tv101wum_ll2_mode = {
+	.clock = (1200 + 27 + 8 + 12) * (1920 + 155 + 8 + 32) * 60 / 1000,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 27,
+	.hsync_end = 1200 + 27 + 8,
+	.htotal = 1200 + 27 + 8 + 12,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 155,
+	.vsync_end = 1920 + 155 + 8,
+	.vtotal = 1920 + 155 + 8 + 32,
+	.width_mm = 136,
+	.height_mm = 217,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int boe_tv101wum_ll2_get_modes(struct drm_panel *panel,
+				      struct drm_connector *connector)
+{
+	/* We do not set display_info.bpc since unset value is bpc=8 by default */
+	return drm_connector_helper_get_modes_fixed(connector, &boe_tv101wum_ll2_mode);
+}
+
+static const struct drm_panel_funcs boe_tv101wum_ll2_panel_funcs = {
+	.prepare = boe_tv101wum_ll2_prepare,
+	.unprepare = boe_tv101wum_ll2_unprepare,
+	.get_modes = boe_tv101wum_ll2_get_modes,
+};
+
+static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct boe_tv101wum_ll2 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = devm_regulator_bulk_get_const(&dsi->dev,
+					ARRAY_SIZE(boe_tv101wum_ll2_supplies),
+					boe_tv101wum_ll2_supplies,
+					&ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_VIDEO_HSE;
+
+	drm_panel_init(&ctx->panel, dev, &boe_tv101wum_ll2_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void boe_tv101wum_ll2_remove(struct mipi_dsi_device *dsi)
+{
+	struct boe_tv101wum_ll2 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id boe_tv101wum_ll2_of_match[] = {
+	{ .compatible = "boe,tv101wum-ll2" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, boe_tv101wum_ll2_of_match);
+
+static struct mipi_dsi_driver boe_tv101wum_ll2_driver = {
+	.probe = boe_tv101wum_ll2_probe,
+	.remove = boe_tv101wum_ll2_remove,
+	.driver = {
+		.name = "panel-boe-tv101wum_ll2",
+		.of_match_table = boe_tv101wum_ll2_of_match,
+	},
+};
+module_mipi_dsi_driver(boe_tv101wum_ll2_driver);
+
+MODULE_DESCRIPTION("DRM driver for BOE TV101WUM-LL2 Panel");
+MODULE_LICENSE("GPL");

-- 
2.34.1


