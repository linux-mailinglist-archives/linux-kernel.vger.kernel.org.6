Return-Path: <linux-kernel+bounces-547808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76261A50DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C306173277
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188BB2580C8;
	Wed,  5 Mar 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbGisM6m"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF962571C6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210828; cv=none; b=tV33dRCKguvYBIdQQzY+zJA7Nauem9Xfml8xPBjRC/ijMGADpkbCsmxaJdUPB0Uqk2x+nB+TaesfH8dNp4UoXBgfOgs6xBGOiIfHB44LNLk1sI/e6BbA/ORthoHciCc7dDsEGm3jVE2g7N06IOqmnjjTxgb/lWcVOwpbwMjF6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210828; c=relaxed/simple;
	bh=snc0jC/pxlqgUTuIvrwEufCdhx6cb0M2p6gkvloje/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8b/cGXr8qoOyQD0PrLKmcWFdQfLRjljmLxRWHQh5RvOHmm0vZrcp9Yzkimu6YwWJ6ZC2nwNHJP4LKOc08e1RBR2jJdZLeD5C+stLySrsEKcCZYRungSNhFqxhUSM9qSHaLDgfguaPqNKcrEcze6oFpkxvEJ8ogvnF+izbSe8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbGisM6m; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 13:40:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741210822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lT+rjmxz451RtxK+9XYt2MkibeQON+Ip2eMj4hfzm0Y=;
	b=JbGisM6mw8n8II39u4BslBwwYGM8UWCoZUjk8OpayK6lW46w7FwnKHu+p/5i7ZsWpan127
	jcD0TWuUbv4wfq2B3qsc1v1Ls0qfGokmhnex1yhnnbK+2Fljg93aPjiUhC71y1suzE4Fa6
	UV5kZHKRqwZZEB8UOMNeW1g5/I7x0Bw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior
 struct for madvise_do_behavior()
Message-ID: <wdre2a4y6xmkvn4pgoptaqc67b6t646hgypbyjbin23u32zd3h@qrrdupkncnea>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-6-sj@kernel.org>
 <yv3k2tpeloyqsncwicjq5yl7rd6ao3a6bd22bwh74bf5nbfocb@xnaurkrxq64k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yv3k2tpeloyqsncwicjq5yl7rd6ao3a6bd22bwh74bf5nbfocb@xnaurkrxq64k>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 01:02:15PM -0800, Shakeel Butt wrote:
> On Wed, Mar 05, 2025 at 10:16:00AM -0800, SeongJae Park wrote:
> > To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> > MADV_FREE, an mmu_gather object in addition to the behavior integer need
> > to be passed to the internal logics.  Define a struct for passing such
> > information together with the behavior value without increasing number
> > of parameters of all code paths towards the internal logic.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/madvise.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index c5e1a4d1df72..3346e593e07d 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1665,9 +1665,15 @@ static bool is_memory_populate(int behavior)
> >  	}
> >  }
> >  
> > +struct madvise_behavior {
> > +	int behavior;
> > +};
> 
> I think the patch 5 to 8 are just causing churn and will be much better
> to be a single patch. Also why not make the above struct a general
> madvise visit param struct which can be used by both
> madvise_vma_anon_name() and madvise_vma_behavior()?

Something like following:

diff --git a/mm/madvise.c b/mm/madvise.c
index c5e1a4d1df72..cbc3817366a6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -890,11 +890,17 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 	return true;
 }
 
+struct madvise_walk_param {
+	int behavior;
+	struct anon_vma_name *anon_name;
+};
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
-				  int behavior)
+				  struct madvise_walk_param *arg)
 {
+	int behavior = arg->behavior;
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
@@ -1249,8 +1255,9 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 static int madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				unsigned long behavior)
+				struct madvise_walk_param *arg)
 {
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
@@ -1462,10 +1469,10 @@ static bool process_madvise_remote_valid(int behavior)
  */
 static
 int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
-		      unsigned long end, unsigned long arg,
+		      unsigned long end, struct madvise_walk_param *arg,
 		      int (*visit)(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev, unsigned long start,
-				   unsigned long end, unsigned long arg))
+				   unsigned long end, struct madvise_walk_param *arg))
 {
 	struct vm_area_struct *vma;
 	struct vm_area_struct *prev;
@@ -1523,7 +1530,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long anon_name)
+				 struct madvise_walk_param *arg)
 {
 	int error;
 
@@ -1532,7 +1539,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (struct anon_vma_name *)anon_name);
+				   arg->anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1548,6 +1555,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long end;
 	unsigned long len;
+	struct madvise_walk_param param = { .anon_name = anon_name };
 
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
@@ -1564,7 +1572,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
+	return madvise_walk_vmas(mm, start, end, &param,
 				 madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
@@ -1666,8 +1674,10 @@ static bool is_memory_populate(int behavior)
 }
 
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, int behavior)
+		unsigned long start, size_t len_in,
+		struct madvise_walk_param *arg)
 {
+	int behavior = arg->behavior;
 	struct blk_plug plug;
 	unsigned long end;
 	int error;
@@ -1681,7 +1691,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_populate(behavior))
 		error = madvise_populate(mm, start, end, behavior);
 	else
-		error = madvise_walk_vmas(mm, start, end, behavior,
+		error = madvise_walk_vmas(mm, start, end, arg,
 					  madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	return error;
@@ -1762,13 +1772,14 @@ static int madvise_do_behavior(struct mm_struct *mm,
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
 	int error;
+	struct madvise_walk_param arg = {.behavior = behavior};
 
 	if (madvise_should_skip(start, len_in, behavior, &error))
 		return error;
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, behavior);
+	error = madvise_do_behavior(mm, start, len_in, &arg);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1785,6 +1796,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 {
 	ssize_t ret = 0;
 	size_t total_len;
+	struct madvise_walk_param arg = {.behavior = behavior};
 
 	total_len = iov_iter_count(iter);
 
@@ -1800,7 +1812,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (madvise_should_skip(start, len_in, behavior, &error))
 			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in, behavior);
+			ret = madvise_do_behavior(mm, start, len_in, &arg);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.43.5


