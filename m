Return-Path: <linux-kernel+bounces-554797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8051A59DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E1716FD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045223718D;
	Mon, 10 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Set4HVYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29118236A98
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627414; cv=none; b=U/IEmKgGssL0K4o7l5E341GFp2g0q+LYlwSgMyrRmphfwVn3p3uXHFkFZf8DCX0gApuvPhhSxX0/VJVV1NuQ/fgtWAkwzN4pxrZ6hwJN/5GxHY8EKZIVhgdvvDDmYo1pxPmYx7GU8pZ0Ky4ecUidEw+fcu2vNj3XzrzPT1HZm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627414; c=relaxed/simple;
	bh=P3FkpaakjLXsflqPzPkcSxDHFwcvtfrO/BuhT1Vlk/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxUFztfYw9JOnirpH/pLeINQFAKjovHpiIy1BitgRqkUxY1qPxqLvFgkmzCF+6jQQdjkvntCG2xz0aXSsEeZxee2F9dPYY4Sp/3c+rZHOb9HpsE2E3f0K7DC6gbW3g8l8wI8MrH02FTrjnAj7q4yCGA+TzZrPa3s08blZE84N30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Set4HVYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A8CC4CEF3;
	Mon, 10 Mar 2025 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627414;
	bh=P3FkpaakjLXsflqPzPkcSxDHFwcvtfrO/BuhT1Vlk/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Set4HVYiJXagZv6AHBunmJA2YaxUOJNXk/xAV/vhDbFjpU1vNEeI+SBBALuj/M05i
	 KURLdN1pNktQabof22sMSLvUlHkADTNX1hIHgdSslYYSh8X5MurEWENbg0as8amXZ8
	 3j67efJT7/8ngHcGzDhAqL3JWDpqLWmrNa3eE93RbLgP3ZaGBOJN+U3MkkZUcfemAX
	 j2w0y5eq4tpmZ16QqA+T7gOEJOtMnGL7tyQX/IHV0A4AE+tJiAxejseb4ofZt0hmKP
	 64a4hJBNiaED6o2r144J+62wh3s3o/d4eb9OVTVKRL8Ck59jNEoJ81sBI1Qo/AZK4L
	 t4BlhlGEzf4NQ==
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
Subject: [PATCH 9/9] mm/madvise: remove !tlb support from madvise_{dontneed,free}_single_vma()
Date: Mon, 10 Mar 2025 10:23:18 -0700
Message-Id: <20250310172318.653630-10-sj@kernel.org>
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

madvise_dontneed_single_vma() and madvise_free_single_vma() support both
batched tlb flushes and unbatched tlb flushes use cases depending on
received tlb parameter's value.  The supports were for safe and fine
transition of the usages from the unbatched flushes to the batched ones.
Now the transition is done, and therefore there is no real unbatched tlb
flushes use case.  Remove the code for supporting the no more being used
cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d5f4ce3041a4..25af0a24c00b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -795,18 +795,11 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
 };
 
 static int madvise_free_single_vma(
-		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,
+		struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long start_addr, unsigned long end_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
-	struct mmu_gather self_tlb;
-	struct mmu_gather *tlb;
-
-	if (caller_tlb)
-		tlb = caller_tlb;
-	else
-		tlb = &self_tlb;
 
 	/* MADV_FREE works for only anon vma at the moment */
 	if (!vma_is_anonymous(vma))
@@ -822,8 +815,6 @@ static int madvise_free_single_vma(
 				range.start, range.end);
 
 	lru_add_drain();
-	if (!caller_tlb)
-		tlb_gather_mmu(tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
@@ -832,9 +823,6 @@ static int madvise_free_single_vma(
 			&madvise_free_walk_ops, tlb);
 	tlb_end_vma(tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	if (!caller_tlb)
-		tlb_finish_mmu(tlb);
-
 	return 0;
 }
 
@@ -866,10 +854,7 @@ static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
 		.even_cows = true,
 	};
 
-	if (!tlb)
-		zap_page_range_single(vma, start, end - start, &details);
-	else
-		unmap_vma_single(tlb, vma, start, end - start, &details);
+	unmap_vma_single(tlb, vma, start, end - start, &details);
 	return 0;
 }
 
-- 
2.39.5

