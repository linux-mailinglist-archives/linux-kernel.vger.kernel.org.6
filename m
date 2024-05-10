Return-Path: <linux-kernel+bounces-175320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF68C1E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA41F21E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4816132C;
	Fri, 10 May 2024 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDxOCPWi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0C15E81C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322392; cv=none; b=hjudrtw6HA+UaPajfA4OHBwSUi4VZdvUDgHUOwLYvcrxtry1KQewlYZk5EcbyulruCnLLHhbNqzsY8Yi4J7lwRyDihnMqOFJHnPL1nJLXaibc2tA9C1yhT03JHLPITgifi3gwJ8tdZJADJZ8KhhBIE5TrDkivh1Z0qpPlJocXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322392; c=relaxed/simple;
	bh=6F7CRpnGxqd3OYJM6ibrRjnqycdGgS1RVcWPgGIsFnE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=spidLgmhOlxMnwQ0zrJEGm+tgMTdCgPYZuf+5yNQUIJL/d+gqKvAr5GHZujQ8hq3f8GHxTZYd8meNFBrqp9PZ7lSQ+3rV+PZxm4AIdiLxgcddbUIXNrkU8einCOxVjPLSy5s/mJb7hp16R6X8+zVrEKt0Nm8YFHA1Y6zLq1gWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HDxOCPWi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A60k6V028599;
	Fri, 10 May 2024 06:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=lidB/7GHuLOyvJaPSOUYyS3tm5icKkY717K7DeJTTTk=;
 b=HDxOCPWiFx5b+6+Aqn8kT94s6kd9HF/0Ec97tE1bjkoOyRt5Byl1pgUDij2aImMhHN+1
 DYqIowMPMJnAGFbAZp6ZAL2yEf6uaTNDO961feviqzGH1J6IFoOrmCVN4lDsEunTQcV7
 3/lfACmxlDsxsJzTJ8ARhK/5ujjEKMmgo35U0n2bv9LZtiM4PCyJKNwmnML9pruZUfQ/
 7DVEd4iR0ch5rJ1kV+c450Lab7aPIKoi+5KKUR3ecpHw+LRxxW1jp+thn5unqYbMY4+F
 I2iCZ0kR/rGHbPoagtEqJr8k/0yEVqYABR47/SdzhIv1kUEi9QNorEVhNZbkKblynn2U QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1dfsr44y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjH020104;
	Fri, 10 May 2024 06:26:14 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-2;
	Fri, 10 May 2024 06:26:14 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mm/memory-failure: try to send SIGBUS even if unmap failed
Date: Fri, 10 May 2024 00:25:58 -0600
Message-Id: <20240510062602.901510-2-jane.chu@oracle.com>
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
X-Proofpoint-GUID: KM_HUVbH9r9GCli7EIF_tqSVgZdQSVFi
X-Proofpoint-ORIG-GUID: KM_HUVbH9r9GCli7EIF_tqSVgZdQSVFi

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


