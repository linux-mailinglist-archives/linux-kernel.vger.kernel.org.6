Return-Path: <linux-kernel+bounces-425691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5909DE921
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E539B21EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56A140E50;
	Fri, 29 Nov 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i18p3+YA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D328691
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893188; cv=none; b=ndeGmb3cu9ia5hHVcRSWKcwwc3pCJSZdLNfx0Zjb9iIh9YaY5yBLKs6pylbHCTZunnNVAcBnFmP7iFSSxyqSfHHwPKdG3mqLvCzqhvm8eUJTj2Nyptc/OeFFh/cmJ1GNQm/8fkc/q0PitrP+iuNm3CbZ6aBjq2/zAzFY2P0Hq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893188; c=relaxed/simple;
	bh=2Cus7nhx7ljNOhJlkHTtvoxcN+BMKzr8wPJVLjjGnDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTAUDU9sEe0MLInE7nkjOJHT8WMDZgd3OzXedGfqo3G4vQNbfjPm7SrA+vd01qFgpxSNH7v23FqQ3zZ9CnefM2syzZdmUiYdLv7Rok/x2xaP9RUuqNZGk7fIJC6bwNtqdMkybb56T7sjUTjgqD62IZjnfgufh02DaZXg/Ctn8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i18p3+YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1BC4CED9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732893188;
	bh=2Cus7nhx7ljNOhJlkHTtvoxcN+BMKzr8wPJVLjjGnDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i18p3+YAClWJ2fuEr6TWmkyprPEGYd5zbD19AVmskA1PR7UwOaxzSfhpQewSbmQoL
	 pFTFMnNgoSHQIL9WER/wVL+y8frP62AVKpyaUeinEESLa1zmLZ52Q+z7U3xNERb7mA
	 deaMGklN6MFNLyE7XnbJWNDy/Nb7w0nLjTxzjx8rYp5emcn4wlSSuhlRSZDt+9U24C
	 8wdCx4ZPn69ERXK3ReBNsUqfriPjpYyINi0H5He3C17wrpSJaUE0YCjKBq3TD6YOCm
	 9NM8f/Hd4xRmMWbPXya5EZEMLQ5K6rTqup7VcuNuu3f6AS03zMrSoHxz2VZRuvS3Rp
	 MYyipd+tk4x2A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso2388325e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:13:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkvZU11haR7BNQCMhlqV9ISlPWpu77YF+Ak+/4HuCGIBotSqsu1hQ6zKvJIsb2C7rJdPORpax46bxILPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnttI5FhoYQJh6QBlGxHm075uOOxYj4DVasnSuQmOZNm6NtpJL
	lWgyOBiQgpPKbpTeQeKpyFfc5rGGBYKlWPVn85YiSWueFvgR7ZhqLky7wXDtQp/J/c2CygRMCh5
	889MeMkXEKA0PBx8WKCynLqHuafM=
X-Google-Smtp-Source: AGHT+IHb0bueuFb8yh8QhK4vaNF43kr1pdmPV+jLXodEtHqPDz0mYORa9L8F7ceLCt8rc1V/6d/e11kUwC6Qk7IhQbA=
X-Received: by 2002:a05:6512:1253:b0:536:73b5:d971 with SMTP id
 2adb3069b0e04-53df0104714mr8116818e87.38.1732893185918; Fri, 29 Nov 2024
 07:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129144319.74257-1-arikalo@gmail.com>
In-Reply-To: <20241129144319.74257-1-arikalo@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 29 Nov 2024 23:12:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRO5Q=CMT8N5nVOF9oOvDb7CtakeemOkX1-v_w-WPuaXQ@mail.gmail.com>
Message-ID: <CAJF2gTRO5Q=CMT8N5nVOF9oOvDb7CtakeemOkX1-v_w-WPuaXQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Rewrite AMO instructions via lr and sc.
To: Aleksandar Rikalo <arikalo@gmail.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Andrea Parri <parri.andrea@gmail.com>, Leonardo Bras <leobras@redhat.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Eric Chan <ericchancf@google.com>, 
	linux-kernel@vger.kernel.org, 
	Djordje Todorovic <djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 10:43=E2=80=AFPM Aleksandar Rikalo <arikalo@gmail.c=
om> wrote:
>
> From: Chao-ying Fu <cfu@mips.com>
>
> Use lr and sc to implement all atomic functions. Some CPUs have
> native support for lr and sc, but emulate AMO instructions through
> trap handlers that are slow.
>
> Add config RISCV_ISA_ZALRSC_ONLY.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++
>  arch/riscv/include/asm/atomic.h  | 52 +++++++++++++++++++++++++++++++-
>  arch/riscv/include/asm/bitops.h  | 45 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 16 ++++++++++
>  arch/riscv/include/asm/futex.h   | 46 ++++++++++++++++++++++++++++
>  5 files changed, 168 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index cc63aef41e94..767538c27875 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -715,6 +715,16 @@ config RISCV_ISA_ZACAS
>
>           If you don't know what to do here, say Y.
>
> +config RISCV_ISA_ZALRSC_ONLY
> +       bool "Zalrsc extension support only"
> +       default n
> +       help
> +          Use lr and sc to build all atomic functions. Some CPUs have
> +          native support for lr and sc, but emulate amo instructions thr=
ough
> +          trap handlers that are slow.
What's the actual hardware?
Is it emulated in m-mode?
Where is the code?

> +
> +          If you don't know what to do here, say n.
> +
>  config TOOLCHAIN_HAS_ZBB
>         bool
>         default y
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/ato=
mic.h
> index 5b96c2f61adb..f484babecb9e 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -50,6 +50,7 @@ static __always_inline void arch_atomic64_set(atomic64_=
t *v, s64 i)
>   * have the AQ or RL bits set.  These don't return anything, so there's =
only
>   * one version to worry about.
>   */
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>  #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)             \
>  static __always_inline                                                 \
>  void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)       \
> @@ -59,7 +60,23 @@ void arch_atomic##prefix##_##op(c_type i, atomic##pref=
ix##_t *v)     \
>                 : "+A" (v->counter)                                     \
>                 : "r" (I)                                               \
>                 : "memory");                                            \
> -}                                                                      \
> +}
> +#else
> +#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)             \
> +static __always_inline                                                 \
> +void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)       \
> +{                                                                      \
> +       register c_type ret, temp;                                      \
> +       __asm__ __volatile__ (                                          \
> +               "1:     lr." #asm_type " %1, %0\n"                      \
> +               "       " #asm_op " %2, %1, %3\n"                       \
> +               "       sc." #asm_type " %2, %2, %0\n"                  \
> +               "       bnez %2, 1b\n"                                  \
> +               : "+A" (v->counter), "=3D&r" (ret), "=3D&r" (temp)       =
   \
> +               : "r" (I)                                               \
> +               : "memory");                                            \
> +}
> +#endif
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS(op, asm_op, I)                                      \
> @@ -84,6 +101,7 @@ ATOMIC_OPS(xor, xor,  i)
>   * There's two flavors of these: the arithmatic ops have both fetch and =
return
>   * versions, while the logical ops only have fetch versions.
>   */
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>  #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)       \
>  static __always_inline                                                 \
>  c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,            \
> @@ -108,6 +126,38 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, at=
omic##prefix##_t *v)   \
>                 : "memory");                                            \
>         return ret;                                                     \
>  }
> +#else
> +#define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)       \
> +static __always_inline                                                 \
> +c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,            \
> +                                            atomic##prefix##_t *v)     \
> +{                                                                      \
> +       register c_type ret, temp;                                      \
> +       __asm__ __volatile__ (                                          \
> +               "1:     lr." #asm_type " %1, %0\n"                      \
> +               "       " #asm_op " %2, %1, %3\n"                       \
> +               "       sc." #asm_type " %2, %2, %0\n"                  \
> +               "       bnez %2, 1b\n"                                  \
> +               : "+A" (v->counter), "=3D&r" (ret), "=3D&r" (temp)       =
   \
> +               : "r" (I)                                               \
> +               : "memory");                                            \
> +       return ret;                                                     \
> +}                                                                      \
> +static __always_inline                                                 \
> +c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)=
       \
> +{                                                                      \
> +       register c_type ret, temp;                                      \
> +       __asm__ __volatile__ (                                          \
> +               "1:     lr." #asm_type ".aqrl %1, %0\n"                 \
> +               "       " #asm_op " %2, %1, %3\n"                       \
> +               "       sc." #asm_type ".aqrl %2, %2, %0\n"             \
> +               "       bnez %2, 1b\n"                                  \
> +               : "+A" (v->counter), "=3D&r" (ret), "=3D&r" (temp)       =
   \
> +               : "r" (I)                                               \
> +               : "memory");                                            \
> +       return ret;                                                     \
> +}
> +#endif
>
>  #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix) =
       \
>  static __always_inline                                                 \
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bit=
ops.h
> index fae152ea0508..b51cb18f7d9e 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -187,12 +187,17 @@ static __always_inline int variable_fls(unsigned in=
t x)
>
>  #if (BITS_PER_LONG =3D=3D 64)
>  #define __AMO(op)      "amo" #op ".d"
> +#define __LR   "lr.d"
> +#define __SC   "sc.d"
>  #elif (BITS_PER_LONG =3D=3D 32)
>  #define __AMO(op)      "amo" #op ".w"
> +#define __LR   "lr.w"
> +#define __SC   "sc.w"
>  #else
>  #error "Unexpected BITS_PER_LONG"
>  #endif
>
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>  #define __test_and_op_bit_ord(op, mod, nr, addr, ord)          \
>  ({                                                             \
>         unsigned long __res, __mask;                            \
> @@ -211,6 +216,33 @@ static __always_inline int variable_fls(unsigned int=
 x)
>                 : "+A" (addr[BIT_WORD(nr)])                     \
>                 : "r" (mod(BIT_MASK(nr)))                       \
>                 : "memory");
> +#else
> +#define __test_and_op_bit_ord(op, mod, nr, addr, ord)          \
> +({                                                             \
> +       unsigned long __res, __mask, __temp;                    \
> +       __mask =3D BIT_MASK(nr);                                  \
> +       __asm__ __volatile__ (                                  \
> +               "1: " __LR #ord " %0, %1\n"                     \
> +               #op " %2, %0, %3\n"                             \
> +               __SC #ord " %2, %2, %1\n"                       \
> +               "bnez %2, 1b\n"                                 \
> +               : "=3D&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=3D&r" (__=
temp)      \
> +               : "r" (mod(__mask))                             \
> +               : "memory");                                    \
> +       ((__res & __mask) !=3D 0);                                \
> +})
> +
> +#define __op_bit_ord(op, mod, nr, addr, ord)                   \
> +       unsigned long __res, __temp;                            \
> +       __asm__ __volatile__ (                                  \
> +               "1: " __LR #ord " %0, %1\n"                     \
> +               #op " %2, %0, %3\n"                             \
> +               __SC #ord " %2, %2, %1\n"                       \
> +               "bnez %2, 1b\n"                                 \
> +               : "=3D&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=3D&r" (__=
temp)      \
> +               : "r" (mod(BIT_MASK(nr)))                       \
> +               : "memory")
> +#endif
>
>  #define __test_and_op_bit(op, mod, nr, addr)                   \
>         __test_and_op_bit_ord(op, mod, nr, addr, .aqrl)
> @@ -354,12 +386,25 @@ static inline void arch___clear_bit_unlock(
>  static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
>                 volatile unsigned long *addr)
>  {
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>         unsigned long res;
>         __asm__ __volatile__ (
>                 __AMO(xor) ".rl %0, %2, %1"
>                 : "=3Dr" (res), "+A" (*addr)
>                 : "r" (__NOP(mask))
>                 : "memory");
> +#else
> +       unsigned long res, temp;
> +
> +       __asm__ __volatile__ (
> +               "1: " __LR ".rl %0, %1\n"
> +               "xor %2, %0, %3\n"
> +               __SC ".rl %2, %2, %1\n"
> +               "bnez %2, 1b\n"
> +               : "=3D&r" (res), "+A" (*addr), "=3D&r" (temp)
> +               : "r" (__NOP(mask))
> +               : "memory");
> +#endif
>         return (res & BIT(7)) !=3D 0;
>  }
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 4cadc56220fe..881082b05110 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -51,6 +51,7 @@
>         }                                                                =
       \
>  })
>
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>  #define __arch_xchg(sfx, prepend, append, r, p, n)                     \
>  ({                                                                     \
>         __asm__ __volatile__ (                                          \
> @@ -61,6 +62,21 @@
>                 : "r" (n)                                               \
>                 : "memory");                                            \
>  })
> +#else
> +#define __arch_xchg(sfx, prepend, append, r, p, n)                     \
> +({                                                                     \
> +       __typeof__(*(__ptr)) temp;                                      \
> +       __asm__ __volatile__ (                                          \
> +               prepend                                                 \
> +               "1:     lr" sfx " %0, %1\n"                             \
> +               "       sc" sfx " %2, %3, %1\n"                         \
> +               "       bnez %2, 1b\n"                                  \
> +               append                                                  \
> +               : "=3D&r" (r), "+A" (*(p)), "=3D&r" (temp)               =
   \
> +               : "r" (n)                                               \
> +               : "memory");                                            \
> +})
> +#endif
>
>  #define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,                 =
       \
>                    sc_append, swap_append)                              \
> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/fute=
x.h
> index fc8130f995c1..47297f47ec35 100644
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h
> @@ -19,6 +19,7 @@
>  #define __disable_user_access()                do { } while (0)
>  #endif
>
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>  #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)     \
>  {                                                              \
>         __enable_user_access();                                 \
> @@ -32,16 +33,39 @@
>         : "memory");                                            \
>         __disable_user_access();                                \
>  }
> +#else
> +#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)     \
> +{                                                              \
> +       __enable_user_access();                                 \
> +       __asm__ __volatile__ (                                  \
> +       "1:     lr.w.aqrl %[ov], %[u]\n"                        \
> +       "       " insn "\n"                                     \
> +       "       sc.w.aqrl %[t], %[t], %[u]\n"                   \
> +       "       bnez %[t], 1b\n"                                \
> +       "2:\n"                                                  \
> +       _ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r])                  \
> +       : [r] "+r" (ret), [ov] "=3D&r" (oldval),                  \
> +         [t] "=3D&r" (temp), [u] "+m" (*uaddr)                   \
> +       : [op] "Jr" (oparg)                                     \
> +       : "memory");                                            \
> +       __disable_user_access();                                \
> +}
> +#endif
>
>  static inline int
>  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *ua=
ddr)
>  {
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>         int oldval =3D 0, ret =3D 0;
> +#else
> +       int oldval =3D 0, ret =3D 0, temp =3D 0;
> +#endif
>
>         if (!access_ok(uaddr, sizeof(u32)))
>                 return -EFAULT;
>
>         switch (op) {
> +#ifndef CONFIG_RISCV_ISA_ZALRSC_ONLY
>         case FUTEX_OP_SET:
>                 __futex_atomic_op("amoswap.w.aqrl %[ov],%z[op],%[u]",
>                                   ret, oldval, uaddr, oparg);
> @@ -62,6 +86,28 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *ov=
al, u32 __user *uaddr)
>                 __futex_atomic_op("amoxor.w.aqrl %[ov],%z[op],%[u]",
>                                   ret, oldval, uaddr, oparg);
>                 break;
> +#else
> +       case FUTEX_OP_SET:
> +               __futex_atomic_op("mv %[t], %z[op]",
> +                                 ret, oldval, uaddr, oparg);
> +               break;
> +       case FUTEX_OP_ADD:
> +               __futex_atomic_op("add %[t], %[ov], %z[op]",
> +                                 ret, oldval, uaddr, oparg);
> +               break;
> +       case FUTEX_OP_OR:
> +               __futex_atomic_op("or %[t], %[ov], %z[op]",
> +                                 ret, oldval, uaddr, oparg);
> +               break;
> +       case FUTEX_OP_ANDN:
> +               __futex_atomic_op("and %[t], %[ov], %z[op]",
> +                                 ret, oldval, uaddr, ~oparg);
> +               break;
> +       case FUTEX_OP_XOR:
> +               __futex_atomic_op("xor %[t], %[ov], %z[op]",
> +                                 ret, oldval, uaddr, oparg);
> +               break;
> +#endif
>         default:
>                 ret =3D -ENOSYS;
>         }
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren

