Return-Path: <linux-kernel+bounces-532333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C8A44BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7983ADD78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE2205AB6;
	Tue, 25 Feb 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bhnz3muZ"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A391A01CC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512899; cv=none; b=kXJAjh6+Sb+DUsymEojQK9KhpmHu6e1VY0KkBodii4Xi/bQO/Ph9gb09sejUOcjEK5PcZ5OC7gpB0zrS05RVbwN4Blbhb9kAM32GN00JI+u4juv2dZPGVYknwdOT7VFcKXOFTOWiZw3PEtc+ny90k3nVnRitySIVKexGoZp1E18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512899; c=relaxed/simple;
	bh=rG4FYwP4uwFeCnkf78eqP4bAIWLedMKUoimUJa8cZj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cErx++R0dwBjTAjWTESO46U8oQDo4LSvJd3IfmzWhMRHrhcB+LK8tLOLjo4tdB/nC4B6xWgd0Bq9zmtccxZfLFtwof6DmIbeLxH93+2PgiL8b2cCp0VgDgSe4ZatpeLZWlc7DwhZ44Av68AQRra4svWoYA49JIzuYlY/FNoMG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bhnz3muZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Feb 2025 14:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740512885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwFZIGkoTfpVfZh8sx/682mASLDO1H5beOdy1xnqYQU=;
	b=bhnz3muZfSa0rKYbHxD8+O0AMYjIMaRKsPwaKIB8wNMZnTKpypQdlPQ4rN9J3kX/cWkdEP
	dBmvxQkAx7eehU3D2yZwqsxETwygpe+UsbOHtT05+jbWyO1ZM97ecqMI4rT2CEWBSo9PqW
	/puXMe1xxqEiqF0nN+veP5QNQEX6Fik=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 10:54:46AM -0800, Linus Torvalds wrote:
> On Tue, 25 Feb 2025 at 08:12, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > I think all of this worrying about Rust not having defined its
> > aliasing model is way overblown. Ultimately, the status quo is that
> > each unsafe operation that has to do with aliasing falls into one of
> > three categories:
> >
> > * This is definitely allowed.
> > * This is definitely UB.
> > * We don't know whether we want to allow this yet.
> 
> Side note: can I please ask that the Rust people avoid the "UD" model
> as much as humanly possible?
> 
> In particular, if there is something that is undefined behavior - even
> if it's in some "unsafe" mode, please please please make the rule be
> that
> 
>  (a) either the compiler ends up being constrained to doing things in
> some "naive" code generation
> 
> or it's a clear UB situation, and
> 
>  (b) the compiler will warn about it
> 
> IOW, *please* avoid the C model of "Oh, I'll generate code that
> silently takes advantage of the fact that if I'm wrong, this case is
> undefined".
> 
> And BTW, I think this is _particularly_ true for unsafe rust. Yes,
> it's "unsafe", but at the same time, the unsafe parts are the fragile
> parts and hopefully not _so_ hugely performance-critical that you need
> to do wild optimizations.

Well, the whole point of unsafe is for the parts where the compiler
can't in general check for UB, so there's no avoiding that.

And since unsafe is required for a lot of low level data structures (vec
and lists), even though the amount of code (in LOC) that uses unsafe
should be tiny, underneath everything it's all over the place so if it
disabled aliasing optimizations that actually would have a very real
impact on performance.

HOWEVER - the Rust folks don't have the same mindset as the C folks, so
I believe (not the expert here, Rust folks please elaborate..) in
practice a lot of things that would generate UB will be able to be
caught by the compiler. It won't be like -fstrict-aliasing in C, which
was an absolute shitshow.

(There was a real lack of communication between the compiler people and
everything else when that went down, trying to foist -fstrict-aliasing
without even an escape hatch defined at the time should've been a
shooting offence).

OTOH, the stacked borrows and tree borrows work is very much rooted in
"can we define a model that works for actual code", and Rust already has
the clearly defined escape hatches/demarcation points (e.g. UnsafeCell).

> So the cases I'm talking about is literally re-ordering accesses past
> each other ("Hey, I don't know if these alias or not, but based on
> some paper standard - rather than the source code - I will assume they
> do not"),

Yep, this is treeborrows. That gives us a model of "this reference
relates to this reference" so it's finally possible to do these
optimizations without handwavy bs (restrict...).

I think the one thing that's missing w.r.t. aliasing that Rust could
maybe use is a kasan-style sanitizer, I think with treeborrows and "now
we have an actual model for aliasing optimizations" it should be possible
to write such a sanitizer. But the amount of code doing complicated
enough stuff with unsafe should really be quite small, so - shouldn't be
urgently needed. Most unsafe will be in boring FFI stuff, and there all
aliasing optimizations get turned off at the C boundary.

