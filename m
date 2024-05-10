Return-Path: <linux-kernel+bounces-175323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0D8C1E10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B41F21629
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F42165FCB;
	Fri, 10 May 2024 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+GG0Ikx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23C1649DD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322397; cv=none; b=L59aXli8X4BWAMa81722XuR6nlESUNkmKoLwFt2XDJj5LoKzGEMoHz6/Am0Gp6DTNRw0JrsJXLnhnUryUkyS6YGx7/UCw7Q5wJaqUfRC6XsdzFYA7nPhRUc+LIxtuvLbYgfjbLO1fCcDS/Y1zrnVVZM3F3UK2M7Z0GQo1dNfoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322397; c=relaxed/simple;
	bh=wCzAosb9yCwghwfxx/CGqsZgf9AZk6yq9vaFDYv2tRY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDWn7sPFwpgBAt7YkrB7vYGrRXXwbSdi5fFki+HQjX6JtsN+E+IjoWrtbhVv9/2ZJ0VgWEqORfimdbpYBE0t+TjJ5WH4qhfrwrnIKmZ18ZsbSxVZ+9cFqmE7BSi33EB+apWqDmHz5aVSxtUGkK2ypJNutmOA02/r7w3G3zbUxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+GG0Ikx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A6MlnA021258;
	Fri, 10 May 2024 06:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=tFRwwH8vMdoczPoQRYMz5N41Zt2owkILdQOhrik+iU8=;
 b=g+GG0IkxeBwWGSyuHfsSdSx+LFncqCu5jZOcbVaDHmkL9ozkB8xCjsgtm+GrDkXmTUj5
 MXoy9msQbB+PCutyZxq+HAKT2pUU8SvxyEZ2h8S8G7Zgpmx8DuozzcRn3wU88odGNPMW
 64+S4Ksxo0HtObmuilQyCk1Bd9sTw/qfkE5mtg1aJGpyp2oOSkUjnFa5aXIRYK5lfYTI
 vAky1uOu1pEQjAxLxo/Of1rF5SrdrkCi2qS+I3DhHhWoODouj/cHvEGyv5JIMn/0SxtB
 9EzEdDUEkS747E2AHQEmFIXqS5giacQ4OQ2QB0t2qfddTjokh/pxF1dkkb3+namnHna6 sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1e8sr05v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjP020104;
	Fri, 10 May 2024 06:26:24 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-6;
	Fri, 10 May 2024 06:26:24 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mm/memory-failure: send SIGBUS in the event of thp split fail
Date: Fri, 10 May 2024 00:26:02 -0600
Message-Id: <20240510062602.901510-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510062602.901510-1-jane.chu@oracle.com>
References: <20240510062602.901510-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100044
X-Proofpoint-ORIG-GUID: Bbu3oqFBFYt86uLCdWySG1px70G6up9M
X-Proofpoint-GUID: Bbu3oqFBFYt86uLCdWySG1px70G6up9M

When handle hwpoison in a RDMA longterm pinned thp page,
try_to_split_thp_page() will fail. And at this point, there is
little else the kernel could do except sending a SIGBUS to
the user process, thus give it a chance to recover.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2fa884d8b5a3..15bb1c0c42e8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1697,7 +1697,7 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-static int try_to_split_thp_page(struct page *page)
+static int try_to_split_thp_page(struct page *page, bool release)
 {
 	int ret;
 
@@ -1705,7 +1705,7 @@ static int try_to_split_thp_page(struct page *page)
 	ret = split_huge_page(page);
 	unlock_page(page);
 
-	if (unlikely(ret))
+	if (ret && release)
 		put_page(page);
 
 	return ret;
@@ -2177,6 +2177,24 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
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
@@ -2313,8 +2331,11 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p) < 0) {
-			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+		if (try_to_split_thp_page(p, false) < 0) {
+			pr_err("%#lx: thp split failed\n", pfn);
+			res = kill_procs_now(p, pfn, flags, folio);
+			put_page(p);
+			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
 			goto unlock_mutex;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -2688,7 +2709,7 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page)) {
+		if (try_to_split_thp_page(page, true)) {
 			pr_info("soft offline: %#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.39.3


