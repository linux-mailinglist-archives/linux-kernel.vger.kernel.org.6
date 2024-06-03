Return-Path: <linux-kernel+bounces-198656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E838D7BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE031F2259A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC457CBC;
	Mon,  3 Jun 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+54Dzaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2357880
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396763; cv=none; b=MFlefXGEBYL0taK6KlS5nBPRIhtGNIQgqilfzlS7C5Ko2OIJVMnScQRNugxUe4YLC8MPYqJ+2BLIjIBanQ+oqoH6IXxbGmlE+ivkR5hDt16sY8pKB+GMBFh7iM0xVu9Zs8KsuUD2+I/ocOLI6ozvcod0uycET4kw7+Dtcojw0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396763; c=relaxed/simple;
	bh=Vrnb3I/DwqFpG6G4q78KoUS0SQY8LiiwkDuZ3EKG3EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teNbliCzn8wkj7Z1iyjyXWW+6/3BM2X+zdcGO2iWeNbkGvRfBdEHEvCWSYaROGPuAzZKMlVDZdu8dN+ghmaq+850L62zr/pX1Wnx/SQ6zF5dqqCh9NOVQEz4hlREyoPSXSDTEa/KSygYpe0up6uTz74C8MbM94Nk2qfm7m1Fefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+54Dzaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDA1C4AF0A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717396763;
	bh=Vrnb3I/DwqFpG6G4q78KoUS0SQY8LiiwkDuZ3EKG3EA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O+54DzawxtrOIfuSemDq+MMq1kWZ67aEhrBUgbUjPaZLW+NC9cs2V39HtebUg1RFU
	 LBrVYyv8tjS845JLRk34JIg1J70eezd6aVygT0eLeR5a43x3AOzL+5btsNirCq814g
	 CeGKhSXaZSGoxMOwVX797q2eA0g090s6qgClbPcKlVuFripdmh5gwcenT8psG9v1bc
	 33+0D0HM/LQETbQM45E3NSkLgEaCU0wc8YlrI/juBo/NHgj3HhMO4XBNr8LzOsrMpQ
	 wIQwaNzS2oweYWsTXiEqRyGeNARKxnvQmnD0/HqfdImuxOm4ww+jvY4uxq3ASHaS37
	 5ovkU6A/E9r/g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe639a5so3943491a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKCKzrv6sz7XBTttewkixwhHPrl4MRYv+JhVqsovafvqvJzaSTsuEOj3rAQDaHZy1ZQCv2Pz041omIQwzD8oUPxfJumUaXSXhLF1GQ
X-Gm-Message-State: AOJu0YxnLQ2YXZI0nlx9O+DBsdIO+IkSFspM73N4xRhRPpsQruuoKR/5
	MTGWztVpPwrCbsvNs2R973adtav4Q9LvAblX2B/SIDiKj9JzLbb8pQeW9ipCNvmPFc0uqpeL4qU
	2dCKmcBsMXkuUP5VBMNf7DFa5u/g=
X-Google-Smtp-Source: AGHT+IEOEYVEkN2ZwRudlM4E5li6lcwTQrg4b9WMBXr5Sta3v9hSr9rcMF60C6H5FpUE88eso7vs6DDTzRa67aJZBUI=
X-Received: by 2002:a50:8e11:0:b0:579:c08b:afa9 with SMTP id
 4fb4d7f45d1cf-57a3636f725mr5803781a12.11.1717396761678; Sun, 02 Jun 2024
 23:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
 <ZYpO/pfbea7hWu3r@gmail.com> <CANtDSirRq0W7AhA8xi0c-3a7_e27RKHWbkK27AR9JhZfW+pTwg@mail.gmail.com>
In-Reply-To: <CANtDSirRq0W7AhA8xi0c-3a7_e27RKHWbkK27AR9JhZfW+pTwg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 3 Jun 2024 14:39:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSbFyr+cTQF7TNpN77Z9Fc8bB0X8=z0mfM027wFcRCvCg@mail.gmail.com>
Message-ID: <CAJF2gTSbFyr+cTQF7TNpN77Z9Fc8bB0X8=z0mfM027wFcRCvCg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Improve exception and system call latency
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: Anton Blanchard <antonb@tenstorrent.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 12:38=E2=80=AFPM Cyril Bur <cyrilbur@tenstorrent.com=
> wrote:
>
> [ apologies, I think my mailer is going to mess up the formatting ]
>
> On 26 Dec 2023, at 2:56=E2=80=AFPM, Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Dec 24, 2023 at 08:00:18PM -0800, Anton Blanchard wrote:
>
> Many CPUs implement return address branch prediction as a stack. The
> RISCV architecture refers to this as a return address stack (RAS). If
> this gets corrupted then the CPU will mispredict at least one but
> potentally many function returns.
>
> There are two issues with the current RISCV exception code:
>
> - We are using the alternate link stack (x5/t0) for the indirect branch
>  which makes the hardware think this is a function return. This will
>  corrupt the RAS.
>
> - We modify the return address of handle_exception to point to
>  ret_from_exception. This will also corrupt the RAS.
>
> Testing the null system call latency before and after the patch:
>
> Visionfive2 (StarFive JH7110 / U74)
> baseline: 189.87 ns
> patched:  176.76 ns
>
> Lichee pi 4a (T-Head TH1520 / C910)
> baseline: 666.58 ns
> patched:  636.90 ns
>
> Just over 7% on the U74 and just over 4% on the C910.
>
>
> Yes, the wrong "jalr zero, t0/ra" would pop RAS and destroy the RAS
> layout of the hardware for the userspace. How about giving a fake push
> for the RAS to connect "jalr zero, ra" of sub-function call return? I'm
> curious if you could measure the difference with only one RAS
> misprediction.
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..94c7d2be35d0 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -93,7 +93,8 @@ SYM_CODE_START(handle_exception)
>        bge s4, zero, 1f
>
>        /* Handle interrupts */
> -       tail do_irq
> +       auipc t0, do_irq
> +       jalr  t0, t0
> 1:
>        /* Handle other exceptions */
>        slli t0, s4, RISCV_LGPTR
> @@ -103,9 +104,10 @@ SYM_CODE_START(handle_exception)
>        /* Check if exception code lies within bounds */
>        bgeu t0, t2, 1f
>        REG_L t0, 0(t0)
> -       jr t0
> +       jalr t0, t0
> 1:
> -       tail do_trap_unknown
> +       auipc t0, do_trap_unknown
> +       jalr  t0, t0
> SYM_CODE_END(handle_exception)
>
> You could prepare a deeper userspace stack calling if you want better
> measurement results.
>
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>
> This introduces some complexity in the stackframe walk code. PowerPC
> resolves the multiple exception exit paths issue by placing a value into
> the exception stack frame (basically the word "REGS") that the stack fram=
e
> code can look for. Perhaps something to look at.
>
> arch/riscv/kernel/entry.S      | 21 ++++++++++++++-------
> arch/riscv/kernel/stacktrace.c | 14 +++++++++++++-
> 2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..89af35edbf6c 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
> scs_load_current_if_task_changed s5
>
> move a0, sp /* pt_regs */
> - la ra, ret_from_exception
>
> /*
> * MSB of cause differentiates between
> @@ -93,7 +92,10 @@ SYM_CODE_START(handle_exception)
> bge s4, zero, 1f
>
> /* Handle interrupts */
> - tail do_irq
> + call do_irq
> +.globl ret_from_irq_exception
> +ret_from_irq_exception:
> + j ret_from_exception
> 1:
> /* Handle other exceptions */
> slli t0, s4, RISCV_LGPTR
> @@ -101,11 +103,16 @@ SYM_CODE_START(handle_exception)
> la t2, excp_vect_table_end
> add t0, t1, t0
> /* Check if exception code lies within bounds */
> - bgeu t0, t2, 1f
> - REG_L t0, 0(t0)
> - jr t0
> -1:
> - tail do_trap_unknown
> + bgeu t0, t2, 3f
> + REG_L t1, 0(t0)
> +2: jalr ra,t1
> +.globl ret_from_other_exception
> +ret_from_other_exception:
> + j ret_from_exception
> +3:
> +
> + la t1, do_trap_unknown
> + j 2b
> SYM_CODE_END(handle_exception)
>
> /*
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 64a9c093aef9..b9cd131bbc4c 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -17,6 +17,18 @@
> #ifdef CONFIG_FRAME_POINTER
>
> extern asmlinkage void ret_from_exception(void);
> +extern asmlinkage void ret_from_irq_exception(void);
> +extern asmlinkage void ret_from_other_exception(void);
> +
> +static inline bool is_exception_frame(unsigned long pc)
> +{
> + if ((pc =3D=3D (unsigned long)ret_from_exception) ||
> +    (pc =3D=3D (unsigned long)ret_from_irq_exception) ||
> +    (pc =3D=3D (unsigned long)ret_from_other_exception))
> + return true;
> +
> + return false;
> +}
>
> We needn't put too many .globl in the entry.S, and just check that pc is
> in SYM_CODE_START/END(handle_exception), then entry.S would be cleaner:
>
> Hi Guo,
>
> I've taken this patch over from Anton, mostly just to tidy it up. I'd
> like to incorporate
> what you mention here but I'm not sure how to achieve it. Have I
> missed something
> obvious? As things currently stand there doesn't seem to be a way to get =
the end
> (or size) of handle_exception in C code.
"just check that pc is in SYM_CODE_START/END(handle_exception)."
Sorry, I think my previous description is wrong.

Instead, "We needn't modify anything in stacktrace.c because we keep
ra =3D ret_from_exception."

I want only cleaner and smaller modifications to the entry.S to
satisfy RAS prediction performance requirements.


>
> Your advice is greatly appreciated,
>
> Thanks,
>
> Cyril
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..d452d5f12b1b 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -84,7 +84,6 @@ SYM_CODE_START(handle_exception)
>        scs_load_current_if_task_changed s5
>
>        move a0, sp /* pt_regs */
>
>        /*
>         * MSB of cause differentiates between
> @@ -93,7 +92,8 @@ SYM_CODE_START(handle_exception)
>        bge s4, zero, 1f
>
>        /* Handle interrupts */
>        call do_irq
>        j ret_from_exception
> 1:
>        /* Handle other exceptions */
>        slli t0, s4, RISCV_LGPTR
> @@ -102,10 +102,12 @@ SYM_CODE_START(handle_exception)
>        add t0, t1, t0
>        /* Check if exception code lies within bounds */
>        bgeu t0, t2, 1f
>        REG_L ra, 0(t0)
>        jalr ra, ra
>        j ret_from_exception
> 1:
>        call do_trap_unknown
>        j ret_from_exception
> SYM_CODE_END(handle_exception)
>
>
>
> void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re=
gs,
>     bool (*fn)(void *, unsigned long), void *arg)
> @@ -62,7 +74,7 @@ void notrace walk_stackframe(struct task_struct
> *task, struct pt_regs *regs,
> fp =3D frame->fp;
> pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
>   &frame->ra);
> - if (pc =3D=3D (unsigned long)ret_from_exception) {
> + if (is_exception_frame(pc)) {
> if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> break;
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren

