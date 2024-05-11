Return-Path: <linux-kernel+bounces-176316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701F8C2DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2A284741
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFBE2579;
	Sat, 11 May 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hguMTNN9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F27366;
	Sat, 11 May 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715387097; cv=none; b=BFeqZQ79u8hnG+d+SssmNQnO3Xff4+uT3Xw7STUl5xj6fCDb/MVlbN4aKoZJh0UBj35aIT9XCZIl1gA3wCgpATxDe8UzkIsdYsuCWc7xTdP/nBZZbTMaRJ8y/Bk6BGiEMogeXZnxmu9iXAes0LjZxfGPQzCDdae2S6XHFIUmlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715387097; c=relaxed/simple;
	bh=1tlLxsR2+Imi6IOxBF/+ezoKLGIAzMl/lG8Xm84WbUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=s4C9/quknUDp7DMgSdU5jwDhXClUICvmvJIgKPy2oqYrCsQ3aBeVTU3zSA4LBWAmVfsrFFTUMivYe+rlu9/kTLpJ31VqvN3vb6FBcXcG0YcI7ckYwyXeusH0Y3R/SGqFW11PGaWQKT00qG/YWzBx2XnMUZaUJnLyp5yh/9Mkkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hguMTNN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE8lLV025195;
	Sat, 11 May 2024 00:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=KuY
	ju2Q3wh58CiYBSoaXhlRVzwV085t7knGwsXBLZwc=; b=hguMTNN9jxWSFgyUE8Z
	ZYOqt4noc2cF+Bi+ZYPFlimO8b5HHg9NtKFs8/GmEm7Lw+7oX+cZ73f1V/U67Ml6
	fEWpQADCGwBdpR48yCtG6FI22KBlOJRPePsJunvcUnD+eHrKFbkJzinTVZI2MOaB
	q+qLVFk1KAvZFVBhB/6axLDYwZtd46i9Ykg/Gq/4wlBYstK5Kly1koSUAbvgIaFy
	xtJkrX3HMnbFWVqCZ10FIALZINctUx4/Ge+krdbgHtIvuJ06E+pi0+z7GS3YqE3L
	9bUm9lIpCFBCgTlClbuO75T6ITTGwMBMneJV3cG5obfGZJhbwIxx3c4xmX9iVczj
	FRg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2aneq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 00:24:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B0OQ38024029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 00:24:26 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 17:24:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 10 May 2024 17:24:25 -0700
Subject: [PATCH] time: add MODULE_DESCRIPTION() to time test modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALi6PmYC/x3MQQqDQAyF4atI1g0kU13Yq0gXo8YacKaSaBHEu
 3fa5Qf/eye4mIrDozrB5KOu71zAtwqGOeaXoI7FECjU1DDhpkkwjUgTN1wTt+FOUOrVZNLj/9Q
 9i/vogr3FPMy//aJ5PzBF38Tgur4ScTXdeAAAAA==
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Riley <davidriley@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: paHimYsuwuULLFoTlqe1zzO3kWD-nxzN
X-Proofpoint-ORIG-GUID: paHimYsuwuULLFoTlqe1zzO3kWD-nxzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=893
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110000

Fix the make W=1 warnings:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/clocksource-wdtest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/test_udelay.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/time_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/time/clocksource-wdtest.c | 1 +
 kernel/time/test_udelay.c        | 1 +
 kernel/time/time_test.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index d06185e054ea..62e73444ffe4 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -22,6 +22,7 @@
 #include "tick-internal.h"
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Clocksource watchdog unit test");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 
 static int holdoff = IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 10 : 0;
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df631570..783f2297111b 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -155,5 +155,6 @@ static void __exit udelay_test_exit(void)
 
 module_exit(udelay_test_exit);
 
+MODULE_DESCRIPTION("udelay test module");
 MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
 MODULE_LICENSE("GPL");
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 3e5d422dd15c..2889763165e5 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -96,4 +96,5 @@ static struct kunit_suite time_test_suite = {
 };
 
 kunit_test_suite(time_test_suite);
+MODULE_DESCRIPTION("time unit test suite");
 MODULE_LICENSE("GPL");

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240510-time-md-0f1514019230


