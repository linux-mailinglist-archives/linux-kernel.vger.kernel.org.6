Return-Path: <linux-kernel+bounces-363936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F599C8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379B11F225DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8C156C74;
	Mon, 14 Oct 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2oNtDd4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA18132117
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904906; cv=none; b=lsrky4pcGXJdg+ySL3VbRUG6Nk1DUV4dqCkR06ljWfsU5/u7516ShcIjAOtg4Ni1IE38RWhZPM2pTM79bq65P4JFPh6cr8myCTHhtUN9yPV0A9dibV/tDa7Jj5+QuDyJgT8bAlwig96SFAGDSxw+O0aMBR5u62q6WEI4DhcrvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904906; c=relaxed/simple;
	bh=+7T/y8axk+fY+zCEhjt1LeFQcJ0MRlfZp7zXj0VpMvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG7JYVUXG7Ibyn5rpd88c2LggCeV0cQd+FMXnwY0BTyI5tRj00dZplZ3BWkuZNmKzq7kvgyajMmwC6rcJg5CxBmnV4z0WG9amoDKJm92Ei+2IOfeN1M3I/ndsRVNt0Dsqaax6XMsuDODWHEOCcJFv8SKIiqEgpdvbncE0lp8OOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2oNtDd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F4C4CEC7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728904906;
	bh=+7T/y8axk+fY+zCEhjt1LeFQcJ0MRlfZp7zXj0VpMvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o2oNtDd4EX3QAO0cLSRzaHtc7sMJ8uFx7OBuh122aMuiZddEVLeaQ9NTH9bIPUVOe
	 hy0F/wFh+vsefp0v3F3e+N+JRCUDKe8+Y/wj5tp9v5g4d4yPWds5C3hnAvK/Z0lGm9
	 wYkPSHRNfIC8/kOXwKExZSQZ50Aq2hKKmyxJDgv4wpl+G6UDEQX82DasKW0htZ7pu8
	 5wpMcmu7lTfnhoeDP0CrqMs4Lv7F/L9ILPYcD6uy5r/EPgtQc5Oi6eZaAXC4/iPln+
	 QZes3GAjAE++28hai0N/K/4ZZlWbvpNcc9YNHVMsUj/nk39pdGzhhia8G6Z0RBKULs
	 ZwdAqpRpJJK9A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so1175510e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:21:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBhVa44MsTe2sxMzkznlA0oknfW3vM7zzCJQ8tRzHaTrGqonRQDJvnF7xxfIcDyKLuED8VvDEp3QaieNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStx8ChC/4vletTJ63n3O9uETC3wplaKI0J/wwn/StXjW9lnwE
	rE3NXHnINAbQA+Y3sYukXclboCuCsQRsTXTPZ4qfYHmp87/ld6UVSKfnKHT+Efxj2KKVkSaDwyT
	Rf6Xc6dBOlHSH94FI4ZHegH9o4lY=
X-Google-Smtp-Source: AGHT+IEqaJeyEBwK7hZ31LhkdFi1dlMxvxTeV2ekzn+xlpJY+hKsvIJBOiqhNyJ8gi3i7z4QCwpyA1gQ1aVdx1vFAI8=
X-Received: by 2002:a05:6512:2256:b0:539:945a:cb4a with SMTP id
 2adb3069b0e04-539da4d65e3mr4478951e87.30.1728904904526; Mon, 14 Oct 2024
 04:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com> <20241014105912.3207374-55-ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-55-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 13:21:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHt9eCoPgJLo0kJ1TuSQ71dpnjB1pLdRO0HiOA3jFNd7w@mail.gmail.com>
Message-ID: <CAMj1kXHt9eCoPgJLo0kJ1TuSQ71dpnjB1pLdRO0HiOA3jFNd7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 55/57] arm64: TRAMP_VALIAS is no longer
 compile-time constant
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Hildenbrand <david@redhat.com>, Greg Marsden <greg.marsden@oracle.com>, 
	Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Ryan,

On Mon, 14 Oct 2024 at 13:02, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> When boot-time page size is in operation, TRAMP_VALIAS is no longer a
> compile-time constant, because the VA of a fixmap slot depends upon
> PAGE_SIZE.
>
> Let's handle this by instead exporting the slot index,
> FIX_ENTRY_TRAMP_BEGIN,to assembly, then do the TRAMP_VALIAS calculation
> per page size and use alternatives to decide which variant to activate.
>
> Note that for the tramp_map_kernel case, we are one instruction short of
> space in the vector to have NOPs for all 3 page size variants. So we do
> if/else for 16K/64K and branch around it for the 4K case. This saves 2
> instructions.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>
>  arch/arm64/kernel/asm-offsets.c |  2 +-
>  arch/arm64/kernel/entry.S       | 50 ++++++++++++++++++++++++++-------
>  2 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index f32b8d7f00b2a..c45fa3e281884 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -172,7 +172,7 @@ int main(void)
>    DEFINE(ARM64_FTR_SYSVAL,     offsetof(struct arm64_ftr_reg, sys_val));
>    BLANK();
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -  DEFINE(TRAMP_VALIAS,         TRAMP_VALIAS);
> +  DEFINE(FIX_ENTRY_TRAMP_BEGIN,        FIX_ENTRY_TRAMP_BEGIN);
>  #endif
>  #ifdef CONFIG_ARM_SDE_INTERFACE
>    DEFINE(SDEI_EVENT_INTREGS,   offsetof(struct sdei_registered_event, interrupted_regs));
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 7ef0e127b149f..ba47dc8672c04 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -101,11 +101,27 @@
>  .org .Lventry_start\@ + 128    // Did we overflow the ventry slot?
>         .endm
>
> +#define TRAMP_VALIAS(page_shift)       (FIXADDR_TOP - (FIX_ENTRY_TRAMP_BEGIN << (page_shift)))
> +
>         .macro  tramp_alias, dst, sym
> -       .set    .Lalias\@, TRAMP_VALIAS + \sym - .entry.tramp.text
> -       movz    \dst, :abs_g2_s:.Lalias\@
> -       movk    \dst, :abs_g1_nc:.Lalias\@
> -       movk    \dst, :abs_g0_nc:.Lalias\@
> +alternative_if ARM64_USE_PAGE_SIZE_4K
> +       .set    .Lalias4k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) + \sym - .entry.tramp.text
> +       movz    \dst, :abs_g2_s:.Lalias4k\@
> +       movk    \dst, :abs_g1_nc:.Lalias4k\@
> +       movk    \dst, :abs_g0_nc:.Lalias4k\@
> +alternative_else_nop_endif
> +alternative_if ARM64_USE_PAGE_SIZE_16K
> +       .set    .Lalias16k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) + \sym - .entry.tramp.text
> +       movz    \dst, :abs_g2_s:.Lalias16k\@
> +       movk    \dst, :abs_g1_nc:.Lalias16k\@
> +       movk    \dst, :abs_g0_nc:.Lalias16k\@
> +alternative_else_nop_endif
> +alternative_if ARM64_USE_PAGE_SIZE_64K
> +       .set    .Lalias64k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) + \sym - .entry.tramp.text
> +       movz    \dst, :abs_g2_s:.Lalias64k\@
> +       movk    \dst, :abs_g1_nc:.Lalias64k\@
> +       movk    \dst, :abs_g0_nc:.Lalias64k\@
> +alternative_else_nop_endif

Since you're changing these, might as well drop the middle movk as the
fixmap is now always in the top 2 GiB of the VA space.

However, wouldn't it be better to reuse the existing callback
alternative stuff that Marc added for KVM?

Same applies below, I reckon.

>         .endm
>
>         /*
> @@ -627,16 +643,30 @@ SYM_CODE_END(ret_to_user)
>         bic     \tmp, \tmp, #USER_ASID_FLAG
>         msr     ttbr1_el1, \tmp
>  #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
> -alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
> +alternative_if_not ARM64_WORKAROUND_QCOM_FALKOR_E1003
> +       b       .Lskip_falkor_e1003\@
> +alternative_else_nop_endif
>         /* ASID already in \tmp[63:48] */
> -       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS >> 12)
> -       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS >> 12)
> -       /* 2MB boundary containing the vectors, so we nobble the walk cache */
> -       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS & ~(SZ_2M - 1)) >> 12)
> +alternative_if ARM64_USE_PAGE_SIZE_4K
> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) >> 12)
> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) >> 12)
> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) & ~(SZ_2M - 1)) >> 12)
> +       b       .Lfinish_falkor_e1003\@
> +alternative_else_nop_endif
> +alternative_if ARM64_USE_PAGE_SIZE_16K
> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) >> 12)
> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) >> 12)
> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) & ~(SZ_2M - 1)) >> 12)
> +alternative_else /* ARM64_USE_PAGE_SIZE_64K */
> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) >> 12)
> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) >> 12)
> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) & ~(SZ_2M - 1)) >> 12)
> +alternative_endif
> +.Lfinish_falkor_e1003\@:
>         isb
>         tlbi    vae1, \tmp
>         dsb     nsh
> -alternative_else_nop_endif
> +.Lskip_falkor_e1003\@:
>  #endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
>         .endm
>
> --
> 2.43.0
>

