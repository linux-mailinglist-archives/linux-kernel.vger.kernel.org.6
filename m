Return-Path: <linux-kernel+bounces-317362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81C96DD12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA65B20C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B4126F1E;
	Thu,  5 Sep 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHbw8TcM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7F61FFE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548418; cv=none; b=d4jU9emtRvx72MjSGkV2MFCIcSaaZgulLP8ktggwIS1l+U7T8NRNyqJ+dFz4bJLo8SNl6Q+cgUxukSp+5IhYqQ89N6jjN46R2KqyY6dQKv5pepZGQG1V1zH+3+4OxKwYJBZDO/G6VdkKeToGTFnfO3TGPkXUm00pjb9hvWyK3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548418; c=relaxed/simple;
	bh=/Om5JQEN1MDMTszU6+n5rrCoTrswg7FUbLZS1sBERO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUrZyWX+2Oii21RY6U811vTZarNiPiP7K9kN03s/Xu7naMeo3Iu8TT93mTRQOYzpbmqwZcVptfCL3r08JYIiDDtiTB7VcyjNv/GmGNc94bdyQJD0TRSL3dEJFpmkpmwRBdQBdkKKF9iAQcK654W9DX+A9sDZC+AdwFlBDKXWRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RHbw8TcM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lXp9LvNk4O+h8/7i8pZgOZHOhKIKwqlhJBsD9NIMphg=; b=RHbw8TcMMqfg9PfH9TkQGajMhG
	4u7Sz7lgh0jUQiE6ZWPEXPoH3qdEZ8jmoAGDQ9X+PE4sJhVow67DFpEXHddci65PGKNvJfOETferL
	fFut9rqvCfTUcTT64TOTSR6IpE+P1vDwUY7iw6iktnVfW3R8WvtZrsycZqLfaP/O1jsaKGq4GMtfT
	VMMz+V+SzyUXryXP3gwT8QVBiUkF2MVAu6FM69kZl6iNQ8qXhhvi3gBokifW0rRq5Ufdf5Loj0Sis
	ZVOjoekjEeJC28PE3yEzImmJiNfGqcZBbLezIVBSl7ao8Nt/XsT29zpEV+mhSNZXmJGrh83fRZ0SY
	Rsc7Tu0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smDy0-00000000VCh-1vhn;
	Thu, 05 Sep 2024 15:00:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E8EE300599; Thu,  5 Sep 2024 17:00:12 +0200 (CEST)
Date: Thu, 5 Sep 2024 17:00:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <20240905150012.GF4928@noisy.programming.kicks-ass.net>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905092858.GA15400@noisy.programming.kicks-ass.net>

On Thu, Sep 05, 2024 at 11:28:58AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 02:47:03PM -1000, Tejun Heo wrote:
> > sched_ext dispatches tasks from the BPF scheduler from balance_scx() and
> > thus every pick_task_scx() call must be preceded by balance_scx(). While
> > this usually holds, there are rare cases where a higher sched class's
> > balance() returns true indicating that it has tasks to run on the CPU and
> > thus terminating balance() calls but fails to actually find the next task to
> > run when pick_task() is called. 
> 
> Oh cute. Which class in particular did you see this do?
> 
> Looking at balance_fair() / sched_balance_newidle() I suppose we could
> verify we actually have a runnable task once we've re-acquired the
> rq-lock and have pulled_task > 0.
> 
> 
> Tightening all that up would probably be better than trying to deal with
> the fallout like this, hmm?

Something like so. Haven't yet looked at the rt/dl classes.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11e890486c1b..7db42735d504 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12716,6 +12716,12 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
+	/*
+	 * We pulled a task, but it got stolen before we re-acquired rq->lock.
+	 */
+	if (!this_rq->cfs.h_nr_running && pulled_task)
+		pulled_task = 0;
+
 	/* Is there a task of a high priority class? */
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;

