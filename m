Return-Path: <linux-kernel+bounces-175322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246978C1E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBBB282A00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC215E81C;
	Fri, 10 May 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H0PXqMVr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C81607A0
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322395; cv=none; b=VbGVizOIqH9/6eCHFde+uK74opLzZCTZvo+uzM36nIwHKSokfvPAoDNP2FzhJzDUMbfKoJWlHHpZnzxEB0+1/fTNagYv4kIIPek9IaErgbLuJ2Eli6V2qlo4GiU3+GwC9VyT78P82Itol9qc63/eeEiiiLnSoqfkvjWtu7pQLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322395; c=relaxed/simple;
	bh=CAuOkel/LqRo1NMDUWv5wRqXBLBpH6DPowOjYYYlZHI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0JUHYFZLhKe/NQtcIRLPckZXhuLiBN6dltpNQyAY9cutSdwpoabb0RurSlOirxIG76OTgiIgL8JuwTyGxXuBfOSPFrwhWCwAlJnXyz0T+5qNyWLboCO9MrkNp1bgAMKwCDb+1ZvP0EyfE1h796XuZMZfXsZDE/2SU1q5YXmSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H0PXqMVr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5t5Pw016630;
	Fri, 10 May 2024 06:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=viAyLHVrzHmyiEoKjeAdCo+t9ZTJA9p8OiNJ7HBHR+g=;
 b=H0PXqMVrGbNDFU8FnAuHXRnL6b4Ig4izVN/GdNGiOReqYUvngSa5ejZeqvvQ5K4u5Em4
 Qh60056Xfp1+LV8p9JxcKYM0dUN1P09xHNDauOccr/WuDICMUgxLQ935GZt3rBGqjis+
 hTeJe1dSch39ZV14iqOIRHGEpM6oPAZkluMStLyEp4PQ9V0BmrfHJb2J22dmWGBlGfgM
 Lf2n1YeUvUqv0eViouFw+l2pwhQLLJr1M/ss+RS5IH5a6OkyhbFFVEBL853d7LTFMwn5
 vUWAYpcu91RtaFuToRxQtEQXMJYpHDHI3g8J3NQMvybc++cjOK8uV4Lozn1fsv2RZ6LQ Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1a0j88g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjK020104;
	Fri, 10 May 2024 06:26:18 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-4;
	Fri, 10 May 2024 06:26:18 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] mm/memory-failure: improve memory failure action_result messages
Date: Fri, 10 May 2024 00:26:00 -0600
Message-Id: <20240510062602.901510-4-jane.chu@oracle.com>
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
 mlxlogscore=690 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100044
X-Proofpoint-ORIG-GUID: 9Wi8zJK1XSS8g6hfb26O6JAQMP9nYrJq
X-Proofpoint-GUID: 9Wi8zJK1XSS8g6hfb26O6JAQMP9nYrJq

Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
Attemped to document the definition of various action names, and made a few
adjustment to the action_result() calls.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/mm.h      |  2 ++
 include/ras/ras_event.h |  2 ++
 mm/memory-failure.c     | 28 +++++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

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
index 739311e121af..62133c10fb51 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -879,6 +879,20 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	return ret > 0 ? -EHWPOISON : -EFAULT;
 }
 
+/*
+ * MF_IGNORED - Either the m-f() handler did nothing to recover, or it did
+ *   something, then caught in a race condition which renders the effort sort
+ *   of moot. This is perhaps the most sever.
+ * MF_FAILED - The m-f() handler might have killed the process, but it can't
+ *   do much to the poisoned page other than marking it poisoned, due to
+ *   conditions such as extra pin, unmap failure, etc.
+ * MF_DELAYED - The poisoned page has been unmapped but not completely isolated,
+ *   such as page might remain in LRU. But an attempt by userspace process
+ *   to access the page again will hit page fault which will kill the process.
+ * MF_RECOVERED - The poisoned page has been completely isolated, via unmap,
+ *   taking the page out of the buddy system, or hole punching out of the
+ *   mapping.
+ */
 static const char *action_name[] = {
 	[MF_IGNORED] = "Ignored",
 	[MF_FAILED] = "Failed",
@@ -893,6 +907,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
+	[MF_MSG_GET_HWPOISON]		= "get hwpoison page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -906,6 +921,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1018,7 +1034,7 @@ static int me_unknown(struct page_state *ps, struct page *p)
 {
 	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
 	unlock_page(p);
-	return MF_FAILED;
+	return MF_IGNORED;
 }
 
 /*
@@ -2055,6 +2071,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
+			return action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		}
 		return res;
 	} else if (res == -EBUSY) {
@@ -2062,7 +2079,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
-		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 	}
 
 	folio = page_folio(p);
@@ -2097,7 +2114,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
 		folio_unlock(folio);
-		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 	}
 
 	return identify_page_state(pfn, p, page_flags);
@@ -2231,6 +2248,7 @@ int memory_failure(unsigned long pfn, int flags)
 			res = kill_accessing_process(current, pfn, flags);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(p);
+		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
 
@@ -2267,7 +2285,7 @@ int memory_failure(unsigned long pfn, int flags)
 			}
 			goto unlock_mutex;
 		} else if (res < 0) {
-			res = action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+			res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 			goto unlock_mutex;
 		}
 	}
@@ -2363,7 +2381,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
 	 */
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
-		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 		goto unlock_page;
 	}
 
-- 
2.39.3


