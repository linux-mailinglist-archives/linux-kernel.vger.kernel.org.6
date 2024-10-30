Return-Path: <linux-kernel+bounces-389261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A639B6AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3312F1C2167E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC70219480;
	Wed, 30 Oct 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO5UXt6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB05218D70;
	Wed, 30 Oct 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308138; cv=none; b=tIG2quGmSiWHMHSfNEihlsrCIeku0wacstTVafHoZ7OHVf27WeZjFSWcBWIYdgi2DCDDhnMGSdflmanA4A94F0gWMl46rqnS6Zv9W+k38uVtGt4VbfgcF+OGJnT5Z678b5pPt74XD/DnNlx+JP0ton37OSnYOJRult96REszzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308138; c=relaxed/simple;
	bh=xwPA/BheIpqJrGKVfaK0TNdyl92ejYqRd7ZDMQChKbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6kxNw1fjM6+CaFWalnYvhQ2S2HjlKJNVMtb67pzWCXn1xjtONn9Y7kG1m/y8IqSeEATqJxOetNMLoxd92EvZAVjrvy04K2SLAgzC2xr7WOP7M0i5PcHA00IZZEWMgJgWtmdS0TkeCy9dSzZVjr1hVZzZ3L7H1ItYhVOOYZWPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO5UXt6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CCDC4CECE;
	Wed, 30 Oct 2024 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730308138;
	bh=xwPA/BheIpqJrGKVfaK0TNdyl92ejYqRd7ZDMQChKbo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bO5UXt6syOeOlJoUU+T0L5VLguCtj8x9unWn1UW4/e06emXPmd7GORjlMEFTfD3uB
	 fvYzVbMLOVdJx01b57uf/onJKtE4v6Gte7kqWnvj4JI6Drfd5lI0eZHMUE20CLCCJ9
	 ks809Xmp70LiCLGz7ahyP7XgTWPtehSTaWaJ2CksOaw2v88YcGoWzjvJYIcAXeJd6s
	 m0elWyHBAGDrp3vD5bQqjPhyoTsekOQ+D3sHbgxcts9ZtO3Ib00ZgHNBTZhXmjLeYu
	 tCxP+j5w3TZkpxLcpABgowbn6R+6VLYBPbM9fUe2Q2DM1q4SOjodZH8yhxcMdDfXOX
	 Chpl6jW7C3Viw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7A22CE0BB3; Wed, 30 Oct 2024 10:08:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:08:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <c936a7f6-e532-4f6a-b55a-bbf0fe6c6f32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyAUO0b3z_f_kVnj@sashalap>

On Mon, Oct 28, 2024 at 06:46:19PM -0400, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> > > For example, for a given PR, the bot can report:
> > > 
> > > - Were the patches CCed to a mailing list?
> > > - A histogram of how long the patches were in next (to show bake times)
> > > - Are any patches associated with test failures? (0day and many other
> > > CIs are already running tests against -next; parse those reports)
> > > 
> > > We could have a real pre-submit checker! :)
> > 
> > That would be very useful.  Items 1 and 2 should be trivial, 3 would
> > require a bit of work but would still be very useful.
> 
> If you've been following so far, there is a bot that is capable of doing
> most of the above
> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).

Nice!!!

What does this make of these commits of mine?

744e87210b1ae rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
cbe644aa6fe17 rcu: Stop stall warning from dumping stacks if grace period ends
26ff1fb02991e rcu: Delete unused rcu_gp_might_be_stalled() function

> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
> long commits spent in -next:
> 
> Days in linux-next:
> ----------------------------------------
>  0 | +++++++++++++++++++++++++++++++++++++++++++++++++ (89)
> <1 | +++++++++++ (21)
>  1 | +++++++++++ (21)
>  2 | +++++++++++++++++++++++++ (45)
>  3 | ++++++++++++++ (25)
>  4 | +++++ (10)
>  5 |
>  6 | + (2)
>  7 |
>  8 | + (3)
>  9 | ++ (4)
> 10 |
> 11 | +++ (6)
> 12 |
> 13 |
> 14+| ++++++++ (15)
> 
> This is where I think the value of linus-next comes during the -rc
> cycles: the (89 + 21) commits that haven't gone through the -next
> workflow before being pulled. I'm not looking to delay the process and
> add latency, I'm looking to plug a hole where code would flow directly
> to Linus's tree bypassing -next.
> 
> With linus-next, we can at least squeeze in build tests as well as some
> rudimentary testing if we get a few hours before Linus pulls (and we
> usually do).

OK, if linus-next is only active just before the merge window opens,
then I have fewer testing-bandwidth concerns.

							Thanx, Paul

