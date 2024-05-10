Return-Path: <linux-kernel+bounces-175321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEA8C1E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3176F1C20DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215B1635BF;
	Fri, 10 May 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRuQN/xM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6061607AC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322394; cv=none; b=UYgsdo4nqSlm4ZsMZ4F9Hy+Q+SAcrmHqWryZf6aXkESGcHtT4U6ivy7tkCZO++VIw5QrsDOLDkkgz9eH3fkM8AE7rXz6Ktv56nafHJrFqp2h11rDlGITICqi+vi6u4d7S5cPv3Woly+ZMG08untbHgpi9imiPNQzoMgP/trzK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322394; c=relaxed/simple;
	bh=y3xH+3hjLxbEC05EGc7rW1iUH9Sb7wWK1YJNYK9P/vk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcJakhUtBB1I07lEngKNzpLHBaePHfMe3v9jLy6EnYPTEo+EwSTbAkWFpGTLHb/p4/3YsOGX8+QpdSNUDMQfGQp+Aole9jNZAB911LxVxu53avce4K4vcIUydxqqGatk1S0hb4y3BIHTGrm+EUGG4LVUnGLwX6FZVqzWXrlK4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lRuQN/xM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5Uk36011962;
	Fri, 10 May 2024 06:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=qec/kt8yhdFKEAaIHR/lBrJDjyfV3DVrQvjyrnvIHpI=;
 b=lRuQN/xMOVSxjVnhzDm+Pq4HIhcUC8yYEOf9Z2eUsA+MLCdtw0r5l4Pombb7wH6UCjOI
 DAYYVBc4bniRlWOm21BPU76OjthY5i0QfqOWVvzwathI0D/W6CQ7uuHBwMV2j0ymnBVI
 ThHaUIo3ooFviW92KbMemp3N1RH9kHybAN3w88XwqwFnJ86LuxAT3grjvFuDiqYUlpxM
 4E3MGarfapaworMInHdK4rD/QALsuDuZONl/Vs8EvtzVfYnk/ELOp7bWs11EOlM63156
 9Sq7AM5bSR1uXmHuJE6cagWmhGhhowmzdH7z2hzzmkJkhWEpKuNwR5yV2arNMnb2X0mT Qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y17x7recv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjL020104;
	Fri, 10 May 2024 06:26:21 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-5;
	Fri, 10 May 2024 06:26:20 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm/memory-failure: move hwpoison_filter() higher up
Date: Fri, 10 May 2024 00:26:01 -0600
Message-Id: <20240510062602.901510-5-jane.chu@oracle.com>
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
X-Proofpoint-GUID: o2ec6oR7IMYucBVlxbovuoOEzvuShcLi
X-Proofpoint-ORIG-GUID: o2ec6oR7IMYucBVlxbovuoOEzvuShcLi

Move hwpoison_filter() higher up as there is no need to spend a lot
cycles only to find out later that the page is supposed to be skipped
for hwpoison handling.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 62133c10fb51..2fa884d8b5a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2236,6 +2236,13 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	if (hwpoison_filter(p)) {
+		if (flags & MF_COUNT_INCREASED)
+			put_page(p);
+		res = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 try_again:
 	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
 	if (hugetlb)
@@ -2354,14 +2361,6 @@ int memory_failure(unsigned long pfn, int flags)
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


