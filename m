Return-Path: <linux-kernel+bounces-210360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC89042CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A8F28BDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2C5BAFC;
	Tue, 11 Jun 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCFXjtV9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033DD54F8C;
	Tue, 11 Jun 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128382; cv=none; b=RtcdFjq8wcdJ7Ck9th95PM20rIA7UiMr89ZcvHsL9QOpqUCcuyPrAS3y2Yle6QcXKyUPozyZ6pwjWdcqSbO/F4vRWA1/LAQgE3fy3vzI+r/cy+YuwDSaXEg1M//LQ75CAdScud3dFoRPU43Bm7isuN7zAhlQDtU7Plc2CVxBPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128382; c=relaxed/simple;
	bh=usGY0bQ1XAWAkyZIdImpVsoaAcxTXjuvtmWLZUzMTE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LnXmHJTc/mQ0mR3JZ1bE3C2gmYd3cBpQcQ4GZ8A70NJpnZ5mxMof9yTVYCOmsqmSwdG65XzczVh76CCgfGERIp6jckomtogGY07e2/vDMbrg6hL3Uw8iFX8PRLCKrSWaqXX/FR4O5EjcYfDJ1RVWYXRj/u/HM+FuW/Hgw+B+fgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nCFXjtV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B9fLVS025776;
	Tue, 11 Jun 2024 17:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TCB1inAc0rBVDe4Vc1itXd
	mI57y2aH/TwAqwscfNfhM=; b=nCFXjtV9vM8WeHAT6qitIGaBDm1rlKzrsrA3Jf
	if0sBcwzt7M2NNf9NsXtxLPTtdfGcE1w2nFztrA05XQiDGkYLu97RvEQRGwgtWA5
	s4o+gP+6SizHvjQIDYMJcXnlhvvnVhs67oaj0BLewLP+FWKo+g63ZhT0qHo2ifrN
	a72KeKNux84yISwL6KZ89BlYkItTQ+LfhRW8vi1VFeiKFEoWEt6RqrI1aJCIUcz5
	0dgY/Mn5jBtu3jOmtbERVyDVuIqANKquMf30mpVm9IsRoMVoJCFiCdb4MgK3+XgA
	mnE24/vmIdWra5CQjcu4kzRHTjKmWkvE5GtFOOSirA9nDbFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp7euk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:52:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BHqtOP002925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:52:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 10:52:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 10:52:54 -0700
Subject: [PATCH] USB: serial: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPaOaGYC/x3MwQ6CMAyA4VchPdtkmwjGVzEeuq1KE5imFUJCe
 HeHx+/w/xsYq7DBrdlAeRGTd6nwpwbSQOXFKLkaggut67zHKWNWWVgNZ4t45DTiJfWhvfbn0Dm
 G2n6Un7L+v/dHdSRjjEolDcdtlDKvOJF9WWHffynpMj+GAAAA
To: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3WM4-IbuGb6Nq6oZ97CqSmSzIXpmFjyJ
X-Proofpoint-ORIG-GUID: 3WM4-IbuGb6Nq6oZ97CqSmSzIXpmFjyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=973 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110123

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/usb/serial/ch341.c             | 1 +
 drivers/usb/serial/mxuport.c           | 1 +
 drivers/usb/serial/navman.c            | 1 +
 drivers/usb/serial/qcaux.c             | 1 +
 drivers/usb/serial/symbolserial.c      | 1 +
 drivers/usb/serial/usb-serial-simple.c | 1 +
 drivers/usb/serial/usb_debug.c         | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 612bea504d7a..060b3208494d 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -863,4 +863,5 @@ static struct usb_serial_driver * const serial_drivers[] = {
 
 module_usb_serial_driver(serial_drivers, id_table);
 
+MODULE_DESCRIPTION("Winchiphead CH341 Single Port Serial Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 1f7bb3e4fcf2..9abb3fec35cd 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1315,4 +1315,5 @@ module_usb_serial_driver(serial_drivers, mxuport_idtable);
 
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_AUTHOR("<support@moxa.com>");
+MODULE_DESCRIPTION("USB Moxa UPORT Serial Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/serial/navman.c b/drivers/usb/serial/navman.c
index 20277c52dded..a08ef41fd561 100644
--- a/drivers/usb/serial/navman.c
+++ b/drivers/usb/serial/navman.c
@@ -112,4 +112,5 @@ static struct usb_serial_driver * const serial_drivers[] = {
 
 module_usb_serial_driver(serial_drivers, id_table);
 
+MODULE_DESCRIPTION("Navman Serial USB driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/serial/qcaux.c b/drivers/usb/serial/qcaux.c
index 929ffba663f2..015bb7c5d19d 100644
--- a/drivers/usb/serial/qcaux.c
+++ b/drivers/usb/serial/qcaux.c
@@ -84,4 +84,5 @@ static struct usb_serial_driver * const serial_drivers[] = {
 };
 
 module_usb_serial_driver(serial_drivers, id_table);
+MODULE_DESCRIPTION("Qualcomm USB Auxiliary Serial Port driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/serial/symbolserial.c b/drivers/usb/serial/symbolserial.c
index d7f73ad6e778..9aabb087f733 100644
--- a/drivers/usb/serial/symbolserial.c
+++ b/drivers/usb/serial/symbolserial.c
@@ -190,4 +190,5 @@ static struct usb_serial_driver * const serial_drivers[] = {
 
 module_usb_serial_driver(serial_drivers, id_table);
 
+MODULE_DESCRIPTION("Symbol USB barcode to serial driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 24b8772a345e..82f4f0b992aa 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -163,4 +163,5 @@ static const struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 module_usb_serial_driver(serial_drivers, id_table);
+MODULE_DESCRIPTION("USB Serial 'Simple' driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index 6934970f180d..8188776b57d1 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -104,4 +104,5 @@ static struct usb_serial_driver * const serial_drivers[] = {
 };
 
 module_usb_serial_driver(serial_drivers, id_table_combined);
+MODULE_DESCRIPTION("USB Debug cable driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-usb-serial-5c724873260e


