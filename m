Return-Path: <linux-kernel+bounces-253353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C32931FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6282838A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0C22F11;
	Tue, 16 Jul 2024 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iUCkbdUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDNl9mnZ"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97C224D4;
	Tue, 16 Jul 2024 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107007; cv=none; b=QrutWaYaLcNYqWSq4mGwnvM6gyrxra3t5ZyOi0tT7qUo5zuWZskvSzLe+WuT7YduyakWqM9ANLwM578uG+fdwnvU7jLQX5x/IxWBDiFISrQME8jjee9AY4Fs+931ul0zGrXvp+AjEZl0k4gDn9HikQbXPGMXFEc7iLi5eGl968o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107007; c=relaxed/simple;
	bh=+f2dVQN4g89Fw2HyImwf61EWmJRbHhC5tigvz5CIgMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT1Hr7/BaC8TuNUkckynWJjMDnIPilc7oB/mTMvpeyBK6JStSGJlQUbo+3dnp1R4PQBVj1lDjJyiDHAzafaZesWtSBBxp55iv9m7IiplLXgTeWoss6AojYofS2RyYKyIXvJo+Quu+1eQYArEDrdv36i8TT9Xjr71DN31Ypmc1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iUCkbdUU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDNl9mnZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 976FD1388C48;
	Tue, 16 Jul 2024 01:16:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Jul 2024 01:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721107004; x=
	1721193404; bh=H0niasfTQ65rb/ipH5vyaIeIw2H0hcDxH6mzlLciZqM=; b=i
	UCkbdUU0ayBZvQNkuBhbB7M95IH5IVJNJ0JJ+jqjyDLKYHt62cJDkKn7ApuuXW+T
	IUdm6LqElpmS1WWokPsFcb2tUQtFqYKoi3M1v0skW2RYZunQl5L1dUlbs6fQhzQ8
	IabrWOVAp6dkByOhmPxSmP9DZrM1XY2srj+nyYa39HVgN84Wnu5AOr+I10/RiAlD
	ZgUBvBuQ+9OrNQpf2zNqBgPf4PeNcfWuJlgcX/pZ3V2mRIRRuGtciIPlo4ymef8H
	2AL+L8rhokzSc1XWvATQpYjCAycLH/b/Gk7gXbP7nIicbHR5xO+P0kJP0OWH2iME
	xLlujC5cW9BrZIdrM+rjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721107004; x=
	1721193404; bh=H0niasfTQ65rb/ipH5vyaIeIw2H0hcDxH6mzlLciZqM=; b=K
	DNl9mnZSI8dm+yhm9jW2FfpHFa+SOeVxAhS8mO/jwAwB46yfUC/Ec9lrnJrRHZIb
	QwtTvi0OmF5W7WAUWrsHiBF05OvWE64EgtTxO/01GKU1N9/4zCPV+AwzLUUa3sa/
	vF5edGg8Expy3g3FBnOuBZdhaemn/JrIuUZOz3o6LosRJSJmwJkq+N6Mrt6NQCvE
	/Mav7qizQeP/lwff0/NNVDgNAOlT7xMfHthVe1b93IRwTydovGElOTMt1I6pMfdI
	Q12usxQQ2L1QqrcvsL/oTKYI/+KbFQSnvtapZLKhIH69rfGWXsOjM0wX/nO6uBG4
	nOKwoPQJsF7lUhIaYej9w==
X-ME-Sender: <xms:OwKWZixw0tJklfR0TCSNRF2PlFyXYcYUEbhDOUcEW27iIxnUo49Wlw>
    <xme:OwKWZuRm56wDLBwe2pHUP0DVBWpD7fnh4G2oDX6OYwD7Ou4TNKC1hfK_FXrmqyHTo
    kZx5dxJ6Dxl4Ej1HbA>
X-ME-Received: <xmr:OwKWZkX_hw7GRcNTDXRituDeTn6l3NhflPdVEP358Il-vFGXUAA4jpVVWiqj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:OwKWZogav82RC87FfKBF14HvE4WXXD5_bBvljrJxhkChpdDXd5w1Ow>
    <xmx:OwKWZkBA2O1i2dTkAciqTPqlljMJ8ISudnO5dzI3Mme3qi3ux8Oe7g>
    <xmx:OwKWZpJ3s8pZ2jVfzBv-ahAruA_St5SsvNhDa4eYrvbglf6ngocfeA>
    <xmx:OwKWZrCmDNXuwwhHFOAwxh8Psw1pTPon5Uks7komVcksoeowIL-gvw>
    <xmx:PAKWZm04rCtzcFSwG-50v715sMv70RusTBIMgxrZO4pFvWm1FskjqNRR>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:40 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/5] asus-wmi: deprecate bios features
Date: Tue, 16 Jul 2024 17:16:12 +1200
Message-ID: <20240716051612.64842-6-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716051612.64842-1-luke@ljones.dev>
References: <20240716051612.64842-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c               | 126 ++++++++++++++----
 3 files changed, 123 insertions(+), 28 deletions(-)

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
index b4a5a5bec7f3..164c53ed06c3 100644
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
index 3f1998638fea..e5ae1b766929 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -269,11 +269,12 @@ struct asus_wmi {
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
@@ -281,6 +282,9 @@ struct asus_wmi {
 	u32 ppt_fppt;
 	u32 nv_dynamic_boost;
 	u32 nv_temp_target;
+	bool panel_overdrive_available;
+	u32 mini_led_dev_id;
+	#endif
 
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
@@ -299,9 +303,6 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
-	bool panel_overdrive_available;
-	u32 mini_led_dev_id;
-
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
 	struct mutex wmi_lock;
@@ -315,6 +316,15 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
+void asus_wmi_show_deprecated(void)
+{
+	pr_notice_once("Accessing attributes through /sys/bus/platform/asus_wmi is \
+		deprecated and will be removed in a future release.  Please switch \
+		over to /sys/class/firmware_attributes.");
+}
+#endif
+
 /* WMI ************************************************************************/
 
 static int asus_wmi_evaluate_method3(u32 method_id,
@@ -683,6 +693,7 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 }
 
 /* Charging mode, 1=Barrel, 2=USB ******************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t charge_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -693,12 +704,16 @@ static ssize_t charge_mode_show(struct device *dev,
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
@@ -709,6 +724,8 @@ static ssize_t dgpu_disable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -762,8 +779,10 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(dgpu_disable);
+#endif
 
 /* eGPU ********************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t egpu_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -774,6 +793,8 @@ static ssize_t egpu_enable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -830,8 +851,10 @@ static ssize_t egpu_enable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(egpu_enable);
+#endif
 
 /* Is eGPU connected? *********************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t egpu_connected_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -842,12 +865,16 @@ static ssize_t egpu_connected_show(struct device *dev,
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
@@ -858,6 +885,8 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -916,6 +945,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(gpu_mux_mode);
+#endif
 
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static ssize_t kbd_rgb_mode_store(struct device *dev,
@@ -1039,6 +1069,7 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 };
 
 /* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
@@ -1077,6 +1108,8 @@ static ssize_t ppt_pl2_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
 }
 static DEVICE_ATTR_RW(ppt_pl2_sppt);
@@ -1119,6 +1152,8 @@ static ssize_t ppt_pl1_spl_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
 }
 static DEVICE_ATTR_RW(ppt_pl1_spl);
@@ -1162,6 +1197,8 @@ static ssize_t ppt_fppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
 }
 static DEVICE_ATTR_RW(ppt_fppt);
@@ -1205,6 +1242,8 @@ static ssize_t ppt_apu_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
 }
 static DEVICE_ATTR_RW(ppt_apu_sppt);
@@ -1248,6 +1287,8 @@ static ssize_t ppt_platform_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
 }
 static DEVICE_ATTR_RW(ppt_platform_sppt);
@@ -1291,6 +1332,8 @@ static ssize_t nv_dynamic_boost_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
 }
 static DEVICE_ATTR_RW(nv_dynamic_boost);
@@ -1334,11 +1377,15 @@ static ssize_t nv_temp_target_show(struct device *dev,
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
@@ -1349,6 +1396,8 @@ static ssize_t mcu_powersave_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -1384,6 +1433,7 @@ static ssize_t mcu_powersave_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(mcu_powersave);
+#endif
 
 /* Battery ********************************************************************/
 
@@ -2213,6 +2263,7 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 }
 
 /* Panel Overdrive ************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t panel_od_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2223,6 +2274,8 @@ static ssize_t panel_od_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2259,9 +2312,10 @@ static ssize_t panel_od_store(struct device *dev,
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
@@ -2272,6 +2326,8 @@ static ssize_t boot_sound_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2307,8 +2363,10 @@ static ssize_t boot_sound_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(boot_sound);
+#endif
 
 /* Mini-LED mode **************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2339,6 +2397,8 @@ static ssize_t mini_led_mode_show(struct device *dev,
 		}
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", value);
 }
 
@@ -2409,10 +2469,13 @@ static ssize_t available_mini_led_mode_show(struct device *dev,
 		return sysfs_emit(buf, "0 1 2\n");
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "0\n");
 }
 
 static DEVICE_ATTR_RO(available_mini_led_mode);
+#endif
 
 /* Quirks *********************************************************************/
 
@@ -4378,27 +4441,29 @@ static struct attribute *platform_attributes[] = {
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
 
@@ -4420,7 +4485,13 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
-	else if (attr == &dev_attr_charge_mode.attr)
+	else if (attr == &dev_attr_fan_boost_mode.attr)
+		ok = asus->fan_boost_mode_available;
+	else if (attr == &dev_attr_throttle_thermal_policy.attr)
+		ok = asus->throttle_thermal_policy_available;
+
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
+	if (attr == &dev_attr_charge_mode.attr)
 		devid = ASUS_WMI_DEVID_CHARGE_MODE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
@@ -4430,10 +4501,6 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
 		ok = asus->gpu_mux_dev != 0;
-	else if (attr == &dev_attr_fan_boost_mode.attr)
-		ok = asus->fan_boost_mode_available;
-	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4458,6 +4525,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
+	#endif
 
 	if (devid != -1) {
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4698,6 +4766,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_platform;
 
 	/* ensure defaults for tunables */
+	#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
 	asus->ppt_pl2_sppt = 5;
 	asus->ppt_pl1_spl = 5;
 	asus->ppt_apu_sppt = 5;
@@ -4721,6 +4790,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+	#endif
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
-- 
2.45.2


