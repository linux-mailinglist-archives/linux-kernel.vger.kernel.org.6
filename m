Return-Path: <linux-kernel+bounces-261440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E693B759
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7671B1F2135E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02F16C686;
	Wed, 24 Jul 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xXQMZQCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CE16F26F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848454; cv=none; b=npQhLsg5IAgASMY6a13GXKu8+rJR4PmcdO0lb3vJG+NAzRSchFZU+DRrQWocF9F+O9oiEki2cchFhaldlE1pxClQBZJjOqpknLl5xcKs/cRqQIfzjgHOap6ryQ+F+6xYYcfl2x23b6JiGFajvYGt2dxwodmtaeKpLHzsKZmO8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848454; c=relaxed/simple;
	bh=J5EXpzSAXq9MlniUjingyvdi5dGIQLOMLHcvs33VHHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rPjVLaDM3/V9r7VcYfZYce9wIgdgBnhXm4x6m7Z9C8PBy2dg5nl5jbys/V4pVLaWxS8pw/yrWLSuhLR4zinMDLjszfcp9we78gWVLq5zSYgdQwpuNJQzoqshxAiWEf6FEu1q4QbwgLi5y1IPjKU9EvjFC5sUCqNnTB/rA8d3bCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xXQMZQCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B6C4AF11;
	Wed, 24 Jul 2024 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721848453;
	bh=J5EXpzSAXq9MlniUjingyvdi5dGIQLOMLHcvs33VHHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xXQMZQCVFKxqS/ZDxC2AhlL6F4r1GJ491M4q51sG7ctao5Qcg6eeKOVViNKGeNrgJ
	 12KYl4jYkxKLDlBznYKz3sTkYzt7DOuogQfif4bzIzgn83CQoH1F0sjoZRpVYCz9RI
	 hsV2roIbXSDPGjWlk0S6NHLje5GrwNK5joz6HnLE=
Date: Wed, 24 Jul 2024 12:14:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: hughd@google.com, willy@infradead.org, david@redhat.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Some cleanups for shmem
Message-Id: <20240724121407.a81ef1cfdddec3ee348049fb@linux-foundation.org>
In-Reply-To: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jul 2024 21:24:19 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Changes from v1:
>  - Add a dummy function in case CONFIG_TRANSPARENT_HUGEPAGE is not
>  enabled, which fixes a building error reported by kernel test robot.

The only difference I'm seeing from the v1 series is the below update
to [3/3]:

--- a/mm/shmem.c~mm-shmem-move-shmem_huge_global_enabled-into-shmem_allowable_huge_orders-v2
+++ a/mm/shmem.c
@@ -549,10 +549,9 @@ static bool shmem_confirm_swap(struct ad
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
 static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					bool shmem_huge_force, struct vm_area_struct *vma,
+					bool shmem_huge_force, struct mm_struct *mm,
 					unsigned long vm_flags)
 {
-	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
@@ -583,14 +582,14 @@ static bool __shmem_huge_global_enabled(
 }
 
 static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-		   bool shmem_huge_force, struct vm_area_struct *vma,
+		   bool shmem_huge_force, struct mm_struct *mm,
 		   unsigned long vm_flags)
 {
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
 		return false;
 
 	return __shmem_huge_global_enabled(inode, index, shmem_huge_force,
-					   vma, vm_flags);
+					   mm, vm_flags);
 }
 
 #if defined(CONFIG_SYSFS)
@@ -775,7 +774,7 @@ static unsigned long shmem_unused_huge_s
 }
 
 static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-		bool shmem_huge_force, struct vm_area_struct *vma,
+		bool shmem_huge_force, struct mm_struct *mm,
 		unsigned long vm_flags)
 {
 	return false;
@@ -1638,6 +1637,7 @@ unsigned long shmem_allowable_huge_order
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
 	unsigned long vm_flags = vma ? vma->vm_flags : 0;
+	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
 	/*
 	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
 	 * are enabled for this vma.
@@ -1656,7 +1656,7 @@ unsigned long shmem_allowable_huge_order
 		return 0;
 
 	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
-						vma, vm_flags);
+						fault_mm, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
 		/*
 		 * For tmpfs, we now only support PMD sized THP if huge page
_


