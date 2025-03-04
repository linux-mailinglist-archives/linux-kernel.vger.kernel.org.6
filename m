Return-Path: <linux-kernel+bounces-544340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E33A4E037
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5671799F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B02063D4;
	Tue,  4 Mar 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HJI0LGTq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE104205E31;
	Tue,  4 Mar 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097163; cv=none; b=EfECyqd0XeZpgwMHFw/EPn2nsN5TecgC9BL7dLLmPiw7sgCCvOaoTn528NXCI7z2LiZK8hkk+2S0B+Txl+JeEL5L3inVGR1fYpSuKZSDmkDJI6YEglpWyTYtZPBA5Kxzv9Xdg9qWcuqN+lt9Pk8iw2DPegYr7JMEidlhGDwh2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097163; c=relaxed/simple;
	bh=PtfajY+mzdSA0U9+nOCOBTlAHodGiTERsIjipJD/XxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4fsxpt7fay0b3OEHyjU1cuCK4Xr8ySsVp+JZ6ldiSPJ9LoHK15zUXV1h1MjXfnj9cqEslxLcrK9iQX+/LDSctyKEZovSFRNfOkY1saKQu6DkkBYFS2FX/j3Jj4bqQ0mM4jNdRGh61R9i35dd9Avrz+wTeh6ReUwy8iHdJpy9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HJI0LGTq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN6003809;
	Tue, 4 Mar 2025 08:05:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=l1Rx+YT+ro7qw4m8GzJuQ67MAW5m0p+bxjLI9qoAAY8=; b=
	HJI0LGTqCbkb/2CzBXniseFkw+A+lHkw/3ky5ZWsTvzp1C4j3dDPs2bz/b/pjgBO
	Vejt6h2jD5mQ6xcPe7P17GBZRRY0VYDEcF/ywHcBTblY+YEEAwwH5bpISJ0V7Ad9
	9rkA4gJH+CXThRq9COdybYe2S5Cc1J7kXnl61i0Jv1HD2cxQwGyhz8Scc/rbDhki
	6gF/Uvia6+f9GpH2YEqjmtWPf1GSrUzVq8q4rxoG53Aqy8UridiP35t3eNEgbisW
	ibuRCWnooBI1Rr/5iHwO+lzZzi+ZE3xfEtMIhxD7vV/JXsmU9T081rjnXSlux8B+
	hO5y6npkq3utYXgjZr1VAA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0tr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:39 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7E04D82026B;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 08/13] ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Tue, 4 Mar 2025 14:04:55 +0000
Message-ID: <20250304140500.976127-9-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: DH5pMMF6v7S455tBoNO83jtg2OwrOSK_
X-Proofpoint-ORIG-GUID: DH5pMMF6v7S455tBoNO83jtg2OwrOSK_
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708b3 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=V7zCF8UxTbGbpslwMU0A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

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


