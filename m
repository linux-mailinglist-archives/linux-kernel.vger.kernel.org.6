Return-Path: <linux-kernel+bounces-515808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E91A3694D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B03B1272
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E12E62B;
	Sat, 15 Feb 2025 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FftUHtFc"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E041CD0C;
	Sat, 15 Feb 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577795; cv=none; b=OK/JXvgNcBh+XQWcT9N2bLFsAFebeuHjmYrQDbQUgA/5PEScdDgwidbblGr5OYZC9Iy7F/ktsxQJpQPAYBjOSokyDnP+zfERBFxKT0VnwtPXUmzFQ9oT0q1AFgysWCvV6ZpxNI9/ez4xA5aS1OBWURoow8OM9i9N5s/0Su+Ov0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577795; c=relaxed/simple;
	bh=I33ECS2dn4xDgX9A3s2ndVHD+u+pmKmrL/6XQzYxerM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4slnwxK90Y7MdjPYUj73O+V/59y4c5f5QDXo4LnkwSjlFmrA4kYhrGMLeFsoKtxU6I4jJ+OhY0KPUX5cEqiv6JrVRAjOI996dFlpcjejsNm4qF1mAtMNKP9p6Ne87mG923axR9kkZ9+PSieTeGzfIhxpXID0PAaYbAEdjedc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FftUHtFc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f9c6d147edso24593127b3.3;
        Fri, 14 Feb 2025 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577792; x=1740182592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nef+ttkW6sOw/of/q3ow/c0DyRk7Vqkp8UwOrc60xng=;
        b=FftUHtFcJEbner79sT4Kh09rsvQk2iW1VFweRSKIvL9L6ojdD1IwiGRvXACAOaUem/
         zS0J0ECE5kcv/ZOglYhS5ZcoRxNyoqwv2eKoF+lkce3i/81j1A0X0C3ybuNGUg91E9aA
         HVq1c6LXhLP3GTc+TSAvf5fQOAvO8jjpc8sMvLq2YZGKh+nImTQM88J2phVzfatl7xEb
         SUKU3dfTHwmg2sDXncYZdYQzUEXy7zdS1rJlKP1D1NBsXXPBGg1PY6to6mO4FANrVXiL
         ObBmcLPZItaI9PnlrdNPUFTT+v4Sz3z6OMZHPy7q7Mc4kUnzZkvSI1hCE3IjRdwT8r2V
         emPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577792; x=1740182592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nef+ttkW6sOw/of/q3ow/c0DyRk7Vqkp8UwOrc60xng=;
        b=OypVALKAh2nS/TYyE5TwFVMI6mshWi1TleY0ZDHJtaN/xajweZoyTEvhF2BXj4DR/i
         Wr4VeYCl6xq6c7ym6p+jYqDKrSBi1WszxBpayNHy+CuuIoaIy5CKykthE0jXf1y7q6d8
         a1lI/cOS1U4i1gJNR+3ocugfB2sRJ8+qOkDTdJk0riaMH6KsvCuoGjAbewFiMmQd5jqG
         k1Scvj+lHd4XCsuHfHTfuhpiFzoP1V7yVUKey5vF6NbfYria3psw3mMWgQRSp3Qo7obf
         UaJOvahT6jxIVq2rsExQ9EEb2ysY37Hjvamrpk81fBnJNgW2VSKXsigyACgdI+BThg90
         yyHw==
X-Forwarded-Encrypted: i=1; AJvYcCWOuLs1l3z7QyaO5kqvCc3t+YqCpgrpmStKhEEpth99NFl8/sMiaWwwsPSCTDb6oHTCx6vwgXAEoZgc9jc=@vger.kernel.org, AJvYcCWqCgcSnqXIxjoBtgQoNANZCOsikisharQ3blaEq36jLK4ciPZgZe43+WRFT6hLsmZ4f4E76ymeqAc9UlMlanJHeOxQqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDQiykUe3rpOColHmkj6AFWSddCwpI8qVYVQxGGE0gwLe+Gwn
	JYH0D8PabMxHPJxvIqa6piwy85GzQHzm1cR+SDtnYVmVOc1l9ukouujJcQ==
X-Gm-Gg: ASbGncustrFeOQBWruCcIXzQEo793Kcwbhe7iSpWMBB37MUjRDZ0QGmqQ/xxj2BRjwx
	zDa3Z/XdCCO9DC/dlmzkyralBjaY+UOIqHJ73EtriFatLQhrl3zY3q2/Xw1S0Nrrlk/FCLJAzuK
	5YNp5apKCShjfgNSJLYmBTSdvvmw+K7TOxjmPvINWDB69Yo3CNZBENpojgrz7MuK25HPUzDz0g3
	EqzgJvvOLqvGR8DpJJdVkBd7RzHiCXflteFd7RFhlDoi/H1Todrgc1tcMSVCjyCaurC8ke75lHa
	947XtuFR1covI31hyc8/Qno=
X-Google-Smtp-Source: AGHT+IEheVAFV0wi/wzsqTMVLV3X3BaSwCdvJMaIS9By7sccuhiYNDmYBozGqjlzr0KxAdwDt8cv5A==
X-Received: by 2002:a05:690c:30f:b0:6f9:7801:7b2b with SMTP id 00721157ae682-6fb583a1865mr14679067b3.35.1739577792535;
        Fri, 14 Feb 2025 16:03:12 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d586e5sm9844207b3.17.2025.02.14.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:11 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 1/2] platform/x86: thinkpad_acpi: Move subdriver initialization to tpacpi_pdriver's probe.
Date: Fri, 14 Feb 2025 19:03:01 -0500
Message-ID: <20250215000302.19753-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215000302.19753-1-kuurtb@gmail.com>
References: <20250215000302.19753-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that if subdrivers assigned devres resources inside
ibm_init_struct's .init callbacks, driver binding would fail with the
following error message:

	platform thinkpad_acpi: Resources present before probing

Let the driver core manage the lifetimes of the subdrivers and children
devices, by initializing them inside tpacpi_driver's .probe callback.
This is appropriate because these subdrivers usually expose sysfs groups
and the driver core manages this automatically to avoid races.

One immediate benefit of this, is that we are now able to use devres
inside .init subdriver callbacks.

platform_create_bundle is specifically used because it makes the
driver's probe type synchronous and returns an ERR_PTR if attachment
failed.

Additionally, to make error handling simpler, allocate the input device
using devm_input_allocate_device().

Reported-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Closes: https://lore.kernel.org/platform-driver-x86/20250208091438.5972-1-mpearson-lenovo@squebb.ca/#t
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 136 ++++++++++++---------------
 1 file changed, 62 insertions(+), 74 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ab1cade5ef23..ad9de48cc122 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -367,8 +367,6 @@ static struct {
 	u32 beep_needs_two_args:1;
 	u32 mixer_no_level_control:1;
 	u32 battery_force_primary:1;
-	u32 input_device_registered:1;
-	u32 platform_drv_registered:1;
 	u32 sensors_pdrv_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
@@ -11815,36 +11813,20 @@ MODULE_PARM_DESC(profile_force, "Force profile mode. -1=off, 1=MMC, 2=PSC");
 
 static void thinkpad_acpi_module_exit(void)
 {
-	struct ibm_struct *ibm, *itmp;
-
 	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
 
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 	if (tp_features.sensors_pdrv_registered)
 		platform_driver_unregister(&tpacpi_hwmon_pdriver);
-	if (tp_features.platform_drv_registered)
-		platform_driver_unregister(&tpacpi_pdriver);
-
-	list_for_each_entry_safe_reverse(ibm, itmp,
-					 &tpacpi_all_drivers,
-					 all_drivers) {
-		ibm_exit(ibm);
-	}
-
-	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
-
-	if (tpacpi_inputdev) {
-		if (tp_features.input_device_registered)
-			input_unregister_device(tpacpi_inputdev);
-		else
-			input_free_device(tpacpi_inputdev);
-	}
-
 	if (tpacpi_sensors_pdev)
 		platform_device_unregister(tpacpi_sensors_pdev);
-	if (tpacpi_pdev)
+
+	if (tpacpi_pdev) {
+		platform_driver_unregister(&tpacpi_pdriver);
 		platform_device_unregister(tpacpi_pdev);
+	}
+
 	if (proc_dir)
 		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
 	if (tpacpi_wq)
@@ -11856,11 +11838,63 @@ static void thinkpad_acpi_module_exit(void)
 	kfree(thinkpad_id.nummodel_str);
 }
 
+static void tpacpi_subdrivers_release(void *data)
+{
+	struct ibm_struct *ibm, *itmp;
+
+	list_for_each_entry_safe_reverse(ibm, itmp, &tpacpi_all_drivers, all_drivers)
+		ibm_exit(ibm);
+
+	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
+}
+
+static int __init tpacpi_pdriver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	devm_mutex_init(&pdev->dev, &tpacpi_inputdev_send_mutex);
+
+	tpacpi_inputdev = devm_input_allocate_device(&pdev->dev);
+	if (!tpacpi_inputdev)
+		return -ENOMEM;
+
+	tpacpi_inputdev->name = "ThinkPad Extra Buttons";
+	tpacpi_inputdev->phys = TPACPI_DRVR_NAME "/input0";
+	tpacpi_inputdev->id.bustype = BUS_HOST;
+	tpacpi_inputdev->id.vendor = thinkpad_id.vendor;
+	tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
+	tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
+	tpacpi_inputdev->dev.parent = &tpacpi_pdev->dev;
+
+	/* Init subdriver dependencies */
+	tpacpi_detect_brightness_capabilities();
+
+	/* Init subdrivers */
+	for (unsigned int i = 0; i < ARRAY_SIZE(ibms_init); i++) {
+		ret = ibm_init(&ibms_init[i]);
+		if (ret >= 0 && *ibms_init[i].param)
+			ret = ibms_init[i].data->write(ibms_init[i].param);
+		if (ret < 0) {
+			tpacpi_subdrivers_release(NULL);
+			return ret;
+		}
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, tpacpi_subdrivers_release, NULL);
+	if (ret)
+		return ret;
+
+	ret = input_register_device(tpacpi_inputdev);
+	if (ret < 0)
+		pr_err("unable to register input device\n");
+
+	return ret;
+}
 
 static int __init thinkpad_acpi_module_init(void)
 {
 	const struct dmi_system_id *dmi_id;
-	int ret, i;
+	int ret;
 	acpi_object_type obj_type;
 
 	tpacpi_lifecycle = TPACPI_LIFE_INIT;
@@ -11920,15 +11954,16 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.quirks = dmi_id->driver_data;
 
 	/* Device initialization */
-	tpacpi_pdev = platform_device_register_simple(TPACPI_DRVR_NAME, PLATFORM_DEVID_NONE,
-							NULL, 0);
+	tpacpi_pdev = platform_create_bundle(&tpacpi_pdriver, tpacpi_pdriver_probe,
+					     NULL, 0, NULL, 0);
 	if (IS_ERR(tpacpi_pdev)) {
 		ret = PTR_ERR(tpacpi_pdev);
 		tpacpi_pdev = NULL;
-		pr_err("unable to register platform device\n");
+		pr_err("unable to register platform device/driver bundle\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+
 	tpacpi_sensors_pdev = platform_device_register_simple(
 						TPACPI_HWMON_DRVR_NAME,
 						PLATFORM_DEVID_NONE, NULL, 0);
@@ -11940,46 +11975,8 @@ static int __init thinkpad_acpi_module_init(void)
 		return ret;
 	}
 
-	mutex_init(&tpacpi_inputdev_send_mutex);
-	tpacpi_inputdev = input_allocate_device();
-	if (!tpacpi_inputdev) {
-		thinkpad_acpi_module_exit();
-		return -ENOMEM;
-	} else {
-		/* Prepare input device, but don't register */
-		tpacpi_inputdev->name = "ThinkPad Extra Buttons";
-		tpacpi_inputdev->phys = TPACPI_DRVR_NAME "/input0";
-		tpacpi_inputdev->id.bustype = BUS_HOST;
-		tpacpi_inputdev->id.vendor = thinkpad_id.vendor;
-		tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
-		tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
-		tpacpi_inputdev->dev.parent = &tpacpi_pdev->dev;
-	}
-
-	/* Init subdriver dependencies */
-	tpacpi_detect_brightness_capabilities();
-
-	/* Init subdrivers */
-	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
-		ret = ibm_init(&ibms_init[i]);
-		if (ret >= 0 && *ibms_init[i].param)
-			ret = ibms_init[i].data->write(ibms_init[i].param);
-		if (ret < 0) {
-			thinkpad_acpi_module_exit();
-			return ret;
-		}
-	}
-
 	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
 
-	ret = platform_driver_register(&tpacpi_pdriver);
-	if (ret) {
-		pr_err("unable to register main platform driver\n");
-		thinkpad_acpi_module_exit();
-		return ret;
-	}
-	tp_features.platform_drv_registered = 1;
-
 	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
 	if (ret) {
 		pr_err("unable to register hwmon platform driver\n");
@@ -11998,15 +11995,6 @@ static int __init thinkpad_acpi_module_init(void)
 		return ret;
 	}
 
-	ret = input_register_device(tpacpi_inputdev);
-	if (ret < 0) {
-		pr_err("unable to register input device\n");
-		thinkpad_acpi_module_exit();
-		return ret;
-	} else {
-		tp_features.input_device_registered = 1;
-	}
-
 	return 0;
 }
 
-- 
2.48.1


