Return-Path: <linux-kernel+bounces-252978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDD931AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45861C2174E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442413A41A;
	Mon, 15 Jul 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3WxHRnB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0783137932
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071317; cv=none; b=TnjMBdqoyU7ka5sra5msicG+in0Ck+ogwcAn7Wr6S3c8MwbpYeH6TzkAcOizq+k8TgIhr1OEh/q4PL2aMOZywhlNOt03TfFfLrgkwXTN6jQq+QTwGt/jMWXyPj7zInRgyKTrUo8IlDwp5VPWg4+/Hgpqkw+7Ka4IzVk3WTMaWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071317; c=relaxed/simple;
	bh=j4dGntuy5ovfbg5GfpZwgNQjpitGGaZVaqagsHPmSn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Us1sYEECQBq07jajSJOYGEFCWIvFXtZiXkkxXRwQopfUq41NYiBIAu41ha7/TdBo5gS0zrHQYez7inpvLIaYK6H0BAca8zQrp803HURulyfXNEdnROZKg+B86pyV0u+Cy6HPOMC11VR0N24KUhxN0qbauje6o43sDnyy7wuS0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3WxHRnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDSHiwJLCIYvvzv2DOw1kewa0irBZ6HqHLZp2ORNUK8=;
	b=L3WxHRnB5gJDLe3EyqWZftF+5pm0P/wi9ynvFParG98cR0+YFDIUbPBdAII47pFzGcA0EM
	7RmzjRE+ZNoVea121kWhpxqodj65beVD0pXy+RYshcIzcmbAfWyt4JeokYRyeXv3vfj4dY
	ZSfPxZFmjyhQt4jU0+x7OLEJDja8I0Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-xYfgCB_kPjK9rtsdUlqdOA-1; Mon, 15 Jul 2024 15:21:51 -0400
X-MC-Unique: xYfgCB_kPjK9rtsdUlqdOA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5e4f6e95bso7236506d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071311; x=1721676111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDSHiwJLCIYvvzv2DOw1kewa0irBZ6HqHLZp2ORNUK8=;
        b=k0oKtrkzzojHtvtqn/Tnuc9EB4TZB3U4voeqxZVEnJu0zJuNEomb1Mzv0HQs1SgtT7
         ywi7e9m4yKN61QnWNFNf6rzhSOLo2vK1Y0OLte3bUHvsgFvyfATu+RSTNI17ILrBAGL8
         jxP+sZ1P5rslnHa6kN/pdsusobdZKxISaYQlnIFByTY/iLvy5Z6l+V1oWEmZNz/7A4F8
         l2bEj0nHzMkQSIZCP2YJ3iZQFuN9ls9urw+s4zQHvZ7r3tgaD0yWS3sXTmB7PamqSArU
         DoOOt5DA1tYniDNUjEXRLhDsVluwR/1OKEGXIrSzEU9Sg5TDtmXiqRYHnaFR2QKPzI34
         IvpA==
X-Forwarded-Encrypted: i=1; AJvYcCXQqYcXVaiKNXBiy4xan08gb+06aUFUbN7eGd0iXYbSiSCdUkGU+MTFi4wKFDp750/fB0cdxfCWFO8G6w2EPRfUK83inntkXQday3C9
X-Gm-Message-State: AOJu0Yw6xFJXY6aZkPLkG8b8jS59+rRnjgqI3x+tfb4sMqVbo33glwUP
	xBE6F8HwqexZafo1XjU98iQ9DPPRXuH2mKdIzPv+uivxKWmz6kBB2xDI+CImyYXPfETgxLBBZcQ
	l167EF2dUFEt05SgYi9MAcu/hKy5P2BZmt4qIvtjs5d0QwulDPaxmXLoTqTNS+Q==
X-Received: by 2002:a05:6214:2d44:b0:6b5:4bf:e0b2 with SMTP id 6a1803df08f44-6b77df230d0mr4738326d6.6.1721071310696;
        Mon, 15 Jul 2024 12:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXNZWcX+OGChgQMRYaFRNal2nxEfRlz+I/X26JLEslV+UpQEodY5JY9Fmq0XZviJ4grHRk9w==
X-Received: by 2002:a05:6214:2d44:b0:6b5:4bf:e0b2 with SMTP id 6a1803df08f44-6b77df230d0mr4738076d6.6.1721071310396;
        Mon, 15 Jul 2024 12:21:50 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Date: Mon, 15 Jul 2024 15:21:36 -0400
Message-ID: <20240715192142.3241557-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
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


