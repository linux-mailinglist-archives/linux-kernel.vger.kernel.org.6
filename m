Return-Path: <linux-kernel+bounces-406026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86C9C5A38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E928497C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178C200131;
	Tue, 12 Nov 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WE2BCxl+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4A20010B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421398; cv=none; b=pDM7UmMES2X9riJxL8FRdm1l9W2vxOoZoAYAekiuxmIBfDLWIXmPOb7OQ57BtykNODGZCEsHKzEt0vwPEXkGlLc9JlwrwLKy2K1fcHQrcTQjeX0P7F8m1tlqP3VFokpX2Rm9oCLq5qfKE1en50Ngrp2rYWl/BuVPfow3q+1HSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421398; c=relaxed/simple;
	bh=xLZH+Xfag2SN+MKIfB72pxM2G5vb0dkWWnFkhnsJMac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOBW8WwevAIc4VQkob7NZPgjdmVF/ulk0WM4k9f/HQrgZBeAXfre4okrFJJxDHRz3avloEpg3gZ4MsYgW5nZB1ics33i2UO53aNnR+Mx7iJjRfgW5X5bPREwYv2Y3iaQOK8s6lfDWeiNiL1nAjf73TKaBWIwrTtTOy6rQREgdgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WE2BCxl+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cBqRmdYnZ0uBmz3/FIRHL3M94rfZ14nksgCicJDAsp0=; b=WE2BCxl+p3TzcV/CkJxxY9N1aj
	sTDCo+70jFAXPXQYk3AFBAX+hjGHm/DTLMS5GrVVY77MxO5NJ8X/R2Am1NXa84meAkobS6NagYbCZ
	ePuLPPneEvuRQLQxpFDnSAMsu/k9q/CsZwyWuOMQnFN97h9r71xQhDv2pRNJhHnjswEVAVs5CgLgw
	GQZjUwBkz0hz4DS2T79gD767bPsUkS7ntH1x+LdKGzrfZ60t4X2vHDbP01PT43z7FxYK8vcVgDrEe
	+58yKmiVUk//BwIJxtV0c6XhTekeeEQtPvs7A2eFJ5d/UaB+EaUsYA2/Dn4b0nDWwBSn2muv1wRsV
	lZ149p+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tArnL-0000000D5Pj-0rBT;
	Tue, 12 Nov 2024 14:23:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F59F300478; Tue, 12 Nov 2024 15:23:02 +0100 (CET)
Date: Tue, 12 Nov 2024 15:23:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
Message-ID: <20241112142302.GI6497@noisy.programming.kicks-ass.net>
References: <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112124117.GA336451@pauld.westford.csb>

On Tue, Nov 12, 2024 at 07:41:17AM -0500, Phil Auld wrote:
> On Tue, Nov 12, 2024 at 08:05:04AM +0100 Mike Galbraith wrote:
> > On Fri, 2024-11-08 at 01:24 +0100, Mike Galbraith wrote:
> > > On Thu, 2024-11-07 at 15:09 +0100, Peter Zijlstra wrote:
> > > > On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> > > > > On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > > > > > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > > > > > > 
> > > > > > > I built that patch out of curiosity, and yeah, set_next_task_fair()
> > > > > > > finding a cfs_rq->curr ends play time pretty quickly.
> > > > > > 
> > > > > > The below improved uptime, and trace_printk() says it's doing the
> > > > > > intended, so I suppose I'll add a feature and see what falls out.
> > > > > 
> > > > > From netperf, I got.. number tabulation practice.  Three runs of each
> > > > > test with and without produced nothing but variance/noise.
> > > > 
> > > > Make it go away then.
> > > > 
> > > > If you could write a Changelog for you inspired bit and stick my cleaned
> > > > up version under it, I'd be much obliged.
> > > 
> > > Salut, much obliged for eyeball relief.
> > 
> > Unfortunate change log place holder below aside, I think this patch may
> > need to be yanked as trading one not readily repeatable regression for
> > at least one that definitely is, and likely multiple others.
> > 
> > (adds knob)
> >
> 
> Yes, I ws just coming here to reply. I have the results from the first
> version of the patch (I don't think the later one fundemtally changed
> enough that it will matter but those results are still pending).
> 
> Not entirely surprisingly we've traded a ~10% rand write regression for
> 5-10% rand read regression. This makes sense to me since the reads are
> more likely to be synchronous and thus be more buddy-like and benefit
> from flipping back and forth on the same cpu.  

OK, so I'm going to make this commit disappear.

