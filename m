Return-Path: <linux-kernel+bounces-168839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA40F8BBEAC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4D01C20CF3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 22:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86884D25;
	Sat,  4 May 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cla/Usr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885717578
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714860290; cv=none; b=sjByXOoiqCm1I6e31W5bSe3YDk4R659rVQLIfRyHNc2k7Z+uP6Om6XlGjDjKqxfUw7a13lYfADIN5Vy3qy7bJ2vNNQaYazO88vHRdd2bpcLKh90ohxezMVJLRq4qAUDaj7xXs4jhPwRN2EaPg9n/G/HccLYfenDFIq4oNiKiyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714860290; c=relaxed/simple;
	bh=4Py6m4XGMvJ2PXCrrMrOIuNk4bqqhMkFjVEJvQgSzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpcYPJ/mZENB/0nlnw3tzbr3UQaXXfOymfKYxhmjkhaIpXXtpYlQTbsYZ9gSe5JSfykKOhLh5NReHLM0j8ztuIojUi45D5ErIZT8a2PPVWYnWWlGN/IdluSxksBP0kFiGcu97orS7cGtphSmV5e/PxypJgXElDslAFxdJ9ICMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cla/Usr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8977EC072AA;
	Sat,  4 May 2024 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714860289;
	bh=4Py6m4XGMvJ2PXCrrMrOIuNk4bqqhMkFjVEJvQgSzv0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cla/Usr1/gh/KtfiF1aVHs56AEOWiP17FloUOyqpvVFBkgVRnt5fZRGn4Hw9uPDc/
	 eLykVPOSxea0xBnUTBrM61bWPJ+N030ONPa+ZOLxN3C4eFQHS5AWkP5dTkA2Hm6N09
	 1sIKR0kyb3hCoDN8P8xc3nd2oYMhQzpNZxeshu6fGHisj3J3HUTNME56grLDbZRlwL
	 MLyAQB4OeKAqAFOYgPIGSwzNZiwlThDXpINIBNNe15EIaytZngZ2jGU+leCPhJT4Bf
	 WO2mDx17OY0DGLKJX9rBFNckJGRyMs+QdEtiXiJWr9eow65q5WaiD/g5AW7ultrNHo
	 UEZ/qRU/V2S5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 228FDCE0F69; Sat,  4 May 2024 15:04:49 -0700 (PDT)
Date: Sat, 4 May 2024 15:04:49 -0700
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
Message-ID: <37195203-9a13-46aa-9cc0-5effea3c4b0e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux>
 <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
 <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
 <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
 <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop>
 <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>

On Sat, May 04, 2024 at 12:11:10PM -0700, Linus Torvalds wrote:
> On Sat, 4 May 2024 at 11:18, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Here is my current thoughts for possible optimizations of non-volatile
> > memory_order_relaxed atomics:
> >
> > o       Loads from the same variable that can legitimately be
> >         reordered to be adjacent to one another can be fused
> >         into a single load.
> 
> Let's call this "Rule 1"
> 
> I think you can extend this to also "can be forwarded from a previous store".

Agreed, with constraints based on intervening synchronization.

> I also think you're too strict in saying "fused into a single load".
> Let me show an example below.

I certainly did intend to make any errors in the direction of being
too strict.

> > o       Stores to the same variable that can legitimately be
> >         reordered to be adjacent to one another can be replaced
> >         by the last store in the series.
> 
> Rule 2.
> 
> Ack, although again, I think you're being a bit too strict in your
> language, and the rule can be relaxed.
> 
> > o       Loads and stores may not be invented.
> 
> Rule 3.
> 
> I think you can and should relax this. You can invent loads all you want.

I might be misunderstanding you, but given my understanding, I disagree.
Consider this example:

	x = __atomic_load(&a, RELAXED);
	r0 = x * x + 2 * x + 1;

It would not be good for a load to be invented as follows:

	x = __atomic_load(&a, RELAXED);
	invented = __atomic_load(&a, RELAXED);
	r0 = x * x + 2 * invented + 1;

In the first example, we know that r0 is a perfect square, at least
assuming that x is small enough to avoid wrapping.  In the second
example, x might not be equal to the value from the invented load,
and r0 might not be a perfect square.

I believe that we really need the compiler to keep basic arithmetic
working.

That said, I agree that this disallows directly applying current
CSE optimizations, which might make some people sad.  But we do need
code to work regardless.

Again, it is quite possible that I am misunderstanding you here.

> > o       The only way that a computation based on the value from
> >         a given load can instead use some other load is if the
> >         two loads are fused into a single load.
> 
> Rule 4.
> 
> I'm not convinced that makes sense, and I don't think it's true as written.
> 
> I think I understand what you are trying to say, but I think you're
> saying it in a way that only confuses a compiler person.
> 
> In particular, the case I do not think is true is very much the
> "spill" case: if you have code like this:
> 
>     a = expression involving '__atomic_load_n(xyz, RELAXED)'
> 
> then it's perfectly fine to spill the result of that load and reload
> the value. So the "computation based on the value" *is* actually based
> on "some other load" (the reload).

As in the result is stored to a compiler temporary and then reloaded
from that temporary?  Agreed, that would be just fine.  In contrast,
spilling and reloading from xyz would not be good at all.

> I really *REALLY* think you need to explain the semantics in concrete
> terms that a compiler writer would understand and agree with.

Experience would indicate that I should not dispute sentence.  ;-)

> So to explain your rules to an actual compiler person (and relax the
> semantics a bit) I would rewrite your rules as:
> 
>  Rule 1: a strictly dominating load can be replaced by the value of a
> preceding load or store
> 
>  Ruie 2: a strictly dominating store can remove preceding stores
> 
>  Rule 3: stores cannot be done speculatively (put another way: a
> subsequent dominating store can only *remove* a store entirely, it
> can't turn the store into one with speculative data)
> 
>  Rule 4: loads cannot be rematerialized (ie a load can be *combined*
> as per Rule 1, but a load cannot be *split* into two loads)

I still believe that synchronization operations need a look-in, and
I am not sure what is being dominated in your Rules 1 and 2 (all
subsequent execution?), but let's proceed.

> Anyway, let's get to the examples of *why* I think your language was
> bad and your rules were too strict.
> 
> Let's start with your Rule 3, where you said:
> 
>  - Loads and stores may not be invented
> 
> and while I think this should be very very true for stores, I think
> inventing loads is not only valid, but a good idea. Example:
> 
>     if (a)
>         b = __atomic_load_n(ptr) + 1;
> 
> can perfectly validly just be written as
> 
>     tmp = __atomic_load_n(ptr);
>     if (a)
>         b = tmp+1;
> 
> which in turn may allow other optimizations (ie depending on how 'b'
> is used, the conditional may go away entirely, and you just end up
> with 'b = tmp+!!a').
> 
> There's nothing wrong with extra loads that aren't used.

From a functional viewpoint, if the value isn't used, then agreed,
inventing the load is harmless.  But there are some code sequences where
I really wouldn't want the extra cache miss.

> And to make that more explicit, let's look at Rule 1:
> 
> Example of Rule 1 (together with the above case):
> 
>     if (a)
>         b = __atomic_load_n(ptr) + 1;
>     else
>         b =  __atomic_load_n(ptr) + 2;
>     c = __atomic_load_n(ptr) + 3;
> 
> then that can perfectly validly re-write this all as
> 
>     tmp = __atomic_load_n(ptr);
>     b = a ? tmp+1 : tmp+2;
>     c = tmp + 3;
> 
> because my version of Rule 1 allows the dominating load used for 'c'
> to be replaced by the value of a preceding load that was used for 'a'
> and 'b'.

OK, I thought that nodes early in the control-flow graph dominated
nodes that are later in that graph, but I am not a compiler expert.

In any case, I agree with this transformation.  This is making three
loads into one load, and there is no intervening synchronization to gum
up the works.

> And to give an example of Rule 2, where you said "reordered to be
> adjacent", I'm saying that all that matters is being strictly
> dominant, so
> 
>     if (a)
>         __atomic_store_n(ptr,1);
>     else
>         __atomic_store_n(ptr,2);
>     __atomic_store_n(ptr,3);
> 
> can be perfectly validly be combined into just
> 
>     __atomic_store_n(ptr,3);
> 
> because the third store completely dominates the two others, even if
> in the intermediate form they are not necessarily ever "adjacent".

I agree with this transformation as well.  But suppose that the code
also contained an smp_mb() right after that "if" statement.  Given that,
it is not hard to construct a larger example in which dropping the first
two stores would be problematic.

> (Your "adjacency" model might still be valid in how you could turn
> first of the first stores to be a fall-through, then remove it, and
> then turn the other to be a fall-through and then remove it, so maybe
> your language isn't _tecnically_ wrong, But I think the whole
> "dominating store" is how a compiler writer would think about it).

I was thinking in terms of first transforming the code as follows:

	if (a) {
		__atomic_store_n(ptr,1);
		__atomic_store_n(ptr,3);
	} else {
		__atomic_store_n(ptr,2);
		__atomic_store_n(ptr,3);
	}

(And no, I would not expect a real compiler to do this!)

Then it is clearly OK to further transform into the following:

	if (a) {
		__atomic_store_n(ptr,3);
	} else {
		__atomic_store_n(ptr,3);
	}

At which point both branches of the "if" statement are doing the
same thing, so:

	__atomic_store_n(ptr,3);

On to your next email!

							Thanx, Paul

