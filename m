Return-Path: <linux-kernel+bounces-406375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE49C5E18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E527A1F2211C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4120822E;
	Tue, 12 Nov 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0PKh1QZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39073212EE3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430865; cv=none; b=hKGIvgyF9BT3X/du3GNqAoXFZpAYjnaFz8TlTn+bHk6eCdpCy/ZtaJ4Zy3ZWOKo7X3cIKWejwtvdV2xeLSQDVnw5pNVg07/Fh+BBTFqkv057Tgv43a96uae/qOfW1rabX5mC0hryAVQtCQtfOqFCn0Zd633tNQI4glCj8SgrlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430865; c=relaxed/simple;
	bh=TaEQq/zsqzk7h8VtTv5NNw6VgKc+uuvVFtnQlq88Y4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7LV1pxKQawaW+VjhVtnzuCgCjW5omZrFxp3J+rmrEEHTkGl1HAtf49n/VllXjPBlfJXvLqWC5q9/tW2ZpUaggUhPReuMmZB0B/IKlOFmqnCOuRdwRAApqh16li4bEt4e/65VYDumalF1PEYHS1Xj0d7qwYyjADRdqHQKZ1vHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0PKh1QZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7edf2872so54768185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731430861; x=1732035661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNeVM7wN3cEFr3UimaaD8sV34evfO8MGbGDN9uNkzEY=;
        b=t0PKh1QZUJmB5T3SAu9yJNIsw5hQn+Q8r+cF1x0XdRbv/A3pT8MMlk0gbhD5K1wweX
         Jz1RUsw+32i1Uq/eoCfoo11YSXmY/CIKS5xJT22jmG8xcz2GnwyVxDYwPAdBB7T4ULLd
         34qm1kWzNVe+3u5dyJq88SPsoF+aqHHeXKirMh8ywpbslu65QpEQDnwghVfO8q1K0+MW
         cRjDgemxb29wgi4oZr/gy7bodWvzn5vtq3EV/kCab1FX9oDCnGjQVxt5fqt5FgDb7/gm
         SD5L73kejJ7T3aLjjZj4s7vZB5VKV7mEtU0npZBpu/E9tP+GFG6SG4aXBWM1nfSFaSGp
         9QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430861; x=1732035661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNeVM7wN3cEFr3UimaaD8sV34evfO8MGbGDN9uNkzEY=;
        b=P7IvsWe6ecOM5C8K/TfTTAUNeDId8cO9BY09JteZ8FYIAZmsz7NQJ5tYrcYj6uOOyr
         pRP9ojHANupoCNX63LziHLW2KxpFs/dKfa+A0tyODUdpP3QlyyqehNKRUnkl6PSDh7Ix
         mKQ5JVhSH++jfbcPfZ0rUEmUQOmJUxWJcmaVDeifg7XSiwR/WN3Qb45IBJ6H12jHRMca
         Q5N56k1iMQDSnwwZYr4K8SY+CegnkFLg/Qa21YteM0aVMPn1/tpz+ssqQlKVtfJv/AFa
         MP9K1gcO42qbHqt2w/LjXBYRSW5h+/dcUXf22P3XSa+0Af+Khzxf80k4YWtXFyghj0sr
         apdA==
X-Forwarded-Encrypted: i=1; AJvYcCWGp8yQt0rdrf4iGUtswkqbw1k1jXhGg7s4iiKKMCwfnVDTJCyA2MA0dVsEueyOUO9lixcLShzjk/5o2yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4HwFc0bulDPhXloLY1+1ELzSlqX3gXAhZh/ZPrczDDOAH/oI
	629qnv6DXhFshWg48zoNF/MRv3Z9HV/EeblZhpPunYDSDOYXmVEv0+uxHScX7gnZoPRPL9FJQv1
	gCPi0mUEWlYIPnBnY51AWnL+nifOyNkqLQ0kPtg==
X-Google-Smtp-Source: AGHT+IFq4G4UQjeS7kkwKm5qmu4RxOjLYC6PEgXZbwvky97imu0uCL18CbjqRRrtZn4NOTKpVH6H8S9//AQyrYmGctM=
X-Received: by 2002:a17:90b:2789:b0:2e2:bb32:73e7 with SMTP id
 98e67ed59e1d1-2e9b1f844damr26117058a91.15.1731430860105; Tue, 12 Nov 2024
 09:01:00 -0800 (PST)
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
 <CAKfTPtB90_ywaVooR=MGfjhxz2mf=kOeEzdDWKh=7jfcuu7xQg@mail.gmail.com>
 <CAGETcx_7LYuZi356mD2j7bcZReobQE0MjoT8vdtgvdN_L2t9ww@mail.gmail.com>
 <CAKfTPtCs8wCoUvNgxNcqi5ozDiRBrLLkuA4Edi1bu1UZLsV-Vg@mail.gmail.com> <CAGETcx-pFmBSkVfQ2tAitunb+1uZ_wE6b1+H-4jdAM_0SxJjtQ@mail.gmail.com>
In-Reply-To: <CAGETcx-pFmBSkVfQ2tAitunb+1uZ_wE6b1+H-4jdAM_0SxJjtQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Nov 2024 18:00:48 +0100
Message-ID: <CAKfTPtAyWEvVMDR4cT_nu9fw47rb-Rjm6X-C5UJE0ZRFzdROrQ@mail.gmail.com>
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

On Tue, 12 Nov 2024 at 17:26, Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Nov 12, 2024 at 1:03=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 12 Nov 2024 at 08:24, Saravana Kannan <saravanak@google.com> wr=
ote:
> > >
> > > On Mon, Nov 11, 2024 at 11:12=E2=80=AFAM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Mon, 11 Nov 2024 at 20:01, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.c=
om> wrote:
> > > > > >
> > > > > > On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@=
infradead.org> wrote:
> > > > > > >
> > > > > > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wro=
te:
> > > > > > >
> > > > > > > > I actually quickly hacked up the cpu_overutilized() functio=
n to return
> > > > > > > > true during suspend/resume and the threads are nicely sprea=
d out and
> > > > > > > > running in parallel. That actually reduces the total of the
> > > > > > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > > > > > >
> > > > > > > Right, so that kills EAS and makes it fall through to the reg=
ular
> > > > > > > select_idle_sibling() thing.
> > > > > > >
> > > > > > > > Peter,
> > > > > > > >
> > > > > > > > Would you be open to the scheduler being aware of
> > > > > > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > > > > > overutilized behavior during these phases? I know it's a ve=
ry use case
> > > > > > > > specific behavior but how often do we NOT want to speed up
> > > > > > > > suspend/resume? We can make this a CONFIG or a kernel comma=
nd line
> > > > > > > > option -- say, fast_suspend or something like that.
> > > > > > >
> > > > > > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > > > > > specific/targeted thing and should not affect much else, so i=
t is a
> > > > > > > relatively safe thing to do.
> > > > > > >
> > > > > > > Perhaps a more direct hack in is_rd_overutilized() would be e=
ven less
> > > > > > > invasive, changing cpu_overutilized() relies on that getting =
propagated
> > > > > > > to rd->overutilized, might as well skip that step, no?
> > > > > >
> > > > > > is_rd_overutilized() sounds good to me. Outside of setting a fl=
ag in
> > > > >
> > > > > At know I'm not convinced that this is a solution but just a quic=
k
> > > > > hack for your problem. We must understand 1st what is wrong
> > > >
> > > > And you should better switch to performance cpufreq governor to
> > > > disable eas and run at max freq if your further wants to decrease
> > > > latency
> > >
> > > Ohhh... now that you mention fixing CPU frequencies, a lot of systems
> > > fix their CPU frequencies during suspend/resume. Pixel 6 is one of
> > > them. In the case of Pixel 6, the driver sets the policy min/max to
> > > these fixed frequencies to force the CPU to stay at one frequency.
> > > Will EAS handle this correctly? I wonder if that'd affect the task
> >
> > AFAICT, it should
>
> To be clear, I'm not opposed to any sched fixes that will do the right
> thing naturally.

a quick try on rb5 while continuing testing my rework of eas patch
doesn't show the problem and I still need to check with current eas
version

>
> > > placement decision. Also, other systems might limit CPU frequencies i=
n
> > > ways that EAS can't tell. If the CPU frequencies are frozen, I'm not
> > > sure EAS makes a lot of sense. Except maybe using CPU max capacity to
> > > make sure little CPUs are busy first before using the big CPUs?
> > >
> > > But even if EAS thinks the CPU freq could go up (when it can't), it
> > > still doesn't make a lot of sense to not use those idle CPUs and
> > > instead try to bump up the frequency (by putting more threads in a
> > > CPU).
> >
> > In this case, you just need to call the below before entering suspend
> > and after resuming
> >   echo 1 > /proc/sys/kernel/sched_energy_aware
> > instead of hacking overutilized
> > This will disable EAS without rebuilding sched domain
>
> That disables EAS for a huge portion of the suspend/resume where we do
> want it to be enabled.
>
> Also, as I said before, I want to do this only for the "devices
> resume" part where there is a lot of parallelism. Not for the entire
> system suspend/resume.

Would this be really a problem ? You might not get the disable of eas
for your exact portion but on the other hand, you want to speedup
suspend resume.
I mean, if systems already fix frequency of cpus during suspend
resume, they can just disable eas as well. eas will be disable but
sched_asym_cpucapacity will remain enabled

>
> Is there an in-kernel version of this call? Do I just need to set and
> clear sysctl_sched_energy_aware? Also, does setting/clearing

no, it ends up updating a static key

> overutilized rebuild the sched domain?

no.

But system is not overutilized as you mentioned in your description,
you have some scheduling latency constraint on kworker threads


>
> Thanks,
> Saravana
>
> >
> > >
> > > Anyway, with all this in mind, it makes more sense to me to just
> > > trigger the "overutilized" mode during these specific parts of
> > > suspend/resume.
> > >
> > > -Saravana
> > >
> > > >
> > > > >
> > > > > > sched.c that the suspend/resume code sets/clears, I can't think=
 of an
> > > > > > interface that's better at avoiding abuse. Let me know if you h=
ave
> > > > > > any. Otherwise, I'll just go with the flag option. If Vincent g=
ets the
> > > > > > scheduler to do the right thing without this, I'll happily drop=
 this
> > > > > > targeted hack.
> > > > > >
> > > > > > -Saravana

