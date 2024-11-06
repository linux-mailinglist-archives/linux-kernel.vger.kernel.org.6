Return-Path: <linux-kernel+bounces-398611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1019BF397
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE452B22081
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA58204F94;
	Wed,  6 Nov 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0SpbMFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E8202640
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911850; cv=none; b=Lw6DOaQH+bEOjhZrOYyxoTxGpsMWGG34j3/qB3vvhyfetXxdBWoKn5ct3RTFZC3F1Rh8NG7huhI/b02c4AdIClKH+UUOfpzb0Cl/1d/xESXu0tVL+yecaMzRRfy+xr7F98QPAp+gdtUQYE378d0J9TpQinVMoOntjVQqE5or/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911850; c=relaxed/simple;
	bh=q5gWslTmXOmIKIR0Phq9m4RfTGiKSPy5Vie0dZjlCMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TAP/uLZHOMFxi60C/rZeyHgSF+omYUyAqdLjLeNfFjDnLfdmR3JmD5kRs5PihmE3pFMrXZpvoQqr5rdTThxNq7jtxsSERIuYI+wY2hoQ2y0MnfhtiSBAZ2RFXGXijP4J9Nc2O46tT8FiPKfq2SlWjX8sEtIvGG7TW+7sGzG6d3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0SpbMFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D6BC4CECC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730911850;
	bh=q5gWslTmXOmIKIR0Phq9m4RfTGiKSPy5Vie0dZjlCMs=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=Z0SpbMFo6GLAzOOz2gLz5q1UWHVpDFpHBo+ZFAQ3z1oG359PMh7J5v3SQhQzRaywz
	 bh3BoUpafHAdzhZrtsI+aCSglRjNLfGEAeDlfWs+AVAUn5tTAzXTHNLY465yvvmKRR
	 wSNs/VHgb4in08ZmedvDk+wCMrAdao+aztkOLlx8OQBN5cs62tcOzuMFtsS/TTQsT+
	 McKc8AFmoR/GF1oQNgJMqFE1Bx9XWu8T9Of610bfpIl8D/rmoPIweJE4KAteniVXSp
	 cv0AwkXQpZJ0hLKuhpBRZJBtZUp/XfV/0uwtKPx6BQyKKTybNF5fJAp6oulNX3LbaN
	 Ty1RuFDRvelFw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so7100829e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjCfS7fkAs61X5bKSM58aDHeu7k99qHmBCHm1HAV5mNoQT/CODjyx88vf4sZKL75l66HfsTUhQ46dRSO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtutxbuSFo1n30VM7/0gZvPnckxEMbjf6DI+jfxKu9ycsNwWBT
	OmKbjkgSvB5oPg8F4F+lOKtjjs11c/Gj6+tbG4UY+6Z0cHtDygDfN6O5nlLDA77322Ytc540XMj
	Bn34Sy5zdtxyON0IxrU/yrRqSd4g=
X-Google-Smtp-Source: AGHT+IFyxo6dsdnmJ8QGD0SQSLP0HIXjeKp08U+g4sEiUit9BBwDnXW50YxV01tXz9p6AqltEhx+UId84EpQFpok1Oo=
X-Received: by 2002:a05:6512:12c8:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-53b348e2efbmr21462389e87.30.1730911848876; Wed, 06 Nov 2024
 08:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918045431.607826-1-masahiroy@kernel.org>
In-Reply-To: <20240918045431.607826-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 7 Nov 2024 01:50:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARJrLA2fC1Jdj+xK8yZk_Y_Xb6MwxqWM_9CTEQjJiZXZg@mail.gmail.com>
Message-ID: <CAK7LNARJrLA2fC1Jdj+xK8yZk_Y_Xb6MwxqWM_9CTEQjJiZXZg@mail.gmail.com>
Subject: Re: [PATCH] microblaze: use the common infrastructure to support
 built-in DTB
To: Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 1:54=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> MicroBlaze is the only architecture that supports a built-in DTB in
> its own way.
>
> Other architectures (e.g., ARC, NIOS2, RISC-V, etc.) use the common
> infrastructure introduced by commit aab94339cd85 ("of: Add support for
> linking device tree blobs into vmlinux").
>
> This commit migrates MicroBlaze to this common infrastructure.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Ping?



>
> I do not know why MicroBlaze still adopts its own way.
> Perhaps, because MicroBlaze supports the built-in DTB
> before aab94339cd85 and nobody attempted migration.
> Anyway, I only compile-tested this patch.
> I hope the maintainer can do boot-testing.
>
>  arch/microblaze/boot/Makefile          | 3 +--
>  arch/microblaze/boot/dts/Makefile      | 5 +----
>  arch/microblaze/boot/dts/linked_dtb.S  | 2 --
>  arch/microblaze/include/asm/sections.h | 2 --
>  arch/microblaze/kernel/head.S          | 2 +-
>  arch/microblaze/kernel/setup.c         | 4 ++--
>  arch/microblaze/kernel/vmlinux.lds.S   | 8 --------
>  7 files changed, 5 insertions(+), 21 deletions(-)
>  delete mode 100644 arch/microblaze/boot/dts/linked_dtb.S
>
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefil=
e
> index 2b42c370d574..23a48e090f93 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -17,8 +17,7 @@ $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
>         $(call if_changed,gzip)
>
>  quiet_cmd_strip =3D STRIP   $< $@$2
> -       cmd_strip =3D $(STRIP) -K microblaze_start -K _end -K __log_buf \
> -                               -K _fdt_start $< -o $@$2
> +       cmd_strip =3D $(STRIP) -K microblaze_start -K _end -K __log_buf $=
< -o $@$2
>
>  UIMAGE_LOADADDR =3D $(CONFIG_KERNEL_BASE_ADDR)
>
> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts=
/Makefile
> index b84e2cbb20ee..f168a127bf94 100644
> --- a/arch/microblaze/boot/dts/Makefile
> +++ b/arch/microblaze/boot/dts/Makefile
> @@ -4,10 +4,7 @@
>  dtb-y :=3D system.dtb
>
>  ifneq ($(DTB),)
> -obj-y +=3D linked_dtb.o
> -
> -# Ensure system.dtb exists
> -$(obj)/linked_dtb.o: $(obj)/system.dtb
> +obj-y +=3D system.dtb.o
>
>  # Generate system.dtb from $(DTB).dtb
>  ifneq ($(DTB),system)
> diff --git a/arch/microblaze/boot/dts/linked_dtb.S b/arch/microblaze/boot=
/dts/linked_dtb.S
> deleted file mode 100644
> index 23345af3721f..000000000000
> --- a/arch/microblaze/boot/dts/linked_dtb.S
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -.section __fdt_blob,"a"
> -.incbin "arch/microblaze/boot/dts/system.dtb"
> diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/inc=
lude/asm/sections.h
> index a9311ad84a67..6bc4855757c3 100644
> --- a/arch/microblaze/include/asm/sections.h
> +++ b/arch/microblaze/include/asm/sections.h
> @@ -14,7 +14,5 @@
>  extern char _ssbss[], _esbss[];
>  extern unsigned long __ivt_start[], __ivt_end[];
>
> -extern u32 _fdt_start[], _fdt_end[];
> -
>  # endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_MICROBLAZE_SECTIONS_H */
> diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.=
S
> index ec2fcb545e64..9727aa1934df 100644
> --- a/arch/microblaze/kernel/head.S
> +++ b/arch/microblaze/kernel/head.S
> @@ -95,7 +95,7 @@ big_endian:
>         bnei    r11, no_fdt_arg                 /* No - get out of here *=
/
>  _prepare_copy_fdt:
>         or      r11, r0, r0 /* incremment */
> -       ori     r4, r0, TOPHYS(_fdt_start)
> +       ori     r4, r0, TOPHYS(__dtb_start)
>         ori     r3, r0, (0x10000 - 4)
>  _copy_fdt:
>         lw      r12, r7, r11 /* r12 =3D r7 + r11 */
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setu=
p.c
> index f417333eccae..8e57b490ca9c 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -120,7 +120,7 @@ void __init machine_early_init(const char *cmdline, u=
nsigned int ram,
>         memset(_ssbss, 0, _esbss-_ssbss);
>
>  /* initialize device tree for usage in early_printk */
> -       early_init_devtree(_fdt_start);
> +       early_init_devtree(__dtb_start);
>
>         /* setup kernel_tlb after BSS cleaning
>          * Maybe worth to move to asm code */
> @@ -132,7 +132,7 @@ void __init machine_early_init(const char *cmdline, u=
nsigned int ram,
>         if (fdt)
>                 pr_info("FDT at 0x%08x\n", fdt);
>         else
> -               pr_info("Compiled-in FDT at %p\n", _fdt_start);
> +               pr_info("Compiled-in FDT at %p\n", __dtb_start);
>
>  #ifdef CONFIG_MTD_UCLINUX
>         pr_info("Found romfs @ 0x%08x (0x%08x)\n",
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kerne=
l/vmlinux.lds.S
> index ae50d3d04a7d..3d4a78aa9ab4 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -44,14 +44,6 @@ SECTIONS {
>                 _etext =3D . ;
>         }
>
> -       . =3D ALIGN (8) ;
> -       __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
> -               _fdt_start =3D . ;                /* place for fdt blob *=
/
> -               *(__fdt_blob) ;                 /* Any link-placed DTB */
> -               . =3D _fdt_start + 0x10000;       /* Pad up to 64kbyte */
> -               _fdt_end =3D . ;
> -       }
> -
>         . =3D ALIGN(16);
>         RO_DATA(4096)
>
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

