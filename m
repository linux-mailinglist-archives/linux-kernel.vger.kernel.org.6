Return-Path: <linux-kernel+bounces-522429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE67A3CA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A3B1898DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B9243953;
	Wed, 19 Feb 2025 20:45:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593D1DF24F;
	Wed, 19 Feb 2025 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997947; cv=none; b=W+zw+t0dNUSce8I7d0DgZp0AC3XrTUOXVPksUYwwMerIE7SCpY36z/O+W3zFhQQfRzaEBLE37kMum6wMTMCeyxwXR4OZwop5j/GV+/7ebm681eSAxIlnQwuDTzDAqv8ZfZ5y/BDgCClmKvgbH2Uz46/3NQ4CN15usUbkA+dNqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997947; c=relaxed/simple;
	bh=RYwHnw45/MEFs5Axvyvrt2KBWzat47/DZtEE1DHf4NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FETad1JojANTJv4WrRdl4OQHeQHY7UB+VDMjfJCwHj6qNHah2qzlzZQvogp3nkvrzHOIY/VFUotJaaxTPwdT4wAk5EqutAcDRasVqWwhNn3SPNWdISWl+3EaGbOKIVuEXYbIG+8TXC+Admv1m2ojWMOdQpkDsu3+7iRR/2u2O8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB25C4CEE6;
	Wed, 19 Feb 2025 20:45:45 +0000 (UTC)
Date: Wed, 19 Feb 2025 15:46:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219154610.30dc6223@gandalf.local.home>
In-Reply-To: <20250219202751.GA42073@nvidia.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<202502191026.8B6FD47A1@keescook>
	<20250219140821.27fa1e8a@gandalf.local.home>
	<202502191117.8E1BCD4615@keescook>
	<20250219202751.GA42073@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 16:27:51 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Can someone do some data mining and share how many "rust
> opportunities" are there per cycle? Ie entirely new drivers introduced
> (maybe bucketed per subsystem) and lines-of-code of C code in those
> drivers.
> 
> My gut feeling is that the security argument is not so strong, just
> based on numbers. We will still have so much code flowing in that will
> not be Rust introducing more and more bugs. Even if every new driver
> is Rust the reduction in bugs will be percentage small.
> 
> Further, my guess is the majority of new drivers are embedded
> things. I strongly suspect entire use cases, like a hypervisor kernel,
> server, etc, will see no/minimal Rust adoption or security improvement
> at all as there is very little green field / driver work there that
> could be in Rust.
> 
> Meaning, if you want to make the security argument strong you must
> also argue for strategically rewriting existing parts of the kernel,
> and significantly expanding the Rust footprint beyond just drivers. ie
> more like binder is doing.
> 
> I think this is also part of the social stress here as the benefits of
> Rust are not being evenly distributed across the community.

Drivers is the biggest part of the Linux kernel and has the biggest churn.
A lot of them are "drive by" submissions too (Let's add a driver for our
new device and work on something else). These are written by people that
are not kernel maintainers but just people trying to get their devices
working on Linux. That means they are the ones to introduce the most bugs
that Rust would likely prevent.

I was going through my own bugs to see how much Rust would help, and the
percentage was rather small. I did have a few ref counter bugs. Not the
kind for freeing, but for which left things in a state that the system
couldn't be modified (the ref count was to lock access). I'm not sure Rust
would have solved that.

So most of the bugs were accounting issues. I found a couple that were
memory safety bugs but those are not as common. I guess that's because I do
test with kmemleak which will usually detect that.

Perhaps I wouldn't need to do all the memory tests if I wrote the code in
Rust? But that's not what you are asking. As a maintainer of core code, I
run a lot of tests before sending to Linus. Which I would hope keeps the
number of bugs I introduce to a minimum. But I can't say the same for the
driver code. That's a much different beast, as to test that code, you also
need the hardware that the driver is for.

I do feel that new drivers written in Rust would help with the
vulnerabilities that new drivers usually add to the kernel.

-- Steve

