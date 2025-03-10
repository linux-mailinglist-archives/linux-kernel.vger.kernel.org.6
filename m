Return-Path: <linux-kernel+bounces-554793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F05A59DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356F016DF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C292356AB;
	Mon, 10 Mar 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQaulE8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042723534F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627409; cv=none; b=NeWADjDKx9Dmxt6jBX1Hcjd5o+Kk53ecpx41o89QE485tgTf9ifxLkqRbapWD8HPBr+BypW3Uac2AQLdqt3L8glC/5TMygUJRQpGOgZiX1s/OSo4bHEtHMKTJOCVZH61Va1M21rIQVYHwzyP6ZNpCUJLDee87inksMU94/NdWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627409; c=relaxed/simple;
	bh=4dhdwBK3uXi/DICcheMKZstN40gWxuAC0U5kXen1d3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raBedTbWsx7mvusBbxyyzD7neGGiLTLiAeGrCI+pRhMTnioVi+2CS4vlHw4QLMsCfnE5eK/BNLpGVcZOZfORk/n87lar5eona2gn1Fi0UQUZbautMnOe8sHW8pry2yqDR3KrHVol/YfhkFFyXle5Dyr87EL4RcCo/IU78vvEB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQaulE8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A85C4CEF7;
	Mon, 10 Mar 2025 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627409;
	bh=4dhdwBK3uXi/DICcheMKZstN40gWxuAC0U5kXen1d3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQaulE8A/QMb9rjKSApl6fMLGmwITsJNjmDE/wylUwceFMbDOjyBzaCG+ymEcYxtB
	 yac+cSxxdxCG0sffnMnnapqPgVDofYfA7hCavPyXj62MObV73yNUVRcBVPpbbJ+pXp
	 Ao1+ptYPErt93XP/gPcnFn4ayqyp1rMQRPBxYKY2tUtmV9FZGignk+VK9guNz7H9B2
	 Db0uGgEW7OgM/N+Dwnj8hWTSmB634uk7VEeM0J0r06rbD/IUwDR8mmoXV/y82Sgtj+
	 lO1ipuZJ8GoK4eZQJxxAMeDsw78WXXsY330Uy2c35Zl4OjMo9XCFhWMFlEFss4ZzH7
	 QeXzSHEmPnwyg==
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
Subject: [PATCH 5/9] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Mon, 10 Mar 2025 10:23:14 -0700
Message-Id: <20250310172318.653630-6-sj@kernel.org>
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

To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
MADV_FREE, an mmu_gather object in addition to the behavior integer need
to be passed to the internal logics.  Using a struct can make it easy
without increasing the number of parameters of all code paths towards
the internal logic.  Define a struct for the purpose and use it on the
code path that starts from madvise_do_behavior() and ends on
madvise_dontneed_free().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 469c25690a0e..ba2a78795207 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -890,11 +890,16 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 	return true;
 }
 
+struct madvise_behavior {
+	int behavior;
+};
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
-				  int behavior)
+				  struct madvise_behavior *madv_behavior)
 {
+	int behavior = madv_behavior->behavior;
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
@@ -1249,8 +1254,10 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 static int madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				unsigned long behavior)
+				void *behavior_arg)
 {
+	struct madvise_behavior *arg = behavior_arg;
+	int behavior = arg->behavior;
 	int error;
 	struct anon_vma_name *anon_name;
 	unsigned long new_flags = vma->vm_flags;
@@ -1270,7 +1277,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 	case MADV_DONTNEED_LOCKED:
-		return madvise_dontneed_free(vma, prev, start, end, behavior);
+		return madvise_dontneed_free(vma, prev, start, end, arg);
 	case MADV_NORMAL:
 		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
 		break;
@@ -1487,10 +1494,10 @@ static bool process_madvise_remote_valid(int behavior)
  */
 static
 int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
-		      unsigned long end, unsigned long arg,
+		      unsigned long end, void *arg,
 		      int (*visit)(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev, unsigned long start,
-				   unsigned long end, unsigned long arg))
+				   unsigned long end, void *arg))
 {
 	struct vm_area_struct *vma;
 	struct vm_area_struct *prev;
@@ -1548,7 +1555,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long anon_name)
+				 void *anon_name)
 {
 	int error;
 
@@ -1557,7 +1564,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (struct anon_vma_name *)anon_name);
+				   anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1589,7 +1596,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
+	return madvise_walk_vmas(mm, start, end, anon_name,
 				 madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
@@ -1673,8 +1680,10 @@ static bool is_madvise_populate(int behavior)
 }
 
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, int behavior)
+		unsigned long start, size_t len_in,
+		struct madvise_behavior *madv_behavior)
 {
+	int behavior = madv_behavior->behavior;
 	struct blk_plug plug;
 	unsigned long end;
 	int error;
@@ -1688,7 +1697,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_madvise_populate(behavior))
 		error = madvise_populate(mm, start, end, behavior);
 	else
-		error = madvise_walk_vmas(mm, start, end, behavior,
+		error = madvise_walk_vmas(mm, start, end, madv_behavior,
 					  madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	return error;
@@ -1769,13 +1778,14 @@ static int madvise_do_behavior(struct mm_struct *mm,
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
 	int error;
+	struct madvise_behavior madv_behavior = {.behavior = behavior};
 
 	if (madvise_should_skip(start, len_in, behavior, &error))
 		return error;
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, behavior);
+	error = madvise_do_behavior(mm, start, len_in, &madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1792,6 +1802,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 {
 	ssize_t ret = 0;
 	size_t total_len;
+	struct madvise_behavior madv_behavior = {.behavior = behavior};
 
 	total_len = iov_iter_count(iter);
 
@@ -1807,7 +1818,8 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (madvise_should_skip(start, len_in, behavior, &error))
 			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in, behavior);
+			ret = madvise_do_behavior(mm, start, len_in,
+					&madv_behavior);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.39.5

