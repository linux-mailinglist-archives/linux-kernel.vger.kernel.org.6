Return-Path: <linux-kernel+bounces-446569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81299F2653
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F307A1541
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96E1BC062;
	Sun, 15 Dec 2024 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cQD8nKXU"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97B653
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298860; cv=none; b=HVzNQWFVqSftRBZ4z9p5ywpAGnJE/XqeIQVZO1RyQ2Uf8bv770kwSN8H+8T5QpEp3sZEnVKc1gQ2QNF//pK2sPonNemvcsEPdnJNJh7hxRa/OTY6EvRNy6sOKuosMzoVzdaXjUyCvrkuPOa7jiA3pnXdZo+J8WCpdI+UY7v3zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298860; c=relaxed/simple;
	bh=le68SKdbovYRlaBqdLSMVHDWCk7xa2fF1VtPDqcpaAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUl9rzPCysbFbDNH7P5kC68MZ/yACH+wCUMKuZJgt8LjJdWbNoRXItxcOVgclG6RgwyDhv8dADapVn+eUkxh8+KO8GytEOzBzQc02taLXdl7uf3N9u/AfAx5UT3CHlTYv4qGGVEf0GAfr+K51X5QXGyHB+AS/GKS1adEFhhNKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cQD8nKXU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BFLeYvJ028375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 16:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734298838; bh=KYI4juDWrmuPbnV9ZmNP/drHexJeHBaaJkqLdNfG4k0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cQD8nKXUesZDUjjAKNC1qfNsururjWb4+I7O3e9NkH11e1Nf1xfoHUSLIhQrE4y7K
	 kY0Zu4Dxoi2cJpMUUjWt3EpqHODz2glYFUCzZ1+nm4qGdNJfGrSwgiYJis0a+yUHLy
	 KMQ/byg3vIoKcWvNC+kDKmuy0KyuWZ4lijHClZB0wI3DzcvZ1bHuLoOWrvX4RdSSnL
	 ETF+E03+gAOxmofA0nLDQJk6GXsWZPONQYTUoA5xNEeLUq9HH4wUDx2RFkcAWU/xnU
	 qXPZ6ai34KyXZVrYiMPhjDhUq2LhTHDUziIj95to3KY7f8JeEIwh9nfiQQTyplQhCq
	 z5BuCoyoFQ3Zw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5E2EA15C4656; Sun, 15 Dec 2024 16:40:34 -0500 (EST)
Date: Sun, 15 Dec 2024 16:40:34 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215214034.GE2472262@mit.edu>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>

On Sun, Dec 15, 2024 at 09:23:18AM -0800, Linus Torvalds wrote:
> 
> You are literally mis-using va_list. The code is *wrong*. It depends
> on the exact calling convention of varargs, and just happens to work
> on many platforms.

It seems to me that the disagreement is fundamentally about whether we
can depend on implementation details, or the formal abstraction of
interfaces like varargs.  One school of thought is that we should only
depend on the formally defined abstraction, so that we are proof
against random breakage cauesed by compilers trying to win
benchmarketing wars by proving that they are 0.001% faster because
that makes a big deal when you can advertise on the back cover of
Businessweek.  (OK, that's really more a trick that enterprise
databases play, but you get the point.)

The other school of thought is that when trying to squeeze every last
cycle of performance (because *we* are the ones engaging in
benchmarketing wars), it's fair game to depend on implementation
details if it gets us a sufficiently large performance advantage, or
if it allows us to preserve interface semantics (perhaps for something
which was imprudently guaranteed by us when we or the code was younger
and more foolish, but we really don't want to break programs depending
on the current semantics).

I've been on both sides of this debate, although when I do the second,
it's often because I know something specific about my operating
environment (such as $WORK's data centers will *never* worry about
using big endian systems, or some such).  I *have* gotten in trouble
when I do this, so these days I insist on doumenting with big red
flags what abstractions I am violating, and the justification for
doing this, and adding tests that check to make sure that the
assumptions I am making won't suddenly break with a new version of the
compiler, or when someone tries to do something like introduce Rust
bindings, that might not know about the terrible assumptions we are
making.

I'm not convinced that it's worth it in this particular case, so I
think I side with Linus here; maybe all of this hackery isn't worth
it?  Steven, what am I missing?  Why did we go down this particular
path in the first place?  I assume there must have been something that
seemed like a good reason at the time?

						- Ted


