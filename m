Return-Path: <linux-kernel+bounces-194538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DD8D3DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D413F1F25BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EB1A0AF9;
	Wed, 29 May 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="VdF2Ntfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8ChrjqF"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147218732D;
	Wed, 29 May 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004995; cv=none; b=F43otHqNaTihhtzwj3KrOiRbLqiVNfBprMLZyy0fiX2rpreff1YdvDnj9fBCQzg1E55jFeAiHzom95JaCHgRlLE4X7FxBETJgFn9Ju5G6CPQaV5i6PHK8ztr02RREyvSR2fk6F09UifsUOKJqfzZakN358P74E1GruxAyuKLbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004995; c=relaxed/simple;
	bh=C0cWvEQj4c8oEzOJFMb+7Zngm0wa9euRys3MlXz+mOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRGz01fQqPD7XRVY+MgPeymOwvLuXv+j3TYV4KqwwYZBR7vzzbiqu9NxieLWsDWVg8dQXm5pEDg643YJvxYdZoOLwseTQTquh/NGEY23yuqWsuxfB1q1TYA/iTdKmTk6x2eIKINVjNrSSl3OUHUTruKf0dMq77GIpm0rBvheWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=VdF2Ntfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8ChrjqF; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 02C511C000E0;
	Wed, 29 May 2024 13:49:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 May 2024 13:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717004991; x=
	1717091391; bh=8XgWDF10KLcdWFyFlccnSrgq0FikP4XbNobaZDo94gU=; b=V
	dF2Ntfhy84PvX/VvMlvImsbCd1N7sLbNqSqmil5J6h6D3socGj6gVK0uWBXbe7O+
	C17+qBhiNMljCOtXJHx/oreR/1QyIFYQONsmRMBgiAlrPwz9zP1S8wxwMNAwhS92
	FGR+kAoNZXlcjj+ztpCE2giaa3qQQhSLI8PfQfs044HoZJ+LVuIPtm3jGHbJgJdE
	FDTyUYkBK7h7wVuV97+575OBl4nqBbn5dvaXc32Jc0AP5WbWX2FF0dkathDvWOSI
	ZarUbUAHSK1XGFVV974QvLoHuX7v5RMXE2JxCMrJWV62SJY/XuUBAundXN6W8iIB
	wtb8x0QCgMIuc8GMzCW1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717004991; x=
	1717091391; bh=8XgWDF10KLcdWFyFlccnSrgq0FikP4XbNobaZDo94gU=; b=P
	8ChrjqFUKf847kz/mWh7oU9fRp3TBEhNmMzmDpkmbDxCpMqeopMXiXSx8iNoaOi2
	ViFMA/rEpZwCwwqAgqAtw8Yz31DMO0zEKG2AyuGO1nkyp0EvzztVB5S7Qze3bVDd
	wfodFRvHYYAqUBnRB4PGLCbTDpHJphgloSMMaJRGRBh07ebd5F9rGgXhsa3LEBKg
	mnIgGkwUrINoyz09DV1w9jB2L11d4UC4T4cETEPu3YuCN5Dou3Y9cndH9JA/9NGc
	aAuU/fHzLca+nJXVYADmeBHFW8+UQ3NEoiBmZ8XmKTq+WqeUZznHmPcP3urjoigg
	ldrSPLgkS+2HfqOyM3NOQ==
X-ME-Sender: <xms:v2pXZuEFRAfW8Y-RkScRcsqqm1yGMn_RBp0ru4Gv3VWDkwdFPcKRLw>
    <xme:v2pXZvXCoAZ1VQVfGGJc1ZYuBrTkxLOAuQhXFxIse4XWW1HoGaPkSZPwnJMJiAria
    zIJQf0pP1FrPKO89Dc>
X-ME-Received: <xmr:v2pXZoJ412hU-x_-UrbF283WzB8fhFeQVzfmMVpbXa8aywycGZzNxSElFgS8kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslh
    ihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeelhfeiffektdeludfgtefggeef
    hefhtefhhfffueevhfdtkedvieekheeljeeiteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:v2pXZoGHvlLB9kSPWsYZ2HwFwX8qhPspaqx9mfrK6tgfGADTpJHwtQ>
    <xmx:v2pXZkVcDW4SIPQKQtc5aZ4eTN667Q18smTF4Q1vINq53OAbCbiK8w>
    <xmx:v2pXZrPjGEPQYmdxuD6-fuazzhsSJzSAh2L_633Up_JWOE3vbvaVRg>
    <xmx:v2pXZr1WzYOXflr3GGAkxsp6T8OQPQ9cqkOtrft4g7U4fHySnpGKFQ>
    <xmx:v2pXZglXd4LupCEkX8dK3lWqNIkj4iLWVKrOerde_mCC8H8n8bxIloDX>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 13:49:50 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v8 3/3] platform/x86: dell-pc: Implement platform_profile
Date: Wed, 29 May 2024 11:47:46 -0600
Message-ID: <20240529174843.13226-4-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240529174843.13226-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240529174843.13226-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Dell laptops support configuration of preset fan modes through
smbios tables.

If the platform supports these fan modes, set up platform_profile to
change these modes. If not supported, skip enabling platform_profile.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 MAINTAINERS                                  |   6 +
 drivers/platform/x86/dell/Kconfig            |  13 +
 drivers/platform/x86/dell/Makefile           |   1 +
 drivers/platform/x86/dell/dell-pc.c          | 307 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |   1 +
 drivers/platform/x86/dell/dell-smbios.h      |   1 +
 6 files changed, 329 insertions(+)
 create mode 100644 drivers/platform/x86/dell/dell-pc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..09ff0dfd65cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6116,6 +6116,12 @@ F:	Documentation/ABI/obsolete/procfs-i8k
 F:	drivers/hwmon/dell-smm-hwmon.c
 F:	include/uapi/linux/i8k.h
 
+DELL PC DRIVER
+M:	Lyndon Sanche <lsanche@lyndeno.ca>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/dell/dell-pc.c
+
 DELL REMOTE BIOS UPDATE DRIVER
 M:	Stuart Hayes <stuart.w.hayes@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 195a8bf532cc..85a78ef91182 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -91,6 +91,19 @@ config DELL_RBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called dell-rbtn.
 
+config DELL_PC
+	tristate "Dell PC Extras"
+	default m
+	depends on ACPI
+	depends on DMI
+	depends on DELL_SMBIOS
+	select ACPI_PLATFORM_PROFILE
+	help
+	This driver adds support for controlling the fan modes via platform_profile
+	on supported Dell systems regardless of formfactor.
+	Module will simply do nothing if thermal management commands are not
+	supported.
+
 #
 # The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
 # backends are selected. The "depends" line prevents a configuration
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 8176a257d9c3..79d60f1bf4c1 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DCDBAS)			+= dcdbas.o
 obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
 obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
 obj-$(CONFIG_DELL_RBU)			+= dell_rbu.o
+obj-$(CONFIG_DELL_PC)			+= dell-pc.o
 obj-$(CONFIG_DELL_SMBIOS)		+= dell-smbios.o
 dell-smbios-objs			:= dell-smbios-base.o
 dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
new file mode 100644
index 000000000000..a86ad921d4ee
--- /dev/null
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Driver for Dell laptop extras
+ *
+ *  Copyright (c) Lyndon Sanche <lsanche@lyndeno.ca>
+ *
+ *  Based on documentation in the libsmbios package:
+ *  Copyright (C) 2005-2014 Dell Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/dmi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/platform_profile.h>
+#include <linux/slab.h>
+
+#include "dell-smbios.h"
+
+static const struct dmi_system_id dell_device_table[] __initconst = {
+	{
+		.ident = "Dell Inc.",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{
+		.ident = "Dell Computer Corporation",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+		},
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(dmi, dell_device_table);
+
+/* Derived from smbios-thermal-ctl
+ *
+ * cbClass 17
+ * cbSelect 19
+ * User Selectable Thermal Tables(USTT)
+ * cbArg1 determines the function to be performed
+ * cbArg1 0x0 = Get Thermal Information
+ *  cbRES1         Standard return codes (0, -1, -2)
+ *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
+ *                  its bit is set to 1
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
+ *                 Each mode corresponds to the supported thermal modes in
+ *                  byte 0. A mode is supported if its bit is set to 1.
+ *     Bit 0 AAC (Balanced)
+ *     Bit 1 AAC (Cool Bottom
+ *     Bit 2 AAC (Quiet)
+ *     Bit 3 AAC (Performance)
+ *  cbRes3, byte 0 Current Thermal Mode
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performanc
+ *  cbRes3, byte 1  AAC Configuration type
+ *          0       Global (AAC enable/disable applies to all supported USTT modes)
+ *          1       USTT mode specific
+ *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
+ *     If AAC Configuration Type is Global,
+ *          0       AAC mode disabled
+ *          1       AAC mode enabled
+ *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
+ *          Bit 0 AAC (Balanced)
+ *          Bit 1 AAC (Cool Bottom
+ *          Bit 2 AAC (Quiet)
+ *          Bit 3 AAC (Performance)
+ *  cbRes3, byte 3  Current Fan Failure Mode
+ *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
+ *     Bit 1 Catastrophic Fan Failure (all fans have failed)
+ *
+ * cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
+ *               desired AAC mode shall be applied
+ * cbArg2, byte 0  Desired Thermal Mode to set
+ *                  (only one bit may be set for this parameter)
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
+ *     If AAC Configuration Type is Global,
+ *         0  AAC mode disabled
+ *         1  AAC mode enabled
+ *     If AAC Configuration Type is USTT mode specific
+ *     (multiple bits may be set for this parameter),
+ *         Bit 0 AAC (Balanced)
+ *         Bit 1 AAC (Cool Bottom
+ *         Bit 2 AAC (Quiet)
+ *         Bit 3 AAC (Performance)
+ */
+
+#define DELL_ACC_GET_FIELD	GENMASK(19, 16)
+#define DELL_ACC_SET_FIELD	GENMASK(11, 8)
+#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
+
+static struct platform_profile_handler *thermal_handler;
+
+enum thermal_mode_bits {
+	DELL_BALANCED    = BIT(0),
+	DELL_COOL_BOTTOM = BIT(1),
+	DELL_QUIET       = BIT(2),
+	DELL_PERFORMANCE = BIT(3),
+};
+
+static int thermal_get_mode(void)
+{
+	struct calling_interface_buffer buffer;
+	int state;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	state = buffer.output[2];
+	if (state & DELL_BALANCED)
+		return DELL_BALANCED;
+	else if (state & DELL_COOL_BOTTOM)
+		return DELL_COOL_BOTTOM;
+	else if (state & DELL_QUIET)
+		return DELL_QUIET;
+	else if (state & DELL_PERFORMANCE)
+		return DELL_PERFORMANCE;
+	else
+		return -ENXIO;
+}
+
+static int thermal_get_supported_modes(int *supported_bits)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	/* Thermal function not supported */
+	if (ret == -ENXIO) {
+		*supported_bits = 0;
+		return 0;
+	}
+	if (ret)
+		return ret;
+	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
+	return 0;
+}
+
+static int thermal_get_acc_mode(int *acc_mode)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
+	return 0;
+}
+
+static int thermal_set_mode(enum thermal_mode_bits state)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+	int acc_mode;
+
+	ret = thermal_get_acc_mode(&acc_mode);
+	if (ret)
+		return ret;
+
+	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
+	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+}
+
+static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_BALANCED:
+		return thermal_set_mode(DELL_BALANCED);
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return thermal_set_mode(DELL_PERFORMANCE);
+	case PLATFORM_PROFILE_QUIET:
+		return thermal_set_mode(DELL_QUIET);
+	case PLATFORM_PROFILE_COOL:
+		return thermal_set_mode(DELL_COOL_BOTTOM);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
+{
+	int ret;
+
+	ret = thermal_get_mode();
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case DELL_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case DELL_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case DELL_COOL_BOTTOM:
+		*profile = PLATFORM_PROFILE_COOL;
+		break;
+	case DELL_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int thermal_init(void)
+{
+	int ret;
+	int supported_modes;
+
+	/* If thermal commands are not supported, exit without error */
+	if (!dell_smbios_class_is_supported(CLASS_INFO))
+		return 0;
+
+	/* If thermal modes are not supported, exit without error */
+	ret = thermal_get_supported_modes(&supported_modes);
+	if (ret < 0)
+		return ret;
+	if (!supported_modes)
+		return 0;
+
+	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler)
+		return -ENOMEM;
+	thermal_handler->profile_get = thermal_platform_profile_get;
+	thermal_handler->profile_set = thermal_platform_profile_set;
+
+	if (supported_modes & DELL_QUIET)
+		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
+
+	/* Clean up if failed */
+	ret = platform_profile_register(thermal_handler);
+	if (ret)
+		kfree(thermal_handler);
+
+	return ret;
+}
+
+static void thermal_cleanup(void)
+{
+	if (thermal_handler) {
+		platform_profile_remove();
+		kfree(thermal_handler);
+	}
+}
+
+static int __init dell_init(void)
+{
+	int ret;
+
+	if (!dmi_check_system(dell_device_table))
+		return -ENODEV;
+
+	/* Do not fail module if thermal modes not supported, just skip */
+	ret = thermal_init();
+	if (ret)
+		goto fail_thermal;
+
+	return 0;
+
+fail_thermal:
+	thermal_cleanup();
+	return ret;
+}
+
+static void __exit dell_exit(void)
+{
+	thermal_cleanup();
+}
+
+module_init(dell_init);
+module_exit(dell_exit);
+
+MODULE_AUTHOR("Lyndon Sanche <lsanche@lyndeno.ca>");
+MODULE_DESCRIPTION("Dell PC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 515c454acfe6..d61b33d5af95 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] = {
 	/* handled by kernel: dell-laptop */
 	{0x0000, CLASS_INFO, SELECT_RFKILL},
 	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
+	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
 };
 
 struct token_range {
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index 1d6463cca12a..ea0cc38642a2 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -19,6 +19,7 @@
 /* Classes and selects used only in kernel drivers */
 #define CLASS_KBD_BACKLIGHT 4
 #define SELECT_KBD_BACKLIGHT 11
+#define SELECT_THERMAL_MANAGEMENT 19
 
 /* Tokens used in kernel drivers, any of these
  * should be filtered from userspace access
-- 
2.42.0


