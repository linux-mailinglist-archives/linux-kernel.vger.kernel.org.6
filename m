Return-Path: <linux-kernel+bounces-400073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DCF9C088B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489EE1F21D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48F212D11;
	Thu,  7 Nov 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hL4c5O4/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709F1E049C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988604; cv=none; b=DmcZCKKmrSRyNy15N03rieWfMF7fSKDOOuKTzmcYoIoG88MZYBDgLtCVU75qN7/SKoudnELslPqToitzSkC/hYRl+sGF2xoxIfbTsAwqFaZ83eSUFWB7gfGtFWOBMFr2/NKgyTwXUaK2cmpWjCqg6gfaQhHoWMy64caU1taY7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988604; c=relaxed/simple;
	bh=tHjFq+/O19qv89wgRqbvlqo6SSp58vCEdx28oCQlBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhXFNl9HxvFxDFClsH9ATTtB1Rjy7kuSmIItlHB87NFaU0PR90zrtdoWCUg3b3+K/sDDLcy/+tcoelvysBEc3MBO0bpAkP27V1vvEDm3OxHu51P9c1XJUq7XPuHO0tQ1J0NOHSer3rLa53lYYYf1V0j3dYCX4CF4VMrWzCs5Kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hL4c5O4/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G6CNBA3+KEhWUklW0A3SaT/tzIPRGpTeEqARX2gKGac=; b=hL4c5O4/kUaatkivHjsnsEix4v
	vAHBe5F5KQGb3H70jNmYd5MCRkh1T2HgAPQteM98OCp8YEvuTCUvQ2XOOQgqWeC5Y0tNUGN8Kl9A9
	3skzym5Sr2+QFB1sOg45xPRNOAkaK2GJgDpsGvx8h/WU7xliBzuqj64mXK3E+KaL2R3yDL6BEgXAy
	IzJj1MS0PruDAE9/rMIVm2X/iagroSv0/x1wJ8W1ndtZ4Xezs/DrwrN+lHvdiKHR1uzfs6FITZI6s
	mj7lVd9s6mwFewQ/sJtCviwtxxwXYXwLSVJUIzFpxys5yVdnByp8MCqZDaxNf/6tziJSpPDOo8D9J
	EVnMbSEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t93Ck-0000000C8j1-0iQt;
	Thu, 07 Nov 2024 14:09:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 665123006AB; Thu,  7 Nov 2024 15:09:45 +0100 (CET)
Date: Thu, 7 Nov 2024 15:09:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241107140945.GA34695@noisy.programming.kicks-ass.net>
References: <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>

On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > >
> > > I built that patch out of curiosity, and yeah, set_next_task_fair()
> > > finding a cfs_rq->curr ends play time pretty quickly.
> >
> > The below improved uptime, and trace_printk() says it's doing the
> > intended, so I suppose I'll add a feature and see what falls out.
> 
> From netperf, I got.. number tabulation practice.  Three runs of each
> test with and without produced nothing but variance/noise.

Make it go away then.

If you could write a Changelog for you inspired bit and stick my cleaned
up version under it, I'd be much obliged.

