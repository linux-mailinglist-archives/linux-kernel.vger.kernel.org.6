Return-Path: <linux-kernel+bounces-211356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBA90508C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5143B24027
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9016EBF8;
	Wed, 12 Jun 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Ge9XPr"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3436B17
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188779; cv=none; b=AI/I/VwTrg09PXBfqewm6KSVvWs9wT9VOEuXzOYbQuhrqUHHE33HNJYSFCDB0iVZesvqlcmdG9N6OVRilmlUPI6cXOl+01IyLT7NIxRvwToD2LUlqXZJKf4HXNsdZ/CfWuReOUANdfV8Eu5OwI3+0kse/UAedrFWtAm1pX4YuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188779; c=relaxed/simple;
	bh=Ca/IzAFsHmkM29ZmGIjZEgnJO1eNX4hnj+saNNVKGc0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uW3p48Xjl/Ue2ru9ZXn+JoRhA9PAUenvbyPmY86+464NKOPCFmhN8ymo30frMguaxax3Rjh2iVzQwJ/bXXtTDsz7/ewc2rfPvD9+K7X2WzzF5wWyGwPdzK0+VciwrRWF+Op6PVzdUDUiqXamMrdaIh+D9Kxjtdn+Yo5nNi+xoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6Ge9XPr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a08b1a81bso67825087b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718188777; x=1718793577; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5olz73DwyCbSfdzarSdgkcfRJ79KG8OMsUnKB9VoupA=;
        b=U6Ge9XPr2XjbHGvvmPRaLoLidtkCDftp2CLZzA8Tedc2xDWyB1rWyzIs56mNt0yOLo
         3pi2Inl4wCB82E4DfxwXUxHamEluAnao6hJ2JEd2I40Zcwj9jhSpJQlkoZdsqgKrPjyw
         hjqQ6hvM3fetF177Qzla9W/FtL8/MfCOyqBO2X1+SG9LI9Safk7/RVuxXK6WgOSsTTpq
         x0mFyRPPZVOWuzZU3dO8KnMFZFCWSRYxSWtzrn/Kq6gp7T4Bpbo5NOtrjfMrpTLYizAc
         7v9s4egKpqx7NJameN+xRl5NOSXP7wUVkAcuUV877z8DM71Cj0YQtmOC5TUiGBJexu84
         /rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718188777; x=1718793577;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5olz73DwyCbSfdzarSdgkcfRJ79KG8OMsUnKB9VoupA=;
        b=qkEMPywkke5nlmWRg1/nS4onrulw/JMCwbNuzg/0PetpheB1NKUQU5MKMLjT00CWCR
         qUd5Z40GFtPGJE+4pKpNSQwsUKh88yS2g89lkUR/cSY7lQ7QiuFaLC+nUsRsL1xHiM36
         dO0vSmjAxVD3d6Yb875bwv43QYcS31DojEb4VgQ/UJQodkrYoHQ/1sO9KOpBZeAcoJ20
         p1C8htMqBZQo0aNwgsBs/aMaEU4rZFu7g9bGi7L46OFbFe68OtVyY5QwE4qA6Ko7oIIz
         3p/vpsv9ZWxEGlqHqHGRmswiO7vXhEQD0YCZeZOQ2odBZGkSLbw1rTHkp/T+UDV62p0l
         LKqA==
X-Forwarded-Encrypted: i=1; AJvYcCV0PK0zr+XAc4L/j1/hBIDRKKnYRU+9T6MrdAhjWug3AKaCcdkDIpjbLlrKohDdapmkyHc4QbOczD39SSxo7TbJbwg8Uw2Kz8+ZCQ1z
X-Gm-Message-State: AOJu0YwHvtsJZp2ZH5fFkSsdLG1L3TEyB2kktM9cDdnEdVE46XDid7sE
	MVEBa22g2Shu/AN5DAF7gHXrOdge6/CC6ZwPpy6spdLWUymwj/mW
X-Google-Smtp-Source: AGHT+IHY/IWQWOez0qQtRNBcod4L6RQ6HaMN+Z080mkuf6hYLK8LLZHjd7D/7nRleqmOVbYRT5Ql+A==
X-Received: by 2002:a81:8707:0:b0:627:dc03:575a with SMTP id 00721157ae682-62fbc5dbde5mr12362797b3.49.1718188776720;
        Wed, 12 Jun 2024 03:39:36 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b07741241dsm35977026d6.135.2024.06.12.03.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 03:39:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
Date: Wed, 12 Jun 2024 18:39:11 +0800
Cc: mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 Honglei Wang <jameshongleiwang@126.com>,
 Mike Galbraith <efault@gmx.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com,
 Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>,
 Honglei Wang <jameshongleiwang@126.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 7, 2024, at 13:07, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
>> I found that some tasks have been running for a long enough time and
>> have become illegal, but they are still not releasing the CPU. This
>> will increase the scheduling delay of other processes. Therefore, I
>> tried checking the current process in wakeup_preempt and entity_tick,
>> and if it is illegal, reschedule that cfs queue.
>>=20
>> When RUN_TO_PARITY is enabled, its behavior essentially remains
>> consistent with the original process. When NO_RUN_TO_PARITY is =
enabled,
>> some additional preemptions will be introduced, but not too many.
>>=20
>> I have pasted some test results below.
>> I isolated four cores for testing and ran hackbench in the =
background,
>> and observed the test results of cyclictest.
>>=20
>> hackbench -g 4 -l 100000000 &
>> cyclictest --mlockall -D 5m -q
>>=20
>>                                 EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY
>>=20
>>                # Min Latencies: 00006      00006      00006      =
00006
>>  LNICE(-19)    # Avg Latencies: 00191      00133      00089      =
00066
>>                # Max Latencies: 15442      08466      14133      =
07713
>>=20
>>                # Min Latencies: 00006      00010      00006      =
00006
>>  LNICE(0)      # Avg Latencies: 00466      00326      00289      =
00257
>>                # Max Latencies: 38917      13945      32665      =
17710
>>=20
>>                # Min Latencies: 00019      00053      00010      =
00013
>>  LNICE(19)     # Avg Latencies: 37151      25852      18293      =
23035
>>                # Max Latencies: 2688299    4643635    426196     =
425708
>>=20
>> I captured and compared the number of preempt occurrences in =
wakeup_preempt
>> to see if it introduced any additional overhead.
>>=20
>> Similarly, hackbench is used to stress the utilization of four cores =
to
>> 100%, and the method for capturing the number of PREEMPT occurrences =
is
>> referenced from [1].
>>=20
>> schedstats                          EEVDF       PATCH   =
EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
>> .stats.check_preempt_count          5053054     5045388    5018589    =
5029585
>> .stats.patch_preempt_count          -------     0020495    -------    =
0700670    -------
>> .stats.need_preempt_count           0570520     0458947    3380513    =
3116966    1140821
>>=20
>> =46rom the above test results, there is a slight increase in the =
number of
>> preempt occurrences in wakeup_preempt. However, the results vary with =
each
>> test, and sometimes the difference is not that significant.
>>=20
>> [1]: =
https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kick=
s-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
>>=20
>> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>>=20
>> ------
>> Changes in v2:
>> - Make the logic that determines the current process as ineligible =
and
>>  triggers preemption effective only when NO_RUN_TO_PARITY is enabled.
>> - Update the commit message
>> ---
>> kernel/sched/fair.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 03be0d1330a6..fa2c512139e5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -745,6 +745,17 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>> return vruntime_eligible(cfs_rq, se->vruntime);
>> }
>>=20
>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>> +{
>> + if (sched_feat(RUN_TO_PARITY) && se->vlag !=3D se->deadline)
>> + return true;
>=20
> If I understand correctly, here it intends to check if the current se
> has consumed its 1st slice after been picked at set_next_entity(), and =
if yes do a reschedule.
> check_entity_need_preempt() is added at the end of entity_tick(), =
which could overwrite
> the police to reschedule current: =
(entity_tick()->update_curr()->update_deadline()), only there
> are more than 1 runnable tasks will the current be preempted, even if =
it has expired the 1st
> requested slice.
>=20

The purpose of the modification is to increase preemption opportunities =
without breaking the
RUN_TO_PARITY rule. However, it clearly introduces some additional =
preemptions, or perhaps
there should be a check for the eligibility of the se. Also, to avoid =
overwriting the scheduling
strategy in entity_tick, would a modification like the following be more =
appropriate?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..5e49a15bbdd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
        return vruntime_eligible(cfs_rq, se->vruntime);
 }

+static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
+{
+       if (cfs_rq->nr_running <=3D 1)
+               return false;
+
+       if (sched_feat(RUN_TO_PARITY) && se->vlag !=3D se->deadline
+                                     && !entity_eligible(cfs_rq, se))
+               return true;
+
+       if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, se))
+               return true;
+
+       return false;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
        u64 min_vruntime =3D cfs_rq->min_vruntime;
@@ -974,11 +989,13 @@ static void clear_buddies(struct cfs_rq *cfs_rq, =
struct sched_entity *se);
 /*
  * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
+ *
+ * return true if se need preempt
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity =
*se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity =
*se)
 {
        if ((s64)(se->vruntime - se->deadline) < 0)
-               return;
+               return false;

        /*
         * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -995,10 +1012,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
        /*
         * The task has consumed its request, reschedule.
         */
-       if (cfs_rq->nr_running > 1) {
-               resched_curr(rq_of(cfs_rq));
-               clear_buddies(cfs_rq, se);
-       }
+       return true;
 }

 #include "pelt.h"
@@ -1157,6 +1171,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 {
        struct sched_entity *curr =3D cfs_rq->curr;
        s64 delta_exec;
+       bool need_preempt =3D false;

        if (unlikely(!curr))
                return;
@@ -1166,12 +1181,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
                return;

        curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
-       update_deadline(cfs_rq, curr);
+       need_preempt =3D update_deadline(cfs_rq, curr);
        update_min_vruntime(cfs_rq);

        if (entity_is_task(curr))
                update_curr_task(task_of(curr), delta_exec);

+       if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
+               resched_curr(rq_of(cfs_rq));
+               clear_buddies(cfs_rq, curr);
+       }
+
        account_cfs_rq_runtime(cfs_rq, delta_exec);
 }



>> +
>> + if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, se))
>> + return true;
>> +
>> + return false;
>> +}
>> +
>> static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>> {
>> u64 min_vruntime =3D cfs_rq->min_vruntime;
>> @@ -5523,6 +5534,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>> hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>> return;
>> #endif
>> +
>> + if (check_entity_need_preempt(cfs_rq, curr))
>> + resched_curr(rq_of(cfs_rq));
>> }
>>=20
>>=20
>> @@ -8343,6 +8357,9 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
>> cfs_rq =3D cfs_rq_of(se);
>> update_curr(cfs_rq);
>>=20
>> + if (check_entity_need_preempt(cfs_rq, se))
>> + goto preempt;
>> +
>=20
> As we changes the preemption policy for current in two places, the =
tick preemption and wakeup preemption,
> do you have statistics that shows which one brings the most benefit?

This modification no longer involves both wakeup and tick but is =
consolidated in 'update_curr', and it completes
the preemption decision along with 'update_deadline'. This approach =
seems more elegant and achieves the
same performance benefits as before.

thanks=20
Chunxin

>=20
> thanks,
> Chenyu


