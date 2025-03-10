Return-Path: <linux-kernel+bounces-554794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075DA59DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EFD18890C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78413235BF5;
	Mon, 10 Mar 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYzz/5cX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A52356CA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627410; cv=none; b=AvpwlDSeJnh0dxj+0RMv3MJFfa6VJOz0PIzA13AdqD9pGeeTDhzg6bcxTU0zuW4P7LvZ1ERJ+zuiAX+mNybIAIM1i8trKdMdVPWG2m/OVLGxsFhgslVr8YPtJLrGVcG5Xi3H13zZPzxLn7nkBAK2J0uyodTOHJJEsDKV/vvNDWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627410; c=relaxed/simple;
	bh=zqoCyf4FJzGNezZ0ikot3jkjvp+Q80Kl3ZyQNT+Fx4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SF9o4la9aUsAUTi+T6okXEXFKD9QRChnDa5cc7v5b32OSQeb/jEtj5+Pwg3IiEEarSnhrH0mpwACFMqK53ctFqS1/YqQDUP/qYeMIcyP41XQipxuaj5Vk8MyF7z+IBxDBAhWUXOEFYG/7G+Vqu90vJ30I/SRT5BJp3SvAOrRXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYzz/5cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA1FC4CEF5;
	Mon, 10 Mar 2025 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627410;
	bh=zqoCyf4FJzGNezZ0ikot3jkjvp+Q80Kl3ZyQNT+Fx4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYzz/5cXRxoUPQlKUgpos/cWLuZ2KWn45gHyU3U9M75uGnPaM5UcQwf/511qy1Tp2
	 glCushNsOICZVKgFqNF987iZhCb+LBCWfScQQSy2z8vFAQqxetIkwYZsaB6A7BDeqM
	 tUv73/Id2lgNh4yQOttjQdClVnd7xQMbsU5nybe6xig4aN7Lf/bXIYsmv2PxyGBXfh
	 VLAnoMfZ/TE7CD0N3y+FbIZ+Cx8wkKXwlIWOKgmHD+Jj6vJ35J55zMYCNqUIcHqfZ6
	 jUqkG1jkGhq0i23slle4gJZMbR5KcqoAVdll1VNfk8SQZre7lOfG2QaUJnROV1GTI6
	 QX/2LPUg6599g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/9] mm/memory: split non-tlb flushing part from zap_page_range_single()
Date: Mon, 10 Mar 2025 10:23:15 -0700
Message-Id: <20250310172318.653630-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310172318.653630-1-sj@kernel.org>
References: <20250310172318.653630-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of zap_page_range_single() callers such as [process_]madvise() with
MADV_DONEED[_LOCKED] cannot batch tlb flushes because
zap_page_range_single() does tlb flushing for each invocation.  Split
out the body of zap_page_range_single() except mmu_gather object
initialization and gathered tlb entries flushing parts for such batched
tlb flushing usage.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memory.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78c7ee62795e..88c478e2ed1a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1995,38 +1995,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 	mmu_notifier_invalidate_range_end(&range);
 }
 
-/**
- * zap_page_range_single - remove user pages in a given range
- * @vma: vm_area_struct holding the applicable pages
- * @address: starting address of pages to zap
- * @size: number of bytes to zap
- * @details: details of shared cache invalidation
- *
- * The range must fit into one VMA.
- */
-void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
+static void unmap_vma_single(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
 	const unsigned long end = address + size;
 	struct mmu_notifier_range range;
-	struct mmu_gather tlb;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
 	hugetlb_zap_begin(vma, &range.start, &range.end);
-	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	/*
 	 * unmap 'address-end' not 'range.start-range.end' as range
 	 * could have been expanded for hugetlb pmd sharing.
 	 */
-	unmap_single_vma(&tlb, vma, address, end, details, false);
+	unmap_single_vma(tlb, vma, address, end, details, false);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb);
 	hugetlb_zap_end(vma, details);
 }
 
+/**
+ * zap_page_range_single - remove user pages in a given range
+ * @vma: vm_area_struct holding the applicable pages
+ * @address: starting address of pages to zap
+ * @size: number of bytes to zap
+ * @details: details of shared cache invalidation
+ *
+ * The range must fit into one VMA.
+ */
+void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
+		unsigned long size, struct zap_details *details)
+{
+	struct mmu_gather tlb;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	unmap_vma_single(&tlb, vma, address, size, details);
+	tlb_finish_mmu(&tlb);
+}
+
 /**
  * zap_vma_ptes - remove ptes mapping the vma
  * @vma: vm_area_struct holding ptes to be zapped
-- 
2.39.5

