Return-Path: <linux-kernel+bounces-404608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF9A9C4596
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE0928374C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF111AAE24;
	Mon, 11 Nov 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWSBUhXx"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7514B965
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352126; cv=none; b=MKMw7A+axUh94XixEKxc1xPVllDBbt12shpiK819exqWJtxM6RmGYNKDkR50iV1dYTWJwPKGsHGNDmFr0j+3nfSnZWRuHeCk/zJH86glB4R59LbV+0LpJNg6kv28y9PhV6AdYEMGrhZTqjvjlriX/3FTTA0fBvC9Szvqu6rT0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352126; c=relaxed/simple;
	bh=d5f9aJRbYM0OJHuxLhCNWfIHUNXiMti3UBx9nE3gLu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFlaQpeFdvYd5a7TwWaELLcYpDjvEEAWdB4p1VmyJyEHKk0w6EssA8kkz9BJszvS+m/6xhd2pbCPxhf/1FJfAj/iEXfx9kshfdAbu82PPCJpPtIMXQ7TMgw9JGdPpgCFwfIcrkuDU/LM8MqN6cbDxtI5qwiAjuCvcz2QZDuWniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWSBUhXx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3145740a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731352124; x=1731956924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hwi/8KWScuym5P049bLAnVdfpqUM3J8cront9nixQyM=;
        b=VWSBUhXxz3xrt9I6EHMOA640421vs3aLBWKJz76qqL0yguPNxJdNRsdt50z5hAzJv1
         VPFf9DGW89osICND3T+g1I5heQ1hdBCqcQn2XN0WJWq6WPWz6bKZftt0briRpMwLhvoY
         PozqjJo4Ex9hxMWYaNU1E5m4+dUuYcA/DjWe9rQ9qhOqoLp1Vo9nx9mdlXWmEJN/jQxP
         m0RaksesYOY6t61hjnFaQVYsPIIR5KMiJeCvp81tisbJYrns3erhrdPTKxqd7BaQ1Gu0
         jClZALrDF6lZhTKK0HEhc53Qlfu6JEdH6+yhUvGTLPfNWpMfA7uT9DlPehOaA0Ft1hRt
         OlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352124; x=1731956924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwi/8KWScuym5P049bLAnVdfpqUM3J8cront9nixQyM=;
        b=bgITJ89AGKbjgkl2Dxsf9AOjSWkpmEzXV16D/x7XUjI2QIS6sxgLKgZgXxAu+/t3SB
         0LUvTweVvBsGYH1PMkrkYvEoJVvA2FdDkMLsCJ9Ca4dyu1ZCL99qi3UeuZZFtfiSfgXd
         eeVt5tL4il+LMqKnpEmc0SD7QjQIeeJJD+X3u21AvAs+KL3RSKF3uon6ML5hzyCS8/s+
         NR7+RYE1WmptV2hmJaHVHqROKaIkW7dfSHHo2QPzHtTk8Nx85SXdT1CK7PqXDLwbyWEl
         5HtePkVWrJbEGpbEP3R6vrCMjxw/GOGiqfYgBYywE7Nh7q6EqaIrLWD29dsYITMITTOw
         FRnw==
X-Forwarded-Encrypted: i=1; AJvYcCU0pDKh1A0eXOYGMSmrM2gWRlz22tmJJvUeT1+tSJbxareVx+uoj0+n3NF249X+XLfivKGh+5B3bFzcq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwS7rJnMikD7Pw2S28drihNfkroi3tpvNBZXZgiYx2ZjmlGN8
	xZrFkbsNVFU1FHJq11zzVGnANbQfI6bh4+413HwCEcgTpyezPVSsT/Imo3Lz7EuPcfZYbGNT0Pg
	Pi/URZjIg0dHP1zrZCiKvHPSMEIWVhjNv4q79gQ==
X-Google-Smtp-Source: AGHT+IFg6wyJE517NxGUoZ5pFlbSKcYkrfegI3fWvMbor0S0y2PJyzQMlbLg4BaDgBs1ZWGaDE3xM9LbvlMDSubNxUY=
X-Received: by 2002:a17:90b:54cf:b0:2e2:8349:239d with SMTP id
 98e67ed59e1d1-2e9e4c7268fmr74000a91.28.1731352123972; Mon, 11 Nov 2024
 11:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <22c7f8cb-41a1-4004-9017-fb9a313f80ae@arm.com> <CAKfTPtBjc+x0_8uGEp=f8nJxP0t2Z86kpjSEBY8HdDfa44ZF3g@mail.gmail.com>
 <b7b6e534-9402-458f-af1f-2a8af46ce190@arm.com>
In-Reply-To: <b7b6e534-9402-458f-af1f-2a8af46ce190@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 11 Nov 2024 20:08:32 +0100
Message-ID: <CAKfTPtDrJyJQbm5c+6FiK=F7vNsrX2DYPfJmD67as_aoKbhWaA@mail.gmail.com>
Subject: Re: [PATCH 0/5] sched/fair: Rework EAS to handle more cases
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com, Christian Loehle <Christian.Loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 14:10, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>
>
> On 11/8/24 10:27, Vincent Guittot wrote:
> > Hi Pierre,
> >
> > On Thu, 7 Nov 2024 at 11:14, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> Hello Vincent,
> >> Related to feec(), but not to this patchset, I think there might be a
> >> concurrency issue while running feec().
> >
> > yes, this is a know limitation
> >
> >>
> >> Feec() doesn't have any locking mechanism. This means that multiple CPUs
> >> might run the function at the same time.
> >
> > this is done on purpose as we don't want to lock and slow down the wakeup path
>
> Yes right, this is understandable. However there could be a way to bail out of
> feec() when such case is detected without actually waiting for a lock (cf. the
> prototype).
> We already bail out of feec() when the utilization of a CPU without a task is
> higher than with the task in the energy computation.
>
> >
> >> If:
> >> - 2 tasks with approximately the same utilization wake up at the same time
> >> - some space on an energy efficient CPU is available
> >> feec() will likely select the same target for the 2 tasks.
> >
> > yes
> >
> >>
> >> Once feec() determined a target for a task, util signals are updated in
> >> enqueue_task_fair(). The delta between running feec() <-> enqueue_task_fair()
> >> is ~20us (on a Pixel6). This is not much, but this still allows some other
> >
> > 20us is quite long. this is the worst case on little core lowest freq ?
>
> I only kept the occurrences where feec() ends up with a target != prev_cpu.
> In these case enqueuing is done on the target CPU (cf. __ttwu_queue_wakelist),
> which might take more time.
>
> In the other case, the delta is effectively lower (~10us).
>
> >
> >> CPUs to run feec() util signals that will be wrong in no time.
> >>
> >> Note that it is also possible for one CPU to run feec() for 2 different tasks,
> >> decide to migrate the 2 tasks to another target CPU, and then start enqueueing
> >> the tasks. Meaning one single CPU will run feec() using util signals it knows
> >> are wrong.
> >
> > isn't this case serialized because cpu selection for next task will
> > happen after enqueuing the 1st one
>
> I'm not sure I understand the question, but if the enqueue is done on the
> target CPU, the running CPU might call feec() in the meantime.

When CPUs share LLC, the local cpu enqueues to the target ... unless
target is idle which is the case for your example above

>
> >
> >>
> >> The issue is problematic as it creates some instability. Once a
> >> 'parallel selection' is done, the following scenarios can happen:
> >> - the system goes overutilized, and EAS is disabled
> >> - a frequency spike happen to handle the unexpected load.
> >>     Then the perf. domain becomes less energy efficient compared to other
> >>     perf. domains, and tasks are migrated out of this perf. domain
> >>
> >> I made the following prototype to avoid 'parallel selections'. The goal here
> >> is to tag CPUs that are under pending migration.
> >> A target CPU is tagged as 'eas_pending_enqueue' at the end of feec(). Other
> >> CPUs should therefore not consider this CPU as valid candidate.
> >>
> >> The implementation is a bit raw, but it gives some good results. Using rt-app
> >> workloads, and trying not to have tasks waking up at the same timing during
> >> the whole test:
> >> Workload1:
> >> N tasks with a period of 16ms and a util of 4/8. Each task starts with a
> >> 4ms delay. Each workload lasts 20s and is run over 5 iterations.
> >>
> >> Workload2:
> >> N tasks with a period of (8 +n)ms and a util of 4/8. I.e. the first task
> >> has a period of 8ms, the second task a period of 9ms, etc. Each workload lasts
> >> 20s and is run over 5 iterations.
> >>
> >> Are presented:
> >> - the measured energy consumed, according to the Pixel6 energy meters
> >> - the estimated energy consumed, lisa uses the util signals along with
> >>     the CPU frequencies and the Energy Model to do an estimation.
> >> - the amount of time spent in the overutilized state, in percentage.
> >>
> >> ------
> >>
> >> Workload1:
> >>
> >> Measured energy:
> >> +------+-------+--------------+--------------+------------+
> >> | util | count | without      | with         | ratio      |
> >> +------+-------+--------------+--------------+------------+
> >> | 4    | 8     | 3220.970324  | 3312.097508  | 2.829184   |
> >> | 4    | 12    | 5942.486726  | 5016.106047  | -15.589108 |
> >> | 4    | 16    | 10412.26692  | 10017.633658 | -3.79008   |
> >> | 8    | 8     | 7524.271751  | 7479.451427  | -0.595677  |
> >> | 8    | 12    | 14782.214144 | 14567.282266 | -1.45399   |
> >> | 8    | 16    | 21452.863497 | 19561.143385 | -8.818031  |
> >> +------+-------+--------------+--------------+------------+
> >> Std:
> >> +------+-------+-------------+-------------+
> >> | util | count | without     | with        |
> >> +------+-------+-------------+-------------+
> >> | 4    | 8     | 165.563394  | 48.903514   |
> >> | 4    | 12    | 518.609612  | 81.170952   |
> >> | 4    | 16    | 329.729882  | 192.739245  |
> >> | 8    | 8     | 105.144497  | 336.796522  |
> >> | 8    | 12    | 384.615323  | 339.86986   |
> >> | 8    | 16    | 1252.735561 | 2563.268952 |
> >> +------+-------+-------------+-------------+
> >>
> >> Estimated energy:
> >> +------+-------+-----------+-----------+------------+
> >> | util | count | without   | with      | ratio      |
> >> +------+-------+-----------+-----------+------------+
> >> | 4    | 8     | 1.4372e10 | 1.2791e10 | -11.000273 |
> >> | 4    | 12    | 3.1881e10 | 2.3743e10 | -25.526193 |
> >> | 4    | 16    | 5.7663e10 | 5.4079e10 | -6.215679  |
> >> | 8    | 8     | 2.5622e10 | 2.5337e10 | -1.109823  |
> >> | 8    | 12    | 6.4332e10 | 6.9335e10 | 7.776814   | [1]
> >> | 8    | 16    | 9.5285e10 | 8.2331e10 | -13.594508 |
> >> +------+-------+-----------+-----------+------------+
> >> Std:
> >> +------+-------+----------+-----------+
> >> | util | count | without  | with      |
> >> +------+-------+----------+-----------+
> >> | 4    | 8     | 1.3896e9 | 5.4265e8  |
> >> | 4    | 12    | 4.7511e9 | 5.1521e8  |
> >> | 4    | 16    | 3.5486e9 | 1.2625e9  |
> >> | 8    | 8     | 3.0033e8 | 2.3168e9  |
> >> | 8    | 12    | 8.7739e9 | 3.0743e9  |
> >> | 8    | 16    | 6.7982e9 | 2.2393e10 |
> >> +------+-------+----------+-----------+
> >>
> >> Overutilized ratio (in % of the 20s test):
> >> +------+-------+-----------+-----------+------------+
> >> | util | count | without   | with      | ratio      |
> >> +------+-------+-----------+-----------+------------+
> >> | 4    | 8     | 0.187941  | 0.015834  | -91.575158 |
> >> | 4    | 12    | 0.543073  | 0.045483  | -91.624815 |
> >> | 4    | 16    | 8.510734  | 8.389077  | -1.429448  |
> >> | 8    | 8     | 1.056678  | 0.876095  | -17.089643 |
> >> | 8    | 12    | 36.457757 | 9.260862  | -74.598378 | [1]
> >> | 8    | 16    | 72.327933 | 78.693558 | 8.801061   |
> >> +------+-------+-----------+-----------+------------+
> >> Std:
> >> +------+-------+-----------+-----------+
> >> | util | count | without   | with      |
> >> +------+-------+-----------+-----------+
> >> | 4    | 8     | 0.232077  | 0.016531  |
> >> | 4    | 12    | 0.338637  | 0.040252  |
> >> | 4    | 16    | 0.729743  | 6.368214  |
> >> | 8    | 8     | 1.702964  | 1.722589  |
> >> | 8    | 12    | 34.436278 | 17.314564 |
> >> | 8    | 16    | 14.540217 | 33.77831  |
> >> +------+-------+-----------+-----------+
> >>
> >> ------
> >>
> >> Workload2:
> >>
> >> Measured energy:
> >> +------+-------+--------------+--------------+-----------+
> >> | util | count | without      | with         | ratio     |
> >> +------+-------+--------------+--------------+-----------+
> >> | 4    | 8     | 3357.578785  | 3324.890715  | -0.973561 |
> >> | 4    | 12    | 5024.573746  | 4903.394533  | -2.411731 |
> >> | 4    | 16    | 10114.715431 | 9762.803821  | -3.479204 |
> >> | 8    | 8     | 7485.230678  | 6961.782086  | -6.993086 |
> >> | 8    | 12    | 13720.482516 | 13374.765825 | -2.519712 |
> >> | 8    | 16    | 24846.806317 | 24444.012805 | -1.621108 |
> >> +------+-------+--------------+--------------+-----------+
> >> Std:
> >> +------+-------+------------+------------+
> >> | util | count | without    | with       |
> >> +------+-------+------------+------------+
> >> | 4    | 8     | 87.450628  | 76.955783  |
> >> | 4    | 12    | 106.062839 | 116.882891 |
> >> | 4    | 16    | 182.525881 | 172.819307 |
> >> | 8    | 8     | 874.292359 | 162.790237 |
> >> | 8    | 12    | 151.830636 | 339.286741 |
> >> | 8    | 16    | 904.751446 | 154.419644 |
> >> +------+-------+------------+------------+
> >>
> >> Estimated energy:
> >> +------+-------+-----------+-----------+------------+
> >> | util | count | without   | with      | ratio      |
> >> +------+-------+-----------+-----------+------------+
> >> | 4    | 8     | 1.4778e10 | 1.4805e10 | 0.184658   |
> >> | 4    | 12    | 2.6105e10 | 2.5485e10 | -2.374486  |
> >> | 4    | 16    | 5.8394e10 | 5.7177e10 | -2.083208  |
> >> | 8    | 8     | 3.0275e10 | 2.5973e10 | -14.211178 |
> >> | 8    | 12    | 7.0616e10 | 6.9085e10 | -2.168347  |
> >> | 8    | 16    | 1.3133e11 | 1.2891e11 | -1.839725  |
> >> +------+-------+-----------+-----------+------------+
> >> Std:
> >> +------+-------+----------+----------+
> >> | util | count | without  | with     |
> >> +------+-------+----------+----------+
> >> | 4    | 8     | 3.5449e8 | 8.2454e8 |
> >> | 4    | 12    | 9.4248e8 | 1.1364e9 |
> >> | 4    | 16    | 8.3240e8 | 1.2084e9 |
> >> | 8    | 8     | 9.0364e9 | 5.0381e8 |
> >> | 8    | 12    | 9.9112e8 | 3.0836e9 |
> >> | 8    | 16    | 4.9429e8 | 1.9533e9 |
> >> +------+-------+----------+----------+
> >>
> >> Overutilized ratio (in % of the 20s test):
> >> +------+-------+-----------+----------+------------+
> >> | util | count | without   | with     | ratio      |
> >> +------+-------+-----------+----------+------------+
> >> | 4    | 8     | 0.154992  | 0.049429 | -68.108419 |
> >> | 4    | 12    | 0.132593  | 0.061762 | -53.420202 |
> >> | 4    | 16    | 6.798091  | 4.606102 | -32.244179 |
> >> | 8    | 8     | 1.360703  | 0.174626 | -87.166465 |
> >> | 8    | 12    | 0.519704  | 0.250469 | -51.805502 |
> >> | 8    | 16    | 12.114269 | 8.969281 | -25.961019 |
> >> +------+-------+-----------+----------+------------+
> >> Std:
> >> +------+-------+----------+----------+
> >> | util | count | without  | with     |
> >> +------+-------+----------+----------+
> >> | 4    | 8     | 0.212919 | 0.036856 |
> >> | 4    | 12    | 0.069696 | 0.060257 |
> >> | 4    | 16    | 0.63995  | 0.542028 |
> >> | 8    | 8     | 2.158079 | 0.211775 |
> >> | 8    | 12    | 0.089159 | 0.187436 |
> >> | 8    | 16    | 0.798565 | 1.669003 |
> >> +------+-------+----------+----------+
> >>
> >> ------
> >>
> >> Analysis:
> >>
> >> - [1]
> >> Without the patch, 2 tasks end up on one little CPU. This consumes
> >> less energy than using the medium/big CPU according to the energy model,
> >> but EAS should not be capable of doing such task placement as the little
> >> CPU becomes overutilized.
> >> Without the patch, the system is overutilized a lot more than with the patch.
> >>
> >> -
> >> Looking at the overutilized ratio, being overutilized 0.5% of the time or
> >> 0.05% of the time might seem close, but it means that EAS ended up
> >> doing a bad task placement multiple, independent times.
> >>
> >> -
> >> The overutilized ratio should be checked along the energy results as it
> >> shows how much EAS was involved in the task placement.
> >>
> >> -
> >> Overall, the energy consumed is less. The quantity of energy saved varies
> >> with the workload.
> >>
> >> ------
> >>
> >> On another note, I wanted to ask if there would be a v2 of this present
> >> patchset (sched/fair: Rework EAS to handle more cases),
> >
> > yes, I have been side tracked by other stuff since LPC and haven't
> > been able to finalize test on v2 but it's ongoing
>
> Ok thanks!
>
> >
> >>
> >> Regards,
> >> Pierre
> >>
> >> ------
> >>
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index bb343136ddd0..812d5bf88875 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1592,6 +1592,12 @@ struct task_struct {
> >>           struct user_event_mm            *user_event_mm;
> >>    #endif
> >>
> >> +       /*
> >> +        * Keep track of the CPU feec() migrated this task to.
> >> +        * There is a per-cpu 'eas_pending_enqueue' value to reset.
> >> +        */
> >> +       int eas_target_cpu;
> >> +
> >>           /*
> >>            * New fields for task_struct should be added above here, so that
> >>            * they are included in the randomized portion of task_struct.
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index c157d4860a3b..34911eb059cf 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6945,6 +6945,8 @@ requeue_delayed_entity(struct sched_entity *se)
> >>           se->sched_delayed = 0;
> >>    }
> >>
> >> +DEFINE_PER_CPU(atomic_t, eas_pending_enqueue);
> >> +
> >>    /*
> >>     * The enqueue_task method is called before nr_running is
> >>     * increased. Here we update the fair scheduling stats and
> >> @@ -7064,6 +7066,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>                   check_update_overutilized_status(rq);
> >>
> >>    enqueue_throttle:
> >> +       if (p->eas_target_cpu != -1) {
> >> +               atomic_set(&per_cpu(eas_pending_enqueue, p->eas_target_cpu), 0);
> >> +               p->eas_target_cpu = -1;
> >> +       }
> >> +
> >>           assert_list_leaf_cfs_rq(rq);
> >>
> >>           hrtick_update(rq);
> >> @@ -8451,6 +8458,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>                           if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >>                                   continue;
> >>
> >> +                       /* Skip this CPU as its util signal will be invalid soon. */
> >> +                       if (atomic_read(&per_cpu(eas_pending_enqueue, cpu)) &&
> >> +                           cpu != prev_cpu)
> >> +                               continue;
> >> +
> >>                           util = cpu_util(cpu, p, cpu, 0);
> >>                           cpu_cap = capacity_of(cpu);
> >>
> >> @@ -8560,6 +8572,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>               ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
> >>                   target = best_energy_cpu;
> >>
> >> +       /*
> >> +        *'Lock' the target CPU if there is a migration. Prevent other feec()
> >> +        * calls to use the same target CPU until util signals are not updated.
> >> +        */
> >> +       if (prev_cpu != target) {
> >> +               if (!atomic_cmpxchg_acquire(&per_cpu(eas_pending_enqueue, target), 0, 1))
> >> +                       p->eas_target_cpu = target;
> >> +               else
> >> +                       target = prev_cpu;
> >> +       }
> >> +
> >>           return target;
> >>
> >>    unlock:

