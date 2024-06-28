Return-Path: <linux-kernel+bounces-233685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FEE91BB85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764FBB228C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C915253D;
	Fri, 28 Jun 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3VJU2Z3E"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12715253B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567181; cv=none; b=b0AFHlWWMleRVr+xu6py//tCUko3yCkgdx6Qgg3cWCAFBNUg/hOeFnQxrtseeo911b6ApcuHZED98RUqI7up74zvzWCoqp3E+AzP8u3qJ5a61Uz9FLoC6siUGqkl6A6QMX4Teu7YyBCyrkStnfmHpAGZp85zZJ0XU18gWccPn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567181; c=relaxed/simple;
	bh=XfJNqKhMFuvcPyNrKFeMpWR9a0aMu9IBK7Nd63qMvEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIvGv9wpe25ts/YpRK7Yh2/GH7bPLxLY4ZUddnXq2YjRUCmrOtMCZgKiusMTjSjJFyru1/p4gClz6fagsJsC8SZfJGl4kkzFGfAXSS372QTMg0mfZcwWjxJ8TrwDxJRDvERwlmLL+l2qW3zR404BlkIUcI8+0GIWmCJ7uSUdc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3VJU2Z3E; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so450933a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719567177; x=1720171977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgZtRJxMO0IoJsWAgZZd1fuUTyrgJyHmlkFKzWwuimo=;
        b=3VJU2Z3Ee9Q8qqSIFzP/6J8WGyUEUiMOxJjrii43N180pv1IL0rEok+x7Uw/BmfkF9
         EMewPjJSTUaX/JJ/MuFedFslFZb1aQQPN8GN5jETOiyJmxuLIHKQBTEeBylJWbu9HEH+
         8Hq2xriKvkw1+j5UpxQy+Bgc3EhMj46/OvCD+XLJl1VIsPbaXVKNbFDR40Zkc5bIxqNZ
         KSdv9bd/bUR7ielrpUZ/TAaL15VXLE9iRT7xjNaRcgf/w9CTAT0+WdfBBw6T6jhyg0fN
         qKCQkDdk4ILHwq+wDj4in6X3WUlrCCqyPeQS75tubTU8h++2mihp57Xkqq0SurOmjflF
         PMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567177; x=1720171977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgZtRJxMO0IoJsWAgZZd1fuUTyrgJyHmlkFKzWwuimo=;
        b=JmvmbcTI6RoQn8KmwttN3r1YoJGEfMgxNkCRUAUcPamFJDZLyeFQIMFp1+o5hOdCB7
         NV8pDH/lXRCiP4pt4bdUpBZSJdN0dUyS/nJDUNQmfRQfT8+TIRz1qJoTzeuTdc2fZtft
         t7/6RxGTGCLA6bA4yvirzfQas1fyyx0UK6cZ4aqTAG99fCXIODboMdbqpN/j2whl62kf
         Blg1UwjOgm6vCcxDPkEoZpzhnCOzkH804kFVt6SJQAcwqV9gHeT2+oNB32NkEg2uJOg1
         FTfNVk3BUjFNSX6oXZVdo/S+g/PpTD2tw8FYmLWwD/rR2Tn4c6EVzPkiWJZawbnoS0TA
         4vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAOT3dkd1QNV1hKvTgsrBEdAXlHRAlE2qJU0s56SUvC9iCSpMUQvh4ioQcvScmIIegDgwOOXa1XhrL4JWVMSE9Y0txp6/0gM85VEeN
X-Gm-Message-State: AOJu0YxsTT6a6KeRl1CBdNtfHmzEE6bU3qcT58lbZWV21K3rnkxvxVqD
	6iHackUsgprgXJUrTFb9Zs50j49nmRjoB06/sNRIJUWD8HwfQixoMq7aCmiV4Y0aUPJmUDFGEYd
	vYS6j6VRIrGtp1Fo9FIsXratNtlpGuU5TeF5R6Q==
X-Google-Smtp-Source: AGHT+IFn5mIorHpE3Ff8lT6iPHz77tgyaXqXlgcKe0o8bphh7G8PHDmwiEZpFFWvBGJXkvu6h9GN2MvcVhk6xHplPkI=
X-Received: by 2002:a17:907:d308:b0:a72:6fc3:9946 with SMTP id
 a640c23a62f3a-a727f688210mr595992866b.16.1719567177507; Fri, 28 Jun 2024
 02:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626171652.366415-1-jesse@rivosinc.com> <20240626171652.366415-3-jesse@rivosinc.com>
In-Reply-To: <20240626171652.366415-3-jesse@rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 28 Jun 2024 11:32:46 +0200
Message-ID: <CAHVXubjzxAoC1U+mYAiOa-3L0GkXFcVnHSYg3rTmOp4vbtvTpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Use Zkr to seed KASLR base address
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Wende Tan <twd2.me@gmail.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sami Tolvanen <samitolvanen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Wed, Jun 26, 2024 at 7:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Parse the device tree for Zkr in isa string.
> If Zkr is present, use it to seed the kernel base address.

It would be nice to explain why we finally decided to only use the Zkr
extension in !EFI platform, if @Ard Biesheuvel agrees, I guess you can
even quote him: "On an ACPI+EFI system, you have to be able to trust
the firmware. And you have to use the available abstractions.
Otherwise, there is no point."

>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/kernel/pi/Makefile           |  2 +-
>  arch/riscv/kernel/pi/archrandom_early.c | 30 ++++++++
>  arch/riscv/kernel/pi/fdt_early.c        | 94 +++++++++++++++++++++++++
>  arch/riscv/kernel/pi/pi.h               |  3 +
>  arch/riscv/mm/init.c                    |  5 +-
>  5 files changed, 132 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
>
> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefil=
e
> index 1ef7584be0c3..dba902f2a538 100644
> --- a/arch/riscv/kernel/pi/Makefile
> +++ b/arch/riscv/kernel/pi/Makefile
> @@ -33,5 +33,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
>  $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> -obj-y          :=3D cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.=
pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
> +obj-y          :=3D cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.=
pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
>  extra-y                :=3D $(patsubst %.pi.o,%.o,$(obj-y))
> diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/=
pi/archrandom_early.c
> new file mode 100644
> index 000000000000..c6261165e8a6
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/archrandom_early.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/csr.h>
> +#include <linux/processor.h>
> +
> +#include "pi.h"
> +
> +/*
> + * To avoid rewriting code include asm/archrandom.h and create macros
> + * for the functions that won't be included.
> + */
> +#undef riscv_has_extension_unlikely
> +#define riscv_has_extension_likely(...) false
> +#undef pr_err_once
> +#define pr_err_once(...)
> +
> +#include <asm/archrandom.h>
> +
> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa)
> +{
> +       unsigned long seed =3D 0;
> +
> +       if (!early_isa_str((const void *)dtb_pa, "zkr"))
> +               return 0;
> +
> +       if (!csr_seed_long(&seed))
> +               return 0;
> +
> +       return seed;
> +}
> diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_=
early.c
> index 40ee299702bf..ba76197b44d1 100644
> --- a/arch/riscv/kernel/pi/fdt_early.c
> +++ b/arch/riscv/kernel/pi/fdt_early.c
> @@ -23,3 +23,97 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
>         *prop =3D 0;
>         return ret;
>  }
> +
> +/* Based off of fdt_stringlist_contains */
> +static int isa_string_contains(const char *strlist, int listlen, const c=
har *str)
> +{
> +       int len =3D strlen(str);
> +       const char *p;
> +
> +       while (listlen >=3D len) {
> +               if (strncasecmp(str, strlist, len) =3D=3D 0)
> +                       return 1;
> +               p =3D memchr(strlist, '_', listlen);
> +               if (!p)
> +                       p =3D memchr(strlist, '\0', listlen);
> +               if (!p)
> +                       return 0; /* malformed strlist.. */
> +               listlen -=3D (p - strlist) + 1;
> +               strlist =3D p + 1;
> +       }
> +
> +       return 0;
> +}
> +
> +/* Based off of fdt_nodename_eq_ */
> +static int fdt_node_name_eq(const void *fdt, int offset,
> +                           const char *s)
> +{
> +       int olen;
> +       int len =3D strlen(s);
> +       const char *p =3D fdt_get_name(fdt, offset, &olen);
> +
> +       if (!p || olen < len)
> +               /* short match */
> +               return 0;
> +
> +       if (memcmp(p, s, len) !=3D 0)
> +               return 0;
> +
> +       if (p[len] =3D=3D '\0')
> +               return 1;
> +       else if (!memchr(s, '@', len) && (p[len] =3D=3D '@'))
> +               return 1;
> +       else
> +               return 0;
> +}
> +
> +/*
> + * Returns true if the extension is in the isa string
> + * Returns false if the extension is not found
> + */
> +static bool get_ext_named(const void *fdt, int node, const char *name)
> +{
> +       const void *prop;
> +       int len;
> +
> +       prop =3D fdt_getprop(fdt, node, "riscv,isa-base", &len);
> +       if (prop && isa_string_contains(prop, len, name))
> +               return true;
> +
> +       prop =3D fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
> +       if (prop && isa_string_contains(prop, len, name))
> +               return true;
> +
> +       prop =3D fdt_getprop(fdt, node, "riscv,isa", &len);
> +       if (prop && isa_string_contains(prop, len, name))
> +               return true;
> +
> +       return false;
> +}
> +
> +/*
> + * Returns true if the extension is in the isa string on all cpus
> + * Returns false if the extension is not found
> + */
> +bool early_isa_str(const void *fdt, const char *ext_name)
> +{
> +       int node, parent;
> +       bool ret =3D false;
> +
> +       parent =3D fdt_path_offset(fdt, "/cpus");
> +       if (parent < 0)
> +               return false;
> +
> +       fdt_for_each_subnode(node, fdt, parent) {
> +               if (!fdt_node_name_eq(fdt, node, "cpu"))
> +                       continue;
> +
> +               if (!get_ext_named(fdt, node, ext_name))
> +                       return false;
> +
> +               ret =3D true;
> +       }
> +
> +       return ret;
> +}
> diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
> index 65da99466baf..26e7e5f84a30 100644
> --- a/arch/riscv/kernel/pi/pi.h
> +++ b/arch/riscv/kernel/pi/pi.h
> @@ -4,6 +4,8 @@
>
>  #include <linux/types.h>
>
> +bool early_isa_str(const void *fdt, const char *ext_name);
> +
>  /*
>   * The folowing functions are exported (but prefixed) declare them here =
so
>   * that LLVM does not complain it lacks the 'static' keyword (which, if
> @@ -11,6 +13,7 @@
>   */
>
>  u64 get_kaslr_seed(uintptr_t dtb_pa);
> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>  bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>  u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9940171c79f0..bfb068dc4a64 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
>  #ifdef CONFIG_RANDOMIZE_BASE
>  extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>  extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
> +extern u64 __init __pi_get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>
>  static int __init print_nokaslr(char *p)
>  {
> @@ -1045,10 +1046,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>  #ifdef CONFIG_RANDOMIZE_BASE
>         if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
> -               u64 kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
> +               u64 kaslr_seed =3D __pi_get_kaslr_seed_zkr(dtb_pa);
>                 u32 kernel_size =3D (uintptr_t)(&_end) - (uintptr_t)(&_st=
art);
>                 u32 nr_pos;
>
> +               if (kaslr_seed =3D=3D 0)
> +                       kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
>                 /*
>                  * Compute the number of positions available: we are limi=
ted
>                  * by the early page table that only has one PUD and we m=
ust
> --
> 2.45.2
>

Thanks,

Alex

