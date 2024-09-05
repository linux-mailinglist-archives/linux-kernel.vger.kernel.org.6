Return-Path: <linux-kernel+bounces-316951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5E96D775
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19141F273BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5CE199397;
	Thu,  5 Sep 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9/97KFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F62F44
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536840; cv=none; b=JQh/FgmoJ+0EtpbLHjMelnFv7FPIY63g20ntWYBLrpYc4QbxzB9j4jRMtF9Shi9SMaYmza0wDmJeinH81DM/kpQr8P1Uj99NOHwCARFQ1E4XiqrPgrhO2Obl0Oks8PlhhDXQ577vD+4hN+VEqeMMSDBGv1PCigXwf1LnctyF5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536840; c=relaxed/simple;
	bh=wTeVP2n7ZbjqU7yMeqGPJbiHY4qOXXjE/B9dKMSVRc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRsaYak3pbw1NTA+H5wlndDDHyFKAW2LvtyIkukuTR+scQtRJIV405252voSrkV5N9EkmGmAL/E/uutfJl3MuF7CSrYyKhDFtdgGglmPj9kPuwHYasvhbnPeZKAiAbCrHs/c6PrrH+oIUNKWGGY+Y1AjGOyTgJ5cd1M7z0wXIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9/97KFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8435DC4CEC9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725536840;
	bh=wTeVP2n7ZbjqU7yMeqGPJbiHY4qOXXjE/B9dKMSVRc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h9/97KFS7fQt75WLT5cUWWvPB+FqjIlKUkTlh3gd6OtEx7cs6m7x5qwtnEUjhBNZU
	 bwHdDKPTZvoNPl0skQ1cTqT7nmcu3R5XD+BA635PBA//CKJiVw1x8Xjt3P5/7Cw+fw
	 vdnsHi1+cT78V74vgLy1uFQ1iVvtjwHFkSEfy7UVXPf1ndhMqnLh6hxSH4AMlAvIEw
	 zaYtgEhlskrdmju7aP7s50r+qklAPuWJ3wmuGlHeK1yMRTgZ7KCsmAXTExd3pqEzIh
	 NZfScHg6Cs44RYPBjyuwSxRMbPYVjd44kadL+aHRRfRVmqxq/D1ph6k+fe8rGywvir
	 +NCJBLeWLDSpA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so853942a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsRJBbF/QYI4eVAN9s9PxOyB2jBafBdXS2BN4fTOwS0kY+ImcIL66Me49tXdrMJGCD1kX5Fn4XanGCsG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHfKGrOf6SdG0q/0hkS7zXjayNOxpUA/PHjVy7f9bZxmSyVBw
	8n6mf8a+u+w6f8HRdrJ57PCz+rqDUtVTM2Vu81e5PbSg1FD+WPVdLPNKBetb3mSRSJ9O1nikcQM
	XCz5HUdQHx/6Uyhnn6nuB+sZbKBA=
X-Google-Smtp-Source: AGHT+IETzRwzpuGcXMVwmYItTmnXZYpcEvhpsGOmibAU5wQOJwk82StxTn8ER5roO9ZRruiWFJIg31tZYC4WuWVX1IU=
X-Received: by 2002:a05:6402:35ca:b0:5c2:50a2:98a7 with SMTP id
 4fb4d7f45d1cf-5c250a327e7mr10458789a12.4.1725536839145; Thu, 05 Sep 2024
 04:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com>
In-Reply-To: <20240905065438.802898-1-ubizjak@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 5 Sep 2024 19:47:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
Message-ID: <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uros,

On Thu, Sep 5, 2024 at 2:54=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> _percpu_read() and _percpu_write() macros call __percpu_read()
> and __percpu_write() static inline functions that result in a single
> assembly instruction. Percpu infrastructure expects its leaf
> definitions to encode the size of their percpu variable, so the patch
> merges asm clauses from the static inline function into the
> corresponding leaf macros.
>
> The secondary effect of this change is to avoid explicit __percpu
> function arguments. Currently, __percpu macro is defined in
> include/linux/compiler_types.h, but with proposed patch [1],
> __percpu definition will need macros from include/asm-generic/percpu.h,
> creating forward dependency loop.
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
> v3: Check the type of _val in _percpu_write().
> ---
>  arch/loongarch/include/asm/percpu.h | 135 ++++++++++------------------
>  1 file changed, 46 insertions(+), 89 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include=
/asm/percpu.h
> index 8f290e5546cf..90ece62ec24c 100644
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
> @@ -157,6 +88,44 @@ static __always_inline unsigned long __percpu_xchg(vo=
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
If the input value is less than 0xff, then "& 0xff" is meaningless, if
the input value is more than 0xff, this conversion still cannot give a
correct result for the caller. So I think for all sizes it is enough
to just use "((unsigned long) val)".

> +#define __pcpu_cast_2(val)     (((unsigned long) val) & 0xffff)
> +#define __pcpu_cast_4(val)     (((unsigned long) val) & 0xffffffff)
> +#define __pcpu_cast_8(val)     ((unsigned long) val)
> +
> +#define _percpu_write(size, _pcp, _val)                                 =
       \
> +do {                                                                   \
> +       unsigned long __pcp_val =3D __pcpu_cast_##size(_val);            =
 \
> +                                                                       \
> +       if (0) {                                                        \
> +               typeof(_pcp) pto_tmp__;                                 \
> +               pto_tmp__ =3D (_val);                                    =
 \
> +               (void)pto_tmp__;                                        \
> +       }                                                               \
Emmm, in V2 I just confirm that whether it is worth to use macro
instead of inline functions, I think we don't really need such a
checking here. :)


Huacai

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
> @@ -167,18 +136,6 @@ static __always_inline unsigned long __percpu_xchg(v=
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
> @@ -215,15 +172,15 @@ do {                                               =
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

