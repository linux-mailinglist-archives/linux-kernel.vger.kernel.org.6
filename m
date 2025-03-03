Return-Path: <linux-kernel+bounces-542444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143CA4C9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEB7189BBDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571325FA1A;
	Mon,  3 Mar 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W/r/zDMA"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003425E80E;
	Mon,  3 Mar 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022095; cv=none; b=Jcc9bdetqf3kZt08okWht43IZp0k3tci9F9pAKc0k+trJhCMRoJybOdqED+Qktf/FynlmUO9AlLHZG7ipf59Ld6c5TwJO0pOrHkqAu3efsUC5WWD+/WiIowPSHiYR1XyIqTeG46T7hAHWApX2BO8jJi97Tpe51kWWPIxdG/mhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022095; c=relaxed/simple;
	bh=rVVJWBn3mUggWkhB0ePVD+YI+ayWpl839k/gWNZOyTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYAjROUICVVFszYss/x6Q7ZM/yK4KRl4iHFIQcKitmqoTf/as/okFKM8HuVMii697DHMOycJ0GXqHe7cFXIfuog66UcKzIbY7U5lbNOUw1tsJAzMaU2+iBybC0f/e8tBMAT21TwjCRVVM0+8DQunu4oBVp8KDfHt2lUoFadPY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W/r/zDMA; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Xa006077;
	Mon, 3 Mar 2025 11:14:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=twL3bWrgitBSo+yJsQ+IkBJoZhd72b0uyxRSePw7eVw=; b=
	W/r/zDMA96FX0kw34FS4I6k4MEPqkuQCsghsH4GWw/UqFtrZQvstAXmwKY7Xlh03
	ehVCj8TEwPQrVFmgBRBOJ1s18DTGbZvDuLRQOklT5RlJWzdysn+xMSuRLsnvG4JF
	hTBC1amEs2fOzcLXfsT9NB1zSzwOW5Ep1GOGP8LNWMO8/wZmrKh/SkSBJJe1Zda1
	ysOTVX2GK0doMrZKDV1ctRSu8IEAvo2yqOYyXKCBfCdjSdtImhOPKIYZN9siPUY8
	e0bbOIAESD2vJZuhJjLzZl4273FGgHdch8CmqzgRJ5PoBWEE4WT5SevF6IADs7MX
	qF3Sly/8to8fZ729HotM+w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:34 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6E68782025A;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 04/13] ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Mon, 3 Mar 2025 17:14:15 +0000
Message-ID: <20250303171424.444556-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
References: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: K9rXozPc2z0lEIuilWHUWkzbbZ_RwAmr
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e37a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=K-sIY6LzpdCAYFUMqkcA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: K9rXozPc2z0lEIuilWHUWkzbbZ_RwAmr
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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


