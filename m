Return-Path: <linux-kernel+bounces-199552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CC8D8877
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EADB23FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA23137C44;
	Mon,  3 Jun 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SSmCPQOd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB2135A46;
	Mon,  3 Jun 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438210; cv=none; b=fRV9xjZ4JtrjdzvCPoRqf2jNM0L7R6hHHXC8si/6jt+AHPGzIR2w5kBq0NS8L44eOwa8z9wit5Z+AcmENN+g2PXmyJ7UM/rhTkIDmh1p5Iz9Gvl+8j+6T09SUSbb5D93+ebtp1mSrZSKzWLJAXmVSoPH19UMVJ5gkkgB9ll/SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438210; c=relaxed/simple;
	bh=zsgMPooafz7AGjnPIjZFIdlWYoALoHzCo+CZZTXQr8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nlr3IeWWzX0AjP8OWBn9VrM3LQonwNv5P574xUdZFAsbs3gP82FkaHwCrT9aVU/KENMYz3intGUl20Ffyxi9iBqEw/6/OnyuO074JZD/utYYXa4LhyGt6tK93d4oXliJsbPFIPN36WnDqArSk1THTTkfko2CQ2JA8B5dnVN54Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SSmCPQOd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Ce3BS014637;
	Mon, 3 Jun 2024 18:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vkRS9m7AYGWskla626cGM7
	D9rxeMb62KofzxY1kyFmA=; b=SSmCPQOdDS7EO3boW55o1RarXfSqSgse9j8GR9
	aEua798r6CB7oReq+VuB2IOKVXsSaBUGVneMt2uo5kQ+R1U1DyKWLumOEfr4saj1
	dtoHDFX/GgWpz4xujYvrPTyVJTx2W8KDwg02lnGaC932hRygw5LV7VtGL4JeyywL
	Ulf7RjoFcQ2wNKAcB1MDp0VnPJndiDI3MVZ/z4JEgkHs5XPMPZsmh4EF1lz3o9yl
	qvtUkh+cTJ1OXLrhT4QwzODLFlHctMQ2cx68KgR2LRDZOAsUYyvQikVPJoksrxXc
	eMonaJggcZhJczC3Y8ZzOwSU/LONvK5Ij0Ib+TA1r0Ziekeg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bcnb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 18:10:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453IA2jh000461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 18:10:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 11:10:01 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 11:10:00 -0700
Subject: [PATCH] ppdev: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-char-ppdev-v1-1-b169cb17c844@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPgGXmYC/x3MywrCQAyF4VcpWRuYTkVHX0VczCXagB2HpJZC6
 bsbXX4czr+BkjApXLsNhBZWfldDf+ggj7E+CbmYwTt/dCc34FTQBsHWCi0Yzr13yQ85hAvYpwk
 9eP33bndzikqYJNY8/iovrp8Vp6gzCez7F89HNm5+AAAA
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8tdwNUACzxdLvqezM0gEWEYUBk3BZ_Uo
X-Proofpoint-GUID: 8tdwNUACzxdLvqezM0gEWEYUBk3BZ_Uo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030148

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ppdev.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/ppdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 58e9dcc2a308..3655aa859185 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -882,5 +882,6 @@ static void __exit ppdev_cleanup(void)
 module_init(ppdev_init);
 module_exit(ppdev_cleanup);
 
+MODULE_DESCRIPTION("Support for user-space parallel port device drivers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(PP_MAJOR);

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-char-ppdev-87120b23c889


