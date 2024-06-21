Return-Path: <linux-kernel+bounces-224851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935491279A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92421F268FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496FEAE1;
	Fri, 21 Jun 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg1VGXEa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3D22EF3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979919; cv=none; b=lr+7KeBFNiLK0k/Cvkucc3EtnLfpoFkkJqKBcQKvvusWxtvU2xgkSrS0e/OOlUfc6/em0+kkgFh6pQ9PIshE/cYdJb4ecN08bCbRMxRL7H7dPDouaANycrQpxAhEiPp6rC1Ch9OLAG5VhkBu/qcrBjiJCkncuJ7zR67tgRx/a0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979919; c=relaxed/simple;
	bh=Imr7BXwXpPmXA7Je8Mj7QUC4jwpI9lQNsZRoGr1DKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujkCjRNHGXApU+BVTXU1tcDNhjMfHUyMDhSPrepZIq/Y0vh6VMgC8zYR2xuiglUVXPTQi/sf0AZ5dDD+CRMUd8xyiCSYuzpPyCcjY6sEn6vj6BNtjYUTBb8WOh8AX7jvOaDgANCKGnllO+DPR+Kry6zShbOiM1fPHhnQLbtmPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg1VGXEa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJ/z3oUyfvIT45NLtsICo4unaxlXJrC1yYznR3c5j0M=;
	b=bg1VGXEaxL37U0T644gJ76xSoctDesBSH46+uVUQc7tL2t9VYQGSi5bGzOf/6jrAjMr1GF
	bvPJ7ZDDVLxwikSrMhsSpMCVrjIb/WWIB60B/iihSYhpX6s9EKPJNM1Sp8d9Gy6FNdUNA7
	I9Uo+9VuUtNG9mo6pU7OBId68Pb+BjY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-V5L1xgk_OOaJ62WsqJQQZQ-1; Fri, 21 Jun 2024 10:25:12 -0400
X-MC-Unique: V5L1xgk_OOaJ62WsqJQQZQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-798084906ddso13082585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979911; x=1719584711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ/z3oUyfvIT45NLtsICo4unaxlXJrC1yYznR3c5j0M=;
        b=udtDWAJx5D+kUMOolU0ZCEB23afo7Vy4gEVjnSKqrCEnqI/Gv/2eV18s19xdAny+jl
         g2Cw3J4kkvABU6aMl/tR5zO92GdSzouu5KUcH6R3TqT6iwazFyIqDHmjiC5olOAqN+An
         UP9We8byfseJ9xsvn+BG2hbaHCwf3WT7TgdD1Il3MJ/AhAwA7TzfkPtWfGs8G2i9XTtB
         h0hpVsAlRndG+ZzvbzIspWli8qLdP3nRuo/KSpc/SMiJhHz8BazGv5DMCeB5SxT5TaoH
         krExnZJtsiQr6AqyH0C47Ck7LFzeDEiAblUwvoADY/mlk+kXcGuhXx5AqYUjz556mgkh
         BWmg==
X-Gm-Message-State: AOJu0YwdbAnKm61AlOx2n9MAgEtwk7XGoEDdOW31Owy0oEIVqX0r/yOE
	ymLeu5Bs4c39Dm8HJAjkqg7mgf3s+Tyq1weHysGTez3BknCUj7VPlxC4mCcT3bHtEJcXUhYGBYi
	REU2sJX19Sl8kBW7FOVgUcCmcTPWFFQogql/pDp4XuJ3MSLdrApXbo1DP2jwSyke77GI4G5k2KB
	kmK/rNbuxkgO1NiZA2jg44MNNmN3YyxKDY4yt50qBunDk=
X-Received: by 2002:a05:620a:4610:b0:79b:be0b:7815 with SMTP id af79cd13be357-79bbe0b7c0fmr735913185a.1.1718979911415;
        Fri, 21 Jun 2024 07:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1JVg4Gm5x1JzvXAIal9/bHLuF/aojpegzJFLEbRVA7h1M8KnWp/bZUR1LNlUwbmLSWaEiNQ==
X-Received: by 2002:a05:620a:4610:b0:79b:be0b:7815 with SMTP id af79cd13be357-79bbe0b7c0fmr735907585a.1.1718979910823;
        Fri, 21 Jun 2024 07:25:10 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: [PATCH 2/7] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Date: Fri, 21 Jun 2024 10:24:59 -0400
Message-ID: <20240621142504.1940209-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240621142504.1940209-1-peterx@redhat.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2013, commit 72403b4a0fbd ("mm: numa: return the number of base pages
altered by protection changes") introduced "numa_huge_pte_updates" vmstat
entry, trying to capture how many huge ptes (in reality, PMD thps at that
time) are marked by NUMA balancing.

This patch proposes to remove it for some reasons.

Firstly, the name is misleading. We can have more than one way to have a
"huge pte" at least nowadays, and that's also the major goal of this patch,
where it paves way for PUD handling in change protection code paths.

PUDs are coming not only for dax (which has already came and yet broken..),
but also for pfnmaps and hugetlb pages.  The name will simply stop making
sense when PUD will start to be involved in mprotect() world.

It'll also make it not reasonable either if we boost the counter for both
pmd/puds.  In short, current accounting won't be right when PUD comes, so
the scheme was only suitable at that point in time where PUD wasn't even
possible.

Secondly, the accounting was simply not right from the start as long as it
was also affected by other call sites besides NUMA.  mprotect() is one,
while userfaultfd-wp also leverages change protection path to modify
pgtables.  If it wants to do right it needs to check the caller but it
never did; at least mprotect() should be there even in 2013.

It gives me the impression that nobody is seriously using this field, and
it's also impossible to be serious.

We may want to do it right if any NUMA developers would like it to exist,
but we should do that with all above resolved, on both considering PUDs,
but also on correct accountings.  That should be able to be done on top
when there's a real need of such.

Cc: Huang Ying <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Alex Thorlton <athorlton@sgi.com>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/vm_event_item.h | 1 -
 mm/mprotect.c                 | 8 +-------
 mm/vmstat.c                   | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 73fa5fbf33a3..a76b75d6a8f4 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -59,7 +59,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		OOM_KILL,
 #ifdef CONFIG_NUMA_BALANCING
 		NUMA_PTE_UPDATES,
-		NUMA_HUGE_PTE_UPDATES,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..21172272695e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -363,7 +363,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	pmd_t *pmd;
 	unsigned long next;
 	long pages = 0;
-	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
 	range.start = 0;
@@ -411,11 +410,8 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				ret = change_huge_pmd(tlb, vma, pmd,
 						addr, newprot, cp_flags);
 				if (ret) {
-					if (ret == HPAGE_PMD_NR) {
+					if (ret == HPAGE_PMD_NR)
 						pages += HPAGE_PMD_NR;
-						nr_huge_updates++;
-					}
-
 					/* huge pmd was handled */
 					goto next;
 				}
@@ -435,8 +431,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	if (range.start)
 		mmu_notifier_invalidate_range_end(&range);
 
-	if (nr_huge_updates)
-		count_vm_numa_events(NUMA_HUGE_PTE_UPDATES, nr_huge_updates);
 	return pages;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6e3347789eb2..be774893f69e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1313,7 +1313,6 @@ const char * const vmstat_text[] = {
 
 #ifdef CONFIG_NUMA_BALANCING
 	"numa_pte_updates",
-	"numa_huge_pte_updates",
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
-- 
2.45.0


