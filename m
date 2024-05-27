Return-Path: <linux-kernel+bounces-190700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850588D019D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFEEB297A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEB15ECEC;
	Mon, 27 May 2024 13:30:20 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8015EFAD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816620; cv=none; b=F6oZ8MNgIWBBho0XKKHf0s8sOmMaRb4kmYGuOMVBLEfarB8bJLbwVrEOo87u+KKVUx+X5i9Io0xrqQ/cgPxLmXJluh0SJk0wQfOWdFU042xfujL2xUVAU5A7pRCcERuHXsgrd264GKkjEyr+vhDspETTvsy+tsB3NaeV35cSHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816620; c=relaxed/simple;
	bh=J9J2V9eVNWcolO4HkttaKyavsOHGJwEhHxVyvbC/t/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6wHZd2qPHfCHzL736QanQh6cCNsuZrQsaQtxSpverRnPthGrYR21MY04ucJqjSj9X60rSZG5jTepf6zmjEWWZq2jQWM5w89gW8wyWUFolHeGxkeAoS+KVw96mJfZRtt9Xs0Sn2500Bpm7MIC952MfAFWTxLiHl+ZBhS8K1AS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxN1430kz9syd;
	Mon, 27 May 2024 15:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pj7Yxgttc3ll; Mon, 27 May 2024 15:30:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxN12xRmz9sqS;
	Mon, 27 May 2024 15:30:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 603768B773;
	Mon, 27 May 2024 15:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DVj7Btd2kdXr; Mon, 27 May 2024 15:30:09 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 709598B764;
	Mon, 27 May 2024 15:30:07 +0200 (CEST)
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
Subject: [RFC PATCH v4 00/16] Reimplement huge pages without hugepd on powerpc (8xx, e500, book3s/64)
Date: Mon, 27 May 2024 15:29:58 +0200
Message-ID: <cover.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816600; l=7097; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=J9J2V9eVNWcolO4HkttaKyavsOHGJwEhHxVyvbC/t/U=; b=l5tcmLFXyLhyJA1651pcJ8HDgdTLLgQZ5Ri35StgetQseLuCtSay7uca9/k26SbU/8/pM8+II nrgQ21YmA5LA0uB4MF/pDpA8UhSeWSUuKbva1aAJ/UX0oE3bAvdksol
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This is the continuation of the RFC v1 series "Reimplement huge pages
without hugepd on powerpc 8xx". It now get rid of hugepd completely
after handling also e500 and book3s/64

Also see https://github.com/linuxppc/issues/issues/483

Unlike most architectures, powerpc 8xx HW requires a two-level
pagetable topology for all page sizes. So a leaf PMD-contig approach
is not feasible as such.

Possible sizes on 8xx are 4k, 16k, 512k and 8M.

First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
must point to a single entry level-2 page table. Until now that was
done using hugepd. This series changes it to use standard page tables
where the entry is replicated 1024 times on each of the two pagetables
refered by the two associated PMD entries for that 8M page.

For e500 and book3s/64 there are less constraints because it is not
tied to the HW assisted tablewalk like on 8xx, so it is easier to use
leaf PMDs (and PUDs).

On e500 the supported page sizes are 4M, 16M, 64M, 256M and 1G. All at
PMD level on e500/32 (mpc85xx) and mix of PMD and PUD for e500/64. We
encode page size with 4 available bits in PTE entries. On e300/32 PGD
entries size is increases to 64 bits in order to allow leaf-PMD entries
because PTE are 64 bits on e500.

On book3s/64 only the hash-4k mode is concerned. It supports 16M pages
as cont-PMD and 16G pages as cont-PUD. In other modes (radix-4k, radix-6k
and hash-64k) the sizes match with PMD and PUD sizes so that's just leaf
entries. The hash processing make things a bit more complex. To ease
things, __hash_page_huge() is modified to bail out when DIRTY or ACCESSED
bits are missing, leaving it to mm core to fix it.

Global changes in v4:
- Fixed a few issues reported privately by robots
- Rebased on top of v6.10-rc1

Global changes in v3:
- Removed patches 1 and 2
- Squashed patch 11 into patch 5
- Replaced patches 12 and 13 with a series from Michael
- Reordered patches a bit to have more general patches up front

For more details on changes, see in each patch.

Christophe Leroy (15):
  mm: Define __pte_leaf_size() to also take a PMD entry
  mm: Provide mm_struct and address to huge_ptep_get()
  powerpc/mm: Remove _PAGE_PSIZE
  powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
  powerpc/mm: Allow hugepages without hugepd
  powerpc/8xx: Fix size given to set_huge_pte_at()
  powerpc/8xx: Rework support for 8M pages using contiguous PTE entries
  powerpc/8xx: Simplify struct mmu_psize_def
  powerpc/e500: Remove enc and ind fields from struct mmu_psize_def
  powerpc/e500: Switch to 64 bits PGD on 85xx (32 bits)
  powerpc/e500: Encode hugepage size in PTE bits
  powerpc/e500: Use contiguous PMD instead of hugepd
  powerpc/64s: Use contiguous PMD/PUD instead of HUGEPD
  powerpc/mm: Remove hugepd leftovers
  mm: Remove CONFIG_ARCH_HAS_HUGEPD

Michael Ellerman (1):
  powerpc/64e: Remove unused IBM HTW code [SQUASHED]

 arch/arm/include/asm/hugetlb-3level.h         |   4 +-
 arch/arm64/include/asm/hugetlb.h              |   2 +-
 arch/arm64/mm/hugetlbpage.c                   |   2 +-
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/book3s/32/pgalloc.h  |   2 -
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  15 -
 arch/powerpc/include/asm/book3s/64/hash.h     |  38 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |  38 --
 .../include/asm/book3s/64/pgtable-4k.h        |  47 --
 .../include/asm/book3s/64/pgtable-64k.h       |  20 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  22 +-
 arch/powerpc/include/asm/hugetlb.h            |  15 +-
 .../include/asm/nohash/32/hugetlb-8xx.h       |  38 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   9 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h  |   3 -
 arch/powerpc/include/asm/nohash/32/pte-44x.h  |   3 -
 arch/powerpc/include/asm/nohash/32/pte-85xx.h |   3 -
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  |  58 ++-
 .../powerpc/include/asm/nohash/hugetlb-e500.h |  36 +-
 arch/powerpc/include/asm/nohash/mmu-e500.h    |   6 +-
 arch/powerpc/include/asm/nohash/pgalloc.h     |   2 -
 arch/powerpc/include/asm/nohash/pgtable.h     |  41 +-
 arch/powerpc/include/asm/nohash/pte-e500.h    |  35 +-
 arch/powerpc/include/asm/page.h               |  32 --
 arch/powerpc/include/asm/pgtable-be-types.h   |  10 -
 arch/powerpc/include/asm/pgtable-types.h      |  13 +-
 arch/powerpc/include/asm/pgtable.h            |   3 +
 arch/powerpc/kernel/exceptions-64e.S          |   4 +-
 arch/powerpc/kernel/head_85xx.S               |  33 +-
 arch/powerpc/kernel/head_8xx.S                |  10 +-
 arch/powerpc/kernel/setup_64.c                |   6 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  11 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |  10 +
 arch/powerpc/mm/book3s64/pgtable.c            |  12 -
 arch/powerpc/mm/hugetlbpage.c                 | 455 +---------------
 arch/powerpc/mm/init-common.c                 |   8 +-
 arch/powerpc/mm/kasan/8xx.c                   |  21 +-
 arch/powerpc/mm/nohash/8xx.c                  |  43 +-
 arch/powerpc/mm/nohash/Makefile               |   2 +-
 arch/powerpc/mm/nohash/book3e_pgtable.c       |   4 +-
 arch/powerpc/mm/nohash/tlb.c                  | 407 +--------------
 arch/powerpc/mm/nohash/tlb_64e.c              | 314 ++++++++++++
 arch/powerpc/mm/nohash/tlb_low_64e.S          | 484 ++----------------
 arch/powerpc/mm/pgtable.c                     |  94 ++--
 arch/powerpc/mm/pgtable_32.c                  |   2 +-
 arch/riscv/include/asm/hugetlb.h              |   2 +-
 arch/riscv/mm/hugetlbpage.c                   |   2 +-
 arch/s390/include/asm/hugetlb.h               |   4 +-
 arch/s390/mm/hugetlbpage.c                    |   4 +-
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/proc/task_mmu.c                            |  10 +-
 fs/userfaultfd.c                              |   2 +-
 include/asm-generic/hugetlb.h                 |   2 +-
 include/linux/hugetlb.h                       |   6 -
 include/linux/pgtable.h                       |   3 +
 include/linux/swapops.h                       |   4 +-
 kernel/events/core.c                          |   2 +-
 mm/Kconfig                                    |  10 -
 mm/damon/vaddr.c                              |   6 +-
 mm/gup.c                                      | 183 +------
 mm/hmm.c                                      |   2 +-
 mm/hugetlb.c                                  |  44 +-
 mm/memory-failure.c                           |   2 +-
 mm/mempolicy.c                                |   2 +-
 mm/migrate.c                                  |   4 +-
 mm/mincore.c                                  |   2 +-
 mm/pagewalk.c                                 |  57 +--
 mm/userfaultfd.c                              |   2 +-
 68 files changed, 756 insertions(+), 2019 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
 create mode 100644 arch/powerpc/mm/nohash/tlb_64e.c

-- 
2.44.0


