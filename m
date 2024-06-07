Return-Path: <linux-kernel+bounces-206748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33F900D47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC61F21779
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9F1552F9;
	Fri,  7 Jun 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CqrcyULt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1B15381A;
	Fri,  7 Jun 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793806; cv=none; b=dV/G465V+YitY1mLPpXsjnM/IEpkvbDDAjjJsjWgecX6rdAxlHd5DMYl60i50gegJlsjN4LXM91MELpEnHtpUARg9QmBuzYficDTZO1UXL9AHqtjplbw3HMZhOnpUo0l8usuVAeJF58iw1K/VwHhaqWg4ePzEkFlpJMh8KtQ+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793806; c=relaxed/simple;
	bh=5vZnBM0Fi9WkA0UfLbNY9mafIyAX5K0nL/rusHjZBkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UlsHaL0r66Q4+74+yZlSHOqz199RqcK+LWnIflyMkho84hAW4Dt9QstRGioR2dBHncK8ojHv2UbfxKwlPemo6Ah+/9gcBveHnqsiNPml3A/8Mj4R1x3nf/R3m5ittMUbgIXbhZhq+kjwJDtHJ0f8VZehlWNGEzqmtlcWIIonYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CqrcyULt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZXuH001308;
	Fri, 7 Jun 2024 20:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LLEktn6rDt57s0EqrwNX46
	731GfXVlWL1F9A9v1PWI0=; b=CqrcyULtqlJpw9FHCahxxcJ4G395lzeWm6r8fW
	tnTMqUsGIwKgXfICfp9G5tEmY5DOofSQJcMtWvBfNXPsgrouDGIEKeEF/WPpyXrN
	3jJyXr8Z+wFoua/GUkwhAiXpTnkwuhqJPX7q8bEZCjxsJycHVsyB0+1/o1FJncv2
	xdBGFaRy5xIn6F/sopmdgqtCGHmQfQj2078qM7Iqf7qW0wZzSL/RGFmgeOACcUmM
	GLAR2Iw+W7NynW2eP2oFa6QshiQJE1qJQIIwDGsUuS4Srctr/1ylWFRXEOxC3mNh
	+9aI/wFynd32jH7hTtqgrBVUD2maTPFKmiI4H43SDEjosZ7w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjq2tq1by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 20:56:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457KucjW031196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 20:56:38 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 13:56:38 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 13:56:37 -0700
Subject: [PATCH] greybus: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAR0Y2YC/x3MwQrCMAyA4VcZORtoa63gq4iHdI1bwFVJ3JiMv
 bvV43f4/w2MVdjg0m2gvIjJszb4Qwf9SHVglNIMwYXokjvjVLCoLKyGg/Inz4bkjzlFjj6cErT
 wpXyX9T+93pozGWNWqv34Wz2kzitOZG9W2Pcv+0zD8YMAAAA=
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bt2AVqkT0MVWf-Kb97p6CI7PlD2ECRof
X-Proofpoint-ORIG-GUID: bt2AVqkT0MVWf-Kb97p6CI7PlD2ECRof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_13,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=946 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070155

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/greybus/core.c | 1 +
 drivers/greybus/es2.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index 95c09d4f3a86..c28bb973f67c 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -375,5 +375,6 @@ static void __exit gb_exit(void)
 	tracepoint_synchronize_unregister();
 }
 module_exit(gb_exit);
+MODULE_DESCRIPTION("Greybus 'core' driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 1ee78d0d90b4..db4d033925e6 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -1456,5 +1456,6 @@ static struct usb_driver es2_ap_driver = {
 
 module_usb_driver(es2_ap_driver);
 
+MODULE_DESCRIPTION("Greybus 'AP' USB driver for 'ES2' controller chips");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-greybus-a13b64e41256


