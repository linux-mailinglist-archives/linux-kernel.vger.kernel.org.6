Return-Path: <linux-kernel+bounces-210954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B821D904B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E0A1C231A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6ED39FCF;
	Wed, 12 Jun 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gwnI6Xkm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A61EB45;
	Wed, 12 Jun 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171489; cv=none; b=bfgWNp6fsmUk2sEWSzG9m2Ubq09+zt0Vz0ZcYPxqZcXs4CoMHT0BHHom4hWudTnV24y2NGhUf86T2V00TABkdRoH4qO/LMnYVtCoCpeMUt0tcQ8But41ADbNUjRKPdfWuFUAAYSh6QokoSfUptZrfpKXEp3G7E3hjHKXbKGmBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171489; c=relaxed/simple;
	bh=eSZ4Sy3Bd+LgKQ/b98+H+wFttIGEU7uB3E1BIMCvP/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=T5HIwcvhhiVvOKjNgWY/7Q3XwoFRO4NuhlnHAaYXojHP+V+pdcWOD81+hOJnJT3nwI2BJtHVRHzuNu9WZ1b6iEBd9rsScOfKZBSZAGuk+CXGItMvmU7xBbS9FxvUH5SvfLF3yRwbD5tLhzi4+zqt5+lR4vIL2m/5czwtL0aapc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gwnI6Xkm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BL0gJK013157;
	Wed, 12 Jun 2024 05:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Asvj8P9d0rg7S+Y9Suvlcx
	FTOWajvcFsS63XkgAaQcs=; b=gwnI6Xkm+yhcXJUattorbWIJEMMBxOKi+CSvuO
	x9IxN8RMGhMVMoTy+pdArLvx09skrEfPLaV/khLAcA0zxRGmYMXnzhlkFzbbbTSD
	zF53fxHQxYsiHstm7nN0M0lwb1gzxBaea5+dhs8zRaFaQNVkXXlbRq/LMG5ObX0F
	VgGuvXMaSdHCGphTP8KhLnr287iS9cNOKmrdybzG2ycFeAY+U1l/XvBTRDkMCAMB
	j24h8jdKbBouPDJ164OTN6f1Tz5QuHR8sE6ND5LvY2g1OvGdh7IlkE4LVzgHfp9b
	bjgtoMQMrBydNNsTSf7ZXFjWGPMxYY0NARloKz0dV7NQrbDA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm45aj40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 05:51:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C5p1uH001793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 05:51:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 22:51:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 22:50:58 -0700
Subject: [PATCH] soc: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEE3aWYC/x3MTQ6CQAxA4auQrm0yHQmIVzEu5qdKExlMq4SEc
 HdGl9/ivQ2MVdjg2mygvIjJXCro1EAaQ3kySq4G73zrOiKcMmaVhdXQ5oTUX1yk4Tx0vocavZU
 fsv6Ht3t1DMYYNZQ0/jYvKd8Vp2AfVtj3A080wx5/AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        "Matthias
 Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hemcyYV9GAtAfb0bwsG1uX_Te_dWyefs
X-Proofpoint-ORIG-GUID: hemcyYV9GAtAfb0bwsG1uX_Te_dWyefs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_02,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120040

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/imx/soc-imx8m.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-qmgr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-npe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/mediatek/mtk-cmdq-helper.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/amlogic/meson-clk-measure.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This is the last of the issues that I see in the soc directory
---
 drivers/soc/amlogic/meson-clk-measure.c | 1 +
 drivers/soc/imx/soc-imx8m.c             | 1 +
 drivers/soc/ixp4xx/ixp4xx-npe.c         | 1 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c        | 1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 3f3039600357..a6453ffeb753 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -688,4 +688,5 @@ static struct platform_driver meson_msr_driver = {
 	},
 };
 module_platform_driver(meson_msr_driver);
+MODULE_DESCRIPTION("Amlogic Meson SoC Clock Measure driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index ec87d9d878f3..fe111bae38c8 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -252,4 +252,5 @@ static int __init imx8_soc_init(void)
 	return ret;
 }
 device_initcall(imx8_soc_init);
+MODULE_DESCRIPTION("NXP i.MX8M SoC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index 35825ee95dff..34a6f187c220 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -764,6 +764,7 @@ static struct platform_driver ixp4xx_npe_driver = {
 module_platform_driver(ixp4xx_npe_driver);
 
 MODULE_AUTHOR("Krzysztof Halasa");
+MODULE_DESCRIPTION("Intel IXP4xx Network Processor Engine driver");
 MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(NPE_A_FIRMWARE);
 MODULE_FIRMWARE(NPE_B_FIRMWARE);
diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 244ad8d7e80b..cb112f3643e9 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -465,6 +465,7 @@ static struct platform_driver ixp4xx_qmgr_driver = {
 };
 module_platform_driver(ixp4xx_qmgr_driver);
 
+MODULE_DESCRIPTION("Intel IXP4xx Queue Manager driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Krzysztof Halasa");
 
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 046522664dc1..dd70d4d2bed7 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -526,4 +526,5 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
+MODULE_DESCRIPTION("MediaTek Command Queue (CMDQ) driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-soc-1780b1939627


