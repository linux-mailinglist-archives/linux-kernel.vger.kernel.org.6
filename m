Return-Path: <linux-kernel+bounces-222743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D79106A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B900E2827E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF91AD407;
	Thu, 20 Jun 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA+M7Iz5"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A348CCD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891136; cv=none; b=u9SZW2UUllF0oJ9zyGODZDjECE5dU7eM61PNkrMOHFbdXzUC62fkEq7I/gb2Lc+WuvHi0AdC8jBEXngHyQ0uLSkKc53S9dXUqIUwRVtQCvEC6Ev6WmtuN+0EYEGCBgDdJNMrHBxnfRYkJsZlNDqlh7D6WP+3tJstoaSEqPO7iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891136; c=relaxed/simple;
	bh=HOjfoGYreKZnZpmuXZ6Au7dPhxY8jwB/HRh9r1yOKuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqENaUxohGbOa05C3/S+WQAmqZnBeP8wQnUWs4W0Z4Zj+QlMEY+gF7Qw556jc1HmTvFQdcSUO/H4aRBdWFlzEghD3TMkzliITvDaE3eW4EKH8pPVC0ssnEtKE+HTSKWNSqPmKeUDxrWcGAP0ctxy0W/8dRD7e5PYPag/4WcpIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uA+M7Iz5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8062f9097so219325a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718891134; x=1719495934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AyU6deXfzId3iNKD+aWWyaHFp57zQswubmQIVn5Jzc=;
        b=uA+M7Iz5FNwrCHyvli96A1wDFgR/3cNVOY3r9/c6TYYPwGdcWT+ztuyZk8E4ubOC49
         UE3caoFXse4Lodc0ugwh0tK3xffJMNwqnT7AnXsanxqpEYaC/MdqInziyRXNsILGrmg9
         F1j9Lq5D8pi+t8Hmgev0MwEfT1pyjtPDUZuNhHWLHDeZLhyX7qbeuZsfx3kMhZG50iBi
         2OTaSvpRlXSgUgmgIIXqxa9IErBGfxCzCgEMWjf32RIYNwzZqRBu3SusUr1MBkyI35sU
         OfftVIoGtk2J+5EFXiWYhbN1pGG3MmVIRyJGATW6FJTUuWzjZDnSPHzBsuhb1COTVHJM
         nT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891134; x=1719495934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AyU6deXfzId3iNKD+aWWyaHFp57zQswubmQIVn5Jzc=;
        b=S04/vNgRCNO6pYvkDj+UgLozuTyRuHPueNlJ+m5yo6rmECrzfkULE+2TJeEyOq86h5
         NFsWb7K/1HgytIWUneqKxQ1eay85RSAbO/qfcdRDmM7z0803ADoOz24/HoZ+ujbD5Hdp
         ZT/wVk6R7NVZD/t+J7LxoXZqVigQ30HJLLYL92PKX/gs9N7BjP6MYiEY0INCrPIZ2bX6
         nk5mfF/VsswVzjAeMd0pMNhJrNWye69I1aKunAw0iqyHMDxfsG5oGxU2zT6WzSUMGOF7
         udTVlppCO0lAv3HAKpIh1YHU2yybpG+JUkEOzpFOOZB+8LcZ+d8iUT1CCzd0J+lwDh2h
         mW3A==
X-Forwarded-Encrypted: i=1; AJvYcCVnIx8I99BJlT/Y9glNDNo/WfUYFdir68/1MbiZx6D5omtjkaS/ZQ0dBy817u0jGbssSMGxtVm6bjWrHS7S34ULdliili2zKUzsP5Hs
X-Gm-Message-State: AOJu0YzwWPHqKsVUmtNcFr+wk4aKrS426NG7E4LY8mN5Gg3x6Qnph0aC
	buxK6yDCsAoBBYa5IiNdI1f38NUXVAHoA4V/eHKzDL9fCZ0yHmJ31DuZ5nqdwbnqAH+loUVaNrC
	f5A7sCg8fbRkLW0wWxHg5IS3xMck24cHJVIF8bA==
X-Google-Smtp-Source: AGHT+IEkbgWtIlRKsROVwMbvn+u4Dmp8R8VC3/t3xQgVOWqEyZY+N2hzOnvpDO7pwbuCzv9Q70Ne5sdfjJ1A5HhtY00=
X-Received: by 2002:a17:90a:f402:b0:2c3:11fb:a163 with SMTP id
 98e67ed59e1d1-2c7b57f374cmr5673149a91.6.1718891134163; Thu, 20 Jun 2024
 06:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508223456.4189689-1-joshdon@google.com>
In-Reply-To: <20240508223456.4189689-1-joshdon@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Jun 2024 15:45:23 +0200
Message-ID: <CAKfTPtAVg7_p4rXXfiO1=F1pjvAbL9V26qjHvtp2S6qBpp6LuQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: prevent unbounded task iteration in load balance
To: Josh Don <joshdon@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Zhang Qiao <zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Josh,

sorry for the delay

On Thu, 9 May 2024 at 00:35, Josh Don <joshdon@google.com> wrote:
>
> b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
> all tasks examined to that point were pinned. The goal of the patch was
> to make it more likely to be able to detach a task buried in a long list
> of pinned tasks. However, this has the unfortunate side effect of
> creating an O(n) iteration in detach_tasks(), as we now must fully
> iterate every task on a cpu if all or most are pinned. Since this load
> balance code is done with rq lock held, and often in softirq context, it
> is very easy to trigger hard lockups. We observed such hard lockups with
> a user who affined O(10k) threads to a single cpu.
>
> My initial suggestion to Vincent was to revert the original patch and
> instead bump sched_nr_migrate. However, he pointed out that we do still
> want to have a limit on the number of tasks we actually detach (which is
> an expensive operation), but still allow a deeper search.
>
> As a result of the above, this patch now separates the number of tasks
> we migrate from the number of tasks we can search. Now, the search limit
> can be raised while keeping the nr_migrate fixed.

Thanks for your patch.

I went back in the archive to remember how I came up with this patch.
I thought that it was fixing a problem raised by
zhangqiao22@huawei.com but my memory was wrong and it isn't. Instead
it's fixing a theoretical case described in the email thread:
https://lore.kernel.org/lkml/20220818083133.GA536@vingu-book/

So I wonder if it's worth adding a new debugfs entry for a case that
nobody might have ever faced or at least complained about. I know that
I asked you to go in this direction whereas you were originally
proposing a revert. After more time to think about this, I'm no longer
convinced that it's worth adding a new debugfs interface finally.

I put some comments below but maybe it would be better to simply
revert b0defa7ae03ec as nobody yet complains with this problem so far.
Let see what other will say or if someone finally faced the problem
but a revert may finally be a better option.

>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/core.c  |  3 ++-
>  kernel/sched/debug.c |  1 +
>  kernel/sched/fair.c  | 19 ++++++++++++++-----
>  kernel/sched/sched.h |  1 +
>  4 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index db4be4921e7f..820ffa9bbcfe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -144,10 +144,11 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
>  #endif /* CONFIG_SCHED_DEBUG */
>
>  /*
> - * Number of tasks to iterate in a single balance run.
> + * Max number of tasks we can move/iterate in a single balance run.
>   * Limited because this is done with IRQs disabled.
>   */
>  const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
> +const_debug unsigned int sysctl_sched_migrate_search_depth = SCHED_NR_MIGRATE_BREAK;
>
>  __read_mostly int scheduler_running;
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 168eecc209b4..d1701c98f996 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -356,6 +356,7 @@ static __init int sched_init_debug(void)
>         debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
>         debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
>         debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
> +       debugfs_create_u32("migrate_search_depth", 0644, debugfs_sched, &sysctl_sched_migrate_search_depth);
>
>         mutex_lock(&sched_domains_mutex);
>         update_sched_domain_debugfs();
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 34fe6e9490c2..b4b26f39dd45 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8764,6 +8764,9 @@ struct lb_env {
>         unsigned int            loop_break;
>         unsigned int            loop_max;
>
> +       unsigned int            num_detached;
> +       unsigned int            detach_max;
> +
>         enum fbq_type           fbq_type;
>         enum migration_type     migration_type;
>         struct list_head        tasks;
> @@ -9044,11 +9047,11 @@ static int detach_tasks(struct lb_env *env)
>
>                 env->loop++;
>                 /*
> -                * We've more or less seen every task there is, call it quits
> -                * unless we haven't found any movable task yet.
> +                * Call it quits if we're going to exceed our search limit;
> +                * we can't search indefinitely even if we've not found a
> +                * migratable task yet.
>                  */
> -               if (env->loop > env->loop_max &&
> -                   !(env->flags & LBF_ALL_PINNED))
> +               if (env->loop > env->loop_max)
>                         break;
>
>                 /* take a breather every nr_migrate tasks */
> @@ -9116,6 +9119,9 @@ static int detach_tasks(struct lb_env *env)
>                 list_add(&p->se.group_node, &env->tasks);
>
>                 detached++;
> +               env->num_detached++;

Do we really need env->num_detached field ? Can't we save remove it
and set env->detach_max = sysctl_sched_nr_migrate - ld_moved

> +               if (env->num_detached >= env->detach_max)
> +                       break;
>
>  #ifdef CONFIG_PREEMPTION
>                 /*
> @@ -11287,6 +11293,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>         env.src_cpu = busiest->cpu;
>         env.src_rq = busiest;
>
> +       env.num_detached = 0;
> +       env.detach_max = sysctl_sched_nr_migrate;
> +
>         ld_moved = 0;
>         /* Clear this flag as soon as we find a pullable task */
>         env.flags |= LBF_ALL_PINNED;
> @@ -11297,7 +11306,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                  * still unbalanced. ld_moved simply stays zero, so it is
>                  * correctly treated as an imbalance.
>                  */
> -               env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> +               env.loop_max  = min(sysctl_sched_migrate_search_depth, busiest->nr_running);
>
>  more_balance:

 +               env->detach_max = sysctl_sched_nr_migrate - ld_moved

>                 rq_lock_irqsave(busiest, &rf);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..1597175d5f0b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2539,6 +2539,7 @@ extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
>
>  extern const_debug unsigned int sysctl_sched_nr_migrate;
>  extern const_debug unsigned int sysctl_sched_migration_cost;
> +extern const_debug unsigned int sysctl_sched_migrate_search_depth;
>
>  extern unsigned int sysctl_sched_base_slice;
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

