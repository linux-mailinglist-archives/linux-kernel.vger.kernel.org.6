Return-Path: <linux-kernel+bounces-191862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846768D1538
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03E01C21B95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E967175B;
	Tue, 28 May 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4GLmUHY"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A257172F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880735; cv=none; b=r5yUNmQDG7Qam/D36p3tzjUADn+yPKs80XtvLP10xfeGYzo4ZjHxpUBXbAhILMfVz7rfEO4jq9y2GKGqSMMN7saDoaxNEcgnWdkCr4TFT+q7W6hwmwQh8Jn1mTQQ4YD3aKwvVwURSL2dU00vPPQMlan/mJdZ0iGS81v0JO85Psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880735; c=relaxed/simple;
	bh=gj2J0ca5uywAni3lh5rRWUwLV5CRBnEGlpaBGP/pIkI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ucs5YspVzDWXyNarjYqataNroeB/a6QQFSv3tL2jJ7Vd+YoYqYRf38nxnVDdvziLGXRHHavSGIWLPxkZG0teIO0say8KxgnbZ9eITdhCMcdor1QFc+3toqfBt7zfO1qxUeCQh3aXXznmiEL+D9R1kYIilQZFE4gCb1rSppS9FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4GLmUHY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ad7a2f8715so5120616d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716880733; x=1717485533; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kbd+GIXBG1LSJLPSDlm8BoJllGvNCDJqQTnUMkYgis=;
        b=V4GLmUHY3TFGHftTyil/KrQHcf4pXCfN9s+ikJjI0dUQq3mAH3HKxYl/Ai6466vUas
         /aHTespzLjDH6W440b6Wc7SL9jCp8pKXptzkINBIt6e5dLWcHPWdl2vYWWI/21HRwLeK
         8G6FsfwQOAgstQMxEKGqc7FBSNUu1RIKTH0WXvOZWHe+ng1rKRy6IT81nHVgVTRoay9f
         I+rmRx2CqkRfF3hC3fm2E0NsxPR3Q+lmTCbOtXk+YL4PSR8+NRtFuvsNjw2aGDQIf6vb
         5DdaU8Msvqe3KxP2oLqFB8y1ii/kABtz+GZ1h4B9KLbylegbJOpG8Hl7wMXVRC3r+xVf
         6mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880733; x=1717485533;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kbd+GIXBG1LSJLPSDlm8BoJllGvNCDJqQTnUMkYgis=;
        b=BaK0LdNhEPBCmf2ecitkyIW0uOQY6I2IlY7KgX6jvyTKg3FF/O5bswXpQh0QsUHty4
         GEkJ4oF1RD9hjGvlxIlR+rJU7Aea3WTNn3yg2D2mLUOEgL5B6e6kUfpt2lB8ILFpyB0i
         siMHch/tUx7jMJA4icUOPWCwGSyLmRswoBXKX0gGDxet3uCwhR6wTPXEBrBaejBhb9XB
         eu5gu6XWNU4bQF3YAue0Xx6HaDuubsrGqsfraqt1bUE2EX0+ftRhei1yixl2IlSKqN6Z
         TL7HDDRWebjJFiqXgmFSVNQZKIknhFhT3W858upr9kUPrYdDCnXsgcsfcMP5qdl3jhSn
         UN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+nLS2wbW3HFV0/Yi+DrskO3Zo4e8Ym5QLlIOwfQTytWBoq6jluS7s6G0JqZzGi+R5TUVYnaMoObbhUWDQzJAHGdvuocK5y3y0ADk8
X-Gm-Message-State: AOJu0YxW/m0X/Xj0/pPcz1W0rDd7M0hLsR7ZCnal0kckIxUih2yEHl8c
	xhZIVFUiwJQO5ickKAqp6B04oiZ+f0WhZuyHByCK8UEjZYrBZX3z
X-Google-Smtp-Source: AGHT+IHWWbIKBstmgkhBOSYbYu7SP29DEV6zLhYPrzaktkDLXhGVHERcfdooCgf96qpACEnlcNk5Fw==
X-Received: by 2002:ad4:4eec:0:b0:6ad:7a01:1980 with SMTP id 6a1803df08f44-6ad7a011a85mr99704126d6.2.1716880732631;
        Tue, 28 May 2024 00:18:52 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad77430c57sm24438516d6.38.2024.05.28.00.18.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2024 00:18:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
Date: Tue, 28 May 2024 15:18:35 +0800
Cc: Chen Yu <yu.c.chen@intel.com>,
 mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com,
 zhouchunhua@lixiang.com,
 zangchunxin@lixiang.com,
 Balakumaran Kannan <kumaran.4353@gmail.com>,
 Mike Galbraith <efault@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D065A1B-7220-4575-B0D9-3442A623E5F6@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
X-Mailer: Apple Mail (2.3731.700.6)

Hi Prateek

> On May 28, 2024, at 13:02, K Prateek Nayak <kprateek.nayak@amd.com> =
wrote:
>=20
> Hello Chunxin,
>=20
> On 5/28/2024 8:12 AM, Chunxin Zang wrote:
>>=20
>>> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
>>>=20
>>> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
>>>> I found that some tasks have been running for a long enough time =
and
>>>> have become illegal, but they are still not releasing the CPU. This
>>>> will increase the scheduling delay of other processes. Therefore, I
>>>> tried checking the current process in wakeup_preempt and =
entity_tick,
>>>> and if it is illegal, reschedule that cfs queue.
>>>>=20
>>>> The modification can reduce the scheduling delay by about 30% when
>>>> RUN_TO_PARITY is enabled.
>>>> So far, it has been running well in my test environment, and I have
>>>> pasted some test results below.
>>>>=20
>>>=20
>>> Interesting, besides hackbench, I assume that you have workload in
>>> real production environment that is sensitive to wakeup latency?
>>=20
>> Hi Chen
>>=20
>> Yes, my workload  are quite sensitive to wakeup latency .
>>>=20
>>>>=20
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..a0005d240db5 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>>>> hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>>> return;
>>>> #endif
>>>> +
>>>> + if (!entity_eligible(cfs_rq, curr))
>>>> + resched_curr(rq_of(cfs_rq));
>>>> }
>>>>=20
>>>=20
>>> entity_tick() -> update_curr() -> update_deadline():
>>> se->vruntime >=3D se->deadline ? resched_curr()
>>> only current has expired its slice will it be scheduled out.
>>>=20
>>> So here you want to schedule current out if its lag becomes 0.
>>>=20
>>> In lastest sched/eevdf branch, it is controlled by two sched =
features:
>>> RESPECT_SLICE: Inhibit preemption until the current task has =
exhausted it's slice.
>>> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until =
0-lag.
>>> =
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dsched/eevdf&id=3De04f5454d68590a239092a700e9bbaf84270397c
>>>=20
>>> Maybe something like this can achieve your goal
>>> if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
>>> resched_curr
>>>=20
>>>>=20
>>>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct =
rq *rq, struct task_struct *p, int
>>>> if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>>>> return;
>>>>=20
>>>> + if (!entity_eligible(cfs_rq, se))
>>>> + goto preempt;
>>>> +
>>>=20
>>> Not sure if this is applicable, later in this function, pick_eevdf() =
checks
>>> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, =
curr will
>>> be evicted. And this change does not consider the cgroup hierarchy.
>=20
> The above line will be referred to as [1] below.
>=20
>>>=20
>>> Besides, the check of current eligiblity can get false negative =
result,
>>> if the enqueued entity has a positive lag. Prateek proposed to
>>> remove the check of current's eligibility in pick_eevdf():
>>> =
https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/=

>>=20
>> Thank you for letting me know about Peter's latest updates and =
thoughts.
>> Actually, the original intention of my modification was to minimize =
the
>> traversal of the rb-tree as much as possible. For example, in the =
following
>> scenario, if 'curr' is ineligible, the system would still traverse =
the rb-tree in
>> 'pick_eevdf' to return an optimal 'se', and then trigger  =
'resched_curr'. After
>> resched, the scheduler will call 'pick_eevdf' again, traversing the
>> rb-tree once more. This ultimately results in the rb-tree being =
traversed
>> twice. If it's possible to determine that 'curr' is ineligible within =
'wakeup_preempt'
>> and directly trigger a 'resched', it would reduce the traversal of =
the rb-tree
>> by one time.
>>=20
>>=20
>> wakeup_preempt-> pick_eevdf                                      -> =
resched_curr
>>                                                 |->'traverse the =
rb-tree'  |
>> schedule->pick_eevdf
>>                                   |->'traverse the rb-tree'
>=20
> I see what you mean but a couple of things:
>=20
> (I'm adding the check_preempt_wakeup_fair() hunk from the original =
patch
> below for ease of interpretation)
>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 03be0d1330a6..a0005d240db5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
>> if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>> return;
>>=20
>> + if (!entity_eligible(cfs_rq, se))
>> + goto preempt;
>> +
>=20
> This check uses the root cfs_rq since "task_cfs_rq()" returns the
> "rq->cfs" of the runqueue the task is on. In presence of cgroups or
> CONFIG_SCHED_AUTOGROUP, there is a good chance this the task is queued
> on a higher order cfs_rq and this entity_eligible() calculation might
> not be valid since the vruntime calculation for the "se" is relative =
to
> the "cfs_rq" where it is queued on. Please correct me if I'm wrong but
> I believe that is what Chenyu was referring to in [1].

=20
Thank you for explaining so much to me; I am trying to understand all of =
this. :)

>=20
>> find_matching_se(&se, &pse);
>> WARN_ON_ONCE(!pse);
>>=20
>> --=20
>=20
> In addition to that, There is an update_curr() call below for the =
first
> cfs_rq where both the entities' hierarchy is queued which is found by
> find_matching_se(). I believe that is required too to update the
> vruntime and deadline of the entity where preemption can happen.
>=20
> If you want to circumvent a second call to pick_eevdf(), could you
> perhaps do:
>=20
> (Only build tested)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9eb63573110c..653b1bee1e62 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8407,9 +8407,13 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
> update_curr(cfs_rq);
>=20
> /*
> -  * XXX pick_eevdf(cfs_rq) !=3D se ?
> +  * If the hierarchy of current task is ineligible at the common
> +  * point on the newly woken entity, there is a good chance of
> +  * wakeup preemption by the newly woken entity. Mark for resched
> +  * and allow pick_eevdf() in schedule() to judge which task to
> +  * run next.
>  */
> - if (pick_eevdf(cfs_rq) =3D=3D pse)
> + if (!entity_eligible(cfs_rq, se))
> goto preempt;
>=20
> return;
>=20
> --
>=20
> There are other implications here which is specifically highlighted by
> the "XXX pick_eevdf(cfs_rq) !=3D se ?" comment. If the current waking
> entity is not the entity with the earliest eligible virtual deadline,
> the current task is still preempted if any other entity has the EEVD.
>=20
> Mike's box gave switching to above two thumbs up; I have to check what
> my box says :)
>=20
> Following are DeathStarBench results with your original patch compared
> to v6.9-rc5 based tip:sched/core:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Test          : DeathStarBench
> Why?       : Some tasks here do no like aggressive preemption
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : Mean
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Pinning      scaling     tip            eager_preempt (pct imp)
> 1CCD           1       1.00            0.99 (%diff: -1.13%)
> 2CCD           2       1.00            0.97 (%diff: -3.21%)
> 4CCD           3       1.00            0.97 (%diff: -3.41%)
> 8CCD           6       1.00            0.97 (%diff: -3.20%)
> --

Please forgive me as I have not used the DeathStarBench suite before. =
Does
this test result indicate that my modifications have resulted in tasks =
that do no
like aggressive preemption being even less likely to be preempted?

thanks
Chunxin

> I'll give the variants mentioned in the thread a try too to see if
> some of my assumptions around heavy preemption hold good. I was also
> able to dig up an old patch by Balakumaran Kannan which skipped
> pick_eevdf() altogether if "pse" is ineligible which also seems like
> a good optimization based on current check in
> check_preempt_wakeup_fair() but it perhaps doesn't help the case of=20
> wakeup-latency sensitivity you are optimizing for; only reduces
> rb-tree traversal if there is no chance of pick_eevdf() returning =
"pse"=20
> =
https://lore.kernel.org/lkml/20240301130100.267727-1-kumaran.4353@gmail.co=
m/=20
>=20
> --
> Thanks and Regards,
> Prateek
>=20
>>=20
>>=20
>> Of course, this would break the semantics of RESPECT_SLICE as well as
>> RUN_TO_PARITY. So, this might be considered a performance enhancement
>> for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.
>>=20
>> thanks=20
>> Chunxin
>>=20
>>=20
>>> If I understand your requirement correctly, you want to reduce the =
wakeup
>>> latency. There are some codes under developed by Peter, which could
>>> customized task's wakeup latency via setting its slice:
>>> https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
>>>=20
>>> thanks,
>>> Chenyu



