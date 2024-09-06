Return-Path: <linux-kernel+bounces-318500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB096EEC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882DF286057
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB161C7B73;
	Fri,  6 Sep 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrC1BctU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C714AD02
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613478; cv=none; b=YZ67axi5qNuSGW3w79gnOkb0YTcUPNf15MtYrFdWe0P7rrNxduERW53uX2P3kbL6tf1whhOJF9SAAj858HBoM6gBeWI7nUG7fkUNV0PQ84rOvKmKQK454Bt+aImrzhhnWCRgTez368rpqCCNeWEjJljz/tDxnzK+1211ir7suhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613478; c=relaxed/simple;
	bh=B497wLt2ssybD9uJU4DGGl+hO6F5Bn8pmYWMZSWCJds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTo84NhlKvH8OIx8cun6kTA0DpWbRgsDw3upkQ4ax6GJoete/VgpJyn6uSEqa87PGBCmD8P+oaZAuQhgkmr4rlvxI7Y/B8rljC1lhlDyZ18Nj5nAej6RldZy9Kw+pKf6J2o/y+X7cXnZJjXBB9oiCQh7RMee/kqjyNm82WiqJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UrC1BctU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TrlHxR1jRMFGe1uMPDdSvo212z3cM9yHy4/c2tNOpFk=; b=UrC1BctU15E3CSynEb3sqI291g
	oFPCx8ZE3dNdsGMfsrOI3vh+enUhgHV589qylUJPgxdZOrRTrZi1Jq3snHP+68Gf+QrbHwMhU6yJv
	3BbOsu0xKVPKAUPbo40kVIFzLG4ei6qDHNm10ycE7OiztiFR2ctHt2XTtg/n2Yf46m0GqEC6MGukz
	iMF57ECWrjklev4jGsH7TjHFcQA4tEcxDm+5xXNkuUcHUiGTpWTY3t9mQlNo5gWfKtZoNhV4OFgJB
	HuPARW6DQwvodDZN0KKp+wPTSVMglR9Loss03TfcslL+aNDjLKrhQMxEpNWg++eOHQalTov3/6idL
	wKz5S5xA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smUtB-00000000dB1-1VYG;
	Fri, 06 Sep 2024 09:04:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 03E313003E1; Fri,  6 Sep 2024 11:04:21 +0200 (CEST)
Date: Fri, 6 Sep 2024 11:04:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <20240906090420.GU4723@noisy.programming.kicks-ass.net>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
 <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
 <ZtpYGQ73WQcb95Fe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtpYGQ73WQcb95Fe@slm.duckdns.org>

On Thu, Sep 05, 2024 at 03:17:13PM -1000, Tejun Heo wrote:
> On Thu, Sep 05, 2024 at 06:41:42AM -1000, Tejun Heo wrote:
> > > @@ -12716,6 +12716,12 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
> > >  	if (this_rq->cfs.h_nr_running && !pulled_task)
> > >  		pulled_task = 1;
> > >  
> > > +	/*
> > > +	 * We pulled a task, but it got stolen before we re-acquired rq->lock.
> > > +	 */
> > > +	if (!this_rq->cfs.h_nr_running && pulled_task)
> > > +		pulled_task = 0;
> > > +
> > 
> > Lemme test that.
> 
> Did a bit of testing and it seems like it's mostly coming from delayed
> dequeue handling. pick_next_entity() does this:
> 
> 	struct sched_entity *se = pick_eevdf(cfs_rq);
> 	if (se->sched_delayed) {
> 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> 		SCHED_WARN_ON(se->sched_delayed);
> 		SCHED_WARN_ON(se->on_rq);
> 		return NULL;
> 	}
> 
> rq->cfs.nr_running includes the number of delay dequeued tasks which aren't
> really runnable, so it seems like balance_fair() saying yes and
> pick_next_entity() then hitting a delayed task.

Duh, yes.

> Maybe the solution is
> tracking the number of delayed ones and subtracting that from nr_running?

That came up yesterday for something else as well. Let me see if I can
make that happen.


Anyway, I suppose you keep your patch for now until I've managed to sort
this out.


