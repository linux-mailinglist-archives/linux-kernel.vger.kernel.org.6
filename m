Return-Path: <linux-kernel+bounces-210926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE6904A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CD91F25009
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97532CCB4;
	Wed, 12 Jun 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MjU6Avya"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CF2942A;
	Wed, 12 Jun 2024 04:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168214; cv=none; b=FLMcV+7ivEFntSiw7tZ3cajdRswPXcCX5nuvD6VfZ8Eghj9vj9oeiEWRbWBZ0gCalwDNzBqgZK6AFsazpsflOy6VJEhj2v79/Lmd2M9mO8dESm90jAZG8V6Cwge3dPQl0HidkDjWbVaCv1RPe7x5f5OYQY/a7sM+/sFtZqIF6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168214; c=relaxed/simple;
	bh=+y3f0XCIIdC71kMUoGDMfayXg+64qkv5Y51MEHfPVug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TK70G+gSR78o0Ikx10uv3i5ammMvNftbLVzz7DtyhL4rqbAr7UGrvQQzA6bSxqb6rxcLWHL6tF21cch5LcVqno5Kh+iXijXw9YUko8jh90zYGtnZtz04RArFT6axlBCMbT+GmCdb4U1yubeu1B180jPI2ifzm4EIG+1RF8Iru2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MjU6Avya; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C38xQq000767;
	Wed, 12 Jun 2024 04:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Fmd/lsPclsgDKuqepDWQog
	9xD4qcIM/6/BE5wOlWA74=; b=MjU6Avya4291E+WEk0mLpx6e8lEppzNyAN5Uoq
	fd4KAAqt4vn6aNkE9vVIrXT+eDpziRwUA965nl2XSHv9wsWhpEgZWp7akQrCIUl/
	Wd6p2JxiOp2EWH8ZlqvSf4u2FIgMUssaZQAG0mR3av0NaxlM787swv3KvrtdiXDm
	3NAbM6aqpJ1WHChBQKHYQtCUdiSQvxSeFvG//pZ2SVlPVYRazojaucDx/FYZun/X
	QODYYEpcT9Zwdrps/GGFKfaW+Y64TfmB2lMnlj/ALtMeHqyeHGOBNq3UKUtXivQt
	nZz2IPCiuIEMA5KUJuktM0EA2bzQMQoKUvueQimUbszGKUrw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yphsattwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:56:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C4uR6C016874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:56:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 21:56:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 21:56:26 -0700
Subject: [PATCH] platform/x86/intel: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-platform-x86-intel-v1-1-5ed967425b04@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHkqaWYC/x3MwQqDMAwA0F+RnBewpZOxXxk7tJrOgK2SVCmI/
 75ux3d5JygJk8KzO0HoYOU1N5hbB+Ps84eQp2awvXX9YAymCSfhg0RxW3yJqySsjwE5F1rQDNH
 37u4i2QDt2IQi1///ejcHr4RBfB7n37pw3ismr4UErusLxw0YOI4AAAA=
To: Alex Hung <alexhung@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rajneesh
 Bhardwaj" <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RyZu6yvN0o_egJaau_METTk_X-bMyZt4
X-Proofpoint-GUID: RyZu6yvN0o_egJaau_METTk_X-bMyZt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_01,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406120033

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/pmc/intel_pmc_core_pltdrv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-vbtn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-rst.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/intel-smartconnect.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/platform/x86/intel/hid.c          | 1 +
 drivers/platform/x86/intel/pmc/pltdrv.c   | 1 +
 drivers/platform/x86/intel/rst.c          | 1 +
 drivers/platform/x86/intel/smartconnect.c | 1 +
 drivers/platform/x86/intel/vbtn.c         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index c7a827645864..10cd65497cc1 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -38,6 +38,7 @@ MODULE_PARM_DESC(enable_sw_tablet_mode,
 /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
 #define TABLET_MODE_FLAG BIT(6)
 
+MODULE_DESCRIPTION("Intel HID Event hotkey driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 
diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index ddfba38c2104..f2cb87dc2d37 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -86,4 +86,5 @@ static void __exit pmc_core_platform_exit(void)
 
 module_init(pmc_core_platform_init);
 module_exit(pmc_core_platform_exit);
+MODULE_DESCRIPTION("Intel PMC Core platform driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index 6bc9c4a603e0..f3a60e14d4c1 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+MODULE_DESCRIPTION("Intel Rapid Start Technology Driver");
 MODULE_LICENSE("GPL");
 
 static ssize_t irst_show_wakeup_events(struct device *dev,
diff --git a/drivers/platform/x86/intel/smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
index cd25d0585324..31019a1a6d5e 100644
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 
+MODULE_DESCRIPTION("Intel Smart Connect disabling driver");
 MODULE_LICENSE("GPL");
 
 static int smartconnect_acpi_init(struct acpi_device *acpi)
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 84c1353eb12b..9b7ce03ba085 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -24,6 +24,7 @@
 
 #define VGBS_TABLET_MODE_FLAGS (VGBS_TABLET_MODE_FLAG | VGBS_TABLET_MODE_FLAG_ALT)
 
+MODULE_DESCRIPTION("Intel Virtual Button driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AceLan Kao");
 

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-platform-x86-intel-16fa0454fe2b


