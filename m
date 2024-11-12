Return-Path: <linux-kernel+bounces-406310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D49C60A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265A2B82562
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8EE207202;
	Tue, 12 Nov 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/HHPXEA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12C205ACA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428803; cv=none; b=Y929MmpNfHay0HH1mmDSHmSVtD0txsTYka7HNqjp7d2QY4vRq1nnyJxBetHDlMDtJkgRrXOO6KHisGJOKUbY8955Mw36w675BhxkpeAGuZ5BTzBMnD0VW7gXvX0UTCavZ6xHWUKfgn5hIm4g04bDdyw4fltBaDDcb56X28wsj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428803; c=relaxed/simple;
	bh=S9W2WXz1aoFle7jMtSo9YFGjT3PLYy1KOHJi8c5DW64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADf1xW9hyIwMnIWvYa3y69xXarz9ub8EauFEOXzFMaYxmqT9H3NVShKk3fh6LsO7yYtA+wReE7UhiB2v16cJY0hK7PUz110e9i/GEUyvp2xZQWGgcClAkc3jKj/Yl4MVlqxl7hUERKelszBYibpW2z3s3yoAS9IjX2UCGxypcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/HHPXEA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cdda5cfb6so58346155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731428800; x=1732033600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBDm5YplvK1Tjp260uG3N3n5iAW+A5nynoG+NI9FCdI=;
        b=C/HHPXEA2SW03oP4RnVgFmxNylsnjmANKRt4uWBEnOH8EljY6jFtB3A/ifLjI63xHx
         CmPV7wUl/Ql6T/OK6dyuJeqzz8jQ5ET1kGFvFy3+FxmEzlpASBPDIUWT0KsTpQlR4aVJ
         CQfi73fjI9d+s1pFVjVxA60iuKCUINEJAZnZAf4veA1k0dyv3KPc5S5Du1GCoxv91fkw
         F72/gncwwZ4k5p6K6YI+JWT6aNBdY2XvQdw50SVS+VmZSll12lSi7iUbMLNyoHrbmm2d
         0q41Eyg10Sy1+GQO+uyLSyLcPDnys1ju41xlvWuJ9+5DmqLqcnW+3BcJveVyRg2h2ymB
         Nm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428800; x=1732033600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBDm5YplvK1Tjp260uG3N3n5iAW+A5nynoG+NI9FCdI=;
        b=vnZ4ZDBCoBairppC6nwww/XDB7t68GQOsFdQjFKPlgI2UPRqBujExQwpAJfE9qV0ky
         jGF8jZGKN0hlldzpNEUOLPdAcV1LxiHO1efSWJsAn8DK6qvHPddOrl/9jxjEjlchhY97
         R+MLaFRDuTLuxY30YxKJcFpnV5qWeCRXiCinQzLEHx37WaUcu5qqWz55HghMyf3Nw8w8
         2vAsDwdc32bNj2uWOtFG8MjzvadyNv3cU41/lVgAsYf/Ppn68O+L8jUY4fBFNBeChQjE
         NvBjiJkgZj6REHcdPbakhD6a8fvdWZ0UxJE8O9n8KPZ+mgJZtyRgEJXzezR8926dJeLG
         LH/A==
X-Forwarded-Encrypted: i=1; AJvYcCWtPIk9dridaZapkY78FAFHLY57J4x4paNupjAysjtFgwxNdxvAgKi//SQk7JWL1c5l+LVw7f83CXYCEtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqFQT6jXT5WPi4Epepk+vH+mTE0DFowbdOGFcfI6MsC2PAhkE
	MTpj5hgrlPyQBadik7/XXi6fOstiRBoAyO/ySmPcGkM69oQ0LZ9oSsYE1t4yNuu5V14wo5mNfJj
	H7o8XLIpDo28Occqv29ZOjhldbAB3nb2CZwg0
X-Google-Smtp-Source: AGHT+IFpm6M7L2VZIQwUnipZyu/MLtDy5Uu3vSlLx0Ppq9T51e9JZwkC8za5NU0aeFDjNXD5LXQAFLac9cPHaatZHC8=
X-Received: by 2002:a17:902:d50c:b0:20c:5cdd:aa7 with SMTP id
 d9443c01a7336-2118359ad74mr239413035ad.43.1731428800233; Tue, 12 Nov 2024
 08:26:40 -0800 (PST)
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
 <CAGETcx_7LYuZi356mD2j7bcZReobQE0MjoT8vdtgvdN_L2t9ww@mail.gmail.com> <CAKfTPtCs8wCoUvNgxNcqi5ozDiRBrLLkuA4Edi1bu1UZLsV-Vg@mail.gmail.com>
In-Reply-To: <CAKfTPtCs8wCoUvNgxNcqi5ozDiRBrLLkuA4Edi1bu1UZLsV-Vg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 12 Nov 2024 08:25:59 -0800
Message-ID: <CAGETcx-pFmBSkVfQ2tAitunb+1uZ_wE6b1+H-4jdAM_0SxJjtQ@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, Nov 12, 2024 at 1:03=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 08:24, Saravana Kannan <saravanak@google.com> wrot=
e:
> >
> > On Mon, Nov 11, 2024 at 11:12=E2=80=AFAM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 11 Nov 2024 at 20:01, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.com=
> wrote:
> > > > >
> > > > > On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@in=
fradead.org> wrote:
> > > > > >
> > > > > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote=
:
> > > > > >
> > > > > > > I actually quickly hacked up the cpu_overutilized() function =
to return
> > > > > > > true during suspend/resume and the threads are nicely spread =
out and
> > > > > > > running in parallel. That actually reduces the total of the
> > > > > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > > > > >
> > > > > > Right, so that kills EAS and makes it fall through to the regul=
ar
> > > > > > select_idle_sibling() thing.
> > > > > >
> > > > > > > Peter,
> > > > > > >
> > > > > > > Would you be open to the scheduler being aware of
> > > > > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > > > > overutilized behavior during these phases? I know it's a very=
 use case
> > > > > > > specific behavior but how often do we NOT want to speed up
> > > > > > > suspend/resume? We can make this a CONFIG or a kernel command=
 line
> > > > > > > option -- say, fast_suspend or something like that.
> > > > > >
> > > > > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > > > > specific/targeted thing and should not affect much else, so it =
is a
> > > > > > relatively safe thing to do.
> > > > > >
> > > > > > Perhaps a more direct hack in is_rd_overutilized() would be eve=
n less
> > > > > > invasive, changing cpu_overutilized() relies on that getting pr=
opagated
> > > > > > to rd->overutilized, might as well skip that step, no?
> > > > >
> > > > > is_rd_overutilized() sounds good to me. Outside of setting a flag=
 in
> > > >
> > > > At know I'm not convinced that this is a solution but just a quick
> > > > hack for your problem. We must understand 1st what is wrong
> > >
> > > And you should better switch to performance cpufreq governor to
> > > disable eas and run at max freq if your further wants to decrease
> > > latency
> >
> > Ohhh... now that you mention fixing CPU frequencies, a lot of systems
> > fix their CPU frequencies during suspend/resume. Pixel 6 is one of
> > them. In the case of Pixel 6, the driver sets the policy min/max to
> > these fixed frequencies to force the CPU to stay at one frequency.
> > Will EAS handle this correctly? I wonder if that'd affect the task
>
> AFAICT, it should

To be clear, I'm not opposed to any sched fixes that will do the right
thing naturally.

> > placement decision. Also, other systems might limit CPU frequencies in
> > ways that EAS can't tell. If the CPU frequencies are frozen, I'm not
> > sure EAS makes a lot of sense. Except maybe using CPU max capacity to
> > make sure little CPUs are busy first before using the big CPUs?
> >
> > But even if EAS thinks the CPU freq could go up (when it can't), it
> > still doesn't make a lot of sense to not use those idle CPUs and
> > instead try to bump up the frequency (by putting more threads in a
> > CPU).
>
> In this case, you just need to call the below before entering suspend
> and after resuming
>   echo 1 > /proc/sys/kernel/sched_energy_aware
> instead of hacking overutilized
> This will disable EAS without rebuilding sched domain

That disables EAS for a huge portion of the suspend/resume where we do
want it to be enabled.

Also, as I said before, I want to do this only for the "devices
resume" part where there is a lot of parallelism. Not for the entire
system suspend/resume.

Is there an in-kernel version of this call? Do I just need to set and
clear sysctl_sched_energy_aware? Also, does setting/clearing
overutilized rebuild the sched domain?

Thanks,
Saravana

>
> >
> > Anyway, with all this in mind, it makes more sense to me to just
> > trigger the "overutilized" mode during these specific parts of
> > suspend/resume.
> >
> > -Saravana
> >
> > >
> > > >
> > > > > sched.c that the suspend/resume code sets/clears, I can't think o=
f an
> > > > > interface that's better at avoiding abuse. Let me know if you hav=
e
> > > > > any. Otherwise, I'll just go with the flag option. If Vincent get=
s the
> > > > > scheduler to do the right thing without this, I'll happily drop t=
his
> > > > > targeted hack.
> > > > >
> > > > > -Saravana

