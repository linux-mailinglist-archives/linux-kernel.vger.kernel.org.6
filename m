Return-Path: <linux-kernel+bounces-565416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7DA667AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238F8422638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6D1C3BE6;
	Tue, 18 Mar 2025 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PFtmXlBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9951C174E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269406; cv=none; b=YATczYWOTB5sL/HNT2hRAAmMljW8gNn6N3Ts4gaVze+JggH+gLt7vjbdYRXzIMdz7n90x4Ug/TbfyEGFbE9n5EWYuG50zZ8FftQ5DydH5A79O1B4eswo62zIfaVu9GbTCqN57l80E4Ldvp4EQdfP/ORJ6o/kb75nTXeo5FbAi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269406; c=relaxed/simple;
	bh=KDFuMlXQj/hcaXTRb3j7gCFMQYHJ2g6a9wMcKUM47Wk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gX67zzcY/+Vke8shr1yEQQ9hPBcPrAcTeHq4JQZizDR7xgytNZzi2kYRUgM+F7rx1yTloePDEI8E1i+phmKnG+NdDguHAAk+nLHS94cA7+oG4i4S7KEq3x2tzlfg9yJAQyIR0Lr0eA/sgG+3hTHp1XktwHgFdoCapV1y5r1RwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PFtmXlBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF130C4CEDD;
	Tue, 18 Mar 2025 03:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742269406;
	bh=KDFuMlXQj/hcaXTRb3j7gCFMQYHJ2g6a9wMcKUM47Wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFtmXlBeOYbR/yed4F8hkIsWHanOpThdl2FbBzxQkhc6W8viO3xMASlzIHlpuMPJO
	 x1tY7viOOQb7Suhjpn3duHDSiZE+NwspbQ5zps3pPVrsjVotRdPaCCW2UwFnCKGHDG
	 kaSlZ0mgbtdzuzC4zOAQaNRAKa4o5iwxjeurZO/Q=
Date: Mon, 17 Mar 2025 20:43:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com,
 liuzixing@hygon.cn
Subject: Re: [PATCH V2] mm/cma: using per-CMA locks to improve concurrent
 allocation performance
Message-Id: <20250317204325.99b45373023ad2f901c1152e@linux-foundation.org>
In-Reply-To: <1739152566-744-1-git-send-email-yangge1116@126.com>
References: <1739152566-744-1-git-send-email-yangge1116@126.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 09:56:06 +0800 yangge1116@126.com wrote:

> From: yangge <yangge1116@126.com>
> 
> For different CMAs, concurrent allocation of CMA memory ideally should not
> require synchronization using locks. Currently, a global cma_mutex lock is
> employed to synchronize all CMA allocations, which can impact the
> performance of concurrent allocations across different CMAs.
> 
> To test the performance impact, follow these steps:
> 1. Boot the kernel with the command line argument hugetlb_cma=30G to
>    allocate a 30GB CMA area specifically for huge page allocations. (note:
>    on my machine, which has 3 nodes, each node is initialized with 10G of
>    CMA)
> 2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
>    count=30 to fully utilize the CMA area by writing zeroes to a file in
>    /dev/shm.
> 3. Open three terminals and execute the following commands simultaneously:
>    (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
>    pages] of CMA memory.)
>    On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
>    On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
>    On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc
> 
> We attempt to allocate pages through the CMA debug interface and use the
> time command to measure the duration of each allocation.
> Performance comparison:
>              Without this patch      With this patch
> Terminal1        ~7s                     ~7s
> Terminal2       ~14s                     ~8s
> Terminal3       ~21s                     ~7s
> 
> To slove problem above, we could use per-CMA locks to improve concurrent
> allocation performance. This would allow each CMA to be managed
> independently, reducing the need for a global lock and thus improving
> scalability and performance.

This patch was in and out of mm-unstable for a while, as Frank's series
"hugetlb/CMA improvements for large systems" was being added and
dropped.

Consequently it hasn't received any testing for a while.

Below is the version which I've now re-added to mm-unstable.  Can
you please check this and retest it?

Thanks.

From: Ge Yang <yangge1116@126.com>
Subject: mm/cma: using per-CMA locks to improve concurrent allocation performance
Date: Mon, 10 Feb 2025 09:56:06 +0800

For different CMAs, concurrent allocation of CMA memory ideally should not
require synchronization using locks.  Currently, a global cma_mutex lock
is employed to synchronize all CMA allocations, which can impact the
performance of concurrent allocations across different CMAs.

To test the performance impact, follow these steps:
1. Boot the kernel with the command line argument hugetlb_cma=30G to
   allocate a 30GB CMA area specifically for huge page allocations. (note:
   on my machine, which has 3 nodes, each node is initialized with 10G of
   CMA)
2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
   count=30 to fully utilize the CMA area by writing zeroes to a file in
   /dev/shm.
3. Open three terminals and execute the following commands simultaneously:
   (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
   pages] of CMA memory.)
   On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
   On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
   On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc

We attempt to allocate pages through the CMA debug interface and use the
time command to measure the duration of each allocation.
Performance comparison:
             Without this patch      With this patch
Terminal1        ~7s                     ~7s
Terminal2       ~14s                     ~8s
Terminal3       ~21s                     ~7s

To solve problem above, we could use per-CMA locks to improve concurrent
allocation performance.  This would allow each CMA to be managed
independently, reducing the need for a global lock and thus improving
scalability and performance.

Link: https://lkml.kernel.org/r/1739152566-744-1-git-send-email-yangge1116@126.com
Signed-off-by: Ge Yang <yangge1116@126.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/cma.c |    7 ++++---
 mm/cma.h |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/mm/cma.c~mm-cma-using-per-cma-locks-to-improve-concurrent-allocation-performance
+++ a/mm/cma.c
@@ -34,7 +34,6 @@
 
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned int cma_area_count;
-static DEFINE_MUTEX(cma_mutex);
 
 static int __init __cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
@@ -175,6 +174,8 @@ static void __init cma_activate_area(str
 
 	spin_lock_init(&cma->lock);
 
+	mutex_init(&cma->alloc_mutex);
+
 #ifdef CONFIG_CMA_DEBUGFS
 	INIT_HLIST_HEAD(&cma->mem_head);
 	spin_lock_init(&cma->mem_head_lock);
@@ -813,9 +814,9 @@ static int cma_range_alloc(struct cma *c
 		spin_unlock_irq(&cma->lock);
 
 		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
-		mutex_lock(&cma_mutex);
+		mutex_lock(&cma->alloc_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
-		mutex_unlock(&cma_mutex);
+		mutex_unlock(&cma->alloc_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
 			break;
--- a/mm/cma.h~mm-cma-using-per-cma-locks-to-improve-concurrent-allocation-performance
+++ a/mm/cma.h
@@ -39,6 +39,7 @@ struct cma {
 	unsigned long	available_count;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
+	struct mutex alloc_mutex;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
_


