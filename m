Return-Path: <linux-kernel+bounces-256841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3A93711F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D578F1F2204E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD3146A9D;
	Thu, 18 Jul 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NayyJj/1"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DD1DA3D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345726; cv=none; b=UCpfyZ7Fr6+w3NvHe/NeX+icqSasjsPKyP29tFVu97Z9o7Lu7CRQHnUucj7eb6P09ZXRwLOl3+jHA3mN7RJOmffIh6XWVzIVHe0xTQnufChpQ20nbuQEOWV5vxpennYsvahEH33CoVTCJXEAbNtuXCIjFWmYw3k7vVbqy8Hv9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345726; c=relaxed/simple;
	bh=7a67cXWeIY9vW6wOmBONnfQHWybmwpJcT73uF1nEFmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbBg7Z+/UHAO3HO8rl7qDHne0ZfzXlGsJqenfJKBSQm3ESbok2cjsI0rodmOFEFxp5NiFu7D59qIl0mDvyulmJZA0lccm3EB+wpSSwbSOLv7cSzRC4tvvhbwwVOu8AVvbwJ9/sFLBl4DfSydAPqS3+kLnYYfEwOf8d9GUMdvffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NayyJj/1; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-397a363cb13so1622585ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721345722; x=1721950522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wuB824Hrye/65n89Susd5Qn8V22yeQN5eVpd+tL4OM=;
        b=NayyJj/1pyOysprAsvX302Op/94XqR/W/7PaYHuFQEM80i4Lt36KiBdZ5KViErSZ7/
         /cWMwQu1e7veEh1zHpf6xdZMjJpjtlaViOBoL2/HGiiFNYjgUt+0h26P+AdjTZf06hYK
         7ycAK/kaO7MUt/Mv2pi7FGw2/n2szmvzLSHuEQnNeST8ja5Ill6Gd3dzEs0+PHwQhQYQ
         14wNkUd8hJixn1CaFR2wPa0CyqcWPBhfRN4ZuXZ9GQ7SGUpPtttvTehRWr9MyZSmQF/K
         zPHu83DtmeZvBQp31w285KZ5fnaQJ7/OZYEmFhtU6vGhsTJNqQXO9VF+dygrE6dT9MxU
         sUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721345722; x=1721950522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wuB824Hrye/65n89Susd5Qn8V22yeQN5eVpd+tL4OM=;
        b=gRJEup774T4rXfqtxuee+onFCvIszOG+n06fF84pVfcLsWbgtEfJOx3WFXKKu785i/
         uCHjlhK2V6Fj7K7nOAjjj3V/x13CC2xwc8KJaB7KOgJLS1b8SaXro4KsHTUcrh1t13CQ
         HUcxxq55NhfcMu+ZGX8f1BJu4lesYJVlqq8Re7g3MY7eT6lN6YfKQ7tfQGtNABxqsl/0
         RAWcV5/waL22tW1qB55BBcpAssqdHRM4p87bFZvutrjluC72zuX8MyINE283jcaGIJ5/
         i4dY0domow0EyjHBnoeb6GL+OhGcpSK4A+nVoJg9pfcO/QJBJ0BTCP4P6jcGolHGinfF
         ommw==
X-Forwarded-Encrypted: i=1; AJvYcCWTg1b6emHlvzC4C+DfA1WtuKGaFVZUnqHQAli5akBs/uo84YZxsLCHpiuHnMGR1UKTERyVkt+tA/6iMa+kBOW30VyFps+yYH8EwLb/
X-Gm-Message-State: AOJu0YwML/0JYBGQaoFMob3hFRjHViqSMCASCwbHV/o25DL5ttDEwLR0
	lxwySDdmIQiE572/GwWOQ/3wzHdXxYBvBJ+Ym9OKXzatrLVtVUSFmeDLJz8JW3g=
X-Google-Smtp-Source: AGHT+IFtVhVM9BDBi07vxZXR86hASuWPxepp8zLd6TCw6Ag6AJelMqPZkldzEt6k5/Z8Yqp4PAfVOw==
X-Received: by 2002:a05:6e02:168a:b0:37a:a9f0:f263 with SMTP id e9e14a558f8ab-39556e4ff57mr82165945ab.20.1721345722320;
        Thu, 18 Jul 2024 16:35:22 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-397f7efad1asm502335ab.76.2024.07.18.16.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 16:35:21 -0700 (PDT)
Message-ID: <c403de1d-cda8-45bc-a6a2-a92170ad8575@sifive.com>
Date: Thu, 18 Jul 2024 18:35:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] RISC-V: Add Svade and Svadu Extensions Support
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com,
 Jinyu Tang <tjytimi@163.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Evan Green <evan@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Leonardo Bras <leobras@redhat.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org
References: <20240712083850.4242-1-yongxuan.wang@sifive.com>
 <20240712083850.4242-2-yongxuan.wang@sifive.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240712083850.4242-2-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yong-Xuan,

Two trivial comments below for if you send another version of the series.

On 2024-07-12 3:38 AM, Yong-Xuan Wang wrote:
> Svade and Svadu extensions represent two schemes for managing the PTE A/D
> bits. When the PTE A/D bits need to be set, Svade extension intdicates
> that a related page fault will be raised. In contrast, the Svadu extension
> supports hardware updating of PTE A/D bits. Since the Svade extension is
> mandatory and the Svadu extension is optional in RVA23 profile, by default
> the M-mode firmware will enable the Svadu extension in the menvcfg CSR
> when only Svadu is present in DT.
> 
> This patch detects Svade and Svadu extensions from DT and adds
> arch_has_hw_pte_young() to enable optimization in MGLRU and
> __wp_page_copy_user() when we have the PTE A/D bits hardware updating
> support.
> 
> Co-developed-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/csr.h     |  1 +
>  arch/riscv/include/asm/hwcap.h   |  2 ++
>  arch/riscv/include/asm/pgtable.h | 13 ++++++++++++-
>  arch/riscv/kernel/cpufeature.c   | 32 ++++++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..3d705e28ff85 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -36,6 +36,7 @@ config RISCV
>  	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_HW_PTE_YOUNG

These lines should be sorted alphabetically.

>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 25966995da04..524cd4131c71 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -195,6 +195,7 @@
>  /* xENVCFG flags */
>  #define ENVCFG_STCE			(_AC(1, ULL) << 63)
>  #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
> +#define ENVCFG_ADUE			(_AC(1, ULL) << 61)
>  #define ENVCFG_CBZE			(_AC(1, UL) << 7)
>  #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
>  #define ENVCFG_CBIE_SHIFT		4
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index e17d0078a651..35d7aa49785d 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,8 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
> +#define RISCV_ISA_EXT_SVADE             75

The number here should be aligned with tabs, like the surrounding lines.

Regards,
Samuel

> +#define RISCV_ISA_EXT_SVADU		76
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index aad8b8ca51f1..ec0cdacd7da0 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -120,6 +120,7 @@
>  #include <asm/tlbflush.h>
>  #include <linux/mm_types.h>
>  #include <asm/compat.h>
> +#include <asm/cpufeature.h>
>  
>  #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
>  
> @@ -288,7 +289,6 @@ static inline pte_t pud_pte(pud_t pud)
>  }
>  
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> -#include <asm/cpufeature.h>
>  
>  static __always_inline bool has_svnapot(void)
>  {
> @@ -624,6 +624,17 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
>  	return __pgprot(prot);
>  }
>  
> +/*
> + * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
> + * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
> + * DT.
> + */
> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU);
> +}
> +
>  /*
>   * THP functions
>   */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5ef48cb20ee1..b2c3fe945e89 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -301,6 +301,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
> +	__RISCV_ISA_EXT_DATA(svadu, RISCV_ISA_EXT_SVADU),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> @@ -554,6 +556,21 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>  		}
>  
> +		/*
> +		 * When neither Svade nor Svadu present in DT, it is technically
> +		 * unknown whether the platform uses Svade or Svadu. Supervisor may
> +		 * assume Svade to be present and enabled or it can discover based
> +		 * on mvendorid, marchid, and mimpid. When both Svade and Svadu present
> +		 * in DT, supervisor must assume Svadu turned-off at boot time. To use
> +		 * Svadu, supervisor must explicitly enable it using the SBI FWFT extension.
> +		 */
> +		if (!test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
> +		    !test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
> +			set_bit(RISCV_ISA_EXT_SVADE, isainfo->isa);
> +		else if (test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
> +			 test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
> +			clear_bit(RISCV_ISA_EXT_SVADU, isainfo->isa);
> +
>  		/*
>  		 * All "okay" hart should have same isa. Set HWCAP based on
>  		 * common capabilities of every "okay" hart, in case they don't
> @@ -619,6 +636,21 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>  
>  		of_node_put(cpu_node);
>  
> +		/*
> +		 * When neither Svade nor Svadu present in DT, it is technically
> +		 * unknown whether the platform uses Svade or Svadu. Supervisor may
> +		 * assume Svade to be present and enabled or it can discover based
> +		 * on mvendorid, marchid, and mimpid. When both Svade and Svadu present
> +		 * in DT, supervisor must assume Svadu turned-off at boot time. To use
> +		 * Svadu, supervisor must explicitly enable it using the SBI FWFT extension.
> +		 */
> +		if (!test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
> +		    !test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
> +			set_bit(RISCV_ISA_EXT_SVADE, isainfo->isa);
> +		else if (test_bit(RISCV_ISA_EXT_SVADE, isainfo->isa) &&
> +			 test_bit(RISCV_ISA_EXT_SVADU, isainfo->isa))
> +			clear_bit(RISCV_ISA_EXT_SVADU, isainfo->isa);
> +
>  		/*
>  		 * All "okay" harts should have same isa. Set HWCAP based on
>  		 * common capabilities of every "okay" hart, in case they don't.


