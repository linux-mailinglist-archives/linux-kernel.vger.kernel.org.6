Return-Path: <linux-kernel+bounces-225554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD130913217
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBA1F22F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454D1494D5;
	Sat, 22 Jun 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kqV/89UM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AF1494C2;
	Sat, 22 Jun 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033283; cv=none; b=QL8Ev+efq6mjFAP2Qv986Z6U2THCve5wSFdcOjLqK/+bpjAenT5vFpfD/swjc7Vzd20LQxLFqpviHhHXZQ1MYD0m1jyRTcjLMInz0uehJgn/1kOZ1y2zB+75+LkAHZkt6IDJzuvO1xXii2qSAI7pP73z4RknkV/aimYKwslYK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033283; c=relaxed/simple;
	bh=Kc+RLa88gMNDqwCT0XNZP+Etw8F29FOxxQSrex6WpHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E0f3RK5pLM/N5+U+ASlYHm2jx09cV+6FucUvYeM6snNwNQ1f6w46OHi+igixy5fEH2y9QK/Tm/Z4MFWAVCRUv1eqHSV/08Sd436aLSHGKnXlHK+EBH3Lst6EHXBwdC9hOO8My/eTJSMSu3T5/Je/fdhMVMKxjWrxHTi3V7bsGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kqV/89UM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M20da8009993;
	Sat, 22 Jun 2024 05:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LpgiY1T2xyR94KEGJpace7
	s5QMmwxFqU+xjV0/oUM0U=; b=kqV/89UMnfhyKtHbcRpZ4Xch73eErgqZsev/h6
	RIK7+i83CFxrgrIu3MKeOzIS14Bh57dHBs/9/ZLMs6d5xpu1ehuNCVVUqV2J54X8
	Ox0E1ShRfErLlz2FUeh9vENqlg4LoVKG6JATBIjSP/fkxcM4QVC6Ae+32BWffOWB
	utIxrnx0hxGA9ER1RUna/3j3OXivqGer6LKyu1oba+3sAAfmGq3n1dtO4uLZFFTq
	4NP0UoGLl0EMTndOfLQB//srWmjPnv6C1RIYklpA19abf+V/9elIj7UC+hCl/76b
	qqGGo2fIB35R/h4jAPFN+FQWo95JFovdz511IIGOLIL04euw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn08uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 05:14:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45M5EWmD031409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 05:14:32 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 22:14:32 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 21 Jun 2024 22:14:29 -0700
Subject: [PATCH] agp: add remaining missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-md-i386-drivers-char-agp-v1-1-fa03ec5c86ac@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALRddmYC/x3M0QqDMAyF4VeRXC/Qxs3KXmXsotpMA9pJ4kQQ3
 33dLj845z/AWIUN7tUBypuYvHOBv1TQjzEPjJKKgRxdXUMe54RStw0mlY3VsKwU47BgCkTeuVs
 KdYByX5Rfsv/Tj2dxF42x05j78RecJH92nKOtrHCeX4Fy262JAAAA
To: David Airlie <airlied@redhat.com>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ADBUmVQHdNsgoHGcV58XcD_ucv2Nhhc0
X-Proofpoint-GUID: ADBUmVQHdNsgoHGcV58XcD_ucv2Nhhc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_02,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220031

With ARCH=i386, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/ali-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/ati-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/amd-k7-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/efficeon-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/nvidia-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/sworks-agp.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes alpha-agp.c and parisc-agp.c which, although they did
not produce a warning with the i386 allmodconfig configuration, may
cause this warning with other configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/agp/ali-agp.c      | 1 +
 drivers/char/agp/alpha-agp.c    | 1 +
 drivers/char/agp/amd-k7-agp.c   | 1 +
 drivers/char/agp/ati-agp.c      | 1 +
 drivers/char/agp/efficeon-agp.c | 1 +
 drivers/char/agp/nvidia-agp.c   | 1 +
 drivers/char/agp/parisc-agp.c   | 1 +
 drivers/char/agp/sworks-agp.c   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
index 760d9a931289..2eaab502ec29 100644
--- a/drivers/char/agp/ali-agp.c
+++ b/drivers/char/agp/ali-agp.c
@@ -418,5 +418,6 @@ module_init(agp_ali_init);
 module_exit(agp_ali_cleanup);
 
 MODULE_AUTHOR("Dave Jones");
+MODULE_DESCRIPTION("ALi AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
 
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index f0d0c044731c..e1763ecb8111 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -217,4 +217,5 @@ module_init(agp_alpha_core_init);
 module_exit(agp_alpha_core_cleanup);
 
 MODULE_AUTHOR("Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>");
+MODULE_DESCRIPTION("Alpha AGP support");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 55397ba765d2..795c8c9ff680 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -549,4 +549,5 @@ static void __exit agp_amdk7_cleanup(void)
 module_init(agp_amdk7_init);
 module_exit(agp_amdk7_cleanup);
 
+MODULE_DESCRIPTION("AMD K7 AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index 3c1fce48aabe..f7871afe08cf 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -572,5 +572,6 @@ module_init(agp_ati_init);
 module_exit(agp_ati_cleanup);
 
 MODULE_AUTHOR("Dave Jones");
+MODULE_DESCRIPTION("ATi AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
 
diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index f28d42319269..0d25bbdc7e6a 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -465,4 +465,5 @@ module_init(agp_efficeon_init);
 module_exit(agp_efficeon_cleanup);
 
 MODULE_AUTHOR("Carlos Puchol <cpglinux@puchol.com>");
+MODULE_DESCRIPTION("Transmeta's Efficeon AGPGART driver");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index dbcbc06cc202..e424360fb4a1 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -462,6 +462,7 @@ static void __exit agp_nvidia_cleanup(void)
 module_init(agp_nvidia_init);
 module_exit(agp_nvidia_cleanup);
 
+MODULE_DESCRIPTION("Nvidia AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
 MODULE_AUTHOR("NVIDIA Corporation");
 
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index edbc4d338117..93a48070b2a1 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -432,4 +432,5 @@ parisc_agp_init(void)
 module_init(parisc_agp_init);
 
 MODULE_AUTHOR("Kyle McMartin <kyle@parisc-linux.org>");
+MODULE_DESCRIPTION("HP Quicksilver AGP GART routines");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index b91da5998dd7..0ab7562d17c9 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -564,5 +564,6 @@ static void __exit agp_serverworks_cleanup(void)
 module_init(agp_serverworks_init);
 module_exit(agp_serverworks_cleanup);
 
+MODULE_DESCRIPTION("Serverworks AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
 

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240621-md-i386-drivers-char-agp-d7221005d737


