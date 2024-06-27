Return-Path: <linux-kernel+bounces-232552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1FD91AADD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A218289F69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC90198E79;
	Thu, 27 Jun 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HYol0NrL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3A770F9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501289; cv=none; b=s5yyXrHUvQ5PRUtabPqPLeVqBpTu9/FvGHfi9vXYXL8aUtzoNghAwQNkYa3MaiRCQKxzT3xstSehLG3HTujNY9Y/cEyD9j0kEXtsxGELmuVxuslDxX6V6Ihv3L3ohqBoOF8C11giIcV1sKplQkN0dWCq0NQH+OTFeVP9IOGnSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501289; c=relaxed/simple;
	bh=kOASd7UC+j6GNE+MuVEH9Me7wXvBGgFcOXOBnWC7374=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiwxHBftVVV+X1ippsHAIMKsT3MjwCOv6uZPpVIMB3uTFJKUjRzs29gWEbyf5INHAHUTvim0kQjDia9prkcDp1Iihd6dXYMDD958n1MjGQKc7PxBgHIEc6fLGFE+O3lWsAr3s/LHbL2g+NZBmXJ9J/NGNInimNsJigfN+2nS8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HYol0NrL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RExQfU013827;
	Thu, 27 Jun 2024 15:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=V66HzH9oSR/Si
	SXR4ViDL5nQK43Lz5hHmVXw8cMBNuw=; b=HYol0NrLDGcv8wIfLxnjT5kNzFtU8
	6ijvy00JM8Ynf2cqI01FLnIyAD79Tukg+x/nIxesnHpXF+ZEqKX4XLA1gF+D21Ch
	O0Ovk1gTYLx9XRZH5oMGk/sEUnxeKshqZqzIg7c1VO7K9RJkPYqo4uMUwNAXJALQ
	vzx3AVJTeQChub8JBBeUdfONGwnyvmXKFyb2n8nAXWfqDSeP59WMmEYEcF6W3219
	cluGfFuEUYJHKqJgKsVDUz8JyCjDwqOhjsouG5aTrGwOSLsNoeyaEaVzmn8CaN3w
	Vk98bCjyjN83n6V84GD53sO9QZpxRSDzi5vTgJe8ZfRfIi8751b+mxOhA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401aagr19w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RFEffv005834;
	Thu, 27 Jun 2024 15:14:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401aagr19m-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45REWkbs008183;
	Thu, 27 Jun 2024 14:58:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b13fea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:58:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45REw0Ot54133066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 14:58:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E340E2004E;
	Thu, 27 Jun 2024 14:57:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F12420043;
	Thu, 27 Jun 2024 14:57:59 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.182])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 14:57:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] kmsan: do not pass NULL pointers as 0
Date: Thu, 27 Jun 2024 16:57:47 +0200
Message-ID: <20240627145754.27333-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145754.27333-1-iii@linux.ibm.com>
References: <20240627145754.27333-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mcPDNdB_CcP6JYr2AQf9iTbwGMyHfuTJ
X-Proofpoint-GUID: db94Zo-DaWkLUU5XH6LyXhk3sy8TGMD3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=968 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270113

sparse complains about passing NULL pointers as 0.  Fix all instances.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406272033.KejtfLkw-lkp@intel.com/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/hooks.c           | 15 ++++++++-------
 mm/kmsan/instrumentation.c |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 26d86dfdc819..3ea50f09311f 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -303,7 +303,8 @@ void kmsan_handle_urb(const struct urb *urb, bool is_out)
 	if (is_out)
 		kmsan_internal_check_memory(urb->transfer_buffer,
 					    urb->transfer_buffer_length,
-					    /*user_addr*/ 0, REASON_SUBMIT_URB);
+					    /*user_addr*/ NULL,
+					    REASON_SUBMIT_URB);
 	else
 		kmsan_internal_unpoison_memory(urb->transfer_buffer,
 					       urb->transfer_buffer_length,
@@ -316,14 +317,14 @@ static void kmsan_handle_dma_page(const void *addr, size_t size,
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
-		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
-					    REASON_ANY);
+		kmsan_internal_check_memory((void *)addr, size,
+					    /*user_addr*/ NULL, REASON_ANY);
 		kmsan_internal_unpoison_memory((void *)addr, size,
 					       /*checked*/ false);
 		break;
 	case DMA_TO_DEVICE:
-		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
-					    REASON_ANY);
+		kmsan_internal_check_memory((void *)addr, size,
+					    /*user_addr*/ NULL, REASON_ANY);
 		break;
 	case DMA_FROM_DEVICE:
 		kmsan_internal_unpoison_memory((void *)addr, size,
@@ -418,8 +419,8 @@ void kmsan_check_memory(const void *addr, size_t size)
 {
 	if (!kmsan_enabled)
 		return;
-	return kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
-					   REASON_ANY);
+	return kmsan_internal_check_memory((void *)addr, size,
+					   /*user_addr*/ NULL, REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
 
diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index 94b49fac9d8b..02a405e55d6c 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -315,8 +315,8 @@ void __msan_warning(u32 origin)
 	if (!kmsan_enabled || kmsan_in_runtime())
 		return;
 	kmsan_enter_runtime();
-	kmsan_report(origin, /*address*/ 0, /*size*/ 0,
-		     /*off_first*/ 0, /*off_last*/ 0, /*user_addr*/ 0,
+	kmsan_report(origin, /*address*/ NULL, /*size*/ 0,
+		     /*off_first*/ 0, /*off_last*/ 0, /*user_addr*/ NULL,
 		     REASON_ANY);
 	kmsan_leave_runtime();
 }
-- 
2.45.2


