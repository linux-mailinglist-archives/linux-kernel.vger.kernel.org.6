Return-Path: <linux-kernel+bounces-542441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA596A4C9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273C717CE8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9E25EF9B;
	Mon,  3 Mar 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R89N8v2g"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB225E47A;
	Mon,  3 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022094; cv=none; b=HCzOFE6J050f8c+bD83oohe4o5DLuvvOttC0vqF/aqH9S4lIXhsfNhm4AJ/NW8IG9/zaiOg8UH21KZYkn3pu/qpcgX/1RM0neDY77OilxsThbsFT0dy5OUUK9hsIGOeA2th4t7yHehA7PCEZwl8sn8nWtaQapdko2eEpsTLjWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022094; c=relaxed/simple;
	bh=1gP661rWIwjaCTm/g5GYus2jKYexqzn2dh/kvEGuD+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7+z/a2XurPZxFU6EB8z6L4dICxgEmhwrlVpLMuN/q22IAd9IgzsIQCYyBUY894LF9wbi710ATcZE+IVMAOyr0rAMlvZK0Bko1GjhqadPtRqtOKdzoClwxgjVV+u69pSUICtqrnnGiHO7YKmMCRRNqZgmsaNjBRbtk57/M4A25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R89N8v2g; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Xe006077;
	Mon, 3 Mar 2025 11:14:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vL9cq0q1mTMDNULTE6OOr7BIk9NpaXgRFpdn7XU0S1A=; b=
	R89N8v2g7Psq7IQuaMcyNwDhFALBzeEQ3WAyUiONX5ugKbEpAX/RxAd5QWrUDptQ
	FT1YYn5XPg85F4aUxOywGcHbLKOd2xN3AZMBaTwgCyMxg4UCl+6AC1+qxXSVxyw3
	rSPOhJohh4g7DR4Rifnw3yjrk17RkJSpc7wnwwAfw4sVo7cm2VDWw0QFkn5Zlv2U
	O6/+snTFkhm37r6dJkOVwVpCdQkAZQsswv/ux6k6jV+swyNm6eLB6b9OSSi+eWoL
	l1BNhAnf1kiAETog7xnO4NBIKSnVOkkaonifIPH06FziubFP2YlCkNqvzkIf9qJG
	jPETc5MzCePZDWLncArr9A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:36 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EAE4C82025A;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 11/13] ASoC: dapm: Use ASoC control macros where possible
Date: Mon, 3 Mar 2025 17:14:22 +0000
Message-ID: <20250303171424.444556-12-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: WIP7DM1icWObxlI1ZZisCl1a-QOdr4rZ
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e37c cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=LvIDoIcrffR_hyHIGeUA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: WIP7DM1icWObxlI1ZZisCl1a-QOdr4rZ
X-Proofpoint-Spam-Reason: safe

Update the DAPM kcontrol creation macros to use the ASoC macros where a
helpful version exists. One minor fixup is required in adau17x1, the
compiler doesn't like the extra level of macro indirection coupled with
the inline struct definition. Make the struct definition explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 include/sound/soc-dapm.h    | 62 +++++++++++++------------------------
 sound/soc/codecs/adau17x1.c | 10 +++---
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bed1c37529aca..4b8ef5b8a391e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -326,41 +326,37 @@ struct soc_enum;
 
 /* dapm kcontrol types */
 #define SOC_DAPM_DOUBLE(xname, reg, lshift, rshift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_DOUBLE_VALUE(reg, lshift, rshift, max, invert, 0) }
+	SOC_DOUBLE_EXT(xname, reg, lshift, rshift, max, invert, \
+		       snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw)
 #define SOC_DAPM_DOUBLE_R(xname, lreg, rreg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_DOUBLE_R_VALUE(lreg, rreg, shift, max, invert) }
+	SOC_DOUBLE_R_EXT(xname, lreg, rreg, shift, max, invert, \
+			 snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw)
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
-#define SOC_DAPM_SINGLE_AUTODISABLE(xname, reg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
+	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
+		       snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw)
 #define SOC_DAPM_SINGLE_VIRT(xname, max) \
 	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0)
 #define SOC_DAPM_DOUBLE_R_TLV(xname, lreg, rreg, shift, max, invert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_DOUBLE_R_VALUE(lreg, rreg, shift, max, invert) }
+	SOC_DOUBLE_R_EXT_TLV(xname, lreg, rreg, shift, max, invert, \
+			     snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw, \
+			     tlv_array)
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+	SOC_SINGLE_EXT_TLV(xname, reg, shift, max, invert, \
+			   snd_soc_dapm_get_volsw, snd_soc_dapm_put_volsw, \
+			   tlv_array)
+#define SOC_DAPM_SINGLE_TLV_VIRT(xname, max, tlv_array) \
+	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0, tlv_array)
+#define SOC_DAPM_ENUM(xname, xenum) \
+	SOC_ENUM_EXT(xname, xenum, snd_soc_dapm_get_enum_double, \
+		     snd_soc_dapm_put_enum_double)
+#define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
+	SOC_ENUM_EXT(xname, xenum, xget, xput)
+
+#define SOC_DAPM_SINGLE_AUTODISABLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
 #define SOC_DAPM_SINGLE_TLV_AUTODISABLE(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -368,20 +364,6 @@ struct soc_enum;
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
-#define SOC_DAPM_SINGLE_TLV_VIRT(xname, max, tlv_array) \
-	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0, tlv_array)
-#define SOC_DAPM_ENUM(xname, xenum) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
- 	.get = snd_soc_dapm_get_enum_double, \
- 	.put = snd_soc_dapm_put_enum_double, \
-  	.private_value = (unsigned long)&xenum }
-#define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
-	.get = xget, \
-	.put = xput, \
-	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_PIN_SWITCH(xname) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
 	.info = snd_soc_dapm_info_pin_switch, \
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 4dcc984761e0a..2ebb5c90bdd91 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -254,11 +254,13 @@ static int adau17x1_dsp_mux_enum_get(struct snd_kcontrol *kcontrol,
 }
 
 #define DECLARE_ADAU17X1_DSP_MUX_CTRL(_name, _label, _stream, _text) \
-	const struct snd_kcontrol_new _name = \
-		SOC_DAPM_ENUM_EXT(_label, (const struct soc_enum)\
+	const struct soc_enum _name##_enum = \
 			SOC_ENUM_SINGLE(SND_SOC_NOPM, _stream, \
-				ARRAY_SIZE(_text), _text), \
-			adau17x1_dsp_mux_enum_get, adau17x1_dsp_mux_enum_put)
+					ARRAY_SIZE(_text), _text); \
+	const struct snd_kcontrol_new _name = \
+		SOC_DAPM_ENUM_EXT(_label, _name##_enum, \
+				  adau17x1_dsp_mux_enum_get, \
+				  adau17x1_dsp_mux_enum_put)
 
 static const char * const adau17x1_dac_mux_text[] = {
 	"DSP",
-- 
2.39.5


