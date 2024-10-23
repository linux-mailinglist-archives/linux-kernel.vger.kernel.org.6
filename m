Return-Path: <linux-kernel+bounces-377620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C419AC168
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938731C244B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14A15855C;
	Wed, 23 Oct 2024 08:20:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34D487BE;
	Wed, 23 Oct 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671608; cv=none; b=Bhh68EKESAH7K6+kpj6aDb6AWzu4efVJouFOeCDORlN8V0CL1w4cLOrdHXaa/8K6PAASOLvrLox4H49hqiTeETPLTDT3MmqJT+D9WqB4ATKvQ1+BBMqAU8RK5QQYQ/s67xbPAVHguRW75PGnpieHYfhsn7OuqmMsNrgga0uS4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671608; c=relaxed/simple;
	bh=Ifg5cy5wv3RinqCl8FuJgeZbnHwOnRvDW2jlSL9wohs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HANkYb1fqnf0GvL7IhfzzjqdpSJQ7oKU4O09XYK4NWO4js0e36NWGGzLpcZQyUWcmY4UYZmaartk3eTDb+TH4yyyxQoDKKAIF9GrBD9LcKNXp+MyJ6zr8H6AuDNTn5KtH9bF7SaSM9baeYknzDo+n5uL2dW6jZOWzQbfwTf1xfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757ABC4CEC6;
	Wed, 23 Oct 2024 08:20:07 +0000 (UTC)
Date: Wed, 23 Oct 2024 04:20:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241023042004.405056f5@rorschach.local.home>
In-Reply-To: <ZxiN3aINYI4u8pRx@infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 22:47:09 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Oct 22, 2024 at 04:12:43AM -0400, Steven Rostedt wrote:
> > You mean have everything go into linux-next before going to Linus after -rc1?
> > 
> > I'm one that doesn't do this. That's because my code in linux-next
> > after -rc1 is for the next merge window, and the code I send to Linus
> > is only fixes for code I sent before -rc1. I tend to keep an "urgent"
> > and "core" branch. My "core" branch is everything I plan to send in the
> > next merge window and goes into linux-next (via being pulled into my
> > for-next branch). After I send my pull request to Linus, and he pulls
> > it in the merge window, that "core" branch becomes my "urgent" branch.  
> 
> You can easily have two branches in linux-next.  Many trees do that.
> It is also a really nice warning about self-conflicts.

I actually do have several branches in linux-next. But they are all
topic branches. My urgent branches usually mirror them (by naming
convention). My scripts pull my for-next branches together and then I
push them up.

I did push urgent branches to linux-next some time back, but never
found any advantage in doing so, so I stopped doing it. As the code in
my urgent branches are just fixing the stuff already in Linus's tree,
they seldom ever have any effect on other subsystems. My new work does
benefit from being in linux-next. But since I don't find more testing
in linux-next for things that are already in Linus's tree, I still
don't see how its worth the time to put my urgent work there.

To put it this way. The bugs I'm fixing was for code in linux-next
where the bugs were never found. They only appeared when they went into
Linus's tree. So why put the fixes in linux-next, if it didn't catch
the bugs I fixed in the first place?

-- Steve

