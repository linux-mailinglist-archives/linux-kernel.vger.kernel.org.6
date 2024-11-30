Return-Path: <linux-kernel+bounces-426206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724959DF042
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE564B21A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2D1865EF;
	Sat, 30 Nov 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8IISfEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDEAD23
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732968164; cv=none; b=ss3kKSol2/cnX5aPC0yNap/76cOg1coGLRJBCWE7NFahbTzzQi0iNayxx+iLLpMZt6PIARYbtOeSSR/3bM9xDtf1cO0vcgd8hvQ7+ZgRyT9L7lmfPPl452uXEogHwy0a2K7QDe6f6C91IOwsfKqt6vtYK+jEubh/jWVXsZg4tJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732968164; c=relaxed/simple;
	bh=GgGrVsRLF8fDG+0XdVVSFInWrE2wLo1WfnjdtdLWP5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUAhK5N4C4bHe7QZWHUhm4AuVLAvW4MJX0PKGfZYecoofL2Ozho3klJIZL+1naIc/2wNB0d/7KYKWakBI9lIsV9qDwYue4hHth3dclZnI+3ssFIlGPiRR1Yj2zR9JsXWuTPnjn4YWqfhkPSsLDz5z/kWDRCauF6A8Ve6J9cwx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8IISfEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE0AC4CED4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732968163;
	bh=GgGrVsRLF8fDG+0XdVVSFInWrE2wLo1WfnjdtdLWP5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X8IISfEztJIUm2uQqPem03pS5E+CwTpxZuzuuFt86uI1vZWV2oiUueCx7N5OnIlG0
	 RtaYVJCpmixzkXqYdRqmnLz4ai5kM28bptgDfGdIbuvE7Ulxg+t5mUnuesQlZSA1wV
	 oCmRuhkl+lMVzVhWZ/scS+obwRuwycp3SqcH2WX7AFzYV2g7viDf1rOUjq3RXGupYF
	 GLoYMznBtl/ugn42G90MpFeSZjSPxn/BJTeMDL5oLDozGmNbCMOs5dIRicJ6DocNpw
	 828GXJ0/KQbAbVwzn6DdG2pee5Ah3bhd4zGMISkUlLw42kxDw8Z16kyxM9VdObj7op
	 pGa0U+bHPIqjw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa545dc7105so383155266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:02:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWflgDTlJJNg2CWu6aKszvj05dVoVx5qkK/mn+tcLy2/iNOc8qsUbztk2cRNcPgn83U7bO8iZR2986K/rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWMcrkBCukGYIwiDd8KAmuq4ZshqI8dwMcePIoxvYpWFTKui3
	bYLM5sDcmIPeTzZEKQ0F+BOMsbtvs0xYMzFfLfYyrh0fzFb9TmxKTmxYSRjTJlpoTrkjL/evbEb
	oAhxWweLx2ojWap9SU71EAh/7CVs=
X-Google-Smtp-Source: AGHT+IElNoz63sGR/Pr4Z1XCmisV3hHaR8F2E8tfX0E8rj8MuwA54HL0IKQaN4Xo1LICAO/r1/m+rxVBZKe+e1HfcZk=
X-Received: by 2002:a17:907:7846:b0:aa5:2573:e38c with SMTP id
 a640c23a62f3a-aa580f178a6mr1069566666b.16.1732968161835; Sat, 30 Nov 2024
 04:02:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130115355.3316160-1-guoren@kernel.org>
In-Reply-To: <20241130115355.3316160-1-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 30 Nov 2024 20:02:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQhfr-wsj2VZwwP7sWq=yp9HtT_kzzr68xh1VpKLSbybQ@mail.gmail.com>
Message-ID: <CAJF2gTQhfr-wsj2VZwwP7sWq=yp9HtT_kzzr68xh1VpKLSbybQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup boot failure when CONFIG_RT_MUTEXES=y
To: paul.walmsley@sifive.com, palmer@dabbelt.com, guoren@kernel.org, 
	bjorn@rivosinc.com, conor@kernel.org, leobras@redhat.com, 
	peterz@infradead.org, parri.andrea@gmail.com, will@kernel.org, 
	longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de, 
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 7:54=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When CONFIG_RT_MUTEXES=3Dy, mutex_lock->rt_mutex_try_acquire would
Correct: CONFIG_DEBUG_RT_MUTEXES=3Dy

> change from rt_mutex_cmpxchg_acquire to rt_mutex_slowtrylock():
>         raw_spin_lock_irqsave(&lock->wait_lock, flags);
>         ret =3D __rt_mutex_slowtrylock(lock);
>         raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>
> Because queued_spin_#ops to ticket_#ops is changed one by one by
> jump_label, raw_spin_lock/unlock would cause a deadlock during the
> changing.
>
> That means in arch/riscv/kernel/jump_label.c:
> 1.
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
>                          |-> raw_spin_unlock -> queued_spin_unlock
> patch_insn_write -> change the raw_spin_lock to ticket_lock
> mutex_unlock(&text_mutex);
> ...
>
> 2. /* Dirty the lock value */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
>                          |-> raw_spin_unlock -> *queued_spin_unlock*
>                           /* BUG: ticket_lock with queued_spin_unlock */
> patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> mutex_unlock(&text_mutex);
> ...
>
> 3. /* Dead lock */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
>                          |-> raw_spin_unlock -> ticket_unlock
> patch_insn_write -> change other raw_spin_#op -> ticket_#op
> mutex_unlock(&text_mutex);
>
> So, the solution is to disable mutex usage of
> arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
> like we have done for stop_machine.
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Fixes: ab83647fadae ("riscv: Add qspinlock support")
> Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4EPt=
_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d8615=
b3775
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/jump_label.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_labe=
l.c
> index 6eee6f736f68..654ed159c830 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_entry=
 *entry,
>                 insn =3D RISCV_INSN_NOP;
>         }
>
> -       mutex_lock(&text_mutex);
> -       patch_insn_write(addr, &insn, sizeof(insn));
> -       mutex_unlock(&text_mutex);
> +       if (early_boot_irqs_disabled) {
> +               riscv_patch_in_stop_machine =3D 1;
> +               patch_insn_write(addr, &insn, sizeof(insn));
> +               riscv_patch_in_stop_machine =3D 0;
> +       } else {
> +               mutex_lock(&text_mutex);
> +               patch_insn_write(addr, &insn, sizeof(insn));
> +               mutex_unlock(&text_mutex);
> +       }
>
>         return true;
>  }
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren

