Return-Path: <linux-kernel+bounces-396480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB69BCDB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC7B21FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A91D5AA9;
	Tue,  5 Nov 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sTX47ytk"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B32A1CA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812881; cv=none; b=DXlYNIia6IwdClFfGRwLa4qNwIwn1OFZMSP9SRzh+fMUi9yS3OmcZUf/32Sik5fOPWQkxMKVijBoh5VrKeS/3dl+5h78i2MryrOGqk4sqYfN1yOhuQSp+SdkM7pQyuYlA3tvQ2hhxYN98vwGHjxhFDo5bk2xXTDq9mPLdIiUndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812881; c=relaxed/simple;
	bh=4DnKpLcBfhg/ZqkKBmwazdfbq17o6drQ+GjJnOC9D7I=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BotEM9H+/hQ4Agb/Nw/U+bKiEnJIMwcWQoLv1PmhUr8hddLdMRD1wueCgyIAgJ8/fcaAP1m3dly6BvNmzaQYuX6fWwvcWh467t4vod0ANZHKmZeVZvHS0bjxpNSAuk9j04YrHQIB8TeQwnukF5lDVlwxeZRkEo7agQNkv8UBIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sTX47ytk; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8764D3FA67
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730812871;
	bh=VwjOCFgSbkb2da3/2hhq9H2bi9XM8d13RFRjH2OAzHg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sTX47ytkhI7fyjG2fA56q5w3swMmCdDXNTGiK52JzJPcS4hm/lp+z0wxNXmrmqfJt
	 6iNNkuw9vgJm+ILl3MNnQrkJvAX3sWsob5N05LXkMCYlOMZKPpx4l2wLyaoo4hSRY9
	 qUl/HVh3L8X71hMURDCjH8GPBb/rmJo7Co9A1My78v3lPH6CGH06kgnr2wnKydHctr
	 KJWEg76ZAyCu1cnJNixIxSk3g8j3cLd5RMpY3w/TyvAihHoULZx/cIX5u/nGC9F75h
	 ML9pZUAI6Mv3EfVC7FRbtGQqIZleclWos1kQzbJ6Eake3krWjX2KIhu3Ofobr9EimA
	 bY7swbhR3arSw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-288c53ab7abso4943599fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812868; x=1731417668;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwjOCFgSbkb2da3/2hhq9H2bi9XM8d13RFRjH2OAzHg=;
        b=qAZOl0iru+b7/AYpt8kxl/SFlSQOKVDg4LeCJpl9/IZwb6QNw6CndNBK11shdT7bf2
         J6JICMImXPcZ6bHgSPv5Ob8ZTaIbnxMan+0T4o8w2ZaR5t6n/SqDlRbJMdPqBaklL9JO
         gxtHjVSdsuumjuxsPWNU54vjohTn2+XP9XS5k8l0oCoo4220yln/rO3ga8PvR3oBHxUM
         AJjts7mBAdVJOhpp3CkI6RXG53djeMKGmTDirYkiqU9HKZEPql18I02TxOYL6QmK8mAm
         euKR8QGv+F051lOcFek+VPfJCkG8L8PQuJO3aiBonCIHn2Mdq4Zr9efVgMKBtAXt6tTx
         bAbA==
X-Forwarded-Encrypted: i=1; AJvYcCV2FiORVhM5Ngruc2E6aQqCU7UiwnHgy7KhCguVALyZlC33mU7npVknomZPbzGQlfhz5Q8jH0LxTqzKhxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb4ghlt5C+ANBPQ1xs696F5fipAl6wtYCkcKMuqkocnJxxYda
	yl2ECmJNrXteJHu63jgPsXhhlE/id/Sk1PdXP0GUHdgrd6R2y0Vl2VBCePBRItXClPGEpePi+kQ
	RmqKO4PmCJ9mQYlmSaCQnq+FgnmXrJufxBaB9rcvBMHjC7fpHu/ZDsiJl+B9vvYcirpSbq2tB2X
	04e3nQTQ7w1x3waPeBXvMiUJOVe4x2hyaJ9M4GE+tOgscRzeo72onKtZm4eWRF5WQ=
X-Received: by 2002:a05:6870:c0cf:b0:287:b4c7:b6dc with SMTP id 586e51a60fabf-29051bbf9d1mr29617229fac.22.1730812868248;
        Tue, 05 Nov 2024 05:21:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6KnIfBk4BP/z6kyF3dANIriu9q7XegMffK577MGSQ15d6bW9KrgyedIeEAAtFKpAAkV38G0AuQ7fanKnyU7A=
X-Received: by 2002:a05:6870:c0cf:b0:287:b4c7:b6dc with SMTP id
 586e51a60fabf-29051bbf9d1mr29617206fac.22.1730812867837; Tue, 05 Nov 2024
 05:21:07 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 08:21:07 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241102000843.1301099-11-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com> <20241102000843.1301099-11-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 5 Nov 2024 08:21:07 -0500
Message-ID: <CAJM55Z-aVZfKf+HeoHU8DbVJVAgm=8sbW7SvLsi+yQcfzkz1NA@mail.gmail.com>
Subject: Re: [PATCH 10/11] riscv: mm: Use physical memory aliases to apply PMAs
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Samuel Holland wrote:
> On some RISC-V platforms, RAM is mapped to multiple physical address
> ranges, with each alias having a different set of statically-determined
> Physical Memory Attributes (PMAs). Software selects the PMAs for a page
> by choosing a PFN from the corresponding physical address range.
>
> Implement this by transforming the PFN when writing page tables.  If the
> memory type field is nonzero, replace the PFN with the corresponding PFN
> from the noncached alias. Similarly, when reading from the page tables,
> if the PFN is found in a noncached alias, replace it with the
> corresponding PFN from the cached alias, and insert _PAGE_NOCACHE.
>
> The rest of the kernel sees only the cached PFNs and _PAGE_MTMASK values
> as if Svpbmt was implemented.
>
> Memory alias pairs are determined from the devicetree. A new cpufeature
> bit is required because that is the only way to trigger alternative
> patching.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/Kconfig                  |   3 +
>  arch/riscv/include/asm/hwcap.h      |   1 +
>  arch/riscv/include/asm/pgtable-64.h |  27 ++++++--
>  arch/riscv/include/asm/pgtable.h    |   8 +++
>  arch/riscv/kernel/cpufeature.c      |   6 ++
>  arch/riscv/kernel/setup.c           |   1 +
>  arch/riscv/mm/Makefile              |   1 +
>  arch/riscv/mm/memory-alias.S        | 101 ++++++++++++++++++++++++++++
>  arch/riscv/mm/pgtable.c             |  91 +++++++++++++++++++++++++
>  9 files changed, 235 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/mm/memory-alias.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 62545946ecf4..d28d1dab5f26 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -566,6 +566,9 @@ config RISCV_ISA_SVPBMT
>
>  	   The Svpbmt extension is only available on 64-bit cpus.
>
> +	   This option also controls selection of memory type based on
> +	   physical memory aliases.
> +

I wonder how much work it would be to make this its own Kconfig option only
enabled by JH7100 and EIC7700 support. Hopefully future chips will just
implement the standard Svpmt and this code will be unneded overhead.

/Emil

>  	   If you don't know what to do here, say Y.
>
>  config TOOLCHAIN_HAS_V
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 46d9de54179e..8a37e22f4223 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -94,6 +94,7 @@
>  #define RISCV_ISA_EXT_ZAWRS		85
>  #define RISCV_ISA_EXT_SVVPTC		86
>
> +#define RISCV_ISA_EXT_XLINUXMEMALIAS	126
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>
>  #define RISCV_ISA_EXT_MAX		128
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 174b6a5837c2..6b4af408a37a 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -124,27 +124,46 @@ enum napot_cont_order {
>   */
>
>  #define ALT_FIXUP_MT(_val)								\
> -	asm(ALTERNATIVE_2("addi	t0, zero, 0x3\n\t"					\
> +	asm(ALTERNATIVE_3("addi	t0, zero, 0x3\n\t"					\
>  			  "slli	t0, t0, 61\n\t"						\
>  			  "not	t0, t0\n\t"						\
>  			  "and	%0, %0, t0\n\t"						\
>  			  "nop\n\t"							\
>  			  "nop\n\t"							\
> +			  "nop\n\t"							\
>  			  "nop",							\
> -			  __nops(7),							\
> +			  __nops(8),							\
>  			  0, RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,		\
> +			  "addi t0, zero, 0x3\n\t"					\
> +			  "slli	t0, t0, 61\n\t"						\
> +			  "and	t0, %0, t0\n\t"						\
> +			  "beqz t0, 2f\n\t"						\
> +			  "xor	t1, %0, t0\n\t"						\
> +			  "1: auipc t0, %%pcrel_hi(riscv_fixup_memory_alias)\n\t"	\
> +			  "jalr	t0, t0, %%pcrel_lo(1b)\n\t"				\
> +			  "mv	%0, t1\n"						\
> +			  "2:",								\
> +			  0, RISCV_ISA_EXT_XLINUXMEMALIAS, CONFIG_RISCV_ISA_SVPBMT,	\
>  			  "srli	t0, %0, 59\n\t"						\
>  			  "seqz t1, t0\n\t"						\
>  			  "slli	t1, t1, 1\n\t"						\
>  			  "or	t0, t0, t1\n\t"						\
>  			  "xori	t0, t0, 0x5\n\t"					\
>  			  "slli	t0, t0, 60\n\t"						\
> -			  "xor	%0, %0, t0",						\
> +			  "xor	%0, %0, t0\n\t"						\
> +			  "nop",							\
>  			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
>  			  : "+r" (_val) :: "t0", "t1")
>
>  #define ALT_UNFIX_MT(_val)								\
> -	asm(ALTERNATIVE(__nops(6),							\
> +	asm(ALTERNATIVE_2(__nops(6),							\
> +			  "mv	t1, %0\n\t"						\
> +			  "1: auipc t0, %%pcrel_hi(riscv_unfix_memory_alias)\n\t"	\
> +			  "jalr	t0, t0, %%pcrel_lo(1b)\n\t"				\
> +			  "mv	%0, t1\n\t"						\
> +			  "nop\n\t"							\
> +			  "nop",							\
> +			  0, RISCV_ISA_EXT_XLINUXMEMALIAS, CONFIG_RISCV_ISA_SVPBMT,	\
>  			  "srli	t0, %0, 60\n\t"						\
>  			  "andi	t0, t0, 0xd\n\t"					\
>  			  "srli	t1, t0, 1\n\t"						\
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 3ffcff76ac0d..0e52dfaaff63 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -949,6 +949,14 @@ extern u64 satp_mode;
>  void paging_init(void);
>  void misc_mem_init(void);
>
> +#ifdef CONFIG_RISCV_ISA_SVPBMT
> +bool __init riscv_have_memory_alias(void);
> +void __init riscv_init_memory_alias(void);
> +#else
> +static inline bool riscv_have_memory_alias(void) { return false; }
> +static inline void riscv_init_memory_alias(void) {}
> +#endif /* CONFIG_RISCV_ISA_SVPBMT */
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3a8eeaa9310c..ca36f8240a86 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -892,6 +892,12 @@ void __init riscv_fill_hwcap(void)
>  			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
>  	}
>
> +	/* Vendor-independent alternatives require a bit in the ISA bitmap. */
> +	if (riscv_have_memory_alias()) {
> +		set_bit(RISCV_ISA_EXT_XLINUXMEMALIAS, riscv_isa);
> +		pr_info("Using physical memory alias for noncached mappings\n");
> +	}
> +
>  	memset(print_str, 0, sizeof(print_str));
>  	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>  		if (riscv_isa[0] & BIT_MASK(i))
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a2cde65b69e9..ab718fc4538f 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -287,6 +287,7 @@ void __init setup_arch(char **cmdline_p)
>  	}
>
>  	riscv_init_cbo_blocksizes();
> +	riscv_init_memory_alias();
>  	riscv_fill_hwcap();
>  	init_rt_signal_env();
>  	apply_boot_alternatives();
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index cbe4d775ef56..50d843b298cd 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -33,3 +33,4 @@ endif
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
>  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
>  obj-$(CONFIG_RISCV_NONSTANDARD_CACHE_OPS) += cache-ops.o
> +obj-$(CONFIG_RISCV_ISA_SVPBMT) += memory-alias.o
> diff --git a/arch/riscv/mm/memory-alias.S b/arch/riscv/mm/memory-alias.S
> new file mode 100644
> index 000000000000..df2e8cc3f69c
> --- /dev/null
> +++ b/arch/riscv/mm/memory-alias.S
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 SiFive
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/pgtable.h>
> +
> +#define CACHED_BASE_OFFSET	(0 * RISCV_SZPTR)
> +#define NONCACHED_BASE_OFFSET	(1 * RISCV_SZPTR)
> +#define SIZE_OFFSET		(2 * RISCV_SZPTR)
> +
> +#define SIZEOF_PAIR		(4 * RISCV_SZPTR)
> +
> +SYM_CODE_START(riscv_fixup_memory_alias)
> +	addi	sp, sp, -4 * SZREG
> +	REG_S	t2, (0 * SZREG)(sp)
> +	REG_S	t3, (1 * SZREG)(sp)
> +	REG_S	t4, (2 * SZREG)(sp)
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	REG_S	t5, (3 * SZREG)(sp)
> +
> +	/* Save and mask off _PAGE_NAPOT if present. */
> +	li	t5, _PAGE_NAPOT
> +	and	t5, t1, t5
> +	xor	t1, t1, t5
> +#endif
> +
> +	lla	t2, memory_alias_pairs
> +.Lfixup_loop:
> +	REG_L	t3, SIZE_OFFSET(t2)
> +	beqz	t3, .Lfixup_end
> +	REG_L	t4, CACHED_BASE_OFFSET(t2)
> +	sub	t4, t1, t4
> +	bltu	t4, t3, .Lfixup_found
> +	addi	t2, t2, SIZEOF_PAIR
> +	j	.Lfixup_loop
> +
> +.Lfixup_found:
> +	REG_L	t3, NONCACHED_BASE_OFFSET(t2)
> +	add	t1, t3, t4
> +
> +.Lfixup_end:
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	xor	t1, t1, t5
> +
> +	REG_L	t5, (3 * SZREG)(sp)
> +#endif
> +	REG_L	t4, (2 * SZREG)(sp)
> +	REG_L	t3, (1 * SZREG)(sp)
> +	REG_L	t2, (0 * SZREG)(sp)
> +	addi	sp, sp, 4 * SZREG
> +	jr	t0
> +SYM_CODE_END(riscv_fixup_memory_alias)
> +
> +SYM_CODE_START(riscv_unfix_memory_alias)
> +	addi	sp, sp, -4 * SZREG
> +	REG_S	t2, (0 * SZREG)(sp)
> +	REG_S	t3, (1 * SZREG)(sp)
> +	REG_S	t4, (2 * SZREG)(sp)
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	REG_S	t5, (3 * SZREG)(sp)
> +
> +	/* Save and mask off _PAGE_NAPOT if present. */
> +	li	t5, _PAGE_NAPOT
> +	and	t5, t1, t5
> +	xor	t1, t1, t5
> +#endif
> +
> +	lla	t2, memory_alias_pairs
> +.Lunfix_loop:
> +	REG_L	t3, SIZE_OFFSET(t2)
> +	beqz	t3, .Lunfix_end
> +	REG_L	t4, NONCACHED_BASE_OFFSET(t2)
> +	sub	t4, t1, t4
> +	bltu	t4, t3, .Lunfix_found
> +	addi	t2, t2, SIZEOF_PAIR
> +	j	.Lunfix_loop
> +
> +.Lunfix_found:
> +	REG_L	t3, CACHED_BASE_OFFSET(t2)
> +	add	t1, t3, t4
> +
> +	/* PFN was in the noncached alias, so mark it as such. */
> +	li	t2, _PAGE_NOCACHE
> +	or	t1, t1, t2
> +
> +.Lunfix_end:
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	xor	t1, t1, t5
> +
> +	REG_L	t5, (3 * SZREG)(sp)
> +#endif
> +	REG_L	t4, (2 * SZREG)(sp)
> +	REG_L	t3, (1 * SZREG)(sp)
> +	REG_L	t2, (0 * SZREG)(sp)
> +	addi	sp, sp, 4 * SZREG
> +	jr	t0
> +SYM_CODE_END(riscv_unfix_memory_alias)
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index 4ae67324f992..8dd43001cd10 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -1,8 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <asm/pgalloc.h>
> +#include <dt-bindings/riscv/physical-memory.h>
> +#include <linux/bitfield.h>
>  #include <linux/gfp.h>
>  #include <linux/kernel.h>
> +#include <linux/memblock.h>
> +#include <linux/of.h>
>  #include <linux/pgtable.h>
>
>  int ptep_set_access_flags(struct vm_area_struct *vma,
> @@ -155,3 +159,90 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>  	return pmd;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#ifdef CONFIG_RISCV_ISA_SVPBMT
> +struct memory_alias_pair {
> +	unsigned long cached_base;
> +	unsigned long noncached_base;
> +	unsigned long size;
> +	int index;
> +} memory_alias_pairs[5];
> +
> +bool __init riscv_have_memory_alias(void)
> +{
> +	return memory_alias_pairs[0].size;
> +}
> +
> +void __init riscv_init_memory_alias(void)
> +{
> +	int na = of_n_addr_cells(of_root);
> +	int ns = of_n_size_cells(of_root);
> +	int nc = na + ns + 2;
> +	const __be32 *prop;
> +	int pairs = 0;
> +	int len;
> +
> +	prop = of_get_property(of_root, "riscv,physical-memory-regions", &len);
> +	if (!prop)
> +		return;
> +
> +	len /= sizeof(__be32);
> +	for (int i = 0; len >= nc; i++, prop += nc, len -= nc) {
> +		unsigned long base = of_read_ulong(prop, na);
> +		unsigned long size = of_read_ulong(prop + na, ns);
> +		unsigned long flags = be32_to_cpup(prop + na + ns);
> +		struct memory_alias_pair *pair;
> +		int alias;
> +
> +		/* We only care about non-coherent memory. */
> +		if ((flags & PMA_ORDER_MASK) != PMA_ORDER_MEMORY || (flags & PMA_COHERENT))
> +			continue;
> +
> +		/* The cacheable alias must be usable memory. */
> +		if ((flags & PMA_CACHEABLE) &&
> +		    !memblock_overlaps_region(&memblock.memory, base, size))
> +			continue;
> +
> +		alias = FIELD_GET(PMR_ALIAS_MASK, flags);
> +		if (alias) {
> +			pair = NULL;
> +			for (int j = 0; j < pairs; j++) {
> +				if (alias == memory_alias_pairs[j].index) {
> +					pair = &memory_alias_pairs[j];
> +					break;
> +				}
> +			}
> +			if (!pair)
> +				continue;
> +		} else {
> +			/* Leave room for the null sentinel. */
> +			if (pairs == ARRAY_SIZE(memory_alias_pairs) - 1)
> +				continue;
> +			pair = &memory_alias_pairs[pairs++];
> +			pair->index = i;
> +		}
> +
> +		/* Align the address and size with the page table PFN field. */
> +		base >>= PAGE_SHIFT - _PAGE_PFN_SHIFT;
> +		size >>= PAGE_SHIFT - _PAGE_PFN_SHIFT;
> +
> +		if (flags & PMA_CACHEABLE)
> +			pair->cached_base = base;
> +		else
> +			pair->noncached_base = base;
> +		pair->size = min_not_zero(pair->size, size);
> +	}
> +
> +	/* Remove any unmatched pairs. */
> +	for (int i = 0; i < pairs; i++) {
> +		struct memory_alias_pair *pair = &memory_alias_pairs[i];
> +
> +		if (pair->cached_base && pair->noncached_base && pair->size)
> +			continue;
> +
> +		for (int j = i + 1; j < pairs; j++)
> +			memory_alias_pairs[j - 1] = memory_alias_pairs[j];
> +		memory_alias_pairs[--pairs].size = 0;
> +	}
> +}
> +#endif /* CONFIG_RISCV_ISA_SVPBMT */
> --
> 2.45.1

