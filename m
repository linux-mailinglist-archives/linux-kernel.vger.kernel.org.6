Return-Path: <linux-kernel+bounces-390215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A49B771F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BA1F24E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FA193417;
	Thu, 31 Oct 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMWdmpKY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CA1EB48
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365997; cv=none; b=MdtYjPMlkKSK4JHD0xrhfb5YBuxFhwaP6synx4yJ+njZldaSLwcTR68mHboQytkS8nhvnPqacDVC/mkJ5MXke7XcIIvBSnDNX2bO6qDy+iJFycSCHz5mYT2aebbC2aZzxSLp3euNUzXvVjbBGeKXT/23DAkR7sCEFMY/gRywBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365997; c=relaxed/simple;
	bh=xaldQxhW7oCmRcLqWy5zJTMCyvuaa8BmD2wBGHg9ljc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We1h9D60PsfAUWAih5vSzESt2DLzCDwBTKwhEEubkCZiLz8qOFQ/A3GAQFLo6xB4keKv72SyskvSVSczwUWZBTviVRHlJ1e9Z+ZVhWBUZpGukWIoxPfCf9F3bJHvELcEwSkJFbCq2470JvmaZi4Ledzb8Av+h/poxONjvCbtb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nMWdmpKY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xaldQxhW7oCmRcLqWy5zJTMCyvuaa8BmD2wBGHg9ljc=; b=nMWdmpKYIbU15Jw1QbSINxX/K/
	DtPSZxWx8kDY8ocqt/fY/uvhJl1ee3plfxZrjbXMFAfynf5/nQHXP6Vp82HEYSFMvvfJO84leyvXN
	/cg8zfCDoqNM0XEFmjCY3AlCR8YkZf5/uo0QSJTDN08aeAkpSyhZseo+CUio6tIX+TTtTfboaa30m
	5TSVR7Mmoh6yzFBDi5zQ3wqEpOGuasd3FWYuqZsdf+J4yHd8Glhc13k8YiXhQCYGMLNR11NBXCCoY
	lSOuPVtJaOpruGmYdZjJLEOO/B6N5jbb1rk0vWm38WBji+2JpEKfXsQSmbRDDHgFm9rwJeXR2aw94
	kaPPfk8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6REo-0000000EWD8-3XBr;
	Thu, 31 Oct 2024 09:13:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C756300599; Thu, 31 Oct 2024 10:13:06 +0100 (CET)
Date: Thu, 31 Oct 2024 10:13:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241031091306.GU9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de>
 <87y128335h.ffs@tglx>
 <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
 <87r080306d.ffs@tglx>
 <20241030210819.GS9767@noisy.programming.kicks-ass.net>
 <878qu5xjxz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qu5xjxz.ffs@tglx>

On Thu, Oct 31, 2024 at 12:14:16AM +0100, Thomas Gleixner wrote:

> If that's handled, then it falls flat when a futex is used as a wait
> queue. There might be a thread sitting on it waiting for an event which
> never happens, which means the old hash never gets removed. Then the
> process gets another pile of threads and can't expand the hash because
> there are already two instances.

Damn... I mean it means a userspace thread is basically stuck forever,
but that's not our problem. Yes this is annoying.

The whole requeue on lookup and hb->waiters thing looks simple enough,
but this is a bit annoying. I can probably make it work though,
however..

> I really want to start simple and let the process' futex usage come to a
> grinding halt when the resizing and rehashing takes place.

Fair enough. Lets do the simple thing first.

> I really want to know who thought that futexes are a good idea to begin
> with. Once we figured that out I need to find those who added all the
> other complexity on top of that bad idea :)

If memory serves me, it was some tall German dude that did most of that.

