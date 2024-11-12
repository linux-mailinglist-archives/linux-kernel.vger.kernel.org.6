Return-Path: <linux-kernel+bounces-405442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565C9C516A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CF7283231
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9820C481;
	Tue, 12 Nov 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p03Cn6nr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAF1F7092
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402213; cv=none; b=rQFMTeXggX9PaAQKAl92z4OpfJ2ZXfPyC5l/vrCTg0PBAQF1aiFgcDrGyqg2KBUg8nYbJ6K5fFANfXI0Pec3YIq6oJ3XgsoLbY8U69ljgNMtfcW54/8GS2EJeSxU7+xWQ7VCWSDTQ5lf/JhG8oYuW9Gk4aBuMlLKUevtnYg6xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402213; c=relaxed/simple;
	bh=SndNaI439ZlW5eU16756Ex0bD3YUhq33Uf6XSS8Tpbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o78rAOBdTqm9b7Z9gTmhE8l31Cv40+VJgr9U+5EE+I5K/6WfgN9/CUDI0kZX7KvWO4emyYEJj6VWvRT2nvwAbwoFV2ctgo4no1pg/x7ieXbgVWMB4X70GjorfH6cAF0VJZArGDRbk//q7CBQ8h/13MNewI4cKQcljoTvfaAwaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p03Cn6nr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so3070145a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731402211; x=1732007011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZodqYnAl+hp6b8+gPO27uullhRtjTjKBuGYhquXyG0=;
        b=p03Cn6nrkD+wSyuef5Nvk3OgLsu6M6qoajQYqjUtaFS/IL8BK9/JZBPd6fgVz6noex
         9oZgCTAwbNbnq5E+H98YleXibH2I6KvTX9+OzFfG5wSn4yXB6md3YZLFXbpezGBifbsr
         3VVPfsTDmsgN9qTPdWMtByc8AUacfRNYSpiWhx2ig8A0XgzsJkefq8nQt4H2aPKtuzrZ
         NhDRDxjxPvRWWbo1QJO94p0/NXVVNpLRyoTmjz22oFfOLgIGQiftf52AuHinYWOAYibW
         v4FDP3aRG8KjJGRM/1kOXBzjBeqF1QYYn00tJ3/GWUeLjSCdizVjumZRThHPhlGb+G/4
         ldhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731402211; x=1732007011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZodqYnAl+hp6b8+gPO27uullhRtjTjKBuGYhquXyG0=;
        b=I9I9IsVPFyqsM2dWvoEfN/kJAJU/alMlSf+cd0oPKduHVKHP0QE4twfjsXLVIIGDjb
         k/1CswNQm2WIXFuAQ4poSO8VZ6MlCS92K+XIsCc52iAZ0vXWIWieDV97E/kQjKV8w7ES
         k5AY2JXg+13EV5htWCylgOMtiiUp3nth2zsx4VzfW62xD9HlIqiQMMaclio9csgOb4Xa
         P/Bay7qZYfBkxudP+1dKv9fHTW2xHG1L96sUucQ24TZhMlB1f0/sSTToRRe+8d25exQ/
         TAFj6KdGzhXpDEHZAa+M7lh94//FILYv4V0SQVaHGpHD6oHCZ6/U7m3UxT9cyOE52lB8
         lmgw==
X-Forwarded-Encrypted: i=1; AJvYcCVl2ZLJiE9dz3KCyHRYKGoIlRJ0TlAWiA2kepxRd6vKLjOj6/kmPf3HIDBemidvRxSitje95wcRqC4CBKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU89sOtuUhO2zwe6ZFMCrk64io4LXjEE3MjyM6khwUyvi+iFcj
	sulTET334eCL06kfvwTAhZYkHsGRCYhdherh6TPUaRiRr3TmlrxZxfAvxE27TA/Ffmgj80SZVMt
	Hx87WZ+8kOVxzwQqORbmD/xNyNOmiqdkG5fqZGg==
X-Google-Smtp-Source: AGHT+IHBgdg+oJyxDVew007cJCkX64nuJzGbC3EDm5y6B/Dzp37sOvWjK5zGvZwAC4w/i8hjX3g1U1WVHjBUfcFGpOM=
X-Received: by 2002:a17:90a:f94b:b0:2e5:e33c:99c5 with SMTP id
 98e67ed59e1d1-2e9b1749339mr19105948a91.37.1731402210857; Tue, 12 Nov 2024
 01:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <20241111104054.GE22801@noisy.programming.kicks-ass.net> <CAGETcx_1uyZ3M1LtSkZDHiTwDQj8M54V-=geRqJYkZXo9ZbU6w@mail.gmail.com>
 <CAKfTPtBBq0mMat4FWPYprxZX52VFrKrrDMqvXBROuY4T-95+GQ@mail.gmail.com>
 <CAKfTPtB90_ywaVooR=MGfjhxz2mf=kOeEzdDWKh=7jfcuu7xQg@mail.gmail.com> <CAGETcx_7LYuZi356mD2j7bcZReobQE0MjoT8vdtgvdN_L2t9ww@mail.gmail.com>
In-Reply-To: <CAGETcx_7LYuZi356mD2j7bcZReobQE0MjoT8vdtgvdN_L2t9ww@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Nov 2024 10:03:19 +0100
Message-ID: <CAKfTPtCs8wCoUvNgxNcqi5ozDiRBrLLkuA4Edi1bu1UZLsV-Vg@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Nov 2024 at 08:24, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Nov 11, 2024 at 11:12=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 11 Nov 2024 at 20:01, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.com> =
wrote:
> > > >
> > > > On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> > > > >
> > > > > > I actually quickly hacked up the cpu_overutilized() function to=
 return
> > > > > > true during suspend/resume and the threads are nicely spread ou=
t and
> > > > > > running in parallel. That actually reduces the total of the
> > > > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > > > >
> > > > > Right, so that kills EAS and makes it fall through to the regular
> > > > > select_idle_sibling() thing.
> > > > >
> > > > > > Peter,
> > > > > >
> > > > > > Would you be open to the scheduler being aware of
> > > > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > > > overutilized behavior during these phases? I know it's a very u=
se case
> > > > > > specific behavior but how often do we NOT want to speed up
> > > > > > suspend/resume? We can make this a CONFIG or a kernel command l=
ine
> > > > > > option -- say, fast_suspend or something like that.
> > > > >
> > > > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > > > specific/targeted thing and should not affect much else, so it is=
 a
> > > > > relatively safe thing to do.
> > > > >
> > > > > Perhaps a more direct hack in is_rd_overutilized() would be even =
less
> > > > > invasive, changing cpu_overutilized() relies on that getting prop=
agated
> > > > > to rd->overutilized, might as well skip that step, no?
> > > >
> > > > is_rd_overutilized() sounds good to me. Outside of setting a flag i=
n
> > >
> > > At know I'm not convinced that this is a solution but just a quick
> > > hack for your problem. We must understand 1st what is wrong
> >
> > And you should better switch to performance cpufreq governor to
> > disable eas and run at max freq if your further wants to decrease
> > latency
>
> Ohhh... now that you mention fixing CPU frequencies, a lot of systems
> fix their CPU frequencies during suspend/resume. Pixel 6 is one of
> them. In the case of Pixel 6, the driver sets the policy min/max to
> these fixed frequencies to force the CPU to stay at one frequency.
> Will EAS handle this correctly? I wonder if that'd affect the task

AFAICT, it should

> placement decision. Also, other systems might limit CPU frequencies in
> ways that EAS can't tell. If the CPU frequencies are frozen, I'm not
> sure EAS makes a lot of sense. Except maybe using CPU max capacity to
> make sure little CPUs are busy first before using the big CPUs?
>
> But even if EAS thinks the CPU freq could go up (when it can't), it
> still doesn't make a lot of sense to not use those idle CPUs and
> instead try to bump up the frequency (by putting more threads in a
> CPU).

In this case, you just need to call the below before entering suspend
and after resuming
  echo 1 > /proc/sys/kernel/sched_energy_aware
instead of hacking overutilized
This will disable EAS without rebuilding sched domain

>
> Anyway, with all this in mind, it makes more sense to me to just
> trigger the "overutilized" mode during these specific parts of
> suspend/resume.
>
> -Saravana
>
> >
> > >
> > > > sched.c that the suspend/resume code sets/clears, I can't think of =
an
> > > > interface that's better at avoiding abuse. Let me know if you have
> > > > any. Otherwise, I'll just go with the flag option. If Vincent gets =
the
> > > > scheduler to do the right thing without this, I'll happily drop thi=
s
> > > > targeted hack.
> > > >
> > > > -Saravana

