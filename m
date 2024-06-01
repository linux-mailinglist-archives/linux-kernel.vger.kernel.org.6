Return-Path: <linux-kernel+bounces-197691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A08D6E06
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5639D1C217F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E53F9D4;
	Sat,  1 Jun 2024 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MJKJj3me"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6871FA1;
	Sat,  1 Jun 2024 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717219309; cv=none; b=qAkc5uYtoECn0QnI4HEn8RKKEivuwdziads6rppQW8RULEYD2SURiCdXWNEv3Sz24j1mWZO9anPEsryZK6RIDK77YuG/R5++pFB0BLZ3bEio+rDmK/yaiMDxJqyYgLAl/izjRSQfOpqrnaHmIcZF5SZPcg6778Mq3cddlmDqSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717219309; c=relaxed/simple;
	bh=WuzLPxmQ2z5qFOYB6Ccrur/y1T1zx02Or2ziLvcjtgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BOmgLR3+LstpNuqQmO0grdoeZc3RnAxV/k7Rq0BY6/y/jh1JO3YjzPrUwSQYqN6elLa97G/B52NUknN6UbForm0S/vxYGHy0Vzy1qysRlNUYA6/EvT7uTP5VKYTL28vF3dZfHNwAWURGE5DD2N8vw+eb7/D9qLvTL8KUTKyjamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MJKJj3me; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451518uZ002791;
	Sat, 1 Jun 2024 05:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e+29MkcgeFyHU/qK6ca+zJ
	YwNpXN/HC1oFMDub0VUZE=; b=MJKJj3meO5ViuQqUzHBkx7mPkyTQ1CcAVA0dLK
	ecDLBI/XLmCkD5gPuKwKY07ar1tz5hjlx03NHXWdm8lS1C3Ugk8b5iaV5tRUdlKx
	nuaFzyE+dWbnOKl8RObW8zbCbltqlDczR73HXkrQkszRd+VpsTIW6708QMAA9EbI
	MTaILbc5at+8AXSXlmblZWo/1iheWXCx9HNsICzN6qGcF3SS80x3FVfVtnI4LQBE
	8SPWH8BV9QTR/R4OA6fUletbf4tOgO3IL6xJuQ/I5OmnQWLeJWTgopb1nEBUepT4
	u5yQEE7R/Ck5z854dbGAsU+sTbeLP8C10eBZ2hUq0+h0Hypw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d00j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 05:21:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4515Lgwn023576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 05:21:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 22:21:41 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 22:21:38 -0700
Subject: [PATCH] lib/math: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-math-v1-1-11a3bec51ebb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOGvWmYC/x3MwQqDMAyA4VeRnBewajfcqwwPjaZrQLvRuCGI7
 26243f4/x2Ui7DCvdqh8FdUXtngLhWMKeQno0xmaOqmq33rcJlwFsIlrAl9SzH27tr7G4EV78J
 Rtv/tMZgpKCOVkMf0e8ySP5uVunKB4zgBBkSsOHwAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vdd0Ca4FGswCdz9Ft6H6c-WFMsoesBx1
X-Proofpoint-GUID: vdd0Ca4FGswCdz9Ft6H6c-WFMsoesBx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010039

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/prime_numbers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/rational-test.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/math/prime_numbers.c | 1 +
 lib/math/rational-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index d3b64b10da1c..9a17ee9af93a 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -311,4 +311,5 @@ module_exit(primes_exit);
 module_param_named(selftest, selftest_max, ulong, 0400);
 
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Prime number library");
 MODULE_LICENSE("GPL");
diff --git a/lib/math/rational-test.c b/lib/math/rational-test.c
index 01611ddff420..47486a95f088 100644
--- a/lib/math/rational-test.c
+++ b/lib/math/rational-test.c
@@ -53,4 +53,5 @@ static struct kunit_suite rational_test_suite = {
 
 kunit_test_suites(&rational_test_suite);
 
+MODULE_DESCRIPTION("Rational fractions unit test");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-math-53bff916957b


