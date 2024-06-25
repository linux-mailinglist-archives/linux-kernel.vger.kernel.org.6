Return-Path: <linux-kernel+bounces-228962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9452591691E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C28F28B2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339116D4FB;
	Tue, 25 Jun 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWyt2F4R"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EB16B72B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322629; cv=none; b=KcyEAq8Fum0oDD657oEWhFcW9QVals8C1AhJf4XVfmxb0YFRtTjc2BUmmX2G/zyVHplBhpDLnCmjmd6PWoB9KlLuaTdTWf2LBEiw6mO2teI5JyLTKGZnjwX7OZe8M/NG9g1ebfxDqVJBvVGIBX5r0WFcJCrfbNXJo9IKQWESJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322629; c=relaxed/simple;
	bh=N5IkBiZ8upF4s8YnrzmFzpvwQYID8FWiPCKApwP/lcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMYzmtgeafOf+7PKN1IaqloZ+8NwT6l7B+GrvRN1L9r4f6tSNKS1L2NdIipIzFEPQU03x2KWBjCiMxv6j4iCaMbRWsNkiyhCxrPiPSqcp+2vE3sJuNLRgpAmQfoMVUtnzmrSWxoX4r/EvSd16p0FmFAciQrd19RizESryYviWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWyt2F4R; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7180e5f735bso2346195a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719322627; x=1719927427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C2OvKfLbKYQ9emw7rPHyp0WrT4SoqNKMGYvkZT0N8Fk=;
        b=TWyt2F4RdGYWYVt6Bccfq58uF+KRzTiK5k7vFpGOiSxH/65dXhxxPepx5lb13SLy24
         9dolvqZmAOeJ34zI/pp+dAKqQ5gVdPJ4uuzzjIzT0Kbvo25HX26M2NX9ffrF98P2GMjI
         +VDyt+y/jl/t8rvEOYVxGXL5+JjiSwwJENWacUy7XenX00rROYlIGaj3FTtg1ULp/Sok
         pKYKnRfl8E4QlmtBL1wlGH0+LmxDTOPGt9FUJDzx78+e5/fpwDKYbyifozxJQCALNxpR
         Zxcft9DCFbppJqailGhAC7wP/UORHX78peR+sN3otIw8EQ52lTdzNq7K3GJeHxlqbBb+
         JzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322627; x=1719927427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2OvKfLbKYQ9emw7rPHyp0WrT4SoqNKMGYvkZT0N8Fk=;
        b=TfmH1c4UDBAzy7sq3BT8zpbOPP7a9RLLSFPC7TX+ivX8j5lPJi4SNBhU98TTK+R/9g
         PbIczD4xq0meJrmSt0VYXO4l21tWpdHJx2UKRdXh5tUjl98Wzc3t8iisDfEioLff4pp2
         /LljvoiX7np2CfAhkEubzn3IjXnj6CBxwc7OFbfJduYMZ9lJuxOZZzsScHDqEhH1XAfG
         nKI4vuKrOR4tlVdlw/v7QKA9doNedNGZUHDXC2OCZnffHUaA8d40+SkZjib3nzWHJR1e
         7taJ55Pp4fIG0aU/FkWgYxGbSnuU0yR2XEbMIIVwcltcEmDvxgHvpv+DtXD9Zb90/+PN
         +8EA==
X-Gm-Message-State: AOJu0Yw1qTAw1YLnQswGkejh55VNtZA2vyVhnL7XmEEwTzllVfErOBiS
	XpREeCyf62qxE7qO3U3r6yAmrdiB6M6WUSayAYEHC02jqZl7+GXO6iufb6CWWye5IW11a5RWmhX
	143iEe/49e4aCy2t/EB5kuKmoyjM3NPHAMz9juA==
X-Google-Smtp-Source: AGHT+IFUpRFmFsAyDpAP+biiz8JjSzqMdh8Vc8qJysZjLKWNiTk9Mn/qnf6OmxG719zI8vqX0loMQN5Zsh4IGbXO+mg=
X-Received: by 2002:a17:90a:e643:b0:2c4:e033:5187 with SMTP id
 98e67ed59e1d1-2c8a23c8bd0mr4889944a91.24.1719322626431; Tue, 25 Jun 2024
 06:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624073900.10343-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20240624073900.10343-1-dtcccc@linux.alibaba.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Jun 2024 15:36:55 +0200
Message-ID: <CAKfTPtB4vDgKmgLvgi2uo+6TwSeUzPFfmtGxZJ2_ec+jR=bynw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Make SCHED_IDLE se be preempted in strict hierarchy
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 09:39, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> Consider the following cgroup:
>                        root
>                         |
>              ------------------------
>              |                      |
>        normal_cgroup            idle_cgroup
>              |                      |
>    SCHED_IDLE task_A           SCHED_NORMAL task_B
>
> According to the cgroup hierarchy, A should preempt B. But current
> check_preempt_wakeup_fair() treats cgroup se and task separately, so B
> will preempt A unexpectedly.
> Unify the wakeup logic by {p}se_is_idle only.
>
> Also fix a bug about se_is_idle() definition when
> !CONFIG_FAIR_GROUP_SCHED.
>
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..c91cfaa7d9ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
>
>  static int se_is_idle(struct sched_entity *se)
>  {
> -       return 0;
> +       return task_has_idle_policy(task_of(se));
>  }
>
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
> @@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         if (test_tsk_need_resched(curr))
>                 return;
>
> -       /* Idle tasks are by definition preempted by non-idle tasks. */
> -       if (unlikely(task_has_idle_policy(curr)) &&
> -           likely(!task_has_idle_policy(p)))
> -               goto preempt;
> -
> -       /*
> -        * Batch and idle tasks do not preempt non-idle tasks (their preemption
> -        * is driven by the tick):
> -        */
> -       if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> +       if (!sched_feat(WAKEUP_PREEMPTION))
>                 return;
>
>         find_matching_se(&se, &pse);
> @@ -8408,6 +8399,12 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int

Replace "group" by "entity" in the comment above as it is not only
group but also entity

>                 goto preempt;
>         if (cse_is_idle != pse_is_idle)
>                 return;
> +       /*
> +        * Batch tasks do not preempt non-idle tasks (their preemption
> +        * is driven by the tick):
> +        */
> +       if (unlikely(pse == &p->se && p->policy == SCHED_BATCH))

I think I would prefer entity_is_task() which makes easier to
understand that the condition is about task

+       if (unlikely(entity_is_task(pse) &&  p->policy == SCHED_BATCH))

other than the 2 comments above

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> +               return;
>
>         cfs_rq = cfs_rq_of(se);
>         update_curr(cfs_rq);
> --
> 2.39.3
>

