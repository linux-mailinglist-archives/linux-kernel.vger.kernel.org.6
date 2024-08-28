Return-Path: <linux-kernel+bounces-305824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740789634E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B747286889
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669791AC446;
	Wed, 28 Aug 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j/79URID"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3C1AD410
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884695; cv=none; b=uxnflJodhu2Pg+eS6RWXNBbus4XkCmjrFQmjyWoxmatCdaZUPNSq3bzUqrE/A4ESEQJkP8YcGY0ySxfS7L67o+LFxHjcjKha9zI5z9vWUkWqVjgzx6gPuV9tXX77gPwaDt0fiPLCLrOihCPSsT5j+tWssAcqukek3W8Uv2uPsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884695; c=relaxed/simple;
	bh=dpMiiRQPfrCqMrlXD/nyO5Ac0v7IUV6zIcJ4K0+QCrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pWjXj+JVkJjqb8qWsMtFqRgZPzR6wwbMV0u6roOnDTBbGiliOrsQHqId8YoaG0BM4V+KMXB49L08aVvq+vW1IXCqn2toHcDXX/0AV2ZDFHhdd9IqAroeVzUeanIJkxBTVoPienlBt7H4YGTIP3q5cKLuncHR2nZTkLuT6boeeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j/79URID; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240828223804euoutp026108d8f2903c8cc9583f77f5f557e99b~wBXtuXRBI0536005360euoutp02U
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240828223804euoutp026108d8f2903c8cc9583f77f5f557e99b~wBXtuXRBI0536005360euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724884685;
	bh=quZhyF15BS1F6otp4GlFpx8EM4QZszKavPMgXP3exzI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=j/79URIDm+CcxZw0JZTGqLk72svoNXXWugkzS6U5pNIoJ2aYpRnbWVKeDug/caSUn
	 ZBgpZ39H8+nmiMIomSSo4rl7qaLLz49cRku6BggWOyQdoXoLngx7tEsgHZN5MqHQSy
	 dsngufa1ZrLkqwlI+uh4zWGbWo7+irW/PIk7v31E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240828223804eucas1p21486c9a2ff9e9053fee9e71176ff95b9~wBXs3ZsgY2753527535eucas1p27;
	Wed, 28 Aug 2024 22:38:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.AD.09875.BC6AFC66; Wed, 28
	Aug 2024 23:38:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240828223802eucas1p16755f4531ed0611dc4871649746ea774~wBXrqKC332245922459eucas1p1U;
	Wed, 28 Aug 2024 22:38:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240828223802eusmtrp2b6d5bb1b0682487e7dbd5fd8c1dc028c~wBXrn4PFO0073800738eusmtrp2z;
	Wed, 28 Aug 2024 22:38:02 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-2d-66cfa6cb5960
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.A6.08810.AC6AFC66; Wed, 28
	Aug 2024 23:38:02 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828223800eusmtip125f2c80c005be46f50e20c585e661be1~wBXpy3Ip61893118931eusmtip1Z;
	Wed, 28 Aug 2024 22:38:00 +0000 (GMT)
Message-ID: <5618d029-769a-4690-a581-2df8939f26a9@samsung.com>
Date: Thu, 29 Aug 2024 00:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240727105030.226163742@infradead.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djP87qnl51PM/gxx9Ri+stGFounE7Yy
	W6x5c4vF4m7/VBaLv52OFpd3zWGzmPzuGaPFpQMLmCyO9x5gstjX8YDJYvOmqcwWHUe+MVts
	Pfqd3WLzjVY2i8stE5kd+D1aL/1l81gzbw2jx78Ta9g8ZjdcZPH48DHOo2XfLXaPBZtKPTav
	0PK4c20Pm8e7c+fYPd7vu8rmsfl0tcfnTXIBvFFcNimpOZllqUX6dglcGdMeHmAruGdV0bjv
	DmMDY79uFyMnh4SAicTqSRvYuhi5OIQEVjBK7NuzlB3C+cIo0X14IguE85lRYv/RHiaYlhfT
	ZkC1LAeqOvQKquUjo8SMAw9YQKp4BewkDny5BGazCKhKPJvyhBUiLihxcuYTsLiogLzE/Vsz
	2EFsYQEHiR+fd4ENEhH4zSjx6tcrRpAEs0CJxLJlf9khbHGJW0/mg53BJmAo0fW2C+gMDg5O
	AVOJ431ZECXyEtvfzmEGmSMhcI5TYtnHFjaIs10kXkxoY4awhSVeHd/CDmHLSPzfCTITpKGd
	UWLB7/tQzgRGiYbntxghqqwl7pz7BbaNWUBTYv0ufYiwo0T32bssIGEJAT6JG28FIY7gk5i0
	bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlKwzELy5Swk78xC2LuAkWUVo3hqaXFuemqx
	UV5quV5xYm5xaV66XnJ+7iZGYHI8/e/4lx2My1991DvEyMTBeIhRgoNZSYT3xPGzaUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MqUq92aITjsTpcths
	3XH7zJvadA6RE02704KqYq4rcs3pU759bdfseRInnurcsOVIusC3b7bv7hcfvxf2qjI7p5wW
	6jT3kQ/Nv1ksYxV2L3eG5IZQ9eSbDnduGOa4NqcZPXyup9st2yqryeEt9UYwMOTC8o/iH17t
	ENjJUC+28HDF3uv8/aUV1tVT3Zv1xBy3hconWzPvvmfBUys130z4s+W1w/6SYk0hCg06h99c
	f6XrwNJrym7OWSyWHNl4RXDFta1MrCq8id2HHzsacNx4d9tty9xULh9m+2/T6qdu9Fhkn6Zz
	NsI7cOZ/i8xtt5vPv5AM8Lu32l9lNts9u/4XdlWSGw+9vRhn1rttrRJLcUaioRZzUXEiABTl
	t5n9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7qnlp1PM9j4UdZi+stGFounE7Yy
	W6x5c4vF4m7/VBaLv52OFpd3zWGzmPzuGaPFpQMLmCyO9x5gstjX8YDJYvOmqcwWHUe+MVts
	Pfqd3WLzjVY2i8stE5kd+D1aL/1l81gzbw2jx78Ta9g8ZjdcZPH48DHOo2XfLXaPBZtKPTav
	0PK4c20Pm8e7c+fYPd7vu8rmsfl0tcfnTXIBvFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
	lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GdMeHmAruGdV0bjvDmMDY79uFyMnh4SAicSLaTPY
	uhi5OIQEljJKfDxxkQkiISNxcloDK4QtLPHnWhcbiC0k8J5RYvFjcRCbV8BO4sCXSywgNouA
	qsSzKU9YIeKCEidnPgGLiwrIS9y/NYMdxBYWcJD48XkXO8gyEYHfjBKd/w+CLWMWKJG4sfYy
	I8SCeIm1ayYwQsTFJW49mQ9WwyZgKNH1FuQIDg5OAVOJ431ZECVmEl1bu6DK5SW2v53DPIFR
	aBaSM2YhmTQLScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBCaCbcd+bt7BOO/V
	R71DjEwcjIcYJTiYlUR4Txw/mybEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84GpKK8k3tDM
	wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgclSfvGlvaGu97vmh2dFGZX7
	CDGdqrkz/3jlxSnbLvzXOOjzcPfaqt7Qk2/vNF5dkihcMLVyu8YEkyC11HNRk3zXez+Vmia0
	5/aJNWeWKf8tbc3POR599fWefWYBz8zj/6xKVssumlRi2LXrluCaay5/WqZt233pzY4j/bFC
	75+IBdle5U2TfvirOuTRI+G8S0effZoVVNB+rXLvhUj+PZ6b77+Y9mWTNHOv09NXOX1ehY17
	DNsMEv4U/lZSPq593r/g6XO3goDbTXwTlvEK/v+bcOvQqSOvVs542He6ImffIxH9rMOL3i9b
	mLuwwnb3z9xK5fNVloycbuseqq9cf7xs8/8X9xPrj/tVhyjdPX7aQ4mlOCPRUIu5qDgRAL8a
	T+WNAwAA
X-CMS-MailID: 20240828223802eucas1p16755f4531ed0611dc4871649746ea774
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240828223802eucas1p16755f4531ed0611dc4871649746ea774
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240828223802eucas1p16755f4531ed0611dc4871649746ea774
References: <20240727102732.960974693@infradead.org>
	<20240727105030.226163742@infradead.org>
	<CGME20240828223802eucas1p16755f4531ed0611dc4871649746ea774@eucas1p1.samsung.com>

On 27.07.2024 12:27, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
>
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
>
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
>
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
>
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This patch landed recently in linux-next as commit 152e11f6df29 
("sched/fair: Implement delayed dequeue"). In my tests on some of the 
ARM 32bit boards it causes a regression in rtcwake tool behavior - from 
time to time this simple call never ends:

# time rtcwake -s 10 -m on

Reverting this commit (together with its compile dependencies) on top of 
linux-next fixes this issue. Let me know how can I help debugging this 
issue.

> ---
>   kernel/sched/deadline.c |    1
>   kernel/sched/fair.c     |   82 ++++++++++++++++++++++++++++++++++++++++++------
>   kernel/sched/features.h |    9 +++++
>   3 files changed, 81 insertions(+), 11 deletions(-)
>
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2428,7 +2428,6 @@ static struct task_struct *__pick_next_t
>   		else
>   			p = dl_se->server_pick_next(dl_se);
>   		if (!p) {
> -			WARN_ON_ONCE(1);
>   			dl_se->dl_yielded = 1;
>   			update_curr_dl_se(rq, dl_se, 0);
>   			goto again;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5379,20 +5379,44 @@ static void clear_buddies(struct cfs_rq
>   
>   static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>   
> -static void
> +static bool
>   dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   {
> -	int action = UPDATE_TG;
> +	if (flags & DEQUEUE_DELAYED) {
> +		/*
> +		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
> +		 * at which point we've already done update_curr() and do not
> +		 * want to do so again.
> +		 */
> +		SCHED_WARN_ON(!se->sched_delayed);
> +		se->sched_delayed = 0;
> +	} else {
> +		bool sleep = flags & DEQUEUE_SLEEP;
> +
> +		/*
> +		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> +		 * states must not suffer spurious wakeups, excempt them.
> +		 */
> +		if (flags & DEQUEUE_SPECIAL)
> +			sleep = false;
> +
> +		SCHED_WARN_ON(sleep && se->sched_delayed);
> +		update_curr(cfs_rq);
>   
> +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !entity_eligible(cfs_rq, se)) {
> +			if (cfs_rq->next == se)
> +				cfs_rq->next = NULL;
> +			se->sched_delayed = 1;
> +			return false;
> +		}
> +	}
> +
> +	int action = UPDATE_TG;
>   	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>   		action |= DO_DETACH;
>   
>   	/*
> -	 * Update run-time statistics of the 'current'.
> -	 */
> -	update_curr(cfs_rq);
> -
> -	/*
>   	 * When dequeuing a sched_entity, we must:
>   	 *   - Update loads to have both entity and cfs_rq synced with now.
>   	 *   - For group_entity, update its runnable_weight to reflect the new
> @@ -5430,6 +5454,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>   
>   	if (cfs_rq->nr_running == 0)
>   		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +
> +	return true;
>   }
>   
>   static void
> @@ -5828,11 +5854,21 @@ static bool throttle_cfs_rq(struct cfs_r
>   	idle_task_delta = cfs_rq->idle_h_nr_running;
>   	for_each_sched_entity(se) {
>   		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> +		int flags;
> +
>   		/* throttled entity or throttle-on-deactivate */
>   		if (!se->on_rq)
>   			goto done;
>   
> -		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> +		/*
> +		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
> +		 * This avoids teaching dequeue_entities() about throttled
> +		 * entities and keeps things relatively simple.
> +		 */
> +		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
> +		if (se->sched_delayed)
> +			flags |= DEQUEUE_DELAYED;
> +		dequeue_entity(qcfs_rq, se, flags);
>   
>   		if (cfs_rq_is_idle(group_cfs_rq(se)))
>   			idle_task_delta = cfs_rq->h_nr_running;
> @@ -6918,6 +6954,7 @@ static int dequeue_entities(struct rq *r
>   	bool was_sched_idle = sched_idle_rq(rq);
>   	int rq_h_nr_running = rq->cfs.h_nr_running;
>   	bool task_sleep = flags & DEQUEUE_SLEEP;
> +	bool task_delayed = flags & DEQUEUE_DELAYED;
>   	struct task_struct *p = NULL;
>   	int idle_h_nr_running = 0;
>   	int h_nr_running = 0;
> @@ -6931,7 +6968,13 @@ static int dequeue_entities(struct rq *r
>   
>   	for_each_sched_entity(se) {
>   		cfs_rq = cfs_rq_of(se);
> -		dequeue_entity(cfs_rq, se, flags);
> +
> +		if (!dequeue_entity(cfs_rq, se, flags)) {
> +			if (p && &p->se == se)
> +				return -1;
> +
> +			break;
> +		}
>   
>   		cfs_rq->h_nr_running -= h_nr_running;
>   		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> @@ -6956,6 +6999,7 @@ static int dequeue_entities(struct rq *r
>   			break;
>   		}
>   		flags |= DEQUEUE_SLEEP;
> +		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
>   	}
>   
>   	for_each_sched_entity(se) {
> @@ -6985,6 +7029,17 @@ static int dequeue_entities(struct rq *r
>   	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>   		rq->next_balance = jiffies;
>   
> +	if (p && task_delayed) {
> +		SCHED_WARN_ON(!task_sleep);
> +		SCHED_WARN_ON(p->on_rq != 1);
> +
> +		/* Fix-up what dequeue_task_fair() skipped */
> +		hrtick_update(rq);
> +
> +		/* Fix-up what block_task() skipped. */
> +		__block_task(rq, p);
> +	}
> +
>   	return 1;
>   }
>   /*
> @@ -6996,8 +7051,10 @@ static bool dequeue_task_fair(struct rq
>   {
>   	util_est_dequeue(&rq->cfs, p);
>   
> -	if (dequeue_entities(rq, &p->se, flags) < 0)
> +	if (dequeue_entities(rq, &p->se, flags) < 0) {
> +		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
>   		return false;
> +	}
>   
>   	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>   	hrtick_update(rq);
> @@ -12973,6 +13030,11 @@ static void set_next_task_fair(struct rq
>   		/* ensure bandwidth has been allocated on our new cfs_rq */
>   		account_cfs_rq_runtime(cfs_rq, 0);
>   	}
> +
> +	if (!first)
> +		return;
> +
> +	SCHED_WARN_ON(se->sched_delayed);
>   }
>   
>   void init_cfs_rq(struct cfs_rq *cfs_rq)
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -29,6 +29,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
>   SCHED_FEAT(CACHE_HOT_BUDDY, true)
>   
>   /*
> + * Delay dequeueing tasks until they get selected or woken.
> + *
> + * By delaying the dequeue for non-eligible tasks, they remain in the
> + * competition and can burn off their negative lag. When they get selected
> + * they'll have positive lag by definition.
> + */
> +SCHED_FEAT(DELAY_DEQUEUE, true)
> +
> +/*
>    * Allow wakeup-time preemption of the current task:
>    */
>   SCHED_FEAT(WAKEUP_PREEMPTION, true)
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


