Return-Path: <linux-kernel+bounces-235341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2626291D425
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809F5B20CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6E4F215;
	Sun, 30 Jun 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3u99lx8"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF847F45
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719782628; cv=none; b=ZOVcJGv4yg1DchMPJxNC7DVY872tBD9EEsYLOaTGu3FbjA5/jgwAP28dqduBYMoee218Qg99LfSlIjdtw9otPs34aXQ0Sbrs3AjDHhopSXE0ZFHslXJGzyUyupVXJGe/IBkLqC3d9nUHfs3COOowYi3E2EjwXBQ8b8Cy/Hbk2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719782628; c=relaxed/simple;
	bh=JJTuu1sWsYDev56XikH1r33QPHpaFF9DT3ePd1OQ0Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGAJckr/hJSQZgyxRtdbfTZhnSZWe/JM5p5va+cvNfs2APVQh/lH5vgEy9npg6ljx5v4LLxr/4Cw4NcZRwP6Z4EPgfHs+EEMw0VDnF6ThSWzpN+K+6n9tbaFA0NjJ86gT8+O6JKwJyTRbVOuj6GVqL1DnHLh2tfPJuoKBUjRDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3u99lx8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719782622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwZu+DYrvPNuzMDQDuXNen/RSGsuSARLPGQMCx00z7g=;
	b=A3u99lx81rj3ayx3okFvXY7c6fdHCYXrLcdo1scJErG3AmHcK1DJNur53uHhN4PyN9RE8/
	hr9sKKEuXZfKuUoGV5ZKUApnvPo/5PbbqwYB1ydN24QMtV8w5Gn1XpKOoNoN1NIRl312H9
	WhoSZ66OI+Dz2DgG6yZL1t+8DWNAmBM=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: bristot@redhat.com
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: klarasmodin@gmail.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: peterz@infradead.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: surenb@google.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
Date: Sun, 30 Jun 2024 17:23:36 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <jvkmjjqfo6w4arluq3ggwilfwucvg5ra273ziq5ov2e2hnrtck@x64ksn72qi3u>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <20240628094944.QwcHkf8J@linutronix.de>
 <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>
 <20240628195553.G48MpeQ6@linutronix.de>
 <w2qopormdwuh54vropw6sgvadnivjnrgvmpurud2cu6nannfj3@xxrs2r6qt7zi>
 <20240630211142.kZAs9f0p@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630211142.kZAs9f0p@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 30, 2024 at 11:11:42PM GMT, Sebastian Andrzej Siewior wrote:
> On 2024-06-28 16:20:27 [-0400], Kent Overstreet wrote:
> > > Kent, you said you didn't want it where it currently is. Fine. You said
> > > you want it at the front next to `flags'. This isn't going to work since
> > > there is no space left. You didn't make another suggestion or say how to
> > > make room.
> > 
> > It doesn't need to be on the exact same cacheline, just as near as you
> > can get it.
> 
> the first possible thing would be somewhere after the scheduler.
> However, what difference does it make if it s two cache lines later or
> more?  I don't understand the requirement "closer".

take advantage of CPU prefetching; CPUs will bring in more than just the
cacheline you touched because 64 bytes is small and it's cheap to fetch
from the same DRAM bank while it's open.

