Return-Path: <linux-kernel+bounces-181211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F78C7907
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBFD1F2172A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58F150997;
	Thu, 16 May 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PhQN27Oh"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79214EC48
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872139; cv=none; b=eBW25FWUX5HXtfLjxoYep4IKt3Ze14NpfnExvM7ZKAsgnazvdPYR0drsYfgYorkesks8X1vsudW6K1AwMbKLfmbmqw9IMJFX5n3ybY/Lln79e2uaSAh9IxTT4s/I8hbwvi0h+kTZK9h06lLi6NbiHaXs3jRfdy6hyj9tIf1p0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872139; c=relaxed/simple;
	bh=2Va0ITxM0suedkhfLIJ7a6V95PomOw82XQ9JMnUFjws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw3cmJcW9nZf4QVVKx1Wva2+p3tgFvOkxiQeRRbzTkC14XvV4eZLevo6hCWpYihJXY0z4Y5gjES6/YQuHNp4GJxvin890koHtyHdk+rM6vjFKJbAnE8zOE0J8F7qRZwiZv86pjFzjpHQ/aajEkGMGUW5IwZhC5pwYrPDwS4XA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PhQN27Oh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso4705365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872135; x=1716476935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL5f80GGi83nhgomz2kgPXZIzOXSZK09LD8gHLnVu8c=;
        b=PhQN27OhGCBho6daqYyVBWZcGjM1J1+bP11BeXMc86+IgsqsDpHEMWwVmtjEBtcNZ7
         Hh9KW+nXAHCBmK9zLZzZR3kUys4pXUgOeNGqH6nFjz/69mgiux/Xw8QHC3iBOQRmDi7w
         3csljkYK8A85Bd8xhR9MOnpcodxMM+BCJeXSEi8sSQ6RjJs48P+Cf3wOsrqwiuqjj2rM
         2sVcI2wsB/k29G/ax/csPG5pjYGza7kU2X0ehX5NPHRgkCWh8e8JkOSJn+OyW/rJPEIl
         3d3dWbIs3m+fkLqmh+IKhRqlGrypnSOAKTPWOVpBDOO7Tv7BoTfHK/ynh2G5n4p61LMQ
         HdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872135; x=1716476935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL5f80GGi83nhgomz2kgPXZIzOXSZK09LD8gHLnVu8c=;
        b=u0EifmMXxNxamT1txaBtYrXCm8P06eEF9OVUfuRFxCCV7rW5RApS4PMk7IaYFgBGFy
         TwRJqUNRFpKe1XcSrF5C1cdmIuB+rK9uzl/nqenERET/zMJqArhlhYGCFraPjG5U92QO
         kagKwletbkZI7jO45y00YqJ1pmPCoZZ0qvTfzS7sxGLOQQwkw+VN46loztFnBjo0Q9K6
         /t2KMqtJYiCZBbvpD1X+BnSbL1IbCny2ISSiWOBOV7ZzsGi4aD/0SBd7Kn3SUH/0oW4+
         F6BxDZ+88H3BChnv0OJMBcTxGNvsfjJsjy+d03bPE4PSKKZSbInMqk3B9jNHh7in4GvI
         fb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUxAGN36dPrNoD6/Gm+bNH1Ff6s4lt9/z7ThPv9rn+D2XtztN9vLg5e7hLn0u9Lk061/YFZ9XE+Bw5i+k/5dWrVfCMwdo2OWO3KDv7X
X-Gm-Message-State: AOJu0YxrS2j90NywgqNuQRKPl2ho5A3Cc4OB9G8H8BVoZlqzdJxnRhzr
	Fu36AkVO/9EVD9fzO+55Hpseyw7TQqt3gVVQNa1iAMOWu1bb2OkHfhPGampG+cyug64Ya3NYJ66
	q
X-Google-Smtp-Source: AGHT+IF30UqBoIXs9icx2iDgiQ7TuYEvX0q0rV/70GCuE7s1xRKQ4Arx1HOxMSeUsJUlVOSEqHZT6Q==
X-Received: by 2002:a05:600c:358f:b0:420:29dd:84d4 with SMTP id 5b1f17b1804b1-42029dd885amr21620795e9.13.1715872135697;
        Thu, 16 May 2024 08:08:55 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 9/9] clk: amlogic: axg-audio: use the auxiliary reset driver
Date: Thu, 16 May 2024 17:08:39 +0200
Message-ID: <20240516150842.705844-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Remove the implementation of the reset driver in axg audio
clock driver and migrate to the one provided by reset framework
on auxiliary bus

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig     |   1 +
 drivers/clk/meson/axg-audio.c | 108 +++-------------------------------
 2 files changed, 9 insertions(+), 100 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 6905aa2f080c..b89e769a6362 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -110,6 +110,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_PHASE
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
+	select COMMON_CLK_MESON_CLK_RST_AUX
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 93e6a6d321be..dc9191a9ab0f 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -15,6 +15,7 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 
+#include "meson-clk-rst-aux.h"
 #include "meson-clkc-utils.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
@@ -1678,84 +1679,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&sm1_earcrx_dmac_clk,
 };
 
-struct axg_audio_reset_data {
-	struct reset_controller_dev rstc;
-	struct regmap *map;
-	unsigned int offset;
-};
-
-static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
-					unsigned long id,
-					unsigned int *reg,
-					unsigned int *bit)
-{
-	unsigned int stride = regmap_get_reg_stride(rst->map);
-
-	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
-	*reg += rst->offset;
-	*bit = id % (stride * BITS_PER_BYTE);
-}
-
-static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
-				unsigned long id, bool assert)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_update_bits(rst->map, offset, BIT(bit),
-			assert ? BIT(bit) : 0);
-
-	return 0;
-}
-
-static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int val, offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_read(rst->map, offset, &val);
-
-	return !!(val & BIT(bit));
-}
-
-static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, true);
-}
-
-static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, false);
-}
-
-static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	int ret;
-
-	ret = axg_audio_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return axg_audio_reset_deassert(rcdev, id);
-}
-
-static const struct reset_control_ops axg_audio_rstc_ops = {
-	.assert = axg_audio_reset_assert,
-	.deassert = axg_audio_reset_deassert,
-	.reset = axg_audio_reset_toggle,
-	.status = axg_audio_reset_status,
-};
-
 static const struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -1766,15 +1689,13 @@ struct audioclk_data {
 	struct clk_regmap *const *regmap_clks;
 	unsigned int regmap_clk_num;
 	struct meson_clk_hw_data hw_clks;
-	unsigned int reset_offset;
-	unsigned int reset_num;
+	const char *rst_drvname;
 };
 
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
-	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	void __iomem *regs;
 	struct clk_hw *hw;
@@ -1832,22 +1753,11 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Stop here if there is no reset */
-	if (!data->reset_num)
-		return 0;
-
-	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
-	if (!rst)
-		return -ENOMEM;
-
-	rst->map = map;
-	rst->offset = data->reset_offset;
-	rst->rstc.nr_resets = data->reset_num;
-	rst->rstc.ops = &axg_audio_rstc_ops;
-	rst->rstc.of_node = dev->of_node;
-	rst->rstc.owner = THIS_MODULE;
+	/* Register auxiliary reset driver when applicable */
+	if (data->rst_drvname)
+		ret = devm_meson_clk_rst_aux_register(dev, map, data->rst_drvname);
 
-	return devm_reset_controller_register(dev, &rst->rstc);
+	return ret;
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -1866,8 +1776,7 @@ static const struct audioclk_data g12a_audioclk_data = {
 		.hws = g12a_audio_hw_clks,
 		.num = ARRAY_SIZE(g12a_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SW_RESET,
-	.reset_num = 26,
+	.rst_drvname = "rst-g12a",
 };
 
 static const struct audioclk_data sm1_audioclk_data = {
@@ -1877,8 +1786,7 @@ static const struct audioclk_data sm1_audioclk_data = {
 		.hws = sm1_audio_hw_clks,
 		.num = ARRAY_SIZE(sm1_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SM1_SW_RESET0,
-	.reset_num = 39,
+	.rst_drvname = "rst-sm1",
 };
 
 static const struct of_device_id clkc_match_table[] = {
-- 
2.43.0


