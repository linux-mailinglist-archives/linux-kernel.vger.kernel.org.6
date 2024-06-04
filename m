Return-Path: <linux-kernel+bounces-199864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A68FA6DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3680284F33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9524A04;
	Tue,  4 Jun 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwgrhMkW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581C2F28;
	Tue,  4 Jun 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460192; cv=none; b=kFxGoREPyvMih4S7tXOeaX1GxJBaHprgI/w2P8bVmCm2vdXlljXYLcWEqidelnshvk1cXINx7cvP5Tg6Wu4AJ4/j3gPwpaJYOgXjs+ikPQ7EuOHf6fj1Dzwu/+JYB+d67g3l3kow2IlGX3vngXOhGgMBrdiw28bAdqzx5Tq4BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460192; c=relaxed/simple;
	bh=gb0aibxD4JVxwoDEk+4ZywdBaq63dDjTiom7H+cVRAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BHvG+SCiDol/j+e2HXF3kIjBKSCZIRi/ZhqstOery5FzmaNQBAt53k/1TjRM9PuELJScrw7vLI1Z/2EY/u/zuP89k3S5QDXl95DqfifbKBnUJ1Rsy2mBFJEYCiljTwopMANndYPN8VHE1D4DsRB5FcuodAhWC0gMf3fCClYqOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwgrhMkW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453AvFJ3026168;
	Tue, 4 Jun 2024 00:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TfJSvsxZchNsACT0iSDrom
	+R4Q6rBRlptZTHzpVSPWY=; b=jwgrhMkWHQg2+omKPlkDYcVZ19/7DaLM8iE8d3
	jD0/fPUVeQenqq+d6ajyxwlBnVuGsrops5Vse0D2ZWuMP06DAr1+A3cy0VDIDcQk
	3vO7SzWDpUFZEKW8PyzB/Mz/oVHCBGGzYyyxHHcEEwO2UIQyWoPdIa+OXjS5arIS
	J4WjpoOVzTNTUOTLUKB1pk/CvNTMZrXgnH9PAsiA7OVLbJlmHV5aSKhcu9QE7uFE
	RADWepgrQoIYKYj7suUBHcrB1YWiEnG79XJFV2X9tCFpEvbLgmfLoT9xWAJgghoW
	UnL57//yxlnMLJYMQlgqbvuG4wqrRmrvmWzrX92WmMBBWylg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wn9x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 00:16:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4540GCR5005442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 00:16:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 17:16:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 17:16:07 -0700
Subject: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMZcXmYC/32OTQ6CMBCFr0K6dkzbQFFX3sOwKG2RSaSVDlQM4
 e4WDuDiLb7k/a2MXERH7FasLLqEhMFnEKeCmV77pwO0mZnksuSKSxgskM8KBkYTBiD7AV5bbap
 WSasqlpPv6DpcjtZHk7nV5KCN2pt+73qhnxcYNE0u7vYeaQrxe3xIYg/9n0sCBFQXeVWdqIXS5
 X2c0aA35+xgzbZtP7tvClTXAAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <kernel@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tepnMV2vBTpmIIg10KvVcq97gzJq5yEQ
X-Proofpoint-ORIG-GUID: tepnMV2vBTpmIIg10KvVcq97gzJq5yEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=847 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040000

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 sound/soc/qcom/sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index eaa8bb016e50..f2eda2ff46c0 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -160,4 +160,5 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
+MODULE_DESCRIPTION("Qualcomm ASoC SoundWire helper functions");
 MODULE_LICENSE("GPL");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-snd-soc-qcom-sdw-07dac5b62d65


