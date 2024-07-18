Return-Path: <linux-kernel+bounces-256205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077D934AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DE9286451
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0C81211;
	Thu, 18 Jul 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0YoN5Wv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD613BB30
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293942; cv=none; b=aEJeb4qI/zfMH9cB8VzH0tjjG41btFiyk24GffhpOvJ+Nbpk4F1X1rsROxpq4sJMtqh11HmEfEoXaPq4NRjwmtBRjay045fPnvI8WnaM7vLgK0TzPUwJtGqKS7OtI1Re8ixlmKDNNufz+Bozi0EKJgBaPyUZMzpCVGkg1SvyHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293942; c=relaxed/simple;
	bh=PEXsUQRuWFa/XsPmagCm6KmvlhiwIZA1STK121ylA0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/2bnLrXJqVy5mPePZptTbDB7EhRod3Ky6yC8KJAeEH54Pz/XrCfn1Xmx6iinAEs6aFQmTovyq5T/ayUA/Y55fiPKvmcVUbWiFM5K8huwx0RAVWqw0aAJfjh2juXcMr53zB8wiLQ7X4Q6jB8G6GnJY+vU4Ho2Ux/RPvT2aKFxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0YoN5Wv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so8358761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721293939; x=1721898739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYRDJTXb7VkR2nu2Bt3xlsYZzSCplD55JeoAUmrsGvg=;
        b=B0YoN5Wvq8xfUhvPrQJyKcodiyhUIvzlXoWnFr9kgpti66eejPv1Qe2YlqhGN0+l0w
         EMOn8QgpOhy5pKJbHeQN9961qxiknmJcslJ49/bAUiZN0BQfoVNyDq4r2/k6HZggXlxB
         +Yqw0F3bgLKogVEyIp9M6oE5m3dISEQyWrlp4zVZANEFxypFcZRbUlDf7KVXhCnYDvn7
         JqoDmKgaf6emMO1fKYaCnvvujUJi0rEzWw3sk+Y4YM+rr09qk76AHO7gBlTr1NHybbH4
         fGvqSxnppSRBqRdBnSvc5rWNeReL9U7rj7zrg9mw1uG6cH3rloLGYPessCy1/y/fXhUz
         Y77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721293939; x=1721898739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYRDJTXb7VkR2nu2Bt3xlsYZzSCplD55JeoAUmrsGvg=;
        b=p+zl0+ZN53KyrEHU2Uj/Ky+Stqn6YD2cUMIkFkBBHCMNGI6QVdHn3CbYv4eLZujJZZ
         K/3ritlYRmkFjsf41fxM2uKhIafXaLqoSyKJzV8engZVFNTmfH1u0LjFHiCcQLiACcUO
         pX8+y+16WaoEelXJ7SpSvJ6E9EBOB5ElpnRBf2dkUtBMnLnvudp+zBlP1YAgTK1nrEio
         FelRvIW7yQEhumjTeoFFYpmw/4tWgjdp/dJdVGPDBvastEo56HtDy48d8/BQZqVb8eu4
         C1AJzfHxAh31cuDxfDy2P9491m4F9OUXUXJNi+tiYz9DY9I4aQHikcQmTZDe551MN9Li
         IaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVLb2uXqdPd+QhZfLRJZC5vcopPzc7xtf9Ci/HQh4PkAUwg0GSISC9ye75dIEc6cRg2hJ8ztEf73Glw16Gg25nLtBepxd8nIYohoxrx
X-Gm-Message-State: AOJu0Yz640NN0pm7YuWzz0ae+yNJO6B7N9Km9qrwgqjBPeuyr0yw/pwV
	pX9ir7LB7bvyZgdp318JyTSkinHuPUldTjX45VjQHyKC+P8nBGaunFgleT5HRnooIWBLjccXwTi
	5HhEFC6G6ALjmlKJArmi+5hDkvGlNYJKJtOc=
X-Google-Smtp-Source: AGHT+IEzjEv1damTpttKz+LCf+AT1wIDiCcudbwQkbMrBn8f0B3SN1rLlEKpdwAapOoV9piTt/ea7WMFEKVP7gI0zWA=
X-Received: by 2002:a2e:9ed3:0:b0:2ee:87e9:319d with SMTP id
 38308e7fff4ca-2ef05d48368mr13444611fa.48.1721293938819; Thu, 18 Jul 2024
 02:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
 <CAFULd4bs7meRq_iTqq1nSzpkSzEQqLkM8S=x4=zqtX6Fo9qQPQ@mail.gmail.com> <77174D9A-79DE-44A7-85E0-63B0BFE343C2@zytor.com>
In-Reply-To: <77174D9A-79DE-44A7-85E0-63B0BFE343C2@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 18 Jul 2024 11:12:07 +0200
Message-ID: <CAFULd4Z91bzEDb+MTDP3NgF_3DxW0mG8jbjCR75e8yjWEeHQkw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use __ASM_SIZE() to reduce ifdeffery in cpuflags.c
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:56=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On July 18, 2024 1:52:17 AM PDT, Uros Bizjak <ubizjak@gmail.com> wrote:
> >On Thu, Jul 18, 2024 at 8:36=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> w=
rote:
> >>
> >> On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail.com> wrot=
e:
> >> >Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf.
> >> >
> >> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >> >Cc: Ingo Molnar <mingo@kernel.org>
> >> >Cc: Borislav Petkov <bp@alien8.de>
> >> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> >---
> >> > arch/x86/boot/cpuflags.c | 10 +++-------
> >> > 1 file changed, 3 insertions(+), 7 deletions(-)
> >> >
> >> >diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> >> >index d75237ba7ce9..aacabe431fd5 100644
> >> >--- a/arch/x86/boot/cpuflags.c
> >> >+++ b/arch/x86/boot/cpuflags.c
> >> >@@ -2,6 +2,7 @@
> >> > #include <linux/types.h>
> >> > #include "bitops.h"
> >> >
> >> >+#include <asm/asm.h>
> >> > #include <asm/processor-flags.h>
> >> > #include <asm/required-features.h>
> >> > #include <asm/msr-index.h>
> >> >@@ -36,13 +37,8 @@ static int has_fpu(void)
> >> >  * compressed/ directory where it may be 64-bit code, and thus needs
> >> >  * to be 'pushfq' or 'popfq' in that case.
> >> >  */
> >> >-#ifdef __x86_64__
> >> >-#define PUSHF "pushfq"
> >> >-#define POPF "popfq"
> >> >-#else
> >> >-#define PUSHF "pushfl"
> >> >-#define POPF "popfl"
> >> >-#endif
> >> >+#define PUSHF __ASM_SIZE(pushf)
> >> >+#define POPF __ASM_SIZE(popf)
> >> >
> >> > int has_eflag(unsigned long mask)
> >> > {
> >>
> >> Just use pushf/popf. gas hasn't needed that suffix for a long time as =
far as I know.
> >
> >Unfortunately, clang does not do the right thing when pushf/popf
> >without suffix are used.
> >
> >arch/x86/boot/cpuflags.c compiles to:
> >
> >00000000 <has_eflag>:
> >   0:    9c                       pushf
> >   1:    9c                       pushf
> >   2:    66 5a                    pop    %edx
> >   4:    66 89 d1                 mov    %edx,%ecx
> >   7:    66 31 c1                 xor    %eax,%ecx
> >   a:    66 51                    push   %ecx
> >   c:    9d                       popf
> >   d:    9c                       pushf
> >   e:    66 59                    pop    %ecx
> >  10:    9d                       popf
> >  11:    66 31 ca                 xor    %ecx,%edx
> >  14:    66 31 c9                 xor    %ecx,%ecx
> >  17:    66 85 c2                 test   %eax,%edx
> >  1a:    0f 95 c1                 setne  %cl
> >  1d:    66 89 c8                 mov    %ecx,%eax
> >  20:    66 c3                    retl
> >
> >instead of:
> >
> >00000000 <has_eflag>:
> >   0:    66 9c                    pushfl
> >   2:    66 9c                    pushfl
> >   4:    66 5a                    pop    %edx
> >   6:    66 89 d1                 mov    %edx,%ecx
> >   9:    66 31 c1                 xor    %eax,%ecx
> >   c:    66 51                    push   %ecx
> >   e:    66 9d                    popfl
> >  10:    66 9c                    pushfl
> >  12:    66 59                    pop    %ecx
> >  14:    66 9d                    popfl
> >  16:    66 31 ca                 xor    %ecx,%edx
> >  19:    66 31 c9                 xor    %ecx,%ecx
> >  1c:    66 85 c2                 test   %eax,%edx
> >  1f:    0f 95 c1                 setne  %cl
> >  22:    66 89 c8                 mov    %ecx,%eax
> >  25:    66 c3                    retl
> >
> >Please note missing 0x66 operand size override prefixes with pushfl
> >and popfl. This is 16bit code, operand prefixes are mandatory to push
> >32-bit EFLAGS register (ID flag lives in bit 21).
> >
> >So, the original patch is the way to go.
> >
> >Uros.
> >
>
> You do know that has_eflag can be completely elided on x86-64, or you can=
 use %z with one of the register operands.

It is 32-bit PUSHFL insn that requires the "L" suffix in 16-bit code.
This is x86_32 issue and clang was just lucky that the instruction was
always defined with explicit L suffix. Please note that PUSHF has no
register operand, so %z can't be used.

> One more reason why clang really needs to shape up.

Indeed.

Thanks,
Uros.

