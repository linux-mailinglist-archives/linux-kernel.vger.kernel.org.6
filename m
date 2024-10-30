Return-Path: <linux-kernel+bounces-389597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B419B6ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213881F220D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE821767E;
	Wed, 30 Oct 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDHCrnJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C621765C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323751; cv=none; b=UbavwSpqBTIff7r5qKMyjTSrgfArFqgTJwNomnPYoZ6i9474DjJ5R3PuUatoey05+2miSPglacgY/HeHL6eVEh3/h9ftIVgEU01QbKXpQgHO4tzxULEBzuwybOpmAOetgIpC11CywgW956EjW9JTK61hJ9xmW3mYehFXmtMl9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323751; c=relaxed/simple;
	bh=5gZt9WNmUg+qL7suLXuHVY3BjHl2KSf7WGO69lus+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chlEYui4kAlvnTcqV0FAJyMXeDeCSoioZxJT6KFhEa4z7M8+Nkxedr12+dE8xQaJse82DbaM2KnrifF+j4FahNn3QBLaQ/9GhiV066LDJgXbW4T5WeHEwE8K5mgbU1FrGN5lVxtDl5a2WJpbjK7/h+qPVxT6zaUSUJX2oQBEgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDHCrnJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF0DC4CED3;
	Wed, 30 Oct 2024 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323750;
	bh=5gZt9WNmUg+qL7suLXuHVY3BjHl2KSf7WGO69lus+hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDHCrnJILxnUO+ZzLf3zXyFAlRV2CUiAQAl9BMxQRBQAfnew0MjZmZ3i+1xGX8zZI
	 joDZ30+VYeR8Xh/eXnGN602mOH3MKjnTXrFfVWmJPDTo3rv9mFJhIUO6EAYCG22qGs
	 ci9AZrQPKp2krbuyYLiYb6qh1CH39YbBfRdvHZh2k5h74df9JSFPjOfOHAnSRtuVyj
	 cVjP2DSPolpaJhQpdeBbIe6AojqiRrBxT6tgoEqGVcQVl38sLLgtPfPU7coAy2m59e
	 InmOHPC9zWPIf/okWa3fLo5kqamCufDwBIiqzpUjaAkZL4gV9KkZuqSu4lBjTXhXPv
	 EjWu4vtplrr9A==
Date: Wed, 30 Oct 2024 11:29:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/6] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <ZyKlJXgXUqDpaQXp@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.711768679@infradead.org>
 <ZyKhQFuMItKsmsnh@slm.duckdns.org>
 <20241030211506.GR14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030211506.GR14555@noisy.programming.kicks-ass.net>

On Wed, Oct 30, 2024 at 10:15:06PM +0100, Peter Zijlstra wrote:
...
> > > +		if (!(queue_flags & DEQUEUE_CLASS))
> > > +			check_prio_changed(task_rq(p), p, p->prio);
> > 
> > Maybe prio_changed can be moved into scoped_guard?
> 
> It wasn't before -- do you have need for it to be inside?

No, was just wondering whether that'd make things a bit more compact. Either
way is fine.

Thanks.

-- 
tejun

