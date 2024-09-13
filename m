Return-Path: <linux-kernel+bounces-328135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FF977F49
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB7E1F21587
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAF1D9324;
	Fri, 13 Sep 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA79J4ew"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C631D88DD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229404; cv=none; b=ppdQlBB7Mojr8OEyPibyEcxRII3QZ5cI3bHNlxLDUAjQV0cM4SC5p3EIWjrfdQGAz/jb4aQNB2+IqAZ8AA/XGUpvD85C7BzbYbfQGs2VHGjCpIwnntDVOySwSToOZgUcOVaAQV32o+dh+/Y5yrO1FVdRoFNpKQeXpTFDUslsz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229404; c=relaxed/simple;
	bh=RVBFsKRHivW7wS0uIf4XmR++ZKHGlfVvI9BxxXs1Bkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYGXSPCDrdp/FskJ4BviXR9W8OJfpzhNBJhRHovPh1ELCRdHOXxA9xTpZ1O4UihWGUu5xSlTqUVWTkwvF4wmPW/vI9SsTdoC9La96L/HydCiazE7HMahV/9xX3O2ZVQphKjPXDgU2XrC2tJlmh0mHxh1eOOV5dRKmh/GCRF6bGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA79J4ew; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1536805a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726229402; x=1726834202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVBFsKRHivW7wS0uIf4XmR++ZKHGlfVvI9BxxXs1Bkw=;
        b=DA79J4ewoyNXuj0y09nb6SHeW2KLGXJ11QZlgstLdDOLdcTa0qhxvNGSLBpwwliDfN
         68pTf4et1aSoqusv2Z4Z9966iCZSVAF6ZABjZv+WTQ2rrxEHennFc/3VuzX2I1JAubq7
         z7PXWo3L1i/cWIyapHLpi4QOqfJ13tNFe64luR7MOFWHzaL359Z/4rePz2XvSMcmRrNv
         5W8AhYpHEsikMDL0fBNWXK216UYvxw0gLKvjdDf1nUzrAvskvOMJGBotljMeErVB40BO
         gOKVjzpOMAQGtUzdFOZeKcA2/FFm09eES5A/3wF3HkybzVqrNxyWflocgeu0NNM7kbiB
         AW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229402; x=1726834202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVBFsKRHivW7wS0uIf4XmR++ZKHGlfVvI9BxxXs1Bkw=;
        b=d2Qhyuz/O1WIHte32dZ364niGHWY1htWTfy2CabKUts7rdzCudIspfmj31a35uxVFC
         MVXAj141g1Jb+iSzSm5gJpGMuSQgPWizBqX4Q2wqWU6JZYU1NpXbPfnBw07S9kw6JG8b
         FdO+vEibhBAs8YSJKfI6crv/m3wHx2cRh9AsdxfgY14RYzaahI2VZFYkpwvO0G+YJch4
         TqEhmUoPHM4/JAd4NkYMivrUIM5yRyS6cfojNqmCeXYyyNdJ4y/vv81KeqpXDxDZRdUx
         Tjdl31HaY4vp1l/eaLDPtFhqGGwSw8+Bf8CksTfTDD8rK9CNnCoLrEkob2qtAxpO5UZ2
         hQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUSxp3fzwUMrjX8uA2w7psEJ5o3GQT+gPLHAJmoJohhtSByEgp7Q0azHq2XznU1zmGy/5tKyY8z6aDmaVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3d2JmF3clpfZ0JlN5iuEKmc3TOGnj+yV1yntVXDwB/vUaiLn
	jIltcSE4+zvWXenv/l2iDEpw32H6XiJ01U61e7pprx/5RQ+uEGfh4E86xy7NZkhT7fxoeWbbtAD
	0wNRSO+MZKJrmvODnL7y8YR7ETeIIBDpBo/Kc
X-Google-Smtp-Source: AGHT+IEC73WGRbYNDi25kqGj4Gj8f6UkyfsTXwUWZe7ltTL9Tzoe7ToEYY/JQx/u7bcJ4ek+vcoFa9/so8xyi0qdIq4=
X-Received: by 2002:a17:90a:8814:b0:2d8:94d6:3499 with SMTP id
 98e67ed59e1d1-2dba0068106mr6358748a91.37.1726229401632; Fri, 13 Sep 2024
 05:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909211506.326648-1-mathieu.desnoyers@efficios.com>
 <20240909211506.326648-2-mathieu.desnoyers@efficios.com> <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
 <0edc398e-d193-4c2d-907e-f5db93143f79@efficios.com>
In-Reply-To: <0edc398e-d193-4c2d-907e-f5db93143f79@efficios.com>
From: Marco Elver <elver@google.com>
Date: Fri, 13 Sep 2024 14:09:25 +0200
Message-ID: <CANpmjNOPJm7nfzuF2VXLmixBZ0ygQ84AkxG8jH0E79XzWPu8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Valentin Schneider <vschneid@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 19:34, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-09-12 12:38, Marco Elver wrote:
> > On Mon, 9 Sept 2024 at 23:15, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> >> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
> >> a reference to the concurrency id allocated for each CPU. This reference
> >> expires shortly after a 100ms delay.
> >>
> >> These per-CPU references keep the per-mm-cid data cache-local in
> >> situations where threads are running at least once on each CPU within
> >> each 100ms window, thus keeping the per-cpu reference alive.
> >
> > One orthogonal idea that I recall: If a thread from a different thread
> > group (i.e. another process) was scheduled on that CPU, the CID can
> > also be invalidated because the caches are likely polluted. Fixed
> > values like 100ms seem rather arbitrary and it may work for one system
> > but not another.
>
> That depends on the cache usage pattern of the different thread group:
> it's also possible that the other thread group does not perform that
> many stores to memory before the original thread group is scheduled
> back, thus keeping the cache content untouched.
>
> The ideal metric there would probably be based on PMU counters, but
> I doubt we want to go there.
>
> [...]
> >
> > I like the simpler and more general approach vs. the NUMA-only
> > approach! Attempting to reallocate the previously assigned CID seems
> > to go a long way.
>
> Indeed it does!
>
> >
> > However, this doesn't quite do L3-awareness as mentioned in [1], right?
> > What I can tell is that this patch improves cache locality for threads
> > scheduled back on the _same CPU_, but not if those threads are
> > scheduled on a _set of CPUs_ sharing the _same L3_ cache. So if e.g. a
> > thread is scheduled from CPU2 to CPU3, but those 2 CPUs share the same
> > L3 cache, that thread will get a completely new CID and is unlikely to
> > hit in the L3 cache when accessing the per-CPU data.
> >
> > [1] https://github.com/google/tcmalloc/issues/144#issuecomment-2307739715
> >
> > Maybe I missed it, or you are planning to add it in future?
>
> In my benchmarks, I noticed that preserving cache-locality at the L1 and
> L2 levels was important as well.
>
> I would like to understand better the use-case you refer to for L3
> locality. AFAIU, this implies a scenario where the scheduler migrates
> a thread from CPU 2 to CPU 3 (both with the same L3), and you would
> like to migrate the concurrency ID along.

Either migrate it along, _or_ pick a CID from a different thread that
ran on a CPU that shares this L3. E.g. if T1 is migrated from CPU2 to
CPU3, and T2 ran on CPU3 before, then it would be ok for T1 to get its
previous CID or T2's CID from when it ran on CPU3. Or more simply,
CIDs aren't tied to particular threads, but tied to a subset of CPUs
based on topology. If the user could specify that topology / CID
affinity would be nice.

> When the number of threads is < number of mm allowed cpus, the
> migrate hooks steal the concurrency ID from CPU 2 and moves it to
> CPU 3 if there is only a single thread from that mm on CPU 2, which
> does what you wish.

Only if the next CPU shares the cache. What if it moves the thread to
a CPU where that CPU's L3 cache != the previous CPU's L3 cache. In
that case, it'd be preferable to pick a last-used CID from the set of
CPUs that are grouped under that L3 cache.

> When the number of threads is >= number of mm allowed cpus, the
> migrate hook is skipped, and the concurrency ID from CPU 2 is
> left in place, favoring cache locality at L1/L2 levels.

... and any higher level caches, too, I'd assume.

> In that
> case it's the scheduler's decision to migrate the thread from
> CPU 2 to CPU 3, so I would think improving the scheduler decisions
> about migration and minimizing thread movement would be more
> relevant than trying to optimize concurrency ID movement.

From what I gather, if the CID is left in place on a CPU, and the next
thread just grabs it, that's already optimal AFAIK.

Thanks,
-- Marco

