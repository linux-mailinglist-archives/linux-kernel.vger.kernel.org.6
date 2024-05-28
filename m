Return-Path: <linux-kernel+bounces-191656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F688D1228
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1C41F23609
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5E101DE;
	Tue, 28 May 2024 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjJCtiMH"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436659450
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864190; cv=none; b=ifdOL+GJCpiUJAKov3bkOwxSVeJtW+ZNwRmpMoejqva6IxPW1TrgyzLCbIsd2NZdTM9vMcYl8eM1hWI0oezkmcashr88lwdv3i2YFOS0GsilwMkwUsFKT6VRu6Lhlp7MAhueTIDHFmWS9RdZmd/JU2zZm9ijrvJMRc22Ry9v9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864190; c=relaxed/simple;
	bh=cA6/vKtJ+ncmVgNMjcvcS3v5Oep7Hbff4E9nnzo0aC8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sgCwMRlagE2jRmRtKvOz3chWd/Kk4H18a9fmxPiVkin3aINU6xJErtXP+NgDGDmoG5Eo666IsxQtabO2V/wvJO3c3QVQFQLnkNM0fBn34KtASlfSzBbYDjYTISFnZdfbO+pXgYvooLmB6WubNtwJy3KF75/Jg+cWu5PtnfLoAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjJCtiMH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7948b50225bso29084785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716864188; x=1717468988; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do9BQZQxBdQ1xktnnuXGvN/BRRQQbdTkLV59eOLitQo=;
        b=gjJCtiMHO1qmiJubhbkdunc6scGjmNQE+WU0jY5kXKIPLelPjoA+a0n+Tt518WqP45
         xf6frq3h41FESbuDsjvB62FhZHb80nm1YlXrwdOSNy1LTs4sjjQcIfI2ilTvkHxl6Vlg
         tWO+Q3eVno01hPHdayT8Lqxd4Ugk1l7oL9dsPKgXTNISmCmZ30ldT0sISfQB/7p4jOVG
         HXb6M2X9V8n6wJhrfRg+wjG2IyuRWHbfvaefh3Z4p0YWnaUszU6FOMY9Em6erzIr7Lkp
         Hy0th8ocT6+X1gdR7pERvP86qxs6fwf6SRFdYxDeSLFWhqQBJRqTRZYFA2b03Uj7krXw
         XBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716864188; x=1717468988;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do9BQZQxBdQ1xktnnuXGvN/BRRQQbdTkLV59eOLitQo=;
        b=vKxWufboLXJjyY1BlFyy1SS7eMaO7PO1w10vyIEz2U8OBCN9IbKBJyRbVPo+ozCL8k
         obgwbBvAvC35BrDo4tJELcYL0W25+KZQoAg8XTeWMcpeV1XnmlNmHPishF+gIYj1jztZ
         x+cnGBbbDNaHiCzEq8GQJSZZcNWw1KIBJZGizlEY3/LGbybabaqLvgX7z7jFX910WkEa
         /RZdIA2aInt1escWfSRMG++nE+AhfjhK3vcXllse0CmpPmCe/TtAYdbewsXmFOjXGYSx
         UhpcCI5jgPNKC8UhEf+SkHv/t7qoAAOy2keYRAgGQRJg1L2PeuV5R0vP38s8rCTtueSj
         NiDA==
X-Forwarded-Encrypted: i=1; AJvYcCV5FGf+xo5gUwFhPtrWSD9fmzcfmg/IH5lDzpdj/a+jgiynoKcNEUads9ZREPkwuLyg6kxpcyp/vLbkOQzVboW6Q7rOikHfbJ/SM4M6
X-Gm-Message-State: AOJu0YyiaPc8dxYb9D+hh/do15gh+3qw0IgGDRHlrBn4h+/ut888Eiod
	zUIL9gym8Pl9gkmTEhuQtNY/9ePc3WgQpJVg0oJB/fKh85P86TZv
X-Google-Smtp-Source: AGHT+IFKe+8FRKEsAks4DSzFmXSrGru5V2S3KPz80RMTHXEvPRx+crjz1622m7i+7ipRF3K2HTwLUA==
X-Received: by 2002:a05:6214:310b:b0:6ad:74ff:baa7 with SMTP id 6a1803df08f44-6ad74ffbb86mr87344606d6.24.1716864188088;
        Mon, 27 May 2024 19:43:08 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac07100a89sm39591056d6.68.2024.05.27.19.43.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 19:43:07 -0700 (PDT)
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
In-Reply-To: <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
Date: Tue, 28 May 2024 10:42:50 +0800
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
 zhouchunhua@lixiang.com,
 zangchunxin@lixiang.com,
 kprateek.nayak@amd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)


> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
>> I found that some tasks have been running for a long enough time and
>> have become illegal, but they are still not releasing the CPU. This
>> will increase the scheduling delay of other processes. Therefore, I
>> tried checking the current process in wakeup_preempt and entity_tick,
>> and if it is illegal, reschedule that cfs queue.
>>=20
>> The modification can reduce the scheduling delay by about 30% when
>> RUN_TO_PARITY is enabled.
>> So far, it has been running well in my test environment, and I have
>> pasted some test results below.
>>=20
>=20
> Interesting, besides hackbench, I assume that you have workload in
> real production environment that is sensitive to wakeup latency?

Hi Chen

Yes, my workload  are quite sensitive to wakeup latency .
>=20
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 03be0d1330a6..a0005d240db5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
>> 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>> 		return;
>> #endif
>> +
>> +	if (!entity_eligible(cfs_rq, curr))
>> +		resched_curr(rq_of(cfs_rq));
>> }
>>=20
>=20
> entity_tick() -> update_curr() -> update_deadline():
> se->vruntime >=3D se->deadline ? resched_curr()
> only current has expired its slice will it be scheduled out.
>=20
> So here you want to schedule current out if its lag becomes 0.
>=20
> In lastest sched/eevdf branch, it is controlled by two sched features:
> RESPECT_SLICE: Inhibit preemption until the current task has exhausted =
it's slice.
> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until =
0-lag.
> =
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dsched/eevdf&id=3De04f5454d68590a239092a700e9bbaf84270397c
>=20
> Maybe something like this can achieve your goal
> 	if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
> 		resched_curr
>=20
>>=20
>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
>> 	if (unlikely(p->policy !=3D SCHED_NORMAL) || =
!sched_feat(WAKEUP_PREEMPTION))
>> 		return;
>>=20
>> +	if (!entity_eligible(cfs_rq, se))
>> +		goto preempt;
>> +
>=20
> Not sure if this is applicable, later in this function, pick_eevdf() =
checks
> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, =
curr will
> be evicted. And this change does not consider the cgroup hierarchy.
>=20
> Besides, the check of current eligiblity can get false negative =
result,
> if the enqueued entity has a positive lag. Prateek proposed to
> remove the check of current's eligibility in pick_eevdf():
> =
https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/=


Thank you for letting me know about Peter's latest updates and thoughts.
Actually, the original intention of my modification was to minimize the
traversal of the rb-tree as much as possible. For example, in the =
following
scenario, if 'curr' is ineligible, the system would still traverse the =
rb-tree in
'pick_eevdf' to return an optimal 'se', and then trigger  =
'resched_curr'. After
resched, the scheduler will call 'pick_eevdf' again, traversing the
rb-tree once more. This ultimately results in the rb-tree being =
traversed
twice. If it's possible to determine that 'curr' is ineligible within =
'wakeup_preempt'
and directly trigger a 'resched', it would reduce the traversal of the =
rb-tree
by one time.


wakeup_preempt-> pick_eevdf                                      -> =
resched_curr
                                                 |->'traverse the =
rb-tree'  |
schedule->pick_eevdf
                                   |->'traverse the rb-tree'


Of course, this would break the semantics of RESPECT_SLICE as well as
RUN_TO_PARITY. So, this might be considered a performance enhancement
for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.

thanks=20
Chunxin


> If I understand your requirement correctly, you want to reduce the =
wakeup
> latency. There are some codes under developed by Peter, which could
> customized task's wakeup latency via setting its slice:
> https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
>=20
> thanks,
> Chenyu






=09


