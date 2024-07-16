Return-Path: <linux-kernel+bounces-253349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B8931FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399FBB21A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0B17556;
	Tue, 16 Jul 2024 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Ik1i/wlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yk3zByfM"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268E17C91;
	Tue, 16 Jul 2024 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106990; cv=none; b=Aw7Mk6Rwd3gXUzHWwaw5fLOb6YlYW4C3jgHsy+qHKLYL9OhLshqL5bW8IvbQp+S8MCv7frzCw4KHX+DyCMiV2qlbMCN9CM1C3gUI7jbkF1unrar5wrpLnth5mRECUEarofjpIlAuQt0wKfLQ0zCYaBbFpZcPMwiO0fEP5Hy1hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106990; c=relaxed/simple;
	bh=EFE5t35h2sRxEjeqexTC3RifxfPIlUY5XvljmkaNSKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DU7PJxiQktNcSbzwEFJgMP3wDO2iGr5v3q2a5MVTMKDGgAHE3z3fJQsTX0SnJGT/CcQVWRDFQ+ohHLN0DzD0iDv9f5hdIrpjokhtaSLQrfRvWqT5pjHUFkSE+PScy1qg5OqbKYqv8lBSEDOmS8OSIE5Og7RgHnbucZZY2Uk0Bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Ik1i/wlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yk3zByfM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D50B71388DD3;
	Tue, 16 Jul 2024 01:16:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 16 Jul 2024 01:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721106986;
	 x=1721193386; bh=mT3ntYteWzvuiganGdFXHoh+iwQqhv4yE2vOBXmoywA=; b=
	Ik1i/wlojzcXBIfLwq3TKGu5SbJBkJIDESy5MzdDhXOGF9LCh8bIA2tN8MKw94sq
	Zs2LcRtjFl40ymXv4z8nFy1Ve79hzONkoUNdK3qorp/uQCMrbSVOVrviIy/EZtQE
	lSzzHAjbPCKZFzHxEEA1a94kuSM63+3ieCwvo/oqrUa3C0K2vqkVR6v967TGIYRX
	Ov3unIPZVHfJZXTEGQuYw7gCRnAwzPO++0k7ywwjga5ptptetFUKd5fVWvJfx6jG
	UbrmlJx+Z0wLNhgaHcJT+eoM5mi2HaMsv98loHaQrWovIuiUjf+EALHJ4PQSZ3nj
	NsXsqMmTEJE6EpACMWDmFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721106986; x=
	1721193386; bh=mT3ntYteWzvuiganGdFXHoh+iwQqhv4yE2vOBXmoywA=; b=Y
	k3zByfMKGCqnaiVQRUDBlSv6bXiOsyxRkxa7uNywdDEq2BnWuFS/JQ7ai5IFYs4g
	7/4Ho/ESAzQB6+gQJB/qEPt8BPv22gb0kdedPuXKFvtwHgamtPTt0m1gtbOhFRNm
	VO06aU3M2XvLSjzRrMF2L5rbYjGGzgE/9lHBPHm2fDLqh0vgrVBiIu/uALlVZ36a
	uYjHvHfg18vAFfPaEIxqeuBMb6zCgtwwgkRMRlH1dE0FHfgcbHiYAq3PoWjaQBiM
	ORGHqib0ZIj464TVizDVitmbncMQqlzVv4ou/lPKz4ZJcrb1ZcJ2GtUyNezzHCzN
	NngIWIozG6VSRKAvHcypw==
X-ME-Sender: <xms:KQKWZr9_0pxuDcYb6Av3OTAdQ-gmZfPY4OVWj6v0apAih6fTWKvjvQ>
    <xme:KQKWZnsacJLkWK39AOPu0DSHVyGViTWrxwfSaj2H7beqCANQZxYkAeD0SKUeyy9vg
    asFtHoukrtN71YkriY>
X-ME-Received: <xmr:KQKWZpAgShxcWAfjs8lbn0_-X4py-i_tGPKNJZBxMoxEBJpr8LqMcflPc-6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepudduteduheeivddvveevlefhge
    ekfeffvdefteeugfevfefggfffieffiedtleeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:KQKWZnepdM7k3_5nGp_OUeRA2W-Hmx7NdcpPUakb6fvSimQOT3Tuew>
    <xmx:KQKWZgPW5F-bCdcAagipJmuzvVB-xuVlaBUwi-nTId2R7HH40Gddng>
    <xmx:KQKWZpltYNL3TcqbGbFN4WME8uTTzuPDLvCAct6m-Ke5Gd6yOVVCwA>
    <xmx:KQKWZquxL19zjjCSHGjuMqufoHjgu4riykrgQeKY8M66aqLPEa0Y8g>
    <xmx:KgKWZsBSa6RxKOwAtK43LHT2cnqC_1iQoYXYlTCt2AqIEalLv7Hn2bjb>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:22 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/5] platform/x86 asus-bioscfg: move existing tunings to asus-bioscfg module
Date: Tue, 16 Jul 2024 17:16:08 +1200
Message-ID: <20240716051612.64842-2-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716051612.64842-1-luke@ljones.dev>
References: <20240716051612.64842-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fw_attributes_class provides a much cleaner interface to all of the
attributes introduced to asus-wmi. This patch moves all of these extra
attributes over to fw_attributes_class, and shifts the bulk of these
definitions to a new kernel module to reduce the clutter of asus-wmi
with the intention of deprecating the asus-wmi attributes in future.

The work applies only to WMI methods which don't have a clearly defined
place within the sysfs and as a result ended up lumped together in
/sys/devices/platform/asus-nb-wmi/ with no standard API.

Where possible the fw attrs now implement defaults, min, max, scalar,
choices, etc. As en example dgpu_disable becomes:

/sys/class/firmware-attributes/asus-bioscfg/attributes/dgpu_disable/
├── current_value
├── display_name
├── possible_values
└── type

as do other attributes.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/Kconfig               |  14 +
 drivers/platform/x86/Makefile              |   1 +
 drivers/platform/x86/asus-bioscfg.c        | 666 +++++++++++++++++++++
 drivers/platform/x86/asus-bioscfg.h        | 243 ++++++++
 drivers/platform/x86/asus-wmi.c            |  18 +-
 include/linux/platform_data/x86/asus-wmi.h |  11 +
 6 files changed, 952 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/asus-bioscfg.c
 create mode 100644 drivers/platform/x86/asus-bioscfg.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa9524986..b4a5a5bec7f3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -265,6 +265,18 @@ config ASUS_WIRELESS
 	  If you choose to compile this driver as a module the module will be
 	  called asus-wireless.
 
+config ASUS_BIOS
+	tristate "ASUS BIOS Driver"
+	depends on ACPI_WMI
+	depends on ASUS_WMI
+	select FW_ATTR_CLASS
+	help
+	  Say Y here if you have a WMI aware Asus laptop and would like to use the
+	  firmware_attributes API.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called asus-bios.
+
 config ASUS_WMI
 	tristate "ASUS WMI Driver"
 	depends on ACPI_WMI
@@ -276,6 +288,8 @@ config ASUS_WMI
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on SERIO_I8042 || SERIO_I8042 = n
+	select ASUS_BIOS
+	select ASUS_WMI_BIOS
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b142947067..d9b5b3f3b241 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 # ASUS
 obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
 obj-$(CONFIG_ASUS_WIRELESS)	+= asus-wireless.o
+obj-$(CONFIG_ASUS_BIOS)		+= asus-bios.o
 obj-$(CONFIG_ASUS_WMI)		+= asus-wmi.o
 obj-$(CONFIG_ASUS_NB_WMI)	+= asus-nb-wmi.o
 obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
new file mode 100644
index 000000000000..0b34e727aab4
--- /dev/null
+++ b/drivers/platform/x86/asus-bioscfg.c
@@ -0,0 +1,666 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Asus BIOS attributes driver
+ *
+ * Copyright(C) 2010 Intel Corporation.
+ * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/platform_data/x86/asus-wmi.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/dmi.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+#include "asus-bios.h"
+#include "firmware_attributes_class.h"
+
+MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
+MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
+MODULE_LICENSE("GPL");
+
+#define ASUS_NB_WMI_EVENT_GUID	"0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
+
+MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
+
+#define ASUS_MINI_LED_MODE_MASK		0x03
+/* Standard modes for devices with only on/off */
+#define ASUS_MINI_LED_OFF		0x00
+#define ASUS_MINI_LED_ON		0x01
+/* New mode on some devices, define here to clarify remapping later */
+#define ASUS_MINI_LED_STRONG_MODE	0x02
+/* New modes for devices with 3 mini-led mode types */
+#define ASUS_MINI_LED_2024_WEAK		0x00
+#define ASUS_MINI_LED_2024_STRONG	0x01
+#define ASUS_MINI_LED_2024_OFF		0x02
+
+/* Default limits for tunables available on ASUS ROG laptops */
+#define PPT_CPU_LIMIT_MIN	5
+#define PPT_CPU_LIMIT_MAX	150
+#define PPT_CPU_LIMIT_DEFAULT	80
+#define PPT_PLATFORM_MIN	5
+#define PPT_PLATFORM_MAX	100
+#define PPT_PLATFORM_DEFAULT	80
+#define NVIDIA_BOOST_MIN	5
+#define NVIDIA_BOOST_MAX	25
+#define NVIDIA_TEMP_MIN		75
+#define NVIDIA_TEMP_MAX		87
+
+/* Tunables provided by ASUS for gaming laptops */
+struct rog_tunables {
+	u32 cpu_default;
+	u32 cpu_max;
+
+	u32 platform_default;
+	u32 platform_max;
+
+	u32 ppt_pl1_spl; // cpu
+	u32 ppt_pl2_sppt; // cpu
+	u32 ppt_apu_sppt; // plat
+	u32 ppt_platform_sppt; // plat
+	u32 ppt_fppt; // cpu
+
+	u32 nv_boost_default;
+	u32 nv_boost_max;
+	u32 nv_dynamic_boost;
+
+	u32 nv_temp_default;
+	u32 nv_temp_max;
+	u32 nv_temp_target;
+};
+
+static const struct class *fw_attr_class;
+
+struct asus_bios_priv {
+	struct device *fw_attr_dev;
+	struct kset *fw_attr_kset;
+
+	struct rog_tunables *rog_tunables;
+	u32 mini_led_dev_id;
+	u32 gpu_mux_dev_id;
+	bool dgpu_disable_available;
+	bool egpu_enable_available;
+
+	struct mutex mutex;
+} asus_bioscfg = {
+	.mutex = __MUTEX_INITIALIZER(asus_bioscfg.mutex),
+};
+
+static struct fw_attrs_group {
+	u32 pending_reboot;
+} fw_attrs = {
+	.pending_reboot = 0,
+};
+
+/* WMI helper methods */
+static bool asus_wmi_is_present(u32 dev_id)
+{
+	int status = asus_wmi_get_devstate_dsts(dev_id, &retval);
+	u32 retval;
+
+	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
+
+	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
+}
+
+static void asus_set_reboot_and_signal_event(void)
+{
+	fw_attrs.pending_reboot = 1;
+	kobject_uevent(&asus_bioscfg.fw_attr_dev->kobj, KOBJ_CHANGE);
+}
+
+static ssize_t pending_reboot_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *buf)
+{
+	return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
+}
+
+static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
+
+static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
+{
+	return !strcmp(attr->attr.name, "gpu_mux_mode");
+		!strcmp(attr->attr.name, "panel_hd_mode");
+}
+
+/*
+ * Generic store function for use with many ROG tunables
+ */
+static ssize_t attr_int_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count,
+				u32 min, u32 max, u32 *store_value, u32 wmi_dev)
+{
+	int result, value;
+
+	result = kstrtoint(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value < min || value > max)
+		return -EINVAL;
+
+	asus_wmi_set_devstate(wmi_dev, value, &result);
+	if (result) {
+		pr_err("Failed to set %s: %d\n", attr->attr.name, result);
+		return result;
+	}
+
+	if (result > 1) {
+		pr_err("Failed to set %s (result): 0x%x\n", attr->attr.name, result);
+		return -EIO;
+	}
+
+	if (store_value != NULL)
+		*store_value = value;
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	if (asus_bios_requires_reboot(attr))
+		asus_set_reboot_and_signal_event();
+
+	return count;
+}
+
+/* Mini-LED mode **************************************************************/
+static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	u32 value;
+	int err;
+
+	err = asus_wmi_get_devstate_dsts(asus_bioscfg.mini_led_dev_id, &value);
+	if (err)
+		return err;
+
+	value = value & ASUS_MINI_LED_MODE_MASK;
+
+	/*
+	 * Remap the mode values to match previous generation mini-led. The last gen
+	 * WMI 0 == off, while on this version WMI 2 ==off (flipped).
+	 */
+	if (asus_bioscfg.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (value) {
+		case ASUS_MINI_LED_2024_WEAK:
+			value = ASUS_MINI_LED_ON;
+			break;
+		case ASUS_MINI_LED_2024_STRONG:
+			value = ASUS_MINI_LED_STRONG_MODE;
+			break;
+		case ASUS_MINI_LED_2024_OFF:
+			value = ASUS_MINI_LED_OFF;
+			break;
+		}
+	}
+
+	return sysfs_emit(buf, "%d\n", value);
+}
+
+static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
+						struct kobj_attribute *attr,
+						const char *buf, size_t count)
+{
+	int result, err;
+	u32 mode;
+
+	result = kstrtou32(buf, 10, &mode);
+	if (result)
+		return result;
+
+	if (asus_bioscfg.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
+	    mode > ASUS_MINI_LED_ON)
+		return -EINVAL;
+	if (asus_bioscfg.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
+	    mode > ASUS_MINI_LED_STRONG_MODE)
+		return -EINVAL;
+
+	/*
+	 * Remap the mode values so expected behaviour is the same as the last
+	 * generation of mini-LED with 0 == off, 1 == on.
+	 */
+	if (asus_bioscfg.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (mode) {
+		case ASUS_MINI_LED_OFF:
+			mode = ASUS_MINI_LED_2024_OFF;
+			break;
+		case ASUS_MINI_LED_ON:
+			mode = ASUS_MINI_LED_2024_WEAK;
+			break;
+		case ASUS_MINI_LED_STRONG_MODE:
+			mode = ASUS_MINI_LED_2024_STRONG;
+			break;
+		}
+	}
+
+	err = asus_wmi_set_devstate(asus_bioscfg.mini_led_dev_id, mode, &result);
+	if (err) {
+		pr_warn("Failed to set mini-LED: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	return count;
+}
+
+static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	switch (asus_bioscfg.mini_led_dev_id) {
+	case ASUS_WMI_DEVID_MINI_LED_MODE:
+		return sysfs_emit(buf, "0;1\n");
+	case ASUS_WMI_DEVID_MINI_LED_MODE2:
+		return sysfs_emit(buf, "0;1;2\n");
+	}
+
+	return sysfs_emit(buf, "0\n");
+}
+
+ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED backlight mode");
+
+static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int result, err;
+	u32 optimus;
+
+	err = kstrtou32(buf, 10, &optimus);
+	if (err)
+		return err;
+
+	if (optimus > 1)
+		return -EINVAL;
+
+	if (asus_bioscfg.dgpu_disable_available) {
+		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
+		if (err)
+			return err;
+		if (err && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %d\n", err);
+			return err;
+		}
+	}
+
+	if (asus_bioscfg.egpu_enable_available) {
+		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
+		if (err)
+			return err;
+		if (result && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n", err);
+			return err;
+		}
+	}
+
+	err = asus_wmi_set_devstate(asus_bioscfg.gpu_mux_dev_id, optimus, &result);
+	if (err) {
+		pr_err("%s Failed to set GPU MUX mode: %d\nn", __func__, err);
+		return err;
+	}
+	/* !1 is considered a fail by ASUS */
+	if (result != 1) {
+		pr_warn("%s Failed to set GPU MUX mode (result): 0x%x\n", __func__, result);
+		return -EIO;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	return count;
+}
+WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_bioscfg.gpu_mux_dev_id);
+ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
+
+/*
+ * A user may be required to store the value twice, typcial store first, then
+ * rescan PCI bus to activate power, then store a second time to save correctly.
+ * The reason for this is that an extra code path in the ACPI is enabled when
+ * the device and bus are powered.
+ */
+static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int result, err;
+	u32 disable;
+
+	result = kstrtou32(buf, 10, &disable);
+	if (result)
+		return result;
+
+	if (disable > 1)
+		return -EINVAL;
+
+	if (asus_bioscfg.gpu_mux_dev_id) {
+		err = asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &result);
+		if (err)
+			return err;
+		if (!result && disable) {
+			err = -ENODEV;
+			pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\n", err);
+			return err;
+		}
+	}
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
+	if (err) {
+		pr_warn("Failed to set dgpu disable: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set dgpu disable (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	return count;
+}
+WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
+ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU");
+
+/* The ACPI call to enable the eGPU also disables the internal dGPU */
+static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int result, err;
+	u32 enable;
+
+	err = kstrtou32(buf, 10, &enable);
+	if (err)
+		return err;
+
+	if (enable > 1)
+		return -EINVAL;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &result);
+	if (err) {
+		pr_warn("Failed to get egpu connection status: %d\n", err);
+		return err;
+	}
+
+	if (asus_bioscfg.gpu_mux_dev_id) {
+		err = asus_wmi_get_devstate_dsts(asus_bioscfg.gpu_mux_dev_id, &result);
+		if (err) {
+			pr_warn("Failed to get gpu mux status: %d\n", result);
+			return result;
+		}
+		if (!result && enable) {
+			err = -ENODEV;
+			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
+			return err;
+		}
+	}
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
+	if (err) {
+		pr_warn("Failed to set egpu state: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	return count;
+}
+WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
+ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
+
+/* Simple attribute creation */
+ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+		0, 3, "0;1;2", "Set the thermal profile: 0=normal, 1=performance, 2=quiet");
+ATTR_GROUP_PPT_RW(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL,
+		cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
+ATTR_GROUP_PPT_RW(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT,
+		cpu_default, 5, cpu_max, 1, "Set the CPU fast package limit");
+ATTR_GROUP_PPT_RW(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
+		platform_default, 5, platform_max, 1, "Set the CPU slow package limit");
+ATTR_GROUP_PPT_RW(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
+		platform_default, 5, platform_max, 1, "Set the CPU slow package limit");
+ATTR_GROUP_PPT_RW(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT,
+		cpu_default, 5, cpu_max, 1, "Set the CPU slow package limit");
+
+ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
+		nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boost limit");
+ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
+		nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal limit");
+
+ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE,
+		"0;1;2", "Show the current mode of charging");
+ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
+		"Set the boot POST sound");
+ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
+		"Set MCU powersaving mode");
+ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
+		"Set the panel refresh overdrive");
+ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+		"Set the panel HD mode to UHD<0> or FHD<1>");
+ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
+	"Show the eGPU connection status");
+
+static int asus_fw_attr_add(void)
+{
+	int ret;
+
+	ret = fw_attributes_class_get(&fw_attr_class);
+	if (ret)
+		goto fail_class_created;
+	else
+		asus_bioscfg.fw_attr_dev = device_create(fw_attr_class, NULL,
+			MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
+
+	if (IS_ERR(asus_bioscfg.fw_attr_dev)) {
+		ret = PTR_ERR(asus_bioscfg.fw_attr_dev);
+		goto fail_class_created;
+	}
+
+	asus_bioscfg.fw_attr_kset = kset_create_and_add("attributes", NULL,
+				&asus_bioscfg.fw_attr_dev->kobj);
+	if (!asus_bioscfg.fw_attr_dev) {
+		ret = -ENOMEM;
+		pr_debug("Failed to create and add attributes\n");
+		goto err_destroy_classdev;
+	}
+
+	/* Add any firmware_attributes required */
+	ret = sysfs_create_file(&asus_bioscfg.fw_attr_kset->kobj, &pending_reboot.attr);
+	if (ret) {
+		pr_warn("Failed to create sysfs level attributes\n");
+		goto fail_class_created;
+	}
+
+	// TODO: logging
+	asus_bioscfg.mini_led_dev_id = 0;
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
+		asus_bioscfg.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mode_attr_group);
+	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
+		asus_bioscfg.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mini_led_mode_attr_group);
+	}
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
+		asus_bioscfg.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
+	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
+		asus_bioscfg.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
+	}
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
+		asus_bioscfg.dgpu_disable_available = true;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_disable_attr_group);
+	}
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
+		asus_bioscfg.egpu_enable_available = true;
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_enable_attr_group);
+	}
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connected_attr_group);
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_policy_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl1_spl_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL2_SPPT))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_pl2_sppt_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_APU_SPPT))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_apu_sppt_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PLAT_SPPT))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_platform_sppt_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_FPPT))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &ppt_fppt_attr_group);
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_DYN_BOOST))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_boost_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_target_attr_group);
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_BOOT_SOUND))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &boot_sound_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_MCU_POWERSAVE))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &mcu_powersave_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_OD))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_od_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_PANEL_HD))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &panel_hd_mode_attr_group);
+
+	return 0;
+
+err_destroy_classdev:
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+
+fail_class_created:
+	fw_attributes_class_put();
+	return ret;
+}
+
+/* Init / exit ****************************************************************/
+
+/* Set up the min/max and defaults for ROG tunables */
+static void init_rog_tunables(struct rog_tunables *rog)
+{
+	const char *product;
+	u32 max_boost = NVIDIA_BOOST_MAX;
+	u32 cpu_default = PPT_CPU_LIMIT_DEFAULT;
+	u32 cpu_max = PPT_CPU_LIMIT_MAX;
+	u32 platform_default = PPT_PLATFORM_DEFAULT;
+	u32 platform_max = PPT_PLATFORM_MAX;
+
+	/*
+	 * ASUS product_name contains everything required, e.g,
+	 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
+	 */
+	product = dmi_get_system_info(DMI_PRODUCT_NAME);
+
+	if (strstr(product, "GA402R")) {
+		cpu_default = 125;
+	} else if (strstr(product, "13QY")) {
+		cpu_max = 250;
+	} else if (strstr(product, "X13")) {
+		cpu_max = 75;
+		cpu_default = 50;
+	} else if (strstr(product, "RC71")) {
+		cpu_max = 50;
+		cpu_default = 30;
+	} else if (strstr(product, "G814")
+		|| strstr(product, "G614")
+		|| strstr(product, "G834")
+		|| strstr(product, "G634")) {
+		cpu_max = 175;
+	} else if (strstr(product, "GA402X")
+		|| strstr(product, "GA403")
+		|| strstr(product, "FA507N")
+		|| strstr(product, "FA507X")
+		|| strstr(product, "FA707N")
+		|| strstr(product, "FA707X")) {
+		cpu_max = 90;
+	}
+
+	if (strstr(product, "GZ301ZE"))
+		max_boost = 5;
+	else if (strstr(product, "FX507ZC4"))
+		max_boost = 15;
+	else if (strstr(product, "GU605"))
+		max_boost = 20;
+
+	/* ensure defaults for tunables */
+	rog->cpu_default = cpu_default;
+	rog->cpu_max = cpu_max;
+
+	rog->platform_default = platform_default;
+	rog->platform_max = platform_max;
+
+	rog->ppt_pl1_spl = cpu_default;
+	rog->ppt_pl2_sppt = cpu_default;
+	rog->ppt_apu_sppt = cpu_default;
+
+	rog->ppt_platform_sppt = platform_default;
+	rog->ppt_fppt = platform_default;
+
+	rog->nv_boost_default = NVIDIA_BOOST_MAX;
+	rog->nv_boost_max = max_boost;
+	rog->nv_dynamic_boost = NVIDIA_BOOST_MIN;
+
+	rog->nv_temp_default = NVIDIA_TEMP_MAX;
+	rog->nv_temp_max = NVIDIA_TEMP_MAX;
+	rog->nv_temp_target = NVIDIA_TEMP_MIN;
+
+}
+
+static int __init asus_fw_init(void)
+{
+	int err;
+
+	mutex_lock(&asus_bioscfg.mutex);
+
+	asus_bioscfg.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
+	if (!asus_bioscfg.rog_tunables) {
+		mutex_unlock(&asus_bioscfg.mutex);
+		return -ENOMEM;
+	}
+	init_rog_tunables(asus_bioscfg.rog_tunables);
+
+	err = asus_fw_attr_add();
+	mutex_unlock(&asus_bioscfg.mutex);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void __exit asus_fw_exit(void)
+{
+	mutex_lock(&asus_bioscfg.mutex);
+
+	sysfs_remove_file(&asus_bioscfg.fw_attr_kset->kobj, &pending_reboot.attr);
+	kset_unregister(asus_bioscfg.fw_attr_kset);
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+	fw_attributes_class_put();
+
+	mutex_unlock(&asus_bioscfg.mutex);
+}
+
+module_init(asus_fw_init);
+module_exit(asus_fw_exit);
diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/asus-bioscfg.h
new file mode 100644
index 000000000000..403563c25f53
--- /dev/null
+++ b/drivers/platform/x86/asus-bioscfg.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Definitions for kernel modules using asus-bios driver
+ *
+ *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
+ */
+
+#ifndef _ASUS_BIOSCFG_H_
+#define _ASUS_BIOSCFG_H_
+
+#include "firmware_attributes_class.h"
+#include <linux/types.h>
+
+#define DRIVER_NAME	"asus-bioscfg"
+
+static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count,
+				u32 min, u32 max, u32 *store_value, u32 wmi_dev);
+
+
+static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+
+static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "enumeration\n");
+}
+
+#define __ASUS_ATTR_RO(_func, _name) {				\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+	.show	= _func##_##_name##_show,			\
+}
+
+#define __ASUS_ATTR_RO_AS(_name, _show) {			\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+	.show	= _show,					\
+}
+
+#define __ASUS_ATTR_RW(_func, _name) __ATTR(_name, 0644,	\
+		_func##_##_name##_show, _func##_##_name##_store)
+
+#define __WMI_STORE_INT(_attr, _min, _max, _wmi)				\
+static ssize_t _attr##_store(struct kobject *kobj,				\
+			struct kobj_attribute *attr,				\
+			const char *buf, size_t count)				\
+{										\
+	return attr_int_store(kobj, attr, buf, count, _min, _max, NULL, _wmi);	\
+}
+
+#define WMI_SHOW_INT(_attr, _fmt, _wmi)				\
+static ssize_t _attr##_show(struct kobject *kobj,		\
+			struct kobj_attribute *attr, char *buf)	\
+{								\
+	u32 result;						\
+	int err;						\
+	err = asus_wmi_get_devstate_dsts(_wmi, &result);	\
+	if (err)						\
+		return err;					\
+	return sysfs_emit(buf, _fmt,				\
+		result & ~ASUS_WMI_DSTS_PRESENCE_BIT);		\
+}
+
+/* Create functions and attributes for use in other macros or on their own */
+
+#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)			\
+static ssize_t _attr##_current_value_store(struct kobject *kobj,	\
+			struct kobj_attribute *attr,			\
+			const char *buf, size_t count)			\
+{									\
+	return attr_int_store(kobj, attr, buf, count,			\
+		_min, asus_bioscfg.rog_tunables->_max,			\
+		&asus_bioscfg.rog_tunables->_attr, _wmi);		\
+}									\
+static ssize_t _attr##_current_value_show(struct kobject *kobj,		\
+			struct kobj_attribute *attr, char *buf)		\
+{									\
+	return sysfs_emit(buf, "%u\n", asus_bioscfg.rog_tunables->_attr);\
+}									\
+static struct kobj_attribute attr_##_attr##_current_value =		\
+	__ASUS_ATTR_RW(_attr, current_value)
+
+#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)			\
+static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,		\
+			struct kobj_attribute *attr, char *buf)		\
+{									\
+	return sysfs_emit(buf, "%d\n", asus_bioscfg.rog_tunables->_val);\
+}									\
+static struct kobj_attribute attr_##_attrname##_##_prop =		\
+	__ASUS_ATTR_RO(_attrname, _prop)
+
+#define __ATTR_CURRENT_INT_RO(_attr, _wmi)	\
+WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);		\
+static struct kobj_attribute attr_##_attr##_current_value =	\
+	__ASUS_ATTR_RO(_attr, current_value)
+
+#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)	\
+__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi);	\
+WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);		\
+static struct kobj_attribute attr_##_attr##_current_value =	\
+	__ASUS_ATTR_RW(_attr, current_value)
+
+/* Shows a formatted static variable */
+#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)		\
+static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,	\
+			struct kobj_attribute *attr, char *buf)	\
+{								\
+	return sysfs_emit(buf, _fmt, _val);			\
+}								\
+static struct kobj_attribute attr_##_attrname##_##_prop =	\
+	__ASUS_ATTR_RO(_attrname, _prop)
+
+/* Int style min/max range, base macro. Requires current_value show&|store */
+#define __ATTR_GROUP_INT(_attrname, _fsname, _default,		\
+				_min, _max, _incstep, _dispname)\
+__ATTR_SHOW_FMT(default_value, _attrname, "%d\n", _default);	\
+__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min);		\
+__ATTR_SHOW_FMT(max_value, _attrname, "%d\n", _max);		\
+__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);	\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
+static struct kobj_attribute attr_##_attrname##_type =		\
+	__ASUS_ATTR_RO_AS(type, int_type_show);			\
+static struct attribute *_attrname##_attrs[] = {		\
+		&attr_##_attrname##_current_value.attr,		\
+		&attr_##_attrname##_default_value.attr,		\
+		&attr_##_attrname##_min_value.attr,		\
+		&attr_##_attrname##_max_value.attr,		\
+		&attr_##_attrname##_scalar_increment.attr,	\
+		&attr_##_attrname##_display_name.attr,		\
+		&attr_##_attrname##_type.attr,			\
+		NULL						\
+};								\
+static const struct attribute_group _attrname##_attr_group = {	\
+		.name = _fsname,				\
+		.attrs = _attrname##_attrs			\
+}
+
+/* Boolean style enumeration, base macro. Requires adding show/store */
+#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)	\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
+__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);		\
+static struct kobj_attribute attr_##_attrname##_type =			\
+	__ASUS_ATTR_RO_AS(type, enum_type_show);			\
+static struct attribute *_attrname##_attrs[] = {			\
+		&attr_##_attrname##_current_value.attr,			\
+		&attr_##_attrname##_display_name.attr,			\
+		&attr_##_attrname##_possible_values.attr,		\
+		&attr_##_attrname##_type.attr,				\
+		NULL							\
+};									\
+static const struct attribute_group _attrname##_attr_group = {		\
+		.name = _fsname,					\
+		.attrs = _attrname##_attrs				\
+}
+
+#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)	\
+do {								\
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);			\
+	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
+} while (0)
+
+#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)	\
+do {								\
+	__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);		\
+	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname);\
+} while (0)
+
+/*
+ * Requires <name>_current_value_show(), <name>_current_value_show()
+ */
+#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)	\
+static struct kobj_attribute attr_##_attrname##_current_value = \
+	__ASUS_ATTR_RW(_attrname, current_value);		\
+__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
+
+#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi,		\
+					_possible, _dispname)		\
+do {									\
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);				\
+	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname);	\
+} while (0)
+
+#define ATTR_GROUP_ENUM_INT_RW(_attrname, _fsname, _wmi, _min,		\
+				_max, _possible, _dispname)		\
+do {									\
+	__ATTR_CURRENT_INT_RW(_attrname, _min, _max, _wmi);		\
+	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname);	\
+} while (0)
+
+/*
+ * Requires <name>_current_value_show(), <name>_current_value_show()
+ * and <name>_possible_values_show()
+ */
+#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)		\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
+static struct kobj_attribute attr_##_attrname##_current_value =		\
+	__ASUS_ATTR_RW(_attrname, current_value);			\
+static struct kobj_attribute attr_##_attrname##_possible_values =	\
+	__ASUS_ATTR_RO(_attrname, possible_values);			\
+static struct kobj_attribute attr_##_attrname##_type =			\
+	__ASUS_ATTR_RO_AS(type, enum_type_show);			\
+static struct attribute *_attrname##_attrs[] = {			\
+			&attr_##_attrname##_current_value.attr,		\
+			&attr_##_attrname##_display_name.attr,		\
+			&attr_##_attrname##_possible_values.attr,	\
+			&attr_##_attrname##_type.attr,			\
+			NULL						\
+};									\
+static const struct attribute_group _attrname##_attr_group = {		\
+			.name = _fsname,				\
+			.attrs = _attrname##_attrs			\
+}
+
+/* ROG PPT attributes need a little different in setup */
+#define ATTR_GROUP_PPT_RW(_attrname, _fsname, _wmi, _default,	\
+			_min, _max, _incstep, _dispname)	\
+__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);			\
+__ROG_TUNABLE_SHOW(default_value, _attrname, _default);		\
+__ATTR_SHOW_FMT(min_value, _attrname, "%d\n", _min);		\
+__ROG_TUNABLE_SHOW(max_value, _attrname, _max);			\
+__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);	\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
+static struct kobj_attribute attr_##_attrname##_type =		\
+	__ASUS_ATTR_RO_AS(type, int_type_show);			\
+static struct attribute *_attrname##_attrs[] = {		\
+		&attr_##_attrname##_current_value.attr,		\
+		&attr_##_attrname##_default_value.attr,		\
+		&attr_##_attrname##_min_value.attr,		\
+		&attr_##_attrname##_max_value.attr,		\
+		&attr_##_attrname##_scalar_increment.attr,	\
+		&attr_##_attrname##_display_name.attr,		\
+		&attr_##_attrname##_type.attr,			\
+		NULL						\
+};								\
+static const struct attribute_group _attrname##_attr_group = {	\
+		.name = _fsname,				\
+		.attrs = _attrname##_attrs			\
+}
+
+#endif /* _ASUS_BIOSCFG_H_ */
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2b968003cb9b..3f1998638fea 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -529,12 +529,28 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if (*retval == ~0)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
+
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
 				 u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 74b32e1d6735..889336a932fb 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -67,6 +67,7 @@
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
 /* Misc */
+#define ASUS_WMI_DEVID_PANEL_HD		0x0005001C
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
@@ -152,8 +153,18 @@
 #define ASUS_WMI_DSTS_LIGHTBAR_MASK	0x0000000F
 
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
+static int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
+static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.45.2


