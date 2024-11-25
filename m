Return-Path: <linux-kernel+bounces-420551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9209D7C45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95657B22B91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37C14AD2D;
	Mon, 25 Nov 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGyxOn7m"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08755187FFA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521471; cv=none; b=gjC6oTSI1AlCpEP0eW4VFtYaUckj66HFppBcj4t7X6j4Kr3gElibW8dauvvIN6TXcWWEyNAC8cwhYxr0VW118eMNqludPo/qzePlrno3ZqNaoeG6I1PYkOEJF0tzOkQgPkiZEdx0JXe+6alNVdxIKFqEdsvXNSU95QeIhFOAPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521471; c=relaxed/simple;
	bh=3obunfAotuBU/BROqEAy4PvHXKeqvSqFEbV/eXhFQ/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PganGjsX0k4Et4ANLrmIaZCwbjYtwU+A0gdOCEpm+Ch9VtbVNKciDuzl865FckyhrJRO3K2BSeXBuiANP6dSWVbl4RWV9NqjBP0qSRBUgeKjqZHAd4Uc2iyalmCyaKs2dfEU1qHfJBSC2QxOo45iNW7kNZcgVtEEBqIg0a5cKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGyxOn7m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP17GER025594;
	Mon, 25 Nov 2024 07:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+298vbJ03oxsX1u8hV5uc77KWHGmqlCVmI7gA7Uzf
	cA=; b=gGyxOn7m3JL8tdeftcP6AyYp5L2lE3FtMaXtnYlrQw7usR7PbA0pAlUUf
	Mqf76C20MJtDhGPpP+QaL2/cmeCdzkH0AQYbfixctAQu0uI8Xn/CG5aVaC2CJgVQ
	SbzF2oNJseqAJt6MWYN90FCl1n8XjFhYQth3Dk8Q8lVVYBMgZUCC7lNlxFKNOLLp
	YnibgBHy+/b72tlsWCVJxwgebrvSSpzPCj7BT6dRJTaCU/FmkID5lYQONgh2fgSY
	GdIJd4iElfsYzqB4OT8BwMes0zRnxpqG5oqkM+R1CtCPZp9eNOwnO8sacbbDG9tT
	g7Asc6Gjs+NNyrAecqG0YutVg3sHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n75kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 07:57:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AP7f6sB028665;
	Mon, 25 Nov 2024 07:57:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n75kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 07:57:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP69k7H025320;
	Mon, 25 Nov 2024 07:57:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvjv7nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 07:57:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AP7vYsc59113958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 07:57:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D2320043;
	Mon, 25 Nov 2024 07:57:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA9D920040;
	Mon, 25 Nov 2024 07:57:32 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 07:57:32 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] Removed unused argument vma from migrate_misplaced_folio
Date: Mon, 25 Nov 2024 01:57:31 -0600
Message-ID: <20241125075731.176573-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XnqdJN7g93ah7a-rHYl2rZsSg83xyFbY
X-Proofpoint-ORIG-GUID: on-jaLuYUAhKykQAHhqnoVJ5zU5MaF2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=900 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250067

Commit ee86814b0562 ("mm/migrate: move NUMA hinting fault folio
isolation + checks under PTL") removed the code that had used
the vma argument in migrate_misplaced_folio.

Since the vma argument was no longer used in migrate_misplaced_folio,
this patch removed it.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 include/linux/migrate.h | 6 ++----
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 mm/migrate.c            | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 002e49b2ebd9..29919faea2f1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -144,16 +144,14 @@ const struct movable_operations *page_movable_ops(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
-int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
-			   int node);
+int migrate_misplaced_folio(struct folio *folio, int node);
 #else
 static inline int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
-static inline int migrate_misplaced_folio(struct folio *folio,
-					 struct vm_area_struct *vma, int node)
+static inline int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..ab46ef718b44 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2002,7 +2002,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
-	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
+	if (!migrate_misplaced_folio(folio, target_nid)) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..12bb79d4df72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5625,7 +5625,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ignore_writable = true;
 
 	/* Migrate to the requested node */
-	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
+	if (!migrate_misplaced_folio(folio, target_nid)) {
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
diff --git a/mm/migrate.c b/mm/migrate.c
index 2ce6b4b814df..411b378dd39f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2683,8 +2683,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
  * elevated reference count on the folio. This function will un-isolate the
  * folio, dereferencing the folio before returning.
  */
-int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
-			    int node)
+int migrate_misplaced_folio(struct folio *folio, int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
 	int nr_remaining;
-- 
2.37.2


