Return-Path: <linux-kernel+bounces-379637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C09AE167
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A41F237F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE11B6CFB;
	Thu, 24 Oct 2024 09:49:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594471B3935;
	Thu, 24 Oct 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763354; cv=none; b=E4++/Rkk9DUUTrgSGmiHx52mLrJtoEJbk0cpt939iEF5IcqanB/WyArjjvMPVEmkGxQ61HA4gEKotAziNfHxxwviJKZaNBX/cHHiIfKauCBPohuaWdKiGzNWrf/41Xs5aMVIIOEAdo8t9B3RcK6ZFfTxD0qpkA2ASZuP2+uc/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763354; c=relaxed/simple;
	bh=aB2lRevzR8yR1hBpjnamd65HmUOLhBUzSa5mbuK6VI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B98qNfJDjZInc43C7pOwozsvCWM7Mw8Xx+DT8vLSAYe1GVmA4KvvLFtdABaFxyJuZciOxvdMH29IE/uAa97Ut7W5ZWmXxLGnWDun+MojsaRba9TN55AqcKo4ZXkXrQjHqX/tsPl+fAXbwwE8E54RdKfFTJmK5aZbKUB20DpJID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999C9C4CECC;
	Thu, 24 Oct 2024 09:49:12 +0000 (UTC)
Date: Thu, 24 Oct 2024 05:49:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck
 <linux@roeck-us.net>, Michael Ellerman <mpe@ellerman.id.au>, Kees Cook
 <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024054909.49ae9faa@rorschach.local.home>
In-Reply-To: <ZxoSZQSw0z6AdgaU@infradead.org>
References: <ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<8734km2lt7.fsf@mail.lhotse>
	<20241024010103.238ef40b@rorschach.local.home>
	<07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
	<20241024024928.6fb9d892@rorschach.local.home>
	<CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
	<20241024052139.2cf7397f@rorschach.local.home>
	<ZxoSZQSw0z6AdgaU@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 02:24:53 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Oct 24, 2024 at 05:21:39AM -0400, Steven Rostedt wrote:
> > them as small as possible. That's not always the case, so maybe I could
> > push it. But it will change my workflow quite a bit or burden Stephen
> > with broken branches.
> > 
> > I'm still not convinced it's worth it.
> > 
> > We are not talking about new development code. We are talking about bug
> > fixes for code that is in Linus's tree. The zero day bot and my tests
> > appear to find most issues. Bugs that happened on my fixes patches are
> > usually other use cases. For instance, cpu hotplug while tracing from
> > rtla. That's not coverage I get from linux-next.  
> 
> Seriously, just add your damn fixes tree to linux-next.  If your fixes
> are as perfect as you claim that one time setup is all you need to do,
> and you have less work than you spent arguing on this thread already.
> 
> If it catches bugs eventually you will need to do more work, but save
> others from deadling with your regression.  There is no downside for
> you.

So basically, all I need to do to satisfy your request is to add fixes
branch that I push to that is pushed after it passes my tests (and not
the urgent branch that is still being tested and may have bugs) and
then have that be added to linux-next?

Now I have been batching changes and not send a pull request right
after my tests pass. I've been sending a pull request at most now once
a week. So I could have this branch hold the code that's already been
tested.

-- Steve

