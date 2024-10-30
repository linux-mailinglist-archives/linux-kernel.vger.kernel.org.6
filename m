Return-Path: <linux-kernel+bounces-389292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CF9B6B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E305EB21670
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0C1993B7;
	Wed, 30 Oct 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsvQqO0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE851BD9C1;
	Wed, 30 Oct 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309577; cv=none; b=dusJ1JObmzvb2kvcNvlYsJ7eznZmA8xUZW5nfOFU+++7Jn313A63YofGSCHw0plVBXgTFlRrKdIpaHIYcA6KaUbnJgyQ33HBnGlJ3zoGDlJhgNtEkuEe8ET9NnIp/gR487AHffvkkUXlKo3JOaivXEiEZsRlqX+LEILuvwwegvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309577; c=relaxed/simple;
	bh=xD3fbQXh0ADlv6ZOptn1aGGPtRMLbGY+tnrT42LdKQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTjfqYWfZS6ehlKDmYNJHaIgo0b4i4I9KaXRyNL/8AeaCNvNw8oN5rbifGCvWLfrF022LK3MOFS8+I8LZggDhFR4lgUGnGotgUNwXRhf0gLjSrIvrHuswBZTLGbO4/HerK3xAEvyQwfDXlg0FTpZpIoTZFh6Y9VHWbWvRY+jlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsvQqO0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DEFC4CECE;
	Wed, 30 Oct 2024 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730309576;
	bh=xD3fbQXh0ADlv6ZOptn1aGGPtRMLbGY+tnrT42LdKQE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NsvQqO0hMPepYn6kSvR2+zBfpxBRcHrK9CeDHrTi4hiB5OyWoQL9iDUjQnMd6ekBG
	 8Bzzc2fdNa/E57e7UWIsRzSwETI10c3FQP1eCdGLEagEOSA3oik4A4xss1Ldpjyvem
	 0egifEgr+Dabr05b2l7y37qdbXaEpVcTBawnIFNKCO2VAyLO5L344L3SBYeTT9cqaN
	 kO7Dsz0As6Z1dcND8X5yvPg1nK1PTZi+bcmr2O8nhfp8O/c0UFmXpAZpKr54Qf/hoH
	 4I9PfcMgtts931boEk2q/nJTZFbkNdOZyNgQuwE+pgz71xEllmW8o+sPJ3yZl6tx4a
	 /LM7S++SmYRhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 815CBCE0BB3; Wed, 30 Oct 2024 10:32:56 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:32:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <cb2af1b4-5ce0-4e91-9456-1c88f4eef4fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
 <c936a7f6-e532-4f6a-b55a-bbf0fe6c6f32@paulmck-laptop>
 <ZyJpu5QdGho6cOUs@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJpu5QdGho6cOUs@sashalap>

On Wed, Oct 30, 2024 at 01:15:39PM -0400, Sasha Levin wrote:
> On Wed, Oct 30, 2024 at 10:08:57AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 28, 2024 at 06:46:19PM -0400, Sasha Levin wrote:
> > > On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
> > > > On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> > > > > For example, for a given PR, the bot can report:
> > > > >
> > > > > - Were the patches CCed to a mailing list?
> > > > > - A histogram of how long the patches were in next (to show bake times)
> > > > > - Are any patches associated with test failures? (0day and many other
> > > > > CIs are already running tests against -next; parse those reports)
> > > > >
> > > > > We could have a real pre-submit checker! :)
> > > >
> > > > That would be very useful.  Items 1 and 2 should be trivial, 3 would
> > > > require a bit of work but would still be very useful.
> > > 
> > > If you've been following so far, there is a bot that is capable of doing
> > > most of the above
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).
> > 
> > Nice!!!
> > 
> > What does this make of these commits of mine?
> > 
> > 744e87210b1ae rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
> > cbe644aa6fe17 rcu: Stop stall warning from dumping stacks if grace period ends
> > 26ff1fb02991e rcu: Delete unused rcu_gp_might_be_stalled() function
> 
> Days in linux-next:
> ----------------------------------------
>  1 |
>  2 |
>  3 |
>  4 |
>  5 |
>  6 | +++ (3)

Very good!

Any indications of errors for any of them?

							Thanx, Paul

