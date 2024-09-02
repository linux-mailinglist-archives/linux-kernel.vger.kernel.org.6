Return-Path: <linux-kernel+bounces-311576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6121968AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075551C21E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8A1CB500;
	Mon,  2 Sep 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmX+/8rl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F214F6C;
	Mon,  2 Sep 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289591; cv=none; b=T8wWOmQzyq59fa0pxk7imHeivdGgFdYuR8YYUiMYgU+UVxvt80LZET3N+81y+O+RuYgFAOT3L1gLYxsDb5Luf5uexNsIAbbfcC0rbiRgeEpVXUh17Obfae528QVVz9L51tM7woWLsJK4RTqD1qA2Vvyx9lJn8djJtqFXNwEGvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289591; c=relaxed/simple;
	bh=wd2Dx+UQj0EdAyX+mYnESpHv+96FyaCmKa9ELxlNSFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkhXkv0vnSKJeRQnwn3S5hcjWpYu3Ltqepx+TofhjuMKEd2ZReCJr1EScmpQQo4K6PZKoPz4L5z8mFZaTKBkTrkpFfWUgLpphUPrZDRlu2TGdSAGoZsNtVBgJ3Ty/1+VLD4n761gMx/TGwdpr2X8pJU+28haP5bpA0zRBlZJQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmX+/8rl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725289589; x=1756825589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wd2Dx+UQj0EdAyX+mYnESpHv+96FyaCmKa9ELxlNSFc=;
  b=TmX+/8rlLsqcrB1+kt0dD7O63m+8NXyZ7BvMOWM/ukH6DyO+Y9ip2zav
   GNMn6AJoSr42QFb/ZASTUxg2J8zbVBxMhwtB3V2UET49JtymWQirtbWFF
   SJAZWncJp1qQmWBdKse8IHUKk2NeMuVJYb1Rnxr8FMCrnZynA0JfAbkhq
   WINXNDaxq73jI656fob2mKvzQmWVwf7t+esK79gK3LLLfo/dPnBdrtud6
   qUwt5QmBc+5JJgW0/bmovN4KmZjqHrCutp+WzrdzMj/M7BYicjQN8J2Yt
   ux5X7rCWROVwUE1vs4bPGgr8lO+v2WiPajOYR9tu0QxdHHNB12BHZlOTU
   Q==;
X-CSE-ConnectionGUID: fnpl7RERRneUk73sjVzrrQ==
X-CSE-MsgGUID: tJxDYVcTTPyGG1gxv1LN9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35267673"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35267673"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 08:06:29 -0700
X-CSE-ConnectionGUID: 7vH6Gc69RKSywgQ2SLsAdQ==
X-CSE-MsgGUID: gpomxZjdS4y9tUoNt/Xrdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64315941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 02 Sep 2024 08:06:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4D026233; Mon, 02 Sep 2024 18:06:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: x86-android-tablets: Fix spelling in the comments
Date: Mon,  2 Sep 2024 18:06:25 +0300
Message-ID: <20240902150625.2722187-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling across comments (besides obvious grammar issues):
- spell words in full, e.g., 'img' --> 'image'
- refer to 'gpio-keys' consistently
- refer to acpi_power_off() clearly as to function
- make sure that the first line is only for the affected model(s)
- miscellaneous improvements

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../platform/x86/x86-android-tablets/Kconfig  |  2 +-
 .../platform/x86/x86-android-tablets/asus.c   |  8 ++---
 .../platform/x86/x86-android-tablets/core.c   | 20 ++++++-------
 .../platform/x86/x86-android-tablets/dmi.c    | 11 +++----
 .../platform/x86/x86-android-tablets/lenovo.c | 22 +++++++-------
 .../platform/x86/x86-android-tablets/other.c  | 30 +++++++++----------
 .../x86/x86-android-tablets/shared-psy-info.c |  4 +--
 .../x86-android-tablets/x86-android-tablets.h |  2 +-
 8 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
index b591419de80c..88d9e8f2ff24 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -20,4 +20,4 @@ config X86_ANDROID_TABLETS
 	  are missing from the DSDT.
 
 	  If you have a x86 Android tablet say Y or M here, for a generic x86
-	  distro config say M here.
+	  distro configuration say M here.
diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
index 227afbb51078..07fbeab2319a 100644
--- a/drivers/platform/x86/x86-android-tablets/asus.c
+++ b/drivers/platform/x86/x86-android-tablets/asus.c
@@ -37,7 +37,7 @@ static const struct x86_gpio_button asus_me176c_tf103c_lid __initconst = {
 	.pin = 12,
 };
 
-/* Asus ME176C tablets have an Android factory img with everything hardcoded */
+/* Asus ME176C tablets have an Android factory image with everything hardcoded */
 static const char * const asus_me176c_accel_mount_matrix[] = {
 	"-1", "0", "0",
 	"0", "1", "0",
@@ -112,7 +112,7 @@ static const struct x86_i2c_client_info asus_me176c_i2c_clients[] __initconst =
 		},
 		.adapter_path = "\\_SB_.I2C5",
 	}, {
-		/* kxtj21009 accel */
+		/* kxtj21009 accelerometer */
 		.board_info = {
 			.type = "kxtj21009",
 			.addr = 0x0f,
@@ -181,7 +181,7 @@ const struct x86_dev_info asus_me176c_info __initconst = {
 	.modules = bq24190_modules,
 };
 
-/* Asus TF103C tablets have an Android factory img with everything hardcoded */
+/* Asus TF103C tablets have an Android factory image with everything hardcoded */
 static const char * const asus_tf103c_accel_mount_matrix[] = {
 	"0", "-1", "0",
 	"-1", "0", "0",
@@ -280,7 +280,7 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
 		},
 		.adapter_path = "\\_SB_.I2C5",
 	}, {
-		/* kxtj21009 accel */
+		/* kxtj21009 accelerometer */
 		.board_info = {
 			.type = "kxtj21009",
 			.addr = 0x0f,
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 919ef4471229..1427a9a39008 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -26,19 +26,19 @@
 static struct platform_device *x86_android_tablet_device;
 
 /*
- * This helper allows getting a gpio_desc *before* the actual device consuming
- * the GPIO has been instantiated. This function _must_ only be used to handle
- * this special case such as e.g. :
+ * This helper allows getting a GPIO descriptor *before* the actual device
+ * consuming it has been instantiated. This function MUST only be used to
+ * handle this special case such as, e.g.:
  *
  * 1. Getting an IRQ from a GPIO for i2c_board_info.irq which is passed to
  * i2c_client_new() to instantiate i2c_client-s; or
- * 2. Calling desc_to_gpio() to get an old style GPIO number for gpio_keys
+ * 2. Calling desc_to_gpio() to get an old style GPIO number for gpio-keys
  * platform_data which still uses old style GPIO numbers.
  *
- * Since the consuming device has not been instatiated yet a dynamic lookup
- * is generated using the special x86_android_tablet dev for dev_id.
+ * Since the consuming device has not been instantiated yet a dynamic lookup
+ * is generated using the special x86_android_tablet device for dev_id.
  *
- * For normal GPIO lookups a standard static gpiod_lookup_table _must_ be used.
+ * For normal GPIO lookups a standard static struct gpiod_lookup_table MUST be used.
  */
 int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
 				 bool active_low, enum gpiod_flags dflags,
@@ -87,7 +87,7 @@ int x86_acpi_irq_helper_get(const struct x86_acpi_irq_data *data)
 		/*
 		 * The DSDT may already reference the GSI in a device skipped by
 		 * acpi_quirk_skip_i2c_client_enumeration(). Unregister the GSI
-		 * to avoid EBUSY errors in this case.
+		 * to avoid -EBUSY errors in this case.
 		 */
 		acpi_unregister_gsi(data->index);
 		irq = acpi_register_gsi(NULL, data->index, data->trigger, data->polarity);
@@ -379,7 +379,7 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* + 1 to make space for (optional) gpio_keys_button pdev */
+	/* + 1 to make space for the (optional) gpio_keys_button platform device */
 	pdevs = kcalloc(dev_info->pdev_count + 1, sizeof(*pdevs), GFP_KERNEL);
 	if (!pdevs) {
 		x86_android_tablet_remove(pdev);
@@ -432,7 +432,7 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 
 			buttons[i] = dev_info->gpio_button[i].button;
 			buttons[i].gpio = desc_to_gpio(gpiod);
-			/* Release gpiod so that gpio-keys can request it */
+			/* Release GPIO descriptor so that gpio-keys can request it */
 			devm_gpiod_put(&x86_android_tablet_device->dev, gpiod);
 		}
 
diff --git a/drivers/platform/x86/x86-android-tablets/dmi.c b/drivers/platform/x86/x86-android-tablets/dmi.c
index 387dd092c4dd..034f97a8ff27 100644
--- a/drivers/platform/x86/x86-android-tablets/dmi.c
+++ b/drivers/platform/x86/x86-android-tablets/dmi.c
@@ -99,14 +99,15 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 	{
 		/* Lenovo Yoga Book X91F / X91L */
 		.matches = {
-			/* Non exact match to match F + L versions */
+			/* Inexact match to match F + L versions */
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
 		.driver_data = (void *)&lenovo_yogabook_x91_info,
 	},
 	{
 		/*
-		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13") This has more or less
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13")
+		 * This has more or less
 		 * the same BIOS as the 830F/L or 1050F/L (8" and 10") below,
 		 * but unlike the 8" / 10" models which share the same mainboard
 		 * this model has a different mainboard.
@@ -124,8 +125,8 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 	},
 	{
 		/*
-		 * Lenovo Yoga Tablet 2 830F/L or 1050F/L (The 8" and 10"
-		 * Lenovo Yoga Tablet 2 use the same mainboard)
+		 * Lenovo Yoga Tablet 2 830F/L or 1050F/L
+		 * The 8" and 10" * Lenovo Yoga Tablet 2 use the same mainboard.
 		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
@@ -163,7 +164,7 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 		.driver_data = (void *)&nextbook_ares8_info,
 	},
 	{
-		/* Nextbook Ares 8A (CHT version)*/
+		/* Nextbook Ares 8A (CHT version) */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 74f39b658d2c..ae087f1471c1 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -59,7 +59,7 @@ static struct lp855x_platform_data lenovo_lp8557_reg_only_pdata = {
 	.initial_brightness = 128,
 };
 
-/* Lenovo Yoga Book X90F / X90L's Android factory img has everything hardcoded */
+/* Lenovo Yoga Book X90F / X90L's Android factory image has everything hardcoded */
 
 static const struct property_entry lenovo_yb1_x90_wacom_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0001),
@@ -262,7 +262,7 @@ const struct x86_dev_info lenovo_yogabook_x90_info __initconst = {
 	.init = lenovo_yb1_x90_init,
 };
 
-/* Lenovo Yoga Book X91F/L Windows tablet needs manual instantiation of the fg client */
+/* Lenovo Yoga Book X91F/L Windows tablet needs manual instantiation of the fuel-gauge client */
 static const struct x86_i2c_client_info lenovo_yogabook_x91_i2c_clients[] __initconst = {
 	{
 		/* BQ27542 fuel-gauge */
@@ -281,7 +281,7 @@ const struct x86_dev_info lenovo_yogabook_x91_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(lenovo_yogabook_x91_i2c_clients),
 };
 
-/* Lenovo Yoga Tablet 2 1050F/L's Android factory img has everything hardcoded */
+/* Lenovo Yoga Tablet 2 1050F/L's Android factory image has everything hardcoded */
 static const struct property_entry lenovo_yoga_tab2_830_1050_bq24190_props[] = {
 	PROPERTY_ENTRY_STRING_ARRAY_LEN("supplied-from", tusb1211_chg_det_psy, 1),
 	PROPERTY_ENTRY_REF("monitored-battery", &generic_lipo_hv_4v35_battery_node),
@@ -521,9 +521,9 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
 }
 
 /*
- * These tablet's DSDT does not set acpi_gbl_reduced_hardware, so acpi_power_off
+ * These tablet's DSDT does not set acpi_gbl_reduced_hardware, so acpi_power_off()
  * gets used as pm_power_off handler. This causes "poweroff" on these tablets
- * to hang hard. Requiring pressing the powerbutton for 30 seconds *twice*
+ * to hang hard. Requiring pressing the power button for 30 seconds *twice*
  * followed by a normal 3 second press to recover. Avoid this by doing an EFI
  * poweroff instead.
  */
@@ -546,7 +546,7 @@ static int __init lenovo_yoga_tab2_830_1050_init(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
+	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off() */
 	lenovo_yoga_tab2_830_1050_sys_off_handler =
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
 					 lenovo_yoga_tab2_830_1050_power_off, NULL);
@@ -742,7 +742,7 @@ static int __init lenovo_yoga_tab2_1380_init(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
+	/* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off() */
 	lenovo_yoga_tab2_830_1050_sys_off_handler =
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
 					 lenovo_yoga_tab2_830_1050_power_off, NULL);
@@ -799,7 +799,7 @@ static const struct software_node fg_bq25890_1_supply_node = {
 	.properties = fg_bq25890_1_supply_props,
 };
 
-/* bq25892 charger settings for the flat lipo battery behind the screen */
+/* bq25892 charger settings for the flat LiPo battery behind the screen */
 static const struct property_entry lenovo_yt3_bq25892_0_props[] = {
 	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", lenovo_yt3_bq25892_0_suppliers),
 	PROPERTY_ENTRY_U32("linux,iinlim-percentage", 40),
@@ -833,7 +833,7 @@ static const struct software_node lenovo_yt3_hideep_ts_node = {
 
 static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 	{
-		/* bq27500 fuel-gauge for the flat lipo battery behind the screen */
+		/* bq27500 fuel-gauge for the flat LiPo battery behind the screen */
 		.board_info = {
 			.type = "bq27500",
 			.addr = 0x55,
@@ -842,7 +842,7 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C1",
 	}, {
-		/* bq25892 charger for the flat lipo battery behind the screen */
+		/* bq25892 charger for the flat LiPo battery behind the screen */
 		.board_info = {
 			.type = "bq25892",
 			.addr = 0x6b,
@@ -859,7 +859,7 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 			.con_id = "bq25892_0_irq",
 		},
 	}, {
-		/* bq27500 fuel-gauge for the round li-ion cells in the hinge */
+		/* bq27500 fuel-gauge for the round Li-ion cells in the hinge */
 		.board_info = {
 			.type = "bq27500",
 			.addr = 0x55,
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index eb0e55c69dfe..aad7114c43c3 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -20,7 +20,7 @@
 #include "shared-psy-info.h"
 #include "x86-android-tablets.h"
 
-/* Acer Iconia One 7 B1-750 has an Android factory img with everything hardcoded */
+/* Acer Iconia One 7 B1-750 has an Android factory image with everything hardcoded */
 static const char * const acer_b1_750_mount_matrix[] = {
 	"-1", "0", "0",
 	"0", "1", "0",
@@ -98,7 +98,7 @@ const struct x86_dev_info acer_b1_750_info __initconst = {
  * Advantech MICA-071
  * This is a standard Windows tablet, but it has an extra "quick launch" button
  * which is not described in the ACPI tables in anyway.
- * Use the x86-android-tablets infra to create a gpio-button device for this.
+ * Use the x86-android-tablets infra to create a gpio-keys device for this.
  */
 static const struct x86_gpio_button advantech_mica_071_button __initconst = {
 	.button = {
@@ -209,7 +209,7 @@ const struct x86_dev_info chuwi_hi8_info __initconst = {
  * This comes in both Windows and Android versions and even on Android
  * the DSDT is mostly sane. This tablet has 2 extra general purpose buttons
  * in the button row with the power + volume-buttons labeled P and F.
- * Use the x86-android-tablets infra to create a gpio-button device for these.
+ * Use the x86-android-tablets infra to create a gpio-keys device for these.
  */
 static const struct x86_gpio_button cyberbook_t116_buttons[] __initconst = {
 	{
@@ -276,7 +276,7 @@ const struct x86_dev_info czc_p10t __initconst = {
 	.init = czc_p10t_init,
 };
 
-/* Medion Lifetab S10346 tablets have an Android factory img with everything hardcoded */
+/* Medion Lifetab S10346 tablets have an Android factory image with everything hardcoded */
 static const char * const medion_lifetab_s10346_accel_mount_matrix[] = {
 	"0", "1", "0",
 	"1", "0", "0",
@@ -305,7 +305,7 @@ static const struct software_node medion_lifetab_s10346_touchscreen_node = {
 
 static const struct x86_i2c_client_info medion_lifetab_s10346_i2c_clients[] __initconst = {
 	{
-		/* kxtj21009 accel */
+		/* kxtj21009 accelerometer */
 		.board_info = {
 			.type = "kxtj21009",
 			.addr = 0x0f,
@@ -359,7 +359,7 @@ const struct x86_dev_info medion_lifetab_s10346_info __initconst = {
 	.gpiod_lookup_tables = medion_lifetab_s10346_gpios,
 };
 
-/* Nextbook Ares 8 (BYT) tablets have an Android factory img with everything hardcoded */
+/* Nextbook Ares 8 (BYT) tablets have an Android factory image with everything hardcoded */
 static const char * const nextbook_ares8_accel_mount_matrix[] = {
 	"0", "-1", "0",
 	"-1", "0", "0",
@@ -387,7 +387,7 @@ static const struct software_node nextbook_ares8_touchscreen_node = {
 
 static const struct x86_i2c_client_info nextbook_ares8_i2c_clients[] __initconst = {
 	{
-		/* Freescale MMA8653FC accel */
+		/* Freescale MMA8653FC accelerometer */
 		.board_info = {
 			.type = "mma8653",
 			.addr = 0x1d,
@@ -428,7 +428,7 @@ const struct x86_dev_info nextbook_ares8_info __initconst = {
 	.gpiod_lookup_tables = nextbook_ares8_gpios,
 };
 
-/* Nextbook Ares 8A (CHT) tablets have an Android factory img with everything hardcoded */
+/* Nextbook Ares 8A (CHT) tablets have an Android factory image with everything hardcoded */
 static const char * const nextbook_ares8a_accel_mount_matrix[] = {
 	"1", "0", "0",
 	"0", "-1", "0",
@@ -446,7 +446,7 @@ static const struct software_node nextbook_ares8a_accel_node = {
 
 static const struct x86_i2c_client_info nextbook_ares8a_i2c_clients[] __initconst = {
 	{
-		/* Freescale MMA8653FC accel */
+		/* Freescale MMA8653FC accelerometer */
 		.board_info = {
 			.type = "mma8653",
 			.addr = 0x1d,
@@ -497,7 +497,7 @@ const struct x86_dev_info nextbook_ares8a_info __initconst = {
  * Peaq C1010
  * This is a standard Windows tablet, but it has a special Dolby button.
  * This button has a WMI interface, but that is broken. Instead of trying to
- * use the broken WMI interface, instantiate a gpio_keys device for this.
+ * use the broken WMI interface, instantiate a gpio-keys device for this.
  */
 static const struct x86_gpio_button peaq_c1010_button __initconst = {
 	.button = {
@@ -521,7 +521,7 @@ const struct x86_dev_info peaq_c1010_info __initconst = {
  * Whitelabel (sold as various brands) TM800A550L tablets.
  * These tablet's DSDT contains a whole bunch of bogus ACPI I2C devices
  * (removed through acpi_quirk_skip_i2c_client_enumeration()) and
- * the touchscreen fwnode has the wrong GPIOs.
+ * the touchscreen firmware node has the wrong GPIOs.
  */
 static const char * const whitelabel_tm800a550l_accel_mount_matrix[] = {
 	"-1", "0", "0",
@@ -566,7 +566,7 @@ static const struct x86_i2c_client_info whitelabel_tm800a550l_i2c_clients[] __in
 			.polarity = ACPI_ACTIVE_HIGH,
 		},
 	}, {
-		/* kxcj91008 accel */
+		/* kxcj91008 accelerometer */
 		.board_info = {
 			.type = "kxcj91008",
 			.addr = 0x0f,
@@ -598,12 +598,12 @@ const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 };
 
 /*
- * The fwnode for ktd2026 on Xaomi pad2. It composed of a RGB LED node
+ * The firmware node for ktd2026 on Xaomi pad2. It composed of a RGB LED node
  * with three subnodes for each color (B/G/R). The RGB LED node is named
  * "multi-led" to align with the name in the device tree.
  */
 
-/* main fwnode for ktd2026 */
+/* Main firmware node for ktd2026 */
 static const struct software_node ktd2026_node = {
 	.name = "ktd2026",
 };
@@ -665,7 +665,7 @@ static const struct software_node *ktd2026_node_group[] = {
 };
 
 /*
- * For the LEDs which backlight the menu / home / back capacitive buttons on
+ * For the LEDs which backlight the Menu / Home / Back capacitive buttons on
  * the bottom bezel. These are attached to a TPS61158 LED controller which
  * is controlled by the "pwm_soc_lpss_2" PWM output.
  */
diff --git a/drivers/platform/x86/x86-android-tablets/shared-psy-info.c b/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
index d2d0aa51bc3f..a46fa15acfb1 100644
--- a/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
+++ b/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
@@ -39,7 +39,7 @@ const struct software_node fg_bq25890_supply_node = {
 	.properties = fg_bq25890_supply_props,
 };
 
-/* LiPo HighVoltage (max 4.35V) settings used by most devs with a HV bat. */
+/* LiPo HighVoltage (max 4.35V) settings used by most devs with a HV battery */
 static const struct property_entry generic_lipo_hv_4v35_battery_props[] = {
 	PROPERTY_ENTRY_STRING("compatible", "simple-battery"),
 	PROPERTY_ENTRY_STRING("device-chemistry", "lithium-ion"),
@@ -80,7 +80,7 @@ const char * const bq24190_modules[] __initconst = {
 	NULL
 };
 
-/* Generic pdevs array and gpio-lookups for micro USB ID pin handling */
+/* Generic platform device array and GPIO lookup table for micro USB ID pin handling */
 const struct platform_device_info int3496_pdevs[] __initconst = {
 	{
 		/* For micro USB ID pin handling */
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index 86402b9b46a3..5517e438c7b6 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -61,7 +61,7 @@ struct x86_serdev_info {
 	const char *ctrl_uid;
 	const char *ctrl_devname;
 	/*
-	 * ATM the serdev core only supports of or ACPI matching; and sofar all
+	 * ATM the serdev core only supports of or ACPI matching; and so far all
 	 * Android x86 tablets DSDTs have usable serdev nodes, but sometimes
 	 * under the wrong controller. So we just tie the existing serdev ACPI
 	 * node to the right controller.
-- 
2.43.0.rc1.1336.g36b5255a03ac


