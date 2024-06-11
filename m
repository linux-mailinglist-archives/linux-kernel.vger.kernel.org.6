Return-Path: <linux-kernel+bounces-209909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1552903CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914B11C22D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2417C7C5;
	Tue, 11 Jun 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4U4w3Zj"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36183178CCF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111473; cv=none; b=VqcBzQVOPSAT6AdsIqjvyzg3f96I3nfY5UokSrwlTRSwew1GouUM1Np3n4L2G17ekSbOjO9mMZh7WW+0kl3wKc+B86yAr1fkQ/OViaDz3qYojJMQ7/w+Zff7dOeMQzTApFUujaLh0OdpgqAJrN/QumFm4wopsc0D3VwojDT2v5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111473; c=relaxed/simple;
	bh=lloqD0Sl94z6Mi6yP6qthiWp/0q+JRRIIV6W/0mCEyE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GKQREITSP3YnwQbeXxw9XKhTuirCSY+psbI3TfzJc5CVSzP6ph6Z62sIsmzY4r+n2ez255fhK/aKfXo/QHmwsa4Xz9jsQUN2+JDNeviFmKcrKG+u+ikftSNO49GwjzAGCdtMkjI3zQOvxDXRfI3+RGjK7N62bKTxOKtRd4HPAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4U4w3Zj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b072522bd5so14311726d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718111470; x=1718716270; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XytnEdx9zkc6a1DXxOgihHJGVgrwUk8V6f1CYBQaevM=;
        b=b4U4w3ZjXIZkyng7L1+9+P20dJPTr1KHemcRQUr48lKZefdfSyZRADWq+27JdziLjj
         BB227BHcIsIsOpO4OyJ8D9+am87ZKeKxRZVvfX+3+rLUFKxtp0a0+kzYcC/PDVA+nwuQ
         Va7qPmbRKm1VWiEnyXmZpOI8BnDqBmbxDgJwr1rseQ7HvX4YKQBdAKY+/Hj3VeKF+oRl
         Q0LbryMGFL3brkwEGNGsAKN7SxYXqgELV/YOj8u8qWwB5Nw2DbM2lh4MpIKsUe9bZhCa
         yXu4o7AASenFzRJnPyj528gDHv1GluFnZQ/rTlpqhhMn+qMCSHRX91kizdawHDvfdhoB
         bBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111470; x=1718716270;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XytnEdx9zkc6a1DXxOgihHJGVgrwUk8V6f1CYBQaevM=;
        b=TBaaBeoFkRFaPYXo9xrPO1rCDHBiuLeYLPeHb7xH1on9J/Ym3zm2i8mT/kIYq1EIis
         A3d3beWG4nlM4TkO7+hksCjOQvhaUfAx/20Ndmvn9JYDEtV9N1boP4zZ0Q9zXl4HFuzI
         Jh8Jb+ANEexRjo25XOAW6SQ0XLzWBUTGLfwOryiCLhjP1NtkwTs5oD+uuOXjHz7pfMII
         yoV5AdbcYz9cFyE0HNQMCQViXswg+YJeNCpVhvqbojV+EGNwXvBbdPGM8cQ6SNS30mfi
         +9uuwCj35DazO1kGHzc1EChtGde29DEnd9cM64XyPsZ8dZy1GJVLtch/U0WSz7s1MIgx
         cbPg==
X-Forwarded-Encrypted: i=1; AJvYcCWZqyqYKrfKkaKcf13lMJOCHEumTCRNF93hTgCXm15fUkbj7rwVHWUbzEIxWqq+CNA9+m0hoLsxkczsAfGsnA40EDRCsm9riJ0vozhd
X-Gm-Message-State: AOJu0YyaXa2DE+rEJzg0D8Iv9ZEhtV1eAw9v5emQYTfoI7qWQeYxHn8Z
	DeKdDxHSEv3pfWdESx6JfFaJFJqENE+BAVSE+Bk7dGMvNW+zRBop
X-Google-Smtp-Source: AGHT+IFLTRWZppKcaR+DVNxtG9FH4yeEWC/inwtrU3YURu5IHOstoE5Z7fpnpZ4TLcI9B3giXoz2Fw==
X-Received: by 2002:a05:6214:3d9b:b0:6b0:6788:c3f5 with SMTP id 6a1803df08f44-6b06788c58dmr103460296d6.37.1718111469527;
        Tue, 11 Jun 2024 06:11:09 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f694acbsm56535116d6.42.2024.06.11.06.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2024 06:11:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <ZmJylkNFg7EFgPmZ@chenyu5-mobl2>
Date: Tue, 11 Jun 2024 21:10:50 +0800
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
Message-Id: <9F5C4D69-4238-44DA-9247-5CE8E7B3ECB6@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
 <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
 <CF70ED2D-2566-4CA7-A9BB-E8536F353797@gmail.com>
 <ZmJylkNFg7EFgPmZ@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 7, 2024, at 10:38, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> On 2024-06-06 at 09:46:53 +0800, Chunxin Zang wrote:
>>=20
>>=20
>>> On Jun 6, 2024, at 01:19, Chen Yu <yu.c.chen@intel.com> wrote:
>>>=20
>>>=20
>>> Sorry for the late reply and thanks for help clarify this. Yes, this =
is
>>> what my previous concern was:
>>> 1. It does not consider the cgroup and does not check preemption in =
the same
>>>  level which is covered by find_matching_se().
>>> 2. The if (!entity_eligible(cfs_rq, se)) for current is redundant =
because
>>>  later pick_eevdf() will check the eligible of current anyway. But
>>>  as pointed out by Chunxi, his concern is the double-traverse of the =
rb-tree,
>>>  I just wonder if we could leverage the cfs_rq->next to store the =
next
>>>  candidate, so it can be picked directly in the 2nd pick as a fast =
path?
>>>  Something like below untested:
>>>=20
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 8a5b1ae0aa55..f716646d595e 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8349,7 +8349,7 @@ static void set_next_buddy(struct sched_entity =
*se)
>>> static void check_preempt_wakeup_fair(struct rq *rq, struct =
task_struct *p, int wake_flags)
>>> {
>>>       struct task_struct *curr =3D rq->curr;
>>> -       struct sched_entity *se =3D &curr->se, *pse =3D &p->se;
>>> +       struct sched_entity *se =3D &curr->se, *pse =3D &p->se, =
*next;
>>>       struct cfs_rq *cfs_rq =3D task_cfs_rq(curr);
>>>       int cse_is_idle, pse_is_idle;
>>>=20
>>> @@ -8415,7 +8415,11 @@ static void check_preempt_wakeup_fair(struct =
rq *rq, struct task_struct *p, int
>>>       /*
>>>        * XXX pick_eevdf(cfs_rq) !=3D se ?
>>>        */
>>> -       if (pick_eevdf(cfs_rq) =3D=3D pse)
>>> +       next =3D pick_eevdf(cfs_rq);
>>> +       if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && =
next)
>>> +               set_next_buddy(next);
>>> +
>>> +       if (next =3D=3D pse)
>>>               goto preempt;
>>>=20
>>>       return;
>>>=20
>>>=20
>>> thanks,
>>> Chenyu
>>=20
>> Hi Chen
>>=20
>> First of all, thank you for your patient response. Regarding the =
issue of avoiding traversing
>> the RB-tree twice, I initially had two methods in mind.=20
>> 1. Cache the optimal result so that it can be used directly during =
the second pick_eevdf operation.
>>  This idea is similar to the one you proposed this time.=20
>> 2. Avoid the pick_eevdf operation as much as possible within =
'check_preempt_wakeup_fair.'=20
>>  Because I believe that 'checking whether preemption is necessary' =
and 'finding the optimal
>>  process to schedule' are two different things.
>=20
> I agree, and it seems that in current eevdf implementation the former =
relies on the latter.
>=20
>> 'check_preempt_wakeup_fair' is not just to
>>  check if the newly awakened process should preempt the current =
process; it can also serve
>>  as an opportunity to check whether any other processes should =
preempt the current one,
>>  thereby improving the real-time performance of the scheduler. =
Although now in pick_eevdf,
>>  the legitimacy of 'curr' is also evaluated, if the result returned =
is not the awakened process,
>>  then the current process will still not be preempted.
>=20
> I thought Mike has proposed a patch to deal with this scenario you =
mentioned above:
> =
https://lore.kernel.org/lkml/e17d3d90440997b970067fe9eaf088903c65f41d.came=
l@gmx.de/
>=20
> And I suppose you are refering to increase the preemption chance on =
current rather than reducing
> the invoke of pick_eevdf() in check_preempt_wakeup_fair().

Hi chen

Happy holidays. I believe the modifications here will indeed provide =
more opportunities for preemption,
thereby leading to lower scheduling latencies, while also truly reducing =
calls to pick_eevdf.  It's a win-win situation. :)

I conducted a test. It involved applying my modifications on top of MIKE =
PATCH, along with
adding some statistical counts following your previous method, in order =
to assess the potential
benefits of my changes.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..c5453866899f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8283,6 +8286,10 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
        struct sched_entity *se =3D &curr->se, *pse =3D &p->se;
        struct cfs_rq *cfs_rq =3D task_cfs_rq(curr);
        int cse_is_idle, pse_is_idle;
+       bool patch_preempt =3D false;
+       bool pick_preempt =3D false;
+
+       schedstat_inc(rq->check_preempt_count);

        if (unlikely(se =3D=3D pse))
                return;
@@ -8343,15 +8350,31 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
        cfs_rq =3D cfs_rq_of(se);
        update_curr(cfs_rq);

+       if ((sched_feat(RUN_TO_PARITY) && se->vlag !=3D se->deadline && =
!entity_eligible(cfs_rq, se))
+                       || (!sched_feat(RUN_TO_PARITY) && =
!entity_eligible(cfs_rq, se))) {
+               schedstat_inc(rq->patch_preempt_count);
+               patch_preempt =3D true;
+       }
+
        /*
         * XXX pick_eevdf(cfs_rq) !=3D se ?
         */
-       if (pick_eevdf(cfs_rq) =3D=3D pse)
+       if (pick_eevdf(cfs_rq) !=3D se) {
+               schedstat_inc(rq->pick_preempt_count);
+               pick_preempt =3D true;
                goto preempt;
+       }

        return;

 preempt:
+       if (patch_preempt && !pick_preempt)
+               schedstat_inc(rq->patch_preempt_only_count);
+       if (!patch_preempt && pick_preempt)
+               schedstat_inc(rq->pick_preempt_only_count);
+
+       schedstat_inc(rq->need_preempt_count);
+
        resched_curr(rq);
 }

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..002c6b0f966a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1141,6 +1141,12 @@ struct rq {
        /* try_to_wake_up() stats */
        unsigned int            ttwu_count;
        unsigned int            ttwu_local;
+       unsigned int            check_preempt_count;
+       unsigned int            need_preempt_count;
+       unsigned int            patch_preempt_count;
+       unsigned int            patch_preempt_only_count;
+       unsigned int            pick_preempt_count;
+       unsigned int            pick_preempt_only_count;
 #endif

 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..fe5487572409 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,21 @@ static int show_schedstat(struct seq_file *seq, =
void *v)

                /* runqueue-specific stats */
                seq_printf(seq,
-                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu *** %u %u * %u =
%u * %u %u",
                    cpu, rq->yld_count,
                    rq->sched_count, rq->sched_goidle,
                    rq->ttwu_count, rq->ttwu_local,
                    rq->rq_cpu_time,
-                   rq->rq_sched_info.run_delay, =
rq->rq_sched_info.pcount);
+                   rq->rq_sched_info.run_delay, =
rq->rq_sched_info.pcount,
+                   rq->check_preempt_count,
+                   rq->need_preempt_count,
+                   rq->patch_preempt_count,
+                   rq->patch_preempt_only_count,
+                   rq->pick_preempt_count,
+                   rq->pick_preempt_only_count);
+

                seq_printf(seq, "\n");

The test results are as follows:

  RUN_TO_PARITY:
                                   EEVDF        PATCH
 .stat.check_preempt_count         5053054      5029546
 .stat.need_preempt_count          0570520      1282780
 .stat.patch_preempt_count         -------      0038602
 .stat.patch_preempt_only_count    -------      0000000
 .stat.pick_preempt_count          -------      1282780
 .stat.pick_preempt_only_count     -------      1244178

  NO_RUN_TO_PARITY:
                                   EEVDF        PATCH
 .stat.check_preempt_count         5018589      5005812
 .stat.need_preempt_count          3380513      2994773
 .stat.patch_preempt_count         -------      0907927
 .stat.patch_preempt_only_count    -------      0000000
 .stat.pick_preempt_count          -------      2994773
 .stat.pick_preempt_only_count     -------      2086846

Looking at the results, adding an ineligible check for the se within =
check_preempt_wakeup_fair
can prevent 3% of pick_eevdf calls under the RUN_TO_PARITY feature, and =
in the case of
NO_RUN_TO_PARITY, it can prevent 30% of pick_eevdf calls. It was also =
discovered that the
patch_preempt_only_count is at 0, indicating that all invalid checks for =
the se are correct.

It's worth mentioning that under the RUN_TO_PARITY feature, the number =
of preemptions
triggered by 'pick_eevdf !=3D se' would be 2.25 times that of the =
original version, which could
lead to a series of other performance issues. However, logically =
speaking, this is indeed reasonable. :(


>=20
>> Therefore, I posted the v2 PATCH.=20
>>  The implementation of v2 PATCH might express this point more =
clearly.=20
>> =
https://lore.kernel.org/lkml/20240529141806.16029-1-spring.cxz@gmail.com/T=
/
>>=20
>=20
> Let me take a look at it and do some tests.

Thank you for doing this :)

>=20
>> I previously implemented and tested both of these methods, and the =
test results showed that
>> method 2 had somewhat more obvious benefits. Therefore, I submitted =
method 2. Now that I
>> think about it, perhaps method 1 could also be viable at the same =
time. :)
>>=20
>=20
> Actually I found that, even without any changes, if we enabled sched =
feature NEXT_BUDDY, the
> wakeup latency/request latency are both reduced. The following is the =
schbench result on a
> 240 CPUs system:
>=20
> NO_NEXT_BUDDY
> Wakeup Latencies percentiles (usec) runtime 100 (s) (1698990 total =
samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  50.0th: 6      =
    (429125 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 14     =
    (682355 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 99.0th: 29     =
    (126695 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  99.9th: 529    =
    (14603 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D1, =
max=3D4741
> Request Latencies percentiles (usec) runtime 100 (s) (1702523 total =
samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  50.0th: 14992  =
    (550939 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 15376  =
    (668687 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 99.0th: 15600  =
    (128111 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  99.9th: 15888  =
    (11238 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D3528, =
max=3D31677
> RPS percentiles (requests) runtime 100 (s) (101 total samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  20.0th: 16864  =
    (31 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 50.0th: 16928  =
    (26 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 17248  =
    (36 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D16615, =
max=3D20041
> average rps: 17025.23
>=20
> NEXT_BUDDY
> Wakeup Latencies percentiles (usec) runtime 100 (s) (1653564 total =
samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  50.0th: 5      =
    (376845 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 12     =
    (632075 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 99.0th: 24     =
    (114398 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  99.9th: 105    =
    (13737 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D1, =
max=3D7428
> Request Latencies percentiles (usec) runtime 100 (s) (1657268 total =
samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  50.0th: 14480  =
    (524763 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 15216  =
    (647982 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 99.0th: 15472  =
    (130730 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  99.9th: 15728  =
    (13980 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D3542, =
max=3D34805
> RPS percentiles (requests) runtime 100 (s) (101 total samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  20.0th: 16544  =
    (62 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82* 50.0th: 16544  =
    (0 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  90.0th: 16608  =
    (37 samples)
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82  min=3D16470, =
max=3D16648
> average rps: 16572.68
>=20
> So I think NEXT_BUDDY has more or less reduced the rb-tree scan.
>=20
> thanks,
> Chenyu

I'm not completely sure if my understanding is correct, but NEXT_BUDDY =
can only cache the process
that has been woken up; it doesn't necessarily correspond to the result =
returned by pick_eevdf.  Furthermore,
even if it does cache the result returned by pick_eevdf, by the time the =
next scheduling occurs, due to
other processes enqueing or dequeuing, it might not be the result picked =
by pick_eevdf at that moment.
Hence, it's a 'best effort' approach, and therefore, its impact on =
scheduling latency may vary depending
on the use case.

thanks
Chunxin


