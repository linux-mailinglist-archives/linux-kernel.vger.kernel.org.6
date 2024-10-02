Return-Path: <linux-kernel+bounces-347186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7998CF38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A073B1C21C12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F919645C;
	Wed,  2 Oct 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGU9YsIB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C361196C67
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858983; cv=none; b=l4KJuNUQ7CuC4cbrWN48DDT4WuxuswAT8X11UVnTIbIcZba9GVHKYNkCjbb/n4XIxVxKvRKPRwS2TJRhCXlLyD5mwMiI0PeJcwSX6YD0gpvwkhw1k+gNczBZRC21st61P71GFfTKAvpluhHCGmRbKscHzHCo+Sh3v8CINYxq0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858983; c=relaxed/simple;
	bh=Z3W9pITpq0sbIFI0A9BC3q6ZdGLqjWbHGQ2enl9bsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr+URHd6H3BNJdGm0klNDs2UdWtaqj6kcnJadILku7PUijgGT5eubI1TOJGiVlAk8aDZlmGrBgmx7/PgGlzYAmI3rjQNdyjzIc9X8h6IZ9p1nwFg7xRtxEWhelNk3TnSD0KXASldqBZJq+3rI87eZvn4rVT9/8M3vVDndDbt4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hGU9YsIB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7ArBZRc7vYZ5jGHtpDzZjoriCFDjp6bUpLmSZ4ec20=; b=hGU9YsIB/AsKEnL6rYFzcp3c5p
	OyEMI+ExZqWn6dtg8FN0pyXfDCNY2CfhvOhEMYfsfv40OLZBCJfq6lChOKhMqy2vEb6V0M7F/CtLZ
	xlcs6tevwQEvY8wtwNXEFjhYMDQG2E1XEwcapeZqet6xhXk2LJAZqCa4fArAeoOyIUG0iqeVo+uW2
	s6SnE5MlO0mSSReVXPjCLefNLiNjYdZ1pCVQHcKnGcDUXPnS63ejiQR8/6HagFkuPciN8p2pJtOcA
	9vxCZraCVbZW3E6HjeQBRmak2IJRgcbdU3kJurCEsyghxRCIMYPFmOIfy+nbeIdovnKVQdSKk9u4c
	bIqXny9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svv37-00000003Rzz-0pHH;
	Wed, 02 Oct 2024 08:49:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29414300777; Wed,  2 Oct 2024 10:49:32 +0200 (CEST)
Date: Wed, 2 Oct 2024 10:49:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <20241002084932.GN5594@noisy.programming.kicks-ass.net>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
 <Zvr2bLBEYyu1gtNz@linux.ibm.com>
 <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>

On Tue, Oct 01, 2024 at 10:30:26AM +0200, Mike Galbraith wrote:
> On Tue, 2024-10-01 at 00:45 +0530, Vishal Chourasia wrote:
> > >
> > for sanity, I ran the workload (kernel compilation) on the base commit
> > where the kernel panic was initially observed, which resulted in a
> > kernel panic, along with it couple of warnings where also printed on the
> > console, and a circular locking dependency warning with it.
> >
> > Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le
> >
> > ------------[ cut here ]------------
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
> > ------------------------------------------------------
> 
> ...
> 
> > --- interrupt: 900
> > se->sched_delayed
> > WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+0x644/0x660
> 
> ...that warning also spells eventual doom for the box, here it does
> anyway, running LTPs cfs_bandwidth01 testcase and hackbench together,
> box grinds to a halt in pretty short order.
> 

Right, I've picked up your patch for sched/urgent. But this does make me
question Vishal's setup.

He said all he does is compile a kernel, but afaik no regular setup uses
CFS bandwidth by default. So something is 'special' at his end that he's
not been telling us about.

Vishal, could you expand upon your configuration? How come you're using
CFS bandwidth, what else is special?

