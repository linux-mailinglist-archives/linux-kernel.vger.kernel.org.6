Return-Path: <linux-kernel+bounces-240491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEA926E53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A70D1C21CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608B1CABF;
	Thu,  4 Jul 2024 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CSJ5Fy12";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1ou7Q+e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CSJ5Fy12";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1ou7Q+e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3D1DA32D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067513; cv=none; b=t0lVEV52f71jahGl1106ZDJTRntLx9rDOwAIteu1NN9igZlK9fsj9MJ1G0YlDrAzQiJ6uN0dORSmsiRvNdZfKA+sKSa6qTiFjOmoP6/uSL66bl0yVVwsi0ClJZPS+ecZ4WTnp/C8JsIt1H76f6SvIEe/gwBWCkE2U92Q0tUUIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067513; c=relaxed/simple;
	bh=tcd2KolKqaHUzz9Q9Dfptvv/8LhUgZC3ItrJI/PCmoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMaiZRBzHZ73g625T8OVPWx+95vPf+RuuUbxytYrcWRWNGu2Hmwd5Kw8nzTWsqOa7j7XLNPbBSQSEbTczyrunCJaobftwNIE9hVJZ6gxCNvSXjRSpfopXfYdPR/b48cTM9dFfxEpYWyJcOxOKc9aqUob1Xl33KvF4B7UytJId80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CSJ5Fy12; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S1ou7Q+e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CSJ5Fy12; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S1ou7Q+e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64F881FCF8;
	Thu,  4 Jul 2024 04:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjq/LdX8GfGKHPJUSWIjWZoCQH5MDyUKxUAhI9Il2Vs=;
	b=CSJ5Fy129t7GTIAnVb/zkJULdKGWTD2VGj2snFSMVu5AAcfFC5HbSxcLQ9PY32t2hIVEWt
	i/BEmJYIRY0m1t3zXxXbwqZtAtNhf8sWlD2QzjC9YwAKHyhEGNGKJZRZiBL76qyYEV9rDb
	IGTzREEq9NLXdTHio2Z9u0ygr0jQr/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjq/LdX8GfGKHPJUSWIjWZoCQH5MDyUKxUAhI9Il2Vs=;
	b=S1ou7Q+eCw7aHphdLfENGgWuIiJEXjKWkUYeQFjWklRoGxLGffu1GhhP7dDMifV7RZngQx
	CMCoziXylTqF5uDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjq/LdX8GfGKHPJUSWIjWZoCQH5MDyUKxUAhI9Il2Vs=;
	b=CSJ5Fy129t7GTIAnVb/zkJULdKGWTD2VGj2snFSMVu5AAcfFC5HbSxcLQ9PY32t2hIVEWt
	i/BEmJYIRY0m1t3zXxXbwqZtAtNhf8sWlD2QzjC9YwAKHyhEGNGKJZRZiBL76qyYEV9rDb
	IGTzREEq9NLXdTHio2Z9u0ygr0jQr/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjq/LdX8GfGKHPJUSWIjWZoCQH5MDyUKxUAhI9Il2Vs=;
	b=S1ou7Q+eCw7aHphdLfENGgWuIiJEXjKWkUYeQFjWklRoGxLGffu1GhhP7dDMifV7RZngQx
	CMCoziXylTqF5uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350F013889;
	Thu,  4 Jul 2024 04:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7iFB7QlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:48 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 00/45] hugetlb pagewalk unification
Date: Thu,  4 Jul 2024 06:30:47 +0200
Message-ID: <20240704043132.28501-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi all,

During Peter's talk at the LSFMM, it was agreed that one of the things
that need to be done in order to further integrate hugetlb into mm core,
is to unify generic and hugetlb pagewalkers.
I started with this one, which is unifying hugetlb into generic
pagewalk, instead of having its hugetlb_entry entries.
Which means that pmd_entry/pte_entry(for cont-pte) entries will also deal with
hugetlb vmas as well, and so will new pud_entry entries since hugetlb can be
pud mapped (devm pages as well but we seem not to care about those with
the exception of hmm code).

The outcome is this RFC.

Before you continue, let me clarify certain points:

This patchset is not yet finished, as there are things that 1) need more thought,
2) are still broken (like the hmm bits as I am clueless about that) 3)
some paths have not been tested at all.

The things I tested were:

 - memory-failure
 - smaps/numa_maps/pagemap (the latter only for pud/pmd, not
   cont-{pmd,ptes}
 - mempolicy

on arm64 (for 64KB and 32M hugetlb pages) and on x86_64 (for 2MB and 1GB
hugetlb pages).
More tests need to be conducted, and I plan to borrow a pp64le machine
to also carry out some tests there, but for now this is what my bandwith
allowed me to do.

I am well aware that there are two things that might scare people, one
being the number of patches, and the other being the amount of code
added.

For the former, I will by no means ask anyone to review 45 patches, but
since this patchset touches isolated paths (damon, mincore, hmm,
task_mmu, memory-failure, mempolicy), I will point out some people
that might be able to help me out with those different bits:

 - Miaohe for memory-failure bits
 - David for task_mmu bits
 - SeongJae Park for damon bits
 - Jerome for hmm bits
 - feel freel to join for the rest

I think that that might be a good approach, and instead of having
to review 45 patches, one has only to review at most 5 or 6.

For the latter, there is an explanation: hugetlb operates on ptes
(although it allocates puds/pmds and the operations work on that level too),
which means that now that we will handle PUD/PMD-mapped hugetlb with
{pud,pmd}_* operations, we need to introduce quite a few functions that
do not exist yet and we need from now onwards.

Although I am sending this out, this is not a "rfc ready material",
as I said there are still things that need to be improved/fixed/tested,
but I wanted to make it public nevertheless so we can gather some constructive
feedback that helps us moving in the right direction and to also widen the discussions.

So take this more of a "Hey, let me show what I am doing and call me out on
things you consider wrong".

Thanks in advance

Oscar Salvador (45):
  arch/x86: Drop own definition of pgd,p4d_leaf
  mm: Add {pmd,pud}_huge_lock helper
  mm/pagewalk: Move vma_pgtable_walk_begin and vma_pgtable_walk_end
    upfront
  mm/pagewalk: Only call pud_entry when we have a pud leaf
  mm/pagewalk: Enable walk_pmd_range to handle cont-pmds
  mm/pagewalk: Do not try to split non-thp pud or pmd leafs
  arch/s390: Enable __s390_enable_skey_pmd to handle hugetlb vmas
  fs/proc: Enable smaps_pmd_entry to handle PMD-mapped hugetlb vmas
  mm: Implement pud-version functions for swap and vm_normal_page_pud
  fs/proc: Create smaps_pud_range to handle PUD-mapped hugetlb vmas
  fs/proc: Enable smaps_pte_entry to handle cont-pte mapped hugetlb vmas
  fs/proc: Enable pagemap_pmd_range to handle hugetlb vmas
  mm: Implement pud-version uffd functions
  fs/proc: Create pagemap_pud_range to handle PUD-mapped hugetlb vmas
  fs/proc: Adjust pte_to_pagemap_entry for hugetlb vmas
  fs/proc: Enable pagemap_scan_pmd_entry to handle hugetlb vmas
  mm: Implement pud-version for pud_mkinvalid and pudp_establish
  fs/proc: Create pagemap_scan_pud_entry to handle PUD-mapped hugetlb
    vmas
  fs/proc: Enable gather_pte_stats to handle hugetlb vmas
  fs/proc: Enable gather_pte_stats to handle cont-pte mapped hugetlb
    vmas
  fs/proc: Create gather_pud_stats to handle PUD-mapped hugetlb pages
  mm/mempolicy: Enable queue_folios_pmd to handle hugetlb vmas
  mm/mempolicy: Create queue_folios_pud to handle PUD-mapped hugetlb
    vmas
  mm/memory_failure: Enable check_hwpoisoned_pmd_entry to handle hugetlb
    vmas
  mm/memory-failure: Create check_hwpoisoned_pud_entry to handle
    PUD-mapped hugetlb vmas
  mm/damon: Enable damon_young_pmd_entry to handle hugetlb vmas
  mm/damon: Create damon_young_pud_entry to handle PUD-mapped hugetlb
    vmas
  mm/damon: Enable damon_mkold_pmd_entry to handle hugetlb vmas
  mm/damon: Create damon_mkold_pud_entry to handle PUD-mapped hugetlb
    vmas
  mm,mincore: Enable mincore_pte_range to handle hugetlb vmas
  mm/mincore: Create mincore_pud_range to handle PUD-mapped hugetlb vmas
  mm/hmm: Enable hmm_vma_walk_pmd, to handle hugetlb vmas
  mm/hmm: Enable hmm_vma_walk_pud to handle PUD-mapped hugetlb vmas
  arch/powerpc: Skip hugetlb vmas in subpage_mark_vma_nohuge
  arch/s390: Skip hugetlb vmas in thp_split_mm
  fs/proc: Make clear_refs_test_walk skip hugetlb vmas
  mm/lock: Make mlock_test_walk skip hugetlb vmas
  mm/madvise: Make swapin_test_walk skip hugetlb vmas
  mm/madvise: Make madvise_cold_test_walk skip hugetlb vmas
  mm/madvise: Make madvise_free_test_walk skip hugetlb vmas
  mm/migrate_device: Make migrate_vma_test_walk skip hugetlb vmas
  mm/memcontrol: Make mem_cgroup_move_test_walk skip hugetlb vmas
  mm/memcontrol: Make mem_cgroup_count_test_walk skip hugetlb vmas
  mm/hugetlb_vmemmap: Make vmemmap_test_walk skip hugetlb vmas
  mm: Delete all hugetlb_entry entries

 arch/arm64/include/asm/pgtable.h             |  19 +
 arch/loongarch/include/asm/pgtable.h         |   8 +
 arch/mips/include/asm/pgtable.h              |   7 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |   8 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  15 +-
 arch/powerpc/mm/book3s64/subpage_prot.c      |   2 +
 arch/riscv/include/asm/pgtable.h             |  15 +
 arch/s390/mm/gmap.c                          |  37 +-
 arch/x86/include/asm/pgtable.h               | 199 +++++----
 fs/proc/task_mmu.c                           | 434 ++++++++++++-------
 include/asm-generic/pgtable_uffd.h           |  30 ++
 include/linux/mm.h                           |   4 +
 include/linux/mm_inline.h                    |  34 ++
 include/linux/pagewalk.h                     |  10 -
 include/linux/pgtable.h                      |  77 +++-
 include/linux/swapops.h                      |  27 ++
 mm/damon/ops-common.c                        |  21 +-
 mm/damon/vaddr.c                             | 173 ++++----
 mm/hmm.c                                     |  69 +--
 mm/hugetlb_vmemmap.c                         |  12 +
 mm/madvise.c                                 |  36 ++
 mm/memcontrol-v1.c                           |  24 +
 mm/memory-failure.c                          |  99 +++--
 mm/memory.c                                  |  51 +++
 mm/mempolicy.c                               | 121 +++---
 mm/migrate_device.c                          |  12 +
 mm/mincore.c                                 |  46 +-
 mm/mlock.c                                   |  12 +
 mm/mprotect.c                                |  10 -
 mm/pagewalk.c                                |  73 +---
 mm/pgtable-generic.c                         |  21 +
 31 files changed, 1089 insertions(+), 617 deletions(-)

-- 
2.26.2


