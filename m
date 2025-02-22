Return-Path: <linux-kernel+bounces-527464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B6A40B84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA7F3B9CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2531EEA43;
	Sat, 22 Feb 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jym11DEO"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89C42A95
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740254424; cv=none; b=PzjvSKqPWx8vvWldapf/UZrkqryaB8WdbiflC8Rnu4u2kLfW70wHlfxzLdoh+4dPisOrUFVBbTJb2WGywxiogWZWHqvmzFUVz8e0PdTVmzbRMIIIwb/qloxmpejbvImWjb33+oHdJBlkqNGPUdSBNASUPsEk33KHyxwX+YzpSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740254424; c=relaxed/simple;
	bh=g+Qy9acPNsiwG7iu1Ffc8KX4B7wsOwPH7BAz6GnIsZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLUS+MmJILEhiGtPkveaJgDxygYfxeD5Q1Uhi/slKAjQ35dJiiLwtkYWtehUEGAZ/v/F9kf1nNLBOXwwapBTViwwS8+hUuDrRJ3rbODXTb+hiaPaYT0IsMur+cI/I5xUmKANJkSq40X+BlYsOO/OVnhlHoeqfgOnyNjSWenT5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jym11DEO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 15:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740254409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwyRu3h9CnMpA1IIRXrDpSkxZiYUzGbaEXD7Ynyx5C0=;
	b=jym11DEO8x5s+FJUS7vuh40rsLYwfAFaquumZgoAqFT5upSqo2gqBXFBxUU1p2PTlrXKh7
	wK7spvj1xMaycm6zx421/eqJCjh3wX3YQEX7BGjbQgp2RG3NfAv3tnG+hNhr+LoGcOTF/t
	eXzHq//MlCr4IbedWgz5pss4pyI4Wow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, 
	airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 11:18:33AM -0800, Linus Torvalds wrote:
> On Sat, 22 Feb 2025 at 10:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > If that work is successful it could lead to significant improvements in
> > code generation, since aliasing causes a lot of unnecessary spills and
> > reloads - VLIW could finally become practical.
> 
> No.
> 
> Compiler people think aliasing matters. It very seldom does. And VLIW
> will never become practical for entirely unrelated reasons (read: OoO
> is fundamentally superior to VLIW in general purpose computing).

OoO and VLIW are orthogonal, not exclusive, and we always want to go
wider, if we can. Separately, neverending gift that is Spectre should be
making everyone reconsider how reliant we've become on OoO.

We'll never get rid of OoO, I agree on that point. But I think it's
worth some thought experiments about how many branches actually need to
be there vs. how many are there because everyone's assumed "branches are
cheap! (so it's totally fine if the CPU sucks at the alternatives)" on
both the hardware and software side.

e.g. cmov historically sucked (and may still, I don't know), but a _lot_
of branches should just be dumb ALU ops. I wince at a lot of the
assembly I see gcc generate for e.g. short multiword integer
comparisons, there are a ton of places where it'll emit 3 or 5 branches
where 1 is all you need if we had better ALU primitives.

> Aliasing is one of those bug-bears where compiler people can make
> trivial code optimizations that look really impressive. So compiler
> people *love* having simplistic aliasing rules that don't require real
> analysis, because the real analysis is hard (not just expensive, but
> basically unsolvable).

I don't think crazy compiler experiments from crazy C people have much
relevance, here. I'm talking about if/when Rust is able to get this
right.

> The C standards body has been much too eager to embrace "undefined behavior".

Agree on C, but for the rest I think you're just failing to imagine what
we could have if everything wasn't tied to a language with
broken/missing semantics w.r.t. aliasing.

Yes, C will never get a memory model that gets rid of the spills and
reloads. But Rust just might. It's got the right model at the reference
level, we just need to see if they can push that down to raw pointers in
unsafe code.

But consider what the world would look like if Rust fixes aliasing and
we get a microarchitecture that's able to take advantage of it. Do a
microarchitecture that focuses some on ALU ops to get rid of as many
branches as possible (e.g. min/max, all your range checks that don't
trap), get rid of loads and spills from aliasing so you're primarily
running out of registers - and now you _do_ have enough instructions in
a basic block, with fixed latency, that you can schedule at compile time
to make VLIW worth it.

I don't think it's that big of a leap. Lack of cooperation between
hardware and compiler folks (and the fact that what the hardware people
wanted was impossible at the time) was what killed Itanium, so if you
fix those two things...

> The kernel basically turns all that off, as much as possible. Overflow
> isn't undefined in the kernel. Aliasing isn't undefined in the kernel.
> Things like that.

Yeah, the religion of undefined behaviour in C has been an absolute
nightmare.

It's not just the compiler folks though, that way of thinking has
infected entirely too many people people in kernel and userspace -
"performance is the holy grail and all that matters and thou shalt shave
every single damn instruction".

Where this really comes up for me is assertions, because we're not
giving great guidance there. It's always better to hit an assertion than
walk off into undefined behaviour la la land, but people see "thou shalt
not crash the kernel" as a reason not to use BUG_ON() when it _should_
just mean "always handle the error if you can't prove that it can't
happen".

> When 'integer overflow' means that you can _sometimes_ remove one
> single ALU operation in *some* loops, but the cost of it is that you
> potentially introduced some seriously subtle security bugs, I think we
> know it was the wrong thing to do.

And those branches just _do not matter_ in practice, since if one side
leads to a trap they're perfectly predicted and to a first approximation
we're always bottlenecked on memory.

