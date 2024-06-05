Return-Path: <linux-kernel+bounces-201788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7DE8FC32C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3974D284D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4821C17F;
	Wed,  5 Jun 2024 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkUPASzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9E946C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566833; cv=none; b=mKgNIMDg7xqUeGXa0YFvwqx0blr3F5ryPi/gHbXd41v+0uy1citd9lI8YcQAspR96pNfj3Q6TQkUyFaZPnclD6k4IJotInQK3byI4i7kc45kYVzwyrhnOThelz9P1zqj4JxtdMxBd+PCWyMsS+FkX9V4YlePuMWVSt8nXWZikyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566833; c=relaxed/simple;
	bh=W7PnTAgacSEV8uyi8cZJK5JCVN0QWoKEfkOy50GD4O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMm8M3nlNTRtbDS7o4jLvud+24YYFp6efqfykaBDkGZYhXBzuboAb2wwB2Ee6B2GYX8zcjEKRG8/8kbLZ2WY/UjroAKFcUS3U/yIgy+d9rCfPmMZjaAb6WHqGuWZwFYBVOjDAXlr7/pX62GMLlLAzYq7tD3piJXTJ0uXiuv/NWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkUPASzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB45C32782
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717566833;
	bh=W7PnTAgacSEV8uyi8cZJK5JCVN0QWoKEfkOy50GD4O0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EkUPASztknC5+qV1/N4ikL8l10bkT38hSLbmfdjFFWtBKIp3kRGoevcpa+7LEH5EM
	 276HeIhvbB8mSGHkuvOznYV+Jb+QsqOlP9i3m06x4T0ChXty3kQRIaunQK8IO1BWzr
	 6aZz8f6FZV9SAxFM4RT5jG97nCnFxJiFMqfCNQziVUu14S0i4SjtazwE0RrHzSc51J
	 30c8sXTIa1gWOeKIy/hn1gUz3nO+oCaE1BYiTn4PuoK4DU2wzCk41QmpzLt//r1Ok6
	 vVLUrMiERC1IYEygPfLqqHXasvZ4IRprSlNPPWoJUNB9HEUcib4cprDe3ywfxIhUw1
	 CFXz3kwkII+Iw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b936c958dso4560361e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:53:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwsz65RkZ08hl7X/2Yp3HlU3eMMfXLdagcERDz633FCB8xNJlB7M+kuNz29OOwhdgY2gSx9MbECItvlk7+RXYk9FUiMvVXjS0VsavS
X-Gm-Message-State: AOJu0YwDZSUILcpDb/JERiIV2i8YmyLCbw9XbvzoastmK3Vtlr8KDy8I
	l/0gLbOJKnCGNsEwwdgWGwvGQnRPSzWfm7FP8sBcH1n2rPvFFnMcQM8V+hw474rE3QwZfYwiuv6
	IYny45i6B5aTthcOasiZNSIk3++E=
X-Google-Smtp-Source: AGHT+IEemJksw/e8Gxxe1S/+YayCPfKhMDWdn69xycFCzqMnykeiDmtI0rn3CaFfK6Y9lUj7AXwYo/rfGfhbX0FEf+E=
X-Received: by 2002:a05:6512:33d1:b0:51d:9ce:c282 with SMTP id
 2adb3069b0e04-52bab4f77b5mr902714e87.46.1717566831340; Tue, 04 Jun 2024
 22:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
 <ZYpO/pfbea7hWu3r@gmail.com> <CANtDSirRq0W7AhA8xi0c-3a7_e27RKHWbkK27AR9JhZfW+pTwg@mail.gmail.com>
 <CAJF2gTSbFyr+cTQF7TNpN77Z9Fc8bB0X8=z0mfM027wFcRCvCg@mail.gmail.com>
 <CANtDSiq=ObDBA+NfPcmUAmpokZ-fGjX-2VW2KsUTaEO+yoq1Tw@mail.gmail.com> <CAJF2gTRCGLyAr9SDPjxoC=dXaPtnRURahrQi2F_ZKy2NqaCPKA@mail.gmail.com>
In-Reply-To: <CAJF2gTRCGLyAr9SDPjxoC=dXaPtnRURahrQi2F_ZKy2NqaCPKA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 5 Jun 2024 13:53:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRKYe5R-xawsWVFWSPY1n7zxFbGrdgB6NMAC+kPn6uEZw@mail.gmail.com>
Message-ID: <CAJF2gTRKYe5R-xawsWVFWSPY1n7zxFbGrdgB6NMAC+kPn6uEZw@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] riscv: Improve exception
 and system call latency
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: Anton Blanchard <antonb@tenstorrent.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:52=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Jun 4, 2024 at 4:16=E2=80=AFPM Cyril Bur <cyrilbur@tenstorrent.co=
m> wrote:
> >
> > On Mon, Jun 3, 2024 at 4:39=E2=80=AFPM Guo Ren <guoren@kernel.org> wrot=
e:
> > >
> > > On Mon, Jun 3, 2024 at 12:38=E2=80=AFPM Cyril Bur <cyrilbur@tenstorre=
nt.com> wrote:
> > > >
> > > > [ apologies, I think my mailer is going to mess up the formatting ]
> > > >
> > > > On 26 Dec 2023, at 2:56=E2=80=AFPM, Guo Ren <guoren@kernel.org> wro=
te:
> > > >
> > > > On Sun, Dec 24, 2023 at 08:00:18PM -0800, Anton Blanchard wrote:
> > > >
> > > > Many CPUs implement return address branch prediction as a stack. Th=
e
> > > > RISCV architecture refers to this as a return address stack (RAS). =
If
> > > > this gets corrupted then the CPU will mispredict at least one but
> > > > potentally many function returns.
> > > >
> > > > There are two issues with the current RISCV exception code:
> > > >
> > > > - We are using the alternate link stack (x5/t0) for the indirect br=
anch
> > > >  which makes the hardware think this is a function return. This wil=
l
> > > >  corrupt the RAS.
> > > >
> > > > - We modify the return address of handle_exception to point to
> > > >  ret_from_exception. This will also corrupt the RAS.
> > > >
> > > > Testing the null system call latency before and after the patch:
> > > >
> > > > Visionfive2 (StarFive JH7110 / U74)
> > > > baseline: 189.87 ns
> > > > patched:  176.76 ns
> > > >
> > > > Lichee pi 4a (T-Head TH1520 / C910)
> > > > baseline: 666.58 ns
> > > > patched:  636.90 ns
> > > >
> > > > Just over 7% on the U74 and just over 4% on the C910.
> > > >
> > > >
> > > > Yes, the wrong "jalr zero, t0/ra" would pop RAS and destroy the RAS
> > > > layout of the hardware for the userspace. How about giving a fake p=
ush
> > > > for the RAS to connect "jalr zero, ra" of sub-function call return?=
 I'm
> > > > curious if you could measure the difference with only one RAS
> > > > misprediction.
> > > >
> > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > > index 54ca4564a926..94c7d2be35d0 100644
> > > > --- a/arch/riscv/kernel/entry.S
> > > > +++ b/arch/riscv/kernel/entry.S
> > > > @@ -93,7 +93,8 @@ SYM_CODE_START(handle_exception)
> > > >        bge s4, zero, 1f
> > > >
> > > >        /* Handle interrupts */
> > > > -       tail do_irq
> > > > +       auipc t0, do_irq
> > > > +       jalr  t0, t0
> > > > 1:
> > > >        /* Handle other exceptions */
> > > >        slli t0, s4, RISCV_LGPTR
> > > > @@ -103,9 +104,10 @@ SYM_CODE_START(handle_exception)
> > > >        /* Check if exception code lies within bounds */
> > > >        bgeu t0, t2, 1f
> > > >        REG_L t0, 0(t0)
> > > > -       jr t0
> > > > +       jalr t0, t0
> > > > 1:
> > > > -       tail do_trap_unknown
> > > > +       auipc t0, do_trap_unknown
> > > > +       jalr  t0, t0
> > > > SYM_CODE_END(handle_exception)
> > > >
> > > > You could prepare a deeper userspace stack calling if you want bett=
er
> > > > measurement results.
> > > >
> > > >
> > > > Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> > > > Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >
> > > > This introduces some complexity in the stackframe walk code. PowerP=
C
> > > > resolves the multiple exception exit paths issue by placing a value=
 into
> > > > the exception stack frame (basically the word "REGS") that the stac=
k frame
> > > > code can look for. Perhaps something to look at.
> > > >
> > > > arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
> > > > arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
> > > > 2 files changed, 27 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > > index 54ca4564a926..89af35edbf6c 100644
> > > > --- a/arch/riscv/kernel/entry.S
> > > > +++ b/arch/riscv/kernel/entry.S
> > > > @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
> > > > scs_load_current_if_task_changed s5
> > > >
> > > > move a0, sp /* pt_regs */
> > > > - la ra, ret_from_exception
> > > >
> > > > /*
> > > > * MSB of cause differentiates between
> > > > @@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
> > > > bge s4, zero, 1f
> > > >
> > > > /* Handle interrupts */
> > > > - tail do_irq
> > > > + call do_irq
> > > > +.globl ret_from_irq_exception
> > > > +ret_from_irq_exception:
> > > > + j ret_from_exception
> > > > 1:
> > > > /* Handle other exceptions */
> > > > slli t0, s4, RISCV_LGPTR
> > > > @@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
> > > > la t2, excp_vect_table_end
> > > > add t0, t1, t0
> > > > /* Check if exception code lies within bounds */
> > > > - bgeu t0, t2, 1f
> > > > - REG_L t0, 0(t0)
> > > > - jr t0
> > > > -1:
> > > > - tail do_trap_unknown
> > > > + bgeu t0, t2, 3f
> > > > + REG_L t1, 0(t0)
> > > > +2: jalr ra,t1
> > > > +.globl ret_from_other_exception
> > > > +ret_from_other_exception:
> > > > + j ret_from_exception
> > > > +3:
> > > > +
> > > > + la t1, do_trap_unknown
> > > > + j 2b
> > > > SYM_CODE_END(handle_exception)
> > > >
> > > > /*
> > > > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/sta=
cktrace.c
> > > > index 64a9c093aef9..b9cd131bbc4c 100644
> > > > --- a/arch/riscv/kernel/stacktrace.c
> > > > +++ b/arch/riscv/kernel/stacktrace.c
> > > > @@ -17,6 +17,18 @@
> > > > #ifdef CONFIG_FRAME_POINTER
> > > >
> > > > extern asmlinkage void ret_from_exception(void);
> > > > +extern asmlinkage void ret_from_irq_exception(void);
> > > > +extern asmlinkage void ret_from_other_exception(void);
> > > > +
> > > > +static inline bool is_exception_frame(unsigned long pc)
> > > > +{
> > > > + if ((pc =3D=3D (unsigned long)ret_from_exception) ||
> > > > +    (pc =3D=3D (unsigned long)ret_from_irq_exception) ||
> > > > +    (pc =3D=3D (unsigned long)ret_from_other_exception))
> > > > + return true;
> > > > +
> > > > + return false;
> > > > +}
> > > >
> > > > We needn't put too many .globl in the entry.S, and just check that =
pc is
> > > > in SYM_CODE_START/END(handle_exception), then entry.S would be clea=
ner:
> > > >
> > > > Hi Guo,
> > > >
> > > > I've taken this patch over from Anton, mostly just to tidy it up. I=
'd
> > > > like to incorporate
> > > > what you mention here but I'm not sure how to achieve it. Have I
> > > > missed something
> > > > obvious? As things currently stand there doesn't seem to be a way t=
o get the end
> > > > (or size) of handle_exception in C code.
> > > "just check that pc is in SYM_CODE_START/END(handle_exception)."
> > > Sorry, I think my previous description is wrong.
> > >
> > > Instead, "We needn't modify anything in stacktrace.c because we keep
> > > ra =3D ret_from_exception."
> > >
> > > I want only cleaner and smaller modifications to the entry.S to
> > > satisfy RAS prediction performance requirements.
> > >
> >
> > I completely agree with keeping entry.S as clean as possible.
> >
> > I'm trying to understand what you mean.
> > Isn't the point of the patch to remove ra =3D ret_from_exception?
> >
> > I'm not sure but maybe we can leave entry.S as it is and the check in
> > stacktrace.c can become a check for pc =3D=3D handle_exception?
> Yes, we needn't modify stacktrace.c anymore. Because we still keep "ra
> =3D handle_exception".
Sorry for the typo. "ra =3D ret_from_exception."
>
> >
> > >
> > > >
> > > > Your advice is greatly appreciated,
> > > >
> > > > Thanks,
> > > >
> > > > Cyril
> > > >
> > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > > index 54ca4564a926..d452d5f12b1b 100644
> > > > --- a/arch/riscv/kernel/entry.S
> > > > +++ b/arch/riscv/kernel/entry.S
> > > > @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
> > > >        scs_load_current_if_task_changed s5
> > > >
> > > >        move a0, sp /* pt_regs */
> > > >
> > > >        /*
> > > >         * MSB of cause differentiates between
> > > > @@ -93,7 +92,8 @@ SYM_CODE_START(handle_exception)
> > > >        bge s4, zero, 1f
> > > >
> > > >        /* Handle interrupts */
> > > >        call do_irq
> > > >        j ret_from_exception
> > > > 1:
> > > >        /* Handle other exceptions */
> > > >        slli t0, s4, RISCV_LGPTR
> > > > @@ -102,10 +102,12 @@ SYM_CODE_START(handle_exception)
> > > >        add t0, t1, t0
> > > >        /* Check if exception code lies within bounds */
> > > >        bgeu t0, t2, 1f
> > > >        REG_L ra, 0(t0)
> > > >        jalr ra, ra
> > > >        j ret_from_exception
> > > > 1:
> > > >        call do_trap_unknown
> > > >        j ret_from_exception
> > > > SYM_CODE_END(handle_exception)
> > > >
> > > >
> > > >
> > > > void notrace walk_stackframe(struct task_struct *task, struct pt_re=
gs *regs,
> > > >     bool (*fn)(void *, unsigned long), void *arg)
> > > > @@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct
> > > > *task, struct pt_regs *regs,
> > > > fp =3D frame->fp;
> > > > pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
> > > >   &frame->ra);
> > > > - if (pc =3D=3D (unsigned long)ret_from_exception) {
> > > > + if (is_exception_frame(pc)) {
> > > > if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> > > > break;
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren

