Return-Path: <linux-kernel+bounces-209261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5264902FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82B6B22EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F4170848;
	Tue, 11 Jun 2024 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mJTP9hSM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C98365;
	Tue, 11 Jun 2024 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718082456; cv=none; b=MUUJH9XZ8y2rRQRdAH3hZEwaGBMhU3836lV6oJ/XHofDkC0czd+EZGzIGFlpDZW+uKzsolJE3FfIosMOO9QYIRwE1D7uoLtxI7GlqyI2OXgomS+p7Uieltzzwi75I16/z5af+C9CC5T+e+SM9Ni0nzrgflPeGY7xKeV9HVwtlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718082456; c=relaxed/simple;
	bh=aMwnRP+SCir2Db2o33feOjTsAtFZwapDTB1Dw4ZNhEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PrCEHg25fINBZ7PaMZ7R6SDx6YRZgYjFdV9cOVsSUREj4CHdzWMKwdZ8JGaB2Je8jSAvKzn78o1WhR4Irpg52lXdPSYSAMuAqv1u7trq1xXZ4l1JhMO3v+b+ZX7lfJzFbaEVRpJhL5kIwtqjWsUv42cGKgdz3uUnmgqcZG/J1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mJTP9hSM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2wqGi008656;
	Tue, 11 Jun 2024 05:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cz7PsYEmasiooBc+YpMk9l
	VLCbEa0Ot9KbWkDUszVJA=; b=mJTP9hSMtOAhLUa+gvN60lA9OEYr8F+qsln9+0
	NYZuD1tdKTxiL0LlOGO6LDmPeoNraF5ZgVnb7q3Ijp68HK+IVrjbYggYaKESYiLo
	8sUIBDkS0NTTRK5USffShsHQn0MhQFpnzEUyMvSYbMJSG0YqwVGlPpRGSIvmHl/s
	KxodBviPt2tbEARhFvYQsd408RE4RkJnA+4DcyKYEpjW3VfZSUYeyAfyCAH396Z9
	l/a9+Cgn0ZDTe/cFxWcd5AmkNZFz1wxabrvOeDCumbO0MfyyAAPo092jBNsP6I2n
	6FnFVhbGEwByROTS7q8jy+l9qXJtDqIqeRy+xXHlbA6DRh9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype9106m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 05:07:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B57F2N008872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 05:07:15 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 22:07:15 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 22:07:13 -0700
Subject: [PATCH] mtd: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-mtd-v1-1-0f59183e4005@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIDbZ2YC/x3MwQrCMAyA4VcZORvoioziq4iHtIkuYKskcwzG3
 t3q8Tv8/w4upuJwGXYwWdX11TrG0wBlpvYQVO6GGOI5TGPAysimq5hjXRhzSLEwJaIpQY/eJnf
 d/sPrrTuTC2ajVubf5qnts2ElX8TgOL5qlOHjfwAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2I8ReiVD-MCgcHufENgu2D0jq3Ufzuay
X-Proofpoint-ORIG-GUID: 2I8ReiVD-MCgcHufENgu2D0jq3Ufzuay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_01,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406110035

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/brcm_u-boot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/tplink_safeloader.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o

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
 drivers/mtd/chips/cfi_cmdset_0020.c     | 1 +
 drivers/mtd/chips/cfi_util.c            | 1 +
 drivers/mtd/maps/map_funcs.c            | 1 +
 drivers/mtd/parsers/brcm_u-boot.c       | 1 +
 drivers/mtd/parsers/tplink_safeloader.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index 60c7f6f751c7..5e5266e2c2e1 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -1399,4 +1399,5 @@ static void cfi_staa_destroy(struct mtd_info *mtd)
 	kfree(cfi);
 }
 
+MODULE_DESCRIPTION("MTD chip driver for ST Advanced Architecture Command Set (ID 0x0020)");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/chips/cfi_util.c b/drivers/mtd/chips/cfi_util.c
index 140c69a67e82..ef0aa6890bc0 100644
--- a/drivers/mtd/chips/cfi_util.c
+++ b/drivers/mtd/chips/cfi_util.c
@@ -441,4 +441,5 @@ int cfi_varsize_frob(struct mtd_info *mtd, varsize_frob_t frob,
 
 EXPORT_SYMBOL(cfi_varsize_frob);
 
+MODULE_DESCRIPTION("Common Flash Interface Generic utility functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/maps/map_funcs.c b/drivers/mtd/maps/map_funcs.c
index 5b684c170d4e..1a4add9e119a 100644
--- a/drivers/mtd/maps/map_funcs.c
+++ b/drivers/mtd/maps/map_funcs.c
@@ -41,4 +41,5 @@ void simple_map_init(struct map_info *map)
 }
 
 EXPORT_SYMBOL(simple_map_init);
+MODULE_DESCRIPTION("Out-of-line map I/O");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/parsers/brcm_u-boot.c b/drivers/mtd/parsers/brcm_u-boot.c
index 7c338dc7b8f3..984f98923446 100644
--- a/drivers/mtd/parsers/brcm_u-boot.c
+++ b/drivers/mtd/parsers/brcm_u-boot.c
@@ -81,4 +81,5 @@ static struct mtd_part_parser brcm_u_boot_mtd_parser = {
 };
 module_mtd_part_parser(brcm_u_boot_mtd_parser);
 
+MODULE_DESCRIPTION("Broadcom's U-Boot partition parser");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/parsers/tplink_safeloader.c b/drivers/mtd/parsers/tplink_safeloader.c
index 1c689dafca2a..e358a029dc70 100644
--- a/drivers/mtd/parsers/tplink_safeloader.c
+++ b/drivers/mtd/parsers/tplink_safeloader.c
@@ -149,4 +149,5 @@ static struct mtd_part_parser mtd_parser_tplink_safeloader = {
 };
 module_mtd_part_parser(mtd_parser_tplink_safeloader);
 
+MODULE_DESCRIPTION("TP-Link Safeloader partitions parser");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-mtd-b082cda8aa68


