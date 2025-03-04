Return-Path: <linux-kernel+bounces-544336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C483BA4E03F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1353A50C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76503205AC1;
	Tue,  4 Mar 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AsOYOI5M"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67530205ABA;
	Tue,  4 Mar 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097151; cv=none; b=tGiWOSZyUr8/7Z9N24Uhpe5RL7ogp2IKSWjdxsW8angA4mcw4v8853VIj7BJKzhK2cKckDaTX/G5bszyNwAnu5aVENrdCy3xxqKu5RZVGd+TxnhebeJIoJVO3x97D4FamIluRBxhH1JzEjiHLCjX4B/PFst05TApuktNuPTQOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097151; c=relaxed/simple;
	bh=ZsFvfi8Y9tumYUtDGNrHEv6mhcvKMkdaP+XBLK0Hs44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r56soENiVbuP2fpb4fAQcI/PpUMnfa8CVH+sN+mxOAeX26ectaNJRAGZzGox5VBbsC/t3x1BYww4dMPZhI5Ri+Lx6ETUiSuy2nLG1Zg/rmtHR8OUzWQfK1kT8MZI8zCOqvZFFGhpOLM14I5SX5p6TdUbuBVWsOe4D2VWsplD0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AsOYOI5M; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN0003809;
	Tue, 4 Mar 2025 08:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=86vpOTLKOTgcc2vYcHbgyQmxe74RZuBBLmjckz6FEwA=; b=
	AsOYOI5MsMH4KJiMBpVDQrpocOSDFE9JOhJLDYT8J9vaYnKKi5T4GOtuSMG+DtHN
	vQ9bIJByvoWwwyyfwh0Rr2Udco1l69v0ncJe5rRTAq43qo98ZUSpU2dWEI39F5HC
	4cg5HtWr8XHXXr00Kt8O2ii9w6S9YdI+ixhyg33PGEUGzvOLeldAuBNS2KYN6eFk
	IOqMVR3zuVzKQ9IQw4VNB0bNZNQI056Jv2MWiV5RPctArAf9oDNMkmLKNe2Tw5k/
	2w/S53T8Og1hyI3VhN5b2jcxGiCJ5YJh15smGrfA0UvTIEaBrRIxudrodiZlwfaM
	RF434T3A4xx81040YDPZlg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0tr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:33 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5204A82255E;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 05/13] ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Tue, 4 Mar 2025 14:04:52 +0000
Message-ID: <20250304140500.976127-6-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: KQQJQcxVj-pvC_oWzrbg_SBymblJKvjc
X-Proofpoint-ORIG-GUID: KQQJQcxVj-pvC_oWzrbg_SBymblJKvjc
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708ad cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=NENWR2pWs0l2DgI0U44A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 sound/soc/codecs/wcd938x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f2a4f3262bdbc..b536e8bdc5a74 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -70,13 +70,8 @@
 #define WCD_MBHC_HS_V_MAX           1600
 
 #define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
-	.put = wcd938x_ear_pa_put_gain, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	SOC_SINGLE_EXT_TLV(xname, reg, shift, max, invert, snd_soc_get_volsw, \
+			   wcd938x_ear_pa_put_gain, tlv_array)
 
 enum {
 	WCD9380 = 0,
-- 
2.39.5


