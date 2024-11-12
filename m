Return-Path: <linux-kernel+bounces-405270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56869C4F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5534F1F21748
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6D20B20A;
	Tue, 12 Nov 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO46elYM"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2020B1F8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396270; cv=none; b=M0Tc+re48so/nrF2rSS0pp5j2FtAtC3KG1TpJTU7PZVamM/pXTLivMqPH9rGvNmTehtmU4Gwbpaen1Xwa5b+smnCrF4p5AgDAjwvko8DWt9iNkarsCQGLTFEzPOOIr9EmzqlhcPrfsjABNeCmLEAbd6/jy+gcg35iPhGrpt/4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396270; c=relaxed/simple;
	bh=8JAlkNRoq0eSrYPtV22XFY+LCdIfby1fw0Cq1EwFAnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGJ/e38+Caw8TL8cw5qye92JsRK//mcWEzO32pu8oxshWuw3Gc40xW/ulf06juk7mzcu68w2T2twvpF8Dh2yfOxNoeMEVlYCl85NPiOr1dQQYT/IZUTy0m9ejMPcUrIpmV/QnJFhzy+LLcf5BH8EZY7hHD7Xh+FUOu1lIrYMlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO46elYM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so4259193a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731396267; x=1732001067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JAlkNRoq0eSrYPtV22XFY+LCdIfby1fw0Cq1EwFAnw=;
        b=CO46elYM42a1OKsqV8LIEAv7aXlCJfP7q8lcwwthPWafliuBMsJPUZGgJueV4Qtg2X
         YG1OxUCdZvkL7XKm68xL59kI0tqQ5IVFwcPSqx8xow/MHEZUhBkwLwrXj/+y5BFe42VV
         pLpbKbOiPDlxrO+huChOJfBdYZgAhCl4me2hJe34hCGM9ROOTPul88SyWZ/vIaZx68ag
         cN2VFJmnqL6Yl3OFnw9y05xXhrUgNBWuKq62HTHLBB+NvIcqBDoYn8OUkCNefM8T4Tj4
         MBRCaz7lA0k9NmTID0SQbQQ490+MUJFFNGySpnalZI+BqMnnTqjlpIoiAE65eVd8L9dO
         EZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731396267; x=1732001067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JAlkNRoq0eSrYPtV22XFY+LCdIfby1fw0Cq1EwFAnw=;
        b=aJVJa+rI1amDBbO+rm8EkDV3B8avJUJJm7g/V1MI00ncIw933XkEatILjXxTwp3xDs
         c+nH3AnzrBnZCPQcWd+tmXjbh6HM/9p2ThFjyKb72654/R4SuciF8SyeW7E7Bql6SE+g
         rv2WOGZ8EPmwiPFMyWsEho7MweksSLp4gqD1qLL8BsCqg5J70aN9M3j+/M/rx1jPuqzH
         Sd91WsTgXe3QAZ/jx3p8PgKR7Ct8GOREzaPSBs7yKuELWmeh/gh/RVdbMEeyf83bexeq
         spJ7bYpgAlR6AYg3LncqEGlOlkdxYcIV4LwqsmlH10OkeDJSbet21YjuKTUdQ4Nlrtls
         sDAg==
X-Forwarded-Encrypted: i=1; AJvYcCWTbJ9sO2r8Cvlapq7FPSI60neztdXMdv+OfoPF7WUFUmaC2u3toi2zMReCPAwjllQ+P/1XZ3e0QpdkObc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNofuX8QOVmDa1IByBhjo6avU2GsL/9+VUA+QlFeN2yL9RIp31
	LQwREfBgLGArMhGdlNHT3sUxpNEE1yjoLQGnQi6pIENIDYcou4JPu0PvmP7Xm3VKvgRO/p1gqJM
	FVLMpJ74TsTD49hiPdDkvDkJpzJTCJ1zWGg5a
X-Google-Smtp-Source: AGHT+IFPmJJXxWAM3RfZsP7B7jxvKM7hhsVy7RGWBKep/B89T6ds4QjrZfKTTnn7PvUlkhWKHiGTWqcMcP5zJMfaK54=
X-Received: by 2002:a17:90b:3c42:b0:2e2:b211:a4da with SMTP id
 98e67ed59e1d1-2e9b1708091mr20035357a91.14.1731396266567; Mon, 11 Nov 2024
 23:24:26 -0800 (PST)
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
 <CAKfTPtBBq0mMat4FWPYprxZX52VFrKrrDMqvXBROuY4T-95+GQ@mail.gmail.com> <CAKfTPtB90_ywaVooR=MGfjhxz2mf=kOeEzdDWKh=7jfcuu7xQg@mail.gmail.com>
In-Reply-To: <CAKfTPtB90_ywaVooR=MGfjhxz2mf=kOeEzdDWKh=7jfcuu7xQg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 11 Nov 2024 23:23:47 -0800
Message-ID: <CAGETcx_7LYuZi356mD2j7bcZReobQE0MjoT8vdtgvdN_L2t9ww@mail.gmail.com>
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

On Mon, Nov 11, 2024 at 11:12=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 20:01, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.com> wr=
ote:
> > >
> > > On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> > > >
> > > > > I actually quickly hacked up the cpu_overutilized() function to r=
eturn
> > > > > true during suspend/resume and the threads are nicely spread out =
and
> > > > > running in parallel. That actually reduces the total of the
> > > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > > >
> > > > Right, so that kills EAS and makes it fall through to the regular
> > > > select_idle_sibling() thing.
> > > >
> > > > > Peter,
> > > > >
> > > > > Would you be open to the scheduler being aware of
> > > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > > overutilized behavior during these phases? I know it's a very use=
 case
> > > > > specific behavior but how often do we NOT want to speed up
> > > > > suspend/resume? We can make this a CONFIG or a kernel command lin=
e
> > > > > option -- say, fast_suspend or something like that.
> > > >
> > > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > > specific/targeted thing and should not affect much else, so it is a
> > > > relatively safe thing to do.
> > > >
> > > > Perhaps a more direct hack in is_rd_overutilized() would be even le=
ss
> > > > invasive, changing cpu_overutilized() relies on that getting propag=
ated
> > > > to rd->overutilized, might as well skip that step, no?
> > >
> > > is_rd_overutilized() sounds good to me. Outside of setting a flag in
> >
> > At know I'm not convinced that this is a solution but just a quick
> > hack for your problem. We must understand 1st what is wrong
>
> And you should better switch to performance cpufreq governor to
> disable eas and run at max freq if your further wants to decrease
> latency

Ohhh... now that you mention fixing CPU frequencies, a lot of systems
fix their CPU frequencies during suspend/resume. Pixel 6 is one of
them. In the case of Pixel 6, the driver sets the policy min/max to
these fixed frequencies to force the CPU to stay at one frequency.
Will EAS handle this correctly? I wonder if that'd affect the task
placement decision. Also, other systems might limit CPU frequencies in
ways that EAS can't tell. If the CPU frequencies are frozen, I'm not
sure EAS makes a lot of sense. Except maybe using CPU max capacity to
make sure little CPUs are busy first before using the big CPUs?

But even if EAS thinks the CPU freq could go up (when it can't), it
still doesn't make a lot of sense to not use those idle CPUs and
instead try to bump up the frequency (by putting more threads in a
CPU).

Anyway, with all this in mind, it makes more sense to me to just
trigger the "overutilized" mode during these specific parts of
suspend/resume.

-Saravana

>
> >
> > > sched.c that the suspend/resume code sets/clears, I can't think of an
> > > interface that's better at avoiding abuse. Let me know if you have
> > > any. Otherwise, I'll just go with the flag option. If Vincent gets th=
e
> > > scheduler to do the right thing without this, I'll happily drop this
> > > targeted hack.
> > >
> > > -Saravana

