Return-Path: <linux-kernel+bounces-530093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13369A42EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AEF3B3CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F31C84A4;
	Mon, 24 Feb 2025 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rbmmk0F0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A21547D8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431720; cv=none; b=AR+h6qm4FM69IthvfIUr2aSoylVl89C0Fr40QtB5MVkaebAN8liBlszwLkpGDT6FCzIcI2dkIxN9Me4E3Dg6X8ovWxwxmfjdnOKdIFffQA6qBeWfPf9KQcCY/BsnLGtoczch+luM0MOgByrNOtGPncOCtNb5MnCAbwZc5n6W8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431720; c=relaxed/simple;
	bh=SzWhDox/ZZ84Bhq/HQ8Yj2avpJ6FGkXI59fJhTn7u5Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BHVTJp4iPYLhOay0GA/NIPsODaNJorpM2klBBwVUD3rkQlx3oFqGfb2EPn03UaIxPOtTWRyg65vl+LUCrjRy8+6nIFwXvF0/XsUaKvVmaf2dYCxQlVjQ0q4B1VNpR957kKSk0+CsfJIdzScR2LF4rrSsPQ9f3WOujxr36ljy5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rbmmk0F0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKfgIo016961;
	Mon, 24 Feb 2025 21:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=4SpDzd6ns5HXEJHJoua6NBwPKsjFU
	DkJuO+bUORWJN8=; b=Rbmmk0F0nGwTQClJDRgQhjwgklyYkoRdXCOhaq8LlYeEz
	WPB38nSJ8d5GZfFzoQ3op31dNtCOq4ZHjlT+uqiwAHkAUetRFMcW707t2GbHB4k1
	G/m3IbEPLBOxdXiZEeKasCj/yYhLOqDMFWzdwv9NgNR/yAlsfg+igLLcCmvxxuSs
	lLvu3U+fbhcAseFrDHgs45oIOaAFZ+fGh63elpZtk1D5AXq4QSEuGLOXJRPiEjNU
	xwJtHMEmjiaEW1dFYRYxjei+P2+utetd0yw6csFzZBEm2+yqk6AE8jS2fpkGN6wV
	1IR2j0mRpL+z72O32ezFaYqTwTcN45dJeqn2LAPOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gakmuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:15:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLBGEV025436;
	Mon, 24 Feb 2025 21:15:01 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y51esy6a-1;
	Mon, 24 Feb 2025 21:15:01 +0000
From: Jane Chu <jane.chu@oracle.com>
To: willy@infradead.org, peterx@redhat.com, akpm@linux-foundation.org,
        linmiaohe@huawei.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: make page_mapped_in_vma() hugetlb walk aware
Date: Mon, 24 Feb 2025 14:14:45 -0700
Message-Id: <20250224211445.2663312-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240135
X-Proofpoint-ORIG-GUID: _QOr_NTjz6qd5eiFeNKLAKMJI1-HAInh
X-Proofpoint-GUID: _QOr_NTjz6qd5eiFeNKLAKMJI1-HAInh

When a process consumes a UE in a page, the memory failure handler
attempts to collect information for a potential SIGBUS.
If the page is an anonymous page, page_mapped_in_vma(page, vma) is
invoked in order to
  1. retrieve the vaddr from the process' address space,
  2. verify that the vaddr is indeed mapped to the poisoned page,
where 'page' is the precise small page with UE.

It's been observed that when injecting poison to a non-head subpage
of an anonymous hugetlb page, no SIGBUS show up; while injecting to
the head page produces a SIGBUS. The casue is that, though hugetlb_walk()
returns a valid pmd entry (on x86), but check_pte() detects mismatch
between the head page per the pmd and the input subpage. Thus the vaddr
is considered not mapped to the subpage and the process is not collected
for SIGBUS purpose.  This is the calling stack
      collect_procs_anon
        page_mapped_in_vma
          page_vma_mapped_walk
            hugetlb_walk
              huge_pte_lock
                check_pte

check_pte() header says that it
"check if [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) is mapped at the @pvmw->pte"
but practically works only if pvmw->pfn is the head page pfn at pvmw->pte.
Hindsight acknowledging that some pvmw->pte could point to a hugepage of
some sort such that it makes sense to make check_pte() work for hugepage.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/page_vma_mapped.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 81839a9e74f1..367209e65830 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -84,6 +84,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
  * mapped at the @pvmw->pte
  * @pvmw: page_vma_mapped_walk struct, includes a pair pte and pfn range
  * for checking
+ * @pte_nr: the number of small pages described by @pvmw->pte.
  *
  * page_vma_mapped_walk() found a place where pfn range is *potentially*
  * mapped. check_pte() has to validate this.
@@ -100,7 +101,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
  * Otherwise, return false.
  *
  */
-static bool check_pte(struct page_vma_mapped_walk *pvmw)
+static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 {
 	unsigned long pfn;
 	pte_t ptent = ptep_get(pvmw->pte);
@@ -133,7 +134,11 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		pfn = pte_pfn(ptent);
 	}
 
-	return (pfn - pvmw->pfn) < pvmw->nr_pages;
+	if ((pfn + pte_nr - 1) < pvmw->pfn)
+		return false;
+	if (pfn > (pvmw->pfn + pvmw->nr_pages - 1))
+		return false;
+	return true;
 }
 
 /* Returns true if the two ranges overlap.  Careful to not overflow. */
@@ -208,7 +213,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return false;
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
-		if (!check_pte(pvmw))
+		if (!check_pte(pvmw, pages_per_huge_page(hstate)))
 			return not_found(pvmw);
 		return true;
 	}
@@ -291,7 +296,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			goto next_pte;
 		}
 this_pte:
-		if (check_pte(pvmw))
+		if (check_pte(pvmw, 1))
 			return true;
 next_pte:
 		do {
-- 
2.39.3


