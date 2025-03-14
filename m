Return-Path: <linux-kernel+bounces-561753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21544A615BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605853AE74A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFC20127B;
	Fri, 14 Mar 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAx6f6bb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35F1FE450
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968394; cv=none; b=J2PgdygN8JtwS/sUfXNPd8mymwdNgWWvEdJNXCCX+XlKjui8d//T0fdn2UIsNoglbGAE2sOGIemQCxfhwVbhdirsNstBx9Xb8cYbuNl1y029LRIl89caPfiPAf1o+suTQJsWfAYY9sVhJImTczg2ndnpIDTBMt++f5EeJhY7U08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968394; c=relaxed/simple;
	bh=nQodReb6SDEmR9+IgZ+zc8GXEFPykk3DgMnpob+uPdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8ExL7diVBTTnoOseypqyMPOe8cwD6sd/+6EzWiigjHICZLZo9s4m5O3sYAIe0Yzqxrf2JApMcpl5xTc+IyaFsTzE1N+KGgNmYTiguKLCJ8YSa3kyO+PHv4icohHiaMpydzcT82FjrOYzuB+Q0J+3IXDnxikptqBjiQwLkO5dsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KAx6f6bb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso3377338a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741968390; x=1742573190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMGhah6DZSaD2b6XWGt1C1YnVnZDgQyITdTbZFQ5dsk=;
        b=KAx6f6bb7zbjnT2StNLhGRn3vgCKW2RZTnJHMOH7lEgRsUXiAlGIubG2Hx+Qk9HzNQ
         kTXqN2veB6NW7UO/tPm6kfp3tHH9XNefo1HVz7IR75hRw0T6M+JBO4CuaHlSY6ExCQFh
         Hxe1BvCotao0/fYxdYiZJBPhPj51N/UPxmcJCF3BkrKAf6c48M/faLPksW7HybQDStYc
         ZJ2r+MSlf9V2ePBaSAMme2qjUfMELra9UYSujd0J+vVYlE9WpbyNXareKsirp/LHvP0G
         pvW5UqoO+eJlrVYSfqwtNF+smD/P6YzxfN5WGoIQ18Sr6dNo5MWI3/0L+q8d8fBukKpa
         PYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968390; x=1742573190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMGhah6DZSaD2b6XWGt1C1YnVnZDgQyITdTbZFQ5dsk=;
        b=iubegpEA9kG8bvmIxzIxwHnp1Gr+wiDRnhjngUk4FgvwiIhvDWjbNpvsOZLV7ueFIY
         CiY0zAIIi/BTpJKmnrp9JSSwP0g8IzQC7G+6t4V17pI6alOIZU53S/3XIKemrSuhw708
         nOgEbw36oIZsbBbZrrecv+asRSBq9gZB3H79jwYcNSfaHXyAJYoxPHfukEJQgo7gaM8D
         0fA7ltBqm1EiPRC7CqGWDAZ/nBo1CINetp1W0deDeA3VUyWtvHifOEAGvwJtUfyTAXLZ
         Us/spbT0o+MPFpGYrRndQk7fJZnFi5G6Y6Mo9gdiqIK31OUQ09NeCPNuuSDAnRjeoTqK
         HOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnlQLNAyq7kPH0Mxk6K5ZlktAIjo+lGA4R6Z2WLDb186cOKP2ul3kLvWCUipOI9OsQgiSSbiiBXRXlf/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qBvzsyyjDaniaGumJs9Ujed1CQbH+Ge+L+fK/xiTaHJtGChJ
	iQQ2rfNJlMgGMWtH12VhQWd4tBnH1PVNEYzJtjPMFxfyEljYDu+McH46vfJm9B10c2mw0TmkKxJ
	cOGEgjKje4a+L44a4reEApU4hG6xvKl04RtlI/w==
X-Gm-Gg: ASbGnctLARS/jFabeAgFk6SaZb023wHz1M4xkmtY+G56wFyPCeoFFp6NisFC2y5sXLV
	XzypT5dtN5acdbgCey/WrPTt/Bjh1ZZ8ALgiC18TxRs9Iweo5iJFs0B96rYRBENBgxzzrb8ld4c
	BPBlV0TtugzmfT8b0SjhJzK0AscJnKd9Gv6wvLDL14C9Wxl40KcrxiBQ==
X-Google-Smtp-Source: AGHT+IGTAEkKQentj4nDjAW3LbI5NDMkkEyjGCVkaTPR/UZrDoWDomgvhgq/ppaIb84SJaNj9w/yM5xFp3B4q5uVqWA=
X-Received: by 2002:a05:6402:2354:b0:5e5:d9e5:c4d7 with SMTP id
 4fb4d7f45d1cf-5e8a0809fa8mr3895589a12.28.1741968389938; Fri, 14 Mar 2025
 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314151345.275739-1-dietmar.eggemann@arm.com>
In-Reply-To: <20250314151345.275739-1-dietmar.eggemann@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 14 Mar 2025 17:06:18 +0100
X-Gm-Features: AQ5f1Jo3ZCM9_W1pAy0gxZ-6G7p-QCoi5seDjnsDSFN0L_NFxNsDXoutMunxibo
Message-ID: <CAKfTPtD5Dx_3aMGWpD8MbfE--gy3j3Bgdnm=FebavA1BZh-8+Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/core: Reduce cost of sched_move_task when
 config autogroup"
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan <hagarhem@amazon.com>, 
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 16:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> This reverts commit eff6c8ce8d4d7faef75f66614dd20bb50595d261.
>
> Hazem reported a 30% drop in UnixBench spawn test with commit
> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> (aarch64) (single level MC sched domain) [1].
>
> There is an early bail from sched_move_task() if p->sched_task_group is
> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> (Ubuntu '22.04.5 LTS').
>
> So in:
>
>   do_exit()
>
>     sched_autogroup_exit_task()
>
>       sched_move_task()
>
>         if sched_get_task_group(p) == p->sched_task_group
>           return
>
>         /* p is enqueued */
>         dequeue_task()              \
>         sched_change_group()        |
>           task_change_group_fair()  |
>             detach_task_cfs_rq()    |                              (1)
>             set_task_rq()           |
>             attach_task_cfs_rq()    |
>         enqueue_task()              /
>
> (1) isn't called for p anymore.
>
> Turns out that the regression is related to sgs->group_util in
> group_is_overloaded() and group_has_capacity(). If (1) isn't called for
> all the 'spawn' tasks then sgs->group_util is ~900 and
> sgs->group_capacity = 1024 (single CPU sched domain) and this leads to
> group_is_overloaded() returning true (2) and group_has_capacity() false
> (3) much more often compared to the case when (1) is called.
>
> I.e. there are much more cases of 'group_is_overloaded' and
> 'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
> then returns much more often a CPU != smp_processor_id() (5).
>
> This isn't good for these extremely short running tasks (FORK + EXIT)
> and also involves calling sched_balance_find_dst_group_cpu() unnecessary
> (single CPU sched domain).
>
> Instead if (1) is called for 'p->flags & PF_EXITING' then the path
> (4),(6) is taken much more often.
>
>   select_task_rq_fair(..., wake_flags = WF_FORK)
>
>     cpu = smp_processor_id()
>
>     new_cpu = sched_balance_find_dst_cpu(..., cpu, ...)
>
>       group = sched_balance_find_dst_group(..., cpu)
>
>         do {
>
>           update_sg_wakeup_stats()
>
>             sgs->group_type = group_classify()
>
>               if group_is_overloaded()                             (2)
>                 return group_overloaded
>
>               if !group_has_capacity()                             (3)
>                 return group_fully_busy
>
>               return group_has_spare                               (4)
>
>         } while group
>
>         if local_sgs.group_type > idlest_sgs.group_type
>           return idlest                                            (5)
>
>         case group_has_spare:
>
>           if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
>             return NULL                                            (6)
>
> Unixbench Tests './Run -c 4 spawn' on:
>
> (a) VM AWS instance (m7gd.16xlarge) with v6.13 ('maxcpus=4 nr_cpus=4')
>     and Ubuntu 22.04.5 LTS (aarch64).
>
>     Shell & test run in '/user.slice/user-1000.slice/session-1.scope'.
>
>     w/o patch   w/ patch
>     21005       27120
>
> (b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
>     Ubuntu 22.04.5 LTS (x86_64).
>
>     Shell & test run in '/A'.
>
>     w/o patch   w/ patch
>     67675       88806
>
> CONFIG_SCHED_AUTOGROUP=y & /sys/proc/kernel/sched_autogroup_enabled equal
> 0 or 1.
>
> [1] https://lkml.kernel.org/r/20250205151026.13061-1-hagarhem@amazon.com
>
> Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
> Tested-by: Hagar Hemdan <hagarhem@amazon.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> Previous discussion under:
> https://lkml.kernel.org/r/20250306162635.2614376-1-dietmar.eggemann@arm.com
>
>  kernel/sched/core.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 621cfc731c5b..532119a3f72b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9015,7 +9015,7 @@ void sched_release_group(struct task_group *tg)
>         spin_unlock_irqrestore(&task_group_lock, flags);
>  }
>
> -static struct task_group *sched_get_task_group(struct task_struct *tsk)
> +static void sched_change_group(struct task_struct *tsk)
>  {
>         struct task_group *tg;
>
> @@ -9027,13 +9027,7 @@ static struct task_group *sched_get_task_group(struct task_struct *tsk)
>         tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
>                           struct task_group, css);
>         tg = autogroup_task_group(tsk, tg);
> -
> -       return tg;
> -}
> -
> -static void sched_change_group(struct task_struct *tsk, struct task_group *group)
> -{
> -       tsk->sched_task_group = group;
> +       tsk->sched_task_group = tg;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         if (tsk->sched_class->task_change_group)
> @@ -9054,20 +9048,11 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
>  {
>         int queued, running, queue_flags =
>                 DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> -       struct task_group *group;
>         struct rq *rq;
>
>         CLASS(task_rq_lock, rq_guard)(tsk);
>         rq = rq_guard.rq;
>
> -       /*
> -        * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
> -        * group changes.
> -        */
> -       group = sched_get_task_group(tsk);
> -       if (group == tsk->sched_task_group)
> -               return;
> -
>         update_rq_clock(rq);
>
>         running = task_current_donor(rq, tsk);
> @@ -9078,7 +9063,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
>         if (running)
>                 put_prev_task(rq, tsk);
>
> -       sched_change_group(tsk, group);
> +       sched_change_group(tsk);
>         if (!for_autogroup)
>                 scx_cgroup_move_task(tsk);
>
> --
> 2.34.1
>

