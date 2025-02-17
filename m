Return-Path: <linux-kernel+bounces-517759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344DA38551
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521BE3A6CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C96E21D59D;
	Mon, 17 Feb 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QHjPfQVy"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C821CA14;
	Mon, 17 Feb 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800938; cv=none; b=KKr4+l81j1+SMIDER6z9t6LBSdnAWP+VELHhZdSYNtvwgoaFo0sRN+/gxJumKrqtuzCo5tQqIXHYgvIkCtTKLZcni4KFtmqpwn1ONmh2lgtXp0I+cIJui8ZTp5hB6F6jtibhImVjbHHIcZHLn0X+KqTHPd6mGbgsKMrqnBGmhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800938; c=relaxed/simple;
	bh=bLmQRNhJGp37BO1Oi54whZkh82Syrfh2M0KXYDJpLmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEY+ugmJ9RwaqnxNS6lFIXXQal0hu6i0SrchL9z4WbnkwYkOCJqBx8rikzSYLzXHXKELlknTnqlFb8GXktOg8ND904eJ4zrJR51fO/fgKkReRsfXq9tGuslp2VDKoFofpPt9/fuEnTdfJ53F0+kqebn4hcREJ5ViUHsavX1+/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QHjPfQVy; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCcKM2008975;
	Mon, 17 Feb 2025 08:02:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=99ULd/dMeouDFHx6C8mCV8lHHYdW8FLhAx4UMJ1ztJk=; b=
	QHjPfQVy2A28Z9VA9sS8k5i2bz3A2V/okHIfemwxvC+OCqmR8z+366yJH+dvoysy
	TVGGeVE0S0NiXzvB4lF+5d6rRoy/XLSxwpkr2w+eeeHTBJMdXlbwtRlaXciTzyMz
	a3aoDEPYdTAe+GI91AWwxY4qihZgiX4NH9kdPrvcoBFoSdSCORKvuWizOCgHm6E8
	Our82Vs9Lkgw/IkRBHjkuX03rucMQMthn6NejrmFLgBLMlOURMeEMILuGvQmo95o
	YqDZlD12XsC5tw491odFS0QbTQoxfoEOdadRAYwi8KSfVke1b28q0nphXcKh6wln
	5l3//ViLuoOgr2D9mA4foQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18x31-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:02:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 14:02:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 14:02:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EBF04822568;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: SDCA: Add helper to write out defaults and fixed values
Date: Mon, 17 Feb 2025 14:01:59 +0000
Message-ID: <20250217140159.2288784-5-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: NcxQjK5ji-Lwwu9FSAGflLxzKkm6HzwX
X-Proofpoint-ORIG-GUID: NcxQjK5ji-Lwwu9FSAGflLxzKkm6HzwX
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b3415a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=y--imf3Z3oHrnomrQQsA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The concept of an SDCA default value differs slightly from the regmap
usage of the term. An SDCA default is a value that is parsed from DisCo
and then written out to the hardware if no user value has superceded
it. Add a helper function that will iterate through all the SDCA
Controls and write out any default values. After these have been written
out once they will exist in the cache and that will take care of any
user values superceeding them. The code here also writes out any
Controls with a fixed value as there is only one available value for
these Controls there is no point in allowing the user to select them,
simply treat them similarly to a default.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_regmap.h  |  4 +++
 sound/soc/sdca/sdca_regmap.c | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/sound/sdca_regmap.h b/include/sound/sdca_regmap.h
index 850533e83f3b..b2e3c2ad2bb8 100644
--- a/include/sound/sdca_regmap.h
+++ b/include/sound/sdca_regmap.h
@@ -12,6 +12,7 @@
 
 struct device;
 struct sdca_function_data;
+struct regmap;
 struct reg_default;
 
 bool sdca_regmap_readable(struct sdca_function_data *function, unsigned int reg);
@@ -24,4 +25,7 @@ int sdca_regmap_count_constants(struct device *dev, struct sdca_function_data *f
 int sdca_regmap_populate_constants(struct device *dev, struct sdca_function_data *function,
 				   struct reg_default *consts);
 
+int sdca_regmap_write_defaults(struct device *dev, struct regmap *regmap,
+			       struct sdca_function_data *function);
+
 #endif // __SDCA_REGMAP_H__
diff --git a/sound/soc/sdca/sdca_regmap.c b/sound/soc/sdca/sdca_regmap.c
index dba4188620f9..4b78188cfceb 100644
--- a/sound/soc/sdca/sdca_regmap.c
+++ b/sound/soc/sdca/sdca_regmap.c
@@ -268,5 +268,54 @@ int sdca_regmap_populate_constants(struct device *dev,
 }
 EXPORT_SYMBOL_NS(sdca_regmap_populate_constants, "SND_SOC_SDCA");
 
+/**
+ * sdca_regmap_write_defaults - write out DisCo defaults to device
+ * @dev: Pointer to the device.
+ * @regmap: Pointer to the Function register map.
+ * @function: Pointer to the Function information, to be parsed.
+ *
+ * This function will write out to the hardware all the DisCo default and
+ * fixed value controls. This will cause them to be populated into the cache,
+ * and subsequent handling can be done through a cache sync.
+ *
+ * Return: Returns zero on success, and a negative error code on failure.
+ */
+int sdca_regmap_write_defaults(struct device *dev, struct regmap *regmap,
+			       struct sdca_function_data *function)
+{
+	int i, j;
+	int ret;
+
+	for (i = 0; i < function->num_entities; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		for (j = 0; j < entity->num_controls; j++) {
+			struct sdca_control *control = &entity->controls[j];
+			int cn;
+
+			if (control->mode == SDCA_ACCESS_MODE_DC)
+				continue;
+
+			if (!control->has_default && !control->has_fixed)
+				continue;
+
+			for_each_set_bit(cn, (unsigned long *)&control->cn_list,
+					 BITS_PER_TYPE(control->cn_list)) {
+				unsigned int reg;
+
+				reg = SDW_SDCA_CTL(function->desc->adr, entity->id,
+						   control->sel, cn);
+
+				ret = regmap_write(regmap, reg, control->value);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_regmap_write_defaults, "SND_SOC_SDCA");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SDCA library");
-- 
2.39.5


