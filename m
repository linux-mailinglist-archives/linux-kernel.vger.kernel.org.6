Return-Path: <linux-kernel+bounces-415410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739E9D35B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E2283392
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4E175D3A;
	Wed, 20 Nov 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QCPqhEij"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECE848C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092172; cv=none; b=hVrSJyhF4OOZQBAArGRrF5cX8CFt8r+N3BO4nqnoZpZ1XPX4wcipBrcpsGO4n7N+U2yVjzoW2vTcV2F/KdVfFQReMWCsIi0nxzu5ucSh4LFuElRQGZmIw1vuLT35uXtIaCM7GohyqOr0LAmk29i+RheKVyBaBLHi80mXeJ3oJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092172; c=relaxed/simple;
	bh=LXj1hqHyPAaHyfoPYIfh1FdaduqmW9vj8ZYkSVAzusM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaRoxcn3u1m8A9R4ttTWJeCXo1vg9GcZBKfuOQxWf/BK1yPuSKARB7giv3TXVBBEItYJmzuz3aXS1cmXKTjXh8W0xsKH3shrRS2ZajbLeo+I+1Qa7ZBokgJI4Qgw/PHyZs0W9y6IpYG8tZ2tzt9HSwekhBlxmhZ6UDi6Bq1uD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QCPqhEij; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xzA/sMsXx59Ze9RLPhtIArvjovkbnF+3hM7gC9xWO8U=; b=QCPqhEij2bRKptLU1+L5R/xX9S
	YTsRu6nSHvC6hWS8ih2Vor4/3YPPOw+BQ3mkD4Og2anv/V9y37TqalAPlu4cYeSlewQaNhWXTyw1J
	QfdOYvaq9uT6//RjTxbF7BldPixlvhN0mqOlSxbInp4V9bEjImsfRmJ/VtI8SsMS+LICbTRtroTqh
	iOHt+8Z8uYDNFQpdxhSf/wisXY9CmVAUrVKlKFusxMSm7t0ZcDQ/x60mDuV6S342egilo67wqXZuL
	FNE0YFy1ot5mLaVX2ckgLQjwzfiUfVbqqRNudhsWOf5uNUcw5DjE671OLpc0+jftX1V5X7WImcITn
	zPbkRIwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgIL-00000000STJ-00An;
	Wed, 20 Nov 2024 08:42:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1A183006AB; Wed, 20 Nov 2024 09:42:40 +0100 (CET)
Date: Wed, 20 Nov 2024 09:42:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
Message-ID: <20241120084240.GA19989@noisy.programming.kicks-ass.net>
References: <20241119020519.832013-1-saravanak@google.com>
 <20241119092829.GF11903@noisy.programming.kicks-ass.net>
 <CAGETcx_vABsh8HgMi1rYRWmB5RhYwqGT6kKJ+9LX0HrcP8i7yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx_vABsh8HgMi1rYRWmB5RhYwqGT6kKJ+9LX0HrcP8i7yA@mail.gmail.com>

On Tue, Nov 19, 2024 at 06:28:00PM -0800, Saravana Kannan wrote:
> On Tue, Nov 19, 2024 at 1:28 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Well, if we push this one step further, why do we need hotplug at all?
> > Can't we just keep them up and idle?
> >
> > That is, if we look at suspend_enter(), you'll note that
> > PM_SUSPEND_TO_IDLE happens before the whole disable_secondary_cpus()
> > thing.
> >
> > So million-dollar question, can this pixel thing do suspend to idle?
> 
> Unfortunately not. You saw my rant about firmware and s2idle bugs at
> LPC. But yes, I'm going my part towards pushing for s2idle over s2ram.

Right, so with Google doing their own chips, I think you stand a fair
chance of making it work 'soon', right? :-)

> And even if this Pixel could do it, there are a lot of devices in use
> today that will never get a firmware update to enable s2idle. So, why
> have all of them waste time and energy doing useless steps during
> suspend?

Right, so if we really want to go do this, we should add place-holder
state for suspend, something like CPUHP_SUSPEND and document the
requirements and audit all existing states now skipped to meet
requirements.

I think it should go somewhere right between CPUHP_BP_PREPARE_DYN_END
and CPUHP_BRINGUP_CPU. WORKQUEUE_PREP seems awefully random, and the
typical purpose of the _PREPARE stages is to allocate memory/resources
such that STARTING can do its thing, similarly _DEAD is about freeing
resources that got unused during _DYING.

So the most logical setup would be to skip the entire _DEAD/_PREPARE
cycle.

> > Traditionally hybernate is the whole save-to-disk and power machine off
> > thing, and then there was suspend (to RAM) which was some dodgy as heck
> > BIOS thing (on x86) which required all non-boot CPUs to be 'dead'.
> 
> My change would also help with the time it takes to power off the CPUs
> during hibernate :) If it'll work (otherwise, we can make sure this
> applies only to suspend).

So I'm not sure you can actually skip this during hibernate. The thing
is, we load the image from the boot CPU in a state where the secondary
CPUs have never yet been loaded up. It might be possible to skip the
DEAD/PREPARE cycle, but it would also mean the image must contain the
full PREPARE resources. So if it all works, then the result is a larger
image, for a slightly faster cycle, but since hibernate is already super
slow, I don't think this trade-off is worth it.


