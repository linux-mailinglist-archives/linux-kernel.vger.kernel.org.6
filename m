Return-Path: <linux-kernel+bounces-547458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC5A50964
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8244F168583
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B0254B19;
	Wed,  5 Mar 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN32lAfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F925484D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198589; cv=none; b=WUAZAKIrXYoZHt3SlUM3cFrvzVfyxAPrPhHLo0aZqnl5JVXsfnrXY/vp+bYQ56u/3cEFXyRI2c6ZIes4HPuI6yMt9dm2o2egkr8bAcUQEbTlFIDe3vlL/IOdkc+L1huZoQy/bv4pFY/WgEjrkR5hOqKyhQc60hzGBOqWXr/VzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198589; c=relaxed/simple;
	bh=5ks7fx/Q1sCl0dg2a2snRfWoft6X+IgkXl2rMy0gCGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVXi5gBNsgLDub0zqgIVS0wX39FIB5OQlI6FlualoABdBEFV6CNFNbwX6UvaCCfuZydTEMLVNaGPiCAcsMM5g6lmGrAXaj/vnBx695ee4UNHdgJZabkp5T5bgLz6ABJ1pkzjsNYQqN2fOssIepyaqkcSizDqORCpNtdUBddbe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN32lAfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D77C4CEE2;
	Wed,  5 Mar 2025 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198589;
	bh=5ks7fx/Q1sCl0dg2a2snRfWoft6X+IgkXl2rMy0gCGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN32lAfOUBUATYQrwl4BKcRsrxm4mSQ3kaYsz2Z0kSriFn1jgHlzV2U6C0xBm4hsD
	 7coxL6aUxhuXz8dmZDGAsaUAqHV7ZEehscytuEa1vzbq5q8IyAtkZv7VEsjmKuJud/
	 nTE3QtKiSWsnOMNuDEtJc+rEEuERdsBPbstKTMn31F18ss5rnYWoEV1kGzrwhf9So+
	 Oh78y+Kz0NuzwnB6DhGgCOqIyb7sWaPAX/f+xGUuDF9HqCWId0tYJK2QPmxz+eb4WU
	 oQOBVsBu52cCCIl3YKWmT+1GhR+dupStWnrMDZwC2FnOPaLGckhmNZGnmQWJRAYYG1
	 kn3rTbJOOUrVA==
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
Subject: [RFC PATCH 08/16] mm/madvise: pass madvise_behavior struct to madvise_dontneed_free()
Date: Wed,  5 Mar 2025 10:16:03 -0800
Message-Id: <20250305181611.54484-9-sj@kernel.org>
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

madvise_dontneed_free() can be optimized to batch tlb flushes by
receiving mmu_gather object that initialized and finished outside, and
doing only gathering of tlb entries that need to be flushed into the
received mmu_gather object.  But the function is receiving only one
single behavior integer value.  Update it to receive
'struct madvise_behavior' object so that upcoming tlb flushes batching
optimization can pass the mmu_gather object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6fa7dabe5bad..73a4323197e2 100644
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
@@ -1241,10 +1246,6 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 			       &guard_remove_walk_ops, NULL);
 }
 
-struct madvise_behavior {
-	int behavior;
-};
-
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1276,7 +1277,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 	case MADV_DONTNEED_LOCKED:
-		return madvise_dontneed_free(vma, prev, start, end, behavior);
+		return madvise_dontneed_free(vma, prev, start, end, arg);
 	case MADV_NORMAL:
 		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
 		break;
-- 
2.39.5

