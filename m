Return-Path: <linux-kernel+bounces-311326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF2D96878C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D81F2017A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BC19E989;
	Mon,  2 Sep 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VP3FvDl7"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E619E991
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280259; cv=none; b=ila6KNwJp2FN+GGSmVubHPVg2V/cWxNxVr/rsA0pYVvx4L9jQwZ2ESUad+MNYJ/cc2rtmJOtdsRkha7d/Smmq+EaGV+sedqGnId98AbTLdiYKypjIhxiUnbbK2SLRa29yHJWozVy3wC4LcHk51xE0yIfblesdKrejrJmc/SMuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280259; c=relaxed/simple;
	bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrwJzXnzuQC/SMBsuMcL1mU4gksjUa0NwZhm+mAmfy0sCegXfb3me3kRFGtmS7t9TySIK0NHA+hsTLbHMfGGNgey7QWiSkJaSbrzYMsEKDRE3m2z0LsqPlbQGgCzywdl12y+grWzvDmWd30SrfBZMZxb4CvVxbTJZZzYivGMk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VP3FvDl7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c08b95cso37971965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725280258; x=1725885058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
        b=VP3FvDl7LaWUq0gNFeriWxYXFHLjcaFmTAAwLy9ljwYBvh+0Lfb+DnROA4IawFqy1M
         MmBHJ+JVS4/Prycq082cAX+lUFVnlx0RC3XxyciyllKQeWNGtXvKPDS9G7V8rpG6yCCw
         S9z6OgmIFfanUeA1XtejTvuCmY9m6FwPOVVG+UyYYRa80T1HjuCCHOPdLVRcDfDkjU4x
         41dlzwPElznoYc/kNSxQmXUqzAh4/3OuV2UuegooPFh2RSZaHhmANJBS3rK68GmdhNm8
         KqDfgyn5X1OUY/6GOVdIzrEV4m1dpwO0jwZkJ40Xa4Ym8kciwd+b6pKqOZnXqfEBOox2
         Dv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280258; x=1725885058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
        b=I7JciFLXZIXkzxefKqtEVXZRTQeVOkrDKYz3yLyaOZYOJanJReTlKJND0GYs0rA2vJ
         Tcx4prn4Xjl+PigK7HhGV8akRhvCY7cm+jSgZCFlxTnGkboIj9WJU6Be2qVrIaxRXgpI
         9J+GRwb0puHfzspkM196/P09wdudxp6/CM1un0YR7tCpcIGspMDoo2P68MXkKKe5RgST
         gFlKEc018jKp+FpxnZJHGmWT+95PW3+3GHJ63l+eInlSRfFZh9hnwr1tJCl6qZ6sv2Nx
         aPc8C4SD3K4yB8bpxUKVSaXqfzo6aqeQHhLx8JAHhI080xQfUJU2wVXHWWCx8Y2FmBwT
         sbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUvRelsbs9zRxnSea/N/4RlNp3nWpqD6jjWzUPNT43cn07VZnQ7P6U1i6uixLzGi1gwLPSSSS2+sWmgxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBFdeNXNX3jzSNouafU8LWa9ZIo1BgpZX3nYcq+QWlqKg/e1Y
	1GJOBLejveFIL3IYMMfKcdDvDEoZT2BbUZwTC0PyzOZFKgt4yk8layJL0ONfLN6ZjAE0IQsFOx/
	y0xmrs47mefIDdASrYpKh3gu70oPGCpa+7DIbEo0FJfZkfsbp
X-Google-Smtp-Source: AGHT+IEXvZIaAkwXaFZIyyKALQVsidIRGXrJUb6IY+ewKFKKFGwxGlpjLdLzBOWWPUKgUFSLvqbMgCdNTeaqvYqXPsw=
X-Received: by 2002:a17:902:e741:b0:205:85f1:7fb6 with SMTP id
 d9443c01a7336-20585f181admr27721715ad.23.1725280257577; Mon, 02 Sep 2024
 05:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com> <20240901175149.46yfk335niccmfq4@airbuntu>
In-Reply-To: <20240901175149.46yfk335niccmfq4@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Sep 2024 14:30:46 +0200
Message-ID: <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
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

On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 08/13/24 10:27, Vincent Guittot wrote:
> > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > > Hi Qais,
> > > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > > freq updates still bothered me so let me share my thoughts even though
> > > > it might be niche enough for us not to care.
> > > >
> > > > 1. On fast_switch systems, assuming they are fine with handling the
> > > > actual updates, we have a bit more work on each context_switch() and
> > > > some synchronisation, too. That should be fine, if anything there's
> > > > some performance regression in a couple of niche cases.
> > > >
> > > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > > update request. This task will preempt whatever and currently will
> > > > pretty much always be running on the CPU it ran last on (so first CPU
> > > > of the PD).
> > >
> > > The !fast_switch is a bit of concern for me too but not for the same
> > > reason and maybe the opposite of yours IIUC your proposal below:
> > >
> > > With fast_switch we have the following sequence:
> > >
> > > sched_switch() to task A
> > > cpufreq_driver_fast_switch -> write new freq target
> > > run task A
> > >
> > > This is pretty straight forward but we have the following sequence
> > > with !fast_switch
> > >
> > > sched_switch() to task A
> > > queue_irq_work -> raise an IPI on local CPU
> > > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > > with 1 CPU per PD)
> > > sched_switch() to sugov dl task
> > > __cpufreq_driver_target() which can possibly block on a lock
> > > sched_switch() to task A
> > > run task A
> > >
> >
> > sent a bit too early
> >
> > > We can possibly have 2 context switch and one IPi for each "normal"
> > > context switch which is not really optimal
> >
> > It would be good to find a way to skip the spurious back and forth
> > between the normal task and sugov
>
> Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> Relaxing this will make it less of a problem, but won't eliminate it.

yes, but it's not a problem of relaxing affinity here

The problem is that the 1st switch to task A will be preempted by
sugov so the 1st switch is useless. You should call cpufreq_update
before switching to A so that we skip the useless switch to task A and
directly switch to sugov 1st then task A

>
> I'll have a think about it, is this a blocker for now?
>
>

