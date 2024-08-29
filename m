Return-Path: <linux-kernel+bounces-307497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F6964E22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073D5286CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F601BF7E2;
	Thu, 29 Aug 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8YwRM3V"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878731BE845
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957088; cv=none; b=YT0UxPUUWS+QNHqVq5KvunrtOswiBgc9MR08ciP3Z/90b38WBPb5Re2KMyxlvxy/FTHXkeV88XYL+RP3wgJh5zatTcErfUpc6KCgRarBK9++PkByIUN2nCxAwBuPkRoJTkBeqqAXXKjXDONDKd8XzUdrxR5B856Qz7ss4e/3JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957088; c=relaxed/simple;
	bh=glpytlFNWVyL5EuuRuf2gTf+/aIydiklOOZeTJB0XJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wmzdp14EXmg0p14LoHtypWKRdGS4QfpFNQU9sHydI/QyvML9czOhTCsmQC1GMGzzvgBqkGxl8mnd1ReSWz+ouQtLV1hEr8pygniRMn0/NVoUZQwk+5ksdNugHZqCoUUBjkD1iXQM/S5DluI3x8u8LZDhdWeAv+Dm+yKKvcKJz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8YwRM3V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367990aaef3so561246f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724957083; x=1725561883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9Sc5q6d+L7jR6dSkuanGyhhhM4vadmsIdrORiHP/aw=;
        b=t8YwRM3VJNPZTTJEZvTQM2W/UmCJIyXftzjiUKAUJOxrTizUhuZaODPZ2ilhBPNTx2
         E4poynzLoOoNWP0rt2Fzt4E81x2qRgh2yTxHJ+uSqLpZbb+7kUFKw6hlVvpIQLIb+Xgr
         TQlgBcAZFy3j7Hk0PGz00zjGPojScUkgZXFi7t618r9SJqNu99F22cPVt6Y/hTNq9kgF
         CiHEiCiCY3uE0poboJujLZwgTudOmJy0UsZ/rka5HvJYdI4W7TDS2WGd2C0rxH0/3CWE
         6rJmIYaO8aAEbJ5rubI+5kAnRo/JKnZoqaaOCbAUyrFXSW/9FKjHsgeanEsgQwmHwD5j
         /R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957083; x=1725561883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9Sc5q6d+L7jR6dSkuanGyhhhM4vadmsIdrORiHP/aw=;
        b=QYUvTwUefTqi7CItVcuCrmx0wwnFKI1Crs6mlWXq0ImWLV/YQgWOPPv4JHcX+hBRsX
         QaG9k1oO37SS3VAR/An2vBkD102UXF6IZyRoCwdMp7OaE0C8x5bQmj9VVZ8apjpcgaBQ
         LEaoXS9Y/eexqKphiOpNRtQYjbwzSYXU+vkhvf0EVIe21cbTluhDYx56NtzMDPbUjUw+
         u/xuThJxQT5SdgjecaN72fPOOLs0u66nSVJGohkmf9CIOLVV2wErqOwxEaJgkUCNgreL
         Wk3bDPMwVLf1WMslXNyrp/5KjVmbI5U55ARERq8GKDEhUDGsUi9i2oXtci0+28FYi368
         eD+A==
X-Forwarded-Encrypted: i=1; AJvYcCXbUWBGt8gWvpoIIn7xtc2gEe0lR+hslChI6wn7jhqRQE077CFaoZu6MuhUYmxHxMuvDB2yo2LWe3yd2EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtLTp8TTgro0Zkgm88fg5OiWmQ64mFAza5QWcNRsN9BZOZ0g9
	m0qh3ddPWFgStdLp7ObhXfPogBnhvmTk974CIsqxD7qEveC9RyoSSSwJyKocDhA=
X-Google-Smtp-Source: AGHT+IHwSGyND99cltAUSDsWUNtowwPO8QufcIbhRi0JQSQLsWYocj0S5nwXV2FqOaMz/V1ZzyWv+Q==
X-Received: by 2002:adf:fc4d:0:b0:374:90b0:1f63 with SMTP id ffacd0b85a97d-3749b586babmr2514627f8f.60.1724957082690;
        Thu, 29 Aug 2024 11:44:42 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33b41sm24540885e9.40.2024.08.29.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:44:42 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 29 Aug 2024 21:44:26 +0300
Subject: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
In-Reply-To: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10730; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=glpytlFNWVyL5EuuRuf2gTf+/aIydiklOOZeTJB0XJw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBm0MGUsqNOux+Q2pK76CLjpRflg110B9hZpYHy/
 k1DjoO5TomJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZtDBlAAKCRAbX0TJAJUV
 VkPGD/91icgCUGLYigkyK5NdblCCernhkJbQhjRNuO7N/l3/qS0FgljE6wmsii3cnClLYHb3J8z
 kkafzHVCLenI+qdolWsViCgLMzFZr46BK3hEoATN1wE+Gd3zoZkquoSg9oqNo5kGzhLJSg7p8iI
 EcqpVF5JauGy28h+4CvucG18/kfA2I5ZT5WeCFlc/5YjBK5sVdFpNKqTU1WLH+4BWfH5/oKr8UT
 GiMuoCaX3L1egfOy7OWfB7Z7tIUqiY+k545k/I0pI94K7RxsHPyitl51WF/xvoev30/Z0t5VCll
 ykV7qsqkOX87Po/zJUlDDyPjPkfNfe0Q45ZSUg7UJcDF8YTgiTJIPA/iAPcc1GFxTsSdiYWTYLk
 Ij5kr+tIbu3U72LUI3EBf3KK2e/PNR1XqJkTd3J8WgDm/fD9eRAsu7xnovbZE4qE4DFlRNZS9KN
 LxfqDjhmr/JoKXiyhJODm8wrwuejw3PkyqFYB82qXlKv4xcE9h5TYwuD2whCdGtOQPcybq2HP85
 vmao+zycEc+89P8AAcchcUvKLDpNhjV7Ywr0eC/usnSzr7p+aQ+VJtFWQS+HKiexhbugNJvrBmS
 lp4qcX0806cGlWMiBbi2h1ddo8VyrA2t138bwxrRsShtDyZqbLoFR+YdHiu0W1lTB1hGmxFvlzf
 T4NPktcaQbp3XIw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
It provides both altmode and orientation handling.

Add a driver with support for the following modes:
 - DP 4lanes
 - USB3
 - DP 2lanes + USB3

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/usb/typec/mux/Kconfig  |  10 ++
 drivers/usb/typec/mux/Makefile |   1 +
 drivers/usb/typec/mux/ps8830.c | 347 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index ce7db6ad3057..48613b67f1c5 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -56,6 +56,16 @@ config TYPEC_MUX_NB7VPQ904M
 	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
 	  redriver chip found on some devices with a Type-C port.
 
+config TYPEC_MUX_PS8830
+	tristate "Parade PS8830 Type-C retimer driver"
+	depends on I2C
+	depends on DRM || DRM=n
+	select DRM_AUX_BRIDGE if DRM_BRIDGE && OF
+	select REGMAP_I2C
+	help
+	  Say Y or M if your system has a Parade PS8830 Type-C retimer chip
+	  found on some devices with a Type-C port.
+
 config TYPEC_MUX_PTN36502
 	tristate "NXP PTN36502 Type-C redriver driver"
 	depends on I2C
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index bb96f30267af..4b23b12cfe45 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
 obj-$(CONFIG_TYPEC_MUX_IT5205)		+= it5205.o
 obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
+obj-$(CONFIG_TYPEC_MUX_PS8830)		+= ps8830.o
 obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
 obj-$(CONFIG_TYPEC_MUX_WCD939X_USBSS)	+= wcd939x-usbss.o
diff --git a/drivers/usb/typec/mux/ps8830.c b/drivers/usb/typec/mux/ps8830.c
new file mode 100644
index 000000000000..517ccac5932f
--- /dev/null
+++ b/drivers/usb/typec/mux/ps8830.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Parade PS8830 usb retimer driver
+ *
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <drm/bridge/aux-bridge.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
+
+struct ps8830_retimer {
+	struct i2c_client *client;
+	struct regulator_bulk_data supplies[4];
+	struct gpio_desc *reset_gpio;
+	struct regmap *regmap;
+	struct typec_switch_dev *sw;
+	struct typec_retimer *retimer;
+	struct clk *xo_clk;
+
+	bool needs_update;
+	struct typec_switch *typec_switch;
+	struct typec_mux *typec_mux;
+
+	struct mutex lock; /* protect non-concurrent retimer & switch */
+
+	enum typec_orientation orientation;
+	unsigned long mode;
+	int cfg[3];
+
+};
+
+static int ps8830_configure(struct ps8830_retimer *retimer, int cfg0, int cfg1, int cfg2)
+{
+	if (cfg0 == retimer->cfg[0] &&
+	    cfg1 == retimer->cfg[1] &&
+	    cfg2 == retimer->cfg[2])
+		return 0;
+
+	retimer->cfg[0] = cfg0;
+	retimer->cfg[1] = cfg1;
+	retimer->cfg[2] = cfg2;
+
+	regmap_write(retimer->regmap, 0x0, cfg0);
+	regmap_write(retimer->regmap, 0x1, cfg1);
+	regmap_write(retimer->regmap, 0x2, cfg2);
+
+	return 0;
+}
+
+static int ps8380_set(struct ps8830_retimer *retimer)
+{
+	int cfg0 = 0x00, cfg1 = 0x00, cfg2 = 0x00;
+	int ret;
+
+	retimer->needs_update = false;
+
+	switch (retimer->orientation) {
+	/* Safe mode */
+	case TYPEC_ORIENTATION_NONE:
+		cfg0 = 0x01;
+		cfg1 = 0x00;
+		cfg2 = 0x00;
+		break;
+	case TYPEC_ORIENTATION_NORMAL:
+		cfg0 = 0x01;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		cfg0 = 0x03;
+		break;
+	}
+
+	switch (retimer->mode) {
+	/* Safe mode */
+	case TYPEC_STATE_SAFE:
+		cfg0 = 0x01;
+		cfg1 = 0x00;
+		cfg2 = 0x00;
+		break;
+
+	/* USB3 Only */
+	case TYPEC_STATE_USB:
+		cfg0 |= 0x20;
+		break;
+
+	/* DP Only */
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		cfg0 &= 0x0f;
+		cfg1 = 0x85;
+		break;
+
+	/* DP + USB */
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_F:
+		cfg0 |= 0x20;
+		cfg1 = 0x85;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	gpiod_set_value(retimer->reset_gpio, 0);
+	msleep(20);
+	gpiod_set_value(retimer->reset_gpio, 1);
+
+	msleep(60);
+
+	ret = ps8830_configure(retimer, 0x01, 0x00, 0x00);
+
+	msleep(30);
+
+	return ps8830_configure(retimer, cfg0, cfg1, cfg2);
+}
+
+static int ps8830_sw_set(struct typec_switch_dev *sw,
+			 enum typec_orientation orientation)
+{
+	struct ps8830_retimer *retimer = typec_switch_get_drvdata(sw);
+	int ret = 0;
+
+	ret = typec_switch_set(retimer->typec_switch, orientation);
+	if (ret)
+		return ret;
+
+	mutex_lock(&retimer->lock);
+
+	if (retimer->orientation != orientation) {
+		retimer->orientation = orientation;
+		retimer->needs_update = true;
+	}
+
+	if (retimer->needs_update)
+		ret = ps8380_set(retimer);
+
+	mutex_unlock(&retimer->lock);
+
+	return ret;
+}
+
+static int ps8830_retimer_set(struct typec_retimer *rtmr,
+			      struct typec_retimer_state *state)
+{
+	struct ps8830_retimer *retimer = typec_retimer_get_drvdata(rtmr);
+	struct typec_mux_state mux_state;
+	int ret = 0;
+
+	mutex_lock(&retimer->lock);
+
+	if (state->mode != retimer->mode) {
+		retimer->mode = state->mode;
+		retimer->needs_update = true;
+	}
+
+	if (retimer->needs_update)
+		ret = ps8380_set(retimer);
+
+	mutex_unlock(&retimer->lock);
+
+	if (ret)
+		return ret;
+
+	mux_state.alt = state->alt;
+	mux_state.data = state->data;
+	mux_state.mode = state->mode;
+
+	return typec_mux_set(retimer->typec_mux, &mux_state);
+}
+
+static const struct regmap_config ps8830_retimer_regmap = {
+	.max_register = 0x1f,
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ps8830_retimer_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_retimer_desc rtmr_desc = { };
+	struct ps8830_retimer *retimer;
+	int ret;
+
+	retimer = devm_kzalloc(dev, sizeof(*retimer), GFP_KERNEL);
+	if (!retimer)
+		return -ENOMEM;
+
+	retimer->client = client;
+
+	retimer->regmap = devm_regmap_init_i2c(client, &ps8830_retimer_regmap);
+	if (IS_ERR(retimer->regmap)) {
+		dev_err(dev, "Failed to allocate register map\n");
+		return PTR_ERR(retimer->regmap);
+	}
+
+	retimer->supplies[0].supply = "vdd33";
+	retimer->supplies[1].supply = "vdd18";
+	retimer->supplies[2].supply = "vdd15";
+	retimer->supplies[3].supply = "vcc";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(retimer->supplies),
+				      retimer->supplies);
+	if (ret)
+		return ret;
+
+	retimer->xo_clk = devm_clk_get(dev, "xo");
+	if (IS_ERR(retimer->xo_clk))
+		return PTR_ERR(retimer->xo_clk);
+
+	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(retimer->reset_gpio))
+		return PTR_ERR(retimer->reset_gpio);
+
+	retimer->typec_switch = fwnode_typec_switch_get(dev->fwnode);
+	if (IS_ERR(retimer->typec_switch))
+		return dev_err_probe(dev, PTR_ERR(retimer->typec_switch),
+				     "failed to acquire orientation-switch\n");
+
+	retimer->typec_mux = fwnode_typec_mux_get(dev->fwnode);
+	if (IS_ERR(retimer->typec_mux)) {
+		ret = dev_err_probe(dev, PTR_ERR(retimer->typec_mux),
+				    "failed to acquire mode-mux\n");
+		goto err_switch_put;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(retimer->supplies),
+				    retimer->supplies);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable regulators %d\n", ret);
+		goto err_mux_put;
+	}
+
+	ret = clk_prepare_enable(retimer->xo_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable XO: %d\n", ret);
+		goto err_disable_vreg;
+	}
+
+	gpiod_set_value(retimer->reset_gpio, 0);
+	msleep(20);
+	gpiod_set_value(retimer->reset_gpio, 1);
+
+	msleep(60);
+	mutex_init(&retimer->lock);
+
+	sw_desc.drvdata = retimer;
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.set = ps8830_sw_set;
+
+	ret = drm_aux_bridge_register(dev);
+	if (ret)
+		goto err_disable_gpio;
+
+	retimer->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(retimer->sw)) {
+		ret = dev_err_probe(dev, PTR_ERR(retimer->sw),
+				    "Error registering typec switch\n");
+		goto err_disable_gpio;
+	}
+
+	rtmr_desc.drvdata = retimer;
+	rtmr_desc.fwnode = dev_fwnode(dev);
+	rtmr_desc.set = ps8830_retimer_set;
+
+	retimer->retimer = typec_retimer_register(dev, &rtmr_desc);
+	if (IS_ERR(retimer->retimer)) {
+		ret = dev_err_probe(dev, PTR_ERR(retimer->retimer),
+				    "Error registering typec retimer\n");
+		goto err_switch_unregister;
+	}
+
+	dev_info(dev, "Registered Parade PS8830 retimer\n");
+	return 0;
+
+err_switch_unregister:
+	typec_switch_unregister(retimer->sw);
+
+err_disable_gpio:
+	gpiod_set_value(retimer->reset_gpio, 0);
+	clk_disable_unprepare(retimer->xo_clk);
+
+err_disable_vreg:
+	regulator_bulk_disable(ARRAY_SIZE(retimer->supplies),
+			       retimer->supplies);
+err_mux_put:
+	typec_mux_put(retimer->typec_mux);
+
+err_switch_put:
+	typec_switch_put(retimer->typec_switch);
+
+	return ret;
+}
+
+static void ps8830_retimer_remove(struct i2c_client *client)
+{
+	struct ps8830_retimer *retimer = i2c_get_clientdata(client);
+
+	typec_retimer_unregister(retimer->retimer);
+	typec_switch_unregister(retimer->sw);
+
+	gpiod_set_value(retimer->reset_gpio, 0);
+
+	clk_disable_unprepare(retimer->xo_clk);
+
+	regulator_bulk_disable(ARRAY_SIZE(retimer->supplies),
+			       retimer->supplies);
+
+	typec_mux_put(retimer->typec_mux);
+	typec_switch_put(retimer->typec_switch);
+}
+
+static const struct i2c_device_id ps8830_retimer_table[] = {
+	{ "parade,ps8830" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ps8830_retimer_table);
+
+static const struct of_device_id ps8830_retimer_of_table[] = {
+	{ .compatible = "parade,ps8830" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ps8830_retimer_of_table);
+
+static struct i2c_driver ps8830_retimer_driver = {
+	.driver = {
+		.name = "ps8830_retimer",
+		.of_match_table = ps8830_retimer_of_table,
+	},
+	.probe		= ps8830_retimer_probe,
+	.remove		= ps8830_retimer_remove,
+	.id_table	= ps8830_retimer_table,
+};
+
+module_i2c_driver(ps8830_retimer_driver);
+
+MODULE_DESCRIPTION("Parade PS8830 Type-C Retimer driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


