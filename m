Return-Path: <linux-kernel+bounces-534275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944EA4650A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0F017E5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C19221D80;
	Wed, 26 Feb 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qT93Crg3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B39223302;
	Wed, 26 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583922; cv=none; b=PMqJRBb2wzVRKd9AbWlEOYgYd0t1P/HkAj29pOAhS+56Olqg7EEqwPhWBcQFoSpEileczCHGYvricJnMFlHTbh1x0Qyco7Q3t6zyZVZqwIXX2leUCLaQ43ND1av8avSbeNBpL1UK3JtNGQLY3ovmq3zKDTi3Qf1BIN42DB5RrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583922; c=relaxed/simple;
	bh=Ki3YteciZ4g0TZOkm1iABA8hLkvNF61/fCMl6jmX1GI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4lpwHIv2JxDvc5auIXWdYkMbFRfK+ZnzLeSrNtR4c/lZSlZfOflyDE/YNuQcTuHGb1iUXZfa9qoRvOrVyRPosrqfsD7IEvHtnX3u0sTZbwWtCNfKbVxf3+zQiFJJVawDaew0PvkmK8ndVU0Vce7X3o/ng7ZyWCeKa77kaWIgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qT93Crg3; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLj001993;
	Wed, 26 Feb 2025 09:31:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1gZk2cG2BQ3kjCIznizZXEa9/fhMIyJ+YLFLo/GNZPU=; b=
	qT93Crg3OXLIVqar8tVlWZ2ZfL8d9hTEd0eCZNHslDT2TA6rPAZ6ZRS6bcQB8G2M
	ccg7p4CcMeL3J3FnAzS5fhI9qNEPLrRT6NyoVTfQqoMn3nlQNrZCwdfKARo+Oot5
	/BA7XapW3UeGDd7N5HMIV7+lZ1fXflNC10ouC4Is4aQqU8QLl/1vkqiAuh3F9clk
	/iuIgng1+BSnP9pcbl/FDvAZXkHb8IwnCPwLu3Kh20DXkOVKQ0Y307jqQ7jm+m5D
	fvSBij/9YL43T3NqJvtppxrpGN7HwvkMURMuxcr8JbzFr+YNnINLHYJmbtPTlfUH
	Dczh5JvtAz7AKh+nYn5+AA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:40 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9765782255C;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 03/12] ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Wed, 26 Feb 2025 15:31:28 +0000
Message-ID: <20250226153137.2791938-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
References: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 36_VYblCDGAToDkU3QOHluetRRbMBzYZ
X-Proofpoint-ORIG-GUID: 36_VYblCDGAToDkU3QOHluetRRbMBzYZ
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33dc cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=K-sIY6LzpdCAYFUMqkcA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/tas2562.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index fef7ce39f6643..8e00dcc09d0c2 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -513,17 +513,9 @@ static const struct snd_kcontrol_new vsense_switch =
 static const struct snd_kcontrol_new tas2562_snd_controls[] = {
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
 		       tas2562_dac_tlv),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Digital Volume Control",
-		.index = 0,
-		.tlv.p = dvc_tlv,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info = snd_soc_info_volsw,
-		.get = tas2562_volume_control_get,
-		.put = tas2562_volume_control_put,
-		.private_value = SOC_SINGLE_VALUE(TAS2562_DVC_CFG1, 0, 110, 0, 0),
-	},
+	SOC_SINGLE_EXT_TLV("Digital Volume Control", TAS2562_DVC_CFG1, 0, 110, 0,
+			   tas2562_volume_control_get, tas2562_volume_control_put,
+			   dvc_tlv),
 };
 
 static const struct snd_soc_dapm_widget tas2110_dapm_widgets[] = {
-- 
2.39.5


