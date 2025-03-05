Return-Path: <linux-kernel+bounces-546259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA52A4F87E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C743AA387
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F91F03D2;
	Wed,  5 Mar 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wja3eobL"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCE1547E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162414; cv=none; b=P7zeOqpiKRKM4EAvsYz2Laf0VcvMBfHQA4AlYnvvcEdsYmCh4/OEkksrWzYwUsLS0cEjnf5Kid96t1qO0LA40FFjd6xhAErvjOqiky9b9HP0HNx4jJZO6K5iN6jzS3uI+IplJpF/IkZXy278YE/2NID3u+E8AvD+Ry+6+mAyhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162414; c=relaxed/simple;
	bh=svlAOvPodQvfwZ2qiXG1x951vrnTPAJCNosuNS+vE3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnC4HviJ8M/GvVrvVcTpE84oIV56PewqX3Vc97G6bS0Tcr+PxwGosaAjDTXQC4ndaZheKdBRQYE0JkzQchYaJdEqBa0SkzBujsGF69Fnu/AfY6d+e/X4FLq8NyUWk4PeEJGGpE+ixNLrCEhqCyTAxGB7R+XC6S+1wfR+V4U1J1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wja3eobL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso949358466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741162410; x=1741767210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IS0JA6DklJWM96i0CbgpsH3MWdxvErdC1Qlf2NdHL3E=;
        b=Wja3eobLE/o4Mf1I5WIR00O1CaSgjHQQ4nZyFUidNDrNZ8L2WiclZC6VUxjkKFARQP
         lVivIUF+n+XQH2TkM01wL6sghe6WAFEhD450y1VhpOTc0E2qTlfO+Jw17UumdpyuXUL1
         5h2T+AFSVIyThOiy2YxNSob2PVvmZDnG8ch2kLKPEwFtAcCzdqT9J5351YX7KbI36BSO
         IPsh4f/E8JtAe63RGVuo+95D4Pfr+G9Hp4KhtXwKoGs6hO6zP6QiaBOtjIuiepIb4FX7
         eyWxZVkJIW+W/hk/U0Qps8O+Xmra+Qoa0s8IwFx5BlTokCqF2B3AlLz/+h/3v6nOAHJf
         trbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162410; x=1741767210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS0JA6DklJWM96i0CbgpsH3MWdxvErdC1Qlf2NdHL3E=;
        b=w7oLwOrrpAkkH5vGmWvEjK91ypYQX2JtavBIPCjL9WORjL5gq8qOCiT3FjNrMWuUQu
         VjtIhlw531bpSFE7sEUY/Rrz6Dj8JVHhGNQkv19bZcsIEKxWTHTIWgAdY1IqWiVJOOgt
         sa5V5mLLG8VDspZsJ4Rb/N+BWsRLWIch9ljP2rUk8DNUkg+G70kLPSqDjAyj45Nx0OjQ
         1gOmRNIk/dnJ1SYM8NJKGUaAPLYsFDubLqvH5Iq4gUW5Kpc+eR9n1dJijQXOpxOhRnWq
         LYSmk/6LRMZwgcTrCGf3/2zmr+diSB8FKqd6TX3UlhFqwRTEzG8d6e80NVcNeYKp0y7W
         PmnA==
X-Forwarded-Encrypted: i=1; AJvYcCVprW1akcJZxJGAuxSl8wvFlYITbyPS1gmSUjCpVHzMMZ4oP8xY/jjkwcHCJ/E7JTHZusftCQ6kTkFzjS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8iMOgKAOjudRZaTDAZtD16fhVQWYHKa6INfqUABI5tv0yD2C
	Kst5LJB3bNBYThR60Xe32sMlhM5m/7aN2dZdId15bJysQRehAzdt86i4W90EIpjUAJm+2xh+toA
	GxGV0vta+Jeatp8F9yvPTLPsgt6CkLlrL1d67sQ==
X-Gm-Gg: ASbGncuVnUy3eFuztCAOENFUc4xYYur7dCMYiB/gDeYh1vP/9HED2cw+FGaxQYWx2Xw
	+UUnmdYE/wR/glAiN+mld6nyhi+CQaYUpWr6pAlbYvlvmAuPcLvkkqAWxten/yR9hblJXgpJmH0
	uRg81MNRfEq7GKG0w+vIHkJlEW/zk3LBNfeX/0HyO+2qSa+1JciDsIelI=
X-Google-Smtp-Source: AGHT+IG/fbh/XCQtBIaI7BXe4KFY1dOaxxeiNMY7xscSHc3xgEyViM80Kfd8bFzdmtGPbuw2UqIkVo9I8x5NN/vkse4=
X-Received: by 2002:a17:907:d86:b0:ac2:8db:7057 with SMTP id
 a640c23a62f3a-ac20d97e4efmr215283866b.3.1741162410608; Wed, 05 Mar 2025
 00:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-2-vincent.guittot@linaro.org> <ce1e5fe8-c6be-4072-88ec-a465e9920213@amd.com>
In-Reply-To: <ce1e5fe8-c6be-4072-88ec-a465e9920213@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 5 Mar 2025 09:13:18 +0100
X-Gm-Features: AQ5f1Joj4LywZ8Z16dQr3if8sqofi276aP6wgexU0gippKDhJdFH4nqaKgE_k3g
Message-ID: <CAKfTPtBO7UioC4kieOxgnrJci96oyniAmiJWtzeRECN-=kF9BQ@mail.gmail.com>
Subject: Re: [PATCH 1/7 v5] sched/fair: Filter false overloaded_group case for EAS
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, pierre.gondois@arm.com, 
	linux-kernel@vger.kernel.org, qyousef@layalina.io, hongyan.xia2@arm.com, 
	christian.loehle@arm.com, luis.machado@arm.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Prateek,

On Tue, 4 Mar 2025 at 05:38, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 3/3/2025 2:35 AM, Vincent Guittot wrote:
> > With EAS, a group should be set overloaded if at least 1 CPU in the group
> > is overutilized but it can happen that a CPU is fully utilized by tasks
> > because of clamping the compute capacity of the CPU. In such case, the CPU
> > is not overutilized and as a result should not be set overloaded as well.
> >
> > group_overloaded being a higher priority than group_misfit, such group can
> > be selected as the busiest group instead of a group with a mistfit task
> > and prevents load_balance to select the CPU with the misfit task to pull
> > the latter on a fitting CPU.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >   kernel/sched/fair.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 857808da23d8..d3d1a2ba6b1a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9931,6 +9931,7 @@ struct sg_lb_stats {
> >       unsigned int group_asym_packing;        /* Tasks should be moved to preferred CPU */
> >       unsigned int group_smt_balance;         /* Task on busy SMT be moved */
> >       unsigned long group_misfit_task_load;   /* A CPU has a task too big for its capacity */
> > +     unsigned int group_overutilized;        /* At least one CPU is overutilized in the group */
> >   #ifdef CONFIG_NUMA_BALANCING
> >       unsigned int nr_numa_running;
> >       unsigned int nr_preferred_running;
> > @@ -10163,6 +10164,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >   static inline bool
> >   group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >   {
> > +     /*
> > +      * With EAS and uclamp, 1 CPU in the group must be overutilized to
> > +      * consider the group overloaded.
> > +      */
> > +     if (sched_energy_enabled() && !sgs->group_overutilized)
> > +             return false;
> > +
> >       if (sgs->sum_nr_running <= sgs->group_weight)
> >               return false;
> >
> > @@ -10374,8 +10382,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               nr_running = rq->nr_running;
> >               sgs->sum_nr_running += nr_running;
> >
> > -             if (cpu_overutilized(i))
> > +             if (cpu_overutilized(i)) {
> >                       *sg_overutilized = 1;
>
> Since sgs->overutilized is tracking the overutilized status, can we get
> avoid passing the "sg_overutilized" pointer to update_sg_lb_stats() and
> just use the sg->overutilized in update_sd_lb_stats()?

yes, make sense

>
> Something like below:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..de4a7e19d383 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10346,14 +10346,12 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>    * @group: sched_group whose statistics are to be updated.
>    * @sgs: variable to hold the statistics for this group.
>    * @sg_overloaded: sched_group is overloaded
> - * @sg_overutilized: sched_group is overutilized
>    */
>   static inline void update_sg_lb_stats(struct lb_env *env,
>                                       struct sd_lb_stats *sds,
>                                       struct sched_group *group,
>                                       struct sg_lb_stats *sgs,
> -                                     bool *sg_overloaded,
> -                                     bool *sg_overutilized)
> +                                     bool *sg_overloaded)
>   {
>         int i, nr_running, local_group, sd_flags = env->sd->flags;
>         bool balancing_at_rd = !env->sd->parent;
> @@ -10375,7 +10373,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 sgs->sum_nr_running += nr_running;
>
>                 if (cpu_overutilized(i))
> -                       *sg_overutilized = 1;
> +                       sgs->group_overutilized = 1;
>
>                 /*
>                  * No need to call idle_cpu() if nr_running is not 0
> @@ -11046,7 +11044,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                                 update_group_capacity(env->sd, env->dst_cpu);
>                 }
>
> -               update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
> +               update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded);
>
>                 if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
>                         sds->busiest = sg;
> @@ -11056,6 +11054,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 /* Now, start updating sd_lb_stats */
>                 sds->total_load += sgs->group_load;
>                 sds->total_capacity += sgs->group_capacity;
> +               sg_overutilized |= sgs->group_overutilized;
>
>                 sum_util += sgs->group_util;
>                 sg = sg->next;
> --
> Thanks and Regards,
> Prateek
>
> > +                     sgs->group_overutilized = 1;
> > +             }
> >
> >               /*
> >                * No need to call idle_cpu() if nr_running is not 0
>

