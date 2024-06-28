Return-Path: <linux-kernel+bounces-233746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16E91BC79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60712285A63
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0110157488;
	Fri, 28 Jun 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LJo/mF11"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA92157476;
	Fri, 28 Jun 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569583; cv=none; b=DZlJDFBWWXqMR+OetlAxCFOSNpOMucR5/qRBXKHPa5OqPL9zeEUhn5N3lbbMXXJzOxM2vutapZbfHhk5isdNniS4QBbqXNGJeQSmJRuo+VqT/HiFaJaVyV4zpdgH6RSvZPGZySgxtQxOFRxIfoP6a+Yi+Bfpls6b0bbffA6gW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569583; c=relaxed/simple;
	bh=wGLZFlGunXIXyg2YfhDN12GObckUXUdBtInGWacU8bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOlEpJkTULIIWqXJ8QRPijFw4BT3y81qjQmn7kACc+oBd7xLSDxZn1K7pk/9UxDGe9Fbr1mwN65sPI5gcwVXzD8YYcgTOYtlZCt+r0AR0Ly0WAZHYqyJZlnEMrI3gQOoGeFnfwbOtUcnfrUVbwmgrQtj75JIkUBPHqH+aOUNz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LJo/mF11; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S91nJw010649;
	Fri, 28 Jun 2024 10:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zvx1l5aJpMiBJg36h0K6ZS3e8UVYD/KaZfLXxfZjbkg=; b=LJo/mF115w18lSWd
	0zTVFuH4+V8duIVDOqVo9EmRqhjYXeBrd4X7xxXWjrK6E6wyRiogcJTIx+UZivtO
	Y38sNGflYD1fi54DOyuSc0aYqY7udrwO5403MXN7rW/EXTFhK1kJUv2x0AZl0H4E
	bLxpVGyjf09aMUuKy7cHErdODkn7c6/gDX62Yjwu7Q3wF9KfXC3pVA9dBaqZenQ4
	dyhmkSF2EHLbSKfoGxNL2A1A+el0RAVYw1nHfYQExAZ/S9xYdA2COX/BFRpnprNG
	nsmZKvb63hprgYHS15qIJ22aLU3VKOZcfC/3udjd7kinpIUYWI62igccLxV2I6Eg
	NCE4Xg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqf6qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SACqDD024370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:52 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 03:12:49 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Prasad
 Kumpatla" <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik
	<quic_mohs@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v1 2/3] ASoC: codecs: wcd937x: Remove the string compare in MIC BIAS widget settings
Date: Fri, 28 Jun 2024 15:41:42 +0530
Message-ID: <20240628101143.1508513-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628101143.1508513-1-quic_mohs@quicinc.com>
References: <20240628101143.1508513-1-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KRs-6_Jh7MrjraGPXQFSGYwEHa-2fzdr
X-Proofpoint-GUID: KRs-6_Jh7MrjraGPXQFSGYwEHa-2fzdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280075

Remove the string compare with widget name in MIC BIAS settings, instead
of string compare use the MIC BIAS id's.

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


