Return-Path: <linux-kernel+bounces-570182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F2A6AD32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815C2189AE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25727227B83;
	Thu, 20 Mar 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ivyMpqZ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA9226D04
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496025; cv=none; b=VsjPFkGgoaBqYTWa5YFNMiqkpKPUcprKph/JfyIO5/acRwTG7f4KI9Et6et9kzCJc/Mb4RL61ZppYbxrjhzuu/KP5GTU149ua9Fqu6Jmf6Dxgo0Bsv7j27zN8O9Q2GPx68x0Ti2dFOwX8FO76Dkyb+E1lknIb0FgnUquMeu8vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496025; c=relaxed/simple;
	bh=dt5qWHWgZr8mv9oxymnDQDUF9Pmr74KB8u40192stLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNbIOSVw9w8hFEmYlJhkXdRJZMLqNImRxU9GNl2sqKH/po9SerPoBJ9WHwNBIuA867g6ysQBlI8gD8L7HOYQs1iQn8jH/sxWKT7qhkJ8dvIhUQMQeOzUk/alUefn84Uh+zkOSGKOoeDxqdibqM+zCl3PKAUYgrYOzL2oCM8nLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ivyMpqZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so1538067a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742496023; x=1743100823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhz89dMrCKQpaeIMcowRZZzOyYwFLmhH3E/vXCpNN2I=;
        b=1ivyMpqZR9UKy3kh3HTDJ5o6VvkAZcNljX3lJDw4OaavUPa/bSUq8NZgzHmzStvMI5
         NMk53ycfTRFjdgERsHX/Nx9K2xpJj8JXg1YjoDfsYucAOC3Q6o9+oinVfKkwEtZNKUM1
         gJp5T9voBFCVONxrl9W4WlLVV3GwRLv7nY8bB2kr3+vHfX7NgwWcRt5S987/YWiNqHv5
         0b39t47fxKCVP9y12VEDMbdVd9Q4Z4qQTcNS3yFuaQ8/HVgEEvfMWs8RhNoai2bVcfN8
         OXu3Q1o/F3qt+q3K7sHpcVDXpNaHt3tBsRWAMgwKhVhzYPXJjK2Ro5tdoQQjRmA+iJY1
         pQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496023; x=1743100823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhz89dMrCKQpaeIMcowRZZzOyYwFLmhH3E/vXCpNN2I=;
        b=TcWCBD5gCS0uGZa94ejnveIz6zmLUAmBLrEecUxESIraFlC7yGUHAFUOpXNC9xN6LJ
         jHZ9ucpty9ecLd9kZiO/adU+FwZ4Biorj9+vB1tWjcqcy7jZyG3CBLNQrZBh/LInyo5U
         mB4e5hLftLAAI1Y3RN/c77HXhTJpFoVORWQ5Eju4DKHIAkYJahse637yxa0Ud5ZNNi04
         BunBcJkvzCSpuYQjpCvQ5ms88gWjyazwl5h+bhy5oWGMbROpcHdr63YUO46pgUanUdgx
         3/aBDLRXTEpPbC8CtD0DtvmNwXzHQ98nuXKbmQpvsRZzBy282gcX3g1QvzcFMvBtdZnO
         tieQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPxz1EtKOhnwbPdxJY2olrN4XQxdiSdy/YMg6HtMdzGKkZ0TX3U2aL6t/4ehEn1qluEU8pKjsrcRksxgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6bRJtzNA/gSaQxtpMUnMhhuz2SiyUk4pejeRFsves5SrsIwQ
	CePLey7iKT0h2SwzPE+vHMJKWC5/7OF/3MekAz0O4mMZOMaHkWU/xDWocD+I8KmSG08OLT/57DQ
	zNi1AQQw1EGWmmcsSOw3PzOPv/V8F43d/M46r
X-Gm-Gg: ASbGncufawzwY/F6EwkKC1pqiKKmM3Brki63GpO73xT9unwNjkiv9BNlWRGm8fkMb+x
	CaP1DeDVz9b5PmzPtQkauiWHGWvSwEivh1s9Hci3VfI/cO0+9XkogE5szz3kVtHzC0I2fTGvETk
	9TtyYXvOIU2edPpbigfaEKuwmiuNO0MbE5YBRQog3pb3+NfKrkfvUGM0fSFKOfaddC
X-Google-Smtp-Source: AGHT+IEUx5IsBsECRcBdEY5LKg54Sw7HeMAu18tqfzCQONrRCHgNXEC7kBokp2is7zyvSbWZTlpXJ9alrqDZX3mjQCE=
X-Received: by 2002:a17:90b:4c81:b0:301:cba1:7ada with SMTP id
 98e67ed59e1d1-3030fe56378mr366501a91.1.1742496022767; Thu, 20 Mar 2025
 11:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
 <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev> <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
 <7d9fbee5-2a06-41ed-9ee3-93ef3c077eff@linux.dev>
In-Reply-To: <7d9fbee5-2a06-41ed-9ee3-93ef3c077eff@linux.dev>
From: Xi Wang <xii@google.com>
Date: Thu, 20 Mar 2025 11:40:11 -0700
X-Gm-Features: AQ5f1JqHEpvPkwNVlM9Tqt5mWcnMf7-w8mqBzFwJUeK96dMmxiRtFi_lQktzLwI
Message-ID: <CAOBoifh2Ya279_jjFBrSAHuczqz_FM4NGUne2Tk0sBV=gD4D+w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based throttle
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Josh Don <joshdon@google.com>, 
	Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider <vschneid@redhat.com>, 
	Ben Segall <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:39=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> Hello Prateek,
>
> On 2025/3/20 14:59, K Prateek Nayak wrote:
> > Hello Chengming,
> >
> > On 3/17/2025 8:24 AM, Chengming Zhou wrote:
> >> On 2025/3/16 11:25, Josh Don wrote:
> >>> Hi Aaron,
> >>>
> >>>>   static int tg_throttle_down(struct task_group *tg, void *data)
> >>>>   {
> >>>>          struct rq *rq =3D data;
> >>>>          struct cfs_rq *cfs_rq =3D tg->cfs_rq[cpu_of(rq)];
> >>>> +       struct task_struct *p;
> >>>> +       struct rb_node *node;
> >>>> +
> >>>> +       cfs_rq->throttle_count++;
> >>>> +       if (cfs_rq->throttle_count > 1)
> >>>> +               return 0;
> >>>>
> >>>>          /* group is entering throttled state, stop time */
> >>>> -       if (!cfs_rq->throttle_count) {
> >>>> -               cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
> >>>> -               list_del_leaf_cfs_rq(cfs_rq);
> >>>> +       cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
> >>>> +       list_del_leaf_cfs_rq(cfs_rq);
> >>>>
> >>>> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> >>>> -               if (cfs_rq->nr_queued)
> >>>> -                       cfs_rq->throttled_clock_self =3D rq_clock(rq=
);
> >>>> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> >>>> +       if (cfs_rq->nr_queued)
> >>>> +               cfs_rq->throttled_clock_self =3D rq_clock(rq);
> >>>> +
> >>>> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> >>>> +       /*
> >>>> +        * rq_lock is held, current is (obviously) executing this in=
 kernelspace.
> >>>> +        *
> >>>> +        * All other tasks enqueued on this rq have their saved PC a=
t the
> >>>> +        * context switch, so they will go through the kernel before=
 returning
> >>>> +        * to userspace. Thus, there are no tasks-in-userspace to ha=
ndle, just
> >>>> +        * install the task_work on all of them.
> >>>> +        */
> >>>> +       node =3D rb_first(&cfs_rq->tasks_timeline.rb_root);
> >>>> +       while (node) {
> >>>> +               struct sched_entity *se =3D __node_2_se(node);
> >>>> +
> >>>> +               if (!entity_is_task(se))
> >>>> +                       goto next;
> >>>> +
> >>>> +               p =3D task_of(se);
> >>>> +               task_throttle_setup_work(p);
> >>>> +next:
> >>>> +               node =3D rb_next(node);
> >>>> +       }
> >>>
> >>> I'd like to strongly push back on this approach. This adds quite a lo=
t
> >>> of extra computation to an already expensive path
> >>> (throttle/unthrottle). e.g. this function is part of the cgroup walk
> >>
> >> Actually, with my suggestion in another email that we only need to mar=
k
> >> these cfs_rqs throttled when quote used up, and setup throttle task wo=
rk
> >> when the tasks under those cfs_rqs get picked, the cost of throttle pa=
th
> >> is much like the dual tree approach.
> >>
> >> As for unthrottle path, you're right, it has to iterate each task on
> >> a list to get it queued into the cfs_rq tree, so it needs more thinkin=
g.
> >>
> >>> and so it is already O(cgroups) for the number of cgroups in the
> >>> hierarchy being throttled. This gets even worse when you consider tha=
t
> >>> we repeat this separately across all the cpus that the
> >>> bandwidth-constrained group is running on. Keep in mind that
> >>> throttle/unthrottle is done with rq lock held and IRQ disabled.
> >>
> >> Maybe we can avoid holding rq lock when unthrottle? As for per-task
> >> unthrottle, it's much like just waking up lots of tasks, so maybe we
> >> can reuse ttwu path to wakeup those tasks, which could utilise remote
> >> IPI to avoid holding remote rq locks. I'm not sure, just some random t=
hinking..
> >>
> >>>
> >>> In K Prateek's last RFC, there was discussion of using context
> >>> tracking; did you consider that approach any further? We could keep
> >>> track of the number of threads within a cgroup hierarchy currently in
> >>> kernel mode (similar to h_nr_runnable), and thus simplify down the
> >>
> >> Yeah, I think Prateek's approach is very creative! The only downside o=
f
> >> it is that the code becomes much complex.. on already complex codebase=
.
> >> Anyway, it would be great that or this could be merged in mainline ker=
nel.
> >
> > I think the consensus is to move to per-task throttling since it'll
> > simplify the efforts to move to a flat hierarchy sometime in the near
> > future.
>
> Ah, agree! And I'm very much looking forward to seeing a flat hierarchy!
>
> At our clusters, there are often too many levels (3-6) of cgroups, which
> caused too much cost in scheduler activities.
>
> >
> > My original approach was complex since i wanted to seamlessly resume th=
e
> > pick part on unthrottle. In Ben;s patch [1] there is a TODO in
> > pick_next_entity() and that probably worked with the older vruntime bas=
ed
> > CFS algorithm but can break EEVDF guarantees.
> >
> > [1] https://lore.kernel.org/all/xm26edfxpock.fsf@bsegall-linux.svl.corp=
.google.com/
> >
> > Unfortunately keeping a single rbtree meant replicating the stats and
> > that indeed adds to complexity.
>
> Ok, got it.
>
> Thanks!
>
> >
> >>
> >> At last, I wonder is it possible that we can implement a cgroup-level
> >> bandwidth control, instead of doing it in each sched_class? Then SCX
> >> tasks could be controlled too, without implementing it in BPF code...
> >>
> >> Thanks!
> >>
> >>> throttling code here.
> >>>
> >>> Best,
> >>> Josh
> >

I am a bit unsure about the overhead experiment results. Maybe we can add s=
ome
counters to check how many cgroups per cpu are actually touched and how man=
y
threads are actually dequeued / enqueued for throttling / unthrottling?

Looks like busy loop workloads were used for the experiment. With throttlin=
g
deferred to exit_to_user_mode, it would only be triggered by ticks. A large
runtime debt can accumulate before the on cpu threads are actually dequeued=
.
(Also noted in https://lore.kernel.org/lkml/20240711130004.2157737-11-vschn=
eid@redhat.com/)

distribute_cfs_runtime would finish early if the quotas are used up by the =
first
few cpus, which would also result in throttling/unthrottling for only a few
runqueues per period. An intermittent workload like hackbench may give us m=
ore
information.

See slide 10 of my presentation for more info:
https://lpc.events/event/18/contributions/1883/attachments/1420/3040/Priori=
ty%20Inheritance%20for%20CFS%20Bandwidth%20Control.pdf

Indeed we are seeing more cfsb scalability problems with larger servers. Bo=
th
the irq off time from the cgroup walk and the overheads from per task actio=
ns
can be problematic.

-Xi

