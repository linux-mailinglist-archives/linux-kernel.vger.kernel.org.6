Return-Path: <linux-kernel+bounces-185535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF9C8CB66A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F57E1F220B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDC14A0BD;
	Tue, 21 May 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQwrzgK3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD18149DEC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335750; cv=none; b=JaNgTIHZgkaxyV7Nb5al5jyFxUTQB3DOwxE/B4+xXxl+M2JjNgG0Uv4m+VZHb8lsbLa+61TNdt0h41cwWSNMb0fJeWd3I9xOxUvaiHKYF+vYp6j/iFKHh/yoocOQr5sHIxbjUWy++d9pbA9Jlg4RefAXqc5vbN1/YYGkUuWfRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335750; c=relaxed/simple;
	bh=NB2jyb5H8LkQB9X2o+xFzjZ2NRKzw7+VkG8ZmX9AVy0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3nCOc/7D762X92sYilSgVOpT+1vv5HNvhUCSijEKg1x+2Q+pSieUkJiJ+GcnvlKxAKVDDW4H4ufd107yY62JydeqSPWTPAypuqQm5s3Eir9HkXGkQDejWlWDX2A5lh1Iyx8j3VOYg5jFRXW4n1+azZRttr3LuNE6KrTjzVeZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQwrzgK3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJkHCC013661;
	Tue, 21 May 2024 23:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=z1prDriYsI1wDXlPHr/vQoqHCvjGzLHUUrEOL1odZwA=;
 b=eQwrzgK3aMomHfB7BcblbNJAV6zG7N5li0pTBG3/PANsHRjFFClVxSG/0iv1hdzzVik0
 v43Hb76Z/loeDVLJ25W7WhaSHhRI4wYwUVUhHGG1w35EOwGBUH1M5nBLCpGYC/NbcFEs
 6HFrOyPu8EKSaLfiB5MaJHGD3g/zm97+lDJz8ODp7TGXc1xZ0wr793eHT0qmlNaBU4h3
 kOM81VIUcEodc/lAR1XqpfzongQK+7JQR9ijLMP9JoPpBk1IBhk7+fTvmwqDN7ez0gAC
 9eWxMn7u+VgfQbpzYDDaJdZbSpbgknlAe9LgiAMQsIRaW/KSOgnWCwNgu0d4cvMG/Dl6 SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv6gts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:55:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKX002667;
	Tue, 21 May 2024 23:55:35 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-4;
	Tue, 21 May 2024 23:55:34 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] mm/memory-failure: improve memory failure action_result messages
Date: Tue, 21 May 2024 17:54:27 -0600
Message-Id: <20240521235429.2368017-4-jane.chu@oracle.com>
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
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=869
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210182
X-Proofpoint-ORIG-GUID: KXCpqkLnQd7MXtvCJkmrwN85KoMMhWcb
X-Proofpoint-GUID: KXCpqkLnQd7MXtvCJkmrwN85KoMMhWcb

Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
Attemped to document the definition of various action names, and made a few
adjustment to the action_result() calls.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/mm.h      |  2 ++
 include/ras/ras_event.h |  2 ++
 mm/memory-failure.c     | 38 +++++++++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..b4598c6a393a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4111,6 +4111,7 @@ enum mf_action_page_type {
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
+	MF_MSG_GET_HWPOISON,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
@@ -4124,6 +4125,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
+	MF_MSG_ALREADY_POISONED,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c011ea236e9b..b3f6832a94fe 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -360,6 +360,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
@@ -373,6 +374,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 739311e121af..1e22d73c9329 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -879,6 +879,28 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	return ret > 0 ? -EHWPOISON : -EFAULT;
 }
 
+/*
+ * MF_IGNORED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * But it could not do more to isolate the page from being accessed again,
+ * nor does it kill the process. This is extremely rare and one of the
+ * potential causes is that the page state has been changed due to
+ * underlying race condition. This is the most severe outcomes.
+ *
+ * MF_FAILED - The m-f() handler marks the page as PG_hwpoisoned'ed. It
+ * should have killed the process, but it can't isolate the page, due to
+ * conditions such as extra pin, unmap failure, etc. Accessing the page
+ * again will trigger another MCE and the process will be killed by the
+ * m-f() handler immediately.
+ *
+ * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed. The
+ * page is unmapped, but perhaps remains in LRU or file mapping. An attempt
+ * to access the page again will trigger page fault and the PF handler
+ * will kill the process.
+ *
+ * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * The page has been completely isolated, that is, unmapped, taken out of
+ * the buddy system, or hole-punnched out of the file mapping.
+ */
 static const char *action_name[] = {
 	[MF_IGNORED] = "Ignored",
 	[MF_FAILED] = "Failed",
@@ -893,6 +915,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
+	[MF_MSG_GET_HWPOISON]		= "get hwpoison page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -906,6 +929,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1013,12 +1037,13 @@ static int me_kernel(struct page_state *ps, struct page *p)
 
 /*
  * Page in unknown state. Do nothing.
+ * This is a catch-all in case we fail to make sense of the page state.
  */
 static int me_unknown(struct page_state *ps, struct page *p)
 {
 	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
 	unlock_page(p);
-	return MF_FAILED;
+	return MF_IGNORED;
 }
 
 /*
@@ -2055,6 +2080,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
+			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+			return res;
 		}
 		return res;
 	} else if (res == -EBUSY) {
@@ -2062,7 +2089,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
-		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 	}
 
 	folio = page_folio(p);
@@ -2097,7 +2124,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
 		folio_unlock(folio);
-		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 	}
 
 	return identify_page_state(pfn, p, page_flags);
@@ -2231,6 +2258,7 @@ int memory_failure(unsigned long pfn, int flags)
 			res = kill_accessing_process(current, pfn, flags);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(p);
+		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
 
@@ -2267,7 +2295,7 @@ int memory_failure(unsigned long pfn, int flags)
 			}
 			goto unlock_mutex;
 		} else if (res < 0) {
-			res = action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+			res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 			goto unlock_mutex;
 		}
 	}
@@ -2363,7 +2391,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
 	 */
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
-		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 		goto unlock_page;
 	}
 
-- 
2.39.3


