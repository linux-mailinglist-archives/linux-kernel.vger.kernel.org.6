Return-Path: <linux-kernel+bounces-424532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A909DB572
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BAD1678C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB49B18A950;
	Thu, 28 Nov 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbnLov5L"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D199143725
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788956; cv=none; b=cBx2OX+kNbsyoNBcUUzjFuYZszBA/LEc1XByzSPHfEpefcXeO9fiYgqw++Fb9ZLEOOMv//mGW8l9u1y+ruEYc0RndidbwsXvVOKF9DazxQHVaYR1qxeGIuRlzzzuRxG75DPWQvEb3TMPLM3bhY6s/rsOSK57mJNjRIsv0adWHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788956; c=relaxed/simple;
	bh=7Nr9UIEVV+XzhExgqwiEzpB0WV8vLl7DC6JdbT+ioQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffpDEQ8kOTeWwVM6XQyCXO2aqrl2MgLzbi5tjvUWkUnVkmzTGlRtfIBd33XL75Jr2LlBSfaVzGG+t+yjmN0lraVsitFqksJR2+0nRjpfmdP7GWRrfsBIIk30UPIBpbYSnNDGgzYyn5zZ5MBPY4dSATT1NkBrCgkq9iNShBTSExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WbnLov5L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0vZ9oVjB8dTpIZcQ2036EY8cTa44ff4rYb+HADHRyoc=; b=WbnLov5L5u90s0DgFd8lUCYbZw
	rHFjN4s9fM3u6OE1BjqUcTq/8iyt85bPpCGmtC4uwbQDGQz/mTOtvYzgBWo4cmif44VOd/990B246
	jUYLlnA1+ASN+EXGcYPJSq07V+Be+3l/O4WMuAkLiBZrDOt4AxVAmSYJkWDq59Nf+DKirkGJy48di
	BrGo3NKWydOsOQltYupfiKb+L7iwNQmDKzsSGoCJ2SLn5zy3SLSc+fZar14tJOrrNq7T6jjenZxHo
	S5NStmGyuqo5Bvtgwi1lnsYIWf/cIGOZCYZNsTHChZw4bf7T4jmWIqLwEOK3tkFzOa6gMfkvDQOMA
	5jBbxnaw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbYr-00000001aNs-3tk5;
	Thu, 28 Nov 2024 10:15:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8882E300271; Thu, 28 Nov 2024 11:15:49 +0100 (CET)
Date: Thu, 28 Nov 2024 11:15:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 7/9] sched/fair: Do not try to migrate delayed dequeue
 task
Message-ID: <20241128101549.GD24400@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-8-vincent.guittot@linaro.org>
 <20241128094936.GA24400@noisy.programming.kicks-ass.net>
 <CAKfTPtB5LaZf6joAEDePxudi8kU_4vxZ1Was9VZjF+t+btzaXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB5LaZf6joAEDePxudi8kU_4vxZ1Was9VZjF+t+btzaXg@mail.gmail.com>

On Thu, Nov 28, 2024 at 11:03:44AM +0100, Vincent Guittot wrote:
> On Thu, 28 Nov 2024 at 10:49, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 28, 2024 at 10:27:48AM +0100, Vincent Guittot wrote:
> > > Migrating a delayed dequeued task doesn't help in balancing the number
> > > of runnable tasks in the system.
> >
> > But it can help balance the weight; furthermore, by moving them to a
> > lighter queue, they'll get picked sooner and disappear sooner.
> 
> When groups are not overloaded, we don't compare load but only running
> tasks t balance them across cpus
> 
> It's only when both src and dst groups are overloaded that we look at
> the load and the weight
> 
> >
> > Perhaps make it: p->se.sched_delayed && !env->sd->nr_balance_failed ?
> 
> So we could take into account which type of migration with
> env->migration_type == migrate_load

Yeah that makes sense.

