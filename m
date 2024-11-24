Return-Path: <linux-kernel+bounces-419341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8A9D6CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 06:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541D2281603
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 05:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F2717C21B;
	Sun, 24 Nov 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed/yWe9f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33313CA99
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732426469; cv=none; b=ihGDQQqSAwo1eVmQuSX9sD/2ElnGqFflSj6q+81yUoXKHZwhpXJOa/Zx+VhmxdG0EUcgCeggJCQ44oicbqrx2nxtoBwnN44+p+HS38UgYm0HvnhkVc3mDZ/a3D3rFUqZ+1YqbtVWnkjV8Wu+2GRz8thToTWKiHMp8k6Og8EFnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732426469; c=relaxed/simple;
	bh=AxO+Pg1ZL7zuTvuRbry0ud0Rw5kP/Li2sbaEC93Ilh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6hYy7GW+gDplDVkfFNcCiR4x7N0vV7K7Mftp4seM2lnEhU0Fufhhm7y5E/Z5UXA7ZAp4C+/FsMsMYQ4DY293AuyzLFQxWkdrPDIcceIs0O970mx8OFrbCkk1IZsgTgXXzptp1XAWhpauPotiyxYUZZbjdB5sGwi6qlKEqgkOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed/yWe9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D7C4CECC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732426468;
	bh=AxO+Pg1ZL7zuTvuRbry0ud0Rw5kP/Li2sbaEC93Ilh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ed/yWe9fIRfHfari8vf99EQYJnoRwUtKeyhVjbUbrsZbWPEik3flN6eTLdhYKRmAh
	 GzmD7aAnr4pWM/T/WkrOpCTr+IFVsWV/lQ3PTsgc+Lrziv7EyGutyJ2j5wDO5+Of0d
	 ncwk67ceI/lpC7TNhRnvmDO6knjJk/xqd8ltihEgERds+Fp0XwsxsEegJ3Lec4mz+F
	 2CY3MFdp6zxdfQNouqj4Ut/93kQBB7PNOZ9Y5+KFhkq71faJf4UA2QEy9fhZdbjUNa
	 K4jAfXLiMdC9hqeZ/hneixn09aYUr+082vuiOTTz40uXHEOZkgLaQcLnJXcE438eGE
	 RpiLWMJf9vtig==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa520699becso266545766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 21:34:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqu3hxpYaRAKerXs0+kaGxK0Yzb8lzrm6sp2HPnP61rbUfx0MUKVRKnjUgeMwfNmNevRUE+bCq/7TG7Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZB1Kt26Suut6EvW2PbKEKBmgdqcyJJzdn8jeLBiCJMN5eEri
	rDlHvbK1z3A0UdMKvNcUwLZTyWJEMhVOO940jfIkn/NlhMjAMFQSmuaGzCNS7Nlzm5HhOl11K/d
	GAo5y/yjfgNZjUE243DoK5C3ukIQ=
X-Google-Smtp-Source: AGHT+IF/vGFmamNRZm0Qw20SbPQ2qIVLqFy2rDL4W5C3b7ksC6dQ4J6wwZS/fdzezW/oGI0+OYcnkwNhga3gLDsdaPg=
X-Received: by 2002:a17:906:cc9:b0:aa5:45f3:cbda with SMTP id
 a640c23a62f3a-aa545f3d410mr101227166b.56.1732426467484; Sat, 23 Nov 2024
 21:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119065051.18449-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241119065051.18449-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 24 Nov 2024 13:34:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Kg0_-YD1BNw32n3sNcVYAcio=+1OtKFABy0Sk_vw-0A@mail.gmail.com>
Message-ID: <CAAhV-H4Kg0_-YD1BNw32n3sNcVYAcio=+1OtKFABy0Sk_vw-0A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix build failure with GCC 15 (-std=gnu23)
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Nov 19, 2024 at 2:51=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Whenever I try to build the kernel with upcoming GCC 15 which defaults
> to -std=3Dgnu23 I get a build failure:
>
>   CC      arch/loongarch/vdso/vgetcpu.o
> In file included from ./include/uapi/linux/posix_types.h:5,
>                  from ./include/uapi/linux/types.h:14,
>                  from ./include/linux/types.h:6,
>                  from ./include/linux/kasan-checks.h:5,
>                  from ./include/asm-generic/rwonce.h:26,
>                  from ./arch/loongarch/include/generated/asm/rwonce.h:1,
>                  from ./include/linux/compiler.h:317,
>                  from ./include/asm-generic/bug.h:5,
>                  from ./arch/loongarch/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:6,
>                  from ./arch/loongarch/include/asm/vdso.h:10,
>                  from arch/loongarch/vdso/vgetcpu.c:6:
> ./include/linux/stddef.h:11:9: error: expected identifier before 'false'
>    11 |         false   =3D 0,
>       |         ^~~~~
> ./include/linux/types.h:35:33: error: two or more data types in declarati=
on specifiers
>    35 | typedef _Bool                   bool;
>       |                                 ^~~~
> ./include/linux/types.h:35:1: warning: useless type name in empty declara=
tion
>    35 | typedef _Bool                   bool;
>       | ^~~~~~~
>
> The kernel builds explicitly with -std=3Dgnu11 in top Makefile, but
> arch/loongarch/vdso does not use KBUILD_CFLAGS from the rest of the
> kernel, just add -std=3Dgnu11 flag to arch/loongarch/vdso/Makefile.
>
> By the way, commit e8c07082a810 ("Kbuild: move to -std=3Dgnu11") did a
> similar change for arch/arm64/kernel/vdso32/Makefile.
>
> Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 40c1175823d6..fdde1bcd4e26 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -19,7 +19,7 @@ ccflags-vdso :=3D \
>  cflags-vdso :=3D $(ccflags-vdso) \
>         -isystem $(shell $(CC) -print-file-name=3Dinclude) \
>         $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> -       -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
> +       -std=3Dgnu11 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin=
 \
>         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING =
\
>         $(call cc-option, -fno-asynchronous-unwind-tables) \
>         $(call cc-option, -fno-stack-protector)
> --
> 2.42.0
>

