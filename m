Return-Path: <linux-kernel+bounces-232551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADAE91AADC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A77E1C20325
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254D198E60;
	Thu, 27 Jun 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y5PFjIf5"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7599198A34
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501288; cv=none; b=X348Rjfg0+gkBfVCQhWZO6RG9KRIPMcMhmH4F+2Ypx48jugKTTWx7hGQNHF+j9SWzDyD1hYfx2JYuc8NrnyloCa+gmpmUcF8HeYOAsqpPtggY026+O1xsXacEGl8RnJSWyRV/ZCDUYaWmOHrx0b7rkNDedYnz2WeLNRdUzgyj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501288; c=relaxed/simple;
	bh=f8x7WT5/nA6aNFCsNVrDgMstHK81Z1+toZLwmkwK5t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSy3qngjbw9whV2DL84rt/jjZVNwrJFqT95b+kb+rCvHREjWc75Zo4w9BMa6MUlU18viTClnRjGcalRi8I8KEt0jj3KZEKevgyNe8A/cONj3XQrfxzYtXmzzczwZHIg0I3DYp5RiivOec98jsj4gedZyqFuR45RrvyuGWtFJX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y5PFjIf5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45REuqR1015553;
	Thu, 27 Jun 2024 15:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=9nSO8vQ8Lysld
	J41kUs8BTYUja1+gnKPMCjMQs//hno=; b=Y5PFjIf5h6Km09SvAKoQtbFtJtQL9
	UxKCaUYxKjp/3iayxbso7EzUhUx8yCP/6mkTpD9JErYqUUTM7DCapno8yKjRq6Vl
	nR9gbuxNUdtGaZ0jdS03iXe8ZEsM2YkM79rd8wE2Z60xBPSaAHNTLl5sRYnGNav4
	0N0G1+4wPckEWUF9eEENeUs8nrNpLvIsJ7BLmRZkRRU3qhOsq4M9o/0mIYl1g5dH
	H3RNUky0n5Xag5d1FtFkfjuq4iChNuBt3qz6mCQ/gFdBYTp6hJwa8Zo2H5YT2jfp
	QHABQ7AYb07we3mZdwPtAr65nukhNzN2lCIhucxyU/O30YB4Z0b/FUuaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4015fsrryj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:40 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RFEdCP008846;
	Thu, 27 Jun 2024 15:14:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4015fsrryd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RBjA4l019602;
	Thu, 27 Jun 2024 14:58:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xqba9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:58:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45REvwtr20054466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 14:58:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A80522004B;
	Thu, 27 Jun 2024 14:57:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2346220043;
	Thu, 27 Jun 2024 14:57:58 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.182])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 14:57:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] kmsan: add missing __user tags
Date: Thu, 27 Jun 2024 16:57:46 +0200
Message-ID: <20240627145754.27333-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145754.27333-1-iii@linux.ibm.com>
References: <20240627145754.27333-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -d7cZN-z68hAjVNQeXA7A1nEUn9qEmjC
X-Proofpoint-GUID: tjwTrgx4dkgHL1UYAClt-09Hv4Ljjbml
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=988 spamscore=0 adultscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270113

sparse complains that __user pointers are being passed to functions
that expect non-__user ones.  In all cases, these functions are in fact
working with user pointers, only the tag is missing. Add it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406272033.KejtfLkw-lkp@intel.com/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/core.c   | 4 ++--
 mm/kmsan/kmsan.h  | 6 +++---
 mm/kmsan/report.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 81b22220711a..a495debf1436 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -249,8 +249,8 @@ struct page *kmsan_vmalloc_to_page_or_null(void *vaddr)
 		return NULL;
 }
 
-void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
-				 int reason)
+void kmsan_internal_check_memory(void *addr, size_t size,
+				 const void __user *user_addr, int reason)
 {
 	depot_stack_handle_t cur_origin = 0, new_origin = 0;
 	unsigned long addr64 = (unsigned long)addr;
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index 91a360a31e85..29555a8bc315 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -73,7 +73,7 @@ void kmsan_print_origin(depot_stack_handle_t origin);
  * @off_last corresponding to different @origin values.
  */
 void kmsan_report(depot_stack_handle_t origin, void *address, int size,
-		  int off_first, int off_last, const void *user_addr,
+		  int off_first, int off_last, const void __user *user_addr,
 		  enum kmsan_bug_reason reason);
 
 DECLARE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
@@ -163,8 +163,8 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id);
 void kmsan_internal_task_create(struct task_struct *task);
 
 bool kmsan_metadata_is_contiguous(void *addr, size_t size);
-void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
-				 int reason);
+void kmsan_internal_check_memory(void *addr, size_t size,
+				 const void __user *user_addr, int reason);
 
 struct page *kmsan_vmalloc_to_page_or_null(void *vaddr);
 void kmsan_setup_meta(struct page *page, struct page *shadow,
diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
index 92e73ec61435..94a3303fb65e 100644
--- a/mm/kmsan/report.c
+++ b/mm/kmsan/report.c
@@ -148,7 +148,7 @@ void kmsan_print_origin(depot_stack_handle_t origin)
 }
 
 void kmsan_report(depot_stack_handle_t origin, void *address, int size,
-		  int off_first, int off_last, const void *user_addr,
+		  int off_first, int off_last, const void __user *user_addr,
 		  enum kmsan_bug_reason reason)
 {
 	unsigned long stack_entries[KMSAN_STACK_DEPTH];
-- 
2.45.2


