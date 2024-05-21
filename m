Return-Path: <linux-kernel+bounces-185537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129E8CB66C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FF71F2215E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC214A4C9;
	Tue, 21 May 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIVRSMsq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC524149DEC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335757; cv=none; b=CiGkIHBVdpcXZLo3wqdBRwod1yt+wThlyCalTuxTr3Q8Ni3tm+VLniG7uMHH9y3FhKkSCEBlu+Jgwf7/CrMAW568fsebE2Sq2Us9FzIAbmokBXXIDFI+gaDTcdAEIeZC8C4m3vTOolTGZmqmgFS+/IifTmqOkVpNm3MBywrImpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335757; c=relaxed/simple;
	bh=Kc38EzOfeWAlb4bBoUH+4kvKqzdFABT2qnEca+zNUkg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfRUslqh914urf+xmn3CMS0rxyrRiJeSgiPZono/DotUgszxoPMAA8gd3dBqYyvf9x4Lz3gIeNkH5vc5aECWR22qNVc5q2RdoaLWmOg1qt+BEtDhvFNz+4mebQg9Wn7nnHNV77m4UPc+IHN4K9jxamg1BjlaHvQkl9ZmCgwxJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIVRSMsq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi9Ws025744;
	Tue, 21 May 2024 23:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=I3L1LQIelw9oqT+0T41Q58pEC5gWfYbgn8T4h8gRVP4=;
 b=cIVRSMsqlLYYsVPR2FJWLHywyYr1y2WfWRRswKtAInrkSKhipcwyIHgLKtg5aCPx3weg
 4/MikqcfOxA1ATOm9swY1+lkMIpxUz75w0nP6P5ImYo/RrVGREO6UMDCS8R7TPSbFnRf
 8fVjE8ZNv6d73S00tKQeZZ3qnP4VREXyaznOoNR2OrLzSBNissq+dH2UqJYWEub8Q+Qn
 1otMtmDfbAtipTA5aSl1oyPWfz1LaQdp2Ga/DMc7sIVCoX/2dyv+MMR3VBeeTAQvbgc7
 79vOJtMhSKQjW6JFNFhr2k2tAYTmoozCsYCkl6OxIwUlQ3OqWFn8oMWe6KVVYV/DDPm8 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k466m2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:55:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKk002667;
	Tue, 21 May 2024 23:55:43 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-6;
	Tue, 21 May 2024 23:55:43 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] mm/memory-failure: send SIGBUS in the event of thp split fail
Date: Tue, 21 May 2024 17:54:29 -0600
Message-Id: <20240521235429.2368017-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521235429.2368017-1-jane.chu@oracle.com>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210182
X-Proofpoint-ORIG-GUID: 79GQpZ_jzEgc6Qmkdeqa_86YlEdLM5cy
X-Proofpoint-GUID: 79GQpZ_jzEgc6Qmkdeqa_86YlEdLM5cy

While handling hwpoison in a THP page, it is possible that
try_to_split_thp_page() fails. For example, when the THP page has
been RDMA pinned. At this point, the kernel cannot isolate the
poisoned THP page, all it could do is to send a SIGBUS to the user
process with meaningful payload to give user-level recovery a chance.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 794196951a04..a14d56e66902 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1706,7 +1706,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-static int try_to_split_thp_page(struct page *page)
+/*
+ * When 'release' is 'false', it means that if thp split has failed,
+ * there is still more to do, hence the page refcount we took earlier
+ * is still needed.
+ */
+static int try_to_split_thp_page(struct page *page, bool release)
 {
 	int ret;
 
@@ -1714,7 +1719,7 @@ static int try_to_split_thp_page(struct page *page)
 	ret = split_huge_page(page);
 	unlock_page(page);
 
-	if (unlikely(ret))
+	if (ret && release)
 		put_page(page);
 
 	return ret;
@@ -2187,6 +2192,24 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+/*
+ * The calling condition is as such: thp split failed, page might have
+ * been RDMA pinned, not much can be done for recovery.
+ * But a SIGBUS should be delivered with vaddr provided so that the user
+ * application has a chance to recover. Also, application processes'
+ * election for MCE early killed will be honored.
+ */
+static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
+				struct folio *folio)
+{
+	LIST_HEAD(tokill);
+
+	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
+	kill_procs(&tokill, true, pfn, flags);
+
+	return -EHWPOISON;
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -2328,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p) < 0) {
-			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+		if (try_to_split_thp_page(p, false) < 0) {
+			res = kill_procs_now(p, pfn, flags, folio);
+			put_page(p);
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -2703,7 +2728,7 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page)) {
+		if (try_to_split_thp_page(page, true)) {
 			pr_info("soft offline: %#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.39.3


