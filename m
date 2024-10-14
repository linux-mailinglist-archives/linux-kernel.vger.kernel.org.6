Return-Path: <linux-kernel+bounces-364596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AE99D6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02DD1F233EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC61C8787;
	Mon, 14 Oct 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHLnC9Dt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48A1C6895
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931192; cv=none; b=IdLrelDGEaoeVtO39K2kzmBFIkJbDuv6gYXZ5mbN1gDAJk1l8M4cJuNgmJ3ms3Wbrr6W3iKm9dD5Vr/+yC3WF0p3rFOJSUvIh9odDVZX5eIqMkcGIBHOdN7QGX6t+kFMxDjFN03/BCtf5UeFUUUj/cvXAzSgh7l0VH2rQvrqGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931192; c=relaxed/simple;
	bh=6xEtOD5Fsu21lq81/J0/GxmQKWBU0Owt2l4BGagYmOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2ER4ZCkAUWTJtc7AuLF/p83u0j+3cl0WSXAoIS6QkyXXmbaBssRvrz8yXLZ8ZKCE3tOgcV4npt19fs/Z+FjZXmCEbIc8NIl2NUS8iRsSdJn2h+sAVc0VkLW0VrltEM2B0ybUxQ9AuRBF66rnwdjJvXfA19OtGQnYcgjrg6xIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHLnC9Dt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAJnDx019709;
	Mon, 14 Oct 2024 18:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=OmFNDURywkkm73pEB8SdJltHWfyk4KMLqnF1nWHYZLE=; b=JH
	LnC9DtW7xiop+vmgCUb3lBkioceFlhlKBtDJkiP2fJ2GD/i68maYqFmdpBswcI30
	i4a3+4JP8TCufPNBRdhXLfOqRgqcyCKdqV/7YWILBuyWy7fBNp0+RqpgF9Lwwjyh
	ky7BJtMVf6e9NVmoWieCPd72ncKr3WOOHRe5eGt6uvGt+MnTaKT7BZroEfRT22jl
	evbDpFVSSNB8bgbvSxtFamX9SEGKvipglvFQGISCVqsq3wKv14+j9cH5LD68nkWv
	k0TtJ/EOwaxTTXlEwBqekgsQgxv88XzS107mcvGCGoxb77fq/iDxlMAho+qiH0FQ
	7IrzVXr/mwW8sRFzdUbg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427h6twd0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:39:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EIdeew019117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:39:40 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 11:39:37 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH] mm/kmemleak: fix errors/warnings for coding style
Date: Tue, 15 Oct 2024 00:09:18 +0530
Message-ID: <20241014183918.30123-1-quic_pintu@quicinc.com>
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
X-Proofpoint-GUID: AOdQbd9XMOLVfz2wXFuA_fmbiW1IPQKQ
X-Proofpoint-ORIG-GUID: AOdQbd9XMOLVfz2wXFuA_fmbiW1IPQKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140133

There are several errors/warnings reported by checkpatch.
Fix all of the positive once as below:
- Use #include <linux/processor.h> instead of <asm/processor.h>
- Missing a blank lines after declarations
- Prefer 'unsigned int' to bare use of 'unsigned'
- else should follow close brace '}'

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/kmemleak.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 0400f5e8ac60..11f92bb7b206 100644
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
@@ -2179,8 +2180,7 @@ static int __init kmemleak_boot_config(char *str)
 	else if (strcmp(str, "on") == 0) {
 		kmemleak_skip_disable = 1;
 		stack_depot_request_early_init();
-	}
-	else
+	} else
 		return -EINVAL;
 	return 0;
 }
-- 
2.17.1


