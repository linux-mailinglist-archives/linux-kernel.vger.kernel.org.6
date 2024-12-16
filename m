Return-Path: <linux-kernel+bounces-447774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44359F36E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AED18926D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627220B1E0;
	Mon, 16 Dec 2024 16:53:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679E20ADEC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368031; cv=none; b=PuS+nykRnwCrl7W9bcvpydiTXxrYHW7NZpKw0b4Z/txnO+QZ3iCL8oq3lwrt4qp/F/L260ZJKW+ogjJZ6BIOGRLU0dfOwdZ7SqRWqDZxyvSqH1cQa5MUP1yVcYt6+MFXGI4yq8FJEnms8iGB7GSG/7T0fXTdWGVgMVMFXsS7ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368031; c=relaxed/simple;
	bh=/XCD4xAd14x2YIkaw5c8j44TIdHV/AaMQm1xOv/49dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uh8xvoxso9EaDYvtrxNGgmQFkLXFCeNLQuCSbB3oOIS6TzMb83EQh4lrqUGeANq0pQwsyZdMqnKqM7V4c1mzjo50suDxnhs1Wf2nO3BtDaAaVaLgC99YRxoL9NzLDywX5vdH+ofgPw2Zc/2IS/qxoPK58VwqhhKrwb1QaZfL4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0479416F8;
	Mon, 16 Dec 2024 08:54:18 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A31E3F528;
	Mon, 16 Dec 2024 08:53:38 -0800 (PST)
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
Subject: [RFC PATCH 12/12] selftests/mm: khugepaged: Enlighten for mTHP collapse
Date: Mon, 16 Dec 2024 22:21:05 +0530
Message-Id: <20241216165105.56185-13-dev.jain@arm.com>
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

One of the testcases triggers a CoW on the 255th page (0-indexing) with
max_ptes_shared = 256. This leads to 0-254 pages (255 in number) being unshared,
and 257 pages shared, exceeding the constraint. Suppose we run the test as
./khugepaged -s 2. Therefore, khugepaged starts collapsing the range to order-2
folios, since PMD-collapse will fail due to the constraint.
When the scan reaches 254-257 PTE range, because at least one PTE in this range
is writable, with other 3 being read-only, khugepaged collapses this into an
order-2 mTHP, resulting in 3 extra PTEs getting unshared. After this, we encounter
a 4-sized chunk of read-only PTEs, and mTHP collapse stops according to the scaled
constraint, but the number of shared PTEs have now come under the constraint for
PMD-sized THPs. Therefore, the next scan of khugepaged will be able to collapse
this range into a PMD-mapped hugepage, leading to failure of this subtest. Fix
this by reducing the CoW range.

Note: The only objective of this patch is to make the test work for the PMD-case;
no extension has been made for testing for mTHPs.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 8a4d34cce36b..143c4ad9f6a1 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -981,6 +981,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared");
+	int fault_nr_pages = is_anon(ops) ? 1 << anon_order : 1;
 	int wstatus;
 	void *p;
 
@@ -997,8 +998,8 @@ static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops
 			fail("Fail");
 
 		printf("Trigger CoW on page %d of %d...",
-				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
-		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
+				hpage_pmd_nr - max_ptes_shared - fault_nr_pages, hpage_pmd_nr);
+		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared - fault_nr_pages) * page_size);
 		if (ops->check_huge(p, 0))
 			success("OK");
 		else
-- 
2.30.2


