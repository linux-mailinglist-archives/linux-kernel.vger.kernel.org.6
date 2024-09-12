Return-Path: <linux-kernel+bounces-327360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CD97749A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947D22829C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AFA1C2DC1;
	Thu, 12 Sep 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s5P3CCSX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043819F41A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181820; cv=none; b=MmbMsG1K2MXLkNkPJPOoCUyzRSBgVP8g5jtpaiJXSz9M4L7Be1waiqH9Yb9qs4+mQe9UZpYO2KYQdDwdrnMKk9qrhzVl+c+M673Xc1wxtUUGRQkHqA+0V5rRAvdDzzrb1F30WjW3bBp24jbvqNs+RbUSi6wkHzx8Wx4OVeMj/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181820; c=relaxed/simple;
	bh=Mpej2Tm3p6L5uzwCOqVkH/eZcj3/XUmd+q8OiBYQawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikwMVC83VA/71I4OnF9vJbzppLlRveuCHv1H6EFBG/i0BnzHwiZ0/3n2OnDMNkiBCVQLShrKJ+xdLKXGD7HxN/4EPbmII/AsXyXIJoHHUNiOm9kFkj+KIue6zJ7bN/y44XGJk3NOY9yRXgCr99e4XLt0vAhwmSFNYNov1aeQI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s5P3CCSX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-206b9455460so12532555ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726181817; x=1726786617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYeDafd6h4Ckb8JAjqukFPSa5tGTBnNmbEnNRSDSsQ0=;
        b=s5P3CCSXCEXnzkY+jm9AWPK1ig4dpOS9FCgnR5VNQWiIJrfKRaRMs5yc4xfzKSolNG
         9LCpLRR1kDCd2DXxQVN4E66mPPkJkdLWC/iSkA1yV5rM+pov8052BymyrwfCZbchkx12
         Sj8maa+HJECj9CA8rFQOIucxBpIvbHzgBHXZ+ffoXRsJwRgJ6D3f/EDP06oNNS2erHVx
         FDOn0DK2hs22eyTeulwatlU/h1CLzmQG8Qu0K/ue6tOMxoX/dH8FL4E97ZJN5GfHN18j
         LRva/lUMTSyrxgvV9LNPWv9q0M8/zF9pdUHxQxL+Yp0NJ8v/CIx8NO8QG2IDuhYp/+KB
         o1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181817; x=1726786617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYeDafd6h4Ckb8JAjqukFPSa5tGTBnNmbEnNRSDSsQ0=;
        b=h8OV909nhQd9vkgiMyqptBo+Q8EoTplr0yJe1pXXI5GQZpiWZEC4g52ZKKM5r5zaLS
         306d+fATN2IxUGFw0uG+8HgkIT+Af2jJ1KrczWj5TuFp9oj12mMdjr1PubxXxWhEO/dN
         uIFZJeTNS6ykSyizfpBAA0e3tLfXmgcEjwqJPWftKvlznCuJCTdw3b0jxWQV8SIEONmE
         3Ll+dJkQIZGUJwUDevqczHrURy5cwW/fGl20U4+Mhwcv6GQ/pioyKuoABopdlCJoWKbz
         TH6mq2igaYnYpgCBpi5FckT1NkNTGikfLRP9LCKQuDsVUwLhTxJMJtS/RlaHGN/93h5a
         kdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/pim9FPAW6HeELYPCMIxrUax84HMohG0cVbLVClYtGFeviBq+cv2WvwC4ZHrnZ1u+CpJVh/JU1nhqd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgp+/NyNGLN4zHq2sfqSw795aW+8CmN3jUDYo7S17T4YQlvYPw
	0HcH2bcZgWgnVu72q4FosvmmclfqMu8Pmsb31ple2pNDjKGbrwvHQn5amb9s93s=
X-Google-Smtp-Source: AGHT+IHY8n+CpuCNyplrI5I2c5yN0lN83eMD2C9rgDbxBSIaStLSLcw/aHiLyl46zfx/eLeTeZoTHQ==
X-Received: by 2002:a17:902:ea03:b0:202:4bd9:aea5 with SMTP id d9443c01a7336-2074c623694mr162541905ad.14.1726181817024;
        Thu, 12 Sep 2024 15:56:57 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdc33csm18588835ad.143.2024.09.12.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:56:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:56:54 -0700
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
Subject: Re: [PATCH v3 2/3] riscv: Add support for per-thread envcfg CSR
 values
Message-ID: <ZuNxtoZqvbzGptyp@ghost>
References: <20240718004808.2246354-1-samuel.holland@sifive.com>
 <20240718004808.2246354-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718004808.2246354-3-samuel.holland@sifive.com>

On Wed, Jul 17, 2024 at 05:47:55PM -0700, Samuel Holland wrote:
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

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
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
> index 4efaf12b470e..43fdae953379 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -878,7 +878,7 @@ unsigned long riscv_get_elf_hwcap(void)
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

