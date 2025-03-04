Return-Path: <linux-kernel+bounces-544344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4FA4E042
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B157D188BBB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973A204F73;
	Tue,  4 Mar 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h+MqNMRz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327782066FE;
	Tue,  4 Mar 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097175; cv=none; b=aojrmftq5CohbrvtlA3gMww6qrqydbr/Q2S3VEB/vJj0bSw+Z4vdQ8sdMfDkBqW3oEpMXlWizlgWt+Ee5RAwkewuejfrGYxUtpsYQnF+WOA03Jdu9AU3OvV8oUCicdqZrOUWLzGGZX/yZX7N1bYDoToyVJyeXwSBv7crQUxDfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097175; c=relaxed/simple;
	bh=1eUdyBvGtfbnspHF/hYnvnxrApW6v84nDRf+FmXaA6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZqZoQZ4SwJBUCwEoHAnJHH8TXqS3sWcaUycYV0clyWhHaP2Um7hYYDLPKZrTo//cK/AkyKL7lVjvjM3el8Wg+d0/ClXa6X234LNm6ngeZ5Ixc5CMFJu83Tq8uoHSWUFvB9YJqU3vLz2DcKm7mUaJe2YcymGYHpEB8SSPU+yNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h+MqNMRz; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HNC003809;
	Tue, 4 Mar 2025 08:05:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Er9FOS7TTQ2Wteg4shU6+ZEjie89QKm7CENPmU6RTNw=; b=
	h+MqNMRzV78YrKa6w0kYv/qVuhCa2PiNP7r91mbLYWcF55Q7uyOS6JkrJQ66EpUZ
	8/XtImc7Ccz+ONlTrF1OY/bL+9yuisVymORESbB19qv0NE0hjFJsKTwiWN6JA/Ea
	CibfRuAae/MDWtPrLkex5YetoarT3XPF1135s1qj2UCgz6PbX5jPa3gHmJ1Zo18I
	c37wquayk9QVCdifZLVqvNDiSEXysbDfj83nCv4JXgZUtS06iLT7hM4exBjclftt
	hXs8IujwpNoOquFdfyY3U/VUMpRDkB/Mdtgm9s1caoDY+iOUsXB/YxHGAEZYEJDI
	fnyqisxgjxjN/PHb82IDog==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:55 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A1CDC82255C;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 11/13] ASoC: dapm: Use ASoC control macros where possible
Date: Tue, 4 Mar 2025 14:04:58 +0000
Message-ID: <20250304140500.976127-12-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
References: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IUcQRBZ7AR9QUL2BblHA9nRiuKrkaiU9
X-Proofpoint-ORIG-GUID: IUcQRBZ7AR9QUL2BblHA9nRiuKrkaiU9
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708c3 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=LvIDoIcrffR_hyHIGeUA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Update the DAPM kcontrol creation macros to use the ASoC macros where a
helpful version exists. One minor fixup is required in adau17x1, the
compiler doesn't like the extra level of macro indirection coupled with
the inline struct definition. Make the struct definition explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

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


