Return-Path: <linux-kernel+bounces-383787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD89B2036
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6A91C20E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC817BB25;
	Sun, 27 Oct 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azyC2cAt"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FD558BB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059818; cv=none; b=LzIyE507lZTQ0gFGlhXUCQzde1s9/WkC+UH7JWm3fIUVv0gYHdl5mER4jwna63yedrkz/xaNOxFfJRAgV4vjfvOtaOgE/cuQQa4xBugIZiSR4lZl637QdX9iOoRj/X8U29tClC8k8oArw4MK1BW1J69Y+ExQR/EWFUmmeFhUAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059818; c=relaxed/simple;
	bh=1PN1fQesQJ3nsQ1SuItnIWC1qEaXkPMDXLaojlXKF5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq9PU1uz/CGRSUFmZZoQJgkNgHIfkB5pzVuPtb/XcT0YXMg2sKx5ZmnNTGxRTIoS+rZ+ADG4dMu5xEVFzz7hFAJ1f+/bwbq2I/w6z3UKyxxbxfVmCiu4G2RbiP2ezTe2T6mRxabgoQwJc6zjdbRzpfiQHxbVusVV17IUf3Dcxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azyC2cAt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2428384b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730059816; x=1730664616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IcPykXlVzWmap0WJxwNrZ0QmvkKZjb6ImovIhp64Ts=;
        b=azyC2cAtlCn+vx+s9oYJ03athjUKi2sy0GMH2+bfzD25V9oQZNBf4DrARbxMbOW9vl
         PHbPhgThDb2OIRclXvQxKT12br0TjupH97/AV/uh9yElfLb12tnq5477RagMLdQucAy5
         l9fxv6/+gHV2pKOiNRE73/eEu4FrJrk8OF6sfA7uwPrcHMJ0JIKjo0dmn/VuKSUiJ2Fj
         Uvd9brgKmxe6UiB/+L8DyX8TfRlbMv47sUCWWuvYAFcS6jOWgNadIK37dEdDVoh8dhdN
         Due9f1I/NDSPNqe+Jj7hDlJZ/vIaE2exnEpTM9HMOVROuVjW/RQo5o0GwOBhoNuQRhAl
         dyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059816; x=1730664616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IcPykXlVzWmap0WJxwNrZ0QmvkKZjb6ImovIhp64Ts=;
        b=LL5OcAjBA6jKgBp92q8HYrVCgTW+uEJaRBMmR2e3jNTc7lvKJAAZtOjMjuzcqBb+kj
         gcP/MpgjEIpJDSmhkaIGmPsGymuekQPlQtE9ctYojKamh4jtbaAacqB0sGVg2MBMUaT7
         OjbnLwyvYm3rSlPASbYM3rpJrkA9C4ae2h499fn7Qlq1wEZ+lxcxAIv9zSebkq9VYZji
         RVFzLeRSYiBPiMif/oK7XpfIesFNnTrnTjT9rYiOtilg7h8SmGctpebOgrviAsv80i1U
         81lcjRrHQjFdIuV0RHLtp6pShLmUXepIvWXBkbzV/cfF0r+RqfzJfqUKjttr3A6txEVb
         DmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIdZa5eXBnc+X5Wqn2E6hmo5AcLA3IRz0o6iZ7787KMSu4z4WYZLnFCoKFAX8fnjtTB1j0bZuGLLhGiqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaA0CQhkZnCPwUMkboU8O0vGGI1u1kw1+aaNdnCNVoT2JrN7f
	egcmeEkYaV2Hze5CMhAtNLDOdF4RjwsmH44xtD7ge/K51SaqPgi/z+vTkHksBImIS7ExmKraifv
	CTipYNp6804v+yRlVmPJykKaWCVU=
X-Google-Smtp-Source: AGHT+IFM947AOOL5ljeFnUR8gsVzYkcDbeaK9fbdkVpqGbimn1UTrDsCfmAGHViUdXQaSxuKdeigDcHjISoZ8+a4oeY=
X-Received: by 2002:a05:6a00:a1d:b0:71e:5de:ad6d with SMTP id
 d2e1a72fcca58-72063094ed0mr9783146b3a.24.1730059815864; Sun, 27 Oct 2024
 13:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026171441.3047904-1-samuel.holland@sifive.com> <20241026171441.3047904-3-samuel.holland@sifive.com>
In-Reply-To: <20241026171441.3047904-3-samuel.holland@sifive.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Sun, 27 Oct 2024 16:09:40 -0400
Message-ID: <CAJFTR8SM0itMgdYYKNS6YAaBRMrwsEcNu9zyxKn5cV_uyZR1MQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: Allow NOMMU kernels to access all of RAM
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 1:16=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> NOMMU kernels currently cannot access memory below the kernel link
> address. Remove this restriction by setting PAGE_OFFSET to the actual
> start of RAM, as determined from the devicetree. The kernel link address
> must be a constant, so keep using CONFIG_PAGE_OFFSET for that purpose.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>

> ---
>
>  arch/riscv/include/asm/page.h    | 12 ++++--------
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 32d308a3355f..24d1ac052609 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -26,12 +26,9 @@
>   * When not using MMU this corresponds to the first free page in
>   * physical memory (aligned on a page boundary).
>   */
> -#ifdef CONFIG_64BIT
>  #ifdef CONFIG_MMU
> +#ifdef CONFIG_64BIT
>  #define PAGE_OFFSET            kernel_map.page_offset
> -#else
> -#define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> -#endif
>  /*
>   * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address spac=
e so
>   * define the PAGE_OFFSET value for SV48 and SV39.
> @@ -41,6 +38,9 @@
>  #else
>  #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
>  #endif /* CONFIG_64BIT */
> +#else
> +#define PAGE_OFFSET            ((unsigned long)phys_ram_base)
> +#endif /* CONFIG_MMU */
>
>  #ifndef __ASSEMBLY__
>
> @@ -97,11 +97,7 @@ typedef struct page *pgtable_t;
>  #define MIN_MEMBLOCK_ADDR      0
>  #endif
>
> -#ifdef CONFIG_MMU
>  #define ARCH_PFN_OFFSET                (PFN_DOWN((unsigned long)phys_ram=
_base))
> -#else
> -#define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
> -#endif /* CONFIG_MMU */
>
>  struct kernel_mapping {
>         unsigned long page_offset;
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index e79f15293492..e224ac66e635 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -12,7 +12,7 @@
>  #include <asm/pgtable-bits.h>
>
>  #ifndef CONFIG_MMU
> -#define KERNEL_LINK_ADDR       PAGE_OFFSET
> +#define KERNEL_LINK_ADDR       _AC(CONFIG_PAGE_OFFSET, UL)
>  #define KERN_VIRT_SIZE         (UL(-1))
>  #else
>
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

