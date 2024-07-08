Return-Path: <linux-kernel+bounces-244737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B592A8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6967B2130B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0F14388F;
	Mon,  8 Jul 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Db9KCWct"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8726AC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462127; cv=none; b=lKgNTBQo+bwwVfohGM8NmlHsboDVipbw+KZf68yvsborqTmWprbEl6fElBj79JaR/KaxPqukFXg9tLRpNRuRYraxG+llX6X+zZZ4/WKdy/DAPwxRdQlVoUEpItwnmPFZxqQkU0+XKSS7GeiNrCtEBN2lJ718z1b12Zsjtw6bNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462127; c=relaxed/simple;
	bh=8Kww8+Trcn1lp3fQ+2Qfz6g7wRKORnofTxADiek3N9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsUJgVDqvzY1jRxAAN8kkwQL9uepihWNSBRkrFvalH6gZfxuic6B1Ebg9bH1TwrQyAJRhzTgJX3c+OKPXCfnwOlJMO0OajFxKbih7Vv95M5UnmudO25t14Bci7/ZmNKPhBTQIJCE2o7jBOi/oJ4iOFx3fXy9lkzan5PKxZ5C3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Db9KCWct; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6lgRD2W7LT4IBgAzBasll/SnbKAIjww6QtMHs6246k8=; b=Db9KCWctgsi6lF1OrWm8SQKm0d
	l7xSX63rvLWESS1kBtGft5jyVn4kyU3/M4Lnzl1VqzWpYTXJT9r6jScw9kgi7A0CiIfJc49P3v8TI
	p9F6CjzCBU+406PkE/vcn9uHUXi4U0eMxcB0TF8qDzuWcMdNj0ZLxmBxkmm/rRb0bbcoeTH1kesLt
	tkNktZxsD5DOrsGhHAaU70EV5WHEfL5MSW2Q77r+26zYwCIYRC15zq+Rc8JZJbrVdbwj+g0XOKuXh
	n46iOZw+lx25dRbyOChrXvtsz1/UHfx36ybBTnFWVNJEWS9zyMssY0XaOiO0Gom1wYWgjSmZT5DUp
	g8SiIoJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQsn1-000000073Bi-0Vf9;
	Mon, 08 Jul 2024 18:08:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04ACF300311; Mon,  8 Jul 2024 20:08:38 +0200 (CEST)
Date: Mon, 8 Jul 2024 20:08:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
Message-ID: <20240708180837.GC27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.579623285@infradead.org>
 <20240708163545.GB18761@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708163545.GB18761@redhat.com>

On Mon, Jul 08, 2024 at 06:35:45PM +0200, Oleg Nesterov wrote:
> I hate to say this again, but I'll try to read this series later ;)
> 
> But let me ask...

:-)

> On 07/08, Peter Zijlstra wrote:
> >
> > +static void uprobe_free_rcu(struct rcu_head *rcu)
> > +{
> > +	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> > +	kfree(uprobe);
> > +}
> > +
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> >  	if (refcount_dec_and_test(&uprobe->ref)) {
> > @@ -604,7 +612,7 @@ static void put_uprobe(struct uprobe *up
> >  		mutex_lock(&delayed_uprobe_lock);
> >  		delayed_uprobe_remove(uprobe, NULL);
> >  		mutex_unlock(&delayed_uprobe_lock);
> > -		kfree(uprobe);
> > +		call_rcu(&uprobe->rcu, uprobe_free_rcu);
> 
> kfree_rcu() ?

I can never remember how that works, also this will very soon be
call_srcu().

> >  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> >  {
> > -	struct uprobe *uprobe;
> > +	unsigned int seq;
> >
> > -	read_lock(&uprobes_treelock);
> > -	uprobe = __find_uprobe(inode, offset);
> > -	read_unlock(&uprobes_treelock);
> > +	guard(rcu)();
> >
> > -	return uprobe;
> > +	do {
> > +		seq = read_seqcount_begin(&uprobes_seqcount);
> > +		struct uprobe *uprobe = __find_uprobe(inode, offset);
> > +		if (uprobe) {
> > +			/*
> > +			 * Lockless RB-tree lookups are prone to false-negatives.
> > +			 * If they find something, it's good.
> 
> Is it true in this case?
> 
> Suppose we have uprobe U which has no extra refs, so uprobe_unregister()
> called by the task X should remove it from uprobes_tree and kfree.
> 
> Suppose that the task T hits the breakpoint and enters handle_swbp().
> 
> Now,
> 
> 	- X calls find_uprobe(), this increments U->ref from 1 to 2
> 
> 	  register_for_each_vma() succeeds
> 
> 	  X enters delete_uprobe()
> 
> 	- T calls find_active_uprobe() -> find_uprobe()
> 
> 	  __read_seqcount_begin__read_seqcount_begin() returns an even number
> 
> 	  __find_uprobe() -> rb_find_rcu() succeeds
> 
> 	- X continues and returns from delete_uprobe(), U->ref == 1
> 
> 	  then it does the final uprobe_unregister()->put_uprobe(U),
> 	  refcount_dec_and_test() succeeds, X calls call_rcu(uprobe_free_rcu).
> 
> 	- T does get_uprobe() which changes U->ref from 0 to 1, __find_uprobe()
> 	  returns, find_uprobe() doesn't check read_seqcount_retry().

I think you're right. However, this get_uprobe() will go away in a few
patches.

But yeah, I should perhaps have been more careful when splitting things
up :/

