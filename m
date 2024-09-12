Return-Path: <linux-kernel+bounces-327366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17A9774A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B54284BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E351519CC28;
	Thu, 12 Sep 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pSopgxnB"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB419CC1B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182119; cv=none; b=PJEH4YBbuq+REZSzj9yuQc3wMetq6XzcVyPjmzNGxU1lshwV4VupfYy8MpALJATF7JJGpLg5PRmprfJFKl26y/licljJLQVSqaqIIdI2FkTWMJjDIA3nQOQO5iw2p5Fr1Tha8CdOkBn2n+t8fAT2LR/6p4IUIlqNvctH9wIMXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182119; c=relaxed/simple;
	bh=+zENuKE0WrYig3DOpk+jZRKULuaPKCiPQEFgcQZ1bjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Xmx7yNL6NkwpvVbjOvuPEPEU4X3DFsoEbmUJuYj6MO2OlzeIiOO/fD46tigBpdrldU9lDWCIB9bCuhoJ68BTyOWKv10yivKz1BEroNQbYdI6mwQWK8/xFqfFRrU5WcdLybb4WH6OEBiQcdLu09r2m7FUuf2Gld8Q0lCXSURT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pSopgxnB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so1119999a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726182117; x=1726786917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KChuFq8ScYbijlFMvm8zOY8n9eP6VarVDAkuanrdrYo=;
        b=pSopgxnBfL29Ec0uKzeMPMu5dRw0o0R5YzYbhhpar7MYafA2KRbskFp1MIFogIviph
         HMYaeHbubwLmFZ3qnx3Ea3X68H054E976Ozy/rmOpu9/EocrQWIylF8AtEonSC8+9iFU
         4ipS5Hdwm1ji49Att5NqCb8WhowF5MG8cwHs2XW9OzorVkZB2qkSRHTQC962vp0nPvlv
         JAYPpMsDvRX/ZGAoBv4RfnRAwtedA7Fa5lCUra3Wbt/XojFvhGLxGUV5ACwcsLq2BoQA
         DALWpz+t7Qz2NIOgs+ffPzR4H5oh9fk+RNyG+GQFFVdtrfKo03i6QQP6xKa6/ZKwMTYv
         cOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182117; x=1726786917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KChuFq8ScYbijlFMvm8zOY8n9eP6VarVDAkuanrdrYo=;
        b=mVzMYOcsIARw0IKfoD4oy0r2BkRjs7nw4Zof12AVPdSTm5vLSKEiW8dNJSTJ3UTm4F
         B02XLoAhRlKJuVKzxGuWKhl2O3yxx3z6ovfY9qu7bPaKq7/LyO0GKP6Mu2Vo8CP1c0YD
         2FoGKa2boxbDHxLp6HKn1z5NoPWi7sbdlNjYuV2D9SKjN3FGAimmvqLLyAy0rGK15lCd
         b1q5FAdcAFXEMXxtCZylrjAU8phUWm/zxO4+djzKYoOpEKCQb25d0p/dnZjxurcD4Hd7
         E6VKiYfVXEDeFDyvF6su7eS69QzQ70BGxxzmdRnGoF2fgas9Oc2bgS3PgRHzM4h+wr6X
         8SPA==
X-Forwarded-Encrypted: i=1; AJvYcCVMyxFbYWiyQLLhJ8b8StuDLlV5NqfOHyqIbE3InmQraVgnWwrltm0mGulTltsCHCUl9E9hGr1Qo9LQdE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyfREFJhfARO0Np95eJ7Ha6z5UJavTQV7Gkkc6tF39Wxs+66/
	t4Nu9bFHRk3Ycd+h38K8xH1WSOQ+z0+JJV+AlIndix7f/dlXojBjgSR1SOT39Mk=
X-Google-Smtp-Source: AGHT+IG46t6i9jwRgQMQoH4kG1FKO/7tAiHFAmbFyy4IgIFqq0GKbGzGJVhjmRRTR2Po/ZMyfwuF2Q==
X-Received: by 2002:a05:6a21:4a4b:b0:1cf:37bd:b553 with SMTP id adf61e73a8af0-1cf76244cb3mr5657217637.46.1726182116780;
        Thu, 12 Sep 2024 16:01:56 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddc705sm2270248a12.58.2024.09.12.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:01:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 16:01:53 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: Re: [PATCH v4 2/3] riscv: Add support for per-thread envcfg CSR
 values
Message-ID: <ZuNy4dIXe6Ik0yy3@ghost>
References: <20240814081126.956287-1-samuel.holland@sifive.com>
 <20240814081126.956287-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814081126.956287-3-samuel.holland@sifive.com>

On Wed, Aug 14, 2024 at 01:10:55AM -0700, Samuel Holland wrote:
> Some bits in the [ms]envcfg CSR, such as the CFI state and pointer
> masking mode, need to be controlled on a per-thread basis. Support this
> by keeping a copy of the CSR value in struct thread_struct and writing
> it during context switches. It is safe to discard the old CSR value
> during the context switch because the CSR is modified only by software,
> so the CSR will remain in sync with the copy in thread_struct.
> 
> Use ALTERNATIVE directly instead of riscv_has_extension_unlikely() to
> minimize branchiness in the context switching code.
> 
> Since thread_struct is copied during fork(), setting the value for the
> init task sets the default value for all other threads.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> (no changes since v1)
> 
>  arch/riscv/include/asm/processor.h | 1 +
>  arch/riscv/include/asm/switch_to.h | 8 ++++++++
>  arch/riscv/kernel/cpufeature.c     | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 8702b8721a27..586e4ab701c4 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -124,6 +124,7 @@ struct thread_struct {
>  	unsigned long s[12];	/* s[0]: frame pointer */
>  	struct __riscv_d_ext_state fstate;
>  	unsigned long bad_cause;
> +	unsigned long envcfg;
>  	u32 riscv_v_flags;
>  	u32 vstate_ctrl;
>  	struct __riscv_v_ext_state vstate;
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 7594df37cc9f..9685cd85e57c 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -70,6 +70,13 @@ static __always_inline bool has_fpu(void) { return false; }
>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
>  
> +static inline void __switch_to_envcfg(struct task_struct *next)
> +{
> +	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
> +				  0, RISCV_ISA_EXT_XLINUXENVCFG, 1)
> +			:: "r" (next->thread.envcfg) : "memory");
> +}
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>  				       struct task_struct *);
>  
> @@ -103,6 +110,7 @@ do {							\
>  		__switch_to_vector(__prev, __next);	\
>  	if (switch_to_should_flush_icache(__next))	\
>  		local_flush_icache_all();		\
> +	__switch_to_envcfg(__next);			\
>  	((last) = __switch_to(__prev, __next));		\
>  } while (0)
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 0139d4ea8426..df3e7e8d6d78 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -922,7 +922,7 @@ unsigned long riscv_get_elf_hwcap(void)
>  void riscv_user_isa_enable(void)
>  {
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> -		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
> +		current->thread.envcfg |= ENVCFG_CBZE;
>  	else if (any_cpu_has_zicboz)
>  		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>  }
> -- 
> 2.45.1
> 

