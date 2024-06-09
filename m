Return-Path: <linux-kernel+bounces-207255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C949014B0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5181C20B48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBF17565;
	Sun,  9 Jun 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="REvMC6+8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479F290F;
	Sun,  9 Jun 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717913835; cv=none; b=RF4jfHrzy+s7Nr3ku24A/KfzkUpRonj0oc6RrGXRfW+t6tHhfJ8ukGrq4Ie6xWUga4tYSlqzSetc5lKo4qhfrlPAYk+iCgYD3Cs8WuDsVlpSD0D9MDv6wwr6zo10nvPzlOjj4Ghr6aeUgtvSjfhYY7p+4GDhHWOQna6DgyJ0Wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717913835; c=relaxed/simple;
	bh=JTu24wGDbSfGoMVKiiOmero5RMISlRfRvaSJB4S8/lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IdQ+wpcAIqkuaTnLUVvwkWJCLxrrZSObt0tcNEa+tVAUpqE6hLC1UN3fdMTG+PYF9SljQrpFxnWs8vzZkRwiHt4CaU1BUx79BV8NxJCfz1lzOIGdI9NhGO4usJWvrYS+iqGI4QiwkKIibc4R9kNvB+4q/A37/hkpS0uTh5reil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=REvMC6+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4595u0D9004094;
	Sun, 9 Jun 2024 06:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bW8kQ1TPwFqdhyEwZwxXgH
	v4hINaS1vaK6f7UDDjVkI=; b=REvMC6+8OXwv+cN2u6TeqGQEWSgqfVAP4HCXP8
	B9cxFKR5o/qx6hXP0+vb25q7jF7iXU+ObyoBWTnOtqtuI9iMiWkTF+ORoduPxLj6
	UXpKm9EpkPGIZoURLbY/FTnAH/0XXEvF/MbwnmnoY+4ki6wlDnV8jcln2WsEgbQo
	Gno58Qhs8wmiNs+UBBqw+wG3nKdhXqNpw7pyXpo77QDaGZhxbUDXzIn5h1iJB7Vs
	nHMGInAKj4MPaGF78SIrTi3nB6Nh1VWQiekSrgxwtXdMtXAhnhMJACHyMDgsVc7m
	EPUVhAnq2sq4W9MGkxf+Dif2vV4tPZBG8LcojTEpcYvzQMbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymemghcs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 06:17:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4596H6kH004243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 06:17:06 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 8 Jun 2024
 23:17:06 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 8 Jun 2024 23:17:05 -0700
Subject: [PATCH] phy: broadcom: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240608-md-drivers-phy-broadcom-v1-1-f070f84cc3f0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOBIZWYC/x3M3QrCMAyG4VsZOTZQ57+3Ih6kbWoDthuJjsnYv
 Vs9fOD73gWMVdjg2i2gPInJUBu2mw5CpvpglNgMvev37ujOWCJGlYnVcMwf9DpQDENB8nRJh+R
 3IZ6gvUflJPO/fLs3ezJua6oh/3pPqe8ZC9mLFdb1C66z+yeIAAAA
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4rvzFQruU4QguwQNpQtmujsfwcGMBDMw
X-Proofpoint-ORIG-GUID: 4rvzFQruU4QguwQNpQtmujsfwcGMBDMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_03,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=993
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406090047

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb3.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c | 1 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 269564bdf687..5213c75b6da6 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -162,4 +162,5 @@ static struct platform_driver bcm_ns_usb2_driver = {
 };
 module_platform_driver(bcm_ns_usb2_driver);
 
+MODULE_DESCRIPTION("Broadcom Northstar USB 2.0 PHY Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 2c8b1b7dda5b..9f995e156f75 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -240,5 +240,6 @@ static struct mdio_driver bcm_ns_usb3_mdio_driver = {
 
 mdio_module_driver(bcm_ns_usb3_mdio_driver);
 
+MODULE_DESCRIPTION("Broadcom Northstar USB 3.0 PHY Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, bcm_ns_usb3_id_table);

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-phy-broadcom-aba9f5fb3cd7


