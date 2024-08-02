Return-Path: <linux-kernel+bounces-272855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9189461E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EB4B21653
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142E1537CC;
	Fri,  2 Aug 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9pxqs+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509D1537BA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616761; cv=none; b=fAgQFEWjMnqEI26/Rk2qxxW6RZ+3z5eCHVNK8zBFZEEDEibzWTejA/QtqZzdyxAkQe9WaWqQiWZe+JqkQxqhiJWz+E5aeHDLc+k4by+wzzTYpjWL02VIpd4IRJqqKAc7uA2TieBuRBGiYUOqUBNK/fEi92vFjxOE9RNASjCnkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616761; c=relaxed/simple;
	bh=NWE7uoEXV0DfxzcvUi3QpqZohIOZaQ4VBRlWKCrWrcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAmHo86Od04vsZ9fxflbVfEEJXeXH1/M+N8Ele7N5Naz2QtDHhRSVfP1NySazOhsi+5B27cEGxPtNIAqKGaWhp3RjVHgChgevPR30FbxkVM/jNAF/LkPopgmn87bDb8zxV+YXbeWuRu/v5F6M52hXCPpqKrOI9qKU3lvWSjYYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9pxqs+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE98C4AF09;
	Fri,  2 Aug 2024 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722616760;
	bh=NWE7uoEXV0DfxzcvUi3QpqZohIOZaQ4VBRlWKCrWrcc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=d9pxqs+ChiGcgGXRvf9OJIg3fHM3TruEF04Wf2U/v7LEMpzHRzlv7FgLNR0dj1hfG
	 ZGg1tdZ5FUJbr6oJmTYOBrPqlHII89QTle/Kob/mcdxkteWzaq2/lvnDie3igEySd/
	 3Xqje5H5QnSaxBzCTt2xZ7sQunHSMSfkE+qcXyHcFlZoqaJXkNdR4jVpWr2Jgxs6qx
	 nu2ZX97PlG2j5HM77748CV+DhMRCusEGlb6x2AIWiE8meixEXDwAIRaLFaeUCruGp6
	 xg8CjJcGBrcERwdbenmOHIqR4J9GVBrYQBARxmsXAX8OGwwqqK0xhDbPj6ybPS0R09
	 MRo3bU/+Cuo2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2889CE09DE; Fri,  2 Aug 2024 09:39:19 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:39:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Anhad Jai Singh <ffledgling@meta.com>,
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH misc 1/2] workqueue: Add check for clocks going backwards
 to wq_worker_tick()
Message-ID: <1452aae8-c8d7-43a2-979a-5b3878ddc2fa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
 <20240802003046.4134043-1-paulmck@kernel.org>
 <bc6cf2940cee5bf3414616051c821c0b17dd61b1.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc6cf2940cee5bf3414616051c821c0b17dd61b1.camel@surriel.com>

On Fri, Aug 02, 2024 at 12:06:06PM -0400, Rik van Riel wrote:
> On Thu, 2024-08-01 at 17:30 -0700, Paul E. McKenney wrote:
> > 
> > +++ b/kernel/workqueue.c
> > @@ -1482,6 +1482,7 @@ void wq_worker_tick(struct task_struct *task)
> >  	 * If the current worker is concurrency managed and hogged
> > the CPU for
> >  	 * longer than wq_cpu_intensive_thresh_us, it's
> > automatically marked
> >  	 * CPU_INTENSIVE to avoid stalling other concurrency-managed
> > work items.
> > +	 * If the time is negative, ignore, assuming a backwards
> > clock.
> >  	 *
> >  	 * Set @worker->sleeping means that @worker is in the
> > process of
> >  	 * switching out voluntarily and won't be contributing to
> > @@ -1491,6 +1492,7 @@ void wq_worker_tick(struct task_struct *task)
> >  	 * We probably want to make this prettier in the future.
> >  	 */
> >  	if ((worker->flags & WORKER_NOT_RUNNING) ||
> > READ_ONCE(worker->sleeping) ||
> > +	    WARN_ON_ONCE((s64)(worker->task->se.sum_exec_runtime -
> > worker->current_at) < 0) ||
> >  	    worker->task->se.sum_exec_runtime - worker->current_at <
> >  	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> >  		return;
> 
> What is the code path by which sum_exec_runtime could go backward
> in time, if the TSC and sched_clock() jump backward?
> 
> Might it make sense to check in the place where sum_exec_runtime is
> updated, instead, and catch a wider net?
> 
> On the flip side, the run time increments are "fairly large" in
> number of TSC cycles, while most of the negative TSC jumps we 
> have seen are quite small, so even that wider net might not catch
> much because of how coarse these updates typically are...

Good points!  Even more telling, this patch didn't catch anything during
Breno's tests.  I will drop it with a workqueue.2024.08.01 branch in
-rcu in case someone needs it later.

							Thanx, Paul

> All Rights Reversed.

