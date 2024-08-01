Return-Path: <linux-kernel+bounces-270841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C8944611
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49551284268
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE93E47B;
	Thu,  1 Aug 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nd/SMveF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CC1BDC8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499311; cv=none; b=LUOnEXuS4M76pzjJqBc6j6TXCxhilN9NQdycX01FF3mN70I5JWowglzKVpAob2k3eOtiGn8+AeNoB63xVnmdtZPvjui35pmxx7gCi64TgRUiPUXzcyo/wstskfXku06ou2QqwiR4L4exO/RgBoxuJ2BxS92Wn8ScHqmnoNHozrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499311; c=relaxed/simple;
	bh=sJgLXmCKFpWtiKLUzC0PZ28csdpabuzHr7uDPxQsJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQvofTUFEP+cL5sM2SrrTNs/n3wdNe4stG2vuSyOQaiZT1j6MtLQvYnTS8JT83jiuW5h6KIfsKyNXUdI9G/EsDvBE5VdqNrd164A4QFZ1+KiMisu2sfyo7kEYQaqllqJgQCRTyb8VlyeFk8AKWyktMVfgGVG0pZTWI/VApojH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nd/SMveF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a975fb47eso925810466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722499307; x=1723104107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5nyBMzKFgDD9FVTBeC5OJZVCX8FHmRFRo/UWwDjEZ4=;
        b=nd/SMveF0CBrIgpyw/ji6GudGoj9l6E6mbNP34rIQJY3XcP6bzPBvBTUOKYKHlY004
         5KjFaU/GGsbiRLNcgvh9qH+37f/6Aeg3w2fPWE8tt5pl+Agz0lEyccWYzsxb/uqdl4DO
         xkxgq+vBGV5/3/Qr9jzNcw3Gn2Ju1CnzOnW5rKLzha3sN/3j0SuWYdEGRRNO1QQA6ZNh
         HVWp+yJYn0PjX1CuM3+06U5Ftz/ZxTzb8TDk2j4UX3GZHOtXMYkZdOE5wG7KRvxvhaks
         VBa6fGgJEuiW/G83o54xUOO4E06fAQ+K5KE26hKGnZrLMZzrJphPaEUFwWCBMiENDjIG
         ecfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499307; x=1723104107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5nyBMzKFgDD9FVTBeC5OJZVCX8FHmRFRo/UWwDjEZ4=;
        b=gsbVUHts59Hv8LBx86+Kp0VtV3ehsadi9yAQFGU8YhThkb8Ckim8txIQ+ZERyA5c5v
         YjgrIt5/mg7yyCyyWvsUrNvrrInSxUoo+Awew5Xxe9XLDSY0MuwT7+EK9DTQrAjAxeoT
         1hnUKmvkSwTSYws1r7Ml2AzWihSU45p70zsej0etGSr2Q0Y7O1LYvq9JxPgIWF1oh3p6
         FftIYeXzJUZ6aM81XnNxAtvtYbY1e+/LYkSt68g4YaiD/cCmvEQ0v5uTenuqHoZtdeZs
         rFs7UGucd9yvcb7dbhDnZB3MwHpoUMrMzHVWHI6LzV3lQZrJXPinBZFQCV9SMEdgZKPY
         Ldgg==
X-Forwarded-Encrypted: i=1; AJvYcCUpdjMioOkDq6rCcaL2yvLRBh6nqFQ0SyVtWTHhqcjt8fa1cavfaF8Lkx+u7w6XNaZXKvNEFsM9OjKqwDtq+V0SRDBktN+rLDDWVHZ/
X-Gm-Message-State: AOJu0YycjbMJl7x3qI2In02KCKd+IWCcRRe/rmhQi0rJH9WiYPADP58t
	mZCzMqjFYPgGPN9YEJYH9enpoDfjyxirOLKW8BHNXAnSqSOQNloUUkhomHw8GvWkDBPKn1uMbZ0
	6kk3RPcwz2zbl9p+qZRD442BiFKSkQtYEpLQYwg==
X-Google-Smtp-Source: AGHT+IFXllK+Nz9VsYx2QJczd1lfjpXOVBZEnpS/FAo0EIeJ75GoHMILePAAcc33Zb/9eZIY/jB6o+J/imVJ2gGybYI=
X-Received: by 2002:a17:906:7315:b0:a7a:c083:8579 with SMTP id
 a640c23a62f3a-a7dafd5e73bmr122064166b.62.1722499307293; Thu, 01 Aug 2024
 01:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725074155.20565-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240725074155.20565-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 1 Aug 2024 10:01:36 +0200
Message-ID: <CAHVXubiyJtmiquZ+vmAa+T-nP-pXbAAvf2S=DSCZMk99wuhhpg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: add paging_check() before paging_init()
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, samitolvanen@google.com, gregkh@linuxfoundation.org, 
	suagrfillet@gmail.com, akpm@linux-foundation.org, shikemeng@huaweicloud.com, 
	willy@infradead.org, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	conor.dooley@microchip.com, chenjiahao16@huawei.com, guoren@kernel.org, 
	jszhang@kernel.org, ajones@ventanamicro.com, bhe@redhat.com, 
	vishal.moola@gmail.com, ndesaulniers@google.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Thu, Jul 25, 2024 at 9:42=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
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
>  arch/riscv/include/asm/page.h    |  9 +++++++++
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/setup.c        |  1 +
>  arch/riscv/mm/init.c             | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 41 insertions(+)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 57e887bfa34c..f6c0f6e14ecb 100644
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
> index c8e8867c42f6..e4835de5a743 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -915,6 +915,7 @@ extern uintptr_t _dtb_early_pa;
>  #endif /* CONFIG_XIP_KERNEL */
>  extern u64 satp_mode;
>
> +void paging_check(void);
>  void paging_init(void);
>  void misc_mem_init(void);
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2a79d4ed2660..366918578544 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -273,6 +273,7 @@ void __init setup_arch(char **cmdline_p)
>         parse_early_param();
>
>         efi_init();
> +       paging_check();
>         paging_init();
>
>         /* Parse the ACPI tables for possible boot-time configuration */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b0cc28f7595f..aa25dcf8a0ff 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1482,6 +1482,36 @@ static void __init reserve_crashkernel(void)
>         crashk_res.end =3D crash_base + crash_size - 1;
>  }
>
> +static void __init phymem_addr_overflow(void)
> +{
> +       phys_addr_t end =3D memblock_end_of_DRAM();
> +
> +       if (pgtable_l5_enabled) {
> +               if (end > MAX_PFN_MEM_ADDR_L5) {
> +                       memblock_reserve(MAX_PFN_MEM_ADDR_L5, end - MAX_P=
FN_MEM_ADDR_L5);
> +                       WARN(true, "Phymem addr 0x%llx overflowed, reserv=
e [0x%llx-0x%llx] directly.",
> +                            end, MAX_PFN_MEM_ADDR_L5, end);
> +               }
> +       }
> +       if (pgtable_l4_enabled) {
> +               if (end > MAX_PFN_MEM_ADDR_L4) {
> +                       memblock_reserve(MAX_PFN_MEM_ADDR_L4, end - MAX_P=
FN_MEM_ADDR_L4);
> +                       WARN(true, "Phymem addr 0x%llx overflowed, reserv=
e [0x%llx-0x%llx] directly.",
> +                            end, MAX_PFN_MEM_ADDR_L4, end);
> +               }
> +       }
> +       if (end > MAX_PFN_MEM_ADDR_L3) {
> +               memblock_reserve(MAX_PFN_MEM_ADDR_L3, end - MAX_PFN_MEM_A=
DDR_L3);
> +               WARN(true, "Phymem addr 0x%llx overflowed, reserve [0x%ll=
x-0x%llx] directly.",
> +                    end, MAX_PFN_MEM_ADDR_L3, end);
> +       }
> +}
> +
> +void __init paging_check(void)
> +{
> +       phymem_addr_overflow();
> +}
> +
>  void __init paging_init(void)
>  {
>         setup_bootmem();
> --
> 2.39.2
>

So the following patch should fix your issue and was posted some time
ago https://lore.kernel.org/linux-riscv/bdfbed9b-ea04-4415-8416-d6e9d0a643a=
3@ghiti.fr/T/#me26a82cf32f46cae12e2ea8892a3bc16d4fc37e3.
I prefer this solution as it does not introduce a bunch of hardcoded
defines and relies on the already existing memblock API.

Let me know if that's not the case!

Thanks,

Alex

