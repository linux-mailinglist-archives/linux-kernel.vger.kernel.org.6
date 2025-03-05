Return-Path: <linux-kernel+bounces-547461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C03A5096C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208FC7A9127
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC82561BC;
	Wed,  5 Mar 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8L/NUdf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBED2561B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198592; cv=none; b=q6/c37NOtv843TryhoiPmr/f+8qCG4AUb1y/8r4szzsxRvXr6Zsj3rJOe/i6CSgcSXcqRReEChdxb3tBdmb/OlkyU8AB7dCVcrK9LZWdyapPeneCtCQ4BckNxbuFHV3Eqmk8WafJl+fIyTwxGKO1NAY1XqAp8yK2BlddYiHEomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198592; c=relaxed/simple;
	bh=VbOLwUfPS96J+Dn4D6VO7VbIh87bUFOgKgh9tH90XtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKcWq83w8gkyoGYgPjU74ZpjCN+OPRFIcW0ce6p8cGjB4bxFp/Lvq6YlOTRBMJW2CYzOsudoZ9AAmKAUkLyjJ/EEa0lvVxtKSBWql8mh7feiDup/iao0FNV0paKIDAdd2eEp0f7Kh7oXIrXOoRGjR3e0nwqqfnBhhzffanQFV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8L/NUdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302EC4CED1;
	Wed,  5 Mar 2025 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198592;
	bh=VbOLwUfPS96J+Dn4D6VO7VbIh87bUFOgKgh9tH90XtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8L/NUdfSFARyAX4ToIaUViXGLmoyIt6P5pSeStwqeYkAQ5qsal4uIh28/nnnWeWx
	 BCNP3KLDIJahIo1NSGAj+CfpF7d8ZolvmgY0DtPbCg2fS8a5Jr4bjfaHQLGTS06Bq5
	 K8SKd17LjNI6OuV8m+WGpk3/duWYX2ANVJpKET0autEmll2LvI72K+80s7Mqi+3zR4
	 JsjMvJHCTEHS3ViA/E1bI3BUEz9eoCp1fO7kFQxq+HD581fSbgb9kQFooJJabZRMqH
	 mgGf2F2R3P624GAUf9a+ZalbXy3HjYOkzBrTDBfiIOHw1woUG9LbBrJygjfOzltkJX
	 Xd305rSU3wOQQ==
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
Subject: [RFC PATCH 11/16] mm/madvise: let madvise_free_single_vma() caller batches tlb flushes
Date: Wed,  5 Mar 2025 10:16:06 -0800
Message-Id: <20250305181611.54484-12-sj@kernel.org>
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

Update madvise_free_single_vma() function so that the caller can pass an
mmu_gather object that should be initialized and will be finished
outside, for batched tlb flushes.  Also modify madvise_free_single_vma()
internal code to support such usage while keeping support of olde usage
that the mmu_gather object is not passed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 22da6699613c..767c5d21ee75 100644
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
@@ -957,7 +966,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
 		return madvise_dontneed_single_vma(NULL, vma, start, end);
 	else if (behavior == MADV_FREE)
-		return madvise_free_single_vma(vma, start, end);
+		return madvise_free_single_vma(NULL, vma, start, end);
 	else
 		return -EINVAL;
 }
-- 
2.39.5

