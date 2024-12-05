Return-Path: <linux-kernel+bounces-432463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B69E4B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882A2188159A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941317BD6;
	Thu,  5 Dec 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFccknqC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C8CA6F;
	Thu,  5 Dec 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359682; cv=none; b=Sw3QFSnSb0Py/XvCIIxMgDzHmFFe5loFg0nbRqtYvb7c7ndQVLLZMdA6KmkF50yXmv5+M4nCMXTFQO/lsAh1NrOX9ueJ+doliCHzJi40C8NCU+JYVMiVGQBn+bAu7fdXEzhR/Jn7s+Z10TgWAvg6PYjuqp+Wk9y68gOsqC31Phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359682; c=relaxed/simple;
	bh=i28X71/BjYrTnrXL1OTZHZGe56vkJmM/YoI0AmPbEfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv/2krq6eEGDBGP96FE0NISnE6sbgQm7VOILxi7Hrl0V9m+Bg9tTlEPcRFuP6mhVRB/i+CJcMuZ3W7QvYjgm2bXzIbJoxjY/qRGBcGB1NeL8akpFnnlgsGvI66PoniQhQth0E3AOl/WSgkTLOVbkhT3bKqN5Qu04/eK6sPeaMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFccknqC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724f42c1c38so347686b3a.1;
        Wed, 04 Dec 2024 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359679; x=1733964479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhtsuYMPQb007qW0/oMwsYDjLAG0FyJEKs2Ui1unyzo=;
        b=YFccknqCscOMY+PWq7nzcy4oihft7iQXZ7h5tuOe3bv2hhOpgCiDHPk+bDzh6KZTMv
         pp9CSQe2poL5syi9M/IZgCeCijRZTII6yFLp+rNWCz2ANviydXBBuRJDpfz6sVQS8OZd
         8VTE3E9QCJkpbgRvrQ7q2vQgFNW1q8akVmWMa1tHDfPAtjpPHn71JZtjEgYLWe/ebiup
         WQYKkIo3pKPvLAzWHML4XLaXC8aLH3L7yzNdPv/OHpXTRW319GxrOI/4wsAZb8vis83s
         3EX1LLQCAk01GXuB6mpNAaECjqG1cW0rJtAP7OxB/elvBERSC8BYQRw4+hFzQNmwUnwP
         KHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359679; x=1733964479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhtsuYMPQb007qW0/oMwsYDjLAG0FyJEKs2Ui1unyzo=;
        b=Pqfu7S7F8SlWfYExSi2ibRHLWKxEh9eNRWoxhT7iU7EdeR9Wx0GE4+4RqE9aVRCGlB
         F2qH7uTIz8eaFNL7jF4S9sXzLL2tFp9TqungFhyCfkSJbQaPTm///xxQUhg7MV4rkAF8
         NBzZ6qFmqpJM67xBa/3PMiwq71AKg+sAxJycKOTcdvrDW7AHsbjh5ZtDO03JgbkwtMxl
         uxSMNX/YcKX0O0xW1rNQedj7KLWnK7wvCbCJElbLqkq6jeUMBMUy8kCDOKONKbswQJmn
         rDKBJZ7xHY4Ww4/7LL/OvEHiOyWG4upodYJFHyoyYpmGSikf4FtVCZYlwn39f7s0yJ/C
         RAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7/Tt9PEhMwbggXdyEYeshinfwmvmKMKuF8XJpNpCeIOnXsj9kRGOkOSLu/xgEpdKzVDTs09hUH3eX+kg=@vger.kernel.org, AJvYcCUJ/BGdr0T+Vv6mTVku8cETVgjxLdnktr9wtPKiD5yGfyJDwxMTrnzNOEYjHxSHH9vQ3DeI7cYJnS6rExEThpo32TRySw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEi7t1zMtXh0BcQYhaeycMh3p6snv0mykZrpGN3aF/mkYWpS/
	A/9fQZd19mJ4GmJ6IJ756wtrO1zaplx5WyIW4itj0Et+S1xOONTy
X-Gm-Gg: ASbGncucsgN7rmLF27dVi0QE2B/bSCIhqzFzSVR4SBOUI1xvgaRIzH8eROIt5i2+YVK
	7Dd8OaltcCM7xkApWztGifl33UPTDhovwjAw+qss1nCCZcZW1mo3mdagBLIUt5feT8o808+3LQO
	0j3vVkybgl0T8TswfPxY5P14gulw2F1ysWiHcjcZ8tvJgr4A6caebIB4jiIinMKnroJhEXkOr4o
	+r3Z5LNKRSClHBlOmHEgLVLJPb1fC5d88Ajso6BwVnSJoaQ6tvf0gf3dGQr272aU4FO0EOYAgMp
	gJZjHw1iwOaQHn3riM0=
X-Google-Smtp-Source: AGHT+IG4PWiSwzvJudmwPhNGdXE0nYN9nI5SGEPi+xvWUXE1pZQl7VlI2Rco53ODmANT/XjUsrEEYg==
X-Received: by 2002:a17:902:e751:b0:215:4b92:2656 with SMTP id d9443c01a7336-215bd10ed5amr122509195ad.31.1733359679050;
        Wed, 04 Dec 2024 16:47:59 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e42752sm1457115ad.55.2024.12.04.16.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:47:58 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 20/21] platform-x86: Split the alienware-wmi module
Date: Wed,  4 Dec 2024 21:47:31 -0300
Message-ID: <20241205004730.2187107-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the alienware-wmi module into three files, which correspond to the
different interfaces this module exposed. The new structure roughly
works like this:

 - alienware-wmi-base.c: Manages DMI quirks and will initialize the
   preferred WMI driver
 - alienware-wmi-alienfx.c: Manages the sysfs interface exposed by the
   "alienware-wmi" platform device
 - alienware-wmi-awcc.c: Manages thermal control methods present on new
   Alienware and Dell devices

These three parts already worked completely independently, so the split
is done seamlessly by copying and pasting.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Makefile            |   2 +
 .../platform/x86/dell/alienware-wmi-alienfx.c | 531 ++++++++++++
 .../platform/x86/dell/alienware-wmi-awcc.c    | 282 +++++++
 .../platform/x86/dell/alienware-wmi-base.c    | 794 ------------------
 4 files changed, 815 insertions(+), 794 deletions(-)
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c

diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 5e7496aeb070..54a592fd6ae6 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -6,6 +6,8 @@
 
 obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
 alienware-wmi-objs			:= alienware-wmi-base.o
+alienware-wmi-y				+= alienware-wmi-alienfx.o
+alienware-wmi-y				+= alienware-wmi-awcc.o
 obj-$(CONFIG_DCDBAS)			+= dcdbas.o
 obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
 obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
diff --git a/drivers/platform/x86/dell/alienware-wmi-alienfx.c b/drivers/platform/x86/dell/alienware-wmi-alienfx.c
new file mode 100644
index 000000000000..d0291d1ba9bb
--- /dev/null
+++ b/drivers/platform/x86/dell/alienware-wmi-alienfx.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Alienware AlienFX control
+ *
+ * Copyright (C) 2014 Dell Inc <Dell.Client.Kernel@dell.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/wmi.h>
+#include "alienware-wmi.h"
+
+struct wmax_basic_args {
+	u8 arg;
+};
+
+/*
+ * Helpers used for zone control
+ */
+static int parse_rgb(const char *buf, struct color_platform *colors)
+{
+	long unsigned int rgb;
+	int ret;
+	union color_union {
+		struct color_platform cp;
+		int package;
+	} repackager;
+
+	ret = kstrtoul(buf, 16, &rgb);
+	if (ret)
+		return ret;
+
+	/* RGB triplet notation is 24-bit hexadecimal */
+	if (rgb > 0xFFFFFF)
+		return -EINVAL;
+
+	repackager.package = rgb & 0x0f0f0f0f;
+	pr_debug("alienware-wmi: r: %d g:%d b: %d\n",
+		 repackager.cp.red, repackager.cp.green, repackager.cp.blue);
+	*colors = repackager.cp;
+	return 0;
+}
+
+/*
+ * Individual RGB zone control
+ */
+static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
+			 char *buf, u8 location)
+{
+	struct alienfx_priv *priv;
+	struct color_platform *colors;
+
+	priv = dev_get_drvdata(dev);
+	colors = &priv->colors[location];
+
+	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
+		       colors->red, colors->green, colors->blue);
+
+}
+
+static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count, u8 location)
+{
+	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
+	struct color_platform *colors;
+	int ret;
+
+	priv = dev_get_drvdata(dev);
+	pdata = dev_get_platdata(dev);
+
+	colors = &priv->colors[location];
+	ret = parse_rgb(buf, colors);
+	if (ret)
+		return ret;
+
+	ret = pdata->ops.upd_led(priv, pdata->wdev, location);
+
+	return ret ? ret : count;
+}
+
+#define ALIENWARE_ZONE_SHOW_FUNC(_num)					\
+	static ssize_t zone0##_num##_show(struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		return zone_show(dev, attr, buf, _num);			\
+	}
+
+#define ALIENWARE_ZONE_STORE_FUNC(_num)					\
+	static ssize_t zone0##_num##_store(struct device *dev,		\
+					struct device_attribute *attr,	\
+					const char *buf, size_t count)	\
+	{								\
+		return zone_set(dev, attr, buf, count, _num);		\
+	}
+
+#define ALIENWARE_ZONE_ATTR(_num)					\
+	ALIENWARE_ZONE_SHOW_FUNC(_num)					\
+	ALIENWARE_ZONE_STORE_FUNC(_num)					\
+	static DEVICE_ATTR_RW(zone0##_num)
+
+ALIENWARE_ZONE_ATTR(0);
+ALIENWARE_ZONE_ATTR(1);
+ALIENWARE_ZONE_ATTR(2);
+ALIENWARE_ZONE_ATTR(3);
+
+/*
+ * Lighting control state device attribute (Global)
+ */
+static ssize_t lighting_control_state_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct alienfx_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+
+	if (priv->lighting_control_state == LEGACY_BOOTING)
+		return sysfs_emit(buf, "[booting] running suspend\n");
+	else if (priv->lighting_control_state == LEGACY_SUSPEND)
+		return sysfs_emit(buf, "booting running [suspend]\n");
+	return sysfs_emit(buf, "booting [running] suspend\n");
+}
+
+static ssize_t lighting_control_state_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
+	u8 val;
+
+	priv = dev_get_drvdata(dev);
+	pdata = dev_get_platdata(dev);
+
+	if (strcmp(buf, "booting\n") == 0)
+		val = LEGACY_BOOTING;
+	else if (strcmp(buf, "suspend\n") == 0)
+		val = LEGACY_SUSPEND;
+	else
+		val = pdata->running_code;
+
+	priv->lighting_control_state = val;
+	pr_debug("alienware-wmi: updated control state to %d\n",
+		 priv->lighting_control_state);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(lighting_control_state);
+
+static umode_t zone_attr_visible(struct kobject *kobj,
+				 struct attribute *attr, int n)
+{
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return n < pdata->num_zones + 1 ? 0644 : 0;
+}
+
+static bool zone_group_visible(struct kobject *kobj)
+{
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->num_zones > 0;
+}
+DEFINE_SYSFS_GROUP_VISIBLE(zone);
+
+static struct attribute *zone_attrs[] = {
+	&dev_attr_lighting_control_state.attr,
+	&dev_attr_zone00.attr,
+	&dev_attr_zone01.attr,
+	&dev_attr_zone02.attr,
+	&dev_attr_zone03.attr,
+	NULL
+};
+
+static struct attribute_group zone_attribute_group = {
+	.name = "rgb_zones",
+	.is_visible = SYSFS_GROUP_VISIBLE(zone),
+	.attrs = zone_attrs,
+};
+
+/*
+ * LED Brightness (Global)
+ */
+static void global_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
+	int ret;
+
+	priv = container_of(led_cdev, struct alienfx_priv, global_led);
+	pdata = dev_get_platdata(&priv->pdev->dev);
+
+	priv->global_brightness = brightness;
+
+	ret = pdata->ops.upd_brightness(priv, pdata->wdev, brightness);
+	if (ret)
+		pr_err("LED brightness update failed\n");
+}
+
+static enum led_brightness global_led_get(struct led_classdev *led_cdev)
+{
+	struct alienfx_priv *priv;
+
+	priv = container_of(led_cdev, struct alienfx_priv, global_led);
+
+	return priv->global_brightness;
+}
+
+/*
+ *	The HDMI mux sysfs node indicates the status of the HDMI input mux.
+ *	It can toggle between standard system GPU output and HDMI input.
+ */
+static ssize_t show_hdmi_cable(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	u32 out_data;
+	struct wmax_basic_args in_args = {
+		.arg = 0,
+	};
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_CABLE,
+				       &in_args, sizeof(in_args), &out_data);
+
+	if (ACPI_SUCCESS(status)) {
+		if (out_data == 0)
+			return sysfs_emit(buf, "[unconnected] connected unknown\n");
+		else if (out_data == 1)
+			return sysfs_emit(buf, "unconnected [connected] unknown\n");
+	}
+	pr_err("alienware-wmi: unknown HDMI cable status: %d\n", status);
+	return sysfs_emit(buf, "unconnected connected [unknown]\n");
+}
+
+static ssize_t show_hdmi_source(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	u32 out_data;
+	struct wmax_basic_args in_args = {
+		.arg = 0,
+	};
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_STATUS,
+				       &in_args, sizeof(in_args), &out_data);
+
+	if (ACPI_SUCCESS(status)) {
+		if (out_data == 1)
+			return sysfs_emit(buf, "[input] gpu unknown\n");
+		else if (out_data == 2)
+			return sysfs_emit(buf, "input [gpu] unknown\n");
+	}
+	pr_err("alienware-wmi: unknown HDMI source status: %u\n", status);
+	return sysfs_emit(buf, "input gpu [unknown]\n");
+}
+
+static ssize_t toggle_hdmi_source(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	struct wmax_basic_args args;
+
+	pdata = dev_get_platdata(dev);
+
+	if (strcmp(buf, "gpu\n") == 0)
+		args.arg = 1;
+	else if (strcmp(buf, "input\n") == 0)
+		args.arg = 2;
+	else
+		args.arg = 3;
+	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_SOURCE,
+				       &args, sizeof(args), NULL);
+
+	if (ACPI_FAILURE(status))
+		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
+		       status);
+	return count;
+}
+
+static DEVICE_ATTR(cable, S_IRUGO, show_hdmi_cable, NULL);
+static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
+		   toggle_hdmi_source);
+
+static bool hdmi_group_visible(struct kobject *kobj)
+{
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->hdmi_mux;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
+
+static struct attribute *hdmi_attrs[] = {
+	&dev_attr_cable.attr,
+	&dev_attr_source.attr,
+	NULL,
+};
+
+static const struct attribute_group hdmi_attribute_group = {
+	.name = "hdmi",
+	.is_visible = SYSFS_GROUP_VISIBLE(hdmi),
+	.attrs = hdmi_attrs,
+};
+
+/*
+ * Alienware GFX amplifier support
+ * - Currently supports reading cable status
+ * - Leaving expansion room to possibly support dock/undock events later
+ */
+static ssize_t show_amplifier_status(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	u32 out_data;
+	struct wmax_basic_args in_args = {
+		.arg = 0,
+	};
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_AMPLIFIER_CABLE,
+				       &in_args, sizeof(in_args), &out_data);
+	if (ACPI_SUCCESS(status)) {
+		if (out_data == 0)
+			return sysfs_emit(buf, "[unconnected] connected unknown\n");
+		else if (out_data == 1)
+			return sysfs_emit(buf, "unconnected [connected] unknown\n");
+	}
+	pr_err("alienware-wmi: unknown amplifier cable status: %d\n", status);
+	return sysfs_emit(buf, "unconnected connected [unknown]\n");
+}
+
+static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
+
+static bool amplifier_group_visible(struct kobject *kobj)
+{
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->amplifier;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
+
+static struct attribute *amplifier_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static const struct attribute_group amplifier_attribute_group = {
+	.name = "amplifier",
+	.is_visible = SYSFS_GROUP_VISIBLE(amplifier),
+	.attrs = amplifier_attrs,
+};
+
+/*
+ * Deep Sleep Control support
+ * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
+ */
+static ssize_t show_deepsleep_status(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	u32 out_data;
+	struct wmax_basic_args in_args = {
+		.arg = 0,
+	};
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_STATUS,
+				       &in_args, sizeof(in_args), &out_data);
+	if (ACPI_SUCCESS(status)) {
+		if (out_data == 0)
+			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
+		else if (out_data == 1)
+			return sysfs_emit(buf, "disabled [s5] s5_s4\n");
+		else if (out_data == 2)
+			return sysfs_emit(buf, "disabled s5 [s5_s4]\n");
+	}
+	pr_err("alienware-wmi: unknown deep sleep status: %d\n", status);
+	return sysfs_emit(buf, "disabled s5 s5_s4 [unknown]\n");
+}
+
+static ssize_t toggle_deepsleep(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct alienfx_platdata *pdata;
+	acpi_status status;
+	struct wmax_basic_args args;
+
+	pdata = dev_get_platdata(dev);
+
+	if (strcmp(buf, "disabled\n") == 0)
+		args.arg = 0;
+	else if (strcmp(buf, "s5\n") == 0)
+		args.arg = 1;
+	else
+		args.arg = 2;
+	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_CONTROL,
+				       &args, sizeof(args), NULL);
+
+	if (ACPI_FAILURE(status))
+		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
+			status);
+	return count;
+}
+
+static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_deepsleep);
+
+static bool deepsleep_group_visible(struct kobject *kobj)
+{
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->deepslp;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
+
+static struct attribute *deepsleep_attrs[] = {
+	&dev_attr_deepsleep.attr,
+	NULL,
+};
+
+static const struct attribute_group deepsleep_attribute_group = {
+	.name = "deepsleep",
+	.is_visible = SYSFS_GROUP_VISIBLE(deepsleep),
+	.attrs = deepsleep_attrs,
+};
+
+/*
+ * Platform Driver
+ */
+static int alienfx_probe(struct platform_device *pdev)
+{
+	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
+	struct led_classdev *leds;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	platform_set_drvdata(pdev, priv);
+
+	priv->pdev = pdev;
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	priv->lighting_control_state = pdata->running_code;
+
+	leds = &priv->global_led;
+	leds->name = "alienware::global_brightness";
+	leds->brightness_set = global_led_set;
+	leds->brightness_get = global_led_get;
+	leds->max_brightness = 0x0F;
+
+	priv->global_brightness = priv->global_led.max_brightness;
+
+	return devm_led_classdev_register(&pdev->dev, &priv->global_led);
+}
+
+static const struct attribute_group *alienfx_groups[] = {
+	&zone_attribute_group,
+	&hdmi_attribute_group,
+	&amplifier_attribute_group,
+	&deepsleep_attribute_group,
+	NULL
+};
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "alienware-wmi",
+		.dev_groups = alienfx_groups,
+	},
+	.probe = alienfx_probe,
+};
+
+int alienfx_wmi_init(struct alienfx_platdata *pdata)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_create_bundle(&platform_driver, alienfx_probe, NULL, 0,
+				      pdata, sizeof(*pdata));
+
+	dev_set_drvdata(&pdata->wdev->dev, pdev);
+
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+void alienfx_wmi_exit(struct wmi_device *wdev)
+{
+	struct platform_device *pdev;
+
+	pdev = dev_get_drvdata(&wdev->dev);
+
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&platform_driver);
+}
diff --git a/drivers/platform/x86/dell/alienware-wmi-awcc.c b/drivers/platform/x86/dell/alienware-wmi-awcc.c
new file mode 100644
index 000000000000..115ef8436ae3
--- /dev/null
+++ b/drivers/platform/x86/dell/alienware-wmi-awcc.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Alienware AlienFX control
+ *
+ * Copyright (C) 2024 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/platform_device.h>
+#include <linux/platform_profile.h>
+#include <linux/wmi.h>
+#include "alienware-wmi.h"
+
+#define WMAX_METHOD_THERMAL_INFORMATION	0x14
+#define WMAX_METHOD_THERMAL_CONTROL	0x15
+#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
+
+#define WMAX_THERMAL_MODE_GMODE		0xAB
+
+#define WMAX_FAILURE_CODE		0xFFFFFFFF
+#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
+#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
+#define WMAX_SENSOR_ID_MASK		BIT(8)
+
+enum WMAX_THERMAL_INFORMATION_OPERATIONS {
+	WMAX_OPERATION_SYS_DESCRIPTION		= 0x02,
+	WMAX_OPERATION_LIST_IDS			= 0x03,
+	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
+};
+
+enum WMAX_THERMAL_CONTROL_OPERATIONS {
+	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
+};
+
+enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
+	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
+	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
+};
+
+enum WMAX_THERMAL_TABLES {
+	WMAX_THERMAL_TABLE_BASIC		= 0x90,
+	WMAX_THERMAL_TABLE_USTT			= 0xA0,
+};
+
+static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
+	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
+	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
+	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
+	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
+};
+
+struct wmax_u32_args {
+	u8 operation;
+	u8 arg1;
+	u8 arg2;
+	u8 arg3;
+};
+
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
+static bool is_wmax_thermal_code(u32 code)
+{
+	if (code & WMAX_SENSOR_ID_MASK)
+		return false;
+
+	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
+		return false;
+
+	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
+	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_QUIET)
+		return true;
+
+	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
+	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
+		return true;
+
+	return false;
+}
+
+static int wmax_thermal_information(struct wmi_device *wdev, u8 operation,
+				    u8 arg, u32 *out_data)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = operation,
+		.arg1 = arg,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_INFORMATION,
+				       &in_args, sizeof(in_args), out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (*out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
+		.arg1 = profile,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+	u32 out_data;
+
+	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_CONTROL,
+				       &in_args, sizeof(in_args), &out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (out_data == WMAX_FAILURE_CODE)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation,
+				  u32 *out_data)
+{
+	acpi_status status;
+	struct wmax_u32_args in_args = {
+		.operation = operation,
+		.arg1 = 0,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+	status = alienware_wmi_command(wdev, WMAX_METHOD_GAME_SHIFT_STATUS,
+				       &in_args, sizeof(in_args), out_data);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (*out_data == WMAX_FAILURE_CODE)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int thermal_profile_get(struct platform_profile_handler *pprof,
+			       enum platform_profile_option *profile)
+{
+	struct awcc_priv *priv;
+	u32 out_data;
+	int ret;
+
+	priv = container_of(pprof, struct awcc_priv, pp_handler);
+
+	ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_CURRENT_PROFILE,
+				       0, &out_data);
+
+	if (ret < 0)
+		return ret;
+
+	if (out_data == WMAX_THERMAL_MODE_GMODE) {
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		return 0;
+	}
+
+	if (!is_wmax_thermal_code(out_data))
+		return -ENODATA;
+
+	out_data &= WMAX_THERMAL_MODE_MASK;
+	*profile = wmax_mode_to_platform_profile[out_data];
+
+	return 0;
+}
+
+static int thermal_profile_set(struct platform_profile_handler *pprof,
+			       enum platform_profile_option profile)
+{
+	struct awcc_priv *priv;
+
+	priv = container_of(pprof, struct awcc_priv, pp_handler);
+
+	if (priv->has_gmode) {
+		u32 gmode_status;
+		int ret;
+
+		ret = wmax_game_shift_status(priv->wdev,
+					     WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+					     &gmode_status);
+
+		if (ret < 0)
+			return ret;
+
+		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
+		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
+			ret = wmax_game_shift_status(priv->wdev,
+						     WMAX_OPERATION_TOGGLE_GAME_SHIFT,
+						     &gmode_status);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return wmax_thermal_control(priv->wdev,
+				    priv->supported_thermal_profiles[profile]);
+}
+
+int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
+{
+	struct awcc_priv *priv;
+	u32 out_data;
+	u8 sys_desc[4];
+	u32 first_mode;
+	enum wmax_thermal_mode mode;
+	enum platform_profile_option profile;
+	int ret;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->wdev = wdev;
+
+	ret = wmax_thermal_information(wdev, WMAX_OPERATION_SYS_DESCRIPTION,
+				       0, (u32 *) &sys_desc);
+	if (ret < 0)
+		return ret;
+
+	first_mode = sys_desc[0] + sys_desc[1];
+
+	for (u32 i = 0; i < sys_desc[3]; i++) {
+		ret = wmax_thermal_information(wdev, WMAX_OPERATION_LIST_IDS,
+					       i + first_mode, &out_data);
+
+		if (ret == -EIO)
+			return ret;
+
+		if (ret == -EBADRQC)
+			break;
+
+		if (!is_wmax_thermal_code(out_data))
+			continue;
+
+		mode = out_data & WMAX_THERMAL_MODE_MASK;
+		profile = wmax_mode_to_platform_profile[mode];
+		priv->supported_thermal_profiles[profile] = out_data;
+
+		set_bit(profile, priv->pp_handler.choices);
+	}
+
+	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
+		return -ENODEV;
+
+	if (has_gmode) {
+		priv->has_gmode = true;
+		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+			WMAX_THERMAL_MODE_GMODE;
+
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->pp_handler.choices);
+	}
+
+	priv->pp_handler.profile_get = thermal_profile_get;
+	priv->pp_handler.profile_set = thermal_profile_set;
+
+	return platform_profile_register(&priv->pp_handler);
+}
+
+void remove_thermal_profile(void)
+{
+	platform_profile_remove();
+}
diff --git a/drivers/platform/x86/dell/alienware-wmi-base.c b/drivers/platform/x86/dell/alienware-wmi-base.c
index 4165eb0d0bf5..7cc6bb3dc0d7 100644
--- a/drivers/platform/x86/dell/alienware-wmi-base.c
+++ b/drivers/platform/x86/dell/alienware-wmi-base.c
@@ -8,24 +8,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
-#include <linux/bitfield.h>
-#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/platform_profile.h>
 #include <linux/dmi.h>
-#include <linux/leds.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
 
-#define WMAX_METHOD_THERMAL_INFORMATION	0x14
-#define WMAX_METHOD_THERMAL_CONTROL	0x15
-#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
-
-#define WMAX_THERMAL_MODE_GMODE		0xAB
-
-#define WMAX_FAILURE_CODE		0xFFFFFFFF
-
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
 MODULE_LICENSE("GPL");
@@ -43,39 +31,6 @@ enum INTERFACE_FLAGS {
 	WMAX,
 };
 
-enum WMAX_THERMAL_INFORMATION_OPERATIONS {
-	WMAX_OPERATION_SYS_DESCRIPTION		= 0x02,
-	WMAX_OPERATION_LIST_IDS			= 0x03,
-	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
-};
-
-enum WMAX_THERMAL_CONTROL_OPERATIONS {
-	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
-};
-
-enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
-	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
-	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
-};
-
-enum WMAX_THERMAL_TABLES {
-	WMAX_THERMAL_TABLE_BASIC		= 0x90,
-	WMAX_THERMAL_TABLE_USTT			= 0xA0,
-};
-
-static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
-	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
-	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
-	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
-	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
-	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
-	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
-	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
-	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
-};
-
 struct quirk_entry {
 	u8 num_zones;
 	u8 hdmi_mux;
@@ -332,17 +287,6 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 	{}
 };
 
-struct wmax_basic_args {
-	u8 arg;
-};
-
-struct wmax_u32_args {
-	u8 operation;
-	u8 arg1;
-	u8 arg2;
-	u8 arg3;
-};
-
 static u8 interface;
 static struct wmi_driver *preferred_wmi_driver;
 
@@ -372,744 +316,6 @@ acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
 	return ret;
 }
 
-/*
- * Helpers used for zone control
- */
-static int parse_rgb(const char *buf, struct color_platform *colors)
-{
-	long unsigned int rgb;
-	int ret;
-	union color_union {
-		struct color_platform cp;
-		int package;
-	} repackager;
-
-	ret = kstrtoul(buf, 16, &rgb);
-	if (ret)
-		return ret;
-
-	/* RGB triplet notation is 24-bit hexadecimal */
-	if (rgb > 0xFFFFFF)
-		return -EINVAL;
-
-	repackager.package = rgb & 0x0f0f0f0f;
-	pr_debug("alienware-wmi: r: %d g:%d b: %d\n",
-		 repackager.cp.red, repackager.cp.green, repackager.cp.blue);
-	*colors = repackager.cp;
-	return 0;
-}
-
-/*
- * Individual RGB zone control
- */
-static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
-			 char *buf, u8 location)
-{
-	struct alienfx_priv *priv;
-	struct color_platform *colors;
-
-	priv = dev_get_drvdata(dev);
-	colors = &priv->colors[location];
-
-	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
-		       colors->red, colors->green, colors->blue);
-
-}
-
-static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count, u8 location)
-{
-	struct alienfx_priv *priv;
-	struct alienfx_platdata *pdata;
-	struct color_platform *colors;
-	int ret;
-
-	priv = dev_get_drvdata(dev);
-	pdata = dev_get_platdata(dev);
-
-	colors = &priv->colors[location];
-	ret = parse_rgb(buf, colors);
-	if (ret)
-		return ret;
-
-	ret = pdata->ops.upd_led(priv, pdata->wdev, location);
-
-	return ret ? ret : count;
-}
-
-#define ALIENWARE_ZONE_SHOW_FUNC(_num)					\
-	static ssize_t zone0##_num##_show(struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
-	{								\
-		return zone_show(dev, attr, buf, _num);			\
-	}
-
-#define ALIENWARE_ZONE_STORE_FUNC(_num)					\
-	static ssize_t zone0##_num##_store(struct device *dev,		\
-					struct device_attribute *attr,	\
-					const char *buf, size_t count)	\
-	{								\
-		return zone_set(dev, attr, buf, count, _num);		\
-	}
-
-#define ALIENWARE_ZONE_ATTR(_num)					\
-	ALIENWARE_ZONE_SHOW_FUNC(_num)					\
-	ALIENWARE_ZONE_STORE_FUNC(_num)					\
-	static DEVICE_ATTR_RW(zone0##_num)
-
-ALIENWARE_ZONE_ATTR(0);
-ALIENWARE_ZONE_ATTR(1);
-ALIENWARE_ZONE_ATTR(2);
-ALIENWARE_ZONE_ATTR(3);
-
-/*
- * Lighting control state device attribute (Global)
- */
-static ssize_t lighting_control_state_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct alienfx_priv *priv;
-
-	priv = dev_get_drvdata(dev);
-
-	if (priv->lighting_control_state == LEGACY_BOOTING)
-		return sysfs_emit(buf, "[booting] running suspend\n");
-	else if (priv->lighting_control_state == LEGACY_SUSPEND)
-		return sysfs_emit(buf, "booting running [suspend]\n");
-	return sysfs_emit(buf, "booting [running] suspend\n");
-}
-
-static ssize_t lighting_control_state_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t count)
-{
-	struct alienfx_priv *priv;
-	struct alienfx_platdata *pdata;
-	u8 val;
-
-	priv = dev_get_drvdata(dev);
-	pdata = dev_get_platdata(dev);
-
-	if (strcmp(buf, "booting\n") == 0)
-		val = LEGACY_BOOTING;
-	else if (strcmp(buf, "suspend\n") == 0)
-		val = LEGACY_SUSPEND;
-	else
-		val = pdata->running_code;
-
-	priv->lighting_control_state = val;
-	pr_debug("alienware-wmi: updated control state to %d\n",
-		 priv->lighting_control_state);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(lighting_control_state);
-
-static umode_t zone_attr_visible(struct kobject *kobj,
-				 struct attribute *attr, int n)
-{
-	struct device *dev;
-	struct alienfx_platdata *pdata;
-
-	dev = container_of(kobj, struct device, kobj);
-	pdata = dev_get_platdata(dev);
-
-	return n < pdata->num_zones + 1 ? 0644 : 0;
-}
-
-static bool zone_group_visible(struct kobject *kobj)
-{
-	struct device *dev;
-	struct alienfx_platdata *pdata;
-
-	dev = container_of(kobj, struct device, kobj);
-	pdata = dev_get_platdata(dev);
-
-	return pdata->num_zones > 0;
-}
-DEFINE_SYSFS_GROUP_VISIBLE(zone);
-
-static struct attribute *zone_attrs[] = {
-	&dev_attr_lighting_control_state.attr,
-	&dev_attr_zone00.attr,
-	&dev_attr_zone01.attr,
-	&dev_attr_zone02.attr,
-	&dev_attr_zone03.attr,
-	NULL
-};
-
-static struct attribute_group zone_attribute_group = {
-	.name = "rgb_zones",
-	.is_visible = SYSFS_GROUP_VISIBLE(zone),
-	.attrs = zone_attrs,
-};
-
-/*
- * LED Brightness (Global)
- */
-static void global_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
-{
-	struct alienfx_priv *priv;
-	struct alienfx_platdata *pdata;
-	int ret;
-
-	priv = container_of(led_cdev, struct alienfx_priv, global_led);
-	pdata = dev_get_platdata(&priv->pdev->dev);
-
-	priv->global_brightness = brightness;
-
-	ret = pdata->ops.upd_brightness(priv, pdata->wdev, brightness);
-	if (ret)
-		pr_err("LED brightness update failed\n");
-}
-
-static enum led_brightness global_led_get(struct led_classdev *led_cdev)
-{
-	struct alienfx_priv *priv;
-
-	priv = container_of(led_cdev, struct alienfx_priv, global_led);
-
-	return priv->global_brightness;
-}
-
-/*
- *	The HDMI mux sysfs node indicates the status of the HDMI input mux.
- *	It can toggle between standard system GPU output and HDMI input.
- */
-static ssize_t show_hdmi_cable(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	u32 out_data;
-	struct wmax_basic_args in_args = {
-		.arg = 0,
-	};
-
-	pdata = dev_get_platdata(dev);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_CABLE,
-				       &in_args, sizeof(in_args), &out_data);
-
-	if (ACPI_SUCCESS(status)) {
-		if (out_data == 0)
-			return sysfs_emit(buf, "[unconnected] connected unknown\n");
-		else if (out_data == 1)
-			return sysfs_emit(buf, "unconnected [connected] unknown\n");
-	}
-	pr_err("alienware-wmi: unknown HDMI cable status: %d\n", status);
-	return sysfs_emit(buf, "unconnected connected [unknown]\n");
-}
-
-static ssize_t show_hdmi_source(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	u32 out_data;
-	struct wmax_basic_args in_args = {
-		.arg = 0,
-	};
-
-	pdata = dev_get_platdata(dev);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_STATUS,
-				       &in_args, sizeof(in_args), &out_data);
-
-	if (ACPI_SUCCESS(status)) {
-		if (out_data == 1)
-			return sysfs_emit(buf, "[input] gpu unknown\n");
-		else if (out_data == 2)
-			return sysfs_emit(buf, "input [gpu] unknown\n");
-	}
-	pr_err("alienware-wmi: unknown HDMI source status: %u\n", status);
-	return sysfs_emit(buf, "input gpu [unknown]\n");
-}
-
-static ssize_t toggle_hdmi_source(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	struct wmax_basic_args args;
-
-	pdata = dev_get_platdata(dev);
-
-	if (strcmp(buf, "gpu\n") == 0)
-		args.arg = 1;
-	else if (strcmp(buf, "input\n") == 0)
-		args.arg = 2;
-	else
-		args.arg = 3;
-	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_SOURCE,
-				       &args, sizeof(args), NULL);
-
-	if (ACPI_FAILURE(status))
-		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
-		       status);
-	return count;
-}
-
-static DEVICE_ATTR(cable, S_IRUGO, show_hdmi_cable, NULL);
-static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
-		   toggle_hdmi_source);
-
-static bool hdmi_group_visible(struct kobject *kobj)
-{
-	struct device *dev;
-	struct alienfx_platdata *pdata;
-
-	dev = container_of(kobj, struct device, kobj);
-	pdata = dev_get_platdata(dev);
-
-	return pdata->hdmi_mux;
-}
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
-
-static struct attribute *hdmi_attrs[] = {
-	&dev_attr_cable.attr,
-	&dev_attr_source.attr,
-	NULL,
-};
-
-static const struct attribute_group hdmi_attribute_group = {
-	.name = "hdmi",
-	.is_visible = SYSFS_GROUP_VISIBLE(hdmi),
-	.attrs = hdmi_attrs,
-};
-
-/*
- * Alienware GFX amplifier support
- * - Currently supports reading cable status
- * - Leaving expansion room to possibly support dock/undock events later
- */
-static ssize_t show_amplifier_status(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	u32 out_data;
-	struct wmax_basic_args in_args = {
-		.arg = 0,
-	};
-
-	pdata = dev_get_platdata(dev);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_AMPLIFIER_CABLE,
-				       &in_args, sizeof(in_args), &out_data);
-	if (ACPI_SUCCESS(status)) {
-		if (out_data == 0)
-			return sysfs_emit(buf, "[unconnected] connected unknown\n");
-		else if (out_data == 1)
-			return sysfs_emit(buf, "unconnected [connected] unknown\n");
-	}
-	pr_err("alienware-wmi: unknown amplifier cable status: %d\n", status);
-	return sysfs_emit(buf, "unconnected connected [unknown]\n");
-}
-
-static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
-
-static bool amplifier_group_visible(struct kobject *kobj)
-{
-	struct device *dev;
-	struct alienfx_platdata *pdata;
-
-	dev = container_of(kobj, struct device, kobj);
-	pdata = dev_get_platdata(dev);
-
-	return pdata->amplifier;
-}
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
-
-static struct attribute *amplifier_attrs[] = {
-	&dev_attr_status.attr,
-	NULL,
-};
-
-static const struct attribute_group amplifier_attribute_group = {
-	.name = "amplifier",
-	.is_visible = SYSFS_GROUP_VISIBLE(amplifier),
-	.attrs = amplifier_attrs,
-};
-
-/*
- * Deep Sleep Control support
- * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
- */
-static ssize_t show_deepsleep_status(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	u32 out_data;
-	struct wmax_basic_args in_args = {
-		.arg = 0,
-	};
-
-	pdata = dev_get_platdata(dev);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_STATUS,
-				       &in_args, sizeof(in_args), &out_data);
-	if (ACPI_SUCCESS(status)) {
-		if (out_data == 0)
-			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
-		else if (out_data == 1)
-			return sysfs_emit(buf, "disabled [s5] s5_s4\n");
-		else if (out_data == 2)
-			return sysfs_emit(buf, "disabled s5 [s5_s4]\n");
-	}
-	pr_err("alienware-wmi: unknown deep sleep status: %d\n", status);
-	return sysfs_emit(buf, "disabled s5 s5_s4 [unknown]\n");
-}
-
-static ssize_t toggle_deepsleep(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	struct alienfx_platdata *pdata;
-	acpi_status status;
-	struct wmax_basic_args args;
-
-	pdata = dev_get_platdata(dev);
-
-	if (strcmp(buf, "disabled\n") == 0)
-		args.arg = 0;
-	else if (strcmp(buf, "s5\n") == 0)
-		args.arg = 1;
-	else
-		args.arg = 2;
-	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
-
-	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_CONTROL,
-				       &args, sizeof(args), NULL);
-
-	if (ACPI_FAILURE(status))
-		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
-			status);
-	return count;
-}
-
-static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_deepsleep);
-
-static bool deepsleep_group_visible(struct kobject *kobj)
-{
-	struct device *dev;
-	struct alienfx_platdata *pdata;
-
-	dev = container_of(kobj, struct device, kobj);
-	pdata = dev_get_platdata(dev);
-
-	return pdata->deepslp;
-}
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
-
-static struct attribute *deepsleep_attrs[] = {
-	&dev_attr_deepsleep.attr,
-	NULL,
-};
-
-static const struct attribute_group deepsleep_attribute_group = {
-	.name = "deepsleep",
-	.is_visible = SYSFS_GROUP_VISIBLE(deepsleep),
-	.attrs = deepsleep_attrs,
-};
-
-/*
- * Thermal Profile control
- *  - Provides thermal profile control through the Platform Profile API
- */
-#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
-#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
-#define WMAX_SENSOR_ID_MASK		BIT(8)
-
-static bool is_wmax_thermal_code(u32 code)
-{
-	if (code & WMAX_SENSOR_ID_MASK)
-		return false;
-
-	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
-		return false;
-
-	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
-	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_QUIET)
-		return true;
-
-	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
-	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
-		return true;
-
-	return false;
-}
-
-static int wmax_thermal_information(struct wmi_device *wdev, u8 operation,
-				    u8 arg, u32 *out_data)
-{
-	acpi_status status;
-	struct wmax_u32_args in_args = {
-		.operation = operation,
-		.arg1 = arg,
-		.arg2 = 0,
-		.arg3 = 0,
-	};
-
-	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_INFORMATION,
-				       &in_args, sizeof(in_args), out_data);
-
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	if (*out_data == WMAX_FAILURE_CODE)
-		return -EBADRQC;
-
-	return 0;
-}
-
-static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
-{
-	acpi_status status;
-	struct wmax_u32_args in_args = {
-		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
-		.arg1 = profile,
-		.arg2 = 0,
-		.arg3 = 0,
-	};
-	u32 out_data;
-
-	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_CONTROL,
-				       &in_args, sizeof(in_args), &out_data);
-
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	if (out_data == WMAX_FAILURE_CODE)
-		return -EBADRQC;
-
-	return 0;
-}
-
-static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation,
-				  u32 *out_data)
-{
-	acpi_status status;
-	struct wmax_u32_args in_args = {
-		.operation = operation,
-		.arg1 = 0,
-		.arg2 = 0,
-		.arg3 = 0,
-	};
-
-	status = alienware_wmi_command(wdev, WMAX_METHOD_GAME_SHIFT_STATUS,
-				       &in_args, sizeof(in_args), out_data);
-
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	if (*out_data == WMAX_FAILURE_CODE)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static int thermal_profile_get(struct platform_profile_handler *pprof,
-			       enum platform_profile_option *profile)
-{
-	struct awcc_priv *priv;
-	u32 out_data;
-	int ret;
-
-	priv = container_of(pprof, struct awcc_priv, pp_handler);
-
-	ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_CURRENT_PROFILE,
-				       0, &out_data);
-
-	if (ret < 0)
-		return ret;
-
-	if (out_data == WMAX_THERMAL_MODE_GMODE) {
-		*profile = PLATFORM_PROFILE_PERFORMANCE;
-		return 0;
-	}
-
-	if (!is_wmax_thermal_code(out_data))
-		return -ENODATA;
-
-	out_data &= WMAX_THERMAL_MODE_MASK;
-	*profile = wmax_mode_to_platform_profile[out_data];
-
-	return 0;
-}
-
-static int thermal_profile_set(struct platform_profile_handler *pprof,
-			       enum platform_profile_option profile)
-{
-	struct awcc_priv *priv;
-
-	priv = container_of(pprof, struct awcc_priv, pp_handler);
-
-	if (priv->has_gmode) {
-		u32 gmode_status;
-		int ret;
-
-		ret = wmax_game_shift_status(priv->wdev,
-					     WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
-					     &gmode_status);
-
-		if (ret < 0)
-			return ret;
-
-		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
-		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
-			ret = wmax_game_shift_status(priv->wdev,
-						     WMAX_OPERATION_TOGGLE_GAME_SHIFT,
-						     &gmode_status);
-
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	return wmax_thermal_control(priv->wdev,
-				    priv->supported_thermal_profiles[profile]);
-}
-
-int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
-{
-	struct awcc_priv *priv;
-	u32 out_data;
-	u8 sys_desc[4];
-	u32 first_mode;
-	enum wmax_thermal_mode mode;
-	enum platform_profile_option profile;
-	int ret;
-
-	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
-	dev_set_drvdata(&wdev->dev, priv);
-
-	priv->wdev = wdev;
-
-	ret = wmax_thermal_information(wdev, WMAX_OPERATION_SYS_DESCRIPTION,
-				       0, (u32 *) &sys_desc);
-	if (ret < 0)
-		return ret;
-
-	first_mode = sys_desc[0] + sys_desc[1];
-
-	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = wmax_thermal_information(wdev, WMAX_OPERATION_LIST_IDS,
-					       i + first_mode, &out_data);
-
-		if (ret == -EIO)
-			return ret;
-
-		if (ret == -EBADRQC)
-			break;
-
-		if (!is_wmax_thermal_code(out_data))
-			continue;
-
-		mode = out_data & WMAX_THERMAL_MODE_MASK;
-		profile = wmax_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = out_data;
-
-		set_bit(profile, priv->pp_handler.choices);
-	}
-
-	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
-		return -ENODEV;
-
-	if (has_gmode) {
-		priv->has_gmode = true;
-		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
-			WMAX_THERMAL_MODE_GMODE;
-
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->pp_handler.choices);
-	}
-
-	priv->pp_handler.profile_get = thermal_profile_get;
-	priv->pp_handler.profile_set = thermal_profile_set;
-
-	return platform_profile_register(&priv->pp_handler);
-}
-
-void remove_thermal_profile(void)
-{
-	platform_profile_remove();
-}
-
-/*
- * Platform Driver
- */
-static int alienfx_probe(struct platform_device *pdev)
-{
-	struct alienfx_priv *priv;
-	struct led_classdev *leds;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	platform_set_drvdata(pdev, priv);
-
-	priv->pdev = pdev;
-
-	if (interface == WMAX)
-		priv->lighting_control_state = WMAX_RUNNING;
-	else if (interface == LEGACY)
-		priv->lighting_control_state = LEGACY_RUNNING;
-
-	leds = &priv->global_led;
-	leds->name = "alienware::global_brightness";
-	leds->brightness_set = global_led_set;
-	leds->brightness_get = global_led_get;
-	leds->max_brightness = 0x0F;
-
-	priv->global_brightness = priv->global_led.max_brightness;
-
-	return devm_led_classdev_register(&pdev->dev, &priv->global_led);
-}
-
-static const struct attribute_group *alienfx_groups[] = {
-	&zone_attribute_group,
-	&hdmi_attribute_group,
-	&amplifier_attribute_group,
-	&deepsleep_attribute_group,
-	NULL
-};
-
-static struct platform_driver platform_driver = {
-	.driver = {
-		.name = "alienware-wmi",
-		.dev_groups = alienfx_groups,
-	},
-	.probe = alienfx_probe,
-};
-
-int alienfx_wmi_init(struct alienfx_platdata *pdata)
-{
-	struct platform_device *pdev;
-
-	pdev = platform_create_bundle(&platform_driver, alienfx_probe, NULL, 0,
-				      pdata, sizeof(*pdata));
-
-	dev_set_drvdata(&pdata->wdev->dev, pdev);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-
-void alienfx_wmi_exit(struct wmi_device *wdev)
-{
-	struct platform_device *pdev;
-
-	pdev = dev_get_drvdata(&wdev->dev);
-
-	platform_device_unregister(pdev);
-	platform_driver_unregister(&platform_driver);
-}
-
 /*
  * Legacy WMI device
  */
-- 
2.47.1


