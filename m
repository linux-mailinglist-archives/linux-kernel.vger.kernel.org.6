Return-Path: <linux-kernel+bounces-336818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D8F98413E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E546FB23192
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C3153BF8;
	Tue, 24 Sep 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNp9jEYB"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A821537DA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168262; cv=none; b=S6cyIhMsnBJd//PBfWsxbnmqoh7tYuzlqnAG1pm9shxeijhiONsJZVX2JyAiSJoC9hhmQ6x9m90FXCNOdmF/2E8gaHqEw1GAvvRsGeIr8McY6WERmw9nAzuqZ+sbTQf9ZUgL0gFRsxXGawcf2zUw1h8UC6/mqyQorNDlS2PPAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168262; c=relaxed/simple;
	bh=lE56tUqc7U6Da9CD+RhdSi+Ii8jDg8oOjX/FkqXb7UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBrNs8eJhU7rRJWePgtH/Gh5KAXJHH4r9UU9Y4eWhqsxjMWfukF+n9FaF1N7qPMAtLM1q3Ef1MR6lRVVkCwGwBw1RqfW+YZX1q6d/Uc2q69o2o94Z7nn9ypR8qwcYnmI8guxzZ93PakJtrtUc7Wfh7Y6Wdl00+WA/f2sdneCaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNp9jEYB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso3658515a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727168260; x=1727773060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8B0FkUkhae115BZWfqwSGmmyTkRrSIOt6X94GGdQUH4=;
        b=TNp9jEYB55rtkmpGrQNBlKGRurgekFq5HM5uIgZpSAvJkoHN0Onx/iJaRQlWw+HZgR
         P+84D72eD7n1QVt6tgPemAYURWoaKWh13osco+zvIVv++CIbsnk4DYqARZQtVvu2fH6j
         1ACsp1rnDwcANLk76oJajGHcfHE7/Itn5IAvehUhve3qa1xxcyTuMPNz1BWsom7Q8LoZ
         fNqxzp13I7Vuf+NAE3Kg93gshkSO1nB+BYX6VmK1/f/WnVEWLdCQNnQEC5oK7pCFrKDj
         SSJP2NRP45AhmWni4IHcSjydfNJnlmdpxkPw4gJqitV/q8xcf7a0WAv8Zw+cYJC4eXPK
         g1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168260; x=1727773060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B0FkUkhae115BZWfqwSGmmyTkRrSIOt6X94GGdQUH4=;
        b=Xtv/hy2uaA5rD23Rbj3DXoDhICBvmPk3Y3qqOsKWA2rph2s/gCCyd8NzlnIN5oaGP5
         OXA8BOespxblWXbcgEFDw7fHOrMH1ZsDajNYsBasyqb6uZ9rLIto91fRlW98BEaQNpy6
         WJvVITfKhvEFhwaee5GzmLASBdFB6WnMVeilYd8982JVEh3/mJ6CyT2Q2iaeCzdEfF67
         mtW9CuD8DmO981QnnuHXd50DiIDbFKERRFS1iiNAJdMQRk1tMTtaw9NN9r5Tz3LYp1QR
         HjrQa7KdtbqpBZVSnNm3o4UUDK73yDGczWW9irIK2yVGwaAWVoBKDV/TnXzweycrEp46
         7aNg==
X-Gm-Message-State: AOJu0Yy9eSvYDEQ3VdjBwb1bezjyLMreha2FjvVb8v4i+i3oo5CSSW99
	NdhIEvNdyYfLTgM2wBFhZd4nia0S9wgLk9hl6Uz1miEJ/ambtjYmm9KEO8S5EcTre3/MoDPBFG9
	wh4T7uw5fCEM3ns4jD57cuZ64hOtl2V876pa6E6nddsrEViRlRYk=
X-Google-Smtp-Source: AGHT+IFa6SkcGvqJYNCdZrCGtuGQVdpRQe/QfVzEU07Fj0idMpJEqjePPAVm4uLcx1Z60XXK/98OeXUx+a7+bXARdw8=
X-Received: by 2002:a17:90b:3511:b0:2d8:840d:d9f2 with SMTP id
 98e67ed59e1d1-2dd7f4572e0mr18019196a91.24.1727168260335; Tue, 24 Sep 2024
 01:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913085824.404709-1-pierre.gondois@arm.com>
 <CAKfTPtB2=_O=dJbTH=e_Hg80_rcSvBgwUP+ZMehfyG4sG5W6iQ@mail.gmail.com> <6f365e5b-220c-4b2e-8a56-a5135b216e62@arm.com>
In-Reply-To: <6f365e5b-220c-4b2e-8a56-a5135b216e62@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Sep 2024 10:57:28 +0200
Message-ID: <CAKfTPtAjC+sLga2OcxJGwBaovo0RGMtQRQYe9nRVhcLyiHtJSQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 19:36, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 9/13/24 18:14, Vincent Guittot wrote:
> > Hi Pierre
> >
> > On Fri, 13 Sept 2024 at 10:58, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> >> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> >> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
> >>
> >> Use lsub_positive() instead of max_t().
> >
> > Have you faced the problem or this patch is based on code review ?
> >
> > we have the below in sched_balance_find_src_group() that should ensure
> > that we have local->idle_cpus > busiest->idle_cpus
> >
> > if (busiest->group_weight > 1 &&
> >      local->idle_cpus <= (busiest->idle_cpus + 1)) {
> >      /*
> >      * If the busiest group is not overloaded
> >      * and there is no imbalance between this and busiest
> >      * group wrt idle CPUs, it is balanced. The imbalance
> >      * becomes significant if the diff is greater than 1
> >      * otherwise we might end up to just move the imbalance
> >      * on another group. Of course this applies only if
> >      * there is more than 1 CPU per group.
> >      */
> >      goto out_balanced;
> > }
>
> It was with this setup:
> - busiest->group_type == group_overloaded
> so it might not have checked the value. I can check the exact path if desired,

I'm curious that we never faced this before as the change is almost 4
years old now but there are probably some topologies that can end up
in such situation

Also the fix tag should be
Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
Before this commit, group_overloaded was not comparing number of tasks

With the correct fix tag:
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Regards,
> Pierre
>
>
> >
> >>
> >> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> >> cc: stable@vger.kernel.org
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >> ---
> >>   kernel/sched/fair.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 9057584ec06d..6d9124499f52 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >>                           * idle CPUs.
> >>                           */
> >>                          env->migration_type = migrate_task;
> >> -                       env->imbalance = max_t(long, 0,
> >> -                                              (local->idle_cpus - busiest->idle_cpus));
> >> +                       env->imbalance = local->idle_cpus;
> >> +                       lsub_positive(&env->imbalance, busiest->idle_cpus);
> >>                  }
> >>
> >>   #ifdef CONFIG_NUMA
> >> --
> >> 2.25.1
> >>

