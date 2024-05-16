Return-Path: <linux-kernel+bounces-180646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D11C8C7140
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDF71F240F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8D28385;
	Thu, 16 May 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wwUVhVC0"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FC282EB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835536; cv=none; b=riB4+l0df7qu3LapRMHdGZAvu44ELmbnow75A1QTZoxqu3eKxwLqoJFtk6SUT8MLeOLMadlsBi7K0YjS9WyHHcTM+vajctDX+kdUl4XXFQX6LAqSEPh5lfUoKGdNUYSjib321w/gCo2Q2GUAsdhXTXYs0wD8dzVt/I7wr4cm6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835536; c=relaxed/simple;
	bh=LN9tVWO3qoa8ScsjnGIed9WEOSDYEook1xUmeJg9sis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klNowDVNcsT+Rrf4D1LkBTb++1MjKFlLPCu33edF5MRVZ3jaCo7zRPmayd0PjWADJtZ0Gf96ZJLdWI66wptV4QJBQrv6MiMoMfoemIHJ6/1TmyiOvcvEoHFSVmEho0LeZ44HKQlAho+wIE3HFgPIOnG0Z+790YafgSniyE73fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wwUVhVC0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dca1efad59so5650141a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715835533; x=1716440333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTSdj0J0ohQfIN2Zi+05yVLixxog7dNtfShb6uY41gE=;
        b=wwUVhVC0KdAntbOtkz5Wrf0VNQs4LN/ZBB39vxFSqoORcuxxBdruwXwYLBQAcaEdsg
         h8A0Kq7c6jkRJ/EQNjYEt/cD6oiBRz14CqYufFsFaYfpWonSt7O14SAcFZyV8XVaccam
         TFbPBhKNvkM1eluVknP5ApcGwo4/xyrDXRvPO5PiBx4wVBD1TCijLSzdcWq8tzp+sTR4
         fwkve6U5G6CQLpokEc7+4zVkivhaHh5ZB+sELVx5Kb/HP1PPEzda1ZkZbqvW1pwcmKw/
         GfTtVNo041Be1Nz4KzNjFOvIRKEB2VlaopHoqiuSJYpUTJqvf3wCHRh2B1+cSIbVNr/4
         WwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835533; x=1716440333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTSdj0J0ohQfIN2Zi+05yVLixxog7dNtfShb6uY41gE=;
        b=Br24M3LlcTGSWSyMtuE7nA/n3U5T40dGRJKH2DVkPdUhwIeg6GyzQVtsd3RhVc2CwB
         hLyoPcfQEYSWuY913usmH0urphcdb3P9LKn0nY3KnTTDiNMhtMJc6qUM9ey1NIpZx37H
         Ix4ixDz0uNAUaIXdOfV0Lg7Mukg/1xFl9GDUTstx7G1ycIg5e3SZ8FmyE2R5iuzRqc33
         VY7t3B5dDx2Ns+7ggjKuC1oUPKav9xdlVB15z7QDknsgHP6WZTUCgZHgSkAXWO/kQW6Y
         HH9v6mSfe4mOdKlQczibgyJm+v5Mml9TC4P0xd+B2TLTgn8QxfstZUSrBtfGYYiackbY
         rtnA==
X-Forwarded-Encrypted: i=1; AJvYcCVyWQQVHgF2AxgQ/vOXzy1oCvCpit0De+zPkY+9vP4In84ojKa9RvVA/OQFECjoXCxCvJJPW/VgZ74Vo/1NYuR8hh0GEyMPB1WYLUDh
X-Gm-Message-State: AOJu0YwIL5y1ukdOx81/1K/RlB3u2gORxFf2qbVVNqCZUcV8w4t52lG5
	iRTAyhxki34F5IYUJw5uchVuC7PndSfHKbD9nS7TAJfDI8jcmx209k5ehPTPpTA=
X-Google-Smtp-Source: AGHT+IHWktKOQnC3021sITYZulmoyXKxZd77raBVrIuG1Z0WF/w1GeVm313YjA+3EucPc9xtmVHfrg==
X-Received: by 2002:a05:6a20:9747:b0:1af:cf63:3742 with SMTP id adf61e73a8af0-1afde1b0193mr16224620637.42.1715835533364;
        Wed, 15 May 2024 21:58:53 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad63bcsm128800265ad.75.2024.05.15.21.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 21:58:52 -0700 (PDT)
Date: Wed, 15 May 2024 21:58:50 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, xiao.w.wang@intel.com,
	Andrew Jones <ajones@ventanamicro.com>, pulehui@huawei.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: separate Zbb optimisations requiring and not
 requiring toolchain support
Message-ID: <ZkWSioeSHh8p3pxM@ghost>
References: <20240515-hedging-passage-44fd394ab1be@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-hedging-passage-44fd394ab1be@spud>

On Wed, May 15, 2024 at 04:27:40PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> It seems a bit ridiculous to require toolchain support for BPF to
> assemble Zbb instructions, so introduce hidden a Kconfig option that
> controls the use of any toolchain-requiring optimisations while support
> is available.
> 
> Zbb support has always depended on alternatives, so while adjusting the
> config options guarding optimisations, remove any checks for
> whether or not alternatives are enabled.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> This patch stems out of a conversation about Zba optimisations in BPF.
> I'm not super sold on the approach in all honesty, even though we
> recently had a conversation about respecting the Kconfig options - but
> at this point I'd be convinced to just add some wording to the Kconfig
> options mentioning that BPF optimisations are excluded.
> Having hidden options that mean someone can turn what on what they
> think are Zbb optimisations but not actually get any cos their toolchain
> doesn't support it seems crap to me. I don't wanna add another
> user-visible option for that situation cos I wanna try to minimise the
> extent of our extension-related Kconfig options, not blow them up like
> Augustus Gloop!
> 
> Cheers,
> Conor.
> 
> CC: xiao.w.wang@intel.com
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: pulehui@huawei.com
> CC: Charlie Jenkins <charlie@rivosinc.com>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig                    | 15 ++++++++++++---
>  arch/riscv/include/asm/arch_hweight.h |  4 ++--
>  arch/riscv/include/asm/bitops.h       |  4 ++--
>  arch/riscv/include/asm/checksum.h     |  3 +--
>  arch/riscv/lib/csum.c                 |  9 +++------
>  arch/riscv/lib/strcmp.S               |  4 ++--
>  arch/riscv/lib/strlen.S               |  4 ++--
>  arch/riscv/lib/strncmp.S              |  4 ++--
>  8 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e927b52b420c..f216a52ed181 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -605,14 +605,23 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
>  	depends on AS_HAS_OPTION_ARCH
>  
> -config RISCV_ISA_ZBB
> -	bool "Zbb extension support for bit manipulation instructions"
> +config RISCV_ISA_ZBB_ALT
> +	def_bool RISCV_ISA_ZBB
>  	depends on TOOLCHAIN_HAS_ZBB
>  	depends on RISCV_ALTERNATIVE
> +	help
> +	  This option controls whether or not we build optimisations that
> +	  depend on toolchain support. It's automatically enabled whenever the
> +	  toolchain in use supports assembling Zbb instructions and
> +	  RISCV_ISA_ZBB is set.
> +
> +config RISCV_ISA_ZBB
> +	bool "Zbb extension support for bit manipulation instructions"
>  	default y
>  	help
>  	   Add support for enabling optimisations in the kernel when the
> -	   Zbb extension is detected at boot.
> +	   Zbb extension is detected at boot. Some optimisations may
> +	   additionally depend on toolchain support for Zbb.
>  
>  	   The Zbb extension provides instructions to accelerate a number
>  	   of bit-specific operations (count bit population, sign extending,
> diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
> index 85b2c443823e..a677f6b82228 100644
> --- a/arch/riscv/include/asm/arch_hweight.h
> +++ b/arch/riscv/include/asm/arch_hweight.h
> @@ -19,7 +19,7 @@
>  
>  static __always_inline unsigned int __arch_hweight32(unsigned int w)
>  {
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#ifdef CONFIG_RISCV_ISA_ZBB_ALT
>  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> @@ -50,7 +50,7 @@ static inline unsigned int __arch_hweight8(unsigned int w)
>  #if BITS_PER_LONG == 64
>  static __always_inline unsigned long __arch_hweight64(__u64 w)
>  {
> -# ifdef CONFIG_RISCV_ISA_ZBB
> +# ifdef CONFIG_RISCV_ISA_ZBB_ALT
>  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 880606b0469a..3ed810a6123d 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,7 +15,7 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>  
> -#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> +#if !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE)
>  #include <asm-generic/bitops/__ffs.h>
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/ffs.h>
> @@ -175,7 +175,7 @@ static __always_inline int variable_fls(unsigned int x)
>  	 variable_fls(x_);					\
>  })
>  
> -#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */
> +#endif /* !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE) */
>  
>  #include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls64.h>
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> index 88e6f1499e88..956224ea8199 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -49,8 +49,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
>  	 * worth checking if supported without Alternatives.
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
>  		unsigned long fold_temp;
>  
>  		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 7fb12c59e571..7a97394c252b 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -44,8 +44,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  	 * Zbb support saves 4 instructions, so not worth checking without
>  	 * alternatives if supported
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
>  		unsigned long fold_temp;
>  
>  		/*
> @@ -161,8 +160,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
>  	 * Zbb support saves 6 instructions, so not worth checking without
>  	 * alternatives if supported
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
>  		unsigned long fold_temp;
>  
>  		/*
> @@ -248,8 +246,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
>  	 * Zbb support saves 6 instructions, so not worth checking without
>  	 * alternatives if supported
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
>  		unsigned long fold_temp;
>  
>  		/*
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 687b2bea5c43..a4dd2ac306f1 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -8,7 +8,7 @@
>  /* int strcmp(const char *cs, const char *ct) */
>  SYM_FUNC_START(strcmp)
>  
> -	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
> +	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)
>  
>  	/*
>  	 * Returns
> @@ -43,7 +43,7 @@ SYM_FUNC_START(strcmp)
>   * The code was published as part of the bitmanip manual
>   * in Appendix A.
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#ifdef CONFIG_RISCV_ISA_ZBB_ALT
>  strcmp_zbb:
>  
>  .option push
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> index 8ae3064e45ff..3ab1310a7b83 100644
> --- a/arch/riscv/lib/strlen.S
> +++ b/arch/riscv/lib/strlen.S
> @@ -8,7 +8,7 @@
>  /* int strlen(const char *s) */
>  SYM_FUNC_START(strlen)
>  
> -	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
> +	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)

I appreciate the direction this is going in, getting rid of the
CONFIG_RISCV_ALTERNATIVE checks in the code that checks
CONFIG_RISCV_ISA_ZBB is a great change.

I am missing why these str functions are changed to use
CONFIG_RISCV_ISA_ZBB_ALT when the __arch_hweight* functions were left as
using CONFIG_RISCV_ISA_ZBB in their alternatives.

- Charlie

>  
>  	/*
>  	 * Returns
> @@ -33,7 +33,7 @@ SYM_FUNC_START(strlen)
>  /*
>   * Variant of strlen using the ZBB extension if available
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#ifdef CONFIG_RISCV_ISA_ZBB_ALT
>  strlen_zbb:
>  
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index aba5b3148621..aeed830804d7 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -8,7 +8,7 @@
>  /* int strncmp(const char *cs, const char *ct, size_t count) */
>  SYM_FUNC_START(strncmp)
>  
> -	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
> +	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)
>  
>  	/*
>  	 * Returns
> @@ -46,7 +46,7 @@ SYM_FUNC_START(strncmp)
>  /*
>   * Variant of strncmp using the ZBB extension if available
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#ifdef CONFIG_RISCV_ISA_ZBB_ALT
>  strncmp_zbb:
>  
>  .option push
> -- 
> 2.43.0
> 

