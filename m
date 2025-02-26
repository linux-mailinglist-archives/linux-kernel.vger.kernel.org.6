Return-Path: <linux-kernel+bounces-534284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDBEA46509
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF6218936F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A822759D;
	Wed, 26 Feb 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a3+2nMdH"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792B225414;
	Wed, 26 Feb 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583928; cv=none; b=IgLzNkXH4oQcGlUnd114RUnU0K4l+DOqalu3YcAFnI/NTIy88FVt/pgOayOUNXv3sB90dEOayFgjybnsD8arbk3Tq20txX8OqGE+six/4r0VKafZN0JwcXr1FFsAStGU50875GP0EYv4wnCfgyQ3smI1eyradHu0S/cZ5Jrr4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583928; c=relaxed/simple;
	bh=ECnI0Elgr3uTzao2ZSaszWGwHqNXdqxD4HXGeDS0ZFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2PXXLkSqiN7z4S5FIEtnse67/olCbkN//LCW9KHiFFu+MaCW05smDVYfmHL4EHduvhWyC1J8vmpJJX8lTYhnwni/n0n/UFpH2QTbSZ0Y+s4FIMHTZwnB3czXxgShoAQLYxEM8faILNg5LD0rC1YVzThJk0PbVoqZ0eOiXXc1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=a3+2nMdH; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLp001993;
	Wed, 26 Feb 2025 09:31:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7p3/g+aMNKbNpD+0Mqn9doJDMO7nQEV1pvma9hDBEXo=; b=
	a3+2nMdH+jYECXIMnxRB1mbqYwtMHc6URzCgt62PLnAWE+1AEYoE5YoQiIshskD9
	Arw4F+y52XMoFJ0U60DhN/tZD9NCHYH54Ww7PDukYKgthkJHPq79iVA0yCmb4SSH
	IKbP0MjS0DUanZSkvlFoXBjROClHMEhucQJxwjbEnrk/i9A/yGlWqGboQYDC2MP1
	cvN+BhcxsbyJuz5bPNFv6xRhujRt1CfLKb66AIhIfdrP+6dLLyP0TIa//0CS68m2
	y+pHa2ZxH54Ykn6nD5mRp4I0kLvxelTZY6OOBurTCaUC3rRdpK/P67V2/Hq/gM/F
	bidK8na5/aKbRNxtrDwWGA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:44 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:38 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1A29782255D;
	Wed, 26 Feb 2025 15:31:38 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 11/12] ASoC: Tidy up SOC_DOUBLE_R_* helpers
Date: Wed, 26 Feb 2025 15:31:36 +0000
Message-ID: <20250226153137.2791938-12-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: jhsF0iGW1j89lGZ4V-R4tMB5ZCQVXK9L
X-Proofpoint-ORIG-GUID: jhsF0iGW1j89lGZ4V-R4tMB5ZCQVXK9L
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33e0 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=9cbaITONGonaCCdGE3wA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Re-implement SOC_DOUBLE_R_VALUE() in terms of SOC_DOUBLE_R_S_VALUE().
SOC_DOUBLE_R_S_VALUE() already had a minimum value so add this to
SOC_DOUBLE_R_VALUE() as well, which makes SOC_DOUBLE_R_RANGE_VALUE()
redundant, so its usage is replaced.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


