Return-Path: <linux-kernel+bounces-327361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDADF97749C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72ABB21C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07B1C2DBE;
	Thu, 12 Sep 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WsPzBh1U"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CF1957E4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181974; cv=none; b=fqI/+vYWq8DKG6hYbL1+k84N2vEooEPRxx0FiccqBlgLAHsoM9v83iL/eWmEhsARs0EGHm2KQhrkmGp78+ma0YB4LWJ4acmgvVXJUpEU77i7jrPlWLg4WBdqfeH5gC7SrhBbwfbNDAZCba7PyPrWhPzczy/7F9d89lhmeNlWs8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181974; c=relaxed/simple;
	bh=D0iFEXwagsK0xQ4eCh5frgkKpmixAYKMf6RJE0YsRWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx2YZmQZjMYyWXUtENWEWS8W012XmUAAiZzdldQ4p2ZzMj8eGJIupPutLj9+190NzEVDha3oqFiBhvCg1RHimX+BtwH9UXS6GEYYOevzA/GG8LTTaQlhb6sUYvpEPkb5v/0UTuFaHikzfVwMVBJHgEh9WaftjVkS12jVjotoo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WsPzBh1U; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8b68bddeaso313320a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726181972; x=1726786772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LI4dI97SWAb860LG4NezAi+gyF0moRXuDnMKm5Q9r2s=;
        b=WsPzBh1Usost2eCxCO+NzvUwHhLM42lrXSvqACRR8BThbgfKwMJg7gUwan8/NT/IsD
         HPU9l7y7A36udx2JIKwpBse1+Uw3cNpz13hYnz7QNFGRLQo9wLxg7qXivh8aMPxJ8JB6
         OrM62SsPnwNGf3seoFfEK3Awzof6L6E97cQb8KO4wYkA5Ar/1oAL64FfWf63bHfXEyct
         iOZT/SBnLqbZZuwZNeqIkYfl0sRfDBPvhx4X0tCq+5RLlCDbFcTWCJaLxiISMv8wQ6dU
         SP62V04DdqVhZ0HSyWYUIUBkrT9mAJpNtNjQbhV05MopgDuivYbEJ+GIlb7bj29SNwqR
         QCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181972; x=1726786772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI4dI97SWAb860LG4NezAi+gyF0moRXuDnMKm5Q9r2s=;
        b=Zy8Tx4p923KG4vg17AUAYnWXD6R1TbTMM1k1aaXQWAd5T2I9KKPpkDTwGA3sUJ2qZ2
         oQXbGR5nwLf+bRGioNT6G4aNGnaqTok1Lrq7n+ftY915rTsM4EguCE4q+9oD5308eiK6
         sTmb070+8/vdlEARbokg3tRxpcFfuun1MkiNUMPP1yeeT3UhpcdaNHjvoztIy2ayQ8XE
         CbKg1CLRjqljGJ6ov0HyDj6Py8JCDKNWkB5Su03t+3KR4jk0f1ySSJkzFDE8X873CozI
         dIqVwBTOJOr41o4+xki6pGFcB8E5zP3zpD0mI9EyB+aCUkcb6Zk9oja5lhnwEXupNiH/
         Foag==
X-Forwarded-Encrypted: i=1; AJvYcCVMroJyep6S8NJS1GEezOq4BIOQL7xUiqRT5czWOB7LX/an2OCXkg2rNnbBHFe41CEkLJtD3LhdiyLTNdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeumuAzOxqBMQHQo1re4ocvseBr1ZUJ+cOAcl/Nh2PacSsYgF/
	IoyGFcrwTASZ2DGPSHlgwQr8DACxZyJGC3WHbC5BveCYlrdFUUyXyPcWl4DT/zY=
X-Google-Smtp-Source: AGHT+IE+CL3+oYuw4kshgAQdGS8pSbDVdFnEX/NOrpfbZgL0VyDq3X6tMQuMNJbHW68DMGighRDooA==
X-Received: by 2002:a17:90b:1c84:b0:2c9:6a2d:b116 with SMTP id 98e67ed59e1d1-2dbb9dc9551mr1002941a91.7.1726181972073;
        Thu, 12 Sep 2024 15:59:32 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af456c5sm18707335ad.65.2024.09.12.15.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:59:31 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:59:28 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiao Wang <xiao.w.wang@intel.com>, Zhao Ke <ke.zhao@shingroup.cn>
Subject: Re: [PATCH v4 3/3] riscv: Call riscv_user_isa_enable() only on the
 boot hart
Message-ID: <ZuNyUC8mUSp8UtfI@ghost>
References: <20240814081126.956287-1-samuel.holland@sifive.com>
 <20240814081126.956287-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814081126.956287-4-samuel.holland@sifive.com>

On Wed, Aug 14, 2024 at 01:10:56AM -0700, Samuel Holland wrote:
> Now that the [ms]envcfg CSR value is maintained per thread, not per
> hart, riscv_user_isa_enable() only needs to be called once during boot,
> to set the value for the init task. This also allows it to be marked as
> __init.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> Changes in v4:
>  - Rebase on riscv/for-next (v6.11-rc)
>  - Add Conor's Reviewed-by tags from v2 (missed in v3)
> 
> Changes in v3:
>  - Drop use of __initdata due to conflicts with cpufeature.c refactoring
> 
> Changes in v2:
>  - Rebase on riscv/for-next
> 
>  arch/riscv/include/asm/cpufeature.h | 2 +-
>  arch/riscv/kernel/cpufeature.c      | 4 ++--
>  arch/riscv/kernel/smpboot.c         | 2 --
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 45f9c1171a48..ce9a995730c1 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>  
> -void riscv_user_isa_enable(void);
> +void __init riscv_user_isa_enable(void);
>  
>  #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
>  	.name = #_name,									\
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index df3e7e8d6d78..b3b9735cb19a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -919,12 +919,12 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
>  
> -void riscv_user_isa_enable(void)
> +void __init riscv_user_isa_enable(void)
>  {
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>  		current->thread.envcfg |= ENVCFG_CBZE;
>  	else if (any_cpu_has_zicboz)
> -		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
> +		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 0f8f1c95ac38..e36d20205bd7 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -233,8 +233,6 @@ asmlinkage __visible void smp_callin(void)
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, true);
>  
> -	riscv_user_isa_enable();
> -
>  	/*
>  	 * Remote cache and TLB flushes are ignored while the CPU is offline,
>  	 * so flush them both right now just in case.
> -- 
> 2.45.1
> 

