Return-Path: <linux-kernel+bounces-306788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26985964398
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3541B221AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE018DF84;
	Thu, 29 Aug 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bw/pmVru"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE418DF8C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932518; cv=none; b=S9RAhVFyijH5GGUJh5XUyrpXl3cXURlnONIMBfqlvWP3umySTPGBkjJ9bIkyUyXkX1gJS59ZwrZuWOMrpzNJaV9jRWUl18/5i1VhGr+y4TP25wt/Ytm+jjIPFxG1g8i2AqEoS1JmWVLEBoGzS3bD0US+27UIsFu0+40lFL5a8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932518; c=relaxed/simple;
	bh=aJe5Fus4ZJGujB0UB2ZsYfAe5goUGITAkrZfAdNS8eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFhz4KR7VFveYuMj3oszVcz6S8Jw2dlWzB80rC26a+cKFvovssb46W5lsuvL8Tmi6A1f1qAWz1ytORWfjeO2QL5ev2fV8alJk3uKuDqUxssUWzaoM6zcsAnyNR79Fn/k3iucV7ZvxSZbZJubybHExfgjHuNk23s2z6gcgpb2MVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bw/pmVru; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 07:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724932512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAQ4lMRxkKE30BQ85RFYubSduZKYsX0TPx4pJMHH9ts=;
	b=bw/pmVruE68blg7sBE+toIJxwqbaXYwuMwUWCmDgIkNrWrfJKlhCEWb1HRDORlcT4j9Utc
	hoT+m0nfIp5o+sarCEicDCILGgxBGKki4zCbTYK6GR52n+4s8KszWrmITZIGzWc/PyLAIe
	cBdH4XwYF4a+94r+2OofoLSIS9yofjs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBWxWunhXTh0bhS@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 01:08:53PM GMT, Michal Hocko wrote:
> On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> > On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> [...]
> > > > It was decided _years_ ago that PF_MEMALLOC flags were how this was
> > > > going to be addressed.
> > > 
> > > Nope! It has been decided that _some_ gfp flags are acceptable to be used
> > > by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
> > > modifiers and other flags so these are indeed safe to be used that way.
> > 
> > Decided by who?
> 
> Decides semantic of respective GFP flags and their compatibility with
> others that could be nested in the scope.

Well, that's a bit of commentary, at least.

The question is which of those could properly apply to a section, not a
callsite, and a PF_MEMALLOC_NOWAIT (similar to but not exactly the same
as PF_MEMALLOC_NORECLAIM) would be at the top of that list since we
already have a clear concept of sections where we're not allowed to
sleep.

And that tells us how to resolve GFP_NOFAIL with other conflicting
PF_MEMALLOC flags: GFP_NOFAIL loses.

It is a _bug_ if GFP_NOFAIL is accidentally used in a non sleepable
context, and properly labelling those sections to the allocator would
allow us to turn undefined behaviour into an error - _that_ would be
turning kmalloc() into a safe interface.

Ergo, if you're not absolutely sure that a GFP_NOFAIL use is safe
according to call path and allocation size, you still need to be
checking for failure - in the same way that you shouldn't be using
BUG_ON() if you cannot prove that the condition won't occur in real wold
usage.

Given that, it's easy to see how to handle __GFP_RETRY_MAYFAIL and
__GFP_NORETRY: if they're applied to a context, then the usage is saying
"I need to attempt to run this section with some sort of latency
bounds", and GFP_NOFAIL should lose - as well as emitting a warning.

BTW, this is how you should be interpreting PF_MEMALLOC_NORECLAIM today:
"I have strong latency bounds here, but not so strict that it needs to
be strictly nonblocking".

