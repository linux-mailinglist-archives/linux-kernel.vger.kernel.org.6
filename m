Return-Path: <linux-kernel+bounces-537440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF80A48BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E59B16FF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D1271835;
	Thu, 27 Feb 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGc9uz2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66923E339;
	Thu, 27 Feb 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696025; cv=none; b=STuW2aCdV49P7NMOSdljS6/HGoxDIc/X91m4Njgh01TB4VJXoZRF18I3Q5CRJ+2nCSyBHGxDSeXlu/3BplIWDjNCc6JpePX14/uU+G1OXovjRR4nYdwo8DP6fVzt83KWavOG6q1pa9k/Q+cYrrpiXX3tU+sVNsm4fVAac8yqa5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696025; c=relaxed/simple;
	bh=13NTXNZWcFnxPHI9L0mDYaLEzu0VRQ10xWOhuSITWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsjAJQoAI+2Upy7QKA3iBQ2o4KXQ0OCf2zrT/oj1lGJjXWkdVFQlOamygoGMj9JMddIIS3tPWzD8YbmccMijiOVtgtldQ8GMC3djar6PZ3mfnDElvfoxJ/K8ghW5OE4WXna4qCrP3ZcSQly8fhwSeRqI/JZvoG3KGT3QcpB0fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGc9uz2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A473C4CEE4;
	Thu, 27 Feb 2025 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696024;
	bh=13NTXNZWcFnxPHI9L0mDYaLEzu0VRQ10xWOhuSITWTw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lGc9uz2EpFAMbR1PZGUQV/E9W8uRLnwvFb+Col8euJh8/933xhTf226HhvjSUS3jY
	 qFgpBcPGwbnWKhuViMRz2NbXIhDd7uXMU9wab6WPO64dEUjRRyqvSemeaFG6S+4iA9
	 8YJy5ZEbAOCIXR6eMkyBO6/39Has2w7jp/qZpv3nSV+ED7gNE0goK/1uG8xXsD9pL0
	 d5Lo0cwmsDup0cIL8CRThM+EedDmjaGC9JZh8U5QJ2om1XQynfibd/D4jqeEqgI9r3
	 RFZsTFubqwH/LUbGZ/5BPTfFrxdk8E07e6iLK3QcAesPe1KAAVm9LeuIDU0AlSiA9f
	 DpeuXI5s4smCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3225ECE04CA; Thu, 27 Feb 2025 14:40:24 -0800 (PST)
Date: Thu, 27 Feb 2025 14:40:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <27b845e5-1db3-4c67-8cf4-11454df3a8b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <72bd8dc3-8a46-47b1-ac60-6b9b18b54f69@paulmck-laptop>
 <20250227222030.3fd32466@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227222030.3fd32466@pumpkin>

On Thu, Feb 27, 2025 at 10:20:30PM +0000, David Laight wrote:
> On Thu, 27 Feb 2025 13:41:15 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, Feb 27, 2025 at 08:47:22PM +0000, David Laight wrote:
> > > On Wed, 26 Feb 2025 17:35:34 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > > On Wed, 26 Feb 2025 14:22:26 -0800
> > > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > >   
> > > > > > But if I used:
> > > > > >
> > > > > >         if (global > 1000)
> > > > > >                 goto out;
> > > > > >         x = global;      
> > > > > 
> > > > > which can have the TUCTOU issue because 'global' is read twice.    
> > > > 
> > > > Correct, but if the variable had some other protection, like a lock held
> > > > when this function was called, it is fine to do and the compiler may
> > > > optimize it or not and still have the same result.
> > > > 
> > > > I guess you can sum this up to:
> > > > 
> > > >   The compiler should never assume it's safe to read a global more than the
> > > >   code specifies, but if the code reads a global more than once, it's fine
> > > >   to cache the multiple reads.
> > > > 
> > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > And when I do use it, it is more to prevent write tearing as you mentioned.  
> > > 
> > > Except that (IIRC) it is actually valid for the compiler to write something
> > > entirely unrelated to a memory location before writing the expected value.
> > > (eg use it instead of stack for a register spill+reload.)
> > > Not gcc doesn't do that - but the standard lets it do it.  
> > 
> > Or replace a write with a read, a check, and a write only if the read
> > returns some other value than the one to be written.  Also not something
> > I have seen, but something that the standard permits.
> 
> Or if you write code that does that, assume it can just to the write.
> So dirtying a cache line.

You lost me on this one.  I am talking about a case where this code:

	x = 1;

gets optimized into something like this:

	if (x != 1)
		x = 1;

Which means that the "x != 1" could be re-ordered prior to an earlier
smp_wmb(), which might come as a surprise to code relying on that
ordering.  :-(

Again, not something I have seen in the wild.

							Thanx, Paul

