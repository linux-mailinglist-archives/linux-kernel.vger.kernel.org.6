Return-Path: <linux-kernel+bounces-542439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7FA4CA4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28673BD5A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB125E81E;
	Mon,  3 Mar 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gwvodxqU"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552D253355;
	Mon,  3 Mar 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022094; cv=none; b=A9LsjW15gsHHaMoTQXVxRyf4i76WFFovviRTzjRDyKtWwOZ/kaia1ZnLHk6Pj4BN+1eGJvWfJ90xpUAewvVEqiLHj2sj4mo3IAFy2lzywd1c/j7UyoSUYxC09rA7NzWAikjbR8+Nr1/CtTkwdQeuUdTfyqTc2kywVcPyP88knOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022094; c=relaxed/simple;
	bh=0a6GsTu1v6G9IFu27pIz+BEGmc3bjQkUNcbXMT5Kr2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN+Ks1eK2ZRYXJ6DHKmR1NYzXRqP8ITFJh0iH04I1vmqQ9494zk/qJugT22NokAP0tyZ/wrjsFCESDnH4oOl2HDRc+9aihM32Z4es0zUZbyNpHIUSYORASJL4rqMnsXQAl0qiuND8usrrljvHPmRo2k1xzadYVrC9QLKY8iaogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gwvodxqU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Xd006077;
	Mon, 3 Mar 2025 11:14:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UhkrunqH3dKw/D1ED3Nwf2ppvHAxhhwCBAUeApJFGC0=; b=
	gwvodxqUZH2L+mNbmUo8UQ/6USCfRI1x9w3hGIyvoJTdZS+q7oX7vuBL5IgdW/TS
	Ook9tYMsgnDx7CH0g5U0WCIYIsLG5wtM140NkmznCVtvw6tsNtHaHmgfQDQkdCGY
	u8M1otwtCUJVzMT/ZZGAZorOLktZlgbq4eMn2DzxlsmfPETlkDQAfl9gjTQ3UWDL
	82rleCbdWXsuGJgMuexTLwjkV8fsA8VGOvIr6w0diLrFoR+a/7XoeRSrOV1MzrDO
	LJjC4QPvvNpjFTRLMrRVVI+rebjri3xVyPY/L0vm///8ujCyyoWQYjbhksF8zUBN
	2LYzHXtcFuZpOKnjdSWkyQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-7
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
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B460D82255C;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 08/13] ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Mon, 3 Mar 2025 17:14:19 +0000
Message-ID: <20250303171424.444556-9-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: YeU0KgxVBju9Aomq6o8PKKQFkWd12p-H
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e37c cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=V7zCF8UxTbGbpslwMU0A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: YeU0KgxVBju9Aomq6o8PKKQFkWd12p-H
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 sound/soc/codecs/wsa881x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index dd2d6661adc71..a3999bb6d5e22 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -199,13 +199,8 @@
 #define WSA881X_PROBE_TIMEOUT 1000
 
 #define WSA881X_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
-	.put = wsa881x_put_pa_gain, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	SOC_SINGLE_EXT_TLV(xname, reg, shift, max, invert, \
+			   snd_soc_get_volsw, wsa881x_put_pa_gain, tlv_array)
 
 static struct reg_default wsa881x_defaults[] = {
 	{ WSA881X_CHIP_ID0, 0x00 },
-- 
2.39.5


