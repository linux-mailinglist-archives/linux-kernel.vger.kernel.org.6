Return-Path: <linux-kernel+bounces-437617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D59E95ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D81E16594A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305022ACC6;
	Mon,  9 Dec 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FBmr3FQu"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8922ACC0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749584; cv=none; b=iCbfTXe3tvpdMm1jx5jbw3FsmtPMii+976+L87lRkNGTPlDQd578FxE2+UtOd1iWXS8g/GD3jZ930/7jrr5ZPMzmdzpj6my1+lR+s4SOkLmyK3ivCguIhKLm1sZMBCdSwS8bjcol8IFSwiXfV2Q99Nz+OYv3M7nOkcbnNITHrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749584; c=relaxed/simple;
	bh=l5hI4R1ggeFR4CRmCgAwp4myfnY4jEgf5gsCYiEiozQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cccJQnta4FHtlsA55jpmkuJ+xJETPa6idkJLt3lvNKG456p9bKgO/5Bz8s6238rgsOIiYaAR7lYjmegCb+eqrxySyIZTrjJo9LcKperhtxSoBZPpEcEoeUejQAmF3aa0Fhbt47rl9wMX+v+xOzi9R3javl2OK/N0YzFlVNja1Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FBmr3FQu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so2788265a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733749580; x=1734354380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vnKbMt8GVQHipfZqCna4Dds/lgTg/09hSxoCFAuMCs=;
        b=FBmr3FQuY6soIW5E5P0BTaZCxUfLIjBdILOtPsZYYGWvhibfT3Qh04hnKp79PyUSUq
         GK403f/w6rgAr6gL+CTZ2rFFSapTkyj4roMMan/pNffxnrScr2wcp7+smqZIbi72yR85
         p2XbSutfN7rksy3hJb5PaEU+WBfQq8cdttW1yXX8cFO7l9duGRd2G1N2dNUhMBpC2Iin
         rQ6F2tmg+NgdSdbeeundkRba4+9KA11psdYwdGDtQ3AakeZbQ8jBm26Op9wHSaxaRj5U
         2DOyj47F9AVhPgbxEvpE+FECoTzvXrHejQhUD6SjQI4ja7kDR7qwHrmIiSdPBv0csqXz
         DYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749580; x=1734354380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vnKbMt8GVQHipfZqCna4Dds/lgTg/09hSxoCFAuMCs=;
        b=KAKVlfYGj9jInwwpSpKeGtWIKz1/87X+50m+AhGF2b/pVcVxAfWGlYTeRPqC5tntWn
         JnL1jv3VPS1HZO9InV4R1JWWkctjYiM2dYidna5S0kaajvQ/VCEOAHzXAeJMPAiMMvib
         d/Q7aGhxKtvMdMUFB95bRbSQex8Ul4+HBqh/xm0VH+yHmEm29XJyZZ5ReAf8CTjeHYs9
         Uy8IMToSSRH32g9sVPifjaB28C6hLhm47Ne6pTRdDqNBYy4ShowVMqSaJdXDQB79Rmgy
         8ZYCyEitf8HvrfOq8a+iIQcluSpSnsG5p1DcPfMOd4pLLcY0z5NxUjFEi49jjFKKqeFB
         oTxA==
X-Forwarded-Encrypted: i=1; AJvYcCVD06YjRx2frk5BW5HbndzgIYsrqIxCsPuGq3+kAiDpUh9K9Oa6pg9I/gkkTvjO3JWrhVj0efM26FERpP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvs7HlsMzNWQWQt8AL1UU86eFpQoyQhTYrqqEOd6Sd1xIMd6T
	SEGSEapNFx902D7gorCZ4DtUBiEy4KHRns4BqYd/fYra3aljZWuESU5ptaUlcuXwSCAGPfVqy5+
	1pX9Tf/F6E9JMrURgz6xGm2JO65DH8MSsswlmQg==
X-Gm-Gg: ASbGncu3Rk1D3Tia/MQ2YIR6bScFZKWlQjtBwf+KyXQfFMCzGZbAZxJy+cp0kTLgueY
	pWTieoqbdW1U2hbjpSXZY9ol3tGXbxg==
X-Google-Smtp-Source: AGHT+IFaQYRw8RYdW1sPvgkRBwggky95xvwYOV9WMfIU8hiYFwkc29e7eBFXhjqLyYEhJh/Ugq9XGO58YSCJQfv/mrw=
X-Received: by 2002:a05:6402:3906:b0:5cf:924f:9968 with SMTP id
 4fb4d7f45d1cf-5d3be661c03mr12885632a12.2.1733749579721; Mon, 09 Dec 2024
 05:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209122617.53341-1-luxu.kernel@bytedance.com>
In-Reply-To: <20241209122617.53341-1-luxu.kernel@bytedance.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 9 Dec 2024 14:06:09 +0100
Message-ID: <CAHVXubghpQsCjf-H7C7ZQHQX7+RLJPCaZYE-KoJbw_mkKZKc2g@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: mm: Fix the out of bound issue of vmemmap address
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xu,

On Mon, Dec 9, 2024 at 1:26=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> wr=
ote:
>
> In sparse vmemmap model, the virtual address of vmemmap is calculated as:
> ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
> And the struct page's va can be calculated with an offset:
> (vmemmap + (pfn)).
>
> However, when initializing struct pages, kernel actually starts from the
> first page from the same section that phys_ram_base belongs to. If the
> first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
> we get an va below VMEMMAP_START when calculating va for it's struct page=
.
>
> For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, th=
e
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
>  arch/riscv/include/asm/page.h    |  1 +
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             | 17 ++++++++++++++++-
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 71aabc5c6713..125f5ecd9565 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -122,6 +122,7 @@ struct kernel_mapping {
>
>  extern struct kernel_mapping kernel_map;
>  extern phys_addr_t phys_ram_base;
> +extern unsigned long vmemmap_start_pfn;
>
>  #define is_kernel_mapping(x)   \
>         ((x) >=3D kernel_map.virt_addr && (x) < (kernel_map.virt_addr + k=
ernel_map.size))
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index d4e99eef90ac..050fdc49b5ad 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -87,7 +87,7 @@
>   * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
>   * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
>   */
> -#define vmemmap                ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
> +#define vmemmap                ((struct page *)VMEMMAP_START - vmemmap_s=
tart_pfn)
>
>  #define PCI_IO_SIZE      SZ_16M
>  #define PCI_IO_END       VMEMMAP_START
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..d93271cb97b1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -33,6 +33,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
>  #include <asm/soc.h>
> +#include <asm/sparsemem.h>
>  #include <asm/tlbflush.h>
>
>  #include "../kernel/head.h"
> @@ -62,6 +63,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
>  phys_addr_t phys_ram_base __ro_after_init;
>  EXPORT_SYMBOL(phys_ram_base);
>
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define VMEMMAP_ADDR_ALIGN     (1ULL << SECTION_SIZE_BITS)
> +
> +unsigned long vmemmap_start_pfn __ro_after_init;
> +EXPORT_SYMBOL(vmemmap_start_pfn);
> +#endif
> +
>  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>                                                         __page_aligned_bs=
s;
>  EXPORT_SYMBOL(empty_zero_page);
> @@ -240,8 +248,12 @@ static void __init setup_bootmem(void)
>          * Make sure we align the start of the memory on a PMD boundary s=
o that
>          * at worst, we map the linear mapping with PMD mappings.
>          */
> -       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> +       if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
>                 phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +               vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP_A=
DDR_ALIGN) >> PAGE_SHIFT;
> +#endif
> +       }
>
>         /*
>          * In 64-bit, any use of __va/__pa before this point is wrong as =
we
> @@ -1101,6 +1113,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         kernel_map.xiprom_sz =3D (uintptr_t)(&_exiprom) - (uintptr_t)(&_x=
iprom);
>
>         phys_ram_base =3D CONFIG_PHYS_RAM_BASE;
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +       vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP_ADDR_ALIG=
N) >> PAGE_SHIFT;
> +#endif
>         kernel_map.phys_addr =3D (uintptr_t)CONFIG_PHYS_RAM_BASE;
>         kernel_map.size =3D (uintptr_t)(&_end) - (uintptr_t)(&_start);
>
> --
> 2.20.1
>

Thanks for the multiple revisions!

It looks good to me, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks again,

Alex

