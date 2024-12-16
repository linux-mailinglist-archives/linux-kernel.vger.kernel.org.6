Return-Path: <linux-kernel+bounces-447762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518119F36C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B316437B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC12080F9;
	Mon, 16 Dec 2024 16:51:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C234207DF1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367908; cv=none; b=Fppn6JXTopZ88TUkrz28KpgMK6TTccCY7xAJj7F66HPtF5bD/uOQM6pPb3bx1+rOFp9fMNFngxDoeYdyqwAi5pNCJ3tFf9m4aBXEnxdUWpF/WftKuLdqk5/kZsEsicto9sEuT9HfPXvQ3CVJO+IUyTJnzxZO3IERNtEVD19IQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367908; c=relaxed/simple;
	bh=4+oEou68DnPE82MGvfHbNQ7lqyWYnBbY4LDya451PpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkUzn3+7zvTwcME/dtaHmRGcG3Eg9YYg6TBe3vc4tWNoQfI6srWxqoXzK319agMgIihRS37/bZ9xtZ3P/OF1pS5QZcFyZJFOrrCyZnUpMO/qJW8Ugncz32RG0Bc77f7Qssn6j0MDZ0D+nKmhBVeOTlO70x2c7EFX1Sn884h+sqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8152F11FB;
	Mon, 16 Dec 2024 08:52:13 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC6DC3F528;
	Mon, 16 Dec 2024 08:51:34 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd() -> ptes()
Date: Mon, 16 Dec 2024 22:20:54 +0530
Message-Id: <20241216165105.56185-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241216165105.56185-1-dev.jain@arm.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename prior to generalizing the collapse function.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99dc995aac11..95643e6e5f31 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -605,7 +605,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		folio = page_folio(page);
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
-		/* See hpage_collapse_scan_pmd(). */
+		/* See hpage_collapse_scan_ptes(). */
 		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
@@ -991,7 +991,7 @@ static int check_pmd_still_valid(struct mm_struct *mm,
 
 /*
  * Bring missing pages in from swap, to complete THP collapse.
- * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
+ * Only done if hpage_collapse_scan_ptes believes it is worthwhile.
  *
  * Called and returns without pte mapped or spinlocks held.
  * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
@@ -1263,7 +1263,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	return result;
 }
 
-static int hpage_collapse_scan_pmd(struct mm_struct *mm,
+static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 				   struct vm_area_struct *vma,
 				   unsigned long address, bool *mmap_locked,
 				   struct collapse_control *cc)
@@ -2457,7 +2457,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 					mmap_read_unlock(mm);
 				}
 			} else {
-				*result = hpage_collapse_scan_pmd(mm, vma,
+				*result = hpage_collapse_scan_ptes(mm, vma,
 					khugepaged_scan.address, &mmap_locked, cc);
 			}
 
@@ -2792,7 +2792,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 							  cc);
 			fput(file);
 		} else {
-			result = hpage_collapse_scan_pmd(mm, vma, addr,
+			result = hpage_collapse_scan_ptes(mm, vma, addr,
 							 &mmap_locked, cc);
 		}
 		if (!mmap_locked)
-- 
2.30.2


