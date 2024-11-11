Return-Path: <linux-kernel+bounces-404602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD79C4580
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47DB1F21CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B21AB6DA;
	Mon, 11 Nov 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHVUN8R1"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0471AA790
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351720; cv=none; b=rHZxoBCrKIuQuX9KdTIN7qmEUY4awDDDKmP9nI/aKyWe8GpTtc1kc5XM3VDzVIEHfWPP8pLvzSLBdEb35NnfL+DQRpCCltV8gj7m/A3hlcJxZgzfPtG+aQhdGb1eIziSwLXR2vd210nSCpG4qSf5aQKkxUcW1DS9pjWHwrYSonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351720; c=relaxed/simple;
	bh=z1XCHDUfA0PxGzFbFqfqqwrYK8Ux8SYswgZx5Q1cqwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpXZMwoPIcM7YehXqZZdcm9FIvKtYkaH2zpie3Zbdirtdu0GywxqZEir6/pu8+38KOsOsCLZKcZfiCoLpZHXoqEyf7obeIlbxWQOPY9q+cL7mp7plUy5tpGrX5aazpT2kF+aUlFIeKCrRjWvhEDHwjovZiG8rCJsN49xc1zTeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHVUN8R1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so3452303a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731351718; x=1731956518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1XCHDUfA0PxGzFbFqfqqwrYK8Ux8SYswgZx5Q1cqwo=;
        b=CHVUN8R1PZM/KgP7Hq72omn4QzUSgeEfKEb92/HStIRFuqQwe1viyZPPrv2yR1K789
         wvCaLwTWhE4FQoPVkTq55nhYMF1y/gjCf7LBv4umfeEBp9B8VIqma6kBdUZBsQnU7r06
         7eNUrQ66d5bebgtrYPullu3bPe1Gb3k18JPsOJuYOhzyfRuIiFm1zbTJdJafFPz0NPsH
         7Q3dnp+rNejL1I4r8Ca+Q9G5FW6vTN2nxct4aepvHWlfbPNPFwX6LyZJpWqMowMC4KSt
         KKz5k9z+GPDyEZszWVytvETxhmLgn4Y0Eqc77dmwfW4tohFFaHRme74QAA04xI34ZuK0
         wo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731351718; x=1731956518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XCHDUfA0PxGzFbFqfqqwrYK8Ux8SYswgZx5Q1cqwo=;
        b=VsYdoHopgpFja90dvvilW/r//Xnl6wYDnMvGoWSxu8rOnEGt/eUGMrONBmJkps6Wd4
         bPnB95E84GlslyUiyHcJJrPk9XvPyOnFOx0Uf9iUn03HRTMriVTwqiAdwk3qqKrj9Eqj
         yXSf3tIhuvaBVA7uqwKUFFuHllekZ2XPJh+NKi7yhgVsk51W78w2V2wljyTIPSY+NR2+
         VreHvL1oB+cuJCXV6NUvQylTbaxAA0RvCCmb+4nhV1RnCuHYdCx/AQGrIJz4p0tkERJX
         ZZI8z/+HTc86yqXsrsakq2YLTLbP+/bB7VS18zRU9vYfQBXvrGmWpn2S+dWF902FHKsx
         4dEg==
X-Forwarded-Encrypted: i=1; AJvYcCXA6wgRVROPbfsElRGOdHq7xNyWe702lG7OVEa3xxo4kNWuJgwtYlkV/67ZNZwn+zEJ321YsFqkgpIUcTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6L6Lvw6L8dDlTxvfg2XhJKSQrUhSlItZCwYwaP27wPD1qLkkT
	ycD2Ftvn9EZ/Mp0s4qZ+H2p8jLeeEVJIJHdGidizqafi0JSRbijgaKAXKIWl3wRMsyBf/fQT8qF
	7FziC8UFW/ozEWzm7v6LM/t1H1MQ3rebJcqg3Qg==
X-Google-Smtp-Source: AGHT+IFOr2IGuH7hA9mN4t/v3mgjzevZv3iyvqAr2lDpBhkMF4UQN4c+N55CzmYNO1W2w3fv3gBA1zRlScgIdP/HAoQ=
X-Received: by 2002:a17:90b:17cc:b0:2e2:af54:d2fe with SMTP id
 98e67ed59e1d1-2e9b178fe12mr18200196a91.34.1731351718325; Mon, 11 Nov 2024
 11:01:58 -0800 (PST)
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
In-Reply-To: <CAGETcx_1uyZ3M1LtSkZDHiTwDQj8M54V-=geRqJYkZXo9ZbU6w@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 11 Nov 2024 20:01:47 +0100
Message-ID: <CAKfTPtBBq0mMat4FWPYprxZX52VFrKrrDMqvXBROuY4T-95+GQ@mail.gmail.com>
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

On Mon, 11 Nov 2024 at 19:24, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> >
> > > I actually quickly hacked up the cpu_overutilized() function to retur=
n
> > > true during suspend/resume and the threads are nicely spread out and
> > > running in parallel. That actually reduces the total of the
> > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> >
> > Right, so that kills EAS and makes it fall through to the regular
> > select_idle_sibling() thing.
> >
> > > Peter,
> > >
> > > Would you be open to the scheduler being aware of
> > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > overutilized behavior during these phases? I know it's a very use cas=
e
> > > specific behavior but how often do we NOT want to speed up
> > > suspend/resume? We can make this a CONFIG or a kernel command line
> > > option -- say, fast_suspend or something like that.
> >
> > Well, I don't mind if Vincent doesn't. It seems like a very
> > specific/targeted thing and should not affect much else, so it is a
> > relatively safe thing to do.
> >
> > Perhaps a more direct hack in is_rd_overutilized() would be even less
> > invasive, changing cpu_overutilized() relies on that getting propagated
> > to rd->overutilized, might as well skip that step, no?
>
> is_rd_overutilized() sounds good to me. Outside of setting a flag in

At know I'm not convinced that this is a solution but just a quick
hack for your problem. We must understand 1st what is wrong

> sched.c that the suspend/resume code sets/clears, I can't think of an
> interface that's better at avoiding abuse. Let me know if you have
> any. Otherwise, I'll just go with the flag option. If Vincent gets the
> scheduler to do the right thing without this, I'll happily drop this
> targeted hack.
>
> -Saravana

