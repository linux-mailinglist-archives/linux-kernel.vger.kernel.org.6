Return-Path: <linux-kernel+bounces-538883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F26A49E44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2603B3887
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D21C1F0D;
	Fri, 28 Feb 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0DGhEpG"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5601607AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758678; cv=none; b=t2GpW7wTbF8LM5fGr5sIUpfUg2oXeWU72wNt/xvSupB5lSqCbxbUouaI7kmyjK4dzvUBZclg8/BFfHL0occQi6aPSRVO2FwxP0tc2s1h/3Pd3zVoRiXpDfFZCmsr0KFC+I4+LPWgVzvmdX70iE8/v3j6x3PJwja4viA5M9rPByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758678; c=relaxed/simple;
	bh=IUNo5mc+dLtm52biT0C00f2IPi+tS7xsDLgtDYZvw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgx7UKKNz+4uH5+JLSwEvSEbt7Og8q3O/kLNTPdZgUy5pjPwdyFSyqG8CF1Wtcr71zDquT9rWORycE5YgC2b2ebjB8dBT8M8nBzoR7QKQsQDpvOZ7bua3INK2HvypdwwAgAHTaiienU7iWq3sCEueB6/Mykjz0ldQLv/kqeG2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0DGhEpG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 11:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740758674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QivQ+TAUEno71bUw9yTt+h23kIoQ6M++FWtpCu3d4/I=;
	b=X0DGhEpG9yJ9VNOAusZf0Bln9WAQC0lM4Ucsup3Iljkt3+u0oTXdG9b/iSLMG694TLrWmN
	ddsTTdVXxM6iNHa2pyyP39o46ya+4BGaF5cKtbg4pd+u6sFAi2c6RX/lNIK8+b3I9oATvw
	Swtf9GAElZ3HT6ofUlI31ommsI86C/g=
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
Message-ID: <vvtxa4jjk2wy7q6wnnxxgidopfd3pzxgntuehsu4skex24x5ml@yejfkrtg5dqc>
References: <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
 <Z8HaT4X4ikQzAghu@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HaT4X4ikQzAghu@Mac.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 07:46:23AM -0800, Boqun Feng wrote:
> On Fri, Feb 28, 2025 at 10:41:12AM -0500, Kent Overstreet wrote:
> > On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> > > Hi,
> > > 
> > > > > I guess you can sum this up to:
> > > > > 
> > > > >    The compiler should never assume it's safe to read a global more than the
> > > > >    code specifies, but if the code reads a global more than once, it's fine
> > > > >    to cache the multiple reads.
> > > > > 
> > > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > > > 
> > > > Except that (IIRC) it is actually valid for the compiler to write something
> > > > entirely unrelated to a memory location before writing the expected value.
> > > > (eg use it instead of stack for a register spill+reload.)
> > > > Not gcc doesn't do that - but the standard lets it do it.
> > > 
> > > Whether the compiler is permitted to do that depends heavily on what exactly
> > > the code looks like, so it's hard to discuss this in the abstract.
> > > If inside some function, *all* writes to a given location are atomic (I
> > > think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> > > to invent any new writes to that memory. The compiler has to assume that
> > > there might be concurrent reads from other threads, whose behavior could
> > > change from the extra compiler-introduced writes. The spec (in C, C++, and
> > > Rust) already works like that.
> > > 
> > > OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> > > val;" or memcpy or so), that is a signal to the compiler that there cannot
> > > be any concurrent accesses happening at the moment, and therefore it can
> > > (and likely will) introduce extra writes to that memory.
> > 
> > Is that how it really works?
> > 
> > I'd expect the atomic writes to have what we call "compiler barriers"
> > before and after; IOW, the compiler can do whatever it wants with non
> 
> If the atomic writes are relaxed, they shouldn't have "compiler
> barriers" before or after, e.g. our kernel atomics don't have such
> compiler barriers. And WRITE_ONCE() is basically relaxed atomic writes.

Then perhaps we need a better definition of ATOMIC_RELAXED?

I've always taken ATOMIC_RELAXED to mean "may be reordered with accesses
to other memory locations". What you're describing seems likely to cause
problems.

e.g. if you allocate a struct, memset() it to zero it out, then publish
it, then do a WRITE_ONCE()...

