Return-Path: <linux-kernel+bounces-256192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B55934A79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C125B226FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E37D3F1;
	Thu, 18 Jul 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpfm0+8g"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B43A28D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292753; cv=none; b=bw0Vag/9KeH3CbGcFfjvKnTtXlxFxzvLdSvAvhcIofK3Lur0JzJ3t5Yb+dlbaiRyOKZqBHkBoX8kwLzy+wqX6qHsnFRi4jOGqtHcbBeZNwnn9KNXGEQZnpqAMu3bCOuEGWFrfGYnnnbca5sE3TMsG2UVWlp54FqeZtbe/DNs//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292753; c=relaxed/simple;
	bh=n0GeRa75FgKWi7FfMPrBn52TRQBaeObjhKPvjwnLwE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ78p09BhXxeJJJE53YR+6c8NkuIXh19ZRX8hY0Xwfnxo4lgwtnN/F7KZ7oXpskLULyXpoueYbU+9tspiDiB5BKZ7dqPv7q0pn1XqsB2xhQLGX0bojrOEz5By0MPO0w2KfAPw9KyPeEcXAKdLtWlkWengd6DYfoOSMIvJBOwCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpfm0+8g; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeef45d865so7778271fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721292749; x=1721897549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzDA8rgjEKXwsDhM/sL66gRmEYTafR6rxJOIFWy86LQ=;
        b=kpfm0+8gZIdxqNXoTelEQApvQeTsnAqNjWOmuI6+RxUqJKE8J2CtpFVx0FP04UKFUK
         YlpQAfUmlk1ptPPKJ2zY3SDKivZ5TlqYh4BfybNP1vHAdGq5F2G9T/ChnwJyzPWeXbNs
         Vj/ifnA94tZ/VB7H/vT/spp5J1JkvkJv9v4Jg1UV4zPFysa9tZbwAlpOYmTeNZDNTnCF
         enXnQlJ1yply8PBmRg9nuMtbFgG0bZNlE/q4QXw/oIkyQNpPg6+37xMAlLRUcaEhRsO4
         fgaXffSeby5ZgjUQsuAdQqENEpY0tEmkmxwH6qfrMZfKQeAxqy9z+kaOxrJfA2MGYyjR
         ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292749; x=1721897549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzDA8rgjEKXwsDhM/sL66gRmEYTafR6rxJOIFWy86LQ=;
        b=vAvP9it6+uZOMWJaiZwuNVFcCDitX2nD7w4EWSRQz1C4kWp3LM6QxxBTxwJJx0Eac3
         so0/V3qP4z0DQtXldI6Ggbd0XNpMPb4+05ojjKDAuLq5c0CIyNyjbWd0kW0G1xJxcQuK
         7CdeNlOqGwvBOkwAoO9/TZsbxHx5g2DQlhePClpE7vAFQ7fMG9/LN2NW/37raVvEcfa0
         Dsh+qWjyF6EOS0EKYT+MLIwHtSWd8QLQEEF8+qz5OkooNixyZcvSYRGOC7YNtDLld7UW
         m93blOP/X24Iw38LzlNmKr4SZRv65gBYOF+MpA9mX4t5nO+tZsCtb3AVLzlvMeoajzNp
         chFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX153GhvyL1TVCQEUPI3R5PqfGPAlDKg3gyvAUzWig9hdiGtamw1bUj9kBMxijbeCS8tsP73GdO5h0F0K3wdZDucqtcuVEgU+NJfjb
X-Gm-Message-State: AOJu0YxPUBG97uYqnJgjSj0XF5Quk47CeDfF/gFadmh6jjjLEv8Od50r
	jNITZpGbUiXvTPG46mNv2N8eImVyWrEnyXqR+0IL8ajGWhH8YRacG8CAR46M8sXkgXDd/pdOGCM
	RkUjIOt5RIaWBeTxAIxRL3CrwAkM=
X-Google-Smtp-Source: AGHT+IEoAnA4tuIwL4IHOd8CHrNCpct0ipozYPWfH8qBgZi2zQ/Fdj9SBTmEpCcIbwu2J91aFaMR+ZHwKUrasVG2jxo=
X-Received: by 2002:a2e:9b12:0:b0:2ec:4b00:a746 with SMTP id
 38308e7fff4ca-2ef05c53c33mr15827551fa.9.1721292748768; Thu, 18 Jul 2024
 01:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
In-Reply-To: <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 18 Jul 2024 10:52:17 +0200
Message-ID: <CAFULd4bs7meRq_iTqq1nSzpkSzEQqLkM8S=x4=zqtX6Fo9qQPQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use __ASM_SIZE() to reduce ifdeffery in cpuflags.c
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 8:36=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On July 17, 2024 11:32:18 PM PDT, Uros Bizjak <ubizjak@gmail.com> wrote:
> >Use __ASM_SIZE() macro to add correct insn suffix to pushf/popf.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> > arch/x86/boot/cpuflags.c | 10 +++-------
> > 1 file changed, 3 insertions(+), 7 deletions(-)
> >
> >diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> >index d75237ba7ce9..aacabe431fd5 100644
> >--- a/arch/x86/boot/cpuflags.c
> >+++ b/arch/x86/boot/cpuflags.c
> >@@ -2,6 +2,7 @@
> > #include <linux/types.h>
> > #include "bitops.h"
> >
> >+#include <asm/asm.h>
> > #include <asm/processor-flags.h>
> > #include <asm/required-features.h>
> > #include <asm/msr-index.h>
> >@@ -36,13 +37,8 @@ static int has_fpu(void)
> >  * compressed/ directory where it may be 64-bit code, and thus needs
> >  * to be 'pushfq' or 'popfq' in that case.
> >  */
> >-#ifdef __x86_64__
> >-#define PUSHF "pushfq"
> >-#define POPF "popfq"
> >-#else
> >-#define PUSHF "pushfl"
> >-#define POPF "popfl"
> >-#endif
> >+#define PUSHF __ASM_SIZE(pushf)
> >+#define POPF __ASM_SIZE(popf)
> >
> > int has_eflag(unsigned long mask)
> > {
>
> Just use pushf/popf. gas hasn't needed that suffix for a long time as far=
 as I know.

Unfortunately, clang does not do the right thing when pushf/popf
without suffix are used.

arch/x86/boot/cpuflags.c compiles to:

00000000 <has_eflag>:
   0:    9c                       pushf
   1:    9c                       pushf
   2:    66 5a                    pop    %edx
   4:    66 89 d1                 mov    %edx,%ecx
   7:    66 31 c1                 xor    %eax,%ecx
   a:    66 51                    push   %ecx
   c:    9d                       popf
   d:    9c                       pushf
   e:    66 59                    pop    %ecx
  10:    9d                       popf
  11:    66 31 ca                 xor    %ecx,%edx
  14:    66 31 c9                 xor    %ecx,%ecx
  17:    66 85 c2                 test   %eax,%edx
  1a:    0f 95 c1                 setne  %cl
  1d:    66 89 c8                 mov    %ecx,%eax
  20:    66 c3                    retl

instead of:

00000000 <has_eflag>:
   0:    66 9c                    pushfl
   2:    66 9c                    pushfl
   4:    66 5a                    pop    %edx
   6:    66 89 d1                 mov    %edx,%ecx
   9:    66 31 c1                 xor    %eax,%ecx
   c:    66 51                    push   %ecx
   e:    66 9d                    popfl
  10:    66 9c                    pushfl
  12:    66 59                    pop    %ecx
  14:    66 9d                    popfl
  16:    66 31 ca                 xor    %ecx,%edx
  19:    66 31 c9                 xor    %ecx,%ecx
  1c:    66 85 c2                 test   %eax,%edx
  1f:    0f 95 c1                 setne  %cl
  22:    66 89 c8                 mov    %ecx,%eax
  25:    66 c3                    retl

Please note missing 0x66 operand size override prefixes with pushfl
and popfl. This is 16bit code, operand prefixes are mandatory to push
32-bit EFLAGS register (ID flag lives in bit 21).

So, the original patch is the way to go.

Uros.

