Return-Path: <linux-kernel+bounces-548281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3827A542CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2750A16BA61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC21A5BA1;
	Thu,  6 Mar 2025 06:31:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2791A23BD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242676; cv=none; b=WrZCvvi/FxRNITELQphTK3Ik7nF1MDzyL7ubGhv/hopcAoUoOUaVM6t4OeBCdS4V1HBJqaMP/B3O9DVn5qTU3WCpsgGcrHZUdQZCs+y3KyrrbtMc/9w9JBW2Jje/xe707ebTCxYSahYsKrFEws59HEQ9T8QW5BPpNbaUU6JZZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242676; c=relaxed/simple;
	bh=cxT47ijM+0vYDh0CvTEqDA5OOZLhZdqFfLxf6rOhvwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yx6cRMvH6Tpd0UTzIwMDnj2RqYkIbVmelc0NxcWDfG59oTGvBSB34fCIboJ/sC9foDhF2McSrLdGoqy/zAkmQicpra28m04syaaSz9HrO6FrJjUWnvxpYXr2MPTF7kTo/2JG6nkKol1JqID6FI0X84ONrRoiNMNgBXKKvLWnBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087B8FEC;
	Wed,  5 Mar 2025 22:31:25 -0800 (PST)
Received: from K4MQJ0H1H2.emea.arm.com (K4MQJ0H1H2.blr.arm.com [10.162.43.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CDD83F673;
	Wed,  5 Mar 2025 22:31:06 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	david@redhat.com,
	willy@infradead.org,
	hughd@google.com,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm/vma: Do not register private-anon mappings with khugepaged during mmap
Date: Thu,  6 Mar 2025 12:00:37 +0530
Message-Id: <20250306063037.16299-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already are registering private-anon VMAs with khugepaged during fault
time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
file vmas for khugepaged" moved the khugepaged registration logic from
shmem_mmap to the generic mmap path. Make this logic specific for non-anon
mappings.

Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index af1d549b179c..730a26bf14a5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2377,7 +2377,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
-	khugepaged_enter_vma(vma, map->flags);
+	if (!vma_is_anonymous(vma))
+		khugepaged_enter_vma(vma, map->flags);
 	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;
-- 
2.30.2


