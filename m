Return-Path: <linux-kernel+bounces-437310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6E9E919F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37661188746D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A421882F;
	Mon,  9 Dec 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKdP0j6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED74227597
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742195; cv=none; b=ultOaurveX1oV9PNThiHR+FZ/Y3TfTjno/lh6igvhRBnJUMm8qkPtzHQj2C4bNCeZmMBnNIl7xGgPmDG704PSrgwAa2xnAAXDWlRww5ZVisz4X1B37V7WtCC8kMcMwjmTdtXuRwOeesdllRFdet1NPhdOfDuRJzdQmdtkjr1sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742195; c=relaxed/simple;
	bh=XFmFr+o2eH6D25FVmx+Ch5yrIyoGiMItdUCeEQo2zBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSTR/urnDyGaD75YJ4Z9aMmhC9/fxODAAO+HgN9OAWBmViUOXiMw9h9Xe4Wru+fWe6hnOcmUxTcrOsxoYl4fDVqgQ5uKe2szIFPHVTE7/s6lcmjMAkMlTkPS/kwNejL17nIZdq9BCft6fGjqtOHPbZPV4wC+j54mXWSaclnig3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKdP0j6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA0C4CED1;
	Mon,  9 Dec 2024 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742194;
	bh=XFmFr+o2eH6D25FVmx+Ch5yrIyoGiMItdUCeEQo2zBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RKdP0j6IX4y+3FCzovfV4iZ6gnLZDvkVVORQ1332+qkvbpMMlxsL+71BFQ3C+XMqe
	 WT/CwNh6Kox1SR7VSa1mfXrnkZOlB+XA0DX8dVCRe2WXx5+5pGNvzG4Tf8EPgwzyqm
	 Ca6Knt30Lo2nq0CKd8Ztzimkvc2g94GO1l1LJ2aAL8me+Fng1yu7ypdObm0mPy2PcR
	 uVPGBj5IV2TYxGZXsubxVXQ2vKHAT6q0IvUaL12QuDVN7sp7SbTCrs8awr6+P/8Bug
	 4j+yznFuEz4+spuyjX2Il/jZ2qFIdt3kJHli20RvBGa9V8NVB5gxELHNxjok1c2KXz
	 fhwKlMpOpcKww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, alexghiti@rivosinc.com, bjorn@rivosinc.com
Cc: lihangjing@bytedance.com, xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xu Lu
 <luxu.kernel@bytedance.com>
Subject: Re: [PATCH v3] riscv: mm: Fix the out of bound issue of vmemmap
 address
In-Reply-To: <20241209095113.41154-1-luxu.kernel@bytedance.com>
References: <20241209095113.41154-1-luxu.kernel@bytedance.com>
Date: Mon, 09 Dec 2024 12:03:11 +0100
Message-ID: <87v7vtw234.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Minor nits below; Too many ifdefs.

Xu Lu <luxu.kernel@bytedance.com> writes:

> In sparse vmemmap model, the virtual address of vmemmap is calculated as:
> ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
> And the struct page's va can be calculated with an offset:
> (vmemmap + (pfn)).
>
> However, when initializing struct pages, kernel actually starts from the
> first page from the same section that phys_ram_base belongs to. If the
> first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
> we get an va below VMEMMAP_START when calculating va for it's struct page.
>
> For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
> first page in the same section is actually pfn 0x80000. During
> init_unavailable_range(), we will initialize struct page for pfn 0x80000
> with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
> below VMEMMAP_START as well as PCI_IO_END.
>
> This commit fixes this bug by introducing a new variable
> 'vmemmap_start_pfn' which is aligned with memory section size and using
> it to calculate vmemmap address instead of phys_ram_base.
>
> Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/page.h    |  4 ++++
>  arch/riscv/include/asm/pgtable.h |  4 +++-
>  arch/riscv/mm/init.c             | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 71aabc5c6713..a1be1adcfb85 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -123,6 +123,10 @@ struct kernel_mapping {
>  extern struct kernel_mapping kernel_map;
>  extern phys_addr_t phys_ram_base;
>=20=20
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP

Not needed, and should be removed.

> +extern unsigned long vmemmap_start_pfn;
> +#endif
> +
>  #define is_kernel_mapping(x)	\
>  	((x) >=3D kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_=
map.size))
>=20=20
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index d4e99eef90ac..e2dbd4b9a686 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -87,7 +87,9 @@
>   * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
>   * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
>   */
> -#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_=
SHIFT))
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP

Dito, please remove.

> +#define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
> +#endif
>=20=20
>  #define PCI_IO_SIZE      SZ_16M
>  #define PCI_IO_END       VMEMMAP_START
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..e7c52d647f50 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -32,6 +32,9 @@
>  #include <asm/numa.h>
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP

Not needed, please remove.

> +#include <asm/sparsemem.h>
> +#endif
>  #include <asm/soc.h>
>  #include <asm/tlbflush.h>
>=20=20
> @@ -62,6 +65,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
>  phys_addr_t phys_ram_base __ro_after_init;
>  EXPORT_SYMBOL(phys_ram_base);
>=20=20
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define VMEMMAP_ADDR_ALIGN	(1ULL << SECTION_SIZE_BITS)
> +
> +unsigned long vmemmap_start_pfn __ro_after_init;
> +EXPORT_SYMBOL(vmemmap_start_pfn);
> +#endif
> +
>  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>  							__page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
> @@ -243,6 +253,11 @@ static void __init setup_bootmem(void)
>  	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
>  		phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
>=20=20
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> +		vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >>=
 PAGE_SHIFT;
> +#endif
> +

Please fold this into the if-statement above, e.g.:
  |         if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
  |                 phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
  | #if defined(CONFIG_SPARSEMEM_VMEMMAP)
  |                 vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP=
_ADDR_ALIGN) >> PAGE_SHIFT;
  | #endif
  |         }


Bj=C3=B6rn

