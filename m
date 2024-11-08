Return-Path: <linux-kernel+bounces-401219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A469C1752
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EC41F23555
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BC1DD861;
	Fri,  8 Nov 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZXbg/zx9"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E841DC753
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052251; cv=none; b=WWYAAlooQ33f4ZSTb/t6Ioj/ADOj1sn8h1HdvPRkHVxKz5YC7JscgtLbIgIF0t0x9L0UGonioeDJ6HINW6iVzbvnu9NUHN3LN5nn/GyG2rpTJfQH9K35PF3Z1Z2VI26sLeqdNueS4g7Dhb+RDEyqBt1mGNUibme/3Qs9nQ4jNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052251; c=relaxed/simple;
	bh=NSv9HKYTfpKEAj81UE+nz5xJvLKjprqFaGJ4xlyv76c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGwt5HBt0N0ID2jHNxRXIvbwCOOme44MWCPh/kM6jk+bFFrode27qZ5JkSzQWRqPIf/k2q5YsyvRHzolPn7QbH5I266heND0rt35LJRUnpI1/aRRfrtPBacu46CPxs+i35ZoYbH698KYFS6AnS/5rWGl+ZEdx2aAopsMr0P7ea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZXbg/zx9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731052246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUvCn2yrrfm8AzUVnUrwIJ/DyEBVwLRQoeLNZi8hUx4=;
	b=ZXbg/zx9eILoNJVRb9TG5+ghUGg+6oeeRnwEQ0QKIMY2gQNY2dirJcVskavAYA1RQMWYiL
	qsOUIHJZp/XBkWgJkWlLlA7RQSvD37oZT/JIFWFiE6PxsiZcgkVxOTa/R7V4WFM4H2sTW8
	0aPxJn0SN1tH6hAt5yyc1M0ALVQ2yCY=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org,
	surenb@google.com,
	kent.overstreet@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] lib/alloc_tag: Remove the sysctl configuration to prevent users from disabling it at runtime
Date: Fri,  8 Nov 2024 15:50:04 +0800
Message-Id: <20241108075004.131911-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

After much consideration,I have decided to remove
the "mem_profiling" sysctl interface to prevent
users from dynamically enabling or disabling the
MEMORY ALLOCATION PROFILING feature at runtime.

I have taken the following actions: I set
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y to
enable memory allocation profiling by default,
and then made adjustments to mem_profiling dynamically
during runtime.

When I ran the OOM test program, I obtained useful
information that was indeed very helpful for debugging.

[ 1023.065402] Memory allocations:
[ 1023.065407]     12.8 GiB     6546 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
[ 1023.065412]      873 MiB   229985 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
[ 1023.065415]      187 MiB    29732 mm/slub.c:2412 func:alloc_slab_page
[ 1023.065418]     99.8 MiB    25560 mm/memory.c:1065 func:folio_prealloc
[ 1023.065421]     47.2 MiB     3189 mm/readahead.c:434 func:ra_alloc_folio
[ 1023.065424]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
[ 1023.065428]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
[ 1023.065430]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
[ 1023.065433]     25.6 MiB     6546 mm/huge_memory.c:1161 func:__do_huge_pmd_anonymous_page
[ 1023.065436]     23.5 MiB     6017 mm/shmem.c:1771 func:shmem_alloc_folio

After running echo 0 > /proc/sys/vm/mem_profiling
and then executing the same test program,
I obtained the following results

[ 1156.509699] Memory allocations:
[ 1156.509703]      187 MiB    29645 mm/slub.c:2412 func:alloc_slab_page
[ 1156.509707]      142 MiB     9357 mm/readahead.c:434 func:ra_alloc_folio
[ 1156.509710]      136 MiB    41325 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
[ 1156.509713]     99.7 MiB    25531 mm/memory.c:1065 func:folio_prealloc
[ 1156.509716]     56.0 MiB       28 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
[ 1156.509719]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
[ 1156.509723]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
[ 1156.509725]     26.3 MiB     7460 mm/readahead.c:264 func:page_cache_ra_unbounded
[ 1156.509728]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
[ 1156.509730]     23.5 MiB     6016 mm/shmem.c:1771 func:shmem_alloc_folio

Because mem_profiling was disabled by executing
echo 0 > /proc/sys/vm/mem_profiling,we are unable to
record memory allocation information after the disablement.
These output logs can mislead users. And similarly, the same
applies to alloc_info.

We already have boot parameters that allow users to
choose whether to enable or disable.
In order to maintain the accuracy of memory allocation
information,I have decided to remove the runtime switch.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 lib/alloc_tag.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..47fa969c23f3 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -227,31 +227,6 @@ struct page_ext_operations page_alloc_tagging_ops = {
 };
 EXPORT_SYMBOL(page_alloc_tagging_ops);
 
-#ifdef CONFIG_SYSCTL
-static struct ctl_table memory_allocation_profiling_sysctls[] = {
-	{
-		.procname	= "mem_profiling",
-		.data		= &mem_alloc_profiling_key,
-#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
-		.mode		= 0444,
-#else
-		.mode		= 0644,
-#endif
-		.proc_handler	= proc_do_static_key,
-	},
-};
-
-static void __init sysctl_init(void)
-{
-	if (!mem_profiling_support)
-		memory_allocation_profiling_sysctls[0].mode = 0444;
-
-	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
-}
-#else /* CONFIG_SYSCTL */
-static inline void sysctl_init(void) {}
-#endif /* CONFIG_SYSCTL */
-
 static int __init alloc_tag_init(void)
 {
 	const struct codetag_type_desc desc = {
@@ -264,7 +239,6 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
-	sysctl_init();
 	procfs_init();
 
 	return 0;
-- 
2.25.1


