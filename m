Return-Path: <linux-kernel+bounces-270859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26770944655
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FBF1F2333F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5001662E2;
	Thu,  1 Aug 2024 08:18:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047C1581E5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500321; cv=none; b=LVteL2PU2hgetbLBgFUKZhaeTEiRKFNdXRnll/zVaL0sZIUlqAiN8tKVo27ccoIKH+Z8NbY/y22f1oBvwRDXxfIXROqQVf4ywsTgQzxZeVoJKdsyuIgbS548yBGeX+LNWkd5GKvTtqXzMdPcdFdMPZniEI0XXD0FLoKbgQf+GMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500321; c=relaxed/simple;
	bh=UBT4cDOVT76H5cor202kszOsyGIcKm6+7uRUYVqUypg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHnynL+PhEgtdCf6wW2yPMh71XFzTN2CEwaBTrey9BYCsXBIeItfwCX3qtYCt9pAw68WTG511BaZu6JEkDWGlegHOuw+JjezNPgaYFOnnQfxULLBTBwC1EGbEPOczY+qUn26PT0625fDwEQftO2Tr8nXi2EZQifA/8kxp1i79uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A1051007;
	Thu,  1 Aug 2024 01:19:00 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D855F3F766;
	Thu,  1 Aug 2024 01:18:25 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	osalvador@suse.de,
	baolin.wang@linux.alibaba.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	ioworker0@gmail.com,
	gshan@redhat.com,
	mark.rutland@arm.com,
	kirill.shutemov@linux.intel.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: Race condition observed between page migration and page fault handling on arm64 machines
Date: Thu,  1 Aug 2024 13:46:57 +0530
Message-Id: <20240801081657.1386743-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I and Ryan had a discussion and we thought it would be best to get feedback
from the community.

The migration mm selftest currently fails on arm64 for shared anon mappings,
due to the following race:

Migration:						Page fault:
try_to_migrate_one():					handle_pte_fault():
1. Nuke the PTE						PTE has been deleted => do_pte_missing()
2. Mark the PTE for migration				PTE has not been deleted but is just not "present" => do_swap_page()

In the test, the parent thread migrates a single page between nodes, and the
children threads read on that page.

The race happens when the PTE has been nuked, and before it gets marked for
migration, the reader faults and checks if the PTE is missing, and calls
do_pte_missing() instead of the correct do_swap_page(); the latter implies that
the reader ends up calling migration_entry_wait() to wait for PTEs to get
corrected. The former path ends up following this: do_fault() -> do_read_fault()
-> __do_fault() -> vma->vm_ops->fault, which is shmem_fault() -> shmem_get_folio_gfp()
-> filemap_get_entry(), which then calls folio_try_get() and takes a reference
on the folio which is under migration. Returning back, the reader blocks on
folio_lock() since the migration path has the lock, and migration ends up
failing in folio_migrate_mapping(), which expects a reference count of 2 on the
folio.

The following hack makes the race vanish:

mm/rmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..bb10b3376595 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2126,7 +2126,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 * transition on a cached TLB entry is written through
 				 * and traps if the PTE is unmapped.
 				 */
-				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+				pteval = pte_mkinvalid(*(pvmw.pte));
+				*(pvmw.pte) = pteval;
 
 				set_tlb_ubc_flush_pending(mm, pteval, address);
 			} else {


It's a hack because the invalidation is non-atomic, and pte_mkinvalid() is
defined only on arm64. I could think of the following solutions:

1. Introduce (atomic)_pte_mkinvalid() for all arches and call the arch-API if
defined, else call ptep_get_and_clear(). The theoretical race would still exist
for other arches.

2. Prepare the migration swap entry and do an atomic exchange to fill the PTE
(this currently seems the best option to me, but I have not tried it out).

3. In try_to_migrate_one(), before the nuking, freeze the refcount of the folio.
This would solve the race, but then we will have to defer all the reference
releases till later, and I don't know whether that's correct or feasible.

4. Since the extra refcount being taken in filemap_get_entry() is due to loading
the folio from the pagecache, delete/invalidate the folio in the pagecache
until migration is complete. I tried with some helpers present in mm/filemap.c
to do that but I guess I am not aware of the subtleties, and I end up triggering
a BUG() somewhere.

5. In do_fault(), under the if block, we are already checking whether this is
just a temporary clearing of the PTE. We can take that out of the if block, but
then that would be a performance bottleneck since we are taking the PTL?

Thanks,
Dev

