Return-Path: <linux-kernel+bounces-315365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E596C1A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736A51F2A6B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C681F1DB94B;
	Wed,  4 Sep 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKa5tpwd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67F1DA2FE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462178; cv=none; b=ZH1migwe34kqrmtsk/4gW7xXdGWOLKjfHX2NeYubTwTyiE3iGPCluNn8CBHQh7OuWp5nzesVN635/wuTwZXdz0GXU9tMcTkBWmkXWt6mD00XEGRvjlnMsqEr5R0rGE7S68bF6Li6C48dbMKoaIyIr1AumdBMaaQ/bkxCLA21dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462178; c=relaxed/simple;
	bh=vme6jZ7GeZZ5TDcoDuVWmlN+GOBoeXUEyLcf4ZC17ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6i+FovMkQ5S27u3WTfxKS6otBhZS/tfS5hTmYepAgx9FlPDYgHsSgGaxSUk7j9kzGD1uDRdyPt6yRoE7pmvSqa0jo48Al+Fvhx+hV+DNq/rJfhXG/Msa7f1EYcg/oQAYcfG6oTG4mTk8qb+C/PF1+Eb4qbzlXsfJjyLo6DjEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKa5tpwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631F7C4CEC6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725462177;
	bh=vme6jZ7GeZZ5TDcoDuVWmlN+GOBoeXUEyLcf4ZC17ts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKa5tpwdkWfDVbu5gYroHQ/Wej0yrjjt8YXkLq+P/H8Xo6SC3YAlbo9Yd72pRNGt4
	 JUqndx55oPBX87Am8/1Aiz5C9hEhP2sk4fBVYp8OTDZx8PICGO7NXtgyev2WdP1Vpn
	 R6WlNP4JX2gaJG3HjSfarxtZBRT7wPuuEoWsFkTA+6fU7nYyuADwyLpojP8Da9LAIy
	 6SodbqQseJ9LDJRROCdchT4rPp5LY8o0qkYrYOlfxdOmwdnvi0kFxslVOnZZYa1KzA
	 u9x9nrrDD79gXpmrJz8eyc9XUY82sq/7kmvKkEp3wGdbfRTVue/WFNRMag/VPx1Tcy
	 5IH43nZyri40g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f5064816edso76454741fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:02:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJsCfBNLFGULF36YeQjsEUamjqxADF9YqR5j/ijjZ2O6gJj54IS7JuEtF+ZLFwUCPilXYtDoQVaaqthzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YqdN7bsihp8+j7By76e9d+AXP3ugZnjhEwr/YFYJ++yLJII4
	JhYGZR7ye/9JkEVqpsLqR59eog9YY75VzDtG3UophQKnqxV/ZIf+7G3bUCEr5vu3iongogpxE2Q
	NXnRfl++lM9m/35m+OalokhJoV7s=
X-Google-Smtp-Source: AGHT+IFfokq07T4PjLku/Inng4Q7N/8lyOKLUi9O1k61EeR3n7DxNcrkC6J6xx7+7IApC5SDJjbiz2NBkSebeYo05GM=
X-Received: by 2002:a05:651c:548:b0:2f4:3de7:ac4c with SMTP id
 38308e7fff4ca-2f6103908d3mr179993071fa.8.1725462175675; Wed, 04 Sep 2024
 08:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904095205.739422-1-ubizjak@gmail.com>
In-Reply-To: <20240904095205.739422-1-ubizjak@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 4 Sep 2024 23:02:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5WX7KXXpLkLm_4L-y5J-4fx-72uN+cvFGOZZh2NXUbHw@mail.gmail.com>
Message-ID: <CAAhV-H5WX7KXXpLkLm_4L-y5J-4fx-72uN+cvFGOZZh2NXUbHw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uros,

Thank you for your patch.

On Wed, Sep 4, 2024 at 5:52=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> _percpu_read() and _percpu_write() macros call __percpu_read()
> and __percpu_write() static inline functions that result in a single
> assembly instruction. Percpu infrastructure expects its leaf
> definitions to encode the size of their percpu variable, so the patch
> merges asm clauses from the static inline function into the
> corresponding leaf macros.
It seems in some other places we prefer inline functions rather than
macros, but this patch is the opposite...

>
> The secondary effect of this change is to avoid explicit __percpu
> function arguments. Currently, __percpu macro is defined in
> include/linux/compiler_types.h, but with proposed patch [1],
> __percpu definition will need macros from include/asm-generic/percpu.h,
> creating forward dependency loop.
Macros don't check types, so use macros to drop "__percpu" checking?
Seems a little strange.

>
> The proposed solution is the same as x86 architecture uses.
>
> Patch is compile tested only.
>
> [1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.co=
m/
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Xi Ruoyao <xry111@xry111.site>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> v2: Add a missing cast and a missing coma in the asm template,
>     reported by kernel test robot. Some formatting changes.
> ---
>  arch/loongarch/include/asm/percpu.h | 130 +++++++++-------------------
>  1 file changed, 41 insertions(+), 89 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include=
/asm/percpu.h
> index 8f290e5546cf..2bb84227a8c5 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -68,75 +68,6 @@ PERCPU_OP(and, and, &)
>  PERCPU_OP(or, or, |)
>  #undef PERCPU_OP
>
> -static __always_inline unsigned long __percpu_read(void __percpu *ptr, i=
nt size)
> -{
> -       unsigned long ret;
> -
> -       switch (size) {
> -       case 1:
> -               __asm__ __volatile__ ("ldx.b %[ret], $r21, %[ptr]       \=
n"
> -               : [ret] "=3D&r"(ret)
> -               : [ptr] "r"(ptr)
> -               : "memory");
> -               break;
> -       case 2:
> -               __asm__ __volatile__ ("ldx.h %[ret], $r21, %[ptr]       \=
n"
> -               : [ret] "=3D&r"(ret)
> -               : [ptr] "r"(ptr)
> -               : "memory");
> -               break;
> -       case 4:
> -               __asm__ __volatile__ ("ldx.w %[ret], $r21, %[ptr]       \=
n"
> -               : [ret] "=3D&r"(ret)
> -               : [ptr] "r"(ptr)
> -               : "memory");
> -               break;
> -       case 8:
> -               __asm__ __volatile__ ("ldx.d %[ret], $r21, %[ptr]       \=
n"
> -               : [ret] "=3D&r"(ret)
> -               : [ptr] "r"(ptr)
> -               : "memory");
> -               break;
> -       default:
> -               ret =3D 0;
> -               BUILD_BUG();
> -       }
> -
> -       return ret;
> -}
> -
> -static __always_inline void __percpu_write(void __percpu *ptr, unsigned =
long val, int size)
> -{
> -       switch (size) {
> -       case 1:
> -               __asm__ __volatile__("stx.b %[val], $r21, %[ptr]        \=
n"
> -               :
> -               : [val] "r" (val), [ptr] "r" (ptr)
> -               : "memory");
> -               break;
> -       case 2:
> -               __asm__ __volatile__("stx.h %[val], $r21, %[ptr]        \=
n"
> -               :
> -               : [val] "r" (val), [ptr] "r" (ptr)
> -               : "memory");
> -               break;
> -       case 4:
> -               __asm__ __volatile__("stx.w %[val], $r21, %[ptr]        \=
n"
> -               :
> -               : [val] "r" (val), [ptr] "r" (ptr)
> -               : "memory");
> -               break;
> -       case 8:
> -               __asm__ __volatile__("stx.d %[val], $r21, %[ptr]        \=
n"
> -               :
> -               : [val] "r" (val), [ptr] "r" (ptr)
> -               : "memory");
> -               break;
> -       default:
> -               BUILD_BUG();
> -       }
> -}
> -
>  static __always_inline unsigned long __percpu_xchg(void *ptr, unsigned l=
ong val, int size)
>  {
>         switch (size) {
> @@ -157,6 +88,39 @@ static __always_inline unsigned long __percpu_xchg(vo=
id *ptr, unsigned long val,
>         return 0;
>  }
>
> +#define __pcpu_op_1(op)                op ".b "
> +#define __pcpu_op_2(op)                op ".h "
> +#define __pcpu_op_4(op)                op ".w "
> +#define __pcpu_op_8(op)                op ".d "
> +
> +#define _percpu_read(size, _pcp)                                       \
> +({                                                                     \
> +       unsigned long __pcp_ret;                                        \
> +                                                                       \
> +       __asm__ __volatile__(                                           \
> +               __pcpu_op_##size("ldx") "%[ret], $r21, %[ptr]   \n"     \
> +               : [ret] "=3D&r"(__pcp_ret)                               =
 \
> +               : [ptr] "r"(&(_pcp))                                    \
> +               : "memory");                                            \
> +       (typeof(_pcp))__pcp_ret;                                        \
> +})
> +
> +#define __pcpu_cast_1(val)     (((unsigned long) val) & 0xff)
> +#define __pcpu_cast_2(val)     (((unsigned long) val) & 0xffff)
> +#define __pcpu_cast_4(val)     (((unsigned long) val) & 0xffffffff)
> +#define __pcpu_cast_8(val)     ((unsigned long) val)
Maybe use "((unsigned long) val)" is enough for all casting?

Huacai

> +
> +#define _percpu_write(size, _pcp, _val)                                 =
       \
> +do {                                                                   \
> +       unsigned long __pcp_val =3D __pcpu_cast_##size(_val);            =
 \
> +                                                                       \
> +       __asm__ __volatile__(                                           \
> +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \n"     \
> +               :                                                       \
> +               : [val] "r"(__pcp_val), [ptr] "r"(&(_pcp))              \
> +               : "memory");                                            \
> +} while (0)
> +
>  /* this_cpu_cmpxchg */
>  #define _protect_cmpxchg_local(pcp, o, n)                      \
>  ({                                                             \
> @@ -167,18 +131,6 @@ static __always_inline unsigned long __percpu_xchg(v=
oid *ptr, unsigned long val,
>         __ret;                                                  \
>  })
>
> -#define _percpu_read(pcp)                                              \
> -({                                                                     \
> -       typeof(pcp) __retval;                                           \
> -       __retval =3D (typeof(pcp))__percpu_read(&(pcp), sizeof(pcp));    =
 \
> -       __retval;                                                       \
> -})
> -
> -#define _percpu_write(pcp, val)                                         =
       \
> -do {                                                                   \
> -       __percpu_write(&(pcp), (unsigned long)(val), sizeof(pcp));      \
> -} while (0)                                                            \
> -
>  #define _pcp_protect(operation, pcp, val)                      \
>  ({                                                             \
>         typeof(pcp) __retval;                                   \
> @@ -215,15 +167,15 @@ do {                                               =
                       \
>  #define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
>  #define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
>
> -#define this_cpu_read_1(pcp) _percpu_read(pcp)
> -#define this_cpu_read_2(pcp) _percpu_read(pcp)
> -#define this_cpu_read_4(pcp) _percpu_read(pcp)
> -#define this_cpu_read_8(pcp) _percpu_read(pcp)
> +#define this_cpu_read_1(pcp) _percpu_read(1, pcp)
> +#define this_cpu_read_2(pcp) _percpu_read(2, pcp)
> +#define this_cpu_read_4(pcp) _percpu_read(4, pcp)
> +#define this_cpu_read_8(pcp) _percpu_read(8, pcp)
>
> -#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_1(pcp, val) _percpu_write(1, pcp, val)
> +#define this_cpu_write_2(pcp, val) _percpu_write(2, pcp, val)
> +#define this_cpu_write_4(pcp, val) _percpu_write(4, pcp, val)
> +#define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
>
>  #define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
>  #define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
> --
> 2.46.0
>

