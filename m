Return-Path: <linux-kernel+bounces-524877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE5A3E84C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B3A16D23A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3AE266F1D;
	Thu, 20 Feb 2025 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YT3oe8Cq"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C01E231E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093723; cv=none; b=kVOPCOkFMvdNaCjb2PcHHaoIs/N7UhfsCZYsk2YelMokZ+T73oJPKiDfMVxIj6nnwFoZmt2dS8HXrlLq9PRU9sC4hXXA2ROqgPfsd4BlocQG0xDr/mW2wystXDsUtvVTMvAjUehU46RT6aPBC7JP+CcpfNJBK8KKt4gNGoPemss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093723; c=relaxed/simple;
	bh=kZ68jG+Z1BV0709xXyDYBm20j2ctu+NNZbpplDZg+OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWOpITeOhqgHryEMCXrq3FJq2jpRiRMfLwLZfl7jScn3wOPow0YkXJ/ppUOSPWfs62fE43K1hOMkB91OnsdCJc/lmvMsSWAOcyfBKv6mM9IYrZSkIM4FzKn7LO431LYEeowVuBkcwV3aXcPevjdoQwE4R6uZFaWwYn408kPsKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YT3oe8Cq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 18:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740093719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zbxI6jjoMfZRkTAMh8XV6NUEnzyMU8+MvcUYYGyk+xY=;
	b=YT3oe8CqDcy8JSqJUX42pb+fpajGdiEh17wUc88GdP2WAqsOWI8iFRscmAMJIzIpQBowuH
	cEkz0CawIHPIU79Wc5pkAdFSwN3nUZLJ1GJBt4hNvd8NKmAv0yMpW34Jo6aIdKY1cpBuwa
	/e5+BjsW8Z09k/MaNijnHuJ6AlGnqgM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Hillf Danton <hdanton@sina.com>, 
	Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <sidjvovjq4erirlld46qostxcycju6ytm3ptvvcapvhd3lhbh3@6oktathem55a>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
 <Z7c0BTteQoZKcSmJ@casper.infradead.org>
 <Z7dFuTkdQ7PmP7sY@home.goodmis.org>
 <ebna3dzn7aevgpzxjdb4vykmrheb7erqpdbos3ayl6tnimijpp@ibkvhcsa3pib>
 <20250220180539.0fadab4b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220180539.0fadab4b@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 06:05:39PM -0500, Steven Rostedt wrote:
> On Thu, 20 Feb 2025 17:53:41 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > > I'll tell you what would happen in my home town. If someone said
> > > that to a co-worker, they would likely be terminated.  
> > 
> > I can't agree with the "this is a firing offence" approach.
> 
> My point was, if this was in a company, it could very well be a firing offense.

Well, to a white color worker, yes. But to someone working a blue collor
safety critical industry, that's going to come across as rather tame.

(And I do get annoyed when people get overly focused on language and
forget that _we_ are a safety critical industry. To a first
approximation, all the critical infrastructure throughout the world runs
on Linux, stuff that doesn't is a rounding error, and all the testing
and validation that exists only provides a safety factor. We have to
have our shit together, and that does need to come first).

That aside - my point isn't about what should and shouldn't be allowed,
it's just that norms are arbitrary and it's not the best argument if you
want someone to change their behavior.

> > We're a community, no one is employed by anyone else here; we work
> > together because we have to and we have to figure out how to get along.
> > We work via consensus, not appeals to authority.
> 
> As a community, yes, things are different. But we should not have to
> tolerate such language.

Agreed.

And I think we're all aware at this point at how that sort of thing does
drive people away, so best not take it so far people start to consider
you a liability - or one way or another there's going to be an "or else".

This place functions by making people feel respected and valued for the
work they do, so a degree of respect and consideration is required.

