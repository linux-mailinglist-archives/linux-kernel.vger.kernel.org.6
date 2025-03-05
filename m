Return-Path: <linux-kernel+bounces-547462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCBDA50969
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE63AB18E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE60252910;
	Wed,  5 Mar 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfAZgM5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8582566D7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198594; cv=none; b=dLSFYZ1dEvKzq6944FMrdND8f+A/cMqDfi+C9cOcnscswcCWqQqLT++1NIpJqARhV40288ia+hC2IUnxNZMsyvnCQjh/Jm8/FkilvZKu+dDqWzJD+BoXqvIuciBoPfAPdQrV/WL5s3wJLCFl7fvHFaPvkIm+T+d9WawehhjWFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198594; c=relaxed/simple;
	bh=jzL4THh0ZOpM9TD9jtctj6vlHRlDDc1QOi0WL+ouKWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yh6yzzOehdy+sOG2E+jnPNZXaoKmoSPIjvoSF3MX0/0xH0xc/T9OeYG3w2AJEXrWVmeR1XJhsc+zMFKyonptlIc391HuopPo0SH2t1o2kYXH3zEqfA4wMPaWX7MYqxZACF/VL4c271FL8/Ua02o6jMQpRqPb8HrnP0OfipKzcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfAZgM5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEBAC4CED1;
	Wed,  5 Mar 2025 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198593;
	bh=jzL4THh0ZOpM9TD9jtctj6vlHRlDDc1QOi0WL+ouKWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfAZgM5NRq4d1FSeYirYc97Aa37ub9mtL5+bYLp6su191iwtezpNxNXtZ9QKnYlfG
	 ZbU4WvCz8p8tYxGgqYlbUlcF7P0PADFKnlM/EF+o3gGKkkEDqFvW6xeVSkOCtyYwx3
	 8m2pMPtJp+qwemce3LMOXfT2qVT5VDOjvkpFLvUpflQ0olmQBk+jZngEtXZcUxs4iA
	 oMGEqY6WB+JVziG+jlXgXL6tNNF+rh3EucCJmQC/exsYPZNpJ3IGf1YyfvdjOY3m1K
	 1cP0WLchBvEthG2w3kt4Kx3pa369OEKOQ0igOLvv2ef71WBsy4u/HRBVQwnfXD0QEf
	 fDAJimD9a+P1A==
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
Subject: [RFC PATCH 12/16] mm/madvise: batch tlb flushes for process_madvise(MADV_DONTNEED[_LOCKED])
Date: Wed,  5 Mar 2025 10:16:07 -0800
Message-Id: <20250305181611.54484-13-sj@kernel.org>
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

MADV_DONTNEED[_LOCKED] internal logic can be invoked with batched tlb
flushes.  Update vector_madvise(), which is called for
process_madvise(), to use that in the way, by passing an mmu_gather
object that it initializes before starting the internal works, and
flushing the gathered tlb entries at once after all the internal works
are done.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 767c5d21ee75..efa4184d6cf5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -905,6 +905,7 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 
 struct madvise_behavior {
 	int behavior;
+	struct mmu_gather *tlb;
 };
 
 static long madvise_dontneed_free(struct vm_area_struct *vma,
@@ -964,7 +965,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-		return madvise_dontneed_single_vma(NULL, vma, start, end);
+		return madvise_dontneed_single_vma(
+				madv_behavior->tlb, vma, start, end);
 	else if (behavior == MADV_FREE)
 		return madvise_free_single_vma(NULL, vma, start, end);
 	else
@@ -1802,19 +1804,50 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
+static bool vector_madvise_batch_tlb_flush(int behavior)
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
+static void vector_madvise_init_tlb(struct madvise_behavior *madv_behavior,
+		struct mm_struct *mm)
+{
+	if (!vector_madvise_batch_tlb_flush(madv_behavior->behavior))
+		return;
+	tlb_gather_mmu(madv_behavior->tlb, mm);
+}
+
+static void vector_madvise_finish_tlb(struct madvise_behavior *madv_behavior)
+{
+	if (!vector_madvise_batch_tlb_flush(madv_behavior->behavior))
+		return;
+	tlb_finish_mmu(madv_behavior->tlb);
+}
+
 /* Perform an madvise operation over a vector of addresses and lengths. */
 static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			      int behavior)
 {
 	ssize_t ret = 0;
 	size_t total_len;
-	struct madvise_behavior madv_behavior = {.behavior = behavior};
+	struct mmu_gather tlb;
+	struct madvise_behavior madv_behavior = {
+		.behavior = behavior,
+		.tlb = &tlb,
+	};
 
 	total_len = iov_iter_count(iter);
 
 	ret = madvise_lock(mm, behavior);
 	if (ret)
 		return ret;
+	vector_madvise_init_tlb(&madv_behavior, mm);
 
 	while (iov_iter_count(iter)) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
@@ -1843,14 +1876,17 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			}
 
 			/* Drop and reacquire lock to unwind race. */
+			vector_madvise_finish_tlb(&madv_behavior);
 			madvise_unlock(mm, behavior);
 			madvise_lock(mm, behavior);
+			vector_madvise_init_tlb(&madv_behavior, mm);
 			continue;
 		}
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
 	}
+	vector_madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	ret = (total_len - iov_iter_count(iter)) ? : ret;
-- 
2.39.5

