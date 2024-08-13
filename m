Return-Path: <linux-kernel+bounces-285545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81552950F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8331F2397C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69F1A7054;
	Tue, 13 Aug 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdOWw7ud"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D419DF49
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586087; cv=none; b=XG4rZcm2sbEXCGuP/M1bR+8md4tYLcv/FdrLa0SxuzNeuQ4ZAC2wOEPP8ZBije1HVCWlMaum52xhQTFx+P0axnAV7Fg11CCFlMSEjwTZZjdnqLnkaq+tYchABqJE3Ihe/y0rzEg9DKPBZDKlY/iY/UUdp6p6TCfkRAjiPu1jZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586087; c=relaxed/simple;
	bh=nOntO/WwxCV9fy+SoEOYJjYcRTxzSIAknkYzNsAqJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RocdCSRuxlCNo9HureD9D/icwmyLeeNVMUvYrd8g1GVHDvO9IY3WvBXQs7FaFXTQktXS7yrjKi4vDvnnQ9OYuvEqE/wnJ+DmamXvQwAlwjj2cqjFwQNjpQIckbeBkS6zZ0VpCr4d9ftszFY6NuLqbAZ69iJek0tkKsYkf8yIEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rdOWw7ud; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=haHenyvRZ/KMn1XkyaOu0D5kK11iw5vMq6bljv0FU5k=; b=rdOWw7udo5yx18UMRj8jDlFHMQ
	sCeScqRRsQgEwactQAwP3fR8sV5VbmXKDd1jndXHWlSJ4g/DlQ8mlx2tgBk45g2jhFAwKBucsNcwk
	N5icMTkF/vKObAvtxaXsC2DJniXVcBt6POatYFXpWzF0Lt/KFWjyXwZKfWU+wuEeSI7qCHT1nslS9
	As6enTasgcZxO6PAeuN8kOHL8+uw2rWw950jLrI9FWR9PkkMZZ6oeR2MY5yCYceddcJJQ25AurUuD
	lhqMyOzc1TMm6NrqczFbqYhZnAo59zHUIf3tutH8ew1TBOh/gNBVD8IPJmTxZMtKlL2vzCGhZ5nsJ
	yeCYVfZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdzTC-0000000H5oM-3La0;
	Tue, 13 Aug 2024 21:54:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E59630074E; Tue, 13 Aug 2024 23:54:21 +0200 (CEST)
Date: Tue, 13 Aug 2024 23:54:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <20240813215421.GA10328@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Aug 13, 2024 at 02:43:47PM +0200, Valentin Schneider wrote:
> On 27/07/24 12:27, Peter Zijlstra wrote:
> > @@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
> >  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> >  {
> >       detach_task_cfs_rq(p);
> > +	/*
> > +	 * Since this is called after changing class, this isn't quite right.
> > +	 * Specifically, this causes the task to get queued in the target class
> > +	 * and experience a 'spurious' wakeup.
> > +	 *
> > +	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
> > +	 * problem.
> > +	 */
> > +	p->se.sched_delayed = 0;
> > +	/*
> > +	 * While here, also clear the vlag, it makes little sense to carry that
> > +	 * over the excursion into the new class.
> > +	 */
> > +	p->se.vlag = 0;
> 
> RQ lock is held, the task can't be current if it's ->sched_delayed; is a
> dequeue_task() not possible at this point?  Or just not worth it?

Hurmph, I really can't remember why I did it like this :-(

Also, I remember thinking this vlag reset might not be ideal, PI induced
class excursions might be very short and would benefit from retaining
vlag.

Let me make this something like:

  if (se->sched_delayed)
    dequeue_entities(rq, &p->se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);


