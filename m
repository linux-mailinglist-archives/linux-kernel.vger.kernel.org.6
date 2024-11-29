Return-Path: <linux-kernel+bounces-425436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAE9DC20A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47476B21A15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022816A95B;
	Fri, 29 Nov 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBIKmpE/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F524AD23
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875542; cv=none; b=AScqqePfS2MjRW3i34+hrw9+WvnDXzlYYEf0QPwQFBSB1aOqfzBX8VwMOmzTxyjQiccXeYM9uRL8LSFUoXqRGSGqgscRW80JZoDncTPNFSDfn66jn1J29SZVFvP4ygJspDh1Vd4dCxMltuLY6BfC495zHfKr0Iwflg3GVIAzd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875542; c=relaxed/simple;
	bh=RvPdE7kX8hLmqDnAOQy1BJSUud0BOZblF6cXs2tZAwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGX6FeJWXjgarI0gPmfdY0bFqNaUIA/aPFtWWvb8wcM8vkldj+/zt68OALtTtxvVdH8513lkF+SeyICSo5CoSvQ04utdyS1fFb/7/djrWT11moQMeyY73lQInXa8T3jmTMNubiAV3wrIUZ8zgoDdXYgwTkVP0beRSVYQ032mfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uBIKmpE/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S2lf3TI/b6E6++0Yk0fvViEeZdn8XaWt6mnXyZys+vY=; b=uBIKmpE/ZELKv2ml/OIelYLYbH
	ueFirbyO6WPV64o2O0LGXogBiSutdQGwFz5jQuV5OzSs3Tbv8ppdajBaZm/oJ5hncvJZ+s1LkgiSO
	4r/R/KtHeURUSMB33TWaUllr5bAKE0FoS5xOm4HFjtRWrrzQkQtm7wj4/31CYYP4ZQZhgjbiyr8Ah
	cPBWIGq6IOn82hr5NKWWT5Z8SEh+q+RhuWU7F+Ln/SWXuQPuVDhCRz5hr2+n0X8bM+KOcp3jZp8er
	/nmCYYlz1xIrLQKKq8OxOqv5Z3TfAzvPPRkO5rbXwkWlunHxUKMrVjKcl88SzGIf2G8Xqy5NQMzLk
	2aB0pdTw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGy5I-00000003szb-2W9R;
	Fri, 29 Nov 2024 10:18:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76F8E30026A; Fri, 29 Nov 2024 11:18:49 +0100 (CET)
Date: Fri, 29 Nov 2024 11:18:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: Re: [PATCH] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
Message-ID: <20241129101849.GB33464@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
 <20241129101541.GA33464@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129101541.GA33464@noisy.programming.kicks-ass.net>

On Fri, Nov 29, 2024 at 11:15:41AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 29, 2024 at 10:55:00AM +0100, Peter Zijlstra wrote:
> 
> > Anyway..  I'm sure I started a patch series cleaning up the whole next
> > buddy thing months ago (there's more problems here), but I can't seem to
> > find it in a hurry :/
> 
> There was this..

And this I think.

Adam, what was the reason you were enabling NEXT_BUDDY in the first
place?

I think someone (Ingo?) was proposing we kill the wakeup preempt thing;
and I suspect you don't actually care about that but instead want either
the cgroup or the yield_to_task()/KVM thing working.

---
Subject: sched/fair: Add CGROUP_BUDDY feature
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 29 10:49:45 CET 2024

Add a feature to toggle the cgroup optimization.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |    3 ++-
 kernel/sched/features.h |    8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7126,7 +7126,8 @@ static int dequeue_entities(struct rq *r
 			 * Bias pick_next to pick a task from this cfs_rq, as
 			 * p is sleeping when it is within its sched_slice.
 			 */
-			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
+			if (sched_feat(CGROUP_BUDDY) &&
+			    task_sleep && se && !throttled_hierarchy(cfs_rq))
 				set_next_buddy(se);
 			break;
 		}
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -32,11 +32,17 @@ SCHED_FEAT(PREEMPT_SHORT, true)
 SCHED_FEAT(NEXT_BUDDY, false)
 
 /*
+ * Optimization for cgroup scheduling where a dequeue + pick tries
+ * to share as much of the hierarchy as possible.
+ */
+SCHED_FEAT(CGROUP_BUDDY, true)
+
+/*
  * Allow completely ignoring cfs_rq->next; which can be set from various
  * places:
  *   - NEXT_BUDDY (wakeup preemption)
  *   - yield_to_task()
- *   - cgroup dequeue / pick
+ *   - CGROUP_BUDDY (cgroup dequeue / pick)
  */
 SCHED_FEAT(PICK_BUDDY, true)
 

