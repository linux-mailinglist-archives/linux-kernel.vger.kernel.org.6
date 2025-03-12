Return-Path: <linux-kernel+bounces-558201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A74A5E2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046DF3BC777
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E325A624;
	Wed, 12 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WHPe6Asv"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11C2528E3;
	Wed, 12 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800159; cv=none; b=Ao7g9fMAmTPzMh7aNhN+VpHeCFBdYkzHA0UAeBysJ292Grm6HHiHvtOG8XXXyIlSfEJ2A49kl/rnHsUxbFpKBcncyoDi3wnL1swswue2TdpdnhvLDfVm1S8tpbtSjDObc6nKGc1t896S6skvhQe1U0PTLY2/VNDnkw7Q5Dogqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800159; c=relaxed/simple;
	bh=DEBA1DqrD4xhubtAmUSqhvmj3w7ocGcaKJuhEmxFgGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUqrbR1ret0mEx+AdWQJA8V0l7gYpRZD6/6o/q16LR+1HhX2uRPMCc6VfrD1sEjBj53x9W/S9UOIflG93mwZLtTVgLXWuC5gHkXyjbpxMN8hVsREFqYaB5NUk22Ji/SaUSj1pQqN0JtxKj4XI+hcJ8w7BI+IpUhHX7IxLLfjeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WHPe6Asv; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6FZHN029588;
	Wed, 12 Mar 2025 12:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FCKe6FOW3iK/t8TOPcHhf3i7jr5ixSZpsHGCm7R+a6U=; b=
	WHPe6AsvCSjoCZvXBRE+tTf1x1pxkPT21uxkPi+ROjj2G9zpycCOdRYZheHlpjoq
	zGh5K9SVlq3OgLl8ncKB3zdpWiVY3POWL2GKwa8r1dQpXwGuh1Ofdd6vrTIYiTiC
	FL0DehctuGN5dTQzIT3BuLJbSLmcwOfy+qj6MRN/B/NyTVz1kGrERErBEBW419GC
	T352WCZQWj+gM4tiZrhkyvla6fIugp0Ty5s0vj5zhyDgDmwJL6rvIn2ym8X9mwVq
	XUGS5++uFRamOtH1Bbjqx9cYyozMMI+JH+2mHFpwyPQlOcvyben84WWnCYivW3cU
	rzSQ7qEumm5AB2dfCXcx3A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 462D982255F;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/6] ASoC: SDCA: Add type flag for Controls
Date: Wed, 12 Mar 2025 17:22:03 +0000
Message-ID: <20250312172205.4152686-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
References: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ao7UG8gO6BhxEMSS2QpAcOphT7nhxK2G
X-Proofpoint-GUID: Ao7UG8gO6BhxEMSS2QpAcOphT7nhxK2G
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2be cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=yK4xkOhfw2pVJqvsVIwA:9
X-Proofpoint-Spam-Reason: safe

SDCA Controls come in a variety of data formats, to simplify later
parsing work out this data type as the control is parsed and stash it
for later use.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_function.h   |  23 +++++
 sound/soc/sdca/sdca_functions.c | 173 ++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index f001ab643fed4..ca0376903e87c 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -600,6 +600,27 @@ enum sdca_entity0_controls {
 #define SDCA_CTL_DEVICE_VERSION_NAME			"Device Version"
 #define SDCA_CTL_DEVICE_SDCA_VERSION_NAME		"Device SDCA Version"
 
+/**
+ * enum sdca_control_datatype - SDCA Control Data Types
+ *
+ * Data Types as described in the SDCA specification v1.0 section
+ * 7.3.
+ */
+enum sdca_control_datatype {
+	SDCA_CTL_DATATYPE_ONEBIT,
+	SDCA_CTL_DATATYPE_INTEGER,
+	SDCA_CTL_DATATYPE_SPEC_ENCODED_VALUE,
+	SDCA_CTL_DATATYPE_BCD,
+	SDCA_CTL_DATATYPE_Q7P8DB,
+	SDCA_CTL_DATATYPE_BYTEINDEX,
+	SDCA_CTL_DATATYPE_POSTURENUMBER,
+	SDCA_CTL_DATATYPE_DP_INDEX,
+	SDCA_CTL_DATATYPE_BITINDEX,
+	SDCA_CTL_DATATYPE_BITMAP,
+	SDCA_CTL_DATATYPE_GUID,
+	SDCA_CTL_DATATYPE_IMPDEF,
+};
+
 /**
  * enum sdca_access_mode - SDCA Control access mode
  *
@@ -653,6 +674,7 @@ struct sdca_control_range {
  * @cn_list: A bitmask showing the valid Control Numbers within this Control,
  * Control Numbers typically represent channels.
  * @range: Buffer describing valid range of values for the Control.
+ * @type: Format of the data in the Control.
  * @mode: Access mode of the Control.
  * @layers: Bitmask of access layers of the Control.
  * @deferrable: Indicates if the access to the Control can be deferred.
@@ -669,6 +691,7 @@ struct sdca_control {
 	u64 cn_list;
 
 	struct sdca_control_range range;
+	enum sdca_control_datatype type;
 	enum sdca_access_mode mode;
 	u8 layers;
 
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 1e36dd20d7abf..0cc25fb9679b4 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -603,6 +603,178 @@ static unsigned int find_sdca_control_bits(const struct sdca_entity *entity,
 	}
 }
 
+static enum sdca_control_datatype
+find_sdca_control_datatype(const struct sdca_entity *entity,
+			   const struct sdca_control *control)
+{
+	switch (SDCA_CTL_TYPE(entity->type, control->sel)) {
+	case SDCA_CTL_TYPE_S(XU, BYPASS):
+	case SDCA_CTL_TYPE_S(MFPU, BYPASS):
+	case SDCA_CTL_TYPE_S(FU, MUTE):
+	case SDCA_CTL_TYPE_S(FU, AGC):
+	case SDCA_CTL_TYPE_S(FU, BASS_BOOST):
+	case SDCA_CTL_TYPE_S(FU, LOUDNESS):
+		return SDCA_CTL_DATATYPE_ONEBIT;
+	case SDCA_CTL_TYPE_S(IT, LATENCY):
+	case SDCA_CTL_TYPE_S(OT, LATENCY):
+	case SDCA_CTL_TYPE_S(MU, LATENCY):
+	case SDCA_CTL_TYPE_S(SU, LATENCY):
+	case SDCA_CTL_TYPE_S(FU, LATENCY):
+	case SDCA_CTL_TYPE_S(XU, LATENCY):
+	case SDCA_CTL_TYPE_S(CRU, LATENCY):
+	case SDCA_CTL_TYPE_S(UDMPU, LATENCY):
+	case SDCA_CTL_TYPE_S(MFPU, LATENCY):
+	case SDCA_CTL_TYPE_S(SMPU, LATENCY):
+	case SDCA_CTL_TYPE_S(SAPU, LATENCY):
+	case SDCA_CTL_TYPE_S(PPU, LATENCY):
+	case SDCA_CTL_TYPE_S(SU, SELECTOR):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_0):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_1):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_2):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_3):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_4):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_5):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_6):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_7):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_8):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_9):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_10):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_11):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_12):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_13):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_14):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_15):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_16):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_17):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_18):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_19):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_20):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_21):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_22):
+	case SDCA_CTL_TYPE_S(UDMPU, OPAQUESET_23):
+	case SDCA_CTL_TYPE_S(SAPU, PROTECTION_MODE):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_BUFFER_PREAMBLE):
+	case SDCA_CTL_TYPE_S(XU, FDL_HOST_REQUEST):
+	case SDCA_CTL_TYPE_S(XU, XU_ID):
+	case SDCA_CTL_TYPE_S(CX, CLOCK_SELECT):
+	case SDCA_CTL_TYPE_S(TG, TONE_DIVIDER):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_MANUFACTURER_ID):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_ID):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_EXTENSION_ID):
+	case SDCA_CTL_TYPE_S(ENTITY_0, DEVICE_MANUFACTURER_ID):
+	case SDCA_CTL_TYPE_S(ENTITY_0, DEVICE_PART_ID):
+	case SDCA_CTL_TYPE_S(XU, FDL_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(XU, FDL_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SPE, AUTHTX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SPE, AUTHTX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SPE, AUTHRX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SPE, AUTHRX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(MFPU, AE_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(MFPU, AE_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SMPU, DTODTX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SMPU, DTODTX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SMPU, DTODRX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SMPU, DTODRX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SAPU, DTODTX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SAPU, DTODTX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(SAPU, DTODRX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(SAPU, DTODRX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(HIDE, HIDTX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(HIDE, HIDTX_MESSAGELENGTH):
+	case SDCA_CTL_TYPE_S(HIDE, HIDRX_MESSAGEOFFSET):
+	case SDCA_CTL_TYPE_S(HIDE, HIDRX_MESSAGELENGTH):
+		return SDCA_CTL_DATATYPE_INTEGER;
+	case SDCA_CTL_TYPE_S(IT, MIC_BIAS):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_BUFFER_MODE):
+	case SDCA_CTL_TYPE_S(PDE, REQUESTED_PS):
+	case SDCA_CTL_TYPE_S(PDE, ACTUAL_PS):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_TYPE):
+		return SDCA_CTL_DATATYPE_SPEC_ENCODED_VALUE;
+	case SDCA_CTL_TYPE_S(XU, XU_VERSION):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_SDCA_VERSION):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_VERSION):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_EXTENSION_VERSION):
+	case SDCA_CTL_TYPE_S(ENTITY_0, DEVICE_VERSION):
+	case SDCA_CTL_TYPE_S(ENTITY_0, DEVICE_SDCA_VERSION):
+		return SDCA_CTL_DATATYPE_BCD;
+	case SDCA_CTL_TYPE_S(FU, CHANNEL_VOLUME):
+	case SDCA_CTL_TYPE_S(FU, GAIN):
+	case SDCA_CTL_TYPE_S(MU, MIXER):
+	case SDCA_CTL_TYPE_S(PPU, HORIZONTALBALANCE):
+	case SDCA_CTL_TYPE_S(PPU, VERTICALBALANCE):
+	case SDCA_CTL_TYPE_S(MFPU, ULTRASOUND_LEVEL):
+	case SDCA_CTL_TYPE_S(UDMPU, ACOUSTIC_ENERGY_LEVEL_MONITOR):
+	case SDCA_CTL_TYPE_S(UDMPU, ULTRASOUND_LOOP_GAIN):
+		return SDCA_CTL_DATATYPE_Q7P8DB;
+	case SDCA_CTL_TYPE_S(IT, USAGE):
+	case SDCA_CTL_TYPE_S(OT, USAGE):
+	case SDCA_CTL_TYPE_S(IT, CLUSTERINDEX):
+	case SDCA_CTL_TYPE_S(CRU, CLUSTERINDEX):
+	case SDCA_CTL_TYPE_S(UDMPU, CLUSTERINDEX):
+	case SDCA_CTL_TYPE_S(MFPU, CLUSTERINDEX):
+	case SDCA_CTL_TYPE_S(MFPU, CENTER_FREQUENCY_INDEX):
+	case SDCA_CTL_TYPE_S(MFPU, AE_NUMBER):
+	case SDCA_CTL_TYPE_S(SAPU, OPAQUESETREQ_INDEX):
+	case SDCA_CTL_TYPE_S(XU, FDL_SET_INDEX):
+	case SDCA_CTL_TYPE_S(CS, SAMPLERATEINDEX):
+	case SDCA_CTL_TYPE_S(GE, SELECTED_MODE):
+	case SDCA_CTL_TYPE_S(GE, DETECTED_MODE):
+		return SDCA_CTL_DATATYPE_BYTEINDEX;
+	case SDCA_CTL_TYPE_S(PPU, POSTURENUMBER):
+		return SDCA_CTL_DATATYPE_POSTURENUMBER;
+	case SDCA_CTL_TYPE_S(IT, DATAPORT_SELECTOR):
+	case SDCA_CTL_TYPE_S(OT, DATAPORT_SELECTOR):
+		return SDCA_CTL_DATATYPE_DP_INDEX;
+	case SDCA_CTL_TYPE_S(MFPU, ALGORITHM_READY):
+	case SDCA_CTL_TYPE_S(MFPU, ALGORITHM_ENABLE):
+	case SDCA_CTL_TYPE_S(MFPU, ALGORITHM_PREPARE):
+	case SDCA_CTL_TYPE_S(SAPU, PROTECTION_STATUS):
+	case SDCA_CTL_TYPE_S(SMPU, TRIGGER_ENABLE):
+	case SDCA_CTL_TYPE_S(SMPU, TRIGGER_STATUS):
+	case SDCA_CTL_TYPE_S(SMPU, TRIGGER_READY):
+	case SDCA_CTL_TYPE_S(SPE, PRIVACY_POLICY):
+	case SDCA_CTL_TYPE_S(SPE, PRIVACY_OWNER):
+		return SDCA_CTL_DATATYPE_BITINDEX;
+	case SDCA_CTL_TYPE_S(IT, KEEP_ALIVE):
+	case SDCA_CTL_TYPE_S(OT, KEEP_ALIVE):
+	case SDCA_CTL_TYPE_S(IT, NDAI_STREAM):
+	case SDCA_CTL_TYPE_S(OT, NDAI_STREAM):
+	case SDCA_CTL_TYPE_S(IT, NDAI_CATEGORY):
+	case SDCA_CTL_TYPE_S(OT, NDAI_CATEGORY):
+	case SDCA_CTL_TYPE_S(IT, NDAI_CODINGTYPE):
+	case SDCA_CTL_TYPE_S(OT, NDAI_CODINGTYPE):
+	case SDCA_CTL_TYPE_S(IT, NDAI_PACKETTYPE):
+	case SDCA_CTL_TYPE_S(OT, NDAI_PACKETTYPE):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_ERROR):
+	case SDCA_CTL_TYPE_S(XU, FDL_STATUS):
+	case SDCA_CTL_TYPE_S(CS, CLOCK_VALID):
+	case SDCA_CTL_TYPE_S(SPE, PRIVACY_LOCKSTATE):
+	case SDCA_CTL_TYPE_S(ENTITY_0, COMMIT_GROUP_MASK):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_STATUS):
+	case SDCA_CTL_TYPE_S(ENTITY_0, FUNCTION_ACTION):
+	case SDCA_CTL_TYPE_S(XU, FDL_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SPE, AUTHTX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SPE, AUTHRX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(MFPU, AE_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SMPU, HIST_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SMPU, DTODTX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SMPU, DTODRX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SAPU, DTODTX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(SAPU, DTODRX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(HIDE, HIDTX_CURRENTOWNER):
+	case SDCA_CTL_TYPE_S(HIDE, HIDRX_CURRENTOWNER):
+		return SDCA_CTL_DATATYPE_BITMAP;
+	case SDCA_CTL_TYPE_S(IT, MATCHING_GUID):
+	case SDCA_CTL_TYPE_S(OT, MATCHING_GUID):
+	case SDCA_CTL_TYPE_S(ENTITY_0, MATCHING_GUID):
+		return SDCA_CTL_DATATYPE_GUID;
+	default:
+		return SDCA_CTL_DATATYPE_IMPDEF;
+	}
+}
+
 static int find_sdca_control_range(struct device *dev,
 				   struct fwnode_handle *control_node,
 				   struct sdca_control_range *range)
@@ -744,6 +916,7 @@ static int find_sdca_entity_control(struct device *dev, struct sdca_entity *enti
 	if (!control->label)
 		return -ENOMEM;
 
+	control->type = find_sdca_control_datatype(entity, control);
 	control->nbits = find_sdca_control_bits(entity, control);
 
 	dev_info(dev, "%s: %s: control %#x mode %#x layers %#x cn %#llx int %d value %#x %s\n",
-- 
2.39.5


