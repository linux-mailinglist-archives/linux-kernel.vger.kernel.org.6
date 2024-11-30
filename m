Return-Path: <linux-kernel+bounces-426186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7299DEFFD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912EAB2164A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A7153BEE;
	Sat, 30 Nov 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJeS6ACo"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3391C6A3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732963820; cv=none; b=OC4gyfaOTvvhi9BXElDD8OpE4l6+xki4TQ5Wu1eXqmFdmUTw71im6AfJACuEnnrt6WotzuDh5xQRJBdE4UQcSOWXmPURDevvnu5kgDQ+Vuftz9ltMTysPMsY8DimZDPwQ4w0gyOkqrBD6k5zV27x3S0qkj0g5WapmEmDVTXEeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732963820; c=relaxed/simple;
	bh=avIiZnETVH/3VkupZbAJg21hJTgUU1spUjS8F/J34Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWbHrmHOhhmxEVZZe/LaOoVlvtFzCoqZ/3WctskPK+R84aMgeddrhwEbc8iaaXjhiljMu5gdYKXRxrsgUMehURed2aBle6Ac17tALAdxhGCjKIWEnoaojdCF6s6T9QPQ0NPnVRrz9rdXyeB2w+A/Zvn3pNDTl6HqHR8g8ONVd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJeS6ACo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso2714531a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732963817; x=1733568617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ4q1dNF8qJCePii0NxxAZvBJ0pPmCKcd6A67qAPMcE=;
        b=IJeS6ACodKFuCUriySGuWoDWRWKr59fpl6oOG6iLJrQzjDjEfs9YTLq3BsEpUR7ysU
         rpoS6mN4BuCI0Ns3+4zkzaJgT6DbQsUD9k+99W2ooYej74vLI8DGTbd6q1M2xkmtF6b8
         Am/aryYRIi4eGZgy7KXUHdNSL8NVthKNoLrF0GrzpK/xH8UPRXD7FVbTNVrj3UmsowB+
         0mmanN5CZ32O7D1OlGoAB950X/MuuhPns/ZPVD3QSUAVFbQMiU3yP+qJFNTBC89+xzE0
         XUTc8LWM4pBSRrAlG6/j7CwvUW9d4cEt3VlD/8dNEr1xh8VTDx3wv753ez8YeqmGqvsE
         5Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732963817; x=1733568617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ4q1dNF8qJCePii0NxxAZvBJ0pPmCKcd6A67qAPMcE=;
        b=hi6BizJZUMUbzt9rPW0Rj8H3vl+YGX3CPC78B/EAm1tOojN2S/o20KONxCP4t9xNX7
         ONzZ5H4ihgYaVD1xKPAD/tJlhY3fULjxTGDRR9Ffb9A21XFdAnmcN8F9kBqgqBCSCyO3
         jiOP+yLkH66Qb8ikVrJFh/EQiPTIE+VAELZgyqMgwmAvdba4jlfYvXIHVOr66zhqa5LH
         JGjnsqbS8LAzk1vArazzj2pz7cIZFJj0YEdM0IgL5IM38e2T+nYgitANZqWdSmhNP6pk
         7YFHojASBpUP0/fysfkmwFfuCrNEUQMhwy3p6bNsGenVWiL/IzTO5Cr6VGdV9P2qTsS7
         trlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSGXA7RqoceGR9J+yCvYhb0eW112V9xNzd4X5m3jYx7TiEwfViMpA/BB8cKtejA9FUwH/8T8cpIeYR1Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6goRuu5xX+ZWWNK6NJBpL+YQcRBxWxYiLgbU6KYaw3k2Zd0o1
	vJFJZn9Mtdknds3SD6FFlDI7KqA96TxalSJPkD4896cqKMXQsuN0UOsG40iZxuugyu7koxCUnOc
	Xw3cDI/+C4wNcGNlQfg31v1oCGfzJ8aQF59pUFA==
X-Gm-Gg: ASbGncuuH7+FivrYnXwmKB9gYPO36Hg2pxBoNyo1VImDF6EiXwMllVHCE+W5wwnHrb7
	ICGxFrPsR8gj03mHbJ1Jfz5pen5J+NRJObk63H6n55dU55c2I1YcegiGuHAlV
X-Google-Smtp-Source: AGHT+IFE8Gj/VCLODC+B+5FYP1MbAu4KK9L0LthS+VPwlos1nkSUxVMBl0n1EuwSPcjV9dUTkFTycnH1T2TzjaCGm1Y=
X-Received: by 2002:a17:90b:8f:b0:2ee:4b72:fb47 with SMTP id
 98e67ed59e1d1-2ee4b72fcfbmr10868891a91.6.1732963817494; Sat, 30 Nov 2024
 02:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org> <d690510c-c3c0-4551-bf18-e1b62269c8cc@arm.com>
In-Reply-To: <d690510c-c3c0-4551-bf18-e1b62269c8cc@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 30 Nov 2024 11:50:06 +0100
Message-ID: <CAKfTPtDbAmYkJ9KKzeFa9yJM4psiN6=eYj6ZN7h0gE0zJGWscQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] sched/fair: Rework EAS to handle more cases
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

Hi Hongyan,

On Thu, 28 Nov 2024 at 18:24, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> Hi Vincent,
>
> On 30/08/2024 14:03, Vincent Guittot wrote:
> > The current Energy Aware Scheduler has some known limitations which have
> > became more and more visible with features like uclamp as an example. This
> > serie tries to fix some of those issues:
> > - tasks stacked on the same CPU of a PD
> > - tasks stuck on the wrong CPU.
> >
> > Patch 1 fixes the case where a CPU is wrongly classified as overloaded
> > whereas it is capped to a lower compute capacity. This wrong classification
> > can prevent periodic load balancer to select a group_misfit_task CPU
> > because group_overloaded has higher priority.
> >
> >
> > Patch 2 creates a new EM interface that will be used by Patch 3
> >
> >
> > Patch 3 fixes the issue of tasks being stacked on same CPU of a PD whereas
> > others might be a better choice. feec() looks for the CPU with the highest
> > spare capacity in a PD assuming that it will be the best CPU from a energy
> > efficiency PoV because it will require the smallest increase of OPP.
> > This is often but not always true, this policy filters some others CPUs
> > which would be as efficients because of using the same OPP but with less
> > running tasks as an example.
> > In fact, we only care about the cost of the new OPP that will be
> > selected to handle the waking task. In many cases, several CPUs will end
> > up selecting the same OPP and as a result having the same energy cost. In
> > such cases, we can use other metrics to select the best CPU with the same
> > energy cost. Patch 3 rework feec() to look 1st for the lowest cost in a PD
> > and then the most performant CPU between CPUs.
> >
> > perf sched pipe on a dragonboard rb5 has been used to compare the overhead
> > of the new feec() vs current implementation.
> > sidenote: delayed dequeue has been disable for all tests.
> >
> > 9 iterations of perf bench sched pipe -T -l 80000
> >                  ops/sec  stdev
> > tip/sched/core  13490    (+/- 1.7%)
> > + patches 1-3   14095    (+/- 1.7%)  +4.5%
> >
> >
> > When overutilized, the scheduler stops looking for an energy efficient CPU
> > and fallback to the default performance mode. Although this is the best
> > choice when a system is fully overutilized, it also breaks the energy
> > efficiency when one CPU becomes overutilized for a short time because of
> > kworker and/or background activity as an example.
> > Patch 4 calls feec() everytime instead of skipping it when overutlized,
> > and fallback to default performance mode only when feec() can't find a
> > suitable CPU. The main advantage is that the task placement remains more
> > stable especially when there is a short and transient overutilized state.
> > The drawback is that the overhead can be significant for some CPU intensive
> > use cases.
> >
> > The overhead of patch 4 has been stressed with hackbench on dragonboard rb5
> >
> >                                 tip/sched/core        + patches 1-4
> >                              Time    stdev         Time    stdev
> > hackbench -l 5120 -g 1         0.724   +/-1.3%       0.765   +/-3.0% (-5.7%)
> > hackbench -l 1280 -g 4         0.740   +/-1.1%       0.768   +/-1.8% (-3.8%)
> > hackbench -l 640  -g 8         0.792   +/-1.3%       0.812   +/-1.6% (-2.6%)
> > hackbench -l 320  -g 16        0.847   +/-1.4%       0.852   +/-1.8% (-0.6%)
> >
> > hackbench -p -l 5120 -g 1      0.878   +/-1.9%       1.115   +/-3.0% (-27%)
> > hackbench -p -l 1280 -g 4      0.789   +/-2.6%       0.862   +/-5.0% (-9.2%)
> > hackbench -p -l 640  -g 8      0.732   +/-1.9%       0.801   +/-4.3% (-9.4%)
> > hackbench -p -l 320  -g 16     0.710   +/-4.7%       0.767   +/-4.9% (-8.1%)
> >
> > hackbench -T -l 5120 -g 1      0.756   +/-3.9%       0.772   +/-1.63 (-2.0%)
> > hackbench -T -l 1280 -g 4      0.725   +/-1.4%       0.737   +/-2.0% (-1.3%)
> > hackbench -T -l 640  -g 8      0.767   +/-1.5%       0.809   +/-2.6% (-5.5%)
> > hackbench -T -l 320  -g 16     0.812   +/-1.2%       0.823   +/-2.2% (-1.4%)
> >
> > hackbench -T -p -l 5120 -g 1   0.941   +/-2.5%       1.190   +/-1.6% (-26%)
> > hackbench -T -p -l 1280 -g 4   0.869   +/-2.5%       0.931   +/-4.9% (-7.2%)
> > hackbench -T -p -l 640  -g 8   0.819   +/-2.4%       0.895   +/-4.6% (-9.3%)
> > hackbench -T -p -l 320  -g 16  0.763   +/-2.6%       0.863   +/-5.0% (-13%)
> >
> > Side note: Both new feec() and current feec() give similar overheads with
> > patch 4.
> >
> > Although the highest reachable CPU throughput is not the only target of EAS,
> > the overhead can be significant in some cases as shown in hackbech results
> > above. That being said I still think it's worth the benefit for the stability
> > of tasks placement and a better control of the power.
> >
> >
> > Patch 5 solves another problem with tasks being stuck on a CPU forever
> > because it doesn't sleep anymore and as a result never wakeup and call
> > feec(). Such task can be detected by comparing util_avg or runnable_avg
> > with the compute capacity of the CPU. Once detected, we can call feec() to
> > check if there is a better CPU for the stuck task. The call can be done in
> > 2 places:
> > - When the task is put back in the runnnable list after its running slice
> >    with the balance callback mecanism similarly to the rt/dl push callback.
> > - During cfs tick when there is only 1 running task stuck on the CPU in
> >    which case the balance callback can't be used.
> >
> > This push callback doesn't replace the current misfit task mecanism which
> > is already implemented but this could be considered as a follow up serie.
> >
> >
> > This push callback mecanism with the new feec() algorithm ensures that
> > tasks always get a chance to migrate on the best suitable CPU and don't
> > stay stuck on a CPU which is no more the most suitable one. As examples:
> > - A task waking on a big CPU with a uclamp max preventing it to sleep and
> >    wake up, can migrate on a smaller CPU once it's more power efficient.
> > - The tasks are spread on CPUs in the PD when they target the same OPP.
> >
> > This series implements some of the topics discussed at OSPM [1]. Other
> > topics will be part of an other serie
> >
> > [1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp
> >
> > Vincent Guittot (5):
> >    sched/fair: Filter false overloaded_group case for EAS
> >    energy model: Add a get previous state function
> >    sched/fair: Rework feec() to use cost instead of spare capacity
> >    sched/fair: Use EAS also when overutilized
> >    sched/fair: Add push task callback for EAS
> >
> >   include/linux/energy_model.h |  18 +
> >   kernel/sched/fair.c          | 693 +++++++++++++++++++++++------------
> >   kernel/sched/sched.h         |   2 +
> >   3 files changed, 488 insertions(+), 225 deletions(-)
> >
>
> On second look, I do wonder if this series should be split into
> individual patches or mini-series. Some of the ideas, like
> overloaded_groups or calling EAS at more locations rather than just
> wake-up events, might be easier to review and merge if they are independent.

The series is almost ready, I was waiting for the support of v6.12 on
a device like pixel 6 to run some benchmarks but it is not yet
available publicly at least so I might send the serie without such
figures. I also wanted to test it with delayed dequeued enabled this
time unlike previous version:
https://lore.kernel.org/lkml/20241129161756.3081386-1-vincent.guittot@linaro.org/

