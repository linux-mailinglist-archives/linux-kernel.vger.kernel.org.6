Return-Path: <linux-kernel+bounces-189157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9FB8CEBED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B0B282942
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF3126F33;
	Fri, 24 May 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TdcJBpGr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E27C083
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587609; cv=none; b=NOCOBoSXbmqjK5qQfGg9+h5z2s81+C3tbD4mNInzruViLwCSWKHaVNBrQ5INbXs7m4GbKw7FoDvtfAMCWYBxVce217cbgZxAwWXOEwNM/FHF47na4EJp436BGgPMyfxwh0EdrdfnK38vGV405Grl1NHo2CAT+PT6t3q27Yj8hAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587609; c=relaxed/simple;
	bh=xR/G2YwzoliqJGu1LnJE7SfCRlqGE6/LuzyY4cSKnBI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcOe5MuJ5sEjLv7RScDFwg7WqUY7fyFYAQmRSOpANQdr1353pbI3ldV+MSllotE8OJJs9yvFwlj/j1H2hnRwREY/v0yPQfS1i9d2qYgcyaE1MCN3QnQoYDo2RbdXvvDwgixVP72WJJoBR9uNPTEjfZlOeQiUgnfw2L8HoqfoV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TdcJBpGr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OFxjhF015807;
	Fri, 24 May 2024 21:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=aVvMSdU9di+/pg8Z/YTSNT+1WpNBkHB9jxFSgsTIf2I=;
 b=TdcJBpGrNn3qNkMVnilcUOPTUhxoR9n7n423lwhS5dNLcFnxh/pfSDcXomK4xUAAhiVX
 wP16N+QrVrskqaU3hspLv/12qFhlJuv6yPMsvpV+ttDjIBK9ICbqduZY7Gy5v2rvAIzq
 z/XnRrIIEl6fT588jno8RVTyxteuGWRg5RfLxAuRuluE9pf+8pFjHnkqNzNOEtwY9/T/
 8xKDCf0hmOW7HMqnejHg1y2haNxqOWSatRApVgawilJbqXdcH/x+Mscnb+u+A9qnEd78
 YP+x++oJOdx5JMQ25xDlKuygN9UcKzsbGEOQHHvkBG+VyRvAhkZPvaxI0+z3pWo5nqjQ BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8ddd00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG18035956;
	Fri, 24 May 2024 21:53:13 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-2;
	Fri, 24 May 2024 21:53:13 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] mm/memory-failure: try to send SIGBUS even if unmap failed
Date: Fri, 24 May 2024 15:53:02 -0600
Message-Id: <20240524215306.2705454-2-jane.chu@oracle.com>
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
 definitions=main-2405240157
X-Proofpoint-GUID: FZtvSnJWRGZRRG_af1fn4jAKDaVUcprt
X-Proofpoint-ORIG-GUID: FZtvSnJWRGZRRG_af1fn4jAKDaVUcprt

For years when it comes down to kill a process due to hwpoison,
a SIGBUS is delivered only if unmap has been successful.
Otherwise, a SIGKILL is delivered. And the reason for that is
to prevent the involved process from accessing the hwpoisoned
page again.

Since then a lot has changed, a hwpoisoned page is marked and
upon being re-accessed, the memory-failure handler invokes
kill_accessing_process() to kill the process immediately.
So let's take out the '!unmap_success' factor and try to deliver
SIGBUS if possible.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b7..739311e121af 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -514,22 +514,15 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
  *
  * Only do anything when FORCEKILL is set, otherwise just free the
  * list (this is used for clean pages which do not need killing)
- * Also when FAIL is set do a force kill because something went
- * wrong earlier.
  */
-static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
+static void kill_procs(struct list_head *to_kill, int forcekill,
 		unsigned long pfn, int flags)
 {
 	struct to_kill *tk, *next;
 
 	list_for_each_entry_safe(tk, next, to_kill, nd) {
 		if (forcekill) {
-			/*
-			 * In case something went wrong with munmapping
-			 * make sure the process doesn't catch the
-			 * signal and then access the memory. Just kill it.
-			 */
-			if (fail || tk->addr == -EFAULT) {
+			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
@@ -1660,7 +1653,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 */
 	forcekill = folio_test_dirty(folio) || (flags & MF_MUST_KILL) ||
 		    !unmap_success;
-	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
+	kill_procs(&tokill, forcekill, pfn, flags);
 
 	return unmap_success;
 }
@@ -1724,7 +1717,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		unmap_mapping_range(mapping, start, size, 0);
 	}
 
-	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
+	kill_procs(to_kill, flags & MF_MUST_KILL, pfn, flags);
 }
 
 /*
-- 
2.39.3


