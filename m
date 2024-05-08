Return-Path: <linux-kernel+bounces-173142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C68BFC18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7840FB21093
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796882486;
	Wed,  8 May 2024 11:32:19 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD07D405
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167937; cv=none; b=gXD+DVOsp3CSViEKh8B1ar4JwT1aGScIdaiDePUM4rFkQNbTTci5mn1Eu7JxCNModg4Li8GRHaRKQdj1wWxnEfRmQgiSiT6HTCf7QzN08QNqqy2E+fGZ8yRX1GV3wK8zIOKINOjv1yonjuoMPgbJ6UAjbBpVTKH9p04uWmIy8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167937; c=relaxed/simple;
	bh=uXuMhgYYDfXUYOwKc03XflYqtAOJ4im0vV2wFj9gQ7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sM0eoyV6TKY7sD9lkQgThVhKuvi8kYcf83vS4/n8Z/0cTThoOq9bNeuJhZMDd4Qui+Op73pY4LGCSXeYMPaEFipb7Qnhe9ugA7F9AqReuH9qFZe3/+5iiDsY8EKVHptVwZUT90kDmHg4S9rER+ymgucLDUfUeEPlBQ0IRLxFXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB8920009;
	Wed,  8 May 2024 11:32:05 +0000 (UTC)
Message-ID: <a45ae760-8d83-494c-8688-ccf8cdd3c7c1@ghiti.fr>
Date: Wed, 8 May 2024 13:32:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-mm@kvack.org
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240508111829.16891-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

I should not have unplugged this outlet...Sorry, ignore this series, I'm 
sending a RESEND right away.

On 08/05/2024 13:18, Alexandre Ghiti wrote:
> This patchset intends to merge the contiguous ptes hugetlbfs implementation
> of arm64 and riscv.
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
> Changes in v2:
>    - Rebase on top of 6.9-rc3
>
> Alexandre Ghiti (9):
>    riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>    riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>    mm: Use common huge_ptep_get() function for riscv/arm64
>    mm: Use common set_huge_pte_at() function for riscv/arm64
>    mm: Use common huge_pte_clear() function for riscv/arm64
>    mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>    mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>    mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>    mm: Use common huge_ptep_clear_flush() function for riscv/arm64
>
>   arch/arm64/Kconfig                  |   1 +
>   arch/arm64/include/asm/pgtable.h    |  56 +++++-
>   arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>   arch/riscv/Kconfig                  |   1 +
>   arch/riscv/include/asm/hugetlb.h    |   2 +-
>   arch/riscv/include/asm/pgtable-64.h |  11 ++
>   arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>   arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>   arch/riscv/mm/pgtable.c             |   6 +-
>   mm/Kconfig                          |   3 +
>   mm/Makefile                         |   1 +
>   mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>   12 files changed, 480 insertions(+), 544 deletions(-)
>   create mode 100644 mm/contpte.c
>

