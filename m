Return-Path: <linux-kernel+bounces-240714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55D927191
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C622E1F242F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FC1A4F11;
	Thu,  4 Jul 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANbFcxP0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890240BF2;
	Thu,  4 Jul 2024 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081169; cv=none; b=IKG9GCe7tcEbq0aE6Pfy7OWgIb8vmkdhbsbt5pkxR6CB9gSM90UsaagC8usRNJSJCatEg3k9GTTaUfU0DBgXxWzGQl55EkMHH37ZinNX8s8hb+3yJI1StWGCOQX8+wIX7R/2VCieBVA+RlMy6t00/K6kl1rrWm+FTKrz9rklsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081169; c=relaxed/simple;
	bh=e/K5DLqwZF68Cf9NR8aDxrmhZ3pI2bNegpaOGpFjPG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te561ZXlIVQoTgF+WKsSZp1GpGhVtGup4CDzqslPBV/roTnewshywPowGcs1JA/KZs9CM2rl/T9B9pBUzZNsPu+FkMnJTlve0SPGlv+Q9ELWBaDTtbRLwnZXdJwOsVkHBEvkEtEVZwVnoyeoxvATXI93TlguECxVXwJNP5veNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANbFcxP0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4645TRcg010965;
	Thu, 4 Jul 2024 08:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jUdu0OXWdnMlFo2C/icf7Grfb2WaYTs3izYGeOnqbx8=; b=ANbFcxP0jiD7maAz
	fbKziqrXij3osmy44qbn5T+6nyKv5wJ7DzJotZpW5c4kBpxsnBK2G3UNGDwzvx8R
	Kb2DH+ge2ROk8ZfPVhkgj6JByxx3GWtOfNLUDRd2YUvbBVc+U1pyoiRjrXWGmPMy
	0/MnJzoK2n2qZFzrzYjCKMKJUYVeOvf9ZBkCzrQTlpFMOo0QyGDb0BOQVdA5FR0E
	nMp/PPYZi6ChxR9OHAhK7mht7aDHqY8bQUCCpvf4kmXsY3Rfh+q1rwTe4BW/DAto
	GhRj7SDVrO2D/q8tnB2BfOc8rTLUsqZcTeP/cP71Bm+PW//8rYL9YWXTbX+AE7t6
	IcykGQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yr9b4p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 08:19:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4648J2iL030497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 08:19:02 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 01:18:59 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>,
        Prasad Kumpatla
	<quic_pkumpatl@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v2 1/3] ASoC: codecs: wcd937x-sdw: Fix Unbalanced pm_runtime_enable
Date: Thu, 4 Jul 2024 13:47:21 +0530
Message-ID: <20240704081723.3394153-2-quic_mohs@quicinc.com>
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
X-Proofpoint-GUID: vAon90bplkqtoKtvqpa064uLKmakboak
X-Proofpoint-ORIG-GUID: vAon90bplkqtoKtvqpa064uLKmakboak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=858 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040057

Fix the unbalanced pm_runtime_enable! in wcd937x-sdw soundwire slave.

Fixes: c99a515ff153 ("ASoC: codecs: wcd937x-sdw: add SoundWire driver")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x-sdw.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index a24d6c620dba..3abc8041406a 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -1067,13 +1067,15 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 		wcd->ch_info = &wcd937x_sdw_rx_ch_info[0];
 	}
 
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
-	return component_add(dev, &wcd937x_sdw_component_ops);
+	ret = component_add(dev, &wcd937x_sdw_component_ops);
+	if (ret)
+		return ret;
+
+	/* Set suspended until aggregate device is bind */
+	pm_runtime_set_suspended(dev);
+
+	return 0;
 }
 
 static int wcd9370_remove(struct sdw_slave *pdev)
@@ -1082,10 +1084,6 @@ static int wcd9370_remove(struct sdw_slave *pdev)
 
 	component_del(dev, &wcd937x_sdw_component_ops);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-
 	return 0;
 }
 
-- 
2.25.1


