Return-Path: <linux-kernel+bounces-195628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475748D4F80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775711C23499
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C652032D;
	Thu, 30 May 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhEtFDh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F21F94C;
	Thu, 30 May 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084681; cv=none; b=WvgiVl6hVStlpqbp11eZhDbOcCQc3xiS+TJ4lDxlejSfUWOKU3oh4rjqu2HQTZhRcRbOdcQcJKf7JJag40P3DHa9LcDAghDWVDEXXeeynip7bjkEzw/j9McuFqfGDqQqiitEMNsR+MQXxocmpGC6zLDRy+3VGeffGs0H6s6Jt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084681; c=relaxed/simple;
	bh=zY+OVKzxA8PmRaPqqnlec7h81ltBTYbGpiadV8zvQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UioB8apVF7SdmDT4nmEi6v3E2Bz9sEKy1LJr8md19PoLBoKdq7V7cuKt9EvxEA8lS9zivZPvQa9SIRWlOKLmIhv8OhLIKHmeNGaEwS+eatHSHiARhQJbpr5BpQi0tybTs5A7xve5cYYwy/2qL8lcWsltOV+VRtxqnQdpD8PTX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhEtFDh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA5CC2BBFC;
	Thu, 30 May 2024 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717084681;
	bh=zY+OVKzxA8PmRaPqqnlec7h81ltBTYbGpiadV8zvQj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhEtFDh2W2hBa/sIc0sOJKfsT/bjJECDFzQBlHUnbAgiTh4vxph9YXTIevp8SQ5uX
	 afD4YYijCKbHRIGarKwVAVRrU5g46XKwVrENs5Zhawf6YVNTKRl97HfFYzfjsJIzrK
	 dbRPPx8k0T5duEaxSWd58qkLLEtFDhi/mEER924buDMRT5fzqvuM2T5t30Sn+1EL69
	 bhj4MT0cBObDeyhqU5YEr1kNoAy/H/Kio0/invkh/G0mdjoDVo2g+xj3Z89Qi50clQ
	 wkLLrHi8Aiac/UOZ4nwBhFh6XDR05Pv6IsUc8esSk0q+5pS2q/fODowAOpC/1pLD5T
	 7w9nNcM2oQjpw==
Date: Thu, 30 May 2024 08:57:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH 1/2] x86/percpu: Fix "multiple identical address spaces
 specified for type" clang warning
Message-ID: <20240530155758.GA2974773@thelio-3990X>
References: <20240526175655.227798-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526175655.227798-1-ubizjak@gmail.com>

On Sun, May 26, 2024 at 07:55:52PM +0200, Uros Bizjak wrote:
> The clang build with named address spaces enabled currently fails with:
> 
> error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
> 
> The warning is emitted when accessing const_pcpu_hot structure,
> which is already declared in __seg_gs named address space.
> 
> Use specialized accessor for __raw_cpu_read_const() instead, avoiding
> redeclaring __seg_gs named address space via __raw_cpu_read().
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Thanks, this resolves the warning for me when patch 2 is applied.

Acked-by: Nathan Chancellor <nathan@kernel.org>

However, as both of us have noticed [1][2], there is a problem in LLVM's
x86 backend with the address space casting that the kernel does, so
patch 2 should not be merged.

[1]: https://github.com/ClangBuiltLinux/linux/issues/2013
[2]: https://github.com/llvm/llvm-project/issues/93449

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> ---
>  arch/x86/include/asm/percpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index c55a79d5feae..aeea5c8a17de 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -160,7 +160,10 @@ do {									\
>  	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
>  } while (0)
>  
> -#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
> +#define __raw_cpu_read_const(pcp)					\
> +({									\
> +	*(typeof(pcp) *)(__force uintptr_t)(&(pcp));			\
> +})
>  
>  #else /* !CONFIG_USE_X86_SEG_SUPPORT: */
>  
> -- 
> 2.42.0
> 

