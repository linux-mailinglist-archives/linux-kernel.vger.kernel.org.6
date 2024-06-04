Return-Path: <linux-kernel+bounces-199987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A5A8FA8D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9ED28AB40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174213D62C;
	Tue,  4 Jun 2024 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D2/C4O5q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA377ECC;
	Tue,  4 Jun 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717472215; cv=none; b=GE15SWWm37trxgj+EuXU2Ugb+A8zWKkAJCXN9U3IWwEbLbbWxaOUrputxjHub11XKr+F2C6fgwTN+HY9Se4hls5i5vUMnTKUDW1bZZf8sw+y+oJgQGttSpiQ7WidOTjNmfCLfgaUC+MBL0L5A1pLpq50jSEXdQxL/yF6mwol9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717472215; c=relaxed/simple;
	bh=O0ooiMhE9ABdkegOf36SMh542CQAMxvZp66UK0IMt60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ycs97H8ppSqVMTJGgpAz2/FdNGKJUgEyb7MoER0p79Hdc76z2OQW/41Mnz17weNn5CW5kvHkI0wWyadb4AUUZSr24HzLR1lAmO1HLa54f+6cwuV+/MnsAlwj+kPf9fl1TyVInSiLaNikjkD4Qa4PMoI+0w8fJVz1GaG7wSLaUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D2/C4O5q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453LjAaf011871;
	Tue, 4 Jun 2024 03:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LuB8fR0LHpEmWCDuLjFiVc
	EamlqAVUpj9s7llmRcsBU=; b=D2/C4O5qxKaUakWrwgm3UL1zbVZw3GJ35G6fbF
	wbLAkLt3eFbBq6KBg3ecmNVSbde5zZ3nNzze2+5d/YkmvC+U63g9IMkkOGPjiYiD
	rrv4wTaS5jyKVgSdbIz9fpnTZCBCjzD7C8zQ/GUVdqMv58hkzAIs9zmzToLg796w
	IVqg1hr0y5KW7jSx188XBL7TK+yoTONWtVAs0GQFA8Nh5Aklp4P4uJ7M7O0MjMem
	sSyH1JYECRps4npHwN1f09nLCv72LUdcXQJ+eczPom9VuwRWNtdsXPBqogaerz1y
	2yXujx4EvxJ8vtT/1DSAFEL0tX4XEPQZK2BKUV06HlT95jJg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qnmdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 03:36:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4543aUIT012497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 03:36:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 20:36:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 20:36:28 -0700
Subject: [PATCH] clk: sunxi-ng: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-drivers-clk-sunxi-ng-v1-1-c44a4c22d544@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALuLXmYC/x3MTQqDQAxA4atI1g2MdpDSq5Qu5idqqKYlURkQ7
 95pl9/ivQOMlMng3hygtLPxWyraSwNpCjIScq6GznXe9e6KS8asvJMapvmFtklhlBG9G24uUus
 p9FDrj9LA5X9+PKtjMMKoQdL0+80sW8El2EoK5/kFn4sfJ4gAAAA=
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HRzBJTv6RcDYu6LHBHavhZlwpsRu2fAh
X-Proofpoint-ORIG-GUID: HRzBJTv6RcDYu6LHBHavhZlwpsRu2fAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040027

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sunxi-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/suniv-f1c100s-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun20i-d1-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun20i-d1-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-a64-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-a100-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-a100-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-h6-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-h6-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun50i-h616-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun4i-a10-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun6i-a31-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun6i-rtc-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-a23-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-a33-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-a83t-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-h3-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-r40-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-v3s-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-de2-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun8i-r-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-de-ccu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     | 1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 1 +
 drivers/clk/sunxi-ng/ccu_common.c        | 1 +
 24 files changed, 24 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
index 0736f6c81269..de36e21d3eaf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
@@ -138,4 +138,5 @@ static struct platform_driver sun20i_d1_r_ccu_driver = {
 module_platform_driver(sun20i_d1_r_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner D1/R528/T113 PRCM CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 60756aadfad6..9b5cfac2ee70 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -1407,4 +1407,5 @@ static struct platform_driver sun20i_d1_ccu_driver = {
 module_platform_driver(sun20i_d1_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner D1/R528/T113 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 14f5c3da652b..d1a1683baff4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1494,4 +1494,5 @@ static struct platform_driver sun4i_a10_ccu_driver = {
 module_platform_driver(sun4i_a10_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A10/A20 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index 3b983bb59bd9..2c791761a646 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -215,4 +215,5 @@ static struct platform_driver sun50i_a100_r_ccu_driver = {
 module_platform_driver(sun50i_a100_r_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A100 PRCM CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 38aa6e5f298e..bbaa82978716 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -1277,4 +1277,5 @@ static struct platform_driver sun50i_a100_ccu_driver = {
 module_platform_driver(sun50i_a100_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A100 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 491b16cfe368..c255dba2c96d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -995,4 +995,5 @@ static struct platform_driver sun50i_a64_ccu_driver = {
 module_platform_driver(sun50i_a64_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A64 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index e2dc29fa99e7..c72815841111 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -257,4 +257,5 @@ static struct platform_driver sun50i_h6_r_ccu_driver = {
 module_platform_driver(sun50i_h6_r_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner H6 and H616 PRCM CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index e6421c2ba122..a20b621ad8f1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1287,4 +1287,5 @@ static struct platform_driver sun50i_h6_ccu_driver = {
 module_platform_driver(sun50i_h6_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner H6 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 45aae1ae5178..cd67751f2bdf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -1167,4 +1167,5 @@ static struct platform_driver sun50i_h616_ccu_driver = {
 module_platform_driver(sun50i_h616_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner H616 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 8cb8cbbdbafb..e8b8d2dd7f2c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -1284,4 +1284,5 @@ static struct platform_driver sun6i_a31_ccu_driver = {
 module_platform_driver(sun6i_a31_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A31/A31s CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 5a98c4e9e667..87e23d16ed0f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -382,4 +382,5 @@ int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
 }
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner H616/R329 RTC CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index e748ad612b8f..6c2a08f722a8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -764,4 +764,5 @@ static struct platform_driver sun8i_a23_ccu_driver = {
 module_platform_driver(sun8i_a23_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A23 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 8a27a1777600..5e0bc08a9ce3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -836,4 +836,5 @@ static struct platform_driver sun8i_a33_ccu_driver = {
 module_platform_driver(sun8i_a33_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A33 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 93eca47935cf..cb4c6b16c467 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -924,4 +924,5 @@ static struct platform_driver sun8i_a83t_ccu_driver = {
 module_platform_driver(sun8i_a83t_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A83T CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index b0b8dba239ae..7683ea08d8e3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -349,4 +349,5 @@ static struct platform_driver sunxi_de2_clk_driver = {
 module_platform_driver(sunxi_de2_clk_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner SoCs DE2 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index ca5739fa04f7..13e57db2f8d5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -1095,4 +1095,5 @@ static struct platform_driver sun8i_h3_ccu_driver = {
 module_platform_driver(sun8i_h3_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner H3 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index bac7e737db98..da6569334d68 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -275,4 +275,5 @@ static struct platform_driver sun8i_r_ccu_driver = {
 module_platform_driver(sun8i_r_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for Allwinner SoCs' PRCM CCUs");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 3774b293e74c..984ad3f76b18 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1376,4 +1376,5 @@ static struct platform_driver sun8i_r40_ccu_driver = {
 module_platform_driver(sun8i_r40_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner R40 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 994258a3ad2e..d24c0d8dfee4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -781,4 +781,5 @@ static struct platform_driver sun8i_v3s_ccu_driver = {
 module_platform_driver(sun8i_v3s_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner V3s CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index ae7939d3f502..0975ac58949f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -267,4 +267,5 @@ static struct platform_driver sun9i_a80_de_clk_driver = {
 module_platform_driver(sun9i_a80_de_clk_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A80 Display Engine CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index bfa2ff9d52a4..e5527c8cc64f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -139,4 +139,5 @@ static struct platform_driver sun9i_a80_usb_clk_driver = {
 module_platform_driver(sun9i_a80_usb_clk_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A80 USB CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index c05805e4ad22..756dd8fca6b0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1249,4 +1249,5 @@ static struct platform_driver sun9i_a80_ccu_driver = {
 module_platform_driver(sun9i_a80_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner A80 CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index 76d3d070b2a7..52f1a04269f8 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -578,4 +578,5 @@ static struct platform_driver suniv_f1c100s_ccu_driver = {
 module_platform_driver(suniv_f1c100s_ccu_driver);
 
 MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_DESCRIPTION("Support for the Allwinner newer F1C100s CCU");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index ac0091b4ce24..9dc56c36add5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -247,4 +247,5 @@ void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 	}
 }
 
+MODULE_DESCRIPTION("Common clock support for Allwinner SoCs");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-drivers-clk-sunxi-ng-40f80be14ea6


