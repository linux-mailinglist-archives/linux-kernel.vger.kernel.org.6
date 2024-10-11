Return-Path: <linux-kernel+bounces-360753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE83999F18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4751F244EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB320B1F7;
	Fri, 11 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i56+gmSo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3019C57C;
	Fri, 11 Oct 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635622; cv=none; b=TjV02A7SPLE1L8UI3aL231X0ABphc+7tv/6y3jalJpPr2Z5l6EaMMs9etdM9uS5bmAox7vdVUsJthMKjlW8+k/AFVAvRGUBRuklIdmhUpsSXiwJcwIBjkZSacVm4h5TasTtLzWXQoYsMGAuP+uWoD6HFc61c3J7Q1fVhtAFwTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635622; c=relaxed/simple;
	bh=m0sAck92rlajrSTRVXAnvXqyywg1btrM7vMF5bFH5OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiFr6lFPCuvehCvfGJd/ASQ2oWA9J/Bqdhwxgp3WV3YzAPswPMdH2NxJb0/WXQdZMQ4Hu0clhcNFFPE/ej2htbtGnlWTC4b9sWEbqX3fTIWE1pGIG4RjvnieXlazcHd5bVXB55IODzZuIf5pLa+dlPWtpsAAN1vwIpZvopNij1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i56+gmSo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m0sAck92rlajrSTRVXAnvXqyywg1btrM7vMF5bFH5OE=; b=i56+gmSoWXKszYbC8vtDaZESmh
	ARgxKgiHCHne97axQQXxLvArCiBWTI2RAhPALr0+kS4NYAgOykLkiaj8J645jiEtaG1VH86frDLKG
	4N09Bt+RmWwUqP5Py08j8b6kEy03uJU1trrOWj2LV3Y8BJ+U+ywLo2wxe7+VCO6WqilHPknW7GckB
	o61fx8XcHMZVyrqFVhXHi8Hnd2fMory6nR9O+pSyF0Fy1luS0xIBcYBdTXoOMFYoQTc53IRRFVWVw
	OL7GkG49/SBJTjafBH42Od4Yy9Rehf0cpEcU2eMTzIyk/BzyhFP/8aH2Pbi5q0rI83/2SIjrJkJS5
	BgEyMGwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1szB5P-0000000AHQv-0zgD;
	Fri, 11 Oct 2024 08:33:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 26677300642; Fri, 11 Oct 2024 10:33:23 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:33:23 +0200
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
Message-ID: <20241011083323.GL17263@noisy.programming.kicks-ass.net>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
 <20241010193712.GC181795@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010193712.GC181795@cmpxchg.org>

On Thu, Oct 10, 2024 at 03:37:12PM -0400, Johannes Weiner wrote:

> This would be a replacement patch for #2 and #3 that handles migration
> of delayed tasks.

Thanks!

> It's slightly more invasive on the psi callback
> side, but I think it keeps the sched core bits simpler. Thoughts?

I wouldn't mind if psi_{en,de}queue() get the full flags argument in the
future. For now the one boolean seems to work, but perhaps it makes more
sense to just pass the flags along in their entirety.


