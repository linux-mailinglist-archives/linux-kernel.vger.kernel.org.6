Return-Path: <linux-kernel+bounces-337182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD898467C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45B1F24520
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05951A7258;
	Tue, 24 Sep 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpn1QfJ4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F61B85DD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183431; cv=none; b=N935DP3r+o4XCWg6lzLM/lxkzNK4Gdp0jq6/Kh2dozWyqwJODUdu5CthZpg1pEkFtscs6WnDgRQlwJMiKWyohYWsL8dNhfV138+JSeli4GoydRiFJU+IHYbc7nN5u+DoNL5p6K9satK85zskYmpG+aq5v47Gqtr6NsbeSAw3ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183431; c=relaxed/simple;
	bh=S5a0cWQEqhoI1fV3iQSutmfXl+cSsM42kiUC38cxZqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ/DR7kyHykarQLfAOzwSLxFT06wfnnbCfLguRAtfArYGBe+pjK5arokMQl3a+7MDqujNhMHcsQKPppEDMbwYz8OInzIjIZOW8mO3gDjpYZpuKnsp6+gzsCcLN1C6YqfOnMesbi4g6atPHEDbxBOz3c2dDpdyGyqeJMD1okr3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpn1QfJ4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20696938f86so43568555ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727183429; x=1727788229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL9xzIsjV+FCSEY6HHkr12haAJLqcPj9LEFbjn4iMXo=;
        b=Bpn1QfJ4VfRQEK+9Z4f+P45pFIFpUz5i5dhqGzH4yAZkzwWJVwAmTOA4gR4e33rg0t
         FMtCJeD8sqsXEOS6QdNHHqrCy9mnEjHbXc4ncwm73vWeZl/7HZAmYYvjUqv4DiV2K+QX
         /GeuPHJx7uqXAUeZRmSYJU3hKOWM+ETUi4est5wOeYjkfVUMEthI31rzlfJ6cltZ+Iun
         2y2/g9tSamOwKKau9rYJYnp5PqHkh6zacOatV2StzHUpmgxrJADyhW9SP8waeQS1aPg8
         aQEY/nmBZC8czYIvT53cWUOFMd6u6aHnLGo2+qHjA9FFHBjE8aNpAHlfel5q5nvdT0Hy
         KK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727183429; x=1727788229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL9xzIsjV+FCSEY6HHkr12haAJLqcPj9LEFbjn4iMXo=;
        b=n6KbD3aWbuAk4SO7ShBXs4wdBVQNgLY0ziZYRflkJeU35lWmavzKSd5dJTK718pbZG
         vO9RnyS9QHdZGL7IIt4UwoJ4MXUSHoJsfOW5MfYqc0xZwV6CwX6fcJZD4bdi7Mblp7Fw
         EPT/f3x986fFWx8Vap5L4KwzIzPrcYQ+T+XlVCmbMRyK30XFgi4Jio5EqYocQjTtQFhl
         3lzUYli1Kf9vMnmQItdFrxqy7ls5yGIjbI6mp1slP+1cFn5/phSyKSN4e/Z/yTFWsQTQ
         8LGHEB7WUkEp3b+pkmYAK8w2Iv0t8arzh6LbCrGp6bnzBab/c9ObvWxkuxBZJzHWOXSo
         t3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmUh1c2J2UBj/nT7cwAHBEqYf/H+4LJjNYaKIU51ghyggXLN/3C76FEodL//mcrKL1hdfkr3K9DOyCS0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3wLiINNjejoyQeAO/Lt3Sp9YaHqsSDk6EIq65uE7RsfZrXn6
	iiQdgB9dvyzLwLZBVxLdgqlnkKWOMnQoAX34B9n/geSA1XBEJcfseEX5bdnbUZs9WDsf18P+tTe
	2VDAIvChAI5qw2RXHMigWV1mUQBs=
X-Google-Smtp-Source: AGHT+IHrtabfB5Bga4wHl+dTRBN/W1FiCZQsQPwbAumun1A608PdR6gPv9W9R4cwLbAzDe89CphtXLP4lA3s7Aif6pM=
X-Received: by 2002:a17:90b:108e:b0:2ca:7636:2217 with SMTP id
 98e67ed59e1d1-2dd80bfc2d2mr19093937a91.2.1727183428936; Tue, 24 Sep 2024
 06:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923072156.343623-1-yu.c.chen@intel.com> <3c969a0b-812e-dedd-b9ed-6378f61d5735@amd.com>
In-Reply-To: <3c969a0b-812e-dedd-b9ed-6378f61d5735@amd.com>
From: Chen Yu <yu.chen.surf@gmail.com>
Date: Tue, 24 Sep 2024 21:10:17 +0800
Message-ID: <CADjb_WRBu8+zhO3ynHE4gferJhvZ=o9Gq1_rUisz143ivjkS0g@mail.gmail.com>
Subject: Re: [PATCH] sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Chunxin Zang <zangchunxin@lixiang.com>, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Prateek,

On Tue, Sep 24, 2024 at 6:28=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello Chenyu,
>
> On 9/23/2024 12:51 PM, Chen Yu wrote:
> > Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preem=
pt")
> > introduced a mechanism that a wakee with shorter slice could preempt
> > the current running task. It also lower the bar for the current task
> > to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_r=
unning
> > when the current task has ran out of time slice. Say, if there is 1 cfs
> > task and 1 rt task, before 85e511df3cec, update_deadline() will
> > not trigger a reschedule, and after 85e511df3cec, since rq->nr_running
> > is 2 and resched is true, a resched_curr() would happen.
> >
> > Some workloads (like the hackbench reported by lkp) do not like
> > over-scheduling. We can see that the preemption rate has been
> > increased by 2.2%:
> >
> > 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary=
_context_switches
> >
> > Restore its previous check criterion.
> >
> > Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preem=
pt")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.san=
g@intel.com
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
> Gave it a spin on my dual socket 3rd Generation EPYC System and I do not
> as big a jump in hackbench numbers as Oliver reported, most likely
> because I couldn't emulate the exact scenario where a fair task is
> running in presence of an RT task queued.

Actually I did not dig into Oliver's test scenario. While looking at the co=
mmit
I thought that there could be scenario where a rt and a cfs task together m=
ight
make a difference in preemption which caused this problem.

> Following are numbers from my
> testing:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Case:           tip[pct imp](CV)    preempt-fix[pct imp](CV)
>   1-groups     1.00 [ -0.00]( 2.60)     1.00 [  0.17]( 2.12)
>   2-groups     1.00 [ -0.00]( 1.21)     0.98 [  2.05]( 0.95)
>   4-groups     1.00 [ -0.00]( 1.63)     0.97 [  2.65]( 1.53)
>   8-groups     1.00 [ -0.00]( 1.34)     0.99 [  0.81]( 1.33)
> 16-groups     1.00 [ -0.00]( 2.07)     0.98 [  2.31]( 1.09)
> --
>
> Feel free to include:
>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>

Thanks for the test!

> > ---
> >   kernel/sched/fair.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 225b31aaee55..2859fc7e2da2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1025,7 +1025,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq=
, struct sched_entity *se)
> >       /*
> >        * The task has consumed its request, reschedule.
> >        */
> > -     return true;
> > +     return (cfs_rq->nr_running > 1);
>
> Was there a strong reason why Peter decided to use "rq->nr_running"
> instead of "cfs_rq->nr_running" with PREEMPT_SHORT in update_curr()?
>
> I wonder if it was to force a pick_next_task() cycle to dequeue a
> possibly delayed entity
>  but AFAICT, "cfs_rq->nr_running" should
> account for the delayed entity still on the cfs_rq and perhaps the
> early return in update_curr() can just be changed to use
> "cfs_rq->nr_running". Not sure if I'm missing something trivial.
>
85e511df3cec changes
if (cfs_rq->nr_running > 1)  resched
to
if (rq->nr_running =3D=3D 1) not_resched
which does lower the bar to trigger resched

Yes, I think your proposal make sense, the resched should only
be triggered between 2 cfs tasks,
and the restore to update_deadline() is not needed, something like below
in update_curr() could also work:

if (cfs_rq->nr_running =3D=3D 1)
      return;

thanks,
Chenyu

