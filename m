Return-Path: <linux-kernel+bounces-280509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8F94CB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC811C225F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931D176228;
	Fri,  9 Aug 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYvNUqx5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86012FB34
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188931; cv=none; b=K7ag0WP1Pz0VqHdTsb0iAykEdz4LtTfOsdBNi7fKyuujdiuLMuhheuUB0F1cFD4kYTYsIDAsIlr8m5sd9pL3CUNiBAYQPzLLICBnM8UWNa2GrgvGPE8u80rm5CTtkixxoj5jP7gdK4LrKlOIq605E3JOtOJNftDdWicg3BlyaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188931; c=relaxed/simple;
	bh=pDUPRjsOLV3M1oYI4Rw4ENYeWvIh4LwVRZTJ8ngr3vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxNi+44/mE6NtLOoBMKf+GJq7dZFJDN/REIMYzOilma3o17nebasuWaa+5MIh5wRb9eGt8lqVNPZZQ4NpIve5qTJaF2NS9jSLOv12ysNlM3f87UuZeRIMISjXBxIC1rgeRywRkzcPBsFqBBKuxmxBraYAv4wVZkNxZPay+SyQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FYvNUqx5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gHdnJFMueDtgGahaf/EdRvyZJrV/GIQ0r76XfrqQjKw=; b=FYvNUqx56dgvb1+0M0ymAEk3n1
	9BdZZKgew80GbVGbnBWRavt6Uyyw5oaUSaqw+B5cpHHn0DaxDqnPQ/YxZiCw851/jJCZd8JWhX5xR
	N1MerbLGvt+NYFl5JW+Wc4eWk57Qxls3QhICnRxfdeGlqTxygmbcBzJjd880BxukitCZ0hyHPopEr
	wjqAcoNXUukbPkPOuM3wvh3bNAC8/Qgkc1uryT2GyQseObQyogaYHxsa5VdOHLUjQGsWxf5tTcVtJ
	KuBfi1SiqEvc+JvqAFcphXnfLHZD81OMFRN7CV9btH21xOkoIBBDNcQ1PVH/e19z9WfPIvKznE1nh
	8ZnhERIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scK9W-0000000ACqh-2dPk;
	Fri, 09 Aug 2024 07:35:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A4A4300402; Fri,  9 Aug 2024 09:35:09 +0200 (CEST)
Date: Fri, 9 Aug 2024 09:35:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
Message-ID: <20240809073509.GK31338@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.735459544@infradead.org>
 <ZrSa1uxiL7G8PnWm@chenyu5-mobl2>
 <20240808102207.GH31338@noisy.programming.kicks-ass.net>
 <ZrS6uQfSfTtq96t9@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrS6uQfSfTtq96t9@chenyu5-mobl2>

On Thu, Aug 08, 2024 at 08:31:53PM +0800, Chen Yu wrote:
> On 2024-08-08 at 12:22:07 +0200, Peter Zijlstra wrote:
> > On Thu, Aug 08, 2024 at 06:15:50PM +0800, Chen Yu wrote:
> > > Hi Peter,
> > > 
> > > On 2024-07-27 at 12:27:53 +0200, Peter Zijlstra wrote:
> > > > Part of the reason to have shorter slices is to improve
> > > > responsiveness. Allow shorter slices to preempt longer slices on
> > > > wakeup.
> > > > 
> > > >     Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
> > > > 
> > > >   100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT
> > > > 
> > > >   1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
> > > >   2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
> > > >   3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
> > > >   1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
> > > >   2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
> > > >   3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
> > > >   1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
> > > >   2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
> > > >   3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |
> > > > 
> > > >   100ms massive_intr 500us cyclictest PREEMPT_SHORT
> > > > 
> > > >   1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
> > > >   2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
> > > >   3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
> > > >   1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
> > > >   2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
> > > >   3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
> > > >   1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
> > > >   2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
> > > >   3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |
> > > > 
> > > > As per the numbers the, this makes cyclictest (short slice) it's
> > > > max-delay more consistent and consistency drops the sum-delay. The
> > > > trade-off is that the massive_intr (long slice) gets more context
> > > > switches and a slight increase in sum-delay.
> > > > 
> > > > [mike: numbers]
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> > > 
> > > Besides this short preemption, it seems that an important patch is missing from
> > > this patch set, that was originally from Prateek and you refined it to fix the
> > > current task's false negative eligibility:
> > > https://lore.kernel.org/lkml/20240424150721.GQ30852@noisy.programming.kicks-ass.net/
> > > 
> > > The RESPECT_SLICE is introduced to honor the current task's slice during wakeup preemption.
> > > Without it we got reported that over-preemption and performance downgrading are observed
> > > when running SPECjbb on servers.
> > 
> > So I *think* that running as SCHED_BATCH gets you exactly that
> > behaviour, no?
> 
> SCHED_BATCH should work as it avoids the wakeup preemption as much as possible.
> Except that RESPECT_SLICE considers the cgroup hierarchical to check if the current
> sched_entity has used up its slice, which seems to be less aggressive.

Note that update_deadline() will trigger a resched at the end up a slice
regardless -- this is driven from update_curr() and also invoked from
any preemption.



