Return-Path: <linux-kernel+bounces-544341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F4A4E038
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF51798EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191422066C3;
	Tue,  4 Mar 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qJH1/0RE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FA2063DE;
	Tue,  4 Mar 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097165; cv=none; b=KXJB7m5HCX/MqsMFZQDCYM7NKEC9etiKerxrfDUKYB81j+4JHUNkXW9oe6mkdnK2g0xlOablS5orXbNc9B37Rb3Oed+V0P6QH2XlB8CC7QDwno77pCWNOOLZb5Aj4z0Hw0QJ1tpywRj8UUhHU88FUz74Vu+a8cICEIOVnWhgQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097165; c=relaxed/simple;
	bh=v5ESO54M7Fu8kyr3zeCN+QE+8AJZh+UCyhRCP26TylM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca4KWUfJhDNvvfmtc9tvI6bOZG4wxPhL0LF5sNOlMzQIlLR0HWTsoFDIdxHklZkQEvDeXiUlUUsTf2hANwXIp3bvKmdseRLCf8Vnb8lZ277lb3PS3UjM2zZ/HK2hfpprrDZtxBqdfH4BgEDR/IPwAx6JDI7rdqsfSanVTOC/RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qJH1/0RE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN8003809;
	Tue, 4 Mar 2025 08:05:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xT8FCC1C9ajhlbKzxy445d1lS+nEcKSmBHp6lxJ3hCM=; b=
	qJH1/0REeU2+nngUbL5rGH+uhGlpHdsGeVeGLMKaXufxTaj+NUoAWE9GsSxvd0zf
	o9s56DVhxAw0mhbnzJmRXdd/sq/rh/7RhIbeEM9AGPSlcOnXeM1MsSrWb2Leisv/
	PRNGp6t3C6GKvt82skuBc1KUitAYhftLbl5IM6C8kNJoGiZim3lYXGYO1fy7PpB7
	JXcM0jFghb2iRuySX3VNJ5MOnfT/3zadoUPjmpbbmMHOCG0UMDJUbQ3pl0O5qw6U
	22D3rRA6fbYVCi5+iT2fhAAEP1QdtJR3t06dAwIeMitCJyiFWO3vZ+kT9Y6tKo1O
	KA4KV0Pwda/GYryOUYvdDA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0tr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:46 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id ADF6682255D;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 12/13] ASoC: Tidy up SOC_DOUBLE_R_* helpers
Date: Tue, 4 Mar 2025 14:04:59 +0000
Message-ID: <20250304140500.976127-13-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: r8syUX3DWVtewkr-hvZX_XFjgiPeVXZp
X-Proofpoint-ORIG-GUID: r8syUX3DWVtewkr-hvZX_XFjgiPeVXZp
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708ba cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=9cbaITONGonaCCdGE3wA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Re-implement SOC_DOUBLE_R_VALUE() in terms of SOC_DOUBLE_R_S_VALUE().
SOC_DOUBLE_R_S_VALUE() already had a minimum value so add this to
SOC_DOUBLE_R_VALUE() as well, which makes SOC_DOUBLE_R_RANGE_VALUE()
redundant, so its usage is replaced.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 include/sound/soc.h | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 01151a6ada350..390e08ba4dd45 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -51,19 +51,14 @@ struct platform_device;
 	.sign_bit = xsign_bit, .invert = xinvert, .autodisable = xautodisable})
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
 	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
-#define SOC_DOUBLE_R_VALUE(xlreg, xrreg, xshift, xmax, xinvert) \
-	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-	.max = xmax, .invert = xinvert})
 #define SOC_DOUBLE_R_S_VALUE(xlreg, xrreg, xshift, xmin, xmax, xsign_bit, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
 	.max = xmax, .min = xmin, .sign_bit = xsign_bit, \
 	.invert = xinvert})
-#define SOC_DOUBLE_R_RANGE_VALUE(xlreg, xrreg, xshift, xmin, xmax, xinvert) \
-	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-	.min = xmin, .max = xmax, .invert = xinvert})
+#define SOC_DOUBLE_R_VALUE(xlreg, xrreg, xshift, xmin, xmax, xinvert) \
+	SOC_DOUBLE_R_S_VALUE(xlreg, xrreg, xshift, xmin, xmax, 0, xinvert)
+
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -127,13 +122,13 @@ struct platform_device;
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
+					    0, xmax, xinvert) }
 #define SOC_DOUBLE_R_RANGE(xname, reg_left, reg_right, xshift, xmin, \
 			   xmax, xinvert)		\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw_range, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
-	.private_value = SOC_DOUBLE_R_RANGE_VALUE(reg_left, reg_right, \
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -176,7 +171,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
+					    0, xmax, xinvert) }
 #define SOC_DOUBLE_R_RANGE_TLV(xname, reg_left, reg_right, xshift, xmin, \
 			       xmax, xinvert, tlv_array)		\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -185,7 +180,7 @@ struct platform_device;
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_range, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
-	.private_value = SOC_DOUBLE_R_RANGE_VALUE(reg_left, reg_right, \
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_R_SX_TLV(xname, xreg, xrreg, xshift, xmin, xmax, tlv_array) \
 {       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -195,10 +190,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw_sx, \
 	.get = snd_soc_get_volsw_sx, \
 	.put = snd_soc_put_volsw_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xrreg, \
-		.shift = xshift, .rshift = xshift, \
-		.max = xmax, .min = xmin} }
+	.private_value = SOC_DOUBLE_R_VALUE(xreg, xrreg, xshift, xmin, xmax, 0) }
 #define SOC_DOUBLE_R_S_TLV(xname, reg_left, reg_right, xshift, xmin, xmax, xsign_bit, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -272,7 +264,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
+					    0, xmax, xinvert) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -313,7 +305,7 @@ struct platform_device;
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
+					    0, xmax, xinvert) }
 #define SOC_DOUBLE_R_S_EXT_TLV(xname, reg_left, reg_right, xshift, xmin, xmax, \
 			       xsign_bit, xinvert, xhandler_get, xhandler_put, \
 			       tlv_array) \
-- 
2.39.5


