Return-Path: <linux-kernel+bounces-197656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D48D6D8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DB31C20F89
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC20AD31;
	Sat,  1 Jun 2024 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e+e13zSj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646276FA8;
	Sat,  1 Jun 2024 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717209783; cv=none; b=O6xFSjsvs30cq0rqszdWsEVLaxhvFovmq/ryZO+rFLnxHqkmwSS2o9HHLf1iHRBwse2/ktOcQHzt0hyOK2u6hP6pZ8a33LPsqrOjTu/O+CWxybz5miTkIWDF2GpzNiBOqHBqWpvr3nsTj3epCrTHFwBz4txqCdFU9ZJ8MdhU7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717209783; c=relaxed/simple;
	bh=egRYUuO/dHIg5qciW3fVWnAEHgfKa3pB/7YHhHAoLoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OpO2hdOTq2LTdLAr2iQy48kTxhUzyaXLpumTTYqDlUg4LOs1452Zan2Wu7di+tAjEuTacD1J+ETbcchTXq9eL+bIH0UeQiyjfpn/7ER3qvhEPgbHhDl7gzN2paee11EB5Gb4PfqfsMc2j+fYsHvdOWjesjJ8vQz+qoai5EOjjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e+e13zSj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4511jSBR022561;
	Sat, 1 Jun 2024 02:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Cs/jEz4qothqugr8gncYpE
	6R5EfSFTMJJjnoGWaPeNw=; b=e+e13zSjczon+SwQtsubb7WaLhbZnxF2kzyyTj
	YeBuDXuInZnz9vcGl6mdkBT+Wp0XU2GONXtAYRJCsy2fm8D6xYvusRQSQXISFTZO
	jIhIlYwXjie+9Bh9wvUprAJLXjfAOXyjwDXXz6cz3N6KhVr6ni8yQrPprcA68QXP
	e2v3XgghBH1+OHpNFV5oEpiw48eZHzvvXcfWK3uAqNIUMeWj2z7u/e8/dA6MObs5
	iN5VQd1vOd2Vbq5UJeRk2uwnTYTZEVoERcOEvIE/2cvYsIdARRn8wbQdScPjBisZ
	iyjw4fLbvbjzucZpZ1K8nIEJAeJL8WiJum1/Ymp0EwDquqLw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjgxuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 02:42:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4512gRZw023061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 02:42:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 19:42:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 19:42:25 -0700
Subject: [PATCH] vsprintf: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJCKWmYC/x3MQQqDQAxA0atI1g2odaT0KqWLzEysgZpKoiKId
 ++0y7f4/wBnE3a4VwcYb+Ly0YLmUkEaSV+MkouhrduuDtcGp4ybzya6DJgp3rrAMYW+h1LMxoP
 s/9vjWRzJGaORpvH3eIuuO07kCxuc5xfKul6sfAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ofPabjqk_b7HEmGEYxnTvtxNRFrt7l_i
X-Proofpoint-ORIG-GUID: ofPabjqk_b7HEmGEYxnTvtxNRFrt7l_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010019

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

(Using vsprintf prefix since these files match the VSPRINTF entry in
the MAINTAINERS file)

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_printf.c | 1 +
 lib/test_scanf.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 69b6a5e177f2..965cb6f28527 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -824,4 +824,5 @@ static void __init selftest(void)
 
 KSTM_MODULE_LOADERS(test_printf);
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
+MODULE_DESCRIPTION("Test cases for printf facility");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index a2707af2951a..7257b1768545 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -810,4 +810,5 @@ static void __init selftest(void)
 
 KSTM_MODULE_LOADERS(test_scanf);
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_DESCRIPTION("Test cases for sscanf facility");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-vsprintf-dab845ebc566


