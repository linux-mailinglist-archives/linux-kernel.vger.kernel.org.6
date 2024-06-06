Return-Path: <linux-kernel+bounces-203509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1158FDC49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FC4285302
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A5FC0B;
	Thu,  6 Jun 2024 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ7Qj1yN"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF10440C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638438; cv=none; b=ROQB2pktgRTyL7zBMNMk3m4wLPTnjba8ibjzt+O4WAvhS5x/VVGL+W2797l1owKTgdBU4aiCKveoKRQp0UbaPXHt94vFA8hljMBeFQlZsM1z80ozZ8A1nWsR15NNnf32IAl3Nbw0l2SWSkvM9y53fRC+JP7YwqeVDpKFqJjtAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638438; c=relaxed/simple;
	bh=TrdCEEkaqWXYdQ7jFC4cKi5oAvIp8/6WtjmrVf4XU4Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gfyIceSAkzAvdu5lNvxr0/NRXoetUCHfoX5l+mw8bLja9gs0g7fWvRKsvSADEz8Q/3SevWNRbUy68IFx5HDlcKAmn+uK97Y31dTjcQ5KvSpP+zdkir5QErlpEbh6DOqtFjKKX4DgTvtkYUtnKYNLDN2bs792zJAaM+tj9HWRsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ7Qj1yN; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8d0a1e500so262917a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717638435; x=1718243235; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7zSc7WfmsW47x9yDqqbJIVYYHv863Xr3VenXezOtNE=;
        b=lJ7Qj1yN29nJQe5YwXzsEMKQ5tfGZciQRs62zdq977fLBSmO/bHol6kDz2q4Cl648a
         LZfd4brAnvSpVVb5oa8kVat8CJhbrO9wdNVN9UvAi/XdB3V70hV+aCEgTikDXfl7V2Qq
         ga0wr8w6Y/OWxNuQs49T6/jW7mPT6uNXPmCX29tmZaUnvaazkQ2Y1k28IU1seYD5yf6p
         f5hx/t1inuF0EDc8aZEwi9EDJoI3ijpH+Rj7vyseN6KqWU6sMFZ0mkQRR+kM4pH2/D2b
         1HJ3+zNt1Fp564xZGR6geHJc91oCfWTlJeP6ouTsVYblI1fNOQDLwSwZQvi+NhCkJG1I
         pqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717638435; x=1718243235;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7zSc7WfmsW47x9yDqqbJIVYYHv863Xr3VenXezOtNE=;
        b=ad8YQL1bhPZN2eUO+GfUKxU1Qju4XIWP4wDUNyl6Heo0ZPj9KP8gnQVhtHjxeQNfSS
         1xOULDKW4nr2U7nAZ+oletAsFZUaowTSe+NJAiLV2acj8u5ujdoU4ZyDAg9lIPIvVIBc
         21T33v/Hj0Eu5Wz4OslmADZADMH4JgsX3uUbo/UXrBLpFVKpv2PS7eypIkJXAsBqb05r
         pwR3krEMn4tHhmcx2QlDnNNmZVtvmvbR+DHa4QZnCvSmIVoP3Ce1H6TztsU/812mwe8s
         L9ZypN9hUd2aUfc6rGP+YL1Ide+9OwMbmJUGpREDvvnDBG8HulnEgbQ2Vo+a4wPCSb1v
         2rvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHLxVUBg7zxkQmkUdu3ZzrGxZOPwg9u/sf8EvMl8whFBDKLzOtiZE+tl/FXswswzA9xamqDZKriJPvj57m2SxhkXvpy2pYBKPGpDx1
X-Gm-Message-State: AOJu0Yy+aAFPORWleK8vmQ5jRD+yTvDMBonpdUgZ2XW6oCKSpwKOKAEX
	TZ+aJRZ9uD9XjhzXTgl5fAshGGLY5l/rIBe0WuqXCj5BT9+zld0n
X-Google-Smtp-Source: AGHT+IEVwQvklmN0rubvKZwWp6xmsRlajYTNSUBByzNaFa+D69kTFaKrgQba/JTQ5jEyxDQrVlWAMQ==
X-Received: by 2002:a9d:74d6:0:b0:6f2:697f:9c98 with SMTP id 46e09a7af769-6f9434623dcmr4400105a34.20.1717638435210;
        Wed, 05 Jun 2024 18:47:15 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038959f9fsm1357961cf.2.2024.06.05.18.47.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2024 18:47:14 -0700 (PDT)
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
In-Reply-To: <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
Date: Thu, 6 Jun 2024 09:46:53 +0800
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
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
 Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>,
 Balakumaran Kannan <kumaran.4353@gmail.com>,
 Mike Galbraith <efault@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF70ED2D-2566-4CA7-A9BB-E8536F353797@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
 <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 6, 2024, at 01:19, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> Hi Prateek, Chunxin,
>=20
> On 2024-05-28 at 10:32:23 +0530, K Prateek Nayak wrote:
>> Hello Chunxin,
>>=20
>> On 5/28/2024 8:12 AM, Chunxin Zang wrote:
>>>=20
>>>> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
>>>>=20
>>>> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
>>>>> I found that some tasks have been running for a long enough time =
and
>>>>> have become illegal, but they are still not releasing the CPU. =
This
>>>>> will increase the scheduling delay of other processes. Therefore, =
I
>>>>> tried checking the current process in wakeup_preempt and =
entity_tick,
>>>>> and if it is illegal, reschedule that cfs queue.
>>>>>=20
>>>>> The modification can reduce the scheduling delay by about 30% when
>>>>> RUN_TO_PARITY is enabled.
>>>>> So far, it has been running well in my test environment, and I =
have
>>>>> pasted some test results below.
>>>>>=20
>>>>=20
>>>> Interesting, besides hackbench, I assume that you have workload in
>>>> real production environment that is sensitive to wakeup latency?
>>>=20
>>> Hi Chen
>>>=20
>>> Yes, my workload  are quite sensitive to wakeup latency .
>>>>=20
>>>>>=20
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 03be0d1330a6..a0005d240db5 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>>>>> hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>>>> return;
>>>>> #endif
>>>>> +
>>>>> + if (!entity_eligible(cfs_rq, curr))
>>>>> + resched_curr(rq_of(cfs_rq));
>>>>> }
>>>>>=20
>>>>=20
>>>> entity_tick() -> update_curr() -> update_deadline():
>>>> se->vruntime >=3D se->deadline ? resched_curr()
>>>> only current has expired its slice will it be scheduled out.
>>>>=20
>>>> So here you want to schedule current out if its lag becomes 0.
>>>>=20
>>>> In lastest sched/eevdf branch, it is controlled by two sched =
features:
>>>> RESPECT_SLICE: Inhibit preemption until the current task has =
exhausted it's slice.
>>>> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until =
0-lag.
>>>> =
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dsched/eevdf&id=3De04f5454d68590a239092a700e9bbaf84270397c
>>>>=20
>>>> Maybe something like this can achieve your goal
>>>> if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
>>>> resched_curr
>>>>=20
>>>>>=20
>>>>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct =
rq *rq, struct task_struct *p, int
>>>>> if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>>>>> return;
>>>>>=20
>>>>> + if (!entity_eligible(cfs_rq, se))
>>>>> + goto preempt;
>>>>> +
>>>>=20
>>>> Not sure if this is applicable, later in this function, =
pick_eevdf() checks
>>>> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, =
curr will
>>>> be evicted. And this change does not consider the cgroup hierarchy.
>>=20
>> The above line will be referred to as [1] below.
>>=20
>>>>=20
>>>> Besides, the check of current eligiblity can get false negative =
result,
>>>> if the enqueued entity has a positive lag. Prateek proposed to
>>>> remove the check of current's eligibility in pick_eevdf():
>>>> =
https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/=

>>>=20
>>> Thank you for letting me know about Peter's latest updates and =
thoughts.
>>> Actually, the original intention of my modification was to minimize =
the
>>> traversal of the rb-tree as much as possible. For example, in the =
following
>>> scenario, if 'curr' is ineligible, the system would still traverse =
the rb-tree in
>>> 'pick_eevdf' to return an optimal 'se', and then trigger  =
'resched_curr'. After
>>> resched, the scheduler will call 'pick_eevdf' again, traversing the
>>> rb-tree once more. This ultimately results in the rb-tree being =
traversed
>>> twice. If it's possible to determine that 'curr' is ineligible =
within 'wakeup_preempt'
>>> and directly trigger a 'resched', it would reduce the traversal of =
the rb-tree
>>> by one time.
>>>=20
>>>=20
>>> wakeup_preempt-> pick_eevdf                                      -> =
resched_curr
>>>                                                 |->'traverse the =
rb-tree'  |
>>> schedule->pick_eevdf
>>>                                   |->'traverse the rb-tree'
>>=20
>> I see what you mean but a couple of things:
>>=20
>> (I'm adding the check_preempt_wakeup_fair() hunk from the original =
patch
>> below for ease of interpretation)
>>=20
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..a0005d240db5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct =
rq *rq, struct task_struct *p, int
>>> if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>>> return;
>>>=20
>>> + if (!entity_eligible(cfs_rq, se))
>>> + goto preempt;
>>> +
>>=20
>> This check uses the root cfs_rq since "task_cfs_rq()" returns the
>> "rq->cfs" of the runqueue the task is on. In presence of cgroups or
>> CONFIG_SCHED_AUTOGROUP, there is a good chance this the task is =
queued
>> on a higher order cfs_rq and this entity_eligible() calculation might
>> not be valid since the vruntime calculation for the "se" is relative =
to
>> the "cfs_rq" where it is queued on. Please correct me if I'm wrong =
but
>> I believe that is what Chenyu was referring to in [1].
>>=20
>=20
> Sorry for the late reply and thanks for help clarify this. Yes, this =
is
> what my previous concern was:
> 1. It does not consider the cgroup and does not check preemption in =
the same
>   level which is covered by find_matching_se().
> 2. The if (!entity_eligible(cfs_rq, se)) for current is redundant =
because
>   later pick_eevdf() will check the eligible of current anyway. But
>   as pointed out by Chunxi, his concern is the double-traverse of the =
rb-tree,
>   I just wonder if we could leverage the cfs_rq->next to store the =
next
>   candidate, so it can be picked directly in the 2nd pick as a fast =
path?
>   Something like below untested:
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..f716646d595e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8349,7 +8349,7 @@ static void set_next_buddy(struct sched_entity =
*se)
> static void check_preempt_wakeup_fair(struct rq *rq, struct =
task_struct *p, int wake_flags)
> {
>        struct task_struct *curr =3D rq->curr;
> -       struct sched_entity *se =3D &curr->se, *pse =3D &p->se;
> +       struct sched_entity *se =3D &curr->se, *pse =3D &p->se, *next;
>        struct cfs_rq *cfs_rq =3D task_cfs_rq(curr);
>        int cse_is_idle, pse_is_idle;
>=20
> @@ -8415,7 +8415,11 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
>        /*
>         * XXX pick_eevdf(cfs_rq) !=3D se ?
>         */
> -       if (pick_eevdf(cfs_rq) =3D=3D pse)
> +       next =3D pick_eevdf(cfs_rq);
> +       if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && next)
> +               set_next_buddy(next);
> +
> +       if (next =3D=3D pse)
>                goto preempt;
>=20
>        return;
>=20
>=20
> thanks,
> Chenyu

Hi Chen

First of all, thank you for your patient response. Regarding the issue =
of avoiding traversing
the RB-tree twice, I initially had two methods in mind.=20
1. Cache the optimal result so that it can be used directly during the =
second pick_eevdf operation.
  This idea is similar to the one you proposed this time.=20
2. Avoid the pick_eevdf operation as much as possible within =
'check_preempt_wakeup_fair.'=20
  Because I believe that 'checking whether preemption is necessary' and =
'finding the optimal
  process to schedule' are two different things. =
'check_preempt_wakeup_fair' is not just to
  check if the newly awakened process should preempt the current =
process; it can also serve
  as an opportunity to check whether any other processes should preempt =
the current one,=20
  thereby improving the real-time performance of the scheduler. Although =
now in pick_eevdf,
  the legitimacy of 'curr' is also evaluated, if the result returned is =
not the awakened process,
  then the current process will still not be preempted. Therefore, I =
posted the v2 PATCH.=20
  The implementation of v2 PATCH might express this point more clearly.=20=

=
https://lore.kernel.org/lkml/20240529141806.16029-1-spring.cxz@gmail.com/T=
/

I previously implemented and tested both of these methods, and the test =
results showed that
method 2 had somewhat more obvious benefits. Therefore, I submitted =
method 2. Now that I
think about it, perhaps method 1 could also be viable at the same time. =
:)

thanks=20
Chunixn

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..f67894d8fbc8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -563,6 +563,8 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
        return (s64)(se->vruntime - cfs_rq->min_vruntime);
 }

+static void unset_pick_cached(struct cfs_rq *cfs_rq);
+
 #define __node_2_se(node) \
        rb_entry((node), struct sched_entity, run_node)

@@ -632,6 +634,8 @@ avg_vruntime_add(struct cfs_rq *cfs_rq, struct =
sched_entity *se)

        cfs_rq->avg_vruntime +=3D key * weight;
        cfs_rq->avg_load +=3D weight;
+
+       unset_pick_cached(cfs_rq);
 }

 static void
@@ -642,6 +646,8 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct =
sched_entity *se)

        cfs_rq->avg_vruntime -=3D key * weight;
        cfs_rq->avg_load -=3D weight;
+
+       unset_pick_cached(cfs_rq);
 }

 static inline
@@ -651,6 +657,8 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 =
delta)
         * v' =3D v + d =3D=3D> avg_vruntime' =3D avg_runtime - =
d*avg_load
         */
        cfs_rq->avg_vruntime -=3D cfs_rq->avg_load * delta;
+
+       unset_pick_cached(cfs_rq);
 }

 /*
@@ -745,6 +753,36 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
        return vruntime_eligible(cfs_rq, se->vruntime);
 }

+static struct sched_entity *try_to_get_pick_cached(struct cfs_rq* =
cfs_rq)
+{
+       struct sched_entity *se;
+
+       se =3D cfs_rq->pick_cached;
+
+       return se =3D=3D NULL ? NULL : (se->on_rq ? se : NULL);
+}
+
+static void unset_pick_cached(struct cfs_rq *cfs_rq)
+{
+       cfs_rq->pick_cached =3D NULL;
+}
+
+static void set_pick_cached(struct sched_entity *se)
+{
+       if (!se || !se->on_rq)
+               return;
+
+       cfs_rq_of(se)->pick_cached =3D se;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
        u64 min_vruntime =3D cfs_rq->min_vruntime;
@@ -856,6 +894,51 @@ struct sched_entity *__pick_first_entity(struct =
cfs_rq *cfs_rq)
        return __node_2_se(left);
 }

+static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
+{
+       struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_node;
+       struct sched_entity *se =3D __pick_first_entity(cfs_rq);
+       struct sched_entity *best =3D NULL;
+
+       /* Pick the leftmost entity if it's eligible */
+       if (se && entity_eligible(cfs_rq, se))
+               return se;
+
+       /* Heap search for the EEVD entity */
+       while (node) {
+               struct rb_node *left =3D node->rb_left;
+
+               /*
+               * Eligible entities in left subtree are always better
+               * choices, since they have earlier deadlines.
+               */
+               if (left && vruntime_eligible(cfs_rq,
+                               __node_2_se(left)->min_vruntime)) {
+                       node =3D left;
+                       continue;
+               }
+
+               se =3D __node_2_se(node);
+
+               /*
+               * The left subtree either is empty or has no eligible
+               * entity, so check the current node since it is the one
+               * with earliest deadline that might be eligible.
+               */
+               if (entity_eligible(cfs_rq, se)) {
+                       best =3D se;
+                       break;
+               }
+
+               node =3D node->rb_right;
+       }
+
+       if (best)
+               set_pick_cached(best);
+
+       return best;
+}
+
 /*
  * Earliest Eligible Virtual Deadline First
  *
@@ -877,7 +960,6 @@ struct sched_entity *__pick_first_entity(struct =
cfs_rq *cfs_rq)
  */
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
-       struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_node;
        struct sched_entity *se =3D __pick_first_entity(cfs_rq);
        struct sched_entity *curr =3D cfs_rq->curr;
        struct sched_entity *best =3D NULL;
@@ -899,41 +981,13 @@ static struct sched_entity *pick_eevdf(struct =
cfs_rq *cfs_rq)
        if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag =3D=3D =
curr->deadline)
                return curr;

-       /* Pick the leftmost entity if it's eligible */
-       if (se && entity_eligible(cfs_rq, se)) {
-               best =3D se;
-               goto found;
-       }
+       best =3D try_to_get_pick_cached(cfs_rq);
+       if (best && !entity_eligible(cfs_rq, best))
+               best =3D NULL;

-       /* Heap search for the EEVD entity */
-       while (node) {
-               struct rb_node *left =3D node->rb_left;
-
-               /*
-                * Eligible entities in left subtree are always better
-                * choices, since they have earlier deadlines.
-                */
-               if (left && vruntime_eligible(cfs_rq,
-                                       =
__node_2_se(left)->min_vruntime)) {
-                       node =3D left;
-                       continue;
-               }
-
-               se =3D __node_2_se(node);
+       if (!best)
+               best =3D __pick_eevdf(cfs_rq);

-               /*
-                * The left subtree either is empty or has no eligible
-                * entity, so check the current node since it is the one
-                * with earliest deadline that might be eligible.
-                */
-               if (entity_eligible(cfs_rq, se)) {
-                       best =3D se;
-                       break;
-               }
-
-               node =3D node->rb_right;
-       }
-found:
        if (!best || (curr && entity_before(curr, best)))
                best =3D curr;

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..373241075449 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -597,6 +597,7 @@ struct cfs_rq {
         */
        struct sched_entity     *curr;
        struct sched_entity     *next;
+       struct sched_entity     *pick_cached;

 #ifdef CONFIG_SCHED_DEBUG
        unsigned int            nr_spread_over;
--
2.34.1


>=20
>>> find_matching_se(&se, &pse);
>>> WARN_ON_ONCE(!pse);
>>>=20
>>> --=20
>>=20
>> In addition to that, There is an update_curr() call below for the =
first
>> cfs_rq where both the entities' hierarchy is queued which is found by
>> find_matching_se(). I believe that is required too to update the
>> vruntime and deadline of the entity where preemption can happen.
>>=20
>> If you want to circumvent a second call to pick_eevdf(), could you
>> perhaps do:
>>=20
>> (Only build tested)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9eb63573110c..653b1bee1e62 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8407,9 +8407,13 @@ static void check_preempt_wakeup_fair(struct =
rq *rq, struct task_struct *p, int
>> update_curr(cfs_rq);
>>=20
>> /*
>> -  * XXX pick_eevdf(cfs_rq) !=3D se ?
>> +  * If the hierarchy of current task is ineligible at the common
>> +  * point on the newly woken entity, there is a good chance of
>> +  * wakeup preemption by the newly woken entity. Mark for resched
>> +  * and allow pick_eevdf() in schedule() to judge which task to
>> +  * run next.
>>  */
>> - if (pick_eevdf(cfs_rq) =3D=3D pse)
>> + if (!entity_eligible(cfs_rq, se))
>> goto preempt;
>>=20
>> return;
>>=20
>> --
>>=20
>> There are other implications here which is specifically highlighted =
by
>> the "XXX pick_eevdf(cfs_rq) !=3D se ?" comment. If the current waking
>> entity is not the entity with the earliest eligible virtual deadline,
>> the current task is still preempted if any other entity has the EEVD.
>>=20
>> Mike's box gave switching to above two thumbs up; I have to check =
what
>> my box says :)
>>=20
>> Following are DeathStarBench results with your original patch =
compared
>> to v6.9-rc5 based tip:sched/core:
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Test          : DeathStarBench
>> Why?       : Some tasks here do no like aggressive preemption
>> Units         : Normalized throughput
>> Interpretation: Higher is better
>> Statistic     : Mean
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Pinning      scaling     tip            eager_preempt (pct imp)
>> 1CCD           1       1.00            0.99 (%diff: -1.13%)
>> 2CCD           2       1.00            0.97 (%diff: -3.21%)
>> 4CCD           3       1.00            0.97 (%diff: -3.41%)
>> 8CCD           6       1.00            0.97 (%diff: -3.20%)
>> --
>>=20
>> I'll give the variants mentioned in the thread a try too to see if
>> some of my assumptions around heavy preemption hold good. I was also
>> able to dig up an old patch by Balakumaran Kannan which skipped
>> pick_eevdf() altogether if "pse" is ineligible which also seems like
>> a good optimization based on current check in
>> check_preempt_wakeup_fair() but it perhaps doesn't help the case of=20=

>> wakeup-latency sensitivity you are optimizing for; only reduces
>> rb-tree traversal if there is no chance of pick_eevdf() returning =
"pse"=20
>> =
https://lore.kernel.org/lkml/20240301130100.267727-1-kumaran.4353@gmail.co=
m/=20
>>=20
>> --
>> Thanks and Regards,
>> Prateek
>>=20
>>>=20
>>>=20
>>> Of course, this would break the semantics of RESPECT_SLICE as well =
as
>>> RUN_TO_PARITY. So, this might be considered a performance =
enhancement
>>> for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.
>>>=20
>>> thanks=20
>>> Chunxin
>>>=20
>>>=20
>>>> If I understand your requirement correctly, you want to reduce the =
wakeup
>>>> latency. There are some codes under developed by Peter, which could
>>>> customized task's wakeup latency via setting its slice:
>>>> =
https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
>>>>=20
>>>> thanks,
>>>> Chenyu



