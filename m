Return-Path: <linux-kernel+bounces-365097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8D99DD74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644121F23E86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5BE17A90F;
	Tue, 15 Oct 2024 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ttQ1Y10u"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C616EBE8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969719; cv=none; b=iSeZRBrRWVPTRPs/SWhwLR71nV3K95ktkUY8i36kiNahfnkyiiirsMs1sY2VpRV3Hj1h+ECM/2QtyWT3h4c3/OMNmvHTz87jAd2PHOxXe675iTNR0pW1VjYGtY5bDqUOhPoFN1rkdByciYh8WNjMjVHjxh8J8fWcDgGAub+KXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969719; c=relaxed/simple;
	bh=woZIcwezUsE6wX6Afbs8PRpZryzSNtwpEz7wJoFXfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUmmiyCz91dCRlg+Xl6hRoc7V98GMRPA01htEdvzxJz27la/hbxK2r54ViTxM2YLOmhdIJkf14ZKzp8yJ16l1NxltOSmNCYgIYgn0+kl1/PxRB9JhiIYfTCMlVXhqLzk+Davn4f41iYoaryjTJgn9N18Fg1EtQVtEDOCzvZHTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ttQ1Y10u; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 07:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728969714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qs6jusuhwrvoW+FjDM8QnlgVGy9SBNuKT+Rpjq29JgY=;
	b=ttQ1Y10uFaRLDKcIyr+45IIpuc+5hCyoefgItQPQSSzLLSL7XJwuKZ0huVkNZDCTki5Tr0
	Vt9L2astrve1g+kX8Lt9KKpIbWQ3KTO6yXArWnfUsMNd6G3KXbObbtz1RhY+18D8pPUliN
	VByOXFa1AmC4Pn1pTx8+SabA9lHgv4o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw377f2g1JnIYNSu@gpd3>
References: <20241014220603.35280-1-andrea.righi@linux.dev>
 <Zw3BcEWQQVLxcrOp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw3BcEWQQVLxcrOp@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 03:12:16PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 15, 2024 at 12:06:03AM +0200, Andrea Righi wrote:
> > @@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
> >  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> >  {
> >  	update_idle_core(rq);
> > -	scx_update_idle(rq, true);
> >  	schedstat_inc(rq->sched_goidle);
> >  	next->se.exec_start = rq_clock_task(rq);
> >  }
> >  
> >  struct task_struct *pick_task_idle(struct rq *rq)
> >  {
> > +	scx_update_idle(rq, true);
> 
> Thanks a lot for debugging this. Both the analysis and solution make sense
> to me. However, as this puts scx_update_idle() in a different place from
> other idle handling functions, can you please add a comment explaining why
> it needs to be in pick_task_idle() instead of set_next_task_idle()?
> 
> Thanks.

Sure, I'll send a v3 with a proper comment.

Thanks,
-Andrea

> 
> -- 
> tejun

