Return-Path: <linux-kernel+bounces-538842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28BA49DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEB83BCBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7B189902;
	Fri, 28 Feb 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPoiAauP"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45A17A2E8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757294; cv=none; b=LYIR8tYs4kSDYUBmfaMjNUP1sJBeIYtm+yKNdruavW3tVpKZcndAZJ7SU3/7ngpRzmSfyT9rkxTS4SyXSMWsVAet/+Vjm3otNblXe+u87lVB1LHW37K1uCnGomMpXBAXYKu9R5lmT19d4ouvMD78+kOezng4HIOWTwv1G1KVK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757294; c=relaxed/simple;
	bh=Q8+BEVuZf0CNh/0XFWqDI26OHG6DDCW3PBnqoaUpeP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGE5BxBxmUrYQ8eTfoin6Z/c7szNo6BygawP7UQOWjqJEvBH1QDR6sJvnq1OLBcssxkJLVH34M1XZ4oOPKmYtSZAh78XurbtItTM/RTCL104h7zkW5S0uvK96nDB7/ES0JmoFasUwZUQN2xXPmQ+6OVwQE9kHIE03HadjQgfyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPoiAauP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 10:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740757280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fm63nDsheZS+DvKLr7F9z1D5v1N6a2uxGHZfV6AVEE=;
	b=cPoiAauPiyLLHJmiPyvk4jwmh3iCvrZjeS13il8qLCJ3HERFwkTRGXdGwwwjYMvD5p5aDf
	wsfAZB8RsA4B+FzVDFHSJJWDYaKo3w1xlkbyAJG9xfJvoTX2dZ6E90KOlvUYzxbrhCu71P
	Oh8WAUg30CioZVUd0QeRwAfRElFRUc4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ralf Jung <post@ralfj.de>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Martin Uecker <uecker@tugraz.at>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
References: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> Hi,
> 
> > > I guess you can sum this up to:
> > > 
> > >    The compiler should never assume it's safe to read a global more than the
> > >    code specifies, but if the code reads a global more than once, it's fine
> > >    to cache the multiple reads.
> > > 
> > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > 
> > Except that (IIRC) it is actually valid for the compiler to write something
> > entirely unrelated to a memory location before writing the expected value.
> > (eg use it instead of stack for a register spill+reload.)
> > Not gcc doesn't do that - but the standard lets it do it.
> 
> Whether the compiler is permitted to do that depends heavily on what exactly
> the code looks like, so it's hard to discuss this in the abstract.
> If inside some function, *all* writes to a given location are atomic (I
> think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> to invent any new writes to that memory. The compiler has to assume that
> there might be concurrent reads from other threads, whose behavior could
> change from the extra compiler-introduced writes. The spec (in C, C++, and
> Rust) already works like that.
> 
> OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> val;" or memcpy or so), that is a signal to the compiler that there cannot
> be any concurrent accesses happening at the moment, and therefore it can
> (and likely will) introduce extra writes to that memory.

Is that how it really works?

I'd expect the atomic writes to have what we call "compiler barriers"
before and after; IOW, the compiler can do whatever it wants with non
atomic writes, provided it doesn't cross those barriers.

