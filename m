Return-Path: <linux-kernel+bounces-235676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BB91D83F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1F1F2227D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30EA47F45;
	Mon,  1 Jul 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S8LSaekI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32E63B9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816639; cv=none; b=VEg2OpbkV/ZdrtSz+kiYykQtYRZxDsqCAr/CahFcJZgYCrEKsHPoEFBgq1XK2UJxUf7aRkGhh2e6fu38H0W0tRsr+IsKlaIOLlb/FmssfIEcmBirM+T141RwQGpkynTILf8YIF2ccMoVFbudxFfNYf4TQXcP58iGabEhSGzqBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816639; c=relaxed/simple;
	bh=O0Pjb5+KKSALr/uC2iytfIB18K2+yrPLmip3QtLTkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEJbFYwQilu0mbusOFcbJJ7GtacXdQmHMwPrclNqQIwk68ja3+er1BzGDVMLnQ6l/W49gU0vj4oCuRi9cYs+bKKqAV3UsLFG1QMpsGrdHzcknugjRjTnXiE5Lispo71mZtjXPTHGMbMU0y/N/yx5jXii+zyQuhunl8aG15XvGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S8LSaekI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso1589069f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719816635; x=1720421435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+82xXOObJXSSEXX4f5vUKX0gC2e+jrB9oaTEOo05T28=;
        b=S8LSaekI1wfL8wmEooOkjb3FTsw6XbqsJCvxqYse+pec+IWnTpw6E1oGw3+f6wygVQ
         XT0ZenaH//gLsgr0tlI9iplcSvKgmrRR2qIzZ61ygQqBATyadFZ33AG9lfh0nGK75SjR
         3HGJRM90MEjAAv+7+Od1lUuzuO/0VJvyRDBFUhi49xfgY9vM4QSy9o70xwte/YXPzKIu
         RLc12aOHERaC4Gdl9fRADO5+IwCGnbOq7qq1wUedU7/jc654EO89DfBSykCCeiF6d29J
         kP4oSWMArekmMYnuJtBqdcO6Y4xQBR018GerigmmIqyKKiyDS+mEeiAPyXeFw8EhVVS+
         LBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719816635; x=1720421435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+82xXOObJXSSEXX4f5vUKX0gC2e+jrB9oaTEOo05T28=;
        b=SeYntiYa1L7xr1xPWINOdx7TuVVNI/gXBvM7T1AQ6PeGPuMirKvYDF7ekhAZB0MR/y
         Mjs3KZG4iuJLHPauHo+Ylkj1VYO2SqI07W9yDXEEEvzb7hQsFkhV8qTDCiw+jpddShrf
         ZpQqz+jH6ALyo3n4+pwuwgCJWMQe0ab4gijg4NFf37raivtAD92kJ4RabHdf/+izXhkL
         Pl+gb6WVW+X2nin9jgLwXxVCCOFQU7ULpYNC4PdXdfN1orWH6V/uuFoTh/D38TJMVBFT
         JUxlT89VkAVKW6fRTLcEvjKR8yIw6DXfYpZCde1twn7PTfsks4ArR43whtYmWx17hTZj
         rjvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Unx/1R3OnRhtUqQLU4WC42Qd7Oc87HM8s6C7iqRkvzvoNjwMDUtECttJr8XHepepwCsRET/7j6pR20qLJKjU9ee4qbDjnvI7RVnM
X-Gm-Message-State: AOJu0Yyu4o1F87bmDe0hlCu4d1aZDCF0Bn3uljOs3IgP3noNp/fS8jwa
	raG27GvRmx1T7yJX4lMzmBmaTRy8O40MklFzDCW3DNAyTaYgvNx16+BB5gCGNgQ=
X-Google-Smtp-Source: AGHT+IGht03/zPzx2c8cKSAQtR+IcFVIo76qxL/DRVmO6lA7XA4iaFCK3fDNblnfvw0NkXXmzNb00Q==
X-Received: by 2002:a05:6000:1b09:b0:354:fc65:39d6 with SMTP id ffacd0b85a97d-367756a9d37mr2820526f8f.26.1719816634538;
        Sun, 30 Jun 2024 23:50:34 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42577a0dda2sm55934635e9.0.2024.06.30.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 23:50:34 -0700 (PDT)
Date: Mon, 1 Jul 2024 08:50:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v7] riscv: mm: Add support for Svinval extension
Message-ID: <20240701-5ea27de0b3592ecf9d9564e8@orel>
References: <20240627165327.7685-1-mchitale@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627165327.7685-1-mchitale@ventanamicro.com>

On Thu, Jun 27, 2024 at 10:23:27PM GMT, Mayuresh Chitale wrote:
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
> Changes in v7:
> - Use existing svinval macros in the insn-def.h
> - Rename local_sinval_vma_asid to local_sinval_vma
> 
> Changes in v6:
> - Rebase on latest torvalds/master
> 
> Changes in v5:
> - Reduce tlb flush threshold to 64
> - Improve implementation of local_flush_tlb* functions
> 
> Changes in v4:
> - Rebase and refactor as per latest changes on torvalds/master
> - Drop patch 1 in the series
> 
> Changes in v3:
> - Fix incorrect vma used for sinval instructions
> - Use unified static key mechanism for svinval
> - Rebased on torvalds/master
> 
> Changes in v2:
> - Rebased on 5.18-rc3
> - update riscv_fill_hwcap to probe Svinval extension
> 
>  arch/riscv/mm/tlbflush.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 9b6e86ce3867..d3396619d8c4 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,6 +6,28 @@
>  #include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> +#include <asm/cpufeature.h>
> +
> +#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
> +
> +static inline void local_sfence_inval_ir(void)
> +{
> +	asm volatile(SFENCE_INVAL_IR() ::: "memory");
> +}
> +
> +static inline void local_sfence_w_inval(void)
> +{
> +	asm volatile(SFENCE_W_INVAL() ::: "memory");
> +}
> +
> +static inline void local_sinval_vma(unsigned long vma, unsigned long asid)
> +{
> +	if (asid != FLUSH_TLB_NO_ASID)
> +		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) :
> +			     "memory");

nit: no need to wrap this line, we can go to 100 chars.

> +	else
> +		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
> +}
>  
>  /*
>   * Flush entire TLB if number of entries to be flushed is greater
> @@ -26,6 +48,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
>  		return;
>  	}
>  
> +	if (has_svinval()) {
> +		local_sfence_w_inval();
> +		for (i = 0; i < nr_ptes_in_range; ++i) {
> +			local_sinval_vma(start, asid);
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

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

