Return-Path: <linux-kernel+bounces-447395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554729F319B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51255188A75D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB636205AA8;
	Mon, 16 Dec 2024 13:32:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A53FD4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355973; cv=none; b=LofF27UDQVlo3lCIEqP5rGJnT25ow9Rb40UlioHYcqYJRnuHyBNsQL+tePPczqxZkhjkOa3LgbBkqnj62bmvaA9uJbLL9JGHti2l2EaM3UZ5mY73kLzjbx8bxPLRxnPFwYTd4L8wbgXZLl9OaUHZgS1bWUd+fFVNxVctLkl3lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355973; c=relaxed/simple;
	bh=Gqw2Rmmp3L7ugK/15rZY0VOdjFzQF0dBkDVeZZmUe8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUATimQU15kZnxNAA0+Q15CPk9C01929KYxPkr2v+2j27AH+yiM6TBEKZGSHFz63dxlsNDA/3FgFv4n2umxNp1Dz96YY+gzQU5XUsG2QwWDswKzg8OwnfiUMpL6kw6cGZfeB5AFKlcpERpJCXh0PnHlAaX0gcMOKDi8nfTzdtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F4AC4CED0;
	Mon, 16 Dec 2024 13:32:52 +0000 (UTC)
Date: Mon, 16 Dec 2024 08:33:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241216083324.5b2677f4@gandalf.local.home>
In-Reply-To: <20241215202404.06f7be8f@batman.local.home>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
	<CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
	<20241215202404.06f7be8f@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 20:24:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Isn't every single case of '%p' in this context from a TP_printk() situation?
> > 
> > IOW, instead of dynamically creating a temporary buffer and adding
> > that 'x' by hand, why wasn't that just a 'sed' script and done
> > statically?
> > 
> > In fact, wouldn't *most* of the sanity checking be possible to just do
> > entirely statically instead of at runtime?
> > 
> > Yeah, yeah, there's more than a few '%p' users, but
> > 
> >      git grep 'TP_printk.*%p[^A-Za-z]' | wc
> > 
> > shows that it's manageable. That probably misses some multi-line
> > cases, but still - doing this kind of "rewrite constant string at
> > runtime because we didn't do it statically" seems *wrong*.
> > 
> > And in this case, that wrongness was literally the cause of the bug.  
> 
> I'm also OK with that. Should that be done for 6.13 or something to be
> added for 6.14?

One issue with just doing it manually, is that it would need to be
maintained, as one or two "%p" are added per release cycle.

-- Steve

