Return-Path: <linux-kernel+bounces-544346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C1A4E043
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B47189E223
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03441206F0E;
	Tue,  4 Mar 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CtpySU0f"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D3206F03;
	Tue,  4 Mar 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097176; cv=none; b=Uw14t6e+GfD5z6M9KZhwLbN+33u88SCbKy2FV1hUwFXtbY3f5bvZf8No2GxcNgjFlON8UbkZgWiVm0DD65k/ILxjL0aBLFr0NRxYjw3z2MsXQncP8FawVXbE3br8MImda3q9Bfy240goOzry+/xkzr5kBmg8l9PZ1afy6ZmOw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097176; c=relaxed/simple;
	bh=CKYbUsfcAQMtuDEmTdnliBnewal4V/5Mr0Qwcn3DWiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kanPXQ/tduxtm/amtedUwMNocx5NonZOdWoQn9MsgWKbJeMWduVmk6poXCq2e1132RT/0jDz6qutzEKSyTZLftT3mu4tTs58O4McXbhZVC0Z6ayOSqckG2PAONhwbOlDgN84ynhlrEf48uNNxNBLc2LMaU+Jr30YimjWUfMEQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CtpySU0f; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HND003809;
	Tue, 4 Mar 2025 08:05:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=EDVrdHz6/R9B0f6ggPbk/Xy3dcSrJ1uOGM/nZkXB8o0=; b=
	CtpySU0f8cOl9IK0v86NuFQkguhKCXbHMCNoWxiiYaXHvrxmWtlro8/pfSV9mlcn
	5lv+cgMPt4mN9XyG0LFvyPgJU2pnnvKaXG25Ra/WyGeW66bAoz+5AE+y2fVAh1+N
	Weng49jxRMo2SMwKMY080vAP+UdAiuETQbzFxDp//Vfu2hkFQFcXyf5Z/afbc9hm
	5noeNo4kOby5GweqQ9+HAbPiuJ86PrATPaGEf1GodupqVauxv31flq7ppNXJuxAz
	JiLhYqy4M/Oc114tJisvc3HyEMZk2Xt1aZeXg5q0wq5q0r6hT4bnCmS/PMBvXXSo
	4YYiSzulZqrhlvXpskeg4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:56 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B38AA82026B;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 13/13] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers
Date: Tue, 4 Mar 2025 14:05:00 +0000
Message-ID: <20250304140500.976127-14-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: PEuUkTIn4uwocwjQPnipMLWplu0HAxz5
X-Proofpoint-ORIG-GUID: PEuUkTIn4uwocwjQPnipMLWplu0HAxz5
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708c5 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=LuYPZTa0VuMH1JCmcYwA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Re-implement SOC_DOUBLE_VALUE() in terms of SOC_DOUBLE_S_VALUE().
SOC_DOUBLE_S_VALUE() already had a minimum value so add this to
SOC_DOUBLE_VALUE as well, this allows replacement of several hard coded
value entries. Likewise update SOC_SINGLE_VALUE to match, which allows
replacement of even more hard coded values.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Fix typo in SOC_DOUBLE_RANGE_TLV refactor

Thanks,
Charles

 include/sound/soc-dapm.h |  4 +--
 include/sound/soc.h      | 65 +++++++++++++++-------------------------
 2 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4b8ef5b8a391e..af802ef536e73 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -356,14 +356,14 @@ struct soc_enum;
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 1) }
 #define SOC_DAPM_SINGLE_TLV_AUTODISABLE(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 1) }
 #define SOC_DAPM_PIN_SWITCH(xname) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
 	.info = snd_soc_dapm_info_pin_switch, \
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 390e08ba4dd45..de1abad06a9b0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -39,18 +39,17 @@ struct platform_device;
 /*
  * Convenience kcontrol builders
  */
-#define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert, xautodisable) \
-	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
-	.rshift = shift_right, .max = xmax, \
-	.invert = xinvert, .autodisable = xautodisable})
-#define SOC_DOUBLE_S_VALUE(xreg, shift_left, shift_right, xmin, xmax, xsign_bit, xinvert, xautodisable) \
+#define SOC_DOUBLE_S_VALUE(xreg, shift_left, shift_right, xmin, xmax, xsign_bit, \
+			   xinvert, xautodisable) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
 	.rshift = shift_right, .min = xmin, .max = xmax, \
 	.sign_bit = xsign_bit, .invert = xinvert, .autodisable = xautodisable})
-#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
-	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
+#define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmin, xmax, xinvert, xautodisable) \
+	SOC_DOUBLE_S_VALUE(xreg, shift_left, shift_right, xmin, xmax, 0, xinvert, \
+			   xautodisable)
+#define SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, xautodisable) \
+	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmin, xmax, xinvert, xautodisable)
 #define SOC_DOUBLE_R_S_VALUE(xlreg, xrreg, xshift, xmin, xmax, xsign_bit, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
@@ -63,15 +62,12 @@ struct platform_device;
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 0) }
 #define SOC_SINGLE_RANGE(xname, xreg, xshift, xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw_range, .get = snd_soc_get_volsw_range, \
 	.put = snd_soc_put_volsw_range, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, .shift = xshift, \
-		 .rshift = xshift,  .min = xmin, .max = xmax, \
-		 .invert = xinvert} }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -79,7 +75,7 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 0) }
 #define SOC_SINGLE_SX_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
 {       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -88,10 +84,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw_sx, \
 	.get = snd_soc_get_volsw_sx,\
 	.put = snd_soc_put_volsw_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, \
-		.shift = xshift, .rshift = xshift, \
-		.max = xmax, .min = xmin} }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, 0, 0) }
 #define SOC_SINGLE_RANGE_TLV(xname, xreg, xshift, xmin, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -99,16 +92,13 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_range, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, .shift = xshift, \
-		 .rshift = xshift, .min = xmin, .max = xmax, \
-		 .invert = xinvert} }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
-					  max, invert, 0) }
+					  0, max, invert, 0) }
 #define SOC_DOUBLE_STS(xname, reg, shift_left, shift_right, max, invert) \
 {									\
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),		\
@@ -116,7 +106,7 @@ struct platform_device;
 	.access = SNDRV_CTL_ELEM_ACCESS_READ |				\
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE,				\
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right,	\
-					  max, invert, 0) }
+					  0, max, invert, 0) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
@@ -138,7 +128,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
-					  max, invert, 0) }
+					  0, max, invert, 0) }
 #define SOC_DOUBLE_SX_TLV(xname, xreg, shift_left, shift_right, xmin, xmax, tlv_array) \
 {       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -147,10 +137,8 @@ struct platform_device;
 	.info = snd_soc_info_volsw_sx, \
 	.get = snd_soc_get_volsw_sx, \
 	.put = snd_soc_put_volsw_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, \
-		.shift = shift_left, .rshift = shift_right, \
-		.max = xmax, .min = xmin} }
+	.private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
+					  xmin, xmax, 0, 0) }
 #define SOC_DOUBLE_RANGE_TLV(xname, xreg, xshift_left, xshift_right, xmin, xmax, \
 			     xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -159,10 +147,8 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, \
-		 .shift = xshift_left, .rshift = xshift_right, \
-		 .min = xmin, .max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_VALUE(xreg, xshift_left, xshift_right, \
+					  xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -250,14 +236,14 @@ struct platform_device;
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, 0) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, 0, xmax, xinvert, 0) }
 #define SOC_DOUBLE_EXT(xname, reg, shift_left, shift_right, max, invert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = \
-		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert, 0) }
+		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, 0, max, invert, 0) }
 #define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -273,7 +259,7 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, 0) }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, 0, xmax, xinvert, 0) }
 #define SOC_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
 				 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -282,10 +268,7 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_range, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, .shift = xshift, \
-		 .rshift = xshift, .min = xmin, .max = xmax, \
-		 .invert = xinvert} }
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -295,7 +278,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
-					  xmax, xinvert, 0) }
+					  0, xmax, xinvert, 0) }
 #define SOC_DOUBLE_R_EXT_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-- 
2.39.5


