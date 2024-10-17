Return-Path: <linux-kernel+bounces-369631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F409A2010
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B6F28438C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D21D270B;
	Thu, 17 Oct 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfAG5xCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172D21E3BB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161105; cv=none; b=R/D8ibPUHC6lf/2ch7GzUEpoH2P0DwCTLgHeHEhXGZaV2st2eyQI4UqFq3vZGwYjXx2DHcBbbQ9cyXrpMBAyWzl9jaQqR9yjwmlG7WQDO+7g38u7ECuFvbcjVsFQAy8+V6/7n7nYaGxD7AYiqbOnGlc1+gwwAwFNEj3AK4PLsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161105; c=relaxed/simple;
	bh=IzG5PSvcg1vpEWcQ5pdzWwgAf53vYWIA/ZY2d5FWYVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwaXsclQNaAEN/AqkcclP8DxD6lTQO4pOeVErjD8uc5hBYF0/+kNii4ainAHls7efBojY+NUpu8amFETpYczja5mTow8Tz1kIcbGFzEY1HrzI0miU2/dz+wJcTTRSPMAGbkpbvp8xrgaMdhoogcIw0EnaWI37NzrWgQjTD5iG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfAG5xCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A277C4AF0B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729161104;
	bh=IzG5PSvcg1vpEWcQ5pdzWwgAf53vYWIA/ZY2d5FWYVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qfAG5xCMS+uLySyzuneiqKxlkYuKORVtpxAAHXFPYHp2oiKUGv+oLcx0Mdk0mtYVz
	 ZdTNXN+z0WVNJ6V6/b+mWJNdvcC7HCWWp1B9r4nwsl+xv8rHAwloJjPBwxotbRizlJ
	 IYwM6et9Am+0rfre6DDirMCG2wZi5C5UlduK1lpDXZQFJiQ1+oMJOsQCoJYNuS0Xfh
	 78aeY6qcQSDtkCIkTuJfZnxE4cwtmcFtvjFNmtB5l6Y1gfaG2m6LWWAqe3rTfAi4pF
	 AYYJjcHpx8EC7lbl21keBswGcAwEDe28M9XzZtDIh+vQMUmY0v2g0de17Tfr9BPBJ7
	 l6dH4fbcjFORg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5743074bso5965771fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:31:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1p5cX4Udi5HRsJgAiTyFB6ZVNQvgVHA40F6+fBFXadELvaDsLsVVuKPswlNmXJHQI3NhoF1r+/FDizhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGO4nffX4L/yjTiwZh1LRdcE0v1fiyBfLQ6Zj1nm7DshRzw6K9
	HlWR6nu4JpVsWT2GGOs2KVSFG0QPkc+/r8ZBnKdRDTlUh72l0T+J268PKJZl8MU46BP+BH2Gv9A
	jtRT95MnBtHRamj5yrNx/wnVSZmI=
X-Google-Smtp-Source: AGHT+IG1iOVo01ioiJTuaWXBujUXqJA0F8wivCSNMdi49h9T8U1BFgLJAG603Xrkgr3FsDpqsimBwMI+O2ws1JJ6zW8=
X-Received: by 2002:a2e:611:0:b0:2fa:ce0d:ec34 with SMTP id
 38308e7fff4ca-2fb6d9c6270mr7476021fa.2.1729161102830; Thu, 17 Oct 2024
 03:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
 <Zw9_imsl2KLf7_GY@J2N7QTR9R3> <CACRpkda8tO=QLF_zznoNjdNfNZJVntY_3+247E=qK6zNqRnVSA@mail.gmail.com>
 <ZxDh9biUbf9W8gNN@J2N7QTR9R3>
In-Reply-To: <ZxDh9biUbf9W8gNN@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 17 Oct 2024 12:31:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFn=pfJqTrMrnqT+OLi3UqAq0PieROQhbC2M3B2uAzyEQ@mail.gmail.com>
Message-ID: <CAMj1kXFn=pfJqTrMrnqT+OLi3UqAq0PieROQhbC2M3B2uAzyEQ@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2024 at 12:10, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Oct 16, 2024 at 09:00:22PM +0200, Linus Walleij wrote:
> > On Wed, Oct 16, 2024 at 10:55=E2=80=AFAM Mark Rutland <mark.rutland@arm=
.com> wrote:
> >
> > > I believe that's necessary for the lazy TLB switch, at least for SMP:
> > >
> > >         // CPU 0                        // CPU 1
> > >
> > >         << switches to task X's mm >>
> > >
> > >                                         << creates kthread task Y >>
> > >                                         << maps task Y's new stack >>
> > >                                         << maps task Y's new shadow >=
>
> > >
> > >                                         // Y switched out
> > >                                         context_switch(..., Y, ..., .=
..);
> > >
> > >         // Switch from X to Y
> > >         context_switch(..., X, Y, ...) {
> > >                 // prev =3D X
> > >                 // next =3D Y
> > >
> > >                 if (!next->mm) {
> > >                         // Y has no mm
> > >                         // No switch_mm() here
> > >                         // ... so no check_vmalloc_seq()
> > >                 } else {
> > >                         // not taken
> > >                 }
> > >
> > >                 ...
> > >
> > >                 // X's mm still lacks Y's stack + shadow here
> > >
> > >                 switch_to(prev, next, prev);
> > >         }
> > >
> > > ... so probably worth a comment that we're faulting in the new
> > > stack+shadow for for lazy tlb when switching to a task with no mm?
> >
> > Switching to a task with no mm =3D=3D switching to a kernel daemon.
>
> A common misconception, but not always true:
>
> * A kernel thread can have an mm: see kthread_use_mm() and
>   kthread_unuse_mm().
>
> * A user thread can lose its mm while exiting: see how do_exit() calls
>   exit_mm(), and how hte task remains preemptible for a while
>   thereafter.
>
> ... so we really do just mean "a task with no mm".
>
> > And those only use the kernel memory and relies on that always
> > being mapped in any previous mm context, right.
>
> A task with no mm only uses kernel memory. Anything it uses must be
> mapped in init_mm, but *might* not have been copied into every other mm,
> and hence might not be in the previous mm context as per the example
> above.
>
> > But where do we put that comment? In kernel/sched/core.c
> > context_switch()?
>
> I was trying to suggest we update the existing comment in switch_to() to
> be more explicit. e.g. expand the existing comment:
>
>         @
>         @ Do a dummy read from the new stack while running from the old o=
ne so
>         @ that we can rely on do_translation_fault() to fix up any stale =
PMD
>         @ entries covering the vmalloc region.
>         @
>
> ... with:
>
>         @
>         @ For a non-lazy mm switch, check_vmalloc_seq() has ensured that
>         @ that the active mm's page tables have mappings for the prev
>         @ task's stack and the next task's stack.
>         @
>         @ For a lazy mm switch the active mm's page tables have mappings
>         @ for the prev task's stack but might not have mappings for the
>         @ new taks stack. Do a dummy read from the new stack while

task

>         @ running from the old stack so that we can rely on
>         @ do_translation_fault() to fix up any stale PMD entries
>         @ covering the vmalloc region.

Might as well be more precise here, and say "populate missing PMD
entries covering the new task's stack in the old task's page tables"

>         @
>
> Ard, does that sound good to you?
>

Yes.

