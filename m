Return-Path: <linux-kernel+bounces-532686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C225EA450F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5AA16A0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF023A98C;
	Tue, 25 Feb 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NOVOkcB8"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65523959F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526491; cv=none; b=uPRh4TjMxh9ailPtY2kPpk9AW5RGmVTBolCX0lyKrSUiiHMyBAAIyUA0iOtMcbCCPndsTlDDbAWc7trkf6TbbFSuEbmKSiYA3eOqYCBik0npRYZZbwOOM3oGdUPm4RpTbg4teqFgwWOUy569L1t3p9h80zShbcUs71COppsiShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526491; c=relaxed/simple;
	bh=W2U3OCVP08ILGCN0pvTsVdLcGG7RpAJsKKWk8SJXRUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt03wEdEalrc5VweDiXcofnWl0yUp/1vYHxabW7SPjVfsPXHesD/On17hejuVTLHCXIjeabGxuJTqhkDOki+BoHkA1bM01MFo/IUbDUiFxKwdf/8P9zexUuhjOc779ke3sgeUNHgQyUwTcJI26H+dVBxz/uxVihGeILt+6t/YmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NOVOkcB8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Feb 2025 18:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740526487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymij2cOzOeeGgSy9Fk623wKplb3B9+lyzrX4hrokkAY=;
	b=NOVOkcB8k3QXQjujzoLxuI3ZDjaujT9CqT5eVInjhO62pBCuFgAs6wgq4DAHanidZjcrfM
	fWHAoyNUKARiSxGxdZ1KLj7C4Ih1AZrZroIGrAs/TLnUG+ub0x3wmlG1wxZmX/8EWkRBro
	Ptsku2BYZNxyigRS4TI3skGmtlzUWUY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny>
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
 <4l6xl5vnpulcvssfestsgrzoazoveopzupb32z5bv6mk23gazo@qn63k7rgsckv>
 <CAHk-=wgMnSOnaddFzfAFwjT-dGO9yeSkv6Lt21LgWmCKYCM7cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMnSOnaddFzfAFwjT-dGO9yeSkv6Lt21LgWmCKYCM7cg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 01:24:42PM -0800, Linus Torvalds wrote:
> On Tue, 25 Feb 2025 at 12:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > The problem isn't that "pointer aliasing is fundamentally unsafe and
> > dangerous and therefore the compiler just has to stay away from it
> > completely" - the problem has just been the lack of a workable model.
> 
> It's not entirely clear that a workable aliasing model exists outside
> of "don't assume lack of aliasing".
> 
> Because THAT is the only truly workable model I know of. It's the one
> we use in the kernel, and it works just fine.
> 
> For anything else, we only have clear indications that _unworkable_
> models exist.
> 
> We know type aliasing is garbage.

The C people thinking casting to a union was a workable escape hatch was
hilarious, heh. But now we've got mem::transmute(), i.e. that can (and
must be) annotated to the compiler.

> We know "restrict" doesn't work very well: part of that is that it's
> fairly cumbersome to use, but a large part of that is that a pointer
> will be restricted in one context and not another, and it's just
> confusing and hard to get right.

And it only works at all in the simplest of contexts...

> What we do know works is hard rules based on provenance. All compilers
> will happily do sane alias analysis based on "this is a variable that
> I created, I know it cannot alias with anything else, because I didn't
> expose the address to anything else".

Yep. That's what all this is based on.

> So *provenance*-based aliasing works, but it only works in contexts
> where you can see the provenance. Having some way to express
> provenance across functions (and not *just* at allocation time) might
> be a good model.

We have that! That's exactly what lifetime annotations are.

We don't have that for raw pointers, but I'm not sure that would ever be
needed since you use raw pointers in small and localized places, and a
lot of the places where aliasing comes up in C (e.g. memmove()) you
express differently in Rust, with slices and indices.

(You want to drop from references to raw pointers at the last possible
moment).

And besides, a lot of the places where aliasing comes up in C are
already gone in Rust, there's a lot of little things that help.
Algebraic data types are a big one, since a lot of the sketchy hackery
that goes on in C where aliasing is problematic is just working around
the lack of ADTs.

> But in the absence of knowledge, and in the absence of
> compiler-imposed rules (and "unsafe" is by *definition* that absence),
> I think the only rule that works is "don't assume they don't alias".

Well, for the vast body of Rust code that's been written that just
doesn't seem to be the case, and I think it's been pretty well
demonstrated that anything we can do in C, we can also do just as
effectively in Rust.

treeborrow is already merged into Miri - this stuff is pretty far along.

Now if you're imagining directly translating all the old grotty C code I
know you have in your head - yeah, that won't work. But we already knew
that.

