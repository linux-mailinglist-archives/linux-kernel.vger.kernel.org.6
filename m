Return-Path: <linux-kernel+bounces-200232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EC8FAD48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575961F21A78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558722075;
	Tue,  4 Jun 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="J3pjHbmj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7113FD6A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488959; cv=none; b=IJXKwJgXWogM/lWl1mG1U/eIF2MSsqnfuX1o/MHbAFrWEe2KHnMTjYJ/JtMtJ6LStV1lYAra3ir0ZLw98Uu9N2D+Tzr209ttE6XWj40DEp3/lUUy7MVoMOxyl6eE8MgxvG7OhLggUrTToHNSWXfRAI1wNNaIYN2CB0FZI4iApEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488959; c=relaxed/simple;
	bh=SndplPGoZPTXQMK2aPyhPBgeYM+E8Ks/zRcGbfcYphI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIamskWAqqi8oKyMByN6RGpLgePoWuSE5LG5pu1gidDIwLUFchi7//MXauJqJrDS+5TINXNBRzx5GJpI8Qer7rtSU1CfE5U8B2TozGjRBWDc3LGwSlx7FTtGavVncRVEi77hOhj6LeGVSDLT4/narmtxnXdZgTMZPioScelvhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=J3pjHbmj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c21571e99bso338856a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1717488955; x=1718093755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsZryEekvAWSSlH3fVKBvOISsbOQXTnZ3xcDSA8wrT4=;
        b=J3pjHbmjqw8lUe0wJb4uulrpu6P1jcxtF5W8p32azuNIWsxgwuXrKLw+/Vu+AaEqOb
         0LVG1dAaJeD4pdQQ7euz2qPxa8LRsWY4O6nPM13y/PSwa1vlNeTQPsDv5kLcdh8uIa/O
         FymtwXdNh7ULo2SGDKB+dVU0cm0FIPUoGq416/beKSE6ygD63psTUZxvKWJsy/iAQe4N
         yKqZeekqnIZQCHT7NzTfApHMBPXZlUqWKHaGpLyIo8lcWgdt0279MCxI6s1kOwI59t3i
         NuaxBZq23c3HE2Si7/XfRuLS90ahYM26jMdHBQpNsjni5mu3xhP78vMLFxa/QBUYF/Ju
         dh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488955; x=1718093755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsZryEekvAWSSlH3fVKBvOISsbOQXTnZ3xcDSA8wrT4=;
        b=sK2tDuKQUjPsNwJUb9iUAU0RxKHUUaxCTAYPpuDDnorl343lXMZDmbZsmZ4Tt/5wBC
         iIt/uMssmAPB9XNDwyhsGq6bcRPHBqLv+btBfPOf9YZviInOy1pBkeNiTpdDdEs8ErrY
         txydJ694AbRX5BBBTeGiVcsLxR0nlciBxSgsD5Q8hERD0Hu0OG7N6iIDd8Nsz9nng211
         N6SSt7goK+KeJ1qVAD6MAx0Si7o6k/dt9+/0In/2dJFwGeTkFX3bZEDX5NHGz7JwBXsY
         u/jOwKMGbjt9/UeRyu++RxwdoHEpENNL1Xo5Y9r0n7AE+VF8vBcQZGdSyKlurblXxE3e
         0Ekg==
X-Forwarded-Encrypted: i=1; AJvYcCWUJZ4nHKMMNzpsyLJZNGrdeN6EDMQju1ZWTZbdukpYdETpWDg5aIOyON5LsRHRaERq8kF1AO/RO5SiRjijRdWTK3gMkgO7Pj08XL1I
X-Gm-Message-State: AOJu0Yx+8fGjDvmMMzgewuyWX3nfNYN6uSCLn99R/3IX7JpZpx+G5zl1
	4ghCHuaRMK5Z1tiDU0e/3KgLfYdB9mvb2T55P0VNGcvb0Ueb8OnMk5PJT0srK4NfL5Tk9vGGRJl
	8NMZAV+kv9kWbE9J8B3fIT/BpFrTMRiYrf0pA
X-Google-Smtp-Source: AGHT+IGzvuU7YbOXxvZdr/muOe8OGLau/aPzsmRY72G+zWLAPglcRbF2mCE4k8FYqjA5/oVy1obgQ1ozO7RDNmiQDQE=
X-Received: by 2002:a17:90b:19c9:b0:2bd:e950:dfa5 with SMTP id
 98e67ed59e1d1-2c253f10e2bmr1479864a91.2.1717488954705; Tue, 04 Jun 2024
 01:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
 <ZYpO/pfbea7hWu3r@gmail.com> <CANtDSirRq0W7AhA8xi0c-3a7_e27RKHWbkK27AR9JhZfW+pTwg@mail.gmail.com>
 <CAJF2gTSbFyr+cTQF7TNpN77Z9Fc8bB0X8=z0mfM027wFcRCvCg@mail.gmail.com>
In-Reply-To: <CAJF2gTSbFyr+cTQF7TNpN77Z9Fc8bB0X8=z0mfM027wFcRCvCg@mail.gmail.com>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Tue, 4 Jun 2024 18:15:43 +1000
Message-ID: <CANtDSiq=ObDBA+NfPcmUAmpokZ-fGjX-2VW2KsUTaEO+yoq1Tw@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] riscv: Improve exception
 and system call latency
To: Guo Ren <guoren@kernel.org>
Cc: Anton Blanchard <antonb@tenstorrent.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:39=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Jun 3, 2024 at 12:38=E2=80=AFPM Cyril Bur <cyrilbur@tenstorrent.c=
om> wrote:
> >
> > [ apologies, I think my mailer is going to mess up the formatting ]
> >
> > On 26 Dec 2023, at 2:56=E2=80=AFPM, Guo Ren <guoren@kernel.org> wrote:
> >
> > On Sun, Dec 24, 2023 at 08:00:18PM -0800, Anton Blanchard wrote:
> >
> > Many CPUs implement return address branch prediction as a stack. The
> > RISCV architecture refers to this as a return address stack (RAS). If
> > this gets corrupted then the CPU will mispredict at least one but
> > potentally many function returns.
> >
> > There are two issues with the current RISCV exception code:
> >
> > - We are using the alternate link stack (x5/t0) for the indirect branch
> >  which makes the hardware think this is a function return. This will
> >  corrupt the RAS.
> >
> > - We modify the return address of handle_exception to point to
> >  ret_from_exception. This will also corrupt the RAS.
> >
> > Testing the null system call latency before and after the patch:
> >
> > Visionfive2 (StarFive JH7110 / U74)
> > baseline: 189.87 ns
> > patched:  176.76 ns
> >
> > Lichee pi 4a (T-Head TH1520 / C910)
> > baseline: 666.58 ns
> > patched:  636.90 ns
> >
> > Just over 7% on the U74 and just over 4% on the C910.
> >
> >
> > Yes, the wrong "jalr zero, t0/ra" would pop RAS and destroy the RAS
> > layout of the hardware for the userspace. How about giving a fake push
> > for the RAS to connect "jalr zero, ra" of sub-function call return? I'm
> > curious if you could measure the difference with only one RAS
> > misprediction.
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 54ca4564a926..94c7d2be35d0 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -93,7 +93,8 @@ SYM_CODE_START(handle_exception)
> >        bge s4, zero, 1f
> >
> >        /* Handle interrupts */
> > -       tail do_irq
> > +       auipc t0, do_irq
> > +       jalr  t0, t0
> > 1:
> >        /* Handle other exceptions */
> >        slli t0, s4, RISCV_LGPTR
> > @@ -103,9 +104,10 @@ SYM_CODE_START(handle_exception)
> >        /* Check if exception code lies within bounds */
> >        bgeu t0, t2, 1f
> >        REG_L t0, 0(t0)
> > -       jr t0
> > +       jalr t0, t0
> > 1:
> > -       tail do_trap_unknown
> > +       auipc t0, do_trap_unknown
> > +       jalr  t0, t0
> > SYM_CODE_END(handle_exception)
> >
> > You could prepare a deeper userspace stack calling if you want better
> > measurement results.
> >
> >
> > Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> > Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >
> > This introduces some complexity in the stackframe walk code. PowerPC
> > resolves the multiple exception exit paths issue by placing a value int=
o
> > the exception stack frame (basically the word "REGS") that the stack fr=
ame
> > code can look for. Perhaps something to look at.
> >
> > arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
> > arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
> > 2 files changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 54ca4564a926..89af35edbf6c 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
> > scs_load_current_if_task_changed s5
> >
> > move a0, sp /* pt_regs */
> > - la ra, ret_from_exception
> >
> > /*
> > * MSB of cause differentiates between
> > @@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
> > bge s4, zero, 1f
> >
> > /* Handle interrupts */
> > - tail do_irq
> > + call do_irq
> > +.globl ret_from_irq_exception
> > +ret_from_irq_exception:
> > + j ret_from_exception
> > 1:
> > /* Handle other exceptions */
> > slli t0, s4, RISCV_LGPTR
> > @@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
> > la t2, excp_vect_table_end
> > add t0, t1, t0
> > /* Check if exception code lies within bounds */
> > - bgeu t0, t2, 1f
> > - REG_L t0, 0(t0)
> > - jr t0
> > -1:
> > - tail do_trap_unknown
> > + bgeu t0, t2, 3f
> > + REG_L t1, 0(t0)
> > +2: jalr ra,t1
> > +.globl ret_from_other_exception
> > +ret_from_other_exception:
> > + j ret_from_exception
> > +3:
> > +
> > + la t1, do_trap_unknown
> > + j 2b
> > SYM_CODE_END(handle_exception)
> >
> > /*
> > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktr=
ace.c
> > index 64a9c093aef9..b9cd131bbc4c 100644
> > --- a/arch/riscv/kernel/stacktrace.c
> > +++ b/arch/riscv/kernel/stacktrace.c
> > @@ -17,6 +17,18 @@
> > #ifdef CONFIG_FRAME_POINTER
> >
> > extern asmlinkage void ret_from_exception(void);
> > +extern asmlinkage void ret_from_irq_exception(void);
> > +extern asmlinkage void ret_from_other_exception(void);
> > +
> > +static inline bool is_exception_frame(unsigned long pc)
> > +{
> > + if ((pc =3D=3D (unsigned long)ret_from_exception) ||
> > +    (pc =3D=3D (unsigned long)ret_from_irq_exception) ||
> > +    (pc =3D=3D (unsigned long)ret_from_other_exception))
> > + return true;
> > +
> > + return false;
> > +}
> >
> > We needn't put too many .globl in the entry.S, and just check that pc i=
s
> > in SYM_CODE_START/END(handle_exception), then entry.S would be cleaner:
> >
> > Hi Guo,
> >
> > I've taken this patch over from Anton, mostly just to tidy it up. I'd
> > like to incorporate
> > what you mention here but I'm not sure how to achieve it. Have I
> > missed something
> > obvious? As things currently stand there doesn't seem to be a way to ge=
t the end
> > (or size) of handle_exception in C code.
> "just check that pc is in SYM_CODE_START/END(handle_exception)."
> Sorry, I think my previous description is wrong.
>
> Instead, "We needn't modify anything in stacktrace.c because we keep
> ra =3D ret_from_exception."
>
> I want only cleaner and smaller modifications to the entry.S to
> satisfy RAS prediction performance requirements.
>

I completely agree with keeping entry.S as clean as possible.

I'm trying to understand what you mean.
Isn't the point of the patch to remove ra =3D ret_from_exception?

I'm not sure but maybe we can leave entry.S as it is and the check in
stacktrace.c can become a check for pc =3D=3D handle_exception?

>
> >
> > Your advice is greatly appreciated,
> >
> > Thanks,
> >
> > Cyril
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 54ca4564a926..d452d5f12b1b 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
> >        scs_load_current_if_task_changed s5
> >
> >        move a0, sp /* pt_regs */
> >
> >        /*
> >         * MSB of cause differentiates between
> > @@ -93,7 +92,8 @@ SYM_CODE_START(handle_exception)
> >        bge s4, zero, 1f
> >
> >        /* Handle interrupts */
> >        call do_irq
> >        j ret_from_exception
> > 1:
> >        /* Handle other exceptions */
> >        slli t0, s4, RISCV_LGPTR
> > @@ -102,10 +102,12 @@ SYM_CODE_START(handle_exception)
> >        add t0, t1, t0
> >        /* Check if exception code lies within bounds */
> >        bgeu t0, t2, 1f
> >        REG_L ra, 0(t0)
> >        jalr ra, ra
> >        j ret_from_exception
> > 1:
> >        call do_trap_unknown
> >        j ret_from_exception
> > SYM_CODE_END(handle_exception)
> >
> >
> >
> > void notrace walk_stackframe(struct task_struct *task, struct pt_regs *=
regs,
> >     bool (*fn)(void *, unsigned long), void *arg)
> > @@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct
> > *task, struct pt_regs *regs,
> > fp =3D frame->fp;
> > pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
> >   &frame->ra);
> > - if (pc =3D=3D (unsigned long)ret_from_exception) {
> > + if (is_exception_frame(pc)) {
> > if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> > break;
> >
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Best Regards
>  Guo Ren

