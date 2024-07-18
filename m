Return-Path: <linux-kernel+bounces-255971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15304934734
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A1B22427
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85973FBB3;
	Thu, 18 Jul 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz9N1vSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66F3A1BF;
	Thu, 18 Jul 2024 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277493; cv=none; b=PW+lug9DWuO+Sk2yCMnlDlk5xJBXNd4noPEZMQ9aqzqL2JGyghW4uc/aVSsFXYAaKUCFnKmT+RuTJdQ0AB7umIP9K9mlg2/Gha1sNEHsyJlHBE2gPr4G9wl39TVBJBT0/e+c9jwjvePltuqRAFG6vwHGkF/ER36LGn7scO0h1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277493; c=relaxed/simple;
	bh=/ZqKPQIlany1MGWZzJeQ3lE3vl+Kxeftfp8j3rgKdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOuqmOXi2/O3ZVxXEcxhQIa1OaeHGklZysg4fKCm0P7Q/kb7GItcnNDoAZxtntSryB+XiqjOrfd/As/1VCbWzUCpvgHjLMv1boUKLj1TAJU1FXQzcwxznRFpX2oNA5wjyqf4PrXjoibblYXpG6zJmSAWgry5yA1h+wYKQYtUvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz9N1vSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2497C4AF0B;
	Thu, 18 Jul 2024 04:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721277493;
	bh=/ZqKPQIlany1MGWZzJeQ3lE3vl+Kxeftfp8j3rgKdU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qz9N1vSD98uNg3eY4FBHtj0mg3xxFUHsA57tG9mSE2HX+XkhpdC8/MZH+U2N/BxwE
	 RjyNQ6jnsZgylAYoyqI6cCTf0he6OuufJeQOdWRqgUfoD7hTnW4K+eQO6XwyDPRdG3
	 bj2pnzdGyNrLtpj7e6bMxancAA7FN2f6dnNfTqSB6GiotWw5xhiA61RwbZ3l5cp0wY
	 ALQCQ+LcrsFDdujAXVzyRpbt6MKUVQ6T5HcBz6Es2rhQi9PGg87Lm/69M4Gvhajwvs
	 5jMoxfkxhX9zOpc3zSClTWgKKjEl5zuj6eSTzmscPwd+3OJarrBbNqyX33FMqs14Av
	 nV4hzzsCAWBTw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eecb63de15so5036501fa.0;
        Wed, 17 Jul 2024 21:38:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1Y5FUNBzR95VKcBPc4wEH2gZl65HLvtQeEHKQN8Z9PmO20cv1yAleYZ7bjaUpyHiH5VlQ+ful/u/rndok/U2KjTIAccpxQhUisy3+U4UZDqLmrYLCsRCgkqeZsBeUqhAfkKOK/DCh
X-Gm-Message-State: AOJu0Yzc99sRD42MMfiJJ1ra9cJ+y8cSmGsX7J5KH5a0j+acuK1unxe7
	jyVaprB9T2E6Dhay8EbwJ4+Py198I+jVYixWhc62tHIGU4OT8TSLs4s0H5y1kVafFlo56a9aSjk
	ASGsFiKTLM5UwNELUxn+Jj5Zd9hk=
X-Google-Smtp-Source: AGHT+IHCgRvKwVNXiQyx13mIIzN+SOrxe4KcPjny4mjQwPYB2CBurwjcf0ymMJtD823+iEDmcEOY5Qw2qOjPfMmkWAU=
X-Received: by 2002:a05:651c:19a3:b0:2ec:5fe1:c762 with SMTP id
 38308e7fff4ca-2ef05d60c13mr8802571fa.46.1721277491053; Wed, 17 Jul 2024
 21:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033440.26506-1-zhangtianyang@loongson.cn>
 <CAAhV-H5BKzrKFrN6JzdDXPsqXA21P3RWE-SOp2oVdPuN4kjoGA@mail.gmail.com> <f9d2f0cf-3b99-35d5-508a-0b134357283c@loongson.cn>
In-Reply-To: <f9d2f0cf-3b99-35d5-508a-0b134357283c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Jul 2024 12:37:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Eej7caidqPJUwY4hMpDA6TXH0nY1ppfvL8piAvEF2rg@mail.gmail.com>
Message-ID: <CAAhV-H5Eej7caidqPJUwY4hMpDA6TXH0nY1ppfvL8piAvEF2rg@mail.gmail.com>
Subject: Re: [PATCH V5] LoongArch: Add AVEC irqchip support
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn, kernel@xen0n.name, 
	tglx@linutronix.de, jiaxun.yang@flygoat.com, gaoliang@loongson.cn, 
	wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn, 
	mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org, 
	maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn, 
	nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn, 
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:12=E2=80=AFAM Tianyang Zhang
<zhangtianyang@loongson.cn> wrote:
>
> Hi , Huacai
>
> =E5=9C=A8 2024/7/16 =E4=B8=8B=E5=8D=885:24, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Tianyang,
> >
> > I'm fixing potential bugs, except NR_IRQS I found some other issues
> > which need your double check. Please see below carefully.
> >
> > On Mon, Jul 15, 2024 at 11:34=E2=80=AFAM Tianyang Zhang
> > <zhangtianyang@loongson.cn> wrote:
> >> Introduce the advanced extended interrupt controllers. This feature wi=
ll
> >> allow each core to have 256 independent interrupt vectors and MSI
> >> interrupts can be independently routed to any vector on any CPU.
> >>
> >> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
> >> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> >> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
> >> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
> >> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> >> ---
> >>   .../arch/loongarch/irq-chip-model.rst         |  33 ++
> >>   .../zh_CN/arch/loongarch/irq-chip-model.rst   |  37 +-
> >>   arch/loongarch/Kconfig                        |   1 +
> >>   arch/loongarch/include/asm/cpu-features.h     |   1 +
> >>   arch/loongarch/include/asm/cpu.h              |   2 +
> >>   arch/loongarch/include/asm/hardirq.h          |   3 +-
> >>   arch/loongarch/include/asm/irq.h              |  23 +-
> >>   arch/loongarch/include/asm/loongarch.h        |  18 +-
> >>   arch/loongarch/include/asm/smp.h              |   2 +
> >>   arch/loongarch/kernel/cpu-probe.c             |   3 +-
> >>   arch/loongarch/kernel/paravirt.c              |   5 +
> >>   arch/loongarch/kernel/smp.c                   |   5 +
> >>   drivers/irqchip/Makefile                      |   2 +-
> >>   drivers/irqchip/irq-loongarch-avec.c          | 433 ++++++++++++++++=
++
> >>   drivers/irqchip/irq-loongarch-cpu.c           |   4 +-
> >>   drivers/irqchip/irq-loongson-eiointc.c        |   3 +
> >>   drivers/irqchip/irq-loongson-pch-msi.c        |  42 +-
> >>   17 files changed, 603 insertions(+), 14 deletions(-)
> >>   create mode 100644 drivers/irqchip/irq-loongarch-avec.c
> >>
> >> Changes log:
> >>   V0->V1:
> >>           1.Modified some formats and declarations
> >>           2.Removed kmalloc/kfree when adding affinity related data to=
 pending_list,
> >>             and used moving tag to replace the original behavior
> >>           3.Adjusted the process that enables AVEC interrupts, now it =
is at the end of all processes
> >>           4.Removed CPUHP related callbacks, now irq_matrix_online/irq=
_matrix_offline is completed in start_secondary/loongson_cpu_disable
> >>           5.Adjusted compatibility issues for CONFIG_ACPI
> >>           6.About question:
> >>           > irr =3D csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);
> >>           > should be good enough, no?
> >>           csr_read64 was built-in as __csrrd_d, it doesn't seem to sup=
port variables as parameters
> >>           >>>>
> >>           drivers/irqchip/irq-loongarch-avec.c: In function =E2=80=98c=
omplete_irq_moving=E2=80=99:
> >>           ./arch/loongarch/include/asm/loongarch.h:164:25: error: inva=
lid argument to built-in function
> >>             164 | #define csr_read64(reg) __csrrd_d(reg)
> >>                 |                         ^~~~~~~~~
> >>           drivers/irqchip/irq-loongarch-avec.c:170:23: note: in expans=
ion of macro =E2=80=98csr_read64=E2=80=99
> >>             170 |                 irr =3D csr_read64(LOONGARCH_CSR_IRR=
_BASE + vector / VECTORS_PER_REG);
> >>                 |                       ^~~~~~~~~~
> >>           >>>>
> >>           So we have temporarily retained the previous implementation.
> >>
> >>   V1->V2:
> >>           Fixed up coding style. Made on/offline functions void
> >>           Added compatibility when CONFIG_SMP is turned off
> >>
> >>   V2->V3:
> >>          Squash two patches into one
> >>
> >>   V3->V4:
> >>          Update NR_IRQS
> >>          Update Register's name
> >>          Fixed up coding style
> >>   V4->V5:
> >>          Retain feature CPUCFG1_MSGINT
> >>          Fixed up coding style
> >>          Delete the test code introduced by V4, and now msi msg addres=
s still uses the 32-bit address
> >>
> >> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documen=
tation/arch/loongarch/irq-chip-model.rst
> >> index 7988f4192363..a90c78c8e5bb 100644
> >> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> >> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> >> @@ -85,6 +85,39 @@ to CPUINTC directly::
> >>       | Devices |
> >>       +---------+
> >>
> >> +Advanced Extended IRQ model
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >> +
> >> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer in=
terrupt go
> >> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI inte=
rrupts go to AVEC,
> >> +and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LP=
C and gathered
> >> +by EIOINTC, and then go to CPUINTC directly::
> >> +
> >> + +-----+     +--------------------------+     +-------+
> >> + | IPI | --> |           CPUINTC        | <-- | Timer |
> >> + +-----+     +--------------------------+     +-------+
> >> +              ^        ^             ^
> >> +              |        |             |
> >> +      +--------+  +---------+ +---------+     +-------+
> >> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
> >> +      +--------+  +---------+ +---------+     +-------+
> >> +           ^            ^
> >> +           |            |
> >> +         +---------+  +---------+
> >> +         | PCH-MSI |  | PCH-PIC |
> >> +         +---------+  +---------+
> >> +            ^          ^       ^
> >> +            |          |       |
> >> +    +---------+ +---------+ +---------+
> >> +    | Devices | | PCH-LPC | | Devices |
> >> +    +---------+ +---------+ +---------+
> >> +                     ^
> >> +                     |
> >> +                +---------+
> >> +                | Devices |
> >> +                +---------+
> >> +
> >> +
> >>   ACPI-related definitions
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>
> >> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-=
model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.=
rst
> >> index f1e9ab18206c..b54567380c90 100644
> >> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.r=
st
> >> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.r=
st
> >> @@ -9,9 +9,8 @@
> >>   LoongArch=E7=9A=84IRQ=E8=8A=AF=E7=89=87=E6=A8=A1=E5=9E=8B=EF=BC=88=
=E5=B1=82=E7=BA=A7=E5=85=B3=E7=B3=BB=EF=BC=89
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> -=E7=9B=AE=E5=89=8D=EF=BC=8C=E5=9F=BA=E4=BA=8ELoongArch=E7=9A=84=E5=A4=
=84=E7=90=86=E5=99=A8=EF=BC=88=E5=A6=82=E9=BE=99=E8=8A=AF3A5000=EF=BC=89=E5=
=8F=AA=E8=83=BD=E4=B8=8ELS7A=E8=8A=AF=E7=89=87=E7=BB=84=E9=85=8D=E5=90=88=
=E5=B7=A5=E4=BD=9C=E3=80=82LoongArch=E8=AE=A1=E7=AE=97=E6=9C=BA
> >> -=E4=B8=AD=E7=9A=84=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=
=88=E5=8D=B3IRQ=E8=8A=AF=E7=89=87=EF=BC=89=E5=8C=85=E6=8B=ACCPUINTC=EF=BC=
=88CPU Core Interrupt Controller=EF=BC=89=E3=80=81LIOINTC=EF=BC=88
> >> -Legacy I/O Interrupt Controller=EF=BC=89=E3=80=81EIOINTC=EF=BC=88Exte=
nded I/O Interrupt Controller=EF=BC=89=E3=80=81
> >> +LoongArch=E8=AE=A1=E7=AE=97=E6=9C=BA=E4=B8=AD=E7=9A=84=E4=B8=AD=E6=96=
=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=88=E5=8D=B3IRQ=E8=8A=AF=E7=89=87=EF=BC=
=89=E5=8C=85=E6=8B=ACCPUINTC=EF=BC=88CPU Core Interrupt Controller=EF=BC=89=
=E3=80=81
> >> +LIOINTC=EF=BC=88Legacy I/O Interrupt Controller=EF=BC=89=E3=80=81EIOI=
NTC=EF=BC=88Extended I/O Interrupt Controller=EF=BC=89=E3=80=81
> >>   HTVECINTC=EF=BC=88Hyper-Transport Vector Interrupt Controller=EF=BC=
=89=E3=80=81PCH-PIC=EF=BC=88LS7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84=E4=B8=
=BB=E4=B8=AD
> >>   =E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=81PCH-LPC=EF=BC=
=88LS7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84LPC=E4=B8=AD=E6=96=AD=E6=8E=A7=
=E5=88=B6=E5=99=A8=EF=BC=89=E5=92=8CPCH-MSI=EF=BC=88MSI=E4=B8=AD=E6=96=AD=
=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=82
> >>
> >> @@ -87,6 +86,38 @@ PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=AB=
EIOINTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=
=8E=A5=E5=88=B0=E8=BE=BECPUINTC::
> >>       | Devices |
> >>       +---------+
> >>
> >> +=E9=AB=98=E7=BA=A7=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=
=8CIPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=
=9C=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=
=81=E5=88=B0CPUINTC=EF=BC=8C
> >> +CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=
=91=E9=80=81=E5=88=B0LIOINTC=EF=BC=8CPCH-MSI=E4=B8=AD=E6=96=AD=E5=8F=91=E9=
=80=81=E5=88=B0AVEC=EF=BC=8C=E8=80=8C=E5=90=8E=E9=80=9A=E8=BF=87AVEC=E9=80=
=81=E8=BE=BECPUINTC=EF=BC=8C=E8=80=8C
> >> +=E5=85=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=
=AD=E6=96=AD=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=
=E8=BF=9E=E6=8E=A5=E7=9A=84PCH-PIC/PCH-LPC=EF=BC=8C=E7=84=B6=E5=90=8E=E7=94=
=B1EIOINTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4
> >> +=E6=8E=A5=E5=88=B0=E8=BE=BECPUINTC::
> >> +
> >> + +-----+     +--------------------------+     +-------+
> >> + | IPI | --> |           CPUINTC        | <-- | Timer |
> >> + +-----+     +--------------------------+     +-------+
> >> +              ^        ^             ^
> >> +              |        |             |
> >> +      +--------+  +---------+ +---------+     +-------+
> >> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
> >> +      +--------+  +---------+ +---------+     +-------+
> >> +              ^        ^
> >> +              |        |
> >> +      +---------+  +-------------+
> >> +      | PCH-MSI |  |   PCH-PIC   |
> >> +      +---------+  +-------------+
> >> +            ^          ^       ^
> >> +            |          |       |
> >> +    +---------+ +---------+ +---------+
> >> +    | Devices | | PCH-LPC | | Devices |
> >> +    +---------+ +---------+ +---------+
> >> +                     ^
> >> +                     |
> >> +                +---------+
> >> +                | Devices |
> >> +                +---------+
> >> +
> >>   ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index e38139c576ee..a66e49b5a68c 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -83,6 +83,7 @@ config LOONGARCH
> >>          select GENERIC_ENTRY
> >>          select GENERIC_GETTIMEOFDAY
> >>          select GENERIC_IOREMAP if !ARCH_IOREMAP
> >> +       select GENERIC_IRQ_MATRIX_ALLOCATOR
> >>          select GENERIC_IRQ_MULTI_HANDLER
> >>          select GENERIC_IRQ_PROBE
> >>          select GENERIC_IRQ_SHOW
> >> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarc=
h/include/asm/cpu-features.h
> >> index 2eafe6a6aca8..16a716f88a5c 100644
> >> --- a/arch/loongarch/include/asm/cpu-features.h
> >> +++ b/arch/loongarch/include/asm/cpu-features.h
> >> @@ -65,5 +65,6 @@
> >>   #define cpu_has_guestid                cpu_opt(LOONGARCH_CPU_GUESTID=
)
> >>   #define cpu_has_hypervisor     cpu_opt(LOONGARCH_CPU_HYPERVISOR)
> >>   #define cpu_has_ptw            cpu_opt(LOONGARCH_CPU_PTW)
> >> +#define cpu_has_avecint                cpu_opt(LOONGARCH_CPU_AVECINT)
> >>
> >>   #endif /* __ASM_CPU_FEATURES_H */
> >> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include=
/asm/cpu.h
> >> index 48b9f7168bcc..843f9c4ec980 100644
> >> --- a/arch/loongarch/include/asm/cpu.h
> >> +++ b/arch/loongarch/include/asm/cpu.h
> >> @@ -99,6 +99,7 @@ enum cpu_type_enum {
> >>   #define CPU_FEATURE_GUESTID            24      /* CPU has GuestID fe=
ature */
> >>   #define CPU_FEATURE_HYPERVISOR         25      /* CPU has hypervisor=
 (running in VM) */
> >>   #define CPU_FEATURE_PTW                        26      /* CPU has ha=
rdware page table walker */
> >> +#define CPU_FEATURE_AVECINT            27      /* CPU has avec interr=
upt */
> >>
> >>   #define LOONGARCH_CPU_CPUCFG           BIT_ULL(CPU_FEATURE_CPUCFG)
> >>   #define LOONGARCH_CPU_LAM              BIT_ULL(CPU_FEATURE_LAM)
> >> @@ -127,5 +128,6 @@ enum cpu_type_enum {
> >>   #define LOONGARCH_CPU_GUESTID          BIT_ULL(CPU_FEATURE_GUESTID)
> >>   #define LOONGARCH_CPU_HYPERVISOR       BIT_ULL(CPU_FEATURE_HYPERVISO=
R)
> >>   #define LOONGARCH_CPU_PTW              BIT_ULL(CPU_FEATURE_PTW)
> >> +#define LOONGARCH_CPU_AVECINT          BIT_ULL(CPU_FEATURE_AVECINT)
> >>
> >>   #endif /* _ASM_CPU_H */
> >> diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/inc=
lude/asm/hardirq.h
> >> index d41138abcf26..b09891e4a4b2 100644
> >> --- a/arch/loongarch/include/asm/hardirq.h
> >> +++ b/arch/loongarch/include/asm/hardirq.h
> >> @@ -12,11 +12,12 @@
> >>   extern void ack_bad_irq(unsigned int irq);
> >>   #define ack_bad_irq ack_bad_irq
> >>
> >> -#define NR_IPI 2
> >> +#define NR_IPI 3
> >>
> >>   enum ipi_msg_type {
> >>          IPI_RESCHEDULE,
> >>          IPI_CALL_FUNCTION,
> >> +       IPI_CLEAR_VECT,
> >>   };
> >>
> >>   typedef struct {
> >> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include=
/asm/irq.h
> >> index 480418bc5071..899e6f9a9eaa 100644
> >> --- a/arch/loongarch/include/asm/irq.h
> >> +++ b/arch/loongarch/include/asm/irq.h
> >> @@ -39,11 +39,22 @@ void spurious_interrupt(void);
> >>
> >>   #define NR_IRQS_LEGACY 16
> >>
> >> +/*
> >> + * 256 vectors Map:
> >> + *
> >> + * 0 - 15: mapping legacy IPs, e.g. IP0-12.
> >> + * 16 - 255: mapping a vector for external IRQ.
> >> + *
> >> + */
> >> +#define NR_VECTORS             256
> >> +#define IRQ_MATRIX_BITS                NR_VECTORS
> >> +#define NR_LEGACY_VECTORS      16
> >> +
> >>   #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrac=
e
> >>   void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int =
exclude_cpu);
> >>
> >>   #define MAX_IO_PICS 2
> >> -#define NR_IRQS        (64 + (256 * MAX_IO_PICS))
> >> +#define NR_IRQS        ((64 + (64 * MAX_IO_PICS)) + NR_VECTORS * NR_C=
PUS)
> >>
> >>   struct acpi_vector_group {
> >>          int node;
> >> @@ -65,7 +76,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PIC=
S];
> >>   #define LOONGSON_LPC_LAST_IRQ          (LOONGSON_LPC_IRQ_BASE + 15)
> >>
> >>   #define LOONGSON_CPU_IRQ_BASE          16
> >> -#define LOONGSON_CPU_LAST_IRQ          (LOONGSON_CPU_IRQ_BASE + 14)
> >> +#define LOONGSON_CPU_LAST_IRQ          (LOONGSON_CPU_IRQ_BASE + 15)
> >>
> >>   #define LOONGSON_PCH_IRQ_BASE          64
> >>   #define LOONGSON_PCH_ACPI_IRQ          (LOONGSON_PCH_IRQ_BASE + 47)
> >> @@ -101,6 +112,14 @@ int pch_msi_acpi_init(struct irq_domain *parent,
> >>                                          struct acpi_madt_msi_pic *acp=
i_pchmsi);
> >>   int pch_pic_acpi_init(struct irq_domain *parent,
> >>                                          struct acpi_madt_bio_pic *acp=
i_pchpic);
> >> +
> >> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
> >> +               struct acpi_madt_msi_pic *pch_msi_entry);
> >> +int __init loongarch_avec_acpi_init(struct irq_domain *parent);
> >> +void complete_irq_moving(void);
> >> +void loongarch_avec_offline_cpu(unsigned int cpu);
> >> +void loongarch_avec_online_cpu(unsigned int cpu);
> > Maybe it is better to use cpuhotplug callbacks, which is similar to
> > this method in irq-loongson-eiointc.c
> >
> > cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_EIOINTC_STARTING,
> >                                            "irqchip/loongarch/eiointc:s=
tarting",
> >                                            eiointc_router_init, NULL);
> >
> Okay, I will adapt to this in the next version
Unnecessary, I have completed here and you can test with it.
https://github.com/chenhuacai/linux/commits/loongarch-next

If no problems, please submit the last patch as V6, otherwise please
feedback to me.

Huacai

> >> +
> >>   int find_pch_pic(u32 gsi);
> >>   struct fwnode_handle *get_pch_msi_handle(int pci_segment);
> >>
> >> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/i=
nclude/asm/loongarch.h
> >> index eb09adda54b7..c21dc52338e3 100644
> >> --- a/arch/loongarch/include/asm/loongarch.h
> >> +++ b/arch/loongarch/include/asm/loongarch.h
> >> @@ -252,8 +252,8 @@
> >>   #define  CSR_ESTAT_EXC_WIDTH           6
> >>   #define  CSR_ESTAT_EXC                 (_ULCAST_(0x3f) << CSR_ESTAT_=
EXC_SHIFT)
> >>   #define  CSR_ESTAT_IS_SHIFT            0
> >> -#define  CSR_ESTAT_IS_WIDTH            14
> >> -#define  CSR_ESTAT_IS                  (_ULCAST_(0x3fff) << CSR_ESTAT=
_IS_SHIFT)
> >> +#define  CSR_ESTAT_IS_WIDTH            15
> >> +#define  CSR_ESTAT_IS                  (_ULCAST_(0x7fff) << CSR_ESTAT=
_IS_SHIFT)
> >>
> >>   #define LOONGARCH_CSR_ERA              0x6     /* ERA */
> >>
> >> @@ -999,10 +999,17 @@
> >>   #define CSR_FWPC_SKIP_SHIFT            16
> >>   #define CSR_FWPC_SKIP                  (_ULCAST_(1) << CSR_FWPC_SKIP=
_SHIFT)
> >>
> >> +#define LOONGARCH_CSR_ISR0             0xa0
> >> +#define LOONGARCH_CSR_ISR1             0xa1
> >> +#define LOONGARCH_CSR_ISR2             0xa2
> >> +#define LOONGARCH_CSR_ISR3             0xa3
> >> +
> >> +#define        LOONGARCH_CSR_IRR               0xa4
> >> +
> >>   /*
> >>    * CSR_ECFG IM
> >>    */
> >> -#define ECFG0_IM               0x00001fff
> >> +#define ECFG0_IM               0x00005fff
> >>   #define ECFGB_SIP0             0
> >>   #define ECFGF_SIP0             (_ULCAST_(1) << ECFGB_SIP0)
> >>   #define ECFGB_SIP1             1
> >> @@ -1045,6 +1052,7 @@
> >>   #define  IOCSRF_EIODECODE              BIT_ULL(9)
> >>   #define  IOCSRF_FLATMODE               BIT_ULL(10)
> >>   #define  IOCSRF_VM                     BIT_ULL(11)
> >> +#define  IOCSRF_AVEC                   BIT_ULL(15)
> >>
> >>   #define LOONGARCH_IOCSR_VENDOR         0x10
> >>
> >> @@ -1055,6 +1063,7 @@
> >>   #define LOONGARCH_IOCSR_MISC_FUNC      0x420
> >>   #define  IOCSR_MISC_FUNC_TIMER_RESET   BIT_ULL(21)
> >>   #define  IOCSR_MISC_FUNC_EXT_IOI_EN    BIT_ULL(48)
> >> +#define  IOCSR_MISC_FUNC_AVEC_EN       BIT_ULL(51)
> >>
> >>   #define LOONGARCH_IOCSR_CPUTEMP                0x428
> >>
> >> @@ -1375,9 +1384,10 @@ __BUILD_CSR_OP(tlbidx)
> >>   #define INT_TI         11      /* Timer */
> >>   #define INT_IPI                12
> >>   #define INT_NMI                13
> >> +#define INT_AVEC       14
> >>
> >>   /* ExcCodes corresponding to interrupts */
> >> -#define EXCCODE_INT_NUM                (INT_NMI + 1)
> >> +#define EXCCODE_INT_NUM                (INT_AVEC + 1)
> >>   #define EXCCODE_INT_START      64
> >>   #define EXCCODE_INT_END                (EXCCODE_INT_START + EXCCODE_=
INT_NUM - 1)
> >>
> >> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include=
/asm/smp.h
> >> index 278700cfee88..2399004596a3 100644
> >> --- a/arch/loongarch/include/asm/smp.h
> >> +++ b/arch/loongarch/include/asm/smp.h
> >> @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
> >>   #define ACTION_BOOT_CPU        0
> >>   #define ACTION_RESCHEDULE      1
> >>   #define ACTION_CALL_FUNCTION   2
> >> +#define ACTION_CLEAR_VECT      3
> >>   #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
> >>   #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
> >>   #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
> >> +#define SMP_CLEAR_VECT         BIT(ACTION_CLEAR_VECT)
> >>
> >>   struct secondary_data {
> >>          unsigned long stack;
> >> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel=
/cpu-probe.c
> >> index 55320813ee08..3b2e72e8f9bd 100644
> >> --- a/arch/loongarch/kernel/cpu-probe.c
> >> +++ b/arch/loongarch/kernel/cpu-probe.c
> >> @@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loonga=
rch *c)
> >>                  elf_hwcap |=3D HWCAP_LOONGARCH_CRC32;
> >>          }
> >>
> >> -
> >>          config =3D read_cpucfg(LOONGARCH_CPUCFG2);
> >>          if (config & CPUCFG2_LAM) {
> >>                  c->options |=3D LOONGARCH_CPU_LAM;
> >> @@ -176,6 +175,8 @@ static void cpu_probe_common(struct cpuinfo_loonga=
rch *c)
> >>                  c->options |=3D LOONGARCH_CPU_EIODECODE;
> >>          if (config & IOCSRF_VM)
> >>                  c->options |=3D LOONGARCH_CPU_HYPERVISOR;
> >> +       if (config & IOCSRF_AVEC)
> >> +               c->options |=3D LOONGARCH_CPU_AVECINT;
> >>
> >>          config =3D csr_read32(LOONGARCH_CSR_ASID);
> >>          config =3D (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
> >> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/=
paravirt.c
> >> index 1633ed4f692f..834c99cb4df4 100644
> >> --- a/arch/loongarch/kernel/paravirt.c
> >> +++ b/arch/loongarch/kernel/paravirt.c
> >> @@ -97,6 +97,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *=
dev)
> >>                  info->ipi_irqs[IPI_CALL_FUNCTION]++;
> >>          }
> >>
> >> +       if (action & SMP_CLEAR_VECT) {
> >> +               complete_irq_moving();
> >> +               info->ipi_irqs[IPI_CLEAR_VECT]++;
> >> +       }
> >> +
> >>          return IRQ_HANDLED;
> >>   }
> >>
> >> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> >> index 0dfe2388ef41..6dfedef306f3 100644
> >> --- a/arch/loongarch/kernel/smp.c
> >> +++ b/arch/loongarch/kernel/smp.c
> >> @@ -234,6 +234,9 @@ static irqreturn_t loongson_ipi_interrupt(int irq,=
 void *dev)
> >>                  per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
> >>          }
> >>
> >> +       if (action & SMP_CLEAR_VECT)
> >> +               complete_irq_moving();
> >> +
> >>          return IRQ_HANDLED;
> >>   }
> >>
> >> @@ -388,6 +391,7 @@ int loongson_cpu_disable(void)
> >>          irq_migrate_all_off_this_cpu();
> >>          clear_csr_ecfg(ECFG0_IM);
> >>          local_irq_restore(flags);
> >> +       loongarch_avec_offline_cpu(cpu);
> >>          local_flush_tlb_all();
> >>
> >>          return 0;
> >> @@ -566,6 +570,7 @@ asmlinkage void start_secondary(void)
> >>           * early is dangerous.
> >>           */
> >>          WARN_ON_ONCE(!irqs_disabled());
> >> +       loongarch_avec_online_cpu(cpu);
> >>          loongson_smp_finish();
> >>
> >>          cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> >> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >> index 9f6f88274bec..1062e713cea4 100644
> >> --- a/drivers/irqchip/Makefile
> >> +++ b/drivers/irqchip/Makefile
> >> @@ -109,7 +109,7 @@ obj-$(CONFIG_LS1X_IRQ)                      +=3D i=
rq-ls1x.o
> >>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)      +=3D irq-ti-sci-intr.o
> >>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)      +=3D irq-ti-sci-inta.o
> >>   obj-$(CONFIG_TI_PRUSS_INTC)            +=3D irq-pruss-intc.o
> >> -obj-$(CONFIG_IRQ_LOONGARCH_CPU)                +=3D irq-loongarch-cpu=
.o
> >> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)                +=3D irq-loongarch-cpu=
.o irq-loongarch-avec.o
> >>   obj-$(CONFIG_LOONGSON_LIOINTC)         +=3D irq-loongson-liointc.o
> >>   obj-$(CONFIG_LOONGSON_EIOINTC)         +=3D irq-loongson-eiointc.o
> >>   obj-$(CONFIG_LOONGSON_HTPIC)           +=3D irq-loongson-htpic.o
> >> diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/ir=
q-loongarch-avec.c
> >> new file mode 100644
> >> index 000000000000..744f46638def
> >> --- /dev/null
> >> +++ b/drivers/irqchip/irq-loongarch-avec.c
> >> @@ -0,0 +1,433 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2020-2024 Loongson Technologies, Inc.
> >> + */
> >> +
> >> +#include <linux/cpuhotplug.h>
> >> +#include <linux/init.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/irq.h>
> >> +#include <linux/irqchip.h>
> >> +#include <linux/irqchip/chained_irq.h>
> >> +#include <linux/irqdomain.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/msi.h>
> >> +#include <linux/radix-tree.h>
> >> +#include <linux/spinlock.h>
> >> +
> >> +#include <asm/loongarch.h>
> >> +#include <asm/setup.h>
> >> +
> >> +#define VECTORS_PER_REG                64
> >> +#define IRR_INVALID_MASK       0x80000000UL
> >> +#define IRR_VECTOR_MASK                0xffUL
> >> +#define AVEC_MSG_OFFSET                0x100000
> >> +
> >> +static phys_addr_t msi_base_v2;
> >> +static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
> >> +
> >> +#ifdef CONFIG_SMP
> >> +struct pending_list {
> >> +       struct list_head        head;
> >> +};
> >> +
> >> +static DEFINE_PER_CPU(struct pending_list, pending_list);
> >> +static struct cpumask intersect_mask;
> >> +#endif
> >> +
> >> +struct loongarch_avec_chip {
> >> +       struct fwnode_handle    *fwnode;
> >> +       struct irq_domain       *domain;
> >> +       struct irq_matrix       *vector_matrix;
> >> +       raw_spinlock_t          lock;
> >> +};
> >> +
> >> +static struct loongarch_avec_chip loongarch_avec;
> >> +
> >> +struct loongarch_avec_data {
> >> +       struct list_head        entry;
> >> +       unsigned int            cpu;
> >> +       unsigned int            vec;
> >> +       unsigned int            prev_cpu;
> >> +       unsigned int            prev_vec;
> >> +       unsigned int            moving          : 1,
> >> +                               managed         : 1;
> >> +};
> >> +
> >> +static inline void loongarch_avec_ack_irq(struct irq_data *d)
> >> +{
> >> +}
> >> +
> >> +static inline void loongarch_avec_unmask_irq(struct irq_data *d)
> >> +{
> >> +}
> >> +
> >> +static inline void loongarch_avec_mask_irq(struct irq_data *d)
> >> +{
> >> +}
> >> +
> >> +#ifdef CONFIG_SMP
> >> +static inline void pending_list_init(int cpu)
> >> +{
> >> +       struct pending_list *plist =3D per_cpu_ptr(&pending_list, cpu)=
;
> >> +
> >> +       INIT_LIST_HEAD(&plist->head);
> >> +}
> >> +
> >> +static void loongarch_avec_sync(struct loongarch_avec_data *adata)
> >> +{
> >> +       struct pending_list *plist;
> >> +
> >> +       if (cpu_online(adata->prev_cpu)) {
> >> +               plist =3D per_cpu_ptr(&pending_list, adata->prev_cpu);
> >> +               list_add_tail(&adata->entry, &plist->head);
> >> +               adata->moving =3D true;
> >> +               mp_ops.send_ipi_single(adata->prev_cpu, ACTION_CLEAR_V=
ECT);
> >> +       }
> >> +}
> >> +
> >> +static int loongarch_avec_set_affinity(struct irq_data *data, const s=
truct cpumask *dest,
> >> +                                      bool force)
> >> +{
> >> +       struct loongarch_avec_data *adata;
> >> +       unsigned int cpu, vector;
> >> +       unsigned long flags;
> >> +       int ret;
> >> +
> >> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> >> +       adata =3D irq_data_get_irq_chip_data(data);
> >> +
> >> +       if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(a=
data->cpu, dest)) {
> >> +               raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags=
);
> >> +               return 0;
> >> +       }
> >> +       if (adata->moving)
> >> +               return -EBUSY;
> >> +
> >> +       cpumask_and(&intersect_mask, dest, cpu_online_mask);
> >> +
> >> +       ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix, &inters=
ect_mask, false, &cpu);
> >> +       if (ret < 0) {
> >> +               raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags=
);
> >> +               return ret;
> >> +       }
> >> +       vector =3D ret;
> >> +       adata->cpu =3D cpu;
> >> +       adata->vec =3D vector;
> >> +       per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_data_to_d=
esc(data);
> >> +       loongarch_avec_sync(adata);
> >> +
> >> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> >> +       irq_data_update_effective_affinity(data, cpumask_of(cpu));
> >> +
> >> +       return IRQ_SET_MASK_OK;
> >> +}
> >> +
> >> +void complete_irq_moving(void)
> >> +{
> >> +       struct pending_list *plist =3D this_cpu_ptr(&pending_list);
> >> +       struct loongarch_avec_data *adata, *tmp;
> >> +       int cpu, vector, bias;
> >> +       u64 isr;
> >> +
> >> +       raw_spin_lock(&loongarch_avec.lock);
> >> +
> >> +       list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
> >> +               cpu =3D adata->prev_cpu;
> >> +               vector =3D adata->prev_vec;
> >> +               bias =3D vector / VECTORS_PER_REG;
> >> +               switch (bias) {
> >> +               case 0:
> >> +                       isr =3D csr_read64(LOONGARCH_CSR_ISR0);
> >> +               case 1:
> >> +                       isr =3D csr_read64(LOONGARCH_CSR_ISR1);
> >> +               case 2:
> >> +                       isr =3D csr_read64(LOONGARCH_CSR_ISR2);
> >> +               case 3:
> >> +                       isr =3D csr_read64(LOONGARCH_CSR_ISR3);
> >> +               }
> >> +
> >> +               if (isr & (1UL << (vector % VECTORS_PER_REG))) {
> >> +                       mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECT)=
;
> >> +                       continue;
> >> +               }
> >> +               list_del(&adata->entry);
> >> +               irq_matrix_free(loongarch_avec.vector_matrix, cpu, vec=
tor, adata->managed);
> >> +               this_cpu_write(irq_map[vector], NULL);
> >> +               adata->prev_cpu =3D adata->cpu;
> >> +               adata->prev_vec =3D adata->vec;
> >> +               adata->moving =3D 0;
> >> +       }
> >> +       raw_spin_unlock(&loongarch_avec.lock);
> >> +}
> >> +
> >> +void loongarch_avec_offline_cpu(unsigned int cpu)
> >> +{
> >> +       struct pending_list *plist =3D per_cpu_ptr(&pending_list, cpu)=
;
> >> +       unsigned long flags;
> >> +
> >> +       if (!loongarch_avec.vector_matrix)
> >> +               return;
> >> +
> >> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> >> +       if (list_empty(&plist->head))
> >> +               irq_matrix_offline(loongarch_avec.vector_matrix);
> >> +       else
> >> +               pr_warn("cpu %d advanced extioi is busy\n", cpu);
> >> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> >> +}
> >> +
> >> +void loongarch_avec_online_cpu(unsigned int cpu)
> >> +{
> >> +       unsigned long flags;
> >> +
> >> +       if (!loongarch_avec.vector_matrix)
> >> +               return;
> >> +
> >> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> >> +
> >> +       irq_matrix_online(loongarch_avec.vector_matrix);
> >> +
> >> +       pending_list_init(cpu);
> >> +
> >> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> >> +}
> >> +
> >> +#else
> >> +#define loongarch_avec_set_affinity            NULL
> >> +#endif
> >> +
> >> +static void loongarch_avec_compose_msg(struct irq_data *d,
> >> +               struct msi_msg *msg)
> >> +{
> >> +       struct loongarch_avec_data *avec_data;
> >> +
> >> +       avec_data =3D irq_data_get_irq_chip_data(d);
> >> +
> >> +       msg->address_hi =3D 0x0;
> >> +       msg->address_lo =3D (msi_base_v2 | (avec_data->vec & 0xff) << =
4) |
> >> +                         ((cpu_logical_map(avec_data->cpu & 0xffff)) =
<< 12);
> >> +       msg->data =3D 0x0;
> >> +
> >> +}
> >> +
> >> +static struct irq_chip loongarch_avec_controller =3D {
> >> +       .name                   =3D "AVECINTC",
> >> +       .irq_ack                =3D loongarch_avec_ack_irq,
> >> +       .irq_mask               =3D loongarch_avec_mask_irq,
> >> +       .irq_unmask             =3D loongarch_avec_unmask_irq,
> >> +       .irq_set_affinity       =3D loongarch_avec_set_affinity,
> >> +       .irq_compose_msi_msg    =3D loongarch_avec_compose_msg,
> >> +};
> >> +
> >> +static void loongarch_avec_dispatch(struct irq_desc *desc)
> >> +{
> >> +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >> +       unsigned long vector;
> >> +       struct irq_desc *d;
> >> +
> >> +       chained_irq_enter(chip, desc);
> >> +       vector =3D csr_read64(LOONGARCH_CSR_IRR);
> >> +       if (vector & IRR_INVALID_MASK)
> >> +               return;
> > Here missing a  chained_irq_exit(chip, desc), right?
> >
> > Moreover, I think it is better to handle all avecintc interrupts in
> > one dispatch, which means
> >
> >          chained_irq_enter(chip, desc);
> >
> >          while (true) {
> >                  vector =3D csr_read64(LOONGARCH_CSR_IRR);
> >                  if (vector & IRR_INVALID_MASK)
> >                          goto out;
> >
> >                  vector &=3D IRR_VECTOR_MASK;
> >
> >                  d =3D this_cpu_read(irq_map[vector]);
> >                  if (d)
> >                          generic_handle_irq_desc(d);
> >                  else {
> >                          spurious_interrupt();
> >                          pr_warn("Unexpected IRQ occurs on CPU#%d
> > [vector %ld]\n", smp_processor_id(), vector);
> >                  }
> >          }
> >
> > out:
> >          chained_irq_exit(chip, desc);
> >
> > Do you think so?
>
> Miss  chained_irq_exit is realy a potential bugs, Thanks
>
> Regarding the second suggestion, the consideration at that time was to
> minimize the
>
> granularity of avec interrupt execution as much as possible, so that
> higher priority tasks could be executed.
>
> However, this has indeed caused some efficiency reduction. I am
> consulting with hardware personnel,
>
> and if the value of the IRR register will not be infinitely refreshed
> when the interrupt is turned off,
>
> then I think the above code is more appropriate
>
>
> >
> >> +
> >> +       vector &=3D IRR_VECTOR_MASK;
> >> +
> >> +       d =3D this_cpu_read(irq_map[vector]);
> >> +       if (d) {
> >> +               generic_handle_irq_desc(d);
> >> +       } else {
> >> +               pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vec=
tor %ld]\n",
> >> +                       smp_processor_id(), vector);
> >> +       }
> >> +
> >> +       chained_irq_exit(chip, desc);
> >> +}
> >> +
> >> +static int loongarch_avec_alloc(struct irq_domain *domain, unsigned i=
nt virq,
> >> +                               unsigned int nr_irqs, void *arg)
> >> +{
> >> +       struct loongarch_avec_data *adata;
> >> +       struct irq_data *irqd;
> >> +       unsigned int cpu, vector, i, ret;
> >> +       unsigned long flags;
> >> +
> >> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> >> +       for (i =3D 0; i < nr_irqs; i++) {
> >> +               irqd =3D irq_domain_get_irq_data(domain, virq + i);
> >> +               adata =3D kzalloc(sizeof(*adata), GFP_KERNEL);
> >> +               if (!adata) {
> >> +                       raw_spin_unlock_irqrestore(&loongarch_avec.loc=
k, flags);
> >> +                       return -ENOMEM;
> >> +               }
> >> +               ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix,=
 cpu_online_mask, false, &cpu);
> >> +               if (ret < 0) {
> >> +                       raw_spin_unlock_irqrestore(&loongarch_avec.loc=
k, flags);
> >> +                       return ret;
> >> +               }
> >> +               vector =3D ret;
> >> +               adata->prev_cpu =3D adata->cpu =3D cpu;
> >> +               adata->prev_vec =3D adata->vec =3D vector;
> >> +               adata->managed =3D irqd_affinity_is_managed(irqd);
> >> +               irq_domain_set_info(domain, virq + i, virq + i, &loong=
arch_avec_controller,
> >> +                               adata, handle_edge_irq, NULL, NULL);
> >> +               adata->moving =3D 0;
> >> +               irqd_set_single_target(irqd);
> >> +               irqd_set_affinity_on_activate(irqd);
> >> +
> >> +               per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_d=
ata_to_desc(irqd);
> >> +       }
> >> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void clear_free_vector(struct irq_data *irqd)
> >> +{
> >> +       struct loongarch_avec_data *adata =3D irq_data_get_irq_chip_da=
ta(irqd);
> >> +       bool managed =3D irqd_affinity_is_managed(irqd);
> >> +
> >> +       per_cpu(irq_map, adata->cpu)[adata->vec] =3D NULL;
> >> +       irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adat=
a->vec, managed);
> >> +       adata->cpu =3D 0;
> >> +       adata->vec =3D 0;
> >> +#ifdef CONFIG_SMP
> >> +       if (!adata->moving)
> >> +               return;
> >> +
> >> +       per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] =3D 0;
> >> +       irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu,
> >> +                       adata->prev_vec, adata->managed);
> >> +       adata->prev_vec =3D 0;
> >> +       adata->prev_cpu =3D 0;
> >> +       adata->moving =3D 0;
> >> +       list_del_init(&adata->entry);
> >> +#endif
> >> +}
> >> +
> >> +static void loongarch_avec_free(struct irq_domain *domain, unsigned i=
nt virq,
> >> +               unsigned int nr_irqs)
> >> +{
> >> +       struct irq_data *d;
> >> +       unsigned long flags;
> >> +       unsigned int i;
> >> +
> >> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> >> +       for (i =3D 0; i < nr_irqs; i++) {
> >> +               d =3D irq_domain_get_irq_data(domain, virq + i);
> >> +               if (d) {
> >> +                       clear_free_vector(d);
> >> +                       irq_domain_reset_irq_data(d);
> >> +
> >> +               }
> >> +       }
> >> +
> >> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> >> +}
> >> +
> >> +static const struct irq_domain_ops loongarch_avec_domain_ops =3D {
> >> +       .alloc          =3D loongarch_avec_alloc,
> >> +       .free           =3D loongarch_avec_free,
> >> +};
> >> +
> >> +static int __init irq_matrix_init(void)
> >> +{
> >> +       int i;
> >> +
> >> +       loongarch_avec.vector_matrix =3D irq_alloc_matrix(NR_VECTORS, =
0, NR_VECTORS - 1);
> >> +       if (!loongarch_avec.vector_matrix)
> >> +               return -ENOMEM;
> >> +       for (i =3D 0; i < NR_LEGACY_VECTORS; i++)
> >> +               irq_matrix_assign_system(loongarch_avec.vector_matrix,=
 i, false);
> >> +
> >> +       irq_matrix_online(loongarch_avec.vector_matrix);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int __init loongarch_avec_init(struct irq_domain *parent)
> >> +{
> >> +       int ret =3D 0, parent_irq;
> >> +       unsigned long tmp;
> >> +
> >> +       raw_spin_lock_init(&loongarch_avec.lock);
> >> +
> >> +       loongarch_avec.fwnode =3D irq_domain_alloc_named_fwnode("CORE_=
AVEC");
> >> +       if (!loongarch_avec.fwnode) {
> >> +               pr_err("Unable to allocate domain handle\n");
> >> +               ret =3D -ENOMEM;
> >> +               goto out;
> >> +       }
> >> +
> >> +       loongarch_avec.domain =3D irq_domain_create_tree(loongarch_ave=
c.fwnode,
> >> +                       &loongarch_avec_domain_ops, NULL);
> >> +       if (!loongarch_avec.domain) {
> >> +               pr_err("core-vec: cannot create IRQ domain\n");
> >> +               ret =3D -ENOMEM;
> >> +               goto out_free_handle;
> >> +       }
> >> +
> >> +       parent_irq =3D irq_create_mapping(parent, INT_AVEC);
> >> +       if (!parent_irq) {
> >> +               pr_err("Failed to mapping hwirq\n");
> >> +               ret =3D -EINVAL;
> >> +               goto out_remove_domain;
> >> +       }
> >> +       irq_set_chained_handler_and_data(parent_irq, loongarch_avec_di=
spatch, NULL);
> >> +
> >> +       ret =3D irq_matrix_init();
> >> +       if (ret) {
> >> +               pr_err("Failed to init irq matrix\n");
> >> +               goto out_free_matrix;
> >> +       }
> >> +#ifdef CONFIG_SMP
> >> +       pending_list_init(0);
> >> +#endif
> >> +       tmp =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> >> +       tmp |=3D IOCSR_MISC_FUNC_AVEC_EN;
> >> +       iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);
> >> +
> >> +       return ret;
> >> +
> >> +out_free_matrix:
> >> +       kfree(loongarch_avec.vector_matrix);
> >> +out_remove_domain:
> >> +       irq_domain_remove(loongarch_avec.domain);
> >> +out_free_handle:
> >> +       irq_domain_free_fwnode(loongarch_avec.fwnode);
> >> +out:
> >> +       return ret;
> >> +}
> >> +
> >> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *hea=
der,
> >> +                                    const unsigned long end)
> >> +{
> >> +       struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_m=
si_pic *)header;
> >> +
> >> +       msi_base_v2 =3D pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
> >> +       return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entr=
y);
> >> +}
> >> +
> >> +static inline int __init acpi_cascade_irqdomain_init(void)
> >> +{
> >> +       return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_p=
arse_madt, 1);
> >> +}
> >> +
> >> +int __init loongarch_avec_acpi_init(struct irq_domain *parent)
> >> +{
> >> +       int ret =3D 0;
> >> +
> >> +       ret =3D loongarch_avec_init(parent);
> >> +       if (ret) {
> >> +               pr_err("Failed to init irq domain\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       ret =3D acpi_cascade_irqdomain_init();
> >> +       if (ret) {
> >> +               pr_err("Failed to cascade IRQ domain\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq=
-loongarch-cpu.c
> >> index 9d8f2c406043..1ecac59925c6 100644
> >> --- a/drivers/irqchip/irq-loongarch-cpu.c
> >> +++ b/drivers/irqchip/irq-loongarch-cpu.c
> >> @@ -138,7 +138,9 @@ static int __init acpi_cascade_irqdomain_init(void=
)
> >>          if (r < 0)
> >>                  return r;
> >>
> >> -       return 0;
> >> +       if (cpu_has_avecint)
> >> +               r =3D loongarch_avec_acpi_init(irq_domain);
> >> +       return r;
> >>   }
> >>
> >>   static int __init cpuintc_acpi_init(union acpi_subtable_headers *hea=
der,
> >> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/=
irq-loongson-eiointc.c
> >> index c7ddebf312ad..1f9a30488137 100644
> >> --- a/drivers/irqchip/irq-loongson-eiointc.c
> >> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> >> @@ -359,6 +359,9 @@ static int __init acpi_cascade_irqdomain_init(void=
)
> >>          if (r < 0)
> >>                  return r;
> >>
> >> +       if (cpu_has_avecint)
> >> +               return 0;
> >> +
> >>          r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_p=
arse_madt, 1);
> >>          if (r < 0)
> >>                  return r;
> >> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/=
irq-loongson-pch-msi.c
> >> index dd4d699170f4..8b7aae22e782 100644
> >> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> >> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> >> @@ -16,7 +16,6 @@
> >>   #include <linux/slab.h>
> >>
> >>   static int nr_pics;
> >> -
> >>   struct pch_msi_data {
> >>          struct mutex    msi_map_lock;
> >>          phys_addr_t     doorbell;
> >> @@ -100,6 +99,17 @@ static struct irq_chip middle_irq_chip =3D {
> >>          .irq_compose_msi_msg    =3D pch_msi_compose_msi_msg,
> >>   };
> >>
> >> +static struct irq_chip pch_msi_irq_chip_v2 =3D {
> >> +       .name                   =3D "MSI",
> >> +       .irq_ack                =3D irq_chip_ack_parent,
> > I think these lines are also needed, right?
> >          .irq_mask               =3D irq_chip_mask_parent,
> >          .irq_unmask             =3D irq_chip_unmask_parent,
> >          .irq_set_affinity       =3D irq_chip_set_affinity_parent,
> >
> > Huacai
>
> The original intention of this design was to use
> MSI_FLAG_USE_DEF_CHIP_OPS, and
>
> then update it with the default value in pci_msi_domain_update_chip_ops
> & msi_domain_update_chip_ops,
>
> so there is no explicit indication
>
>
> Tianyang
>
> >
> >> +};
> >> +
> >> +static struct msi_domain_info pch_msi_domain_info_v2 =3D {
> >> +       .flags          =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DE=
F_CHIP_OPS |
> >> +                       MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> >> +       .chip   =3D &pch_msi_irq_chip_v2,
> >> +};
> >> +
> >>   static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
> >>                                          unsigned int virq, int hwirq)
> >>   {
> >> @@ -268,6 +278,9 @@ struct fwnode_handle *get_pch_msi_handle(int pci_s=
egment)
> >>   {
> >>          int i;
> >>
> >> +       if (cpu_has_avecint)
> >> +               return pch_msi_handle[0];
> >> +
> >>          for (i =3D 0; i < MAX_IO_PICS; i++) {
> >>                  if (msi_group[i].pci_segment =3D=3D pci_segment)
> >>                          return pch_msi_handle[i];
> >> @@ -289,4 +302,31 @@ int __init pch_msi_acpi_init(struct irq_domain *p=
arent,
> >>
> >>          return ret;
> >>   }
> >> +
> >> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent, struct acp=
i_madt_msi_pic *msi_entry)
> >> +{
> >> +       struct irq_domain *msi_domain;
> >> +
> >> +       if (pch_msi_handle[0])
> >> +               return 0;
> >> +
> >> +       pch_msi_handle[0] =3D irq_domain_alloc_named_fwnode("msipic-v2=
");
> >> +       if (!pch_msi_handle[0]) {
> >> +               pr_err("Unable to allocate domain handle\n");
> >> +               kfree(pch_msi_handle[0]);
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       msi_domain =3D pci_msi_create_irq_domain(pch_msi_handle[0],
> >> +                       &pch_msi_domain_info_v2,
> >> +                       parent);
> >> +       if (!msi_domain) {
> >> +               pr_err("Failed to create PCI MSI domain\n");
> >> +               kfree(pch_msi_handle[0]);
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       pr_info("IRQ domain MSIPIC-V2 init done.\n");
> >> +       return 0;
> >> +}
> >>   #endif
> >> --
> >> 2.36.0
> >>
> >>
>

