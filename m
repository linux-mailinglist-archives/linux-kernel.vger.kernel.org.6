Return-Path: <linux-kernel+bounces-204585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F88FF0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7419B1F255E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B6196457;
	Thu,  6 Jun 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnKaB05e"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1D194ADF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688172; cv=none; b=huUC9AhrhitCjPZqhJ6oCfiMyQFDkCTH1IYG45hSmbkFkgfJ7jYYzWM8mkZQEZ/UdHzqgM4xldJYxMZSeGGzB0jZtg3bC48HJmCueL1BgM+TOG7Ihc9pnu9AbbK2pPcbIe++cEazzJCVHuKHGkpcb6tJO8sm3G1DthoqOV+PJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688172; c=relaxed/simple;
	bh=PeDlhjT8ut6E9aKG5RIVbh/fG7BR4qLOOB65IxE1J9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ5mFd4dG0s7vCG9SQtW1Pwp5F67H9IC32drU2qMMdBwGaA7gNaTqTlDXip99wJ1cH4cWeL2nI59usIbpwwuVh/Q2x6T4f128ArQLv2SqnGz7wJkxaq3f1I+crYTMYpFNl/ilFO+oEWOzt5Oaho1kiwFnt5COIPym0iZaWv0rIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnKaB05e; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52961b77655so1309292e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688168; x=1718292968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyiq1sRZOIKUcWY3fSoYAYeVrpMvl8oHpujcmV9B7v4=;
        b=DnKaB05eccfIAt/C4CYbAhTKKOwE/SMPwFgJpGjhS3woxmo2+CJypdIK6oaDN1YiW+
         q73QrQ7YTour5BwWTqHVrERTBIChu2M9N+rZAd88Wk8OM7RkEzi8q2WzAxTtJapjoebU
         jA8rEbqlfblph4HScoqXsu3ja58Mu2TvHAxvs5eoiVvW9s64hiCL+sYLmz89uGo9ZKxf
         CTP4TR8R9YzHxI3H7K9HQnzjEmnj0Ib6R/YjRAZPUSjjx94T+YtfTkI1hRuXu1i1Es2f
         zXkv0c7rFajw1OExJANAXHBBXKGMmB8wPhNrw59p8E1C929Zgd5ElTiJeBSai9+3lNSH
         vaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688168; x=1718292968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pyiq1sRZOIKUcWY3fSoYAYeVrpMvl8oHpujcmV9B7v4=;
        b=Xqc80V6ogOlfBymzX/8CUrntPKfZOjMlLawDoQWa0XtnetTSRwnC65+ri8UsHpWlC3
         cl7OQQzwAS65nzO8+rvqcU7pKAxxMZx6gG6xOrvuraqKEJ0f0Ny1KmsXa71AHlV5WVon
         zt3IlLiiiyTynXVXR4kDvXJNrxufaM3Zp5nvsGhU/foCSTsaRa78F3zP481C9Pra2QO6
         hCJhn93Z4JIxwRlc8hfFzGgkr8h6hp4nkM2OWNUreNa59KNzHP5hx1lSRtuFUbEAhtim
         Ea76GYfmJMnyfEdnrGGp/j2f+obRWiYbIqAy357D1hJGHqB4ZmNsXYM+v+/BvAVS4Cnf
         MpwQ==
X-Gm-Message-State: AOJu0Yzppboq0Azp+TRk5efetBwjnsxvaHpzph0WaNGGSiUt+AhD6Xi0
	2bA50ZcGsJxXqRXrf0Yr7V/uXw8YQYEzWbCAPLvBf60tq19gfB12gQwEKM01N/NsjfFcW3ZOI8n
	YE21hh5FxMcajcBVXkdqKl6DbcA==
X-Google-Smtp-Source: AGHT+IHQuNdr2OeAp/oAD/js4i9hW2f2j3tQeBgOjO+X2z42P30KkS8IeXfyT1aOsY/e6aSvoXJOhcS0RNQUMGCqCvc=
X-Received: by 2002:ac2:5927:0:b0:520:36bb:a6e1 with SMTP id
 2adb3069b0e04-52bab4e777fmr3309879e87.29.1717688167638; Thu, 06 Jun 2024
 08:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605083557.2051480-1-mingo@kernel.org> <CAMzpN2hms-cpsaief4j_1LhXXznreE+it8nnsH2-8yoQ2Bn0Rw@mail.gmail.com>
 <ZmF8AH0TX_lgkxS5@gmail.com>
In-Reply-To: <ZmF8AH0TX_lgkxS5@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 6 Jun 2024 11:35:56 -0400
Message-ID: <CAMzpN2gL04UbRUP5HDkz9hxdyxXVkFcXBrDc+hGmvR0rxt2Onw@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:06=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > >  17 files changed, 104 insertions(+), 107 deletions(-)
> >
> > This series would be better if you added the x86_task_fpu() helper in
> > an initial patch without any other changes.  That would make the
> > actual changes more visible with less code churn.
>
> Makes sense - I've split out the patch below and adjusted the rest of the
> series. Is this what you had in mind?
>
> Note that I also robustified the macro a bit:
>
>  -# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task=
)))
>  +# define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(t=
ask))))
>
> Thanks,
>
>         Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 6 Jun 2024 11:01:14 +0200
> Subject: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method
>
> The per-task FPU context/save area is allocated right
> next to task_struct() - introduce the x86_task_fpu()
> helper that calculates this explicitly from the
> task pointer.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 920b0beebd11..fb6f030f0692 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -507,6 +507,8 @@ struct thread_struct {
>         struct fpu              *fpu;
>  };
>
> +#define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(tas=
k))))
> +
>  /*
>   * X86 doesn't need any embedded-FPU-struct quirks:
>   */

Since this should be the first patch in the series, It would be:

#define #define x86_task_fpu(task) (&(task)->thread.fpu)

along with converting the existing accesses to task->thread.fpu in one
patch with no other functional changes. Then you could change how the
fpu struct is allocated without touching every access site again.


Brian Gerst

