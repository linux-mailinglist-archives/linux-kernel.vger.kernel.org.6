Return-Path: <linux-kernel+bounces-233747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F328E91BC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC911F238A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC3155757;
	Fri, 28 Jun 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lZYriwEo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFB156676;
	Fri, 28 Jun 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569588; cv=none; b=jqYoyhReRrknOFET9IqBwpFv56rDjV3ydJae/7P/wVsshHfMiDIr2VSjZhkg2JdaTGzynISrryeM37PyXtT3qyFNnC+PGvNWC6tsPomwfNAi6bRjC0A1UfNYvF3XjIkSk3djBFH9wo3xCO9YugCy6ufH2rji4gor1mCUbLFowLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569588; c=relaxed/simple;
	bh=wgvO9vNszEzLKlcodrtoegm/fjFpygBPpy9DZyWxx6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPgsLyfwRoXFSBnVeZQcQ6eO7F0JxNJ8ARcHdiPS2CshhkXs9w0VyN1TWRldKvL+HF9hVnOgub6t5e9tcslQtXxDLUv4REOzndebDbYMuxjrDAMv1iF3hdrOvALCq9bE/S32Hnko4SEZbRXpIOYWpfOALf/1WmM4L5SLd7+peTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lZYriwEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S7mrsY029826;
	Fri, 28 Jun 2024 10:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MiPTyQeqNCwGK/FsWxf2ZGjgaaqxJytz2W2uNqpM44k=; b=lZYriwEoMXwrrFzB
	rtc3/0tXoZ+viYdn5nbKI+GasFpJViB/CVIeoxhT9U52am2aLMQjKkwZIvzQSzb0
	Nc+RDQ8o0Ihu7XHFSfYR1oUqg1SPw6Kru6EC4dJSFepw9skkNxAFX9YXk3KiA43C
	hw7T9vadga16kdSsIrToZj+OrvCCYeXz3dyymb05YAV+AY5mXWe5iQE6yCLj+yrN
	CcDLjiXHqApn5nYj+41TugO+wa1PbSgj5uPq+UVuUUWvX8LL5k+sfbmeqhVXkHh5
	5Utncz7PcziN4YPID9JhCzonij3aHNtgWsZSTmlPYWlNOuSjr6VXqCz2c2SlV+GC
	y2GIIA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46f5gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SACvha017347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:57 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 03:12:54 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Prasad
 Kumpatla" <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik
	<quic_mohs@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v1 3/3] ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply
Date: Fri, 28 Jun 2024 15:41:43 +0530
Message-ID: <20240628101143.1508513-4-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cOQD51wkXNbBG3ma6-MOhNN9xkXTautF
X-Proofpoint-GUID: cOQD51wkXNbBG3ma6-MOhNN9xkXTautF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280075

Remove separate handling for vdd-buck regulator supply which is not
required. The vdd-buck regulator supply enabled using bulk enable.

Add the error handling in wcd937x_probe() and disable the regulators in
error case.

Replace free_irq() with devm_free_irq() because irq have been requested
wth devm_request_threaded_irq().

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 67 +++++++++-----------------------------
 sound/soc/codecs/wcd937x.h |  2 +-
 2 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 94282499fa33..b696305c0817 100644
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
@@ -2614,9 +2580,9 @@ static void wcd937x_soc_codec_remove(struct snd_soc_component *component)
 	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
 
 	wcd937x_mbhc_deinit(component);
-	free_irq(wcd937x->aux_pdm_wd_int, wcd937x);
-	free_irq(wcd937x->hphl_pdm_wd_int, wcd937x);
-	free_irq(wcd937x->hphr_pdm_wd_int, wcd937x);
+	devm_free_irq(component->dev, wcd937x->aux_pdm_wd_int, wcd937x);
+	devm_free_irq(component->dev, wcd937x->hphl_pdm_wd_int, wcd937x);
+	devm_free_irq(component->dev, wcd937x->hphr_pdm_wd_int, wcd937x);
 
 	wcd_clsh_ctrl_free(wcd937x->clsh_info);
 }
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


