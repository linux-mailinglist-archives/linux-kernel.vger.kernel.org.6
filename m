Return-Path: <linux-kernel+bounces-206794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B71900DD9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C91F23C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7215530B;
	Fri,  7 Jun 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxFyrJAH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CF14D45B;
	Fri,  7 Jun 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797788; cv=none; b=sj8AZGkdfL1vVnNqc24aOu/nYXignf3haQQ490/qDJT33NVCiJzPlmVCHgHfVYUikH7hI2PQSeYKsFDjWabIj3Kgntq1tw1A7AgyNjFb63fAPcg9nEDz49FrdHkXB2i3xqdwn1GDODE5mREMq9ZjMDTgQNPZOXSdPKtb+4Rw2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797788; c=relaxed/simple;
	bh=1jRqw3b5jNId4CuyD1hxo3XagfFdcuxOWHFpWmsLHGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=KH3kNrjoSAMXFdSirKtMdD07WfQQ6ATYGpbgU9SujvIEeb5WUXLE3x1n2OZn08f52XjfaGqdyVp2OHt/AUEQKemn7GmAAIugNu2h9FMjgbmOFFI0CPVry8MalHeNIwhQlNSVY6sPnYrhducDObg2PtG4W+uKXW3g2z7UINPcaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxFyrJAH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HaBTk008010;
	Fri, 7 Jun 2024 22:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6peD2aU4S77arzo5+5tyXF
	H/8AWJP9hftjSkGRSgoMI=; b=nxFyrJAHwRLBbximvfL9Ab8hqrsGKqz32HRHpq
	hgko3P6V7RzniCwWkHxrcakrQnwWSCc8C+RwWOF6eCzC37ZfzntZmIYJsSI00ZSj
	pOuQJpknvoofnI1G0Gu/dPMvKvJTUnpODoBkgJqjiLC3XMYJOUhSc1F7G3fVlK3f
	qynAXth/AFnfPdL/r/acN9hozfTzTVpL1TvTGwEbMJx9H9Feo4kRkiFqBp4XcEts
	taUFkpMHXSvWFCQO+C2JpGLd9nV7yivQO07TIE+xLWUmG6vzVfkQaaBNQyPeLyGk
	s43MnPYQM3NDvvlpQQueN+AJg1j7TeVHOSr70spB57PzaJ0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rrwf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 22:03:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457M2xXo007027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 22:02:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 15:02:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 15:02:58 -0700
Subject: [PATCH] pcmcia: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-pcmcia-v1-1-6014889a1324@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJGDY2YC/x3MwQ6CMAyA4VchPdtkTNDoqxgP3VakiZukVUJCe
 HeGx+/w/ysYq7DBvVlBeRaTT6loTw3EkcqLUVI1eOc7d3FXzAmTysxqOMUchbDv3DmEtmc/3KB
 2k/Igy//5eFYHMsagVOJ4nN5Sfgtmsi8rbNsO26ae+oIAAAA=
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MYX96FXRT1MWsCULhV545rRjIhQ6pvA0
X-Proofpoint-ORIG-GUID: MYX96FXRT1MWsCULhV545rRjIhQ6pvA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070163

On x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE(). This includes files which did not
produce a warning with the x86 allmodconfig since they may cause this
warning with other configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/pcmcia/i82092.c         | 1 +
 drivers/pcmcia/i82365.c         | 1 +
 drivers/pcmcia/max1600.c        | 1 +
 drivers/pcmcia/rsrc_mgr.c       | 1 +
 drivers/pcmcia/rsrc_nonstatic.c | 1 +
 drivers/pcmcia/yenta_socket.c   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index a335748bdef5..a947ffb2df55 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -23,6 +23,7 @@
 #include "i82092aa.h"
 #include "i82365.h"
 
+MODULE_DESCRIPTION("Driver for Intel I82092AA PCI-PCMCIA bridge");
 MODULE_LICENSE("GPL");
 
 /* PCI core routines */
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index 891ccea2cccb..86a357837a7b 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1342,5 +1342,6 @@ static void __exit exit_i82365(void)
 
 module_init(init_i82365);
 module_exit(exit_i82365);
+MODULE_DESCRIPTION("Driver for Intel 82365 and compatible PC Card controllers");
 MODULE_LICENSE("Dual MPL/GPL");
 /*====================================================================*/
diff --git a/drivers/pcmcia/max1600.c b/drivers/pcmcia/max1600.c
index 379875a5e7cd..7be9068f6191 100644
--- a/drivers/pcmcia/max1600.c
+++ b/drivers/pcmcia/max1600.c
@@ -119,4 +119,5 @@ int max1600_configure(struct max1600 *m, unsigned int vcc, unsigned int vpp)
 }
 EXPORT_SYMBOL_GPL(max1600_configure);
 
+MODULE_DESCRIPTION("MAX1600 PCMCIA power switch library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pcmcia/rsrc_mgr.c b/drivers/pcmcia/rsrc_mgr.c
index 252893216e50..3168d2a98103 100644
--- a/drivers/pcmcia/rsrc_mgr.c
+++ b/drivers/pcmcia/rsrc_mgr.c
@@ -66,5 +66,6 @@ EXPORT_SYMBOL(pccard_static_ops);
 
 
 MODULE_AUTHOR("David A. Hinds, Dominik Brodowski");
+MODULE_DESCRIPTION("Resource management routines");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("rsrc_nonstatic");
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index bf9d070a4496..84af1a9f3f5d 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -31,6 +31,7 @@
 
 /* moved to rsrc_mgr.c
 MODULE_AUTHOR("David A. Hinds, Dominik Brodowski");
+MODULE_DESCRIPTION("Resource management routines for !SS_CAP_STATIC_MAP sockets");
 MODULE_LICENSE("GPL");
 */
 
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 1365eaa20ff4..f40f3daafd8e 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1452,4 +1452,5 @@ static struct pci_driver yenta_cardbus_driver = {
 
 module_pci_driver(yenta_cardbus_driver);
 
+MODULE_DESCRIPTION("Regular cardbus driver (yenta_socket)");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-pcmcia-5403bb15e2f9


