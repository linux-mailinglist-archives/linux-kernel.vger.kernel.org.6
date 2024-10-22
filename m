Return-Path: <linux-kernel+bounces-377048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D39AB926
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A7282FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC571D0417;
	Tue, 22 Oct 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="LxvPr0FO"
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E21CFEDD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634049; cv=none; b=jYdLN8b5EY1maDEA6TsjaYutxeo+UhmsxLP5+ULx6PO8qrTMLQBEW9WfFn/M3oI+WTVQFBIPAVFhwVBSehZSto0R9ESPGXnUm5kVRSOjnCvF34Xe9qvymZKEwG+CEWF/2b4c6mBsHEL1PC8Eu5+MW1Ny2oiWT/YawEzizAPaylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634049; c=relaxed/simple;
	bh=g++a2B4CheVBx4WzXBzPoWNad5FRHHEhfwrEmacF3wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWzBDoLGJVJau2TqmWRPa1d9daZ9Ipg6k5gThS1DDQIdZ/JrkFobLQjAP3lAxTo65HFJQ/mHWIpzKJMF3mF8ZFa/s/zis68s0zWRaR+lVIuyYcAQJG4fFOFSMiMY3JqDvOZUYCMc93fSdeCdtXMrmJ4arpjVu8ZVIUUkKV+NQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=LxvPr0FO; arc=none smtp.client-ip=77.238.178.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729634045; bh=70QVeRtyDiMg9KxW5Djk0oZQv4ngnf+PlKtHAYt3mCU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LxvPr0FOcJICBO2IeCDVLNMwU8d4Z6SHwfO4CWPwT9g8FmHC8Zj/kKj578KNt2LzLJtGQ/IS/pP8ZU0moGByR9wv7/rq83KZb5tqRwpN699sIkPD07GMGE0PMak6wGYPdWrZ9QYj2ivlf9OqGNOc/QYnQlh8UkVM7PCdhfmvha3RyUpbCloiwbziUaTPOLn+62eOKn4/YfVEYy/1Wd85qmAkXmAfUDf+46Zp68QdFOj1j9Bk8jA8r/a72VZ4JifefsCJVcgUAHJ6pyaSTeLnJS55AZciRnboiC5O6lmOG5x388EEyQsk2sysAVikVGkCvBfSfaOTmcoYtukalpOQww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729634045; bh=IxYM/RT8HeIOxvp2A33FbYbi7vLghRjR/vY6Ns1cMw0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HE0l71184C9IRog4jiMDWcSQpO3Vz5H0M98WIsb1FzxVzyl7ez42+P1qkA/1iqn3ipu2gZbeqGx0IfYkRk7XAMZqOPukDPjCAEHYuCYYLqBjNolKLG+cpTdWsJAmArsuT7bcj/cGsYlv8WhiAF/tStRGEojltzilOK6DSBlAizCnj6bRlgNvnkh9GjG7X6nGsLa7dujhPPH8kk5sU14ehwn050IzG6Sm0ndIrO/cA6kyUA5AEyWTZGbA2NjiLgo/Jl4RYJAxcveX1faamH5MC4KFeKxNakMQu6cP5IA2/l/bA2013dYakbs7IXmrrzQsnRSQfU4eSwTUlLPkyFuj/Q==
X-YMail-OSG: AyD3kEwVM1kZlugt63NC1r5xzUJaJQ89y3TOsrfo9DzTEQNhQZ7qFf75qksr7H2
 sjgwJp88tt708JmYdtTeqGiyXhIAnBtojIO5xEK_PvZ9zEermbW3PmHrqqgeANR1tar_z54.jT3A
 8TliZJeM.KyvpBqAKOFRX7BwYWyr5aaEGyklggVybKe7AlAA_LlONS5DD7kljD.lARDzdOEkmHor
 YFuOcVTCGnaBXtVmjMW15E9O5P48i3UDey5M9.ot60jSCVoWGGuyauHnLAOb_YJ7JZ1mZdvt1Xks
 SpEZwum1KGpUGk9WiVo2QG7BGriQHf7F7n9CC1ecmxWrO6i.c1n4BUhOwY_D5A_FIDXkBcGhIOpO
 ukhrpeFytvImDwIntWflYNtjYyWfAbsYl1wa.nWC.JR_wYNervOkrr7cEz6TwbQn7VIPKGAv6t35
 5U6IsZIa9s2lHzpYk2tm826uZaMXyRre82cYrdkpWDADB1f_YDvgN.wKKCTFnKD3u_4KtAz7hWm3
 eqtjYL1vEZZkmDfg96Y5I36zgoTtuFVLLg6z4JHTOZmPoEafVwHoTOJydVeBI6FH18PQT1lURYU3
 RZsBazCOyzfyId5yma8DJPyh0ImnJlL2sFnfD4qx4073VKwaWGBrda867Me.nKYam0uXfuZXSQjl
 IrJeykL1edzkS7VIiDXeUjFAF.i6gjk_BuS3b6Xj7ujrfsWvOtVrdVALzmsXumnY3UExOnC61c.u
 1hWgANCDKWEM8JXO8RuQdHazXqUW.FHpKmfDcYigOVF3Pf4dhtIL6v13NKcHaNpnEZFaS5Jvh3E_
 HmrFDKfiEkGG.i.8BvUuj5kow891BmM5gQz6_F6LDFIaR8JKAL7ghYoBZOxkUhTRWVBKm.ww5oWO
 OHIWselF_6rpBqxzTEeN95zLm_4C00xV8Yl0_c7Jew2_7ULL5bantguCXmaZl9uvwvR8O0gtiNK0
 J3KA.RcJPAb59Hdf2mrCE_fWK3ivxrNHj5BqdBF7bRXVBjVVELrBjkrr4sdtI7bljpnKjzOOasvR
 xLxrxWI90F5d2Fb5X3XglAI3ykei9H1KnbzjiElf6aOLw0bSC8RNVg_sThF9CcEhlIRZND1s1hvQ
 xos5echbVevLbcxjZvCu06_Y21vcx0avDfSTyqBIcoLDO6PJC9e_lMGqx.Yv5vOA_ozVSTRH6Jz.
 hY6O3eZls0xbeDQz0AmaqbQwFAhpGuPpcs3hXrOrPKFRqIr1iaCXEc_Ki7ZcjBsDKCyulS_xXDH3
 EnrbEN1pmCAO2dpOrpgOX7jIVN.bHfCGe4VafQnZit5T9g_8wt7T8TkFLr1pA1jfR1JOxeJ0P9gF
 oJC5T2m3dqKtqNfH3RbqyrP2OFDiWm4LuRTF9tF9Lvckz_hxDPvY8nGUSdd.6PcuSuaVnpC3uUBF
 u83pesJeMPU37aiy23tBPpQXcPGuXprZ68xSAmrUojqa_jwqOoaZv.9X5ZmKnjafSEgFZjeaVTUi
 5WJON1NQCppt5iVFns.MbT4IZX5DlDBpBQKb9fwXbHlCrapGytH2AizHqz6IWUFNN2NUCyoxywPC
 ghfLfLDzj25aMX2jZ2PmUiWago_HZkqalPkVnhLTqJRlNU_dZXptdTCwGXDrOrpPUrD1Q_6e9CbJ
 16pPOeZI4DwUiKwTJg2sEpCu_tf.H0dC4tc.PAhnwmZ_P3Gc9qFYBCBzJ4oF1GOCbBV2NsEh0kwq
 4_qnKtKGaGO2yJUe47JrpJVD0WmK2RJ9lqLv7IQhiL2qeV7d5ZjIwuXGhOili8GCRSiqkvvccTZH
 3XXAqPUE3zt18zKotbbQ94ONiCHU5y5uf4lZ_ZB_q1anbMLahMZhFSCgPMKB.wxmka4r12pZcRtC
 Ecb44JeBapoWqM.Thz4mpDluoEJXbq4U9NALuYexWCdQ5arcUX9p47vE.8gx6OJezzs7na5qgHc0
 jxj_Cw0lB.b9Du4voT2Dy6E29mTC.k2e02lp4caYn0ZsdQV2DdUCy71vflrrd1DxXmrpLtBAxCok
 VHj1Pe8o6NjNeCe0V3DieLJgEv8o.OHeCyX.UHqJdNZ6FXnsqY7XlrV2_UzE5l0JFiZkqEOWq.gO
 wj9UuOmOSo9slv2RznGMbjTaFNvDvAZVqy1hEsgxJ1HOuVFIHgoVaWZ1lO7vau20JjosgZHQFSjp
 E4eA0FnWsDlgLKrAd40rL8Qb1DH3dSrUXP_OkE9XU4gjuYNTJ3kFbpjbzKSKfLIDZ_gteivwvfie
 yTis_nnbaV_jZvNd1PQFG_4dbvgxGj1udm5MgKZuaNdFqUjuC2SqEz0RScImWN1guop9qwYjCCHq
 9ayF84bDUzPcMaEWUyObH2UHPLOjoQ_bJDs4Ty7u.4TAMNymGJA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 35b9d1d3-400a-4fc6-b194-8a75753c9daf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 22 Oct 2024 21:54:05 +0000
Received: by hermes--production-ir2-c694d79d9-qjs6q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 00a5d0a4af66107c7c1614b6d685cac8;
          Tue, 22 Oct 2024 21:33:46 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 3/5] drm/panel: samsung-s6e88a0-ams427ap24: Add initial driver
Date: Tue, 22 Oct 2024 23:33:37 +0200
Message-Id: <3a7d3e17e37819fa0a198a37d0c2f54de7b93971.1729630039.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1729630039.git.jahau@rocketmail.com>
References: <cover.1729630039.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This initial part of the panel driver was mostly generated by the
"linux-mdss-dsi-panel-driver-generator" tool [1], reading downstream
Android kernel file "dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi" [2].

On top of the generic output of the tool, there were a couple of changes
applied:
- Added mipi_dsi_dcs_set_display_on() to function s6e88a0_ams427ap24_on(),
  otherwise the display does not show up.
- In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off()
  changed DSI commands to multi context and used "accum_err" returns.
- In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off() replaced
  msleep() by mipi_dsi_msleep().
- The function s6e88a0_ams427ap24_get_modes() was changed to make use of
  drm_connector_helper_get_modes_fixed(). This also required to include
  drm/drm_probe_helper.h.
- In function s6e88a0_ams427ap24_probe() registring the regulators was changed
  to devm_regulator_bulk_get_const(). This required to change supplies in struct
  s6e88a0_ams427ap24 to a pointer.
- Removed bool "prepared" from struct s6e88a0_ams427ap24 and instead used
  framework-provided "panel->prepared" in functions s6e88a0_ams427ap24_prepare()
  and s6e88a0_ams427ap24_unprepare().

[1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
[2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
Coulnd't read out RAW EDID, /sys/class/drm/card0-DSI-1/edid is empty.

Changes in v2:
 - Removed bool "prepared" from struct s6e88a0_ams427ap24 and instead used
   framework-provided "panel->prepared" in functions s6e88a0_ams427ap24_prepare()
   and s6e88a0_ams427ap24_unprepare(). Mentioned this in the commit message.
---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-samsung-s6e88a0-ams427ap24.c  | 260 ++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index bce4cb64184a..f8adc38447fb 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -632,6 +632,15 @@ config DRM_PANEL_SAMSUNG_AMS639RQ08
 	  Say Y or M here if you want to enable support for the
 	  Samsung AMS639RQ08 FHD Plus (2340x1080@60Hz) CMD mode panel.
 
+config DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24
+	tristate "Samsung AMS427AP24 panel with S6E88A0 controller"
+	depends on GPIOLIB && OF && REGULATOR
+	depends on DRM_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Samsung AMS427AP24 panel
+	  with S6E88A0 controller (found in Samsung Galaxy S4 Mini Value Edition
+	  GT-I9195I). To compile this driver as a module, choose M here.
+
 config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
 	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 4db02c2411ae..7dcf72646cac 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI) += panel-samsung-s6e63m0-spi.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI) += panel-samsung-s6e63m0-dsi.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24) += panel-samsung-s6e88a0-ams427ap24.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01) += panel-samsung-s6e88a0-ams452ef01.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_SOFEF00) += panel-samsung-sofef00.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
new file mode 100644
index 000000000000..0ab2768e0e2b
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung AMS427AP24 panel with S6E88A0 controller
+ * Copyright (c) 2024 Jakob Hauser <jahau@rocketmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct s6e88a0_ams427ap24 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+const struct regulator_bulk_data s6e88a0_ams427ap24_supplies[] = {
+	{ .supply = "vdd3" },
+	{ .supply = "vci" },
+};
+
+static inline
+struct s6e88a0_ams427ap24 *to_s6e88a0_ams427ap24(struct drm_panel *panel)
+{
+	return container_of(panel, struct s6e88a0_ams427ap24, panel);
+}
+
+static void s6e88a0_ams427ap24_reset(struct s6e88a0_ams427ap24 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(18000, 19000);
+}
+
+static int s6e88a0_ams427ap24_on(struct s6e88a0_ams427ap24 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfd, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfd, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x30);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcc, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf2, 0x03, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca,
+				     0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x80,
+				     0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2,
+				     0x40, 0x08, 0x20, 0x00, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0x28, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf7, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0xa5, 0xa5);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
+}
+
+static int s6e88a0_ams427ap24_off(struct s6e88a0_ams427ap24 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static int s6e88a0_ams427ap24_prepare(struct drm_panel *panel)
+{
+	struct s6e88a0_ams427ap24 *ctx = to_s6e88a0_ams427ap24(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (panel->prepared)
+		return 0;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(s6e88a0_ams427ap24_supplies),
+				    ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	s6e88a0_ams427ap24_reset(ctx);
+
+	ret = s6e88a0_ams427ap24_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(s6e88a0_ams427ap24_supplies),
+				       ctx->supplies);
+		return ret;
+	}
+
+	panel->prepared = true;
+	return 0;
+}
+
+static int s6e88a0_ams427ap24_unprepare(struct drm_panel *panel)
+{
+	struct s6e88a0_ams427ap24 *ctx = to_s6e88a0_ams427ap24(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (!panel->prepared)
+		return 0;
+
+	ret = s6e88a0_ams427ap24_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(s6e88a0_ams427ap24_supplies),
+			       ctx->supplies);
+
+	panel->prepared = false;
+	return 0;
+}
+
+static const struct drm_display_mode s6e88a0_ams427ap24_mode = {
+	.clock = (540 + 94 + 4 + 18) * (960 + 12 + 1 + 3) * 60 / 1000,
+	.hdisplay = 540,
+	.hsync_start = 540 + 94,
+	.hsync_end = 540 + 94 + 4,
+	.htotal = 540 + 94 + 4 + 18,
+	.vdisplay = 960,
+	.vsync_start = 960 + 12,
+	.vsync_end = 960 + 12 + 1,
+	.vtotal = 960 + 12 + 1 + 3,
+	.width_mm = 55,
+	.height_mm = 95,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int s6e88a0_ams427ap24_get_modes(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &s6e88a0_ams427ap24_mode);
+}
+
+static const struct drm_panel_funcs s6e88a0_ams427ap24_panel_funcs = {
+	.prepare = s6e88a0_ams427ap24_prepare,
+	.unprepare = s6e88a0_ams427ap24_unprepare,
+	.get_modes = s6e88a0_ams427ap24_get_modes,
+};
+
+static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct s6e88a0_ams427ap24 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = devm_regulator_bulk_get_const(dev,
+				      ARRAY_SIZE(s6e88a0_ams427ap24_supplies),
+				      s6e88a0_ams427ap24_supplies,
+				      &ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	drm_panel_init(&ctx->panel, dev, &s6e88a0_ams427ap24_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void s6e88a0_ams427ap24_remove(struct mipi_dsi_device *dsi)
+{
+	struct s6e88a0_ams427ap24 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id s6e88a0_ams427ap24_of_match[] = {
+	{ .compatible = "samsung,s6e88a0-ams427ap24" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, s6e88a0_ams427ap24_of_match);
+
+static struct mipi_dsi_driver s6e88a0_ams427ap24_driver = {
+	.probe = s6e88a0_ams427ap24_probe,
+	.remove = s6e88a0_ams427ap24_remove,
+	.driver = {
+		.name = "panel-s6e88a0-ams427ap24",
+		.of_match_table = s6e88a0_ams427ap24_of_match,
+	},
+};
+module_mipi_dsi_driver(s6e88a0_ams427ap24_driver);
+
+MODULE_AUTHOR("Jakob Hauser <jahau@rocketmail.com>");
+MODULE_DESCRIPTION("Samsung AMS427AP24 panel with S6E88A0 controller");
+MODULE_LICENSE("GPL v2");
-- 
2.39.5


