Return-Path: <linux-kernel+bounces-426328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C99DF1C9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBFD1630BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC21A08C1;
	Sat, 30 Nov 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiO7CeS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FB42AA4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980989; cv=none; b=ZohKkAnyLrP8ZYEfS7kgeYnAy3pU1Gco6stFseMsLo7vqdF7Ee6nIMjn8CY9/8wk0SvjAbJubgT5GwFxro+gqLZGsWd1TdtBwebAVAsxTuHHTWkvaMz1yWz9pxdm29afn881q0fHCJkCURm0T3JGgEsj79X+1N8TRiz6BYftzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980989; c=relaxed/simple;
	bh=i2wtbIqmpawPaNp5Btdx5Ar7zkC857Xk8v4whaZ01vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1qNZolxEwCrx5P4c9zVdbYBaM1wmdVvzyVm7axTeVvBNFDle20z9ypFVB70BOxBaONTcnLRmVkGrcyJKbtXaCaVcZTn0+9A/yX9J1NmcH3A8zij7IySneUHlCEt6vx0lAFHQ9QP4E/2CW+aBossiPdP/3WmO69YanYFv4dptEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiO7CeS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01F3C4CEDC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732980988;
	bh=i2wtbIqmpawPaNp5Btdx5Ar7zkC857Xk8v4whaZ01vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CiO7CeS2vsEIgTLlls4gOdNxdqWDV6mk4yi8iXoCspP3vDrRwMQfReixKraH7cjeI
	 0FHLGd+mi4RaTkM/mneIM+9rCreIJPnOf7+9eDCPeA36bhQV0qWFrJ6ENgTjS/foMm
	 WFF3cKrpqN0fa3OZsaR4LplpY3GTK1lJopKyws07napUANn9AnKOBXeKaVP5yrPqX4
	 G5lPmcSWpLP083O5ydfiY/B4s4w7RxN/9BCjVHuKK3AJVSW+XU5nVt7rWR33p3U02E
	 H+YnY4Kq+j3mwH1bDPYoRAxYixrpjK7AgaDdhn+ZdjJIkkO7dyrHZg2zx4B1+bRD6g
	 CNd5qmx1DW1HA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so398655866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:36:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpCV6WTGCs1XW6YHjVI8aDL/98kqFv/hoA2zy25ZWzwM3dAYxoFp2uOs0cfNX9nRm5ONgfDywRIO6NWBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55L2UAqXVPORKwoY8qCfXLkpwhPjAylCQ49pYy0TPVf12/nA5
	aZqdnWUMWa4vbGP+4UI2Z8YZTDY+wiyiApeOfS8wX6x3yExf6HYthvcGm/hq44lgFjaOxxHZqiU
	+r5RsZTYcAI9bYcnzjgSAOnRmtbA=
X-Google-Smtp-Source: AGHT+IFCbSZTXAOHJScz3jShbtoC55XaWETe6KCUxwT/Fq9CLf8JLid4BoIIEkr2VsAivDhAk3kDfg+Q5MIIOdO5iyI=
X-Received: by 2002:a17:906:c4d5:b0:aa5:392a:f5a7 with SMTP id
 a640c23a62f3a-aa581066f35mr1161420066b.57.1732980987180; Sat, 30 Nov 2024
 07:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130115355.3316160-1-guoren@kernel.org> <CAJF2gTQhfr-wsj2VZwwP7sWq=yp9HtT_kzzr68xh1VpKLSbybQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQhfr-wsj2VZwwP7sWq=yp9HtT_kzzr68xh1VpKLSbybQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 30 Nov 2024 23:36:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRcaZhHdETFk9KbL1rUdO-U4dX8Ydta7ViAUQ3unrbScg@mail.gmail.com>
Message-ID: <CAJF2gTRcaZhHdETFk9KbL1rUdO-U4dX8Ydta7ViAUQ3unrbScg@mail.gmail.com>
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

On Sat, Nov 30, 2024 at 8:02=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Nov 30, 2024 at 7:54=E2=80=AFPM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When CONFIG_RT_MUTEXES=3Dy, mutex_lock->rt_mutex_try_acquire would
> Correct: CONFIG_DEBUG_RT_MUTEXES=3Dy
Abandoned.

Here is the RESEND PATCH:
https://lore.kernel.org/linux-riscv/20241130153310.3349484-1-guoren@kernel.=
org/

>
> > change from rt_mutex_cmpxchg_acquire to rt_mutex_slowtrylock():
> >         raw_spin_lock_irqsave(&lock->wait_lock, flags);
> >         ret =3D __rt_mutex_slowtrylock(lock);
> >         raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> >
> > Because queued_spin_#ops to ticket_#ops is changed one by one by
> > jump_label, raw_spin_lock/unlock would cause a deadlock during the
> > changing.
> >
> > That means in arch/riscv/kernel/jump_label.c:
> > 1.
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
> >                          |-> raw_spin_unlock -> queued_spin_unlock
> > patch_insn_write -> change the raw_spin_lock to ticket_lock
> > mutex_unlock(&text_mutex);
> > ...
> >
> > 2. /* Dirty the lock value */
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
> >                          |-> raw_spin_unlock -> *queued_spin_unlock*
> >                           /* BUG: ticket_lock with queued_spin_unlock *=
/
> > patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> > mutex_unlock(&text_mutex);
> > ...
> >
> > 3. /* Dead lock */
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! =
*/
> >                          |-> raw_spin_unlock -> ticket_unlock
> > patch_insn_write -> change other raw_spin_#op -> ticket_#op
> > mutex_unlock(&text_mutex);
> >
> > So, the solution is to disable mutex usage of
> > arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
> > like we have done for stop_machine.
> >
> > Reported-by: Conor Dooley <conor@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Fixes: ab83647fadae ("riscv: Add qspinlock support")
> > Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4E=
Pt_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d86=
15b3775
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/kernel/jump_label.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_la=
bel.c
> > index 6eee6f736f68..654ed159c830 100644
> > --- a/arch/riscv/kernel/jump_label.c
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_ent=
ry *entry,
> >                 insn =3D RISCV_INSN_NOP;
> >         }
> >
> > -       mutex_lock(&text_mutex);
> > -       patch_insn_write(addr, &insn, sizeof(insn));
> > -       mutex_unlock(&text_mutex);
> > +       if (early_boot_irqs_disabled) {
> > +               riscv_patch_in_stop_machine =3D 1;
> > +               patch_insn_write(addr, &insn, sizeof(insn));
> > +               riscv_patch_in_stop_machine =3D 0;
> > +       } else {
> > +               mutex_lock(&text_mutex);
> > +               patch_insn_write(addr, &insn, sizeof(insn));
> > +               mutex_unlock(&text_mutex);
> > +       }
> >
> >         return true;
> >  }
> > --
> > 2.40.1
> >
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren

