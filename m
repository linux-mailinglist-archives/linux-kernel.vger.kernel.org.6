Return-Path: <linux-kernel+bounces-367824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A6F9A0741
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E41C2611D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDC208213;
	Wed, 16 Oct 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxPLIuzH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AA208208;
	Wed, 16 Oct 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074240; cv=none; b=YAw3eU0DVircNLWqVBmMAx2/nIZw1PvNyxBBlaNxF2YI5m5Dyt2ZxzZgZw70RoE70njhJPf91brrDdqVahc0gD4TTFxnB8yYKHpQdoLNa3BH42Cg07lfe247uQ0CGoexhH5x+NL/cx1W0IZeB6w+vzHDk9BScYm0OFdtq5KlB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074240; c=relaxed/simple;
	bh=diJ36RLK/l5o56cnGDl0UJM9WiHgarjAT0U7fl+VFWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL5rMM/j1/Vegq8RvOve5mzQTeK8HD3dgMEOc2FIW5JKF0QyLs2QE6NQIVnlqkG2juncOg8S2MJWEGoWF8z6ATOHCWeqrM4VXBQoJWbgt1VrTtV58UNvOWAeqDaKNmlyBeKqifEak9iNtJybXB4Gd6WoMZJW2WhzovYVKySteaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxPLIuzH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074238; x=1760610238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diJ36RLK/l5o56cnGDl0UJM9WiHgarjAT0U7fl+VFWE=;
  b=MxPLIuzHpDRvbTqkLX7SvzvABGUgHMdu6Upb9RJw1ao1qx5Y7+Mo+0GP
   IosTddHfEkWB2nNqlHy05ok+RlcvIc4hUIryLQLFLVw132ZlrB0Nf0TtZ
   nwiQCqjpb4pyxFpvMvh1GUI40j4Po8GkS7jX++NOquKB4O/Bv5McgxQ2e
   6hOFoCDIoY/AvxAgFPCKLHWWJ8eiucViMHFZhKMejC1xp4Vzz8N+9nPLQ
   vB7vogeSq/WLNhmJJMp9VoRuCn6pFyqEPECsSitzHk2mQXUJu4A0miH/M
   HJeoJdpt9VUB+Jor/FVEki3pUxljQNcyyMAH8Ov/UCmBZT8abCh4XtSga
   w==;
X-CSE-ConnectionGUID: jMt3/VvvT3aOSbK09T7G+w==
X-CSE-MsgGUID: kMYg/sW8RymryOcUYscxLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985883"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985883"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:58 -0700
X-CSE-ConnectionGUID: ktrH/MDzS9ySZe40e5gIIA==
X-CSE-MsgGUID: /Fnt1euGRLWYdX9VbEMqcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960847"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:55 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 03/11] ASoC: SDCA: add initial module
Date: Wed, 16 Oct 2024 18:23:25 +0800
Message-ID: <20241016102333.294448-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add new module for SDCA (SoundWire Device Class for Audio) support.
For now just add a parser to identify the SDCA revision and the
function mask.

Note that the SDCA definitions and related MIPI DisCo properties are
defined only for ACPI platforms and extracted with _DSD helpers. There
is currently no support for Device Tree in the specification, the
'depends on ACPI' reflects this design limitation. This might change
in a future revision of the specification but for SDCA 1.0 ACPI is the
only supported type of platform firmware.

The SDCA library is defined with static inline fallbacks, which will
allow for unconditional addition of SDCA support in common parts of
the code.

The design follows a four-step process:

1) Basic information related to Functions is extracted from MIPI DisCo
tables and stored in the 'struct sdw_slave'. Devm_ based memory
allocation is not allowed at this point prior to a driver probe, so we only
store the function node, address and type.

2) When a codec driver probes, it will register subdevices for each
Function identified in phase 1)

3) a driver will probe for each subdevice and addition parsing/memory
allocation takes place at this level. devm_ based allocation is highly
encouraged to make error handling manageable.

4) Before the peripheral device becomes physically attached, register
access is not permitted and the regmaps are cache-only. When
peripheral device is enumerated, the bus level uses the
'update_status' notification; after optional device-level
initialization, the codec driver will notify each of the subdevices so
that they can start interacting with the hardware.

Note that the context extracted in 1) should be arguably be handled
completely in the codec driver probe. That would however make it
difficult to use the ACPI information for machine quirks, and
e.g. select different machine driver and topologies as done for the
RT712_VB handling later in the series. To make the implementation of
quirks simpler, this patchset extracts a minimal amount of context
(interface revision and number/type of Functions) before the codec
driver probe, and stores this context in the scope of the 'struct
sdw_slave'.

The SDCA library can also be used in a vendor-specific driver without
creating subdevices, e.g. to retrieve the 'initialization-table'
values to write platform-specific values as needed.

For more technical details, the SDCA specification is available for
public downloads at https://www.mipi.org/mipi-sdca-v1-0-download

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h   |   3 +
 include/sound/sdca.h            |  54 ++++++++++
 include/sound/sdca_function.h   |  55 ++++++++++
 sound/soc/Kconfig               |   1 +
 sound/soc/Makefile              |   1 +
 sound/soc/sdca/Kconfig          |  11 ++
 sound/soc/sdca/Makefile         |   5 +
 sound/soc/sdca/sdca_device.c    |  24 +++++
 sound/soc/sdca/sdca_functions.c | 173 ++++++++++++++++++++++++++++++++
 9 files changed, 327 insertions(+)
 create mode 100644 include/sound/sdca.h
 create mode 100644 include/sound/sdca_function.h
 create mode 100644 sound/soc/sdca/Kconfig
 create mode 100644 sound/soc/sdca/Makefile
 create mode 100644 sound/soc/sdca/sdca_device.c
 create mode 100644 sound/soc/sdca/sdca_functions.c

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 283c8bfdde49..49d690f3d29a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -10,6 +10,7 @@
 #include <linux/irqdomain.h>
 #include <linux/mod_devicetable.h>
 #include <linux/bitfield.h>
+#include <sound/sdca.h>
 
 struct sdw_bus;
 struct sdw_slave;
@@ -663,6 +664,7 @@ struct sdw_slave_ops {
  * @is_mockup_device: status flag used to squelch errors in the command/control
  * protocol for SoundWire mockup devices
  * @sdw_dev_lock: mutex used to protect callbacks/remove races
+ * @sdca_data: structure containing all device data for SDCA helpers
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -686,6 +688,7 @@ struct sdw_slave {
 	bool first_interrupt_done;
 	bool is_mockup_device;
 	struct mutex sdw_dev_lock; /* protect callbacks/remove races */
+	struct sdca_device_data sdca_data;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
diff --git a/include/sound/sdca.h b/include/sound/sdca.h
new file mode 100644
index 000000000000..34473ca4c789
--- /dev/null
+++ b/include/sound/sdca.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ *
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#ifndef __SDCA_H__
+#define __SDCA_H__
+
+struct sdw_slave;
+
+#define SDCA_MAX_FUNCTION_COUNT 8
+
+/**
+ * sdca_device_desc - short descriptor for an SDCA Function
+ * @adr: ACPI address (used for SDCA register access)
+ * @type: Function topology type
+ * @name: human-readable string
+ */
+struct sdca_function_desc {
+	u64 adr;
+	u32 type;
+	const char *name;
+};
+
+/**
+ * sdca_device_data - structure containing all SDCA related information
+ * @sdca_interface_revision: value read from _DSD property, mainly to check
+ * for changes between silicon versions
+ * @num_functions: total number of supported SDCA functions. Invalid/unsupported
+ * functions will be skipped.
+ * @sdca_func: array of function descriptors
+ */
+struct sdca_device_data {
+	u32 interface_revision;
+	int num_functions;
+	struct sdca_function_desc sdca_func[SDCA_MAX_FUNCTION_COUNT];
+};
+
+#if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SDCA)
+
+void sdca_lookup_functions(struct sdw_slave *slave);
+void sdca_lookup_interface_revision(struct sdw_slave *slave);
+
+#else
+
+static inline void sdca_lookup_functions(struct sdw_slave *slave) {}
+static inline void sdca_lookup_interface_revision(struct sdw_slave *slave) {}
+
+#endif
+
+#endif
diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
new file mode 100644
index 000000000000..a01eec86b9a6
--- /dev/null
+++ b/include/sound/sdca_function.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ *
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#ifndef __SDCA_FUNCTION_H__
+#define __SDCA_FUNCTION_H__
+
+/*
+ * SDCA Function Types from SDCA specification v1.0a Section 5.1.2
+ * all Function types not described are reserved
+ * Note that SIMPLE_AMP, SIMPLE_MIC and SIMPLE_JACK Function Types
+ * are NOT defined in SDCA 1.0a, but they were defined in earlier
+ * drafts and are planned for 1.1.
+ */
+
+enum sdca_function_type {
+	SDCA_FUNCTION_TYPE_SMART_AMP	= 0x01,	/* Amplifier with protection features */
+	SDCA_FUNCTION_TYPE_SIMPLE_AMP	= 0x02,	/* subset of SmartAmp */
+	SDCA_FUNCTION_TYPE_SMART_MIC	= 0x03,	/* Smart microphone with acoustic triggers */
+	SDCA_FUNCTION_TYPE_SIMPLE_MIC	= 0x04,	/* subset of SmartMic */
+	SDCA_FUNCTION_TYPE_SPEAKER_MIC	= 0x05,	/* Combination of SmartMic and SmartAmp */
+	SDCA_FUNCTION_TYPE_UAJ		= 0x06,	/* 3.5mm Universal Audio jack */
+	SDCA_FUNCTION_TYPE_RJ		= 0x07,	/* Retaskable jack */
+	SDCA_FUNCTION_TYPE_SIMPLE_JACK	= 0x08,	/* Subset of UAJ */
+	SDCA_FUNCTION_TYPE_HID		= 0x0A,	/* Human Interface Device, for e.g. buttons */
+	SDCA_FUNCTION_TYPE_IMP_DEF	= 0x1F,	/* Implementation-defined function */
+};
+
+/* Human-readable names used for kernel logs and Function device registration/bind */
+#define	SDCA_FUNCTION_TYPE_SMART_AMP_NAME	"SmartAmp"
+#define	SDCA_FUNCTION_TYPE_SIMPLE_AMP_NAME	"SimpleAmp"
+#define	SDCA_FUNCTION_TYPE_SMART_MIC_NAME	"SmartMic"
+#define	SDCA_FUNCTION_TYPE_SIMPLE_MIC_NAME	"SimpleMic"
+#define	SDCA_FUNCTION_TYPE_SPEAKER_MIC_NAME	"SpeakerMic"
+#define	SDCA_FUNCTION_TYPE_UAJ_NAME		"UAJ"
+#define	SDCA_FUNCTION_TYPE_RJ_NAME		"RJ"
+#define	SDCA_FUNCTION_TYPE_SIMPLE_NAME		"SimpleJack"
+#define	SDCA_FUNCTION_TYPE_HID_NAME		"HID"
+
+enum sdca_entity0_controls {
+	SDCA_CONTROL_ENTITY_0_COMMIT_GROUP_MASK		= 0x01,
+	SDCA_CONTROL_ENTITY_0_INTSTAT_CLEAR		= 0x02,
+	SDCA_CONTROL_ENTITY_0_INT_ENABLE		= 0x03,
+	SDCA_CONTROL_ENTITY_0_FUNCTION_SDCA_VERSION	= 0x04,
+	SDCA_CONTROL_ENTITY_0_FUNCTION_TOPOLOGY		= 0x05,
+	SDCA_CONTROL_ENTITY_0_FUNCTION_MANUFACTURER_ID	= 0x06,
+	SDCA_CONTROL_ENTITY_0_FUNCTION_ID		= 0x07,
+	SDCA_CONTROL_ENTITY_0_FUNCTION_VERSION		= 0x08
+};
+
+#endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index e87bd15a8b43..8e01b421fe8d 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -108,6 +108,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/qcom/Kconfig"
 source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
+source "sound/soc/sdca/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sof/Kconfig"
 source "sound/soc/spear/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 775bb38c2ed4..5307b0b62a93 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= qcom/
 obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
+obj-$(CONFIG_SND_SOC)	+= sdca/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sof/
 obj-$(CONFIG_SND_SOC)	+= spear/
diff --git a/sound/soc/sdca/Kconfig b/sound/soc/sdca/Kconfig
new file mode 100644
index 000000000000..07f6822fa614
--- /dev/null
+++ b/sound/soc/sdca/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SND_SOC_SDCA
+	tristate "ASoC SDCA library"
+	depends on ACPI
+	help
+	  This option enables support for the MIPI SoundWire Device
+	  Class for Audio (SDCA).
+
+config SND_SOC_SDCA_OPTIONAL
+	def_tristate SND_SOC_SDCA || !SND_SOC_SDCA
diff --git a/sound/soc/sdca/Makefile b/sound/soc/sdca/Makefile
new file mode 100644
index 000000000000..c296bd5a0a7c
--- /dev/null
+++ b/sound/soc/sdca/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+snd-soc-sdca-objs	:= sdca_functions.o sdca_device.o
+
+obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca.o
diff --git a/sound/soc/sdca/sdca_device.c b/sound/soc/sdca/sdca_device.c
new file mode 100644
index 000000000000..58f5f6f0f723
--- /dev/null
+++ b/sound/soc/sdca/sdca_device.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2024 Intel Corporation
+
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ */
+
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <sound/sdca.h>
+
+void sdca_lookup_interface_revision(struct sdw_slave *slave)
+{
+	struct fwnode_handle *fwnode = slave->dev.fwnode;
+
+	/*
+	 * if this property is not present, then the sdca_interface_revision will
+	 * remain zero, which will be considered as 'not defined' or 'invalid'.
+	 */
+	fwnode_property_read_u32(fwnode, "mipi-sdw-sdca-interface-revision",
+				 &slave->sdca_data.interface_revision);
+}
+EXPORT_SYMBOL_NS(sdca_lookup_interface_revision, SND_SOC_SDCA);
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
new file mode 100644
index 000000000000..a6ad57430dd4
--- /dev/null
+++ b/sound/soc/sdca/sdca_functions.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2024 Intel Corporation
+
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ */
+
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <sound/sdca.h>
+#include <sound/sdca_function.h>
+
+static int patch_sdca_function_type(struct device *dev,
+				    u32 interface_revision,
+				    u32 *function_type,
+				    const char **function_name)
+{
+	unsigned long function_type_patch = 0;
+
+	/*
+	 * Unfortunately early SDCA specifications used different indices for Functions,
+	 * for backwards compatibility we have to reorder the values found
+	 */
+	if (interface_revision >= 0x0801)
+		goto skip_early_draft_order;
+
+	switch (*function_type) {
+	case 1:
+		function_type_patch = SDCA_FUNCTION_TYPE_SMART_AMP;
+		break;
+	case 2:
+		function_type_patch = SDCA_FUNCTION_TYPE_SMART_MIC;
+		break;
+	case 3:
+		function_type_patch = SDCA_FUNCTION_TYPE_SPEAKER_MIC;
+		break;
+	case 4:
+		function_type_patch = SDCA_FUNCTION_TYPE_UAJ;
+		break;
+	case 5:
+		function_type_patch = SDCA_FUNCTION_TYPE_RJ;
+		break;
+	case 6:
+		function_type_patch = SDCA_FUNCTION_TYPE_HID;
+		break;
+	default:
+		dev_warn(dev, "%s: SDCA version %#x unsupported function type %d, skipped\n",
+			 __func__, interface_revision, *function_type);
+		return -EINVAL;
+	}
+
+skip_early_draft_order:
+	if (function_type_patch)
+		*function_type = function_type_patch;
+
+	/* now double-check the values */
+	switch (*function_type) {
+	case SDCA_FUNCTION_TYPE_SMART_AMP:
+		*function_name = SDCA_FUNCTION_TYPE_SMART_AMP_NAME;
+		break;
+	case SDCA_FUNCTION_TYPE_SMART_MIC:
+		*function_name = SDCA_FUNCTION_TYPE_SMART_MIC_NAME;
+		break;
+	case SDCA_FUNCTION_TYPE_UAJ:
+		*function_name = SDCA_FUNCTION_TYPE_UAJ_NAME;
+		break;
+	case SDCA_FUNCTION_TYPE_HID:
+		*function_name = SDCA_FUNCTION_TYPE_HID_NAME;
+		break;
+	case SDCA_FUNCTION_TYPE_SIMPLE_AMP:
+	case SDCA_FUNCTION_TYPE_SIMPLE_MIC:
+	case SDCA_FUNCTION_TYPE_SPEAKER_MIC:
+	case SDCA_FUNCTION_TYPE_RJ:
+	case SDCA_FUNCTION_TYPE_IMP_DEF:
+		dev_warn(dev, "%s: found unsupported SDCA function type %d, skipped\n",
+			 __func__, *function_type);
+		return -EINVAL;
+	default:
+		dev_err(dev, "%s: found invalid SDCA function type %d, skipped\n",
+			__func__, *function_type);
+		return -EINVAL;
+	}
+
+	dev_info(dev, "%s: found SDCA function %s (type %d)\n",
+		 __func__, *function_name, *function_type);
+
+	return 0;
+}
+
+static int find_sdca_function(struct acpi_device *adev, void *data)
+{
+	struct fwnode_handle *function_node = acpi_fwnode_handle(adev);
+	struct sdca_device_data *sdca_data = data;
+	struct device *dev = &adev->dev;
+	struct fwnode_handle *control5; /* used to identify function type */
+	const char *function_name;
+	u32 function_type;
+	int func_index;
+	u64 addr;
+	int ret;
+
+	if (sdca_data->num_functions >= SDCA_MAX_FUNCTION_COUNT) {
+		dev_err(dev, "%s: maximum number of functions exceeded\n", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * The number of functions cannot exceed 8, we could use
+	 * acpi_get_local_address() but the value is stored as u64 so
+	 * we might as well avoid casts and intermediate levels
+	 */
+	ret = acpi_get_local_u64_address(adev->handle, &addr);
+	if (ret < 0)
+		return ret;
+
+	if (!addr) {
+		dev_err(dev, "%s: no addr\n", __func__);
+		return -ENODEV;
+	}
+
+	/*
+	 * Extracting the topology type for an SDCA function is a
+	 * convoluted process.
+	 * The Function type is only visible as a result of a read
+	 * from a control. In theory this would mean reading from the hardware,
+	 * but the SDCA/DisCo specs defined the notion of "DC value" - a constant
+	 * represented with a DSD subproperty.
+	 * Drivers have to query the properties for the control
+	 * SDCA_CONTROL_ENTITY_0_FUNCTION_TOPOLOGY (0x05)
+	 */
+	control5 = fwnode_get_named_child_node(function_node,
+					       "mipi-sdca-control-0x5-subproperties");
+	if (!control5)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u32(control5, "mipi-sdca-control-dc-value",
+				       &function_type);
+
+	fwnode_handle_put(control5);
+
+	if (ret < 0) {
+		dev_err(dev, "%s: the function type can only be determined from ACPI information\n",
+			__func__);
+		return ret;
+	}
+
+	ret = patch_sdca_function_type(dev, sdca_data->interface_revision,
+				       &function_type, &function_name);
+	if (ret < 0)
+		return ret;
+
+	/* store results */
+	func_index = sdca_data->num_functions;
+	sdca_data->sdca_func[func_index].adr = addr;
+	sdca_data->sdca_func[func_index].type = function_type;
+	sdca_data->sdca_func[func_index].name = function_name;
+	sdca_data->num_functions++;
+
+	return 0;
+}
+
+void sdca_lookup_functions(struct sdw_slave *slave)
+{
+	struct device *dev = &slave->dev;
+	struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+	acpi_dev_for_each_child(adev, find_sdca_function, &slave->sdca_data);
+}
+EXPORT_SYMBOL_NS(sdca_lookup_functions, SND_SOC_SDCA);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SDCA library");
-- 
2.43.0


