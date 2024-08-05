Return-Path: <linux-kernel+bounces-275306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E8948310
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D42C1C20B52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BD16C860;
	Mon,  5 Aug 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWn8mmzm"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1A16BE3A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888876; cv=none; b=Qs6gwebG9OCGO3vhEOIxAEH4hgMD9ctx0+Cx92ae/GB6Wk8aqd1UwvLnno9VZyweEl8lolkVLSVKjXkNVpiYfBRHmop27WiJsjKmBTep6/RU504Nj5tkLav8enQMNCgDdCBwhJKI6AzIQ1XJwPYDV2N3fAa+XFvhnDCMvhPsEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888876; c=relaxed/simple;
	bh=z2/BJY97U4s+5UB1SF8YTqPgm1IHuPyN/YSe3yeIlMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdmydHQD16Y577fsRP28Vw86sul5KbNZm3Zq6N5+JdKmoaMi2K5y92XT38ki5QODqHtNqLztCc4OQFajGzl1N9GHmBWIpc1qt6bCGG592EzYVrKhciFfPD4iTijB5iRh5DHtwM5mVMO3YLdAvEU2+YOdPue0EeQjnr7Gn9XNVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gWn8mmzm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so1177379066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722888870; x=1723493670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CYiIbK4c0KcOt/WWRIuFBQSVRAfQqa4aNsAtAKJ4UY=;
        b=gWn8mmzmDfuO+u8d/pXP1KzG4VWhhKWdZiT5ggPEQM/MVr3aI4wkSZX5PsNc+QAzkI
         NOumU+Q7T+Ozc6Wsbej+GG3eUUMAclB7GB4XwPifi8Vqi6w9dGKHaOxcn/c/y0U8GZp5
         ozyyhzfrXDLTSzc6evsPXf7H3BR7hrI8jMMh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888870; x=1723493670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CYiIbK4c0KcOt/WWRIuFBQSVRAfQqa4aNsAtAKJ4UY=;
        b=XFrPElT4AK76u2Mz+ikExGj1Lkkq7kjRbpXDX1XvFWT8gSCTg8uvp19GcIKBpy5/Wu
         UJpwBH4PAtPxWm4egyUJb9wRRLVFRHMvxxaggHbtj0z9etka4VZ/AxoXcnayihB1gQSI
         nFr2lfxSm9/DZ84psGHchfmqy4VF46U0LWP2EETCAUbXZ5AU8SdsVlejOhHSocAl/IIU
         Nwnzi5zY+upl0a/rd2B6uEz+KM9Q+wmam/sr4WtIsskNkfLBEfZovi3v1GnvmDjuqOyJ
         uwthuR/kKpW8Gky3yNnSbIK3Hu+yQksQL233/cdCJczvV7SS64iIJoNRQXNbjV316+E5
         VJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/iiwEPtk8NpwSGkU3bz8s0SZmJV7c4ORz+mSbiy1aOVMzC4Ngx6lRr9lamrlYiD0BT5z3FlWM4pIBdQzLJvY0jXyrE4Za27BzdgpZ
X-Gm-Message-State: AOJu0YxoqP4gF5dSkGZso+7aEzRhtcapz7cYE0Lb43yFhR5uRWKp1+0u
	TiaciiaERsz0JRizls6vQpV/SiBno0BmDEmV6yOlrOQpOpE20s5P1Zg9zAGgyBc8k0W+Cof4ZGt
	1XQ==
X-Google-Smtp-Source: AGHT+IFmsBnVMQvl3+72Agf1KMMP1jQ1+jVZAJz/TiBn6zhe2CFKGY/djFyGcq+sY1kLzF9s1JvIWw==
X-Received: by 2002:a17:907:7f24:b0:a7d:a29e:5c41 with SMTP id a640c23a62f3a-a7dc5029a1dmr952439166b.40.1722888870542;
        Mon, 05 Aug 2024 13:14:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c129e2sm481492966b.82.2024.08.05.13.14.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 13:14:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so1087a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUo1OR7TLbJn/0YzKuLoF6JHx6C0gGDYlvSQc4TzRYY+apdQCoajbZRJ5+6YY43cTRqwT94urPqrxfyo8RBHtixPfSN+KFinrdUb7cw
X-Received: by 2002:a05:6402:40c5:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5bb98241678mr30269a12.1.1722888869040; Mon, 05 Aug 2024
 13:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
 <20240805172419.GD10196@willie-the-truck>
In-Reply-To: <20240805172419.GD10196@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 13:14:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQMvHvXJUsSZgW1NEATXE3pi4PUr9XKRzgjMnQYm2-0A@mail.gmail.com>
Message-ID: <CAD=FV=UQMvHvXJUsSZgW1NEATXE3pi4PUr9XKRzgjMnQYm2-0A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Yu Zhao <yuzhao@google.com>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 10:24=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Aug 05, 2024 at 10:13:11AM -0700, Doug Anderson wrote:
> > On Mon, Aug 5, 2024 at 9:53=E2=80=AFAM Will Deacon <will@kernel.org> wr=
ote:
> > > On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> > > > @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online=
_cpus(void)
> > > >
> > > >  void smp_send_stop(void)
> > > >  {
> > > > +     static unsigned long stop_in_progress;
> > > > +     cpumask_t mask;
> > > >       unsigned long timeout;
> > > >
> > > > -     if (num_other_online_cpus()) {
> > > > -             cpumask_t mask;
> > > > +     /*
> > > > +      * If this cpu is the only one alive at this point in time, o=
nline or
> > > > +      * not, there are no stop messages to be sent around, so just=
 back out.
> > > > +      */
> > > > +     if (num_other_online_cpus() =3D=3D 0)
> > > > +             goto skip_ipi;
> > > >
> > > > -             cpumask_copy(&mask, cpu_online_mask);
> > > > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > > > +     /* Only proceed if this is the first CPU to reach this code *=
/
> > > > +     if (test_and_set_bit(0, &stop_in_progress))
> > > > +             return;
> > > >
> > > > -             if (system_state <=3D SYSTEM_RUNNING)
> > > > -                     pr_crit("SMP: stopping secondary CPUs\n");
> > > > -             smp_cross_call(&mask, IPI_CPU_STOP);
> > > > -     }
> > > > +     cpumask_copy(&mask, cpu_online_mask);
> > > > +     cpumask_clear_cpu(smp_processor_id(), &mask);
> > > >
> > > > -     /* Wait up to one second for other CPUs to stop */
> > > > +     if (system_state <=3D SYSTEM_RUNNING)
> > > > +             pr_crit("SMP: stopping secondary CPUs\n");
> > > > +
> > > > +     /*
> > > > +      * Start with a normal IPI and wait up to one second for othe=
r CPUs to
> > > > +      * stop. We do this first because it gives other processors a=
 chance
> > > > +      * to exit critical sections / drop locks and makes the rest =
of the
> > > > +      * stop process (especially console flush) more robust.
> > > > +      */
> > > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> > >
> > > I realise you've moved this out of crash_smp_send_stop() and it looks
> > > like we inherited the code from x86, but do you know how this seriali=
se
> > > against CPU hotplug operations? I've spent the last 20m looking at th=
e
> > > code and I can't see what prevents other CPUs from coming and going
> > > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> >
> > I don't think there is anything. ...and it's not just this code
> > either. It sure looks like nmi_trigger_cpumask_backtrace() has the
> > same problem.
> >
> > I guess maybe in the case of nmi_trigger_cpumask_backtrace() it's not
> > such a big deal because:
> > 1. If a CPU goes away then we'll just time out
> > 2. If a CPU shows up then we'll skip backtracing it, but we were
> > sending backtraces at an instant in time anyway.
> >
> > In the case of smp_send_stop() it's probably fine if a CPU goes away
> > because, again, we'll just timeout. ...but if a CPU shows up then
> > that's not super ideal. Maybe it doesn't cause problems in practice
> > but it does feel like it should be fixed.
>
> On the other hand, I really don't fancy taking a CPU hotplug mutex on
> the panic() path, so it's hard to know what's best.
>
> I suppose one thing we could do is recompute the mask before sending the
> NMI, which should make it a little more robust in that case. It still
> feels fragile, but it's no worse than the existing code, I suppose.

Happy to do this and send a new version if you want. Just let me know.
Basically it's just replacing `cpumask_and(&mask, &mask,
cpu_online_mask)`  with `cpumask_copy(&mask, cpu_online_mask);
cpumask_clear_cpu(smp_processor_id(), &mask);` in the case where we
fallback to NMI. If you're happy with the patch I'm also happy if you
make this change while applying.

BTW: if you want to dig into what's (possibly) another preexisting
race condition that I think I noticed while coding this up, I suspect
that "kcrash" will end up lacking info on a CPU any time we end up in
the panic_smp_self_stop() case. Trying to do something about that felt
a bit far afield for me, though.

-Doug

