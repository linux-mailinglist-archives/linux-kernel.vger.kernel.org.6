Return-Path: <linux-kernel+bounces-378688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252769AD416
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552701C20C00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74971D0E3E;
	Wed, 23 Oct 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm11Fg47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75812DD88;
	Wed, 23 Oct 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708652; cv=none; b=Eqr8xMhJGhETRxfkckCBMrOy2vjBkha0vNIFyObMoiBvweokixgYaO0gSYdoq6Y1OXy7RZOD2XZX5VisikB19kUR/x5XDsbpMJ+aOv/wxw0tv20iYLzq7ltDMoW0AVjFt3ypHUA4Vzd/QUwQq1uD9LOumgpSaEz6h+wD/ufb+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708652; c=relaxed/simple;
	bh=8KloaCA+RS39SpLRuQLnw9Se30zdDqceqHjRrVAVWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR68Fo5KGlZo7+pvWpwyscXSnuUTiVNHmR69NBReH/6V8EM5ewkpE5o2fxX6jSnRkAxMemScUQeEXI+OLeSLlri0xadk2S2pHVEuU10W3tSuqrFdlakGSk1CTVTIndETAc/Q+cj8iZ+8WrRriO9Vxbqec6Q+r3tA9ijXgqZgCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm11Fg47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95D2C4CEC6;
	Wed, 23 Oct 2024 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729708651;
	bh=8KloaCA+RS39SpLRuQLnw9Se30zdDqceqHjRrVAVWIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Pm11Fg47iYCnk/wWpaY209DMUehknEUH3MJH+n8HvKKZQTDEfNevYE0AT18MZLPMm
	 Z071ImvnnkyKTdKDFQvSmjkoZdp8oGt1v3qZEL6K5nmhzPJ5gDy5aig8oN5xWqkcp0
	 r9YWW8sDniv1s1JWgqm57oJ9P1Z5dwp8EmHPH3EgDfseMFChoDBVmHv8d9kSMim+d7
	 2fiMJ4Z/wsmc7Cp25JAGnqHjdIEOyV/k/PAchgbURZWeR7N3yiBXv0LVLTT7FvChrt
	 b3z9LAlTHEFF0LRboH5ERGx74WsUYkp+55In5Yfbj4ZMUN4paCWOo/9S9gyekVwQP3
	 iu+h63dqjVjgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72174CE0EE1; Wed, 23 Oct 2024 11:37:31 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:37:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <e4ac4459-faf6-48df-851a-a5204bdee4cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org>
 <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>

On Wed, Oct 23, 2024 at 11:06:59AM -0700, Linus Torvalds wrote:
> On Wed, 23 Oct 2024 at 10:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > Yes, without Linus caring we're not going to get our process worked out.
> > > Not sure how a tree that probably won't have much better latency than
> > > linux-next is going to fix that, though.
> >
> > If I recall correctly, one thing Linus asked us to do earlier this year
> > (ARM Summit) is to CC him on -next failures.
> 
> Yes. I definitely care about failures in linux-next, but I often don't
> _know_ about them unless I'm told.
> 
> The linux-next automation sends notifications to the owners of the
> trees, but not to me.

OK, then I guess I was inadvertently doing the right thing by forgetting
to CC you on all -next issues my testing has located.  ;-)

[ . . . ]

> And yes, I know some people do functional testing on linux-next
> already. The message at the maintainer summit was a bit mixed with
> some people saying linux-next tends to work even for that, others
> saying it's often too broken to be useful.

Functional testing?

Me, I do rcutorture *stress* testing on -next, and it usually passes.
Yes, there is the occasional spectacular exception, like the version
last month where rcutorture found the better part of ten bugs.  Two of
which were ugly heisenbugs that are still being chased down.

(Full disclosure: One of those bugs is in RCU, but that bug is already
in mainline.  Much of my time over the past two weeks has gone into
moving it from a once-per-year heisenbug to more than ten failures
per hour.  This bug does not happen without lots of CPU hotplug, as in
a 50-millisecond delay between successive CPU-hotplug operations.)

What I do is to carry patches against -next, and this week I am down
from two to one of them.  But most of the time, my list of -next-fix
patches is of length zero.

Now, I freely admit that rcutorture doesn't hammer all that much of
the kernel: mostly just RCU, timers, the scheduler, and CPU hotplug.
So I could easily imagine that -next testing of other parts of the kernel
might be more failure-prone.  Except that the correct answer to that is
*more* -next testing, not less of it.

							Thanx, Paul

