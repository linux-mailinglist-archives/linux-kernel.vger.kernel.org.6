Return-Path: <linux-kernel+bounces-567773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF29A68A71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16975425832
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78530254AFA;
	Wed, 19 Mar 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q61kqbL4"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C6254AF3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381915; cv=none; b=Z5735bjM/a/MxfWvy1VhtiWvD6Hpo8WSy9CXmPmu6kvxNWzgqYKIkujkuHPZlmkj5oYJWqcqqgFkHzDtXTNlEhGDcxO9gEu0bh8kE/gueV2tuDoUOVVqBUL0vXoI4A9JtIe8oeFLGrJvHSHIVWnsGa8l9F6mcEgP+ZxN9xI2s/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381915; c=relaxed/simple;
	bh=GMdHk4rB/VRem8za4n4bsg01/EBevt6JAfLArqRo7aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWawZicYRh+P77zN2j+fSWb7kVjdiVyAD7WK9So7JCGvtMVs2knpvlGAESEpsjtev8Yw6IatRHQHSU9BstYMbKkmF2qi7Ps4ekIlYhpyDF0Yfdebni4prZYdbFtn3CaAT64E/drEelwGd1bbSYEg2J/i2vE0trjElBAPNEK45wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q61kqbL4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so9541313a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742381912; x=1742986712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vW7C4tPOxvZELCYbKzcfy0qxwpLuWCsEpQ5j+INPE1k=;
        b=Q61kqbL4dk4QVtimd7vsIv5KYSjmk/IaUiLMZ3aRlg+8lfyFu+WqrpFmm3PLequDbS
         NVIILOP+Nx7ILJ108ZMeL5Zpx72dRzFkT3xn4k7xTS+TYosRCYsYWcuP9mKLiEJbhzo8
         hJWa05xlqoJHRsAlzUrnNeHtPZxGg2LSbNWrL7wjx+sRNPOMr0oa9m/5q2MgA5poLAi4
         H5sxxmWmKPDZ38BtojUha78XQrUUq8M3JRuIqNfQ3xbo7D8CLDOxf35FFtjad7wZsB1+
         89qUeVscJj9+2gO7r5WFsra+MRNHVs9ULABz5sxbaF/b8M4cc0HKEkrevF/Gs+F9NJ2X
         JAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381912; x=1742986712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vW7C4tPOxvZELCYbKzcfy0qxwpLuWCsEpQ5j+INPE1k=;
        b=lq4W/4KSema+QtOwqld6agWvg4LHcgT80a9xL2uc2s7uK0Vyyy/Ej9y4h3N5gdZoSC
         undMNmijPJWU1yUpBV6/RZOv8snOYXatnfAChxEVSF3PwCWaYcBEeD9Bn4DNfnjE0Lbi
         2vSbBjNvtiXknd5cMIsJfaSJomwzvZs2dLMyBhQestsdgyBsiel925VT5f6we1/kzhj2
         FBEs+Ck4iYDsaeijVnIcr92EvFQYKkpOw1R49HNhR7bvmpiyfDhU7VbYjLtvfLTnR5uJ
         54ZZAaAvxhwxjLEKaI5dvhN+iinzpaCaoXNWzA95erem0b9zQlCLdPqrXVvDLGTpL21S
         vaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FZjPsYM8pRvjg9P/nHfxHx+rnUfDzdN+9SJJiFGKbellNc841LUc/Upg/KcTH9f7vfinbe1aaRS5ogM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQcnaqvR/Y29rALZIgT8/fEDQd+CjVwFa0jf6jOt0FYBeX5u7
	byEoOArxlhhKKVYdAYnm6ORZ+w6SpjJuD3olvxqhPMhxbZbOLqG9GBpC9nxZBkzZyD9PDvkjUNY
	ywPNeYN/ck45mF9zyYOi0KfagQ/9JXGRlqbDekQ==
X-Gm-Gg: ASbGncu7UiOvIJVHEzg1w/kxvaehZ83ePcLtl+qH/5aG5WKeoNHVMT/uaYuLRm1ayZE
	n0fTdfT1hwgk6RSWCSQ17TD3+vMHEqlQon42Q855AjPl49KpO75BpopX6Xmm58Yi3z9a0oLuZIh
	7MOxFxf7bz/VNmAvC+2ofv5tpc
X-Google-Smtp-Source: AGHT+IGx5ow9cN09CGCBAFuQbRNLmOL250AFrlh1Cl73NR3fRo90gqsunH8AHB9HnIengqE7XD+1WZgmcCDx4gB+BfE=
X-Received: by 2002:a17:907:86a0:b0:ac3:898d:40d6 with SMTP id
 a640c23a62f3a-ac3b7c236dbmr218987066b.13.1742381911424; Wed, 19 Mar 2025
 03:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-2-wuyun.abel@bytedance.com> <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
 <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com> <CAKfTPtAqBgCAoTaMv3_7Xguo+jtpBgg5EXOeUBWfMyPY8YDkJw@mail.gmail.com>
 <31574ba7-a04f-49fa-aea8-a0a751915ecc@bytedance.com>
In-Reply-To: <31574ba7-a04f-49fa-aea8-a0a751915ecc@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 11:58:18 +0100
X-Gm-Features: AQ5f1JpJ8cpGv2N7-vocd3suL4kiamMKO0Cx6PYWBnxrPxs9P-2_uSjE5c5mEnU
Message-ID: <CAKfTPtAHEtyrQ0VfrC6iHR8Rs5AjCOFNbMiVHzFzHTU00vjeVg@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU
 selection consistent throughout"
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 11:36, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 3/19/25 5:17 PM, Vincent Guittot wrote:
> > On Thu, 13 Mar 2025 at 08:18, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> On 3/12/25 12:58 AM, Vincent Guittot wrote:
> >>> On Mon, 10 Mar 2025 at 08:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>>>
> >>>> This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.
> >>>>
> >>>> The above commit tried to unify selection policy between idle cpus
> >>>> and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
> >>>> by treating them equally (although the SCHED_IDLE cpus are turned
> >>>> to be given more preference in slowpath). The test results seemed
> >>>> solid, but the setup didn't take cgroup hierarchy into account,
> >>>> which actually made some of our important services get affected.
> >>>>
> >>>> The cgroup hierarchy in our production environment looks like below,
> >>>> which might be common in modern containerized setup:
> >>>>
> >>>>                             root
> >>>>                           /       \
> >>>>                   kubepods        system.slice
> >>>>                   /       \\              \
> >>>>           guaranteed      besteffort      containerd
> >>>>
> >>>>           (where 'X=A' means A is SCHED_IDLE cgroup)
> >>>>
> >>>> The cpu is treated as SCHED_IDLE if only besteffort is running, which
> >>>> is given at least equal preference as the idle cpus when deciding where
> >>>> to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
> >>>> mean they can be preempted soon enough to start serving the wakee, and
> >>>
> >>> Could you give us more details why the SCHED_IDLE cpu which runs only
> >>> besteffort can't be preempted soon enough ?
> >>>
> >>> because kubepods vs system.slice is not sched_idle when comparing the
> >>
> >> Yes, exactly. What's worse is that kubepods.weight is the sum of all its
> >> children and can easily reach ~3000, while system.weight is default to
> >> 100. The weight configuration can be optimized, but it's another topic.
> >>
> >>> entities ? some maybe the definition of sched_idle_cpu should be fixed
> >>> instead
> >>
> >> Yes, there are at least two ways to fix it:
> >>
> >>    1) Let sched_idle_cpu() depends on a specific task, just like Josh
> >>       mentioned in the reply of 2nd patch. So if sched_idle_cpu(cpu, p)
> >>       returns true, then
> >>
> >>          a) this rq only contains hierarchical idle tasks, and
> >>          b) p can preempt current immediately
> >>
> >>       Please see my reply to Josh to check the details.
> >
> > yeah, that should be the solution which covers all cases but at the
> > cost of walking cgroup hierarchy which is far from being ideal
>
> Only comparing curr vs wakee doesn't solve the problem. A cpu can be
> treated as SCHED_IDLE iff *all* its SCHED_IDLE entities can be preempted
> by the wakee.
>
> >
> > Could we change h_nr_idle to only track fully sched idle tasks; I mean
> > tasks with a full sched_idle cgroup hierarchy ? so we would be sure to
> > preempt those sched idle cpus
> >
> > Then, for other case of sched idle task or sched idle group childs of
> > a non sched idle group then we don't consider those cpu as sched idle
> > cpu
>
> Ahthough this is correct, I think it would be too much since this kind
> of setup is rare to the best of my knowledge.

But that's the only case that we are sure

>
> >
> >
> >>
> >>    2) Or get rid of sched_idle_cpu() entirely. This needs some careful
> >>       rework. Now the users of cfs_rq::h_nr_idle are two parts:
> >>
> >>          a) select_task_rq, including sched_balance_find_dst_group_cpu()
> >>             and select_idle_*(). The former is handled by this series by
> >>             simply ignoring sched_idle_cpus, which should be safe since
> >>             sched_idle_cpus do not always follow the goal of the slowpath
> >>             to find a least loaded cpu to help load balancing. While the
> >>             latter is roughly designed as following:
> >>
> >>             - Must search within target LLC domain, since L3$ miss is
> >>               much more costly than L1/L2$
> >>             - To use cache more wisely, start searching from the L1/L2$
> >>               cache hot cpus like prev/recent_used/..
> >>             - Cheers if found an idle cpu that can preempt immediately.
> >>               This helps maximize using cpu bandwidth, hence improving
> >>               total throughput
> >>             - (?)
> >>             - Return target anyway, at least it might be cache hot
> >>
> >>             It could be less optimal if simply remove sched_idle_cpu and
> >>             return @target if no idle cpu available, because @target can
> >>             be heavy loaded and the cache may not hot any longer when the
> >>             wakee finally hit cpu. So in order not to fight with the load
> >>             balancing, shall we tiebreak on cpu_load() for the non-idle
> >>             cpus?
>
> What do you think to choose a less loaded cpu if no idle ones available?
> So the wakee will probably get better served, and also helps load balance.

I'm not a fan of adding more than idle selection and we already
compared load in wake_affine.
So we should only look at a cpu that we can preempt immediately: idle
cpus or cpus with full hierarchy sched idle entities

>
> >>
> >>          b) load balance: sched_balance_domains() and dequeue_entities().
> >>             We could leave this as-is, but I would propose using h_idle
> >>             instead: if the on_cpu task is hierarchically idle when
> >>             triggering normal load balancing, then we guess it's a less
> >>             loaded cpu and can reduce balance interval. The rationale
> >>             behind is that the idle entities usually get very limited
> >>             bandwidth if any hierarchically non-idle tasks available.
> >>             The heuristics may have false positives which can generally
> >>             be divided into 3 cases:
> >>
> >>                  (The numbers represents hierarchical shares%)
> >>
> >>                                                     C
> >>                     A               B              / \
> >>                   /  \\           /  \\           80  20
> >>                  99    1         50   50         // \
> >>                                                100  (X)
> >
> >
> > How the sched_idle group in B can have the same share/weight as the
> > not sched idle one in case B ?
>
> It can't, but theoretically several SCHED_IDLE siblings can be summed up
> to match a niced SCHED_NORMAL entity.
>
>                                     B
>                                     |
>                  ---------------------------------------
>                  |     ||      ||      ||      ||      ||
>                 15      3       3       3       3       3
>
> >
> >
> >>
> >>             - Case A) The hierarchical share of h_idle tasks is indeed
> >>               small. So in this case they are just get scheduled to take
> >>               some breath, and the possibility of false positive is low
> >>               enough to be safely ignored.
> >>
> >>             - Case B) The h_idle & !h_idle tasks equally share bandwidth
> >>               which usually means the !h_idle part becomes less loaded
> >>               and pulling some load might be preferred.
> >>
> >>             - Case C) The hierarchical share of h_idle tasks dominates
> >>               which usually means their !h_idle parents are allowed to
> >>               use a big portion of bandwidth. In this case speedup the
> >>               balance is still fine because we could pull some !h_idle
> >>               tasks for the most 'important' cgroup.
> >>
> >>             So the heuristics of using rq->curr's h_idle to judge the need
> >>             of pulling (load balancing) seems fine.
> >>
> >>       And as a result cfs_rq::h_nr_idle can be removed and its maintenance
> >>       cost in hotpath can be saved.
> >>
> >> Which way do you prefer? It would be much appreciated if you can shed some
> >> light on this.
> >>
> >>>
> >>> a sched_idle_cpu should be preempted immediately otherwise it's not a
> >>> sched idle cpu and the definition is meaningless
> >>
> >> Agree.
> >>
> >> Thanks!
> >>          Abel
> >>
>

