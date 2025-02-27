Return-Path: <linux-kernel+bounces-537341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F93A48AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB4516CC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E19271295;
	Thu, 27 Feb 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiniMhKa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB1271272;
	Thu, 27 Feb 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692479; cv=none; b=nueK10OVaS7L2j3svwpOPVngublwEckbRKo+WCI6Tm6E17B8i/+JiBCQrGPKDqZmYPWZNiJY2SUTJ7guBAnIqKKSTToY6OhQg5spU/ZG3h+xAa/+um75vRj298kjsj34V152OtT56VRKSWFQ1hRkx4Iopud74vKOEZjlnsxZo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692479; c=relaxed/simple;
	bh=s6/Sys11FQCail6u5a/RCgjidg0h3LHn6wI4Lyxz6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajgBnVJQdmA40KWiGg9xPYVRtn98nxUxsjAwY5BB4aLwP6I2eIFMbAeWplqGeznGZNCLrXn6CBP+w20Ybts5B7qxbrnbGsVv3BfHrcpOKUHe1c9xj5oA+Cd3dOg4GJlOxNG3N6hNwDJMPk39Cj7TXbs1lZ4MWbe0XHpp9HlUQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiniMhKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A3C4CEDD;
	Thu, 27 Feb 2025 21:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740692476;
	bh=s6/Sys11FQCail6u5a/RCgjidg0h3LHn6wI4Lyxz6Ho=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qiniMhKaH9OM1vebqKi2trSfKHKXoBMfx7Rsc+qUHWodxA22cTOttzf7JDOK4zV5o
	 XZaVy7dgq4fBSVHzaG1a5blARaC/MEuUrzul4lKfJjyegmGRRBLY1kp9LR/OOiEfMx
	 bU8dYARfyMeWW3SltpUebou+2WUH6GgzBEP+Ohnr28r9THC99I6hxmM1FMdHnAwe7R
	 QXRZemDXrXI0+SuqmazVlQFla2QCcYubbgYVvFiani3ij4m2m1uJRf3Jn3wTPAInw/
	 0Ok56p4Wbc2gy59lXlc3ek7lqiYEz9LUG9FmiYJ4n8HU08uh1k/e6688Ca6dLu34v8
	 pvH470FDEEl9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0E74CE04CA; Thu, 27 Feb 2025 13:41:15 -0800 (PST)
Date: Thu, 27 Feb 2025 13:41:15 -0800
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
Message-ID: <72bd8dc3-8a46-47b1-ac60-6b9b18b54f69@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227204722.653ce86b@pumpkin>

On Thu, Feb 27, 2025 at 08:47:22PM +0000, David Laight wrote:
> On Wed, 26 Feb 2025 17:35:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 26 Feb 2025 14:22:26 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > > But if I used:
> > > >
> > > >         if (global > 1000)
> > > >                 goto out;
> > > >         x = global;    
> > > 
> > > which can have the TUCTOU issue because 'global' is read twice.  
> > 
> > Correct, but if the variable had some other protection, like a lock held
> > when this function was called, it is fine to do and the compiler may
> > optimize it or not and still have the same result.
> > 
> > I guess you can sum this up to:
> > 
> >   The compiler should never assume it's safe to read a global more than the
> >   code specifies, but if the code reads a global more than once, it's fine
> >   to cache the multiple reads.
> > 
> > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > And when I do use it, it is more to prevent write tearing as you mentioned.
> 
> Except that (IIRC) it is actually valid for the compiler to write something
> entirely unrelated to a memory location before writing the expected value.
> (eg use it instead of stack for a register spill+reload.)
> Not gcc doesn't do that - but the standard lets it do it.

Or replace a write with a read, a check, and a write only if the read
returns some other value than the one to be written.  Also not something
I have seen, but something that the standard permits.

							Thanx, Paul

