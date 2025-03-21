Return-Path: <linux-kernel+bounces-571760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A67A6C1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DC3BAA77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3D22E403;
	Fri, 21 Mar 2025 17:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86C22E3F0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579405; cv=none; b=PMu87iOdKoiJFYJ4bgQ5wpAanuGQ4nBtWoK/isPG9l8T9GTdJi+X7Y9JWgzUep028Ep8HwwA3Thuvi1TVRuaZRRlm3LCVflmwmLK/npz2+uppxovnC83ASFSNOI5gvVZqCGCIUFEzYUZcJIxLIwycFXTlCtJ9wcMQfkLGj4Gqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579405; c=relaxed/simple;
	bh=fSFS2ycDYeeCiLvOt5f5Q7tuudwqXUGq51vYZZ8GWz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E1eQL5raNqojc+q541rg/PihjCpaS44ZzsxrzSB/M9wKNKtSTqoPBbQOCyP/rL0Qw59z/xrHgJc6vaZvOWZZBwQQZd3EJFQZ94Jy5yyg6IgiOKcjgwmMAwQFz+kWvPw+UCBg2noiCwI9IT4BnRE9uTPHHZXkkH/2VezyU7KDBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZK8Sl5g91z9sSc;
	Fri, 21 Mar 2025 18:24:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGiE3Fieq8zB; Fri, 21 Mar 2025 18:24:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZK8Sl3Q1Zz9sSZ;
	Fri, 21 Mar 2025 18:24:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 13D588B79C;
	Fri, 21 Mar 2025 18:24:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PgNENOWgR9TQ; Fri, 21 Mar 2025 18:24:22 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E6918B763;
	Fri, 21 Mar 2025 18:24:22 +0100 (CET)
Message-ID: <1b0d0513-9d18-4603-91e9-20af36334145@csgroup.eu>
Date: Fri, 21 Mar 2025 18:24:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Merge arm64/riscv hugetlbfs contpte support
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-mm@kvack.org
References: <20250321130635.227011-1-alexghiti@rivosinc.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250321130635.227011-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/03/2025 à 14:06, Alexandre Ghiti a écrit :
> This patchset intends to merge the contiguous ptes hugetlbfs implementation
> of arm64 and riscv.

Can we also add powerpc in the dance ?

powerpc also use contiguous PTEs allthough there is not (yet) a special 
name for it:
- b250c8c08c79 powerpc/8xx: Manage 512k huge pages as standard pages
- e47168f3d1b1 powerpc/8xx: Support 16k hugepages with 4k pages

powerpc also use configuous PMDs/PUDs for larger hugepages:
- 57fb15c32f4f ("powerpc/64s: use contiguous PMD/PUD instead of HUGEPD")
- 7c44202e3609 ("powerpc/e500: use contiguous PMD instead of hugepd")
- 0549e7666373 ("powerpc/8xx: rework support for 8M pages using 
contiguous PTE entries")

Christophe

> 
> Both arm64 and riscv support the use of contiguous ptes to map pages that
> are larger than the default page table size, respectively called contpte
> and svnapot.
> 
> The riscv implementation differs from the arm64's in that the LSBs of the
> pfn of a svnapot pte are used to store the size of the mapping, allowing
> for future sizes to be added (for now only 64KB is supported). That's an
> issue for the core mm code which expects to find the *real* pfn a pte points
> to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
> and restores the size of the mapping when it is written to a page table.
> 
> The following patches are just merges of the 2 different implementations
> that currently exist in arm64 and riscv which are very similar. It paves
> the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
> reimplementing the same in riscv.
> 
> This patchset was tested by running the libhugetlbfs testsuite with 64KB
> and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
> 
> v4: https://lore.kernel.org/linux-riscv/20250127093530.19548-1-alexghiti@rivosinc.com/
> v3: https://lore.kernel.org/all/20240802151430.99114-1-alexghiti@rivosinc.com/
> v2: https://lore.kernel.org/linux-riscv/20240508113419.18620-1-alexghiti@rivosinc.com/
> v1: https://lore.kernel.org/linux-riscv/20240301091455.246686-1-alexghiti@rivosinc.com/
> 
> Changes in v5:
>    - Fix "int i" unused variable in patch 2 (as reported by PW)
>    - Fix !svnapot build
>    - Fix arch_make_huge_pte() which returned a real napot pte
>    - Make __ptep_get(), ptep_get_and_clear() and __set_ptes() napot aware to
>      avoid leaking real napot pfns to core mm
>    - Fix arch_contpte_get_num_contig() that used to always try to get the
>      mapping size from the ptep, which does not work if the ptep comes the core mm
>    - Rebase on top of 6.14-rc7 + fix for
>      huge_ptep_get_and_clear()/huge_pte_clear()
>      https://lore.kernel.org/linux-riscv/20250317072551.572169-1-alexghiti@rivosinc.com/
> 
> Changes in v4:
>    - Rebase on top of 6.13
> 
> Changes in v3:
>    - Split set_ptes and ptep_get into internal and external API (Ryan)
>    - Rename ARCH_HAS_CONTPTE into ARCH_WANT_GENERAL_HUGETLB_CONTPTE so that
>      we split hugetlb functions from contpte functions (actually riscv contpte
>      functions to support THP will come into another series) (Ryan)
>    - Rebase on top of 6.11-rc1
> 
> Changes in v2:
>    - Rebase on top of 6.9-rc3
> 
> Alexandre Ghiti (9):
>    riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>    riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>    mm: Use common huge_ptep_get() function for riscv/arm64
>    mm: Use common set_huge_pte_at() function for riscv/arm64
>    mm: Use common huge_pte_clear() function for riscv/arm64
>    mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>    mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>    mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>    mm: Use common huge_ptep_clear_flush() function for riscv/arm64
> 
>   arch/arm64/Kconfig                  |   1 +
>   arch/arm64/include/asm/hugetlb.h    |  22 +--
>   arch/arm64/include/asm/pgtable.h    |  68 ++++++-
>   arch/arm64/mm/hugetlbpage.c         | 294 +---------------------------
>   arch/riscv/Kconfig                  |   1 +
>   arch/riscv/include/asm/hugetlb.h    |  36 +---
>   arch/riscv/include/asm/pgtable-64.h |  11 ++
>   arch/riscv/include/asm/pgtable.h    | 222 ++++++++++++++++++---
>   arch/riscv/mm/hugetlbpage.c         | 243 +----------------------
>   arch/riscv/mm/pgtable.c             |   6 +-
>   include/linux/hugetlb_contpte.h     |  39 ++++
>   mm/Kconfig                          |   3 +
>   mm/Makefile                         |   1 +
>   mm/hugetlb_contpte.c                | 258 ++++++++++++++++++++++++
>   14 files changed, 583 insertions(+), 622 deletions(-)
>   create mode 100644 include/linux/hugetlb_contpte.h
>   create mode 100644 mm/hugetlb_contpte.c
> 


