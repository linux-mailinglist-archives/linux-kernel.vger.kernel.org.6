Return-Path: <linux-kernel+bounces-318015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212196E72C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197881F24311
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231122315;
	Fri,  6 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVdPJwKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D1208A0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585434; cv=none; b=rikS6EeIkBZ6kBZnzgp1/Y5vJKjBOnnXz49VvuVTRFeAOTWyCZHPjsg4X9TdgAkTtDxbMGU27kgVIhQ5QZMlJeFo5XgP4Mesc4OID+qf//06yCTvX32YgJSKOrBbnXfM6HshsrwaH2Ur3mEOCK1lGrd7yiEf2nc07NVe1ZsiQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585434; c=relaxed/simple;
	bh=oMKTdOMh4Q+8QWUs2vKScAQiNmbGRNHHRfDB5Jo8Rko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLM2WcdMs4K4VmGL8dIlxiDs7nxEaPdF11dzcADRLLGLK7TwMnD2l+kOQvr0IGyK0CzgS9ZWoW8ivrLpmhjsnNiivaS1z+oCI+L9G6wLcOvuZdcd7BqajOwB0upsJLk9aDFq5ZYIh2zdHR2bJpXtTsgl9PZnKU5iwZFqdywkHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVdPJwKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157C7C4CEC3;
	Fri,  6 Sep 2024 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725585434;
	bh=oMKTdOMh4Q+8QWUs2vKScAQiNmbGRNHHRfDB5Jo8Rko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVdPJwKGJG5XedwbZFH22j2uw43P3sNs219uA7z8VX2tLpfooOsHzoqzHE8Gs0zZE
	 N2uzin4LJnKsa7pkpAWD1VyRuBgn5AoLtc9SCVn3rpLDtIvfIBV5VbPfp9n7sPos30
	 2x04YYdIPMvakVHz8cNGrMyL71hJ0qPsXCwKDlnKqr+wPLsPAzu3l2SN5SenMY0Wsh
	 De8SF5YLMhBJGgtGaqVUUqJxwBIdTi3IgF01R2sV2FDiWpLuaNsQD0ufGm5l+I1gUk
	 Cio4ZLxIGULbq85WmMD07k5SckE521XpMiASbLAQAbDpv6u378fKrwEWy9+6EcVR1c
	 Q3zQbAwf/kB/Q==
Date: Thu, 5 Sep 2024 15:17:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <ZtpYGQ73WQcb95Fe@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
 <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtnfRnmo-EpWKcyC@slm.duckdns.org>

On Thu, Sep 05, 2024 at 06:41:42AM -1000, Tejun Heo wrote:
> > @@ -12716,6 +12716,12 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
> >  	if (this_rq->cfs.h_nr_running && !pulled_task)
> >  		pulled_task = 1;
> >  
> > +	/*
> > +	 * We pulled a task, but it got stolen before we re-acquired rq->lock.
> > +	 */
> > +	if (!this_rq->cfs.h_nr_running && pulled_task)
> > +		pulled_task = 0;
> > +
> 
> Lemme test that.

Did a bit of testing and it seems like it's mostly coming from delayed
dequeue handling. pick_next_entity() does this:

	struct sched_entity *se = pick_eevdf(cfs_rq);
	if (se->sched_delayed) {
		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
		SCHED_WARN_ON(se->sched_delayed);
		SCHED_WARN_ON(se->on_rq);
		return NULL;
	}

rq->cfs.nr_running includes the number of delay dequeued tasks which aren't
really runnable, so it seems like balance_fair() saying yes and
pick_next_entity() then hitting a delayed task. Maybe the solution is
tracking the number of delayed ones and subtracting that from nr_running?
I'm trying that but can't get the delayed count straight for some reason.

Thanks.

-- 
tejun

