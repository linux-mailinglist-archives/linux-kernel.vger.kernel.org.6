Return-Path: <linux-kernel+bounces-330473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20359979EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7614DB214F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2614C592;
	Mon, 16 Sep 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cAXJ8jAB"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D421CF83
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481575; cv=none; b=dxhlte3gOTW0efugpAUSwiB6SGjMlQVLknz5lmhHGx048kH1JUDyAHUwGXQrHwvl0SGKSGcnHpnLB6TUDQVoNILRpGRadraLGpMQLt9ebv+DyOnmAgsvJ4yzjNIpWyyHfRw6OQap5qfv2lLeUHngEiH0FxcRFvwqXkm2SZ4aVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481575; c=relaxed/simple;
	bh=QIRVAFOpl6ucDBpeBRGOnKH6EQO3eYbq60GJF1MZIzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYOG5xOtud2F5/HTwBza/yfH2/f7SYxTi6etNMDkNp1xCeJjLryJgp6cwmjhUYtU711FDlfrrJY1O0b7pem25jWZ9LdkqEjMx8ZtNwTiAkVefV4n3vFE8lbl5FyL0+RTdFV50SzOle18xAy7kvrky87JIflWjgK9T5/VLbYoJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cAXJ8jAB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726481564;
	bh=QIRVAFOpl6ucDBpeBRGOnKH6EQO3eYbq60GJF1MZIzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cAXJ8jABqjZ7X5FrX5wdjiEvEVAhZb+iHBi+JvX6coGLHiAIZGDC2zoCqyQiFKTK5
	 +fYQ2chWvu03yVhZykuEQPG+ccFtsZyvp1EiR9h+JTxtblY9Q/A57prdDhwJiiX/ck
	 h3+HlsPBfYh1KyfwNgbCss5PzFcL1JmH1Kyr4jpe4cVSSNXyUzitqCfeWyDZbfiuPp
	 +xiU4fBf8Fzuf7+Y6MGAoEDcp/h8O4PLKU9lcgmgDVE5Oum4Y/zxlMyupf+FPSbCNC
	 DzueGtH3GZLkYLWd2ReZxW2sfmI3R48k8GOWnw88RDNFEwm2iNx/vUnreE/W0/WlOS
	 pOe+CjBgn/lRQ==
Received: from [10.9.6.249] (vpn-konference.ms.mff.cuni.cz [195.113.20.101])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X6ghT75PYz1LHt;
	Mon, 16 Sep 2024 06:12:41 -0400 (EDT)
Message-ID: <5cf2c0a5-7a99-4294-b316-eee07896ddf6@efficios.com>
Date: Sun, 15 Sep 2024 12:11:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240909211506.326648-1-mathieu.desnoyers@efficios.com>
 <20240909211506.326648-2-mathieu.desnoyers@efficios.com>
 <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
 <0edc398e-d193-4c2d-907e-f5db93143f79@efficios.com>
 <CANpmjNOPJm7nfzuF2VXLmixBZ0ygQ84AkxG8jH0E79XzWPu8xQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CANpmjNOPJm7nfzuF2VXLmixBZ0ygQ84AkxG8jH0E79XzWPu8xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-13 14:09, Marco Elver wrote:
> On Thu, 12 Sept 2024 at 19:34, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-09-12 12:38, Marco Elver wrote:
>>> On Mon, 9 Sept 2024 at 23:15, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
>>>> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
>>>> a reference to the concurrency id allocated for each CPU. This reference
>>>> expires shortly after a 100ms delay.
>>>>
>>>> These per-CPU references keep the per-mm-cid data cache-local in
>>>> situations where threads are running at least once on each CPU within
>>>> each 100ms window, thus keeping the per-cpu reference alive.
>>>
>>> One orthogonal idea that I recall: If a thread from a different thread
>>> group (i.e. another process) was scheduled on that CPU, the CID can
>>> also be invalidated because the caches are likely polluted. Fixed
>>> values like 100ms seem rather arbitrary and it may work for one system
>>> but not another.
>>
>> That depends on the cache usage pattern of the different thread group:
>> it's also possible that the other thread group does not perform that
>> many stores to memory before the original thread group is scheduled
>> back, thus keeping the cache content untouched.
>>
>> The ideal metric there would probably be based on PMU counters, but
>> I doubt we want to go there.
>>
>> [...]
>>>
>>> I like the simpler and more general approach vs. the NUMA-only
>>> approach! Attempting to reallocate the previously assigned CID seems
>>> to go a long way.
>>
>> Indeed it does!
>>
>>>
>>> However, this doesn't quite do L3-awareness as mentioned in [1], right?
>>> What I can tell is that this patch improves cache locality for threads
>>> scheduled back on the _same CPU_, but not if those threads are
>>> scheduled on a _set of CPUs_ sharing the _same L3_ cache. So if e.g. a
>>> thread is scheduled from CPU2 to CPU3, but those 2 CPUs share the same
>>> L3 cache, that thread will get a completely new CID and is unlikely to
>>> hit in the L3 cache when accessing the per-CPU data.
>>>
>>> [1] https://github.com/google/tcmalloc/issues/144#issuecomment-2307739715
>>>
>>> Maybe I missed it, or you are planning to add it in future?
>>
>> In my benchmarks, I noticed that preserving cache-locality at the L1 and
>> L2 levels was important as well.
>>
>> I would like to understand better the use-case you refer to for L3
>> locality. AFAIU, this implies a scenario where the scheduler migrates
>> a thread from CPU 2 to CPU 3 (both with the same L3), and you would
>> like to migrate the concurrency ID along.
> 
> Either migrate it along, _or_ pick a CID from a different thread that
> ran on a CPU that shares this L3. E.g. if T1 is migrated from CPU2 to
> CPU3, and T2 ran on CPU3 before, then it would be ok for T1 to get its
> previous CID or T2's CID from when it ran on CPU3. Or more simply,
> CIDs aren't tied to particular threads, but tied to a subset of CPUs
> based on topology. If the user could specify that topology / CID
> affinity would be nice.

There is probably something to improve there, but I suspect this
is beyond the scope of this patch, and would prefer tackling this
topology-aware CID stealing as a separate effort. I fear that attempting
to be too aggressive in keeping the CID allocation compact on migration
may require us to set/clear bits in the mm_cidmask more often, which may
impact some workloads. If we look into this we need to be careful about
regressions.

> 
>> When the number of threads is < number of mm allowed cpus, the
>> migrate hooks steal the concurrency ID from CPU 2 and moves it to
>> CPU 3 if there is only a single thread from that mm on CPU 2, which
>> does what you wish.
> 
> Only if the next CPU shares the cache. What if it moves the thread to
> a CPU where that CPU's L3 cache != the previous CPU's L3 cache. In
> that case, it'd be preferable to pick a last-used CID from the set of
> CPUs that are grouped under that L3 cache.

Without going all the way towards making this topology-aware, one
improvement I would do for the next version of this patch is to
prevent moving the src CID to the destination cpu (on migration)
when the dst cpu has a recent_cid set. Basically this:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3243e9abfefb..3e290d8609fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11798,7 +11798,8 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  {
  	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
  	struct mm_struct *mm = t->mm;
-	int src_cid, dst_cid, src_cpu;
+	int src_cid, src_cpu;
+	bool dst_cid_is_set;
  	struct rq *src_rq;
  
  	lockdep_assert_rq_held(dst_rq);
@@ -11815,9 +11816,9 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  	 * allocation closest to 0 in cases where few threads migrate around
  	 * many cpus.
  	 *
-	 * If destination cid is already set, we may have to just clear
-	 * the src cid to ensure compactness in frequent migrations
-	 * scenarios.
+	 * If destination cid or recent cid is already set, we may have
+	 * to just clear the src cid to ensure compactness in frequent
+	 * migrations scenarios.
  	 *
  	 * It is not useful to clear the src cid when the number of threads is
  	 * greater or equal to the number of allowed cpus, because user-space
@@ -11825,9 +11826,9 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  	 * allowed cpus.
  	 */
  	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
-	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
-	if (!mm_cid_is_unset(dst_cid) &&
-	    atomic_read(&mm->mm_users) >= atomic_read(&mm->nr_cpus_allowed))
+	dst_cid_is_set = !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->cid)) ||
+			 !mm_cid_is_unset(READ_ONCE(dst_pcpu_cid->recent_cid));
+	if (dst_cid_is_set && atomic_read(&mm->mm_users) >= atomic_read(&mm->nr_cpus_allowed))
  		return;
  	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
  	src_rq = cpu_rq(src_cpu);
@@ -11838,7 +11839,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  							    src_cid);
  	if (src_cid == -1)
  		return;
-	if (!mm_cid_is_unset(dst_cid)) {
+	if (dst_cid_is_set) {
  		__mm_cid_put(mm, src_cid);
  		return;
  	}

> 
>> When the number of threads is >= number of mm allowed cpus, the
>> migrate hook is skipped, and the concurrency ID from CPU 2 is
>> left in place, favoring cache locality at L1/L2 levels.
> 
> ... and any higher level caches, too, I'd assume.

Yes.

> 
>> In that
>> case it's the scheduler's decision to migrate the thread from
>> CPU 2 to CPU 3, so I would think improving the scheduler decisions
>> about migration and minimizing thread movement would be more
>> relevant than trying to optimize concurrency ID movement.
> 
>  From what I gather, if the CID is left in place on a CPU, and the next
> thread just grabs it, that's already optimal AFAIK.

That's indeed the behavior when nr threads >= weight(mm cpus allowed),
which is optimal.

When the number of threads is < weight(mm cpus allowed), this is were
we may want to consider being more aggressive in stealing an
unused already-allocated CID or reserve a recent CID value which is
observed close to the destination cpu within the topology on
thread migration in the future, but the benefit of doing that
vs its downsides is not immediately clear to me. E.g. this
could scan the topology_{sibling,core,cluster,llc}_cpumask
in that order for unused recently used CID to reserve, or
lazy-put CIDs to steal.

Thanks,

Mathieu


> 
> Thanks,
> -- Marco

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


