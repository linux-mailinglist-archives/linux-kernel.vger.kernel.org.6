Return-Path: <linux-kernel+bounces-243155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B03929292
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9653FB21906
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178E6A8CF;
	Sat,  6 Jul 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYf7Q5aT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE25FBB7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261779; cv=none; b=QgR0DdBdH/fsMod595uuCO80o8mi/gqKpLQxg9u2dJY1lKSm4styO1n5Y+2FYHoDmp+yRjt4LsCt8yfXyI34vc7KkFVh6OK6lJQnfyOriNMkayxFKj3XQQjLkG+T6wYflA4/0AMJb+bWKyeOgn7lxp0/9fvSwONk0SRdEmylOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261779; c=relaxed/simple;
	bh=r7NUPpKWJkcWjWI8J6KpTF0A56sbKiYsklXo24upl50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvf2JH8QrOF7Wnljm7eeD0yuhCbsEPb2SdbggEQ7TFD7cAV5YI00Ew7YXMm/2WT3By77LPAD98Ojotl0kkTactiqC0r+RE5KXjhTfsxwi1NlOtV/zVlxDkwGc9DK37iV+vaaP5b4a4IVbpDjFgP88MU67S85hFZR5WlOyeraX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYf7Q5aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BAEC2BD10
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720261778;
	bh=r7NUPpKWJkcWjWI8J6KpTF0A56sbKiYsklXo24upl50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VYf7Q5aTuJhpwvGvH20moQv19ySOauc0HDO9p3/MMwhYO5B9+u+vvgbckDOM1sjPk
	 7Rgg3wRS6cZD5gWroCaEtiJsmWrqICUCF9kohc+XyusOJQvC6L1xcRFTkOx86zavtg
	 qLPmurbJTwjv9X8vtQ7Zx9GMVC5M2t2qXGEZWmBgkYp5/GsNqWjVGUU10SHmNRXZSS
	 boFtyiQot8QdZbW13aIszx2JeowdsKj3RdQsoDhM+5Pp2al84zu/zCmQVUZ6ty4Vv9
	 FMfuGbFHLt3YjsCbUZ4hnvT75Lv1B/eDC184A17+xvmp9IwjCKig+5nynfigDoW5Fq
	 a8P1zmqFthLqQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a75131ce948so283662066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 03:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6TkHmxxUTuMn5/7e30hgaWQIXedttIeI33nlQcp99KJjXZ8XEoFPWSZXHzUgxIyhwwsOzwfCMUFohzF80ACOIbk9zZ5lbfYRICWBf
X-Gm-Message-State: AOJu0Yzxe1jyaizon1nPo8SyzAX8I8IsPpThwewCUkbzT8QePpqW6fUB
	T4qx3Az+t/aFt4WxIYsp72AT4S5JhAZE0oyzrk1Gv9/FVqbaKi3LXVM3cWoiNucjKLuaiC0tx/7
	9Armh8avckjLrdMkKWCG1yNjHyPo=
X-Google-Smtp-Source: AGHT+IFNIEG18Cj0x0Siil0rzAqfYZr9X+bAg1/I4JmZ5boLndckP1EN+QzSiuFk9E3CIS6gwqCTWnSJBAOl5AHr57o=
X-Received: by 2002:a17:906:4f0f:b0:a6f:49eb:31a5 with SMTP id
 a640c23a62f3a-a77ba72e088mr380092966b.77.1720261777447; Sat, 06 Jul 2024
 03:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706073858.161035-1-xry111@xry111.site> <20240706073858.161035-2-xry111@xry111.site>
In-Reply-To: <20240706073858.161035-2-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jul 2024 18:29:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com>
Message-ID: <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add support for relocating the kernel with
 RELR relocation
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
	Youling Tang <tangyouling@kylinos.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Fangrui Song <maskray@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Sat, Jul 6, 2024 at 3:39=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> RELR as a relocation packing format for relative relocations for
> reducing the size of relative relocation records.  In a position
> independent executable there are often many relative relocation
> records, and our vmlinux is a PIE.
>
> The LLD linker (since 17.0.0) and the BFD linker (since 2.43) supports
> packing the relocations in the RELR format for LoongArch, with the flag
> -z pack-relative-relocs.
>
> Commits 5cf896fb6be3
> ("arm64: Add support for relocating the kernel with RELR relocations")
> and ccb2d173b983
> ("Makefile: use -z pack-relative-relocs") have already added the
> framework to use RELR.  We just need to wire it up and process the RELR
> relocation records in relocate_relative() in addition to the RELA
> relocation records.
>
> A ".p2align 3" directive is added to la_abs macro or the BFD linker
> cannot pack the relocation records against the .la_abs section (the
> ". =3D ALIGN(8);" directive in vmlinux.lds.S is too late in the linking
> process).
>
> With defconfig and CONFIG_RELR vmlinux.efi is 2.1 MiB (6%) smaller, and
> vmlinuz.efi (using gzip compression) is 384 KiB (2.8%) smaller.
>
> Link: https://groups.google.com/d/topic/generic-abi/bX460iggiKg
> Link: https://reviews.llvm.org/D138135#4531389
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Dd89=
ecf33ab6d
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig                |  1 +
>  arch/loongarch/include/asm/asmmacro.h |  1 +
>  arch/loongarch/include/asm/setup.h    |  5 +++++
>  arch/loongarch/kernel/relocate.c      | 18 ++++++++++++++++++
>  arch/loongarch/kernel/vmlinux.lds.S   |  8 ++++++++
>  5 files changed, 33 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ddc042895d01..03b3ef5edd24 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -607,6 +607,7 @@ config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>
>  config RELOCATABLE
>         bool "Relocatable kernel"
> +       select ARCH_HAS_RELR
Why is this selection under RELOCATABLE? I know ARM64 is the same, but why?

Huacai

>         help
>           This builds the kernel as a Position Independent Executable (PI=
E),
>           which retains all relocation metadata required, so as to reloca=
te
> diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/inclu=
de/asm/asmmacro.h
> index 655db7d7a427..8d7f501b0a12 100644
> --- a/arch/loongarch/include/asm/asmmacro.h
> +++ b/arch/loongarch/include/asm/asmmacro.h
> @@ -609,6 +609,7 @@
>         lu32i.d \reg, 0
>         lu52i.d \reg, \reg, 0
>         .pushsection ".la_abs", "aw", %progbits
> +       .p2align 3
>         .dword  766b
>         .dword  \sym
>         .popsection
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/=
asm/setup.h
> index ee52fb1e9963..3c2fb16b11b6 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -34,6 +34,11 @@ extern long __la_abs_end;
>  extern long __rela_dyn_begin;
>  extern long __rela_dyn_end;
>
> +#ifdef CONFIG_RELR
> +extern long __relr_dyn_begin;
> +extern long __relr_dyn_end;
> +#endif
> +
>  extern unsigned long __init relocate_kernel(void);
>
>  #endif
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/rel=
ocate.c
> index 69d73dc7326a..6abb9c91b255 100644
> --- a/arch/loongarch/kernel/relocate.c
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -37,6 +37,24 @@ static inline void __init relocate_relative(void)
>                 relocated_addr =3D (Elf64_Addr)RELOCATED(relocated_addr);
>                 *(Elf64_Addr *)RELOCATED(addr) =3D relocated_addr;
>         }
> +
> +#ifdef CONFIG_RELR
> +       u64 *relr =3D (u64 *)&__relr_dyn_begin;
> +       u64 *relr_end =3D (u64 *)&__relr_dyn_end;
> +       u64 *addr =3D NULL;
> +
> +       for ( ; relr < relr_end; relr++) {
> +               if ((*relr & 1) =3D=3D 0) {
> +                       addr =3D (u64 *)(*relr + reloc_offset);
> +                       *addr++ +=3D reloc_offset;
> +               } else {
> +                       for (u64 *p =3D addr, r =3D *relr >> 1; r; p++, r=
 >>=3D 1)
> +                               if (r & 1)
> +                                       *p +=3D reloc_offset;
> +                       addr +=3D 63;
> +               }
> +       }
> +#endif
>  }
>
>  static inline void __init relocate_absolute(long random_offset)
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/=
vmlinux.lds.S
> index 3c7595342730..08ea921cdec1 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -113,6 +113,14 @@ SECTIONS
>                 __rela_dyn_end =3D .;
>         }
>
> +#ifdef CONFIG_RELR
> +       .relr.dyn : ALIGN(8) {
> +               __relr_dyn_begin =3D .;
> +                *(.relr.dyn)
> +               __relr_dyn_end =3D .;
> +       }
> +#endif
> +
>         .data.rel : { *(.data.rel*) }
>
>  #ifdef CONFIG_RELOCATABLE
> --
> 2.45.2
>

