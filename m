Return-Path: <linux-kernel+bounces-244362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D484392A324
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BFD1C20C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95289824A1;
	Mon,  8 Jul 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlCNFTe2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA07E0EA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442868; cv=none; b=udnnjk5+5TsaDWN9rPKF8ySKzCoPub7eZWrPijSkV4wJgGFha+U7iVDMGdebZTZhlO5c1/weRdQCdyDDD8ZegvU5QYTB4miQig69fdbrXMHb3DEA96KtfAWiLL86TdOdRMMbW8hZ9K4Cs7emBvfaUEaap/Jsiw7+XdQwM9I4etA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442868; c=relaxed/simple;
	bh=3Ak5xUBHyaHOdfMhs/mCfmmplbSl0ZIAZgXlRgGAfTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzS+yh69le09ehCGKiz0ZXlHOCMa4NU57oqnHgBgOvAtph/D5t/4y+pO5rLrMecJX5wrV0rJ0dXH7WcpTTCiB4X7+l48zHh6MTV/ivm4DZL3qJoiNJpNUXHKYZd7z3G96f4DKMe78yIoF6Z6iAoUMRpeDU6aW6+3d3Va8kmiDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlCNFTe2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb70169c23so6278105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720442866; x=1721047666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TlTxrHUn7mwk/tnpYeQaN++XyU41zDkCIyIHXuoEzmw=;
        b=UlCNFTe2gKLvTgAE79GvnpmI8Wlb5yQZVn4kwEgG0Ltcq+fBSBXv4jjWsfM/Rx9ls1
         G38acQOD+QKbZtftbseVOMxJz7mzrUdTsGMYZVwIqy8ytdnyq869kaJuOdlQun12x/12
         ITd42IxPqiZVgp6JV9bPlotyWBXjIG4H1CGUxJN2LK5MhmsHwy0z5WMnRGaRR28N760P
         mSpqckZXibBeNpmb1MIVLd+DTQybHhRWjUjzsGi0rAcKRC/WaWLGldTagVCmjrjsAHva
         mlpV90OC6QtKPhOF+B8A84GSSCHm2WCah5abf+izqtn/va1iRqpRGP25qHDbJUHJs2Sa
         tQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442866; x=1721047666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlTxrHUn7mwk/tnpYeQaN++XyU41zDkCIyIHXuoEzmw=;
        b=e067LdqIA1mBEj/Awp5Hk+17PU6ck+C20Q87LGgzlhlS7EBSwyHZpxlsGPK/AVlJY9
         0mduzrmQc4AfXlnwvq/RADrXBefDlp2Ty/8sKZpMkSqHdLpSJriF4ffm8iythoK3E3r1
         jJKVGkVWK9v7bDsg1Pd1xe9r48+6a+eEbuAYe6XsiK+yR+Au8bRuM/m2QajclosWt1TP
         UF+ANHkXvED8z73TvifW3bvQ0Fbn0rii5KJ2IEfgcveTAbL3JrJP7njEbMnwLz/fgaMN
         kwz6scZf7Rm2ZhcYwLpwh0IgGcWSti/K35BTb47dvKYYXnraVzvUXG4cokV8rLnqpb2y
         IOKw==
X-Forwarded-Encrypted: i=1; AJvYcCVzB+F2PIBvV64sldTDg6Xp2xlPpU+py8keLPoRBK/L8c+rJnHtzJ9XVWRLhTc5sRHDe+S5L0wflqPyfGDkRvWe4Ogaju/YqEZg9e7Z
X-Gm-Message-State: AOJu0YzGv59/ZD0jzK0MPoJGKPcl4nZCxgHnlToX3l5v9Fra35hOR/Op
	CDinuFIKoSbzblb+nd8kYwAQiupebcaHVd2LSHVdd01ybeAv1rECN+sZpSdFyfvqenGwbIDvPS9
	6/c1cfRko+npSfwa+sHIb4XLSyQLcGnI9mXC0gg==
X-Google-Smtp-Source: AGHT+IGgSzvZ8Vjg+cCCxFTfIyMnGzcjLhYPG5WHmlvXiHzjVsWh+Qmco5WQkXlzKtgYVsGEedDjDY9AMoeenXRSZCo=
X-Received: by 2002:a17:903:41c9:b0:1fb:57e7:5bba with SMTP id
 d9443c01a7336-1fb57e75c96mr35913635ad.20.1720442866205; Mon, 08 Jul 2024
 05:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com> <20240708120254.GA27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240708120254.GA27299@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jul 2024 14:47:34 +0200
Message-ID: <CAKfTPtDxdLpm6cC-vv1PpHaEtiOeLtuCwChgZ6Ypg6owz3Vvsw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 26, 2024 at 10:35:05AM +0800, Tianchen Ding wrote:
> > Consider the following cgroup:
> >
> >                        root
> >                         |
> >              ------------------------
> >              |                      |
> >        normal_cgroup            idle_cgroup
> >              |                      |
> >    SCHED_IDLE task_A           SCHED_NORMAL task_B
> >
> > According to the cgroup hierarchy, A should preempt B. But current
> > check_preempt_wakeup_fair() treats cgroup se and task separately, so B
> > will preempt A unexpectedly.
> > Unify the wakeup logic by {c,p}se_is_idle only. This makes SCHED_IDLE of
> > a task a relative policy that is effective only within its own cgroup,
> > similar to the behavior of NICE.
> >
> > Also fix se_is_idle() definition when !CONFIG_FAIR_GROUP_SCHED.
> >
> > Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> > Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> > Reviewed-by: Josh Don <joshdon@google.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > v2:
> > Use entity_is_task() to check whether pse is a task.
> > Improve comments and commit log.
> >
> > v1: https://lore.kernel.org/all/20240624073900.10343-1-dtcccc@linux.alibaba.com/
> > ---
> >  kernel/sched/fair.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 41b58387023d..f0b038de99ce 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
> >
> >  static int se_is_idle(struct sched_entity *se)
> >  {
> > -     return 0;
> > +     return task_has_idle_policy(task_of(se));
> >  }
> >
> >  #endif       /* CONFIG_FAIR_GROUP_SCHED */
> > @@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >       if (test_tsk_need_resched(curr))
> >               return;
> >
> > -     /* Idle tasks are by definition preempted by non-idle tasks. */
> > -     if (unlikely(task_has_idle_policy(curr)) &&
> > -         likely(!task_has_idle_policy(p)))
> > -             goto preempt;
> > -
> > -     /*
> > -      * Batch and idle tasks do not preempt non-idle tasks (their preemption
> > -      * is driven by the tick):
> > -      */
> > -     if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> > +     if (!sched_feat(WAKEUP_PREEMPTION))
> >               return;
> >
> >       find_matching_se(&se, &pse);
> > @@ -8401,7 +8392,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >       pse_is_idle = se_is_idle(pse);
> >
> >       /*
> > -      * Preempt an idle group in favor of a non-idle group (and don't preempt
> > +      * Preempt an idle entity in favor of a non-idle entity (and don't preempt
> >        * in the inverse case).
> >        */
> >       if (cse_is_idle && !pse_is_idle)
> > @@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >       if (cse_is_idle != pse_is_idle)
> >               return;
> >
> > +     /*
> > +      * Batch tasks do not preempt non-idle tasks (their preemption
> > +      * is driven by the tick).
> > +      * We've done the check about "only one of the entities is idle",
> > +      * so cse must be non-idle if p is a batch task.
> > +      */
> > +     if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
> > +             return;
>
> I'm not convinced this condition is right. The current behaviour of
> SCHED_BATCH doesn't care about pse, only p.
>
> That is, if p is SCHED_BATCH it will not preempt -- except an
> SCHED_IDLE.
>
> So I'm tempted to delete this first part of your condition and have it
> be:
>
>         if (p->policy == SCHED_BATCH)
>                 return;
>
> That is, suppose you have:
>
>                         root
>                          |
>               ------------------------
>               |                      |
>         normal_cgroup          normal_cgroup
>               |                      |
>         SCHED_BATCH task_A     SCHED_BATCH task_B
>
> Then the preemption crud will end up comparing the groups to one another
> and still allow A to preempt B -- except we explicitly do not want this.
>
> The 'problem' is that the whole BATCH thing isn't cgroup aware ofcourse,
> but I'm not sure we want to go fix that -- esp. not in this patch.
>
> Hmm?

Good question, but do we want to make SCHED_BATCH tasks behave
differently than SCHED_IDLE tasks in a group in this case ?

With this patch, we don't want task_B to preempt task_A for the case
but task_A will preempt task_B whereas task A is SCHED_IDLE

                         root
                          |
               ------------------------
               |                      |
         normal_cgroup          idle_cgroup
               |                      |
         SCHED_IDLE task_A     SCHED_NORMAL task_B

As we only look at the common level of hierarchy between the tasks,
the below will make A to preempt B whereas both are SCHED_IDLE

                         root
                          |
               ------------------------
               |                      |
         normal_cgroup          normal_cgroup
               |                      |
         SCHED_IDLE task_A     SCHED_IDLE task_B

