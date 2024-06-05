Return-Path: <linux-kernel+bounces-203332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443A8FD998
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1F91F26042
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4EC15FA8C;
	Wed,  5 Jun 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hv73U/3c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960C3BBE5;
	Wed,  5 Jun 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625251; cv=none; b=madIknZ78MQn0+9ysryMd+mSCH5GPGVnKVDfXIFu0cjNMx6ykGPrCfpsNZ5K4wpLEHsIr1Qc/CHNx7jNPQabDJdM/8JXCXWXCgIzCVN3PV8sumZDV8KTd/QbcWtkyrHZVkgh9XEyez+bgIA9g6eurcYp02m8fN9O7736Tyw/E24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625251; c=relaxed/simple;
	bh=ggvzqStwGSfnGyZWv2fxQrTMgMOwfOsslA05L+fu2XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BnyOuD5Fe+6JhpDwtWC8mK94t52KOO2ry05HJPcq0eEeZmJWsekWGgIn17BJTNWJwxRH+Mnk2FNHyx7VhMGl6rtam7gfgCDjdKDRSnu1sdxzgfjkNT7e3sdjgyjv4fYkiGm19Q9k+uGDhlxtnd70M/nNvQmxayHG7GDI56cqI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hv73U/3c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455I2j9t013971;
	Wed, 5 Jun 2024 22:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AI35arAhNzTkB8zFlJZJKR
	AtptE0x3IH3zx+M9838XY=; b=Hv73U/3cpSc0b3F6B9Rnse6gveR0exs5fY+bXe
	y3j+lewTki+WKBtVoHUS0m3Q/6Ed56/mXoS+fE6euqdnZSltQznaHI0mPiJr7AH7
	XsgZdVH2xR/2HbqKtEq81ZHDqID3AkpzUK4ozFc7n7PPE4GWeRLvskcU1jjv4M4X
	eI5+BkKNTSZLDUncWuslBmOdVtdyzN6WlWWukNNWIT8KvzGnSEfvg6hjETP7GCob
	hGlCXozQ76YVAC/l/Gt2ss8zoiErCQOyDr7VLUWiVelaAhXry0TR94NM0uaFwzX8
	w2pV0Gn0TzVDpvJk3aWYK81WvHpFwdfNTPG4+CfoxOPHGDbQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjvxy8gna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 22:07:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455M7MS8004876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 22:07:22 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 15:07:22 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 5 Jun 2024 15:07:21 -0700
Subject: [PATCH] firmware: google: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240605-md-drivers-firmware-google-v1-1-18878de97fa5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJjhYGYC/x3MSwrCMBAA0KuUWTuQFKvoVcRFPtN0oElkptZC6
 d2NLt/m7aAkTAr3bgehlZVrabCnDsLkSiLk2Ay96c/mYgbMEaPwSqI4suSPE8JUa5oJb+5qbbB
 9GHyEFryERt7++ePZ7J0SenElTL9y5vLeMDtdSOA4viyGpdiLAAAA
To: Tzung-Bi Shih <tzungbi@kernel.org>,
        Brian Norris
	<briannorris@chromium.org>,
        Julius Werner <jwerner@chromium.org>
CC: <chrome-platform@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c38EFTHi2PLIpEjohNsuIPA2b6Pr_o2W
X-Proofpoint-GUID: c38EFTHi2PLIpEjohNsuIPA2b6Pr_o2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050166

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/gsmi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/coreboot_table.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/framebuffer-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole-x86-legacy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/cbmem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/vpd-sysfs.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/firmware/google/cbmem.c                 | 1 +
 drivers/firmware/google/coreboot_table.c        | 1 +
 drivers/firmware/google/framebuffer-coreboot.c  | 1 +
 drivers/firmware/google/gsmi.c                  | 1 +
 drivers/firmware/google/memconsole-coreboot.c   | 1 +
 drivers/firmware/google/memconsole-x86-legacy.c | 1 +
 drivers/firmware/google/memconsole.c            | 1 +
 drivers/firmware/google/vpd.c                   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
index 6f810d720f4d..66042160b361 100644
--- a/drivers/firmware/google/cbmem.c
+++ b/drivers/firmware/google/cbmem.c
@@ -131,4 +131,5 @@ static struct coreboot_driver cbmem_entry_driver = {
 module_coreboot_driver(cbmem_entry_driver);
 
 MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
+MODULE_DESCRIPTION("Driver for exporting CBMEM entries in sysfs");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index fa7752f6e89b..a4e3bbd556a3 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -255,4 +255,5 @@ module_init(coreboot_table_driver_init);
 module_exit(coreboot_table_driver_exit);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("Module providing coreboot table access");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index 07c458bf64ec..daadd71d8ddd 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -97,4 +97,5 @@ static struct coreboot_driver framebuffer_driver = {
 module_coreboot_driver(framebuffer_driver);
 
 MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Memory based framebuffer accessed through coreboot table");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 96ea1fa76d35..d304913314e4 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -1090,4 +1090,5 @@ module_init(gsmi_init);
 module_exit(gsmi_exit);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("EFI SMI interface for Google platforms");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index 24c97a70aa80..c5f08617aa8d 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -113,4 +113,5 @@ static struct coreboot_driver memconsole_driver = {
 module_coreboot_driver(memconsole_driver);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("Memory based BIOS console accessed through coreboot table");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/memconsole-x86-legacy.c b/drivers/firmware/google/memconsole-x86-legacy.c
index 3d3c4f6b8194..a0974c376985 100644
--- a/drivers/firmware/google/memconsole-x86-legacy.c
+++ b/drivers/firmware/google/memconsole-x86-legacy.c
@@ -154,4 +154,5 @@ module_init(memconsole_x86_init);
 module_exit(memconsole_x86_exit);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("EBDA specific parts of the memory based BIOS console.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 44d314ad69e4..b9d99fe1ff0f 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -50,4 +50,5 @@ void memconsole_exit(void)
 EXPORT_SYMBOL(memconsole_exit);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("Architecture-independent parts of the memory based BIOS console");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index 8e4216714b29..1749529f63d4 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -323,4 +323,5 @@ static struct coreboot_driver vpd_driver = {
 module_coreboot_driver(vpd_driver);
 
 MODULE_AUTHOR("Google, Inc.");
+MODULE_DESCRIPTION("Driver for exporting Vital Product Data content to sysfs");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240605-md-drivers-firmware-google-9a711c12c5bd


