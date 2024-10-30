Return-Path: <linux-kernel+bounces-389662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07299B6F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5021F21E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B6219485;
	Wed, 30 Oct 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJ4oxsC+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843802170CB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324265; cv=none; b=aGBNOpQsEtUVljjzGPftcGoTu7j9TygGdAgSnlyasQT5x6VAdfAemFupnftE14J8TYTUlZ00xg9zqvi1WCenQojou3ygdC9+kde5OvOaXYSMJOKJxSAnNZzZ+/YRkxHha0kAcQ0DcntY9utvPwDU02zgqN+m8O0UqWfTbqTLCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324265; c=relaxed/simple;
	bh=aPWpanHqZe/iGfQmkgoLw3c74T5cvbrvyuCPjHu+cPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQEosrXTCqx9yxS2xz3MDx4eolg2z5V5ziocL6euIYIEgqtlkaA18lU8fj8TFx/0amcdnvByTWJlu4Pzeif1MDTQI5hpQOIn/jfA2HzSvCWYVs3t4/ARac7hCkhqt08X/6CIs6GKYBtC+JRxnJS/RZh7YlRu8LgduB8YqQpPfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJ4oxsC+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WPRkShuQG9G71KCkfnN88++Epe286/PbVni+m8aDPM0=; b=NJ4oxsC+oftUESVtNPiyWyCrAM
	g6vvxX5GlUM711J7h/B+kUAYS5qvmwFTwKaFdXJTOb4gtI/bhyeixqkaQmRss8k3tRG/ebG98PYeV
	N9rIa+hDHkI0kzHWtRLTobv+oc6QwMddfmIE5MK26sr7s2ntG6IIOgfM7df0t4qFbI4JT2/H9IG5P
	ijQMxPQwdTHNYIBAZ20nEtgGACIpxWTX6D+rv2JA3ZMlqdX9E2/MeR4qyMKuoABWNTXhiPr6piTKk
	cyl+wHhT/e2teExqK1udb9Ok7VKXA/Dp+5u1m2VVJoBucyu1gf5ZSUC/1SPuofnvRy9OMxM7jZW9A
	JLn5M6pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6GNj-0000000DwRN-3Bov;
	Wed, 30 Oct 2024 21:37:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04154300ABE; Wed, 30 Oct 2024 22:37:36 +0100 (CET)
Date: Wed, 30 Oct 2024 22:37:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/6] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <20241030213735.GS14555@noisy.programming.kicks-ass.net>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.711768679@infradead.org>
 <ZyKhQFuMItKsmsnh@slm.duckdns.org>
 <20241030211506.GR14555@noisy.programming.kicks-ass.net>
 <ZyKlJXgXUqDpaQXp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyKlJXgXUqDpaQXp@slm.duckdns.org>

On Wed, Oct 30, 2024 at 11:29:09AM -1000, Tejun Heo wrote:
> On Wed, Oct 30, 2024 at 10:15:06PM +0100, Peter Zijlstra wrote:
> ...
> > > > +		if (!(queue_flags & DEQUEUE_CLASS))
> > > > +			check_prio_changed(task_rq(p), p, p->prio);
> > > 
> > > Maybe prio_changed can be moved into scoped_guard?
> > 
> > It wasn't before -- do you have need for it to be inside?
> 
> No, was just wondering whether that'd make things a bit more compact. Either
> way is fine.

Oh, did you perhaps mean into sched_change_end() ? I suppose that's
possible indeed. Initially I thought that would require yet another
flags, but looking at it again, that doesn't seem to be the case. All
sched_change users lacking it never change the prio anyway.

I'll have a look at doing that tomorrow, with a slightly fresher brain.

I also think that adding flags to the switch*() methods isn't at all
needed, but perhaps it makes sense anyway.

