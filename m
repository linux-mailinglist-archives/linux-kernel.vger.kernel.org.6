Return-Path: <linux-kernel+bounces-274033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB01894718E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CA1C20B4D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2B13B5B7;
	Sun,  4 Aug 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpv6/oJD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7C1CD39;
	Sun,  4 Aug 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722812929; cv=none; b=BwC1IiWoR0i/5iVtGwTPJWimiUQglqH5zsdfuH4cQLVqQc06jf3ke+Bd4dDJ9BtUZ3fqKJ5LXOFjXD0bBhqV3SJkrT7hCftFe3JOoZ4Ig/6NvHaCEMTSbAqc93Kd3YGqfA8z4fcV6kag0P5lQ4WeocjN2WhGeItKb9WKPA+7vZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722812929; c=relaxed/simple;
	bh=uXazAgzWjWMKqAu+LqD+kdrcJ89JiG0q+jN3nJfZ5IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qARj1dULLiCUryz5OffWnmmMVVIOrKlnNvMzOkhDTBgWYYtVsHfeu78f2ePjTeRGht8a3cUmJGiX0UW+yB0yBbxB/BZy4kN8oxrFMCCJlaYuueFj9C7q/x7VbMyx8XS/7aIAMw1DIOntNi0feFBtDkfHagury4wpUJeg8cHfgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpv6/oJD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd855adbso13579701e87.2;
        Sun, 04 Aug 2024 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722812925; x=1723417725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCY7+immcdfucaqPpVVcufb9QtsyrZSj4oLGCzgBHLc=;
        b=Hpv6/oJDVd6gkSprISVSg+poED8ShoIkNVqMKNDRyLY3AxtQQpIttw44W+s9+zO+Pt
         vN5k6If8uk4SnaW0DJjn/AV6vHasJQEkXeKPvGYbBfmX1iYtGIZHIemXWeXLLmDB1WF2
         Rf7Y8ryrqgM0TCegiwFe4cB9Umtr56PO7cJ6LiMnxN491rM/dgNcC8zYGfljgMnNsbnE
         DNZkG+PeUU1zLGyPl+ygEpn3VMuW+BRZR5gELSTXksScr7AYkkaNweiZ14bX09R67ufM
         Cg5AEifHJrgOg5zWAJE2mWtrCJpLgtbzEVcQ9vDZIWlFtDjud6b72GAmbuBfg2CG6DiW
         /Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722812925; x=1723417725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCY7+immcdfucaqPpVVcufb9QtsyrZSj4oLGCzgBHLc=;
        b=wqy9VGcwQTqKOm0Enov251pfOh3kpINMf3v2yxTJ3Ol18W2B9bIne5ETf3u647eHSD
         vufdnKjbt1nL7fM3cGhSTGv/9dAOH7DZlDcMNGrLfeYfjjpBfXZ83+BQszCAOr03OHEx
         WuCG9+zkDRWcBF856mmJFnu67wcMv6qtDAo7hyEWmT+h6nZ0OCGpuKAC11KBa9jDvtWI
         /OEhMHj/tA2MLSwF+vOtSF+JvIQnnlhgSIslpryzTq5cdi/dqKjr7Jk90IBLnB/znY1h
         xxga8oJygzEzUNFZWWPZmonsefYxU9vCfB8Z6NbWfLqb2MNny4eUNpNpbXvUk18H+4uc
         DIYA==
X-Forwarded-Encrypted: i=1; AJvYcCV+mabUAydiZB92NoIijRMcITL6ybXu+vYhW37oVIAjFnLqve9HjseOsME7c97IPLJfkplmF89uqVX8vM6K31D6memZGuevyiex7N3t5SMNV2Z5p64k8CozaYZZnP3af69FOxgQGwov2XI=
X-Gm-Message-State: AOJu0YwRSZgs4Zvlqzk0IMxIZfrcU9nEFVLma1BvMeziUgVG5gChJOrz
	MuHOQPBI+ygwMZN70OU13s5r9956o9c1RbX+K2rdOInx3aKSOdkE
X-Google-Smtp-Source: AGHT+IHmEWVBI3me/pCVCsfPcC+RDADzrbSHnI3s71UcHhG45q8rQPSrk9bO0V1usbJdYGJnKZlY9g==
X-Received: by 2002:a05:6512:b1f:b0:52e:9d6c:4462 with SMTP id 2adb3069b0e04-530bb3797d6mr6735102e87.23.1722812925024;
        Sun, 04 Aug 2024 16:08:45 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7266sm378753366b.196.2024.08.04.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:08:44 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: Add thermal sensor driver for Surface Aggregator Module
Date: Mon,  5 Aug 2024 01:08:29 +0200
Message-ID: <20240804230832.247852-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the newer Microsoft Surface devices (such as the Surface Book
3 and Pro 9) have thermal sensors connected via the Surface Aggregator
Module (the embedded controller on those devices). Add a basic driver
to read out the temperature values of those sensors.

The EC can have up to 16 thermal sensors connected via a single
sub-device, each providing temperature readings and a label string.

Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Co-developed-by: Ivor Wanders <ivor@iwanders.net>
Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

---

Links:
 - v1: https://lore.kernel.org/linux-kernel/ee8c39ab-d47a-481d-a19c-1d656519e66d@gmail.com

Changes in v2:
 - Drop patch 0003 ("platform/surface: aggregator_registry: Add support
   for thermal sensors on the Surface Pro 9") as it has already been
   applied.
 - Squash patches 0001 ("hwmon: Add thermal sensor driver for Surface
   Aggregator Module") and 0002 ("hwmon: surface_temp: Add support for
   sensor names") into a single patch.
 - Replace usage of WARN_ON() with dev_err().
 - Fix formatting and (strict) checkpatch complaints.

---
 MAINTAINERS                  |   6 +
 drivers/hwmon/Kconfig        |  10 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/surface_temp.c | 235 +++++++++++++++++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 drivers/hwmon/surface_temp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..39c61db0169c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15200,6 +15200,12 @@ S:	Maintained
 F:	Documentation/hwmon/surface_fan.rst
 F:	drivers/hwmon/surface_fan.c
 
+MICROSOFT SURFACE SENSOR THERMAL DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/surface_temp.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..70c6385f0ed6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
 
 	  Select M or Y here, if you want to be able to read the fan's speed.
 
+config SENSORS_SURFACE_TEMP
+	tristate "Microsoft Surface Thermal Sensor Driver"
+	depends on SURFACE_AGGREGATOR
+	help
+	  Driver for monitoring thermal sensors connected via the Surface
+	  Aggregator Module (embedded controller) on Microsoft Surface devices.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called surface_temp.
+
 config SENSORS_ADC128D818
 	tristate "Texas Instruments ADC128D818"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..3ce8d6a9202e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -209,6 +209,7 @@ obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_SPD5118)	+= spd5118.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
+obj-$(CONFIG_SENSORS_SURFACE_TEMP)+= surface_temp.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
new file mode 100644
index 000000000000..cd21f331f157
--- /dev/null
+++ b/drivers/hwmon/surface_temp.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Thermal sensor subsystem driver for Surface System Aggregator Module (SSAM).
+ *
+ * Copyright (C) 2022-2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
+
+/* -- SAM interface. -------------------------------------------------------- */
+
+/*
+ * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
+ * presence of a sensor. So we have at most 16 possible sensors/channels.
+ */
+#define SSAM_TMP_SENSOR_MAX_COUNT	16
+
+/*
+ * All names observed so far are 6 characters long, but there's only
+ * zeros after the name, so perhaps they can be longer. This number reflects
+ * the maximum zero-padded space observed in the returned buffer.
+ */
+#define SSAM_TMP_SENSOR_NAME_LENGTH	18
+
+struct ssam_tmp_get_name_rsp {
+	__le16 unknown1;
+	char unknown2;
+	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
+} __packed;
+
+static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
+
+SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x04,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x01,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x0e,
+});
+
+static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
+{
+	__le16 sensors_le;
+	int status;
+
+	status = __ssam_tmp_get_available_sensors(sdev, &sensors_le);
+	if (status)
+		return status;
+
+	*sensors = le16_to_cpu(sensors_le);
+	return 0;
+}
+
+static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temperature)
+{
+	__le16 temp_le;
+	int status;
+
+	status = __ssam_tmp_get_temperature(sdev->ctrl, sdev->uid.target, iid, &temp_le);
+	if (status)
+		return status;
+
+	/* Convert 1/10 °K to 1/1000 °C */
+	*temperature = (le16_to_cpu(temp_le) - 2731) * 100L;
+	return 0;
+}
+
+static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
+{
+	struct ssam_tmp_get_name_rsp name_rsp;
+	int status;
+
+	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
+	if (status)
+		return status;
+
+	/*
+	 * This should not fail unless the name in the returned struct is not
+	 * null-terminated or someone changed something in the struct
+	 * definitions above, since our buffer and struct have the same
+	 * capacity by design. So if this fails, log an error message. Since
+	 * the more likely cause is that the returned string isn't
+	 * null-terminated, we might have received garbage (as opposed to just
+	 * an incomplete string), so also fail the function.
+	 */
+	status = strscpy(buf, name_rsp.name, buf_len);
+	if (status < 0) {
+		dev_err(&sdev->dev, "received non-null-terminated sensor name string\n");
+		return status;
+	}
+
+	return 0;
+}
+
+/* -- Driver.---------------------------------------------------------------- */
+
+struct ssam_temp {
+	struct ssam_device *sdev;
+	s16 sensors;
+	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
+};
+
+static umode_t ssam_temp_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	const struct ssam_temp *ssam_temp = data;
+
+	if (!(ssam_temp->sensors & BIT(channel)))
+		return 0;
+
+	return 0444;
+}
+
+static int ssam_temp_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *value)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
+}
+
+static int ssam_temp_hwmon_read_string(struct device *dev,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel, const char **str)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	*str = ssam_temp->names[channel];
+	return 0;
+}
+
+static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops ssam_temp_hwmon_ops = {
+	.is_visible = ssam_temp_hwmon_is_visible,
+	.read = ssam_temp_hwmon_read,
+	.read_string = ssam_temp_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
+	.ops = &ssam_temp_hwmon_ops,
+	.info = ssam_temp_hwmon_info,
+};
+
+static int ssam_temp_probe(struct ssam_device *sdev)
+{
+	struct ssam_temp *ssam_temp;
+	struct device *hwmon_dev;
+	s16 sensors;
+	int channel;
+	int status;
+
+	status = ssam_tmp_get_available_sensors(sdev, &sensors);
+	if (status)
+		return status;
+
+	ssam_temp = devm_kzalloc(&sdev->dev, sizeof(*ssam_temp), GFP_KERNEL);
+	if (!ssam_temp)
+		return -ENOMEM;
+
+	ssam_temp->sdev = sdev;
+	ssam_temp->sensors = sensors;
+
+	/* Retrieve the name for each available sensor. */
+	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
+		if (!(sensors & BIT(channel)))
+			continue;
+
+		status = ssam_tmp_get_name(sdev, channel + 1, ssam_temp->names[channel],
+					   SSAM_TMP_SENSOR_NAME_LENGTH);
+		if (status)
+			return status;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev, "surface_thermal", ssam_temp,
+							 &ssam_temp_hwmon_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct ssam_device_id ssam_temp_match[] = {
+	{ SSAM_SDEV(TMP, SAM, 0x00, 0x02) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, ssam_temp_match);
+
+static struct ssam_device_driver ssam_temp = {
+	.probe = ssam_temp_probe,
+	.match_table = ssam_temp_match,
+	.driver = {
+		.name = "surface_temp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(ssam_temp);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Thermal sensor subsystem driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.45.2


