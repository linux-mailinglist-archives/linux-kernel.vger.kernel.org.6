Return-Path: <linux-kernel+bounces-312543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE449697EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A1A1C232BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB91C7670;
	Tue,  3 Sep 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EC0eFkri"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1F1C7662
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353705; cv=none; b=IHETIM+G/jpMlMHRhNYq9I2N8eekZiDb+93KKrNSBG8BkqUtntFs//Iw9ioJueC/j9E219ldZxeWN/gNI4PzAG05dcgg9k/fEaJDyTxHSiI4jU5UoAZncYE/Cx5lRDihICJFL+YL9QftKiKCPwILUZ5AI1q0G6pBtCxmddcJcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353705; c=relaxed/simple;
	bh=VQpEqB8sfiUpkwf3VCj/Q/HUVt6b9qZeSUA/HzLzH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmn6leBrGsupbTrlIXZ8CVN2hELR3N3QWbMWPmOUc9jI5OXBYg3zvXJch7zeom0yiVWhcTOePQ/uR+7kGyyK+9DCVgeOj/aRSaYRnl92WV1wF9eOegBNCmHjpjLBt1raSU3iXOeU6DrM+OguZyJrSzPgY3cEtkw5hA3zeAFoAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EC0eFkri; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qtkcbQwLM0CdSStH7EBONAFFspkfszGotCfCSr10ReU=; b=EC0eFkriiU8m7sBDdRJ3K5BMyU
	IRUQG736MdTjcrXgfUZSEegI2yZq03cmKpS0mlYQcqO5miijpdN9I9Xz/ut34a92H6X+HjfQ/mZmH
	GSeKGdi1IhcLftgFb+XPXWFMeVgcg7Rlaa9VNR6NxAw7UkXCQUoW0zGk8YNeEb4bgupNDp1wAWEJ/
	WGCDFUqIbg4MJcLeRkaWzx39LKCWmU8WQ0pvtWHyo/rSdYYFxEN5lxzRi+GsIJ620ieaEOqagh2NM
	g9rxWFBObWVHxdJNsHJLyyxpZ57T4IciIRDN27UhlpTozFrjWguldVKvyAMmgwCO3/IVqEM/40+8f
	B3BQdRrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slPJP-0000000CIDi-1Vgj;
	Tue, 03 Sep 2024 08:54:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07222300390; Tue,  3 Sep 2024 10:54:55 +0200 (CEST)
Date: Tue, 3 Sep 2024 10:54:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on
 AMD IBS
Message-ID: <20240903085454.GR4723@noisy.programming.kicks-ass.net>
References: <20240830232910.1839548-1-namhyung@kernel.org>
 <20240830232910.1839548-5-namhyung@kernel.org>
 <20240902091232.GB4723@noisy.programming.kicks-ass.net>
 <CAM9d7cg-7USE-Ofusc1VDpr3qtviX4xZmoKmBjmEfBDw9XJ+nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg-7USE-Ofusc1VDpr3qtviX4xZmoKmBjmEfBDw9XJ+nw@mail.gmail.com>

On Mon, Sep 02, 2024 at 10:30:19AM -0700, Namhyung Kim wrote:
> On Mon, Sep 2, 2024 at 2:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Aug 30, 2024 at 04:29:10PM -0700, Namhyung Kim wrote:
> > > While IBS is available for per-thread profiling, still regular users
> > > cannot open an event due to the default paranoid setting (2) which
> > > doesn't allow unprivileged users to get kernel samples.  That means
> > > it needs to set exclude_kernel bit in the attribute but IBS driver
> > > would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> > > we want and I've been getting requests to fix this issue.
> > >
> > > This should be done in the hardware, but until we get the HW fix we may
> > > allow exclude_{kernel,user} in the attribute and silently drop the
> > > samples in the PMU IRQ handler.  It won't guarantee the sampling
> > > frequency or even it'd miss some with fixed period too.  Not ideal,
> > > but that'd still be helpful to regular users.
> >
> > Urgh.... this is really rather bad. And I'm sure a bunch of people are
> > going to be spending a lot of time trying to figure out why their
> > results don't make sense.
> 
> I agree it can be confusing but there are use cases where regular users
> want IBS information like memory data source, data address and so on.

Sure, but I'm a bit worried about users not being aware of this
trickery. This makes IBS events that have exclude_kernel=1 behave
significantly different from those that don't have it.

At the very least you should kill the IBS forward in amd_pmu_hw_config()
when this is active. But perhaps we should also emit a one time
KERN_INFO message when such an event gets created?

> Also I realized that software events like cpu-clock use the same logic to
> discard samples by privilege mode already.

Right, but everybody expects the software things to suck :-) And they
always suck, unconditionally.

While the IBS thing only sucks when you use exclude_[user,kernel]
things. Stealth suckage is bad and enrages people.

> > I realize that having entry hooks to disable/enable the counters is also
> > not going to happen, this has a ton of problems too.
> 
> Do you mean kernel/user mode change hook?  I guess it'd be too costly.

Yep, insanely expensive :-)

> > Also, that PMU passthrough patch set has guest hooks, so you can
> > actually do the exclude_host/guest nonsense with those, right?
> 
> Oh.. this patch is about exclude_user/kernel not host/guest.  Anyway
> it'd be great if IBS could support the guest hooks and allow the exclude
> bits.

Right, but since your other patchset about disabling exclude_guest
because IBS don't support it I figured I'd mention that it would be
fairly simple to fix.

