Return-Path: <linux-kernel+bounces-311427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A1968904
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C683B2213B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E36184D;
	Mon,  2 Sep 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpV0mk8H"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A619C54E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284224; cv=none; b=JXVBkivARuhbXi8gz8cYiGjRykLcudmRHcKZ4NOKjxNYKpK0ldEfiCm0DvzGBMV2CbNvIX/2TDvBUYq0ZcxCzxagDdLChjNewYeaPTY4a0UIqG84IDj0/+nd4CPorChkoX5u9H8XeC7C3e1S7P2gJnn9LM0mtLpE7aWXy5rtrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284224; c=relaxed/simple;
	bh=dKgFBPTPCLDPW+xcxCISmbsFqEFW0cs33FNM5roea3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fATrUf8CkMQwAYH2p9NdL1B/aPjnPxPsfUJo6Mb+Pond1vvSasGuiGNjkgc+AjvWh5I7DZ62xhCduVlspjkVoW2ISPZDTrxDpNbHoR8TsVsPoJAHL2hGQxgPz3RojgszU8hvPAoHHKTgc/RmS2TSHR6mR7HMzPX03C2sKgXUApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hpV0mk8H; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso1986057a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725284222; x=1725889022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dKgFBPTPCLDPW+xcxCISmbsFqEFW0cs33FNM5roea3c=;
        b=hpV0mk8HvlsZOZLjTD4Gs4Fk3+UM5PeEW96gEEzXtwU/LxqlE4GzH8EDd31KiR9Frm
         Y+o0QuZ2wiox6t7H9UMno2tddg/4M/EfMjLne3SZsJFYlokYINq2TeI4vISXf4gRT81x
         avlhe38KrLz1sHsEortLKk+jwKhC6+73YNi8md+WBnH1LhXMFSTdZ81ueDSEWdgvoLRQ
         vNUv22XQTNzk4wVWIjHpZTycWqKzykGhKRjkkDeag8H4oO3StT6GpoNeV3GxUSE3bxDw
         MgaR/3yfik6/gJ6yUtu6cY0AOOnMK24ct3aVCAd/15HEV6q7pp6SvIuO8iyL89UEFvUz
         gj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284222; x=1725889022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKgFBPTPCLDPW+xcxCISmbsFqEFW0cs33FNM5roea3c=;
        b=lVsbGT36Sy7xTVVwWYNz96JdQyAt78jIgo+ZYNwRkdW1PP+DoIox1ZpmzYmfSNyNyf
         6mZdI49glzNFBvbDUbhVwdohkVkCvoHY+E/PWe+gjenWQNDCoy9qpN12x6SNBby87Zc3
         YCys4L1gU4VceqpzE+xe/xh52tCAVnnOsjQRKK2rux66Rcz4I7s3iC9p5/iNsfAdDj5V
         lalsZkuny3Ko2uhe8SW1odQXbm3k92Nwptd7lXWzGpbB+kFCysMRFA/gQBBc4qcZa7sK
         5mRhlv0jkYcDHVaq02wZna6eybh36zk/25g+4CjcndnmisgdJfDzO9V7Cnw1Rn/LNCzz
         ouHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXF5O26COCKz37fnj1/qPNxp7IjnoYMVDeeJarFq76PxDro52wobUxptle+gMjXB4LZ5DKlquP6cQBCL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJlDexTk2m+vQ8vtcjdlhPJhtsCfdpCuHNLj87AkYmpjBQh56
	hYwOPbjc5kCXhtWT4Rb82ZEYwQ+UXJAhgQ6A56OEKmzWk01/e60xhhngBCMXp5dD5gekv78O6d8
	uaIhBetG0HnWCWGqT2RFbHkZEOUiXlm0/kk9FsPlE/GNkspuS
X-Google-Smtp-Source: AGHT+IEbpvQJofWdB/L63zkErG3AQrOMk5GCwdArxvFkwi1pwDg95bSgSzlr/VYNWZeCRErImVxWzKhQOfaLugZy+TU=
X-Received: by 2002:a17:90a:fa42:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2d856382f44mr14849679a91.33.1725284222194; Mon, 02 Sep 2024
 06:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu> <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu>
In-Reply-To: <20240902125815.vu3s25ciib34eu3a@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Sep 2024 15:36:51 +0200
Message-ID: <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 14:58, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 09/02/24 14:30, Vincent Guittot wrote:
> > On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 08/13/24 10:27, Vincent Guittot wrote:
> > > > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > > > > Hi Qais,
> > > > > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > > > > freq updates still bothered me so let me share my thoughts even though
> > > > > > it might be niche enough for us not to care.
> > > > > >
> > > > > > 1. On fast_switch systems, assuming they are fine with handling the
> > > > > > actual updates, we have a bit more work on each context_switch() and
> > > > > > some synchronisation, too. That should be fine, if anything there's
> > > > > > some performance regression in a couple of niche cases.
> > > > > >
> > > > > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > > > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > > > > update request. This task will preempt whatever and currently will
> > > > > > pretty much always be running on the CPU it ran last on (so first CPU
> > > > > > of the PD).
> > > > >
> > > > > The !fast_switch is a bit of concern for me too but not for the same
> > > > > reason and maybe the opposite of yours IIUC your proposal below:
> > > > >
> > > > > With fast_switch we have the following sequence:
> > > > >
> > > > > sched_switch() to task A
> > > > > cpufreq_driver_fast_switch -> write new freq target
> > > > > run task A
> > > > >
> > > > > This is pretty straight forward but we have the following sequence
> > > > > with !fast_switch
> > > > >
> > > > > sched_switch() to task A
> > > > > queue_irq_work -> raise an IPI on local CPU
> > > > > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > > > > with 1 CPU per PD)
> > > > > sched_switch() to sugov dl task
> > > > > __cpufreq_driver_target() which can possibly block on a lock
> > > > > sched_switch() to task A
> > > > > run task A
> > > > >
> > > >
> > > > sent a bit too early
> > > >
> > > > > We can possibly have 2 context switch and one IPi for each "normal"
> > > > > context switch which is not really optimal
> > > >
> > > > It would be good to find a way to skip the spurious back and forth
> > > > between the normal task and sugov
> > >
> > > Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> > > Relaxing this will make it less of a problem, but won't eliminate it.
> >
> > yes, but it's not a problem of relaxing affinity here
>
> If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> I am just this will be safe on all platforms of course.
>
> But yeah, I don't think this is a solution anyway but the simplest thing to
> make it harder to hit.
>
> > The problem is that the 1st switch to task A will be preempted by
> > sugov so the 1st switch is useless. You should call cpufreq_update
> > before switching to A so that we skip the useless switch to task A and
> > directly switch to sugov 1st then task A
>
> Can we do this safely after we pick task A, but before we do the actual context
> switch? One of the reasons I put this too late is because there's a late call
> to balance_calbacks() that can impact the state of the rq and important to take
> into account based on my previous testing and analysis.

I don't have all cases in mind and it would need more thinking but
this should be doable

>
> Any reason we need to run the sugov worker as DL instead for example being
> a softirq?

sugov can sleep

