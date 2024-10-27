Return-Path: <linux-kernel+bounces-383799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BEE9B2053
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E172A2810BF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE117CA09;
	Sun, 27 Oct 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQTr2gdj"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6315885E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060769; cv=none; b=TbMZcHL5hXXmyXCo5fgy05mfffyeTVPQO2Upk7swBgDAb4tpCZYA258iA+vbBW/P74p5wIixzkjfUenAISnY3MdX8F6qk+26LaZabFCkH8+HSG/wl8/YJQym/BUJkSIScmViaGQ93T8JwQaSrgnO/YRUPxRTIhQe1MAfbuUyDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060769; c=relaxed/simple;
	bh=4iX+hjIAsXN6wsa53VrKIxg2sWTgQk/YE6aPYpKH/eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaYrhBKP+UOHeJvTfPR2Su0ZSlmcPMXyFH0NL/eENwkEbQEKKoWynASeHqrzraF8Z0JEH+W7tKbxDKdPwOTFNOCtZNJH7Xm0G9+ROQ31AwSlvegcOeeKzt98VSZqHjptCINwpB81qSp+p82pTt+Mv1BZ4K+70GcoGG0bA6ba/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQTr2gdj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2468113a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730060766; x=1730665566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZQCNHp8BAwV5cLSWa4H7dFNLCnjYR05zJc1+gDeJDI=;
        b=DQTr2gdjzAtpnq7mI0CQufkjDUoN+NLY/d4xT2pLTGdaZG3/5JAv21SYNu+FcjN0mW
         KegKtuc6zbKgj8SSs7vpcfXQj/ILHIA3gMoxHlDfZ8jvzjiGLmOlUG7jyRyVdc2GvD3V
         fxvtBAlCone/LL4Pfv+4bi186j7k9EwDOBWsVo5Pr9Q+Yb1AJMmJnS8ysoEUbuah11tX
         DFQSRkkRNRkeyN6wwk+rnr3eoaAsFamoy7Ts/WDidb64v/KY9TnHE4fGvqBGmxmv+F0z
         slbcz4N0PU+/ZgGHS0dGJVPDASbhcuwEohc6Bkn3Q4yEQNku/xXNCc7eGrAM0bLUk00g
         4J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730060766; x=1730665566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZQCNHp8BAwV5cLSWa4H7dFNLCnjYR05zJc1+gDeJDI=;
        b=lMKzzxqu5euwi+4PhwIiFYo9/ir4+KjfnCEeV2ME1e+CiMNeWSkCbdZmbMVUiDesNE
         oear7/RSeZED8T355BQKUieNQgSCs+T9Rq6JusbUihIxfAWlQgU8itONjiNuO6mK9DAW
         mLAzVxwT6gCo2w8VgyTT9Mk3I1RqTpjhF4LxFRjEyEEAGDqIhvuX4JTad2KqPE4DRcQt
         hOp9+jzKpQtLRmI/+obR5VWZw+sH8+0okOE9VbPdwa3E/c/ic98jPiXa0RAZK890j/li
         FG3U+Wa4CINARP7OmCCLqjyJbFVhwrCYNer1B+SjLxg94wyy96kvGI57f/SkFuNYd0qS
         6Y5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/2FpTnRXf7yYd2hQFN/PfC0ERRKOinjJguOMPYhqrPu6f+2PZyGDMpYAiHihVWfiKc8B/NdM//2q7wV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfxuTu4ZbjD4dHtE6ymzrcRHSOePKsUIZJNmeb8F/Hec09FgA
	ZET9aZrlJbaHeLP15ee9WzZCwgQrxyD9NVXZbsUcYT/rclVX9QZBNWFeepwnuH0NKVzJ0BMXWiI
	sbrakPe2UUCUBrrtOqpUj0Ed41R8=
X-Google-Smtp-Source: AGHT+IEoV85pZcjnD1jjPkci6ROXQwwjZK5h8YcKZWw55Z0O/M8GYhsNQm6DwRg6UntvImKPJovBgxeoxAV5ndIHAgU=
X-Received: by 2002:a17:90b:17cc:b0:2e2:92dc:6fd4 with SMTP id
 98e67ed59e1d1-2e8f107d4camr8257794a91.23.1730060766027; Sun, 27 Oct 2024
 13:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026171441.3047904-1-samuel.holland@sifive.com> <20241026171441.3047904-7-samuel.holland@sifive.com>
In-Reply-To: <20241026171441.3047904-7-samuel.holland@sifive.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Sun, 27 Oct 2024 16:25:30 -0400
Message-ID: <CAJFTR8RJYdT6CQ=FgBkM3jUj=PnYnuyi3+bO3=NPeH6xJ6TTaw@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: Remove CONFIG_PAGE_OFFSET
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 1:16=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> The current definition of CONFIG_PAGE_OFFSET is problematic for a couple
> of reasons:
>  1) The value is misleading for normal 64-bit kernels, where it is
>     overridden at runtime if Sv48 or Sv39 is chosen. This is especially
>     the case for XIP kernels, which always use Sv39.
>  2) The option is not user-visible, but for NOMMU kernels it must be a
>     valid RAM address, and for !RELOCATABLE it must additionally be the
>     exact address where the kernel is loaded.
>
> Fix both of these by removing the option.
>  1) For MMU kernels, drop the indirection through Kconfig. Additionally,
>     for XIP, drop the indirection through kernel_map.
>  2) For NOMMU kernels, use the user-visible physical RAM base if
>     provided. Otherwise, force the kernel to be relocatable.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Jesse Taube <mr.bossman075@gmail.com>

> ---
>
>  arch/riscv/Kconfig               |  8 +-------
>  arch/riscv/include/asm/page.h    | 15 ++++++++-------
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             |  8 ++------
>  4 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 33aa79d84021..297ccbf4b5ce 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -195,6 +195,7 @@ config RISCV
>         select PCI_DOMAINS_GENERIC if PCI
>         select PCI_ECAM if (ACPI && PCI)
>         select PCI_MSI if PCI
> +       select RELOCATABLE if !MMU && !PHYS_RAM_BASE_FIXED
>         select RISCV_ALTERNATIVE if !XIP_KERNEL
>         select RISCV_APLIC
>         select RISCV_IMSIC
> @@ -282,13 +283,6 @@ config MMU
>           Select if you want MMU-based virtualised addressing space
>           support by paged memory management. If unsure, say 'Y'.
>
> -config PAGE_OFFSET
> -       hex
> -       default 0x80000000 if !MMU && RISCV_M_MODE
> -       default 0x80200000 if !MMU

Should the default values above now be moved to CONFIG_PHYS_RAM_BASE?

> -       default 0xc0000000 if 32BIT
> -       default 0xff60000000000000 if 64BIT
> -
>  config KASAN_SHADOW_OFFSET
>         hex
>         depends on KASAN_GENERIC
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 24d1ac052609..d1acd1efe0dc 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -28,15 +28,16 @@
>   */
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_64BIT
> -#define PAGE_OFFSET            kernel_map.page_offset
> -/*
> - * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address spac=
e so
> - * define the PAGE_OFFSET value for SV48 and SV39.
> - */
> +#define PAGE_OFFSET_L5         _AC(0xff60000000000000, UL)
>  #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
>  #define PAGE_OFFSET_L3         _AC(0xffffffd600000000, UL)
> +#ifdef CONFIG_XIP_KERNEL
> +#define PAGE_OFFSET            PAGE_OFFSET_L3
>  #else
> -#define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> +#define PAGE_OFFSET            kernel_map.page_offset
> +#endif /* CONFIG_XIP_KERNEL */
> +#else
> +#define PAGE_OFFSET            _AC(0xc0000000, UL)
>  #endif /* CONFIG_64BIT */
>  #else
>  #define PAGE_OFFSET            ((unsigned long)phys_ram_base)
> @@ -100,7 +101,6 @@ typedef struct page *pgtable_t;
>  #define ARCH_PFN_OFFSET                (PFN_DOWN((unsigned long)phys_ram=
_base))
>
>  struct kernel_mapping {
> -       unsigned long page_offset;
>         unsigned long virt_addr;
>         unsigned long virt_offset;
>         uintptr_t phys_addr;
> @@ -114,6 +114,7 @@ struct kernel_mapping {
>         uintptr_t xiprom;
>         uintptr_t xiprom_sz;
>  #else
> +       unsigned long page_offset;
>         unsigned long va_kernel_pa_offset;
>  #endif
>  };
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index d0190ee9b2e4..b8125c3aa85d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -15,7 +15,7 @@
>  #ifdef CONFIG_RELOCATABLE
>  #define KERNEL_LINK_ADDR       UL(0)
>  #else
> -#define KERNEL_LINK_ADDR       _AC(CONFIG_PAGE_OFFSET, UL)
> +#define KERNEL_LINK_ADDR       _AC(CONFIG_PHYS_RAM_BASE, UL)
>  #endif
>  #define KERN_VIRT_SIZE         (UL(-1))
>  #else
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0aad925848a4..a1a185e6faf0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -843,6 +843,8 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
>         uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & =
PMD_MASK;
>         u64 satp_mode_cmdline =3D __pi_set_satp_mode_from_cmdline(dtb_pa)=
;
>
> +       kernel_map.page_offset =3D PAGE_OFFSET_L5;
> +
>         if (satp_mode_cmdline =3D=3D SATP_MODE_57) {
>                 disable_pgtable_l5();
>         } else if (satp_mode_cmdline =3D=3D SATP_MODE_48) {
> @@ -1090,11 +1092,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         kernel_map.virt_addr =3D KERNEL_LINK_ADDR + kernel_map.virt_offse=
t;
>
>  #ifdef CONFIG_XIP_KERNEL
> -#ifdef CONFIG_64BIT
> -       kernel_map.page_offset =3D PAGE_OFFSET_L3;
> -#else
> -       kernel_map.page_offset =3D _AC(CONFIG_PAGE_OFFSET, UL);
> -#endif
>         kernel_map.xiprom =3D (uintptr_t)CONFIG_XIP_PHYS_ADDR;
>         kernel_map.xiprom_sz =3D (uintptr_t)(&_exiprom) - (uintptr_t)(&_x=
iprom);
>
> @@ -1106,7 +1103,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         kernel_map.va_kernel_xip_data_pa_offset =3D kernel_map.virt_addr =
- kernel_map.phys_addr
>                                                 + (uintptr_t)&_sdata - (u=
intptr_t)&_start;
>  #else
> -       kernel_map.page_offset =3D _AC(CONFIG_PAGE_OFFSET, UL);
>         kernel_map.phys_addr =3D (uintptr_t)(&_start);
>         kernel_map.size =3D (uintptr_t)(&_end) - kernel_map.phys_addr;
>         kernel_map.va_kernel_pa_offset =3D kernel_map.virt_addr - kernel_=
map.phys_addr;
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

