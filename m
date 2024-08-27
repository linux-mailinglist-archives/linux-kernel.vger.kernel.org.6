Return-Path: <linux-kernel+bounces-304098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1084961A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C21C22E09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E771D417F;
	Tue, 27 Aug 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="TVKQ28mD"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FF84A2F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800225; cv=none; b=Nysy+S31Ly5367D6ORMsg8J6JkipgICXdGqsF8w7l9MO7zfiqLuAlUZ/y3foi2t4xujFVAcrIeN6IzX9eYwib2tej1bYAvgXRtsIQOmowmUz11QXmHclyENGQepYM7AUFxFWH3npS+lsglT+aNxDkPnKBams2UJ9Id1vVI3ayJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800225; c=relaxed/simple;
	bh=Ms7piF5thBQY/yUT4ix5SOgQEAlf9cszcTCRdCSSng0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2MgI8OUUnq7XHgYUrbMzGilv3LmBFXZM0AYZORnzV8OOxeontpJvwGlYVNV5HvXONxFVknKK31OEU4Qvn6F1B5Hmg1wyYiRf5FBmNVQStfnY9sC93FM5Wv5CSxxUWynJi5OChEXPoRD8Isop8q/pi1TePN5hLnNgfbcAqb8F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=TVKQ28mD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7141e20e31cso5083406b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1724800222; x=1725405022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W32QRSPB+v/v1hZB3DM0yi6GVvOLbgl8fIqle8GTQRg=;
        b=TVKQ28mDknkn2Q0GmBrBua2BhkgQNbaoI+PBa+krPBK47wvnW5LrTU/ntZLhv0Hz0X
         7PG1YG7VWYSmfvLiaYuM9K3Qg/HWyFSzoHcNCPNtmt5sSxHo/Q/mkaArfeCe4IXUIvo2
         2zoFjoBubU1O203OVMPPEOTCA9QGYsFmiEHFwztSnvg9hlejkmiSNHz/AFYpOofcAI8+
         0IFDsF+wPVHbQ29ISkwCxJeWR91THctsb0PsXSPigNRhF5SeelgY0gpYpfQIFBGus6PS
         b26kB0xIKc9K7oz/3d8RofQW1eVF6azBrJrQ8svuBalSWbQzGsXHQQ4JZ1kJOSk+gcTA
         Gd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800222; x=1725405022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32QRSPB+v/v1hZB3DM0yi6GVvOLbgl8fIqle8GTQRg=;
        b=mjLkB5vjSuI5gaAQiYXYcs9Xd80KT5OJHtJ4qS0SS67c/pYGxhbacFjI3b9gwrdHfB
         46L+H/loOX46Cm+idD52/qx3Sl0JsMwnKYfZUoSyn3IwqyqpSkNZ+U9g+nNTCvJNxnuO
         k4TCiujpuQpk9wJ8M0iI8MDdK5nsvAjSKZBlg+Cwm/iULu+qbyBRDmxwM1QjwjaX4iuk
         d1q84uNgrpsF2M37f/XXLRadZmKsfXChrWc52n7hEpjUJq48DVIGkYRC39Ppv1lJeekk
         /SJD1VnoIL4o5hwqD5udM5kPquadUgqfSl+VMYvwps0XaFpCAHDd2smH2oXhJNrqXr9X
         VLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjUXp0udR9RZVHLwKvWHOGHI3MHr+sNmja7mn8TklXt6cZ3U02sN5KQzZKzF3HI3HbCPm0PeeI76jH6dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTsd/l2OMkshCWMH3gjRzvrc9r+A2arq7LNrnwnZT1b1pfhMR
	fgt5k26nKeMosPM06EJvdtqTh1L7i9V6Zv4jtI+s1Z5ti/so9A/iHAtIjqDG79w=
X-Google-Smtp-Source: AGHT+IEroGkXS6DzUhuTL3usdmL+nViyF25HwRxsfbE8sxGqcjS2RSN8mHQbCRPygBZgO5SnMudlIw==
X-Received: by 2002:a05:6a20:c6ce:b0:1ca:dbec:c5d2 with SMTP id adf61e73a8af0-1ccd28675a7mr85752637.5.1724800222214;
        Tue, 27 Aug 2024 16:10:22 -0700 (PDT)
Received: from x1 (75-164-215-68.ptld.qwest.net. [75.164.215.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430c407sm9369816b3a.178.2024.08.27.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 16:10:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:10:20 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Message-ID: <Zs5c3KJR41AUVyEv@x1>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>

On Tue, Aug 27, 2024 at 02:36:11PM +0300, Vladimir Kondratiev wrote:
> It is not necessary any RISCV platform has ZONE_DMA32.
> 
> Example - if platform has no DRAM in [0..4G] region,
> it will report failure like below each boot.
> 
> [    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
> [    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
> [    0.088864] Call Trace:
> [    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
> [    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
> [    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
> [    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
> [    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
> [    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
> [    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
> [    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
> [    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
> [    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
> [    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
> [    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
> [    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c
> 
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>  arch/riscv/Kconfig | 2 +-
>  mm/Kconfig         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..94a573112625 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -50,6 +50,7 @@ config RISCV
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAS_VDSO_DATA
> +	select ARCH_HAS_ZONE_DMA_SET if 64BIT
>  	select ARCH_KEEP_MEMBLOCK if ACPI
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> @@ -200,7 +201,6 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> -	select ZONE_DMA32 if 64BIT
>  
>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
>  	def_bool CC_IS_CLANG
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f78..97c85da98e89 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1032,7 +1032,7 @@ config ZONE_DMA
>  config ZONE_DMA32
>  	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
>  	depends on !X86_32
> -	default y if ARM64
> +	default y if ARM64 || (RISCV && 64BIT)
>  
>  config ZONE_DEVICE
>  	bool "Device memory (pmem, HMM, etc...) hotplug support"
> -- 
> 2.37.3
> 

Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>

Thanks for sending this patch as I've also encountered that annoying
error on systems with DRAM above 4GB.

I tested this patch by changing the qemu virt machine to have DRAM
starting at 2^32:

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cef41c150aaf..3033a2560edb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -87,7 +87,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_PCIE_ECAM] =    { 0x30000000,    0x10000000 },
     [VIRT_PCIE_MMIO] =    { 0x40000000,    0x40000000 },
-    [VIRT_DRAM] =         { 0x80000000,           0x0 },
+    [VIRT_DRAM] =        { 0x100000000,           0x0 },
 };
 
 /* PCIe high mmio is fixed for RV32 */

