Return-Path: <linux-kernel+bounces-547464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D2A50971
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D772A7A9984
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C82571D9;
	Wed,  5 Mar 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHqFAg4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261E2571B8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198596; cv=none; b=lRB1HIqMeKWzyKCa2FjgOlJn5X6In7xlyP2Vajea0KU7f8FGWkt66FrwVyjpGW/3UaQ3pbgedqXDodJs4Yk8Hu6mYEt91LipZBnhgONxi1Pq2Zcocw1zg+ka7EwhYf5tTfiGbYt90uURu6YP9SuF1DwBsmsBc3BtaV7tUcBoY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198596; c=relaxed/simple;
	bh=1LPOXs5PBkvrUa9S0qnB8qMN3Uc/uSVSQOTjrIyqAEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwQg0zoAX+Yd83VrLP3ld4VqPmwHUD/S49Nx082yF77fvOK6iNe4cNv13Z1+PFVdqsUxpK3E85C/kNU/iMSlTSI4BYexAikGdi6motdXjrTDlpvzK4QIaLEuEpEc00K/wVVEXRx0Bz6PnUDS7cexA85/GEiycDrcuDm8G7hzp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHqFAg4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDADAC4CED1;
	Wed,  5 Mar 2025 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198596;
	bh=1LPOXs5PBkvrUa9S0qnB8qMN3Uc/uSVSQOTjrIyqAEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHqFAg4AOa7S72mrOT/H3kNLtZLpur42QTtIRfYbMO+8bjFaIMS1gEdG7yG47ywRy
	 4rqL7AOqSLUArKtqalvcDEx3ixdn8dlfbcGDTM1pqiALKHLYqhtQxCLfVmbiUAhrTX
	 2RcH9u9I5jIJsy6XNsl18EuyAwWPEEvd/joVHWmWx0elQQUeWx3GfIyDmIE/G9M6Re
	 XFyFhxghJiYElbYzzl1lLS52XUGPvwNvv+54MiCrwgqJI55xsVpJFhza5Ax/bx2POQ
	 n1qO5tDPVQXxLPtGBrry7hNgEENXcWxlm8HRSwn0cqoTuKx/tfYYqSPbb7fu1+nRVF
	 LQwENlJY4X9sw==
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
Subject: [RFC PATCH 14/16] mm/madvise: batch tlb flushes for madvise(MADV_{DONTNEED[_LOCKED],FREE}
Date: Wed,  5 Mar 2025 10:16:09 -0800
Message-Id: <20250305181611.54484-15-sj@kernel.org>
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

MADV_DONTNEED[_LOCKED] and MADV_FREE internal logics can be invoked with
batched tlb flushes.  madvise() is called for single address range, but
if there are multiple vmas for the range, tlb flush will happen multiple
times.  Update do_madvise(), which is called for madvise(), to use that
in the efficient way, by passing an mmu_gather object that it
initializes before starting the work, and flushing the tlb entries at
once after all the internal works are done.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 68 ++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f1beadb6176a..0d292b8e1a0e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1635,6 +1635,32 @@ static void madvise_unlock(struct mm_struct *mm, int behavior)
 		mmap_read_unlock(mm);
 }
 
+static bool madvise_batch_tlb_flush(int behavior)
+{
+	switch (behavior) {
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void madvise_init_tlb(struct madvise_behavior *madv_behavior,
+		struct mm_struct *mm)
+{
+	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
+		return;
+	tlb_gather_mmu(madv_behavior->tlb, mm);
+}
+
+static void madvise_finish_tlb(struct madvise_behavior *madv_behavior)
+{
+	if (!madvise_batch_tlb_flush(madv_behavior->behavior))
+		return;
+	tlb_finish_mmu(madv_behavior->tlb);
+}
+
 static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
 {
 	size_t len;
@@ -1787,14 +1813,20 @@ static int madvise_do_behavior(struct mm_struct *mm,
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
 	int error;
-	struct madvise_behavior madv_behavior = {.behavior = behavior};
+	struct mmu_gather tlb;
+	struct madvise_behavior madv_behavior = {
+		.behavior = behavior,
+		.tlb = &tlb,
+	};
 
 	if (madvise_should_skip(start, len_in, behavior, &error))
 		return error;
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
+	madvise_init_tlb(&madv_behavior, mm);
 	error = madvise_do_behavior(mm, start, len_in, &madv_behavior);
+	madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1805,32 +1837,6 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
-static bool vector_madvise_batch_tlb_flush(int behavior)
-{
-	switch (behavior) {
-	case MADV_DONTNEED:
-	case MADV_DONTNEED_LOCKED:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static void vector_madvise_init_tlb(struct madvise_behavior *madv_behavior,
-		struct mm_struct *mm)
-{
-	if (!vector_madvise_batch_tlb_flush(madv_behavior->behavior))
-		return;
-	tlb_gather_mmu(madv_behavior->tlb, mm);
-}
-
-static void vector_madvise_finish_tlb(struct madvise_behavior *madv_behavior)
-{
-	if (!vector_madvise_batch_tlb_flush(madv_behavior->behavior))
-		return;
-	tlb_finish_mmu(madv_behavior->tlb);
-}
-
 /* Perform an madvise operation over a vector of addresses and lengths. */
 static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			      int behavior)
@@ -1848,7 +1854,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	ret = madvise_lock(mm, behavior);
 	if (ret)
 		return ret;
-	vector_madvise_init_tlb(&madv_behavior, mm);
+	madvise_init_tlb(&madv_behavior, mm);
 
 	while (iov_iter_count(iter)) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
@@ -1877,17 +1883,17 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			}
 
 			/* Drop and reacquire lock to unwind race. */
-			vector_madvise_finish_tlb(&madv_behavior);
+			madvise_finish_tlb(&madv_behavior);
 			madvise_unlock(mm, behavior);
 			madvise_lock(mm, behavior);
-			vector_madvise_init_tlb(&madv_behavior, mm);
+			madvise_init_tlb(&madv_behavior, mm);
 			continue;
 		}
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
 	}
-	vector_madvise_finish_tlb(&madv_behavior);
+	madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	ret = (total_len - iov_iter_count(iter)) ? : ret;
-- 
2.39.5

