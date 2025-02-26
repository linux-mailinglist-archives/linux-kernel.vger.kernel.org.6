Return-Path: <linux-kernel+bounces-534853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1976A46BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8064316ED45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0008266196;
	Wed, 26 Feb 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="Yp7bCQt9"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77332262D12;
	Wed, 26 Feb 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600024; cv=none; b=QkJnk05XsdE+pOiQid2OqKzlQMgDCUxmPe0jXEBvNNgZUXbBOW7ND5bXX8BmqqlsTSGRVsPA/vi7k0mwbXf/42e8qxnK2dX6cEJ8HMJlt1EgPXmajCwCBd/B2WVD3Qg1P7HeM8fbNEHsThcY10DVXYAKeFFB51s2Jy8zQ9kxKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600024; c=relaxed/simple;
	bh=LfFyrdi3p+fSTlPHrvITPMsJFwZas28Qz09A3L/Dt2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ka/KoOyW2JNexXIEKgyOFOV3TN/XDGllJ42SSQlR6jpCpk9Rsx8OcmqDoE5CRjxPdZ9UXIWpk+Y6s58NPm8xRq/q2gAKwrdCjeCtwYNpLqyH+0D7k8QN6/ZN8BGkRAcprnOn4H6BrZnXJUxMXHXj4iryX+Tvf3KrTqupitSagfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=Yp7bCQt9; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-88.tugraz.at (vra-172-88.tugraz.at [129.27.172.88])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z351857Byz1LZ2f;
	Wed, 26 Feb 2025 21:00:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z351857Byz1LZ2f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740600013;
	bh=DyLAPIgkUJPj4u0uXbf2C16aXcYlu8baPQSuG9CxPYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yp7bCQt9ubJfwFb6RLXQoQ2iF5g/w2OVyds54oY3Rimlx6/LDvY/YUtNAwWZrcKm6
	 cT9oFvaKnAUgwCuut3b0wXxHyZG8gloiuv1sZfSUoKdrDV4ObFcW5ZqN8sQ2V+qXHM
	 Se6XM69pLGSe8IT4WapgJeB6ppitPv/Ausjq0Jlo=
Message-ID: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung
 <post@ralfj.de>,  "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Ventura Jack
 <venturajack85@gmail.com>,  Kent Overstreet <kent.overstreet@linux.dev>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
 rust-for-linux@vger.kernel.org
Date: Wed, 26 Feb 2025 21:00:12 +0100
In-Reply-To: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
References: 
	<CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	 <20250222141521.1fe24871@eugeo>
	 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Mittwoch, dem 26.02.2025 um 09:59 -0800 schrieb Linus Torvalds:
> On Wed, 26 Feb 2025 at 05:54, Ralf Jung <post@ralfj.de> wrote:
> >=20
> >      The only approach we know that we can actually
> > pull through systematically (in the sense of "at least in principle, we=
 can
> > formally prove this correct") is to define the "visible behavior" of th=
e source
> > program, the "visible behavior" of the generated assembly, and promise =
that they
> > are the same.
>=20
> That's literally what I ask for with that "naive" code generation, you
> just stated it much better.

The model is exactly the same as in C.  One defines "observable
behavior" (to use C terminology) and compiler can do whatever it
wants as long as it preserves this.=20

Regarding undefined behavior, the idea the C standard had originally
was that compilers do something "naive" (e.g. what the architecture
does for some operation) or at least reasonable.  This worked well
until modern optimizers started rather aggressively exploit
that there is UB. C and Rust are are in the same boat here.

As Ralf said, the difference is that Rust makes it much harder to
accidentally trigger UB.


>=20
> I think some of the C standards problems came from the fact that at
> some point the standards people decided that the only way to specify
> the language was from a high-level language _syntax_ standpoint.
>=20
> Which is odd, because a lot of the original C semantics came from
> basically a "this is how the result works". It's where a lot of the
> historical C architecture-defined (and undefined) details come from:
> things like how integer division rounding happens, how shifts bigger
> than the word size are undefined, etc. But most tellingly, it's how
> "volatile" was defined.

Compiler changed here, not the C standard.  Of course, later the
compiler people in ISO WG14 may have pushed back against=C2=A0
*removing* UB or even clarifying things (e.g. TS 6010 is not in C23
because compiler people want to evaluate the impact on optimization
first)

>=20
> I suspect that what happened is that the C++ people hated the volatile
> definition *so* much (because of how they changed what an "access"
> means), that they then poisoned the C standards body against
> specifying behavior in terms of how the code *acts*, and made all
> subsequent C standards rules be about some much more abstract
> higher-level model that could not ever talk about actual code
> generation, only about syntax.

At least since C89 the model did not change.
For example, see "5.1.2.3 Program execution" in this draft
for C89:

https://www.open-std.org/JTC1/sc22/wg14/www/docs/n1256.pdf


C++ was not standardized until 1998.

> And that was a fundamental shift, and not a good one.
>=20
> It caused basically insurmountable problems for the memory model
> descriptions. Paul McKenney tried to introduce the RCU memory model
> requirements into the C memory model discussion, and it was entirely
> impossible. You can't describe memory models in terms of types and
> syntax abstractions. You *have* to talk about what it means for the
> actual code generation.

The C model for concurrency indeed came to C11 from C++.  It is defined
in terms of accesses to memory objects and when those accesses
become visible to other threads.
>=20
> The reason? The standards people wanted to describe the memory model
> not at a "this is what the program does" level, but at the "this is
> the type system and the syntactic rules" level. So the RCU accesses
> had to be defined in terms of the type system, but the actual language
> rules for the RCU accesses are about how the data is then used after
> the load.

If your point is that this should be phrased in terms of atomic
accesses instead of accesses to atomic objects, then I absolutely
agree with you.  This is something I tried to get fixed, but it
is difficult. The concurrency work mostly happens in WG21=20
and not WG14.

But still, the fundamental definition of the model is in terms
of accesses and when those become visible to other threads, and
not in terms of syntax and types.

>=20
> (We have various memory model documentation in
> tools/memory-model/Documentation and that goes into the RCU rules in
> *much* more detail, but simplified and much shortened: a
> "rcu_dereference()" could be seen as a much weaker form of
> "load_acquire": it's a barrier only to accesses that are
> data-dependencies, and if you turn a data dependency into a control
> dependency you have to then add specific barriers.
>=20
> When a variable access is no longer about "this loads this value from
> memory", but is something much more high-level, trying to describe
> that is complete chaos. Plus the description gets to be so abstract
> that nobody understands it - neither the user of the language nor the
> person implementing the compiler.
>=20
> So I am personally - after having seen that complete failure as a
> by-stander - 100% convinced that the semantics of a language *should*
> be defined in terms of behavior, not in terms of syntax and types.
> Sure, you have to describe the syntax and type system *too*, but then
> you use those to explain the behavior and use the behavior to explain
> what the allowable optimizations are.
>=20
> > So the Rust compiler promises nothing about the shape of the assembly
> > you will get, only about its "visible" behavior
>=20
> Oh, absolutely. That should be the basic rule of optimization: you can
> do anything AT ALL, as long as the visible behavior is the same.
>=20
> > (and which exact memory access occurs when is generally
> > not considered "visible").
>=20
> .. but this really has to be part of it. It's obviously part of it
> when there might be aliases, but it's also part of it when there is
> _any_ question about threading and/or memory ordering.
>=20
> And just as an example: threading fundamentally introduces a notion of
> "aliasing" because different *threads* can access the same location
> concurrently. And that actually has real effects that a good language
> absolutely needs to deal with, even when there is absolutely *no*
> memory ordering or locking in the source code.
>=20
> For example, it means that you cannot ever widen stores unless you
> know that the data you are touching is thread-local. Because the bytes
> *next* to you may not be things that you control.
>=20
> It also *should* mean that a language must never *ever* rematerialize
> memory accesses (again, unless thread-local).
>=20
> Seriously - I consider memory access rematerialization a huge bug, and
> both a security and correctness issue. I think it should be expressly
> forbidden in *any* language that claims to be reliablel.
> Rematerialization of memory accesses is a bug, and is *hugely* visible
> in the end result. It introduces active security issues and makes
> TOCTOU (Time-of-check to time-of-use) a much bigger problem than it
> needs to be.

Rematerialization or widening is essentially forbidden by=C2=A0
the C++ / C memory model.

>=20
> So memory accesses need to be part of the "visible" rules.
>=20
> I claim that C got that right with "volatile". What C got wrong was to
> move away from that concept, and _only_ have "volatile" defined in
> those terms. Because "volatile" on its own is not very good (and that
> "not very good" has nothing to do with the mess that C++ made of it).

I don't get your point. The compiler needs to preserve
observable behavior (which includes volatile accesses), while
the concurrency model is defined in terms of visibility of
stored values as seen by loads from other threads.  This
visibility does not imply observable behavior, so all non-volatile
accesses do not have to be preserved by optimizations. Still this
model fundamentally constrains the optimization, e.g. by ruling
out the widening stores you mention above.   I think this is
basically how this *has* to work, or at least I do not see how
this can be done differently.=20

I think C++ messed up a lot (including time-travel UB, uninitialized
variables, aliasing ules and much more), but I do not see
the problem here.


Martin



=20



