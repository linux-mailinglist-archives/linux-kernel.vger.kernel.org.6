Return-Path: <linux-kernel+bounces-448935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B09F475A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B7D7A7A61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362F71E0B7D;
	Tue, 17 Dec 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vghqSsaU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21591DFE16
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427193; cv=none; b=p08zelS13sERQyvTgaKeuvGehYSh38wHe0by4hNtKnAMVwVt2QJw6jG8KzzqPfaYO7wDo5dtHyOFjpIA+8KLF+7BgEHW9ur3iObR7CXsW1odphB3Dmeoiceb6IjvUJD7bO0CAdTQ1wY4Bdij/grJl1VnVuoRmGVlogIxKD+98Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427193; c=relaxed/simple;
	bh=OUuzywE8CHloqIU0RJfp7qUpRNQcGoQYoHO73/PmFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrJVOeozL2hkHb/fYeeD4FuBcI7eq7ZncioF4kFvw5deUeAJLp7Ia2QuakpmMzYEMEcGEs37NHFVo8fc8gnnPFMzUHhOARpC5aLgUSnz9RNFfB9F8rq2dGvINGKINPVZND64dy1o6Gdl/m/5RazHe2Mx9XkkoDkmC6SnRmpqYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vghqSsaU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xCZ8fnFaYFb5nC5ZozgtceveuSSe0JXurTGbtKIVuMw=; b=vghqSsaU0BaSKHkf0SHFYuDCTV
	7pIkPhlp4HoB3ncG9yiP4eVVeHFlIW6mgO8Tf5pjFgetelmX6BbAMqTjWCctB9PsTkZXYKuNgxJRN
	uHg6uhPUkPbYMFDce5tJKNc4Lpj/iDiPuoMx6Ow6dcMxy9P2WrjPMu69IxwXitegFFXDwrad/YNPQ
	MwZKF4HWnrYrqJxzlrFbSVMDVyBDs9D+zBlaaH4mT2OUuo8suox3TRfXZqMD1W2GYR6JERWkGlMxB
	uj4TacOEtinDVmwGByMpkFn0YRLSDPDQtwYtOvR2bodw7djt7lUkuZZ0SR3NvUy7nYrjjb73q41oB
	6K8BEkMA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTk0-000000060g6-0gqq;
	Tue, 17 Dec 2024 09:19:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0B1730015F; Tue, 17 Dec 2024 10:19:43 +0100 (CET)
Date: Tue, 17 Dec 2024 10:19:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241217091943.GL35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
 <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
 <20241216165419.GE35539@noisy.programming.kicks-ass.net>
 <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>

On Mon, Dec 16, 2024 at 09:01:24PM -0800, John Stultz wrote:
> > Specifically, slide 27 talks about a modification to try_to_wake_up() in
> > order to force the task into ttwu_runnable() such that it then hits
> > proxy_needs_return(). This latter part I can find, but not the former.
> >
> > /me puzzles
> 
> So the slides actually have links to the code at that time, which
> should be the v12 series:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v12-6.11-rc5

Oh, no the reason I looked at -v7 is that I thought it was the most
recent one.

This github piece of shit lists it as the first 'proxy-exec-v7*' in the
branch pull down with earlier version below it.

Only if you scoll down further (which I didn't, because why would I),
you'll eventually come across 'proxy-exec-v14*'.

I'm looking forward to the day where the web implodes under its own
incompetence, urgh, web sucks.

