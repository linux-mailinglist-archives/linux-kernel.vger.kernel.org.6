Return-Path: <linux-kernel+bounces-231512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326991995E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB6D1F21DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68D194C84;
	Wed, 26 Jun 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ncjhj1Fq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A6194120;
	Wed, 26 Jun 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434479; cv=none; b=cSHaVEdYz3pcWy5FiVpwmUbZ7fyKTPRE3oQH1BB/5CVsIwU+DrllJIiIgiL1Hfbf1Dgkw8hjBgnProQywTaIBJIJoj2T/vUvfGmfOOFcUPTmPMG9Z+QnevHR0+syIM4czfc18sVoBVNLqab6nS+ujfrvpIDBIy6XPqTzBzMu1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434479; c=relaxed/simple;
	bh=Jlg3bM/s2vMzrXs49CY5/zilnGIWwYB0FCxaN6BCsKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=g9cF7n1Zh+ty3ktzg744ee6XZwlAgzPHfszBNMh3aEPrXzrbDngi+3L+3QLE9xUUvkMcA0AYJLmNHQtYdP+96asfgV6NHU9QHujZwVp7P+tb27VK7v8xcB27iR5cBPVt8cbtuV591t4h0XAxD9ssr8m8WXazXNdk0bKYvLokTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ncjhj1Fq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfS0e029236;
	Wed, 26 Jun 2024 20:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MPFeSDxJNesyJ1nbWQOwSi
	IbyfU/gMqfomQS4JyA3r0=; b=ncjhj1Fq+d2sRkAstgM9WH+hzl/UUv99BalXXT
	0Whz+u1Ei9m89p1zaN87kjfNaSDTp2kCTvTto8PsLyRiFwrxGFMK1BFu5905EUAR
	bUpGy7u/r4Od2OhVgvh37jxf+IasE07cOvJFHozhCgyvGMe+OdXgRiVV4dSzfxYF
	94GKBjTB4u26YI+Q3lahKILEqhO7hsY83MUIjHodv6tiHAzdSEFHC3bCngMcsE41
	i64xMkIHg2RmDBr53Rx4Gznaoup87TTWG2CPcO8wCBatT+wxBemheYKHfj2dnwp5
	0XMptN5dujAqWURaKGDFmTeVizEUhfr0or+ddfTIiIdKf7eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6t8xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:41:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QKfBQ9023020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:41:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 13:41:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 26 Jun 2024 13:41:09 -0700
Subject: [PATCH v2] greybus: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-md-drivers-greybus-v2-1-d520ffb9a489@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOR8fGYC/32OSw6DMAxEr1JlXVdJ+FTqqveoWCTBgKUSWhsiE
 OLuBQ7Q5ZNm3syqBJlQ1OOyKsZEQkPcwV4vKnQutghU76ystrku9R36GmqmhCzQMi5+EnAm82W
 OubFFqfbih7Gh+ZS+qp29EwTPLobuUL0pTjP0TkbkI96RjAMv54VkjtLftWTAQGYa57S3xuji+
 Z0oUAy3MPSq2rbtB7FRaqnVAAAA
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LEkuwiIVbKihnYeU1OAjdbniOXHS0SWj
X-Proofpoint-ORIG-GUID: LEkuwiIVbKihnYeU1OAjdbniOXHS0SWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260151

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Acked-by: Alex Elder <elder@kernel.org>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Dropped the single quotes at the suggestion of Alex and pulled in
  his Acked-by tag
- Link to v1: https://lore.kernel.org/r/20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com
---
 drivers/greybus/core.c | 1 +
 drivers/greybus/es2.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index 95c09d4f3a86..33a47e73f0fa 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -375,5 +375,6 @@ static void __exit gb_exit(void)
 	tracepoint_synchronize_unregister();
 }
 module_exit(gb_exit);
+MODULE_DESCRIPTION("Greybus core driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 1ee78d0d90b4..69e46b1dff1f 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -1456,5 +1456,6 @@ static struct usb_driver es2_ap_driver = {
 
 module_usb_driver(es2_ap_driver);
 
+MODULE_DESCRIPTION("Greybus AP USB driver for ES2 controller chips");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-greybus-a13b64e41256


