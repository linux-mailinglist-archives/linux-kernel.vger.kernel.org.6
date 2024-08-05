Return-Path: <linux-kernel+bounces-274733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE9947C07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E8E281971
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8415381DF;
	Mon,  5 Aug 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNwEsPZ5"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF423A6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865289; cv=none; b=qHxT5FVWMBG68pNafX1XhLW2okoKTBHl/nPKxXugBPwnztOy4MWBCpcPfwn77PlNtx6zo9vh3U2KBg6aScBaFN01IU37EMAU/vtsDDh6x5NiV/AP5Krar8jXIknjpXuzCir51Z+EYFvEpUrHV61zMFVtTj+YZ6snJZ1ppvEcN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865289; c=relaxed/simple;
	bh=28kjmTSx7M98OTHTuQyRz1LftvNLpOUI7JdTGc4Jiwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otQHOfHY2u+I5ro6PlEUCUtaRwq+1i0RJ1P2WEbfz3Siw7+tSkRhYNXQ1Zuo8PEvSYs8hm7Teu0xSCugcBYZscmE7ApxXuuTf9fdweQHU/LayaqVTaGFvz7iZt7Go1+/VKjTfJfZR7MttGW3mTRbgSFZnwwjkRdtUynMxa6eYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BNwEsPZ5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ab09739287so6197810a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722865287; x=1723470087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZYPQSCyJXg1ozs25bIVk6AB+xRavDU5HPNTPw9NJ5U=;
        b=BNwEsPZ5YzhC6PR3Yk9TGg0+AVTUos2RqbrnkydYwPc6zh3Amn/L95sBIw04GRLse7
         DG5j1DvIClavMGlParHy0OteB/2ZrmhvAD1cBHS8jY7V1Je6FPE7bgoSfjhTL2kJ6OCP
         BNGg3cV04NXH/57UauLQHGU3yHb2sv4tnlLZ70th3umw2J55d/0oT+UzZJc2QDQwYxR1
         6KVv7QtOCxGBgz4xZysPBNP5pOyK23hbeM2hAFI9BOQXvrANJrV/DibesWD/Qww+D8o9
         AEOU+GbpsdgJxQ9Ax/VE+0qrifwHJ+bWoDAzNLLqVyjcsOMqvvfBlRkn14iLBgc0V8b6
         3+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722865287; x=1723470087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZYPQSCyJXg1ozs25bIVk6AB+xRavDU5HPNTPw9NJ5U=;
        b=aIYGEYZBhN8ywDLyE6GZ8JQBJd08+izxBBvOtfOKy8Kin7TIbqLwqECedq5Gnz+qzC
         wvIC+aUdE1BZZtcuYCy+vDWS9EMDzGzz7OeSuFoU673+ccyFsIECWlM/x/WNoePrevAE
         IXOF9JUNvIc0hPYP53i058HYCbEBOhQ7A9S2c3nsX5pa6XcYndBY0rdyK2GaeGBL68FR
         wIXuRuNbHXs0fHeah7CNA9DBasMr/VjRmZTCwuGE4nqHFXWkmRhVpcY+wpjs83jSJZ+I
         V6KOiGKvBln/LLBpLLVuuE914jNspVZQ7BXtEq9unXHC+pGPDf6UKvFuCAaLOVBGODUS
         NGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdK851yYMNtqUBMCjqWshLlKwtDG7Pt6XjB7AjUxxweDpd0aAsGYylYVTm1eHSzOUitKCknCTgtxjmJ5HuZC676kYkmL3wIpmdg5s/
X-Gm-Message-State: AOJu0Yw7XoBSM9q4xLPKtqR7z8pdEjfxSvadKFKFSeCrkhKMFujrDxnI
	eXUVRlHbr57AJkRW3zA7Eei+Sz1Xb4sxrHgv2wU8L+8oMMtgaqbpRSWVfwRCrdPI2Ca06Fjmn8E
	dJJORr5MjFn7e5TJsJJidh1g1w2arVDgMF/ThJQ==
X-Google-Smtp-Source: AGHT+IFYaDtYp6d8qAZBOzpBZF7epYRUQyxY2Woz8jZsI3j49dWSXng5zUxCWdmSYD/be2rR0PAVum0kSd5L2P0c6c4=
X-Received: by 2002:a17:90a:474c:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2cff9432df7mr9689186a91.15.1722865287241; Mon, 05 Aug 2024
 06:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729104616.180445-1-zhouchuyi@bytedance.com>
In-Reply-To: <20240729104616.180445-1-zhouchuyi@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 5 Aug 2024 15:41:15 +0200
Message-ID: <CAKfTPtA4VRDzvbKC11rhbkFECMNvbFdWkf2n4pk=AehBUgRxvQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Sync se's load_avg with cfs_rq in reweight_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chengming.zhou@linux.dev, 
	linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 12:47, Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>
> In reweight_task(), there are two situations:
>
> 1. The task was on_rq, then the task's load_avg is accurate because in
> __sched_setscheduler()/set_user_nice(), we would dequeue the on_rq tasks
> before doing reweight. The task's load_avg would be synchronized with
> cfs_rq through update_load_avg() in dequeue_task().
>
> 2. The task is sleeping, its load_avg might not have been updated for some
> time, which can result in inaccurate dequeue_load_avg() in
> reweight_entity().
>
> This patch solves this by using sync_entity_load_avg() to synchronize the
> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
> For tasks were on_rq, since we already update load_avg to accurate values
> in dequeue_task(), this change will not have other effects due to the short
> time interval between the two updates.
>
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
> Changes in v4:
> - Fix the 'if else' code style issue.(Dietmar)
> - Add a description of __sched_setscheduler()/set_user_nice() in the commit
>   log.(Dietmar)
> - Add comment before calling sync_entity_load_avg().(Qais)
> Changes in v3:
> - use sync_entity_load_avg() rather than update_load_avg() to sync the
> sleeping task with its cfs_rq suggested by Dietmar.
> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
> Changes in v2:
> - change the description in commit log.
> - use update_load_avg() in reweight_task() rather than in reweight_entity
> suggested by chengming.
> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> ---
>  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..1e3c7c582541 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>                                           cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>  }
> +
> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> +{
> +       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> +                                cfs_rq->last_update_time_copy);
> +}
> +
> +/*
> + * Synchronize entity load avg of dequeued entity without locking
> + * the previous rq.
> + */
> +static void sync_entity_load_avg(struct sched_entity *se)
> +{
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +       u64 last_update_time;
> +
> +       last_update_time = cfs_rq_last_update_time(cfs_rq);
> +       __update_load_avg_blocked_se(last_update_time, se);
> +}
> +
>  #else
>  static inline void
>  enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>  static inline void
>  dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
> +static void sync_entity_load_avg(struct sched_entity *se) { }
>  #endif
>
>  static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
> @@ -3795,7 +3816,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>                 if (!curr)
>                         __dequeue_entity(cfs_rq, se);
>                 update_load_sub(&cfs_rq->load, se->load.weight);
> +       } else if (entity_is_task(se)) {
> +               /*
> +                * If the task is sleeping, we need to synchronize entity load avg
> +                * before dequeue_load_avg().
> +                */
> +               sync_entity_load_avg(se);
>         }
> +
>         dequeue_load_avg(cfs_rq, se);
>
>         if (se->on_rq) {
> @@ -4034,11 +4062,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
>         return true;
>  }
>
> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> -{
> -       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> -                                cfs_rq->last_update_time_copy);
> -}
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  /*
>   * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> @@ -4773,19 +4796,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         }
>  }
>
> -/*
> - * Synchronize entity load avg of dequeued entity without locking
> - * the previous rq.
> - */
> -static void sync_entity_load_avg(struct sched_entity *se)
> -{
> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -       u64 last_update_time;
> -
> -       last_update_time = cfs_rq_last_update_time(cfs_rq);
> -       __update_load_avg_blocked_se(last_update_time, se);
> -}
> -
>  /*
>   * Task first catches up with cfs_rq, and then subtract
>   * itself from the cfs_rq (task must be off the queue now).
> --
> 2.20.1
>

