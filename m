Return-Path: <linux-kernel+bounces-193794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217038D3241
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823841F22082
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55815176FD3;
	Wed, 29 May 2024 08:47:53 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F0175545
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972472; cv=none; b=Wtrek0Y6KLcGmvjNAIBDNrAmu91xHw1myLCrUPljnQs+nRBbOQY/zJgwNmtX3tXSE/dp1h4/y/IT+ZsnCaB2Fg1QREW5OX2NunaPIzQl+etQ0LIrFcdIiu9XpqdyCrGbj0vttHvJuV8aopXKU6/GzPNvp9UhOfbI3XV7bX0KuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972472; c=relaxed/simple;
	bh=QPLz+5EPc7RiBkWK7FqfnbKNVxm6qHft5JAgAcNdaFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiZZ4xWcot6xFF1ReoKySxLFAJpXXXhWwaih+DipP//3jqCDO0r/WGpcR9RpyV+lVcbIYDiZnlppaqJUXQiYJIMJCMpSuoDF8wwAH8R2i9eKBi67mRD/eahxoQgHK3+AuKmBaMWrs9lrDcmbmdCEAhHOQuhAvoMAQ6no03X+moQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 847A5E000A;
	Wed, 29 May 2024 08:47:41 +0000 (UTC)
Message-ID: <f2a3bddd-0cc1-43ca-8421-1d67dd2800f8@ghiti.fr>
Date: Wed, 29 May 2024 10:47:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] RISC-V: clarify what some RISCV_ISA* config
 options do
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, xiao.w.wang@intel.com,
 Andrew Jones <ajones@ventanamicro.com>, pulehui@huawei.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-varnish-status-9c22973093a0@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240528-varnish-status-9c22973093a0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 28/05/2024 13:11, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> During some discussion on IRC yesterday and on Pu's bpf patch [1]
> I noticed that these RISCV_ISA* Kconfig options are not really clear
> about their implications. Many of these options have no impact on what
> userspace is allowed to do, for example an application can use Zbb
> regardless of whether or not the kernel does. Change the help text to
> try and clarify whether or not an option affects just the kernel, or
> also userspace. None of these options actually control whether or not an
> extension is detected dynamically as that's done regardless of Kconfig
> options, so drop any text that implies the option is required for
> dynamic detection, rewording them as "do x when y is detected".
>
> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..3b702e6cc051 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -501,7 +501,8 @@ config RISCV_ISA_C
>   	help
>   	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
>   	  when building Linux, which results in compressed instructions in the
> -	  Linux binary.
> +	  Linux binary. This option produces a kernel that will not run on
> +	  systems that do not support compressed instructions.
>   
>   	  If you don't know what to do here, say Y.
>   
> @@ -511,8 +512,8 @@ config RISCV_ISA_SVNAPOT
>   	depends on RISCV_ALTERNATIVE
>   	default y
>   	help
> -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> -	  time and enable its usage.
> +	  Add support for the Svnapot ISA-extension in the kernel when it
> +	  is detected at boot.


To me, the new version makes things even more confusing: svnapot 
mappings will indeed be handled by the kernel (since only the kernel 
sets up the page tables) but it will only be used (for now) for HugeTLB 
mappings in userspace.


>   
>   	  The Svnapot extension is used to mark contiguous PTEs as a range
>   	  of contiguous virtual-to-physical translations for a naturally
> @@ -530,9 +531,8 @@ config RISCV_ISA_SVPBMT
>   	depends on RISCV_ALTERNATIVE
>   	default y
>   	help
> -	   Adds support to dynamically detect the presence of the Svpbmt
> -	   ISA-extension (Supervisor-mode: page-based memory types) and
> -	   enable its usage.
> +	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> +	   page-based memory types) in the kernel when it is detected at boot.
>   
>   	   The memory type for a page contains a combination of attributes
>   	   that indicate the cacheability, idempotency, and ordering
> @@ -551,14 +551,15 @@ config TOOLCHAIN_HAS_V
>   	depends on AS_HAS_OPTION_ARCH
>   
>   config RISCV_ISA_V
> -	bool "VECTOR extension support"
> +	bool "Vector extension support"
>   	depends on TOOLCHAIN_HAS_V
>   	depends on FPU
>   	select DYNAMIC_SIGFRAME
>   	default y
>   	help
> -	  Say N here if you want to disable all vector related procedure
> -	  in the kernel.
> +	  Add support for the Vector extension when it is detected at boot.
> +	  When this option is disabled, neither the kernel nor userspace may
> +	  use vector procedures.
>   
>   	  If you don't know what to do here, say Y.
>   
> @@ -616,8 +617,8 @@ config RISCV_ISA_ZBB
>   	depends on RISCV_ALTERNATIVE
>   	default y
>   	help
> -	   Adds support to dynamically detect the presence of the ZBB
> -	   extension (basic bit manipulation) and enable its usage.
> +	   Add support for enabling optimisations in the kernel when the
> +	   Zbb extension is detected at boot.
>   
>   	   The Zbb extension provides instructions to accelerate a number
>   	   of bit-specific operations (count bit population, sign extending,
> @@ -633,9 +634,9 @@ config RISCV_ISA_ZICBOM
>   	select RISCV_DMA_NONCOHERENT
>   	select DMA_DIRECT_REMAP
>   	help
> -	   Adds support to dynamically detect the presence of the ZICBOM
> -	   extension (Cache Block Management Operations) and enable its
> -	   usage.
> +	   Add support for the Zicbom extension (Cache Block Management
> +	   Operations) and enable its use in the kernel when it is detected
> +	   at boot.
>   
>   	   The Zicbom extension can be used to handle for example
>   	   non-coherent DMA support on devices that need it.
> @@ -648,7 +649,7 @@ config RISCV_ISA_ZICBOZ
>   	default y
>   	help
>   	   Enable the use of the Zicboz extension (cbo.zero instruction)
> -	   when available.
> +	   in the kernel when it is detected at boot.
>   
>   	   The Zicboz extension is used for faster zeroing of memory.
>   
> @@ -693,8 +694,9 @@ config FPU
>   	bool "FPU support"
>   	default y
>   	help
> -	  Say N here if you want to disable all floating-point related procedure
> -	  in the kernel.
> +	  Add support for floating point operations when an FPU is detected at
> +	  boot. When this option is disabled, neither the kernel nor userspace
> +	  may use the floating point unit.
>   
>   	  If you don't know what to do here, say Y.
>   

