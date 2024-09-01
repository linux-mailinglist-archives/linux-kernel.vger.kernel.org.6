Return-Path: <linux-kernel+bounces-310131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE15967553
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035ED1C20E52
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189431420A8;
	Sun,  1 Sep 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjCrvpGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3E748A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725172665; cv=none; b=thEG2N+xkXrteGnNUpueuikgxDWZ++jIPMlUdaXbzXpgy60AVhu3b1u8EbqGvMkngLGrPWE7s2G3Vl6qLLYJVbEw/hGz1UpfRtQUGdTB0AOSqtTM3Zos8UeHP8aGuyCfda/loWrNVBXpSDEK7FHPE9xCk2q/ZyzhK+cUx0yhFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725172665; c=relaxed/simple;
	bh=YTpC/TIiad9U2QDxYGT39G3AcvYMbOXyGx2BdaYU31Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo4Set4+GgFqE55/uU1a+DcS8Aoq/lcWsR2jYnt3hFFjBnZYvBKIqL1b7aod0Qyc9E3Bkz87IB2RSmLbc653OgAVFQhlnN4WDEj8cY/UhuVUSeOn0fdWXj1DAWODlIkj7VmlD+1Fha37PPZvQ59nlGYz/I7SGt8+fCrLj6Knbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjCrvpGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88847C4CEC3;
	Sun,  1 Sep 2024 06:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725172664;
	bh=YTpC/TIiad9U2QDxYGT39G3AcvYMbOXyGx2BdaYU31Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjCrvpGKaff97Iv0y6lr8x2VZbvM3LfOCPQBcOUxWr7Y9SkSz7o/5idjbkeqgRieH
	 0hlEytK1HhVjtR3oV959U3ngBjhh3CmOblVFS0qyMcAU6H6I/L/YfY1NtcA1QSlQqI
	 Zuo1C8MT2DuivJmZM/tChXQBFOJmEeVb9KmqHcLgh708Cvv9IwBpKRdO8ERokF+lbw
	 8FBfbOzG9Bp3mCgds1X8ur0duPIpzK8Zgb1UqU7weHRqjW7Ec+gcaTcztkFJV+rSHI
	 bHBbFGYMWKtxITGNFWXjmHcVop86gxVmkKpEwhKd+nxEC1S/kuvsPzLYpeka2Fqtrt
	 ZahAY0aQhDrJg==
Date: Sat, 31 Aug 2024 20:37:43 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Reorder args for
 consume_local/remote_task()
Message-ID: <ZtQLt-rLQfeAtypd@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-7-tj@kernel.org>
 <20240901014000.GG70166@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901014000.GG70166@maniforge>

Hello,

On Sat, Aug 31, 2024 at 08:40:00PM -0500, David Vernet wrote:
...
> > @@ -2265,7 +2265,7 @@ static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
> >  }
> >  #else	/* CONFIG_SMP */
> >  static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
> > -static inline bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq, struct task_struct *p, struct rq *task_rq) { return false; }
> > +static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
> >  #endif	/* CONFIG_SMP */
> >  
> >  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
> > @@ -2286,12 +2286,12 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
> >  		struct rq *task_rq = task_rq(p);
> >  
> >  		if (rq == task_rq) {
> > -			consume_local_task(rq, dsq, p);
> > +			consume_local_task(p, dsq, rq);
> >  			return true;
> >  		}
> >  
> >  		if (task_can_run_on_remote_rq(p, rq, false)) {
> 
> How do you feel about always prefixing src_ and dst_ for any arguments
> that refer to either (with any @rq before @p implying current as this
> patch proposes)? In this case it's a bit confusing to read because
> technically according to the convention proposed in this patch, @rq
> could be either curr_rq or src_rq in consume_dispatch_q() (there's no
> @p to disambiguate), and @rq could be either src_rq or dst_rq in
> task_can_run_on_remote_rq() (they both come after @p).
> 
> It's pretty obvious from context that @rq is referring to a dst_rq in
> task_can_run_on_remote_rq(), but it might still be a bit easier on the
> eyes to be explicit. And for functions like consume_remote_task() which
> take both a src_dsq and a src_rq, I think it will be easier to follow
> then the convention.

re. these arguments, there are largely two schemes - one coming from sched
core and shared with other scheds where the leading [this_]rq denotes the
current / local rq, and the other internal to SCX where more parties are
involved - this_rq, src_rq and dst_rq. While the latter situation may not be
unique to SCX, it is a lot more pronounced in SCX than other scheduling
classes as migrations are integral to how it works.

I'm not sure about applying the latter naming scheme to everything. Where
SCX is interfacing with sched core, I think there are more benefits in
following the existing naming scheme. This means that there are going to be
places where the two naming schemes interact, which is what this patch is
showing - consume*() functions are following the sched core scheme as
they're always used to pull tasks to the "current" rq for ops.balance() -
it's still doing what balances do in other sched classes. However, the
helpers that they use are more generic and flexible ones which are going to
be used for SCX specific things such as moving tasks between arbitrary DSQs.

That said, the use of @task_rq instead of @src_rq here is just confusing. I
will rename it to @src_rq.

Thanks.

-- 
tejun

