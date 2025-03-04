Return-Path: <linux-kernel+bounces-544335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1DA4E02A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7005616C77A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0A204C1C;
	Tue,  4 Mar 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Te/jy+Ne"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A1204C1E;
	Tue,  4 Mar 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097148; cv=none; b=iN6X8IdAAB8nCWXIbThEplDw32oCkp3sIFGuLHoBhvyIuvfzWVWdXIOR4db0pzTCFr6wngvjyuYOnMC1KvReUyWfK52eShfqZpMJh5iMikrP5wDRVjCI4gUWHknmt+yo9Plqg4w2Lx57UAHGoT8yVyNV5Z2CKNtthjaZbtQ2Fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097148; c=relaxed/simple;
	bh=XXigbBoKFF8OkZzhPzwjoD3VSbtlFilc8SFe3BJzct8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc2bXhaFSMgCjwo8ad2iwqfYlxYmT7zu+S4LfOEUvM/zponAYhWzofl6C71yJWNaXlTjy3naRI8DYZ92WpbsuXjOIx2w4GLYTvOMQDKl+9bHUeT9VFTWyZRJVOfq78WGV3vPZooDeEQCZbn3vbnXMkgaxLzUlJHf3JmOPAtQ6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Te/jy+Ne; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HMw003809;
	Tue, 4 Mar 2025 08:05:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ufumqolr95pkYg2iAfSwy6Cb0l6vyPNgJ5V4SIpZRCM=; b=
	Te/jy+NeKwtRv3kTHXCfiIfKJQ3FMIMpPoyLlUb0rucNsRvqQR7JEwwz/Y1+61TV
	hMGqQRMC2TwgyUJqyY7lASDK4ciZPTMIDaoou32pkpF79/ykecFm33/XYW8Y3EDx
	Rfy2HO1cqj3zqZFj11PiEkufqpQisDku9antB3IIeUXU/ILbaTrgP6iGbmQ31yuw
	jvgK+62eoV6GY8ijU1Ker3pdUaCrstiQsSApBF1yDCJEBnYIz6c6/WBvoQ3IUVzL
	Li2NVQ8sflGb/C3zN+XLFk4tERJKxkQEfv+ls1xR+jVsSqujfKF1JdIN7ivIiY6l
	4Q1ptqgPv+jLJJjRo6vfSQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0tr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:28 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 445FF82255D;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 04/13] ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
Date: Tue, 4 Mar 2025 14:04:51 +0000
Message-ID: <20250304140500.976127-5-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: 215iVgDR0Y5hpNsNf4uswulPEzBQo0sz
X-Proofpoint-ORIG-GUID: 215iVgDR0Y5hpNsNf4uswulPEzBQo0sz
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708a8 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=K-sIY6LzpdCAYFUMqkcA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 sound/soc/codecs/tas2562.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index fef7ce39f6643..8e00dcc09d0c2 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -513,17 +513,9 @@ static const struct snd_kcontrol_new vsense_switch =
 static const struct snd_kcontrol_new tas2562_snd_controls[] = {
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
 		       tas2562_dac_tlv),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Digital Volume Control",
-		.index = 0,
-		.tlv.p = dvc_tlv,
-		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info = snd_soc_info_volsw,
-		.get = tas2562_volume_control_get,
-		.put = tas2562_volume_control_put,
-		.private_value = SOC_SINGLE_VALUE(TAS2562_DVC_CFG1, 0, 110, 0, 0),
-	},
+	SOC_SINGLE_EXT_TLV("Digital Volume Control", TAS2562_DVC_CFG1, 0, 110, 0,
+			   tas2562_volume_control_get, tas2562_volume_control_put,
+			   dvc_tlv),
 };
 
 static const struct snd_soc_dapm_widget tas2110_dapm_widgets[] = {
-- 
2.39.5


