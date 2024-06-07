Return-Path: <linux-kernel+bounces-206809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B263900E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34DD2860CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED907155C98;
	Fri,  7 Jun 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bvTbd5vw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE5155724;
	Fri,  7 Jun 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799300; cv=none; b=OgTV+4SyLrIaW+dG1G44HW2VEGBvOvUkqEtzLDijJI7tWPTeoS2pdh6HhrahuJNDou6vO1eSqrx2s/wztl1GELZeGsC/NrmFDqZKewHwApF5rcbMfcK3uKxlo3TxRpEVtR9QTQ6/Fu08KdDXJFiS+IencEk5BY9BB8mbWsUseUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799300; c=relaxed/simple;
	bh=sNjivo9Zvmbdpxv0rjCgyehgb1bPO24dBUGKz6U6QLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VRceocoiew0rASQsDuaXljJ4lsMNVC8uUfKyjnr7awnj5m8IGI6HvBekJW99pOF3R/HSSlUWpm204QMTzrPEiD2EBf+XZB+HH+N6uJPCjnbFJZ8SobztnvaaDsyFd94WhwKambX82Iijjw+tRksMUGg5G1JDTa5J2GQsLfAP+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bvTbd5vw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZhIX028186;
	Fri, 7 Jun 2024 22:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=p4puNrUTPUexUPQ4paUS/w
	F6E13ce631RWT1AfUA6Yw=; b=bvTbd5vw7LwlAAEMcggwklCV9AOYdJKY2j8h/d
	vJMaue6MC+8tsUUFZ/TpLtpHVGw5NMl+0C9qYyVvn8OAnZafDRTLxOYxB6AuUW7K
	i23kUDr0p/KLwYX8UyZGeGXEJQHB+KyCnMVP663QGat20xN6SZeCh9nDyP4MuBwk
	+oYyy+TP8QA9mhy8E2OA+2lmlSaEOQB6lQwUR5Z7JFKFULOCzleZQLWi+A3fFIJ/
	AFWRCr9xYY44EkDhdkpJsG3JPY4SZwFkx6k0a6g8rMyRYCqikTYZJeh3gC1ybrir
	Qb+UqOKWt354S4caCpmPLeVWc4YHTTAYPMCPz5jkr0INraGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2wgmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 22:28:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457MS0dh026576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 22:28:00 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 15:27:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 15:27:59 -0700
Subject: [PATCH] hwmon: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-hwmon-v1-1-1ea6d6fe61e3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG6JY2YC/x3MwQ6CMAyA4VchPdtkLIKZr2I8FFZcEzdMq0hCe
 Hcnx+/w/xsYq7DBtdlAeRGTuVS0pwbGROXBKLEavPNn17sL5ohRZWE1TN88F+xiCM633UQuQM1
 eypOsx/J2rx7IGAelMqb/6Cnls2Ime7PCvv8Au8bCnoEAAAA=
To: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marius Zachmann <mail@mariuszachmann.de>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wO8xonhjJCmZE-pSvJKvgECHdB9nDrsX
X-Proofpoint-ORIG-GUID: wO8xonhjJCmZE-pSvJKvgECHdB9nDrsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 spamscore=0 mlxlogscore=901 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070167

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/asus_atk0110.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/corsair-cpro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/hwmon/asus_atk0110.c | 1 +
 drivers/hwmon/corsair-cpro.c | 1 +
 drivers/hwmon/mr75203.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index d778a2aaefec..3751c1e3eddd 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -1389,4 +1389,5 @@ static void __exit atk0110_exit(void)
 module_init(atk0110_init);
 module_exit(atk0110_exit);
 
+MODULE_DESCRIPTION("ASUS ATK0110 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 3e63666a61bd..370c5a8a1486 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -582,6 +582,7 @@ static struct hid_driver ccp_driver = {
 };
 
 MODULE_DEVICE_TABLE(hid, ccp_devices);
+MODULE_DESCRIPTION("Corsair Commander Pro controller driver");
 MODULE_LICENSE("GPL");
 
 static int __init ccp_init(void)
diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 50a8b9c3f94d..7848198f8996 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -925,4 +925,5 @@ static struct platform_driver moortec_pvt_driver = {
 };
 module_platform_driver(moortec_pvt_driver);
 
+MODULE_DESCRIPTION("Moortec Semiconductor MR75203 PVT Controller driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-hwmon-5d990215fa09


