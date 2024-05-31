Return-Path: <linux-kernel+bounces-196237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD98D5949
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091B31C23511
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FE78C88;
	Fri, 31 May 2024 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MeA9PJ5k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E85B69E;
	Fri, 31 May 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129552; cv=none; b=gjS9j5ams53XonIj9nQyiXqBWv3dFUppb0oHP3iG2OzfApbYzKR2Rx6d+JGFXWnayTGaP8JYLzCQ+CItV3HXgWvM1IwXml/F82y1Zd0BUB3hYdczI8L/8/y/YoGuegbju31JI+5s/M2ntbhPf3IQoXZR56wi+25t4OSPrGD/UaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129552; c=relaxed/simple;
	bh=FS8+0BhE4Szb/ivvNekGQHQWGTNAgoxEFQIozQwZMcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aEDuO5hR1Lzh4N+/p9vJKQ6D0N7WOADO7IpRqC5E4UZbs9drQ+rGumztxYI5GH/R9PJf3dHwwv3fwQUCkMe0OzqdCH7Ta1Rsl1rRLDUyOPES1w6SHWq5Anyqchi9r20swfe3OpURfxiBXNDLfeOpBZpf5cKIZYdbvkvQlXfzKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MeA9PJ5k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UMIaq0019046;
	Fri, 31 May 2024 04:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tXnO9w0sElzxjIohMmnui9
	JGeIht4372nvJoWpQcmQ0=; b=MeA9PJ5kZj5WvToBhlfZQn8VOqn/wC7MMZx9Ar
	Q45uyK8jIdyeyYFNum5GLeQJT4TFWVCyyZTl3PD9U6l052LNvWMUJ2GsPrJYIvUi
	h3/8e6KE7p6oUtmFpLa7FHg0Y6aD4T3wyYhMmBnrZKw6XrH74bUOBTItnSEONgJ1
	7ABJPyrpogeNIztRqahHMWkESmQB8Bdrx/nfUHvVCOn7RNmIwJ+1iZrmZ4l3uuCx
	oyTB4rot2e9PC20qZsxMMKHql5R3j957ufUDacqL46iHeQqNLNKUpgS7snfkSrTD
	eaw2nG2OIcPABPIT8BD41oE2vSDHM+yYmYJYectVk5lLdtyQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf23srjny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:25:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V4PeFx026618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:25:40 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 21:25:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 21:25:37 -0700
Subject: [PATCH] siox: bus-gpio: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-siox-bus-gpio-v1-1-6a2f943ac8ad@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEBRWWYC/x3M3QqDMAyG4VuRHC9QO8d+bmXsoK1RA7NKoqMg3
 vuihw9837uBkjApvKoNhH6sPGVDfakgDSH3hNyawTvfuNvV4diibQrGVbGfecK7TzE8fZ26RwN
 2m4U6Lmfy/THHoIRRQk7DEfpyXguOQRcS2Pc//GXHPYEAAAA=
To: Thorsten Scherer <t.scherer@eckelmann.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KnqSYY3ZKbs7_5zhAk_jkgWEithom3wy
X-Proofpoint-GUID: KnqSYY3ZKbs7_5zhAk_jkgWEithom3wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310032

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/siox/siox-bus-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index 9e01642e72de..d6f936464063 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -148,5 +148,6 @@ static struct platform_driver siox_gpio_driver = {
 module_platform_driver(siox_gpio_driver);
 
 MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
+MODULE_DESCRIPTION("SIOX GPIO bus driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-siox-bus-gpio-72cba921cf84


