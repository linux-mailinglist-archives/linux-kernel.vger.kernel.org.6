Return-Path: <linux-kernel+bounces-278361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230494AF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A851F23209
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528CA13DDC0;
	Wed,  7 Aug 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="InL0bEFU"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CB13C9A7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053371; cv=none; b=gDksfXtxTMvxkkkWZrMgzoLmyg2VAlfSZ9jB7LS2vwmWmoo+GqVRjCxwUUkmrBa7miPLOa/3tu7Ge9JtqEvd6FKxGqytWCEWnOsHbFTEz4suF399Laa3GvKvrkVWWsLR+GAEgshtn4CUbHms6JbcmqZi8bKp6soSmy1Wj/Z3DGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053371; c=relaxed/simple;
	bh=6uOf5s52tG+8Vy0GYiklTIODGUI/L652kgcPgH9uiXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9pvrZcNQ3fzs76yOH972pcLgzYKBQxvXKAYosXAWKtG0MWu4WP/qZhd6FJvld0MU3B7gyOBe+r3xtvuHPExDUQlfhYclh/6Go/sbKTOZUK5ZRAe/UGYKbu/c+iHla2wGNIwvM16wkLvIsMmhjQ9UrOjjaG+T/MtamGxjP9XHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=InL0bEFU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc692abba4so1687725ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723053368; x=1723658168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIsLECqYOdZrI8qSJNosdOQy1k7IMWa6VZp48zwfYak=;
        b=InL0bEFUrirO2hmOJaqwan402hb0R2Nw8h0xgvbtm+wbWSFB7ns2Bf2m++bOqkSPqp
         iGpBr0bp8Q0CkKfp2ber4ofLuv83tCglBXzNSV/aSUHdQGOu0ztyyKFHhU6IC0JPIrxp
         tSIW2pOKqgPgWT7VyfwASg3n6k2OYs6X57X6vV8e0G+/6WkhKVWpp1fNswietBq2JENg
         AVNxlGrHXlfr7leKF5uli7XQ/H23GR8+IUY30IRPrLDyH2HyTsHYLnQGWoUl6ifxrG2s
         h9WCYNa0wgxm8fx/TTZIANunaCFomSzZp0l6RR6ica9fgffkGqGVXmkBhpokW+NHsiOh
         ncZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053368; x=1723658168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIsLECqYOdZrI8qSJNosdOQy1k7IMWa6VZp48zwfYak=;
        b=l0m0D9Xp2mIAUbkAdod3xWtxHeacNq6IqRrl1cCnUgd7zvySCc4pzBE7lRiguqwzQb
         6BUt4MMJH5RyDzSRagP+B2apwzHmXkOXNzES0Hgy5BUqwF3+epGbl9z7rEnwllutHx/i
         vwSbhRLppUIYTv8lk0LqUOeCAR0OOTqUGZ6mvAW5EEB+WBpcafF5mGLBTuD/ficD+rAd
         vNvXrSxVjcY70HQGMzohP8MS2MiYorBONxQwWyIwk3Zor9nc9/fkohT5WCmHAnn4foN+
         lflV4GdYePwaBelUC3Gjc6wGldmZ9nBXv2SVxtrt1lX+XeB++YYNh6AWelpvkAnmzAXK
         yJiA==
X-Forwarded-Encrypted: i=1; AJvYcCVk72FUtcjQVPYeaGD9VQWJ60rixFBildw1dBCbnfuXuWvt3JF3TbDeb90Fa+p2VH3Ew4Pa0dZNvtFOetVnNKHxoxAgxISJNYCheXjV
X-Gm-Message-State: AOJu0YxNs2a5EZaGH8Jr/3fGOHa50xlM2kyWv8/we69YTTtLBD03CYa5
	alvAygtscQI1m2RvjSlseCSPIQ3OCOsB5H4pYpnYXwO2nSRdlVTu/e9oHzl4Shc=
X-Google-Smtp-Source: AGHT+IFTv/8yrRoRq9RQ9HsBX7+9iJcN5jG9mmxStROSH6/8TM+4bgNqOr4C+BCMrwK30KYYVM/3kQ==
X-Received: by 2002:a17:902:fac4:b0:1fc:5ed5:ff51 with SMTP id d9443c01a7336-1ff57421a7emr138490255ad.43.1723053367593;
        Wed, 07 Aug 2024 10:56:07 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:b4d6:3d2:4f2e:547])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19d17sm109547075ad.42.2024.08.07.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:56:06 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:56:03 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf
 defines
Message-ID: <ZrO1MxZH+GwC5FQS@ghost>
References: <20240627172238.2460840-1-evan@rivosinc.com>
 <20240627172238.2460840-3-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627172238.2460840-3-evan@rivosinc.com>

On Thu, Jun 27, 2024 at 10:22:38AM -0700, Evan Green wrote:
> In preparation for misaligned vector performance hwprobe keys, rename
> the hwprobe key values associated with misaligned scalar accesses to
> include the term SCALAR. Leave the old defines in place to maintain
> source compatibility.
> 
> This change is intended to be a functional no-op.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> ---
> 
> Changes in v3:
>  - Leave the old defines in place (Conor, Palmer)
> 
> Changes in v2:
>  - Added patch to rename misaligned perf key values (Palmer)
> 
>  Documentation/arch/riscv/hwprobe.rst       | 14 +++++++-------
>  arch/riscv/include/uapi/asm/hwprobe.h      |  5 +++++
>  arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
>  arch/riscv/kernel/traps_misaligned.c       |  6 +++---
>  arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
>  5 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 7121a00a8464..0d14e9d83a78 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -243,23 +243,23 @@ The following keys are defined:
>    the performance of misaligned scalar native word accesses on the selected set
>    of processors.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> -    accesses is unknown.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performance of
> +    misaligned accesses is unknown.

Hey Evan,

This series hasn't landed yet, can you rebase and resend? There is a
patch [1] that changes the wording of this description to "misaligned
scalar" instead of "misaligned". Can you apply that wording change to
these new keys?

- Charlie

Link: https://lore.kernel.org/linux-riscv/CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com/

>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned accesses are
>      emulated via software, either in or below the kernel.  These accesses are
>      always extremely slow.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned native word
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned native word
>      sized accesses are slower than the equivalent quantity of byte accesses.
>      Misaligned accesses may be supported directly in hardware, or trapped and
>      emulated by software.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned native word
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned native word
>      sized accesses are faster than the equivalent quantity of byte accesses.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
> -    not supported at all and will generate a misaligned address fault.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned accesses
> +    are not supported at all and will generate a misaligned address fault.
>  
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 7ebb2f2cc4cf..bcb2d91241d5 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -80,6 +80,11 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF	7
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN		0
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED	1
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW		2
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_FAST		3
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED	4
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index b18639020c61..d5541f6c843e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -176,13 +176,13 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  			perf = this_perf;
>  
>  		if (perf != this_perf) {
> -			perf = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +			perf = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  			break;
>  		}
>  	}
>  
>  	if (perf == -1ULL)
> -		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  
>  	return perf;
>  }
> @@ -190,12 +190,12 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
>  	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> -		return RISCV_HWPROBE_MISALIGNED_FAST;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
>  
>  	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unaligned_ctl_available())
> -		return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>  
> -	return RISCV_HWPROBE_MISALIGNED_SLOW;
> +	return RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
>  }
>  #endif
>  
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index b62d5a2f4541..192cd5603e95 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -338,7 +338,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> -	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> +	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>  #endif
>  
>  	if (!unaligned_enabled)
> @@ -532,13 +532,13 @@ static bool check_unaligned_access_emulated(int cpu)
>  	unsigned long tmp_var, tmp_val;
>  	bool misaligned_emu_detected;
>  
> -	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +	*mas_ptr = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  
>  	__asm__ __volatile__ (
>  		"       "REG_L" %[tmp], 1(%[ptr])\n"
>  		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
>  
> -	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
> +	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED);
>  	/*
>  	 * If unaligned_ctl is already set, this means that we detected that all
>  	 * CPUS uses emulated misaligned access at boot time. If that changed
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index a9a6bcb02acf..160628a2116d 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -34,9 +34,9 @@ static int check_unaligned_access(void *param)
>  	struct page *page = param;
>  	void *dst;
>  	void *src;
> -	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> +	long speed = RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
>  
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
>  		return 0;
>  
>  	/* Make an unaligned destination buffer. */
> @@ -95,14 +95,14 @@ static int check_unaligned_access(void *param)
>  	}
>  
>  	if (word_cycles < byte_cycles)
> -		speed = RISCV_HWPROBE_MISALIGNED_FAST;
> +		speed = RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
>  
>  	ratio = div_u64((byte_cycles * 100), word_cycles);
>  	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
>  		cpu,
>  		ratio / 100,
>  		ratio % 100,
> -		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> +		(speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST) ? "fast" : "slow");
>  
>  	per_cpu(misaligned_access_speed, cpu) = speed;
>  
> @@ -110,7 +110,7 @@ static int check_unaligned_access(void *param)
>  	 * Set the value of fast_misaligned_access of a CPU. These operations
>  	 * are atomic to avoid race conditions.
>  	 */
> -	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> +	if (speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST)
>  		cpumask_set_cpu(cpu, &fast_misaligned_access);
>  	else
>  		cpumask_clear_cpu(cpu, &fast_misaligned_access);
> @@ -188,7 +188,7 @@ static int riscv_online_cpu(unsigned int cpu)
>  	static struct page *buf;
>  
>  	/* We are already set since the last check */
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
>  		goto exit;
>  
>  	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -- 
> 2.34.1
> 

