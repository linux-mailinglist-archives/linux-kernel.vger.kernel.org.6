Return-Path: <linux-kernel+bounces-534276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7AA46515
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FA3B8AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54C22371A;
	Wed, 26 Feb 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iYjXFq74"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9322331C;
	Wed, 26 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583922; cv=none; b=tqCG0AAJQk4bHsxLjJCfXmS0MdVRvHP9Bjl/sxhghae4iJWDC34lBXro310iI8lTkyrPMY3fdCnwmopIAQIOyY1HUHcsYuTLR7YRjjMAPohGJuJA4t33RdABL5r1Ieu/qUedI3Lrz2b/mlWpS8gbNWyxkaZzkdvFFyvft+Bi4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583922; c=relaxed/simple;
	bh=LQabUaWXlF0Ro9JGvhCKIJKzXZqlmvkxc71kE8CjMw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/UCQniP+tMcXK5rz0Z9gfXoQiLPCkRgaofuD6gLQbQSf+Y+7h/ooGFSwU3c1GxJ//q5FwrTpUcLOU6HH0dgQrea3nMJDBt6H2MLlNtAP6gSAuuOah6eePm2xhzVpxgaHNAOVJdiJ8aDrB80FLz6MqZ76cEpGTEO+u/Kn2/PWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iYjXFq74; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLo001993;
	Wed, 26 Feb 2025 09:31:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RIiIwQSWePvLW5IcEl9bRP2ThrXxLwQJS9CEscKWDlY=; b=
	iYjXFq74aoLr6dd86PjdWunmVsDbV4gz9HTHBZHD8abu08ujyPV+ze9JCKJRvt3l
	WzYSI8cCeo89ej/wQamRazsoIxVrIjK1Q8qPdJPsxmmKxFcJLW0ZyPRT+aAKs3ir
	j1qYEBbETilmB9j9aAH6PvSOgO2kv5ekf25gl7AfOHaXWeQtOQY3yObzqeyPeFIF
	fAa8Twpz+iqWdgXX2oWhGGrdHpffEkOobtKDY9M5SICg34sgfsAUKdy01vc5X/uL
	Ny6bL9HTo5N9nNIsn6I36acnMDXtg81f2/v65csGxfbq6c1Pc9+BRkI2a/dzYPT8
	veAQzK97TVRdqMbhb1opsQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:43 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:38 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 03D9082255C;
	Wed, 26 Feb 2025 15:31:38 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 09/12] ASoC: dapm: Add missing SOC_DAPM_DOUBLE_R_TLV() helper
Date: Wed, 26 Feb 2025 15:31:34 +0000
Message-ID: <20250226153137.2791938-10-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: l81QmHjwEthqOvPBo1QZXBsIqbBi1Hep
X-Proofpoint-ORIG-GUID: l81QmHjwEthqOvPBo1QZXBsIqbBi1Hep
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33df cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=eHhbDft_Fg0bQzyGKX0A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

A few drivers are open coding SOC_DAPM_DOUBLE_R_TLV() add a core
helper and use that instead.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc-dapm.h  |  7 +++++++
 sound/soc/codecs/jz4760.c | 32 ++++---------------------------
 sound/soc/codecs/jz4770.c | 40 ++++++---------------------------------
 3 files changed, 17 insertions(+), 62 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7cf52c8c9cf32..bed1c37529aca 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -347,6 +347,13 @@ struct soc_enum;
 	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
 #define SOC_DAPM_SINGLE_VIRT(xname, max) \
 	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0)
+#define SOC_DAPM_DOUBLE_R_TLV(xname, lreg, rreg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_DOUBLE_R_VALUE(lreg, rreg, shift, max, invert) }
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
index 6217e611259fe..e04af1b9ace86 100644
--- a/sound/soc/codecs/jz4760.c
+++ b/sound/soc/codecs/jz4760.c
@@ -314,37 +314,13 @@ static const struct snd_kcontrol_new jz4760_codec_snd_controls[] = {
 };
 
 static const struct snd_kcontrol_new jz4760_codec_pcm_playback_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Volume",
-		.info = snd_soc_info_volsw,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ
-			| SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.tlv.p = dac_tlv,
-		.get = snd_soc_dapm_get_volsw,
-		.put = snd_soc_dapm_put_volsw,
-		.private_value = SOC_DOUBLE_R_VALUE(JZ4760_CODEC_REG_GCR6,
-						    JZ4760_CODEC_REG_GCR5,
-						    REG_GCR_GAIN_OFFSET,
-						    REG_GCR_GAIN_MAX, 1),
-	},
+	SOC_DAPM_DOUBLE_R_TLV("Volume", JZ4760_CODEC_REG_GCR6, JZ4760_CODEC_REG_GCR5,
+			      REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, dac_tlv),
 };
 
 static const struct snd_kcontrol_new jz4760_codec_hp_playback_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Volume",
-		.info = snd_soc_info_volsw,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ
-			| SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.tlv.p = out_tlv,
-		.get = snd_soc_dapm_get_volsw,
-		.put = snd_soc_dapm_put_volsw,
-		.private_value = SOC_DOUBLE_R_VALUE(JZ4760_CODEC_REG_GCR2,
-						    JZ4760_CODEC_REG_GCR1,
-						    REG_GCR_GAIN_OFFSET,
-						    REG_GCR_GAIN_MAX, 1),
-	},
+	SOC_DAPM_DOUBLE_R_TLV("Volume", JZ4760_CODEC_REG_GCR2, JZ4760_CODEC_REG_GCR1,
+			      REG_GCR_GAIN_OFFSET, REG_GCR_GAIN_MAX, 1, out_tlv),
 };
 
 static int hpout_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index acb9eaa7ea1c5..312202ab5ceae 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -331,43 +331,15 @@ static const struct snd_kcontrol_new jz4770_codec_snd_controls[] = {
 };
 
 static const struct snd_kcontrol_new jz4770_codec_pcm_playback_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Volume",
-		.info = snd_soc_info_volsw,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ
-			| SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.tlv.p = dac_tlv,
-		.get = snd_soc_dapm_get_volsw,
-		.put = snd_soc_dapm_put_volsw,
-		/*
-		 * NOTE: DACR/DACL are inversed; the gain value written to DACR
-		 * seems to affect the left channel, and the gain value written
-		 * to DACL seems to affect the right channel.
-		 */
-		.private_value = SOC_DOUBLE_R_VALUE(JZ4770_CODEC_REG_GCR_DACR,
-						    JZ4770_CODEC_REG_GCR_DACL,
-						    REG_GCR_GAIN_OFFSET,
-						    REG_GCR_GAIN_MAX, 1),
-	},
+	SOC_DAPM_DOUBLE_R_TLV("Volume", JZ4770_CODEC_REG_GCR_DACR,
+			      JZ4770_CODEC_REG_GCR_DACL, REG_GCR_GAIN_OFFSET,
+			      REG_GCR_GAIN_MAX, 1, dac_tlv),
 };
 
 static const struct snd_kcontrol_new jz4770_codec_hp_playback_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Volume",
-		.info = snd_soc_info_volsw,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ
-			| SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.tlv.p = out_tlv,
-		.get = snd_soc_dapm_get_volsw,
-		.put = snd_soc_dapm_put_volsw,
-		/* HPR/HPL inversed for the same reason as above */
-		.private_value = SOC_DOUBLE_R_VALUE(JZ4770_CODEC_REG_GCR_HPR,
-						    JZ4770_CODEC_REG_GCR_HPL,
-						    REG_GCR_GAIN_OFFSET,
-						    REG_GCR_GAIN_MAX, 1),
-	},
+	SOC_DAPM_DOUBLE_R_TLV("Volume", JZ4770_CODEC_REG_GCR_HPR,
+			      JZ4770_CODEC_REG_GCR_HPL, REG_GCR_GAIN_OFFSET,
+			      REG_GCR_GAIN_MAX, 1, out_tlv),
 };
 
 static int hpout_event(struct snd_soc_dapm_widget *w,
-- 
2.39.5


