Return-Path: <linux-kernel+bounces-234761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E491CAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1124628467E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED261CD2F;
	Sat, 29 Jun 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YAUI2Q0s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7118C36;
	Sat, 29 Jun 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719629083; cv=none; b=hlfxda76uBn6Kp8lSVQT81YTc07Uo76ds///oprhIrw9oRX53VoSz3jHFEuqcV4kxCFCu/mAmTBoHJNfExQllFMsb570MV4gCOKwUun1/eLDvq41XE2dqtOjpSywCJJs3qh+tRhZsFuo+VLO4jAPwtp+1xB6Hws+RUW6H4xxx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719629083; c=relaxed/simple;
	bh=p8iIXpwYR9Biygc/M5mSdAtHO7W8ZU5of6LQ+JgyoNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PvP9epxI7Tj11SQhgqHi5DXf17tQMgx6Zc3AwzqrQlQg0182stTliCOVMdaN+EeBRhtT6TGJhbv+RrUkQLhq7GOpbWt6d2+XqRoxQMW/23IB1LCDTZ9p0PXBQYR27LU/lDRtX3CRgyfbmd/qlcE4eYfhtmo2oZYV50aEqIKF/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YAUI2Q0s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T1OaZe010461;
	Sat, 29 Jun 2024 02:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5s2Gl/oj6oJvHPbGpv/AYi
	PtZVdErC+YN9KDK/tR+OU=; b=YAUI2Q0sZDomPb+zSupKcEmFQx9iHw3riLe0x/
	RSjRNwkBPvVu2DLZ0hW/G+QbZjEIgG8g+iEEzETU1c8XSQHDaWWASGvd5C4pe4+P
	7K4po2CJeGSWvRYjkdVqYh+HtezgATwLuxmJp3Bx+kG2a3hyC71oGFUAeOeiUnt7
	bmvc+nUR81rBKjdEz05PunG8sv8BFxjUXIX8Dvf8jT1VU8OUA3Gi1SVPjfb3a662
	SqMP8JukKaRJNxcR4IN39kp84j1poPSfSiJXb6q+pygn8Opun1RS6POY08INVQyE
	rLhbXgACLay8k68gfAHeS1P+o61nVRvkFpSDBNV/cVk5yFHw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mng5vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:44:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T2iTYx013630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 02:44:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 19:44:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 28 Jun 2024 19:44:18 -0700
Subject: [PATCH v2] clk: vexpress-osc: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240628-md-arm64-drivers-clk-versatile-v2-1-cd8ec6cad92e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAF1f2YC/42OSw6CMBCGr2K6dkx5Slx5D8NiWgaZCEWnQDCEu
 9tyAnf/l/yvTXkSJq9up00JLex5dAHS80nZDt2TgJvAKtVprsskg6EBlKHMoRFeSDzY/gVR4MQ
 9AWpTYpal1zavVCh5C7W8HgOPOrBBT2AEne1ibc9uXmFAP5FEe8d+GuV73FmSGPp7eUkggdJUW
 FBBWlN7/8xs2dmLHQdV7/v+A3rIbV/tAAAA
To: Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Liviu Dudau
	<liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DKptU_KILgEA0e1h_LBYxT7jtugEyutG
X-Proofpoint-GUID: DKptU_KILgEA0e1h_LBYxT7jtugEyutG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=931 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290019

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/versatile/clk-vexpress-osc.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- no changes to the actual patch, just collected review tags and rebased
  to current linus/master. Hoping to get this into linux-next and out
  of my tracking spreadsheet :)
- Link to v1: https://lore.kernel.org/r/20240613-md-arm64-drivers-clk-versatile-v1-1-6b8a5e5e00ef@quicinc.com
---
 drivers/clk/versatile/clk-vexpress-osc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index b2b32fa2d7c3..c385ca2f4a74 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -119,4 +119,5 @@ static struct platform_driver vexpress_osc_driver = {
 	.probe = vexpress_osc_probe,
 };
 module_platform_driver(vexpress_osc_driver);
+MODULE_DESCRIPTION("Clock driver for Versatile Express OSC clock generators");
 MODULE_LICENSE("GPL v2");

---
base-commit: de0a9f4486337d0eabacc23bd67ff73146eacdc0
change-id: 20240613-md-arm64-drivers-clk-versatile-a0b6a3327f48


