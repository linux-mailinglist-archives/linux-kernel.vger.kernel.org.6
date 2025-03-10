Return-Path: <linux-kernel+bounces-554796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988DA59DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36097A5CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCC236429;
	Mon, 10 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krWQwApA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79651236A6A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627413; cv=none; b=bnTJOnk7okOCTKuyLBkFEnIvMqzldkK24SF8KyhUYQXwbmvt3CAV3b3zEfvwjwJRUCP670lb6W9ozoF4axP6D+P/deglPO5CpWTHkO0ffzV6zLc1fShAemY/Z8heStdZGLzaaKmBj0rpE9jeveVArSyOHmVIiC8xkF+DqHKYL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627413; c=relaxed/simple;
	bh=XwNyPWkuo3x8UEQgYUucQN44sSUMxDXOQT6wzHvLom0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d84ItyLXBmMQegyKWh/BYGIS4C0o2pxRodsiGEspcTmmnxMl1gld4wUuW4E1dfyH5mF2HFYi5ZMH5F9+13ZwcRav6ieWNxZ+T1uDR963X0VET/0+qB+02+fwC9jTFASA2Jd3izgUJpAiAFlNzH1T2fcgfNskFLw/sLx7ivKuuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krWQwApA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC673C4CEEC;
	Mon, 10 Mar 2025 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627412;
	bh=XwNyPWkuo3x8UEQgYUucQN44sSUMxDXOQT6wzHvLom0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krWQwApAFooJw8RDR+VQklpBSPp/jb0qvzqLu5pCDpb7eW76XF5JyZwxHg4cy4FEU
	 XvMGRSStteW7kyuxgIk/BsxYaqWeRdLQaa6PTij9bEWwE2+rClOI+uMaCmLkdK2M8K
	 8MzU+FiOthWHwlK/bdFrs0qShtkdkmaAE2UaZYZM8XMrmJtSnawjt/mLWf6uLnDD0d
	 C+kVoxCRMP9beh4TlBf27mnPlUXccx8TLOwatzKscv0CoCZgrpLWWu7zmxnnpVRCyE
	 Liha99fJhrQLYsMoDyQNiPeJZ4C//wNOTCnt8/6+cNVwvl2dr6Jp1ifIZUVfh+ZNIy
	 g/6Q0LWdHYpWA==
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
Subject: [PATCH 8/9] mm/madvise: batch tlb flushes for [process_]madvise(MADV_{DONTNEED[_LOCKED],FREE})
Date: Mon, 10 Mar 2025 10:23:17 -0700
Message-Id: <20250310172318.653630-9-sj@kernel.org>
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

MADV_DONTNEED[_LOCKED] and MADV_FREE internal logics for
[process_]madvise() can be invoked with batched tlb flushes.  Update
vector_madvise() and do_madvise(), which are called for the two system
calls  respectively, to use those in the efficient way.  Initialize an
mmu_gather object before starting the internal works, and flush the
gathered tlb entries at once after all the internal works are done.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d7ea71c6422c..d5f4ce3041a4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -905,6 +905,7 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 
 struct madvise_behavior {
 	int behavior;
+	struct mmu_gather *tlb;
 };
 
 static long madvise_dontneed_free(struct vm_area_struct *vma,
@@ -964,9 +965,11 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
-		return madvise_dontneed_single_vma(NULL, vma, start, end);
+		return madvise_dontneed_single_vma(
+				madv_behavior->tlb, vma, start, end);
 	else if (behavior == MADV_FREE)
-		return madvise_free_single_vma(NULL, vma, start, end);
+		return madvise_free_single_vma(
+				madv_behavior->tlb, vma, start, end);
 	else
 		return -EINVAL;
 }
@@ -1639,6 +1642,32 @@ static void madvise_unlock(struct mm_struct *mm, int behavior)
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
@@ -1791,14 +1820,20 @@ static int madvise_do_behavior(struct mm_struct *mm,
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
@@ -1815,13 +1850,18 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
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
+	madvise_init_tlb(&madv_behavior, mm);
 
 	while (iov_iter_count(iter)) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
@@ -1850,14 +1890,17 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			}
 
 			/* Drop and reacquire lock to unwind race. */
+			madvise_finish_tlb(&madv_behavior);
 			madvise_unlock(mm, behavior);
 			madvise_lock(mm, behavior);
+			madvise_init_tlb(&madv_behavior, mm);
 			continue;
 		}
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
 	}
+	madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	ret = (total_len - iov_iter_count(iter)) ? : ret;
-- 
2.39.5

