Return-Path: <linux-kernel+bounces-517757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD2A3854E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369E83A5CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930D21D583;
	Mon, 17 Feb 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YsRrN5Eu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A521CC54;
	Mon, 17 Feb 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800938; cv=none; b=nmMIyK1vuDhr9qatLMHGX9NPyIUT8NfxdikRJQrps7zCvUA9GTooXSfESOFhe2EnJmZOKpkOj+5TigoDbEz7sVNye/8IoDqf1CjRa2b4cdG4lNwuFs7Db/JwP/yTAIgq1CCl8eR0dVDxHoHNlfrG9BVnlmRmQ2/rVC3afQLqtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800938; c=relaxed/simple;
	bh=7ZI3GQD7omVNDsHBsd4PwDzlPdeGko+6HoBaqG25IjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpZ30Mp0onDAik69S4203Jb3x3UuKIPz2O5w6LrtYJaCGKS4KeeALnQMubswdbcCfrgUO+hfzHra20KtXNTa952CX/KdTnAnpZJlarEVAk2gZaxYLAtwT9EDn0WZwUoQ+Mf93zr61P4RIEhjt5gZrTYVaXkMgKTcEKoHJzW48g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YsRrN5Eu; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCcKM3008975;
	Mon, 17 Feb 2025 08:02:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=15lqH1KNisZy3TQxc3hf4IRw7PhZ8JfZBz598u1ykNw=; b=
	YsRrN5EuDkjFHSoCz1GD/NGB0bp4GmcCXziPjp8+3xAXkIJeAu3rZOQtu2kYNJjz
	fu+MUbYZBGuqHofEjcklmbajsnFkc6edJYrw69scMdZbFwGi++p+tR8JBpjneqyP
	pyDxHWoHPECV2S3lf7s0RwJ7561YaEfH7GglbJ+BPOfoBdctD16L3cvDGR1tMOmX
	semArkYtubBbkyBgJch7vF2qq12ZPRYiuWGhAlu48r0K7TmUOc5PHK9bbuiRllUi
	8jIeei6rtmCjWnVajbkFgjljvj5XRV8oNA7GMaRzd4XKcgm842Q47ClJIBt4Uc/R
	nExI2KybQt5OBsuKIrDXfw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18x31-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:02:03 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 14:01:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 14:01:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DE7DA822567;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: SDCA: Add regmap helpers for parsing for DisCo Constant values
Date: Mon, 17 Feb 2025 14:01:58 +0000
Message-ID: <20250217140159.2288784-4-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: Rcq5I19RXm6Us2woPl0abPvOn5XJPxLz
X-Proofpoint-ORIG-GUID: Rcq5I19RXm6Us2woPl0abPvOn5XJPxLz
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b3415b cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=MoLhzvuKESCIkqKpY6wA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Add helpers to parse the DisCo Constant values from ACPI and populate an
array of reg_defaults with these. This will allow drivers to access
these ACPI specified values through the same interface as other
registers that are physically present on the device, using the regmap
cache.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_regmap.h  |  6 +++
 sound/soc/sdca/sdca_regmap.c | 80 ++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/sound/sdca_regmap.h b/include/sound/sdca_regmap.h
index 11826f4f0726..850533e83f3b 100644
--- a/include/sound/sdca_regmap.h
+++ b/include/sound/sdca_regmap.h
@@ -10,7 +10,9 @@
 #ifndef __SDCA_REGMAP_H__
 #define __SDCA_REGMAP_H__
 
+struct device;
 struct sdca_function_data;
+struct reg_default;
 
 bool sdca_regmap_readable(struct sdca_function_data *function, unsigned int reg);
 bool sdca_regmap_writeable(struct sdca_function_data *function, unsigned int reg);
@@ -18,4 +20,8 @@ bool sdca_regmap_volatile(struct sdca_function_data *function, unsigned int reg)
 bool sdca_regmap_deferrable(struct sdca_function_data *function, unsigned int reg);
 int sdca_regmap_mbq_size(struct sdca_function_data *function, unsigned int reg);
 
+int sdca_regmap_count_constants(struct device *dev, struct sdca_function_data *function);
+int sdca_regmap_populate_constants(struct device *dev, struct sdca_function_data *function,
+				   struct reg_default *consts);
+
 #endif // __SDCA_REGMAP_H__
diff --git a/sound/soc/sdca/sdca_regmap.c b/sound/soc/sdca/sdca_regmap.c
index ae6358f0fc26..dba4188620f9 100644
--- a/sound/soc/sdca/sdca_regmap.c
+++ b/sound/soc/sdca/sdca_regmap.c
@@ -10,8 +10,10 @@
 #include <linux/bitops.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/types.h>
+#include <sound/sdca.h>
 #include <sound/sdca_function.h>
 #include <sound/sdca_regmap.h>
 
@@ -188,5 +190,83 @@ int sdca_regmap_mbq_size(struct sdca_function_data *function, unsigned int reg)
 }
 EXPORT_SYMBOL_NS(sdca_regmap_mbq_size, "SND_SOC_SDCA");
 
+/**
+ * sdca_regmap_count_constants - count the number of DisCo constant Controls
+ * @dev: Pointer to the device.
+ * @function: Pointer to the Function information, to be parsed.
+ *
+ * This function returns the number of DisCo constant Controls present
+ * in a function. Typically this information will be used to populate
+ * the regmap defaults array, allowing drivers to access the values of
+ * DisCo constants as any other physical register.
+ *
+ * Return: Returns number of DisCo constant controls, or a negative error
+ * code on failure.
+ */
+int sdca_regmap_count_constants(struct device *dev,
+				struct sdca_function_data *function)
+{
+	int nconsts = 0;
+	int i, j;
+
+	for (i = 0; i < function->num_entities; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		for (j = 0; j < entity->num_controls; j++) {
+			if (entity->controls[j].mode == SDCA_ACCESS_MODE_DC)
+				nconsts += hweight64(entity->controls[j].cn_list);
+		}
+	}
+
+	return nconsts;
+}
+EXPORT_SYMBOL_NS(sdca_regmap_count_constants, "SND_SOC_SDCA");
+
+/**
+ * sdca_regmap_populate_constants - fill an array with DisCo constant values
+ * @dev: Pointer to the device.
+ * @function: Pointer to the Function information, to be parsed.
+ * @consts: Pointer to the array which should be filled with the DisCo
+ * constant values.
+ *
+ * This function will populate a regmap struct reg_default array with
+ * the values of the DisCo constants for a given Function. This
+ * allows to access the values of DisCo constants the same as any
+ * other physical register.
+ *
+ * Return: Returns the number of constants populated on success, a negative
+ * error code on failure.
+ */
+int sdca_regmap_populate_constants(struct device *dev,
+				   struct sdca_function_data *function,
+				   struct reg_default *consts)
+{
+	int i, j, k;
+
+	for (i = 0, k = 0; i < function->num_entities; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		for (j = 0; j < entity->num_controls; j++) {
+			struct sdca_control *control = &entity->controls[j];
+			int cn;
+
+			if (control->mode != SDCA_ACCESS_MODE_DC)
+				continue;
+
+			for_each_set_bit(cn, (unsigned long *)&control->cn_list,
+					 BITS_PER_TYPE(control->cn_list)) {
+				consts[k].reg = SDW_SDCA_CTL(function->desc->adr,
+							     entity->id,
+							     control->sel, cn);
+				consts[k].def = control->value;
+				k++;
+			}
+		}
+	}
+
+	return k;
+}
+EXPORT_SYMBOL_NS(sdca_regmap_populate_constants, "SND_SOC_SDCA");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SDCA library");
-- 
2.39.5


