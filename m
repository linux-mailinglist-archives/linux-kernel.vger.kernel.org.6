Return-Path: <linux-kernel+bounces-317131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212D96D9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38F31C22C01
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC519AD71;
	Thu,  5 Sep 2024 13:02:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04249198E84
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541372; cv=none; b=XlZ0u+Y/68khhkevfbOyHsbGSd5QhCZmh0DABuY0lbe+7BpBQSCTswGZHKzqQMzQ7jGlVj3KMxBddZUcH+u+mQSa5eyP4JcoAOURDVVEvlj9NjO4luSnbng+ecIV8NuIOe9U/KuNSS9DpwzqMkPjdo6jgFF6c7n7WQYUbACfKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541372; c=relaxed/simple;
	bh=yYZkt3edU0NNOuvBYF/n57PexRLn23QqcUY+uCNNhDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea+ncHhgVe4wXdGW0mKNRZ857b6iISu/0OUKdA9Au9BQDa9r/kqgyrC4ZX72bFfEmbCFL4ze1E9tdc0pFVsBjaUlRh1RJ0pCaRsa37efHYqKfdhCqqqrayU2BY/iVTLSHuNwtCE/oGvklaaGPhCxc0qHCU/eYtI+Jd8bYswDR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 127791063;
	Thu,  5 Sep 2024 06:03:17 -0700 (PDT)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6353F73F;
	Thu,  5 Sep 2024 06:02:48 -0700 (PDT)
Message-ID: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
Date: Thu, 5 Sep 2024 15:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Hongyan Xia <hongyan.xia2@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Luis Machado <luis.machado@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2024 17:42, Hongyan Xia wrote:
> On 22/08/2024 15:58, Vincent Guittot wrote:
>> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>>>
>>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>>>>
>>>> Vincent,
>>>>
>>>> On 8/22/24 11:28, Luis Machado wrote:
>>>>> On 8/22/24 10:53, Vincent Guittot wrote:
>>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Hi Peter,
>>>>>>>>>
>>>>>>>>> Sorry for bombarding this thread in the last couple of days.
>>>>>>>>> I'm seeing
>>>>>>>>> several issues in the latest tip/sched/core after these patches
>>>>>>>>> landed.
>>>>>>>>>
>>>>>>>>> What I'm now seeing seems to be an unbalanced call of util_est.
>>>>>>>>> First, I applied
>>>>>>>>
>>>>>>>> I also see a remaining util_est for idle rq because of an unbalance
>>>>>>>> call of util_est_enqueue|dequeue
>>>>>>>>
>>>>>>>
>>>>>>> I can confirm issues with the utilization values and frequencies
>>>>>>> being driven
>>>>>>> seemingly incorrectly, in particular for little cores.
>>>>>>>
>>>>>>> What I'm seeing with the stock series is high utilization values
>>>>>>> for some tasks
>>>>>>> and little cores having their frequencies maxed out for extended
>>>>>>> periods of
>>>>>>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the
>>>>>>> cores are mostly
>>>>>>> idle. But whenever certain tasks get scheduled there, they have a
>>>>>>> very high util
>>>>>>> level and so the frequency is kept at max.
>>>>>>>
>>>>>>> As a consequence this drives up power usage.
>>>>>>>
>>>>>>> I gave Hongyan's draft fix a try and observed a much more
>>>>>>> reasonable behavior for
>>>>>>> the util numbers and frequencies being used for the little cores.
>>>>>>> With his fix,
>>>>>>> I can also see lower energy use for my specific benchmark.
>>>>>>
>>>>>> The main problem is that the util_est of a delayed dequeued task
>>>>>> remains on the rq and keeps the rq utilization high and as a result
>>>>>> the frequency higher than needed.
>>>>>>
>>>>>> The below seems to works for me and keep sync the enqueue/dequeue of
>>>>>> uti_test with the enqueue/dequeue of the task as if de dequeue was
>>>>>> not
>>>>>> delayed
>>>>>>
>>>>>> Another interest is that we will not try to migrate a delayed dequeue
>>>>>> sleeping task that doesn't actually impact the current load of the
>>>>>> cpu
>>>>>> and as a result will not help in the load balance. I haven't yet
>>>>>> fully
>>>>>> checked what would happen with hotplug
>>>>>
>>>>> Thanks. Those are good points. Let me go and try your patch.
>>>>
>>>> I gave your fix a try, but it seems to make things worse. It is
>>>> comparable
>>>> to the behavior we had before Peter added the uclamp imbalance fix,
>>>> so I
>>>> believe there is something incorrect there.
>>>
>>> we need to filter case where task are enqueued/dequeued several
>>> consecutive times. That's what I'm look now
>>
>> I just realize before that It's not only util_est but the h_nr_running
>> that keeps delayed tasks as well so all stats of the rq are biased:
>> h_nr_running, util_est, runnable avg and load_avg.
> 
> After staring at the code even more, I think the situation is worse.
> 
> First thing is that uclamp might also want to be part of these stats
> (h_nr_running, util_est, runnable_avg, load_avg) that do not follow
> delayed dequeue which needs to be specially handled in the same way. The
> current way of handling uclamp in core.c misses the frequency update,
> like I commented before.
> 
> Second, there is also an out-of-sync issue in update_load_avg(). We only
> update the task-level se in delayed dequeue and requeue, but we return
> early and the upper levels are completely skipped, as if the delayed
> task is still on rq. This de-sync is wrong.

I had a look at the util_est issue.

This keeps rq->cfs.avg.util_avg sane for me with
SCHED_FEAT(DELAY_DEQUEUE, true):

-->8--

From 0d7e8d057f49a47e0f3f484ac7d41e047dccec38 Mon Sep 17 00:00:00 2001
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Thu, 5 Sep 2024 00:05:23 +0200
Subject: [PATCH] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE

Remove delayed tasks from util_est even they are runnable.

Exclude delayed task which are (a) migrating between rq's or (b) in a
SAVE/RESTORE dequeue/enqueue.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e693ca8ebd6..5c32cc26d6c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
 
-	if (flags & ENQUEUE_DELAYED) {
-		requeue_delayed_entity(se);
-		return;
-	}
-
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	util_est_enqueue(&rq->cfs, p);
+	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
+		util_est_enqueue(&rq->cfs, p);
+
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	util_est_dequeue(&rq->cfs, p);
+	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+		util_est_dequeue(&rq->cfs, p);
 
 	if (dequeue_entities(rq, &p->se, flags) < 0) {
 		if (!rq->cfs.h_nr_running)
-- 
2.34.1


























