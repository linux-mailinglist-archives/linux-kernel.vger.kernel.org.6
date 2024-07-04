Return-Path: <linux-kernel+bounces-240715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AD927192
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7804E1C23CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A11A4F28;
	Thu,  4 Jul 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGdSMvTU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFD40BF2;
	Thu,  4 Jul 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081175; cv=none; b=RoTQhtAZ65bR/vvIR/dA3NMBjtVuE4qZKa02vV90OAPzAT8XnNKXjvXSHjUqDJteNupAaOJ7hPj3EVkENRUU3MDQP7RMV6geuijY58guKeAdLyWTV6EvfbVUnxlhIIiFDrm2rKGLCMiWLxjmXIll6aOAnlQPm8hvlQZAGDFcEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081175; c=relaxed/simple;
	bh=uXYIvJJjOHeyOGKww0AYWtM3SVrVRKDmiNBpovYRsqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MURbYohZheZzUB49FaZqlRn/FVNBvVXlIOXcGHqxh5cXUZflBy+nFN8ZP1mvwBSuaQHq8dhVuQIAr7+vULBoeUE0OTQKsyLtD4PGX/bNuJ+jW/QW+Pd0tsD32Uf0UrqINdT8noLPnfltPnjgx+DuOdWu9sTgMXw3Hppw4EmbJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGdSMvTU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463J4vNB003645;
	Thu, 4 Jul 2024 08:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bY6cwzD4iAZ6uGFeNzw7OsIgw4CYUJ5dshXMiNSRHMM=; b=eGdSMvTU2GNPw5jz
	Rk9QVhZmSW8wFFCepN38QKjzetaGZ5Rc7zDftrsBmytMOPkJVtG55FjlBfVSHnXI
	tn/FHwcGqGwIXwzvUt8lMolDUXXIbQjjYKa/E41wQA0JRTDe90DIQPY5amRaPCn9
	J6f20e8j7nMSjZwFep9Ik971xjc+O2mYngPHqOT1zQ7kuW2D/jq/pIcWQs5viO5/
	1TYmwmBRE0vjFwrRzgqf92ydg8Lp2LqHJYPbydfVRpRJUrd1in3pLqltaNkAljrB
	EyEkRYt2CSyh1Bj0wNi7HiE/u8afCG/V4Z7uJ67RpXTgRKasY4YXRmwgdE6nXBcm
	mpbtJA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 405cg297sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 08:19:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4648JC5S017941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 08:19:12 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 01:19:09 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>,
        Prasad Kumpatla
	<quic_pkumpatl@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/3] ASoC: codecs: wcd937x: Remove the string compare in MIC BIAS widget settings
Date: Thu, 4 Jul 2024 13:47:22 +0530
Message-ID: <20240704081723.3394153-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704081723.3394153-1-quic_mohs@quicinc.com>
References: <20240704081723.3394153-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aMlt3GTNd1ppehrB-mwWfz4WAOcc-K2_
X-Proofpoint-ORIG-GUID: aMlt3GTNd1ppehrB-mwWfz4WAOcc-K2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040057

Remove the string compare with widget name in MIC BIAS settings, instead
of string compare use the MIC BIAS id's.

Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Closes: https://lore.kernel.org/linux-sound/ba911ebd-aef5-46af-ace1-84d13bee6876@linaro.org/
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 4beb70bc4d8c..94282499fa33 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -1164,16 +1164,7 @@ static int __wcd937x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
 					  int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	int micb_num;
-
-	if (strnstr(w->name, "MIC BIAS1", sizeof("MIC BIAS1")))
-		micb_num = MIC_BIAS_1;
-	else if (strnstr(w->name, "MIC BIAS2", sizeof("MIC BIAS2")))
-		micb_num = MIC_BIAS_2;
-	else if (strnstr(w->name, "MIC BIAS3", sizeof("MIC BIAS3")))
-		micb_num = MIC_BIAS_3;
-	else
-		return -EINVAL;
+	int micb_num = w->shift;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1203,16 +1194,7 @@ static int __wcd937x_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
 						 int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	int micb_num;
-
-	if (strnstr(w->name, "VA MIC BIAS1", sizeof("VA MIC BIAS1")))
-		micb_num = MIC_BIAS_1;
-	else if (strnstr(w->name, "VA MIC BIAS2", sizeof("VA MIC BIAS2")))
-		micb_num = MIC_BIAS_2;
-	else if (strnstr(w->name, "VA MIC BIAS3", sizeof("VA MIC BIAS3")))
-		micb_num = MIC_BIAS_3;
-	else
-		return -EINVAL;
+	int micb_num = w->shift;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -2231,15 +2213,15 @@ static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
 			     SND_SOC_DAPM_POST_PMD),
 
 	/* MIC_BIAS widgets */
-	SND_SOC_DAPM_SUPPLY("MIC BIAS1", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("MIC BIAS1", SND_SOC_NOPM, MIC_BIAS_1, 0,
 			    wcd937x_codec_enable_micbias,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("MIC BIAS2", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("MIC BIAS2", SND_SOC_NOPM, MIC_BIAS_2, 0,
 			    wcd937x_codec_enable_micbias,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("MIC BIAS3", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("MIC BIAS3", SND_SOC_NOPM, MIC_BIAS_3, 0,
 			    wcd937x_codec_enable_micbias,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
@@ -2320,15 +2302,15 @@ static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HPHR"),
 
 	/* MIC_BIAS pull up widgets */
-	SND_SOC_DAPM_SUPPLY("VA MIC BIAS1", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS1", SND_SOC_NOPM, MIC_BIAS_1, 0,
 			    wcd937x_codec_enable_micbias_pullup,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("VA MIC BIAS2", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS2", SND_SOC_NOPM, MIC_BIAS_2, 0,
 			    wcd937x_codec_enable_micbias_pullup,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SUPPLY("VA MIC BIAS3", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS3", SND_SOC_NOPM, MIC_BIAS_3, 0,
 			    wcd937x_codec_enable_micbias_pullup,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
-- 
2.25.1


