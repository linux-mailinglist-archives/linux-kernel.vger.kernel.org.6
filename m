Return-Path: <linux-kernel+bounces-182561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309458C8CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536471C211A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E413FD9D;
	Fri, 17 May 2024 19:20:07 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD413FD91
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973606; cv=none; b=QVcUdS+dZQO41SGV3uYUu8fLJCSd6I8mj82Gh2ZR1GuXyNRBmyWC00ZjB0bewPj+D1lguOZ/TbDqNfdAo35iPoblU5ytMNyCbBZW1wOjTQGidZTnJBHQtICPZh+70cfxRjc9pgw7uB4GuUNh6wFlPJBMmTFiXeUfJtFdAruz7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973606; c=relaxed/simple;
	bh=nXgiWCnTh81NG+HIgJTsNmlUbBq2v6oarBwpgv/bUOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHPraOl9WLFQluSI6kffIrZAnZ+NdwjjEUm1PTQFSWIFjzjdGXnDng9PQSmcgQlfzHPuZHjaDC0aCCaDfBq/m6K9k+7rX9VBHFx3AuzIT8txYLVCO/3f6Rw4JXMKRB5J6Kfmmy7fjjL2Le+5RfQLt9IaNV+u84sNa73ZL2HZ56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9H3Jflz9st4;
	Fri, 17 May 2024 21:00:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8Eu0JPkjFau; Fri, 17 May 2024 21:00:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9H2DPjz9st0;
	Fri, 17 May 2024 21:00:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 42E4B8B783;
	Fri, 17 May 2024 21:00:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kTwwTQayvkPH; Fri, 17 May 2024 21:00:03 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A6FB58B766;
	Fri, 17 May 2024 21:00:02 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on powerpc (8xx, e500, book3s/64)
Date: Fri, 17 May 2024 20:59:54 +0200
Message-ID: <cover.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972395; l=6993; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=nXgiWCnTh81NG+HIgJTsNmlUbBq2v6oarBwpgv/bUOk=; b=JJc9xjsdS8vG4cTo/Ay4rt3hpTzOoF+49PWU37xMh+OtrrREx7xjwaJB5Mb+tWOmexAHZkx0S g8PFoT08NPSBoJdlf5dx+XAf+WUko8IAO1YC5ivO0qgat4VyLrQHX6W
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This is the continuation of the RFC v1 series "Reimplement huge pages
without hugepd on powerpc 8xx". It now get rid of hugepd completely
after handling also e500 and book3s/64

Unlike most architectures, powerpc 8xx HW requires a two-level
pagetable topology for all page sizes. So a leaf PMD-contig approach
is not feasible as such.

Possible sizes are 4k, 16k, 512k and 8M.

First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
must point to a single entry level-2 page table. Until now that was
done using hugepd. This series changes it to use standard page tables
where the entry is replicated 1024 times on each of the two pagetables
refered by the two associated PMD entries for that 8M page.

At the moment it has to look into each helper to know if the
hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
a lower size. I hope this can me handled by core-mm in the future.

For e500 and book3s/64 there are less constraints because it is not
tied to the HW assisted tablewalk like on 8xx, so it is easier to use
leaf PMDs (and PUDs).

On e500 the supported page sizes are 4M, 16M, 64M, 256M and 1G. All at
PMD level on e500/32 and mix of PMD and PUD for e500/64. We encode page
size with 4 available bits in PTE entries. On e300/32 PGD entries size
is increases to 64 bits in order to allow leaf-PMD entries because PTE
are 64 bits on e500.

On book3s/64 only the hash-4k mode is concerned. It supports 16M pages
as cont-PMD and 16G pages as cont-PUD. In other modes (radix-4k, radix-6k
and hash-64k) the sizes match with PMD and PUD sizes so that's just leaf
entries.

Christophe Leroy (20):
  mm: Provide pagesize to pmd_populate()
  mm: Provide page size to pte_alloc_huge()
  mm: Provide pmd to pte_leaf_size()
  mm: Provide mm_struct and address to huge_ptep_get()
  powerpc/mm: Allow hugepages without hugepd
  powerpc/8xx: Fix size given to set_huge_pte_at()
  powerpc/8xx: Rework support for 8M pages using contiguous PTE entries
  powerpc/8xx: Simplify struct mmu_psize_def
  powerpc/mm: Remove _PAGE_PSIZE
  powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
  powerpc/mm: Complement huge_pte_alloc() for all non HUGEPD setups
  powerpc/64e: Remove unneeded #ifdef CONFIG_PPC_E500
  powerpc/64e: Clean up impossible setups
  powerpc/e500: Remove enc field from struct mmu_psize_def
  powerpc/85xx: Switch to 64 bits PGD
  powerpc/e500: Encode hugepage size in PTE bits
  powerpc/e500: Use contiguous PMD instead of hugepd
  powerpc/64s: Use contiguous PMD/PUD instead of HUGEPD
  powerpc/mm: Remove hugepd leftovers
  mm: Remove CONFIG_ARCH_HAS_HUGEPD

 arch/arm/include/asm/hugetlb-3level.h         |   2 +-
 arch/arm64/include/asm/hugetlb.h              |   2 +-
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/mm/hugetlbpage.c                   |   4 +-
 arch/parisc/mm/hugetlbpage.c                  |   2 +-
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/book3s/32/pgalloc.h  |   2 -
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  15 -
 arch/powerpc/include/asm/book3s/64/hash.h     |  38 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |  38 --
 .../include/asm/book3s/64/pgtable-4k.h        |  34 --
 .../include/asm/book3s/64/pgtable-64k.h       |  20 -
 arch/powerpc/include/asm/hugetlb.h            |  26 +-
 .../include/asm/nohash/32/hugetlb-8xx.h       |  58 +--
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   9 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h  |   2 +
 arch/powerpc/include/asm/nohash/32/pte-40x.h  |   3 -
 arch/powerpc/include/asm/nohash/32/pte-44x.h  |   3 -
 arch/powerpc/include/asm/nohash/32/pte-85xx.h |   3 -
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  |  64 ++-
 .../powerpc/include/asm/nohash/hugetlb-e500.h |  36 +-
 arch/powerpc/include/asm/nohash/mmu-e500.h    |   4 -
 arch/powerpc/include/asm/nohash/pgalloc.h     |   2 -
 arch/powerpc/include/asm/nohash/pgtable.h     |  45 +-
 arch/powerpc/include/asm/nohash/pte-e500.h    |  22 +-
 arch/powerpc/include/asm/page.h               |  32 --
 arch/powerpc/include/asm/pgtable-be-types.h   |  10 -
 arch/powerpc/include/asm/pgtable-types.h      |  13 +-
 arch/powerpc/include/asm/pgtable.h            |   3 +
 arch/powerpc/kernel/head_85xx.S               |  33 +-
 arch/powerpc/kernel/head_8xx.S                |  10 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  11 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  12 -
 arch/powerpc/mm/hugetlbpage.c                 | 450 ++----------------
 arch/powerpc/mm/init-common.c                 |   8 +-
 arch/powerpc/mm/kasan/8xx.c                   |  15 +-
 arch/powerpc/mm/nohash/8xx.c                  |  46 +-
 arch/powerpc/mm/nohash/book3e_pgtable.c       |   4 +-
 arch/powerpc/mm/nohash/tlb.c                  | 172 ++-----
 arch/powerpc/mm/nohash/tlb_low_64e.S          | 257 ++--------
 arch/powerpc/mm/pgtable.c                     |  94 ++--
 arch/powerpc/mm/pgtable_32.c                  |   2 +-
 arch/riscv/include/asm/hugetlb.h              |   2 +-
 arch/riscv/include/asm/pgtable.h              |   2 +-
 arch/riscv/mm/hugetlbpage.c                   |   4 +-
 arch/s390/include/asm/hugetlb.h               |   2 +-
 arch/s390/mm/hugetlbpage.c                    |   2 +-
 arch/sh/mm/hugetlbpage.c                      |   2 +-
 arch/sparc/include/asm/pgtable_64.h           |   2 +-
 arch/sparc/mm/hugetlbpage.c                   |   4 +-
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/proc/task_mmu.c                            |   8 +-
 fs/userfaultfd.c                              |   2 +-
 include/asm-generic/hugetlb.h                 |   2 +-
 include/linux/hugetlb.h                       |  10 +-
 include/linux/mm.h                            |  12 +-
 include/linux/pgtable.h                       |   2 +-
 include/linux/swapops.h                       |   2 +-
 kernel/events/core.c                          |   2 +-
 mm/Kconfig                                    |  10 -
 mm/damon/vaddr.c                              |   6 +-
 mm/filemap.c                                  |   2 +-
 mm/gup.c                                      | 105 +---
 mm/hmm.c                                      |   2 +-
 mm/hugetlb.c                                  |  46 +-
 mm/internal.h                                 |   2 +-
 mm/memory-failure.c                           |   2 +-
 mm/memory.c                                   |  19 +-
 mm/mempolicy.c                                |   2 +-
 mm/migrate.c                                  |   4 +-
 mm/mincore.c                                  |   2 +-
 mm/pagewalk.c                                 |  57 +--
 mm/pgalloc-track.h                            |   2 +-
 mm/userfaultfd.c                              |   6 +-
 74 files changed, 494 insertions(+), 1444 deletions(-)

-- 
2.44.0


