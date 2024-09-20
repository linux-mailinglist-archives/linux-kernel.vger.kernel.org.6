Return-Path: <linux-kernel+bounces-334348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B897D610
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBF1F2335A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF731714AF;
	Fri, 20 Sep 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="G5N6KKLC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F801422AB
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838305; cv=none; b=Hw9E/Xfmyt2i0luZSJAuHFAmZBCC7imoEo8VZR78aq3pnLUtWV8OwVy+0nAEWSon1kybHWPPXR845O8baLP2X/FVXaFkykqQoBjHaYcjasbj4kHHztKQ0qYn2gEq5adT7gjTZiORX/G4E78RRZrzD/qUFC4u9R7AqYmAag/18aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838305; c=relaxed/simple;
	bh=9tesRVsZ7ddwOkKfTsjmJUig+CLz21Z/WhxJbLEl5mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbYAlR5S0rfP7PXrBGAI3vlxXSGREIqtOuKckJdRZajPaaIpfq9WFAck15rKoq4/nQa6dKyI3wZkPvXrPVr9lnFwKZGUL/CC6piD61POyxJvLDUrIa54079e1C23H2gSU13zpSKC4Z3EWXnbu5lcxfJVkpi7HGV+C0qovVRwDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=G5N6KKLC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f74e468baeso23429971fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1726838302; x=1727443102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCr+b1uaUv6DBDhbwInFIiICgPG/Kycc9x8fjXZbOhA=;
        b=G5N6KKLCTI7sZ8nxci/E2uvctqQcbtCaqrCLtdbBiQk/IQpTO38/5MXAV0tYe5mMZT
         UU2fNRJRY02LtKjLIIjiNpZLP4F6nU3z44oXhEYUY5nWJM8rH5wg5mOQk4Zq5/SgGD4S
         Iq4ri8Z0Z+/tQ1K8H78NOsRadVVvt0Xukg/9BNuDI3/KegjNnCalHhTqd9N8KjfP5f+I
         Sa2dZJAUx2zTp6v3tVeS8LhOMMFgQg4vnmv84bZ8j11p7bsgge2eQpmPeVu2R7egQ06s
         iwj8oKg9Yqq8EMifIXthgn0VorjxE2s3YVU1BjAJdh/lnmKt9mh7gENoFhV3mKF051ci
         j/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726838302; x=1727443102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCr+b1uaUv6DBDhbwInFIiICgPG/Kycc9x8fjXZbOhA=;
        b=eg+tS2WYbPttBbSFzlgSZ6oXtya13SlACbT3m3GfakYsbiKW76Y/rcAdQIEgwX2/+n
         dT7d1gXaW7R//iLk4eYDyV4HzSeMYx6F1M+UpGAX6Y58EyVwAVf2Ef+yvdZHLYzCYYPp
         mlqU9wJLi69q4EKiP2vGuBhzgU2LCV1eKmETcAx1W06ALj5ZeOpARCCj56jjEYX2nuR+
         A7+li8mdm+3u/JG2NjIING55DPo+AKlKvwvqvyFz6v5q+WY/Nf1N2pTcG0p98QB10PHF
         kcuOflR7ci0bJG5pRwr08hbGwd+GEmxtat/7FrHWJvrSHrlhG8JOiV7Q00yEecdG+B6g
         7USQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmAqGZP1e57fwORPyT7oivxh+d3fICBSseswLsLtBwjePIdBZm0TdxZTy/Cp45vdS9PefjR+4f6XI2hyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjyZvGgnO2l0RTGgSkEezyjOYBqxp/xKS0dlp3MS82akyvf1W
	+GHk28rQ19QaYOfBhIIA1MV/1EuAv8CWub+8AdTWkKtMdpmZ0VZ/5IgWHCrqqcI=
X-Google-Smtp-Source: AGHT+IEKGMpSHb5f0yI5u05QvgiUAxmRxE826tRbypV2GPNIMdsmv1gm2pe/f5PYbylfyOE4f+EASQ==
X-Received: by 2002:a05:651c:220d:b0:2f6:5921:f35b with SMTP id 38308e7fff4ca-2f7cb30cabfmr19027321fa.27.1726838301434;
        Fri, 20 Sep 2024 06:18:21 -0700 (PDT)
Received: from x1 ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5ee43sm7111622a12.50.2024.09.20.06.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:18:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:18:19 +0200
From: Drew Fustini <drew@pdp7.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dfustini@tenstorrent.com, Conor Dooley <conor@kernel.org>,
	vladimir.kondratiev@mobileye.com,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Message-ID: <Zu12G+Px2E+d26aD@x1>
References: <Zs5c3KJR41AUVyEv@x1>
 <mhng-ff7311d0-a1e2-4487-af68-130a7efb6040@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-ff7311d0-a1e2-4487-af68-130a7efb6040@palmer-ri-x1c9>

On Fri, Sep 20, 2024 at 01:58:23AM -0700, Palmer Dabbelt wrote:
> On Tue, 27 Aug 2024 16:10:20 PDT (-0700), dfustini@tenstorrent.com wrote:
> > On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:
> > > It is not necessary any RISCV platform has ZONE_DMA32.
> > > 
> > > Example - if platform has no DRAM in [0..4G] region,
> > > it will report failure like below each boot.
> > > 
> > > [    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
> > > [    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
> > > [    0.088864] Call Trace:
> > > [    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
> > > [    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
> > > [    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
> > > [    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
> > > [    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
> > > [    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
> > > [    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
> > > [    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
> > > [    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
> > > [    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
> > > [    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
> > > [    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
> > > [    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c
> > > 
> > > Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > > ---
> > >  arch/riscv/Kconfig | 2 +-
> > >  mm/Kconfig         | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 0f3cd7c3a436..94a573112625 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -50,6 +50,7 @@ config RISCV
> > >  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > >  	select ARCH_HAS_UBSAN
> > >  	select ARCH_HAS_VDSO_DATA
> > > +	select ARCH_HAS_ZONE_DMA_SET if 64BIT
> > >  	select ARCH_KEEP_MEMBLOCK if ACPI
> > >  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
> > >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> > > @@ -200,7 +201,6 @@ config RISCV
> > >  	select THREAD_INFO_IN_TASK
> > >  	select TRACE_IRQFLAGS_SUPPORT
> > >  	select UACCESS_MEMCPY if !MMU
> > > -	select ZONE_DMA32 if 64BIT
> > > 
> > >  config CLANG_SUPPORTS_DYNAMIC_FTRACE
> > >  	def_bool CC_IS_CLANG
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index b72e7d040f78..97c85da98e89 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -1032,7 +1032,7 @@ config ZONE_DMA
> > >  config ZONE_DMA32
> > >  	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
> > >  	depends on !X86_32
> > > -	default y if ARM64
> > > +	default y if ARM64 || (RISCV && 64BIT)
> > > 
> > >  config ZONE_DEVICE
> > >  	bool "Device memory (pmem, HMM, etc...) hotplug support"
> > > --
> > > 2.37.3
> > > 
> > 
> > Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > Thanks for sending this patch as I've also encountered that annoying
> > error on systems with DRAM above 4GB.
> > 
> > I tested this patch by changing the qemu virt machine to have DRAM
> > starting at 2^32:
> > 
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index cef41c150aaf..3033a2560edb 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -87,7 +87,7 @@ static const MemMapEntry virt_memmap[] = {
> >      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> >      [VIRT_PCIE_ECAM] =    { 0x30000000,    0x10000000 },
> >      [VIRT_PCIE_MMIO] =    { 0x40000000,    0x40000000 },
> > -    [VIRT_DRAM] =         { 0x80000000,           0x0 },
> > +    [VIRT_DRAM] =        { 0x100000000,           0x0 },
> >  };
> > 
> >  /* PCIe high mmio is fixed for RV32 */
> 
> IIRC the ZONE_DMA32 stuff existed for some of the early SiFive systems,
> where the expansion daughterboard's PCIe controller (via a Xilinx FPGA)
> could only handle 32-bit DMA addreses.  I think there's a similar quirk in
> the Microsemi PCIe controller on the PolarFire boards, but Conor would know
> for sure.

I don't think this patch would affect those systems that need ZONE_DMA2.
I believe it just makes it possible to disable it in the kernel config.
The platform I'm working on has no memory below 4GB and all the PCIe
devices that I care about are not 32-bit constrained. Therefore I just
want to be able to turn it off in my .config.

Thanks,
Drew

