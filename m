Return-Path: <linux-kernel+bounces-353092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158B992852
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A4B2840E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA27199948;
	Mon,  7 Oct 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgzHT2GC"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93A18E055;
	Mon,  7 Oct 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294093; cv=none; b=cXt4c5BWtaarGUXnrmF1fbwI6KtLhUVJGDhAkIWeYwydR+Ey+GVaOh273RhygqJmlN98B4QD+7lL6IXnoTWVHrdhPejpVB+cYwH8tzKwCTOX5XAuKSAT+u3E7Imo/cH5+/9aC7QHsv3PkCEPEpOwL65CsA3aLoRrHOdiXAKQBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294093; c=relaxed/simple;
	bh=4xb1wWkcwTWIcA0EoZfaMm7dn+0ksqt5TMsQFiCRioY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsCnRFjnO5+TD/+H8zwUu+QfGsLE27a98lD43frCH4T6jS2sTfDS0yCMznbf1yfGMfMqHO+qAxUtyV09buqRWMcEnFX0wNX/CH7svQIEV2yCFJrJKfSr+gJWk940uI2n0Dxe/YzUcQvplJw9sp6OD1WlYU260Um6wkUTb/0Zytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgzHT2GC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2933277a12.2;
        Mon, 07 Oct 2024 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728294091; x=1728898891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/yUKosjh6HDH4+w6oxBH3n7uxN0rSo2dJt82OnzDEI=;
        b=LgzHT2GCA3ZgNSIttSPmU+6LJl12lZgNcs3lNDfdvPrvNhKp9W3Ebl5RrKygDNBW2D
         G9jkOppfM9yScSADQ3iYzXZ9vWC9dof/+qVxzSoN964SydYaeOwvi3SR83mD2c9dUp3R
         tDPzwKYHfzYH+l01UYZ9lmHggNz+8hudqSH0eKgThRzBW5y7kVlXQ/oPGXj6VUDQ9U3z
         q1puDQ92J2t2yGQvlrIO5QCmnLbf7LmoV+tS1nay3GD3J5oViISqUkNVHvWmsUslc88s
         DJ7Em0h2MLw+BxelLsjyYn9IqT7vV26K5WomGJfEIqc98M/WirRsCU9QMKxqgUaYTnog
         oFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294091; x=1728898891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/yUKosjh6HDH4+w6oxBH3n7uxN0rSo2dJt82OnzDEI=;
        b=YLobdMItVfWZDJJYtxtqx1CeqtldA0UVRyxqarGPglFThp4Xxc58lLklhBFJfPMIUV
         Ot93ioe7PH1Af4yEtwPaafVL69+2uW9RdAQaT3dWaCKa6KJHicLmj97k7zLj3ohdWzUn
         On8edyIueWBkHipZd3ssEhki9oLGhnVraJMe3gWIBxkpF5TWWrcRvPtoRWgNATifC4lq
         d7V4DrbvZ7okw7gpaSv52p1v4GCjAWNU6ikXiCTekkikJi0wZufLl3JFoy+62lVPdD6q
         t4+keJgdpeATkuaoFZCgCJ/1mG0KAIr+UT55DKH4lU8zfRKGOSuvi28VM4cjPmcbihf7
         TKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgZhjzNB4yGcm0XUFUS1oPso6nijw7i6cHSFL865psLKr21k0MPo7kc3bclz0FzFJ3mcXCU67kFXbGGEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1C0KQVTTVKaosq1oj0ueG+BTUPHGS4thmzGRQpj3duy3yefF
	EZIFLGPIPWyeorHzML0z6cDWODxgYPf0Dp9Jv5pxUmMZSB5k/A0XsDBMzIby
X-Google-Smtp-Source: AGHT+IEBYnzq0PCmiNagBufWkdWis+CklbZD4eQtz4XdzS/5G2N8cw/w59cm9SlDnkE6No2YDRXIhg==
X-Received: by 2002:a05:6a21:1643:b0:1d2:f039:4638 with SMTP id adf61e73a8af0-1d6dfa416f9mr19476697637.23.1728294091008;
        Mon, 07 Oct 2024 02:41:31 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d664aesm4145012b3a.148.2024.10.07.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:41:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH] Dell AWCC platform_profile support
Date: Mon,  7 Oct 2024 06:33:26 -0300
Message-ID: <20241007093324.49631-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds platform_profile support for Dell devices which implement
User Selectable Thermal Tables (USTT) that are meant to be controlled by
Alienware Command Center (AWCC). These devices may include newer Alienware
M-Series, Alienware X-Series and Dell's G-Series. This patch, was tested
by me on an Alienware x15 R1.

It is suspected that Alienware Command Center manages thermal profiles
through the WMI interface, specifically through a device with identifier
\_SB_.AMW1.WMAX. This device was reverse engineered and the relevant
functionality is documented here [1]. This driver interacts with this
WMI device and thus is able to mimic AWCC's thermal profiles functionality
through the platform_profile API. In consequence the user would be able
to set and retrieve thermal profiles, which are just fan speed profiles.

This driver was heavily inspired on inspur_platform_profile, special
thanks.

Notes:
 - Performance (FullSpeed) profile is a special profile which has it's own
   entry in the Firmware Settings of the Alienware x15 R1. It also changes
   the color of the F1 key. I suspect this behavior would be replicated in
   other X-Series or M-Series laptops.
 - G-Mode is a profile documented on [1] which mimics the behavior of
   FullSpeed mode but it does not have an entry on the Firmware Settings of
   the Alienware x15 R1, this may correspond to the G-Mode functionality on
   G-Series laptops (activated by a special button) but I cannot test it. I
   did not include this code in the driver as G-Mode causes unexpected
   behavior on X-Series laptops.

Thanks for your time and patiente in advance.

Regards,

Kurt

[1] https://gist.github.com/kuu-rt/b22328ff2b454be505387e2a38c61ee4

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig         |   9 +
 drivers/platform/x86/dell/Makefile        |   1 +
 drivers/platform/x86/dell/dell-wmi-awcc.c | 204 ++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/platform/x86/dell/dell-wmi-awcc.c

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 68a49788a..20300ff98 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -27,6 +27,15 @@ config ALIENWARE_WMI
 	 zones on Alienware machines that don't contain a dedicated AlienFX
 	 USB MCU such as the X51 and X51-R2.
 
+config AWCC_PLATFORM_PROFILE
+	tristate "AWCC Platform Profile support"
+	depends on ACPI_WMI
+	select ACPI_PLATFORM_PROFILE
+	help
+	 This driver provides platform_profile support for selecting thermal
+	 profiles on Dell devices with User Selectable Thermal Tables,
+	 controlled by AWCC's WMI interface.
+
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
 	default m
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 79d60f1bf..bfef99580 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
 obj-$(CONFIG_DELL_WMI_DDV)		+= dell-wmi-ddv.o
 obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
+obj-$(CONFIG_AWCC_PLATFORM_PROFILE)	+= dell-wmi-awcc.o
 obj-$(CONFIG_DELL_WMI_SYSMAN)		+= dell-wmi-sysman/
diff --git a/drivers/platform/x86/dell/dell-wmi-awcc.c b/drivers/platform/x86/dell/dell-wmi-awcc.c
new file mode 100644
index 000000000..0837d1bc6
--- /dev/null
+++ b/drivers/platform/x86/dell/dell-wmi-awcc.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  WMI driver for Dell's AWCC platform_profile
+ *
+ *  Copyright (c) Kurt Borja <kuurtb@gmail.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_profile.h>
+#include <linux/wmi.h>
+
+#define PROF_TO_ARG(mode) ((mode << 8) | 1)
+
+#define DELL_AWCC_GUID "A70591CE-A997-11DA-B012-B622A1EF5492"
+
+enum awcc_wmi_method {
+	AWCC_WMI_THERMAL_INFORMATION = 0x14,
+	AWCC_WMI_THERMAL_CONTROL = 0x15,
+};
+
+enum awcc_tmp_profile {
+	AWCC_TMP_PROFILE_BALANCED = 0xA0,
+	AWCC_TMP_PROFILE_BALANCED_PERFORMANCE = 0xA1,
+	AWCC_TMP_PROFILE_COOL = 0xA2,
+	AWCC_TMP_PROFILE_QUIET = 0xA3,
+	AWCC_TMP_PROFILE_PERFORMANCE = 0xA4,
+	AWCC_TMP_PROFILE_LOW_POWER = 0xA5,
+};
+
+struct awcc_wmi_priv {
+	struct wmi_device *wdev;
+	struct platform_profile_handler handler;
+};
+
+static int awcc_wmi_query(struct wmi_device *wdev, enum awcc_wmi_method method,
+			  u32 arg, u32 *res)
+{
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	const struct acpi_buffer in = { sizeof(arg), &arg };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
+
+	status = wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (obj->integer.value <= U32_MAX)
+		*res = (u32)obj->integer.value;
+	else
+		ret = -ERANGE;
+
+out_free:
+	kfree(obj);
+
+	return ret;
+}
+
+static int awcc_platform_profile_get(struct platform_profile_handler *pprof,
+				     enum platform_profile_option *profile)
+{
+	struct awcc_wmi_priv *priv =
+		container_of(pprof, struct awcc_wmi_priv, handler);
+
+	u32 res;
+	int ret;
+
+	ret = awcc_wmi_query(priv->wdev, AWCC_WMI_THERMAL_INFORMATION, 0x0B,
+			     &res);
+
+	if (ret < 0)
+		return ret;
+
+	if (res < 0)
+		return -EBADRQC;
+
+	switch (res) {
+	case AWCC_TMP_PROFILE_LOW_POWER:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	case AWCC_TMP_PROFILE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	case AWCC_TMP_PROFILE_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case AWCC_TMP_PROFILE_BALANCED_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+		break;
+	case AWCC_TMP_PROFILE_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int awcc_platform_profile_set(struct platform_profile_handler *pprof,
+				     enum platform_profile_option profile)
+{
+	struct awcc_wmi_priv *priv =
+		container_of(pprof, struct awcc_wmi_priv, handler);
+
+	u32 arg;
+	u32 res;
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		arg = PROF_TO_ARG(AWCC_TMP_PROFILE_LOW_POWER);
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		arg = PROF_TO_ARG(AWCC_TMP_PROFILE_QUIET);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		arg = PROF_TO_ARG(AWCC_TMP_PROFILE_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		arg = PROF_TO_ARG(AWCC_TMP_PROFILE_BALANCED_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		arg = PROF_TO_ARG(AWCC_TMP_PROFILE_PERFORMANCE);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = awcc_wmi_query(priv->wdev, AWCC_WMI_THERMAL_CONTROL, arg, &res);
+
+	if (ret < 0)
+		return ret;
+
+	if (res < 0)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static int awcc_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct awcc_wmi_priv *priv;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->handler.profile_set = awcc_platform_profile_set;
+	priv->handler.profile_get = awcc_platform_profile_get;
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_QUIET, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
+
+	return platform_profile_register(&priv->handler);
+}
+
+static void awcc_wmi_remove(struct wmi_device *wdev)
+{
+	platform_profile_remove();
+}
+
+static const struct wmi_device_id awcc_wmi_id_table[] = {
+	{ .guid_string = DELL_AWCC_GUID },
+	{},
+};
+
+MODULE_DEVICE_TABLE(wmi, awcc_wmi_id_table);
+
+static struct wmi_driver awcc_wmi_driver = {
+	.driver = {
+		.name = "dell-wmi-awcc-platform-profile",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = awcc_wmi_id_table,
+	.probe = awcc_wmi_probe,
+	.remove = awcc_wmi_remove,
+	.no_singleton = true,
+};
+
+module_wmi_driver(awcc_wmi_driver);
+
+MODULE_AUTHOR("Kurt Borja");
+MODULE_DESCRIPTION("Dell AWCC WMI driver");
+MODULE_LICENSE("GPL");
-- 
2.46.2


