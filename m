Return-Path: <linux-kernel+bounces-413292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9DA9D16F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B7D1F22DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAEF1C173F;
	Mon, 18 Nov 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqUNbNj1"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7821BD9DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950346; cv=none; b=RN/hlupmsT+YMgkeb4QWAJjaPI3rpz8zwwHRc9V6SmW6JCYGd1imtbOFTdahBsxQUzB65b0ZOcwym5CTBE2IvbOEDgvvVkNX7ZNPTFUVjfP1mBw0z+uAz7RFoTwcFZWfM775Ro760bHO0ZAsN7t2Gd9/+VjTPnszcl2tarEqIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950346; c=relaxed/simple;
	bh=+AkeSd488IHXaNmvrfNRaTaOf+29cgnUQfLt5ryWYEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/MVBAuIYSv1oLAaDFQLH9o+UDntebF1cirpeciLR4XcasakQstdPXClscfibYJ0pSz6dcGrgXBsJYbQUzqUGBEwyZGS7V0ShyUsrOA2ydS8HbHtKN/m0mzADTjBCG4gzG0fbhvFjqsJasa1Z9j6Yjgky4CrRPix42w8/WJDfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqUNbNj1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so20109201fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731950342; x=1732555142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuNH0nDXMSVd1ccWJD9FBlP/snQ56+VRExml0DwRZXE=;
        b=EqUNbNj1z/nwEat/Qj5iT7Vl7jMMKhLpW3DYWhRCzc/FpgTJzMLElgQRnRwN7b3Yeb
         mjZ+rvdCT2j0nDAvxUJJBfC8oNZRidOhVi3IrTAICxCk7Bhd1rMqPUKTG7r8knqMV4P7
         BT9SESb9vkzrR64QpUWrgz4eaQICKzETTaW9Kbha7BG4DZb89CBxSQhum9OCM80bScAQ
         r8pwOFofPXuHkZQ8xAeqRCS0TyAOza47gacwd79q/SLijIn0hjXmO68C86oIzOI200JM
         H/m/J1lXhWs7XXcS6C5IwJn5iNswdtK2GexXklxYE4bReQCr4T4cU1AppFbwHXfdY4zp
         596g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950342; x=1732555142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuNH0nDXMSVd1ccWJD9FBlP/snQ56+VRExml0DwRZXE=;
        b=EqYMuPoLYaqCQaMyXVUz+1WMPjy4Win9FMAqzZmY/3Hd/rX25yb2sKfLg9mJHQVIi0
         3rDEMPMILy03eWtJFISGt1QKCNPLPYuENuCXIARHNHhr9DRGXORW+wQPLnegm5DI83ST
         ICvDhMpkKOjVnY2+9H+xA8C/C+9zjVQGoab/0kBRiL3RhnCgN2FwFvBkVkXa4GGpx8lK
         eYouLN4t7LwtmSEiG0WL7+MHe+l/9KeW8uKjZwreECTmPjxY74aogUiBqTWQo8LQqp0F
         1DEqF9l7/KWJiQ5HhfjAZ2r1bYqYY9CsXtkVOjeVtjbPj9ljgYB/HLHb0zMa5QDQ887g
         OFmA==
X-Forwarded-Encrypted: i=1; AJvYcCVMCox098N+RS0kTZVsmPhfSjNA7ZS9oaL3GpX2pzuEsIxM4Ihv6p76kXN9aP+4Lrksw0pA1glkeXnKIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyAi0aUvfQtIfpoaGhMV16go7sPJu5JIAWbK+Wnpij1Xe0j9Q
	mS/vRYjN+7fH9zszqXz0r3X5124b9xu232hKBaKTpS/gwN6qKQnYpFr8bSufzA+m2NN5JGAufUm
	6RFJHFoytg9weheoMhp+R5HvqdqfOB2J8ndmo
X-Google-Smtp-Source: AGHT+IGaVPtjxg0lZYHH7EjyYhWGOPdUdEx0tpeIxRt4+xqS5fBLmpT3skueq7C79i8nPh+VD6qJMRwCLj/TFa72kuU=
X-Received: by 2002:a2e:be12:0:b0:2fb:5da7:47a7 with SMTP id
 38308e7fff4ca-2ff6074b31bmr62802331fa.25.1731950342158; Mon, 18 Nov 2024
 09:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-6-saravanak@google.com> <2df83343-2198-4193-8452-f6a27585b999@arm.com>
In-Reply-To: <2df83343-2198-4193-8452-f6a27585b999@arm.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 18 Nov 2024 09:18:25 -0800
Message-ID: <CAGETcx_cQVr=n+TZtA39Eswi_-o-ohKtB-is78d0yzO0a1SQfw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:52=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/14/24 22:09, Saravana Kannan wrote:
> > As of today, the scheduler doesn't spread out all the kworker threads
> > across all the available CPUs during suspend/resume. This causes
> > significant resume latency during the dpm_resume*() phases.
> >
> > System resume latency is a very user-visible event. Reducing the
> > latency is more important than trying to be energy aware during that
> > period.
> >
> > Since there are no userspace processes running during this time and
> > this is a very short time window, we can simply disable EAS during
> > resume so that the parallel resume of the devices is spread across all
> > the CPUs.
> >
> > On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> > plus disabling EAS for resume yields significant improvements:
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Phase                           | Old full sync | New full async | % =
change |
> > |                         |               | + EAS disabled |          |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Total dpm_suspend*() time |        107 ms |          62 ms |     -42%=
 |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Total dpm_resume*() time  |         75 ms |          61 ms |     -19%=
 |
> > +---------------------------+-----------+------------+-----------------=
-+
> > | Sum                     |        182 ms |         123 ms |     -32% |
> > +---------------------------+-----------+------------+-----------------=
-+
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  kernel/power/suspend.c  | 16 ++++++++++++++++
> >  kernel/sched/topology.c | 13 +++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 09f8397bae15..7304dc39958f 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
> >       local_irq_enable();
> >  }
> >
> > +/*
> > + * Intentionally not part of a header file to avoid risk of abuse by o=
ther
> > + * drivers.
> > + */
> > +void sched_set_energy_aware(unsigned int enable);
> > +
> >  /**
> >   * suspend_enter - Make the system enter the given sleep state.
> >   * @state: System sleep state to enter.
> > @@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bo=
ol *wakeup)
> >
> >   Platform_wake:
> >       platform_resume_noirq(state);
> > +     /*
> > +      * We do this only for resume instead of suspend and resume for t=
hese
> > +      * reasons:
> > +      * - Performance is more important than power for resume.
> > +      * - Power spent entering suspend is more important for suspend. =
Also,
> > +      *   stangely, disabling EAS was making suspent a few millisecond=
s
> > +      *   slower in my testing.
>
> s/stangely/strangely
> s/suspent/suspend

Will fix it in the next version.

> I'd also be curious why that is. Disabling EAS shouldn't be that expensiv=
e.
> What if you just hack the static branch switch (without the sd rebuild)?

I don't think the enabling/disabling is the expensive part. Because I
do it around dpm_resume*() and it helps performance. I tried to see if
I could spot a reason, looking at the trace. But nothing stood out.

My educated guess is that when going into suspend, the "thundering
herd" happens early (all the leaf nodes suspend first) and then peters
out. Whereas, during resume it's a slow ramp up until the "thundering
herd" happens at the end (all the leaf nodes resume last).  Spreading
out the threads immediately (no EAS) probably has a different impact
on these two styles of thundering herds.

>
> > +      */
> > +     sched_set_energy_aware(0);
> >       dpm_resume_noirq(PMSG_RESUME);
> >
> >   Platform_early_resume:
> > @@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state=
)
> >   Resume_devices:
> >       suspend_test_start();
> >       dpm_resume_end(PMSG_RESUME);
> > +     sched_set_energy_aware(1);
> >       suspend_test_finish("resume devices");
> >       trace_suspend_resume(TPS("resume_console"), state, true);
> >       resume_console();
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..c069c0b17cbf 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
> >       mutex_unlock(&sched_energy_mutex);
> >  }
> >
> > +void sched_set_energy_aware(unsigned int enable)
>
> bool enable?

Will do.

>
> > +{
> > +     int state;
> > +
> > +     if (!sched_is_eas_possible(cpu_active_mask))
> > +             return;
> > +
> > +     sysctl_sched_energy_aware =3D enable;
> > +     state =3D static_branch_unlikely(&sched_energy_present);
> > +     if (state !=3D sysctl_sched_energy_aware)
> > +             rebuild_sched_domains_energy();
> > +}
> > +
>
> This definitely shouldn't just overwrite
> sysctl_sched_energy_aware, otherwise you enable EAS
> for users that explicitly disabled it.

Good point. Will fix it in the next version.

Thanks for the review!

-Saravana

>
> If it ever comes to other users wanting this we might
> need a eas_pause counter so this can be nested, but
> let's just hope that's never needed.
>
> Regards,
> Christian
>

