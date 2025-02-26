Return-Path: <linux-kernel+bounces-534285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C4A4650D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0177F189CC73
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875732288D0;
	Wed, 26 Feb 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WH3Bf5Hp"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32D227E91;
	Wed, 26 Feb 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583931; cv=none; b=LD3xM0+4fKM6RpROerMozIm5jjrSWuDtpa86b7JBZqww9Zn7Hnxtfi6slP8hniagwoBb8RWuLwgHVIRDU5RHFGPmZWQ3FnLAYhZAFi38co9xCfw/FA83EPGFHx886FqEm+xSMzq8UitVZmkmJjZc0VmSjJFFyilE52u1uu0fuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583931; c=relaxed/simple;
	bh=QROLHpitftxJz93rFpf0GRpdzzkQV1U5H9dZKqjurFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOAeeMi0V/kAakZ5LHQyZCIYgtqKpEOHcsMyPrspmi2MjiGjlycvgQoxmu0EDGWXg/sjTxX+nNN9AiBSgVIWLkOrIIgVQpwK+hFY9jmAPJPIkcFGoRSlgo/4EOeKpHxPALK5k+fNTEMqJJVeyOAzi7TvDqBjCFIePev7EhgsWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WH3Bf5Hp; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFJEx3014247;
	Wed, 26 Feb 2025 09:31:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zPlfN0cFXudE0W4CMRPSUAzF0Qn+ZW4zAlumi1M16C8=; b=
	WH3Bf5HpThkQ/3i6sxpQ+TxFDzqbBs0FA0DYBoN2vYUQBm0EgjL3PVDY6Q8pFwwF
	22j4NtM5xnhEL2cu2YKUMCRW7FDn/2iEXGf4UQO3f/jH/4CDnKz3xptrnmzFiPN9
	bWwJEofCyCpZWiKcBC971DXHQsUgJpVZkizhziDPZV1w23qBmXmGLgITqyH4nTte
	2tfv+iov2JrsaGsQ/C14AV1Yy4n6SCFikPvNl1aHLjN9fuvTCPN5tXaUogN6U2g8
	pLPxynfKqcN33NmWyN/pAGMdT+mBut+zk0Iw0KhN1pWqjOcaWOcJFUQdzVJNZ3W0
	SWBoUT2dL64L9dAS3wHRTw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 451pt3hq9w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:41 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D798482026B;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 07/12] ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Wed, 26 Feb 2025 15:31:32 +0000
Message-ID: <20250226153137.2791938-8-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=XrQAOUF9 c=1 sm=1 tr=0 ts=67bf33dd cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=V7zCF8UxTbGbpslwMU0A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-ORIG-GUID: 95OgwlwIRn40zE5wb9Gy8iYx0pMaKJmF
X-Proofpoint-GUID: 95OgwlwIRn40zE5wb9Gy8iYx0pMaKJmF
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


