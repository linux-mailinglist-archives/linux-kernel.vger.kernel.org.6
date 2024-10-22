Return-Path: <linux-kernel+bounces-375869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0129A9C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A5281BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0CF156F34;
	Tue, 22 Oct 2024 08:12:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81D347C7;
	Tue, 22 Oct 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584767; cv=none; b=cMoH1LuLfVSA0umjX4k6dMNpVfiy5Ek9ty9qL3FK2ZfzkyyVhQI6/cHeerifEaZVhzrOUjtMp97Wk9/CRj6mfLfJjQgzzs8U+kTQks803HXNRr298AsRbxKkkeov9xgtFpEc5dBnkZhRPzfCFiQWKfGBjA+KRYZcP5qdCtmjl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584767; c=relaxed/simple;
	bh=Gv1pTwKuPZSBBtO0p+QP4yCkEZ6GKdVQGtuuIxNh2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAUCIddwYJ/ty4INhaaWY4SvdkFt6QyiutOIDHOCWG1+E30fK0E14yH/7U+zIe+myWNj9Aswg2B5mbaR9OFyUDcGF0hFMRtY03ST+RWSCstTPVED1P+evVO4rnTp7I8ru50q1ZMpXLZ4XcwyiwOt/UuLjMisJJA0485slSGuCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB7AC4CEC3;
	Tue, 22 Oct 2024 08:12:46 +0000 (UTC)
Date: Tue, 22 Oct 2024 04:12:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241022041243.7f2e53ad@rorschach.local.home>
In-Reply-To: <ZxdKwtTd7LvpieLK@infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 23:48:34 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > How about this, instead: no one sends -rc1 PRs to Linus that didn't go
> > through -next. Just have a bot that replies to all PRs with a health
> > check, and Linus can pull it if he thinks it looks good.   
> 
> Not just -rc1, otherwise agreed.

You mean have everything go into linux-next before going to Linus after -rc1?

I'm one that doesn't do this. That's because my code in linux-next
after -rc1 is for the next merge window, and the code I send to Linus
is only fixes for code I sent before -rc1. I tend to keep an "urgent"
and "core" branch. My "core" branch is everything I plan to send in the
next merge window and goes into linux-next (via being pulled into my
for-next branch). After I send my pull request to Linus, and he pulls
it in the merge window, that "core" branch becomes my "urgent" branch.

But when I find a bug that's in Linus's tree, I put the fix on top of
"urgent", run it through my test suite (takes 8 hours or so), then send
a pull request to Linus. My "urgent" branch doesn't go into linux-next
as it doesn't have changes that should affect others work, which is
what I think linux-next is mostly for. I also find known bugs in
Linus's tree to be high priority to be fixed (I stop what I'm doing to
get the fix out ASAP).

Now, if there was better testing from linux-next, maybe it would be
worth the time to push my urgent branch there for a bit. But so far I
haven't seen the benefit of doing that.

> 
> > For example, for a given PR, the bot can report:
> > 
> > - Were the patches CCed to a mailing list?
> > - A histogram of how long the patches were in next (to show bake times)
> > - Are any patches associated with test failures? (0day and many other
> > CIs are already running tests against -next; parse those reports)
> > 
> > We could have a real pre-submit checker! :)  
> 
> That would be very useful.  Items 1 and 2 should be trivial, 3 would
> require a bit of work but would still be very useful.

If there was more feedback to going into linux-next, that would be good.

-- Steve

