Return-Path: <linux-kernel+bounces-210733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E5904808
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BAD1F229BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16079D8;
	Wed, 12 Jun 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iGnSniAI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C34A0A;
	Wed, 12 Jun 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152369; cv=none; b=QdNqiLoD8wN3ZbhqrcyQ/N9TrGnJX4wD3e3vrtpvn8GUb638RZG43xdd+Mja/bocNslS5lHfHyIQkbk23H5rlot8CxmOMynA5XBmxrBnr0nk0g9aWhgttyryEGMlfD9h7SwukZPYTjaXDYBya6DS6mipM5v61DAh3j19Q6FMgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152369; c=relaxed/simple;
	bh=ZMCA7LjMy4ZpCik029YtPKh3ZGnC6OkWXJPzL1UauCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LlwlVvyFD1oXCQXOgAPU4KQEQ+7O8ldqNVWRNas7PtiNMTTYPMYhuSRGplYgQEfD0nMlYn2QpWDif8XbXYq1P/g41Hux0o3YbVkHddYTictpwtxV0ymZ1MMZTWK055lNqQWgi83PolGT394/Ibk15Hrn+n51KJ7mJVZnOe2p6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iGnSniAI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BMLxti005154;
	Wed, 12 Jun 2024 00:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o7+9w/zVAOP/GvxJZt3AbE
	1bCIu2tMpuoArXQc/0xok=; b=iGnSniAI+zJneEXchBKdLnw03B5MjN/nKJX95O
	ih/z6iZMiyWVShOPkxO/PV+dv7OGFPDHlmquKNds5P+HLU2nq/KjQXh8su1TMe7e
	axC0x0Q3Vwr2/NryspR7098IpqKsZmbidx8CT2y6WzF+ZMB2QhRexTrw3Xxa6aVF
	KIsf/7gcxwxZm0luE2ICCBL3x0ec2b2KYmKlL3JZY44Fm0TeEbXwq+7JAcICrkNW
	8Xu9vow+BKlC2E+7rgMF6CT1PUxdo+iPctuoviTskEkzZ56zYYYD1WZQLQgn+Gym
	d8Y0iyxdx/sG5My+oC9kSCvfbZzdBRD/2+YbM8mca84W5Zqg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm45a015-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 00:32:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C0WiuZ022552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 00:32:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 17:32:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 17:32:35 -0700
Subject: [PATCH] usb: misc: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-usb-misc-v1-1-98475a5aa8ef@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKLsaGYC/x3MwQqDMAyA4VeRnBdo3VDcq4wd0jbTwFolmSKI7
 75ux+/w/wcYq7DBvTlAeROTuVT4SwNxojIySqqG1rU313mPOWFS2VgNVwuYxSIm11+JhtAN3kE
 tF+WX7P/r41kdyBiDUonT7/WWsu6YyT6scJ5ffkwTCoQAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uNjeptbInfT68jqc9Fv0OxMsPBePV1qz
X-Proofpoint-ORIG-GUID: uNjeptbInfT68jqc9Fv0OxMsPBePV1qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_12,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120000

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/ezusb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/yurex.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/usb/misc/ezusb.c           | 1 +
 drivers/usb/misc/isight_firmware.c | 1 +
 drivers/usb/misc/yurex.c           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
index 78aaee56c2b7..7ab4856aba0e 100644
--- a/drivers/usb/misc/ezusb.c
+++ b/drivers/usb/misc/ezusb.c
@@ -148,4 +148,5 @@ int ezusb_fx2_ihex_firmware_download(struct usb_device *dev,
 EXPORT_SYMBOL_GPL(ezusb_fx2_ihex_firmware_download);
 #endif
 
+MODULE_DESCRIPTION("EZUSB device support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/misc/isight_firmware.c b/drivers/usb/misc/isight_firmware.c
index 4d30095d6ad2..2d9af74a62c1 100644
--- a/drivers/usb/misc/isight_firmware.c
+++ b/drivers/usb/misc/isight_firmware.c
@@ -127,5 +127,6 @@ static struct usb_driver isight_firmware_driver = {
 
 module_usb_driver(isight_firmware_driver);
 
+MODULE_DESCRIPTION("iSight firmware loading support");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 9a0649d23693..4745a320eae4 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -531,4 +531,5 @@ static const struct file_operations yurex_fops = {
 
 module_usb_driver(yurex_driver);
 
+MODULE_DESCRIPTION("USB YUREX driver support");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-usb-misc-d073aa9b6910


