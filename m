Return-Path: <linux-kernel+bounces-229928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB379917620
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC11C1C2243B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197824B28;
	Wed, 26 Jun 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lPONvfqx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F81CA85;
	Wed, 26 Jun 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368781; cv=none; b=A72IPsFjuOnOgP1lhEzsD8a2YDeSdcS+xtSB4f+jzgKsFmNUzeorfGTS2LrAgfrsg8O7AxSXU0ppiDVA/QK31GnJDDwS0CMJyD8tW892ZJolNCC9xjD5EtLUnqNGmc+IbSiEkW65SyAoaBHwWOCrAmVQnRiecOC6TTfMEPBh01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368781; c=relaxed/simple;
	bh=4EXmUsFo8b2xhR1P7lQQvnCd0Xtbmq9kHad9mhdzlz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bnhzNlJAZREFCIlbPOH+ddxcepYxbt2TgbnRb5FUNjH/uZT5CTOO/o0s6jvYMykD0onwYcVMesUwBcTSn6H9NbCYcpclV0g6sS5oWrMDNRd3kKqNKCvUmdubDI8xD4vKAxqYaBJqZSZ0ZmNgfIUzlNyCos3s+lJfIwKZl2o/wEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lPONvfqx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIm44Y014138;
	Wed, 26 Jun 2024 02:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IeGrfFSUKNXY/SQdHsLOXN
	+RZ1hfsllv4M0nMVD7vZM=; b=lPONvfqxmIjCnH6WpHJjwhXItejauKe5ObKM/d
	ra2BsQRA0J1QZi5wJbvBu8X6lV2cEH0Ldix8wozHAXy1ZnwQGuIo5CLoLc34ld7y
	kKTDM+lwYDAsppZvrklMkvZcWWKOZjCNN3G1dpaEnIXb+uQbfDXxyl6djhxSb+jG
	l+cC+QFwP9eQSdF4+pp2JwDDDZs35Hk7D9Nk2J3uj39ovrendxj/p9bptC76N2oN
	aCjldkE/jHASQGGOxl4YUEevSinyLzHwzezJvONxFxaRpMdSCRyIMzSy7FLqG8mP
	oTT21tTT3HyewYhDP+BwMIgAt2PnOqtU1DeYn8N73zTc3V/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgyybe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 02:26:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q2Q22K016612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 02:26:02 GMT
Received: from jiegan-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 19:25:55 -0700
From: Jie Gan <quic_jiegan@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai
	<quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>,
        <quic_yijiyang@quicinc.com>, <quic_yuanjiey@quicinc.com>,
        <quic_liuxin@quicinc.com>, <quic_yanzl@quicinc.com>,
        <quic_xinlon@quicinc.com>, <quic_xueqnie@quicinc.com>,
        <quic_sijiwu@quicinc.com>
Subject: [PATCH 1/2] Coresight: Set correct cs_mode for TPDM to fix disable issue
Date: Wed, 26 Jun 2024 10:25:36 +0800
Message-ID: <20240626022537.1887219-1-quic_jiegan@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RYmr0EAsq5ha8KF5jmfbUIwpa4dwU63J
X-Proofpoint-ORIG-GUID: RYmr0EAsq5ha8KF5jmfbUIwpa4dwU63J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260018

The coresight_disable_source_sysfs function should verify the
mode of the coresight device before disabling the source.

However, the mode for the TPDM device is always set to
CS_MODE_DISABLED, resulting in the check consistently failing.
As a result, TPDM cannot be properly disabled.

Configure CS_MODE_SYSFS/CS_MODE_PERF during the enablement.
Configure CS_MODE_DISABLED during the disablement.

Fixes: b3c71626a933 ("Coresight: Add coresight TPDM source driver")
Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index a9708ab0d488..90a5105f6199 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -449,6 +449,11 @@ static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
 		return -EBUSY;
 	}
 
+	if (!coresight_take_mode(csdev, mode)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EBUSY;
+	}
+
 	__tpdm_enable(drvdata);
 	drvdata->enable = true;
 	spin_unlock(&drvdata->spinlock);
@@ -506,6 +511,7 @@ static void tpdm_disable(struct coresight_device *csdev,
 	}
 
 	__tpdm_disable(drvdata);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	drvdata->enable = false;
 	spin_unlock(&drvdata->spinlock);
 
-- 
2.34.1


