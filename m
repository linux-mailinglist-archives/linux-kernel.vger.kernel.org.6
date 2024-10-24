Return-Path: <linux-kernel+bounces-379187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0329ADB35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2381F22E18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D917333D;
	Thu, 24 Oct 2024 05:01:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527E1C01;
	Thu, 24 Oct 2024 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746068; cv=none; b=bNChb+kItO0Rf51V+uG7YcvcMv/GqRIz5HzVJTgOBSPXsg+sCBeY1mj8wDVQozQ2qDueKHXslxPwdBNmoJEz9OOYeBBVV3+/+mNse/XYWzZNmJc3U3mylyFhkWnv8WLH6aZrb2vBfb8/kaj3svAb7yZXMuLkvUz/rv8XvKB/1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746068; c=relaxed/simple;
	bh=Rqr1vNeJwxHKMB70g8KYLLLZlbbTn1NQ6ed6SEO4OfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNJzeyfJUMtHwQEYVDaikWbI0mQycwNSkX6ML4ZWmaGsmo6ahSF18EXDuW7JYXE3yG92yc1dmZkLBPsgrczl3Xg9m959WjOipoboIKrUwCQpLE7NBLHiHZ7zZjoqJRX/iT1h6FpDk/RBd4lgT+BxLGUJRN59tEMgtUP1fNx5J4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E375DC4CEC7;
	Thu, 24 Oct 2024 05:01:06 +0000 (UTC)
Date: Thu, 24 Oct 2024 01:01:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig
 <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin
 <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024010103.238ef40b@rorschach.local.home>
In-Reply-To: <8734km2lt7.fsf@mail.lhotse>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<8734km2lt7.fsf@mail.lhotse>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 14:59:16 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> > But pushing to linux-next for a day or two, what does that give me?  
> 
> Several thousand build tests, across pretty much every architecture.
> 
> And a few hundred boot tests, lots virtualised, but some on real HW.
> 
> A single character typo in an #ifdef your testing doesn't cover can
> break the build for lots of people ...

I use to get that from the zero-day bot from intel. Does that not run
anymore? I noticed that I don't get notifications anymore.

So yeah, my work flow is to push to my "urgent" branch, and wait a day
for the zero-day bot. But if that's no longer the case, then maybe I
can ask Stephen to take my urgent branches.

Now the issue here is that I push to my urgent branches *before* I run
my tests. That's because my tests take 8 - 13 hours and I want the
zero-day bot to get a head start. When a bug was in my code, both my
tests and the zero-day bot would catch it. I would check to see which
one found it first. Sometimes it was my tests, sometimes the bot.

Now the issue is, if a bug is found. I don't change the branch I pushed
up. Thus, if its broken, it will stay broken until I get around to
fixing it. Depending on how badly it is broken, it may be several days
before its fixed. I would imagine if this branch is now in next, it
would break next and burden Stephen to revert my branch until its
fixed. Or it will change my workflow to have to either push after it
passes my tests or revert what I pushed first. I'm guessing I would
have to now push after my tests pass (if zero-day is no longer working).

As for the linus-next (linus-pr), this is a case that could work with
my workflow. I would happily sign up, and when I do my git pull, have
a bot pull my code into this tree (along with all the other pull
request for the day) run all these tests, and then Linus can pull after
they all passed.

-- Steve

