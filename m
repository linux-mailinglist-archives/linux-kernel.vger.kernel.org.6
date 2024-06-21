Return-Path: <linux-kernel+bounces-224286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FA912042
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED88528DCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7E16DEC1;
	Fri, 21 Jun 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gHlCfYkY"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19452F71
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961357; cv=none; b=MPWQ+1NxLfj+8vHraxiyghp7QP1eYRlZu3KYjJ9BLr5wM3tTsQR02rXkpbCoGKHo3+xPbRC81VJreBiAriQvqHGgjpYmXc2F2rhkeDBwzvDyyWtdGbKPR97hrgRnJIOZ3c4w9JraBpLHTCQ7MIHbc04IbijhDEVygUvMAyheasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961357; c=relaxed/simple;
	bh=LWKPnGaAZyOgyVCp6XI+CxEWH2xLYJGvLATHAe3ca7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uojdAK/86rOJL53VUtkADmVquH9pX/qwM0Hw5ZgTW+PU2TzAvc5gaETF9yelwPtp941uQ+MOokNi0ru5+93bUxGc5YfUD6RvJcIC3Nyc9AUGxnmPb+tJzJa2B6W5bdgTz2a9vPkTHphHPrV872PplBaD385lTKXEkTEJ6YC782o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gHlCfYkY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec4a35baddso12178441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718961354; x=1719566154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2jvjig3AYIEyRn3flEvgDjFbBS4OpGQwrJnUvDqBBI=;
        b=gHlCfYkYDr4S35pWoYUdTNHOBpNhtRfNKwSYGzqrrvnQYI5+gwlLeuRCY2Me5nr4Qe
         UMhcv35ENdvGR9Eza8KqieToRWdXIbMNeXQf0vtWtxtlWZEPiDhiq7flA4cJraE2o7sh
         RJnfbyor04rlIIMlRFcrr48cKuv1LHw1AePu3DYfatdqWNJJZa4ebZf0c9gmFoSmVjvV
         tDIDicl5JC5cqxP66X7aISKSUHfehwzK4j6+3afVEqy2QjidhHxl5LPGg0uyvwLFDle6
         2sTOLFPi2tedrhcz+qk+OgoyiA16Nat7xhdRPOwzG0FTy3OyIc1aU0x6cgQFnYAy0A0n
         DCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718961354; x=1719566154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2jvjig3AYIEyRn3flEvgDjFbBS4OpGQwrJnUvDqBBI=;
        b=oNd+mWddQ0BFo8RCeq2bLgOR6MFTuqNhP/JXm9o1vQMXniuCt7mzarcyzQkef7S/Pa
         xSTnJ2D3ejfoax665sBXlZJsr44LanVMGk7cafYAHMzuxhVhRLpTFYFEZmVTwelwEjfQ
         2zcm3CRi4j4mmaEUUc7zo4yZE9r5Lpc2UtPobynHUGdjCCZR8ZnhVS6X/e+p8RdPsKRN
         VUrcR7qIrEF8ctbpIbF46sHsTFx5zccOV0FSRSEgA4plPbNkZzcsQArgVvSsE9OgT8bK
         27N0X0TLG08XcwLeWwnIPLs34erAEJ86l485+PM6DesKKBGf1FowUdIGVSUk7RMXi/Zi
         sLJA==
X-Forwarded-Encrypted: i=1; AJvYcCUeLi+mJPevwMJxlvKlVyVKBVHuSLywf+cfAEkgBokV0pUkY/CR0eDMxGFK+hd1wjrbcS6SIKfAxbuesTmncLHR8tEv1L0G7SukJK/4
X-Gm-Message-State: AOJu0YwJmHFV5GpHjCeQrqXwKoXOP0372zPrGTtHVb6Vw3QvSIL/eVtS
	OIhAq80i2+xynl7rX0/vIDHfM+gxSKTbWVCxbhAMZ5ViNTDE+qwWYtGdLiBfKTg=
X-Google-Smtp-Source: AGHT+IFKJNicO3uhmDyrJLucOIHE0vfinnnmMr9OxG7eOes5d7m8ZFjdrD3XNJP1E8qkltVhFzuPCQ==
X-Received: by 2002:ac2:597a:0:b0:52c:7f25:dbac with SMTP id 2adb3069b0e04-52ccaa5d210mr3865442e87.20.1718961353465;
        Fri, 21 Jun 2024 02:15:53 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56e9f3sm60866566b.215.2024.06.21.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:15:53 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:15:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v6 1/1] riscv: mm: Add support for Svinval extension
Message-ID: <20240621-469a3d5eb7bb2c0cc8ae0611@orel>
References: <20240609112103.285190-1-mchitale@ventanamicro.com>
 <20240609112103.285190-2-mchitale@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609112103.285190-2-mchitale@ventanamicro.com>

On Sun, Jun 09, 2024 at 04:51:03PM GMT, Mayuresh Chitale wrote:
> The Svinval extension splits SFENCE.VMA instruction into finer-grained
> invalidation and ordering operations and is mandatory for RVA23S64 profile.
> When Svinval is enabled the local_flush_tlb_range_threshold_asid function
> should use the following sequence to optimize the tlb flushes instead of
> a simple sfence.vma:
> 
> sfence.w.inval
> svinval.vma
>   .
>   .
> svinval.vma
> sfence.inval.ir
> 
> The maximum number of consecutive svinval.vma instructions that
> can be executed in local_flush_tlb_range_threshold_asid function
> is limited to 64. This is required to avoid soft lockups and the
> approach is similar to that used in arm64.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>  arch/riscv/mm/tlbflush.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 9b6e86ce3867..49d7978ac8d3 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,6 +6,54 @@
>  #include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> +#include <asm/cpufeature.h>
> +
> +#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
> +
> +static inline void local_sfence_inval_ir(void)
> +{
> +	/*
> +	 * SFENCE.INVAL.IR
> +	 * 0001100 00001 00000 000 00000 1110011
> +	 */
> +	__asm__ __volatile__ (".word 0x18100073" ::: "memory");
> +}
> +
> +static inline void local_sfence_w_inval(void)
> +{
> +	/*
> +	 * SFENCE.W.INVAL
> +	 * 0001100 00000 00000 000 00000 1110011
> +	 */
> +	__asm__ __volatile__ (".word 0x18000073" ::: "memory");
> +}
> +
> +static inline void local_sinval_vma_asid(unsigned long vma, unsigned long asid)

Please name this to

  void local_sinval_vma(unsigned long vaddr, unsigned long asid)

to match the spec's naming. But, if we want the arguments in the name,
then it should be something like

  void local_sinval_vma_addr_asid(unsigned long vaddr, unsigned long asid)

but I think that's unnecessary.

> +{
> +	if (asid != FLUSH_TLB_NO_ASID) {
> +		/*
> +		 * rs1 = a0 (VMA)
> +		 * rs2 = a1 (asid)
> +		 * SINVAL.VMA a0, a1
> +		 * 0001011 01011 01010 000 00000 1110011
> +		 */
> +		__asm__ __volatile__ ("add a0, %0, zero\n"
> +					"add a1, %1, zero\n"
> +					".word 0x16B50073\n"
> +					:: "r" (vma), "r" (asid)
> +					: "a0", "a1", "memory");
> +	} else {
> +		/*
> +		 * rs1 = a0 (VMA)
> +		 * rs2 = 0
> +		 * SINVAL.VMA a0
> +		 * 0001011 00000 01010 000 00000 1110011
> +		 */
> +		__asm__ __volatile__ ("add a0, %0, zero\n"
> +					".word 0x16050073\n"
> +					:: "r" (vma) : "a0", "memory");
> +	}

Please create an SINVAL_VMA instruction in insn-def.h to allow the
compiler to choose which registers will be used for asid and vaddr. And,
since SINVAL_VMA will be in insn-def.h, then we might as well add
SFENCE_INVAL_IR and SFENCE_W_INVAL there too for consistency, even though
they don't have operands. We should still create the three static inline
wrapper functions here though.

> +}
>  
>  /*
>   * Flush entire TLB if number of entries to be flushed is greater
> @@ -26,6 +74,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
>  		return;
>  	}
>  
> +	if (has_svinval()) {
> +		local_sfence_w_inval();
> +		for (i = 0; i < nr_ptes_in_range; ++i) {

Where do we limit this to 64 as the commit message states it does?

> +			local_sinval_vma_asid(start, asid);
> +			start += stride;
> +		}
> +		local_sfence_inval_ir();
> +		return;
> +	}
> +
>  	for (i = 0; i < nr_ptes_in_range; ++i) {
>  		local_flush_tlb_page_asid(start, asid);
>  		start += stride;
> -- 
> 2.34.1
>

Thanks,
drew

