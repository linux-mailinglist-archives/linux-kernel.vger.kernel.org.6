Return-Path: <linux-kernel+bounces-547459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A390FA50965
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCCA3ADF32
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E20255E30;
	Wed,  5 Mar 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIdVI7Ez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1F255238
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198590; cv=none; b=f32vVZvQR9nUUXY3+qxvQmps6IZ5SYHhk7oI3YbM7vnTd51YcaSBrGJFzGlb7VHcwmUEM4vR96YdmOfyY6jJJLeYyWW7wOkHgCX1MHqKNObAQEZyEHmU7hWfrc0dCfuQ02ikz8nLg5UFpzBhNpUGgFJmJFgBcgCevgCPJE1ec6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198590; c=relaxed/simple;
	bh=2xphIriEKA8i5rp9aYhxLxFxGr/HuEVyUJQbKTIJ9W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNZIk18IpYZzvRacujPoT6BziVboX4ZsTWBuRozEE2CytdcPwtLFlTdWct96FopA4HkB2fy9N6LHNw/1/xB3BKnOwGOkVzdGtbS5Kc1eBPnN+dE6OcI5iqA/6e5MPdrhKHy+O/29QYikRwEa0Wz/3bpipwpI+dqrtF2dnkSMcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIdVI7Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2FFC4CEEC;
	Wed,  5 Mar 2025 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198590;
	bh=2xphIriEKA8i5rp9aYhxLxFxGr/HuEVyUJQbKTIJ9W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIdVI7Ezc8/ZF2n0e2HlbbzQczYnvzGI5HusymbHblTUb8ZINUYydPwmj3Ni8dGNU
	 QylfDQt4OmqKTwR0TDaBNDmpHfEvCzdEbqbG+yzY8YFAbZ2JpoKjQYMf//LdaQIXjX
	 YrN7k4OweALQuFfzViR1+pHQmbV+YkvlqVzz2NEVMRkCRUvWciCj/FXV5PmE23qEaJ
	 3a2AlWAM7CkaK/nFKTlG154acKna2tJovPZeBSrDc/OMc4qnOIR5detGdZsRiJ7cCa
	 DrCp0ukPkgd8e/ouCQ2KiOQXvIFe8tTgEil7tRhrPP7G9gIvHyQSPx54gaSXTp7HJo
	 orNrTtIB5HhqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/16] mm/memory: split non-tlb flushing part from zap_page_range_single()
Date: Wed,  5 Mar 2025 10:16:04 -0800
Message-Id: <20250305181611.54484-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
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
out core part of zap_page_range_single() except mmu_gather object
initialization and gathered tlb entries flushing part for such batched
tlb flushing usage.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memory.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a838c8c44bfd..aadb2844c701 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2011,38 +2011,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
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

