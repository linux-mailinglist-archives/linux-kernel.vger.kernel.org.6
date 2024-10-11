Return-Path: <linux-kernel+bounces-360950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07999A19F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C593B1F2145B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF09220FAB9;
	Fri, 11 Oct 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvwGVbLM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173721E3DC0;
	Fri, 11 Oct 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643217; cv=none; b=kGLznxKr4+bx1WMVF7yEFlGfNyKLALO9/xOOzs4NyKoTHA2TRm3ueTQew3Ri59MENIEqspl+zx4xCAQqoklC8SWvuN6xY3jq8z8GU3EZ4kyaWOudezZgnKpB+TeUMHlSg2XYxGFjzwY4ZQyxnnk8pCGK8NGPYQLnskcDJ0OHoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643217; c=relaxed/simple;
	bh=UwprDjCRPo53QATi/50yz4xLZs+7HmYX6Xddp6qU6ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irdF7Q6sZhiaAsvRfni05oBTBiDXOprsaL9/m3LiOrJqNv4GhXPLsJKqDHTgSB/RR7vk76xGubgBXRyAKGKSmdt/aDZQ3kLCiVSuJH17h9ANqaa9FkSOjGOodvr3fSVHI2uevEZofpEXzPw6+2Pt92zc91R4XZ+2r/t4E+qxrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UvwGVbLM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zsb/X6vWwNEkHOK+a0pqgQ7CW/JwBJKq0qJ/CteO/mw=; b=UvwGVbLMMoQEpyY50NxG4bNpmm
	KaeuOFPktD6RlmWJ/OOQWlldtyo3sg7xC5cvbjvkzMz5h2EcvKMn15FCM0azmwe084hZIYHYbZ9z1
	mCnv3TL6vMf+XaSMuiwZktkhn8utBZH5qJhb7+eUmAfInjjYO8jL1+XHTrwMixMC/D0yIKROJat7/
	YBVoeApCwuPzC0RWYuvcnZ/QuKxpb7F5SwS2CFKQ7DqZiLtcCobk6x54I9mmRNyyxv4cqgc+u06eD
	auvLrSzygi1lxAt80mE10w6CL9RG4UQj0gvTgSnCgVoHahQK45AqaUaOylAHLO/ethwop1ekHUlDW
	bbvARWuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1szD3v-00000005r6p-31Jk;
	Fri, 11 Oct 2024 10:39:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA8B0300642; Fri, 11 Oct 2024 12:39:58 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:39:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Message-ID: <20241011103958.GO17263@noisy.programming.kicks-ass.net>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
 <20241010193712.GC181795@cmpxchg.org>
 <20241011083323.GL17263@noisy.programming.kicks-ass.net>
 <20241011100803.GA331616@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011100803.GA331616@cmpxchg.org>

On Fri, Oct 11, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:

> Something like this?

Yeah, something like that indeed :-)

> I like it better too. There is a weird asymmetry between passing
> ENQ_MIGRATED to one and !ENQ_SLEEP to the other both as "migrate".

So I have a note to stare at the whole {EN,DE}QUEUE_MIGRATING,
ENQUEUE_MIGRATED and task_on_rq_migrating() situation, it has the
feeling that something could be done to clean up there.

> No strong preference for whether the ENQUEUE_RESTORE check should be
> in caller or callee, but I figured if we pass the flags anyway...

Right, and this way it's behind the static key, so win, right :-)

> I toyed with a separate branch for ENQUEUE_INITIAL. But it saves one
> branch during fork while adding one to repeat enqueues. The latter
> should be hotter on average, so I removed it again.
> 
> Completely untested. But if it looks good, I'll send a proper patch.

Sure. Thanks for doing this.

