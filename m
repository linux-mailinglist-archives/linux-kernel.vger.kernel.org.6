Return-Path: <linux-kernel+bounces-414335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA069D2668
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C9E28152B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF231CCB21;
	Tue, 19 Nov 2024 13:08:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B21CC146
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021702; cv=none; b=fAJ/mXO4AcI3xKD5SGU9zKxU8U2tpN6i3sjUy9tsMrw/EHiLq7RsIneIZKun5E7O0KIzakfzoNJ1NGjp/NFJKOmt45S1BRQlSiove3NISqOoGUYXns2t2ZE8PZnsEB0i9f8ak6DZw9VYQ78TXPQSE1Z4jrmWG6TIVuVUORHbxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021702; c=relaxed/simple;
	bh=+DuU/CNyb2X1+4eDy2X1WRcvPDY3+SMoxf80Eglk4B4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcZqQyBF6b/7qm6nHwflHB8CCi7EjSAh+udxeVl6HohzalvtBJl1MSMx20qwsk5IwlZcs3gKotddrhKf7zD+y/iFReYSWuY97b1XdveYp2lwXfoLZcSIhXg8k5ubb7C7WNJ6pC89dyNPZ5/imHUNWvazEVqOGzS3eXtpqfyvn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B792CC4CECF;
	Tue, 19 Nov 2024 13:08:20 +0000 (UTC)
Date: Tue, 19 Nov 2024 08:08:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH sched-next] sched/cputime: Fix unused value issue
Message-ID: <20241119080853.58cbca4f@gandalf.local.home>
In-Reply-To: <20241119083650.GD11903@noisy.programming.kicks-ass.net>
References: <20241118111314.58481-1-dheeraj.linuxdev@gmail.com>
	<20241118153047.7e90015f@gandalf.local.home>
	<20241119083650.GD11903@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 09:36:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > The above adds more branches than just having:
> > 
> > 	if (stime == 0)
> > 		goto update;
> > 
> > 	if (utime == 0) {
> > 		stime = rtime;
> > 		goto update;
> > 	}
> > 
> > (or's "||" are branches)
> > 
> > And the latter is much easier to read!
> > 
> > Just fix the issue. Don't try to be clever about it.  
> 
> There is nothing to fix. Yes there is an unused assignment, but the
> compiler is free to elide it (and it does).

This has nothing to do with the compiler optimizing it.

> 
> Keep the code as is, it is simple and straight-forward.

I disagree from a stability and understandability point of view. Why is
utime assigned? Here's the full context:

	if (stime == 0) {
		utime = rtime;  <<<---- Assigns utime
		goto update;    <<<---- Jumps to "update"
	}

	if (utime == 0) {
		stime = rtime;
		goto update;
	}

	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
	/*
	 * Because mul_u64_u64_div_u64() can approximate on some
	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
	 */
	if (unlikely(stime > rtime))
		stime = rtime;

update:                           <<<---- Jumped here
	/*
	 * Make sure stime doesn't go backwards; this preserves monotonicity
	 * for utime because rtime is monotonic.
	 *
	 *  utime_i+1 = rtime_i+1 - stime_i
	 *            = rtime_i+1 - (rtime_i - utime_i)
	 *            = (rtime_i+1 - rtime_i) + utime_i
	 *            >= utime_i
	 */
	if (stime < prev->stime)
		stime = prev->stime;
	utime = rtime - stime;   <<<---- reassigns utime

So the first assignment of "utime" is meaningless, or there's a bug here
that utime incorrectly had its value overwritten. If the first assignment
is meaningless, it leaves others still wondering if there is actually a bug
here, because they are wondering "why was utime assigned?".

-- Steve



