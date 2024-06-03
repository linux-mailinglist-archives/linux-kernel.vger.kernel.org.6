Return-Path: <linux-kernel+bounces-199381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C68D8652
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FF282C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F2131BDD;
	Mon,  3 Jun 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BJLC6ASq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BC320D;
	Mon,  3 Jun 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429517; cv=none; b=DWDYkUN9eWhTWVguRvBEHNioG95Ki3tXcbM/FCTVtY2msK2NCT4MCCMoyLdh1LFfE6GrISQrqjfmSPenvmdnPd7l74AuFg5J28AabzA4CcWxwfk0Rap9XEpEjJX1AC8wSulZK/A2G9CUcoI/5b18Fw2dKV0IxJjZfRFKtDocyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429517; c=relaxed/simple;
	bh=muqDbPKeiipSY6oszhV00qRfruj4/IQ0162hxp/gbLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E8uB/Xuc9GQ4c0yjONXcaDdPjIBu3qg9xaDLBcAhY2ocYriEY8SrDE7NaMasWjk1v3TcPiQoSo0b8cmL5x3zgUioRnAzJ7lrIcnHmF4GEad2DjJDGdKl1l+fndsLIqhD8O+UPnso30NzMPmmwwBPV4g/BEg0Sqp3cL0kvuDvd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BJLC6ASq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4539tpHs020306;
	Mon, 3 Jun 2024 15:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UXiGIEaAi12+29+yq0qxkR
	YcqOkKnufMJtw3E+mjJko=; b=BJLC6ASqt0LldjI854YmDXgqUX8CppNndbhipR
	fDmui6KCCV5pzTwesSMrJy5feW++0fCthpuxx0Al8rznBCVvvJqkbI6tta3M4lGa
	CgIbUoxr9mN6qG3uPpP5zx3cWZw0qb5sJz2kr73PUdkL5YaU9M3CbcsTp82t+zYs
	8nkPJqCnerSQsWIp4NRNOqDcg9CHVp6S7JMIA8IbSg2u8tNxFDXT7hvN4VsjIWzU
	dlIz1f3lWKVahaGOE+2FBuo72lGReX6fl7CfsOAU+s3SgtzgUXTLG+mFkCgMCbp9
	yvkfBRoj9gn66wI4ATBjklpLMteggl2WCj9FMFm4S9IKPOew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4amk98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 15:45:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453Fj9dC028861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 15:45:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 08:45:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 08:45:08 -0700
Subject: [PATCH] regmap: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-base-regmap-v1-1-ff7a2e5f990f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAPlXWYC/x3M0QqDMAyF4VeRXC9Qq4zhqwwv0jZqwHaSbEMQ3
 32dlx+c8x9grMIGQ3OA8ldMXqWivTUQFyozo6Rq8M737u46zAkDGaPynGnDyD5M1D1Cij3U06Y
 8yX4Fn2P1tQ1KJS7/zCrls2Mme7PCef4A2WDBPn8AAAA=
To: Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i_oT2KCwy9S1WeYKXM8zP1gB6sH8S1Nh
X-Proofpoint-ORIG-GUID: i_oT2KCwy9S1WeYKXM8zP1gB6sH8S1Nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030131

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ac97.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spmi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-sccb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi-avmm.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/base/regmap/regmap-ac97.c     | 1 +
 drivers/base/regmap/regmap-ram.c      | 1 +
 drivers/base/regmap/regmap-raw-ram.c  | 1 +
 drivers/base/regmap/regmap-sccb.c     | 1 +
 drivers/base/regmap/regmap-slimbus.c  | 1 +
 drivers/base/regmap/regmap-spi-avmm.c | 1 +
 drivers/base/regmap/regmap-spmi.c     | 1 +
 drivers/base/regmap/regmap-w1.c       | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/base/regmap/regmap-ac97.c b/drivers/base/regmap/regmap-ac97.c
index b9f76bdf74a9..a561971c459c 100644
--- a/drivers/base/regmap/regmap-ac97.c
+++ b/drivers/base/regmap/regmap-ac97.c
@@ -86,4 +86,5 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_ac97);
 
+MODULE_DESCRIPTION("Register map access API - AC'97 support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-ram.c b/drivers/base/regmap/regmap-ram.c
index 5b4cbf982a11..4e5b4518ce4d 100644
--- a/drivers/base/regmap/regmap-ram.c
+++ b/drivers/base/regmap/regmap-ram.c
@@ -83,4 +83,5 @@ struct regmap *__regmap_init_ram(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__regmap_init_ram);
 
+MODULE_DESCRIPTION("Register map access API - Memory region");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-raw-ram.c b/drivers/base/regmap/regmap-raw-ram.c
index 69eabfb89eda..76c98814fb8a 100644
--- a/drivers/base/regmap/regmap-raw-ram.c
+++ b/drivers/base/regmap/regmap-raw-ram.c
@@ -142,4 +142,5 @@ struct regmap *__regmap_init_raw_ram(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__regmap_init_raw_ram);
 
+MODULE_DESCRIPTION("Register map access API - Memory region with raw access");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
index 986af26d88c2..12bbbb03e5f2 100644
--- a/drivers/base/regmap/regmap-sccb.c
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -125,4 +125,5 @@ struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sccb);
 
+MODULE_DESCRIPTION("Register map access API - SCCB support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 8075db788b39..54eb7d227cf4 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -68,4 +68,5 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
 
+MODULE_DESCRIPTION("Register map access API - SLIMbus support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 4c2b94b3e30b..d86a06cadcdb 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -710,4 +710,5 @@ struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spi_avmm);
 
+MODULE_DESCRIPTION("Register map access API - SPI AVMM support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-spmi.c b/drivers/base/regmap/regmap-spmi.c
index cdf12d2aa3a1..347bfe9544ce 100644
--- a/drivers/base/regmap/regmap-spmi.c
+++ b/drivers/base/regmap/regmap-spmi.c
@@ -222,4 +222,5 @@ struct regmap *__devm_regmap_init_spmi_ext(struct spmi_device *sdev,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spmi_ext);
 
+MODULE_DESCRIPTION("Register map access API - SPMI support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index 3a8b402db852..29fd24f9c7ed 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -234,4 +234,5 @@ struct regmap *__devm_regmap_init_w1(struct device *w1_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_w1);
 
+MODULE_DESCRIPTION("Register map access API - W1 (1-Wire) support");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-base-regmap-ce2bfa38bdc4


