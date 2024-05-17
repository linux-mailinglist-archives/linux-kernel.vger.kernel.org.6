Return-Path: <linux-kernel+bounces-182675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BD8C8E54
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D111C21591
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2831419BA;
	Fri, 17 May 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="CDPkHaMI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LC2uoq2T"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3E1411F3;
	Fri, 17 May 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715985896; cv=none; b=du+NFJ4j05hWNxXJYs3PoKJMw0YJms/Op4NDsfKD2j0m8Oh4w5CbwffFpKcjQ47UNO4WqyS+wcXv+tJjEzoYwy9i133/Bb2GkSS3gNF77fHkzzKBqbM+0psK1lrjSTPpPk3MbJ7+m5dskhVT0+Thd/7SuiQmt7MXpmBBlcf/rFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715985896; c=relaxed/simple;
	bh=14pJ2SxyocDF9QPo2JuNxF36cHnRfNCx0F2XwWYCweU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzZE8vUkBp9l3CSciyzaPest/QWdiipBWFI5l1JCAIG9r+MlWCmYdenMp0sm3UcyBJVhfT1nZoZXgOK9mYxUrclYR3n+F8XorckClWf2+6UnQ2GOHGijlMJHEDFuWWCxosxEWYULT25b8O02Ny45CqSPS9lyQodB8MAMZNGMz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=CDPkHaMI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LC2uoq2T; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 94C601C000AA;
	Fri, 17 May 2024 18:44:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 17 May 2024 18:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715985892; x=
	1716072292; bh=GcGf8y9JMMlF17xgMILRyI8NTyOd/EO9TmYQZ8YZCYw=; b=C
	DPkHaMIbBfXvhr6v6CfWeCdM+o+LAMRscTO/ij8EE3PF5EnIReN8i+5aEcmlM3jt
	pqQoEax5eLZQIIHIu0eddJfQoKgjov+AJd+WGsziBLLJe4p0Tg8eJtMbrDiGV/HB
	2MB1AkNKIQcxkVwkvx0nC2WKIVzPWs2vnq91kssQs1j4JFLtjTTTVDlEBSM4kcDR
	Q4P5qkLsNySb/+NpWyQDkurHpYBJF4po3foW13m40A7zUaekzX/zwIk81G53fpiT
	SMe8NI7+6OJiivDwElO4i/UqwGaJUcduo7QIBX99YKYYXzVpzUABuWPb3O2O68jJ
	vYlKjcz5WrhqEslNHcNNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715985892; x=
	1716072292; bh=GcGf8y9JMMlF17xgMILRyI8NTyOd/EO9TmYQZ8YZCYw=; b=L
	C2uoq2T1GR8w3RkFaS3ntO9hZBHLVeOpOuGKWv4HtJZ/ai/VJnHzVrbLKEhh994n
	r9ThxsWxeC9IgQoTjwYBEMUEepf0PtdLQz8abqatb5VvWppnJE2CFcikT/7MFMkg
	7RugM4YLqdKCmUJNyzzoVzmk2orQfrfcfXXP2rYocx5coXKHsIyGQlogjSFQZjcT
	vbwDEQDz7TCcrCYkQw7ibRillrSPUrjKzTc5xFj4PRlqWa2GX4fcaYByEVa7KHEV
	63fZLi3rXCuZ2yg2oOLp5znKYNyrBmR5iEndrfsCAm9JEEUXZvOXZzZGdyQv3Rto
	GAK5YTzrr4id6V50PSCpA==
X-ME-Sender: <xms:5N1HZhuruisIKv735zdeBri15M0B0pETFm2hg7jnHugYWpeTgyQXYA>
    <xme:5N1HZqc4D8N08G5cNp449A7cbXTSyyoR9j9ygcuN60tVk4xe33y2mv-Ah32LI7yBf
    wJhX7kLym5HMYVNGiA>
X-ME-Received: <xmr:5N1HZkyBtb2F0qMkvscPOeJMZ_etHpbaTa4E30XYoGB24vJOpoiQsjZ35Ln2r5MGzuCx6y5MzxUlKHjxn84HFumuYwsgaCpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:5N1HZoPBZTdhQVLWgp7WEGIEyLmG-xBdOilsB8WLZ56vK4_2D1ySFw>
    <xmx:5N1HZh_bNj23iJ64ZvFbVLd0oHyJq7TAxx7lAikRFVW1eS4MGPT-sg>
    <xmx:5N1HZoXCs7wBbF1UOukB1gTLvPzxXuAd5xZzSjem_QYgzVhhT6j0nw>
    <xmx:5N1HZifihvRRRASagDar0qH8XW2RXKORzuUE8Qu5yJapKhPDjfleDA>
    <xmx:5N1HZpMFHBmMV0SxCq462e9HEfs5daadWlfvX4yLTXsO0ig8qXchK4oS>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:44:51 -0400 (EDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v7 3/3] platform/x86: dell-pc: Implement platform_profile
Date: Fri, 17 May 2024 16:42:36 -0600
Message-ID: <20240517224323.10045-4-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240517224323.10045-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240517224323.10045-1-lsanche@lyndeno.ca>
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
 drivers/platform/x86/dell/dell-pc.c          | 310 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |   1 +
 drivers/platform/x86/dell/dell-smbios.h      |   1 +
 6 files changed, 332 insertions(+)
 create mode 100644 drivers/platform/x86/dell/dell-pc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..69c582b72a08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5961,6 +5961,12 @@ F:	Documentation/ABI/obsolete/procfs-i8k
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
index bd9f445974cc..0732850a3dd6 100644
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
index 1b8942426622..9b0094fafcce 100644
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
index 000000000000..3dd762e39f45
--- /dev/null
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -0,0 +1,310 @@
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
+#include "dell-smbios.h"
+
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
+#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
+#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
+#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
+
+static struct platform_profile_handler *thermal_handler;
+
+enum thermal_mode_bits {
+	DELL_BALANCED = BIT(0),
+	DELL_COOL_BOTTOM = BIT(1),
+	DELL_QUIET = BIT(2),
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
+	if (ret) {
+		/* Thermal function not supported */
+		if (ret == -ENXIO) {
+			*supported_bits = 0;
+			return 0;
+		} else {
+			return ret;
+		}
+	}
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
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	return ret;
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
+	/* If thermal commands not supported, exit without error */
+	if (!dell_smbios_class_is_supported(CLASS_INFO))
+		return 0;
+
+	/* If thermal modes not supported, exit without error */
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


