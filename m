Return-Path: <linux-kernel+bounces-363860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6599C7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D61F1F2486D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47111AAE16;
	Mon, 14 Oct 2024 11:00:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB241AA782
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903616; cv=none; b=L3tj3P0iPTNgOdPgt6iBeDbSR1pLJSx9FPAXQvE+3k0ACq/stdEiZrpN2Eix4SKVcVTdctSxwzNhdovZCstT+hTNE6WOvkVBkqu+NA3tgjJD9MtDZDV6PXJOUhjr9tRTBD31emMoAPxObZ1Wf1FN1go6uA9tCW6/WaynWsk5F9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903616; c=relaxed/simple;
	bh=RJA+e4KX+mvmw1zI84SqBEoV8nApC8Eop+pK1GntlbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhqLyGMmUZUxST/CnOMUtDbF3c6lWV81r1pLoNcP3eKsFQmGB5a9qOrdb3uK/ku0DLEx2V0pox7+BBBzQrjJKDdq5WwP1W6sXFtV9NeRYboJA/9pbVd7764IsRXM4B4nJJrQzHsEprp5lUuLzyI9i9lM2aZf4+hcP9p5UGD/9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5741691;
	Mon, 14 Oct 2024 04:00:43 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0D53F51B;
	Mon, 14 Oct 2024 04:00:11 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 15/57] stackdepot: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:22 +0100
Message-ID: <20241014105912.3207374-15-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

"union handle_parts" previously calculated the number of bits required
for its pool index and offset members based on PAGE_SHIFT. This is
problematic for boot-time page size builds because the actual page size
isn't known until boot-time.

We could use PAGE_SHIFT_MAX in calculating the worst case offset bits,
but bits would be wasted that could be used for pool index when
PAGE_SIZE is set smaller than MAX, the end result being that stack depot
can address less memory than it should.

To avoid needing to dynamically define the offset and index bit widths,
let's instead fix the pool size and derive the order at runtime based on
the PAGE_SIZE. This means that the fields' widths can remain static,
with the down side being slightly increased risk of failing to allocate
the large folio.

This only affects boot-time page size builds. compile-time page size
builds will still always allocate order-2 folios.

Additionally, wrap global variables that are initialized with PAGE_SIZE
derived values using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their
initialization can be deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/stackdepot.h | 6 +++---
 lib/stackdepot.c           | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e9ec32fb97d4a..ac877a4e90406 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -32,10 +32,10 @@ typedef u32 depot_stack_handle_t;
 
 #define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
 
-#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
-#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages of PAGE_SIZE_MAX */
+#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT_MAX + DEPOT_POOL_ORDER))
 #define DEPOT_STACK_ALIGN 4
-#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT_MAX - DEPOT_STACK_ALIGN)
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc3..974351f0e9e3c 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -68,7 +68,7 @@ static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
 /* Offset to the unused space in the currently used pool. */
-static size_t pool_offset = DEPOT_POOL_SIZE;
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(size_t, pool_offset, DEPOT_POOL_SIZE);
 /* Freelist of stack records within stack_pools. */
 static LIST_HEAD(free_stacks);
 /* The lock must be held when performing pool or freelist modifications. */
@@ -625,7 +625,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	 */
 	if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
 		page = alloc_pages(gfp_nested_mask(alloc_flags),
-				   DEPOT_POOL_ORDER);
+				   get_order(DEPOT_POOL_SIZE));
 		if (page)
 			prealloc = page_address(page);
 	}
@@ -663,7 +663,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 exit:
 	if (prealloc) {
 		/* Stack depot didn't use this memory, free it. */
-		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
+		free_pages((unsigned long)prealloc, get_order(DEPOT_POOL_SIZE));
 	}
 	if (found)
 		handle = found->handle.handle;
-- 
2.43.0


