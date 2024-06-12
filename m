Return-Path: <linux-kernel+bounces-210906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D899049F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E621C230E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96325622;
	Wed, 12 Jun 2024 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cxi9IGSI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5571208AF;
	Wed, 12 Jun 2024 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166409; cv=none; b=Vfjb/UJooMHd496k85eZM+b/yD5vQm/cciOOY77E3wC/LjqRUceSOwCMqix5YIxI7qBW/6WOgfNG+VIQkHTpZwtc18orJKUdj+kprlZz5y0ZvneV/4QfT/ymz8M1JwsQRWoA/lRkuFQs3BjzqYd+9P0kHxzL4+BkP47WNW8JV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166409; c=relaxed/simple;
	bh=Wb1KqxF48uGDnhR9pYhRPTClWOE2cIsLIRZ+lwkgF/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZRbwWbX9c9OrxUMkj4UB1iXOejPQidIw0eOrzhxgntoXE8AXvwuPOGLFzkHymtzpJwizwfIB4B4O69y9gwUCRcBFJO5QCFqQE2IteuDWtTHugvfkZCmn9z2MluCtzcD0eTrPAjAYKrGPEmb9FO2SmboIph3ApXVEi85bHDbpjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cxi9IGSI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BItrvZ013278;
	Wed, 12 Jun 2024 04:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I+aDBYBh4TTYcKzX/Ar7nw
	R5Fhbs6R4VLgGoKwD1YHY=; b=Cxi9IGSIf7UXYQ7nT9dy3TnOJ8ytCj4ngfeswq
	US+Trdwi3hPzcJ2mfDMTlqK6X+K66o9DTx9c+g/3G2NSTn3gDMzmOf8dJ4g599sU
	UTS/BE89s8uKgd5QC5D2RxxIlM9mbWJVQhH6/kSU+A54cyBCMuwu1HtE2gdPJekf
	S/hlqS0X9fFggQF9OWNhP/uvHT22Bp8fF4YJOr9s1GgC5Ciw64n3O19aPBGTg4BA
	EBmnLRhS/CvD4HToDSYYTJmeJIXMopPQ1ve//VcJR50rlyBgtisrwtD4bqqx6ks0
	1yxwvBazae+fmr+JwprEtYLYRCte8JDiNdUQwaj9OeEtpQ7w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm45acvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:26:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C4PwIg004981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:25:58 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 21:25:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 21:25:56 -0700
Subject: [PATCH] platform/x86/siemens: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-platform-x86-siemens-v1-1-b399d7d6ae64@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFMjaWYC/x3NQQqDMBBA0avIrDuQBLG1VyldxGSsAybKjEpAv
 HvTLt/m/xOUhEnh2ZwgdLDykivsrYEw+fwh5FgNzrjWdNZiihiFDxLFdfbbuEjC8uhQmRJlxZ7
 uwZmhD961UCur0Mjlf3i9qwevhIP4HKZfd+a8F0xeNxK4ri8ThIqXkAAAAA==
To: Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Xing Tong Wu
	<xingtong.wu@siemens.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ZP6ygviFXY3gvGjl2jlGXu7Ft-ub20Q
X-Proofpoint-ORIG-GUID: 8ZP6ygviFXY3gvGjl2jlGXu7Ft-ub20Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_01,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120029

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c  | 1 +
 drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c | 1 +
 drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c      | 1 +
 drivers/platform/x86/siemens/simatic-ipc-batt.c             | 1 +
 drivers/platform/x86/siemens/simatic-ipc.c                  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
index 31a139d87d9a..5edc294de6e4 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
@@ -45,6 +45,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
 
 module_platform_driver(simatic_ipc_batt_driver);
 
+MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Apollo Lake GPIO");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
 MODULE_SOFTDEP("pre: simatic-ipc-batt platform:apollolake-pinctrl");
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
index a7676f224075..e6a56d14b505 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
@@ -45,6 +45,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
 
 module_platform_driver(simatic_ipc_batt_driver);
 
+MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Elkhart Lake GPIO");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
 MODULE_SOFTDEP("pre: simatic-ipc-batt platform:elkhartlake-pinctrl");
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
index 5e77e05fdb5d..f8849d0e48a8 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
@@ -81,6 +81,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
 
 module_platform_driver(simatic_ipc_batt_driver);
 
+MODULE_DESCRIPTION("CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
 MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl platform:alderlake-pinctrl");
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index c6dd263b4ee3..d9aff10608cf 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -247,6 +247,7 @@ static struct platform_driver simatic_ipc_batt_driver = {
 
 module_platform_driver(simatic_ipc_batt_driver);
 
+MODULE_DESCRIPTION("CMOS core battery driver for Siemens Simatic IPCs");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
 MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 8ca6e277fa03..7039874d8f11 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -231,6 +231,7 @@ static void __exit simatic_ipc_exit_module(void)
 module_init(simatic_ipc_init_module);
 module_exit(simatic_ipc_exit_module);
 
+MODULE_DESCRIPTION("Siemens SIMATIC IPC platform driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Gerd Haeussler <gerd.haeussler.ext@siemens.com>");
 MODULE_ALIAS("dmi:*:svnSIEMENSAG:*");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-platform-x86-siemens-9e7c20b9ca24


