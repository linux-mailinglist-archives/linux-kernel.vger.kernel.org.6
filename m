Return-Path: <linux-kernel+bounces-422538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362869D9AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A305163E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7651D89EF;
	Tue, 26 Nov 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P3FvoJg1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B341D63F6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636628; cv=none; b=RrttI3H0P9m/3iZ2KVwGebwhkk/J6COuxU8UbPPP1uCbu1SljA4wwvjeRjqLHB6Nk4fHicCu2kPJCm+A4sqk4yxYzLLS/u5uggFk+nVFh6SBBgAXh3pW4BYYcpQMdzSNRbBwpO0hywSliMAK02xzB3hfmukLpyGkl25gq1/tpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636628; c=relaxed/simple;
	bh=mA54TR4JezK4xE/4cirZXykcN65B+WwNWMEXC6GU0f4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NF9FKptZfjazN9DtU3VVR1a/C4sFe5n/5wPUEDXdit3ZBqIZUUrTBdi5TJ4eJ2cYCLWEndHSZ68085tFbeziKkRg+SwDCJ8sUAF2NneP4lIK+9qbZ/vK6fdboCMLQQ53nsZrApdwiR45veF7JaPiVQWAJEIGmQ3amD2TCTHtlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P3FvoJg1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQCTsoi002420;
	Tue, 26 Nov 2024 15:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZiEzFkEEG/yOd1SYlmIUbRGREFxV/2noPsDQUv2e7
	+4=; b=P3FvoJg133j+VaaQ8p9Glw/lWNfDu96qeoVcWgbn1JHfItydm2EqnazlU
	Rdu999Tt2pGKY4ybj24BlGVtR7t+N1faGDtTVUc+cwTzgmH/mCGPfW7a3lILJOhC
	OGVCCPybZHO3kgL/D9F+AOrp197FHxEmVlJdZO3WKjIR7rWdLR1r+iLTRPbwBR4S
	0E3vRmF9KljS2gRuac7dXwrPssHec1m/YvM97W5nqE61I1VY3dr65dzSvPldX57+
	WOKqr05nOTGckCEoXT0hciST+CAUJpw/wP5i2OmSha9h7z2UpAA3kTdNMeFnU2PR
	ne6bLIatsVxAh7xXJrfEAyAod4PZg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 435ecmh0w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:57:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQFrnoZ002824;
	Tue, 26 Nov 2024 15:56:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 435ecmh0vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:56:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQEpjB0026370;
	Tue, 26 Nov 2024 15:56:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30vjp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:56:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQFuvir34079400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 15:56:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A28F2004B;
	Tue, 26 Nov 2024 15:56:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF79F20040;
	Tue, 26 Nov 2024 15:56:55 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 15:56:55 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2] mm: migrate: Removed unused argument vma from migrate_misplaced_folio
Date: Tue, 26 Nov 2024 09:56:54 -0600
Message-ID: <20241126155655.466186-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WxJmLFfR-jztPCh5UfWLIRIzY6oCxbi-
X-Proofpoint-GUID: FbdtrPHVT26p0mdygF1ze3MGpw1xuuCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260125

Commit ee86814b0562 ("mm/migrate: move NUMA hinting fault folio
isolation + checks under PTL") removed the code that had used
the vma argument in migrate_misplaced_folio.

Since the vma argument was no longer used in migrate_misplaced_folio,
this patch removed it.

changes:
V2:
  Added mm:migrate prefix in subject line.
V1:
https://lore.kernel.org/all/20241125075731.176573-1-donettom@linux.ibm.com/

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
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


