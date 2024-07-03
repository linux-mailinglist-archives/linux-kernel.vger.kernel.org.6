Return-Path: <linux-kernel+bounces-240205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7621926A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB82850EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E1193097;
	Wed,  3 Jul 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3bnLMXr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DC1940AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042174; cv=none; b=D7h4rNKBu8wy39a1ijrMIRVgkarvIWLLeQoWUdNuwAVG5wZYvR+cdCznV0qR1z0Iuc1y+9F0fAsy2ZLXbi0/6pqMnEMytdqfjFo4FaNzRV1OvxlT6mKXaVPhG+zeI73nRl9sC7ioN4Ur4ystVwWDANUB1HzdragmSfd3fHy46lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042174; c=relaxed/simple;
	bh=j4dGntuy5ovfbg5GfpZwgNQjpitGGaZVaqagsHPmSn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1IlPXHgSrvfHgxeBW5j8Jr9WmL5NxbRAbWG8tz4YPzJ1LhHalciobIaFf5xb5hmA73R6Qe7MTl+I6mnkwWJll4txBx3RDafE+/n9h4m8o1UIyQe6LxwzBa9BG8XX+hT9Y8maHy569f1vOjTUMHOgLAx2pY+S4vZBj/m903qb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3bnLMXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDSHiwJLCIYvvzv2DOw1kewa0irBZ6HqHLZp2ORNUK8=;
	b=d3bnLMXrArWOKD3XyZWq3GMJOO6KZHS2VFgSwdkk2A+2VbovLz2hSVeYyyO5sldvdNJXCa
	800Ad8XAuIemhkWqWN84Z52Psqvbyx+EyAaJIwTsTa9UC6b7nvBktFNR1QMfVtyw6kk8EU
	lvdD7YiPG2pN6xF9EqzPjXHsKdHhLzU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-wJj-lrkePUyArtq4QckGgw-1; Wed, 03 Jul 2024 17:29:27 -0400
X-MC-Unique: wJj-lrkePUyArtq4QckGgw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4464454e329so1957801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042166; x=1720646966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDSHiwJLCIYvvzv2DOw1kewa0irBZ6HqHLZp2ORNUK8=;
        b=TlI1plDxnDkp7FA63C204MtrSybwAb6GFGllqOuwHs6TXTUbyBn6XMOuBXXuUVOkCC
         26Der5OUmlMV/LWQ5GbAU3vZ1UR5K+DmzTaSvfSM3ThFCn1/TMnIpIc1k4oyoP5QwB9h
         6IDNLzWXtl+4WaLoV5cE7N0gHFgVhzaJM5oCmOiYSn+gjoZUJX1TJ4SyL5jKuB9sn3FX
         kzoyUpCl8udlf6+08ssFruF9oQFj4Ix/1mj0M0BvgYDeqqpBr5yBP1oxOU5gwT8SwEmk
         Vq5mT9p2QrVWdk0W+9vVh78P/jC1yX1wgiSXlV+To3ndTZYeoskTOaavH3zH7NaCHmX9
         gShg==
X-Gm-Message-State: AOJu0Yw0J8r1HeB2v51EJKW8O+TbO4/acEOIvD8seyArhuV9ieTT0HL8
	Xxru/3KNScA2EcrDDCotqQuBiJL+/kG8/eTH11bBoAN8xZCDoBUF0bTUP41uLpd/Hbr4A4Tj8YN
	8QZDmnq+J2HS6saYYvwAQM2mTQvQdzN77dC7QkPXP8lXPpa1lxwLU0+pkHBCDXHjURZg4jb+lbw
	c7GteHOG4cKUEQ7hA+bospeygN9dd2d2ES2NrjyCUDO2g=
X-Received: by 2002:a05:622a:1a29:b0:446:5c96:3e39 with SMTP id d75a77b69052e-44662c7b9b6mr149928501cf.2.1720042165954;
        Wed, 03 Jul 2024 14:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMMhz5U/uaY0swHE/aSBQQusLb0Xfs1HUkfM825Vkmolo2nubsLeOfdQnkewhNugg6U8gw9g==
X-Received: by 2002:a05:622a:1a29:b0:446:5c96:3e39 with SMTP id d75a77b69052e-44662c7b9b6mr149928031cf.2.1720042165404;
        Wed, 03 Jul 2024 14:29:25 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: [PATCH v2 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Date: Wed,  3 Jul 2024 17:29:12 -0400
Message-ID: <20240703212918.2417843-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240703212918.2417843-1-peterx@redhat.com>
References: <20240703212918.2417843-1-peterx@redhat.com>
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
index 747943bc8cc2..2a3797fb6742 100644
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
index 73d791d1caad..53656227f70d 100644
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


