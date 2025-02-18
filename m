Return-Path: <linux-kernel+bounces-519020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A59A39734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79143BB65A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E022FAE1;
	Tue, 18 Feb 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/lPDmOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BC2309B6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870961; cv=none; b=BB/4gX3HgUMto2xKTMGAQcTbuNwP0wFXTW1V4lN1G7qM5NPKjBZVnBKpuxmvW37YKTGiw1Jn1X+j2CBkMBZUVmihABo/X+hLPVAJxxHjTpTm2UFqEQ+xab4G1dbOD0WxI16sjZfPy+PPnRL3jfaZwnpqg/d1QuoePgJ1eRGaW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870961; c=relaxed/simple;
	bh=Vt8uHoPI1XZNaOMHC73ISJa9D5QU0i2SrQwJ8IeWBPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QErMUeZ1zseSz0oemwH72G9r1bQ3d9a457V80dvjmBHyixQeYjP1B+pd+po3mtQ/21mLuFpqHUS1/Y3xhV+dSUf/9ou5U8ZchucRXKwROoFFhfmuOtGVl1Z0thKtU77UWGnZZ8Uf3n/NQ++nAzpZr/Z2xX9rM5sFYJM40lZMDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/lPDmOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB24C4CEE2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870961;
	bh=Vt8uHoPI1XZNaOMHC73ISJa9D5QU0i2SrQwJ8IeWBPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n/lPDmOmu+Cj3a8tVpFDEXJWD4dMDH5VntC0Y7NojnBY9r9Y/JLttNX2o8Dx5a+0T
	 gsWzlX5MdoB6J/6RDzppQd/q/Kwsn7ckFTYd7wMHL3hOpor8Y+WaWNqVTUAJBy+JDx
	 G0oT2ItCEBhlbRrKgyuofU6ONokNd0xbr/gslroq9OhK2uuW2SgVsNfgdiCHjEH9iZ
	 Fv20aljlKTt1VTYcpccARoTlBaEKXLVnxvx3oFz5mbvq+qGbcxxt1iAn3UB8KXGBAT
	 t1oeuMSLf/RRMU6a8HbNlkaQ0plNFo3UK7603beEdb6A/xOdgBAZiNFVYmgfkThP2p
	 qdHJEvVDHSF5A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a303a656aso17381101fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:29:21 -0800 (PST)
X-Gm-Message-State: AOJu0YwX1yxQTzak7Zj7e1LO7i5c22fExf4gzWzssuPF9JgzvBgNHeM7
	0Os1/IZLKFVc28T7EokImLKLTQYrx0VNtjsha3DFBlla+5L+dLeCkiKKD7xjNjLsSKFxjqQgiQi
	BV/URDb1/ewidI+xvU6uYhBSx+90=
X-Google-Smtp-Source: AGHT+IGQlg+gLOgHJQ4yvUSzGL8F+Y93q6Rargiw1nef606JJZ04uKDe0/pLDbkcDE7pNlMWGhWi42ymxz4Adbivcug=
X-Received: by 2002:a2e:9905:0:b0:307:deea:f576 with SMTP id
 38308e7fff4ca-30927afe650mr39362311fa.34.1739870959658; Tue, 18 Feb 2025
 01:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218092538.1903204-2-ardb+git@google.com>
In-Reply-To: <20250218092538.1903204-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Feb 2025 10:29:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGyhYHS3WpC2oowWOnJiQVrbHOw57ULYuSx5Rip=Lt9oA@mail.gmail.com>
X-Gm-Features: AWEUYZnokY7fgWHWjnUTZoau8la-Ncg7fDAXpOIlhQwuDE6ix5b2cZJhn-QNOD8
Message-ID: <CAMj1kXGyhYHS3WpC2oowWOnJiQVrbHOw57ULYuSx5Rip=Lt9oA@mail.gmail.com>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 10:26, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> When running in PIE mode, the compiler will emit const global objects
> into .data.rel.ro rather than into .rodata if those objects contain
> statically initialized fields carrying addresses that are subject to
> runtime relocation (e.g., function pointers).
>
> This is needed so that the user space runtime linker can identify which
> parts of the executable image need to be writable initially, but can be
> converted into read-only before the image starts executing.
>
> This distinction does not matter for the kernel, but when using the
> compiler in PIE mode (such as when building for LoongArch), those
> .data.rel.ro sections need to be treated as .rodata as well.
>
> It also means that manually placed const global objects that contain
> absolute addresses (such as the non-JIT BPF jump table) need to be
> emitted into .data.rel.ro too so that the linker does not complain about
> conflicting permissions.
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Please consider this approach instead of the ..rodata hack - thanks.
>
>  include/asm-generic/vmlinux.lds.h       | 2 +-
>  include/linux/compiler.h                | 6 +++++-
>  tools/objtool/check.c                   | 7 +++----
>  tools/objtool/include/objtool/special.h | 2 +-
>  4 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 91a7e824ed8b..337d3336e175 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>         . = ALIGN((align));                                             \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
>                 __start_rodata = .;                                     \
> -               *(.rodata) *(.rodata.*) *(..rodata.*)                   \
> +               *(.rodata) *(.rodata.*) *(.data.rel.ro*)                \
>                 SCHED_DATA                                              \
>                 RO_AFTER_INIT_DATA      /* Read only after init */      \
>                 . = ALIGN(8);                                           \
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 3d013f1412e0..27024a128a6a 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -110,7 +110,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  /* Unreachable code */
>  #ifdef CONFIG_OBJTOOL
>  /* Annotate a C jump table to allow objtool to follow the code flow */
> -#define __annotate_jump_table __section("..rodata.c_jump_table")
> +#ifndef __pie__
> +#define __annotate_jump_table __section(".rodata.c_jump_table")
> +#else
> +#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
> +#endif
>  #else /* !CONFIG_OBJTOOL */
>  #define __annotate_jump_table
>  #endif /* CONFIG_OBJTOOL */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 1398ffc20b16..898d0cee4565 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2471,14 +2471,13 @@ static void mark_rodata(struct objtool_file *file)
>          *
>          * - .rodata: can contain GCC switch tables
>          * - .rodata.<func>: same, if -fdata-sections is being used
> -        * - ..rodata.c_jump_table: contains C annotated jump tables
> +        * - .data.rel.ro: same when using -fPIE codegen
>          *
>          * .rodata.str1.* sections are ignored; they don't contain jump tables.
>          */
>         for_each_sec(file, sec) {
> -               if ((!strncmp(sec->name, ".rodata", 7) ||
> -                   !strncmp(sec->name, "..rodata", 8)) &&
> -                   !strstr(sec->name, ".str1.")) {
> +               if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
> +                   !strncmp(sec->name, ".data.rel.ro", 12)) {
>                         sec->rodata = true;
>                         found = true;
>                 }
> diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
> index 34acf4ae5fab..e049679bb17b 100644
> --- a/tools/objtool/include/objtool/special.h
> +++ b/tools/objtool/include/objtool/special.h
> @@ -10,7 +10,7 @@
>  #include <objtool/check.h>
>  #include <objtool/elf.h>
>
> -#define C_JUMP_TABLE_SECTION "..rodata.c_jump_table"
> +#define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
>

Ugh - just spotted myself that this needs a #ifndef __pie__ too (or we
just emit into .data.rel.ro unconditionally, which would also be
fine).

I'll send a fixed v2 once the LoongArch folks confirm that this works for them.

