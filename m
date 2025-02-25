Return-Path: <linux-kernel+bounces-530359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE77A43276
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E613B0778
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D752AF0B;
	Tue, 25 Feb 2025 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiC9qWIH"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C0179A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446967; cv=none; b=H/gZEMe1yJcz1I6ufwMGGrxFQBFlCl/wvZw9LMZkRcFOxpKNDpc/4TTKlofZI+voVGw9S+ncX3OTI2l6qmTZlYKu07NdHB7dAMjpIj7otFi4yPgG2KADgSIhb/9AmxB/fEkf2gzeXEGHZLGVUISxF8/fPwIjWAImqFagjZkRQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446967; c=relaxed/simple;
	bh=3sh51aaUx3b4aPbEUlJbRTDNdotlWQsr+pjjngQkBro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGpRn69ibD2LMstaVzZKFI/5LY1T/7Moh/hg0R6VLKnLdcOF1mrWF8KrJ/Bpswt46E8ARYenqICGaWZaN7HjWE3ktEAwB4M8TibJVzk5V4aLEmFLNupzVIkuU6YevXrLEEuJ0JjPb72X0RckMg1B9ZIpSAkru2aSMJNgCWE6wgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SiC9qWIH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaeec07b705so825398066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740446963; x=1741051763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3sh51aaUx3b4aPbEUlJbRTDNdotlWQsr+pjjngQkBro=;
        b=SiC9qWIHKKqXhXuPE6X6ofNzWZlooCXsx6YTDvhMEtm0imGebvyodfqfEPRzCgm9yC
         AQgDRjmCn/1PzWr8Q/SEhl03vLwzWy+1XOy3ufUA5QvzXczP1uXYw3v7+ubvvPCRUUnu
         Sq2mVjWEXVoSz2HYQeJ3a7KOdh9CiN/w+ejGh9YRlpYhJNKbWBD/TgsIVIcHh8UfoG1I
         w+wBoCyksdxv7UhiW44XNZQYzsUyqkVZe/+47Gwl/JZQ+xzfJP7EymPpzDp72vs9I3gC
         XOkZKXSsfzbKxqpr4HVKQtZ3z3T2NqtWhIhZHxPI2WrxKJBIpZB1DoxpIrWRO5XK2dVt
         pHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446963; x=1741051763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sh51aaUx3b4aPbEUlJbRTDNdotlWQsr+pjjngQkBro=;
        b=tMqyl+HNgFqrm1fFlw2zYpSbtGIW8FKwLY7yCd4ceZCk2qAtU+gYRub1bFFT48Svfm
         5xAaFH1j2WilV7h3AMK699oy4y6lIWl4rjAZA4RMYx1IBYqH41J7/ZkC9Ax8KC17MF/X
         NULyPJhNudPXuMaA01lMeFHw9pOYcHgjkwJuEjTVSGFZ2JLhTdIK4i1Iovwj4mL80/JA
         TmD1A9rGT3BnH0uI+cfyB8mssKdMmLpFY9eRP+NhHytAKb/lE/Ee8UWahGmzUqTchgAq
         pmwR3Qbmjn54ZDqd3ZMRrQ/Px/TOH9qYJXecc0BTbE25xcCe7N4+hBtq/l95Gs+FFO2o
         R19Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCMK21Y74nuEy3IMYOjDIOxYiEp0LTEemUhUbg0pMl03rpiqSDZJYqPwSG6tGD66oOPGWRJBHMcm/KP3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3X7T7e3MxLtJi2f0me7frtX7ggxZmee2BCdIaDYzVAE6ajf3
	TXQeKhqrr6XnDrdJEmL3xZ5KzETsvisv90EJ7NMeO8m7JuEl0qAIPr20EfSK40udVid1h282or1
	1GVqtqlWHzZhb1ixCAg51D87CojSRQTq72OGfyw==
X-Gm-Gg: ASbGncsryKn5Fpg3XI0cOcgLnfX8Zkp+hYK+nzFVFYrq3+YYWVZVsCnYLUn89pc1Oq4
	NOMqd587yfdDJJ2STlm9PNAVI1Co/WswhRtDdZjKLgYtCGJpHyjmkVlfxSMDf8/Z3yz807JTY3j
	LrDTwNvQa/VU5+UHTk7fsRhjBCiLivSf9UwivN
X-Google-Smtp-Source: AGHT+IGh6wuwvM01uHBnDhZndlB2D37lkKbb5XsT1qNRaHoE0fUszErLZ3l0Oplh29yWCGBV5JkPTYeO9MyTRzCseEE=
X-Received: by 2002:a17:907:98a:b0:abe:cfbd:9d39 with SMTP id
 a640c23a62f3a-abecfbd9ef2mr163893666b.22.1740446963520; Mon, 24 Feb 2025
 17:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com> <20250210012931.ym337oexdcjmwwzv@airbuntu>
 <20250210091352.GC10324@noisy.programming.kicks-ass.net> <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>
 <20250225002521.t5w2deyyw6uqxo3r@airbuntu>
In-Reply-To: <20250225002521.t5w2deyyw6uqxo3r@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Feb 2025 02:29:12 +0100
X-Gm-Features: AWEUYZnaPbu2VlMMv8Mi9Mn7Pji_TcGh7JTe5C-94HaJSqO6kys6c0__XmRTWWQ
Message-ID: <CAKfTPtDLRWVWhZ3QNEL_fQMwwh_LMZPPFcAEQ=shhRyVdmGQPg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
To: Qais Yousef <qyousef@layalina.io>
Cc: Peter Zijlstra <peterz@infradead.org>, zihan zhou <15645113830zzh@gmail.com>, bsegall@google.com, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 01:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/24/25 15:15, Vincent Guittot wrote:
> > On Mon, 10 Feb 2025 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 01:29:31AM +0000, Qais Yousef wrote:
> > >
> > > > I brought the topic up of these magic values with Peter and Vincent in LPC as
> > > > I think this logic is confusing. I have nothing against your patch, but if the
> > > > maintainers agree I am in favour of removing it completely in favour of setting
> > > > it to a single value that is the same across all systems.
> > >
> > > You're talking about the scaling, right?
> > >
> > > Yeah, it is of limited use. The cap at 8, combined with the fact that
> > > its really hard to find a machine with less than 8 CPUs on, makes the
> > > whole thing mostly useless.
> > >
> > > Back when we did this, we still had dual-core laptops. Now phones have
> > > 8 or more CPUs on.
> > >
> > > So I don't think I mind ripping it out.
> >
> > Beside the question of ripping it out or not. We still have a number
> > of devices with less than 8 cores but they are not targeting phones,
> > laptops or servers ...
>
> I'm not sure if this is in favour or against the rip out, or highlighting a new
> problem. But in case it is against the rip-out, hopefully my answer in [1]

My comment was only about the fact that assuming that systems now have
8 cpus or more so scaling doesn't make any real diff at the end is not
really true.

> highlights why the relationship to CPU number is actually weak and not really
> helping much - I think it is making implicit assumptions about the workloads and
> I don't think this holds anymore. Ignore me otherwise :-)

Then regarding the scaling factor, I don't have a strong opinion but I
would not be so definitive about its uselessness as there are few
things to take into account:
- From a scheduling PoV, the scheduling delay is impacted by largeer
slices on devices with small number of CPUs even for light loaded
cases
- 1000 HZ with 1ms slice will generate 3 times more context switch
than 2.8ms in a steady loaded case and if some people were concerned
but using 1000hz by default, we will not feel better with 1ms slice
- 1ms is not a good value. In fact anything which is a multiple of the
tick is not a good number as the actual time accounted to the task is
usually less than the tick
- And you can always set the scaling to none with tunable_scaling to
get a fixed 0.7ms default slice whatever the number of CPUs

>
> FWIW a raspberry PI can be used as a server, a personal computer, a multimedia
> entertainment system, a dumb sensor recorder/relayer or anything else. I think
> most systems expect to run a variety of workloads and IMHO the fact the system
> is overloaded and we need a reasonable default base_slice to ensure timely
> progress of all running tasks has little relation to NR_CPUs nowadays.
>
> [1] https://lore.kernel.org/all/20250210230500.53mybtyvzhdagot5@airbuntu/

