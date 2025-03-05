Return-Path: <linux-kernel+bounces-547460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A0A50966
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1DD168948
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD62561A4;
	Wed,  5 Mar 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgRqfs2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B91255E3D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198591; cv=none; b=E+3m/m5ZaU2KbOXTE+XprAxXIX4eNJym232XUMQzp5mj2Vg1E3kwwQ0graIIhEPnMtygLTRidLqUDJHOMDdSwTVqY5ezye/cMCKQkZRbDaLniEBFuI6a6qcsq0q16kUE9a5YDtU8lI1p6VALGAoApQv1bBcHOqfELhkVNOVH34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198591; c=relaxed/simple;
	bh=qTz2EADhHkd12Pdb2rgzQeU5lnQ9KkIcBg1xzIMxfqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWN6oir9GFiNktCoNiF+7pnSUhMVSGAbrty6id2ZEbDeEdCmVsD2L21EbVNKotEzhXhB6vboHOm5cv7URAfpjU1IJGIpx5eH0lgj+cqPjoFDqOQxDnW4+XB/M2MsQ7xlgpXWAwk6B50FZzQqlM+3NgKBJNITKKGce4r0pAEsBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgRqfs2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B554C4CED1;
	Wed,  5 Mar 2025 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198591;
	bh=qTz2EADhHkd12Pdb2rgzQeU5lnQ9KkIcBg1xzIMxfqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgRqfs2NseUkix5vrYEws4rsZfUtLGUzUiaQKz9cL3cUczbHcnhtImfhyuuyEter5
	 jReIK8APFWJgSQCwIor9x6PTZBSTjB3bEwYOXEQoO82GoaOItFlnPpmJ55nrb4pQEH
	 Icz+IKD6OzUoGVchOBRUXmwZXhu8OTsKyeufqiejQsO9/JLFngmaTLNNy8cgBvvS6m
	 eGZW+6snKE73VeZUE3xG4Q1vGmh0GAvWhjtQYXwCTzYQGH2pSqKvHU2zNH1KHyKUsi
	 9XZXa7koL3kvZxHcyftsU8YgULJP9WVJIazYRyRFmjTe4aa1mo4c2FD1hkRvwREDeX
	 TV52sNWDWuA3w==
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
Subject: [RFC PATCH 10/16] mm/madvise: let madvise_dontneed_single_vma() caller batches tlb flushes
Date: Wed,  5 Mar 2025 10:16:05 -0800
Message-Id: <20250305181611.54484-11-sj@kernel.org>
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

Update madvise_dontneed_single_vma() function so that the caller can
pass an mmu_gather object that should be initialized and will be
finished outside, for batched tlb flushes.  Also modify
madvise_dontneed_single_vma() internal code to support such usage by
skipping the initialization and finishing of self-allocated mmu_gather
object if it received a valid mmu_gather object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h |  3 +++
 mm/madvise.c  | 10 +++++++---
 mm/memory.c   |  6 +++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0413822ee34b..45b8d08cd176 100644
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
index 73a4323197e2..22da6699613c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -848,7 +848,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
  * An interface that causes the system to free clean pages and flush
  * dirty pages is already available as msync(MS_INVALIDATE).
  */
-static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
+static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
+					struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
 	struct zap_details details = {
@@ -856,7 +857,10 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 		.even_cows = true,
 	};
 
-	zap_page_range_single(vma, start, end - start, &details);
+	if (!tlb)
+		zap_page_range_single(vma, start, end - start, &details);
+	else
+		unmap_vma_single(tlb, vma, start, end - start, &details);
 	return 0;
 }
 
@@ -951,7 +955,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-		return madvise_dontneed_single_vma(vma, start, end);
+		return madvise_dontneed_single_vma(NULL, vma, start, end);
 	else if (behavior == MADV_FREE)
 		return madvise_free_single_vma(vma, start, end);
 	else
diff --git a/mm/memory.c b/mm/memory.c
index aadb2844c701..ba011c064936 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2011,9 +2011,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 	mmu_notifier_invalidate_range_end(&range);
 }
 
-static void unmap_vma_single(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
-		unsigned long size, struct zap_details *details)
+void unmap_vma_single(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		      unsigned long address, unsigned long size,
+		      struct zap_details *details)
 {
 	const unsigned long end = address + size;
 	struct mmu_notifier_range range;
-- 
2.39.5

