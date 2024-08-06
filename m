Return-Path: <linux-kernel+bounces-276830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD79498ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09332853DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2914901A;
	Tue,  6 Aug 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxGIsqQb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF678C8B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975535; cv=none; b=CQJ70t1tDinHWlPjQB5IRShAwIWr627n2uz5T+dNEnWNV1tpnzDSx9hfvPT5oCIBEiK+0qk/1wnHtr6QPHnGwdb9ksmTMjAdJIxTGirU9Eieoed9auWjVxEZtMvuRVpduDz1vn52qkDzpzEjNFbon5VCC46s2VKQdgTYuNMSLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975535; c=relaxed/simple;
	bh=QILZWBSRP6Ol78dEz9h+B6v4FoCeJflsetn/bbi3Ljk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfoJ6z9ay9oCN09tbd92Qt5vbVOb9lIGDOHhMDhRpCP4GMxg4BUwNmg7+/E3+0Uphbu8QOKBh/cVoWVkQ7uZEWT5vCU3whr/nBGSFGz5h/aq+iSj+nJ8af6Q4IVkzoNuHT6xQgo4kWM5zhqo78G54zCVjawc5D6df2tJTqnikG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxGIsqQb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/mTPKpbvCBoHOXmYTX8EkdXEovN5m1wPdieemPEOsw=; b=oxGIsqQbi12URvbDtjHVw4Zkq4
	QcehRtpeGh2+t0QtYHIn1tR/x31crLyEyVh7VLnWWRnXFLPO3SrX0AQ0pDV7rGnt21w7B/omGUqii
	3uu/aDbYu5pbZDaqx+FYGuOeY2HTpK43CXsjVQPjooHCEDgL2dMVPH39P8JCZO2r7ILCRIvwOeLBZ
	+lqsmoxVxsXB+UjgU7TSlh4c2tb9UcgIrqeCAzW5xn+3+jYGZlW9kUJ4DjESL5B7s2CBEpG9y7mBn
	nADLyCzobD7R3DdR+hDp3Dlr0S7XoQAKOUz+svyS0ItRrHzdf+tCCTcK6XYTZhVnRSc9tnTIOsUKa
	0rNB5yhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQdr-00000006WQm-0Bsi;
	Tue, 06 Aug 2024 20:18:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8DC7230066A; Tue,  6 Aug 2024 22:18:45 +0200 (CEST)
Date: Tue, 6 Aug 2024 22:18:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240806201845.GY37996@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZrJ_9OF3TaXA3xtp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrJ_9OF3TaXA3xtp@slm.duckdns.org>

On Tue, Aug 06, 2024 at 09:56:36AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Wed, Jul 24, 2024 at 10:52:21AM +0200, Peter Zijlstra wrote:
> ...
> > So pick_task() came from the SCHED_CORE crud, which does a remote pick
> > and as such isn't able to do a put -- remote is still running its
> > current etc.
> > 
> > So pick_task() *SHOULD* already be considering its current and pick
> > that if it is a better candidate than whatever is on the queue.
> > 
> > If we have a pick_task() that doesn't do that, it's a pre-existing bug
> > and needs fixing anyhow.
> 
> I haven't applied the patch to make balance_fair() test
> sched_fair_runnable() instead of rq->nr_running yet but after that I think
> all review points that you raised should be addressed except for the above
> pick_task() conversion. If you want to go ahead with this change, please do
> so. I'll pull in tip/sched/core and update accordingly. AFAICS, it doesn't
> make any significant difference to SCX one way or the other and I think
> updating shouldn't be too painful.

OK. So my plan was to finish reading the for 6.11 pull diff, and then
merge that eevdf patch-set I send out. Post those patches I had in
sched/prep that re-arrange the put_prev thing. Then merge those, and
then ask you to rebase the whole lot on top of that, after which I'll
pull your branch.

And while I'm behind my own schedule, I think we can still get all that
sorted.

Anyway, I'll go stick this patch somewhere so it don't get lost.

