Return-Path: <linux-kernel+bounces-256303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E6934C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE01C2193F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CF112A14C;
	Thu, 18 Jul 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZsF02yT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6B12EBCA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301073; cv=none; b=k0wPjugmFDcI6alZCs5YAy+l/+7g/SxjE+Hq/Vl9SpCyjt3efH6G0WNNQAdn/o+peCBDRxgD6RyLSF2hvYM7JEVoPcIk3iS+3M6ch2WI0uLujyck8Y086llvQyWspr5iR6OVk7wFSBQbqbQjXdVt1c8Q7WmEnY+JsQaHg+I5AEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301073; c=relaxed/simple;
	bh=cuttWEZD3FpxypnUQ9jmCx45XcqKjZqgckz4XijONwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLarNp0/VyQ3Q0DFXmwuEViC5uZepB2VdAnlgZuaVplx4ULigzXDYxBYJuLNIzMWH7doXW1asqhheZKdw4YTibNIz0fnF6aSZa1grMxEd+G5gSIr+GEqs56n2a7gK9xIR26Va9QdFWitQzilVFJ4KD4U3rY2/7iK7bHDQYJPa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZsF02yT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721301070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSODUOEexthmLgwTf2Q/7unpL442Tw+C3z/R5dCTkQc=;
	b=BZsF02yTayvWAlfHYGM1Xt68rz7cfWVsdoyVnpve7aB/etE9rt4pUCZt6Xnmv2HUlbraPw
	dAmp3JAv0z+6iHd+MRaAlTWkhw+LOaoxumxvUWmVUhEZ95+QxvJtaMmekK5u5L4GUJrm1W
	pbjj9/A2OuVfqCGpKWdEq0gLM2stWgQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-8UIMRK83NRqlsiS1CiZDTA-1; Thu,
 18 Jul 2024 07:11:06 -0400
X-MC-Unique: 8UIMRK83NRqlsiS1CiZDTA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F9E1955D4F;
	Thu, 18 Jul 2024 11:11:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEE0319560B2;
	Thu, 18 Jul 2024 11:10:53 +0000 (UTC)
Date: Thu, 18 Jul 2024 19:10:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, vgoyal@redhat.com,
	dyoung@redhat.com, arnd@arndb.de, afd@ti.com,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org,
	javierm@redhat.com, deller@gmx.de, robh@kernel.org,
	hbathini@linux.ibm.com, thunder.leizhen@huawei.com,
	chenjiahao16@huawei.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] crash: Fix x86_32 crash memory reserve dead loop
 bug
Message-ID: <Zpj4OUsTPshBK4JZ@MiWiFi-R3L-srv>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
 <20240718035444.2977105-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718035444.2977105-2-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/18/24 at 11:54am, Jinjie Ruan wrote:
> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=1G,high"
> will cause system stall as below:
> 
> 	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
> 	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
> 	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
> 	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
> 	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
> 	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
> 	143MB HIGHMEM available.
> 	879MB LOWMEM available.
> 	  mapped low ram: 0 - 36ffe000
> 	  low ram: 0 - 36ffe000
> 	 (stall here)
> 
> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
> on x86_32, the first high crash kernel memory reservation will fail, then
> go into the "retry" loop and never came out as below.
> 
> -> reserve_crashkernel_generic() and high is true
>  -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
>     -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
>        (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> Fix it by prevent crashkernel=,high from being parsed successfully on 32bit
> system with a architecture-defined macro.
> 
> After this patch, the 'crashkernel=,high' for 32bit system can't succeed,
> and it has no chance to call reserve_crashkernel_generic(), therefore this
> issue on x86_32 is solved.
> 
> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Just adding my Suggested-by is fine. If multiple people cooperate on one
patch, the Co-developed-by tag is needed. As a maintainer, I prefer to
have the Suggested-by tag in this case.

> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>

You can't add Tested-by tag for your own patch. When you post patch,
testing it is your obligation.

Other than these tag adding concerns, this patch looks good to me. You
can post v4 to update and add my:

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> v3:
> - Fix it as Baoquan suggested.
> - Update the commit message.
> v2:
> - Peel off the other two patches.
> - Update the commit message and fix tag.
> ---
>  arch/arm64/include/asm/crash_reserve.h | 2 ++
>  arch/riscv/include/asm/crash_reserve.h | 2 ++
>  arch/x86/include/asm/crash_reserve.h   | 1 +
>  kernel/crash_reserve.c                 | 2 +-
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
> index 4afe027a4e7b..bf362c1a612f 100644
> --- a/arch/arm64/include/asm/crash_reserve.h
> +++ b/arch/arm64/include/asm/crash_reserve.h
> @@ -7,4 +7,6 @@
>  
>  #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
> +
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  #endif
> diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
> index 013962e63587..8d7a8fc1d459 100644
> --- a/arch/riscv/include/asm/crash_reserve.h
> +++ b/arch/riscv/include/asm/crash_reserve.h
> @@ -7,5 +7,7 @@
>  #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
>  
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
> +
>  extern phys_addr_t memblock_end_of_DRAM(void);
>  #endif
> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> index 7835b2cdff04..24c2327f9a16 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
> @@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
>  #else
>  # define CRASH_ADDR_LOW_MAX     SZ_4G
>  # define CRASH_ADDR_HIGH_MAX    SZ_64T
> +#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  #endif
>  
>  # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..c5213f123e19 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
>  	/* crashkernel=X[@offset] */
>  	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
>  				crash_base, NULL);
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>  	/*
>  	 * If non-NULL 'high' passed in and no normal crashkernel
>  	 * setting detected, try parsing crashkernel=,high|low.
> -- 
> 2.34.1
> 


