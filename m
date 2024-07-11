Return-Path: <linux-kernel+bounces-249955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E75592F222
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C20B20BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D581A01D1;
	Thu, 11 Jul 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gTRGSGZn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030119F497
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737560; cv=none; b=CPdEAW7DGCdUt5Kh1tYFCBnAU77rPJVpsFvUBoJnwgD5bKn6M68OyVrix9XvQa8FPMQZnj3+Ibf7PLh5edy+yhrj+5DwX1CUmvNlVMgT+etmHT9zqAfl+E5GMtC2E1P7qWBiCO/BQJLPlspLw4jlZ/bybInflkjC4nnnT0AkR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737560; c=relaxed/simple;
	bh=HDyXJ8S+KYvgzqidXWyMUnXsE5rJOctGkPASw2p9WBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR4XwLLmcZjV4gfC1hdR4kFfYQ36X+NSQUoXIygqmDs3b1xrQ8YUYXjPttbHI5F35GwAaVg5LLJeK7/5EiJIJPc9cdm1oy5qopMyqXFDXpn+OBsn/2PSP2MPVqSg3DzB80Ux9MXIEKYgDcHE2agmB4Rx3izLqNNtCAjQxPYl2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gTRGSGZn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so9884325ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737558; x=1721342358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GxgjPLShiSewN+a/1ZZw6RNJuPMBowXLb8tj+mVPPI=;
        b=gTRGSGZn9rc63s+ilzV6AkKmnTk43tEi+j/Pvwx9HlrNREOrklZ+hLZe1wrmr59DaQ
         jk83MDcp5E/95OfbcrlYjiydBW0HmcxWQXnv2FLTNVgEwSqlOyHTLXP9O2N3vGmYnzmQ
         zIsEF9tXZtamHbAq/pJB2z/rYyUMGEVhm+X6LGHWOew+2Dnu69xcFAGOrqzW0BBGC+k/
         kUnlDRJnBD+3xESBsz7rZ4istRKcnUIcIlp0ZROvgLzi/fzmbb9V166cY3rFZMqkcMfF
         LGpI5IdUIC0sCYCo1wKpIKm2kxzkdYhK0h9ZDxzRWNUdH+kCTlbGUuoD0d7YRPVGwDjH
         olQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720737558; x=1721342358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GxgjPLShiSewN+a/1ZZw6RNJuPMBowXLb8tj+mVPPI=;
        b=nnE+WmZ60nqH7dF8PTDKGgmtjKDBZSELd0BA/rISriFiKWwftE4rromDGKJQknjCUl
         IDd0+Kr+/uwNaSl4NhnKo3Khsi/aZfHmeRlvLDlI8gXWQLkm5sZiouXHSwIE7HfH12ts
         c1YGgX/X1VI1OUaCTYTRg0zDEZ5ImOR+wn+/HJDcm7MOyfcFmagbMhGTvfH90n0a68xp
         f1dRMkOZke9s8yuwhnvHH5afLb1ZpK1Qgzdcx5Q6P2yaTpl9yN7AvDyPuHq4pS2oGf/v
         vuG6cHp+2pOv+ns/bVowQM14ZlrFzlNV3Gki00TuSqdMCJuI6nIHCAYF6QCpYYA3lqER
         l8dw==
X-Forwarded-Encrypted: i=1; AJvYcCX7RXW7jybtl9l5MbOMTz3VhglMkhRGJQvFvl6s539tvW0aWtF4k7B938TBZQpZXMAjNxLHFTkDfwyTr3paANRE3Ojm8h+bZxhDkJlV
X-Gm-Message-State: AOJu0YwOeQmrgx5Lb6s/bNJ3Nsj/SUXnN1jfx7Po+wymX/SrffQ7qzpO
	Olk3cvzIbIYtaPZCuofY32Pb+t/7yt1vCUnNFGn9g/HR00tiFLz/49zo62MUils=
X-Google-Smtp-Source: AGHT+IGkcS1UnmFUiDfnYfYf9oTjjiw9v89JiL0uz2DalF+LCxXc2R7fkoXd9no1eEDuFpDvvIk9aA==
X-Received: by 2002:a17:902:e54c:b0:1fb:5c3d:b8c3 with SMTP id d9443c01a7336-1fbb6cdab3amr85148975ad.4.1720737557983;
        Thu, 11 Jul 2024 15:39:17 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac778dsm55465595ad.228.2024.07.11.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:39:17 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:39:15 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 4/7] RISC-V: Replace RISCV_MISALIGNED with
 RISCV_SCALAR_MISALIGNED
Message-ID: <ZpBfE3odf9Re85kU@ghost>
References: <20240711215846.834365-1-jesse@rivosinc.com>
 <20240711215846.834365-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711215846.834365-5-jesse@rivosinc.com>

On Thu, Jul 11, 2024 at 05:58:43PM -0400, Jesse Taube wrote:
> Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
> for the addition of RISCV_VECTOR_MISALIGNED in a later patch.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> V2 -> V3:
>  - New patch
> V3 -> V4:
>  - No changes
> ---
>  arch/riscv/Kconfig                    | 6 +++---
>  arch/riscv/include/asm/cpufeature.h   | 2 +-
>  arch/riscv/include/asm/entry-common.h | 2 +-
>  arch/riscv/kernel/Makefile            | 4 ++--
>  arch/riscv/kernel/fpu.S               | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..34d24242e37a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -717,7 +717,7 @@ config THREAD_SIZE_ORDER
>  	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
>  	  affects irq stack size, which is equal to thread stack size.
>  
> -config RISCV_MISALIGNED
> +config RISCV_SCALAR_MISALIGNED
>  	bool
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
>  	help
> @@ -734,7 +734,7 @@ choice
>  
>  config RISCV_PROBE_UNALIGNED_ACCESS
>  	bool "Probe for hardware unaligned access support"
> -	select RISCV_MISALIGNED
> +	select RISCV_SCALAR_MISALIGNED
>  	help
>  	  During boot, the kernel will run a series of tests to determine the
>  	  speed of unaligned accesses. This probing will dynamically determine
> @@ -745,7 +745,7 @@ config RISCV_PROBE_UNALIGNED_ACCESS
>  
>  config RISCV_EMULATED_UNALIGNED_ACCESS
>  	bool "Emulate unaligned access where system support is missing"
> -	select RISCV_MISALIGNED
> +	select RISCV_SCALAR_MISALIGNED
>  	help
>  	  If unaligned memory accesses trap into the kernel as they are not
>  	  supported by the system, the kernel will emulate the unaligned
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 347805446151..0ed7d99c14dd 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>  
>  void riscv_user_isa_enable(void);
>  
> -#if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
>  DECLARE_PER_CPU(long, misaligned_access_speed);
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> index 2293e535f865..0a4e3544c877 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,7 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>  
> -#ifdef CONFIG_RISCV_MISALIGNED
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  int handle_misaligned_load(struct pt_regs *regs);
>  int handle_misaligned_store(struct pt_regs *regs);
>  #else
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5b243d46f4b1..8d4e7d40e42f 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,8 +62,8 @@ obj-y	+= probes/
>  obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
> -obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> -obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
> +obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= traps_misaligned.o
> +obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= unaligned_access_speed.o
>  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
>  
>  obj-$(CONFIG_FPU)		+= fpu.o
> diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
> index 327cf527dd7e..f74f6b60e347 100644
> --- a/arch/riscv/kernel/fpu.S
> +++ b/arch/riscv/kernel/fpu.S
> @@ -170,7 +170,7 @@ SYM_FUNC_END(__fstate_restore)
>  	__access_func(f31)
>  
>  
> -#ifdef CONFIG_RISCV_MISALIGNED
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  
>  /*
>   * Disable compressed instructions set to keep a constant offset between FP
> @@ -224,4 +224,4 @@ SYM_FUNC_START(get_f64_reg)
>  	fp_access_epilogue
>  SYM_FUNC_END(get_f64_reg)
>  
> -#endif /* CONFIG_RISCV_MISALIGNED */
> +#endif /* CONFIG_RISCV_SCALAR_MISALIGNED */
> -- 
> 2.45.2
> 

Thank you for making this change!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


