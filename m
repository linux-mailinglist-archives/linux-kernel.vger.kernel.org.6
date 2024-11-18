Return-Path: <linux-kernel+bounces-412639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C949D0BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539BF283286
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E6192B70;
	Mon, 18 Nov 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kdp0aDwI"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C06191F81
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922448; cv=none; b=As7GcYSQh17yZODLfK6FJIedHcryvFcgaLYVKj4B4MfSQ3B+0jo4uDibsg7gjUZm3GbIgQuvcgF3oF5j9NdWCKMXSpuWNdfZDb832mtYFhw4zFQB4hNRqHV56U9p5gpbDGP09RVY2NlkVjosDwQg2x6tx/9yFzuColvdTzCrbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922448; c=relaxed/simple;
	bh=mr78STc32F6NVAyA04kXqtWn3/4JDgdZRTo0Intr1/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAsx0wtzbYim4SiJqeycYs0azl/4p70mzOTJ4+ZZYw3HwADKlKHRg9/26/kAn204z0+0MeHh0Xs8aEXhjUCvydzLZOfWAl9WPrCfo9gY6IJpSuL26AqT3vcui0tnvDaf6oF/ikch1t2ucwtuq2RgHAltDUCK+QpLCjiP9RxIuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kdp0aDwI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso2874516a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731922445; x=1732527245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks7+zAh8GlNof48UsfJ+LdfKrIBWbtjlmTnt6P9ZM8Q=;
        b=Kdp0aDwIfyHoJ+a7QGAP6Bp42il2v5L4yISgLOpeWwe7onR6MWPnTQGKTpYj1DsNgS
         B6UwOGyW6HhoLbPO0qCYtEy/bpbJWlRR8s4hum1iYIGa0HRrdMF4a39HUECoh5Pc6wzZ
         SkaiXp5RZ6w6cw/JJw5dw/X3lYIjA2JtIuEuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922445; x=1732527245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks7+zAh8GlNof48UsfJ+LdfKrIBWbtjlmTnt6P9ZM8Q=;
        b=sFL0GxSingrgCK2GGKLfWU15spL5OhxmL1VN+0wMCIROacNNp1fYZbJAo7CW5hW0zc
         BPxRVUAuDhZ6lbXViKKab5+pyARpzbDNejE/K+wQLtTDPxfwfQNKi/PudVn1AUA5+zij
         qWwezy77shD+5dGfjwhRozgoRBgM7S7tilLuouqPrNKYmc1XwppoHzopRtREjsaD2W4c
         XcQZhrO+EioyJb9avTQA3238yfSM56G/N1nZHc0Kv25XhNCERdF3nkYiTUcJ/uKD2nTk
         oiJg8D2z2L0VY+CmNy2sLxyVQrT5PD3c+pQfclYvkUjtO0sabPdCNzXHFUlWLCl8mX+l
         5ErA==
X-Gm-Message-State: AOJu0Yzi8hpPAoLaaJaVTPTzXjRNNuGrS4HxD35ks3+0X+CQoc5mEXva
	ojO9K31WvzTGBx5wE5P2Ct0OP3GGkWAsSGv4inF9aml8s5FnbERIwaJkvs6sXA==
X-Google-Smtp-Source: AGHT+IEJfWkT4rx6TA0lmY/3l1SbBZlpAFbZZ+EhIEzl62OAA3Oe1rd4uNwXlwBQvP/WP4bn+OmVHg==
X-Received: by 2002:a05:6a20:c896:b0:1dc:bdbd:9017 with SMTP id adf61e73a8af0-1dcbdbd91f4mr150236637.40.1731922445334;
        Mon, 18 Nov 2024 01:34:05 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:e40d:fa29:75db:2caa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f1e24ce4sm8333500a91.0.2024.11.18.01.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:34:04 -0800 (PST)
From: "Sung-Chi, Li" <lschyi@chromium.org>
Date: Mon, 18 Nov 2024 17:33:46 +0800
Subject: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new driver
 to control charge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
In-Reply-To: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731922439; l=8745;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=mr78STc32F6NVAyA04kXqtWn3/4JDgdZRTo0Intr1/Y=;
 b=6ULQoZs/+Ku8qgFPy2ll+3sbBufLGITxaWVjTEpjxIL63t2VI1Y0t3aFvm4E40JZQBd1AtoeV
 eG9syX/9SIPApVJKwygVB32YxlGxhGybsHb1hEf1sacGf5LwTgWwJGU
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

Implement the new platform driver cros_ec_charge_state to have low finer
control over the charge current flow through the charge chip connected
on ChromeOS Embedded Controller (EC).

The driver reads configured charge chip configurations from the device
tree, and register these chip controls as thermal zone devices, so they
are controllable from the thermal subsystem.

As such, corresponding DTS changes are needed, and here is a sample DTS
configuration:

```
&cros_ec {
	charge-chip-battery {
		compatible = "google,cros-ec-charge-state";
		type = "charge";
		min-milliamp = <150>;
		max-milliamp = <5000>;
	};
};
```

Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
---
 drivers/platform/chrome/Kconfig                |  11 ++
 drivers/platform/chrome/Makefile               |   1 +
 drivers/platform/chrome/cros_ec_charge_state.c | 215 +++++++++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 7dbeb786352a..34d00d8823cb 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -297,6 +297,17 @@ config CROS_TYPEC_SWITCH
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros_typec_switch.
 
+config CROS_CHARGE_STATE
+	tristate "ChromeOS EC Charger Chip  Control"
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
+	help
+	  If you say Y here, you get support for configuring the battery
+	  charging and system input current.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros-ec-charge-state.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 # Kunit test cases
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..01c7154ae119 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_HPS_I2C)		+= cros_hps_i2c.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
+obj-$(CONFIG_CROS_CHARGE_STATE)		+= cros_ec_charge_state.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
 
diff --git a/drivers/platform/chrome/cros_ec_charge_state.c b/drivers/platform/chrome/cros_ec_charge_state.c
new file mode 100644
index 000000000000..3fed5b48bc92
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_charge_state.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Charge state driver for ChromeOS Embedded Controller
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This driver exports the low level control over charge chip connected to EC
+ * which allows to manipulate the current used to charge the battery, and also
+ * manipulate the current input to the whole system.
+ * This driver also registers that charge chip as a thermal cooling device.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define DRV_NAME "cros-ec-charge-state"
+#define CHARGE_TYPE_CHARGE "charge"
+#define CHARGE_TYPE_INPUT "input"
+
+struct cros_ec_charge_state_data {
+	struct cros_ec_device *ec_dev;
+	struct device *dev;
+	enum charge_state_params charge_type;
+	uint32_t min_milliamp;
+	uint32_t max_milliamp;
+};
+
+static int
+cros_ec_charge_state_get_current_limit(struct cros_ec_device *ec_dev,
+				       enum charge_state_params charge_type,
+				       uint32_t *limit)
+{
+	struct ec_params_charge_state param;
+	struct ec_response_charge_state state;
+	int ret;
+
+	param.cmd = CHARGE_STATE_CMD_GET_PARAM;
+	param.get_param.param = charge_type;
+	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_CHARGE_STATE, &param, sizeof(param),
+			  &state, sizeof(state));
+	if (ret < 0)
+		return ret;
+
+	*limit = cpu_to_le32(state.get_param.value);
+	return 0;
+}
+
+static int
+cros_ec_charge_state_set_current_limit(struct cros_ec_device *ec_dev,
+				       enum charge_state_params charge_type,
+				       uint32_t limit)
+{
+	struct ec_params_charge_state param;
+	int ret;
+
+	param.cmd = CHARGE_STATE_CMD_SET_PARAM;
+	param.set_param.param = charge_type;
+	param.set_param.value = cpu_to_le32(limit);
+	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_CHARGE_STATE, &param, sizeof(param),
+			  NULL, 0);
+	return (ret < 0) ? ret : 0;
+}
+
+static int
+cros_ec_charge_state_get_max_state(struct thermal_cooling_device *cdev,
+				   unsigned long *state)
+{
+	struct cros_ec_charge_state_data *data = cdev->devdata;
+	*state = data->max_milliamp;
+	return 0;
+}
+
+static int
+cros_ec_charge_state_get_cur_state(struct thermal_cooling_device *cdev,
+				   unsigned long *state)
+{
+	struct cros_ec_charge_state_data *data = cdev->devdata;
+	uint32_t limit;
+	int ret;
+
+	ret = cros_ec_charge_state_get_current_limit(data->ec_dev,
+						     data->charge_type, &limit);
+	if (ret) {
+		dev_err(data->dev, "failed to get current state: %d", ret);
+		return ret;
+	}
+
+	*state = data->max_milliamp - limit;
+	return 0;
+}
+
+static int
+cros_ec_charge_state_set_cur_state(struct thermal_cooling_device *cdev,
+				   unsigned long state)
+{
+	struct cros_ec_charge_state_data *data = cdev->devdata;
+	uint32_t limit = data->max_milliamp - state;
+
+	if (limit < data->min_milliamp) {
+		dev_warn(
+			data->dev,
+			"failed to set current %u lower than minimum %d; set to minimum",
+			limit, data->min_milliamp);
+		limit = data->min_milliamp;
+	}
+
+	state = data->max_milliamp - limit;
+	return cros_ec_charge_state_set_current_limit(
+		data->ec_dev, data->charge_type, (uint32_t)state);
+}
+
+static const struct thermal_cooling_device_ops
+	cros_ec_charge_state_cooling_device_ops = {
+		.get_max_state = cros_ec_charge_state_get_max_state,
+		.get_cur_state = cros_ec_charge_state_get_cur_state,
+		.set_cur_state = cros_ec_charge_state_set_cur_state,
+	};
+
+static int
+cros_ec_charge_state_register_charge_chip(struct device *dev,
+					  struct device_node *node,
+					  struct cros_ec_device *cros_ec)
+{
+	struct cros_ec_charge_state_data *data;
+	struct thermal_cooling_device *cdev;
+	const char *type_val = NULL;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_string(node, "type", &type_val);
+	if (ret) {
+		dev_err(dev, "failed to get charge type: %d", ret);
+		return ret;
+	}
+
+	if (!strcmp(type_val, CHARGE_TYPE_CHARGE)) {
+		data->charge_type = CS_PARAM_CHG_CURRENT;
+	} else if (!strcmp(type_val, CHARGE_TYPE_INPUT)) {
+		data->charge_type = CS_PARAM_CHG_INPUT_CURRENT;
+	} else {
+		dev_err(dev, "unknown charge type: %s", type_val);
+		return -1;
+	}
+
+	ret = of_property_read_u32(node, "min-milliamp", &data->min_milliamp);
+	if (ret) {
+		dev_err(dev, "failed to get min-milliamp data: %d", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "max-milliamp", &data->max_milliamp);
+	if (ret) {
+		dev_err(dev, "failed to get max-milliamp data: %d", ret);
+		return ret;
+	}
+
+	data->ec_dev = cros_ec;
+	data->dev = dev;
+
+	cdev = devm_thermal_of_cooling_device_register(
+		dev, node, node->name, data,
+		&cros_ec_charge_state_cooling_device_ops);
+	if (IS_ERR_VALUE(cdev)) {
+		dev_err(dev,
+			"failed to register charge chip %s as cooling device: %pe",
+			node->name, cdev);
+		return PTR_ERR(cdev);
+	}
+
+	return 0;
+}
+
+static int cros_ec_charge_state_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct device_node *child;
+
+	for_each_available_child_of_node(cros_ec->dev->of_node, child) {
+		if (!of_device_is_compatible(child,
+					     "google,cros-ec-charge-state"))
+			continue;
+		if (cros_ec_charge_state_register_charge_chip(dev, child,
+							      cros_ec))
+			continue;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id cros_ec_charge_state_id[] = {
+	{ DRV_NAME,  0 },
+	{}
+};
+
+static struct platform_driver cros_ec_chargedev_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_ec_charge_state_probe,
+};
+
+module_platform_driver(cros_ec_chargedev_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_ec_charge_state_id);
+MODULE_DESCRIPTION("ChromeOS EC Charge State Driver");
+MODULE_AUTHOR("Sung-Chi, Li <lschyi@chromium.org>");
+MODULE_LICENSE("GPL");

-- 
2.47.0.338.g60cca15819-goog


