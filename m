Return-Path: <linux-kernel+bounces-245090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDE92AE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435DB1C20BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494433D388;
	Tue,  9 Jul 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nxwnVCuy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF852C1AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491359; cv=none; b=lP//EvPrC8NegyWWDd6p+5b5TaFT7WjCVr3svDqYmh3k/rNTyENROZ4wF105s748sMz+81Qx7P7t4ZAKIS1aA3L4FchXUJdNTxbTLckyiLMIbYDbSl6Bcg4xa7N3CtXcj5aJ6KJfu00xieVWLxMydUbNU9T6Hz+MEEfZge+jWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491359; c=relaxed/simple;
	bh=nS/dkZX0QY1yvaexqPtL6mM5XRAJy6Bsn6llaERihDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvwhHVdzHQzI7kJGGHSgQy3oTQfdJXe3FyuLAJtXjjZB5E6IRMFsuvgIV2c/YI0IRsXu5Ln8pBpBM7tlC8td0XZRlm9LnI0PVY3d1AtXJ6SBD8MGvCx0wB/Jv+GGeEex+zLh/9/fznCJMcJKFN2PLZ/47gnqqO0Op20IqNHs/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nxwnVCuy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af22a9c19so3354388b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720491356; x=1721096156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bnz9B6ig7Xz6h+rr6QHRC8DIXT9AMGxIguL2yfBRX9U=;
        b=nxwnVCuy9Z/0dDhyNKNq35yBo4ndGqGVNR9ZnmlCjdK1b8fbbKd0ylElkMMD4i1CQk
         u/2XZj+yIW2sSC10RU7TMrkUKdP4MeTToKwKhU/9TAGEM/2lDbWyySlSrMuLRx3qbWOQ
         poreyBjnX6Wh2KW0BUqrfyIyOMN5sSdY4Z16jws7SK4KTIiHE07zbFVOII8nNB5y28Wv
         FNZwXF/cRdrLB2sXCSpmFJTY2APqSH7Zh7LV5uJYuBESVLbKxWnMz8KX4k4EhHHb6AHK
         EANoONP59GJJ6OT9BBlKdhKDkQpWAgvHHRxh8LfaAV4/oII96zvyepBNk5Jz2YZv3gTS
         PQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720491356; x=1721096156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bnz9B6ig7Xz6h+rr6QHRC8DIXT9AMGxIguL2yfBRX9U=;
        b=UOH5GdQCFN2IVTGTaiNlJtN9SUNpZ0MxJ+OF+MxiaNTgBNPOYoR/mQQtZ+I9q0Kkf+
         HbzLud7bs402xTRrPtTypIsOXSvRhMJbKQirJhvH7rftIv48Vx8Ma1NPuNzPEDYHuMb9
         kAGB0vUxE+q/ju2lIWqy+IJznrrtvQ0LKprIpl4zHbFuujMhqr+z53FAFoiQiJOKwGpK
         +jGd4rTN5W0aLDvpPEgNuTzlfi7OfLi5tLhXXvUtBSOAuhhvRU0A43qfeUQlJ7kA/8MN
         iui4MZcnhGxyk9d9es85oacnSXjXDFbULNXGoY4YxeN1LqIoJel5OGReGikgoKA8YFFS
         aOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXRrUOiEdFEXVhaTvSFqgnsUrQIlQ3ZJ9YsBEZvJKKXKRuYijV6IXnoqAcXayNZdqC3v92FbLXkw+AeUJNiQTQnkFE+nRW2vPZWIxWF
X-Gm-Message-State: AOJu0Yx0d0YbMjypkjMnNMeXxnjso6s4C37T6EkXaRg0IsIFHxWJMc/O
	83mgXdB6Xyf20HhcdLq9qZ5UmfFWxmVBth3JMFGoSpn7CODwzUeF+v6D1gGueIk=
X-Google-Smtp-Source: AGHT+IG6qJBw6KO7Qk5DzPxTWPK9eD4FdYm01SAL3rqN3QI07tYW+1qf5NcNtRGxEhzOKf+MdVmKxg==
X-Received: by 2002:a05:6a00:3d08:b0:706:8e4:56a1 with SMTP id d2e1a72fcca58-70b4356c646mr1599075b3a.18.1720491356107;
        Mon, 08 Jul 2024 19:15:56 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:482b:e40f:a784:6039])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43968688sm567555b3a.114.2024.07.08.19.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 19:15:55 -0700 (PDT)
Date: Mon, 8 Jul 2024 19:15:51 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into
 a platform driver
Message-ID: <ZoydV7vad5JWIcZb@ghost>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com>
 <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
 <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
 <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com>
 <CAAhSdy1pesbdTfWnFURMJRcy2ujjX+cXtt-cfLDj2CQf2Ua_gw@mail.gmail.com>
 <CAJM55Z_=94+aMv=ywhih44eF0pR2WXiyx3FcrwRaX6tZto4gpQ@mail.gmail.com>
 <CAK9=C2XWjtWtV1WbQrX4Cg8KyzjVevMjG18YTgQJbZxi61BFjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2XWjtWtV1WbQrX4Cg8KyzjVevMjG18YTgQJbZxi61BFjg@mail.gmail.com>

On Thu, Jun 20, 2024 at 08:38:09PM +0530, Anup Patel wrote:
> On Thu, Jun 20, 2024 at 6:40 PM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Anup Patel wrote:
> > > On Wed, Jun 19, 2024 at 11:16 PM Emil Renner Berthing
> > > <emil.renner.berthing@canonical.com> wrote:
> > > >
> > > > Anup Patel wrote:
> > > > > On Tue, Jun 18, 2024 at 7:00 PM Emil Renner Berthing
> > > > > <emil.renner.berthing@canonical.com> wrote:
> > > > > >
> > > > > > Anup Patel wrote:
> > > > > > > The PLIC driver does not require very early initialization so convert
> > > > > > > it into a platform driver.
> > > > > > >
> > > > > > > After conversion, the PLIC driver is probed after CPUs are brought-up
> > > > > > > so setup cpuhp state after context handler of all online CPUs are
> > > > > > > initialized otherwise PLIC driver crashes for platforms with multiple
> > > > > > > PLIC instances.
> > > > > > >
> > > > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > >
> > > > > > Hi Anup,
> > > > > >
> > > > > > Sorry for the late reply to the mailing list, but ever since 6.9 where this was
> > > > > > applied my Allwinner D1 based boards no longer boot. This is the log of my
> > > > > > LicheeRV Dock booting plain 6.10-rc4, locking up and then rebooting due to the
> > > > > > the watchdog timing out:
> > > > > >
> > > > > > https://pastebin.com/raw/nsbzgEKW
> > > > > >
> > > > > > On 6.10-rc4 I can bring the same board to boot by reverting this patch and all
> > > > > > patches building on it. Eg.:
> > > > > >
> > > > > >   git revert e306a894bd51 a7fb69ffd7ce abb720579490 \
> > > > > >              956521064780 a15587277a24 6c725f33d67b \
> > > > > >              b68d0ff529a9 25d862e183d4 8ec99b033147
> > > > >
> > > > > Does your board boot with only SBI timer driver enabled ?
> > > >
> > > > I'm not 100% sure this is what you mean, but with this change I can disable
> > > > CONFIG_SUN4I_TIMER:
> > > >
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index f51bb24bc84c..0143545348eb 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -39,7 +39,6 @@ config ARCH_SUNXI
> > > >         bool "Allwinner sun20i SoCs"
> > > >         depends on MMU && !XIP_KERNEL
> > > >         select ERRATA_THEAD
> > > > -       select SUN4I_TIMER
> > > >         help
> > > >           This enables support for Allwinner sun20i platform hardware,
> > > >           including boards based on the D1 and D1s SoCs.
> > > >
> > > >
> > > > But unfortunately the board still doesn't boot:
> > > > https://pastebin.com/raw/AwRxcfeu
> > >
> > > I think we should enable debug prints in DD core and see
> > > which device is not getting probed due to lack of a provider.
> > >
> > > Just add "#define DEBUG" at the top in drivers/base/core.c
> > > and boot again with "loglevel=8" kernel parameter (along with
> > > the above change).
> >
> > With the above changes this is what I get:
> > https://pastebin.com/raw/JfRrEahT
> 
> You should see prints like below which show producer consumer
> relation:
> 
> [    0.214589] /soc/rtc@101000 Linked as a fwnode consumer to /soc/plic@c000000
> [    0.214966] /soc/serial@10000000 Linked as a fwnode consumer to
> /soc/plic@c000000
> [    0.215443] /soc/virtio_mmio@10008000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.216041] /soc/virtio_mmio@10007000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.216482] /soc/virtio_mmio@10006000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.216868] /soc/virtio_mmio@10005000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.217477] /soc/virtio_mmio@10004000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.217949] /soc/virtio_mmio@10003000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.218595] /soc/virtio_mmio@10002000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.219280] /soc/virtio_mmio@10001000 Linked as a fwnode consumer
> to /soc/plic@c000000
> [    0.219908] /soc/plic@c000000 Linked as a fwnode consumer to
> /cpus/cpu@0/interrupt-controller
> [    0.220800] /soc/plic@c000000 Linked as a fwnode consumer to
> /cpus/cpu@1/interrupt-controller
> [    0.221323] /soc/plic@c000000 Linked as a fwnode consumer to
> /cpus/cpu@2/interrupt-controller
> [    0.221838] /soc/plic@c000000 Linked as a fwnode consumer to
> /cpus/cpu@3/interrupt-controller
> [    0.222347] /soc/clint@2000000 Linked as a fwnode consumer to
> /cpus/cpu@0/interrupt-controller
> [    0.222769] /soc/clint@2000000 Linked as a fwnode consumer to
> /cpus/cpu@1/interrupt-controller
> [    0.223864] /soc/clint@2000000 Linked as a fwnode consumer to
> /cpus/cpu@2/interrupt-controller
> [    0.224370] /soc/clint@2000000 Linked as a fwnode consumer to
> /cpus/cpu@3/interrupt-controller
> [    0.225217] /soc/pci@30000000 Linked as a fwnode consumer to
> /soc/plic@c000000
> 
> To get further prints, I suggest enabling SBI_HVC console and use
> "console=hvc0" as kernel parameter.
> 
> Regards,
> Anup

I did some follow-up research into this. The hanging after "cpuidle:
using governor menu" is due to being stuck inside of
check_unaligned_access(). Specifically, there is a check that appears to
be waiting for jiffies to start ticking, but they never do:

while ((now = jiffies) == start_jiffies)
	cpu_relax();

`jiffies` is fixed at 0xfffedb08, effectively making this a while(true)
loop. This happens with and without SUN4I_TIMER.

This hang unfortunately happens before the "Linked as a fwnode consumer"
print statements start.

After bypassing this with the configs

CONFIG_NONPORTABLE=y
CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS=y

A new warning is tripped:

[    1.015134] No max_rate, ignoring min_rate of clock 9 - pll-video0
[    1.021322] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:155 sunxi_ccu_probe+0x144/0x1a2
[    1.021351] Modules linked in:
[    1.021360] CPU: 0 PID: 1 Comm: swapper Tainted: G        W          6.10.0-rc6 #1
[    1.021372] Hardware name: Allwinner D1 Nezha (changed) (DT)
[    1.021377] epc : sunxi_ccu_probe+0x144/0x1a2
[    1.021386]  ra : sunxi_ccu_probe+0x144/0x1a2
[    1.021397] epc : ffffffff80405a50 ra : ffffffff80405a50 sp : ffffffc80000bb80
[    1.021406]  gp : ffffffff815f69c8 tp : ffffffd801df8000 t0 : 6100000000000000
[    1.021414]  t1 : 000000000000004e t2 : 61725f78616d206f s0 : ffffffc80000bbe0
[    1.021422]  s1 : ffffffff81537498 a0 : 0000000000000036 a1 : 000000000000054b
[    1.021430]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : ffffffff8141f628
[    1.021438]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000000004442434e
[    1.021446]  s2 : 0000000000000009 s3 : 0000000000000000 s4 : ffffffd801dc9010
[    1.021453]  s5 : ffffffd802428a00 s6 : ffffffd83ffdcf20 s7 : ffffffc800015000
[    1.021462]  s8 : ffffffff80e55360 s9 : ffffffff81034598 s10: 0000000000000000
[    1.021470]  s11: 0000000000000000 t3 : ffffffff8160a257 t4 : ffffffff8160a257
[    1.021478]  t5 : ffffffff8160a258 t6 : ffffffc80000b990
[    1.021485] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    1.021493] [<ffffffff80405a50>] sunxi_ccu_probe+0x144/0x1a2
[    1.021510] [<ffffffff80405af6>] devm_sunxi_ccu_probe+0x48/0x82
[    1.021524] [<ffffffff80409020>] sun20i_d1_ccu_probe+0xba/0xfa
[    1.021546] [<ffffffff804a8b40>] platform_probe+0x4e/0xa6
[    1.021562] [<ffffffff808d81ee>] really_probe+0x10a/0x2dc
[    1.021581] [<ffffffff808d8472>] __driver_probe_device.part.0+0xb2/0xe8
[    1.021597] [<ffffffff804a67aa>] driver_probe_device+0x7a/0xca
[    1.021621] [<ffffffff804a6912>] __driver_attach+0x52/0x164
[    1.021638] [<ffffffff804a4c7a>] bus_for_each_dev+0x56/0x8c
[    1.021656] [<ffffffff804a6382>] driver_attach+0x1a/0x22
[    1.021673] [<ffffffff804a5c18>] bus_add_driver+0xea/0x1d8
[    1.021690] [<ffffffff804a7852>] driver_register+0x3e/0xd8
[    1.021709] [<ffffffff804a8826>] __platform_driver_register+0x1c/0x24
Emil[    1.021725] [<ffffffff80a17488>] sun20i_d1_ccu_driver_init+0x1a/0x22
[    1.021746] [<ffffffff800026ae>] do_one_initcall+0x46/0x1be
[    1.021762] [<ffffffff80a00ef2>] kernel_init_freeable+0x1c6/0x220
[    1.021791] [<ffffffff808e0b46>] kernel_init+0x1e/0x112
Linked as a fwnode consumer[    1.021807] [<ffffffff808e7632>] ret_from_fork+0xe/0x1c

The warning is not fatal, so execution continues until hanging at

[    2.110919] printk: legacy console [ttyS0] disabled
[    2.136911] 2500000.serial: ttyS0 at MMIO 0x2500000 (irq = 205, base_baud = 1500000) is a 16550A�[    2.145674] printk: legacy console [ttyS0] enabled
[    2.145674] printk: legacy console [ttyS0] enabled
[    2.155095] printk: legacy bootconsole [sbi0] disabled
[    2.155095] printk: legacy bootconsole [sbi0] disabled

I have not been able to discover why it hangs here.

The clock is somehow relying on the previous behavior of this PLIC
driver.

- Charlie

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

