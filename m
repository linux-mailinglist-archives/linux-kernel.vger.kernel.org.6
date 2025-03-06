Return-Path: <linux-kernel+bounces-549116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56AA54DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2592216B559
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857917995E;
	Thu,  6 Mar 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeOLBcDx"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1414F9FF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271139; cv=none; b=c7ZKM6hwV624hJaAiLUMIkQO+ROokPpi4bELfMH0UmZqXnay9jGJifdvXPZ+mgL+5Clp+iv4P6ER7u4BgTv8bpHy3pd5+Trqo2LI0PZOwvWQl2QnsEpnDJIHxdSE5mqKf4GBvmZF5e1gu999qLlSMLNKq6GR594Wu3ZZcBinRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271139; c=relaxed/simple;
	bh=wkuR6V7yX4FWV69BoRi9f9igrdPVM6MN9Y5OKyuLTKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQEq6Hb8+6dwn+uqHRjei8Ls54hRB1ruM2Gi5jiSa5A1ks2VN8WOC0vqF4fNQzwK7kNYt+XPLgB+OIt4t0DYbfc8A/PneNuy+SyiL9e6QGeQgApFGPjdnfmN9CFD0oY3e8k7pDA38qCGLGgTGIhIx545mwm8AqpbmRE5flvxKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeOLBcDx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30797730cbdso6889051fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271135; x=1741875935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwbv0t6uK6SvbcukPPqIRzqkIicD6618q2LOrpZbTpQ=;
        b=aeOLBcDxkpWQB+BIlUV4C+Dsa3Lq004+2vBntJeFCkL2p8NtxLgGOabr6oApeN51Jg
         JELjE9Q6HkWr/Q7yOtbh6RL393om/WpR6oszZkJcnYa7NmonUtll+5iARwkzSPG+uBlp
         JtXXmYUwo5kGAZBJamNG47PrKlMLTg2DP8x5rICGItfxyIM0qihMn6+rKkFeyLd0vFtm
         oXBMiBqmo3Y6+bRxxMEfNNTQMmGR0CzVK7w+1nLxLI1jUHeBwrM+Cs6OhJb8sPgg5PI+
         pS9OOcuXnlrp0mHv++kbrTZxJ2S5BiPHmwF1QNBHH1zsb6M4Pg8xON1oKiImyvjRGB+b
         KyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271135; x=1741875935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwbv0t6uK6SvbcukPPqIRzqkIicD6618q2LOrpZbTpQ=;
        b=AqLnu3Dna6j1KqMFnhkxtSPTSYHLK2b0zYyrteVyKcjLGLrTR+qS2uhlq7mMLKaKVk
         ZOHhs/ONhUZLoJ/hgNtqepLiZP4LAYkwVTAEZJ6yVQkGCehrLwWkp6bQC3SJGptMzfTI
         6nGsQi/rjM4DUUJIh8WSPAcTJerwkN3ox4bhzP5dY8JwTPIUnjFdKjew36IdsqtUn9zH
         hf5Yxbwe0wMNsqtEz2L9quK0J1iC33eUaebHFf1wiUzaIUyYf/O9M7Lhjq7s4709kA5Q
         4W23BujJeZ2/r0vC6TeMEPEyYPjqYEfmrUC02RIBeAi2lWTEV2ybTw49jTgLR5RxgRPE
         z2ng==
X-Forwarded-Encrypted: i=1; AJvYcCUz5D66LXp+2Pwqq0pDqOKjPqe/GAfEBf3FtQoviRCFtSn8ytQFmljeedVVcWn8dwt4TEUDrDv0AVC7aao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyduHH+tCBYLMKoSvPbhKtvb0tkZV9I2Z3QIY0oTEg3k5D8MtDu
	jkaH4QYH8ieUz/ZHkzz0WY9z6ymZG/UoY2eUgZgMGg4yliG3EbLweEOb1DfgWrDnZ2DlsHq3THv
	FOxxjPvtbwHpT/q0TI5Jp0vbjws8=
X-Gm-Gg: ASbGncuFsDg6ibgK5BxmVfgpOsdMg12THWeZKMCuRYkePAjRqfYs4MgLwO4rLMuP7td
	cMQoMLX4ndt5YOUf8IzOj0qEdn2JfNs/L2niN1KBtZhFD2x/+hGvoMuvWpiHJVCUW0EEuIFEabz
	vEYPB39+jSeE5/eTBWWdH8aRJu0A==
X-Google-Smtp-Source: AGHT+IHN8O5OpTzZU49TK7paMaeNy/5cRAh7/eGnGuA3MPMyjnk0sSQeNE8QuVdqC681J0asdg6GZ9AdwPFpd4EXTWU=
X-Received: by 2002:a05:651c:544:b0:30b:c637:fcc3 with SMTP id
 38308e7fff4ca-30bd7a1e327mr24522161fa.6.1741271134841; Thu, 06 Mar 2025
 06:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305162649.130270-1-ubizjak@gmail.com> <1A02CCC5-8D03-44B0-A927-3BEC671C7744@zytor.com>
In-Reply-To: <1A02CCC5-8D03-44B0-A927-3BEC671C7744@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 15:25:34 +0100
X-Gm-Features: AQ5f1JqX8bwSa4ZqpmSYq2r0I4Gr-tMYR4UkQqMR4mkbQdqPaLkNFRzjMINBsbg
Message-ID: <CAFULd4a2wxyr_=j6S_3kBKdX3AbF-9fUEyXLjt_M8jwv6T3j0A@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Merge x86_32 and x86_64 code using macros from asm.h
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:14=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On March 5, 2025 8:26:37 AM PST, Uros Bizjak <ubizjak@gmail.com> wrote:
> >Merge common x86_32 and x86_64 code in crash_setup_regs()
> >using macros from asm/asm.h.
> >
> >The compiled object files before and after the patch are unchanged.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> > arch/x86/include/asm/asm.h   |  2 ++
> > arch/x86/include/asm/kexec.h | 44 +++++++++++++++---------------------
> > 2 files changed, 20 insertions(+), 26 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> >index 975ae7a9397e..2bccc063d30b 100644
> >--- a/arch/x86/include/asm/asm.h
> >+++ b/arch/x86/include/asm/asm.h
> >@@ -41,6 +41,8 @@
> > #define _ASM_SUB      __ASM_SIZE(sub)
> > #define _ASM_XADD     __ASM_SIZE(xadd)
> > #define _ASM_MUL      __ASM_SIZE(mul)
> >+#define _ASM_PUSHF    __ASM_SIZE(pushf)
> >+#define _ASM_POP      __ASM_SIZE(pop)
> >
> > #define _ASM_AX               __ASM_REG(ax)
> > #define _ASM_BX               __ASM_REG(bx)
> >diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> >index 8ad187462b68..56040ae6bda0 100644
> >--- a/arch/x86/include/asm/kexec.h
> >+++ b/arch/x86/include/asm/kexec.h
> >@@ -18,6 +18,7 @@
> > #include <linux/string.h>
> > #include <linux/kernel.h>
> >
> >+#include <asm/asm.h>
> > #include <asm/page.h>
> > #include <asm/ptrace.h>
> >
> >@@ -71,29 +72,15 @@ static inline void crash_setup_regs(struct pt_regs *=
newregs,
> >       if (oldregs) {
> >               memcpy(newregs, oldregs, sizeof(*newregs));
> >       } else {
> >-#ifdef CONFIG_X86_32
> >-              asm volatile("movl %%ebx,%0" : "=3Dm"(newregs->bx));
> >-              asm volatile("movl %%ecx,%0" : "=3Dm"(newregs->cx));
> >-              asm volatile("movl %%edx,%0" : "=3Dm"(newregs->dx));
> >-              asm volatile("movl %%esi,%0" : "=3Dm"(newregs->si));
> >-              asm volatile("movl %%edi,%0" : "=3Dm"(newregs->di));
> >-              asm volatile("movl %%ebp,%0" : "=3Dm"(newregs->bp));
> >-              asm volatile("movl %%eax,%0" : "=3Dm"(newregs->ax));
> >-              asm volatile("movl %%esp,%0" : "=3Dm"(newregs->sp));
> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
> >-              asm volatile("movl %%ds, %%eax;" :"=3Da"(newregs->ds));
> >-              asm volatile("movl %%es, %%eax;" :"=3Da"(newregs->es));
> >-              asm volatile("pushfl; popl %0" :"=3Dm"(newregs->flags));
> >-#else
> >-              asm volatile("movq %%rbx,%0" : "=3Dm"(newregs->bx));
> >-              asm volatile("movq %%rcx,%0" : "=3Dm"(newregs->cx));
> >-              asm volatile("movq %%rdx,%0" : "=3Dm"(newregs->dx));
> >-              asm volatile("movq %%rsi,%0" : "=3Dm"(newregs->si));
> >-              asm volatile("movq %%rdi,%0" : "=3Dm"(newregs->di));
> >-              asm volatile("movq %%rbp,%0" : "=3Dm"(newregs->bp));
> >-              asm volatile("movq %%rax,%0" : "=3Dm"(newregs->ax));
> >-              asm volatile("movq %%rsp,%0" : "=3Dm"(newregs->sp));
> >+              asm volatile(_ASM_MOV " %%" _ASM_BX ",%0" : "=3Dm"(newreg=
s->bx));
> >+              asm volatile(_ASM_MOV " %%" _ASM_CX ",%0" : "=3Dm"(newreg=
s->cx));
> >+              asm volatile(_ASM_MOV " %%" _ASM_DX ",%0" : "=3Dm"(newreg=
s->dx));
> >+              asm volatile(_ASM_MOV " %%" _ASM_SI ",%0" : "=3Dm"(newreg=
s->si));
> >+              asm volatile(_ASM_MOV " %%" _ASM_DI ",%0" : "=3Dm"(newreg=
s->di));
> >+              asm volatile(_ASM_MOV " %%" _ASM_BP ",%0" : "=3Dm"(newreg=
s->bp));
> >+              asm volatile(_ASM_MOV " %%" _ASM_AX ",%0" : "=3Dm"(newreg=
s->ax));
> >+              asm volatile(_ASM_MOV " %%" _ASM_SP ",%0" : "=3Dm"(newreg=
s->sp));
> >+#ifdef CONFIG_X86_64
> >               asm volatile("movq %%r8,%0" : "=3Dm"(newregs->r8));
> >               asm volatile("movq %%r9,%0" : "=3Dm"(newregs->r9));
> >               asm volatile("movq %%r10,%0" : "=3Dm"(newregs->r10));
> >@@ -102,10 +89,15 @@ static inline void crash_setup_regs(struct pt_regs =
*newregs,
> >               asm volatile("movq %%r13,%0" : "=3Dm"(newregs->r13));
> >               asm volatile("movq %%r14,%0" : "=3Dm"(newregs->r14));
> >               asm volatile("movq %%r15,%0" : "=3Dm"(newregs->r15));
> >-              asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
> >-              asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
> >-              asm volatile("pushfq; popq %0" :"=3Dm"(newregs->flags));
> > #endif
> >+              asm volatile("movl %%ss,%k0" :"=3Da"(newregs->ss));
> >+              asm volatile("movl %%cs,%k0" :"=3Da"(newregs->cs));
> >+#ifdef CONFIG_X86_32
> >+              asm volatile("movl %%ds,%k0" :"=3Da"(newregs->ds));
> >+              asm volatile("movl %%es,%k0" :"=3Da"(newregs->es));
> >+#endif
> >+              asm volatile(_ASM_PUSHF "\n\t"
> >+                           _ASM_POP " %0" : "=3Dm"(newregs->flags));
> >               newregs->ip =3D _THIS_IP_;
> >       }
> > }
>
> There is no reason to stick a size suffix on if it is unambiguous. Normal=
ly pushf/popf never are, since stack operations are promoted automatically.

Thanks, I'll provide a v2 with removed suffixes.

BR,
Uros.

