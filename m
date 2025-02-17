Return-Path: <linux-kernel+bounces-517535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC50A38217
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2467A1488
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672A2219A9D;
	Mon, 17 Feb 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRzK+0SD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F908219A67
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792558; cv=none; b=T+HgCnCt9UXurpCTBv7S03kp2pr6lUVOoqXGslzfvUZ2bpTrbNLzD8JNePXeJi7AErHRoH4JsACmw3a9m8fHrP4LlkQdubP5R1OMUF0Psxm4EqtGDvh39eioN5hxLJrMHrU5XGrAI3bN+7Ozi63KDuuNFmMX83MBGZ2gnPzG0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792558; c=relaxed/simple;
	bh=DNULcASukNRpXS5sreTTqFhtJw596PFXgzjCQbZMGCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQbM2a2RYNtS6tCQ7GiLiCp43wxw0RpFn56XEzYAjHXbNxsB8jNVlu27zdQodOE9ZlXNHKshW16spKBIIdr3MDrs+H17dyVVlFd44I1BFoNCAmE7g2JCgk55d+W+/yqZ3SH+AowRfGHZa0V2efXt7iGUbR1YTHURtB81gcc/0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRzK+0SD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739792557; x=1771328557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNULcASukNRpXS5sreTTqFhtJw596PFXgzjCQbZMGCM=;
  b=CRzK+0SDvonGa2iSMSDsytOHrI/iXWjErI7q9PslSn/TRih8TXI9k1EU
   23AoxNjvKwrqj5f3QbZuZGjMcdTPeooyX+E/PeCwjWcpRdiVI7m0VvwqS
   cKXiKxUlyAwA2Y6ZDNnhjJ42kRHkazZXcQhYlx9Hjnvw9oR4YIBZkLcg3
   06riKL/k9+U2JdR5fqMAc1ICAmrTIF6t/cvSRGVe45KU8dHpUQ5UChy8N
   qyFj+YfFTeoVzNi+OaaPG35z/TFzUQIBI8urVFlD1ry3NJzccJPo/Yo19
   EugFyW3wP71kUB8Y0aL3yfhuYikGFvSymOjQfO/+XsUveHTkcMTJ+GxK5
   A==;
X-CSE-ConnectionGUID: gpg9FoE6QFKIFOuYPG8hWA==
X-CSE-MsgGUID: nlWNqEnfQuehJmHW6tK9GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40394198"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40394198"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 03:42:37 -0800
X-CSE-ConnectionGUID: DCc9MJb0TqmkSVVIYLwqAg==
X-CSE-MsgGUID: /k5Od7wqRhS+eLrOglLz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114725589"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO rapter.intel.com) ([10.245.246.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 03:42:34 -0800
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To: linux-kernel@vger.kernel.org
Cc: osalvador@suse.de,
	42.hyeyoo@gmail.com,
	byungchul@sk.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of vmemmap-based VA
Date: Mon, 17 Feb 2025 13:41:33 +0200
Message-ID: <20250217114133.400063-2-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process leads the addition of a struct page to vmemmap
(e.g. hot-plug), the page table update for the newly added vmemmap-based
virtual address is updated first in init_mm's page table and then
synchronized later.
If the vmemmap-based virtual address is accessed through the process's
page table before this sync, a page fault will occur.

This translates vmemmap-based virtual address to direct-mapped virtual
address and use it, if the current top-level page table is not init_mm's
page table when accessing a vmemmap-based virtual address before this sync.

Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/mm/init_64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..1cb26f692831 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -844,6 +844,17 @@ void __init paging_init(void)
  */
 static unsigned long unused_pmd_start __meminitdata;
 
+static void * __meminit vmemmap_va_to_kaddr(unsigned long vmemmap_va)
+{
+	void *kaddr = (void *)vmemmap_va;
+	pgd_t *pgd = __va(read_cr3_pa());
+
+	if (init_mm.pgd != pgd)
+		kaddr = __va(slow_virt_to_phys(kaddr));
+
+	return kaddr;
+}
+
 static void __meminit vmemmap_flush_unused_pmd(void)
 {
 	if (!unused_pmd_start)
@@ -851,7 +862,7 @@ static void __meminit vmemmap_flush_unused_pmd(void)
 	/*
 	 * Clears (unused_pmd_start, PMD_END]
 	 */
-	memset((void *)unused_pmd_start, PAGE_UNUSED,
+	memset(vmemmap_va_to_kaddr(unused_pmd_start), PAGE_UNUSED,
 	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
 	unused_pmd_start = 0;
 }
@@ -882,7 +893,7 @@ static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
 	 * case the first memmap never gets initialized e.g., because the memory
 	 * block never gets onlined).
 	 */
-	memset((void *)start, 0, sizeof(struct page));
+	memset(vmemmap_va_to_kaddr(start), 0, sizeof(struct page));
 }
 
 static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
@@ -924,7 +935,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
 	 */
 	if (!IS_ALIGNED(start, PMD_SIZE))
-		memset((void *)page, PAGE_UNUSED, start - page);
+		memset(vmemmap_va_to_kaddr(page), PAGE_UNUSED, start - page);
 
 	/*
 	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
-- 
2.48.1


