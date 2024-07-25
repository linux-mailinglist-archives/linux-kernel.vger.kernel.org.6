Return-Path: <linux-kernel+bounces-261704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FA93BB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB96C2846D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5014A84;
	Thu, 25 Jul 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QhsOekPL"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DADE556
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721877141; cv=none; b=Xfv7gCpw5etRfzQhxXklpd4Yu7CKItSS6XR32Apsq4vwTJZ7B0bsR7K0Szi7jn4N792A99qGmQTu/dpF5Zyg5PiiwrpE4Hw57Ja3qHmnycLeVMlw4Gh5TCEO/OQtH9Drtyszxl/rNtqkx+u3tZGq/9ubpoHZU6HlyysFvAar05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721877141; c=relaxed/simple;
	bh=/IyIXj4F2RoOm1Qzvp5d02HPwr0GRMXw9V5J6S5gCIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f0OdHJJmVcrIr6oCjL2HbXG6sM7ux/MIV9xuJowVluEVfFMSHaVfcRwwBeksyP7JUViz6kH44kQ2lkXcPCynOyL4UT5bqgC+mcHisJQiu7qUEN+X/WK+5LIStf3FayhlpG095apqIqYVcY8zSYOLYYI4yHC9wVTswpDT4iSKhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QhsOekPL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3cabac56b38so304625b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721877138; x=1722481938; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu9687oCx4uOGDe4OiwariNCS6dee7E66EmnZVU7Q0Y=;
        b=QhsOekPLEw2GjPvLoA8O2eG0MHB6WW3i8PdhxcxoDCmVqXbg6SKNAOjjNEItGyKqQV
         /vdMDQe1UwrxqXPG2afCq7QYLLBvDnvwCweGfqUZZ0IX3R5s34VTS5MPdvepKcTI6vih
         blWycpS+oDeovj5nBSPINpn9htlx1VDzG/wMG6t6XaEUekKuPwo/mqwNBRuOu9COJ0OG
         BdiisPamc6gwxAxcVG4GMz8rpoXWz8KmcRSQd+3qcRWJVTatRWac7OaWbQj0DUNgCb6l
         0I0JLyx9Owinm/A81GmJL2MFO4ImTmL455Tn/7z9lFF7gNF/svFPAr2lLWxT1KaoPijW
         bnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721877138; x=1722481938;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu9687oCx4uOGDe4OiwariNCS6dee7E66EmnZVU7Q0Y=;
        b=WuYls30WgHPxOOPRatxxlWWzglyBxKAGaT1PMolN8C5YdAO1XxN3puuSjjCdSH0vio
         8P6VNPXc3DFu5DosDI4qp9Lut0UvxureUjCMRjKUoDAhKq4aGHMpBrlS+2EvWv2yv6cx
         xYfTGTsCPb82V+U3KA2f8/HA/F6s63hHDbpRt8/eZRKC2qxNFpoBfyBh3VS9EL05M1ol
         karXLSRANwl38dBksgEFsUd2/kxoVa5ERxFvvz+1Tt1jtGdawnPZ1G+kGLmONaBDNQge
         VLcG3R+jd0qwIPgHfosXtQJv5W3HsNt2y5ORW4/TEE2qcIB02Olh2Ke0/7d0UC9qELBY
         4A3w==
X-Forwarded-Encrypted: i=1; AJvYcCUPithnAwO/0qD2RdcDuxcmFJ9XTZU0Ohffkocgf0iiLyyBGTi9r61XNHWK+NIau0SCbegwxlFj8kFD4AmfPByLPTAHn8VS5ULKOT3k
X-Gm-Message-State: AOJu0YwN8KqKwZPdMHGaPNQ3TF6j5Q+HUd9NHFqWpRCVJ9BeuI8d+gtS
	yfxzhwA+NDCtxQvsfbhTCELycV5+RpcsCYLZJgUn2DAeuNBoHKQceAaLDnpKjy35PlweAwdXwk0
	c71kbq2mCxKwvRFGIvprcImJAaL8PVO0kkM1ARg==
X-Google-Smtp-Source: AGHT+IH7eQqNk/hE6j0z3hEenIAwOSDS1pqafFZdF1oX4eGeVYwsChdoaEs/YGxXKyBqffJft9Wjco1IX1haQoD405c=
X-Received: by 2002:a05:6870:d10d:b0:260:e48b:62d8 with SMTP id
 586e51a60fabf-264a0e7267emr1682524fac.29.1721877137982; Wed, 24 Jul 2024
 20:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724142137.91047-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240724142137.91047-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 25 Jul 2024 11:12:07 +0800
Message-ID: <CAEEQ3wnO43HLvfCKCmDbjOOLXOmDAATcyxsALrSBNCZngCTmqw@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: add paging_check() before paging_init()
To: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, rppt@kernel.org, akpm@linux-foundation.org, 
	alexghiti@rivosinc.com, bjorn@rivosinc.com, tglx@linutronix.de, 
	suagrfillet@gmail.com, arnd@arndb.de, samuel.holland@sifive.com, 
	cuiyunhui@bytedance.com, david@redhat.com, shikemeng@huaweicloud.com, 
	leobras@redhat.com, xiao.w.wang@intel.com, charlie@rivosinc.com, 
	willy@infradead.org, jszhang@kernel.org, gregkh@linuxfoundation.org, 
	chenjiahao16@huawei.com, conor.dooley@microchip.com, james.morse@arm.com, 
	ajones@ventanamicro.com, bhe@redhat.com, rmk+kernel@armlinux.org.uk, 
	namcao@linutronix.de, dawei.li@shingroup.cn, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add mailing list:
linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack=
.org

On Wed, Jul 24, 2024 at 10:22=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> When establishing a linear mapping, the virtual address is obtained
> through __va(). If the physical address is too large, such as 1TB, then
> the virtual address will overflow in the address space of sv39.
> The log is as follows:
> [    0.000000] Unable to handle kernel paging request at virtual address =
000000d97fdf7ad8
> [    0.000000] [000000d97fdf7ad8] pgd=3D000000407ff7e801, p4d=3D000000407=
ff7e801, pud=3D000000407ff7e801
> [    0.000000] Unable to handle kernel paging request at virtual address =
000000d97fdfaff0
> [    0.000000] [000000d97fdfaff0] pgd=3D000000407ff7e801, p4d=3D000000407=
ff7e801, pud=3D000000407ff7e801
> ...
> [    0.000000] Insufficient stack space to handle exception!
> [    0.000000] Task stack:     [0xffffffff81400000..0xffffffff81404000]
> [    0.000000] Overflow stack: [0xffffffff80c67370..0xffffffff80c68370]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6=
.6.3-00133-g60497fad461d-dirty #71
> [    0.000000] epc : die_kernel_fault+0x158/0x1c8
> [    0.000000]  ra : die_kernel_fault+0x12a/0x1c8
> [    0.000000] epc : ffffffff808cde36 ra : ffffffff808cde08 sp : ffffffff=
813fff80
> [    0.000000]  gp : ffffffff815a1678 tp : 0000000000000000 t0 : 00000031=
30386537
> [    0.000000]  t1 : 0000000000000031 t2 : 6537666637303430 s0 : ffffffff=
813fffc0
> [    0.000000]  s1 : ffffffff815b0b28 a0 : 0000000000000016 a1 : ffffffff=
81495298
> [    0.000000]  a2 : 0000000000000010 a3 : ffffffff81495298 a4 : 00000000=
000001fe
> [    0.000000]  a5 : 000000d97fdfa000 a6 : ffffffff814250d0 a7 : 00000000=
00000030
> [    0.000000]  s2 : 000000d97fdfaff0 s3 : ffffffff81400040 s4 : 000000d9=
7fdfaff0
> [    0.000000]  s5 : ffffffff815a0ed0 s6 : 0000000000000000 s7 : 00000000=
8f604390
> [    0.000000]  s8 : 0000000000000000 s9 : ffffffffffffffff s10: 00000000=
00000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff815baa9b t4 : ffffffff=
815baa9b
> [    0.000000]  t5 : ffffffff815baa88 t6 : ffffffff813ffda8
> [    0.000000] status: 0000000200000100 badaddr: 000000d97fdfaff0 cause: =
000000000000000d
> [    0.000000] Kernel panic - not syncing: Kernel stack overflow
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6=
.6.3-00133-g60497fad461d-dirty #71
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff800066bc>] dump_backtrace+0x28/0x30
> [    0.000000] [<ffffffff808cdac8>] show_stack+0x38/0x44
> [    0.000000] [<ffffffff808d9d40>] dump_stack_lvl+0x44/0x5c
> [    0.000000] [<ffffffff808d9d70>] dump_stack+0x18/0x20
> [    0.000000] [<ffffffff808cdfb6>] panic+0x110/0x2f2
> [    0.000000] [<ffffffff80006532>] walk_stackframe+0x0/0x120
> [    0.000000] [<ffffffff808cde08>] die_kernel_fault+0x12a/0x1c8
> [    0.000000] ---[ end Kernel panic - not syncing: Kernel stack overflow=
 ]---
>
> In other words, the maximum value of the physical address needs to meet
> Documentation/riscv/vm-layout.rst to ensure that there is no overflow.
> For sv48/57, the actual virtual address space is huge, so this problem
> is generally not triggered, but it is also checked in the code.
>
> We give a warning for the overflowed physical address region and reverve =
it
> so that the kernel can bringup successfully.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/page.h    |  9 +++++++
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/setup.c        |  1 +
>  arch/riscv/mm/init.c             | 44 ++++++++++++++++++++++++++++++++
>  include/linux/memblock.h         |  5 ++++
>  mm/memblock.c                    |  5 ----
>  6 files changed, 60 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 235fd45d998d..60c3db47c6d8 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -38,6 +38,15 @@
>   */
>  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
>  #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
> +
> +/*
> + * See vm-layout.rst, the size of L3 direct mapping of all physical
> + * memory 124GB, L4 is 64TB, L5 is 32PB.
> + */
> +#define MAX_PFN_MEM_ADDR_L5    (0x80000000000000ULL)
> +#define MAX_PFN_MEM_ADDR_L4    (0x400000000000ULL)
> +#define MAX_PFN_MEM_ADDR_L3    (0x1F00000000ULL)
> +
>  #else
>  #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
>  #endif /* CONFIG_64BIT */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 089f3c9f56a3..b4ff4791e1dc 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -947,6 +947,7 @@ extern uintptr_t _dtb_early_pa;
>  #endif /* CONFIG_XIP_KERNEL */
>  extern u64 satp_mode;
>
> +void paging_check(void);
>  void paging_init(void);
>  void misc_mem_init(void);
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..24fedaa7ae93 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -259,6 +259,7 @@ void __init setup_arch(char **cmdline_p)
>         parse_early_param();
>
>         efi_init();
> +       paging_check();
>         paging_init();
>
>         /* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bfa2dea95354..1c475c1d4c1b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1385,6 +1385,50 @@ static void __init arch_reserve_crashkernel(void)
>                                     low_size, high);
>  }
>
> +static inline bool phymem_addr_overflow(phys_addr_t start, phys_addr_t e=
nd)
> +{
> +       if (pgtable_l5_enabled) {
> +               if (start > MAX_PFN_MEM_ADDR_L5 || end > MAX_PFN_MEM_ADDR=
_L5)
> +                       goto out;
> +       }
> +       if (pgtable_l4_enabled) {
> +               if (start > MAX_PFN_MEM_ADDR_L4 || end > MAX_PFN_MEM_ADDR=
_L4)
> +                       goto out;
> +       }
> +       if (start > MAX_PFN_MEM_ADDR_L3 || end > MAX_PFN_MEM_ADDR_L3)
> +               goto out;
> +
> +       return false;
> +
> +out:
> +       WARN(true, "Physical memory address overflowed!");
> +       return true;
> +}
> +
> +static void __init phymem_check(struct memblock_type *type)
> +{
> +       phys_addr_t base, end, size;
> +       int idx;
> +       struct memblock_region *rgn;
> +
> +       for_each_memblock_type(idx, type, rgn) {
> +               base =3D rgn->base;
> +               size =3D rgn->size;
> +               end =3D base + size - 1;
> +
> +               if (phymem_addr_overflow(base, end)) {
> +                       pr_warn("Region: [0x%llx-0x%llx] reserved.", base=
, end);
> +                       memblock_reserve(base, size);
> +               }
> +       }
> +}
> +
> +void __init paging_check(void)
> +{
> +       phymem_check(&memblock.reserved);
> +       phymem_check(&memblock.memory);
> +}
> +
>  void __init paging_init(void)
>  {
>         setup_bootmem();
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index fc4d75c6cec3..36a38c326b7a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -251,6 +251,11 @@ static inline void __next_physmem_range(u64 *idx, st=
ruct memblock_type *type,
>         __for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE, \
>                              MEMBLOCK_NONE, p_start, p_end, NULL)
>
> +#define for_each_memblock_type(i, memblock_type, rgn)                  \
> +       for (i =3D 0, rgn =3D &memblock_type->regions[0];                =
   \
> +            i < memblock_type->cnt;                                    \
> +            i++, rgn =3D &memblock_type->regions[i])
> +
>  static inline bool memblock_is_hotpluggable(struct memblock_region *m)
>  {
>         return m->flags & MEMBLOCK_HOTPLUG;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3b9dc2d89b8a..f992050093f1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -141,11 +141,6 @@ struct memblock_type physmem =3D {
>   */
>  static __refdata struct memblock_type *memblock_memory =3D &memblock.mem=
ory;
>
> -#define for_each_memblock_type(i, memblock_type, rgn)                  \
> -       for (i =3D 0, rgn =3D &memblock_type->regions[0];                =
   \
> -            i < memblock_type->cnt;                                    \
> -            i++, rgn =3D &memblock_type->regions[i])
> -
>  #define memblock_dbg(fmt, ...)                                         \
>         do {                                                            \
>                 if (memblock_debug)                                     \
> --
> 2.39.2
>

Thanks,
Yunhui

