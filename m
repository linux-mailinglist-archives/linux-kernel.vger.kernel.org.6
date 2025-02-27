Return-Path: <linux-kernel+bounces-537446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE02A48BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7195188F0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A823E355;
	Thu, 27 Feb 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReviaM9y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA884438B;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696312; cv=none; b=BG+/akimBgEfNrUktyj5tjIjA9/6Z574Yx/KfpbhOqSbiINYBgRYFcqnd9bOgq/6ilpWb3ANfrklJOYPlTwSKkkwPCu4yx11kiSNyOSIdB4M6C1SLYeNPM9ysIUSE/4pATuGEPfDHlifdFwWB/8ZthbCh3MYWMZorN1Ep3AEwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696312; c=relaxed/simple;
	bh=oJkzUc1eO6G6pDf5SWNcF21d4R6h8JEKsl5niSERdXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGCNRVHQitHEAhsJ/pvlTZFpYjnJgI+fNggK4LBuzDELhk0x5OUXHjyxGyZIounUxUvPaJoA6FmaJ7ZzbPRgFNhXgOsYvWTN+39mZdD3QSJeWjPLbYg5u+4KizaTKkOPAqTWW9bjOpS00SeVfqzT2m+OgfveLRW1fvbJPWvZWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReviaM9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47134C4CEE5;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696312;
	bh=oJkzUc1eO6G6pDf5SWNcF21d4R6h8JEKsl5niSERdXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ReviaM9yL+36eqR29e6Vy+s7kRMgf6UR2DuPXer6kYpF66TbEH8IrrMV/pIKDRZgQ
	 uxWGq/oaUO4smsW4N8sgNwJ/kzKWuFe4PgYWKM3M4ej2Sx4u8qSjwULkJ6zQSil0Su
	 aJM49uQc/djfCltKu3NRTkStM8oA4D4PFi+OmLa4zdy2awpUtnW+9dexgdg74yqjxo
	 J+/rKLyJQKOclSVXJY/mYx3y8Gzc0GIZrJlf7K0VD92zPA8i2Y0ztc06GfaVrAQFLE
	 fcltTlj2HA+NqTuf5Mv7QneE6o4IcWlPDAcROIahDrHFUWQeobE2Icb9mV6YuVj9gX
	 VdCaZ5LiAT0ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376BAC282C5;
	Thu, 27 Feb 2025 22:45:12 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Thu, 27 Feb 2025 23:45:05 +0100
Subject: [PATCH v2 1/3] mm: hugetlb: improve parallel huge page allocation
 time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-hugepage-parameter-v2-1-7db8c6dc0453@cyberus-technology.de>
References: <20250227-hugepage-parameter-v2-0-7db8c6dc0453@cyberus-technology.de>
In-Reply-To: <20250227-hugepage-parameter-v2-0-7db8c6dc0453@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740696310; l=3225;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=J38/TB8riQAZ4fzuSMdQ3k6+xa/EprG/GBf8GbXV050=;
 b=N4v8H7XB40hwjOeVzS9b78vwFut9BRoOByegtj+ANmDvtJNJUb0+/dyY3IgOtGis0NqPG1rj7
 K9li2G7PWLgD7gQQ4vqzz3BzxbBK12dZtF1nd1XSS1XJkld/sxlzqqQ
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

From: Thomas Prescher <thomas.prescher@cyberus-technology.de>

Before this patch, the kernel currently used a hard coded
value of 2 threads per NUMA node for these allocations.

This patch changes this policy and the kernel now uses 25%
of the available hardware threads for the allocations.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
 mm/hugetlb.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 163190e89ea16450026496c020b544877db147d1..e9b1b3e2b9d467f067d54359e1401a03f9926108 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -14,9 +14,11 @@
 #include <linux/pagemap.h>
 #include <linux/mempolicy.h>
 #include <linux/compiler.h>
+#include <linux/cpumask.h>
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -3427,31 +3429,31 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned int num_allocation_threads = max(num_online_cpus() / 4, 1);
+
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
 	job.size	= h->max_huge_pages;
 
 	/*
-	 * job.max_threads is twice the num_node_state(N_MEMORY),
+	 * job.max_threads is 25% of the available cpu threads by default.
 	 *
-	 * Tests below indicate that a multiplier of 2 significantly improves
-	 * performance, and although larger values also provide improvements,
-	 * the gains are marginal.
+	 * On large servers with terabytes of memory, huge page allocation
+	 * can consume a considerably amount of time.
 	 *
-	 * Therefore, choosing 2 as the multiplier strikes a good balance between
-	 * enhancing parallel processing capabilities and maintaining efficient
-	 * resource management.
+	 * Tests below show how long it takes to allocate 1 TiB of memory with 2MiB huge pages.
+	 * 2MiB huge pages. Using more threads can significantly improve allocation time.
 	 *
-	 * +------------+-------+-------+-------+-------+-------+
-	 * | multiplier |   1   |   2   |   3   |   4   |   5   |
-	 * +------------+-------+-------+-------+-------+-------+
-	 * | 256G 2node | 358ms | 215ms | 157ms | 134ms | 126ms |
-	 * | 2T   4node | 979ms | 679ms | 543ms | 489ms | 481ms |
-	 * | 50G  2node | 71ms  | 44ms  | 37ms  | 30ms  | 31ms  |
-	 * +------------+-------+-------+-------+-------+-------+
+	 * +-----------------------+-------+-------+-------+-------+-------+
+	 * | threads               |   8   |   16  |   32  |   64  |   128 |
+	 * +-----------------------+-------+-------+-------+-------+-------+
+	 * | skylake      144 cpus |   44s |   22s |   16s |   19s |   20s |
+	 * | cascade lake 192 cpus |   39s |   20s |   11s |   10s |    9s |
+	 * +-----------------------+-------+-------+-------+-------+-------+
 	 */
-	job.max_threads	= num_node_state(N_MEMORY) * 2;
-	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
+
+	job.max_threads	= num_allocation_threads;
+	job.min_chunk	= h->max_huge_pages / num_allocation_threads;
 	padata_do_multithreaded(&job);
 
 	return h->nr_huge_pages;

-- 
2.48.1



