Return-Path: <linux-kernel+bounces-264885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766093E9B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD781F21120
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11978281;
	Sun, 28 Jul 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="H9VcSYNL"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E2171CC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202191; cv=none; b=p/11nqZb2t4l5Qem0XouLBG25gmT07xufCZxydlQ9R0GECIQ1E2xTpERuJ2DNvUTkYFIeqqsjVPVFl6dfNKr3evs9bCxbHvHiCh92FOeniey54hOcwVVwF3cSvFK6C+Ie8SfziuZVgYwd08fpXlNJlzggorJDRZVZTLjdjN9Lds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202191; c=relaxed/simple;
	bh=eh7UOb0gpwvmRc/U0nM38o+Rf1CDu8haYM4fvwZiuuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyl7bzHIkpWjWImrQvOVyaxk8HrsYJPoaS4Tsag2oBWfGqCn8VRJ5xkJxWr97JjEpoA9sKSaAekboXoyS3Cy9FhcwIV3NwQJmwMaNkkSPXiADRB6TVQHSqVK6E8MB1Aj8lCRwm4OBOEZqalSuOjxwMQjQaA7aCAMng50gGkXjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=H9VcSYNL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-785862fdd46so30238a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1722202189; x=1722806989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=068DTb7U3GP+TGu0Qp5p0q4bxI1cSTdW1IWK0tXmmHM=;
        b=H9VcSYNLo+6qu5CU4aomvZhBwjhfHC7w0STNJ03XdZje2IiCIU7p1+Xp0BtYjG+qwE
         NtWW2/aPzf4gJgN932XkrH8EE3JYgFbGhK5ybRpFb3LZYuXT/0A2IE7QHuptefyHVlXA
         Fh9SiPw8K0pOguD6jTZ18PKF/BZhOK/RJKGgtuhxSGhaisw3eHSA1MQOU+hoDphHHXzH
         r4VAe8AQrPAiaI7Vvgr6kJqesnp56QcvtqbA1VzgceTzovo4ZSna0NxTVwbWTzWQSEFF
         n6HOLPgWF3X2QfMyFb28qaYKIgegMCY1fQU6OI0ykUf6cLBpycrRMHSR9XjGA1cDL5V8
         wt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722202189; x=1722806989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=068DTb7U3GP+TGu0Qp5p0q4bxI1cSTdW1IWK0tXmmHM=;
        b=f8BL4kG56jeHLqUU4zf1Obhrp84ufz93FAmZYk4HbFAIpRyt19tQ3DhuxcM6CeqIEu
         kkWekucUEniXiFullulpOb7qgeDBjYjZGJhImKDgd7egMQD7x/qPEleFPJqDLxPHP6wg
         yZBlhThLBiauhaJpPBYWr2Q0rtSqqYg2cna+5xJYi8gsMBjFG2rOpDP4OErLxWWtnhua
         FZ47Kr3+pQH9v0vGtmLdCDE+/bGEcJps6f5IBBOwYYWw10TL01cr5dvP0GIRzw/KnujI
         BRdx0hc7IulnE8mSaBE75mOQD240pL9D99cjODiuxXraoj3qd2rTTTFBSmDt+oqzAiA+
         luqw==
X-Forwarded-Encrypted: i=1; AJvYcCWwvts6fnNE+8UYXPVKHnVAutFoaDBUOqFsvM29bYwqiXK/M5rZPfVwtltx/KtjAn89P5vIgEnKKi0BMl70vU+qN+oziIJuqHqS0Ds1
X-Gm-Message-State: AOJu0Yxe0juUHjpoaJzzCF97qn3LSnUa723auj8WlsgeAUGm1jZA3nhV
	cfNBr/yTIECRXWgsljVdj/jylVAT/129WwTf7wyA8mtlHnEVp5WQlEHvkmfSlkA=
X-Google-Smtp-Source: AGHT+IHqPaezX3BPHyjcEbrdPXpuQZ0UQyPyHD01eJ06JdV8rZkIEtL2lDeBP5dT54WROrrc6TEhiQ==
X-Received: by 2002:a05:6a20:3d91:b0:1c4:a20e:7a8c with SMTP id adf61e73a8af0-1c4a20e859dmr5512134637.4.1722202189103;
        Sun, 28 Jul 2024 14:29:49 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7115a1sm5704594b3a.46.2024.07.28.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 14:29:48 -0700 (PDT)
Date: Sun, 28 Jul 2024 14:29:44 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
	clang-built-linux <clang-built-linux@googlegroups.com>,
	zhuqiuer <zhuqiuer1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: vfp: Use asm volatile in fmrx/fmxr macros
Message-ID: <Zqa4SAyPKPuaXdgg@mozart.vkv.me>
References: <92a00580828a1bdf96e7e36545f6d229809af04f.1722154575.git.calvin@wbinvd.org>
 <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFT3RFW7oPg5pc=bXCqBrzx9amAyR1dZpiqaLKu-5GXpQ@mail.gmail.com>

On Sunday 07/28 at 19:09 +0200, Ard Biesheuvel wrote:
> (cc Arnd, Nathan, zhuqiuer)
> 
> On Sun, 28 Jul 2024 at 10:21, Calvin Owens <calvin@wbinvd.org> wrote:
> > <snip>
> >
> > Crudely grepping for vmsr/vmrs instructions in the otherwise nearly
> > idential text for vfp_support_entry() makes the problem obvious:
> >
> >     vmlinux.llvm.good [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> >     vmlinux.llvm.good [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> >     vmlinux.llvm.good [0xc0101d20] <+152>: vmsr   fpexc, r7
> >     vmlinux.llvm.good [0xc0101d38] <+176>: vmrs   r4, fpexc
> >     vmlinux.llvm.good [0xc0101d6c] <+228>: vmrs   r0, fpscr
> >     vmlinux.llvm.good [0xc0101dc4] <+316>: vmsr   fpexc, r0
> >     vmlinux.llvm.good [0xc0101dc8] <+320>: vmrs   r0, fpsid
> >     vmlinux.llvm.good [0xc0101dcc] <+324>: vmrs   r6, fpscr
> >     vmlinux.llvm.good [0xc0101e10] <+392>: vmrs   r10, fpinst
> >     vmlinux.llvm.good [0xc0101eb8] <+560>: vmrs   r10, fpinst2
> >
> >     vmlinux.llvm.bad  [0xc0101cb8] <+48>:  vmrs   r7, fpexc
> >     vmlinux.llvm.bad  [0xc0101cd8] <+80>:  vmsr   fpexc, r0
> >     vmlinux.llvm.bad  [0xc0101d20] <+152>: vmsr   fpexc, r7
> >     vmlinux.llvm.bad  [0xc0101d30] <+168>: vmrs   r0, fpscr
> >     vmlinux.llvm.bad  [0xc0101d50] <+200>: vmrs   r6, fpscr  <== BOOM!
> >     vmlinux.llvm.bad  [0xc0101d6c] <+228>: vmsr   fpexc, r0
> >     vmlinux.llvm.bad  [0xc0101d70] <+232>: vmrs   r0, fpsid
> >     vmlinux.llvm.bad  [0xc0101da4] <+284>: vmrs   r10, fpinst
> >     vmlinux.llvm.bad  [0xc0101df8] <+368>: vmrs   r4, fpexc
> >     vmlinux.llvm.bad  [0xc0101e5c] <+468>: vmrs   r10, fpinst2
> >
> > I think LLVM's reordering is valid as the code is currently written: the
> > compiler doesn't know the instructions have side effects in hardware.
> >
> > Fix by using "asm volatile" in fmxr() and fmrx(), so they cannot be
> > reordered with respect to each other. The original compiler now produces
> > working kernels on my hardware with DYNAMIC_DEBUG=n.
> >
> > This is the relevant piece of the diff of the vfp_support_entry() text,
> > from the original oopsing kernel to a working kernel with this patch:
> >
> >          vmrs r0, fpscr
> >          tst r0, #4096
> >          bne 0xc0101d48
> >          tst r0, #458752
> >          beq 0xc0101ecc
> >          orr r7, r7, #536870912
> >          ldr r0, [r4, #0x3c]
> >          mov r9, #16
> >         -vmrs r6, fpscr
> >          orr r9, r9, #251658240
> >          add r0, r0, #4
> >          str r0, [r4, #0x3c]
> >          mvn r0, #159
> >          sub r0, r0, #-1207959552
> >          and r0, r7, r0
> >          vmsr fpexc, r0
> >          vmrs r0, fpsid
> >         +vmrs r6, fpscr
> >          and r0, r0, #983040
> >          cmp r0, #65536
> >          bne 0xc0101d88
> >
> > Fixes: 4708fb041346 ("ARM: vfp: Reimplement VFP exception entry in C code")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >  arch/arm/vfp/vfpinstr.h | 48 ++++++++++++++++++++++-------------------
> >  1 file changed, 26 insertions(+), 22 deletions(-)
> >
> 
> Thanks for the patch, and for the excellent analysis.
> 
> Note that this fix has been proposed in the past, as well as another
> one addressing the same issue, but we've been incredibly sloppy
> getting it merged.
> 
> https://lore.kernel.org/linux-arm-kernel/20240410024126.21589-2-zhuqiuer1@huawei.com/
> https://lore.kernel.org/linux-arm-kernel/20240318093004.117153-2-ardb+git@google.com/

Ah sorry for missing that, I searched for the symptom not the cure.

> What both of us appear to have missed is that there are two versions
> of these routines, which should either be dropped (as they are
> obsolete now that the minimum binutils version is 2.25) or fixed up as
> well, as you do below.
> 
> Anyone have any thoughts on using a memory clobber as opposed to
> volatile? I think volatile means that the access cannot be elided, but
> it is unclear to me whether that implies any ordering. A 'memory'
> clobber implies that globally visible state is updated, which seems
> like a stronger guarantee to me.

My thinking was that if 'asm volatile' is sufficient, it will suppress
less optimization than the clobber, since the clobber might force the
compiler to assume unrelated memory could have been modified when it
really never is. But I'm not sure about that.

Out of curiousity, I tried it both ways with the same compiler just now,
the only tiny difference in the emitted vfp_support_entry() is here:

	--- /volatile	2024-07-28 13:28:59.890505404 -0700
	+++ /memclobber	2024-07-28 13:28:59.890505404 -0700
	 str r0, [r5, #0x4]
	 vmrs r7, fpexc
	 tst r7, #1073741824
	 bne 0xc0101d28
	 orr r7, r7, #1073741824
	 bic r0, r7, #-2147483648
	 vmsr fpexc, r0
	+ldr r8, [pc, #0x26c]
	 ldr r0, [r5, #0x8]
	-ldr r8, [pc, #0x268]
	 add r6, r5, #224
	 ldr r0, [r8, r0, lsl #2]
	 cmp r0, r6
	 beq 0xc0101d18

Thanks,
Calvin

> In any case, let's work together to get /some/ version of this fix merged asap.
> 
> > diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> > index 3c7938fd40aa..32090b0fb250 100644
> > --- a/arch/arm/vfp/vfpinstr.h
> > +++ b/arch/arm/vfp/vfpinstr.h
> > @@ -64,33 +64,37 @@
> >
> >  #ifdef CONFIG_AS_VFP_VMRS_FPINST
> >
> > -#define fmrx(_vfp_) ({                 \
> > -       u32 __v;                        \
> > -       asm(".fpu       vfpv2\n"        \
> > -           "vmrs       %0, " #_vfp_    \
> > -           : "=r" (__v) : : "cc");     \
> > -       __v;                            \
> > - })
> > -
> > -#define fmxr(_vfp_,_var_)              \
> > -       asm(".fpu       vfpv2\n"        \
> > -           "vmsr       " #_vfp_ ", %0" \
> > -          : : "r" (_var_) : "cc")
> > +#define fmrx(_vfp_) ({                         \
> > +       u32 __v;                                \
> > +       asm volatile (".fpu     vfpv2\n"        \
> > +                     "vmrs     %0, " #_vfp_    \
> > +                    : "=r" (__v) : : "cc");    \
> > +       __v;                                    \
> > +})
> > +
> > +#define fmxr(_vfp_, _var_) ({                  \
> > +       asm volatile (".fpu     vfpv2\n"        \
> > +                     "vmsr     " #_vfp_ ", %0" \
> > +                    : : "r" (_var_) : "cc");   \
> > +})
> >
> >  #else
> >
> >  #define vfpreg(_vfp_) #_vfp_
> >
> > -#define fmrx(_vfp_) ({                 \
> > -       u32 __v;                        \
> > -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #_vfp_    \
> > -           : "=r" (__v) : : "cc");     \
> > -       __v;                            \
> > - })
> > -
> > -#define fmxr(_vfp_,_var_)              \
> > -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ ", %0" \
> > -          : : "r" (_var_) : "cc")
> > +#define fmrx(_vfp_) ({                                         \
> > +       u32 __v;                                                \
> > +       asm volatile ("mrc p10, 7, %0, " vfpreg(_vfp_) ","      \
> > +                     "cr0, 0 @ fmrx    %0, " #_vfp_            \
> > +                    : "=r" (__v) : : "cc");                    \
> > +       __v;                                                    \
> > +})
> > +
> > +#define fmxr(_vfp_, _var_) ({                                  \
> > +       asm volatile ("mcr p10, 7, %0, " vfpreg(_vfp_) ","      \
> > +                     "cr0, 0 @ fmxr    " #_vfp_ ", %0"         \
> > +                    : : "r" (_var_) : "cc");                   \
> > +})
> >
> >  #endif
> >
> > --
> > 2.39.2
> >

