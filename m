Return-Path: <linux-kernel+bounces-207129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F89012B2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB12C1F21B8B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8217B4FE;
	Sat,  8 Jun 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A0AHLCrW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CB179675;
	Sat,  8 Jun 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717863309; cv=none; b=Z6Q1kRbWwf+CmybdIo8MEJsQlH851K1VAKYIWlXgRb61NPK48rrj73r4Abv9bWBfRhTL48oQ2W0T9erEUpgT0+oTwNf+JwW6X3UCV3MpAe3e6N7f1RcCSLOfVhKFP6LUPsy0IK4VZfJo8Klwmk15j8h61BaHO5D0hi3995Gwvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717863309; c=relaxed/simple;
	bh=6t8KhUaq2gdgrr+pplXAkboAQ7kJUYZMZNlrL9HX1E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dFonfBZNX0bbxAzX66bIPCWOXGn39Iz0VBHtuRZk/utQgzSFtczNlhum/31vDqCFjRJGnM5TBCevhS9Wd6UTT3GaEmHG6rbCkANHNsYbh/pPEKZzAnyHdhgkS5jrEdGLEXHdWA8PlYOjGrNzD6rHUJNJUTNt60SKKwDgT17Mdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A0AHLCrW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458GBFgO022930;
	Sat, 8 Jun 2024 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jCVO1rlcKIt68CFsV2gzjy
	XhQ0yWTU5oC6XzCiUFPHM=; b=A0AHLCrWSZIwfTDYo9dFpXyoP5+ruuughFOJYB
	2aaR/NrajduZ9LLVpmuXLv3uHlXD60wNn3bLEFv3ydHlFGHZKbA9uRBEVdLSpnBR
	WuCuPuY8esVgWI0UIbskjoB325FhZv29cu3B4pmxaW/iB/0ekcpcopNJw/V7irJ9
	GChxYrq7OqCdWLhAf4guT5+robez1h3v9E2XKLlA308jPLvacAnawTcEzyhQHTF1
	gcFUO9yPKl6VQJuNmm9+Ap6ER6EVHcbYmvVrD/lUd47RuVSLb6G2F8LZNqel/nrv
	FaBMldVpLBCR44j77XJX91nq9aeYCK76X2oMjssEDcvluglA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmrv2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 16:14:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 458GEdb6002661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 8 Jun 2024 16:14:39 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 8 Jun 2024
 09:14:38 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 8 Jun 2024 09:14:37 -0700
Subject: [PATCH] irqchip: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240608-md-drivers-irqchip-v1-1-dd02c3229277@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGyDZGYC/x3MQQrCQAyF4auUrA2MRQfxKuJimkQnYMeaaCmU3
 t3o8uPx/hVcTMXh3K1gMqvrswX2uw6olnYXVA5Dn/pDyumEIyObzmKOai+qOiEz51iPlDJBHCe
 Tmy7/6OUaHooLDlYa1V/qoe2z4Fj8LQbb9gWnE/pRgwAAAA==
To: Thomas Gleixner <tglx@linutronix.de>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Jerome
 Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Gregory
 Clement" <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wj7q2II9feNUhcMiywsfcwBYAbQzzmOz
X-Proofpoint-ORIG-GUID: Wj7q2II9feNUhcMiywsfcwBYAbQzzmOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406080122

On x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/irqchip/irq-ts4800.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/irqchip/irq-meson-gpio.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().  This includes a 3rd file,
irq-mvebu-pic.c, which did not produce a warning with the x86
allmodconfig, but which may cause this warning with other kernel
configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/irqchip/irq-meson-gpio.c | 1 +
 drivers/irqchip/irq-mvebu-pic.c  | 1 +
 drivers/irqchip/irq-ts4800.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 9a1791908598..27e30ce41db3 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -608,5 +608,6 @@ IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
 IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
 
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Meson GPIO Interrupt Multiplexer driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:meson-gpio-intc");
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index d17d9c0e2880..08b0cc862adf 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -193,6 +193,7 @@ module_platform_driver(mvebu_pic_driver);
 
 MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 7K/8K PIC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:mvebu_pic");
 
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 57f610dab6b8..b5dddb3c1568 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -163,5 +163,6 @@ static struct platform_driver ts4800_ic_driver = {
 module_platform_driver(ts4800_ic_driver);
 
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ts4800_irqc");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-irqchip-ddd62405c06c


