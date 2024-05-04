Return-Path: <linux-kernel+bounces-168842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD58BBEB7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7222822AC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D184DEF;
	Sat,  4 May 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiBjUSU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED684A37
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714861057; cv=none; b=FpMG2rox4m84e+uUA875+LuqUJGjTkcGwqU9UvasyqF8c9tlP1yJ5hXURHV7OtfwyF0BBoZtVrXd3vujDaBC1yU6nm7TE2mWxf3GxH8yf82iUoC7Nw59V1Raz61ybJ82KS6PcjSL0gfjZeBLFWocvEJ+lZC0n/Udfc4O6BU3h6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714861057; c=relaxed/simple;
	bh=upHKd08o+Ou1Lblw4gOXnZeF1CD2NWpIaEij3oKJwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjpkSYuX3e3lNFUcn5IkUa6WF33rt2OSkLL41QvvG+MncS/n1/C6bVn+H7jrsy5mXkhak0T+YyJSiEj4YhGCwpN56LFPdf3AEll4cAo4PmxP6kJJ6OrpJbqpUWhzq6EDUUtygZaXhcOhA6sAtdKxoEvYPc8CjaOKSVY9IcYYtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiBjUSU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC5BC072AA;
	Sat,  4 May 2024 22:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714861057;
	bh=upHKd08o+Ou1Lblw4gOXnZeF1CD2NWpIaEij3oKJwJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qiBjUSU7xROJZZUBVRh6vnS94/TC+VBTtCwfYQ3pN+BxDJ1dMl6V4SoFJXT5+zyQ0
	 AkwCJ3lckTVghSn+uCBNbiNh8FMrcUVWJ3gnbAEu19OL1D8sUEMAicd7lMVjLThaCO
	 LRpubCtY0tTMmTKttmzGpnRaAKgu5aBIVMZvK25ccwmW1j0oiKsAfwCE5jUffK29FO
	 PQCPBdmbMWjpreO/6gSQ5JTD1uxf40Xr6nlk+XWvjxsMgG7EQXwdPi4HJDC1Nzdchz
	 TBlcnnAHSriFnVLSXDWxUY26MeZNQSp+wmZVYkz6nt6ZeZkTtZgP7S92igR6pgzNfV
	 IaYAfof7LjrpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DB35ECE0F69; Sat,  4 May 2024 15:17:36 -0700 (PDT)
Date: Sat, 4 May 2024 15:17:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <3f132208-12a2-4821-bf32-8c8569c632fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux>
 <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
 <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
 <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
 <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop>
 <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
 <CAHk-=wgMzXHHxaAu8V1AyWLtPGwNZxbqm6_7j33zkziikFHFYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMzXHHxaAu8V1AyWLtPGwNZxbqm6_7j33zkziikFHFYg@mail.gmail.com>

On Sat, May 04, 2024 at 12:25:12PM -0700, Linus Torvalds wrote:
> On Sat, 4 May 2024 at 12:11, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Anyway, the above are all normal optimizations that compilers
> > *already* do, and the only real issue is that with memory ordering,
> > the "dominance" thing will need to take into account the ordering
> > requirements of other memory operations with stricter memory ordering
> > in between. So, for example, if you have
> >
> >     __atomic_store_n(ptr,1, RELAXED);
> >     __atomic_load_n(otherptr,2, ACQUIRE);
> >     __atomic_store_n(ptr,2, RELAXED);

I am assuming that I should ignore the "2," in that load.

> > then the second store doesn't dominate the first store, because
> > there's a stricter memory ordering instruction in between.
> 
> Actually, that was a bad example, because in that pattern, the second
> store does actually dominate (the second store can not move up beyond
> the ACQUIRE, but the first store can indeed move down after it, so
> dominance analysis does actually allow the second store to strictly
> dominate the first one).

Agreed, and the stores can be combined as a result of the fact that
the two stores can be reordered to be adjacent to one another.

> So the ACQUIRE would need to be SEQ for my example to be valid.

And here the C and C++ memory models get very strange due to mixing
memory_order_seq_cst and non-memory_order_seq_cst.

But if there was a Linux-kernel smp_mb() immediately after that first
store, then the compiler would not be allowed to combine the two stores.
Though that is true regardless because of the smp_mb()'s barrier().

> Of course, usually the barrier that stops domination is something
> entirely different. Even without an actual conditional (which is
> almost certainly the most common reason why dominance goes away), it
> might be a function call (which could do any arbitrary memory ordering
> operations - there was a clang bug in this very case) or something
> like an explicit full memory barrier.

If there was something like, then the two stores could not be combined,
from what I can see.

    __atomic_store_n(ptr,1, RELAXED);
    __atomic_load_n(otherptr, ACQUIRE);
    __atomic_store_n(otherptr, 4, RELEASE);
    __atomic_store_n(ptr,2, RELAXED);

I freely confess that I don't know how to map that into dominance
relations, which means that I have no idea what this example means
in terms of your rules.

> Anyway, take that email as a "written in the MUA on the fly". There
> might be other thinkos in there. But I think the big picture was
> right.

If things go as they usually do, there will be quite a few litmus tests
between here and something credible.  ;-)

Thank you for the tutorial on dominance in CFGs!

							Thanx, Paul

