Return-Path: <linux-kernel+bounces-219680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3090D664
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7877A1C23C63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB7132494;
	Tue, 18 Jun 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aeg1qpJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7312139AC;
	Tue, 18 Jun 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722777; cv=none; b=N7TJP5BFY8x/FZwwRrm3Y2mkjMOp+FjDCkhV2/HZmzxozleWZHr8upm39nXHzZAt/E8XqDi5AAI9xgjGn8qXWH4CT9juQkNDfc2/p9Cbx/eAU/+BoR7PMwtNCQmKsHMq//i/ENRGOsW338Xo5uLktfZALsNeCm7jhxzEbRo0nTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722777; c=relaxed/simple;
	bh=9VFvLJ5D2bcVwMlb/aO0woCroDo49q//nKnY5oo0Vus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agn3GatWEjZXBdUPt6MxNNa35H3Bt4F6+Gq0+H8T4JS8corCDTbaXSYtx6FmYalgbGhEjZ2tXdaJnP1xhlRHNnpneO9gwTpp4HeNShXIjnyv2KYUWE9jHEonNxh9TcE1bKVnnYl/YpwNMLUA6O1t/wDoKunEwfYoPdABj/xJwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aeg1qpJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B634BC4AF55;
	Tue, 18 Jun 2024 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722776;
	bh=9VFvLJ5D2bcVwMlb/aO0woCroDo49q//nKnY5oo0Vus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aeg1qpJzbdiwhk0HyabcDzTXwO9AQCbIcPBHS7QUTNJkXRqIfCgR1bVmJoAwJqIqW
	 aA/mfHHKLn6NsqkPepHxDC+fxhid4DKHAx7TUdE+3ULPCiG1Dnpj0ZazWAGetk+T06
	 Fpqb//mvvp6ioyECDSMv5z7hfiSYl75o2wb5jFEWqnnveBNbsHyvSshFRZp3Faw1RS
	 I1nQT5+/0ON4TQ6ZRIi6vEVB78OXNSL8/Al7ICpwsSi6AGC4axkLIATerU0pHF4KEy
	 rePk7ffEiv9dxbrVEHw+Brt4hhINevCU3yqR8++MMgH6r7KixVGf+RFAoK0wZFiJ9J
	 g+yyDQpcEPjaw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso59211541fa.1;
        Tue, 18 Jun 2024 07:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWepa+BaUb7KH1NPCSx/EOcQlfS3x0rcBgr1OqfIVuNtzmGnabMy00akWeGXCO9BnuWv0nqsZcTZnMSm4rzjbiGvNOouAaAPP9YSiXmQGR93Tuvn6G/7LMogRnhV/gBFU2L6I9o12a1
X-Gm-Message-State: AOJu0YxU2/kBHb8PCvLIptU8bCDlU0vdp2rDyzKRSPM9ZM0Q+ARgeD+e
	ViMNA7MQrYWrP+ZYza8wvQlGklOA4cbso6OEFV57bdq2g88uRGByWCAUnAUv23EaZjGBIoPixhc
	+C9FaHcK4gAX7W7un9zujgkyYcFU=
X-Google-Smtp-Source: AGHT+IFmKDr0UJF/vB46P5FDkAXrOS2m32z+9GBnyCDYe1Bfh6hX7g0qK5mLLgIhmZTL1cK7ajhZR9bGd8nlSWfuLOw=
X-Received: by 2002:a2e:9b93:0:b0:2eb:f5ec:5acc with SMTP id
 38308e7fff4ca-2ec3cec5416mr669361fa.25.1718722774799; Tue, 18 Jun 2024
 07:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv> <san7zg5rohy7q2oep2kx6awf6gltpuv2f4xlfljw5ezxqydfkv@zkd4k4udcezz>
In-Reply-To: <san7zg5rohy7q2oep2kx6awf6gltpuv2f4xlfljw5ezxqydfkv@zkd4k4udcezz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Jun 2024 16:59:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEr579hDqV5OuEbBB-O9meCOcmcTe_SZg97UKSLbKj6pw@mail.gmail.com>
Message-ID: <CAMj1kXEr579hDqV5OuEbBB-O9meCOcmcTe_SZg97UKSLbKj6pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: non leaf ptdump support
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 16:40, Maxwell Bland <mbland@motorola.com> wrote:
>
> Separate the pte_bits used in ptdump from pxd_bits used by pmd, p4d,
> pud, and pgd descriptors, thereby adding support for printing key
> intermediate directory protection bits, such as PXNTable, and enable the
> associated support Kconfig option.
>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  arch/arm64/Kconfig     |   1 +
>  arch/arm64/mm/ptdump.c | 140 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 125 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..f4c3290160db 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -98,6 +98,7 @@ config ARM64
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>         select ARCH_SUPPORTS_PER_VMA_LOCK
> +       select ARCH_SUPPORTS_NON_LEAF_PTDUMP
>         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>         select ARCH_WANT_DEFAULT_BPF_JIT
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 6986827e0d64..8f0b459c13ed 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -24,6 +24,7 @@
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/ptdump.h>
> +#include <asm/pgalloc.h>
>
>
>  #define pt_dump_seq_printf(m, fmt, args...)    \
> @@ -105,11 +106,6 @@ static const struct prot_bits pte_bits[] = {
>                 .val    = PTE_CONT,
>                 .set    = "CON",
>                 .clear  = "   ",
> -       }, {
> -               .mask   = PTE_TABLE_BIT,
> -               .val    = PTE_TABLE_BIT,
> -               .set    = "   ",
> -               .clear  = "BLK",
>         }, {
>                 .mask   = PTE_UXN,
>                 .val    = PTE_UXN,
> @@ -143,34 +139,129 @@ static const struct prot_bits pte_bits[] = {
>         }
>  };
>
> +static const struct prot_bits pxd_bits[] = {

This table will need to distinguish between table and block entries.
In your sample output, I see

2M PMD   TBL     RW               x            UXNTbl    MEM/NORMAL

for a table entry, which includes a memory type and access permissions
based on descriptor fields that are not used for table descriptors.

Some other attributes listed below are equally inapplicable to table
entries, but happen to be 0x0 so they don't appear in the output, but
they would if the IGNORED bit in the descriptor happened to be set.

So I suspect that the distinction pte_bits <-> pxd_bits is not so
useful here. It would be better to have tbl_bits[], with pointers to
it in the pg_level array, where the PTE level one is set to NULL.


> +       {
> +               .mask   = PMD_SECT_VALID,
> +               .val    = PMD_SECT_VALID,
> +               .set    = " ",
> +               .clear  = "F",
> +       }, {
> +               .mask   = PMD_TABLE_BIT,
> +               .val    = PMD_TABLE_BIT,
> +               .set    = "TBL",
> +               .clear  = "BLK",
> +       }, {
> +               .mask   = PMD_SECT_USER,
> +               .val    = PMD_SECT_USER,
> +               .set    = "USR",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PMD_SECT_RDONLY,
> +               .val    = PMD_SECT_RDONLY,
> +               .set    = "ro",
> +               .clear  = "RW",
> +       }, {
> +               .mask   = PMD_SECT_S,
> +               .val    = PMD_SECT_S,
> +               .set    = "SHD",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PMD_SECT_AF,
> +               .val    = PMD_SECT_AF,
> +               .set    = "AF",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PMD_SECT_NG,
> +               .val    = PMD_SECT_NG,
> +               .set    = "NG",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PMD_SECT_CONT,
> +               .val    = PMD_SECT_CONT,
> +               .set    = "CON",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PMD_SECT_PXN,
> +               .val    = PMD_SECT_PXN,
> +               .set    = "NX",
> +               .clear  = "x ",
> +       }, {
> +               .mask   = PMD_SECT_UXN,
> +               .val    = PMD_SECT_UXN,
> +               .set    = "UXN",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PMD_TABLE_PXN,
> +               .val    = PMD_TABLE_PXN,
> +               .set    = "NXTbl",
> +               .clear  = "     ",
> +       }, {
> +               .mask   = PMD_TABLE_UXN,
> +               .val    = PMD_TABLE_UXN,
> +               .set    = "UXNTbl",
> +               .clear  = "      ",
> +       }, {
> +               .mask   = PTE_GP,
> +               .val    = PTE_GP,
> +               .set    = "GP",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PMD_ATTRINDX_MASK,
> +               .val    = PMD_ATTRINDX(MT_DEVICE_nGnRnE),
> +               .set    = "DEVICE/nGnRnE",
> +       }, {
> +               .mask   = PMD_ATTRINDX_MASK,
> +               .val    = PMD_ATTRINDX(MT_DEVICE_nGnRE),
> +               .set    = "DEVICE/nGnRE",
> +       }, {
> +               .mask   = PMD_ATTRINDX_MASK,
> +               .val    = PMD_ATTRINDX(MT_NORMAL_NC),
> +               .set    = "MEM/NORMAL-NC",
> +       }, {
> +               .mask   = PMD_ATTRINDX_MASK,
> +               .val    = PMD_ATTRINDX(MT_NORMAL),
> +               .set    = "MEM/NORMAL",
> +       }, {
> +               .mask   = PMD_ATTRINDX_MASK,
> +               .val    = PMD_ATTRINDX(MT_NORMAL_TAGGED),
> +               .set    = "MEM/NORMAL-TAGGED",
> +       }
> +};
> +
>  struct pg_level {
>         const struct prot_bits *bits;
>         char name[4];
>         int num;
>         u64 mask;
> +       unsigned long size;
>  };
>
>  static struct pg_level pg_level[] __ro_after_init = {
>         { /* pgd */
>                 .name   = "PGD",
> -               .bits   = pte_bits,
> -               .num    = ARRAY_SIZE(pte_bits),
> +               .bits   = pxd_bits,
> +               .num    = ARRAY_SIZE(pxd_bits),
> +               .size   = PGDIR_SIZE,
>         }, { /* p4d */
>                 .name   = "P4D",
> -               .bits   = pte_bits,
> -               .num    = ARRAY_SIZE(pte_bits),
> +               .bits   = pxd_bits,
> +               .num    = ARRAY_SIZE(pxd_bits),
> +               .size   = P4D_SIZE,
>         }, { /* pud */
>                 .name   = "PUD",
> -               .bits   = pte_bits,
> -               .num    = ARRAY_SIZE(pte_bits),
> +               .bits   = pxd_bits,
> +               .num    = ARRAY_SIZE(pxd_bits),
> +               .size   = PUD_SIZE,
>         }, { /* pmd */
>                 .name   = "PMD",
> -               .bits   = pte_bits,
> -               .num    = ARRAY_SIZE(pte_bits),
> +               .bits   = pxd_bits,
> +               .num    = ARRAY_SIZE(pxd_bits),
> +               .size   = PMD_SIZE,
>         }, { /* pte */
>                 .name   = "PTE",
>                 .bits   = pte_bits,
>                 .num    = ARRAY_SIZE(pte_bits),
> +               .size   = PAGE_SIZE
>         },
>  };
>
> @@ -251,10 +342,27 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>                         note_prot_wx(st, addr);
>                 }
>
> -               pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> -                                  st->start_address, addr);
> +               /*
> +                * Non-leaf entries use a fixed size for their range
> +                * specification, whereas leaf entries are grouped by
> +                * attributes and may not have a range larger than the type
> +                * specifier.
> +                */
> +               if (st->start_address == addr) {
> +                       if (check_add_overflow(addr, pg_level[st->level].size,
> +                                              &delta))
> +                               delta = ULONG_MAX - addr + 1;
> +                       else
> +                               delta = pg_level[st->level].size;
> +                       pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> +                                          addr, addr + delta);
> +               } else {
> +                       delta = (addr - st->start_address);
> +                       pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> +                                          st->start_address, addr);
> +               }
>
> -               delta = (addr - st->start_address) >> 10;
> +               delta >>= 10;
>                 while (!(delta & 1023) && unit[1]) {
>                         delta >>= 10;
>                         unit++;
> --
> 2.39.2
>
>

