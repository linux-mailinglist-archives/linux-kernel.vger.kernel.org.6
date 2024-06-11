Return-Path: <linux-kernel+bounces-210713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F99047CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCF4284D06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677FF156255;
	Tue, 11 Jun 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e4TLos3d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41C155A5C;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150058; cv=none; b=h8+LsxasnuK0iJrYOhbCw88YIJ5zbqePtrEynLxSsS4Gis3Aj7iusu2/K/oWfnThFTiQIw1HilmqfOzg65YnhSUwQtD/+P7R/lKzwuafrCBR3AUTfVLi+mjUCtJP5Ob8cNGhWWAfC2AdZqiz280p7dMz++0zFDZz+LTiZBDtxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150058; c=relaxed/simple;
	bh=U+HJzVqm3PDjXmyP9XmJ4A4lD0uZ4jNu/vnAUFtrs+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=i7LSq3UmMPP+iEEtPjjDLgxFgBbGgyNYIadUklMQACcOkUwcSrJHvLNN9WcrGQXxjhfsZZpRvER4H7fEkEy4z+Mh6cH1G+7vx24BQUrctCG9IT7bO86QUbwJqIvImsj46VN1mUkyfZmoPYnwrDDR/AU6RkNxWjDI3XGtRHJw2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e4TLos3d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BBa1Zo008217;
	Tue, 11 Jun 2024 23:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0Y4GBa+TXFeSS85sJfdH9J
	Pc3l5l71wn18Ou06XOFkE=; b=e4TLos3dK/YG8S+9jMfoo4Wu+sKGwfLL4fKyS0
	xiEXEYx43KDh9ay6ggX33lNeVg28igFxu4fUTQAZvQVmgwiBy0kn4F56a/FQg0Rx
	inxz72fZKXyRAvETnJDyzm2JR6M8j8DjKgCkUBTWwA/PFphcnsrUw/qI3gMk0Okm
	Et9HdGp4QNmllsaHDj+xp7juIvfMgwK5tADIZhw4Vsw72eH7EQQO52A60s28JtP1
	/xa2YAbW7mskRvXdrSyGva+1+lOhKxy/UGof3JXoyGFH1zt4KhpIrIbSTtTC/aYk
	qWMhE3YiSkFHy/MpZgqrzJk1qBrFGajQlYLwgfRyy1/Wz6+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yme8s08t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 23:54:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BNs6iK022456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 23:54:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 16:54:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 16:54:05 -0700
Subject: [PATCH] xen: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-xen-v1-1-1eb677364ca6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJzjaGYC/x3MywrCMBBG4Vcps3YgCV6KryIu0uSPHbBRZmopl
 L670eW3OGcjgwqMrt1GikVMXrXBHzpKY6wPsORmCi4c3dl7njJnlQVqvKLyKYSSelxQXE8teiu
 KrP/h7d48RAMPGmsaf5un1M/KU7QZSvv+BbPmCuV/AAAA
To: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
	<sstabellini@kernel.org>,
        Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y8hV1AhieqTHTlSwvyJF07qR0S-m50t2
X-Proofpoint-GUID: y8hV1AhieqTHTlSwvyJF07qR0S-m50t2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_12,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110162

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-pciback/xen-pciback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-evtchn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xen-privcmd.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Corrections to these descriptions are welcomed. I'm not an expert in
this code so in most cases I've taken these descriptions directly from
code comments, Kconfig descriptions, or git logs.  History has shown
that in some cases these are originally wrong due to cut-n-paste
errors, and in other cases the drivers have evolved such that the
original information is no longer accurate.
---
 drivers/xen/evtchn.c               | 1 +
 drivers/xen/privcmd-buf.c          | 1 +
 drivers/xen/privcmd.c              | 1 +
 drivers/xen/xen-pciback/pci_stub.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index f6a2216c2c87..9b7fcc7dbb38 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -729,4 +729,5 @@ static void __exit evtchn_cleanup(void)
 module_init(evtchn_init);
 module_exit(evtchn_cleanup);
 
+MODULE_DESCRIPTION("Xen /dev/xen/evtchn device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index 2fa10ca5be14..0f0dad427d7e 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -19,6 +19,7 @@
 
 #include "privcmd.h"
 
+MODULE_DESCRIPTION("Xen Mmap of hypercall buffers");
 MODULE_LICENSE("GPL");
 
 struct privcmd_buf_private {
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 67dfa4778864..b9b784633c01 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -48,6 +48,7 @@
 
 #include "privcmd.h"
 
+MODULE_DESCRIPTION("Xen hypercall passthrough driver");
 MODULE_LICENSE("GPL");
 
 #define PRIV_VMA_LOCKED ((void *)1)
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..4faebbb84999 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1708,5 +1708,6 @@ static void __exit xen_pcibk_cleanup(void)
 module_init(xen_pcibk_init);
 module_exit(xen_pcibk_cleanup);
 
+MODULE_DESCRIPTION("Xen PCI-device stub driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:pci");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-xen-522fc8e7ef08


