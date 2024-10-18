Return-Path: <linux-kernel+bounces-371346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B89A39DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA791C20358
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A221EF953;
	Fri, 18 Oct 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eUpY00op"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DC1E883A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243372; cv=none; b=c2apCnHxNqpS6OCmNZ47SDykLIupQdq651IV7vnwlOUdw70AOReyq46XSWTAYYwKjZBhky0nI2Zdk/qBAiYwszIQxZd1X9y6MGudExrn6w/iqQOFwoFJW01vd3e+CAkQTE1dMSRRv3oYY9YgEu4rb0UJtiHi+9p47i7DZL20V9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243372; c=relaxed/simple;
	bh=+cNGane3sTo7+rSYkfcuXw7m4NmzJ7jEgA9mlQ11BPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q05T/lH8whMIZJwgYLgJHNHhIlJGVx0OZUHXX5VZmAS/5uZl/jLVDgajXC0mKd8/6OZ/yuc9IN9fh6Z+53v5E9mSYHhvo7n1DU89DTBXG+iBWqVHGXQhAy7QDym5wzlE6SQeSGi40BoMbBXt45O9zqVHdzbqaGRVvX4E2BdR18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eUpY00op; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I1gJNQ021882;
	Fri, 18 Oct 2024 09:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=ypNyheCLO8fd3m2liOpgl6CzILJlaANSUDyAIrNWJGk=; b=eU
	pY00opyDQBGs7Z53W8+u9GCM5DmT1YZgw8RYPMw2khROEbUEDTMm2KZcwqwlABy+
	k9mIcDrIbk7HQWGS9J2eHXyfjNmGmKQd7+nhptAJmbSTiXUk2g2kTDBVC9JcSsoQ
	Mz6Gf5Cuxxps/Kz9aBFgX/rNH0JHuIegy0/WRCZyKl3zCcoyH4ZHfI8sC04nKahN
	WuzvV7iNY2dqV5PvWy0yOiEGOiRmJmjp01mVQmInGtBIULikwLrhtQqRW0tVwJ2m
	ENO+9QTALIm7i3s2/qV1myRZZMENU+D/5xfIglngirwEVOmzuJaRxInAnzf0Hzrs
	ga7jN/vWrXG1fIJu6gUw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42be8c95a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:22:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I9McZs022578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:22:38 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Oct 2024 02:22:35 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH v2] mm/kmemleak: fix errors/warnings for coding style
Date: Fri, 18 Oct 2024 14:52:05 +0530
Message-ID: <20241018092205.757-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g-bbuv_bw_i_Lr7gbY3p1wkwxmEYHZIG
X-Proofpoint-ORIG-GUID: g-bbuv_bw_i_Lr7gbY3p1wkwxmEYHZIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180059

There are several errors/warnings reported by checkpatch.
Fix all of the positive once as below:
- Use #include <linux/processor.h> instead of <asm/processor.h>
- Missing a blank lines after declarations
- Prefer 'unsigned int' to bare use of 'unsigned'
- else should follow close brace '}'

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
Changes in V2:
Introduce missing bracket in else as suggested by Catalin Marinas.
V1: https://lore.kernel.org/all/ZxDbgS98-_VNkGXJ@arm.com/
---
 mm/kmemleak.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 17006d8a2afa..312a1a9fba97 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/kmemleak.c
- *
  * Copyright (C) 2008 ARM Limited
  * Written by Catalin Marinas <catalin.marinas@arm.com>
  *
@@ -95,7 +93,7 @@
 #include <linux/crc32.h>
 
 #include <asm/sections.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
@@ -373,6 +371,7 @@ static void print_unreferenced(struct seq_file *seq,
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
+
 		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
 	}
 }
@@ -1711,6 +1710,7 @@ static void kmemleak_scan(void)
 		rcu_read_lock();
 		for_each_process_thread(g, p) {
 			void *stack = try_get_task_stack(p);
+
 			if (stack) {
 				scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
@@ -1817,6 +1817,7 @@ static int kmemleak_scan_thread(void *arg)
 	 */
 	if (first_run) {
 		signed long timeout = msecs_to_jiffies(SECS_FIRST_SCAN * 1000);
+
 		first_run = 0;
 		while (timeout && !kthread_should_stop())
 			timeout = schedule_timeout_interruptible(timeout);
@@ -2062,7 +2063,7 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	else if (strncmp(buf, "scan=off", 8) == 0)
 		stop_scan_thread();
 	else if (strncmp(buf, "scan=", 5) == 0) {
-		unsigned secs;
+		unsigned int secs;
 		unsigned long msecs;
 
 		ret = kstrtouint(buf + 5, 0, &secs);
@@ -2179,9 +2180,10 @@ static int __init kmemleak_boot_config(char *str)
 	else if (strcmp(str, "on") == 0) {
 		kmemleak_skip_disable = 1;
 		stack_depot_request_early_init();
-	}
-	else
+	} else {
 		return -EINVAL;
+	}
+
 	return 0;
 }
 early_param("kmemleak", kmemleak_boot_config);
-- 
2.17.1


