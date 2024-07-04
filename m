Return-Path: <linux-kernel+bounces-240716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BAA927193
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0541283FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634DC1A4F34;
	Thu,  4 Jul 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EApAlsOb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB91A4F32;
	Thu,  4 Jul 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081179; cv=none; b=cZGefHG13oNcVv+r/zfr9D0V9sxl5XQRBzhMdHNCjZPeDnQyjCewuJTqjNpzW1px68t5W5tXf/Q89Y5ACSQKr7d3zSb1QCFrJGwLia8CTne/O6XrxueWmSb0xD9Qkn7u0MWpjNqopwc8TbrPjOZ/MkQ6VXmjuuzxepftltVm6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081179; c=relaxed/simple;
	bh=upmZAW8dn69PnkO8E8xNmjChTgJpfXDrhWbIGwNqiFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXfrJRvmUNUjF8AP6z4oCc4BimYKRs/3/eq1FiTml0W/m8+yZSa9LZ3EpqmF/hygAPQPkvTmT643sIfU98+p0NV+1fI94Zk1ofhnvldit8LqwjPAVk6gV9JJTb7wgCydyhl8ycx4Djid7SKovmTXMdw43yOoeBI4v9QB13BFtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EApAlsOb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463JgnbU015287;
	Thu, 4 Jul 2024 08:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o22hio7VyV4ycaCVCMQlLHB5tAzv6dao/1poTjxR9NU=; b=EApAlsObfCuurAqW
	voTM/ZT2WDaAJf4o9oGTJbxkh/Ph4mwbyizGaGF9kIShKzKvgkbMKZsJGlfvpp+S
	IeRRsrsoFxb6+2FzuktHDy2tbb2hUNMtzxdnRI8Ifcw7w/9973Q6c7w642LoaggY
	JxO9+BEI0UMVgcenoqRthpHssahwoEEhPqlIFKtySZMhzmwgFa/7Ifzm6VSbvPk2
	Ru6KFWzKfLFP2s3zKN111StLS3FSHvf/mbaefVjyOz4SR/o1vgI5xL2bFjug+Nq5
	E5bYKXLDvVqgZkN+SznNWalt5bI35MSgKmbbXPNkG2Z3DapdLPqLiCIOO+5b1vEP
	ta+nVw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4052yhjmxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 08:19:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4648JIkn031119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 08:19:18 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 01:19:15 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>,
        Prasad Kumpatla
	<quic_pkumpatl@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>,
        Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/3] ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply
Date: Thu, 4 Jul 2024 13:47:23 +0530
Message-ID: <20240704081723.3394153-4-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9eHRJvyNRn9UwheURdooeFR7trTVYoav
X-Proofpoint-GUID: 9eHRJvyNRn9UwheURdooeFR7trTVYoav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040057

Remove separate handling for vdd-buck regulator supply which is not
required. The vdd-buck regulator supply enabled using bulk enable.

Add the error handling in wcd937x_probe() and disable the regulators in
error case.

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/linux-sound/834d31cc-f4bc-4db7-a25b-f9869e550eb6@wanadoo.fr/
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 61 ++++++++------------------------------
 sound/soc/codecs/wcd937x.h |  2 +-
 2 files changed, 14 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 94282499fa33..13926f4b0d9f 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -869,37 +869,6 @@ static int wcd937x_enable_rx3(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wcd937x_codec_enable_vdd_buck(struct snd_soc_dapm_widget *w,
-					 struct snd_kcontrol *kcontrol,
-					 int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
-	int ret = 0;
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		if (test_bit(ALLOW_BUCK_DISABLE, &wcd937x->status_mask)) {
-			dev_err(component->dev, "buck already in enabled state\n");
-			clear_bit(ALLOW_BUCK_DISABLE, &wcd937x->status_mask);
-			return 0;
-		}
-		ret = regulator_enable(wcd937x->buck_supply);
-		if (ret) {
-			dev_err(component->dev, "VDD_BUCK is not enabled\n");
-			return ret;
-		}
-		clear_bit(ALLOW_BUCK_DISABLE, &wcd937x->status_mask);
-		usleep_range(200, 250);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		set_bit(ALLOW_BUCK_DISABLE, &wcd937x->status_mask);
-		break;
-	}
-
-	return 0;
-}
-
 static int wcd937x_get_micb_vout_ctl_val(u32 micb_mv)
 {
 	if (micb_mv < 1000 || micb_mv > 2850) {
@@ -2226,10 +2195,7 @@ static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_SUPPLY("VDD_BUCK", SND_SOC_NOPM, 0, 0,
-			    wcd937x_codec_enable_vdd_buck,
-			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-
+	SND_SOC_DAPM_SUPPLY("VDD_BUCK", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("CLS_H_PORT", 1, SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* RX widgets */
@@ -2915,24 +2881,17 @@ static int wcd937x_probe(struct platform_device *pdev)
 	wcd937x->supplies[0].supply = "vdd-rxtx";
 	wcd937x->supplies[1].supply = "vdd-px";
 	wcd937x->supplies[2].supply = "vdd-mic-bias";
+	wcd937x->supplies[3].supply = "vdd-buck";
 
 	ret = devm_regulator_bulk_get(dev, WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
-	if (ret)
+	if (ret) {
+		regulator_bulk_free(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
 		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
-
-	/* Get the buck separately, as it needs special handling */
-	wcd937x->buck_supply = devm_regulator_get(dev, "vdd-buck");
-	if (IS_ERR(wcd937x->buck_supply))
-		return dev_err_probe(dev, PTR_ERR(wcd937x->buck_supply),
-				     "Failed to get buck supply\n");
-
-	ret = regulator_enable(wcd937x->buck_supply);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable buck supply\n");
+	}
 
 	wcd937x_dt_parse_micbias_info(dev, wcd937x);
 
@@ -2949,13 +2908,13 @@ static int wcd937x_probe(struct platform_device *pdev)
 
 	ret = wcd937x_add_slave_components(wcd937x, dev, &match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	wcd937x_reset(wcd937x);
 
 	ret = component_master_add_with_match(dev, &wcd937x_comp_ops, match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
@@ -2964,6 +2923,12 @@ static int wcd937x_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_idle(dev);
 
+	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
+	regulator_bulk_free(WCD937X_MAX_BULK_SUPPLY, wcd937x->supplies);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index f267c66ca959..37bff16e88dd 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -483,7 +483,7 @@
 #define WCD937X_MAX_REGISTER			(WCD937X_DIGITAL_EFUSE_REG_31)
 
 #define WCD937X_MAX_MICBIAS			3
-#define WCD937X_MAX_BULK_SUPPLY			3
+#define WCD937X_MAX_BULK_SUPPLY			4
 #define WCD937X_MAX_TX_SWR_PORTS		4
 #define WCD937X_MAX_SWR_PORTS			5
 #define WCD937X_MAX_SWR_CH_IDS			15
-- 
2.25.1


