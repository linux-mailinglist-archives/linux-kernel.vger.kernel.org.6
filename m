Return-Path: <linux-kernel+bounces-273359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A3946828
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DED1C20AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F14136350;
	Sat,  3 Aug 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fM5Oi57h"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FF136353
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722666520; cv=none; b=rTDiUaOOoezdw+GHMoGT8529LMlMF0rweUZny+IGcr+aFfVblkTn9gMUt2Z7GC57xOxFtbM0P68d2r51udHYDHZ6aZUUFx3nypDfy0cQXtUUTMjnhK+AzUPRDCzDG77SkxjhJf4s6q8wvTvTH1ISkacIOp3J2BlO/Jl8Ugk6RWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722666520; c=relaxed/simple;
	bh=vqqtOOP/WMnJmURAvzaXzhiv8hoFMb5vJXvHDB7u74Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtZMiq+L1LiodIi1QaqTR2Hkl1ueySGxZgeQjJ4qr1tq8d5d+YMKLmsrqndbZuTw/1/R6YEXEgSanElrAdcOCckY8+JkqNg69xtnCwSlbE6YNGIlR1R1OOmkZZtnIn/LzCfQeg8sFC9gyGafqVl0D2TN4FRn93UIqOWCzWd1Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fM5Oi57h; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-26106ec9336so4828361fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722666517; x=1723271317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS9e5AojM2FyKsRCAqA1FtAEc0CQzzQZzDu8fB+emLU=;
        b=fM5Oi57h8GJOTomqaM48pE02meGq0IsQjHChW4/q62gxnjdf7a1KvR/7cm78g3VBZL
         FawOSgKfy7m0T5troORwAShsf0rNPOvMiGr2eWcpt9HrMW98bpjlE5wqPUDpDwi/no8L
         1LvobFf5SrtBs7XhUnps5aVGOlQeuVrjdB7sRQyb0Jw09Boqk7yfdUSIZIVydiQbsJhB
         r0SpR9Cm37hqv1qrP3hxy2p4cGYE8Bt3jnAEvX1ROlXFYLUIElb4RT6x2aqg3leYvkPH
         x1sj+xELQlLeDeGd95w7S14hgPPLVGMyCM9vjWZkT+L+Lg5FXysxg1I5uSYLMYN7kP9z
         VirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722666517; x=1723271317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS9e5AojM2FyKsRCAqA1FtAEc0CQzzQZzDu8fB+emLU=;
        b=grztUVZpmQh2i+7G/SvTe8cvRHrhoahInfFKYU3Tv7qm8Dmy/ADgsAPv9dk1MK+mmP
         l6pBiXcxAjptJZorTP9YW+3/WNSous6nKGZR7XHi2fy4eglJvoltMg3YPs3IEf3myQqr
         jeKZdEHLQDubyR5z7mR0iIiQvQVDVp6Kwz9RmywZt1SkbFEbNnLoZdLUGQMezJJLhYW4
         S44X3uMPUx7OoZ1sVulqRttgyfJ5AMHYRawnslpJ0mlYptDE5tmNixnC2wKDaQeMuE6A
         qIZfOeZ8gyGixhXC2O76lEm9W7uHgp1kjcENOG9+Jv+DPEOVK4JIdH9JwFbTe6jTjqEk
         tB6w==
X-Forwarded-Encrypted: i=1; AJvYcCUMURH2yuo+BV62vQ5pn5Q67MaN1lmBKQCzDg3xzmJITNBzqbxw5GJGlaO7DnZdmDBraE9cw8N7OVcp4gtcHAQWu4CDhC17IxCG3V8/
X-Gm-Message-State: AOJu0YzswEMzeu1RZuHfhrvzufYhFk7W1QPis06qQsh6yyz0Mh2J7T01
	EyP8uckGout+81B4NwHWibeyh8ODoGFCexTcdYWc3txtVbndZP9Qgss7J3v4pfoj1LxqM68U18R
	8IHouXpWBk2OetHRlQhwuZ9dyWlrzC1LJVRy5Yw==
X-Google-Smtp-Source: AGHT+IFB6k85XSry+FXivXr70vUaAShWN6O99fsVTwPfilw5NmNHRB3djHJUefgNQ5xFryVWzKmNJbPfDL6P2MwwFmY=
X-Received: by 2002:a05:6870:41d2:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-26891e930damr7215988fac.40.1722666516996; Fri, 02 Aug 2024
 23:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725074155.20565-1-cuiyunhui@bytedance.com> <CAHVXubiyJtmiquZ+vmAa+T-nP-pXbAAvf2S=DSCZMk99wuhhpg@mail.gmail.com>
In-Reply-To: <CAHVXubiyJtmiquZ+vmAa+T-nP-pXbAAvf2S=DSCZMk99wuhhpg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sat, 3 Aug 2024 14:28:26 +0800
Message-ID: <CAEEQ3wkDprXSGmPO8ufYqJMiTjuxoQwFHG+OAtfd9p0ggC8y_g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv: mm: add paging_check() before paging_init()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
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

Hi Alex,

On Thu, Aug 1, 2024 at 4:02=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hi Yunhui,
>
> On Thu, Jul 25, 2024 at 9:42=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > When establishing a linear mapping, the virtual address is obtained
> > through __va(). If the physical address is too large, such as 1TB, then
> > the virtual address will overflow in the address space of sv39.
> > The log is as follows:
> > [    0.000000] Unable to handle kernel paging request at virtual addres=
s 000000d97fdf7ad8
> > [    0.000000] [000000d97fdf7ad8] pgd=3D000000407ff7e801, p4d=3D0000004=
07ff7e801, pud=3D000000407ff7e801
> > [    0.000000] Unable to handle kernel paging request at virtual addres=
s 000000d97fdfaff0
> > [    0.000000] [000000d97fdfaff0] pgd=3D000000407ff7e801, p4d=3D0000004=
07ff7e801, pud=3D000000407ff7e801
> > ...
> > [    0.000000] Insufficient stack space to handle exception!
> > [    0.000000] Task stack:     [0xffffffff81400000..0xffffffff81404000]
> > [    0.000000] Overflow stack: [0xffffffff80c67370..0xffffffff80c68370]
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W         =
 6.6.3-00133-g60497fad461d-dirty #71
> > [    0.000000] epc : die_kernel_fault+0x158/0x1c8
> > [    0.000000]  ra : die_kernel_fault+0x12a/0x1c8
> > [    0.000000] epc : ffffffff808cde36 ra : ffffffff808cde08 sp : ffffff=
ff813fff80
> > [    0.000000]  gp : ffffffff815a1678 tp : 0000000000000000 t0 : 000000=
3130386537
> > [    0.000000]  t1 : 0000000000000031 t2 : 6537666637303430 s0 : ffffff=
ff813fffc0
> > [    0.000000]  s1 : ffffffff815b0b28 a0 : 0000000000000016 a1 : ffffff=
ff81495298
> > [    0.000000]  a2 : 0000000000000010 a3 : ffffffff81495298 a4 : 000000=
00000001fe
> > [    0.000000]  a5 : 000000d97fdfa000 a6 : ffffffff814250d0 a7 : 000000=
0000000030
> > [    0.000000]  s2 : 000000d97fdfaff0 s3 : ffffffff81400040 s4 : 000000=
d97fdfaff0
> > [    0.000000]  s5 : ffffffff815a0ed0 s6 : 0000000000000000 s7 : 000000=
008f604390
> > [    0.000000]  s8 : 0000000000000000 s9 : ffffffffffffffff s10: 000000=
0000000000
> > [    0.000000]  s11: 0000000000000000 t3 : ffffffff815baa9b t4 : ffffff=
ff815baa9b
> > [    0.000000]  t5 : ffffffff815baa88 t6 : ffffffff813ffda8
> > [    0.000000] status: 0000000200000100 badaddr: 000000d97fdfaff0 cause=
: 000000000000000d
> > [    0.000000] Kernel panic - not syncing: Kernel stack overflow
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W         =
 6.6.3-00133-g60497fad461d-dirty #71
> > [    0.000000] Call Trace:
> > [    0.000000] [<ffffffff800066bc>] dump_backtrace+0x28/0x30
> > [    0.000000] [<ffffffff808cdac8>] show_stack+0x38/0x44
> > [    0.000000] [<ffffffff808d9d40>] dump_stack_lvl+0x44/0x5c
> > [    0.000000] [<ffffffff808d9d70>] dump_stack+0x18/0x20
> > [    0.000000] [<ffffffff808cdfb6>] panic+0x110/0x2f2
> > [    0.000000] [<ffffffff80006532>] walk_stackframe+0x0/0x120
> > [    0.000000] [<ffffffff808cde08>] die_kernel_fault+0x12a/0x1c8
> > [    0.000000] ---[ end Kernel panic - not syncing: Kernel stack overfl=
ow ]---
> >
> > In other words, the maximum value of the physical address needs to meet
> > Documentation/riscv/vm-layout.rst to ensure that there is no overflow.
> > For sv48/57, the actual virtual address space is huge, so this problem
> > is generally not triggered, but it is also checked in the code.
> >
> > We give a warning for the overflowed physical address region and reverv=
e it
> > so that the kernel can bringup successfully.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/page.h    |  9 +++++++++
> >  arch/riscv/include/asm/pgtable.h |  1 +
> >  arch/riscv/kernel/setup.c        |  1 +
> >  arch/riscv/mm/init.c             | 30 ++++++++++++++++++++++++++++++
> >  4 files changed, 41 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 57e887bfa34c..f6c0f6e14ecb 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -38,6 +38,15 @@
> >   */
> >  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
> >  #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
> > +
> > +/*
> > + * See vm-layout.rst, the size of L3 direct mapping of all physical
> > + * memory 124GB, L4 is 64TB, L5 is 32PB.
> > + */
> > +#define MAX_PFN_MEM_ADDR_L5    (0x80000000000000ULL)
> > +#define MAX_PFN_MEM_ADDR_L4    (0x400000000000ULL)
> > +#define MAX_PFN_MEM_ADDR_L3    (0x1F00000000ULL)
> > +
> >  #else
> >  #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> >  #endif /* CONFIG_64BIT */
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index c8e8867c42f6..e4835de5a743 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -915,6 +915,7 @@ extern uintptr_t _dtb_early_pa;
> >  #endif /* CONFIG_XIP_KERNEL */
> >  extern u64 satp_mode;
> >
> > +void paging_check(void);
> >  void paging_init(void);
> >  void misc_mem_init(void);
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2a79d4ed2660..366918578544 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -273,6 +273,7 @@ void __init setup_arch(char **cmdline_p)
> >         parse_early_param();
> >
> >         efi_init();
> > +       paging_check();
> >         paging_init();
> >
> >         /* Parse the ACPI tables for possible boot-time configuration *=
/
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b0cc28f7595f..aa25dcf8a0ff 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -1482,6 +1482,36 @@ static void __init reserve_crashkernel(void)
> >         crashk_res.end =3D crash_base + crash_size - 1;
> >  }
> >
> > +static void __init phymem_addr_overflow(void)
> > +{
> > +       phys_addr_t end =3D memblock_end_of_DRAM();
> > +
> > +       if (pgtable_l5_enabled) {
> > +               if (end > MAX_PFN_MEM_ADDR_L5) {
> > +                       memblock_reserve(MAX_PFN_MEM_ADDR_L5, end - MAX=
_PFN_MEM_ADDR_L5);
> > +                       WARN(true, "Phymem addr 0x%llx overflowed, rese=
rve [0x%llx-0x%llx] directly.",
> > +                            end, MAX_PFN_MEM_ADDR_L5, end);
> > +               }
> > +       }
> > +       if (pgtable_l4_enabled) {
> > +               if (end > MAX_PFN_MEM_ADDR_L4) {
> > +                       memblock_reserve(MAX_PFN_MEM_ADDR_L4, end - MAX=
_PFN_MEM_ADDR_L4);
> > +                       WARN(true, "Phymem addr 0x%llx overflowed, rese=
rve [0x%llx-0x%llx] directly.",
> > +                            end, MAX_PFN_MEM_ADDR_L4, end);
> > +               }
> > +       }
> > +       if (end > MAX_PFN_MEM_ADDR_L3) {
> > +               memblock_reserve(MAX_PFN_MEM_ADDR_L3, end - MAX_PFN_MEM=
_ADDR_L3);
> > +               WARN(true, "Phymem addr 0x%llx overflowed, reserve [0x%=
llx-0x%llx] directly.",
> > +                    end, MAX_PFN_MEM_ADDR_L3, end);
> > +       }
> > +}
> > +
> > +void __init paging_check(void)
> > +{
> > +       phymem_addr_overflow();
> > +}
> > +
> >  void __init paging_init(void)
> >  {
> >         setup_bootmem();
> > --
> > 2.39.2
> >
>
> So the following patch should fix your issue and was posted some time
> ago https://lore.kernel.org/linux-riscv/bdfbed9b-ea04-4415-8416-d6e9d0a64=
3a3@ghiti.fr/T/#me26a82cf32f46cae12e2ea8892a3bc16d4fc37e3.
> I prefer this solution as it does not introduce a bunch of hardcoded
> defines and relies on the already existing memblock API.
>
> Let me know if that's not the case!
I understand that there is no problem with the functionality of this
patch, but since the actual physical memory is lost, we need a Warning
message to avoid confusion about memory disappearance for no reason.

>
> Thanks,
>
> Alex

Thanks,
Yunhui

