Return-Path: <linux-kernel+bounces-517756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF5A3854C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE72A7A31BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2B21D3CF;
	Mon, 17 Feb 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XvR7+GZ4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FD22083;
	Mon, 17 Feb 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800937; cv=none; b=LZ/Imtb5cDt1xDsGpvjPUJHs7hhcLSdbjvE/YNEOWXqelyVP8i3KAEyLR/XwfAlXM7Pbd4rJeuubmjca4UZeG1aZOPDedh5OGEC2ngRrkIAad+1LE6pBQU51/1RqS0hC0Wwvg9giB/bggqrUqwiksd+KHWRoXrXnuJeEqZLKmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800937; c=relaxed/simple;
	bh=7ZOePsI7De/wftuySY2eADs4tnzDsDXtA3MspwmGjj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+Fo8wzcXyDKYD9UaUlQjsS21RRt6go8dYs/ddRut+DPs5Lajz4tORM67yIlcQE/CUtTNPgQ3F2h5t8K++7YkLhIYjzqxSxi3jDU/qVM893zxVfbvmWFKUF8/oOmw4mT5OdTiB7w3hBlWz3p+695dQgUhp1jjAwdEgap7qLyaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XvR7+GZ4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H7w1b1014998;
	Mon, 17 Feb 2025 08:02:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=keDMlI0CFLvxS0/n6pF3Tl+h1Y2iZaJHdl1G3lfgYes=; b=
	XvR7+GZ4BI6J414NaMukqwRbRUWiQR1dDvfTrH5tpBB28g8CsLcgeXR6qmQN5zAq
	wACRa469UyzmafVBcz1xq27JR4ZwDKXmqtvRckVJgLp24H+KjuoRWTm9u3InT7+A
	6dJOHPC/z9DObiLBj+QtdZRsqnce5PC6xNv68dahncSkT8Eopwyc0qyFgp9/hoXP
	UpF1ZvhjPnLDfSowH7RUrT7Ty4wcpf+iqZ8PHfT4bLVUyziu14JKvxkPlBiXEIKE
	ceRbhYn3KE2Do/tdW/KugDBnrcyUxGx9mZXQnhaAKcCxV87Of2Hg4t2RdLZvbkJc
	6oqTRsqU0+7WPdAJiZjqgg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18x32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:02:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 14:01:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 14:01:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D09DA822566;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: SDCA: Add generic regmap SDCA helpers
Date: Mon, 17 Feb 2025 14:01:57 +0000
Message-ID: <20250217140159.2288784-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
References: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5nRYVmbENNeb9vbaPsqqBLYo6xAGe0yZ
X-Proofpoint-ORIG-GUID: 5nRYVmbENNeb9vbaPsqqBLYo6xAGe0yZ
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b34159 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=KJT-RnjOAAAA:8 a=w1d2syhTAAAA:8 a=Jel_ZZRJdv7A84t5tSwA:9 a=HE_01F9_QflCRFonrIQr:22
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Add helper functions that SDCA drivers can use to calculate the
properties of SDCA Controls (registers) specified through DisCo.
Most of these are fairly obvious from the SDCA Access Modes.

DisCo Constants, values which are specified in the ACPI rather than on
the device, are handled as unreadable and unwritable registers. The
intention is these will be populated in the register defaults table
allowing drivers to read them normally. This means the drivers can be
agnostic as to which values are DisCo Constants.

Finally, support for SDCA Dual Ranked Controls is currently limited
here, at the moment the current value will be used directly. Writing
the current value directly is valid as per the specification
although the synchronicity of updates across multiple registers is
lost. Support for this will probably need to be added later. But its a
fairly hard problem and doesn't need to be solved immediately.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_regmap.h  |  21 ++++
 sound/soc/sdca/Makefile      |   2 +-
 sound/soc/sdca/sdca_regmap.c | 192 +++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/sdca_regmap.h
 create mode 100644 sound/soc/sdca/sdca_regmap.c

diff --git a/include/sound/sdca_regmap.h b/include/sound/sdca_regmap.h
new file mode 100644
index 000000000000..11826f4f0726
--- /dev/null
+++ b/include/sound/sdca_regmap.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ *
+ * Copyright (C) 2025 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef __SDCA_REGMAP_H__
+#define __SDCA_REGMAP_H__
+
+struct sdca_function_data;
+
+bool sdca_regmap_readable(struct sdca_function_data *function, unsigned int reg);
+bool sdca_regmap_writeable(struct sdca_function_data *function, unsigned int reg);
+bool sdca_regmap_volatile(struct sdca_function_data *function, unsigned int reg);
+bool sdca_regmap_deferrable(struct sdca_function_data *function, unsigned int reg);
+int sdca_regmap_mbq_size(struct sdca_function_data *function, unsigned int reg);
+
+#endif // __SDCA_REGMAP_H__
diff --git a/sound/soc/sdca/Makefile b/sound/soc/sdca/Makefile
index 5d1ddbbfbf62..dddc3e694256 100644
--- a/sound/soc/sdca/Makefile
+++ b/sound/soc/sdca/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-snd-soc-sdca-y	:= sdca_functions.o sdca_device.o
+snd-soc-sdca-y	:= sdca_functions.o sdca_device.o sdca_regmap.o
 
 obj-$(CONFIG_SND_SOC_SDCA)	+= snd-soc-sdca.o
diff --git a/sound/soc/sdca/sdca_regmap.c b/sound/soc/sdca/sdca_regmap.c
new file mode 100644
index 000000000000..ae6358f0fc26
--- /dev/null
+++ b/sound/soc/sdca/sdca_regmap.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+/*
+ * The MIPI SDCA specification is available for public downloads at
+ * https://www.mipi.org/mipi-sdca-v1-0-download
+ */
+
+#include <linux/bitops.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/types.h>
+#include <sound/sdca_function.h>
+#include <sound/sdca_regmap.h>
+
+static struct sdca_entity *
+function_find_entity(struct sdca_function_data *function, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < function->num_entities; i++)
+		if (SDW_SDCA_CTL_ENT(reg) == function->entities[i].id)
+			return &function->entities[i];
+
+	return NULL;
+}
+
+static struct sdca_control *
+entity_find_control(struct sdca_entity *entity, unsigned int reg)
+{
+	int i;
+
+	for (i = 0; i < entity->num_controls; i++) {
+		if (SDW_SDCA_CTL_CSEL(reg) == entity->controls[i].sel)
+			return &entity->controls[i];
+	}
+
+	return NULL;
+}
+
+static struct sdca_control *
+function_find_control(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_entity *entity;
+
+	entity = function_find_entity(function, reg);
+	if (!entity)
+		return NULL;
+
+	return entity_find_control(entity, reg);
+}
+
+/**
+ * sdca_regmap_readable - return if a given SDCA Control is readable
+ * @function: Pointer to the Function information.
+ * @reg: Register address/Control to be processed.
+ *
+ * Return: Returns true if the register is readable.
+ */
+bool sdca_regmap_readable(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_control *control;
+
+	if (!SDW_SDCA_VALID_CTL(reg))
+		return false;
+
+	control = function_find_control(function, reg);
+	if (!control)
+		return false;
+
+	switch (control->mode) {
+	case SDCA_ACCESS_MODE_RW:
+	case SDCA_ACCESS_MODE_RO:
+	case SDCA_ACCESS_MODE_DUAL:
+	case SDCA_ACCESS_MODE_RW1S:
+	case SDCA_ACCESS_MODE_RW1C:
+		/* No access to registers marked solely for device use */
+		return control->layers & ~SDCA_ACCESS_LAYER_DEVICE;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS(sdca_regmap_readable, "SND_SOC_SDCA");
+
+/**
+ * sdca_regmap_writeable - return if a given SDCA Control is writeable
+ * @function: Pointer to the Function information.
+ * @reg: Register address/Control to be processed.
+ *
+ * Return: Returns true if the register is writeable.
+ */
+bool sdca_regmap_writeable(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_control *control;
+
+	if (!SDW_SDCA_VALID_CTL(reg))
+		return false;
+
+	control = function_find_control(function, reg);
+	if (!control)
+		return false;
+
+	switch (control->mode) {
+	case SDCA_ACCESS_MODE_RW:
+	case SDCA_ACCESS_MODE_DUAL:
+	case SDCA_ACCESS_MODE_RW1S:
+	case SDCA_ACCESS_MODE_RW1C:
+		/* No access to registers marked solely for device use */
+		return control->layers & ~SDCA_ACCESS_LAYER_DEVICE;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS(sdca_regmap_writeable, "SND_SOC_SDCA");
+
+/**
+ * sdca_regmap_volatile - return if a given SDCA Control is volatile
+ * @function: Pointer to the Function information.
+ * @reg: Register address/Control to be processed.
+ *
+ * Return: Returns true if the register is volatile.
+ */
+bool sdca_regmap_volatile(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_control *control;
+
+	if (!SDW_SDCA_VALID_CTL(reg))
+		return false;
+
+	control = function_find_control(function, reg);
+	if (!control)
+		return false;
+
+	switch (control->mode) {
+	case SDCA_ACCESS_MODE_RO:
+	case SDCA_ACCESS_MODE_RW1S:
+	case SDCA_ACCESS_MODE_RW1C:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS(sdca_regmap_volatile, "SND_SOC_SDCA");
+
+/**
+ * sdca_regmap_deferrable - return if a given SDCA Control is deferrable
+ * @function: Pointer to the Function information.
+ * @reg: Register address/Control to be processed.
+ *
+ * Return: Returns true if the register is deferrable.
+ */
+bool sdca_regmap_deferrable(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_control *control;
+
+	if (!SDW_SDCA_VALID_CTL(reg))
+		return false;
+
+	control = function_find_control(function, reg);
+	if (!control)
+		return false;
+
+	return control->deferrable;
+}
+EXPORT_SYMBOL_NS(sdca_regmap_deferrable, "SND_SOC_SDCA");
+
+/**
+ * sdca_regmap_mbq_size - return size in bytes of a given SDCA Control
+ * @function: Pointer to the Function information.
+ * @reg: Register address/Control to be processed.
+ *
+ * Return: Returns the size in bytes of the Control.
+ */
+int sdca_regmap_mbq_size(struct sdca_function_data *function, unsigned int reg)
+{
+	struct sdca_control *control;
+
+	if (!SDW_SDCA_VALID_CTL(reg))
+		return -EINVAL;
+
+	control = function_find_control(function, reg);
+	if (!control)
+		return false;
+
+	return clamp_val(control->nbits / BITS_PER_BYTE, sizeof(u8), sizeof(u32));
+}
+EXPORT_SYMBOL_NS(sdca_regmap_mbq_size, "SND_SOC_SDCA");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SDCA library");
-- 
2.39.5


