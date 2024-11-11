Return-Path: <linux-kernel+bounces-404610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4F9C459E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00BB283493
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EE1AAE2C;
	Mon, 11 Nov 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC400pap"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965014B965
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352337; cv=none; b=pLtWyjUL2h/608R9zBwCwI2yd9Q9EVKua6fvo/4WJuMUjzxjGqbAjfeXpAKlGGXx8EXdPXhEkT0988UW4B0VHAf5J2aA7cFJLprsV4p0ac5ABe7nyzVH4vbIuAjZQyMyKmtmJb5A/42c1lRTH6sFRyKmNrg9ej7VOX0LV7Bky1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352337; c=relaxed/simple;
	bh=o8iJVODvf7LcF/eKC+p+GcC3b7QDS5bj3e6XA68aep0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m37/1EJdYno7NWtNp+7kYZvEKYeVBrrfx/TwVfO7Fdf6N1BgUBtynfj+zpHEsT8e3TQ1CngTd4vQK4AqZfTfWGM4+FYlsVuZXoGtC98oKUjFeXKLklbnnDYnUCtPNkeqsC7F2p8R3HUj+eQPQKA76D2w4rAk9rmtRcjtQmQB6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HC400pap; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so286319a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731352335; x=1731957135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8iJVODvf7LcF/eKC+p+GcC3b7QDS5bj3e6XA68aep0=;
        b=HC400pap6+GmBDaMO+PmN44vhuWle4T3uTgVom9AT4pMgQIXtkcAizVtZD8lLOTPZT
         0edOCbleUlPU1H4ijZXLT2AFqfLb4LQIBLF5OXLSGFPCtIEuxppAqfzspjRvtTymQqkK
         eh/6gbwam//foy0jnmawbFZs+n4xz3SXU22A7PJiEG4G0EhNjXA+eTBc5XjgzHliNOoH
         wmHT34yygODFeo2LWEeoWm9BwhOGtTpin8NztQ2wMB7Tg7GzolySixnrl1+hmEGtJ/f+
         MZ2w8lBtSJW5C0Ii+daCrQAf1osr6vb5IzHHH001UIAHNA3kxYRbFS0RQ1uwz0YUZEl9
         WW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352335; x=1731957135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8iJVODvf7LcF/eKC+p+GcC3b7QDS5bj3e6XA68aep0=;
        b=dhkayBhwSMq/9sB6nHIdOiwFVXZTv0zqX9qzWWSSI1UMX5cVipy9RKdOU7ns6Gi+1b
         0FNAfsgZXIY3GTktwhn/28yP+X3aOChKr2VTf55yAfF9N66jMWge3gLJL6oUkTOLhMUz
         7lU3xoCoDDGu7HE5L5aKdQTTXxHMcBWmKYuP4ZlA3T81dgZQwydatPfOVeIbi026B4f8
         RMMsLJhgt//FK+2UIw5hfXq0UmOyr9rPegY9AYKcwpL/s82AJSV5qWEuAfJuEN9ZO50+
         3NCAw9jgx1377N4sNusG3SuwJ+bnzbhhbyyuom/36BS2GQLa9O/XxUOh70QvyPVYL2h3
         Z9hg==
X-Forwarded-Encrypted: i=1; AJvYcCXHcH7fsYvMMa8zy6gAEeNJQNHm7DKQ6welm11cPfPVsV6tHkLJ5N6ONUPpGzLQ4jDrRA7xUUOl/74TTac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3eceFgX8fVFVgpy/j1xhe0ahIx+GG/Knqeaj5QIxyFHbqyt09
	hVmxjBcTYvWDevGFfIqM/uGevYROmBjEas6Y9M167RXTLKoyzr5ieQZL71Bat6F7B4Hbrk3qqFp
	fSgkbUFNK2LSkZaqk8NN2eqEbKL9pspph6xSd2w==
X-Google-Smtp-Source: AGHT+IFDm/QfKBXJlv9ZGVdtgav9/uVsDqhPq2Lvn556Xh0/jVW68lLyjDQdPrcuQ4856z2LzjpXymmFXyY5r6YJcIs=
X-Received: by 2002:a17:90a:d405:b0:2e2:a8e0:85e9 with SMTP id
 98e67ed59e1d1-2e9b172d9c9mr19666661a91.18.1731352335000; Mon, 11 Nov 2024
 11:12:15 -0800 (PST)
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
In-Reply-To: <CAKfTPtBBq0mMat4FWPYprxZX52VFrKrrDMqvXBROuY4T-95+GQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 11 Nov 2024 20:12:03 +0100
Message-ID: <CAKfTPtB90_ywaVooR=MGfjhxz2mf=kOeEzdDWKh=7jfcuu7xQg@mail.gmail.com>
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

On Mon, 11 Nov 2024 at 20:01, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.com> wrot=
e:
> >
> > On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> > >
> > > > I actually quickly hacked up the cpu_overutilized() function to ret=
urn
> > > > true during suspend/resume and the threads are nicely spread out an=
d
> > > > running in parallel. That actually reduces the total of the
> > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > >
> > > Right, so that kills EAS and makes it fall through to the regular
> > > select_idle_sibling() thing.
> > >
> > > > Peter,
> > > >
> > > > Would you be open to the scheduler being aware of
> > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > overutilized behavior during these phases? I know it's a very use c=
ase
> > > > specific behavior but how often do we NOT want to speed up
> > > > suspend/resume? We can make this a CONFIG or a kernel command line
> > > > option -- say, fast_suspend or something like that.
> > >
> > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > specific/targeted thing and should not affect much else, so it is a
> > > relatively safe thing to do.
> > >
> > > Perhaps a more direct hack in is_rd_overutilized() would be even less
> > > invasive, changing cpu_overutilized() relies on that getting propagat=
ed
> > > to rd->overutilized, might as well skip that step, no?
> >
> > is_rd_overutilized() sounds good to me. Outside of setting a flag in
>
> At know I'm not convinced that this is a solution but just a quick
> hack for your problem. We must understand 1st what is wrong

And you should better switch to performance cpufreq governor to
disable eas and run at max freq if your further wants to decrease
latency

>
> > sched.c that the suspend/resume code sets/clears, I can't think of an
> > interface that's better at avoiding abuse. Let me know if you have
> > any. Otherwise, I'll just go with the flag option. If Vincent gets the
> > scheduler to do the right thing without this, I'll happily drop this
> > targeted hack.
> >
> > -Saravana

