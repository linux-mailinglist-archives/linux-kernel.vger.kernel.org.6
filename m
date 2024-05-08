Return-Path: <linux-kernel+bounces-172946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612808BF92D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A7D281B11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D55381E;
	Wed,  8 May 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="YEGDdr6n"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F65535D5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158879; cv=none; b=fARRBEFfJ+hlFvqWV5XUde7UcuN2yppXSiL0yAY6owJrClBX4mPjrOxsGx3FyqVSt6ChxYCJyPmV+7/HS3ZJVjDn42sCUijOPF6kwcKm6FzFPIk+iNGalJzcV40AxNkUpuWeeixgnBe52/Ftlo7yrvhwQ8gbpwcVpN9DvELPFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158879; c=relaxed/simple;
	bh=JkP6+eiZhw46lunKytgdnT9Oh1wOlD5bnLpNuf/BUHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPE9xR5YKj99sTbGwpM16eT64vQbmw6RoAU0vu9qf2B9F8bwqVRU/KN6DuqVCh9mf9Io6wTHqsvH6j7bddOi+KcMhbr+0LoknWGk8/lyg0wWbRLaWIwElR1+pwUOrb0lEnNBKIwCNap+s706vsmVKTTV3r23aCx0xu+EHlQ3Cgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=YEGDdr6n; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tjH7M6aUma+Zios2O7UafiQx4LAtq5MpcVX+A3JHUj8=; b=YEGDdr6nkoPywUVGaCZZatD78P
	hBYnQckFCrYii4KQz/nzJZDrcuBH0vlv6FolPa2yz1roRWV3/mQ4tW6Ba/lwD9E36oitEb0QKzBQR
	oKt4ZgJWDiXD7LLzxxHYkT6R1S9sS8aAob1Vq4NnuGl4jvLMuaUhsMAhv7kn5yPh2vMQsXL+vBE7b
	iBvZjvFNUrhh+5tvymSVVwB+hnW6l3mQ2+TT0tUanBsLAXUXRYvk8i+b+eR1wpVKEQCjZaJqUzfB6
	Fj3zlqyQZ1Uc331KCv6pHZGl0oIZB/qrdLUz2j90t7/4LeznnfrDPQMuHXfneL0Rdfl91bTjUv1to
	BPLul6Iw==;
Received: from [63.135.74.212] (helo=[192.168.1.184])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s4dAQ-008QRp-Qs; Wed, 08 May 2024 10:00:50 +0100
Message-ID: <b3ff587a-61f5-4abf-b71f-7ad48ff66969@codethink.co.uk>
Date: Wed, 8 May 2024 10:00:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
 Kconfig option
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-3-722c21c328c6@rivosinc.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-3-722c21c328c6@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 08/05/2024 02:36, Charlie Jenkins wrote:
> The existing "RISCV_ISA_SVNAPOT" option is repurposed to be used to by
> kernel code to determine if either
> PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT or
> PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT has been set.
> 
> PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT will check if the hardware
> supports Svnapot before using it, while
> PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT will assume that the hardware
> supports Svnapot.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/riscv/Kconfig               | 19 -----------------
>   arch/riscv/Kconfig.isa           | 44 ++++++++++++++++++++++++++++++++++++++++
>   arch/riscv/include/asm/pgtable.h |  3 ++-
>   3 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c2e9eded0a7d..3c1960e8cd7c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -484,25 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
>   	help
>   	  Allows early patching of the kernel for special errata
>   
> -config RISCV_ISA_SVNAPOT
> -	bool "Svnapot extension support for supervisor mode NAPOT pages"
> -	depends on 64BIT && MMU
> -	depends on RISCV_ALTERNATIVE
> -	default y
> -	help
> -	  Add support for the Svnapot ISA-extension in the kernel when it
> -	  is detected at boot.
> -
> -	  The Svnapot extension is used to mark contiguous PTEs as a range
> -	  of contiguous virtual-to-physical translations for a naturally
> -	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
> -	  size. When HUGETLBFS is also selected this option unconditionally
> -	  allocates some memory for each NAPOT page size supported by the kernel.
> -	  When optimizing for low memory consumption and for platforms without
> -	  the Svnapot extension, it may be better to say N here.
> -
> -	  If you don't know what to do here, say Y.
> -
>   config RISCV_ISA_SVPBMT
>   	bool "Svpbmt extension support for supervisor mode page-based memory types"
>   	depends on 64BIT && MMU
> diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
> index 0663c98b5b17..37585bcd763e 100644
> --- a/arch/riscv/Kconfig.isa
> +++ b/arch/riscv/Kconfig.isa
> @@ -124,3 +124,47 @@ config RISCV_ISA_V_PREEMPTIVE
>   	  This config allows kernel to run SIMD without explicitly disable
>   	  preemption. Enabling this config will result in higher memory
>   	  consumption due to the allocation of per-task's kernel Vector context.
> +
> +config RISCV_ISA_SVNAPOT
> +	bool
> +
> +choice
> +	prompt "Svnapot extension support for supervisor mode NAPOT pages"
> +	default PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
> +	help
> +	  This selects the level of support for Svnapot in the Linux Kernel.
> +
> +	  The Svnapot extension is used to mark contiguous PTEs as a range
> +	  of contiguous virtual-to-physical translations for a naturally
> +	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
> +	  size. When HUGETLBFS is also selected this option unconditionally
> +	  allocates some memory for each NAPOT page size supported by the kernel.
> +	  When optimizing for low memory consumption and for platforms without
> +	  the Svnapot extension, it may be better to prohibit Svnapot.
> +
> +config PROHIBIT_RISCV_ISA_SVNAPOT
> +	bool "Prohibit Svnapot extension"
> +	help
> +	  Regardless of if the platform supports Svnapot, prohibit the kernel
> +	  from using Svnapot.
> +
> +config PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
> +	bool "Allow Svnapot extension if supported"
> +	depends on 64BIT && MMU
> +	depends on RISCV_ALTERNATIVE
> +	select RISCV_ISA_SVNAPOT
> +	help
> +	  Add support for the Svnapot ISA-extension in the kernel when it
> +	  is detected at boot.
> +
> +config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
> +	bool "Emit Svnapot mappings when building Linux"
> +	depends on 64BIT && MMU
> +	depends on NONPORTABLE
> +	select RISCV_ISA_SVNAPOT
> +	help
> +	  Compile a kernel that assumes that the platform supports Svnapot.
> +	  This option produces a kernel that will not run on systems that do
> +	  not support Svnapot.
> +
> +endchoice
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 6afd6bb4882e..432be9691b78 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -289,7 +289,8 @@ static inline pte_t pud_pte(pud_t pud)
>   
>   static __always_inline bool has_svnapot(void)
>   {
> -	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
> +	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT) ||
> +	       riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);

could you add the IS_ENABLED(*) check into riscv_has_extension_likely
and other such functions?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


