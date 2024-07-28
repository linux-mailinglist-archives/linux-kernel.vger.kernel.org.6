Return-Path: <linux-kernel+bounces-264817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA193E8C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BEE1F21951
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A569D31;
	Sun, 28 Jul 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHBCCx5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFD5D8F0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722186610; cv=none; b=mqdSQ99C1NPXDoa9XfFS571ZdXJoIfcMTBXDB0WU/IXplFlNXnHRglJvcSUJKyysAYgPvwwhwz4eW/u5lc0xl0+onbKWZiRXeU2ZdjFNHFh7Q0pxF8cT/xuGcf4iAkiCmrp7H1KAO9o3wE4gX0KJvLLd9Z7QXTXVjKlVN39GU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722186610; c=relaxed/simple;
	bh=l3gHkQ/NU32IzCYO3ixV8wWe6hv/MkF0B1GAK7YJoLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn5oT+5O8kbWRgcvRNlMc2yXiOIiXD1ZlSFLBFRiybwI5DO5sq+1BfSp/3N3pHw8UyxyxAcg+aIYpm+vd2FoLGrqMJ7r/Fzcalz8RRBGQOK++CtSFHfnIjUbVQvA9/s9CNe5ZEVUxuY9IhDULvEjrotcTKQsbYuaZrKYfY76cuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHBCCx5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29D4C116B1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722186609;
	bh=l3gHkQ/NU32IzCYO3ixV8wWe6hv/MkF0B1GAK7YJoLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NHBCCx5RDlwCDdIPkEMAmDSRP6GZPtRSmEjR2Q49/lNYB2p3s58glXwHs8EzXQiIB
	 EADcCgAcineT8Oz9jI/JNYo8/DLBB1gYEqiKyhezsLhP8jbyu3DdR/RXEGjshm8ygp
	 5wJRw0Yrn2C2uZtUNwq78wcYCBdr+fpv9vbO3CazDSweLQYMJdpNZp1yHcHhXHKfdS
	 p5W9iSdLpglSXb9LsN5EweeKi3Eqicedn4pzNdd92aU9JN1PfhxgVZXyWISR3+AwEA
	 1g9H79W60Vn3tVXh6VGVlXTnR2sqYzuecuIG8+fk+HWWIdcQ/+CN5duliAHn82hpYC
	 REX/UHwaPC9og==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01613acbso3140701e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:10:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNMCmf92Fiqf85+FardF9DmRlRlh4nnT9ZFzZ8FsfMDPZtqYLJ
	jOZHlXc/73ZULl4W9rIKXR6/q7grtPj6/MNzDmYtJdO1cpwWsxnOynGwXibBrwt19iSTMdPKj4z
	IO1PIkeWHIqCQ4FVS7aje+D0Uhfw=
X-Google-Smtp-Source: AGHT+IESy5OGxKc5Z3uEqXtfhs0Fn9kXpkT5oA1UAMJoLUBY8B6sYtqDSadfb7H2/5AKXEnFMohq2ch5ceB7JNX7Ljs=
X-Received: by 2002:a05:6512:250d:b0:52f:cc9e:4480 with SMTP id
 2adb3069b0e04-5309b674224mr1693146e87.0.1722186608115; Sun, 28 Jul 2024
 10:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
In-Reply-To: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Jul 2024 19:09:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com>
Message-ID: <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: vfp: Use asm volatile in fmrx/fmxr macros
To: Calvin Owens <calvin@wbinvd.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, 
	zhuqiuer <zhuqiuer1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

(cc Arnd, Nathan, zhuqiuer)

On Sun, 28 Jul 2024 at 10:21, Calvin Owens <calvin@wbinvd.org> wrote:
>
> Floating point instructions in userspace can crash some arm kernels
> built with clang/LLD 17.0.6:
>
>     BUG: unsupported FP instruction in kernel mode
>     FPEXC == 0xc0000780
>     Internal error: Oops - undefined instruction: 0 [#1] ARM
>     CPU: 0 PID: 196 Comm: vfp-reproducer Not tainted 6.10.0 #1
>     Hardware name: BCM2835
>     PC is at vfp_support_entry+0xc8/0x2cc
>     LR is at do_undefinstr+0xa8/0x250
>     pc : [<c0101d50>]    lr : [<c010a80c>]    psr: a0000013
>     sp : dc8d1f68  ip : 60000013  fp : bedea19c
>     r10: ec532b17  r9 : 00000010  r8 : 0044766c
>     r7 : c0000780  r6 : ec532b17  r5 : c1c13800  r4 : dc8d1fb0
>     r3 : c10072c4  r2 : c0101c88  r1 : ec532b17  r0 : 0044766c
>     Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>     Control: 00c5387d  Table: 0251c008  DAC: 00000051
>     Register r0 information: non-paged memory
>     Register r1 information: vmalloc memory
>     Register r2 information: non-slab/vmalloc memory
>     Register r3 information: non-slab/vmalloc memory
>     Register r4 information: 2-page vmalloc region
>     Register r5 information: slab kmalloc-cg-2k
>     Register r6 information: vmalloc memory
>     Register r7 information: non-slab/vmalloc memory
>     Register r8 information: non-paged memory
>     Register r9 information: zero-size pointer
>     Register r10 information: vmalloc memory
>     Register r11 information: non-paged memory
>     Register r12 information: non-paged memory
>     Process vfp-reproducer (pid: 196, stack limit = 0x61aaaf8b)
>     Stack: (0xdc8d1f68 to 0xdc8d2000)
>     1f60:                   0000081f b6f69300 0000000f c10073f4 c10072c4 dc8d1fb0
>     1f80: ec532b17 0c532b17 0044766c b6f9ccd8 00000000 c010a80c 00447670 60000010
>     1fa0: ffffffff c1c13800 00c5387d c0100f10 b6f68af8 00448fc0 00000000 bedea188
>     1fc0: bedea314 00000001 00448ebc b6f9d000 00447608 b6f9ccd8 00000000 bedea19c
>     1fe0: bede9198 bedea188 b6e1061c 0044766c 60000010 ffffffff 00000000 00000000
>     Call trace:
>     [<c0101d50>] (vfp_support_entry) from [<c010a80c>] (do_undefinstr+0xa8/0x250)
>     [<c010a80c>] (do_undefinstr) from [<c0100f10>] (__und_usr+0x70/0x80)
>     Exception stack(0xdc8d1fb0 to 0xdc8d1ff8)
>     1fa0:                                     b6f68af8 00448fc0 00000000 bedea188
>     1fc0: bedea314 00000001 00448ebc b6f9d000 00447608 b6f9ccd8 00000000 bedea19c
>     1fe0: bede9198 bedea188 b6e1061c 0044766c 60000010 ffffffff
>     Code: 0a000061 e3877202 e594003c e3a09010 (eef16a10)
>     ---[ end trace 0000000000000000 ]---
>     Kernel panic - not syncing: Fatal exception in interrupt
>     ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> This is a minimal userspace reproducer on a Raspberry Pi Zero W:
>
>     #include <stdio.h>
>     #include <math.h>
>
>     int main(void)
>     {
>             double v = 1.0;
>             printf("%f\n", NAN + *(volatile double *)&v);
>             return 0;
>     }
>
> Another way to consistently trigger the oops is:
>
>     calvin@raspberry-pi-zero-w ~$ python -c "import json"
>
> The bug reproduces only when the kernel is built with DYNAMIC_DEBUG=n,
> because the pr_debug() calls act as barriers even when not activated.
>
> This is the output from the same kernel source built with the same
> compiler and DYNAMIC_DEBUG=y, where the userspace reproducer works as
> expected:
>
>     VFP: bounce: trigger ec532b17 fpexc c0000780
>     VFP: emulate: INST=0xee377b06 SCR=0x00000000
>     VFP: bounce: trigger eef1fa10 fpexc c0000780
>     VFP: emulate: INST=0xeeb40b40 SCR=0x00000000
>     VFP: raising exceptions 30000000
>
>     calvin@raspberry-pi-zero-w ~$ ./vfp-reproducer
>     nan
>
> Crudely grepping for vmsr/vmrs instructions in the otherwise nearly
> idential text for vfp_support_entry() makes the problem obvious:
>
>     vmlinux.llvm.good [0xc0101cb8] <+48>:  vmrs   r7, fpexc
>     vmlinux.llvm.good [0xc0101cd8] <+80>:  vmsr   fpexc, r0
>     vmlinux.llvm.good [0xc0101d20] <+152>: vmsr   fpexc, r7
>     vmlinux.llvm.good [0xc0101d38] <+176>: vmrs   r4, fpexc
>     vmlinux.llvm.good [0xc0101d6c] <+228>: vmrs   r0, fpscr
>     vmlinux.llvm.good [0xc0101dc4] <+316>: vmsr   fpexc, r0
>     vmlinux.llvm.good [0xc0101dc8] <+320>: vmrs   r0, fpsid
>     vmlinux.llvm.good [0xc0101dcc] <+324>: vmrs   r6, fpscr
>     vmlinux.llvm.good [0xc0101e10] <+392>: vmrs   r10, fpinst
>     vmlinux.llvm.good [0xc0101eb8] <+560>: vmrs   r10, fpinst2
>
>     vmlinux.llvm.bad  [0xc0101cb8] <+48>:  vmrs   r7, fpexc
>     vmlinux.llvm.bad  [0xc0101cd8] <+80>:  vmsr   fpexc, r0
>     vmlinux.llvm.bad  [0xc0101d20] <+152>: vmsr   fpexc, r7
>     vmlinux.llvm.bad  [0xc0101d30] <+168>: vmrs   r0, fpscr
>     vmlinux.llvm.bad  [0xc0101d50] <+200>: vmrs   r6, fpscr  <== BOOM!
>     vmlinux.llvm.bad  [0xc0101d6c] <+228>: vmsr   fpexc, r0
>     vmlinux.llvm.bad  [0xc0101d70] <+232>: vmrs   r0, fpsid
>     vmlinux.llvm.bad  [0xc0101da4] <+284>: vmrs   r10, fpinst
>     vmlinux.llvm.bad  [0xc0101df8] <+368>: vmrs   r4, fpexc
>     vmlinux.llvm.bad  [0xc0101e5c] <+468>: vmrs   r10, fpinst2
>
> I think LLVM's reordering is valid as the code is currently written: the
> compiler doesn't know the instructions have side effects in hardware.
>
> Fix by using "asm volatile" in fmxr() and fmrx(), so they cannot be
> reordered with respect to each other. The original compiler now produces
> working kernels on my hardware with DYNAMIC_DEBUG=n.
>
> This is the relevant piece of the diff of the vfp_support_entry() text,
> from the original oopsing kernel to a working kernel with this patch:
>
>          vmrs r0, fpscr
>          tst r0, #4096
>          bne 0xc0101d48
>          tst r0, #458752
>          beq 0xc0101ecc
>          orr r7, r7, #536870912
>          ldr r0, [r4, #0x3c]
>          mov r9, #16
>         -vmrs r6, fpscr
>          orr r9, r9, #251658240
>          add r0, r0, #4
>          str r0, [r4, #0x3c]
>          mvn r0, #159
>          sub r0, r0, #-1207959552
>          and r0, r7, r0
>          vmsr fpexc, r0
>          vmrs r0, fpsid
>         +vmrs r6, fpscr
>          and r0, r0, #983040
>          cmp r0, #65536
>          bne 0xc0101d88
>
> Fixes: 4708fb041346 ("ARM: vfp: Reimplement VFP exception entry in C code")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  arch/arm/vfp/vfpinstr.h | 48 ++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>

Thanks for the patch, and for the excellent analysis.

Note that this fix has been proposed in the past, as well as another
one addressing the same issue, but we've been incredibly sloppy
getting it merged.

https://lore.kernel.org/linux-arm-kernel/20240410024126.21589-2-zhuqiuer1@huawei.com/
https://lore.kernel.org/linux-arm-kernel/20240318093004.117153-2-ardb+git@google.com/

What both of us appear to have missed is that there are two versions
of these routines, which should either be dropped (as they are
obsolete now that the minimum binutils version is 2.25) or fixed up as
well, as you do below.

Anyone have any thoughts on using a memory clobber as opposed to
volatile? I think volatile means that the access cannot be elided, but
it is unclear to me whether that implies any ordering. A 'memory'
clobber implies that globally visible state is updated, which seems
like a stronger guarantee to me.

In any case, let's work together to get /some/ version of this fix merged asap.



> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> index 3c7938fd40aa..32090b0fb250 100644
> --- a/arch/arm/vfp/vfpinstr.h
> +++ b/arch/arm/vfp/vfpinstr.h
> @@ -64,33 +64,37 @@
>
>  #ifdef CONFIG_AS_VFP_VMRS_FPINST
>
> -#define fmrx(_vfp_) ({                 \
> -       u32 __v;                        \
> -       asm(".fpu       vfpv2\n"        \
> -           "vmrs       %0, " #_vfp_    \
> -           : "=r" (__v) : : "cc");     \
> -       __v;                            \
> - })
> -
> -#define fmxr(_vfp_,_var_)              \
> -       asm(".fpu       vfpv2\n"        \
> -           "vmsr       " #_vfp_ ", %0" \
> -          : : "r" (_var_) : "cc")
> +#define fmrx(_vfp_) ({                         \
> +       u32 __v;                                \
> +       asm volatile (".fpu     vfpv2\n"        \
> +                     "vmrs     %0, " #_vfp_    \
> +                    : "=r" (__v) : : "cc");    \
> +       __v;                                    \
> +})
> +
> +#define fmxr(_vfp_, _var_) ({                  \
> +       asm volatile (".fpu     vfpv2\n"        \
> +                     "vmsr     " #_vfp_ ", %0" \
> +                    : : "r" (_var_) : "cc");   \
> +})
>
>  #else
>
>  #define vfpreg(_vfp_) #_vfp_
>
> -#define fmrx(_vfp_) ({                 \
> -       u32 __v;                        \
> -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #_vfp_    \
> -           : "=r" (__v) : : "cc");     \
> -       __v;                            \
> - })
> -
> -#define fmxr(_vfp_,_var_)              \
> -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
> -          : : "r" (_var_) : "cc")
> +#define fmrx(_vfp_) ({                                         \
> +       u32 __v;                                                \
> +       asm volatile ("mrc p10, 7, %0, " vfpreg(_vfp_) ","      \
> +                     "cr0, 0 @ fmrx    %0, " #_vfp_            \
> +                    : "=r" (__v) : : "cc");                    \
> +       __v;                                                    \
> +})
> +
> +#define fmxr(_vfp_, _var_) ({                                  \
> +       asm volatile ("mcr p10, 7, %0, " vfpreg(_vfp_) ","      \
> +                     "cr0, 0 @ fmxr    " #_vfp_ ", %0"         \
> +                    : : "r" (_var_) : "cc");                   \
> +})
>
>  #endif
>
> --
> 2.39.2
>

