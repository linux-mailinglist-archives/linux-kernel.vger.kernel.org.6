Return-Path: <linux-kernel+bounces-188082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D68CDCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E711F24E84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445C128383;
	Thu, 23 May 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bgRHcyjs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA77E766;
	Thu, 23 May 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503949; cv=none; b=EjI+2yiij1tKkYpwAsa9vsMneuUoGDRTv2GIZWZV5tXOvfMEkis2o2BspaseKF36SWsuxECtEX8T3iq6JUwx9oADrH66bZmaF0lVJde9xqf9yYdwvsQbORoAf9IKidDP9hWw3edHS+IP1djGw+SVaIkyrl2FbAh5JJlEe5/wGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503949; c=relaxed/simple;
	bh=pnbF9bbWu3CYe1fqPSxNRmank0cVx5cpuMcSN1/JeK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=buKp7QGWNdN+ffVnLm8QjVO/xJKgHOc+r37UN8PW8zTkJwS1QzOQQAV6YhzkSu2BsZ4Pu0VLMxPWxNRSC27Zb1cI3YefIjJkjNAhQJluPQvGp2lvZWCpq/unTS1wt+8uNJe4iLgVdCWyxGZ9xm9WvAh/HWM4ACmdrCFlBDDYnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bgRHcyjs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NHafiW026662;
	Thu, 23 May 2024 22:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5oDcmIuni4HOcVlebVG0Ak
	wbpA2Qbg0h6ew16BKwo7o=; b=bgRHcyjsNxvyewnRo3qBPjrtkAEORAKm9BdEG2
	dRnZWHSscg6l0j47yDXgkyzxTS4VdWf3P412DTkDRh6xzUsaVaCwjoSeA8VqppQQ
	Fl+Kn3l19O6lD1gUUNVOIbCu08tzbmAcejdvygBNh+BdQo60mp2X79oN5F1Fnw71
	UlSlI3bU2ci0CXGUWwu/wmzLU0Je0nP5+buI3IdXfJJa8rVasKn/lkvjHNLBiI9q
	BzyejY8rQEhE11Xpegq3a0qnTy1RMFBY/3jTBKawNgryySH4GqqpZYumEvyA+RiT
	Y+9NAm8hzn8l/DcQSo+ZiHBgoSEjDHkYYqphjsX5v0mcAEog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaabq0jhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 22:39:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NMd3In027845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 22:39:03 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 15:39:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 23 May 2024 15:39:03 -0700
Subject: [PATCH] uio: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-md-drivers-uio-v1-1-3ae9ea481670@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIbFT2YC/x3MQQqDQAyF4atI1g3oaC32KqWL6KQaqKMkKhbx7
 k27/OC9/wBjFTa4Zwcob2IyJUdxyaAbKPWMEt0Q8lDl11DiGDGqbKyGq0zYlKG5VVxQoBr8NCu
 /ZP8HH093S8bYKqVu+GXektYdR7KFFeePT+E8v8Rzjy+FAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sDGY7mxRLWoiQfS64EPDu8asiQi9dyMz
X-Proofpoint-ORIG-GUID: sDGY7mxRLWoiQfS64EPDu8asiQi9dyMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_13,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405230156

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_netx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_pruss.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_mf624.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/uio/uio.c       | 1 +
 drivers/uio/uio_aec.c   | 1 +
 drivers/uio/uio_cif.c   | 1 +
 drivers/uio/uio_mf624.c | 3 ++-
 drivers/uio/uio_netx.c  | 1 +
 drivers/uio/uio_pruss.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 009158fef2a8..7f041433293d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1131,4 +1131,5 @@ static void __exit uio_exit(void)
 
 module_init(uio_init)
 module_exit(uio_exit)
+MODULE_DESCRIPTION("Userspace IO core module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/uio/uio_aec.c b/drivers/uio/uio_aec.c
index 64eafd59e6e7..8c164e51ff9e 100644
--- a/drivers/uio/uio_aec.c
+++ b/drivers/uio/uio_aec.c
@@ -144,4 +144,5 @@ static struct pci_driver pci_driver = {
 };
 
 module_pci_driver(pci_driver);
+MODULE_DESCRIPTION("Adrienne Electronics Corp time code PCI device");
 MODULE_LICENSE("GPL");
diff --git a/drivers/uio/uio_cif.c b/drivers/uio/uio_cif.c
index 653f842a1491..1cc3b8b5a345 100644
--- a/drivers/uio/uio_cif.c
+++ b/drivers/uio/uio_cif.c
@@ -130,5 +130,6 @@ static struct pci_driver hilscher_pci_driver = {
 
 module_pci_driver(hilscher_pci_driver);
 MODULE_DEVICE_TABLE(pci, hilscher_pci_ids);
+MODULE_DESCRIPTION("UIO Hilscher CIF card driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hans J. Koch, Benedikt Spranger");
diff --git a/drivers/uio/uio_mf624.c b/drivers/uio/uio_mf624.c
index 5065c6a073a8..790412f8dfd5 100644
--- a/drivers/uio/uio_mf624.c
+++ b/drivers/uio/uio_mf624.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * UIO driver fo Humusoft MF624 DAQ card.
+ * UIO driver for Humusoft MF624 DAQ card.
  * Copyright (C) 2011 Rostislav Lisovy <lisovy@gmail.com>,
  *                    Czech Technical University in Prague
  */
@@ -221,5 +221,6 @@ static struct pci_driver mf624_pci_driver = {
 MODULE_DEVICE_TABLE(pci, mf624_pci_id);
 
 module_pci_driver(mf624_pci_driver);
+MODULE_DESCRIPTION("UIO driver for Humusoft MF624 DAQ card");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rostislav Lisovy <lisovy@gmail.com>");
diff --git a/drivers/uio/uio_netx.c b/drivers/uio/uio_netx.c
index 2319d6de8d04..a1a58802c793 100644
--- a/drivers/uio/uio_netx.c
+++ b/drivers/uio/uio_netx.c
@@ -170,5 +170,6 @@ static struct pci_driver netx_pci_driver = {
 
 module_pci_driver(netx_pci_driver);
 MODULE_DEVICE_TABLE(pci, netx_pci_ids);
+MODULE_DESCRIPTION("UIO driver for Hilscher NetX based fieldbus cards");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hans J. Koch, Manuel Traut");
diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index f67881cba645..c1d6f29cdbc3 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -249,6 +249,7 @@ static struct platform_driver pruss_driver = {
 
 module_platform_driver(pruss_driver);
 
+MODULE_DESCRIPTION("Programmable Real-Time Unit Sub System (PRUSS) UIO driver (uio_pruss)");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR("Amit Chatterjee <amit.chatterjee@ti.com>");

---
base-commit: 5c4069234f68372e80e4edfcce260e81fd9da007
change-id: 20240523-md-drivers-uio-932974e1a2a6


