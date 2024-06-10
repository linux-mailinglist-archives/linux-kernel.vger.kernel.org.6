Return-Path: <linux-kernel+bounces-209020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AAB902BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CA51F22D31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37241514CC;
	Mon, 10 Jun 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="atuKmN6p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEE3BB48;
	Mon, 10 Jun 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060206; cv=none; b=DiSu8Zot/7E+szgqTlbDcPGGdt4y0D8BUXYgbmZJr7ePqST0JPjUByo6t1lvdtjOgAP7Rl+M9FDQVQh4FDoo86u6G9UEvAGRPqYx3YNqHgcXeNqHKgWTXR9dQLzP3pXKbFO+3L658NvWeQQ5VjADauyIaH8l8GzYoqYQKYG46a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060206; c=relaxed/simple;
	bh=HeyZpv9HOfHEcwRtNywwbHU/cJUoJdI5HBouhBRJXqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EbTKd9CQbGT4H5WJWM99+RraNVdFQNhuDekDrKt00RrmRnCOEhbIUOhlSXCiWKvoL0u665mq+mmVCMEhkW9138wTZm9arFyjzz+oBLTwfwpGg+Wyqx1UGuMfV/EqzqjvSE2QeSo0G7/RtawBKhzpUvbXoJyW5p7F/LljGuR95HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=atuKmN6p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEX2fn027341;
	Mon, 10 Jun 2024 22:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PNzIX1tjJYbFEwvCr4XcvI
	TZ/hsJcmo2otAJAvEuFtc=; b=atuKmN6ph3I4sXZ7mulJiAf8v2zYfFHoxE+fP9
	Q3KcSIyfwj4n9pCnJAE2wERwDsi4FbfF18e0K4dZLcVi6VT8FXYmVkUOUV7Tj53k
	AFzLSNfsGz9xRb1zpwaGIRtfPn68R3y94kP/n2almGZNLcOecrZXL7MX6ktWuXFA
	9HgDlJDAqKfVutySmrItUqIwX3Q6eSn7ibg+Ib0i4vCx9apwq5SF/IvQ5sd9tjOp
	CRUxMssvk++IndmSvzzEc2UWIVrw5nq1Pg7FrWo6SGtxxpXAsygvEJEA5wm9qCBF
	dWAqbJKtsTuD2vrRaoLL+cWVEea29aqk9SDodjoYtg73q/Ew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymevxcteb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 22:56:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AMu0hJ016644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 22:56:00 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 15:56:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 15:55:58 -0700
Subject: [PATCH] nvmem: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240610-md-drivers-nvmem-v1-1-c5d378597cc7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAH6EZ2YC/x3MwQ6CMAyA4VchPdtkgDPgqxgPG6vSxFXT4kJCe
 Hemx+/w/xsYKZPBtdlAqbDxWyraUwPTHORJyKkaOted3aV1mBMm5UJqKCVTRj/GcQje9z4NULO
 P0oPX//J2r47BCKMGmebf6MXyXTEHW0hh3w9XBVTvgQAAAA==
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
	<rafal@milecki.pl>
CC: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dgoPhFNkG5HIQcx3BVcOq7yGQdfnEzE2
X-Proofpoint-GUID: dgoPhFNkG5HIQcx3BVcOq7yGQdfnEzE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100170

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/nvmem/apple-efuses.c | 1 +
 drivers/nvmem/brcm_nvram.c   | 1 +
 drivers/nvmem/u-boot-env.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
index d3d49d22338b..1d1bf84a099f 100644
--- a/drivers/nvmem/apple-efuses.c
+++ b/drivers/nvmem/apple-efuses.c
@@ -78,4 +78,5 @@ static struct platform_driver apple_efuses_driver = {
 module_platform_driver(apple_efuses_driver);
 
 MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple SoC eFuse driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 5cdf339cfbec..3d8c87835f4d 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -253,5 +253,6 @@ static int __init brcm_nvram_init(void)
 subsys_initcall_sync(brcm_nvram_init);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom I/O-mapped NVRAM support driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(of, brcm_nvram_of_match_table);
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index befbab156cda..936e39b20b38 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -249,5 +249,6 @@ static struct platform_driver u_boot_env_driver = {
 module_platform_driver(u_boot_env_driver);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("U-Boot environment variables support module");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-nvmem-59b98a5535d8


