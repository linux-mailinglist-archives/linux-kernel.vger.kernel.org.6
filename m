Return-Path: <linux-kernel+bounces-393556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322159BA251
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DAF1F23502
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D681AB53A;
	Sat,  2 Nov 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S8weI+ZY"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B241A4E9E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577439; cv=none; b=F9xnFewp4MCz/doddRsAWtdiyJnf/8WHuG/DkfT/lTyhmn1EHWdZQFMiOvsYK9a9iAYvCtPepQNPTniwuApmFLTva9F244rLa+TjmWqaMhLZnWRPGENsWMqt5WlVmF6L0heFh6pDovKodka3YYdiOml7vXtLeM65kLllEcKixL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577439; c=relaxed/simple;
	bh=vkCTPEZrnTsV7OWCGO5bGCnJOS+bTKiKWsQ/KJuHjBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArZvkVfn8JItLhMBFsGo+z5wEhlYYsA2mhL2+rWCwhu3A2bBoHDKYGpS3We9SmrxSRajEKBG90R1EnHGLdmpgUkpuze6MBvmispLZZesWCU6WssCLW61Rornw9jICRbyU8tKYzwZ7K3SUif2X6B+iWQCZiW/aE2b0qeY6bWibRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=S8weI+ZY; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288d4da7221so1504740fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730577436; x=1731182236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eHRJuCoN/saRECrjZiUVo1CyjsSQtW8x6zbAAwYKWI=;
        b=S8weI+ZY9uylTcmAOLeDmiw9FkawfDWM09OCF08cLlkgDAiAZr1E7N0XrpCE331KQd
         5THuCjzSVVkToMYUkpDs2fGyI1ho2IK2y7urP1r1wU685GEsZ8d+SBYEwPO8f9M/NEUs
         0FbocmSGrebpn1s6d6qS379bAkUKY+V77a8xEyAZ8w0e9da59Iqq5PN+IRWIr96lgM5A
         /29y4deU07tRH60/pbayNeJ9ERSBZ9XT/8hhWdKRcal5AjXi32drirAA/GP7yDPl0b/N
         dhNkdU2+xPZ2Pz1BVUnCFGCLMXj/D7J96UAF4DZQwig2Hqrp1FAr5pxWcHJx4PE6hfe4
         WwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730577436; x=1731182236;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eHRJuCoN/saRECrjZiUVo1CyjsSQtW8x6zbAAwYKWI=;
        b=Oe5jVlvWpxcp8i3dWVoC1TO0zBwnl+gWNDgFej+6a7R6geunAkp6P2FncT1IdE5mLZ
         rz4bqVz6pJ9qpGRdKcxMsob5rwfN/raYVnwaFqzuvQoTZ1tSFlNVSvHdQjea7JP9EIvU
         4jKOK9aWpY3D+yRHEB+bxljEspvK9L4y4MSnL+eZpNyTGA8Iwwp10wMbv/ev24CBouOC
         Ocx3xNRmgbrzCGINKZyTU02iZnTvTR/9yL1cgohH0+LeMQbOVudO6aJUjldmJAlYdrbG
         RRxZqO7mvJgY9ZeWj6caTFIxe8JibJhfkeXSkb0AXlelQMMl/2VPlNqXEhJ4Dnizm5rG
         VbIg==
X-Forwarded-Encrypted: i=1; AJvYcCXap/ipkqxfxyiXVBF+FTPhoAjdZoW2oAqyBGm+rAcBI1sj2J58zGcHm4voNotNqphZyZwX9EbGRW94R9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkde5kmR/976bTKKvfzLjm0fxPyDmVuAIvVEL4MLj91WMTzF3
	s0CNZlpEz92JGC2ZP3NJlTKvL/0YmXDfLdoPgzDsiyTRKmkbnQ31hA28TVs2izA=
X-Google-Smtp-Source: AGHT+IEhhYqBn3nyCiGBuavtJ8ryJtYb1IMsp93T4ff7Z0tYx0WdumqYa1pnklichc1LcLUH4By26A==
X-Received: by 2002:a05:6871:e085:b0:278:1c68:9c03 with SMTP id 586e51a60fabf-29051af0d58mr25402481fac.8.1730577435987;
        Sat, 02 Nov 2024 12:57:15 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59c92sm1275993a34.10.2024.11.02.12.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 12:57:15 -0700 (PDT)
Message-ID: <5ee03973-1f14-44eb-b9ac-a41bc9ae474e@sifive.com>
Date: Sat, 2 Nov 2024 14:57:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] riscv: Remove CONFIG_PAGE_OFFSET
To: Jesse T <mr.bossman075@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
 <20241026171441.3047904-7-samuel.holland@sifive.com>
 <CAJFTR8RJYdT6CQ=FgBkM3jUj=PnYnuyi3+bO3=NPeH6xJ6TTaw@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAJFTR8RJYdT6CQ=FgBkM3jUj=PnYnuyi3+bO3=NPeH6xJ6TTaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jesse,

On 2024-10-27 3:25 PM, Jesse T wrote:
> On Sat, Oct 26, 2024 at 1:16 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> The current definition of CONFIG_PAGE_OFFSET is problematic for a couple
>> of reasons:
>>  1) The value is misleading for normal 64-bit kernels, where it is
>>     overridden at runtime if Sv48 or Sv39 is chosen. This is especially
>>     the case for XIP kernels, which always use Sv39.
>>  2) The option is not user-visible, but for NOMMU kernels it must be a
>>     valid RAM address, and for !RELOCATABLE it must additionally be the
>>     exact address where the kernel is loaded.
>>
>> Fix both of these by removing the option.
>>  1) For MMU kernels, drop the indirection through Kconfig. Additionally,
>>     for XIP, drop the indirection through kernel_map.
>>  2) For NOMMU kernels, use the user-visible physical RAM base if
>>     provided. Otherwise, force the kernel to be relocatable.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>

Thanks!

>> ---
>>
>>  arch/riscv/Kconfig               |  8 +-------
>>  arch/riscv/include/asm/page.h    | 15 ++++++++-------
>>  arch/riscv/include/asm/pgtable.h |  2 +-
>>  arch/riscv/mm/init.c             |  8 ++------
>>  4 files changed, 12 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 33aa79d84021..297ccbf4b5ce 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -195,6 +195,7 @@ config RISCV
>>         select PCI_DOMAINS_GENERIC if PCI
>>         select PCI_ECAM if (ACPI && PCI)
>>         select PCI_MSI if PCI
>> +       select RELOCATABLE if !MMU && !PHYS_RAM_BASE_FIXED
>>         select RISCV_ALTERNATIVE if !XIP_KERNEL
>>         select RISCV_APLIC
>>         select RISCV_IMSIC
>> @@ -282,13 +283,6 @@ config MMU
>>           Select if you want MMU-based virtualised addressing space
>>           support by paged memory management. If unsure, say 'Y'.
>>
>> -config PAGE_OFFSET
>> -       hex
>> -       default 0x80000000 if !MMU && RISCV_M_MODE
>> -       default 0x80200000 if !MMU
> 
> Should the default values above now be moved to CONFIG_PHYS_RAM_BASE?

No, there doesn't need to be a default address, because the default behavior is
to be relocatable. If the kernel is running in S-mode, then it does not have
access to all of RAM, because the firmware is using some of it. So in that case
I don't think it makes sense to hardcode any addresses in the kernel.

For M-mode, the default for CONFIG_PHYS_RAM_BASE is already 0x80000000.

Regards,
Samuel

>> -       default 0xc0000000 if 32BIT
>> -       default 0xff60000000000000 if 64BIT
>> -
>>  config KASAN_SHADOW_OFFSET
>>         hex
>>         depends on KASAN_GENERIC
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> index 24d1ac052609..d1acd1efe0dc 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -28,15 +28,16 @@
>>   */
>>  #ifdef CONFIG_MMU
>>  #ifdef CONFIG_64BIT
>> -#define PAGE_OFFSET            kernel_map.page_offset
>> -/*
>> - * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
>> - * define the PAGE_OFFSET value for SV48 and SV39.
>> - */
>> +#define PAGE_OFFSET_L5         _AC(0xff60000000000000, UL)
>>  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
>>  #define PAGE_OFFSET_L3         _AC(0xffffffd600000000, UL)
>> +#ifdef CONFIG_XIP_KERNEL
>> +#define PAGE_OFFSET            PAGE_OFFSET_L3
>>  #else
>> -#define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
>> +#define PAGE_OFFSET            kernel_map.page_offset
>> +#endif /* CONFIG_XIP_KERNEL */
>> +#else
>> +#define PAGE_OFFSET            _AC(0xc0000000, UL)
>>  #endif /* CONFIG_64BIT */
>>  #else
>>  #define PAGE_OFFSET            ((unsigned long)phys_ram_base)
>> @@ -100,7 +101,6 @@ typedef struct page *pgtable_t;
>>  #define ARCH_PFN_OFFSET                (PFN_DOWN((unsigned long)phys_ram_base))
>>
>>  struct kernel_mapping {
>> -       unsigned long page_offset;
>>         unsigned long virt_addr;
>>         unsigned long virt_offset;
>>         uintptr_t phys_addr;
>> @@ -114,6 +114,7 @@ struct kernel_mapping {
>>         uintptr_t xiprom;
>>         uintptr_t xiprom_sz;
>>  #else
>> +       unsigned long page_offset;
>>         unsigned long va_kernel_pa_offset;
>>  #endif
>>  };
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index d0190ee9b2e4..b8125c3aa85d 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -15,7 +15,7 @@
>>  #ifdef CONFIG_RELOCATABLE
>>  #define KERNEL_LINK_ADDR       UL(0)
>>  #else
>> -#define KERNEL_LINK_ADDR       _AC(CONFIG_PAGE_OFFSET, UL)
>> +#define KERNEL_LINK_ADDR       _AC(CONFIG_PHYS_RAM_BASE, UL)
>>  #endif
>>  #define KERN_VIRT_SIZE         (UL(-1))
>>  #else
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 0aad925848a4..a1a185e6faf0 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -843,6 +843,8 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>>         uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
>>         u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
>>
>> +       kernel_map.page_offset = PAGE_OFFSET_L5;
>> +
>>         if (satp_mode_cmdline == SATP_MODE_57) {
>>                 disable_pgtable_l5();
>>         } else if (satp_mode_cmdline == SATP_MODE_48) {
>> @@ -1090,11 +1092,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>         kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
>>
>>  #ifdef CONFIG_XIP_KERNEL
>> -#ifdef CONFIG_64BIT
>> -       kernel_map.page_offset = PAGE_OFFSET_L3;
>> -#else
>> -       kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
>> -#endif
>>         kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
>>         kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
>>
>> @@ -1106,7 +1103,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>         kernel_map.va_kernel_xip_data_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr
>>                                                 + (uintptr_t)&_sdata - (uintptr_t)&_start;
>>  #else
>> -       kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
>>         kernel_map.phys_addr = (uintptr_t)(&_start);
>>         kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
>>         kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>> --
>> 2.45.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


