Return-Path: <linux-kernel+bounces-534279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38325A46502
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB72419C04F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9092224AF8;
	Wed, 26 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QvH/eusM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA484223320;
	Wed, 26 Feb 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583923; cv=none; b=i8PUh7GMdTV1eHIrsCak7BEzPzCp+F9jgbQCtTXTyZMF+Db0lA4Af0gYRIX+ewbcRXCLUMtjNZXPtpXvY5CDhCc6eZLM6KOGdrwT0kdcvgkti9Xn0TDVW3FIGDNUHnHVENpCAL1UL7e/YAmGmkQlEk2oASba80b185dnqMOPOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583923; c=relaxed/simple;
	bh=SASfia464CiAzxFdocq0lnOQ2B+i0ylY44C/RUdxb2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz+VxC7HkO45ZhMcHfEqf4KTUpmMv0I3j/nkeZeFrBQH9LVAX4PUs26LcULbn/kk+TcC72IXI4Mi9qL0yN9aZYvN6jYAq5BiwNWEKEzzn9y7N14cbq7eundsUuAt015H8wPt+lMskLyDKnXt3vP5gbE+Kwlg/PG7aRMNPYAvGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QvH/eusM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLn001993;
	Wed, 26 Feb 2025 09:31:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Pfe/AzTL5XTSs+iAqom4b56hQhyoLN9UVGuX+0WDjZ0=; b=
	QvH/eusM7gaZGXk4gQQd/ztCiXTbE64z+j3pwvF2iaTWHkyS485o+0cTTYaVr8eU
	Y3MhdGOBQWkfxh4cZa1DJ6WGIgkzPPhhOUzbex58YHRgUFOSF7AyTO3s6Gppfxv5
	0nYyjTvFysPv8EElq+Kc5XMLd/HENA0ve6Zs1RDMxcdLSvqzuWJtt8L2+Y9qCoBX
	+I9Y50L50tzYPUgbGFKMaEkv9T448xrulwbgU4PrnwMERNep3Tl5yD+aR9tWD910
	Mw6B3369SLDXXF8KuFi0pbyH/AjMza6d6tRbKSdnVbhZZOjNXZylAcOhtha+qMsX
	QZHazwn+5gsyLhk+KW+d6g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:42 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:38 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1340482025A;
	Wed, 26 Feb 2025 15:31:38 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 10/12] ASoC: dapm: Use ASoC control macros where possible
Date: Wed, 26 Feb 2025 15:31:35 +0000
Message-ID: <20250226153137.2791938-11-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: O1HhhWRYuGV7glEqanjB9sc5z3yMv1vl
X-Proofpoint-ORIG-GUID: O1HhhWRYuGV7glEqanjB9sc5z3yMv1vl
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33de cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=LvIDoIcrffR_hyHIGeUA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Update the DAPM kcontrol creation macros to use the ASoC macros where a
helpful version exists. One minor fixup is required in adau17x1, the
compiler doesn't like the extra level of macro indirection coupled with
the inline struct definition. Make the struct definition explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


