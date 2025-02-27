Return-Path: <linux-kernel+bounces-535697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E829FA47624
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63E416F70E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B244A1A;
	Thu, 27 Feb 2025 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="lynlg9ZH"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4431E833E;
	Thu, 27 Feb 2025 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639428; cv=none; b=u1btpgV7G1YeL6P2KLpBUQulO3yDyENdAn/r4Lke25njoPOvFDfopdXZk2gc71kehIJ0PS3KQWcWlqdGSGDIV/VF0VTMb32UAKCw7xPYgWHNc8fxYMfaePWRIqWUfjzEiubnn1aYf215Q/hnKS0rXq38wm9t6+kSo5+KvSNlN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639428; c=relaxed/simple;
	bh=nmSc/GUKLRnUp0bGH7keGs76rS9T9zwENIZjDs5RBLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8vLQpm0dZDIBnP1IgsyOt+KkeSpr3P/qSS8SOMN+Ax0lDo2F+qmDAL3mOZjYjah87uNflBnh5KKYF0w3z1ryHzjvBuxVmvKAHnqNwqux80wCpp75ScCqfkJusnf0vAEkGXmRH4zkm+Y52PB6/JdwPEIZYruqCd/z7L6Onk3cRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=lynlg9ZH; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-173-30.tugraz.at (vra-173-30.tugraz.at [129.27.173.30])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z3MZm0CWTz1JJBS;
	Thu, 27 Feb 2025 07:56:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z3MZm0CWTz1JJBS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740639410;
	bh=D8QBXAzvQoC+Xb07K7j1VN6BMzujnFc52lhvda6IFIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lynlg9ZH44Ovzhy2q+sNNR/xiRa23CARDp62OJZw4H2QJVlTR1iiG6RKW4ig0laXs
	 1L1XtaI8+uJRJ86NBpyL3i3Iw1+accZgTWyGwLLAWGk3ITFWCHnmXRpyeKB/8AORam
	 Ka0+/eYIXg3dOTps51k7FRs363+kw0uMGftS+ud0=
Message-ID: <2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
Subject: Re: C aggregate passing (Rust kernel policy)
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,  boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de,  gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Date: Thu, 27 Feb 2025 07:56:47 +0100
In-Reply-To: <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
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
	 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
	 <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
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
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Mittwoch, dem 26.02.2025 um 21:52 -0800 schrieb Linus Torvalds:
> On Wed, 26 Feb 2025 at 20:18, Martin Uecker <uecker@tugraz.at> wrote:
> >=20
> > This is not really related to "observable" but to visibility
> > of stores to other threads.
>=20
> Yes? What's the difference?

Observable is I/O and volatile accesses.  These are things considered
observable from the outside of a process and the only things an
optimizer has to preserve. =C2=A0

Visibility is related to when stores are visible to other threads of
the same process. But this is just an internal concept to give
evaluation of expressions semantics in a multi-threaded=C2=A0
program when objects are accessed from different threads. But=C2=A0
the compiler is free to change any aspect of it, as=C2=A0 long as the=C2=A0
observable behavior stays the same.

In practice the difference is not so big for a traditional
optimizer that only has a limited local view and where
"another thread" is basically part of the "outside world".

I personally would have tried to unify=C2=A0this more, but this
was a long time before I got involved in this.

>=20
> Threading is a fundamental thing. It didn't *use* to be fundamental,
> and yes, languages and CPU architectures were designed without taking
> it into account.
>=20
> But a language that was designed this century, wouldn't you agree that
> threading is not something unusual or odd or should be an
> after-thought, and something as basic as "observable" should take it
> into account?
>=20
> Also note that "visibility of stores to other threads" also does mean
> that the loads in those other threads matter.

I agree that this could have been done better.  This was bolted
on retrospectively and in a non-optimal way.
>=20
> That's why rematerializing loads is wrong - the value in memory may
> simply not be the same value any more, so a load that is
> rematerialized is a bug.

I assume that compromises were made very deliberately
to require only limited changes to compilers designed for=C2=A0
optimizing single-threaded code. =C2=A0 This could certainly be
reconsidered.

>=20
> > It sounds you want to see the semantics strengthened in case
> > of a data race from there being UB to having either the old
> > or new value being visible to another thread, where at some
> > point this could change but needs to be consistent for a
> > single access as expressed in the source code.
>=20
> Absolutely.
>=20
> And notice that in the non-UB case - ie when you can rely on locking
> or other uniqueness guarantees - you can generate better code.

A compiler would need to understand that certain objects are
only accessed when protected somehow.  Currently this is
assumed for everything.  If you want to strengthen semantics
for all regular memory accesses, but still allow more optimization
for certain objects, one would need to express this somehow,
e.g. that certain memory is protected by specific locks.

>=20
> So "safe rust" should generally not be impacted, and you can make the
> very true argument that safe rust can be optimized more aggressively
> and migth be faster than unsafe rust.
>=20
> And I think that should be seen as a feature, and as a basic tenet of
> safe vs unsafe. A compiler *should* be able to do better when it
> understands the code fully.
>=20
> > There would certainly be opposition if this fundamentally
> > diverges from C++ because no compiler framework will seriously
> > consider implementing a completely different memory model
> > for C (or for Rust) than for C++.
>=20
> Well, if the C++ peoiple end up working on some "safe C" model, I bet
> they'll face the same issues.

I assume they will enforce the use of safe high-level
interfaces and this will not affect the memory model.

>=20
> > I could also imagine that the problem here is that it is
> > actually very difficult for compilers to give the guarantess
> > you want, because they evolved from compilers
> > doing optimization for single threads and and one would
> > have to fix a lot of issues in the optimizers.  So the
> > actually problem here might be that nobody wants to pay
> > for fixing the compilers.
>=20
> I actually suspect that most of the work has already been done in practic=
e.
>=20
> As mentioned, some time ago I checked the whole issue of
> rematerializing loads, and at least gcc doesn't rematerialize loads
> (and I just double-checked: bad_for_rematerialization_p() returns true
> for mem-ops)
>=20
> I have this memory that people told me that clang similarly
>=20
> And the C standards committee already made widening stores invalid due
> to threading issues.

That widening stores are not allowed is a consequence
of the memory model when only using local optimization.
There are not explicitely forbidden, and an optimizer that
could see that it does not affect global observable behavior
could theoretically then widen a store where this is safe,
but in practice no compiler can do such things.

>=20
> Are there other issues? Sure. But remat of memory loads is at least
> one issue, and it's one that has been painful for the kernel - not
> because compilers do it, but because we *fear* compilers doing it so
> much.

I will talk to some compiler people.

Martin






