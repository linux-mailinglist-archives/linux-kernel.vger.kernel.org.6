Return-Path: <linux-kernel+bounces-375293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49AC9A9441
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E11F22F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F61FF5EB;
	Mon, 21 Oct 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlmJFdG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132881E377A;
	Mon, 21 Oct 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553942; cv=none; b=M+Jak7geg24VekaJhbXA0rYzeREsj2js7egSbmcsDdbwkW8RoRGeABa5FOvPC/Fc/fWd3zlqLKZrw9AbetlZUmYkdVaTmOJijQdmnZ2alsrjp/76jT94CFhuI4GzpRlHH3VqtPIeacnnmTJl3oIJbputH1UVKtTy6iDmToBt6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553942; c=relaxed/simple;
	bh=8qnMmFH0MXE6Lj7BejyTMYR4Q9lLJBOkGOACB4p65Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqqisjR2GRP/RnCBbPcDuaEHcKYj6DXfb0LNZtCMrb+wLS4a6tFZpYWZ/m7zfouKkrgHsesPqgR1igrUUlgTpldsuchla1qjTxpcJPVgoN6B4fzM2yfrf2BxfWbe5lrEhQ1sNjY6yiNFaGtEK+SyTt5Y+4KsstUQJbrc97XzW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlmJFdG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD8BC4CEC3;
	Mon, 21 Oct 2024 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729553941;
	bh=8qnMmFH0MXE6Lj7BejyTMYR4Q9lLJBOkGOACB4p65Z8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SlmJFdG4UyEk0Tq6sBDLnlhUO1/r57NMe9kYQtlDl+5xbdB8lqr3cW2B7izWC83Pp
	 xA0oRXEwpqi5zO5INQSfhIxg9z9p8J0pM/Qn0KQb7aYfPPQFD2C1dkNmjFDlUqu95b
	 V9O8eNCSb6XS7oljJIxjxc4QcaYwYli/9BDwWUmMvvNv/B65dlLuR6ekWFJrkzTjnh
	 tJ60U9kt81sXOuoYUBixo2po4MHPleB88ixwUbwX5/9RdNlbAQVMJyYAiCUpSTfxA5
	 e/WpE97ZUWxLvdss8DXpPygy3K7ITFIFmut5JM422EbVjZEWBcqARwYuHFrQ0Yev72
	 bzCDdhHO5vcOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 261EBCE0F74; Mon, 21 Oct 2024 16:39:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:39:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZ8MStt4e8JXeJb@sashalap>

On Mon, Oct 21, 2024 at 12:07:13PM -0400, Sasha Levin wrote:
> Hi folks,
> 
> The linux-next tree we all know and love is widely used by the kernel
> community for integration work. It offers several advantages:
> 
> 	1. Early detection of conflicts between matinainer trees
> 
> 	2. Catching most new build errors/warnings
> 
> However, it faces significant testing challenges:
> 
> 	1. Contains a mix of "ready-to-go" code and experimental additions
> 
> 	2. A single "bad" piece of code can affect testing of everything else
> 
> 	3. Low barrier of entry, encouraging inclusion over exclusion
> 
> 	4. While linux-next offers early conflict resolution and
> 	identifies build issues, it is very difficult to actually test
> 	due to the abundance of runtime issues it tends to have
> 
> These factors combine to make linux-next a valuable tool for integration
> but problematic for comprehensive testing.
> 
> During the Maintainer's Summit, Linus Torvalds expressed concerns about
> the quality of testing that code receives before he pulls it. The
> subsequent discussion side-tracked to the testability of linux-next, but
> we didn't directly address Linus's original concern about pre-pull
> testing quality.

I have to ask...

Wouldn't more people testing -next result in more pressure to fix
linux-next problems quickly?  Or perhaps more pressure for people to
avoid linux-next?  But this later would also apply to a new linus-next.
Unless Linus were to start rejecting pull requests that had not been
in linu[sx]-next for "long enough", whatever that might be.  ;-)

							Thanx, Paul

> In an attempt to address the concerns, we're trying out a new "linus-next"
> tree is being created and maintained with the following characteristics:
> 
> 	1. Composed of pull requests sent directly to Linus
> 
> 	2. Contains branches destined for imminent inclusion by Linus
> 
> 	3. Higher code quality expectation (these are pull requests that
> 	maintainers expect Linus to pull)
> 
> 	4. Continuous tree (not daily tags like in linux-next),
> 	facilitating easier bisection
> 
> The linus-next tree aims to provide a more stable and testable
> integration point compared to linux-next, addressing the runtime issues
> that make testing linux-next challenging and focusing on code that's
> about to be pulled by Linus.
> 
> linus-next is (expected to be) particularly effective before the merge
> window opens, as maintainers tend to send their pull requests early,
> allowing for more thorough testing of to-be-merged changes.
> 
> We also want to avoid altering the existing workflow. In particular:
> 
> 	1. No increase in latency. If anything, the expectation is that
> 	the cadence of merges would be improved given that Linus will
> 	need to do less builds and tests.
> 
> 	2. Require "sign up" for the tree like linux-next does. Instead,
> 	pull requests are monitored and grabbed directly from the
> 	mailing list.
> 
> Tree location: `git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git linus-next`
> 
> Current testing:
>   - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
>   - KernelCI: https://t.ly/KEW7F
> 
> Feedback and suggestions for improving usability are welcome!
> 
> -- 
> Thanks,
> Sasha
> 

