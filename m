Return-Path: <linux-kernel+bounces-210941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E356D904AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C74A1F252EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E3374E9;
	Wed, 12 Jun 2024 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IzbvRK58"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1D17C77;
	Wed, 12 Jun 2024 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169689; cv=none; b=ERw4vnRCOhI8kKqYMYTkgG3rXEjfhJ6R4dLlb7GobkO+uwBWKzhzhgu00jQZcRF+Izt+yVyJukwn8y8vnHEHAjGsx2sXo9g5yD3THxOWGxEXIxDaKDD850TP4DuOiLjR4QfjlyKm0QD+wQ0E/beBapRt17vMs3IPPsFtH3R5kAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169689; c=relaxed/simple;
	bh=4mkGo9OXoaEwGBVqvDJO298UkslxWHdGdGifnUeG6a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UpXVYuw2EE8qrNx7SnyQMqnTgm6ZPwYSqrMDGGTaOavfhEl0KujHUFz/k2O7uS7TBJQ4N+0h2GEBZ4UOE9yJt39iU+lCZccZqHNxo3TdY8/RMCbjSsniRPFIghVtbQLRdYypPcv+JEHz9aUy1SrpFl6t5QV4GwOEmsN2qNSEfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IzbvRK58; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C5BleE025787;
	Wed, 12 Jun 2024 05:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q1cUHs5b56/GKnz57ZOrMs
	p6LpP35/QWVMEWh9vbuNg=; b=IzbvRK58mJpq6Y/WEiBqZLqSzP0yUjP0zuD9zS
	iboKLphkve+iGdaDZA9zn2EUuXL+y46crn8w/zZjpfabXI4zNWCbJwsEfeWkpr4p
	iMvt4id/WFaBSzA+Jp5JUcQW8W+ozOin2RZMEq3T1/6urqr1F/rEFozSjxn6m+ov
	04Zqh9+Vj+Q1mo2yayBLLEwvCvJozQ7KGa3ZXr/Ywnlft1hd1ArcP0Tcluzhdjwg
	PHdGhFrvjKSRiSJr4RMLu6y48B1xco8wIWYV5azZyShsr/79tkTZw/WZjudtGtUA
	1WkHOZOu4BpXsmHTe5utSTn04ZptBmjGRHhuDBRf/kvf/Png==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5x9jfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 05:21:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C5L1xO020174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 05:21:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 22:21:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 22:20:59 -0700
Subject: [PATCH] platform/x86: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-platform-x86-v1-1-d850e53619ee@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADowaWYC/x3MQQqDMBBA0avIrDuQGAmlVyldjMlYB0yUiZWAe
 PemXb7F/ycUVuECj+4E5UOKrLnB3joIM+U3o8Rm6E0/GG8tpohR5WAtuC20T6smrHeP5Mj43g3
 RuQCt3pQnqf/z89U8UmEclXKYf79F8qdiorKzwnV9AdrJciuIAAAA
To: Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HgIMLBW91dznE7LdXGdpJM2in-X0IuoV
X-Proofpoint-ORIG-GUID: HgIMLBW91dznE7LdXGdpJM2in-X0IuoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_02,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406120036

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/amilo-rfkill.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/uv_sysfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/ibm_rtl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/xo1-rfkill.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/firmware_attributes_class.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/wireless-hotkey.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This is the last of the issues present (that I'm aware of) in
drivers/platform/x86
---
 drivers/platform/x86/amilo-rfkill.c              | 1 +
 drivers/platform/x86/firmware_attributes_class.c | 1 +
 drivers/platform/x86/ibm_rtl.c                   | 1 +
 drivers/platform/x86/uv_sysfs.c                  | 1 +
 drivers/platform/x86/wireless-hotkey.c           | 1 +
 drivers/platform/x86/xo1-rfkill.c                | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/amilo-rfkill.c b/drivers/platform/x86/amilo-rfkill.c
index efcf909786a5..2423dc91debb 100644
--- a/drivers/platform/x86/amilo-rfkill.c
+++ b/drivers/platform/x86/amilo-rfkill.c
@@ -171,6 +171,7 @@ static void __exit amilo_rfkill_exit(void)
 }
 
 MODULE_AUTHOR("Ben Hutchings <ben@decadent.org.uk>");
+MODULE_DESCRIPTION("Fujitsu-Siemens Amilo rfkill support");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(dmi, amilo_rfkill_id_table);
 
diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index dd8240009565..182a07d8ae3d 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -49,4 +49,5 @@ int fw_attributes_class_put(void)
 EXPORT_SYMBOL_GPL(fw_attributes_class_put);
 
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_DESCRIPTION("Firmware attributes class helper module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/ibm_rtl.c b/drivers/platform/x86/ibm_rtl.c
index 1d4bbae115f1..231b37909801 100644
--- a/drivers/platform/x86/ibm_rtl.c
+++ b/drivers/platform/x86/ibm_rtl.c
@@ -29,6 +29,7 @@ static bool debug;
 module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Show debug output");
 
+MODULE_DESCRIPTION("IBM Premium Real Time Mode (PRTM) driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Keith Mannthey <kmmanth@us.ibm.com>");
 MODULE_AUTHOR("Vernon Mauery <vernux@us.ibm.com>");
diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 37372d7cc54a..f6a0627f36db 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -929,4 +929,5 @@ module_init(uv_sysfs_init);
 module_exit(uv_sysfs_exit);
 
 MODULE_AUTHOR("Hewlett Packard Enterprise");
+MODULE_DESCRIPTION("Sysfs structure for HPE UV systems");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index e95cdbbfb708..459e20f7e161 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
+MODULE_DESCRIPTION("Airplane mode button for AMD, HP & Xiaomi laptops");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 MODULE_ALIAS("acpi*:HPQ6001:*");
diff --git a/drivers/platform/x86/xo1-rfkill.c b/drivers/platform/x86/xo1-rfkill.c
index e64d5646b4c7..5fe68296501c 100644
--- a/drivers/platform/x86/xo1-rfkill.c
+++ b/drivers/platform/x86/xo1-rfkill.c
@@ -74,5 +74,6 @@ static struct platform_driver xo1_rfkill_driver = {
 module_platform_driver(xo1_rfkill_driver);
 
 MODULE_AUTHOR("Daniel Drake <dsd@laptop.org>");
+MODULE_DESCRIPTION("OLPC XO-1 software RF kill switch");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:xo1-rfkill");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-platform-x86-a3a06234d33c


