Return-Path: <linux-kernel+bounces-201754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A78FC2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8516C1C225A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1A1350FD;
	Wed,  5 Jun 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MCx/TvRP"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C212F5A6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717563100; cv=none; b=ITNwyl6lVQ9tVqAMy6qRnFqKB0/IaiGhRSDpwfk73UV7NA6EUwSFquoRMoO1BGOlzRNitXAdj7sZNEpHOYoS+egsjC6A9fWwR4CMamnVgmX+/samqEXCcGdvRAp3TaGOl3vzHNYccKzNoYCPc7OFGArgFV1JkPvAdZGNuy86UCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717563100; c=relaxed/simple;
	bh=fRj/9daOi684S1CjP8+/OFf16Zh4BiNKACL519r/dhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI8H+8jnnc1cdCvmXZZZyEWKgvKIiWaoFl4ep0W+VCe9w2wrP3yVOFpNlXEsjwX7bUSgRf68BizGaa7YxrrIKbsYpEyit5HkGUAVgF5vqR0KmsrTuny4CmIvwjfB5lxZgq+imv83CLCXND677QjosZ7mqEVHhxD5X0y3iCwqI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MCx/TvRP; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e1f984312cso262889039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717563097; x=1718167897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+9KIC2ZMxoi+KaQ4+bun3D6PF4buG3kzbZsU0iekQA=;
        b=MCx/TvRPnOGXYgjiFoHSXxbwPHz81PL5kLtlfNa46l0dMmMmeiRbvYLkGz+ZmM4nIp
         UlUFPQGS8u/v5Sjr3G2wAQ0C9L/qRcCRtB+JxMFYLFurL2K0vqHFTMuRFvm3u+UT8QpH
         05JrU9avzjvoANS/q7OExYHOQ7pMHjcrKfaD1TmW3ikP6tTFzddfoBgqcznYnJymBDFQ
         GqZd62A61gL5wKfgwGDxGK+7F6ab2RG6ZU5QaN+kkP8m3tiOXkux8oJjm40foZnkfAxY
         j4fIBeNdUq4RKN1hiBszQzEtWBGKo83xEPp3gMwu4oqCYclAjCEy1TjcxqxDKfma+7er
         d55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717563097; x=1718167897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+9KIC2ZMxoi+KaQ4+bun3D6PF4buG3kzbZsU0iekQA=;
        b=VkduO3NG171NXzS5CLPmXhsfaMLug8S3RltBNzpq3GCQqyMp5XV199hxzlX3kwgahH
         Vk3eAlB9yRW7LUrR6AtmqI+5g1yo4Y8whdQfKHOiUFGi+oC05mWiLY8u0VNU3GSyPwb0
         4oXqSf6PoxCX8RlYTUoUprt6MufANbU2OtbnI0kqHEz686pS45V51lWatkgQqMeRZlW5
         x82bw8Xt9w/UkAS6rzL+Ux7I91oCtxuZwPRLncQBX+cQiBEjX7add4S+DqsTfDjpXCNB
         MnPk+oKiOLQF8SfvBczT8rzLwiLbCo0dE/rQqOZmjVMTpNqzz4LLH5+o/qE+/iFR+LN3
         D2rg==
X-Forwarded-Encrypted: i=1; AJvYcCUJLUZdlW1Bya6zB9vtoG7C04wgHkla2o3kzxPaNxKiQyC/LkS+4RCMWhdMedTxYLC8Mn0b++M8Ite0i8wL5m2gl5UehkFf9aDVV0Rd
X-Gm-Message-State: AOJu0YxfnedIcL9EzJNPHdbweHKLGCt9SH7BMQCKEi7jbtJhr8p0jcE4
	be5yceOjpKdjAYpM30zyFhtZJyE3zkNjaIVsAnSSXMwjKXaZHmheD8PSfzL/qJ32UDpyqFhAFAK
	9PjmkfoKvHr7883uug3LjpnLicZYY9AeW4rV8yg==
X-Google-Smtp-Source: AGHT+IHDdgM5M7Aerg3GufHIekxnMW6S0tnaUVXZfbMHW9u3OV196yASyKEW6+bqR469jIOGILXJOClrDiM+GwbYUwk=
X-Received: by 2002:a05:6602:3fc7:b0:7e1:85a5:36c0 with SMTP id
 ca18e2360f4ac-7eb3c8b52edmr187420039f.9.1717563097575; Tue, 04 Jun 2024
 21:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531162327.2436962-1-jesse@rivosinc.com>
In-Reply-To: <20240531162327.2436962-1-jesse@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 5 Jun 2024 12:51:26 +0800
Message-ID: <CANXhq0pYNWvMxkkNPpYW4OrOXK19Rehdy3yO8u1sforyVjdTZg@mail.gmail.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 12:23=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Dectect the Zkr extension and use it to seed the kernel base address.
>
> Detection of the extension can not be done in the typical fashion, as
> this is very early in the boot process. Instead, add a trap handler
> and run it to see if the extension is present.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/kernel/pi/Makefile           |  2 +-
>  arch/riscv/kernel/pi/archrandom_early.c | 71 +++++++++++++++++++++++++
>  arch/riscv/mm/init.c                    |  3 ++
>  3 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
>
> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefil=
e
> index 50bc5ef7dd2f..9025eb52945a 100644
> --- a/arch/riscv/kernel/pi/Makefile
> +++ b/arch/riscv/kernel/pi/Makefile
> @@ -32,5 +32,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
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
> index 000000000000..311be9388b5c
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/archrandom_early.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * To avoid rewriteing code include asm/archrandom.h and create macros
> + * for the functions that won't be included.
> + */
> +
> +#define riscv_has_extension_likely(...) false
> +#define pr_err_once(...)
> +
> +#include <linux/types.h>
> +#include <asm/hwcap.h>
> +#include <asm/archrandom.h>
> +
> +/*
> + * Asm goto is needed so that the compiler does not remove the label.
> + */
> +
> +#define csr_goto_swap(csr, val)                                         =
       \
> +({                                                                     \
> +       unsigned long __v;                                              \
> +       __asm__ __volatile__ goto("csrrw %0, " __ASM_STR(csr) ", %1"    \
> +                                 : "=3Dr" (__v) : "rK" (&&val)          =
 \
> +                                 : "memory" : val);                    \
> +       __v;                                                            \
> +})
> +
> +/*
> + * Declare the functions that are exported (but prefixed) here so that L=
LVM
> + * does not complain it lacks the 'static' keyword (which, if added, mak=
es
> + * LLVM complain because the function is actually unused in this file).
> + */
> +
> +u64 get_kaslr_seed_zkr(void);
> +
> +/*
> + * This function is called by setup_vm to check if the kernel has the ZK=
R.
> + * Traps haven't been set up yet, but save and restore the TVEC to avoid
> + * any side effects.
> + */
> +
> +static inline bool __must_check riscv_has_zkr(void)
> +{
> +       unsigned long tvec;
> +
> +       tvec =3D csr_goto_swap(CSR_TVEC, not_zkr);
> +       csr_swap(CSR_SEED, 0);
> +       csr_write(CSR_TVEC, tvec);
> +       return true;
> +not_zkr:
> +       csr_write(CSR_TVEC, tvec);
> +       return false;
> +}
> +
> +u64 get_kaslr_seed_zkr(void)
> +{
> +       const int needed_seeds =3D sizeof(u64) / sizeof(long);
> +       int i =3D 0;
> +       u64 seed =3D 0;
> +       long *entropy =3D (long *)(&seed);
> +
> +       if (!riscv_has_zkr())
> +               return 0;
> +
> +       for (i =3D 0; i < needed_seeds; i++) {
> +               if (!csr_seed_long(&entropy[i]))
> +                       return 0;
> +       }
> +
> +       return seed;
> +}
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9940171c79f0..8ef1edd2cddd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
>  #ifdef CONFIG_RANDOMIZE_BASE
>  extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>  extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
> +extern u64 __init __pi_get_kaslr_seed_zkr(void);
>
>  static int __init print_nokaslr(char *p)
>  {
> @@ -1049,6 +1050,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                 u32 kernel_size =3D (uintptr_t)(&_end) - (uintptr_t)(&_st=
art);
>                 u32 nr_pos;
>
> +               if (kaslr_seed =3D=3D 0)
> +                       kaslr_seed =3D __pi_get_kaslr_seed_zkr();

Could you elaborate on why we try to get the seed from DT first,
rather than from ZKR? Also, I was wondering if, by any chance, it can
leverage arch_get_random_seed_longs() to get the seed instead of
__pi_get_kasler_seed_zkr()? Thanks

>                 /*
>                  * Compute the number of positions available: we are limi=
ted
>                  * by the early page table that only has one PUD and we m=
ust
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

