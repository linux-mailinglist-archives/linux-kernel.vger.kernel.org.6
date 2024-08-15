Return-Path: <linux-kernel+bounces-288044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F167953224
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D7B284293
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B41A01B9;
	Thu, 15 Aug 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgsEmYFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7B1AC8BB;
	Thu, 15 Aug 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730510; cv=none; b=mX7TzrH6Zozu8YEvZqOBaM0UUkzvNNAze03XeVfiz35rIDVM61c6R5uH7aT7YmlPqdIyMlttF5NBToRl8K5gGsOxW8aIW+Gwh6Jzj7cfWOXgysLxdiXpbrbMtCeQmVRY6w/x8nzDhWyybxAeDCZKbVZX+89sqNKDQgyBNlKRKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730510; c=relaxed/simple;
	bh=jEMtHxNfXR0nXSRDo6ecNWjuNaFwaoL99JGk8ZNp/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqZO8u8DFjSzguQkpFyeIhYvEOdOgjyuiarY/T+zbopDRACfjog6mfABu6I9kPDgBvqSQ7zqXiy9JS4dgTB4GLIomGHAOmO3Ksp/L5Bw6+W7SrpgCGt4InklshioPnu8E+xCEysZvPMWKOkP4As8bc7NmSeChvqPte5+SpxVEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgsEmYFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0097CC32786;
	Thu, 15 Aug 2024 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730509;
	bh=jEMtHxNfXR0nXSRDo6ecNWjuNaFwaoL99JGk8ZNp/Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgsEmYFFulP8x/t9dLYlSykTfiVJ5Jn1hZ7B8xgYxb4c1pbQ8gEY54ge3G80EuUBl
	 Vlr/cwn40zJ/l7ZOQonKRCWvftY5qn3M0bLPx76Ea4CoitZr0/9H0FIUe/bBMNdC8P
	 2DM+3qL1lfDTFBYbAR3g4pjaZ9F9vh92vKT9hc+DAIkUqEMN91ufpS+HCg6MA2B+Zm
	 nXy3XX/YT9WFYemBG51qozSVHQQ36abWMBYEAATVG30HuLtLwTZPJzjPuEgIp5BZzq
	 AqPO7/yN8Ep6s7YtRtIpNwwoKDCbAC3bE7V3dOBhwMnFwyFd0+p/F3X5ma7DNTaV4C
	 xATztTk36O5jA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lars Randers <lranders@mail.dk>
Subject: [RFC PATCH 02/11] hwmon: add a driver for the temp/voltage sensor on PolarFire SoC
Date: Thu, 15 Aug 2024 15:01:05 +0100
Message-ID: <20240815-rebuilt-snowstorm-04bfdaa24a1f@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12022; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=8oatO5wTt5vz/iuFpGgGCMDMPpmbnqz7B3dspxsyhwE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHS6K7vl1f+5FXm9W3ta8JhP+OUZB5veBe/3cJ87O 7CvYG1VRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACYisIORYc89O+/VF++em+fd aCZ3PjaDIX5SZI2ZX8D/o6FTzkTf6WdkaD+zKfAf835mtTAV/ykPZqn/Wfdx8pQb5m9Nlpnwioc IMAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Lars Randers <lranders@mail.dk>

Signed-off-by: Lars Randers <lranders@mail.dk>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/hwmon/Kconfig          |  12 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/tvs-mpfs.c       | 379 +++++++++++++++++++++++++++++++++
 drivers/mailbox/mailbox-mpfs.c |   1 +
 4 files changed, 393 insertions(+)
 create mode 100644 drivers/hwmon/tvs-mpfs.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..2d2bed68dcad 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2295,6 +2295,18 @@ config SENSORS_TMP513
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp513.
 
+config SENSORS_TVS_MPFS
+	tristate "PolarFire SoC (MPFS) temperature and voltage sensor"
+	depends on POLARFIRE_SOC_MAILBOX
+	help
+	  This driver adds support for the PolarFire SoC (MPFS) Temperature and
+	  Voltage Sensor.
+
+	  To compile this driver as a module, choose M here. the
+	  module will be called tvs-mpfs.
+
+	  If unsure, say N.
+
 config SENSORS_VEXPRESS
 	tristate "Versatile Express"
 	depends on VEXPRESS_CONFIG
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..7f44c2567008 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -220,6 +220,7 @@ obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TMP464)	+= tmp464.o
 obj-$(CONFIG_SENSORS_TMP513)	+= tmp513.o
+obj-$(CONFIG_SENSORS_TVS_MPFS)  += tvs-mpfs.o
 obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
diff --git a/drivers/hwmon/tvs-mpfs.c b/drivers/hwmon/tvs-mpfs.c
new file mode 100644
index 000000000000..6f117d0b7db6
--- /dev/null
+++ b/drivers/hwmon/tvs-mpfs.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * Author: Lars Randers <lranders@mail.dk>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/freezer.h>
+#include <linux/kthread.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PFSOC_CONTROL_SCB_TVS_CONTROL 0x08
+#define PFSOC_CONTROL_SCB_TVS_OUTPUT0 0x24
+#define PFSOC_CONTROL_SCB_TVS_OUTPUT1 0x28
+
+#define CTRL_POWEROFF BIT(5)
+#define CTRL_ABORT    BIT(4)
+#define CTRL_TEMP     BIT(3)
+#define CTRL_2P5      BIT(2)
+#define CTRL_1P8      BIT(1)
+#define CTRL_1P05     BIT(0)
+
+#define OUTPUT0_U1P8_MASK GENMASK(30, 16)
+#define OUTPUT0_U1P8_OFF  16
+#define OUTPUT0_U1P0_MASK GENMASK(14, 0)
+#define OUTPUT0_U1P0_OFF  0
+#define OUTPUT1_TEMP_MASK GENMASK(31, 16)
+#define OUTPUT1_TEMP_OFF  16
+#define OUTPUT1_U2P5_MASK GENMASK(14, 0)
+#define OUTPUT1_U2P5_OFF  0
+
+#define MPFS_TVS_MIN_POLL_INTERVAL_IN_MILLIS 2000
+
+/* The following constant is 273.5 in (16.4) fixedpoint notation */
+#define MPFS_TVS_MIN_TEMP_IN_K 0x1112
+
+typedef struct {
+	long min;
+	long actual;
+	long max;
+} mpfs_tvs_sensor_t;
+
+typedef enum {
+	SN_V1P05 = 0,
+	SN_V1P8,
+	SN_V2P5,
+	SN_TEMP,
+
+	SN_MAX
+} mpfs_tvs_sn_t;
+
+static const char *mpfs_tvs_voltage_labels[] = { "U1P05", "U1P8", "U2P5" };
+
+struct mpfs_tvs {
+	struct device *dev;
+	struct device *hwmon_dev;
+	struct task_struct *poll_task;
+	struct regmap *regmap;
+	bool kthread_running;
+	long update_interval;	/* in milli-seconds */
+	mpfs_tvs_sensor_t sensors[SN_MAX];
+};
+
+static int mpfs_tvs_update_sensors(struct mpfs_tvs *data) {
+	u32 temp;
+	u32 work;
+	int ret;
+
+	ret = regmap_read(data->regmap, PFSOC_CONTROL_SCB_TVS_OUTPUT1, &temp);
+	if (ret)
+		return ret;
+
+	work = temp;
+
+	temp = (temp & OUTPUT1_TEMP_MASK) >> OUTPUT1_TEMP_OFF;
+	temp = clamp_val(temp, MPFS_TVS_MIN_TEMP_IN_K, INT_MAX);
+	temp = temp - MPFS_TVS_MIN_TEMP_IN_K; /* Kelvin to Celsius */
+	temp = (1000 * temp) >> 4; /* fixed point (10.4) to millicentigrade */
+	data->sensors[SN_TEMP].actual = temp;
+	data->sensors[SN_TEMP].max =
+		max(data->sensors[SN_TEMP].actual, data->sensors[SN_TEMP].max);
+	data->sensors[SN_TEMP].min =
+		min(data->sensors[SN_TEMP].min, data->sensors[SN_TEMP].actual);
+
+	work &= OUTPUT1_U2P5_MASK;
+	/* fixed point (11.3) adjust; value is already millivolts */
+	work  = (1 * work) >> 3;
+	data->sensors[SN_V2P5].actual = work;
+	data->sensors[SN_V2P5].max =
+		max(data->sensors[SN_V2P5].actual, data->sensors[SN_V2P5].max);
+	data->sensors[SN_V2P5].min =
+		min(data->sensors[SN_V2P5].min, data->sensors[SN_V2P5].actual);
+
+	ret = regmap_read(data->regmap, PFSOC_CONTROL_SCB_TVS_OUTPUT0, &temp);
+	if (ret)
+		return ret;
+
+	work = temp;
+	temp = (OUTPUT0_U1P8_MASK & temp) >> OUTPUT0_U1P8_OFF;
+	/* fixed point (11.3) adjust; value is already millivolts */
+	temp = (1 * temp) >> 3;
+	data->sensors[SN_V1P8].actual = temp;
+	data->sensors[SN_V1P8].max =
+		max(data->sensors[SN_V1P8].actual, data->sensors[SN_V1P8].max);
+	data->sensors[SN_V2P5].min =
+		min(data->sensors[SN_V1P8].min, data->sensors[SN_V1P8].actual);
+
+	work &= OUTPUT0_U1P0_MASK;
+	 /* fixed point (11.3) adjust; value is already millivolts */
+	work  = (1 * work) >> 3;
+	data->sensors[SN_V1P05].actual = work;
+	data->sensors[SN_V1P05].max =
+		max(data->sensors[SN_V1P05].actual, data->sensors[SN_V1P05].max);
+	data->sensors[SN_V1P05].min =
+		min(data->sensors[SN_V1P05].min, data->sensors[SN_V1P05].actual);
+
+	return 0;
+}
+
+
+static int mpfs_tvs_chip_read(struct mpfs_tvs *data, long *val)
+{
+	*val = data->update_interval;
+	return 0;
+}
+
+static int mpfs_tvs_temp_read(struct mpfs_tvs *data, u32 attr,
+			      int channel, long *val)
+{
+	switch(attr) {
+	case hwmon_temp_input:
+		*val = data->sensors[SN_TEMP].actual;
+		break;
+
+	case hwmon_temp_max:
+		*val = data->sensors[SN_TEMP].max;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int mpfs_tvs_voltage_read(struct mpfs_tvs *data, u32 attr,
+				 int channel, long *val)
+{
+	dev_dbg(data->dev, "read voltage chan %d\n", channel);
+	switch(attr) {
+	case hwmon_in_input:
+		*val = data->sensors[channel].actual;
+		break;
+
+	case hwmon_in_max:
+		*val = data->sensors[channel].max;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+
+static ssize_t mpfs_tvs_interval_write(struct mpfs_tvs *data, long val)
+{
+	data->update_interval =
+		clamp_val(val, MPFS_TVS_MIN_POLL_INTERVAL_IN_MILLIS, INT_MAX);
+	return 0;
+}
+
+
+static umode_t mpfs_tvs_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	if(type == hwmon_chip && attr == hwmon_chip_update_interval)
+		return 0644;
+
+	if(type == hwmon_temp) {
+		switch(attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_max:
+		case hwmon_temp_label:
+			return 0444;
+
+		default:
+			return 0;
+		}
+	} else if(type == hwmon_in) {
+		switch(attr) {
+		case hwmon_in_input:
+		case hwmon_in_label:
+			return 0444;
+
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static int mpfs_tvs_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct mpfs_tvs *data = dev_get_drvdata(dev);
+
+	switch(type) {
+	case hwmon_temp:
+		return mpfs_tvs_temp_read(data, attr, channel, val);
+	case hwmon_in:
+		return mpfs_tvs_voltage_read(data, attr, channel, val);
+	case hwmon_chip:
+		return mpfs_tvs_chip_read(data, val);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mpfs_tvs_write(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long val)
+{
+	struct mpfs_tvs *data = dev_get_drvdata(dev);
+
+	switch(type) {
+	case hwmon_chip:
+		return mpfs_tvs_interval_write(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mpfs_tvs_read_labels(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel,
+				const char **str)
+{
+	switch(type) {
+	case hwmon_temp:
+		*str = "CPU Temp";
+		return 0;
+	case hwmon_in:
+		*str = mpfs_tvs_voltage_labels[channel];
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+
+static const struct hwmon_ops mpfs_tvs_ops = {
+	.is_visible = mpfs_tvs_is_visible,
+	.read_string = mpfs_tvs_read_labels,
+	.read = mpfs_tvs_read,
+	.write = mpfs_tvs_write,
+};
+
+static const struct hwmon_channel_info *mpfs_tvs_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN |
+			   HWMON_T_MAX | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info mpfs_tvs_chip_info = {
+	.ops = &mpfs_tvs_ops,
+	.info = mpfs_tvs_info,
+};
+
+
+static int mpfs_tvs_poll_task(void *ptr)
+{
+	struct mpfs_tvs *data = ptr;
+	int ret = 0;
+
+	data->kthread_running = true;
+
+	set_freezable();
+
+	while(!kthread_should_stop()) {
+		schedule_timeout_interruptible(data->update_interval);
+		try_to_freeze();
+		ret = mpfs_tvs_update_sensors(data);
+		if(ret)
+			break;
+	}
+
+	data->kthread_running = false;
+	return ret;
+}
+
+static int mpfs_tvs_probe(struct platform_device *pdev)
+{
+	struct device *hwmon_dev;
+	struct mpfs_tvs *data;
+	struct task_struct *task;
+	int err;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if(!data)
+		return -ENOMEM;
+
+	data->dev = &pdev->dev;
+
+	data->regmap = syscon_node_to_regmap(data->dev->of_node->parent);
+
+	data->kthread_running = false;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(data->dev, "mpfs_tvs",
+							 data,
+							 &mpfs_tvs_chip_info,
+							 NULL);
+
+	if(IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(data->dev, "Class registration failed (%d)\n", err);
+		return err;
+	}
+
+	/* enable HW sensor */
+	err = regmap_write(data->regmap, PFSOC_CONTROL_SCB_TVS_CONTROL,
+			   CTRL_1P05 | CTRL_1P8 | CTRL_2P5 | CTRL_TEMP);
+
+	data->hwmon_dev = hwmon_dev;
+	data->sensors[SN_TEMP].max = 0;
+	data->sensors[SN_V1P05].min =
+		data->sensors[SN_V1P8].min =
+		data->sensors[SN_V2P5].min = 20000;
+	data->sensors[SN_V1P05].max =
+		data->sensors[SN_V1P8].max =
+		data->sensors[SN_V2P5].max = 0;
+	data->update_interval = MPFS_TVS_MIN_POLL_INTERVAL_IN_MILLIS;
+	mpfs_tvs_update_sensors(data);
+
+	task = kthread_run(mpfs_tvs_poll_task, data, "tvs-mpfs-kthread");
+	if (IS_ERR(task)) {
+		err = PTR_ERR(task);
+		dev_err(data->dev, "Unable to run kthread err %d\n", err);
+		return err;
+	}
+
+	data->poll_task = task;
+
+	dev_info(data->dev, "Registered MPFS TVS auxiliary driver\n");
+	return 0;
+}
+
+static const struct of_device_id mpfs_tvs_of_match[] = {
+	{ .compatible = "microchip,mpfs-tvs", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_tvs_of_match);
+
+static struct platform_driver mpfs_tvs_driver = {
+	.probe		= mpfs_tvs_probe,
+	.driver = {
+		.name = "mpfs-tvs",
+		.of_match_table = mpfs_tvs_of_match,
+	},
+};
+module_platform_driver(mpfs_tvs_driver);
+
+MODULE_AUTHOR("Lars Randers <lranders@mail.dk>");
+MODULE_DESCRIPTION("PolarFire SoC temperature & voltage sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 20ee283a04cc..0fd83bdd4cee 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -262,6 +262,7 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Registering MPFS mailbox controller failed\n");
 		return ret;
 	}
+
 	dev_info(&pdev->dev, "Registered MPFS mailbox controller driver\n");
 
 	return 0;
-- 
2.43.0


