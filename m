Return-Path: <linux-kernel+bounces-204285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745E68FE6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6801F27C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2970195B0A;
	Thu,  6 Jun 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJYMlWJ0"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9C13F014
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677608; cv=none; b=UcVMd6Weg1mCTEe/Yj+RUE+FRL/OTEddm1M5DPC1bzsozHuhp5etdNc0zS/kgXIQxvYYzVNIXL6mKE2CvjXUkKkciEN+XKCRxKyVNDNxhmFViI52AEohzDPwPeIi0u5aBgwHNO7BNbAxKRGn9nVHEbhyp25lj+TO+EvOTcagdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677608; c=relaxed/simple;
	bh=2hmuyNqQTvaA5z2wwn4yQo3Vjk9z0/qD/1y7aL3KO4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hb6qn0KMpAyDOdP78Zh7bkAHT4YbrKMXKZEEKmcZ3KaQtKk5u5ySGGcJwWdQQvCbMOG2jnuA1tTKfXa69ae0ilxysuI61oPfVsiI/ekMSrk6vdRADCovZG/JaC8OPvdJBpHsUpBLQ0vTIty0+kjNTqX2Ktbg1aWlAlUPw9ACXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJYMlWJ0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6afc61f9a2eso7022726d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717677606; x=1718282406; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuUr0xdmiuXB9sYL3V50E0XBlpUTxzxBdUup1Y2+RDI=;
        b=WJYMlWJ0a4Hr5tSHe5UrScT/j3PwIKn/4x4+zw9VGSUBITUzVLPuont45kPA5ctJQz
         qHg6pASeJMDLiVftxdlb1RCBWTPWylv/FVROiHf9H/W6EWXAZbwiUzIn4mpSpDIJAiMw
         HBZiMHWJTOINQv1It4CAg1WS/NPCs0syo03kz32UydFJqM/T9iPqyf0My/xLp6ygebf1
         dlDcvk6GGSlGFpT7E45ZmPLvDyDOy6/sDld8RaKJeFm/NwA8C6PMJPbjMwgkUdqwlKb+
         ykv4kzKHOXBihDksJiBeWif95hmhfvoXNVyD608G/VL/CYyLj3xqwly2Gw4mavI0I6h9
         u3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677606; x=1718282406;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuUr0xdmiuXB9sYL3V50E0XBlpUTxzxBdUup1Y2+RDI=;
        b=Svn3GcooWvcKFGGWTmEySW3YgslHpIC5wN40adL+y3xFCS78UrP0MtCVKtM/cfqF4H
         n9CX1jxZVFsQTaNugq1h2DpKwWkNNkgi7NofzlAMfCrxZcIJDN5rSFzje4y7d60xomoK
         /g8Ziq2JJTHefBU97yObeWZYbLP4MK47uwmJfmNLOQ1lGWrMdB75F7j+xYjAKu9bGqfn
         WjxFCuEzogaCyePQmTaqdAKtNxDqIMLI+UyXYFtR2h4dweGsYtSMb52b7/fRYx+2WMCO
         tAqSqPQFyBnLMRqcit+aLZMaDG1OuXYmrM2hI18nclx3ZWoiUbEjcnUxZD4J18aw2UA2
         SliA==
X-Forwarded-Encrypted: i=1; AJvYcCW9zyFJcEfGEbjvYdX71ZnlZIWTdYqEN4SpSUro31aHpYdpXUThRg4jAK0yEboWkpkTgYgHeQfC2034BYYZtYb+HOtd2teIlRTcwWU5
X-Gm-Message-State: AOJu0YyeTNgYgjWf+pBMgjKx5N6Jrp3ovKRpFcKUOUQ+VnyLb2ON31Pk
	Qiniovoq7gCCA+iNfOx3dtFWspQm2p0+dLb8XLb1n0fN9utDozXq
X-Google-Smtp-Source: AGHT+IES+FMJjr9muBMUefRvn7PGclBxSG1bMxV60L4GSkvNKmMX4kS3eOt112c/VzYFf2D7NP3Kjw==
X-Received: by 2002:a05:6214:598b:b0:6b0:5755:7dcf with SMTP id 6a1803df08f44-6b057557eaamr1976836d6.10.1717677605695;
        Thu, 06 Jun 2024 05:40:05 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9fb10csm5743626d6.120.2024.06.06.05.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2024 05:40:05 -0700 (PDT)
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
In-Reply-To: <bb43844e-0ef2-44d6-9d98-496865d942b9@126.com>
Date: Thu, 6 Jun 2024 20:39:44 +0800
Cc: dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 Chen Yu <yu.c.chen@intel.com>,
 yangchen11@lixiang.com,
 Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>,
 mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD2A2CD1-E7F9-4519-82F5-22E769364C55@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <572bef0a-727c-4922-93e9-ad29c385120e@126.com>
 <6AF97701-B8F4-46C6-851E-A8BACE97E8C0@gmail.com>
 <bb43844e-0ef2-44d6-9d98-496865d942b9@126.com>
To: Honglei Wang <jameshongleiwang@126.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 3, 2024, at 10:55, Honglei Wang <jameshongleiwang@126.com> =
wrote:
>=20
>=20
>=20
> On 2024/5/29 22:31, Chunxin Zang wrote:
>>> On May 25, 2024, at 19:48, Honglei Wang <jameshongleiwang@126.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>> On 2024/5/24 21:40, Chunxin Zang wrote:
>>>> I found that some tasks have been running for a long enough time =
and
>>>> have become illegal, but they are still not releasing the CPU. This
>>>> will increase the scheduling delay of other processes. Therefore, I
>>>> tried checking the current process in wakeup_preempt and =
entity_tick,
>>>> and if it is illegal, reschedule that cfs queue.
>>>> The modification can reduce the scheduling delay by about 30% when
>>>> RUN_TO_PARITY is enabled.
>>>> So far, it has been running well in my test environment, and I have
>>>> pasted some test results below.
>>>> I isolated four cores for testing. I ran Hackbench in the =
background
>>>> and observed the test results of cyclictest.
>>>> hackbench -g 4 -l 100000000 &
>>>> cyclictest --mlockall -D 5m -q
>>>>                                  EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY
>>>>                 # Min Latencies: 00006      00006      00006      =
00006
>>>>   LNICE(-19)    # Avg Latencies: 00191      00122      00089      =
00066
>>>>                 # Max Latencies: 15442      07648      14133      =
07713
>>>>                 # Min Latencies: 00006      00010      00006      =
00006
>>>>   LNICE(0)      # Avg Latencies: 00466      00277      00289      =
00257
>>>>                 # Max Latencies: 38917      32391      32665      =
17710
>>>>                 # Min Latencies: 00019      00053      00010      =
00013
>>>>   LNICE(19)     # Avg Latencies: 37151      31045      18293      =
23035
>>>>                 # Max Latencies: 2688299    7031295    426196     =
425708
>>>> I'm actually a bit hesitant about placing this modification under =
the
>>>> NO_PARITY feature. This is because the modification conflicts with =
the
>>>> semantics of RUN_TO_PARITY. So, I captured and compared the number =
of
>>>> resched occurrences in wakeup_preempt to see if it introduced any
>>>> additional overhead.
>>>> Similarly, hackbench is used to stress the utilization of four =
cores to
>>>> 100%, and the method for capturing the number of PREEMPT =
occurrences is
>>>> referenced from [1].
>>>> schedstats                          EEVDF       PATCH   =
EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
>>>> stats.check_preempt_count          5053054     5057286    5003806   =
 5018589    5031908
>>>> stats.patch_cause_preempt_count    -------     858044     -------   =
 765726     -------
>>>> stats.need_preempt_count           570520      858684     3380513   =
 3426977    1140821
>>>> =46rom the above test results, there is a slight increase in the =
number of
>>>> resched occurrences in wakeup_preempt. However, the results vary =
with each
>>>> test, and sometimes the difference is not that significant. But =
overall,
>>>> the count of reschedules remains lower than that of CFS and is much =
less
>>>> than that of NO_PARITY.
>>>> [1]: =
https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kick=
s-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
>>>> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
>>>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>>>> ---
>>>>  kernel/sched/fair.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..a0005d240db5 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>>>>   hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>>>   return;
>>>>  #endif
>>>> +
>>>> + if (!entity_eligible(cfs_rq, curr))
>>>> + resched_curr(rq_of(cfs_rq));
>>>>  }
>>>>    @@ -8325,6 +8328,9 @@ static void =
check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>>>   if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>>>>   return;
>>>>  + if (!entity_eligible(cfs_rq, se))
>>>> + goto preempt;
>>>> +
>>>>   find_matching_se(&se, &pse);
>>>>   WARN_ON_ONCE(!pse);
>>>> =20
>>> Hi Chunxin,
>>>=20
>>> Did you run a comparative test to see which modification is more =
helpful on improve the latency? Modification at tick point makes more =
sense to me. But, seems just resched arbitrarily in wakeup might =
introduce too much preemption (and maybe more context switch?) in =
complex environment such as cgroup hierarchy.
>>>=20
>>> Thanks,
>>> Honglei
>> Hi Honglei
>> I attempted to build a slightly more complex scenario. It consists of =
4 isolated cores,
>> 4 groups of hackbench (160 processes in total) to stress the CPU, and =
1 cyclictest
>> process to test scheduling latency. Using cgroup v2, to created 64 =
cgroup leaf nodes
>> in a binary tree structure (with a depth of 7). I then evenly =
distributed the aforementioned
>> 161 processes across the 64 cgroups respectively, and observed the =
scheduling delay
>> performance of cyclictest.
>> Unfortunately, the test results were very fluctuating, and the two =
sets of data were very
>> close to each other. I suspect that it might be due to too few =
processes being distributed
>> in each cgroup, which led to the logic for determining ineligible =
always succeeding and
>> following the original logic. Later, I will attempt more tests to =
verify the impact of these
>> modifications in scenarios involving multiple cgroups.
>=20
> Sorry to lately replay, I was a bit busy last week. How's the test =
going on? What about run some workload processes who spend more time in =
kernel? Maybe it's worth do give a try, but it depends on your test =
plan.
>=20

Hi honglei

Recently, I conducted testing of multiple cgroups using version 2. =
Version 2 ensures the
RUN_TO_PARITY feature, so the test results are somewhat better under the
NO_RUN_TO_PARITY feature.
=
https://lore.kernel.org/lkml/20240529141806.16029-1-spring.cxz@gmail.com/T=
/

The testing environment I used still employed 4 cores,  4 groups of =
hackbench (160 processes)
and 1 cyclictest. If too many cgroups or processes are created on the 4 =
cores, the test
results will fluctuate severely, making it difficult to discern any =
differences.

The organization of cgroups was in two forms:=20
1. Within the same level cgroup, 10 sub-cgroups were created, with each =
cgroup having
  an average of 16 processes.=20

                                  EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY

   LNICE(-19)    # Avg Latencies: 00572      00347      00502      00218

   LNICE(0)      # Avg Latencies: 02262      02225      02442      02321

   LNICE(19)     # Avg Latencies: 03132      03422      03333      03489

2. In the form of a binary tree, 8 leaf cgroups were established, with a =
depth of 4.=20
  On average, each cgroup had 20 processes

                                  EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY

   LNICE(-19)    # Avg Latencies: 00601      00592      00510      00400

   LNICE(0)      # Avg Latencies: 02703      02170      02381      02126

   LNICE(19)     # Avg Latencies: 04773      03387      04478      03611

Based on the test results, there is a noticeable improvement in =
scheduling latency after
applying the patch in scenarios involving multiple cgroups.


thanks=20
Chunxin

> Thanks,
> Honglei
>=20
>> thanks
>> Chunxin



