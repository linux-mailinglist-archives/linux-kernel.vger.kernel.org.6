Return-Path: <linux-kernel+bounces-185533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9C8CB668
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC357282807
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A214A4F3;
	Tue, 21 May 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozaHhLK3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2D14A4DF
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335717; cv=none; b=BXhQdh1NIfhUzz79PhWhjyBruTSAzvnM1rSDsvh2855WBQHxy5Iei8Gz8fpAzWS7zlaofb3EsezMpn2/FfiGzD2lB40iw9ujOdQYDq2w3Pk2O0awG9WupYYm08y42zGq4BpBpL7NnbCVE0nyaz2jxuhsgQDWJ/Fs++LwZ3DdoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335717; c=relaxed/simple;
	bh=xR/G2YwzoliqJGu1LnJE7SfCRlqGE6/LuzyY4cSKnBI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hg8dFzf3msbQkOJUWxRP6YT/rOI+YIJc5t/xKkBEyUioh+1nvOqvdGIxloRvYneuZN3ib1Rvvsmzlcs7xqeu8vU9fU0VdDrqp21W96IUMbwn077AR4NPTEqLTbQNDFGwfJc9v5DpwmnHfPkGy4+bpF7k9c+9geZ4IuLPThtyT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozaHhLK3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi3AL011519;
	Tue, 21 May 2024 23:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=aVvMSdU9di+/pg8Z/YTSNT+1WpNBkHB9jxFSgsTIf2I=;
 b=ozaHhLK3zTKdc2Hph/rlUXGL/acHXan8W2VjZFKVnfmWjoysXZ+EKLGG0vFyu/tvrPya
 YCF8MOAdfRcfbqCoYhyYwZHcEC7A5CVpcihcTC4H4SLMcSosNGiRqLRREaNFvk5+Yph+
 /3ODhSVoGnP4hTcU0GttTiST2tUhqyX85HZ3zgnZ0EO5B4s2SHY2HcRwqGaZGnhk4/k1
 HKVu+8RM0pY6Zdo6223C17NDHPOs9lkC+Y2hCkNWK+9R0JpRMivj9X4oytzJRRBN1Xi2
 rq2q/ELDQkZKru9HB5FqHGtqk1ArG7jiEjBhpZN48XcBjCr8hpjLdN9oFYWX0+olMErw Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdxkkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:55:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKS002667;
	Tue, 21 May 2024 23:55:00 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-2;
	Tue, 21 May 2024 23:55:00 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] mm/memory-failure: try to send SIGBUS even if unmap failed
Date: Tue, 21 May 2024 17:54:25 -0600
Message-Id: <20240521235429.2368017-2-jane.chu@oracle.com>
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
 engine=8.12.0-2405010000 definitions=main-2405210181
X-Proofpoint-ORIG-GUID: B4WTxpJGzidQZfA17erZRzLWZ4zjq7Hs
X-Proofpoint-GUID: B4WTxpJGzidQZfA17erZRzLWZ4zjq7Hs

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


