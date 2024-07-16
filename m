Return-Path: <linux-kernel+bounces-253585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83263932366
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E35282902
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B1197552;
	Tue, 16 Jul 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF45T1Qz"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958D2E832
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123602; cv=none; b=Rvz/lm0uWVUvu3vp6mSJ4KG3M56kSokoNI7LQksGD7V25aUJRTMqkOPQ/yT24IjyMdbVauA/Y7NpbvcNlQzcilPhsP5+gIxNfgY3YFrAzv8vxlnhdu8SKteZn/ize5PlhgsHHpuZ1xYGNLrT788GuqppPAnZxqWwjuU2SDmwvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123602; c=relaxed/simple;
	bh=fw1opmFA1yWu6Zf4s/QanTKQ2IQadzLjtRvu4W109uA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qasLs6MNQe711XM/d2NxLiQTShUKWsNxufxU9RTR/4oA5L3NEKiOODzrRXxNAAOJmfl1sXt7UixxdHp8PXQONCJUaeNt02cxV8tfTcADK1bRYh4n0sETkwYey0t2jEUNQyj5HX0dz3ZgwwiL8Y9C3uHBTAzX9Jth0D2jiEY0fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF45T1Qz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79ef7ecc7d4so325505185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721123600; x=1721728400; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55EDdcQ8nQNovPuhv7U48LBs7k1+cwbUeJ5tdjYXXYE=;
        b=MF45T1QzhPN/qLpVC2am2BmnHu43UyMv4K+cRspG6bRXrtpJp1nk8KAvMc3hLMfZeU
         0b4k/G4frfWB5VNQL9mFSy6oHz4AqrRsh6+TA0SnM1POKDe/aYjGlPVIPcV/pGiEeLt+
         Fzma2ST4dj+UoVwFeKxQ35+ubRW6UPuSnsCYKRsy8JbVT4MBo/hK9HCOi/FkJrBS6w8T
         LJSu7TvXiVzoXzPLMSCIdaldtFYOR4EDuA7ogpchTyesKd9uADhB9g7aeZCtWD0QwWCV
         trt+bbIyFuFebODdw7GsZ5Hq5L7hKgd0jXoIyajJGDQeBbTUrv/eNC0dC3wR1gTZx4sq
         +TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123600; x=1721728400;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55EDdcQ8nQNovPuhv7U48LBs7k1+cwbUeJ5tdjYXXYE=;
        b=Ew5Yzxjk+hfSBMwl0yk0vpvuqZU3m/Y0ZB7o5vjneb+oTqtDfuFDrlcLzXw9oBsBgS
         PazTG0QXB3xdQPxkKztf1EOs+suoy0o6WUv4ga8aaUJDZYeBifRxnT44RQCSorOmxbEJ
         h1w/pnaF8hH6xxqYMx7bdq5bM/uOqn/1X8i63Qz3YSEO2SwTkAnbffU4ebDbHbEOrcyp
         OWRmA0ExysXH3VNg+vqxWpXurKnSQgV5CI4L7L0ODwmAdx9kl/CorOeAZ+Tvp/b40im8
         H9uTX2qx89U4I/trOdrpA8hepE2MSb2I+OVsKlatC9kUO8UQVLjV4gJ8pf2jbeKVpdwS
         QoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeBXzRXsE7IjzUD8DZK3gKIQZcdZ1S5QI4rfM9smme8Zf8XAaE9y2L5jd+aWX3OZ3+kKKbQ5wWnpysW1ywjNCSkOJeCfaaY5PgbC+I
X-Gm-Message-State: AOJu0YzXVk2PVyvVzBJXaLQgED3cJ9yVqcEGY7e9CVi4are5gqJZ5WNr
	vj7v4GVGhdXeEreuPK4sxpxcuQBaZeC8uXnDyM/HcAgjq4K1s43b
X-Google-Smtp-Source: AGHT+IFHVDKFHaoyeov8n775dZ9CaLj5bDkw/sRcccLQN+VHXYMiJQZD6tsReH5V8A9zULLgBIu/6A==
X-Received: by 2002:a05:620a:1a1e:b0:79f:178f:99e6 with SMTP id af79cd13be357-7a17b750175mr208364585a.64.1721123599716;
        Tue, 16 Jul 2024 02:53:19 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba82cdsm276149085a.4.2024.07.16.02.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:53:19 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] sched/fair: Preempt if the current process is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <e53a487f-e811-45de-a188-cadffd8a3a97@gmail.com>
Date: Tue, 16 Jul 2024 17:52:59 +0800
Cc: Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 Chen Yu <yu.c.chen@intel.com>,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 Mike Galbraith <efault@gmx.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Honglei Wang <jameshongleiwang@126.com>,
 Chen Yang <yangchen11@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C49DFE5-657F-4D64-9D2C-9F5D2A8AA220@gmail.com>
References: <20240613131437.9555-1-spring.cxz@gmail.com>
 <20240620125155.GY31592@noisy.programming.kicks-ass.net>
 <8B4C4FA2-C261-4723-ABA4-2EF3CBBB2C0E@gmail.com>
 <36B22124-E952-4508-A4A3-5AE2C944FBDF@gmail.com>
 <9e56b874-724e-4c2e-8e7d-db6317cb414c@gmail.com>
 <e53a487f-e811-45de-a188-cadffd8a3a97@gmail.com>
To: John Stills <johnstills191@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jul 15, 2024, at 21:05, John Stills <johnstills191@gmail.com> =
wrote:
>=20
>=20
>> On Jun 21, 2024, at 21:53, Chunxin Zang <spring.cxz@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> On Jun 20, 2024, at 20:51, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Thu, Jun 13, 2024 at 09:14:37PM +0800, Chunxin Zang wrote:
>>>> ---
>>>> kernel/sched/fair.c | 28 +++++++++++++++++++++-------
>>>> 1 file changed, 21 insertions(+), 7 deletions(-)
>>>>=20
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..21ef610ddb14 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -745,6 +745,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>> return vruntime_eligible(cfs_rq, se->vruntime);
>>>> }
>>>>=20
>>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>> +{
>>>> + if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <=3D 1 ||
>>>> +    entity_eligible(cfs_rq, se))
>>>> + return false;
>>>> +
>>>> + return true;
>>>> +}
>>>> +
>>>> static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 =
vruntime)
>>>> {
>>>> u64 min_vruntime =3D cfs_rq->min_vruntime;
>>>> @@ -974,11 +983,13 @@ static void clear_buddies(struct cfs_rq =
*cfs_rq, struct sched_entity *se);
>>>> /*
>>>> * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
>>>> * this is probably good enough.
>>>> + *
>>>> + * return true if se need preempt
>>>> */
>>>> -static void update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>>>> +static bool update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>>>> {
>>>> if ((s64)(se->vruntime - se->deadline) < 0)
>>>> - return;
>>>> + return false;
>>>>=20
>>>> /*
>>>> * For EEVDF the virtual time slope is determined by w_i (iow.
>>>> @@ -995,10 +1006,7 @@ static void update_deadline(struct cfs_rq =
*cfs_rq, struct sched_entity *se)
>>>> /*
>>>> * The task has consumed its request, reschedule.
>>>> */
>>>> - if (cfs_rq->nr_running > 1) {
>>>> - resched_curr(rq_of(cfs_rq));
>>>> - clear_buddies(cfs_rq, se);
>>>> - }
>>>> + return true;
>>>> }
>>>>=20
>>>> #include "pelt.h"
>>>> @@ -1157,6 +1165,7 @@ static void update_curr(struct cfs_rq =
*cfs_rq)
>>>> {
>>>> struct sched_entity *curr =3D cfs_rq->curr;
>>>> s64 delta_exec;
>>>> + bool need_preempt;
>>>>=20
>>>> if (unlikely(!curr))
>>>> return;
>>>> @@ -1166,12 +1175,17 @@ static void update_curr(struct cfs_rq =
*cfs_rq)
>>>> return;
>>>>=20
>>>> curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
>>>> - update_deadline(cfs_rq, curr);
>>>> + need_preempt =3D update_deadline(cfs_rq, curr);
>>>> update_min_vruntime(cfs_rq);
>>>>=20
>>>> if (entity_is_task(curr))
>>>> update_curr_task(task_of(curr), delta_exec);
>>>>=20
>>>> + if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
>>>> + resched_curr(rq_of(cfs_rq));
>>>> + clear_buddies(cfs_rq, curr);
>>>> + }
>>>> +
>>>> account_cfs_rq_runtime(cfs_rq, delta_exec);
>>>> }
>>> Yeah sorry no. This will mess up the steady state schedule. At best =
we
>>> can do something like the below which will make PREEMPT_SHORT a =
little
>>> more effective I suppose.
>>>=20
>>>=20
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -985,10 +985,10 @@ static void clear_buddies(struct cfs_rq
>>> * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
>>> * this is probably good enough.
>>> */
>>> -static void update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>>> +static bool update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>>> {
>>> if ((s64)(se->vruntime - se->deadline) < 0)
>>> - return;
>>> + return false;
>>>=20
>>> /*
>>> * For EEVDF the virtual time slope is determined by w_i (iow.
>>> @@ -1005,10 +1005,7 @@ static void update_deadline(struct cfs_r
>>> /*
>>> * The task has consumed its request, reschedule.
>>> */
>>> - if (cfs_rq->nr_running > 1) {
>>> - resched_curr(rq_of(cfs_rq));
>>> - clear_buddies(cfs_rq, se);
>>> - }
>>> + return true;
>>> }
>>>=20
>>> #include "pelt.h"
>>> @@ -1168,6 +1165,8 @@ static void update_curr(struct cfs_rq *c
>>> {
>>> struct sched_entity *curr =3D cfs_rq->curr;
>>> s64 delta_exec;
>>> + struct rq *rq;
>>> + bool resched;
>>>=20
>>> if (unlikely(!curr))
>>> return;
>>> @@ -1177,13 +1176,23 @@ static void update_curr(struct cfs_rq *c
>>> return;
>>>=20
>>> curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
>>> - update_deadline(cfs_rq, curr);
>>> + resched =3D update_deadline(cfs_rq, curr);
>>> update_min_vruntime(cfs_rq);
>>>=20
>>> if (entity_is_task(curr))
>>> update_curr_task(task_of(curr), delta_exec);
>>>=20
>>> account_cfs_rq_runtime(cfs_rq, delta_exec);
>>> +
>>> + rq =3D rq_of(cfs_rq);
>>> + if (rq->nr_running =3D=3D 1)
>>> + return;
>>> +
>>> + if (resched ||
>>> +    (curr->vlag !=3D curr->deadline && !entity_eligible(cfs_rq, =
curr))) {
>>> + resched_curr(rq);
>>> + clear_buddies(cfs_rq, curr);
>>> + }
>>> }
>>>=20
>>> static void update_curr_fair(struct rq *rq)
>> Hi peter
>>=20
>> Got it. If I understand correctly, modifications to basic interfaces =
like update_curr
>> should be appropriate and not too aggressive. Additionally, these =
changes have
>> already shown significant improvements in scheduling delay (test =
results are at the
>> end). How about we limit this patch to these changes for now? =
Actually, I also want
>> to try a more aggressive preemption under NO_RUN_TO_PARITY, but it =
might be
>> better to consider this comprehensively after integrating the changes =
from your
>> latest branch.
>>=20
>>=20
>> Comparison of this modification with the mainline EEVDF in =
cyclictest.
>>=20
>>                                  EEVDF      PATCH EEVDF-NO_PARITY  =
PATCH-NO_PARITY
>>=20
>>   LNICE(-19)    # Avg Latencies: 00191      00162      00089 00080
>>=20
>>   LNICE(0)      # Avg Latencies: 00466      00404      00289 00285
>>=20
>>   LNICE(19)     # Avg Latencies: 37151      38781      18293 19315
>>=20
>> thanks
>> Chunxin
>>=20
>>=20
> Hi Chunxin
>=20
> The latency test results look great. Have you conducted tests in other =
scenarios, such
> as performance testing in production networks or machine learning?
>=20
> --=20
> thanks,
> John
>=20
>=20

Hi John

Due to limited resources in my environment, over the past month, I have =
mainly conducted
basic scheduling latency tests (hackbench + cyclictest). Currently, this =
modification has been
merged into Peter's eevdf branch and is expected to be released with =
Peter's other changes
in the next version. I believe there will be more test data available at =
that time.

[sched/eevdf: Allow shorter slices to wakeup-preempt]
=
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dsched/eevdf&id=3D87ca38328760c9834c465d6939b4e89aa8354ac3

thanks
Chunxin



