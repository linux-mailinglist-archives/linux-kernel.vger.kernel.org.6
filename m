Return-Path: <linux-kernel+bounces-208367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A890241B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949D71C21CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DB12F5BF;
	Mon, 10 Jun 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="px2kz3Pu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2938FB0;
	Mon, 10 Jun 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029872; cv=none; b=SGOEfHdd8EsfG2qqwqecLlpKAM7EGuh4/QWXIVbE3V7K6GR7kaQmm6adNDPRYCKq+j3bL/fw+YKj9bbKNGTNhMwfxP+btt8kIhU0m3/Iznsi9xHqsRagOlaEJp3NeJBV5t5z1UelH3Qfl/hWXMVFePuZQUth5OB433Hv42VCDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029872; c=relaxed/simple;
	bh=P6pSkLFmuW0973Npk9d7Ss4E+eZ2nLnR94446ttggfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=DhJ8WxCBht1SiHjCvTk+QCp32tQkJvGJVGUnm8RgKMYP8vP0RlsWTgO0/aLIN8WTIxLDTf9jwOujdi3vSArnQAPp8zMsppClQEowd+IBwS9+iHfoMoRHMaYukU8VkycS6ql9Ygz+7HEruHLN57NMYmCd3rJuYLmaynBnfhWdnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=px2kz3Pu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A3ObUo002331;
	Mon, 10 Jun 2024 14:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AN+bJArvlluW9QbbgJ9AEw
	/BRBIY3WiR+W6cC4f0kmg=; b=px2kz3PuiQR7yx8iPAQahrOIQb2Y7kDqFNCvjy
	KE8p5YroMPK3pk9PW7f1CuPq0qVmkCgQyByiCKMzjSzLK5jr6ShBvkJvCmWRHw+v
	NsyQZl52Jgq65WoYfRgJBTTUCpt8GIgzpVXqShEwqJhh7tzaKD4HuePRovPyyGzc
	3ndZ+OKj2i7bZh2y2ArqiPIAGZ7QvAllpl180ONSSKh58vSSWZ4+h2j6GKIwlT5Q
	G/Qbz6pngvniBOrCw4HRQOqbI9R2V7hF6swn7PvORpS6lB/AcmIQiA/lLcoJZ0Fz
	FO+IaxufYvxIZqWdom6qylh8IZ6qCP/9MJCFKv42vefzzlgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfcv3twy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:30:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AEUrqM016360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:30:53 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 07:30:51 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 07:30:51 -0700
Subject: [PATCH v2] regulator: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-regulator-v2-1-cf39106d7e54@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABoOZ2YC/4WOQQ6CMBBFr2K6dkxbpBJX3sOwKO0Ik0DRKTQYw
 t0tXMDlS/5//68iIhNGcT+tgjFRpDFk0OeTcJ0NLQL5zEJLfZVGVjB48EwJOQJjO/d2Ghm0LrQ
 qvZWojMjVN+OLlkP7rDM3NiI0bIPrdllPYV5gsHFC3uMdxWz5HieS2kt/9pICBd4WRWVM6Zubf
 XxmchTcxY2DqLdt+wEM/mkR2QAAAA==
To: Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E3Wwpvl10ESoM1_ljdFCjLqZ1FuzpV9b
X-Proofpoint-GUID: E3Wwpvl10ESoM1_ljdFCjLqZ1FuzpV9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=998 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100110

On x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/da9121-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Removed drivers/regulator/mtk-dvfsrc-regulator.c from the patch and updated
  the patch description to remove the mention of this file
- Fixed the drivers/regulator/rt4831-regulator.c description
- Link to v1: https://lore.kernel.org/r/20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com
---
 drivers/regulator/da9121-regulator.c   | 1 +
 drivers/regulator/max20411-regulator.c | 1 +
 drivers/regulator/rt4831-regulator.c   | 1 +
 drivers/regulator/tps6286x-regulator.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 96257551bb12..3571b6242e3a 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1192,4 +1192,5 @@ static struct i2c_driver da9121_regulator_driver = {
 
 module_i2c_driver(da9121_regulator_driver);
 
+MODULE_DESCRIPTION("Dialog Semiconductor DA9121/DA9122/DA9220/DA9217/DA9130/DA9131/DA9132 regulator driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index 8c09dc71b16d..6614e767072f 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -161,4 +161,5 @@ static struct i2c_driver max20411_i2c_driver = {
 };
 module_i2c_driver(max20411_i2c_driver);
 
+MODULE_DESCRIPTION("Maxim MAX20411 High-Efficiency Single Step-Down Converter driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index 97e6f7e2a0ba..dfc868a24056 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -202,4 +202,5 @@ static struct platform_driver rt4831_regulator_driver = {
 module_platform_driver(rt4831_regulator_driver);
 
 MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT4831 DSV Regulators driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 758c70269653..65d0a5a145bd 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -156,4 +156,5 @@ static struct i2c_driver tps6286x_regulator_driver = {
 
 module_i2c_driver(tps6286x_regulator_driver);
 
+MODULE_DESCRIPTION("TI TPS6286x Power Regulator driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-regulator-223215da0e16


