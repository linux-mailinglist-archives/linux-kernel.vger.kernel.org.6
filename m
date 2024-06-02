Return-Path: <linux-kernel+bounces-198063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDA8D72F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20A3282271
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20817FF;
	Sun,  2 Jun 2024 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NRAtPeJS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2341C02;
	Sun,  2 Jun 2024 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717290320; cv=none; b=gWpmHYFRWFLQdqTfKvP3FEPr1adsTf6DtCm8u4bFpu472vW4y/rKfWdFk9u+bGM4hKZMQu2RiAhH+jq1Zv9fWr5WX6pzDUW0R5VHqn9ukH+PmmTyNEqFe1qa1K81K2wDzvXH6M2VyiT2jz9Nrp/leNq8N15vsjp+Zp0bvIWjkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717290320; c=relaxed/simple;
	bh=ycaIQHwv23FhdyMBPlzaQWH001Y8fX3ldWu7i2BNQJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nUrz5a2Y0rJROvpq7VpFut/DyErxqiORRMY5aeswB/xkWCgy+/lsycR5YQ0O5UM3K4YcrY4cCMtqJqA4kH5ovhVHTHn3+9zjyJvRhcz9d+gB7IGT0GQWKGgoNK8gBgxNv6TyD+DGjyDLvJq2U5LacWQVIvlo1uX/W6eP7aPM+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NRAtPeJS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4520uPK7008966;
	Sun, 2 Jun 2024 01:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RTUx560FFI75m1LSio9e7x
	ELNosUaIRzVoxaz+yTG0Q=; b=NRAtPeJSEQdPPG7NjVphrQ3w9IuLa4X2ev7tzV
	NggMUwR6wTbZVih6WPCQBHnhIYX8omHkyWNOGdIr5uP/ycLdiyxLrk05H38LKCJV
	sACKJHgj/ABU8KIJtLyVj4wx8EU+lpDPtGGdN/TNfR5XR2EBIbmL+cEKwuFZjBrm
	1S26XudUXozRcWoecwnm+r+2ayHnE4jvgqv6IW6Uqyqhns4C7ewdWoPjfBiJEWIS
	tZ4zTKQptlRjJdjoTgIwUCIZwNqqLrW62ehffSzGV+Ww/I1zFvlp7xMUWAGObUdr
	FI62dlLWXQ/AhA3BPU7L+r5+a+Xqzn8q4Te/FVSpuZi3v/iQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7dhgv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 01:05:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452159fD025110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 01:05:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 18:05:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 18:05:00 -0700
Subject: [PATCH] kmemleak-test: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-samples-kmemleak-v1-1-47186be7f0a8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADvFW2YC/x3MQQ6CMBBG4auQWTtJQYONVzEuhvIjE2glHTQkh
 LtbXX6L93YyZIXRrdop46Omr1RQnyoKo6QnWPtialxzca2rOfZsEpcZxlNEnCETy7UNg4fzOHs
 q5ZIx6Pa/3h/FnRi4y5LC+HvNmt4bR7EVmY7jC1hq8FeEAAAA
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zlTsgr8Gw7j-fJpcSeWyUVMbmtOfyVJS
X-Proofpoint-GUID: zlTsgr8Gw7j-fJpcSeWyUVMbmtOfyVJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020006

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kmemleak/kmemleak-test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 samples/kmemleak/kmemleak-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/kmemleak/kmemleak-test.c b/samples/kmemleak/kmemleak-test.c
index 6ced5ddd99d4..f7470ed85a79 100644
--- a/samples/kmemleak/kmemleak-test.c
+++ b/samples/kmemleak/kmemleak-test.c
@@ -96,4 +96,5 @@ static void __exit kmemleak_test_exit(void)
 }
 module_exit(kmemleak_test_exit);
 
+MODULE_DESCRIPTION("Sample module to leak memory for kmemleak testing");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-samples-kmemleak-a76cf8e08e38


