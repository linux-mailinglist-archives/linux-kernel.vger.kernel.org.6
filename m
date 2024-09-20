Return-Path: <linux-kernel+bounces-334157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65D97D32E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D5C1C21FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB013B5BD;
	Fri, 20 Sep 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Ha2mXU4z"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579F13A86C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822706; cv=none; b=aGhRoKXiK2uveVhXAQfMEBF69p8+XsgrhcUFk81i+uTyRgRMZwZXDcCzjcd9zkNUM/Uwg+B2As6Q1Me2QspagZeDqptDMAThAjazLt3WnBzfAYZcirk/DtQ+ltMbbpplJCgz04pyy4S+Do+j//KhuYyRK0ejA9+7WUptBFkUPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822706; c=relaxed/simple;
	bh=BaIzFtKx0gXlru3ePEIPLFJqkigtotP+GB46RB3gveQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=MvQ+OWtmuxGGAmL+bhfD9xdg0ljIckoglMvGjznZy8hK+46btDkyFp3k0W7c6xdebrmky8lw13RNlORxRAHS/9zZjqTXn+gT6zPXIUorliVQJeWCX1Es7SlfcAudTiccNt5f7ORVWxJlVApmjjILz/s8mhaYu4yHZ1hJLwx1EW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Ha2mXU4z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d87176316eso2163965a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726822704; x=1727427504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/PwlrtjlNSmeYLWhd72xmzvu8WtL1wEwRjHNhxr9dA=;
        b=Ha2mXU4zNk9myZlUXvFsO0yfOdRU/7NUtZSKIVY0prQ08XbhMN/aVB4p3s9ErUqurC
         iFawiUlgY3S0mTnUTVRW+/plIy3MUo1GHvV2Jdm8i9MeMAajlFmGeIRJmF8XtKnEAukw
         uDomZ6PsaQgP4mmSE+okPGGT/AXIAkhk8jQtkUUvPyFQaI9/WhHQs8kVU0MH/g7S009K
         cUXzKWa5ja15/9IL+pYFsiEx0oZRm2mIYFgon2qxE2cl4SZyDpxOnDBYSzXaBuD7/1yG
         wHpHs1qBJz+/lwo+oXUsT3fWQT3yvYkmwJMKI7x43h2X7CzFUWqoePAeXD7xOluTCUGH
         x2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822704; x=1727427504;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/PwlrtjlNSmeYLWhd72xmzvu8WtL1wEwRjHNhxr9dA=;
        b=QzUvxliEotD/69AQ5inWh63natBbph+Ri4Ifep2QwDvj2Ot7Bwo7WyJF1S69uBUKE5
         /zQY41lBJo9Nd8WcbkoyH29TLi/HHLwiQG9cuhItqzVmAxFpFFfusuO6vNAHabQQILj2
         vjwLWc5CLblKPbbe+aTBMqsrKSXELVI9/bEArubaSykohq53W1Botda+Eh0IqCYZDPV6
         5jNDCNFkVQEEvlRo3n/q9cS9CvqdXv6tOPdOLucgzkz24KkJ/KeHicXGpPmtqqsBAHRl
         nP4ySc1ZQT8mYfEGzk03R0XDbLiH5LTvP+BC1n+SA27q9z0hRhrL/KuRmgpEa+L2z8Km
         c5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8aKguUxm5XuEiFgWE5TDd9d10J5vIHSMekEkxO3nfunFh9BUmnhYxGnxK2OUDBGHEAqQd9WseIlSdi1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbacgiXItwSgho6KksGyGLkkJ+CmiXAxKjR2dwNNgikxqmIqL
	Wa4PH0+naMl5tKhnHMge1M8gqR1OxDPiQVlHXNyInL6ns23weumpVw/MbMT2DY4=
X-Google-Smtp-Source: AGHT+IGY4mUINDatBTGE4l8Jfn0u9GfoIA4KWyA7TWO6T/LKxZHGtq1vizvHcmT/bPLPkL6rcUs0bQ==
X-Received: by 2002:a17:90a:7345:b0:2d8:8a3a:7b88 with SMTP id 98e67ed59e1d1-2dd6cdfaefcmr9547372a91.6.1726822703616;
        Fri, 20 Sep 2024 01:58:23 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd50c054d8sm4250330a91.0.2024.09.20.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:23 -0700 (PDT)
Date: Fri, 20 Sep 2024 01:58:23 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2024 01:58:17 PDT (-0700)
Subject:     Re: [PATCH] riscv: make ZONE_DMA32 optional
In-Reply-To: <Zs5c3KJR41AUVyEv@x1>
CC: vladimir.kondratiev@mobileye.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, akpm@linux-foundation.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-mm@kvack.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: dfustini@tenstorrent.com, Conor Dooley <conor@kernel.org>
Message-ID: <mhng-ff7311d0-a1e2-4487-af68-130a7efb6040@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 16:10:20 PDT (-0700), dfustini@tenstorrent.com wrote:
> On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:
>> It is not necessary any RISCV platform has ZONE_DMA32.
>>
>> Example - if platform has no DRAM in [0..4G] region,
>> it will report failure like below each boot.
>>
>> [    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
>> [    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
>> [    0.088864] Call Trace:
>> [    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
>> [    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
>> [    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
>> [    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
>> [    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
>> [    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
>> [    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
>> [    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
>> [    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
>> [    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
>> [    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
>> [    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
>> [    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c
>>
>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
>> ---
>>  arch/riscv/Kconfig | 2 +-
>>  mm/Kconfig         | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0f3cd7c3a436..94a573112625 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -50,6 +50,7 @@ config RISCV
>>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>  	select ARCH_HAS_UBSAN
>>  	select ARCH_HAS_VDSO_DATA
>> +	select ARCH_HAS_ZONE_DMA_SET if 64BIT
>>  	select ARCH_KEEP_MEMBLOCK if ACPI
>>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>> @@ -200,7 +201,6 @@ config RISCV
>>  	select THREAD_INFO_IN_TASK
>>  	select TRACE_IRQFLAGS_SUPPORT
>>  	select UACCESS_MEMCPY if !MMU
>> -	select ZONE_DMA32 if 64BIT
>>
>>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
>>  	def_bool CC_IS_CLANG
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index b72e7d040f78..97c85da98e89 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1032,7 +1032,7 @@ config ZONE_DMA
>>  config ZONE_DMA32
>>  	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
>>  	depends on !X86_32
>> -	default y if ARM64
>> +	default y if ARM64 || (RISCV && 64BIT)
>>
>>  config ZONE_DEVICE
>>  	bool "Device memory (pmem, HMM, etc...) hotplug support"
>> --
>> 2.37.3
>>
>
> Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
>
> Thanks for sending this patch as I've also encountered that annoying
> error on systems with DRAM above 4GB.
>
> I tested this patch by changing the qemu virt machine to have DRAM
> starting at 2^32:
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cef41c150aaf..3033a2560edb 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -87,7 +87,7 @@ static const MemMapEntry virt_memmap[] = {
>      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_PCIE_ECAM] =    { 0x30000000,    0x10000000 },
>      [VIRT_PCIE_MMIO] =    { 0x40000000,    0x40000000 },
> -    [VIRT_DRAM] =         { 0x80000000,           0x0 },
> +    [VIRT_DRAM] =        { 0x100000000,           0x0 },
>  };
>
>  /* PCIe high mmio is fixed for RV32 */

IIRC the ZONE_DMA32 stuff existed for some of the early SiFive systems, 
where the expansion daughterboard's PCIe controller (via a Xilinx FPGA) 
could only handle 32-bit DMA addreses.  I think there's a similar quirk 
in the Microsemi PCIe controller on the PolarFire boards, but Conor 
would know for sure.

