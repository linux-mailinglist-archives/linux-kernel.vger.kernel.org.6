Return-Path: <linux-kernel+bounces-275572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6E948758
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D71B23232
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D31E495;
	Tue,  6 Aug 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="AU3Qd8Y0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTM8LKfD"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A93C466;
	Tue,  6 Aug 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910099; cv=none; b=KPlKIxV3WDMNv8UPBpKThxssE3Y5k0+6GZW0JsHLO5V613qPBe8eKwmIlqExeU4IIZdPhnpWuXBDxqiEZa/r32VMWzoAfhvUjsZpnlzHtSYbppNGr84ArB4tZfb0QKVNek3OE2QivKII/BBY5B7cz9EJBgPKKRYid1qusp03hRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910099; c=relaxed/simple;
	bh=927Y/8lx1xKRkyIL6RFt+6V+dxo/1qqK9xm26FW+gEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atspxwq0FDx9rsq+y+AoBvSd5eK2rl5C+fFPtSRzdEpCocoV53kFoE68myq1LZ5igxlFiANh2QFr0ZlCAzwc3hdKorBS0znXqMBbE6KvlFZYyfYlokvCBvsS/0HeMg/nGpDPj1//Wy8qUhKz5dzl6PfQ4JMNlDF8xJxfGSjwxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=AU3Qd8Y0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTM8LKfD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 69DA4138FC3B;
	Mon,  5 Aug 2024 22:08:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 22:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1722910096; x=
	1722996496; bh=hepVkLOIOqBtH1VWXZfEsOU74Sztw04bD8peTe5i/40=; b=A
	U3Qd8Y0Iaxl48FWPvgJXp3XB4Unq/+1SmkxRo2/dsFXNjeAGVZoPIZ+w1+oD1kYR
	mk0M8TA4J6Ya5UtxONDX8nxuClooff+kxNxnFdP5N3D/HW+2EwvbPYpD3dAh5Mxw
	9x/My7WJTylAWykBe/e2CfKL7wLCky7eaou7qpzl7gcdxnK68nCaCgtV8wzw21s3
	bB5w1B589/wCdE4AjYTguQGmxu/vaGL8NXyWfoYJgZaeI53/s3nxZrgEXZ566F22
	JlU4O3Oxl3hm1DAOQ0Ub+9tHx6RoHvJLCLbkFta5SqJhjUy7buV/XxA9fZtdxRe7
	68yefJ/F7b/yz9rXh5LKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722910096; x=
	1722996496; bh=hepVkLOIOqBtH1VWXZfEsOU74Sztw04bD8peTe5i/40=; b=r
	TM8LKfDEcn9rYO3p57onQ4I08m5t5UscOdmo9Ur9UIl6+CClEF5IvEXDzX9SfXyi
	GIv6LZbMHnS5FvQ9xKD7G/DWBjoqARM5Vf3UEV8ENR3z/+raAbvdlA2V+nDBKFuv
	Y/EGTofUggF4p7qzLnNK0UGB15grfOfGxZY/jh59yFBsiWodzYS1b2alTYH3aj5B
	IRAIM2d40/ZmFbwUTnX9s2txLmor8fLH7z9d9s2xjAeLn72JkKuMJO+XqktaJFlY
	QXQB79pVAI2Gq4PoMmb5ql9XL6Zi1nlXsNWH4wfEvrz6vzcpUdsqBICOZHOPPiNm
	17qhFH0Teg548/Lcb5m0w==
X-ME-Sender: <xms:kIWxZlpKv5T3HaYgnJRczreTtpkV-mm9qHEA-_poNvKX62c5BQ75og>
    <xme:kIWxZnqgLREl_w3tzgaivGHMwxD4_ZcvKwzRykTCnnjLqR--OmU_aG8rHK-Ph0vGt
    bZ2mOk__qBkBytkdhU>
X-ME-Received: <xmr:kIWxZiNIcwJWo_LMifICZ0RwFhYmXMmr6KjsaVik-xvOniPmIPJ6Qbo4h-_r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprh
    gtphhtthhopedt
X-ME-Proxy: <xmx:kIWxZg6VDL0rbwrzjls3zfIaq9dVPjRH0vxroSFcTBhA3iWE32Ci1w>
    <xmx:kIWxZk7PcZUWKMOqvTW4-L5mIf9YkuhSt4CJoNwT3ZibeJMNccO-NQ>
    <xmx:kIWxZoj0gyIZYvpqGAbg3rUvh--iCpfjY_TKpeKpaAHmUwA-3iN2Tg>
    <xmx:kIWxZm7f3g8GIKofuck3sWjCpie-05ZRbVE3PWcow7dqKqXFcgGFfw>
    <xmx:kIWxZuRYKw26T_oC4e2X10arifNmykM484viGPl4WGiVKMT-61sc0fxg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:08:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 6/6] asus-wmi: deprecate bios features
Date: Tue,  6 Aug 2024 14:07:47 +1200
Message-ID: <20240806020747.365042-7-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806020747.365042-1-luke@ljones.dev>
References: <20240806020747.365042-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the existence of the asus-bioscfg module the attributes no-longer
need to live under the /sys/devices/platform/asus-nb-wmi/ path.

Deprecate all those that were implemented in asus-bioscfg with the goal
of removing them fully in the next LTS cycle.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  17 +++
 drivers/platform/x86/Kconfig                  |   8 ++
 drivers/platform/x86/asus-wmi.c               | 125 ++++++++++++++----
 3 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 28144371a0f1..765d50b0d9df 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -63,6 +63,7 @@ Date:		Aug 2022
 KernelVersion:	6.1
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Switch the GPU hardware MUX mode. Laptops with this feature can
 		can be toggled to boot with only the dGPU (discrete mode) or in
 		standard Optimus/Hybrid mode. On switch a reboot is required:
@@ -75,6 +76,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Disable discrete GPU:
 			* 0 - Enable dGPU,
 			* 1 - Disable dGPU
@@ -84,6 +86,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Enable the external GPU paired with ROG X-Flow laptops.
 		Toggling this setting will also trigger ACPI to disable the dGPU:
 
@@ -95,6 +98,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Enable an LCD response-time boost to reduce or remove ghosting:
 			* 0 - Disable,
 			* 1 - Enable
@@ -104,6 +108,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Get the current charging mode being used:
 			* 1 - Barrel connected charger,
 			* 2 - USB-C charging
@@ -114,6 +119,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Show if the egpu (XG Mobile) is correctly connected:
 			* 0 - False,
 			* 1 - True
@@ -123,6 +129,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
@@ -133,6 +140,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		List the available mini-led modes.
 
 What:		/sys/devices/platform/<platform>/ppt_pl1_spl
@@ -140,6 +148,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
 		Shown on Intel+Nvidia or AMD+Nvidia based systems:
 
@@ -150,6 +159,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
 		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
 
@@ -160,6 +170,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
 			* min=5, max=250
 
@@ -168,6 +179,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the APU SPPT limit. Shown on full AMD systems only:
 			* min=5, max=130
 
@@ -176,6 +188,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the platform SPPT limit. Shown on full AMD systems only:
 			* min=5, max=130
 
@@ -184,6 +197,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the dynamic boost limit of the Nvidia dGPU:
 			* min=5, max=25
 
@@ -192,6 +206,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
 
@@ -200,6 +215,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set if the BIOS POST sound is played on boot.
 			* 0 - False,
 			* 1 - True
@@ -209,6 +225,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON
 		Set if the MCU can go in to low-power mode on system sleep
 			* 0 - False,
 			* 1 - True
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8ecc73ef2670..bafe5883805b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -301,6 +301,14 @@ config ASUS_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called asus-wmi.
 
+config ASUS_WMI_BIOS
+	bool "BIOS option support in WMI platform (DEPRECATED)"
+	depends on ASUS_WMI
+	help
+	  Say Y to expose the configurable BIOS options through the asus-wmi
+	  driver. This can be used with or without the new asus-bios driver as
+	  the options are the same but the asus-bios driver has more features.
+
 config ASUS_NB_WMI
 	tristate "Asus Notebook WMI Driver"
 	depends on ASUS_WMI
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 165e7932c371..5ecd47f23c83 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -290,11 +290,12 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+
+	/* Tunables provided by ASUS for gaming laptops */
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 	bool egpu_enable_available;
 	bool dgpu_disable_available;
 	u32 gpu_mux_dev;
-
-	/* Tunables provided by ASUS for gaming laptops */
 	u32 ppt_pl2_sppt;
 	u32 ppt_pl1_spl;
 	u32 ppt_apu_sppt;
@@ -302,6 +303,9 @@ struct asus_wmi {
 	u32 ppt_fppt;
 	u32 nv_dynamic_boost;
 	u32 nv_temp_target;
+	bool panel_overdrive_available;
+	u32 mini_led_dev_id;
+	#endif
 
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
@@ -320,9 +324,6 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
-	bool panel_overdrive_available;
-	u32 mini_led_dev_id;
-
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
 	struct mutex wmi_lock;
@@ -336,6 +337,15 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
+static void asus_wmi_show_deprecated(void)
+{
+	pr_notice_once("Accessing attributes through /sys/bus/platform/asus_wmi is " +
+		"deprecated and will be removed in a future release.  Please switch " +
+		"over to /sys/class/firmware_attributes.\n");
+}
+#endif
+
 /* WMI ************************************************************************/
 
 static int asus_wmi_evaluate_method3(u32 method_id,
@@ -732,6 +742,7 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 }
 
 /* Charging mode, 1=Barrel, 2=USB ******************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t charge_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -742,12 +753,16 @@ static ssize_t charge_mode_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", value & 0xff);
 }
 
 static DEVICE_ATTR_RO(charge_mode);
+#endif
 
 /* dGPU ********************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t dgpu_disable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -758,6 +773,8 @@ static ssize_t dgpu_disable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -811,8 +828,10 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(dgpu_disable);
+#endif
 
 /* eGPU ********************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t egpu_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -823,6 +842,8 @@ static ssize_t egpu_enable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -879,8 +900,10 @@ static ssize_t egpu_enable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(egpu_enable);
+#endif
 
 /* Is eGPU connected? *********************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t egpu_connected_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -891,12 +914,16 @@ static ssize_t egpu_connected_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
 static DEVICE_ATTR_RO(egpu_connected);
+#endif
 
 /* gpu mux switch *************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t gpu_mux_mode_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -907,6 +934,8 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -965,6 +994,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(gpu_mux_mode);
+#endif
 
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static ssize_t kbd_rgb_mode_store(struct device *dev,
@@ -1088,6 +1118,7 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 };
 
 /* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
@@ -1126,6 +1157,8 @@ static ssize_t ppt_pl2_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
 }
 static DEVICE_ATTR_RW(ppt_pl2_sppt);
@@ -1168,6 +1201,8 @@ static ssize_t ppt_pl1_spl_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
 }
 static DEVICE_ATTR_RW(ppt_pl1_spl);
@@ -1211,6 +1246,8 @@ static ssize_t ppt_fppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
 }
 static DEVICE_ATTR_RW(ppt_fppt);
@@ -1254,6 +1291,8 @@ static ssize_t ppt_apu_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
 }
 static DEVICE_ATTR_RW(ppt_apu_sppt);
@@ -1297,6 +1336,8 @@ static ssize_t ppt_platform_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
 }
 static DEVICE_ATTR_RW(ppt_platform_sppt);
@@ -1340,6 +1381,8 @@ static ssize_t nv_dynamic_boost_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
 }
 static DEVICE_ATTR_RW(nv_dynamic_boost);
@@ -1383,11 +1426,15 @@ static ssize_t nv_temp_target_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
 }
 static DEVICE_ATTR_RW(nv_temp_target);
+#endif
 
 /* Ally MCU Powersave ********************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t mcu_powersave_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -1398,6 +1445,8 @@ static ssize_t mcu_powersave_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -1433,6 +1482,7 @@ static ssize_t mcu_powersave_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(mcu_powersave);
+#endif
 
 /* Battery ********************************************************************/
 
@@ -2296,6 +2346,7 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 }
 
 /* Panel Overdrive ************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t panel_od_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2306,6 +2357,8 @@ static ssize_t panel_od_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2342,9 +2395,10 @@ static ssize_t panel_od_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(panel_od);
+#endif
 
 /* Bootup sound ***************************************************************/
-
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t boot_sound_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -2355,6 +2409,8 @@ static ssize_t boot_sound_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2390,8 +2446,10 @@ static ssize_t boot_sound_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(boot_sound);
+#endif
 
 /* Mini-LED mode **************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2422,6 +2480,8 @@ static ssize_t mini_led_mode_show(struct device *dev,
 		}
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", value);
 }
 
@@ -2492,10 +2552,13 @@ static ssize_t available_mini_led_mode_show(struct device *dev,
 		return sysfs_emit(buf, "0 1 2\n");
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "0\n");
 }
 
 static DEVICE_ATTR_RO(available_mini_led_mode);
+#endif
 
 /* Quirks *********************************************************************/
 
@@ -4477,27 +4540,29 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
-	&dev_attr_charge_mode.attr,
-	&dev_attr_egpu_enable.attr,
-	&dev_attr_egpu_connected.attr,
-	&dev_attr_dgpu_disable.attr,
-	&dev_attr_gpu_mux_mode.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
-	&dev_attr_ppt_pl2_sppt.attr,
-	&dev_attr_ppt_pl1_spl.attr,
-	&dev_attr_ppt_fppt.attr,
-	&dev_attr_ppt_apu_sppt.attr,
-	&dev_attr_ppt_platform_sppt.attr,
-	&dev_attr_nv_dynamic_boost.attr,
-	&dev_attr_nv_temp_target.attr,
-	&dev_attr_mcu_powersave.attr,
-	&dev_attr_boot_sound.attr,
-	&dev_attr_panel_od.attr,
-	&dev_attr_mini_led_mode.attr,
-	&dev_attr_available_mini_led_mode.attr,
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
+		&dev_attr_charge_mode.attr,
+		&dev_attr_egpu_enable.attr,
+		&dev_attr_egpu_connected.attr,
+		&dev_attr_dgpu_disable.attr,
+		&dev_attr_gpu_mux_mode.attr,
+		&dev_attr_ppt_pl2_sppt.attr,
+		&dev_attr_ppt_pl1_spl.attr,
+		&dev_attr_ppt_fppt.attr,
+		&dev_attr_ppt_apu_sppt.attr,
+		&dev_attr_ppt_platform_sppt.attr,
+		&dev_attr_nv_dynamic_boost.attr,
+		&dev_attr_nv_temp_target.attr,
+		&dev_attr_mcu_powersave.attr,
+		&dev_attr_boot_sound.attr,
+		&dev_attr_panel_od.attr,
+		&dev_attr_mini_led_mode.attr,
+		&dev_attr_available_mini_led_mode.attr,
+	#endif
 	NULL
 };
 
@@ -4519,7 +4584,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
-	else if (attr == &dev_attr_charge_mode.attr)
+	else if (attr == &dev_attr_fan_boost_mode.attr)
+		ok = asus->fan_boost_mode_available;
+
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
+	if (attr == &dev_attr_charge_mode.attr)
 		devid = ASUS_WMI_DEVID_CHARGE_MODE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
@@ -4557,6 +4626,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
+	#endif /* CONFIG_ASUS_WMI_BIOS */
 
 	if (devid != -1) {
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4797,6 +4867,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_platform;
 
 	/* ensure defaults for tunables */
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 	asus->ppt_pl2_sppt = 5;
 	asus->ppt_pl1_spl = 5;
 	asus->ppt_apu_sppt = 5;
@@ -4808,8 +4879,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
@@ -4820,6 +4889,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+	#endif
+
+	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
+						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
-- 
2.45.2


