Return-Path: <linux-kernel+bounces-532462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B855A44E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E93AFD18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2EF20D502;
	Tue, 25 Feb 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B/MK3bDA"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12FDF59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516924; cv=none; b=K/1XPqZRVQD8wyjIw+MNPJsdvNjr4Tf1gQYS63zZl5T5TXF0FL9Fl5TkZx56O4UgzsSazFpK1zV/uqYjpe7YVg8OVCTvj+SKKfSBpMr42GZ5K8BHQumW92MpYGQGaGMefE3CUu30zTJ6OofJyinqVlx/+o/myG0/G0F5LlYCr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516924; c=relaxed/simple;
	bh=1NW2HHOC8ICVgbVaMKLK6tFdue4Fuj8hQvoAW7jiRmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgflWm/QQS2q4YZzQGBlXRNocfytd0Uc4lKtleXYDsViT7XSEZgQa6HbfIWyKZNczNRyXr7NnEx6L4t02nm7260+OjlgD4kRQvQ3Lcj+0Yh/oawZKgWvIRG50VjREgdsRByhhZK4oq0TbB+pGNX+O6TiqTil0gAVnhpNiNsiDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B/MK3bDA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Feb 2025 15:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740516910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gz1wsHwRbqo+YF6s2RjcKTV01eyBPUhOwhd/i+qShc8=;
	b=B/MK3bDAuOlpOSxiQIAUyobKDsLdbIN+HBzf3cTWnH4UKQNpmvRpWOX3RZd6RtsGye9pE4
	IdV/ZUSkhH82gr7c03k2LtHAHBrQgDrT7NRWkdqRg5jOiVL60zlgHuI2NOb4zZmRJ7ZqrG
	Edxm4Q+wUeNCp8cpT/IoVcLPyuGJFd0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <4l6xl5vnpulcvssfestsgrzoazoveopzupb32z5bv6mk23gazo@qn63k7rgsckv>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 12:25:13PM -0800, Linus Torvalds wrote:
> On Tue, 25 Feb 2025 at 11:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Well, the whole point of unsafe is for the parts where the compiler
> > can't in general check for UB, so there's no avoiding that.
> 
> No, that's most definitely NOT the whole point of unsafe.
> 
> The point of unsafe is to bypass some rules, and write *SOURCE CODE*
> that does intentionally questionable things.

"Intentionally questionable"?

No, no, no.

That's not a term that has any meaning here; code is either correct or
it's not. We use unsafe when we need to do things that can't be
expressed in the model the compiler checks against - i.e. the model
where we can prove for all inputs that UB is impossible.

That does _not_ mean that there is no specification for what is and
isn't allowed: it just means that there is no way to check for all
inputs, _at compile time_, whether code obeys the spec.

> So if you are implementing the equivalent of malloc/free in unsafe
> rust, you want to be able to do things like arbitrary pointer
> arithmetic, because you are going to do very special things with the
> heap layout, like hiding your allocation metadata based on the
> allocation pointer, and then you want to do all the very crazy random
> arithmetic on pointers that very much do *not* make sense in safe
> code.

Yes, and the borrow checker has to go out the window.

> So unsafe rust is supposed to let the source code bypass those normal
> "this is what you can do to a pointer" rules, and create random new
> pointers that you then access.
> 
> But when you then access those pointers, unsafe Rust should *NOT* say
> "oh, I'm now going to change the order of your accesses, because I
> have decided - based on rules that have nothing to do with your source
> code, and because you told me to go unsafe - that your unsafe pointer
> A cannot alias with your unsafe pointer B".

Well, not without sane rules everyone can follow, which _we never had in
C_.

In C, there's simply no model for derived pointers - this is why e.g.
restrict is just laughable. Because it's never just one pointer that
doesn't alias, we're always doing pointer arithmetic and computing new
pointers, so you need to be able to talk about _which_ pointers can't
alias.

This is the work we've been talking about with stacked/tree borrows: now
we do have that model. We can do pointer arithmetic, compute a new
pointer from a previous pointer (e.g. to get to the malloc header), and
yes of _course_ that aliases with the previous pointer - and the
compiler can understand that, and there are rules (that compiler can
even check, I believe) for "I'm doing writes through mutable derived
pointer A', I can't do any through A while A' exist".

See?

The problem isn't that "pointer aliasing is fundamentally unsafe and
dangerous and therefore the compiler just has to stay away from it
completely" - the problem has just been the lack of a workable model.

Much like how we went from "multithreaded programming is crazy and
dangerous", to "memory barriers are something you're just expected to
know how to use correctly".

