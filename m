Return-Path: <linux-kernel+bounces-527332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F2A409CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35241886A09
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5001DB375;
	Sat, 22 Feb 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+1vCjWz"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D93EADC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740240266; cv=none; b=HSQ8GX7fUlGs4EfMOD7CMBobFNxBki/Jsb9NRtSh10kMh0Pzst/Mwan0ImntG8ZbZGht1kzP4sq31W0zA6PgFUW1yjDhaR5+meTneXn8Rql4gtJDmaxFSUZQbA7g9CY08wn97N+MBmSy7oXClk0RufDJdLMFKwaoUN+0gZYcIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740240266; c=relaxed/simple;
	bh=9W4KhsIWQn2rh642SPG0bH7Ff5he2jpDMTRvJ4M9LxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csUcoorw7kesCgHU6MfaQEhOC10FGZDn3iGR6X2wc92Y6KjeXJqh7Np0vGV9zaf/o7mZwplZV/aIgonQgegUZ5iZjGdCQ09WU6lGdlSfrP+93AYzFUPAWaZ1PLT5xErJVwp7HHIuvAJPQEWIu8IJiAhVMDr+Gi5MRSHG2Skas0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+1vCjWz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 11:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740240262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9W4KhsIWQn2rh642SPG0bH7Ff5he2jpDMTRvJ4M9LxY=;
	b=l+1vCjWzGlNtUtkwMVYQGNpt44UGMsBVzFYku9RjXAaKp+703acvP+StkQE4V43wCeS2CD
	AQ+Y2JhR/MzYggBmnAwI5mBOe3mhVHE+Ynv6fmlV8vlPCjhA/mLqIZnx67vpV33D/xZRJK
	xmDq/jI7CkQjC5xmWjqUAYw/XRvAWew=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021954-flaccid-pucker-f7d9@gregkh>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
> Rust isn't a "silver bullet" that will solve all of our problems, but it
> sure will help in a huge number of places, so for new stuff going
> forward, why wouldn't we want that?

I would say that Rust really is a silver bullet; it won't solve
everything all at once but it's a huge advance down the right path, and
there's deep theoretical reasons why it's the right approach - if we
want to be making real advances towards writing more reliable code.

Previously, there have been things like Compcert (writing a compiler in
a proof checking language) and Sel4 (proving the behaviour of a (small)
C program), but these approaches both have practical problems. A proof
checker isn't a systems programming language (garbage collection is
right out), and writing correctness proofs for C programs is arduous.

The big thing we run into when trying to bring this to a practical
systems language, and the fundamental reason the borrow checker looks
the way it does, is Rice's theorem. Rice's theorem is a direct corollary
of the halting problem - "any nontrivial property of a program is either
a direct consequence of the syntax or undecidable".

The halting problem states - "given an arbitrary program, you can't tell
without running it whether it halts or not, and then..." - you know.
Rice's theorem extends that: not only can you not tell if a program
halts or not, you can't tell in general anything about what a program
does without running it and seeing what happens.

The loophole is the "unless that property is a direct consequence of
the syntax".

"Direct consequence of the syntax" directly corresponds to static type
systems. This is the explanation for why large programs in statically
typed languages tend to be more maintainable than in python/javascript -
there are things about your program that you can understand just by
reading code, instead of running it and waiting to see what type a
variable has and what method is called or what have you.

IOW: improvements in static analysis have to come from type system
improvements, and memory safety in particular (in a language without
garbage collection) has to come from baking information about references
into the type system.

So this is why all those other "let's just add some safety features to C
or what have you" efforts are doomed to fail - for them to work, and be
as good as Rust, they'd have to add all the core difficult features of
Rust to C, and we'd still have to rewrite pretty much all of our code,
because making effective use of the borrow checker does require a fair
amount of rearchitecting and rewriting to make things more explicit and
more regular.

And Rust gets us a lot. Besides solving memory safety, the W^R rule of
the borrow checker gets us a lot of the nice "easy to analyze"
properties of pure functional languages, and it's a good foundation for
the next advances in formal verification - dependent types.

TL;DR - it's going to be worth it.

(Also, listen to people like Josef who say "I'm now writing Rust in my
day to day and I never want to go back". It really is that good.)

