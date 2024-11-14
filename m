Return-Path: <linux-kernel+bounces-409335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6479C8BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F31FB3088A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26691FB3C0;
	Thu, 14 Nov 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz3wIEkQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADD18C32C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589610; cv=none; b=X70KrXaLtJUEkBbT+MjC2rcWWsXTxdSsrHv8FLnVrS3hn8MWGsby7r4hJy5LXbN1fEeTZn6ciQxjvkIRCSYRVxjB6fk7LzyLsMhzhYA0lbOYyoy1OY/0PUT9UXy/W5EXNwWbuCJs5NPOb2rDImYkh5kHG0fXb1atXg3dMpxNFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589610; c=relaxed/simple;
	bh=WwOImXDBX80gfUH0lg8uuNJ7CUogMKlF1SFzS1Tux7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex26dGQEWu4L/RzFU/djAnlaohpbrmnX83tFS74sAityfBzB3w37IxBSJJgrbA3cSALmctYPSgs9yqlmKEv6QA9nmX6E+R28ZO8w4Cla9HrvUjsHxWj2YNeyenKmS61I+RUFhwvfW+eIZVeffQ+IdP2wv98MMyLObhnwfsPFLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tz3wIEkQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so415408a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731589608; x=1732194408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwOImXDBX80gfUH0lg8uuNJ7CUogMKlF1SFzS1Tux7U=;
        b=Tz3wIEkQre320Ln0t92NnIZ1HOjLLykqtyVKTB7Bbu1840L9/f4tVbZ0F2XaXZcV10
         CQQYit5qQydy1t5dghMmY9n137LkVpgKgcjsZHCQjFmBxydun2F9iBvr7hGi8mfpd20x
         iC7gu6FThz9gkQe/nOfZgzZP6NVHPvzZiNMjoHJr748N2taSh2UitxAvmHMK7/KNRnya
         iVIn/nh/NYTEqGXVFV6AG02FOeNO7sZdkQ8CiwtU61v4HZAo8TsZzPiSFzLe05LErGEn
         QCRX34xXZrPpKOIRvOYjPYNI6KF0s4fTSvYIapa9UFDhKOmmKGAq86LuvGC28PDFTUUQ
         0FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589608; x=1732194408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwOImXDBX80gfUH0lg8uuNJ7CUogMKlF1SFzS1Tux7U=;
        b=bXJF3+AyJzLmsXQsztJGLgCNXGQpWgoWXq6h175L6Ui2w9D/z2HfuslMJsn60VJ/k+
         itZxZMMF+Tpyn3Iq/2GW2e1AIn5we+RNkL+2G40na16Baujke+1rh/hC0MOUxIZlcMcI
         ZH4GM83G4uE4R4wbBtPjA+rz5miDKUUBGiapUUiOZsE2hulBbrhw/7J9KxC56D81gr7/
         ng/OlvMlZsYr943GhDdaare3iQno55dZZ88hGJAdTTIMOMvsyXoh6Lp3v/LoebudjtOc
         0XednP1+tnwb1dJACcNfusKT6naCyTjYpVyrhRxmEAF08P/x240R3WKryJewDbiJO59x
         akTA==
X-Forwarded-Encrypted: i=1; AJvYcCWB4MROaBxMIyPGx64Er66dcaNN4C11ZBwxXC8Mk2MYvWKsX58XPR1du7zfpDX/4PKplK+Ve85tZeuxKuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6ziS8s6OWKoaqdMpigmqqhRHdK9TEo7UBZ4WgICc0VC/vtiw
	58Ve9W/Hpb7YYm7BuLyBFsbEwyZtVcgvp7sm6fJoXaRTZG/RHet89qT75HpTGiC0WT0vQAX7vBc
	mo20WAovHinOL5bxB8l93eTLvoGn8wqzjQ59DvQ==
X-Google-Smtp-Source: AGHT+IEntshl4SB5YU4JDzZqZ3du/7RF116gDifZ30LeEUeAPvBKjq5NqPBftK7yWq+pIvoZxXIGBDtgLXcyVJ8uoxE=
X-Received: by 2002:a17:90b:5111:b0:2e2:d87f:3cc with SMTP id
 98e67ed59e1d1-2ea0639f6b9mr1929113a91.23.1731589607809; Thu, 14 Nov 2024
 05:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <CAKfTPtCjax48zq3dzuupfrz52Q5TVF=kYSm0t35kT=E4QJGQ7w@mail.gmail.com> <CAGETcx_nVKYMhCmC6BPNVxLfDaz=uoSsk1WOs-aX=M03Ew2qTA@mail.gmail.com>
In-Reply-To: <CAGETcx_nVKYMhCmC6BPNVxLfDaz=uoSsk1WOs-aX=M03Ew2qTA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 14 Nov 2024 14:06:36 +0100
Message-ID: <CAKfTPtDtmtW7EKte9vwPUxYKfCGJuTDGudnz342p6sTDsk1qUg@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, 
	K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 at 07:37, Saravana Kannan <saravanak@google.com> wrote:
>
> Ugh... just realized that for a few of the emails I've been replying
> directly to one person instead of reply-all.
>
> On Fri, Nov 8, 2024 at 1:02=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 8 Nov 2024 at 08:28, Saravana Kannan <saravanak@google.com> wro=
te:
> > >
> > > Hi scheduler folks,
> > >
> > > I'm running into some weird scheduling issues when testing non-sched
> > > changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure i=
f
> > > this is an issue in earlier kernel versions or not.
> > >
> > > The async suspend/resume code calls async_schedule_dev_nocall() to
> > > queue up a bunch of work. These queued up work seem to be running in
> > > kworker threads.
> > >
> > > However, there have been many times where I see scheduling latency
> > > (runnable, but not running) of 4.5 ms or higher for a kworker thread
> > > when there are plenty of idle CPUs.
> >
> > You are using EAS, aren't you ?
> > so the energy impact drive the cpu selection not cpu idleness
> >
> > There is a proposal to change feec to also take into account such case
> > in addition to the energy impact
> > https://lore.kernel.org/lkml/64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.c=
om/T/
> >
> > I still have to finalize v2
>
> Anyway, I tried this series (got it from
> https://git.linaro.org/people/vincent.guittot/kernel.git/log/?h=3Dsched/r=
ework-eas)
> and:
> 1. The timing hasn't improved at all compared to not having the series.

Surprising As I can see improvements on rb5 with unbounded kworker
spreads on little cpus unlike current implementation but the use of
med and big cores waitq for little to be filled 1st which is not not
case when disable eas

> 2. There's still a lot of preemption of runnable tasks with some empty CP=
Us.

Yes, little are fully filled but med and big are used later when
utilization of little have increased

>
> For example:
> https://ui.perfetto.dev/#!/?s=3D955ff7e73edf32dab27501025211fa2ce322f725
>
> Thanks,
> Saravana
>
>
> >
> > >
> > > Does async_schedule_dev_nocall() have some weird limitations on where
> > > they can be run? I know it has some NUMA related stuff, but the Pixel
> > > 6 doesn't have NUMA. This oddity unnecessarily increases
> > > suspend/resume latency as it adds up across kworker threads. So, I'd
> > > appreciate any insights on what might be happening?
> > >
> > > If you know how to use perfetto (it's really pretty simple, all you
> > > need to know is WASD and clicking), here's an example:
> > > https://ui.perfetto.dev/#!/?s=3De20045736e7dfa1e897db6489710061d2495b=
e92
> > >
> > > Thanks,
> > > Saravana

