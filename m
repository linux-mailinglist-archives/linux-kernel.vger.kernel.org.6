Return-Path: <linux-kernel+bounces-538903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B9A49EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749847A95F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3627293D;
	Fri, 28 Feb 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAmqQvx7"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D017A2E8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759730; cv=none; b=p3v1xEF9jkRMECWUCbWvpanG2CU91OWyPn2qJYxpB+gSA2uHXst9HQWPEdH6eSEzBnCjHnbf4LsTI40N/tWBsTBpSeGnrEuHknY1dpov9RqdXMmyZiYFsjHSBuQ2R+l0vjRXKmaHqUmlfLRZrzaw5y1gpvSgdQ+MftWWSsLmkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759730; c=relaxed/simple;
	bh=mOh36F/FeSkCgHWlr2jtMP4f+QGrB7mDuoTaTfqRy9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi6R/ltDVh6tblo1Eebs9OMP3KU6ukq+9O1G7V0p5DO0nAvm2s9zp2E4jksmHWXzfaw1BP1EpX4JewI6GaHBGrHwPuHNsjE93ouDOkKm+FZSF0zn6besbDUtBI1LgRoVa4qT/64JxqSOIasIzoJNn1gF+TLtIVtKaBsT4Poc3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAmqQvx7; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 11:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740759716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzKc3rBUKoHHye8u6hnRwGozyJjYumTyHV57CCW+rTs=;
	b=SAmqQvx7xn1SLBOUbdz0Ny3Hp3tZf5lg+rBdIHk06M54E0RMHrg9JThfULp1L0pzA04PUW
	W+uDMW9P6aQ2vsFLiWpdi3WUBrfr+XpNTe3dn0aysJ3gGEa6X3mzv9+ZiSb27hP2vf+ItP
	4BPlJNl/NWKFo3SQoeJ7p/eH4RCeYIg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, David Laight <david.laight.linux@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <p4bawegz52nu3v2l25gnj5gh34patcxeggcdbom327wh3dhxyq@cp735olb55ps>
References: <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
 <Z8HaT4X4ikQzAghu@Mac.home>
 <vvtxa4jjk2wy7q6wnnxxgidopfd3pzxgntuehsu4skex24x5ml@yejfkrtg5dqc>
 <Z8HglTh3EKO63lmu@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HglTh3EKO63lmu@Mac.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 08:13:09AM -0800, Boqun Feng wrote:
> On Fri, Feb 28, 2025 at 11:04:28AM -0500, Kent Overstreet wrote:
> > On Fri, Feb 28, 2025 at 07:46:23AM -0800, Boqun Feng wrote:
> > > On Fri, Feb 28, 2025 at 10:41:12AM -0500, Kent Overstreet wrote:
> > > > On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> > > > > Hi,
> > > > > 
> > > > > > > I guess you can sum this up to:
> > > > > > > 
> > > > > > >    The compiler should never assume it's safe to read a global more than the
> > > > > > >    code specifies, but if the code reads a global more than once, it's fine
> > > > > > >    to cache the multiple reads.
> > > > > > > 
> > > > > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > > > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > > > > > 
> > > > > > Except that (IIRC) it is actually valid for the compiler to write something
> > > > > > entirely unrelated to a memory location before writing the expected value.
> > > > > > (eg use it instead of stack for a register spill+reload.)
> > > > > > Not gcc doesn't do that - but the standard lets it do it.
> > > > > 
> > > > > Whether the compiler is permitted to do that depends heavily on what exactly
> > > > > the code looks like, so it's hard to discuss this in the abstract.
> > > > > If inside some function, *all* writes to a given location are atomic (I
> > > > > think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> > > > > to invent any new writes to that memory. The compiler has to assume that
> > > > > there might be concurrent reads from other threads, whose behavior could
> > > > > change from the extra compiler-introduced writes. The spec (in C, C++, and
> > > > > Rust) already works like that.
> > > > > 
> > > > > OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> > > > > val;" or memcpy or so), that is a signal to the compiler that there cannot
> > > > > be any concurrent accesses happening at the moment, and therefore it can
> > > > > (and likely will) introduce extra writes to that memory.
> > > > 
> > > > Is that how it really works?
> > > > 
> > > > I'd expect the atomic writes to have what we call "compiler barriers"
> > > > before and after; IOW, the compiler can do whatever it wants with non
> > > 
> > > If the atomic writes are relaxed, they shouldn't have "compiler
> > > barriers" before or after, e.g. our kernel atomics don't have such
> > > compiler barriers. And WRITE_ONCE() is basically relaxed atomic writes.
> > 
> > Then perhaps we need a better definition of ATOMIC_RELAXED?
> > 
> > I've always taken ATOMIC_RELAXED to mean "may be reordered with accesses
> > to other memory locations". What you're describing seems likely to cause
> 
> You lost me on this one. if RELAXED means "reordering are allowed", then
> why the compiler barriers implied from it?

yes, compiler barrier is the wrong language here

> > e.g. if you allocate a struct, memset() it to zero it out, then publish
> > it, then do a WRITE_ONCE()...
> 
> How do you publish it? If you mean:
> 
> 	// assume gp == NULL initially.
> 
> 	*x = 0;
> 	smp_store_release(gp, x);
> 
> 	WRITE_ONCE(*x, 1);
> 
> and the other thread does
> 
> 	x = smp_load_acquire(gp);
> 	if (p) {
> 		r1 = READ_ONCE(*x);
> 	}
> 
> r1 can be either 0 or 1.

So if the compiler does obey the store_release barrier, then we're ok.

IOW, that has to override the "compiler sees the non-atomic store as a
hint..." - but the thing is, since we're moving more to type system
described concurrency than helpers, I wonder if that will actually be
the case.

Also, what's the situation with reads? Can we end up in a situation
where a non-atomic read causes the compiler do erronious things with an
atomic_load(..., relaxed)?

