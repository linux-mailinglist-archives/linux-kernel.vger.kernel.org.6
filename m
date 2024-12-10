Return-Path: <linux-kernel+bounces-439169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530939EABD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF6428AC12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C323279C;
	Tue, 10 Dec 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGyyob1h"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB419924F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822580; cv=none; b=LCQOFYMQWKFmd+c7eD3iNHyyPZqAx1fVGkxwF54uIjnGTJl/e5cfv8B2d7hpLzaIjaf+MwuPZ6RvwjG62NLP8iuJAsFNhocO3BmZjwrW6VGn6+HSc6EOx1nbAtlr/rYkSc88tnKX79ZcxBhQYoK9V5sGqluxW7wK1T2WlnlywtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822580; c=relaxed/simple;
	bh=oqYvUPyzOiv39dL27Heb1n/UlEMMz+A/Skeg/UF3fDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYpEqPULhYx+nirhstc3gjxMe9vPG0JOSshGJ80hNs3gCtksoi3mfP3DwcAPw74qo0CGCvl0pmOLbIEcGkNdsYnAZAda/WeI1VTpxeYBb2epsJqPLKJrkK87hiXAtp6syDTo/Sp/oajGsnwokzF6NibQt7CIDVhZ3dLNAV1lIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGyyob1h; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so549109a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822578; x=1734427378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m4XN5YD/esnhUESrYFDWpIBpwu3AmP2NdsqTlp2vSw=;
        b=YGyyob1hCgRo5GFY/mSYa97t3U9OHUpRmJxDeczVgw3e9Q0TFWvjP0zKNkELlynuND
         KwGHZKDISzhyEamYljNIxrYopmxUxUzkqSUEES9Y7pl8oSV3uglABWwZuqB4A+lezAvN
         pGghsVnBmqslaAn5qAAwRyPimpwTEAKNtcF9cG7NSia/E+qVNXhbAl85i3i5CiH/Dbem
         yRcGr0/uxh1mGRyV9O478BJUitFBFNY5hhD1bDwDubeI8sDfEnnn8s+V4XU/PnrUXFjP
         oJn1eHU03Ya3HioBXX8qhc2CjXRkPVy026wPyA1NLya/JQk2xZG3vmOb0ssxDO/UvaU8
         Xqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822578; x=1734427378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m4XN5YD/esnhUESrYFDWpIBpwu3AmP2NdsqTlp2vSw=;
        b=AO+QkQ7Fu6eTB/wvREbSOKOkjRTpFdORwC4N/SH1VxnPklNEgqkA286+S3dwz51GMF
         rw5q4Fyz38mh3GeigqbZS0R06p6NoNpM7Lf+2Gv2gI3I3Io69QuFh8zQUV54gx/l8hP+
         5B+7UFHpU0dCrAKYNzuAp5/VEPruwp4M6dFMDHUrJr3d9BIEtVJjNQfATRS1SSTUTBal
         eOEMgXYh1wZxsk2LmYk920QLY4H45AOEOiSe4JrB9ndpcAnESciYZi4MjWuf+qGcr8ZC
         cC8oA6+TCQzfsYMObrgUnZTB6q6QyJKIYxhbTl06DiXNS32f4ROpADG0/oQcGQWQzsdp
         2DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtXOCdomAT3ygjsCnW1usGbGgO/wryELozlS3AMlXl62RxXfbpAPnxSMOpoTIXd440X4kCjUOp9bus5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYz2pW+Qwo2Kntoddyj0Di1rKU8JaqUWIR2rqnBD+7NqiOiAAi
	MWAtvi1XNzcBSbFMkvmt5D9GULmnVF20vOTXQ8y9zFS6ZeV7eDZJTfv832Ypss58/D+ArOLVOXc
	LDG+oy1Gaja4sttziJ1chJQjOEtk=
X-Gm-Gg: ASbGncte440iQBIbpYZYX5rDk9IeyxP/aqJdGVw+OeuOGstGFwfAO14SUUC9dr93eZ3
	SC2upG4Q3noyFYcRXgtIW3Xb38l4awL06/MfS
X-Google-Smtp-Source: AGHT+IFFbv80EL4XFCbYAHhq1w7V1JVq2WEYK9L8i6TdHZ0gT8hn/3D4wY6rnn00Occ2IMF2C0nHoY33btbOXh19c4s=
X-Received: by 2002:a17:90a:d88e:b0:2ea:61de:38f7 with SMTP id
 98e67ed59e1d1-2ef6ab0cf78mr22173714a91.29.1733822578117; Tue, 10 Dec 2024
 01:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126103513.GK38837@noisy.programming.kicks-ass.net>
 <20241127070534.62903-1-zhouzihan30@jd.com> <CAHb70uysf8qOTwGCm0-rfR1KxxK9K6bhEwRX4O0QaeqyzM6ODw@mail.gmail.com>
In-Reply-To: <CAHb70uysf8qOTwGCm0-rfR1KxxK9K6bhEwRX4O0QaeqyzM6ODw@mail.gmail.com>
From: zihan zhou <15645113830zzh@gmail.com>
Date: Tue, 10 Dec 2024 17:22:46 +0800
Message-ID: <CAHb70uz8SZ49MSxyXvZfd-5AF7Y9KuUYbcKaZ_mbXD2zgu_0Yw@mail.gmail.com>
Subject: Re: [PATCH] sched: Forward deadline for early tick
To: peterz@infradead.org
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	rostedt@goodmis.org, vincent.guittot@linaro.org, vschneid@redhat.com, 
	yaozhenguo@jd.com, zhouzihan30@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, may I ask what you think of my latest patch
(https://lore.kernel.org/all/20241127070534.62903-1-zhouzihan30@jd.com/)?
 If there are any shortcomings here, I would be happy to continue
making revisions.
(I'm sorry, there seems to be a formatting issue with the email I
sent, so I sent it again)

zihan zhou <15645113830zzh@gmail.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello, may I ask what you think of my latest patch (https://lore.kernel.o=
rg/all/20241127070534.62903-1-zhouzihan30@jd.com/)?  If there are any short=
comings here, I would be happy to continue making revisions.
>
> zhouzihan30 <15645113830zzh@gmail.com> =E4=BA=8E2024=E5=B9=B411=E6=9C=882=
7=E6=97=A5=E5=91=A8=E4=B8=89 15:06=E5=86=99=E9=81=93=EF=BC=9A
>>
>> From: zhouzihan <zhouzihan30@jd.com>
>>
>> Thank you very much for your reply, which has brought me lots
>>  of thoughts.
>>
>> I have reconsidered this issue and believe that the root cause is that
>>  the kernel is difficult and unnecessary to implement an ideal eevdf
>>  due to real hardware:
>> for example,
>> an ideal eevdf may bring frequent switching, its cost makes kernel can't
>>  really do it.
>>
>> So I see that the kernel has a very concise and clever implementation:
>>  update_deadline, which allows each task to use up the request size
>>  as much as possible in one go.
>>
>> Here, the kernel has actually slightly violated eevdf: we are no longer
>>  concerned about whether a task is eligible for the time being.
>>
>> In the prev patch, it was mentioned that due to tick errors, some tasks
>>  run longer than requested. So if we can do this: when a task vruntime
>>  approaches the deadline, we check if the task is eligible.
>> If it is eligible, we follow the previous logic and do not schedule it.
>> However, if it is ineligible, we schedule it because eevdf has the
>>  responsibility to not exec ineligible task.
>>
>> In other words, the kernel has given the task a "benefit" based on the
>>  actual situation, and we still have the right to revoke this benefit.
>>
>> In this way, it actually brings the kernel closer to an ideal eevdf,
>> and at the same time, your reply made me realize my mistake:
>> The deadline update should be updated using the following function,
>> which is more reasonable:
>>     vd_i +=3D r_i / w_i
>> By using it, our scheduler is still fair,
>>  and each task can obtain its own time according to its weight.
>>
>> About tolerance, I think min(vslice/128, tick/2) is better,
>> as your reply, vslice maybe too big, so use it.
>>
>> However, there is still a new issue here:
>> If a se 1 terminates its deadline prematurely due to ineligible,
>> and then a se 2 runs, after the end of the run,
>> se 1 becomes eligible, but its deadline has already been pushed back,
>> which is not earliest eligible,
>> so se 1 can't run. This seems to not comply with eevdf specifications.
>>
>> But I think this is acceptable. In the past, the logic causes a task to
>>  run an extra tick (ms), which means other tasks have to wait for an
>>  extra tick. Now, a task maybe run less time (us), but it will be
>>  compensated for in the next scheduling. In terms of overall accuracy,
>>  I think it has improved.
>>
>> By the way, we may try to solve this by delaying the deadline update,
>> which means we schedule a task but not update its deadline,
>> util next exec it.
>> I am not sure if it is necessary to implement such complex logic here.
>> I think it is actually unnecessary,
>> because the ideal eevdf may not be suitable for the kernel.
>> It is no need to spend so much to solve the error of few time.
>> If there is a truly completely accurate system, it should not have
>>  tick error, and just closes the FORWARD_DEADLINE feature.
>> Of course, if you think it is necessary, I am willing try to implement i=
t.
>>
>> Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
>> ---
>>  kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++----
>>  kernel/sched/features.h |  7 +++++++
>>  2 files changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2d16c8545c71..e6e58c7d6d4c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1006,8 +1006,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, =
struct sched_entity *se);
>>   */
>>  static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity =
*se)
>>  {
>> -       if ((s64)(se->vruntime - se->deadline) < 0)
>> -               return false;
>> +
>> +       u64 vslice;
>> +       u64 tolerance =3D 0;
>> +       u64 next_deadline;
>>
>>         /*
>>          * For EEVDF the virtual time slope is determined by w_i (iow.
>> @@ -1016,11 +1018,42 @@ static bool update_deadline(struct cfs_rq *cfs_r=
q, struct sched_entity *se)
>>          */
>>         if (!se->custom_slice)
>>                 se->slice =3D sysctl_sched_base_slice;
>> +       vslice =3D calc_delta_fair(se->slice, se);
>> +
>> +       next_deadline =3D se->vruntime + vslice;
>> +
>> +       if (sched_feat(FORWARD_DEADLINE))
>> +               tolerance =3D min(vslice>>7, TICK_NSEC/2);
>> +
>> +       if ((s64)(se->vruntime + tolerance - se->deadline) < 0)
>> +               return false;
>>
>>         /*
>> -        * EEVDF: vd_i =3D ve_i + r_i / w_i
>> +        * when se->vruntime + tolerance - se->deadline >=3D 0
>> +        * but se->vruntime - se->deadline < 0,
>> +        * there is two case: if entity is eligible?
>> +        * if entity is not eligible, we don't need wait deadline, becau=
se
>> +        * eevdf don't guarantee
>> +        * an ineligible entity can exec its request time in one go.
>> +        * but when entity eligible, just let it run, which is the
>> +        * same processing logic as before.
>>          */
>> -       se->deadline =3D se->vruntime + calc_delta_fair(se->slice, se);
>> +
>> +       if (sched_feat(FORWARD_DEADLINE) && (s64)(se->vruntime - se->dea=
dline) < 0) {
>> +               if (entity_eligible(cfs_rq, se)) {
>> +                       return false;
>> +               } else {
>> +                       /*
>> +                        * in this case, entity's request size does not =
use light=EF=BC=8C
>> +                        * but considering it is not eligible, we don't =
need exec it.
>> +                        * and we let vd_i +=3D r_i / w_i, make schedule=
r fairness.
>> +                        */
>> +                       next_deadline =3D se->deadline + vslice;
>> +               }
>> +       }
>> +
>> +
>> +       se->deadline =3D next_deadline;
>>
>>         /*
>>          * The task has consumed its request, reschedule.
>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> index 290874079f60..5c74deec7209 100644
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -24,6 +24,13 @@ SCHED_FEAT(RUN_TO_PARITY, true)
>>   */
>>  SCHED_FEAT(PREEMPT_SHORT, true)
>>
>> +/*
>> + * For some cases where the tick is faster than expected,
>> + * move the deadline forward
>> + */
>> +SCHED_FEAT(FORWARD_DEADLINE, true)
>> +
>> +
>>  /*
>>   * Prefer to schedule the task we woke last (assuming it failed
>>   * wakeup-preemption), since its likely going to consume data we
>> --
>> 2.39.3 (Apple Git-146)
>>

