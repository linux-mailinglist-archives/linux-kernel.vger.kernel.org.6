Return-Path: <linux-kernel+bounces-185536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2FE8CB66B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93BA282807
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A514A4D2;
	Tue, 21 May 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3CrhepT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904214A4E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335756; cv=none; b=BOTJzG7hXY2GIz9+O2S3ryP2kDZF89OHNtcNeQ4v1ZK7/YDDFKlKJeqdc4oq9sl704PNAe/hp+su/SYU06hcwGIcp4lwL2wC80Dh/DaUkKM2d7dFtFG28P/kypgakve4RW0Lr43n/gj2XGiBMs5ljC9cxOCF9lwHzJs5TjW1nBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335756; c=relaxed/simple;
	bh=ihTcaZfF9lRkBEAHfa67ibCvGJNlg5fyNNR5cehumz4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ozxrsy0GoGgBWsQr9oIrKNTkhJUx2RdOB6SP78tYHgm2zYUW+TipUttqVV+VrlVLssznQlE0FjenLZxyD585EfE1adiv2yG1TdkMTRqFjeMxDAwC+JGOWsjNqeMhqKzcCH0OpbUGsjenPZZ7qR3M5nhrMdqcwwb5jYiypSU9O/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3CrhepT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi8dZ025724;
	Tue, 21 May 2024 23:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=frA7aS1vLKTncyYL7L1DmGtD13xbXGlpWxyw+e4B7WM=;
 b=h3CrhepTNn/GaGgIJzZhqtsA7faeT1QZf89SKUeSOVcUQEJKLeokWgdytocXbQ/tR6wd
 mvdIHTnqEutpHvRGnRnDRNy0BeIXtqXtEbZ19zn0/AMebwZaz97AqmHJl6VA8GQ9RSTX
 pkUkL+cbnjeDIQ9wc72PTtUQeyieP/pbryXb98HMIJAmqNl+yM1zEXbTU2pRXuNfmKWU
 FPTPhJh4CglqeOBXb7DRzY9IM3xTiV1SHJRB6BybSR0VEj91El9FE9C8CCVzQpW2w7w1
 ORy8M037XhGzohEkU3LnrD3PKhweG9vEWPfIaeaIiUMP5WMgGC7tBF7q/V3BPMrYnm8H 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k466m2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:55:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKi002667;
	Tue, 21 May 2024 23:55:39 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-5;
	Tue, 21 May 2024 23:55:39 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] mm/memory-failure: move hwpoison_filter() higher up
Date: Tue, 21 May 2024 17:54:28 -0600
Message-Id: <20240521235429.2368017-5-jane.chu@oracle.com>
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
X-Proofpoint-ORIG-GUID: fN-L7z8FkqKuAIhlYwvx_1gv1456QLzQ
X-Proofpoint-GUID: fN-L7z8FkqKuAIhlYwvx_1gv1456QLzQ

Move hwpoison_filter() higher up as there is no need to spend a lot
cycles only to find out later that the page is supposed to be skipped
from hwpoison handling.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 1e22d73c9329..794196951a04 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2301,6 +2301,18 @@ int memory_failure(unsigned long pfn, int flags)
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
@@ -2364,14 +2376,6 @@ int memory_failure(unsigned long pfn, int flags)
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


