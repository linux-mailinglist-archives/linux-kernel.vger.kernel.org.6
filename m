Return-Path: <linux-kernel+bounces-310339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D529967B90
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 19:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95EC1F217EA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44349183CBF;
	Sun,  1 Sep 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vlRdhOCs"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892C53E15
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213116; cv=none; b=DJf598gnIzcNaCh6C+PDZS8aEu7rUiICQDwb7Sub+HugNaKfTSF0VbnLTtxeocE8bo60CbbGLIiuE5hqTAOpO/wkc0fiQ2NQ9O5LM7BbWupsqmumDPmu6xsn9Mw/FgIYxxByDIZPnbTfoFVpgFwq0SYxsQQAXQ+IS5aORgJf590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213116; c=relaxed/simple;
	bh=Tn6tHZIhVIU8zRTnyxfsgdnTgYxw83yj+IEMUQM3pv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YymaKYrwEugW8rPNaKTN7UnV4QGOZ2OsaZbrXFFREjSzpJ/YFALyPyyJ39fPM4vDlGrKLrQb+9CtvQnfOWxJo4PLK1u3YRW9//TGgrDdoFrV0ZHztOw0re8jYIaK5G+qHZ2wmvg8reihQYIr2i+mMDM911+YKbb36j6sqmHFAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vlRdhOCs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so3249655a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725213113; x=1725817913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRaHoHzfShs9AbyvrFmo6S/xkJsBUX6uusSCB+QrMFI=;
        b=vlRdhOCs75cyxVEfYdG+vGJwIyZef0z6jmPKwN+vnZOkRxXqs0/i78sUXgxzcnmF98
         7lRUMoIuPrhIGMf122IlhpgmoP/PbsJ0mnOU0GMnYybB+9dpTkJDQviqAQxmJ0cyFcQC
         9CBZQ810nnVD5vGTP14sRBkTO73n1QzuyKSxk+hJE3uD3OlP7BMTRFqW5K2QsAqcUAzL
         x1iH9Wx1dW9B+6mYAxri4WNk92JQjZsBWsYa/TT+JoOqVPuQ6pTZZZMgbB1fylZtP57I
         2LgGHVGmIhKVg993/tpfKakAmKp+Jcwe4T3HK3BjTjQn6oZSFoSpkbQxbjjU9cXItcpC
         qtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213113; x=1725817913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRaHoHzfShs9AbyvrFmo6S/xkJsBUX6uusSCB+QrMFI=;
        b=gUx7+jWy5PPHtKrXJVw2YlK19VeppLhqP+bXlpter269RaFHnjDHVO/lNJErWJbsWp
         gW+rWSkzzSQj1ibDy73+QSxEuKoFSETXZhcRi1ZcaeDtCrz3YfSGkHccbVqOXYWKpuAP
         4WOgRQ7fr1MfD4u0weWO6i34Gx0ju8C370m/p0CWb79OXDy5uX2T4Sg7JZy7kN0tNu39
         phsoZltLdglJAqglJJLYhlHzq3pY8ZE7smzuy0Gu0sFgn+U+QIoy3TpFaDHMgI5ddcgW
         7z/aRn1Zkv26QVUgfQFXBUFOo0kVO53UiuUdhBo0JpPQIzRW7SLkXgfOPGgqlcwZnD5U
         v7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUXkDL0UQXejXLk0bpIdu7b7KJ1x6Yo13jv+kASgME8b+MeyNa2AHoH5Gsk2PloIJFWF32QWHMhFzr4p2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEN4fQGFDwOV1iajj6Apr1tMz/Mz/wA8SBTiOoTtA1I/eSbgKZ
	8KVLzNEPiD3XIdIoxblVw3fjdAaulY3SODbwBBebBRWRcZL8Z7LkD1ir/u+zJxM=
X-Google-Smtp-Source: AGHT+IFRRDbGvFCHQXdboqdVjJadxSjBkeetzH05dZheYKJemWnppoFoaTieZCL7fGuQhPEAeiLn9Q==
X-Received: by 2002:a17:906:dc95:b0:a86:789f:c756 with SMTP id a640c23a62f3a-a897fa754cbmr735860166b.53.1725213113103;
        Sun, 01 Sep 2024 10:51:53 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89890219aasm460154066b.65.2024.09.01.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:51:52 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:51:49 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240901175149.46yfk335niccmfq4@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>

On 08/13/24 10:27, Vincent Guittot wrote:
> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > Hi Qais,
> > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > freq updates still bothered me so let me share my thoughts even though
> > > it might be niche enough for us not to care.
> > >
> > > 1. On fast_switch systems, assuming they are fine with handling the
> > > actual updates, we have a bit more work on each context_switch() and
> > > some synchronisation, too. That should be fine, if anything there's
> > > some performance regression in a couple of niche cases.
> > >
> > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > update request. This task will preempt whatever and currently will
> > > pretty much always be running on the CPU it ran last on (so first CPU
> > > of the PD).
> >
> > The !fast_switch is a bit of concern for me too but not for the same
> > reason and maybe the opposite of yours IIUC your proposal below:
> >
> > With fast_switch we have the following sequence:
> >
> > sched_switch() to task A
> > cpufreq_driver_fast_switch -> write new freq target
> > run task A
> >
> > This is pretty straight forward but we have the following sequence
> > with !fast_switch
> >
> > sched_switch() to task A
> > queue_irq_work -> raise an IPI on local CPU
> > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > with 1 CPU per PD)
> > sched_switch() to sugov dl task
> > __cpufreq_driver_target() which can possibly block on a lock
> > sched_switch() to task A
> > run task A
> >
> 
> sent a bit too early
> 
> > We can possibly have 2 context switch and one IPi for each "normal"
> > context switch which is not really optimal
> 
> It would be good to find a way to skip the spurious back and forth
> between the normal task and sugov

Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
Relaxing this will make it less of a problem, but won't eliminate it.

I'll have a think about it, is this a blocker for now?



