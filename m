Return-Path: <linux-kernel+bounces-284969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5D95076F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2843528281B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940319B3DD;
	Tue, 13 Aug 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sWEpHQD7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B723A8CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558877; cv=none; b=bVocPfqAh/zAuYeSLIlEWwyjuhKWjF2+/hZ9CmpOitv2UofScjXOq5/N92740qQKD0Mi84PV+UH/n4lkOc/HepI/ZD16lYCU/eljLJhzN1kxDT/09/Y3rol0XmZisdci6sKkA/sojMFAWukFd63uvse0jgw1LfQPzWw2RcQFsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558877; c=relaxed/simple;
	bh=jwlrSXjBLQKWdX0A2XL95R/moy/IvsHAFZ3R262NAQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqB6bqCCVSiekC2fbUp63bcdN3BrREp6wB/Nirt6t79p8XvXZi5Xie415raFZ/3bDqipxnTSnV6AkKVEbUzbBQQE76p2GC6D8VXFfkHTasDYEkcayyFk6RxWS8n3l+Q9PvhTD4s4hCKofCyjnBtrcQuMYUSOYG3pAV7l6IxSgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sWEpHQD7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so660380166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723558873; x=1724163673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLg3qaDz3DYkzgc2l/zSX+LACtnGKjChhi9vXW+TEm4=;
        b=sWEpHQD7dcPd4NGMM8MD1IgMCtciEfr0bxu6ohlMkdeA8yzYC3uuqHJ+ONYXzAmJrR
         6A7wrAg6bm+kwaHT5Ch3jiItTb26s+ilqHD8dAWqncfEmxIWFpvJBwyxW0f+w/Gr9fmo
         2VDYnq8/J3QaHhhJoZObDumDi33mAPkeXmkZ49/gFV7FYwmJXUXjxyzRWZgHCVaxeU8H
         FzhkX1wz9M53js9PM5sQ40tJ+spl9AWljVWW+qU6DVWDtEYfxwOFJBbE9ZdrBChNMRhS
         xUwwyouAG5rrRlcq1/rPjNBThSVRyY9bRjQgrutoKojxmLnmljMKHjB4CaDObVNUzR5o
         sRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723558873; x=1724163673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLg3qaDz3DYkzgc2l/zSX+LACtnGKjChhi9vXW+TEm4=;
        b=Lkac5H0ANGIAvN+E2R7W5ojw7XSqDolvgZOoVLFUejEBhZ+3i4lL5Eo6UnyyOXtBbF
         7XryJSEcXS+5rMaLxhr2S40I2eQH8xoMyOPnrjtwJu7XpUi2aV7iffrePKBUl0Lk5+/X
         qEpQJchPC59v8dSqtR850u8vZdIzA5pP3rOwToz/lB9uvpzlPJWUACulSz5OuvH96hbW
         okXPzmXA8XYVIzd5wnD8yntAmLyhZ0+L9ihUC+kUf9i1anYTj1lZGu2uSwi9wBCj6l+a
         TKqh5evzzw7NjdDf5IRznlyWCigJj2PzjpHZQFWvNN7NixHKwdyk4LNEHpJ+R5J8OeeP
         5xlA==
X-Forwarded-Encrypted: i=1; AJvYcCW9O19qgyxm3OzU9ysRxvSMD7qGEE6fe93uLTPWenuMUmeVEaSBNMKcbYQE1r9XRcA7LblJOYO0PLTZmnAPkCZT54RfPrt+/5dRf0Kq
X-Gm-Message-State: AOJu0Yz6Aud+aJFPKx6PGXOKz2hQ2lzALkAigoPxw3hnFiHIRFQRvYG8
	+lLVVwQFqxoxVK2fd1fQFuvpTUSIRvjsFRYDu7T1eSxwJlFag4cYZK7e3W8dcaGyIn/370ipfmS
	H33Aec/220k5hqVvqVmQ5u05PwquKCsncoXM93A==
X-Google-Smtp-Source: AGHT+IGYvkuz/0NMkA+x7Byp7o63kQgjk+KYrUpeMfLPvwM/RrhxPduLmLLEIiNlZqrrZMOGlOgVU9jepm7WcpEmNJM=
X-Received: by 2002:a17:906:730a:b0:a75:23bb:6087 with SMTP id
 a640c23a62f3a-a80ed25b2camr304701166b.29.1723558873213; Tue, 13 Aug 2024
 07:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725074155.20565-1-cuiyunhui@bytedance.com>
 <CAHVXubiyJtmiquZ+vmAa+T-nP-pXbAAvf2S=DSCZMk99wuhhpg@mail.gmail.com> <CAEEQ3wkDprXSGmPO8ufYqJMiTjuxoQwFHG+OAtfd9p0ggC8y_g@mail.gmail.com>
In-Reply-To: <CAEEQ3wkDprXSGmPO8ufYqJMiTjuxoQwFHG+OAtfd9p0ggC8y_g@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 13 Aug 2024 16:21:00 +0200
Message-ID: <CAHVXubiaFuTpSAw_1kS_tHFBASNJnT7i=wxv0E556AitQKyfRQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv: mm: add paging_check() before paging_init()
To: yunhui cui <cuiyunhui@bytedance.com>
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

Sorry I was off last week.

On Sat, Aug 3, 2024 at 8:28=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Hi Alex,
>
> On Thu, Aug 1, 2024 at 4:02=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > Hi Yunhui,
> >
> > On Thu, Jul 25, 2024 at 9:42=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > When establishing a linear mapping, the virtual address is obtained
> > > through __va(). If the physical address is too large, such as 1TB, th=
en
> > > the virtual address will overflow in the address space of sv39.
> > > The log is as follows:
> > > [    0.000000] Unable to handle kernel paging request at virtual addr=
ess 000000d97fdf7ad8
> > > [    0.000000] [000000d97fdf7ad8] pgd=3D000000407ff7e801, p4d=3D00000=
0407ff7e801, pud=3D000000407ff7e801
> > > [    0.000000] Unable to handle kernel paging request at virtual addr=
ess 000000d97fdfaff0
> > > [    0.000000] [000000d97fdfaff0] pgd=3D000000407ff7e801, p4d=3D00000=
0407ff7e801, pud=3D000000407ff7e801
> > > ...
> > > [    0.000000] Insufficient stack space to handle exception!
> > > [    0.000000] Task stack:     [0xffffffff81400000..0xffffffff8140400=
0]
> > > [    0.000000] Overflow stack: [0xffffffff80c67370..0xffffffff80c6837=
0]
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W       =
   6.6.3-00133-g60497fad461d-dirty #71
> > > [    0.000000] epc : die_kernel_fault+0x158/0x1c8
> > > [    0.000000]  ra : die_kernel_fault+0x12a/0x1c8
> > > [    0.000000] epc : ffffffff808cde36 ra : ffffffff808cde08 sp : ffff=
ffff813fff80
> > > [    0.000000]  gp : ffffffff815a1678 tp : 0000000000000000 t0 : 0000=
003130386537
> > > [    0.000000]  t1 : 0000000000000031 t2 : 6537666637303430 s0 : ffff=
ffff813fffc0
> > > [    0.000000]  s1 : ffffffff815b0b28 a0 : 0000000000000016 a1 : ffff=
ffff81495298
> > > [    0.000000]  a2 : 0000000000000010 a3 : ffffffff81495298 a4 : 0000=
0000000001fe
> > > [    0.000000]  a5 : 000000d97fdfa000 a6 : ffffffff814250d0 a7 : 0000=
000000000030
> > > [    0.000000]  s2 : 000000d97fdfaff0 s3 : ffffffff81400040 s4 : 0000=
00d97fdfaff0
> > > [    0.000000]  s5 : ffffffff815a0ed0 s6 : 0000000000000000 s7 : 0000=
00008f604390
> > > [    0.000000]  s8 : 0000000000000000 s9 : ffffffffffffffff s10: 0000=
000000000000
> > > [    0.000000]  s11: 0000000000000000 t3 : ffffffff815baa9b t4 : ffff=
ffff815baa9b
> > > [    0.000000]  t5 : ffffffff815baa88 t6 : ffffffff813ffda8
> > > [    0.000000] status: 0000000200000100 badaddr: 000000d97fdfaff0 cau=
se: 000000000000000d
> > > [    0.000000] Kernel panic - not syncing: Kernel stack overflow
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W       =
   6.6.3-00133-g60497fad461d-dirty #71
> > > [    0.000000] Call Trace:
> > > [    0.000000] [<ffffffff800066bc>] dump_backtrace+0x28/0x30
> > > [    0.000000] [<ffffffff808cdac8>] show_stack+0x38/0x44
> > > [    0.000000] [<ffffffff808d9d40>] dump_stack_lvl+0x44/0x5c
> > > [    0.000000] [<ffffffff808d9d70>] dump_stack+0x18/0x20
> > > [    0.000000] [<ffffffff808cdfb6>] panic+0x110/0x2f2
> > > [    0.000000] [<ffffffff80006532>] walk_stackframe+0x0/0x120
> > > [    0.000000] [<ffffffff808cde08>] die_kernel_fault+0x12a/0x1c8
> > > [    0.000000] ---[ end Kernel panic - not syncing: Kernel stack over=
flow ]---
> > >
> > > In other words, the maximum value of the physical address needs to me=
et
> > > Documentation/riscv/vm-layout.rst to ensure that there is no overflow=
.
> > > For sv48/57, the actual virtual address space is huge, so this proble=
m
> > > is generally not triggered, but it is also checked in the code.
> > >
> > > We give a warning for the overflowed physical address region and reve=
rve it
> > > so that the kernel can bringup successfully.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/riscv/include/asm/page.h    |  9 +++++++++
> > >  arch/riscv/include/asm/pgtable.h |  1 +
> > >  arch/riscv/kernel/setup.c        |  1 +
> > >  arch/riscv/mm/init.c             | 30 ++++++++++++++++++++++++++++++
> > >  4 files changed, 41 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/p=
age.h
> > > index 57e887bfa34c..f6c0f6e14ecb 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -38,6 +38,15 @@
> > >   */
> > >  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
> > >  #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
> > > +
> > > +/*
> > > + * See vm-layout.rst, the size of L3 direct mapping of all physical
> > > + * memory 124GB, L4 is 64TB, L5 is 32PB.
> > > + */
> > > +#define MAX_PFN_MEM_ADDR_L5    (0x80000000000000ULL)
> > > +#define MAX_PFN_MEM_ADDR_L4    (0x400000000000ULL)
> > > +#define MAX_PFN_MEM_ADDR_L3    (0x1F00000000ULL)
> > > +
> > >  #else
> > >  #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> > >  #endif /* CONFIG_64BIT */
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index c8e8867c42f6..e4835de5a743 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -915,6 +915,7 @@ extern uintptr_t _dtb_early_pa;
> > >  #endif /* CONFIG_XIP_KERNEL */
> > >  extern u64 satp_mode;
> > >
> > > +void paging_check(void);
> > >  void paging_init(void);
> > >  void misc_mem_init(void);
> > >
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 2a79d4ed2660..366918578544 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -273,6 +273,7 @@ void __init setup_arch(char **cmdline_p)
> > >         parse_early_param();
> > >
> > >         efi_init();
> > > +       paging_check();
> > >         paging_init();
> > >
> > >         /* Parse the ACPI tables for possible boot-time configuration=
 */
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index b0cc28f7595f..aa25dcf8a0ff 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -1482,6 +1482,36 @@ static void __init reserve_crashkernel(void)
> > >         crashk_res.end =3D crash_base + crash_size - 1;
> > >  }
> > >
> > > +static void __init phymem_addr_overflow(void)
> > > +{
> > > +       phys_addr_t end =3D memblock_end_of_DRAM();
> > > +
> > > +       if (pgtable_l5_enabled) {
> > > +               if (end > MAX_PFN_MEM_ADDR_L5) {
> > > +                       memblock_reserve(MAX_PFN_MEM_ADDR_L5, end - M=
AX_PFN_MEM_ADDR_L5);
> > > +                       WARN(true, "Phymem addr 0x%llx overflowed, re=
serve [0x%llx-0x%llx] directly.",
> > > +                            end, MAX_PFN_MEM_ADDR_L5, end);
> > > +               }
> > > +       }
> > > +       if (pgtable_l4_enabled) {
> > > +               if (end > MAX_PFN_MEM_ADDR_L4) {
> > > +                       memblock_reserve(MAX_PFN_MEM_ADDR_L4, end - M=
AX_PFN_MEM_ADDR_L4);
> > > +                       WARN(true, "Phymem addr 0x%llx overflowed, re=
serve [0x%llx-0x%llx] directly.",
> > > +                            end, MAX_PFN_MEM_ADDR_L4, end);
> > > +               }
> > > +       }
> > > +       if (end > MAX_PFN_MEM_ADDR_L3) {
> > > +               memblock_reserve(MAX_PFN_MEM_ADDR_L3, end - MAX_PFN_M=
EM_ADDR_L3);
> > > +               WARN(true, "Phymem addr 0x%llx overflowed, reserve [0=
x%llx-0x%llx] directly.",
> > > +                    end, MAX_PFN_MEM_ADDR_L3, end);
> > > +       }
> > > +}
> > > +
> > > +void __init paging_check(void)
> > > +{
> > > +       phymem_addr_overflow();
> > > +}
> > > +
> > >  void __init paging_init(void)
> > >  {
> > >         setup_bootmem();
> > > --
> > > 2.39.2
> > >
> >
> > So the following patch should fix your issue and was posted some time
> > ago https://lore.kernel.org/linux-riscv/bdfbed9b-ea04-4415-8416-d6e9d0a=
643a3@ghiti.fr/T/#me26a82cf32f46cae12e2ea8892a3bc16d4fc37e3.
> > I prefer this solution as it does not introduce a bunch of hardcoded
> > defines and relies on the already existing memblock API.
> >
> > Let me know if that's not the case!
> I understand that there is no problem with the functionality of this
> patch, but since the actual physical memory is lost, we need a Warning
> message to avoid confusion about memory disappearance for no reason.

Yes, you're right, we should advertise people when something like this
happens. What do you think of the following instead?

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index de8a608eec1a..29c8e321eadc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -254,8 +254,11 @@ static void __init setup_bootmem(void)
         */
        if (IS_ENABLED(CONFIG_64BIT)) {
                max_mapped_addr =3D __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
-               memblock_cap_memory_range(phys_ram_base,
-                                         max_mapped_addr - phys_ram_base);
+               if (memblock_end_of_DRAM() > max_mapped_addr) {
+                       memblock_cap_memory_range(phys_ram_base,
+                                                 max_mapped_addr -
phys_ram_base);
+                       pr_warn("Physical memory overflows the linear
mapping size: region above 0x%llx removed", max_mapped_addr);
+               }
        }

        /*

Thanks,

Alex

>
> >
> > Thanks,
> >
> > Alex
>
> Thanks,
> Yunhui

