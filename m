Return-Path: <linux-kernel+bounces-189161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DA8CEBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB813282A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CD129E74;
	Fri, 24 May 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lYxXVGvI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D0126F2A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587640; cv=none; b=Tovma6tk/hsaWgCKIHsuYYIBSP7HtAA5rkd94f5CvHy8hmBHTuu/WCPUduBWxhtcnOSkH9naT/HJv7LxEhB4aJkgp39MsZBswrm+lpWNob4fmIHdQobSjOIvFK0rxvgO3HLS+yrOYF82aEZUFTX3Jx+fzk2pJe/+rd+Nc6zGles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587640; c=relaxed/simple;
	bh=a/Hlm8C/sajEH5HK6MNoXK+XCedLERs9NZBp9DNex2c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUahLEHkBLJAuWFa1fO+O6Yhjp7p9GuW3RWnthVP6dcFPeRsuKtv5cYQ6dGgrQupxpsLv3Q2wlkTN3RxbilTe129RJWBiFAi0BrlRd5k7bTRD7LCnw+53ERFHvdLcBzSUz/LRJUe/Awuk+u0dApeaIkkM3r3s025vUOU6SeaRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lYxXVGvI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OHcEG8021717;
	Fri, 24 May 2024 21:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NItRoZidtl5jZFk2E3c9bRVzuOiNACCqAvB+zCVBjYM=;
 b=lYxXVGvInCRrVClVw+SA1gLS/PoZSLuThuPH2VElXUrdvyUuoUBAjy9MpgU6YzWceXem
 BZbTLq1JzVtnDMGh6Uh7mTdNen0dxTm8UUbCdQJAYXIaP3yd5zN6XyZ+ngfrMoAE6WOF
 KWRl1cKdzdZAihheh+6KJSVT5CTtnwNWg1tLBaZTXw69Fqqiozft4SWpyJH+rER00ZSb
 2b9tOmhozHoN9sEHi6gCCWEfVPjFto+TkY4Ja4x2K5laurVTgs0/19bHk5bVjOmupBSQ
 RjuNJwWEn6CJlXSSQVTmrC4tHvyaMbK1bKokqG6Aya5gJJNurZAMxygDOTuEvYQVTePE yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8ddd0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG1Q035956;
	Fri, 24 May 2024 21:53:50 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-6;
	Fri, 24 May 2024 21:53:49 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] mm/memory-failure: send SIGBUS in the event of thp split fail
Date: Fri, 24 May 2024 15:53:06 -0600
Message-Id: <20240524215306.2705454-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240524215306.2705454-1-jane.chu@oracle.com>
References: <20240524215306.2705454-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240158
X-Proofpoint-GUID: hPXbkI42xBQJuar7JkbK3Zr9qXE31038
X-Proofpoint-ORIG-GUID: hPXbkI42xBQJuar7JkbK3Zr9qXE31038

While handling hwpoison in a THP page, it is possible that
try_to_split_thp_page() fails. For example, when the THP page has
been RDMA pinned. At this point, the kernel cannot isolate the
poisoned THP page, all it could do is to send a SIGBUS to the user
process with meaningful payload to give user-level recovery a chance.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85659dd0ea32..dcca7297a94c 100644
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
@@ -2186,6 +2191,22 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+/*
+ * The calling condition is as such: thp split failed, page might have
+ * been RDMA pinned, not much can be done for recovery.
+ * But a SIGBUS should be delivered with vaddr provided so that the user
+ * application has a chance to recover. Also, application processes'
+ * election for MCE early killed will be honored.
+ */
+static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
+				struct folio *folio)
+{
+	LIST_HEAD(tokill);
+
+	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
+	kill_procs(&tokill, true, pfn, flags);
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -2327,8 +2348,11 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p) < 0) {
-			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+		if (try_to_split_thp_page(p, false) < 0) {
+			res = -EHWPOISON;
+			kill_procs_now(p, pfn, flags, folio);
+			put_page(p);
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -2702,7 +2726,7 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page)) {
+		if (try_to_split_thp_page(page, true)) {
 			pr_info("soft offline: %#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.39.3


