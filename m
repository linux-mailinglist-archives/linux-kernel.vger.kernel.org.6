Return-Path: <linux-kernel+bounces-188206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C528CDF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0201C2174C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CB101C8;
	Fri, 24 May 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AuNceffK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE36FBF;
	Fri, 24 May 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514241; cv=none; b=laBQ4eiXFGCxVc6lO8SPs0+DQQyEVDQ96Pz9e1ZyE8n/QW2SgBirFXyHX3v1PyXWZCS/A05hNBdnv/mOKbrII+4qhGhniqGg7rDshftB4CGisrv0FQkNOSONviD/XiwEiacu0IXY2bG1Nc3LCcBc9WUUFRVrjsNxylUMLKAAPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514241; c=relaxed/simple;
	bh=dU2hI2zA2JICwThCLKeqzbQwMpoJ/Z1eYaVQWAplIRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=oOz4AWqxLVn4Z+YxjcpjEfdxPAaHmjIR8AemKqgSlXAuEo1wmM25HQo+ope69WsHe8oKbGZt9/tWZ2umwD6pJ7hlu4vTt9dNOKNZz5mnoqOFR4gzZatTnGHo0pST0YOq+6ZoMZEaxaXNEP2t2XPk/4s6iNnTdBB5bMQ7R6HtkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AuNceffK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNPCoI021766;
	Fri, 24 May 2024 01:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LAWF4zplhYSx4zd5iX5CAB
	WJ+6G7OSH8UR2PtNJwENU=; b=AuNceffKK9/Vjk0NqRmyb3yqqYBW2EdiPEdipX
	YDtMUJgMDf6ozC9UwP8w7UAa+zsn5LVK3fkp6mgAwK/3T6rO2EPGLczKp8peU3Y5
	5f95AbwC+ZNaOX6JEksKtM3CC76nKMpGnvLblrP8aFQhZuWpwVHgA0iJoY4DKnYm
	C0kXmhI83vFd7A7J61029LDl6+XUqd6I1x9OyaFUfrN5fjT53rUifYlbrUDsHXbi
	TGaj+KQ7BVN6sjuC7Aoc1i74xau/eO3jZbXjZqy8Rhr0T2Dp3zXOFDiAknwluZw2
	KCVxUdaRbW+2b21rY3sack1rV7QibbXffgc6WMycsbgySdfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa9u0ue0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 01:30:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O1Uaib006571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 01:30:36 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 18:30:36 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 23 May 2024 18:30:35 -0700
Subject: [PATCH v2] uio: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-md-drivers-uio-v2-1-5173b2ae9563@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALrtT2YC/3WOwQ6CMBBEf8X07BpaEMST/2E4LGWVTaTFLRAI4
 d8t3D2+ZN7MrCqQMAV1P61KaOLA3kUw55OyLbo3ATeRlUlMllxNCl0DjfBEEmBkD2VqyiIjjQZ
 zFaVe6MXzUfisItcYCGpBZ9u95sNunKHDMJBAv8ToLrUcBi/LcWLSu/p3b9KgIUUqCbObzovk8
 R3ZsrMX6ztVbdv2A0RkWLDTAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4fQ04ne4i3yTwL6OYKUfq2ZQTY9XiUtO
X-Proofpoint-ORIG-GUID: 4fQ04ne4i3yTwL6OYKUfq2ZQTY9XiUtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_14,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240008

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_cif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_aec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_netx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_mf624.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Removed change to now deleted drivers/uio/uio_pruss.c
  (see https://lore.kernel.org/all/20240410144803.126831-1-afd@ti.com/)
- Link to v1: https://lore.kernel.org/r/20240523-md-drivers-uio-v1-1-3ae9ea481670@quicinc.com
---
 drivers/uio/uio.c       | 1 +
 drivers/uio/uio_aec.c   | 1 +
 drivers/uio/uio_cif.c   | 1 +
 drivers/uio/uio_mf624.c | 3 ++-
 drivers/uio/uio_netx.c  | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5ce429286ab0..20d2a55cb40b 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1145,4 +1145,5 @@ static void __exit uio_exit(void)
 
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

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240523-md-drivers-uio-932974e1a2a6


