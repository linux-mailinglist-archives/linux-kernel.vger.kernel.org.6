Return-Path: <linux-kernel+bounces-261144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478193B320
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DE7B26B75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31815E5AE;
	Wed, 24 Jul 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="dctgBkKg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50815B12F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832657; cv=none; b=Q7k6UA2IAwZj3fElKgShKr/c1CwQFPHgwFFlCMD6NT8/ost3eQi9URD8rgtDODCCzgO8P5sZifuxqw+6wf5tm53BG81SpM6GkzJ7J+JIjt4vb8cSYDIXXZm1a/wIMjXvmEzLuM0U1J7tWzHXjj/r1qY8tEFDqN7ey1I2fTOglAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832657; c=relaxed/simple;
	bh=oldBH+JDNGSI+67Pzz+1KSnK/P6XXY32s/DhW1GuSJA=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LvUr5D8CGCwBL4D0w1uRLyBetLGzLkSk1ugvUAmrPlEvT9kTL2vtCzPbGLvRe8RB2TV5bqEdooLvPyEWFfLs2kF06j2isYl599uDU3pRXEKh7hazY7ryjZxdG9do3JLWdG/uQPV00FvM1O7F3V0E13JFwFESO2/eB/mEWg/uv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=dctgBkKg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc52394c92so19493455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1721832655; x=1722437455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ8EOFuu7vB+SiN9WcOSWsfMWAn/pybVkBUfGTLMLI0=;
        b=dctgBkKguoazisF/aZHhKe9S89Ay9/oLnLwhLpYDfKZEe6oUU4xPB1XtVWYPMahdBC
         vOfwLVL6Ky+AQevm/+/nSr0yUN6pEWCv2aoD/Qp2K1a6Oys/yLUGSp9B9QMDfsg6MwDZ
         JtIjFiGRx+ItnGX7nRrlby8ctid58w3TUYJfF89UoP2KtYAWU7eWOCZT1sFPhR8vTDDP
         1jktU5JtHySl0uHntvNVPBDWh5FWQfPyPtWAjKZALDgblbDqsxFUdb47+sshx6epc5HW
         MnYfrJRa+EWOCcltod1n7Gy8N5GvSTvAyIlbb7Gkxg72V6+DQSZPGPsdJbjPCtfuC4eg
         TkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832655; x=1722437455;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ8EOFuu7vB+SiN9WcOSWsfMWAn/pybVkBUfGTLMLI0=;
        b=XGFuRKY7+U7GMLDZkakjr9j+cbcFzm+8V59czELQcaDGJT7vmecljvd1V4tYHZuQbW
         rOuRUiB+KS4G9QpABcaUdXO03+GEJWeuo5TK5auMyNhBNb5xbe6aKDw2kF4Qnd2pJfjm
         FphEfYDviEXUIgnI1D34mlVl63u0a+qO+8pelJzcs+HAwb1ui7cQeGU5n7flCBbfBmR0
         DzgGifK7grxrN0GwteLI2rGcQnWjJhbixcEygwnTD/2xi2HqJBKGRWMM37Zd+PSNx9ly
         ykvUSmHxGbjZ9yGiUuZHY9NghCLSqQyUbqHpXi4tZJelpI8cjeMkWhVLDBUKSEBnYLNv
         unew==
X-Forwarded-Encrypted: i=1; AJvYcCWpUmeyDNf2MEJR2wz5sxYresspoYY0pK01CE4iMZzLTrnGlRBsXxJUSd+QjwytBP/Nn+DNEmCW89P0v2+dnXM0E+BhmgcADB9A3+QQ
X-Gm-Message-State: AOJu0YydYKX/VBBs2hFC1fTUSWstgvV8rwax3dIiMHI6Py0eVmQ+H6jS
	Pb0hvd3ZthN0UK/gUB606qW5DifHuP/GnYEG9WtX6yFqHM7vnSFTbY40RfEJ5Z4=
X-Google-Smtp-Source: AGHT+IGPM0RZbkYZEg6h1kJV/6aaKS0BcId2ZV9yXzR111FIf7xwltEw9bDtF36tKb2aVWhOS43ROQ==
X-Received: by 2002:a17:902:d2ca:b0:1fa:a03e:349a with SMTP id d9443c01a7336-1fdd5577320mr23338705ad.52.1721832655015;
        Wed, 24 Jul 2024 07:50:55 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f436cc2sm94911955ad.202.2024.07.24.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:50:54 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:50:54 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2024 07:50:51 PDT (-0700)
Subject:     Re: [PATCH v8] riscv: mm: Add support for Svinval extension
In-Reply-To: <20240702102637.9074-1-mchitale@ventanamicro.com>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  mchitale@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  alexghiti@rivosinc.com, samuel.holland@sifive.com, ajones@ventanamicro.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: mchitale@ventanamicro.com
Message-ID: <mhng-38c26ef6-8d45-4dd1-9c3a-f71f34f1ef81@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 03:26:37 PDT (-0700), mchitale@ventanamicro.com wrote:
> The Svinval extension splits SFENCE.VMA instruction into finer-grained
> invalidation and ordering operations and is mandatory for RVA23S64 profile.
> When Svinval is enabled the local_flush_tlb_range_threshold_asid function
> should use the following sequence to optimize the tlb flushes instead of

Do you have any performance numbers for the optimization?  As per here 
<https://lore.kernel.org/all/mhng-f799bd2b-7f22-4c03-bdb2-903fa3b5d508@palmer-ri-x1c9a/>.

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
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> Changes in v8:
> - Fix line wrap
> - Add RB tag
>
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
> index 9b6e86ce3867..782147a63f3b 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,6 +6,27 @@
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
> +		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) : "memory");
> +	else
> +		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
> +}
>
>  /*
>   * Flush entire TLB if number of entries to be flushed is greater
> @@ -26,6 +47,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
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

