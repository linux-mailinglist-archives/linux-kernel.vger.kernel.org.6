Return-Path: <linux-kernel+bounces-430838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F639E364D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEB2B2BD1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAD19B3E2;
	Wed,  4 Dec 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ45P40+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3264190058
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303439; cv=none; b=gIms6lURhca3dFElrVf1A1mQwfx8lIgVlYxc4T1cRBbmA9WVK7Qc9pfOgSJXQE+ZujIAZ6kxhnmlzAN7zqn/p6PFCVkCBlgC5it79lF+gLQKzx2oZFpXRVEyNFoPL5yH6K5fkKnEzK9e9Uof7EQdWM7mi1ri+jRoDQ2ZsHlmkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303439; c=relaxed/simple;
	bh=DfVWUFdPcEjBd+yOxs95lEaIRtPlZMisWDeWXBNb6zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9bcDpa/ZImUCgxvO6KqRH3X+7DHYC/Xp9u1zIoGix2Fv18lMKQguK3p/bwoE2KKJPzQLFIogLW9ymCghvb7fCTGccUdd0akjgwRgMESyZQO8ULTm7V6c9KX9geydoT3oSyp4MaH4frgkSLvg6xh7z8ZrNwU3Lk1h3pk0lztfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ45P40+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A1C4CEE1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733303439;
	bh=DfVWUFdPcEjBd+yOxs95lEaIRtPlZMisWDeWXBNb6zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pZ45P40+Es/yLV+50g0zRxUMKOGgCdo/s7rOrhByCmUZISDVVmRNSmvz709nBfdo2
	 ZCgD3aQfpudzUUf3xn91KqPFJDhpYo1Q8R+0tSWwSV+CqApBpVIZsJS8nfU0cVKWPV
	 ZbMOW9o9mpmD8Lxk0VaKG6dzBKFrbk+ZNbSgD0aTDlgjRBNVcYX6aqk0hp2NciW/xf
	 5ybCm2A1Je4UQ1GP2osbqJUZjHJtUCZbBjL1RepN/XBgi+/is4YNxOCsIl5QIIjRic
	 dS8R7DwGJ9kFDqVXwYfkVT7mjEJBebxF8JDGuBzRkYtFu9KcUYDdQp7dPl2EjQJ44n
	 7aSp0KC/SSJUw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so7358777a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:10:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZYJxW30Th1Qp0/sYMhcFOUkenuCU44ti9TPsq23Rl8i4yPZael9f1yxq2EzfByWOFfqtPfGxHOhXFeBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7ce7u9FxCPPvtqMDNeq7Wmdha8HTaDi/ZLeObKRakSTrb0F+
	bsDKUviBGl/Jms+QEk8gD3VJURQsOVv2WD0eqy33GlDsBySMyNftNoIQ33NLYiiKGiL9aZy4IEd
	Uu/CgfwVMha6FRiLgn3hQDAROUyQ=
X-Google-Smtp-Source: AGHT+IEbdqWd0RxA1wsVaRAQCNqZAPdocTVmf/Y+kR7OMUCRPbGbJYecjAQ4oaj/Z7p+701rYpCuBMgzHjDi6lAMHNg=
X-Received: by 2002:a17:906:2921:b0:aa5:4672:663d with SMTP id
 a640c23a62f3a-aa5f7f4bbc5mr395521566b.57.1733303437378; Wed, 04 Dec 2024
 01:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130153310.3349484-1-guoren@kernel.org> <7e93d7a9-caa8-40c4-997a-d96ad94dbe94@ghiti.fr>
In-Reply-To: <7e93d7a9-caa8-40c4-997a-d96ad94dbe94@ghiti.fr>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 4 Dec 2024 17:10:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT6bezLuxe-+8tSUyBstbnW-=FQnN8N-Gno12C07+tgYQ@mail.gmail.com>
Message-ID: <CAJF2gTT6bezLuxe-+8tSUyBstbnW-=FQnN8N-Gno12C07+tgYQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=y
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	conor@kernel.org, leobras@redhat.com, peterz@infradead.org, 
	parri.andrea@gmail.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, arnd@arndb.de, alexghiti@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:27=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Guo,
>
> On 30/11/2024 16:33, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When CONFIG_DEBUG_RT_MUTEXES=3Dy, mutex_lock->rt_mutex_try_acquire
> > would change from rt_mutex_cmpxchg_acquire to
> > rt_mutex_slowtrylock():
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> >       ret =3D __rt_mutex_slowtrylock(lock);
> >       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> >
> > Because queued_spin_#ops to ticket_#ops is changed one by one by
> > jump_label, raw_spin_lock/unlock would cause a deadlock during the
> > changing.
> >
> > That means in arch/riscv/kernel/jump_label.c:
> > 1.
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
> >                        |-> raw_spin_unlock -> queued_spin_unlock
> > patch_insn_write -> change the raw_spin_lock to ticket_lock
> > mutex_unlock(&text_mutex);
> > ...
> >
> > 2. /* Dirty the lock value */
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
> >                           |-> raw_spin_unlock -> *queued_spin_unlock*
> >                         /* BUG: ticket_lock with queued_spin_unlock */
> > patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> > mutex_unlock(&text_mutex);
> > ...
> >
> > 3. /* Dead lock */
> > arch_jump_label_transform_queue() ->
> > mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! =
*/
> >                           |-> raw_spin_unlock -> ticket_unlock
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
> >   arch/riscv/kernel/jump_label.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_la=
bel.c
> > index 6eee6f736f68..654ed159c830 100644
> > --- a/arch/riscv/kernel/jump_label.c
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_ent=
ry *entry,
> >               insn =3D RISCV_INSN_NOP;
> >       }
> >
> > -     mutex_lock(&text_mutex);
> > -     patch_insn_write(addr, &insn, sizeof(insn));
> > -     mutex_unlock(&text_mutex);
> > +     if (early_boot_irqs_disabled) {
> > +             riscv_patch_in_stop_machine =3D 1;
> > +             patch_insn_write(addr, &insn, sizeof(insn));
> > +             riscv_patch_in_stop_machine =3D 0;
> > +     } else {
> > +             mutex_lock(&text_mutex);
> > +             patch_insn_write(addr, &insn, sizeof(insn));
> > +             mutex_unlock(&text_mutex);
> > +     }
> >
> >       return true;
> >   }
>
>
> Sorry for the late answer, I've been sick lately!
I wish you a speedy recovery.

>
> Thank you very much for looking into this and finding this not-so-bad
> solution! I remind everyone that this is a temporary solution until we
> can use an alternative instead of a static key.
Herer, I want to point out that the problem is not jump_label
infrastructure but our arch_jump_label_transform_queue
->patch_insn_write. The alternative also has a similar situation. So
you still need the modification like the below:

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.=
c
index 467c5c735bf5..475f7c520be4 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -1017,10 +1017,17 @@ void __init_or_module
riscv_cpufeature_patch_func(struct alt_entry *begin,
                oldptr =3D ALT_OLD_PTR(alt);
                altptr =3D ALT_ALT_PTR(alt);

+if (early_boot_irqs_disabled) {
+               riscv_patch_in_stop_machine =3D 1;
+               patch_text_nosync(oldptr, altptr, alt->alt_len);
+               riscv_alternative_fix_offsets(oldptr, alt->alt_len,
oldptr - altptr);
+               riscv_patch_in_stop_machine =3D 0;
+} else {
                mutex_lock(&text_mutex);
                patch_text_nosync(oldptr, altptr, alt->alt_len);
                riscv_alternative_fix_offsets(oldptr, alt->alt_len,
oldptr - altptr);
                mutex_unlock(&text_mutex);
+}
        }
 }
 #endif

>
> You can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> The revert is still on the table IMO, let's Palmer decide.
Okay

--=20
Best Regards
 Guo Ren

