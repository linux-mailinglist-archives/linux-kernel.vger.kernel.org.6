Return-Path: <linux-kernel+bounces-189159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12B8CEBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB08B20F65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAB83CBB;
	Fri, 24 May 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0IW7CgH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000750263
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587635; cv=none; b=JiefFhVpV/kagcEu9YifZJ0Zj53zpr2GhkYp6b84RsAVQYcmYMpnw3KXpTIm3TkujRJV5NCmwWtvbWezKsCYXkjoghyRkuA8OJibAiA/Ur9myFvWZUg5rp8uYba5j04XNnmnJOiOiBGWHkrYaVM1r7417DfyJSuaCPev1TP+zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587635; c=relaxed/simple;
	bh=D7kXXmKbXqjGmHdN4mg/BtutHXoSCD6re2jm29C5YuY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKbIxgpBeX5F2JbyNIgYcLjZRg+O1edNQQDJPZgGx0Bvew1EZeCiqECC5CLpP8YuBkiSoG/xuX65RGY4+XWJydXSuqGnnUw+7S58uNe557Oj9ri7XZ0kcDcqfUK0jPx+7v3goXzhLMFFGAwSoXI3qsxPzzDVblKCBGcZywPINFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0IW7CgH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OFx1PV020088;
	Fri, 24 May 2024 21:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=7HYN1EpHhN8K7/QWXfhCO5Xkdz0SMhL/TG8r2CsGXTY=;
 b=f0IW7CgHhxEM/jkAAr9fsWvW80EjOTg3U1E+Aunb7J/MnOxa8mzWmn5h8o+z36Ougs1R
 j7mySjed4aSn7Gj2WGdbKGKSDbyeUBeIJPMJ1ixkjbIe8AMwpxH1cQEhQ3bdjQk285MI
 uMCFag5BEhdMzWUituxLxLmpPr7qXrV9fkXyHeB+Foy19xBnGYm4LsWk9yYW0ljxREXl
 Y4I54CbIY1NB2m7nngKDmzJWwmnDIOwrrm1CSQTb1aV5ZGkysrq2rit8nPt3+aIpAWlj
 AKFIg9WwBL26PdNS9zBStJOBfx6FuwC7d08Zspm4khQP5eFIJbH1BGH8975OJFIIXm2l QQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mce5h56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG1C035956;
	Fri, 24 May 2024 21:53:42 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-4;
	Fri, 24 May 2024 21:53:42 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] mm/memory-failure: improve memory failure action_result messages
Date: Fri, 24 May 2024 15:53:04 -0600
Message-Id: <20240524215306.2705454-4-jane.chu@oracle.com>
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
 mlxlogscore=940 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240158
X-Proofpoint-ORIG-GUID: _mdySqjhmz_UPwiin9TJeXbOJ1k2kgS6
X-Proofpoint-GUID: _mdySqjhmz_UPwiin9TJeXbOJ1k2kgS6

Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
Attemped to document the definition of various action names, and made a few
adjustment to the action_result() calls.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h      |  2 ++
 include/ras/ras_event.h |  2 ++
 mm/memory-failure.c     | 37 ++++++++++++++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 5 deletions(-)

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
index 739311e121af..d1fb1d6f6b11 100644
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
+ * MF_FAILED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * It should have killed the process, but it can't isolate the page,
+ * due to conditions such as extra pin, unmap failure, etc. Accessing
+ * the page again may trigger another MCE and the process will be killed
+ * by the m-f() handler immediately.
+ *
+ * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * The page is unmapped, and is removed from the LRU or file mapping.
+ * An attempt to access the page again will trigger page fault and the
+ * PF handler will kill the process.
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
@@ -2055,6 +2080,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
+			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		}
 		return res;
 	} else if (res == -EBUSY) {
@@ -2062,7 +2088,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
-		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 	}
 
 	folio = page_folio(p);
@@ -2097,7 +2123,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
 		folio_unlock(folio);
-		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 	}
 
 	return identify_page_state(pfn, p, page_flags);
@@ -2231,6 +2257,7 @@ int memory_failure(unsigned long pfn, int flags)
 			res = kill_accessing_process(current, pfn, flags);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(p);
+		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
 
@@ -2267,7 +2294,7 @@ int memory_failure(unsigned long pfn, int flags)
 			}
 			goto unlock_mutex;
 		} else if (res < 0) {
-			res = action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
+			res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 			goto unlock_mutex;
 		}
 	}
@@ -2363,7 +2390,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
 	 */
 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
-		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
+		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
 		goto unlock_page;
 	}
 
-- 
2.39.3


