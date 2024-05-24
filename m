Return-Path: <linux-kernel+bounces-189160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EE8CEBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93931282A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926C126F05;
	Fri, 24 May 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KW8Qwaw9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBF8612E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587639; cv=none; b=VGeymSiQrsGG19Q9Kga6rvW8fqApR+hv11En5217oxLpG+EvWCSLxc2rlcyQiQFKnzbe5D3A+dDfN0dB/KM6H8XILjPhjxgUTxkiIlr45UqcMl5a28ad2/EcmnOZMmzFy9D8Fxs0/gzDYOfG9pqRxlKA3NO3F/wLNE0S6gUH/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587639; c=relaxed/simple;
	bh=u+F3kkTCsexw6gGbJjFN/h7di0MuMht4yskvMifGQnc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KH6nrTEcHqbQiULP6e9tYQLWljMVIRO1joAItFAE9KNmkJ1IqSCd9Hb0BdbEWoYBkcmz3m1NoVAOYN8wUyhN2ersgI7vYB/fwHTpiLF6mmzaVUfmQjwhn7TXy+OhAw2V477qrVPm9OugE05IGknAJrPr4ztchmQoF60fnSjVoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KW8Qwaw9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OKTbZh023819;
	Fri, 24 May 2024 21:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=SihancN5k8LC/Hgj/5KOjJmpYjhXQMOG14zedpZ75B8=;
 b=KW8Qwaw9MgRTg2x6HgWx4L/6ultVBxcZu1IHaepybohYvCDch5isMwzqEapu2CteSb41
 KWsxMyoAa4IVCIzA3xHEdbiU/p+B0JNiK28ssP9KL1at9eBlEDlu9VQvIIPEV71Fe9tl
 paGzZjvKEZdH3GGMsFwvJI92QFHNMWlBqWjF+krfNuSlKwU/K20kV/2/DaWde3jORtEO
 tgndbaquKNWUHvyVk4U0GJOw9aDiQFSK6IoxCMC10njzgNpoESMeyt7brQPHCjwIorpk
 ndpalrOF/jweatfkpifBeTuvSXR0REwwlGLeLTp2455ym1GMtO9lc9Rf0X8ORikqiLFO Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7bcxts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG1O035956;
	Fri, 24 May 2024 21:53:47 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-5;
	Fri, 24 May 2024 21:53:47 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] mm/memory-failure: move hwpoison_filter() higher up
Date: Fri, 24 May 2024 15:53:05 -0600
Message-Id: <20240524215306.2705454-5-jane.chu@oracle.com>
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
X-Proofpoint-ORIG-GUID: OTsiOAKLEUfSAJALl24pXDTKjX6cQFx5
X-Proofpoint-GUID: OTsiOAKLEUfSAJALl24pXDTKjX6cQFx5

Move hwpoison_filter() higher up as there is no need to spend a lot
cycles only to find out later that the page is supposed to be skipped
from hwpoison handling.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d1fb1d6f6b11..85659dd0ea32 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2300,6 +2300,18 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	folio = page_folio(p);
+
+	/* filter pages that are protected from hwpoison test by users */
+	folio_lock(folio);
+	if (hwpoison_filter(p)) {
+		ClearPageHWPoison(p);
+		folio_unlock(folio);
+		folio_put(folio);
+		res = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+	folio_unlock(folio);
+
 	if (folio_test_large(folio)) {
 		/*
 		 * The flag must be set after the refcount is bumped
@@ -2363,14 +2375,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	page_flags = folio->flags;
 
-	if (hwpoison_filter(p)) {
-		ClearPageHWPoison(p);
-		folio_unlock(folio);
-		folio_put(folio);
-		res = -EOPNOTSUPP;
-		goto unlock_mutex;
-	}
-
 	/*
 	 * __munlock_folio() may clear a writeback folio's LRU flag without
 	 * the folio lock. We need to wait for writeback completion for this
-- 
2.39.3


