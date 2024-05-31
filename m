Return-Path: <linux-kernel+bounces-197105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778428D6641
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3336729094F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7231581EB;
	Fri, 31 May 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YGOxBPX/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93C57CA7;
	Fri, 31 May 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171402; cv=none; b=t5VwiGYTJ8z7RV8xZnoDOrQNz0UWyZJwn6y0kTpLZMQHyaDBs/5fNKHQ69y4ulMuq2ipiSsnX3SDowyj27jdcYBHm5nXgalkJyxfs1c4HKl7cCb9gyJNk96iYvxKizQlD6lUOaULp0jITEMUrw5M+/qgZgTlaegrjSF3XKvwTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171402; c=relaxed/simple;
	bh=bMFv7xDnJL+hw/p29GL/YYNnQd909xblIrlSOzQjKyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rCJvNpsJnhsWAbaiTpUP6/ZT5+2NNZPYukWQFyhyZvz8Kwd15h70eVc1Lq978FGfdjA7KKr1+QQZiCzjVSRkryqXrbWn6CjXgDAfiB5LxncvCbS6b/Wl/emkmg7j/m/e68F+ZPh0QJQSoBHKYouKQjwaOQRdZ0kuMklhpMODf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YGOxBPX/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9C7O0015967;
	Fri, 31 May 2024 16:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vCUZllc4TeUKj1QZG2IYPG
	qKIcTqIzUjXXYoUoV18pY=; b=YGOxBPX/7HmBp3VROPCSFF68p6+wAvGR9HWzLv
	Sx5tYSquzjraiQCY1S3/lZOMwF/HoAPs5/LIYvKollLCfptxE10B4VJ9yyCqGhmu
	Yt06wY8jTxog66ZZjKkT4aY44R1Zy1JkY2PXPACvV+5MMUhhBACip1XZ2jyDT7Wc
	mWFpbhS+nH68fr7dUNLiVwSY8eeYHmj+i7Kw9Yvhxd0hIwf2FEAnZFoh8RY213gd
	U6BVItugiCNFVjet+L1H2I523IX2+pbyEYMR7atYlirMWbU6zMraIwzFtptFTcHW
	cqcHncHSdY9Mp7KCMjy9ZWeY2jgPXqFCCbr+qsC6LXu267eg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf23st5qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 16:03:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VG3CdF025759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 16:03:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 09:03:12 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 09:03:11 -0700
Subject: [PATCH] lib: bitmap: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-lib-bitmap-v1-1-45a782cf3686@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAL/0WWYC/x3MwQqDMAyA4VeRnBew1a2wVxk7pG02A9pJokMQ3
 32dx+/w/zsYq7DBvdlB+Ssmn1LhLg2kgcqbUXI1+Nb37bVzOErEKMtEM4bEt5Cjzy50UINZ+SX
 bOXs8qyMZY1QqafgvRinrhhPZwgrH8QNLhfIZewAAAA==
To: Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tudb-G3CITrWrkZe_6E_8r8iMT-plcJR
X-Proofpoint-GUID: tudb-G3CITrWrkZe_6E_8r8iMT-plcJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310120

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/find_bit_benchmark.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cpumask_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This is the subset of "missing MODULE_DESCRIPTION()" which fall under
the scope of the BITMAP API entry in the MAINTAINERS file.
---
 lib/cpumask_kunit.c      | 1 +
 lib/find_bit_benchmark.c | 1 +
 lib/test_bitmap.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index a105e6369efc..6b62a6bdd50e 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -152,4 +152,5 @@ static struct kunit_suite test_cpumask_suite = {
 };
 kunit_test_suite(test_cpumask_suite);
 
+MODULE_DESCRIPTION("KUnit tests for cpumask");
 MODULE_LICENSE("GPL");
diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index d3fb09e6eff1..402e160e7186 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -194,4 +194,5 @@ static int __init find_bit_test(void)
 }
 module_init(find_bit_test);
 
+MODULE_DESCRIPTION("Test for find_*_bit functions");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6dfb8d46a4ff..65a75d58ed9e 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1486,4 +1486,5 @@ static void __init selftest(void)
 
 KSTM_MODULE_LOADERS(test_bitmap);
 MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
+MODULE_DESCRIPTION("Test cases for bitmap API");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240531-lib-bitmap-7ce67db2d173


