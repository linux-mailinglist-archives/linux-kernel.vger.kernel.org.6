Return-Path: <linux-kernel+bounces-560369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C26A60337
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB527A56B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA61F463F;
	Thu, 13 Mar 2025 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VueEj8pF"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DF1F540F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900027; cv=none; b=U0+DYSvQOdPezagx1L+ZUqUjbMqvhk2hAQ/BLg+pLyV/MXmx/PmGXVXH5rzzOAiRAEfC932XJPydnisZGlSNVv0SWABR8KO/DdewcPWtP2PMY/kjbFdHTIsr2XPsVd6yZVS1XTT0G43m+emF/nqgd3VUQ0pvavpKXs2Xk2OQkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900027; c=relaxed/simple;
	bh=G5viki70LrhtbkQE4Q5MpsJyR7EHFb+uxi7SbmxvjUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu21ribhpi0Gb2WkLBsIpc4Mld5gaPoeyX9iDFaGVtd6fgNzxypxvZcEj2MaFUUrnPt1v7GPn+DrCEa/Uu/gK0gA37n95S9CmhEWNSGZPr6cbFe6tWnQ6aOslj7uGQvsce5gvDkNR8v1oQ0NrGyyOLwL6fKnHcaCf3HNfd1ZTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VueEj8pF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ddcff5a823so12826116d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900024; x=1742504824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZHRsjhwN4k6tUsXlsg8AVWAXyHTwCMhLnhjRmadEFs=;
        b=VueEj8pFsLksb5cIDfWIXaZZUXlOwlZZjHb1zEIeest6oB0PnuknAaRPdXfPlQRel2
         ENPAgITF6SaTDGIpcsiPfvYEsqUa1NkhIMjUVC9roc0aKfi7rhkvwjW+A5NSvJU/pIHL
         Qs3VOSw2i+Mx6C0TverAVbTlnuGTHr+Wm7eD4Dk918wbWZhoy8DJwa8Qy5lXwQQlfhw7
         7jHx7B+4WbSxH2QlDjEJi2+iUpSilKPmimJOpRon4FqEj6Bbn0QGV3QNawxfx9rQFOTD
         T2ISVwHeVEieGQmLFOiV2xAGBWl3xFe9XXKDo4tEFFgK4KVx/X0nfSpMX17MvhTonu/S
         z7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900024; x=1742504824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZHRsjhwN4k6tUsXlsg8AVWAXyHTwCMhLnhjRmadEFs=;
        b=rbNr6z8p8HXWHD27tLLsHcLSvs7MIieiAroM/qHg1BWS8AwUVzLVu+vIR776S3uPnU
         94LxMaKuTOxDnz7Jl5xUdVyNTfSnStRPQOLuaXXDjGqBsrcCToolo5XC3OB93MkP1df2
         3bKIJE92FbF4N7jDcj+w2Q9D13WOdsokRjhjDGFDGVIsnOLxpAkuooLXCP+hTM9oAwGb
         D+5S9tsAESOIi9C2Nlwq9thdj9n5GLxOkAzAEodmOKGWHvmooIuzOiL0DKHREoFFjwWO
         2K8GrBAzeXWcvG8dmeu89T9ietV4HrGlS2Dik2ZSTfH/rqNu8pjzCQXBeW9EUOW3ZelE
         8sCg==
X-Forwarded-Encrypted: i=1; AJvYcCXx8j4WOtYkAVlgGtrMc6foM055FUbKp2jCtOEo/yrvhAeEaQvEzbikrAGRtMuJr8pNX8TsUtlS+fJLMSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3p4ox6Jej9Dmn3UwzY8KboRFv21JLaG7BtFuGDjrcnqIyk2D
	i8VZho+Nu9DrPHoWiLDLCrhLaTt2RBSLcIARXtgpO2/AbQcGnEL2YrrhuWEpwJE=
X-Gm-Gg: ASbGnct9M5jUJGeuFOhot+lIQyMHXvAhxEh9B/iapvrhtQdJAyO1QJ8gK7cC5+cruUA
	XGdjTI5lgtpXkHF11fiVT4wuCmtvX4KtcqmNB8V0YsXrb2GvjbcJjAifQLLVX7IMtzee5OBkc54
	gQLeJE57lkKvm7PaLS9f8e7M/G4m8rh9CHgvfrJUAP8ZdtgNZWwC3kaUOF/8sNaq06YpP6m9U9L
	d3lT1jkH/nUve674UJwhE+swsgivc7+ALPzYnmSi/47+3FftDqRgfcWNZPdqj0N983ZQNZeTLF3
	bOashCoGY8JMHviFjaH4PJaYzD5VBZt8yWMdInySdw0=
X-Google-Smtp-Source: AGHT+IHwO+cZb5MGTiwyC3MJf2gMVF38ko0IXPhHKQ4bI2CQqbDOb0AFS8ZUsuofmUulVbWhY9Mvjw==
X-Received: by 2002:a05:6214:5299:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6eae7b3faa0mr22068376d6.45.1741900024009;
        Thu, 13 Mar 2025 14:07:04 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade230de3sm14015326d6.28.2025.03.13.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:07:02 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: page_alloc: defrag_mode
Date: Thu, 13 Mar 2025 17:05:34 -0400
Message-ID: <20250313210647.1314586-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313210647.1314586-1-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page allocator groups requests by migratetype to stave off
fragmentation. However, in practice this is routinely defeated by the
fact that it gives up *before* invoking reclaim and compaction - which
may well produce suitable pages. As a result, fragmentation of
physical memory is a common ongoing process in many load scenarios.

Fragmentation deteriorates compaction's ability to produce huge
pages. Depending on the lifetime of the fragmenting allocations, those
effects can be long-lasting or even permanent, requiring drastic
measures like forcible idle states or even reboots as the only
reliable ways to recover the address space for THP production.

In a kernel build test with supplemental THP pressure, the THP
allocation rate steadily declines over 15 runs:

    thp_fault_alloc
    61988
    56474
    57258
    50187
    52388
    55409
    52925
    47648
    43669
    40621
    36077
    41721
    36685
    34641
    33215

This is a hurdle in adopting THP in any environment where hosts are
shared between multiple overlapping workloads (cloud environments),
and rarely experience true idle periods. To make THP a reliable and
predictable optimization, there needs to be a stronger guarantee to
avoid such fragmentation.

Introduce defrag_mode. When enabled, reclaim/compaction is invoked to
its full extent *before* falling back. Specifically, ALLOC_NOFRAGMENT
is enforced on the allocator fastpath and the reclaiming slowpath.

For now, fallbacks are permitted to avert OOMs. There is a plan to add
defrag_mode=2 to prefer OOMs over fragmentation, but this requires
additional prep work in compaction and the reserve management to make
it ready for all possible allocation contexts.

The following test results are from a kernel build with periodic
bursts of THP allocations, over 15 runs:

                                        vanilla    defrag_mode=1
@claimer[unmovable]:                        189              103
@claimer[movable]:                           92              103
@claimer[reclaimable]:                      207               61
@pollute[unmovable from movable]:            25                0
@pollute[unmovable from reclaimable]:        28                0
@pollute[movable from unmovable]:         38835                0
@pollute[movable from reclaimable]:      147136                0
@pollute[reclaimable from unmovable]:       178                0
@pollute[reclaimable from movable]:          33                0
@steal[unmovable from movable]:              11                0
@steal[unmovable from reclaimable]:           5                0
@steal[reclaimable from unmovable]:         107                0
@steal[reclaimable from movable]:            90                0
@steal[movable from reclaimable]:           354                0
@steal[movable from unmovable]:             130                0

Both types of polluting fallbacks are eliminated in this workload.

Interestingly, whole block conversions are reduced as well. This is
because once a block is claimed for a type, its empty space remains
available for future allocations, instead of being padded with
fallbacks; this allows the native type to group up instead of
spreading out to new blocks. The assumption in the allocator has been
that pollution from movable allocations is less harmful than from
other types, since they can be reclaimed or migrated out should the
space be needed. However, since fallbacks occur *before*
reclaim/compaction is invoked, movable pollution will still cause
non-movable allocations to spread out and claim more blocks.

Without fragmentation, THP rates hold steady with defrag_mode=1:

    thp_fault_alloc
    32478
    20725
    45045
    32130
    14018
    21711
    40791
    29134
    34458
    45381
    28305
    17265
    22584
    28454
    30850

While the downward trend is eliminated, the keen reader will of course
notice that the baseline rate is much smaller than the vanilla
kernel's to begin with. This is due to deficiencies in how reclaim and
compaction are currently driven: ALLOC_NOFRAGMENT increases the extent
to which smaller allocations are competing with THPs for pageblocks,
while making no effort themselves to reclaim or compact beyond their
own request size. This effect already exists with the current usage of
ALLOC_NOFRAGMENT, but is amplified by defrag_mode insisting on whole
block stealing much more strongly.

Subsequent patches will address defrag_mode reclaim strategy to raise
the THP success baseline above the vanilla kernel.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/sysctl/vm.rst |  9 +++++++++
 mm/page_alloc.c                         | 27 +++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index ec6343ee4248..e169dbf48180 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -29,6 +29,7 @@ files can be found in mm/swap.c.
 - compaction_proactiveness
 - compaction_proactiveness_leeway
 - compact_unevictable_allowed
+- defrag_mode
 - dirty_background_bytes
 - dirty_background_ratio
 - dirty_bytes
@@ -162,6 +163,14 @@ On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
 to compaction, which would block the task from becoming active until the fault
 is resolved.
 
+defrag_mode
+===========
+
+When set to 1, the page allocator tries harder to avoid fragmentation
+and maintain the ability to produce huge pages / higher-order pages.
+
+It is recommended to enable this right after boot, as fragmentation,
+once it occurred, can be long-lasting or even permanent.
 
 dirty_background_bytes
 ======================
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f0404941886..9a02772c2461 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -273,6 +273,7 @@ int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 static int watermark_boost_factor __read_mostly = 15000;
 static int watermark_scale_factor = 10;
+static int defrag_mode;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
@@ -3389,6 +3390,11 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 	 */
 	alloc_flags = (__force int) (gfp_mask & __GFP_KSWAPD_RECLAIM);
 
+	if (defrag_mode) {
+		alloc_flags |= ALLOC_NOFRAGMENT;
+		return alloc_flags;
+	}
+
 #ifdef CONFIG_ZONE_DMA32
 	if (!zone)
 		return alloc_flags;
@@ -3480,7 +3486,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				continue;
 		}
 
-		if (no_fallback && nr_online_nodes > 1 &&
+		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
 		    zone != zonelist_zone(ac->preferred_zoneref)) {
 			int local_nid;
 
@@ -3591,7 +3597,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	 * It's possible on a UMA machine to get through all zones that are
 	 * fragmented. If avoiding fragmentation, reset and try again.
 	 */
-	if (no_fallback) {
+	if (no_fallback && !defrag_mode) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
 		goto retry;
 	}
@@ -4128,6 +4134,9 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
+	if (defrag_mode)
+		alloc_flags |= ALLOC_NOFRAGMENT;
+
 	return alloc_flags;
 }
 
@@ -4510,6 +4519,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 				&compaction_retries))
 		goto retry;
 
+	/* Reclaim/compaction failed to prevent the fallback */
+	if (defrag_mode) {
+		alloc_flags &= ALLOC_NOFRAGMENT;
+		goto retry;
+	}
 
 	/*
 	 * Deal with possible cpuset update races or zonelist updates to avoid
@@ -6286,6 +6300,15 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_THREE_THOUSAND,
 	},
+	{
+		.procname	= "defrag_mode",
+		.data		= &defrag_mode,
+		.maxlen		= sizeof(defrag_mode),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "percpu_pagelist_high_fraction",
 		.data		= &percpu_pagelist_high_fraction,
-- 
2.48.1


