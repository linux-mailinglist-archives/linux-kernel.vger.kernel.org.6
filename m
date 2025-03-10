Return-Path: <linux-kernel+bounces-554795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34DA59DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF563A7575
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20EB23644F;
	Mon, 10 Mar 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSx76SP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223A231A2A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627412; cv=none; b=NXCCxDCnSHYYvitjIeCt0dr6fSgxDU8Mt+JxcI6/+qB/3WRP6eauVXhpZQt67mymLx0fxVANMsTT15swrYOxFouOf8PYR8/mY5XdLPo3gUBgmeuxyyLmQMCjLna1esxHgoXZdgbkjMZwG8Ck1IA3nGH9UBRsOHPRtpm0ya7Rthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627412; c=relaxed/simple;
	bh=RSFUpifN3HuVWoEj944CoZ0VVGpww5B6SbD8iILWaq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8QvEnJ2h+dvZsCjPLsNuegJJiGnNx1iMcaex2of296UMmPQbqzP4mkMbirvc9fzjDDnx9BxZ2TFwI4s3pJynUE0ULl7yM5FdD7nIek0Ty4GO/pssj9RwjJy3pdhgzZqBT/LdJ5uV7MqGt8c3TOitG+rkRMiu8fLjLDXaziWvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSx76SP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDEC4CEED;
	Mon, 10 Mar 2025 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627411;
	bh=RSFUpifN3HuVWoEj944CoZ0VVGpww5B6SbD8iILWaq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSx76SP1aMWn5lYQ40SpWdThFZAVcwsocl3ap/sjfMRB7710mfqiSRU6pLK6zibY+
	 /JVK/IYLx1GfYEXDCgblSfJbiMNgX96eIfr3qx8F+pOU+KqVLcvH3sqjmx4o8rUgS2
	 8xu2CsWKaUtKwmy6yCSvJLoHKNOkTkLlB25SLTWdsjZ4GzC0OaJhZtNXn798S5yRAE
	 HHwcXczG6UftPqSdNetvITTqiLoPeMA3WDlTu4ynL3Wkd7HhCMVxVOvpYEGTmTkSf5
	 Dwo21kDvLQYj+Y2+Ka8/D3qsv0CE7h3+tuFfOS42mpzYM3XRqlPTHO4EyILJQjMfvr
	 oP5hoQkQjgILA==
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
Subject: [PATCH 7/9] mm/madvise: let madvise_{dontneed,free}_single_vma() caller batches tlb flushes
Date: Mon, 10 Mar 2025 10:23:16 -0700
Message-Id: <20250310172318.653630-8-sj@kernel.org>
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

Update madvise_dontneed_single_vma() and madvise_free_single_vma()
functions so that the caller can pass an mmu_gather object that should
be initialized and will be finished outside, for batched tlb flushes.
Also modify their internal code to support such usage by skipping the
initialization and finishing of self-allocated mmu_gather object if it
received a valid mmu_gather object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h |  3 +++
 mm/madvise.c  | 37 +++++++++++++++++++++++++------------
 mm/memory.c   | 16 +++++++++++++---
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0caa64dc2cb7..ce7fb2383f65 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -438,6 +438,9 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
+void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long size,
+		      struct zap_details *details);
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp);
 
diff --git a/mm/madvise.c b/mm/madvise.c
index ba2a78795207..d7ea71c6422c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -794,12 +794,19 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
-static int madvise_free_single_vma(struct vm_area_struct *vma,
-			unsigned long start_addr, unsigned long end_addr)
+static int madvise_free_single_vma(
+		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,
+		unsigned long start_addr, unsigned long end_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
-	struct mmu_gather tlb;
+	struct mmu_gather self_tlb;
+	struct mmu_gather *tlb;
+
+	if (caller_tlb)
+		tlb = caller_tlb;
+	else
+		tlb = &self_tlb;
 
 	/* MADV_FREE works for only anon vma at the moment */
 	if (!vma_is_anonymous(vma))
@@ -815,16 +822,18 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 				range.start, range.end);
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
+	if (!caller_tlb)
+		tlb_gather_mmu(tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
-	tlb_start_vma(&tlb, vma);
+	tlb_start_vma(tlb, vma);
 	walk_page_range(vma->vm_mm, range.start, range.end,
-			&madvise_free_walk_ops, &tlb);
-	tlb_end_vma(&tlb, vma);
+			&madvise_free_walk_ops, tlb);
+	tlb_end_vma(tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb);
+	if (!caller_tlb)
+		tlb_finish_mmu(tlb);
 
 	return 0;
 }
@@ -848,7 +857,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
  * An interface that causes the system to free clean pages and flush
  * dirty pages is already available as msync(MS_INVALIDATE).
  */
-static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
+static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
+					struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
 	struct zap_details details = {
@@ -856,7 +866,10 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 		.even_cows = true,
 	};
 
-	zap_page_range_single(vma, start, end - start, &details);
+	if (!tlb)
+		zap_page_range_single(vma, start, end - start, &details);
+	else
+		unmap_vma_single(tlb, vma, start, end - start, &details);
 	return 0;
 }
 
@@ -951,9 +964,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-		return madvise_dontneed_single_vma(vma, start, end);
+		return madvise_dontneed_single_vma(NULL, vma, start, end);
 	else if (behavior == MADV_FREE)
-		return madvise_free_single_vma(vma, start, end);
+		return madvise_free_single_vma(NULL, vma, start, end);
 	else
 		return -EINVAL;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 88c478e2ed1a..3256b9713cbd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1995,9 +1995,19 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 	mmu_notifier_invalidate_range_end(&range);
 }
 
-static void unmap_vma_single(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
-		unsigned long size, struct zap_details *details)
+/**
+ * unmap_vma_single - remove user pages in a given range
+ * @tlb: pointer to the caller's struct mmu_gather
+ * @vma: vm_area_struct holding the applicable pages
+ * @address: starting address of the pages
+ * @size: number of bytes to remove
+ * @details: details of shared cache invalidation
+ *
+ * @tlb shouldn't be NULL.  The range must fit into one VMA.
+ */
+void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		      unsigned long address, unsigned long size,
+		      struct zap_details *details)
 {
 	const unsigned long end = address + size;
 	struct mmu_notifier_range range;
-- 
2.39.5

