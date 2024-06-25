Return-Path: <linux-kernel+bounces-229269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937B916DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2BBB26A17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AD172BA4;
	Tue, 25 Jun 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNxrNQk1"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA0171E5F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331243; cv=none; b=j4b5ciyX4lif2opaiyEQcIe4FTbHvuUbkoSVQFYcqh1KswITcZhx+p3yEses2mzvOKTzFNwhAtO61ekSqSXYhM7WF3xGZZALL0HhD4dR8pyKbRiJPiVhTllnhTGEBP54KlfoSzvqhv0dzPkTacLaeTeyeYgLmxWCfcWvmz8ixJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331243; c=relaxed/simple;
	bh=ISVRDzwhcr+yv8EnigfcS97Q8bWZ/YKkxrf99pzqyHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrTNZkg6MhgHHj4poQsCBdjTgSkHB+XxpFjjwQzbmMVCBHdtZO143YPSVdFjSXz2nHVbez7jjJiBJKIW6z3diPtL0D3Zbl9omGF7GF3amL72AFatkwjKGUirfQti+doc/SV6/1tEi1tXrv6AfQfH8tMwkVYPZFQ83yHir5QcqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNxrNQk1; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80fa1509989so997016241.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719331240; x=1719936040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGAs5Wtcc8fAU8dtCBhVqU6cNJrqxGDPOZOTDG4bTWk=;
        b=fNxrNQk1mkEx4efPmSfZGGzFG2PTEddEIqDpV18XHsK/brFUhbB7DyNhBvvRmM4O1b
         cev1i1sjZNMRg2l6EqcamRP+ttuYxwLFextekP0w/w5buzpIKUL4D88DIrJT3ppMoEzI
         UWTaUZjJ/sQSHLd9rkr8GkBhZ6vu/pfPhrtUcWxODJpfGpTtSI2IZHVZqSVsLIi727QG
         /UpaFekw55AD5pkJamKGhpwNFDjD/vlGEWoI5S7+5TZVnL9BuZVuVQCYpq3ISZ/qD1Pl
         hy457ZVLzK3Q4jiNErzDfTVBoAZiebyu3AabXGJAMwQauzhKKBQtG0sKgEdI/azg2ubr
         2uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331240; x=1719936040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGAs5Wtcc8fAU8dtCBhVqU6cNJrqxGDPOZOTDG4bTWk=;
        b=EHe9289VKzAHU2fJsMiIX8NrItT/rw1O/f8idunsZ+mSe6iwm+KqhQO+sXVS7A+H7S
         jmp4S2k77QaIIpVaCezMEKBqvDlfmlLxrDBz9HW6qOrQqERoUE/aDj33sqnoYBmqiaKm
         qLd0A03VDwuGu1qYAJA8GMJX7ilfiLsqVvVmMNO+9Vprs9rKQLQ/U+0JLWDlnabjrGLb
         aTYz6J+5DUoSrW9sMDamwPzhHp1O3vCnky66n1xvDU23gPyR5Mk879k5jQ3WTrSmKALb
         FwusiGwhqPMY+G+jtUPSARqqSEnIjGBEK+/sZCS/fyQu8EZ4dqRlSEeblxKxsZgO/mlf
         XPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgIm8lQLeEF56CQ/7umroPw95B9mdekZBD40I8HrLWLh/TkTTQ8bh4LIsuOgt9hRYAjbWVBOPu/hkN7XRpXAl0YbGdx6L9B1TmMRUw
X-Gm-Message-State: AOJu0YwHzuqDEioiYLcixvaSWfHEy/DRKUgvi5FuorYJOTOPRy6nYd2o
	ksfRwJ+LeR48pMTACuhpdHi9U9Ost0hIQ8URp7kED9boj7mJ50BF9qd/zUivDHQ6YNvtPUbnjaS
	XOd1YVyImVF8u5uC472++bbn2y+9IdzhM0tJSOtG+6cYleZkSlTNpD4o=
X-Google-Smtp-Source: AGHT+IG0nu9UNAR7AZc7WRyeB2quuN3FajFGwslyoT0UUTZGqC7hJhnj0C+KxLaRtzJ2zMZg2zxGNZwQs6bwReITcP0=
X-Received: by 2002:a67:f289:0:b0:48d:a07e:d003 with SMTP id
 ada2fe7eead31-48f49a5f853mr6502317137.2.1719331240180; Tue, 25 Jun 2024
 09:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com> <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
In-Reply-To: <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 09:00:03 -0700
Message-ID: <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > Basically, I prefer that we don't skip flushing at all and keep
> > userspace and in-kernel users the same. We can use completions to make
> > other overlapping flushers sleep instead of spin on the lock.
> >
>
> I think there are good reasons for skipping flushes for userspace when
> reading these stats. More below.
>
> I'm looking at kernel code to spot cases where the flush MUST to be
> completed before returning.  There are clearly cases where we don't need
> 100% accurate stats, evident by mem_cgroup_flush_stats_ratelimited() and
> mem_cgroup_flush_stats() that use memcg_vmstats_needs_flush().
>
> The cgroup_rstat_exit() call seems to depend on cgroup_rstat_flush()
> being strict/accurate, because need to free the percpu resources.

Yeah I think this one cannot be skipped.

>
> The obj_cgroup_may_zswap() have a comments that says it needs to get
> accurate stats for charging.

This one needs to be somewhat accurate to respect memcg limits. I am
not sure how much inaccuracy we can tolerate.

>
> These were the two cases, I found, do you know of others?

Nothing that screamed at me, but as I mentioned, the non-deterministic
nature of this makes me uncomfortable and feels to me like a potential
way to get subtle bugs.

>
>
> > A proof of concept is basically something like:
> >
> > void cgroup_rstat_flush(cgroup)
> > {
> >      if (cgroup_is_descendant(cgroup, READ_ONCE(cgroup_under_flush))) {
> >          wait_for_completion_interruptible(&cgroup_under_flush->completion);
> >          return;
> >      }
>
> This feels like what we would achieve by changing this to a mutex.

The main difference is that whoever is holding the lock still cannot
sleep, while waiters can (and more importantly, they don't disable
interrupts). This is essentially a middle ground between a mutex and a
lock. I think this dodges the priority inversion problem Shakeel
described because a low priority job holding the lock cannot sleep.

Is there an existing locking primitive that can achieve this?

>
> >
> >      __cgroup_rstat_lock(cgrp, -1);
> >      reinit_completion(&cgroup->completion);
> >      /* Any overlapping flush requests after this write will not spin
> > on the lock */
> >      WRITE_ONCE(cgroup_under_flush, cgroup);
> >
> >      cgroup_rstat_flush_locked(cgrp);
> >      complete_all(&cgroup->completion);
> >      __cgroup_rstat_unlock(cgrp, -1);
> > }
> >
> > There may be missing barriers or chances to reduce the window between
> > __cgroup_rstat_lock and WRITE_ONCE(), but that's what I have in mind.
> > I think it's not too complicated, but we need to check if it fixes the
> > problem.
> >
> > If this is not preferable, then yeah, let's at least keep the
> > userspace behavior intact. This makes sure we don't affect userspace
> > negatively, and we can change it later as we please.
>
> I don't think userspace reading these stats need to be 100% accurate.
> We are only reading the io.stat, memory.stat and cpu.stat every 53
> seconds. Reading cpu.stat print stats divided by NSEC_PER_USEC (1000).
>
> If userspace is reading these very often, then they will be killing the
> system as it disables IRQs.
>
> On my prod system the flush of root cgroup can take 35 ms, which is not
> good, but this inaccuracy should not matter for userspace.
>
> Please educate me on why we need accurate userspace stats?

My point is not about accuracy, although I think it's a reasonable
argument on its own (a lot of things could change in a short amount of
time, which is why I prefer magnitude-based ratelimiting).

My point is about logical ordering. If a userspace program reads the
stats *after* an event occurs, it expects to get a snapshot of the
system state after that event. Two examples are:

- A proactive reclaimer reading the stats after a reclaim attempt to
check if it needs to reclaim more memory or fallback.
- A userspace OOM killer reading the stats after a usage spike to
decide which workload to kill.

I listed such examples with more detail in [1], when I removed
stats_flush_ongoing from the memcg code.

[1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/

