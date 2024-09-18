Return-Path: <linux-kernel+bounces-332478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF497BA44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E731C20C07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4A17C7BF;
	Wed, 18 Sep 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="LpNuyYHh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggGQFwwx"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29217A586;
	Wed, 18 Sep 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652586; cv=none; b=feguZK0PBj9/kWFLGXzbCbD2tOnpA/4lHL1iDFsPcPfqhSIF1lkOycRYYNDrCB4qok1bG+4rIG/VrPKbGjrnr+hygqJXn81lakAD0DKZXamiwzcfa4Hv20XQXGPD+h7dvOV/D+DC4g+BUAIwKc0T8RqwpYTZu6ZG4IaZRexMf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652586; c=relaxed/simple;
	bh=HU6u5hyC9cGLodLTs9Yd4D1sHLQ6VSBsIvhka7kNS9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIH+H20gbtf1jcT9dUJsCEDpZ5PrK9W7ttVysG/SZ7mXTFPx20zE+OCb/DgVPgACs8cVCBdQX91dNvehQTioJcqiOHBkzEJlnLMM10ojugn6GIexrgZBgZ3BX2fahwOX8iiZIDWNVcCeAbxPiAjyqdb4AEAzXbQUc0DrcdMAUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=LpNuyYHh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggGQFwwx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 855B01140232;
	Wed, 18 Sep 2024 05:43:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Sep 2024 05:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726652582;
	 x=1726738982; bh=0CqJm1GvTl7JcMtPBupOc7lUEP9IDK717lmFoXFpwTM=; b=
	LpNuyYHhm+YQnHWHXIL9JP44IFL7CvIJvajf4JnqYp6L93y5FcSvzcCkRGxpqhW4
	A2SPMEuT6P/7zdl5yAH0ueuS6WKDYtLpwm10VAtRZU58TgygEcucKa+Fx4cGTLPN
	NkmbQK/AABICHDzITInk9GRQNKyiuB/Xdq7UT9/gYZc3R1pB7rfx271/VV8u73x+
	rZNfdggw+Hl3PP4AzTbFiPTLfzQ9JnS18FY9HLuIm9OvnChOr3mR2Rl8g4WZAi2e
	e7oYObtS5cxchg97zWPk6DB4fEV7K7Xtz/yZ7mxHWNew2fqMeVRJcoWpa369ssYT
	UFPuqGUmiCBjuF/c5v93xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726652582; x=
	1726738982; bh=0CqJm1GvTl7JcMtPBupOc7lUEP9IDK717lmFoXFpwTM=; b=g
	gGQFwwx8iuAcWuzYfB994zI5473X4ixG8Mu+DEkOtQgB6EoZls6yFvDugpqDjfGm
	QN8pKcDWE0AkSgRpxOiTepjil3xY0FPvwa9LSjbe96DxZktJ/kHnGk0Mj6sMldar
	48b2eVu1KNwO0DdceLoktXekmfJtW3FHFdmiwdHHOPb6Y7k+Hotp/NernFRYBEuA
	D1B73N2rI5Wijsm40q5rf4G3hfBB28f6f6SdgYgVeVlzQ8VQCE9KFMb0FxxuO3MH
	uoitKX4fkRB1dIp1cmh6hmjXiuFDCPobWSWw/aUXauVuPC11K9BoGFiFWEJw0MFh
	hoMx6wVKpSxu2IXIsfUdg==
X-ME-Sender: <xms:pqDqZmqkUZMCvW21MNtigmsmBWa7sNJ4Ff4_2ErVC8EHJpUpvZ1CRA>
    <xme:pqDqZkpZKNlSgQN5QQmhc-n4gyS0I4z2U25JzI6PEurShZpUU0hVSObO2EQvPN9_Z
    gPTBp_Gxi0YKwrpmZ8>
X-ME-Received: <xmr:pqDqZrPY_ilEFzBzSk5Kfrire5MA9-4w0hwFgVhOBd7PbyK4QbImszI2Y6Csfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhn
    vghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduud
    etudehiedvvdevveelhfegkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjoh
    hnvghsrdguvghvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:pqDqZl6CGhyowDYQ7fo06WhV5vHlkR6m91wQ3f43u7lc_wPqGJUtzw>
    <xmx:pqDqZl66VbcdRwSPvdAHsQNDYBLeJszWK67DTqRER1DlMA-hgEcdTQ>
    <xmx:pqDqZlhqf-iziL7kaX_9m4i7saIElUIf5lTot211X3mtmDSsUUs6qg>
    <xmx:pqDqZv7oiEMB_DAecKSfVEYnNUnqO8sA4U3xjnUu4wnyaJ0wRRw53A>
    <xmx:pqDqZjTFJvlS5c5nNxC3V6I7oQXg5p6VaVik4cjrYVI_fRil3exfeH-r>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:42:59 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings to asus-armoury module
Date: Wed, 18 Sep 2024 21:42:46 +1200
Message-ID: <20240918094250.82430-2-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240918094250.82430-1-luke@ljones.dev>
References: <20240918094250.82430-1-luke@ljones.dev>
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

/sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
├── current_value
├── display_name
├── possible_values
└── type

as do other attributes.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/Kconfig               |  14 +
 drivers/platform/x86/Makefile              |   1 +
 drivers/platform/x86/asus-armoury.c        | 702 +++++++++++++++++++++
 drivers/platform/x86/asus-armoury.h        | 209 ++++++
 drivers/platform/x86/asus-wmi.c            |  69 +-
 drivers/platform/x86/asus-wmi.h            |  14 +
 include/linux/platform_data/x86/asus-wmi.h |  11 +
 7 files changed, 1001 insertions(+), 19 deletions(-)
 create mode 100644 drivers/platform/x86/asus-armoury.c
 create mode 100644 drivers/platform/x86/asus-armoury.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ddfccc226751..d13c4085c228 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -265,6 +265,19 @@ config ASUS_WIRELESS
 	  If you choose to compile this driver as a module the module will be
 	  called asus-wireless.
 
+config ASUS_ARMOURY
+	tristate "ASUS Armoury (firmware) Driver"
+	depends on ACPI_WMI
+	depends on ASUS_WMI
+	select FW_ATTR_CLASS
+	help
+	  Say Y here if you have a WMI aware Asus laptop and would like to use the
+	  firmware_attributes API to control various settings typically exposed in
+	  the ASUS Armoury Crate application available on Windows.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called asus-armoury.
+
 config ASUS_WMI
 	tristate "ASUS WMI Driver"
 	depends on ACPI_WMI
@@ -276,6 +289,7 @@ config ASUS_WMI
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on SERIO_I8042 || SERIO_I8042 = n
+	select ASUS_ARMOURY
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b142947067..fe3e7e7dede8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 # ASUS
 obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
 obj-$(CONFIG_ASUS_WIRELESS)	+= asus-wireless.o
+obj-$(CONFIG_ASUS_ARMOURY)	+= asus-armoury.o
 obj-$(CONFIG_ASUS_WMI)		+= asus-wmi.o
 obj-$(CONFIG_ASUS_NB_WMI)	+= asus-nb-wmi.o
 obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
new file mode 100644
index 000000000000..6e4507be0f05
--- /dev/null
+++ b/drivers/platform/x86/asus-armoury.c
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Asus Armoury (WMI) attributes driver. This driver uses the fw_attributes
+ * class to expose the various WMI functions that many gaming and some
+ * non-gaming ASUS laptops have available.
+ * These typically don't fit anywhere else in the sysfs such as under LED class,
+ * hwmon or other, and are set in Windows using the ASUS Armoury Crate tool.
+ *
+ * Copyright(C) 2010 Intel Corporation.
+ * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_data/x86/asus-wmi.h>
+#include <linux/types.h>
+
+#include "asus-armoury.h"
+#include "firmware_attributes_class.h"
+#include "asus-wmi.h"
+
+#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
+
+#define ASUS_MINI_LED_MODE_MASK 0x03
+/* Standard modes for devices with only on/off */
+#define ASUS_MINI_LED_OFF 0x00
+#define ASUS_MINI_LED_ON 0x01
+/* New mode on some devices, define here to clarify remapping later */
+#define ASUS_MINI_LED_STRONG_MODE 0x02
+/* New modes for devices with 3 mini-led mode types */
+#define ASUS_MINI_LED_2024_WEAK 0x00
+#define ASUS_MINI_LED_2024_STRONG 0x01
+#define ASUS_MINI_LED_2024_OFF 0x02
+
+/* Default limits for tunables available on ASUS ROG laptops */
+#define PPT_CPU_LIMIT_MIN 5
+#define PPT_CPU_LIMIT_MAX 150
+#define PPT_CPU_LIMIT_DEFAULT 80
+#define PPT_PLATFORM_MIN 5
+#define PPT_PLATFORM_MAX 100
+#define PPT_PLATFORM_DEFAULT 80
+#define NVIDIA_BOOST_MIN 5
+#define NVIDIA_BOOST_MAX 25
+#define NVIDIA_TEMP_MIN 75
+#define NVIDIA_TEMP_MAX 87
+
+/* Tunables provided by ASUS for gaming laptops */
+struct rog_tunables {
+	u32 cpu_default;
+	u32 cpu_min;
+	u32 cpu_max;
+
+	u32 platform_default;
+	u32 platform_min;
+	u32 platform_max;
+
+	u32 ppt_pl1_spl; // cpu
+	u32 ppt_pl2_sppt; // cpu
+	u32 ppt_apu_sppt; // plat
+	u32 ppt_platform_sppt; // plat
+	u32 ppt_fppt; // cpu
+
+	u32 nv_boost_default;
+	u32 nv_boost_min;
+	u32 nv_boost_max;
+	u32 nv_dynamic_boost;
+
+	u32 nv_temp_default;
+	u32 nv_temp_min;
+	u32 nv_temp_max;
+	u32 nv_temp_target;
+};
+
+static const struct class *fw_attr_class;
+
+struct asus_armoury_priv {
+	struct device *fw_attr_dev;
+	struct kset *fw_attr_kset;
+
+	struct rog_tunables *rog_tunables;
+	u32 mini_led_dev_id;
+	u32 gpu_mux_dev_id;
+
+	struct mutex mutex;
+};
+
+static struct asus_armoury_priv asus_armoury = { .mutex = __MUTEX_INITIALIZER(
+							 asus_armoury.mutex) };
+
+struct fw_attrs_group {
+	bool pending_reboot;
+};
+
+static struct fw_attrs_group fw_attrs = {
+	.pending_reboot = false,
+};
+
+struct asus_attr_group {
+	const struct attribute_group *attr_group;
+	u32 wmi_devid;
+};
+
+static bool asus_wmi_is_present(u32 dev_id)
+{
+	u32 retval;
+	int status;
+
+	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, &retval);
+	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
+
+	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
+}
+
+static void asus_set_reboot_and_signal_event(void)
+{
+	fw_attrs.pending_reboot = true;
+	kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
+}
+
+static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
+}
+
+static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
+
+static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
+{
+	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "panel_hd_mode");
+}
+
+/**
+ * attr_int_store() - Generic store function for use with most WMI functions.
+ * @kobj: Pointer to the driver object.
+ * @kobj_attribute: Pointer to the attribute calling this function.
+ * @buf: The buffer to read from, this is parsed to `int` type.
+ * @count:
+ * @min: Minimum accepted value. Below this returns -EINVAL.
+ * @max: Maximum accepted value. Above this returns -EINVAL.
+ * @store_value: Pointer to where the parsed value should be stored.
+ * @wmi_dev: The WMI function ID to use.
+ *
+ * The WMI functions available on most ASUS laptops return a 1 as "success", and
+ * a 0 as failed. However some functions can return n > 1 for additional errors.
+ * attr_int_store() currently treats all values which are not 1 as errors, ignoring
+ * the possible differences in WMI error returns.
+ *
+ * Returns: Either count, or an error.
+ */
+static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf,
+			      size_t count, u32 min, u32 max, u32 *store_value, u32 wmi_dev)
+{
+	u32 result, value;
+	int err;
+
+	err = kstrtouint(buf, 10, &value);
+	if (err)
+		return err;
+
+	if (value < min || value > max)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(wmi_dev, value, &result);
+	if (err) {
+		pr_err("Failed to set %s: %d\n", attr->attr.name, err);
+		return err;
+	}
+
+	if (result != 1) {
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
+						struct kobj_attribute *attr, char *buf)
+{
+	u32 value;
+	int err;
+
+	err = asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &value);
+	if (err)
+		return err;
+
+	value &= ASUS_MINI_LED_MODE_MASK;
+
+	/*
+	 * Remap the mode values to match previous generation mini-LED. The last gen
+	 * WMI 0 == off, while on this version WMI 2 == off (flipped).
+	 */
+	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
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
+	return sysfs_emit(buf, "%u\n", value);
+}
+
+static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
+						 struct kobj_attribute *attr, const char *buf,
+						 size_t count)
+{
+	int result, err;
+	u32 mode;
+
+	err = kstrtou32(buf, 10, &mode);
+	if (err)
+		return err;
+
+	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
+	    mode > ASUS_MINI_LED_ON)
+		return -EINVAL;
+	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
+	    mode > ASUS_MINI_LED_STRONG_MODE)
+		return -EINVAL;
+
+	/*
+	 * Remap the mode values so expected behaviour is the same as the last
+	 * generation of mini-LED with 0 == off, 1 == on.
+	 */
+	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
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
+	err = asus_wmi_set_devstate(asus_armoury.mini_led_dev_id, mode, &result);
+	if (err) {
+		pr_warn("Failed to set mini-LED: %d\n", err);
+		return err;
+	}
+
+	if (result != 1) {
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
+						  struct kobj_attribute *attr, char *buf)
+{
+	switch (asus_armoury.mini_led_dev_id) {
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
+						struct kobj_attribute *attr, const char *buf,
+						size_t count)
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
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
+		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
+		if (err)
+			return err;
+		if (result && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %02X %02X %d\n",
+				result, optimus, err);
+			return err;
+		}
+	}
+
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
+		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
+		if (err)
+			return err;
+		if (result && !optimus) {
+			err = -ENODEV;
+			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	err = asus_wmi_set_devstate(asus_armoury.gpu_mux_dev_id, optimus, &result);
+	if (err) {
+		pr_err("Failed to set GPU MUX mode: %d\n", err);
+		return err;
+	}
+	/* !1 is considered a fail by ASUS */
+	if (result != 1) {
+		pr_warn("Failed to set GPU MUX mode (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+	asus_set_reboot_and_signal_event();
+
+	return count;
+}
+WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_armoury.gpu_mux_dev_id);
+ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
+
+/*
+ * A user may be required to store the value twice, typical store first, then
+ * rescan PCI bus to activate power, then store a second time to save correctly.
+ * The reason for this is that an extra code path in the ACPI is enabled when
+ * the device and bus are powered.
+ */
+static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
+						struct kobj_attribute *attr, const char *buf,
+						size_t count)
+{
+	int result, err;
+	u32 disable;
+
+	err = kstrtou32(buf, 10, &disable);
+	if (err)
+		return err;
+
+	if (disable > 1)
+		return -EINVAL;
+
+	if (asus_armoury.gpu_mux_dev_id) {
+		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
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
+		pr_warn("Failed to set dGPU disable: %d\n", err);
+		return err;
+	}
+
+	if (result != 1) {
+		pr_warn("Failed to set dGPU disable (result): 0x%x\n", result);
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
+static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					       const char *buf, size_t count)
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
+		pr_warn("Failed to get eGPU connection status: %d\n", err);
+		return err;
+	}
+
+	if (asus_armoury.gpu_mux_dev_id) {
+		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
+		if (err) {
+			pr_warn("Failed to get GPU MUX status: %d\n", result);
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
+		pr_warn("Failed to set eGPU state: %d\n", err);
+		return err;
+	}
+
+	if (result != 1) {
+		pr_warn("Failed to set eGPU state (retval): 0x%x\n", result);
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
+ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
+		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT, cpu_default,
+		       cpu_min, cpu_max, 1, "Set the CPU fast package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
+		       platform_default, platform_min, platform_max, 1,
+		       "Set the CPU slow package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
+		       platform_default, platform_min, platform_max, 1,
+		       "Set the CPU slow package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT, cpu_default, cpu_min,
+		       cpu_max, 1, "Set the CPU slow package limit");
+ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
+		       nv_boost_default, nv_boost_min, nv_boost_max, 1,
+		       "Set the Nvidia dynamic boost limit");
+ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
+		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
+		       "Set the Nvidia max thermal limit");
+
+ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
+		       "Show the current mode of charging");
+
+ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
+		   "Set the boot POST sound");
+ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
+		   "Set MCU powersaving mode");
+ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
+		   "Set the panel refresh overdrive");
+ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+		   "Set the panel HD mode to UHD<0> or FHD<1>");
+ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
+		   "Show the eGPU connection status");
+
+/* If an attribute does not require any special case handling add it here */
+static const struct asus_attr_group armoury_attr_groups[] = {
+	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
+	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
+	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
+
+	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
+	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
+	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
+	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
+	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
+	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
+	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
+
+	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
+	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
+	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
+	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
+	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
+};
+
+static int asus_fw_attr_add(void)
+{
+	int err;
+
+	err = fw_attributes_class_get(&fw_attr_class);
+	if (err)
+		goto fail_class_created;
+
+	asus_armoury.fw_attr_dev =
+		device_create(fw_attr_class, NULL, MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
+
+	if (IS_ERR(asus_armoury.fw_attr_dev)) {
+		err = PTR_ERR(asus_armoury.fw_attr_dev);
+		goto fail_class_created;
+	}
+
+	asus_armoury.fw_attr_kset =
+		kset_create_and_add("attributes", NULL, &asus_armoury.fw_attr_dev->kobj);
+	if (!asus_armoury.fw_attr_dev) {
+		err = -ENOMEM;
+		pr_debug("Failed to create and add attributes\n");
+		goto err_destroy_classdev;
+	}
+
+	err = sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
+	if (err) {
+		pr_warn("Failed to create sysfs level attributes\n");
+		goto fail_class_created;
+	}
+
+	err = 0;
+	asus_armoury.mini_led_dev_id = 0;
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
+		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &mini_led_mode_attr_group);
+	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
+		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &mini_led_mode_attr_group);
+	}
+	if (err)
+		pr_warn("Failed to create sysfs-group for mini_led\n");
+
+	err = 0;
+	asus_armoury.gpu_mux_dev_id = 0;
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
+		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX;
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &gpu_mux_mode_attr_group);
+	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
+		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &gpu_mux_mode_attr_group);
+	}
+	if (err)
+		pr_warn("Failed to create sysfs-group for gpu_mux\n");
+
+	for (int i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
+		/* Do not show for the Ally devices as powersave is entirely unreliable on it */
+		if (armoury_attr_groups[i].wmi_devid == ASUS_WMI_DEVID_MCU_POWERSAVE &&
+		    dmi_check_system(asus_rog_ally_device))
+			continue;
+
+		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
+			continue;
+
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 armoury_attr_groups[i].attr_group);
+		if (err)
+			pr_warn("Failed to create sysfs-group for %s\n",
+				armoury_attr_groups[i].attr_group->name);
+		else
+			pr_debug("Created sysfs-group for %s\n",
+				 armoury_attr_groups[i].attr_group->name);
+	}
+
+	return 0;
+
+err_destroy_classdev:
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+
+fail_class_created:
+	fw_attributes_class_put();
+	return err;
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
+	} else if (strstr(product, "RC71") || strstr(product, "RC72")) {
+		cpu_max = 50;
+		cpu_default = 30;
+	} else if (strstr(product, "G814") || strstr(product, "G614") ||
+		   strstr(product, "G834") || strstr(product, "G634")) {
+		cpu_max = 175;
+	} else if (strstr(product, "GA402X") || strstr(product, "GA403") ||
+		   strstr(product, "FA507N") || strstr(product, "FA507X") ||
+		   strstr(product, "FA707N") || strstr(product, "FA707X")) {
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
+	rog->cpu_min = PPT_CPU_LIMIT_MIN;
+	rog->cpu_max = cpu_max;
+
+	rog->platform_default = platform_default;
+	rog->platform_max = PPT_PLATFORM_MIN;
+	rog->platform_max = platform_max;
+
+	rog->ppt_pl1_spl = cpu_default;
+	rog->ppt_pl2_sppt = cpu_default;
+	rog->ppt_apu_sppt = cpu_default;
+
+	rog->ppt_platform_sppt = platform_default;
+	rog->ppt_fppt = cpu_default;
+
+	rog->nv_boost_default = NVIDIA_BOOST_MAX;
+	rog->nv_boost_max = NVIDIA_BOOST_MIN;
+	rog->nv_boost_max = max_boost;
+	rog->nv_dynamic_boost = NVIDIA_BOOST_MIN;
+
+	rog->nv_temp_default = NVIDIA_TEMP_MAX;
+	rog->nv_temp_max = NVIDIA_TEMP_MIN;
+	rog->nv_temp_max = NVIDIA_TEMP_MAX;
+	rog->nv_temp_target = NVIDIA_TEMP_MIN;
+}
+
+static int __init asus_fw_init(void)
+{
+	int err;
+
+	fw_attrs.pending_reboot = false;
+
+	asus_armoury.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
+	if (!asus_armoury.rog_tunables)
+		return -ENOMEM;
+
+	init_rog_tunables(asus_armoury.rog_tunables);
+
+	err = asus_fw_attr_add();
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void __exit asus_fw_exit(void)
+{
+	mutex_lock(&asus_armoury.mutex);
+
+	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
+	kset_unregister(asus_armoury.fw_attr_kset);
+	device_destroy(fw_attr_class, MKDEV(0, 0));
+	fw_attributes_class_put();
+
+	mutex_unlock(&asus_armoury.mutex);
+}
+
+module_init(asus_fw_init);
+module_exit(asus_fw_exit);
+
+MODULE_IMPORT_NS(ASUS_WMI);
+MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
+MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
new file mode 100644
index 000000000000..8bb75cf88305
--- /dev/null
+++ b/drivers/platform/x86/asus-armoury.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Definitions for kernel modules using asus-armoury driver
+ *
+ *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
+ */
+
+#ifndef _ASUS_BIOSCFG_H_
+#define _ASUS_BIOSCFG_H_
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "asus-armoury"
+
+static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count, u32 min, u32 max,
+			      u32 *store_value, u32 wmi_dev);
+
+static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+
+static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "enumeration\n");
+}
+
+#define __ASUS_ATTR_RO(_func, _name)                                  \
+	{                                                             \
+		.attr = { .name = __stringify(_name), .mode = 0444 }, \
+		.show = _func##_##_name##_show,                       \
+	}
+
+#define __ASUS_ATTR_RO_AS(_name, _show)                               \
+	{                                                             \
+		.attr = { .name = __stringify(_name), .mode = 0444 }, \
+		.show = _show,                                        \
+	}
+
+#define __ASUS_ATTR_RW(_func, _name) \
+	__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
+
+#define __WMI_STORE_INT(_attr, _min, _max, _wmi)                          \
+	static ssize_t _attr##_store(struct kobject *kobj,                \
+				     struct kobj_attribute *attr,         \
+				     const char *buf, size_t count)       \
+	{                                                                 \
+		return attr_int_store(kobj, attr, buf, count, _min, _max, \
+				      NULL, _wmi);                        \
+	}
+
+#define WMI_SHOW_INT(_attr, _fmt, _wmi)                                     \
+	static ssize_t _attr##_show(struct kobject *kobj,                   \
+				    struct kobj_attribute *attr, char *buf) \
+	{                                                                   \
+		u32 result;                                                 \
+		int err;                                                    \
+		err = asus_wmi_get_devstate_dsts(_wmi, &result);            \
+		if (err)                                                    \
+			return err;                                         \
+		return sysfs_emit(buf, _fmt,                                \
+				  result & ~ASUS_WMI_DSTS_PRESENCE_BIT);    \
+	}
+
+/* Create functions and attributes for use in other macros or on their own */
+
+#define __ATTR_CURRENT_INT_RO(_attr, _wmi)                          \
+	WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
+	static struct kobj_attribute attr_##_attr##_current_value = \
+		__ASUS_ATTR_RO(_attr, current_value)
+
+#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)            \
+	__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi); \
+	WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
+	static struct kobj_attribute attr_##_attr##_current_value = \
+		__ASUS_ATTR_RW(_attr, current_value)
+
+/* Shows a formatted static variable */
+#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)                         \
+	static ssize_t _attrname##_##_prop##_show(                            \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{                                                                     \
+		return sysfs_emit(buf, _fmt, _val);                           \
+	}                                                                     \
+	static struct kobj_attribute attr_##_attrname##_##_prop =             \
+		__ASUS_ATTR_RO(_attrname, _prop)
+
+/* Boolean style enumeration, base macro. Requires adding show/store */
+#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
+	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
+	static struct kobj_attribute attr_##_attrname##_type =          \
+		__ASUS_ATTR_RO_AS(type, enum_type_show);                \
+	static struct attribute *_attrname##_attrs[] = {                \
+		&attr_##_attrname##_current_value.attr,                 \
+		&attr_##_attrname##_display_name.attr,                  \
+		&attr_##_attrname##_possible_values.attr,               \
+		&attr_##_attrname##_type.attr, NULL                     \
+	};                                                              \
+	static const struct attribute_group _attrname##_attr_group = {  \
+		.name = _fsname, .attrs = _attrname##_attrs             \
+	}
+
+#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
+	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
+
+#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
+	__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
+	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
+
+/*
+ * Requires <name>_current_value_show(), <name>_current_value_show()
+ */
+#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)           \
+	static struct kobj_attribute attr_##_attrname##_current_value = \
+		__ASUS_ATTR_RW(_attrname, current_value);               \
+	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
+
+#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname) \
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                                \
+	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
+
+/*
+ * Requires <name>_current_value_show(), <name>_current_value_show()
+ * and <name>_possible_values_show()
+ */
+#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)             \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      \
+	static struct kobj_attribute attr_##_attrname##_current_value =   \
+		__ASUS_ATTR_RW(_attrname, current_value);                 \
+	static struct kobj_attribute attr_##_attrname##_possible_values = \
+		__ASUS_ATTR_RO(_attrname, possible_values);               \
+	static struct kobj_attribute attr_##_attrname##_type =            \
+		__ASUS_ATTR_RO_AS(type, enum_type_show);                  \
+	static struct attribute *_attrname##_attrs[] = {                  \
+		&attr_##_attrname##_current_value.attr,                   \
+		&attr_##_attrname##_display_name.attr,                    \
+		&attr_##_attrname##_possible_values.attr,                 \
+		&attr_##_attrname##_type.attr, NULL                       \
+	};                                                                \
+	static const struct attribute_group _attrname##_attr_group = {    \
+		.name = _fsname, .attrs = _attrname##_attrs               \
+	}
+
+/*
+ * ROG PPT attributes need a little different in setup as they
+ * require rog_tunables members.
+ */
+
+#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)                             \
+	static ssize_t _attr##_current_value_store(                           \
+		struct kobject *kobj, struct kobj_attribute *attr,            \
+		const char *buf, size_t count)                                \
+	{                                                                     \
+		return attr_int_store(kobj, attr, buf, count,                 \
+				      asus_armoury.rog_tunables->_min,        \
+				      asus_armoury.rog_tunables->_max,        \
+				      &asus_armoury.rog_tunables->_attr,      \
+				      _wmi);                                  \
+	}                                                                     \
+	static ssize_t _attr##_current_value_show(                            \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{                                                                     \
+		return sysfs_emit(buf, "%u\n",                                \
+				  asus_armoury.rog_tunables->_attr);          \
+	}                                                                     \
+	static struct kobj_attribute attr_##_attr##_current_value =           \
+		__ASUS_ATTR_RW(_attr, current_value)
+
+#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)                            \
+	static ssize_t _attrname##_##_prop##_show(                            \
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
+	{                                                                     \
+		return sysfs_emit(buf, "%d\n",                                \
+				  asus_armoury.rog_tunables->_val);           \
+	}                                                                     \
+	static struct kobj_attribute attr_##_attrname##_##_prop =             \
+		__ASUS_ATTR_RO(_attrname, _prop)
+
+#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _default, _min, _max, \
+			       _incstep, _dispname)                            \
+	__ROG_TUNABLE_SHOW(default_value, _attrname, _default);                \
+	__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);                         \
+	__ROG_TUNABLE_SHOW(min_value, _attrname, _min);                        \
+	__ROG_TUNABLE_SHOW(max_value, _attrname, _max);                        \
+	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);        \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);           \
+	static struct kobj_attribute attr_##_attrname##_type =                 \
+		__ASUS_ATTR_RO_AS(type, int_type_show);                        \
+	static struct attribute *_attrname##_attrs[] = {                       \
+		&attr_##_attrname##_current_value.attr,                        \
+		&attr_##_attrname##_default_value.attr,                        \
+		&attr_##_attrname##_min_value.attr,                            \
+		&attr_##_attrname##_max_value.attr,                            \
+		&attr_##_attrname##_scalar_increment.attr,                     \
+		&attr_##_attrname##_display_name.attr,                         \
+		&attr_##_attrname##_type.attr,                                 \
+		NULL                                                           \
+	};                                                                     \
+	static const struct attribute_group _attrname##_attr_group = {         \
+		.name = _fsname, .attrs = _attrname##_attrs                    \
+	}
+
+#endif /* _ASUS_BIOSCFG_H_ */
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 08861792bddd..d265ef0d7aba 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -152,20 +152,6 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
-static const struct dmi_system_id asus_ally_mcu_quirk[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
-		},
-	},
-	{ },
-};
-
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -386,7 +372,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 {
 	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
 }
-EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
+EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, ASUS_WMI);
 
 static int asus_wmi_evaluate_method5(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
@@ -550,12 +536,58 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI function to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * The returned WMI function state can also be used to determine if the WMI
+ * function is supported by checking if the asus_wmi_get_devstate_dsts()
+ * returns an error.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call. An error value is returned only if the
+ * WMI function failed, or if it returns "unsupported" which is typically a 0
+ * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1) which if not
+ * caught here can result in unexpected behaviour later.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	*retval &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+
+	if (err)
+		return err;
+	/* Be explicit about retval */
+	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, ASUS_WMI);
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * The returned WMI function state if not checked here for error as
+ * asus_wmi_set_devstate() is not called unless first paired with a call to
+ * asus_wmi_get_devstate_dsts() to check that the WMI function is supported.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call. An error value is returned only if the
+ * WMI function failed.
+ */
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, ASUS_WMI);
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
@@ -4774,8 +4806,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_check_system(asus_ally_mcu_quirk);
+	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index d02f15fd3482..c66e970b3674 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -86,4 +86,18 @@ struct asus_wmi_driver {
 int asus_wmi_register_driver(struct asus_wmi_driver *driver);
 void asus_wmi_unregister_driver(struct asus_wmi_driver *driver);
 
+static const struct dmi_system_id asus_rog_ally_device[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
+		},
+	},
+	{ },
+};
+
 #endif /* !_ASUS_WMI_H_ */
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 365e119bebaa..7caf2c7ed8c9 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -73,6 +73,7 @@
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
+#define ASUS_WMI_DEVID_PANEL_HD		0x0005001C
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
@@ -158,8 +159,18 @@
 #define ASUS_WMI_DSTS_LIGHTBAR_MASK	0x0000000F
 
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
+static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
+static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.46.1


