Return-Path: <linux-kernel+bounces-534278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09634A46516
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6049A3B3464
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE40224AE3;
	Wed, 26 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XG+/NUhs"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4F223324;
	Wed, 26 Feb 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583923; cv=none; b=CVEIF3BiR5PejpCUCA5+dROZM3q0qWPdeQcRPChsp1csALAdNIF7SSPEthURQsOAOm3fij4S93VAqIkyADTFuqndOckfHPDoCczMrLHcqqRJKQJtJ2SD9b0Sn1Ne864hAOxD9iuqyzRKWftBBocdJ/bWy6S9ZkONGkJ3sS5WmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583923; c=relaxed/simple;
	bh=xSTOWQz7w7PTjO8l0/0h8UX6goqy09fm7ackPwmZWMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omttBgUL/Pz5J4B8acJML74UU54RGZfc85D8pg3NEu0YLcHTxJim2P3vIeZqtAO69oFmcOq20M6Qu84oDcfWUkiKNMekSja0q/JhpDgCqo0lRoXaGqhIqZjeQP1yO2w+2nnvOZQ6oVB6Rwy40L07mzaOQvlfSMNJBnw01L4XeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XG+/NUhs; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLm001993;
	Wed, 26 Feb 2025 09:31:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=OMNTumwjkDvIVUDIPTygYbbQiYLiFDUJ7kkZjWOANU8=; b=
	XG+/NUhsWzFFUmHtimfkq7MyK/3Man0s36qtngd4SGfR5d0nbPX9ZZ0jfmhQmjO7
	KtcTueOTr2F3/SM7IcmSgaWp53ayuxj4mJ9adDL2sBzAdHfaA4gOXd072aJ++XtE
	XM3bI9qEO2ld8kg52TwbqBh0EhmHY6VEwi471k8/QNJiBSG7eYF1JbIIiT2SPW4N
	gPlXaYyAmLLM84hKlt1wtGP7TE02ztGjLW1+yLpQ+N1Y3IfxhAYtjxladvBsAONO
	ntaywogMLJ6TVyPaH7ZXfa0mpwACIeHOe4HrgNRgKwqlqfFs3QTKapJyeGLea2sa
	2G0bSvkNkPnTVvzDhq38fA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:42 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:38 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E8C86820270;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 08/12] ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
Date: Wed, 26 Feb 2025 15:31:33 +0000
Message-ID: <20250226153137.2791938-9-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: fIa8xEdolOIrVQYoZG5V82k-d9KkUIqv
X-Proofpoint-ORIG-GUID: fIa8xEdolOIrVQYoZG5V82k-d9KkUIqv
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33de cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=0mOSjS8g2lfFcO4yiOgA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The TSE850_DAPM_SINGLE_EXT() macro is an identical duplicate of the
core SOC_SINGLE_EXT() marco. Use the macro provided by the core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/atmel/tse850-pcm5142.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 0a9efd5f28615..2a1d0408a4cf1 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -227,16 +227,9 @@ static const struct snd_kcontrol_new mux1 =
 static const struct snd_kcontrol_new mux2 =
 	SOC_DAPM_ENUM_EXT("MUX2", mux_enum, tse850_get_mux2, tse850_put_mux2);
 
-#define TSE850_DAPM_SINGLE_EXT(xname, reg, shift, max, invert, xget, xput) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = xget, \
-	.put = xput, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
-
 static const struct snd_kcontrol_new mix[] = {
-	TSE850_DAPM_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
-			       tse850_get_mix, tse850_put_mix),
+	SOC_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
+		       tse850_get_mix, tse850_put_mix),
 };
 
 static const char * const ana_text[] = {
-- 
2.39.5


