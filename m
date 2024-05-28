Return-Path: <linux-kernel+bounces-191818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7E8D1498
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A72283922
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980626A33B;
	Tue, 28 May 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALFsbEHt"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB561FF6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878514; cv=none; b=Oqac1t0X27tgZW2rh+fKi+ObTCvj/mnhFucTslpACdeCt9MIfYWqjaBlLzBdSdLLF+RcsWo5mw6mRIjcidNX8LIpb06E9g05Qu0Zco3ZZ2uvnTptdHKCHPT+Adl7MjeIpgqAZdkM2RYMNaZB7BvsWkm0QEhB7gDjmY+CyVRnZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878514; c=relaxed/simple;
	bh=82HAfOyvKSoJTle9HI1BkdJU0HPg2ryPihpkE6FIgKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MYR3U1Tgxmtq7GLJYOf4ggwo0Do8iBu8kmp4awimISEiL/bEPMasXF901cNMz/w+bpipAtbrqO38cp1V3pI9IIP0zhZwE/0n2jhc0eJ9+u64KKrYo8hwQhQ7TcUK4HYfMLA7I8sFxAFxH/ziOE8Kgy/gMLHt75jBXovcCN/Fwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALFsbEHt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e3ba01083so2542201cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716878512; x=1717483312; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZWqewD2P1bCIUUISdcl3vIbMvnwxU4jgvPJjfgoMEU=;
        b=ALFsbEHtEvno+LYqAww6fNH//4Ky/W5EfnED3jXuGy/9+FFLMh63IYz6KQaetr91hJ
         ol/IaS1IoTw/l76TcJkpe6ALkJvOibDXaTP/D1ETArXvSLF/lkUhrGMN0/sffQ3i00rT
         gD/fum3oCuuPMAvbkMYgCvNuOopIYGWWKWl/xk4UL7GxhDeqg+/EZi9CouooPihTfMTW
         BEAaSPL/FuJwWYQgkkcLN+KuCqmL8rM73xB+ieNT+Vt1ImdhiDQk6LyQOOUhWL9MBd8I
         km+5WXoGjUKiZecQuKsF7OceIbBgibspMP0b3shjLTO4j3CxhurOTD/SHm7bUQYKDm9e
         gS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716878512; x=1717483312;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZWqewD2P1bCIUUISdcl3vIbMvnwxU4jgvPJjfgoMEU=;
        b=v3uSizGzyn5g47R+71e+iFuD3nbmN170UG57/RRMTXttHgO3AdCS2vSZZAZQt+kDrL
         iEm7wMh2h5VOmJ+5E3EAxextncE1MO3O3oUlosPCsK6JUA8aaZHfDc2ina43xhTnIgD6
         igiYmgBr/b/M4H+SWCeBWJfiMJOvPHlU7dG+RfpYkPsMEW4k8fU9/jTekBonjxc2UoYK
         ooJufhYjF6KgJ9+zo+Zk66Ndu//ePAA663+G1x2nWXuZ15hienFA5nYquPfADsh6QmN3
         brNA9OBpWG9Hgym228SqIR5I4k38UwISgdCXJmsr04bxFPZUcfuck4mRhEnHzmONwH3y
         84FA==
X-Forwarded-Encrypted: i=1; AJvYcCVnOE+nkh4WPp10LeI+pkna5j4K3vrbwOzgGdC9zlmmxkbngGJ5edsvB23OKNiYY0VkHfpRK4Jp1Gj1bmlUn52dvxerEMUVARQAqsYf
X-Gm-Message-State: AOJu0YzDcQVFOuxq6PBjP/PFA7YRQau6O4c5xaE/w+vBNiNDU7lTjoZK
	sul4Ljsn8Yyli1LOVz8P1QzQNZxBoYWDZTckKC/FXPr/u77y7VXV
X-Google-Smtp-Source: AGHT+IH/K/aB5kM6SeQm3i4+PpUgsTXL17dWiaLyKiFcKW7Y7tFC4n2rVybUm4lLbLr1ZXghG9ax+g==
X-Received: by 2002:a05:622a:1923:b0:43a:ecf9:c1c7 with SMTP id d75a77b69052e-43fb0e70accmr115275771cf.51.1716878511923;
        Mon, 27 May 2024 23:41:51 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b7a06sm40270001cf.8.2024.05.27.23.41.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 23:41:51 -0700 (PDT)
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
In-Reply-To: <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
Date: Tue, 28 May 2024 14:41:34 +0800
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
 linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com,
 Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>,
 kprateek.nayak@amd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A381B712-B0A2-4218-AAD4-956FB73D88CE@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On May 28, 2024, at 10:42, Chunxin Zang <spring.cxz@gmail.com> wrote:
>=20
>>=20
>> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
>>=20
>> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
>>> I found that some tasks have been running for a long enough time and
>>> have become illegal, but they are still not releasing the CPU. This
>>> will increase the scheduling delay of other processes. Therefore, I
>>> tried checking the current process in wakeup_preempt and =
entity_tick,
>>> and if it is illegal, reschedule that cfs queue.
>>>=20
>>> The modification can reduce the scheduling delay by about 30% when
>>> RUN_TO_PARITY is enabled.
>>> So far, it has been running well in my test environment, and I have
>>> pasted some test results below.
>>>=20
>>=20
>> Interesting, besides hackbench, I assume that you have workload in
>> real production environment that is sensitive to wakeup latency?
>=20
> Hi Chen
>=20
> Yes, my workload  are quite sensitive to wakeup latency .
>>=20
>>>=20
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..a0005d240db5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>>> hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>> return;
>>> #endif
>>> +
>>> + if (!entity_eligible(cfs_rq, curr))
>>> + resched_curr(rq_of(cfs_rq));
>>> }
>>>=20
>>=20
>> entity_tick() -> update_curr() -> update_deadline():
>> se->vruntime >=3D se->deadline ? resched_curr()
>> only current has expired its slice will it be scheduled out.
>>=20
>> So here you want to schedule current out if its lag becomes 0.
>>=20
>> In lastest sched/eevdf branch, it is controlled by two sched =
features:
>> RESPECT_SLICE: Inhibit preemption until the current task has =
exhausted it's slice.
>> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until =
0-lag.
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dsched/eevdf&id=3De04f5454d68590a239092a700e9bbaf84270397c
>>=20
>> Maybe something like this can achieve your goal
>> if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
>> resched_curr
>>=20
>>>=20
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
>> Not sure if this is applicable, later in this function, pick_eevdf() =
checks
>> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, =
curr will
>> be evicted. And this change does not consider the cgroup hierarchy.
>>=20
>> Besides, the check of current eligiblity can get false negative =
result,
>> if the enqueued entity has a positive lag. Prateek proposed to
>> remove the check of current's eligibility in pick_eevdf():
>> =
https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/=

>=20
> Thank you for letting me know about Peter's latest updates and =
thoughts.
> Actually, the original intention of my modification was to minimize =
the
> traversal of the rb-tree as much as possible. For example, in the =
following
> scenario, if 'curr' is ineligible, the system would still traverse the =
rb-tree in
> 'pick_eevdf' to return an optimal 'se', and then trigger  =
'resched_curr'. After
> resched, the scheduler will call 'pick_eevdf' again, traversing the
> rb-tree once more. This ultimately results in the rb-tree being =
traversed
> twice. If it's possible to determine that 'curr' is ineligible within =
'wakeup_preempt'
> and directly trigger a 'resched', it would reduce the traversal of the =
rb-tree
> by one time.
>=20
>=20
> wakeup_preempt-> pick_eevdf                                      -> =
resched_curr
>                                                 |->'traverse the =
rb-tree'  |
> schedule->pick_eevdf
>                                   |->'traverse the rb-tree'
>=20
>=20
> Of course, this would break the semantics of RESPECT_SLICE as well as
> RUN_TO_PARITY. So, this might be considered a performance enhancement
> for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.
>=20
Sorry for the mistake. I mean it should be a performance enhancement for =
scenarios
with NO_RESPECT_SLICE/NO_RUN_TO_PARITY.

Maybe it should be like this

@@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
return;

+ if (!sched_feat(RESPECT_SLICE) && !sched_feat(RUN_TO_PARITY) && =
!entity_eligible(cfs_rq, se))
+ 	goto preempt;
+

> thanks=20
> Chunxin
>=20
>=20
>> If I understand your requirement correctly, you want to reduce the =
wakeup
>> latency. There are some codes under developed by Peter, which could
>> customized task's wakeup latency via setting its slice:
>> https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
>>=20
>> thanks,
>> Chenyu



